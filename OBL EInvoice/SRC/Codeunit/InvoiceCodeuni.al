codeunit 50200 "E-Invoice Generation"
{
    Permissions = tabledata "Sales Invoice Header" = mr, tabledata "Sales Cr.Memo Header" = mr, tabledata "Transfer Shipment Header" = mr;
    trigger OnRun()
    begin
    end;

    var

        TransferShipmentHeader: Record 5744;
        PayloadOutPut: Text;
        JGlobalNull: JsonValue;
        SalesCrMemoHeader: Record 114;
        SalesInvoiceHeader: Record 112;
        APIError: Label 'Error When Contacting API';
        CancelBody: text;
        IsInvoice: Boolean;
        IsTransferInvoice: Boolean;
        MessageText: Text;
        SalesLinesErr: Label 'E-Invoice allowes only 100 lines per Invoice. Curent transaction is having %1 lines.', Comment = '%1 = Sales Lines count';

        SerialNo: Integer;
        GlbTrdNm: Text[100];
        GlbBno: Text[60];
        GlbBnm: Text[60];
        GlbFlno: Text[60];
        GlbLoc: Text[60];
        GlbDst: Text[60];
        GlbPin: Text[6];
        GlbStcd: Text[50];
        GlbPh: Text[10];
        GlbEm: Text[50];
        access_token: Text;
        GlbStcddes: Text;

        GbFinalinvoiceValue: Decimal;

        CurrExRate: Decimal;
        SubSuppType: Code[10];
        IsExport: Boolean;
        ShipToModel: Boolean;
        IsEWB: Boolean;
        GSTNNo: Code[20];
        DocumentNo: Text[20];
        LocationCode: Code[20];
        JHeaderObject: JsonObject;

        JFinalArray: JsonArray;
        JFinalLoad: JsonObject;
        JLineObject: JsonObject;
        JLineArray: JsonArray;

    procedure GenerateSalesInvJSONSchema(SalesInvoiceHeader: Record 112)
    begin
        IF (GetGSTNNo(SalesInvoiceHeader."Location Code") <> '') THEN
            GSTNNo := GetGSTNNo(SalesInvoiceHeader."Location Code"); //MSKS

        DocumentNo := SalesInvoiceHeader."No.";
        LocationCode := SalesInvoiceHeader."Location Code";
        Authenticate1();

        //ReadCredentials(1);

        WriteFileHeader;
        ReadTransDtls(SalesInvoiceHeader."GST Customer Type", SalesInvoiceHeader."Ship-to Code");
        ReadDocDtls;
        ReadExpDtls;
        ReadSellerDtls;
        ReadBuyerDtls;
        ReadShipDtls;
        WriteEWBDtls('', '', '', '', '', '', 0, '', '');//Keshav0402021
        ReadValDtls;
        ReadItemList();

        JFinalArray.Add(JHeaderObject);
        JHeaderObject.Add('lineItems', JLineArray);
        JFinalLoad.Add('req', JFinalArray);
        JFinalLoad.WriteTo(MessageText);
        PayloadOutPut := DelChr(MessageText, '=', '#');
        Message(PayloadOutPut);
        GetIRNNo();
    end;

    procedure GenerateSalesInvJSONSchemaforChecking(SalesInvoiceHeader: Record 112)
    begin
        IF (GetGSTNNo(SalesInvoiceHeader."Location Code") <> '') THEN
            GSTNNo := GetGSTNNo(SalesInvoiceHeader."Location Code"); //MSKS

        DocumentNo := SalesInvoiceHeader."No.";
        LocationCode := SalesInvoiceHeader."Location Code";
        WriteFileHeader;
        ReadTransDtls(SalesInvoiceHeader."GST Customer Type", SalesInvoiceHeader."Ship-to Code");
        ReadDocDtls;
        ReadExpDtls;
        ReadSellerDtls;
        ReadBuyerDtls;
        ReadShipDtls;
        WriteEWBDtls('', '', '', '', '', '', 0, '', '');//Keshav0402021
        ReadValDtls;
        ReadItemList();

        JFinalArray.Add(JHeaderObject);
        JHeaderObject.Add('lineItems', JLineArray);
        JFinalLoad.Add('req', JFinalArray);
        JFinalLoad.WriteTo(MessageText);
        PayloadOutPut := DelChr(MessageText, '=', '#');
        Message(PayloadOutPut);
    end;

    local procedure GetGSTNNo(LocationCode: Code[10]): Text
    var
        Location: Record 14;
        CompanyInformation: Record 79;
    begin
        //EXIT('29AAACO0305P1ZD');
        CompanyInformation.GET;
        IF Location.GET(LocationCode) THEN
            IF Location."GST Registration No." <> '' THEN
                EXIT(Location."GST Registration No.")
            ELSE BEGIN
                EXIT(CompanyInformation."GST Registration No.");
            END ELSE BEGIN
            EXIT(CompanyInformation."GST Registration No.");
        END;
    end;

    procedure Authenticate1()
    var
        EinvoiceHttpClient: HttpClient;
        EinvoiceHttpRequest: HttpRequestMessage;
        EinvoiceHttpContent: HttpContent;
        EinvoiceHttpHeader: HttpHeaders;
        EinvoiceHttpResponse: HttpResponseMessage;
        JOutputObject: JsonObject;
        JResultToken: JsonToken;
        JResultObject: JsonObject;
        OutputMessage: Text;
        ResultMessage: Text;
        rLocation: Record 14;
    begin
        rLocation.GET(LocationCode);
        rLocation.TESTFIELD("E-InvAuthenticateURL");
        rLocation.TESTFIELD(Username);
        rLocation.TESTFIELD(Password);
        rLocation.TESTFIELD(apiaccesskey);

        EinvoiceHttpContent.GetHeaders(EinvoiceHttpHeader);
        EinvoiceHttpHeader.Clear();
        //EinvoiceHttpHeader.Add('username', 'manmohan.khare@orientbell.eyasp.com');
        //EinvoiceHttpHeader.Add('password', 'T0JMQDIwMjA=');
        //EinvoiceHttpHeader.Add('apiaccesskey', 'l7xx1521cf8bc25c4e18a0e8f3abba019451');
        EinvoiceHttpHeader.Add('username', rLocation.Username);
        EinvoiceHttpHeader.Add('password', rLocation.Password);
        EinvoiceHttpHeader.Add('apiaccesskey', rLocation.apiaccesskey);
        EinvoiceHttpHeader.Add('Content-Type', 'application/json');
        EinvoiceHttpRequest.Content := EinvoiceHttpContent;
        // EinvoiceHttpRequest.SetRequestUri('https://eapi.eyasp.com/eapi/v2.0/authenticate');
        EinvoiceHttpRequest.SetRequestUri(rLocation."E-InvAuthenticateURL");
        EinvoiceHttpRequest.Method := 'POST';
        if EinvoiceHttpClient.Send(EinvoiceHttpRequest, EinvoiceHttpResponse) then begin
            EinvoiceHttpResponse.Content.ReadAs(ResultMessage);
            JResultObject.ReadFrom(ResultMessage);

            if JResultObject.Get('status', JResultToken) then
                if JResultToken.AsValue().AsInteger() = 1 then begin
                    if JResultObject.Get('accessToken', JResultToken) then
                        access_token := JResultToken.AsValue().AsText();
                end else
                    Message(Format(JResultToken));
            if JResultToken.IsObject then begin
                JResultToken.WriteTo(OutputMessage);
                JOutputObject.ReadFrom(OutputMessage);
            end;
        end else
            Error('Error When Contacting API');
    end;

    local procedure WriteFileHeader()
    begin
        ReadCredentials(0);
    end;

    local procedure ReadCredentials(RequestType: Option CreateRequest,CancelRequest)
    var
        "ACTION": Text[15];
        VERSION: Text[6];
    begin
        IF RequestType = RequestType::CreateRequest THEN
            ACTION := 'INVOICE'
        ELSE
            ACTION := 'CANCEL';

        IF RequestType = RequestType::CreateRequest THEN
            VERSION := '1.01'
        ELSE
            VERSION := '';
        WriteCredentials(ACTION, VERSION, RequestType);
    end;

    local procedure WriteCredentials("ACTION": Text[15]; VERSION: Text; RequestType: Option CreateRequest,CancelRequest)
    var
        RecLocation: Record 14;
    begin
        IF LocationCode = '' THEN
            ERROR('Location Code cannot be blank');
        RecLocation.GET(LocationCode);
        RecLocation.TESTFIELD("GST Registration No.");
        if RequestType = RequestType::CreateRequest then
            JHeaderObject.add('suppGstin#', RecLocation."GST Registration No.")
        else
            JHeaderObject.add('suppGstin', RecLocation."GST Registration No.");
        //JsonTextWriter.WriteValue('29AAACO0305P1ZD');//RecLocation."GST Registration No."
        IF RequestType = RequestType::CreateRequest THEN BEGIN
            JHeaderObject.add('VERSION', VERSION);
        END;
    end;

    local procedure ReadTransDtls(GSTCustType: Option " ",Registered,Unregistered,Export,"Deemed Export",Exempted,"SEZ Development","SEZ Unit"; ShipToCode: Code[12])
    var
        SalesCrMemoLine: Record 115;
        catg: Text[6];
        Typ: Text[5];
        ECMGSTN: Text;
        ExpCat: Text;
        WithPay: Text;
        Customer: Record 18;
    begin
        SubSuppType := 'TAX';
        IF IsInvoice THEN BEGIN
            catg := 'B2B';
            //catg = TypeofSupp
            IF GSTCustType IN [SalesInvoiceHeader."GST Customer Type"::Registered, SalesInvoiceHeader."GST Customer Type"::Exempted] THEN
                catg := 'B2B'
            ELSE BEGIN
                IF GSTCustType IN [SalesInvoiceHeader."GST Customer Type"::Export, SalesInvoiceHeader."GST Customer Type"::"Deemed Export", SalesInvoiceHeader."GST Customer Type"::"SEZ Unit",
                    SalesInvoiceHeader."GST Customer Type"::"SEZ Development"]
                THEN BEGIN
                    CASE SalesInvoiceHeader."GST Customer Type" OF
                        SalesInvoiceHeader."GST Customer Type"::Export:
                            ExpCat := 'DIR';
                        SalesInvoiceHeader."GST Customer Type"::"Deemed Export":
                            ExpCat := 'DEM';
                        SalesInvoiceHeader."GST Customer Type"::"SEZ Unit":
                            ExpCat := 'SEZ';
                        SalesInvoiceHeader."GST Customer Type"::"SEZ Development":
                            ExpCat := 'SED';
                    END;
                    IF SalesInvoiceHeader."GST Without Payment of Duty" THEN
                        WithPay := 'N'
                    ELSE
                        WithPay := 'Y';
                END;
                IF (ExpCat = 'DIR') AND (WithPay = 'Y') THEN
                    catg := 'EXPT';
                IF (ExpCat = 'DIR') AND (WithPay = 'N') THEN
                    catg := 'EXPWT';
                IF (ExpCat = 'SEZ') AND (WithPay = 'Y') THEN
                    catg := 'SEZWP';
                IF (ExpCat = 'SEZ') AND (WithPay = 'N') THEN
                    catg := 'SEZWOP';
                IF ExpCat = 'DEM' THEN
                    catg := 'DXP';

                SubSuppType := catg;
            END;
            IF (GSTCustType IN [SalesInvoiceHeader."GST Customer Type"::Unregistered]) AND (IsEWB) THEN
                SubSuppType := 'TAX';
            Customer.GET(SalesInvoiceHeader."Sell-to Customer No.");
            //Keshav05022021>>
            //IF (SalesInvoiceHeader."Ship to Pin" <> Customer."Pin Code") AND (SalesInvoiceHeader."Ship to Pin"<>'') THEN BEGIN
            IF ((SalesInvoiceHeader."Ship to Pin" <> Customer."Pin Code") AND (SalesInvoiceHeader."Ship to Pin" <> '')) OR
              ((SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Export) AND IsEWB) THEN BEGIN
                //Keshav05022021<<
                ShipToModel := TRUE;
                Typ := 'SHP';
                ShipToCode := 'SHP';

            END ELSE BEGIN
                Typ := 'REG';
                ShipToModel := FALSE;
            END;
            /*  IF ShipToCode <> '' THEN BEGIN
                SalesInvoiceLine.SETRANGE("Document No.",DocumentNo);
                SalesInvoiceLine.SETFILTER(Quantity,'<>%1',0);
                IF SalesInvoiceLine.FINDSET THEN
                  REPEAT
                    IF SalesInvoiceLine."GST Place of Supply" <> SalesInvoiceLine."GST Place of Supply"::"Ship-to Address" THEN
                      Typ := 'SHP'
                    ELSE
                      Typ := 'REG';
                  UNTIL SalesInvoiceLine.NEXT = 0;
              END ELSE
                Typ := 'REG';
            */
        END ELSE
            IF IsTransferInvoice THEN BEGIN
                catg := 'B2B';
                Typ := 'REG';
            END
            ELSE BEGIN
                IF GSTCustType IN [SalesCrMemoHeader."GST Customer Type"::Registered, SalesCrMemoHeader."GST Customer Type"::Exempted] THEN
                    catg := 'B2B'
                ELSE BEGIN
                    IF GSTCustType IN [SalesCrMemoHeader."GST Customer Type"::Export, SalesCrMemoHeader."GST Customer Type"::"Deemed Export", SalesCrMemoHeader."GST Customer Type"::"SEZ Unit",
                      SalesCrMemoHeader."GST Customer Type"::"SEZ Development"]
                  THEN BEGIN
                        CASE SalesCrMemoHeader."GST Customer Type" OF
                            SalesCrMemoHeader."GST Customer Type"::Export:
                                ExpCat := 'DIR';
                            SalesCrMemoHeader."GST Customer Type"::"Deemed Export":
                                ExpCat := 'DEM';
                            SalesCrMemoHeader."GST Customer Type"::"SEZ Unit":
                                ExpCat := 'SEZ';
                            SalesCrMemoHeader."GST Customer Type"::"SEZ Development":
                                ExpCat := 'SED';
                        END;
                        IF SalesCrMemoHeader."GST Without Payment of Duty" THEN
                            WithPay := 'N'
                        ELSE
                            WithPay := 'Y';
                    END;
                    IF (ExpCat = 'DIR') AND (WithPay = 'Y') THEN
                        catg := 'EXPT';
                    IF (ExpCat = 'DIR') AND (WithPay = 'N') THEN
                        catg := 'EXPWT';
                    IF (ExpCat = 'SEZ') AND (WithPay = 'Y') THEN
                        catg := 'SEZWP';
                    IF (ExpCat = 'SEZ') AND (WithPay = 'N') THEN
                        catg := 'SEZWOP';
                    IF ExpCat = 'DEM' THEN
                        catg := 'DEXP';
                    SubSuppType := catg;
                END;

                SalesCrMemoLine.SETRANGE("Document No.", DocumentNo);
                SalesCrMemoLine.SETFILTER(Quantity, '<>%1', 0);
                IF SalesCrMemoLine.FINDSET THEN
                    REPEAT
                        IF SalesCrMemoLine."GST Place of Supply" = SalesCrMemoLine."GST Place of Supply"::"Ship-to Address" THEN
                            Typ := 'REG'
                        ELSE
                            Typ := 'SHP';
                    UNTIL SalesCrMemoLine.NEXT = 0;
            END;
        IF catg IN ['EXPT', 'EXPWT'] THEN
            IsExport := TRUE;

        WriteTransDtls(catg, 'N', Typ, 'false', 'Y', ECMGSTN);
    end;

    local procedure WriteTransDtls(catg: Text[6]; RegRev: Text[2]; Typ: Text[5]; EcmTrnSel: Text[5]; EcmTrn: Text[1]; EcmGstin: Text[15])
    begin
        JHeaderObject.Add('docCat', Typ);
        JHeaderObject.Add('reverseCharge', RegRev);
        JHeaderObject.Add('taxScheme', 'GST');
    end;

    local procedure ReadDocDtls()
    var
        Typ: Text[3];
        Dt: Text[10];
        OrgInvNo: Text[16];
    begin
        IF IsInvoice THEN BEGIN
            IF SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."Invoice Type"::Taxable THEN
                Typ := 'INV'
            ELSE
                IF (SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."Invoice Type"::"Debit Note") OR
                   (SalesInvoiceHeader."Invoice Type" = SalesInvoiceHeader."Invoice Type"::Supplementary)
                THEN
                    Typ := 'DBN'
                ELSE
                    Typ := 'INV';
            Dt := FormatDate(SalesInvoiceHeader."Posting Date");
        END ELSE
            IF IsTransferInvoice THEN BEGIN
                Typ := 'INV';
                Dt := FormatDate(TransferShipmentHeader."Posting Date");
            END ELSE BEGIN
                Typ := 'CR';
                Dt := FormatDate(SalesCrMemoHeader."Posting Date");
            END;

        OrgInvNo := COPYSTR(GetRefInvNo(DocumentNo), 1, 16);

        WriteDocDtls(Typ, COPYSTR(DocumentNo, 1, 16), Dt, OrgInvNo);

        // OrgInvNo := 'InvTest0018';
        // WriteDocDtls(Typ,COPYSTR('InvTest0018',1,16),Dt,OrgInvNo);
    end;

    local procedure FormatDate(PostDate: Date): Text
    begin
        EXIT(FORMAT(PostDate, 0, '<Day,2>/<Month,2>/<Year4>'));
    end;

    local procedure GetRefInvNo(DocNo: Code[20]) RefInvNo: Code[20]
    var
        ReferenceInvoiceNo: Record "Reference Invoice No.";
    begin
        ReferenceInvoiceNo.SETRANGE("Document No.", DocNo);
        IF ReferenceInvoiceNo.FINDFIRST THEN
            RefInvNo := ReferenceInvoiceNo."Reference Invoice Nos."
        ELSE
            RefInvNo := RemoveSpecialChar(DocNo); //MSKS
    end;

    local procedure RemoveSpecialChar(TxtDoc: Text): Text
    begin
        EXIT(DELCHR(TxtDoc, '=', './,-\!@#$%^&*()+ '));
    end;

    local procedure ConverttexttoInteger(text: Text) inttext: BigInteger
    begin
        EVALUATE(inttext, text);
    end;

    local procedure WriteDocDtls(Typ: Text[3]; No: Text[16]; Dt: Text[10]; OrgInvNo: Text[16])
    begin
        JHeaderObject.Add('docType', Typ);
        JHeaderObject.Add('docNo', No);
        JHeaderObject.Add('docDate', Dt);
    end;

    local procedure ReadExpDtls()
    var
        SalesInvoiceLine: Record 113;
        DiscouAmt: Decimal;
        SalesCrMemoLine: Record 115;
        // GSTManagement: Codeunit 16401;
        ExpCat: Text[3];
        WithPay: Text[1];
        ShipBNo: Text[16];
        ShipBDt: Text[10];
        Port: Text[10];
        InvForCur: Decimal;
        ForCur: Text[3];
        CntCode: Text[2];
        GSTBaseAmt: Decimal;
        GSTAmt: Decimal;
        GStBAmt: Decimal;
    begin
        CurrExRate := 1;
        IF IsInvoice THEN
            WITH SalesInvoiceHeader DO BEGIN
                IF "GST Customer Type" IN
                   ["GST Customer Type"::Export,
                    "GST Customer Type"::"Deemed Export",
                    "GST Customer Type"::"SEZ Unit",
                    "GST Customer Type"::"SEZ Development"]
                THEN BEGIN
                    CASE "GST Customer Type" OF
                        "GST Customer Type"::Export:
                            ExpCat := 'DIR';
                        "GST Customer Type"::"Deemed Export":
                            ExpCat := 'DEM';
                        "GST Customer Type"::"SEZ Unit":
                            ExpCat := 'SEZ';
                        "GST Customer Type"::"SEZ Development":
                            ExpCat := 'SED';
                    END;
                    IF "GST Without Payment of Duty" THEN
                        WithPay := 'N'
                    ELSE
                        WithPay := 'Y';
                    ShipBNo := COPYSTR("Bill Of Export No.", 1, 16);
                    ShipBDt := FormatDate("Bill Of Export Date");
                    Port := "Exit Point";
                    IF SalesInvoiceHeader."Currency Factor" <> 0 THEN
                        CurrExRate := 1 / SalesInvoiceHeader."Currency Factor"
                    ELSE
                        CurrExRate := 1;
                    SalesInvoiceLine.SETRANGE("Document No.", "No.");
                    IF SalesInvoiceLine.FINDSET THEN
                        REPEAT
                            GSTValueSalesHeader(SalesInvoiceLine, GSTBaseAmt, GSTAmt, DiscouAmt, GStBAmt);
                            if GSTAmt <> 0 then
                                //IF GSTManagement.IsGSTApplicable(Structure) THEN
                                InvForCur := RoundGSTInvoicePrecision(SalesInvoiceLine, InvForCur + SalesInvoiceLine.Amount)
                            ELSE
                                InvForCur := InvForCur + SalesInvoiceLine.Amount;
                        UNTIL SalesInvoiceLine.NEXT = 0;
                    ForCur := COPYSTR("Currency Code", 1, 3);
                    CntCode := COPYSTR("Bill-to Country/Region Code", 1, 2);
                END ELSE
                    EXIT;
            END
        ELSE
            WITH SalesCrMemoHeader DO BEGIN
                IF "GST Customer Type" IN
                   ["GST Customer Type"::Export,
                    "GST Customer Type"::"Deemed Export",
                    "GST Customer Type"::"SEZ Unit",
                    "GST Customer Type"::"SEZ Development"]
                THEN BEGIN
                    CASE "GST Customer Type" OF
                        "GST Customer Type"::Export:
                            ExpCat := 'DIR';
                        "GST Customer Type"::"Deemed Export":
                            ExpCat := 'DEM';
                        "GST Customer Type"::"SEZ Unit":
                            ExpCat := 'SEZ';
                        "GST Customer Type"::"SEZ Development":
                            ExpCat := 'SED';
                    END;
                    IF "GST Without Payment of Duty" THEN
                        WithPay := 'N'
                    ELSE
                        WithPay := 'Y';
                    ShipBNo := COPYSTR("Bill Of Export No.", 1, 16);
                    ShipBDt := FormatDate("Bill Of Export Date");
                    Port := "Exit Point";
                    IF SalesCrMemoHeader."Currency Factor" <> 0 THEN
                        CurrExRate := 1 / SalesCrMemoHeader."Currency Factor"
                    ELSE
                        CurrExRate := 1;
                    SalesCrMemoLine.SETRANGE("Document No.", "No.");
                    IF SalesCrMemoLine.FINDSET THEN
                        REPEAT
                            /* IF GSTManagement.IsGSTApplicable(Structure) THEN
                                InvForCur := InvForCur + SalesCrMemoLine.Amount
                            ELSE */
                            InvForCur := InvForCur + SalesCrMemoLine.Amount;
                        UNTIL SalesCrMemoLine.NEXT = 0;
                    ForCur := COPYSTR("Currency Code", 1, 3);
                    CntCode := COPYSTR("Bill-to Country/Region Code", 1, 2);
                END ELSE
                    EXIT;
            END;

        WriteExpDtls(ExpCat, WithPay, ShipBNo, ShipBDt, Port, InvForCur, ForCur, CntCode);
    end;

    local procedure WriteExpDtls(ExpCat: Text[3]; WithPay: Text[1]; ShipBNo: Text[16]; ShipBDt: Text[10]; Port: Text[10]; InvForCur: Decimal; ForCur: Text[3]; CntCode: Text[2])
    begin
        if ShipBNo <> '' then
            JHeaderObject.Add('shippingBillNo', ShipBNo)
        else
            JHeaderObject.Add('shippingBillNo', JGlobalNull);
        if ShipBDt <> '' then
            JHeaderObject.Add('shippingBillDate', ShipBDt)
        else
            JHeaderObject.Add('shippingBillDate', JGlobalNull);
        if CntCode <> '' then
            JHeaderObject.Add('countryCode', CntCode)
        else
            JHeaderObject.Add('countryCode', JGlobalNull);

        IF ForCur <> '' THEN
            JHeaderObject.add('foreignCurrency', ForCur)
        ELSE
            JHeaderObject.Add('foreignCurrency', JGlobalNull);
        JHeaderObject.Add('invValueFc', InvForCur);
        if Port <> '' then
            JHeaderObject.Add('portCode', Port)
        else
            JHeaderObject.Add('portCode', JGlobalNull);
    end;

    local procedure ReadSellerDtls()
    var
        CompanyInformationBuff: Record 79;
        LocationBuff: Record 14;
        StateBuff: Record State;
        Gstin: Text[15];
        TrdNm: Text[100];
        Bno: Text[60];
        Bnm: Text[60];
        Flno: Text[60];
        Loc: Text[60];
        Dst: Text[60];
        Pin: Text[6];
        Stcd: Text[50];
        Ph: Text[10];
        Em: Text[50];
        PinInt: Integer;
    begin
        IF IsInvoice THEN
            WITH SalesInvoiceHeader DO BEGIN
                //Gstin := '29AAACO0305P1ZD';
                LocationBuff.GET("Location Code");
                Gstin := LocationBuff."GST Registration No.";//Keshav30Sep2020
                CompanyInformationBuff.GET;
                TrdNm := CompanyInformationBuff.Name;
                //Gstin:=LocationBuff."GST Registration No.";//Keshav30Sep2020
                Bno := LocationBuff.Address;
                Bnm := LocationBuff."Address 2";
                Flno := 'FLNo1';
                Loc := LocationBuff.City;
                Dst := LocationBuff.City;
                LocationBuff.TESTFIELD("Pin Code");
                Pin := COPYSTR(LocationBuff."Pin Code", 1, 6);
                //Pin := '110007';

                StateBuff.GET(LocationBuff."State Code");
                Stcd := StateBuff."State Code (GST Reg. No.)";
                Ph := RemoveSpecialChar(COPYSTR(LocationBuff."Phone No.", 1, 10));
                Em := COPYSTR(LocationBuff."E-Mail", 1, 50);
            END
        ELSE
            IF IsTransferInvoice THEN
                WITH TransferShipmentHeader DO BEGIN
                    //    Gstin := '29AAACO0305P1ZD';// "Location GST Reg. No.";//Keshav30Sep2020
                    CompanyInformationBuff.GET;
                    TrdNm := CompanyInformationBuff.Name;
                    LocationBuff.GET("Transfer-from Code");
                    Gstin := LocationBuff."GST Registration No.";//Keshav30Sep2020
                    Bno := LocationBuff.Address;
                    Bnm := LocationBuff."Address 2";
                    Flno := 'FLNo1';
                    Loc := LocationBuff.City;
                    Dst := LocationBuff.City;
                    LocationBuff.TESTFIELD("Pin Code");
                    Pin := COPYSTR(LocationBuff."Pin Code", 1, 6);

                    StateBuff.GET(LocationBuff."State Code");
                    Stcd := StateBuff."State Code (GST Reg. No.)";
                    Ph := RemoveSpecialChar(COPYSTR(LocationBuff."Phone No.", 1, 10));
                    Em := COPYSTR(LocationBuff."E-Mail", 1, 50);
                END
            ELSE
                WITH SalesCrMemoHeader DO BEGIN
                    //    Gstin := '29AAACO0305P1ZD';// "Location GST Reg. No.";//Keshav30Sep2020
                    //Gstin := "Location GST Reg. No.";
                    CompanyInformationBuff.GET;
                    TrdNm := CompanyInformationBuff.Name;
                    LocationBuff.GET("Location Code");
                    Gstin := LocationBuff."GST Registration No.";//Keshav30Sep2020
                    Bno := LocationBuff.Address;
                    Bnm := LocationBuff."Address 2";
                    Flno := '';
                    Loc := LocationBuff.City;
                    Dst := LocationBuff.City;
                    LocationBuff.TestField("Pin Code");
                    Pin := COPYSTR(LocationBuff."Pin Code", 1, 6);
                    StateBuff.GET(LocationBuff."State Code");
                    Stcd := StateBuff."State Code (GST Reg. No.)";
                    Ph := COPYSTR(LocationBuff."Phone No.", 1, 10);
                    Em := COPYSTR(LocationBuff."E-Mail", 1, 50);
                END;
        EVALUATE(PinInt, Pin);
        WriteSellerDtls(Gstin, TrdNm, Bno, Bnm, Flno, Loc, Dst, PinInt, Stcd, Ph, Em);
    end;

    local procedure WriteSellerDtls(Gstin: Text[15]; TrdNm: Text[100]; Bno: Text[60]; Bnm: Text[60]; Flno: Text[60]; Loc: Text[60]; Dst: Text[60]; Pin: Integer; Stcd: Text[50]; Ph: Text[10]; Em: Text[50])
    begin
        if Gstin <> '' then
            JHeaderObject.Add('suppGstin', Gstin)
        else
            JHeaderObject.Add('suppGstin', JGlobalNull);
        if TrdNm <> '' then
            JHeaderObject.Add('supTradeName', TrdNm)
        else
            JHeaderObject.Add('supTradeName', JGlobalNull);
        if TrdNm <> '' then
            JHeaderObject.Add('supLegalName', TrdNm)
        else
            JHeaderObject.Add('supLegalName', JGlobalNull);
        if TrdNm <> '' then
            JHeaderObject.Add('supBuildingNo', Bno)
        else
            JHeaderObject.Add('supBuildingNo', JGlobalNull);
        if TrdNm <> '' then
            JHeaderObject.Add('supBuildingName', Bnm)
        else
            JHeaderObject.Add('supBuildingName', JGlobalNull);

        if Loc <> '' then
            JHeaderObject.Add('supLocation', Loc)
        else
            JHeaderObject.Add('supLocation', JGlobalNull);
        if Pin <> 0 then
            JHeaderObject.Add('supPincode', Pin)
        else
            JHeaderObject.add('supPincode', JGlobalNull);
        if Stcd <> '' then
            JHeaderObject.Add('supStateCode', Stcd)
        else
            JHeaderObject.Add('supStateCode', JGlobalNull);
        if Ph <> '' then
            JHeaderObject.Add('supPhone', Ph)
        else
            JHeaderObject.Add('supPhone', JGlobalNull);
        if Em <> '' then
            JHeaderObject.Add('supEmail', Em)
        else
            JHeaderObject.Add('supEmail', JGlobalNull);

        //JsonTextWriter.WriteEndObject;
    end;

    local procedure ReadBuyerDtls()
    var
        Contact: Record 5050;
        LocationBuff: Record 14;
        SalesInvoiceLine: Record 113;
        SalesCrMemoLine: Record 115;
        ShipToAddr: Record 222;
        StateBuff: Record State;
        Gstin: Text[15];
        TrdNm: Text[100];
        Bno: Text[60];
        Bnm: Text[60];
        Flno: Text[60];
        Loc: Text[60];
        Dst: Text[60];
        Pin: Text[6];
        Stcd: Text[2];
        Ph: Text[10];
        Em: Text[50];
        Customer: Record 18;
        Stcddes: Text;
    begin
        IF IsInvoice THEN
            WITH SalesInvoiceHeader DO BEGIN
                //IF "GST Customer Type"="GST Customer Type"::Unregistered THEN//Keshav05022021
                IF ("GST Customer Type" = "GST Customer Type"::Unregistered) AND (IsEWB = FALSE) THEN//Keshav05022021
                    ERROR('Unregistered');
                Gstin := "Customer GST Reg. No.";
                TrdNm := "Bill-to Name";
                Bno := "Bill-to Address";
                Bnm := "Bill-to Address 2";
                Flno := 'F1';
                Loc := "Bill-to City";
                Dst := "Bill-to City";
                Customer.GET("Sell-to Customer No.");

                IF Customer."Pin Code" <> '' THEN
                    Pin := COPYSTR(Customer."Pin Code", 1, 6)
                ELSE
                    ERROR('Customer Pin doesnot exist');

                //Pin := COPYSTR("Ship to Pin",1,6);
                SalesInvoiceLine.SETRANGE("Document No.", "No.");
                SalesInvoiceLine.SETFILTER(Quantity, '<>%1', 0);
                IF SalesInvoiceLine.FINDFIRST THEN
                    IF SalesInvoiceLine."GST Place of Supply" = SalesInvoiceLine."GST Place of Supply"::"Bill-to Address" THEN BEGIN
                        IF NOT ("GST Customer Type" = "GST Customer Type"::Export) THEN BEGIN
                            StateBuff.GET("GST Bill-to State Code");
                            Stcd := StateBuff."State Code (GST Reg. No.)";
                            Stcddes := StateBuff.Description;
                        END ELSE
                            Stcd := '';
                        Customer.GET("Bill-to Customer No.");
                        IF Customer."Phone No." <> '' THEN BEGIN
                            Ph := COPYSTR(Customer."Phone No.", 1, 10);
                            Em := COPYSTR(Customer."E-Mail", 1, 50);
                        END ELSE
                            IF Contact.GET("Bill-to Contact No.") THEN BEGIN
                                Ph := COPYSTR(Contact."Phone No.", 1, 10);
                                Em := COPYSTR(Contact."E-Mail", 1, 50);
                            END ELSE BEGIN
                                Ph := '';
                                Em := '';
                            END;
                    END ELSE
                        IF SalesInvoiceLine."GST Place of Supply" = SalesInvoiceLine."GST Place of Supply"::"Ship-to Address" THEN BEGIN
                            IF NOT ("GST Customer Type" = "GST Customer Type"::Export) THEN BEGIN
                                StateBuff.GET("GST Ship-to State Code");
                                Stcd := StateBuff."State Code (GST Reg. No.)";
                                Stcddes := StateBuff.Description;
                            END ELSE
                                Stcd := '';
                            IF ShipToAddr.GET("Sell-to Customer No.", "Ship-to Code") THEN BEGIN
                                Ph := COPYSTR(ShipToAddr."Phone No.", 1, 10);
                                Em := COPYSTR(ShipToAddr."E-Mail", 1, 50);
                            END ELSE BEGIN
                                Ph := '';
                                Em := '';
                            END;
                        END ELSE BEGIN
                            Stcd := '';
                            Ph := '';
                            Em := '';
                        END;
            END
        ELSE
            IF IsTransferInvoice THEN
                WITH TransferShipmentHeader DO BEGIN
                    LocationBuff.GET("Transfer-to Code");
                    Gstin := LocationBuff."GST Registration No.";
                    TrdNm := LocationBuff.Name;
                    Bno := LocationBuff.Address;
                    Bnm := LocationBuff."Address 2";
                    Flno := '';
                    Loc := LocationBuff.City;
                    Dst := LocationBuff.City;
                    Pin := COPYSTR(LocationBuff."Pin Code", 1, 6);
                    StateBuff.GET(LocationBuff."State Code");
                    Stcd := StateBuff."State Code (GST Reg. No.)";
                    Ph := COPYSTR(LocationBuff."Phone No.", 1, 10);
                    Em := COPYSTR(LocationBuff."E-Mail", 1, 50);
                END
            ELSE
                WITH SalesCrMemoHeader DO BEGIN
                    IF "GST Customer Type" = "GST Customer Type"::Unregistered THEN
                        ERROR('Unregistered');
                    Gstin := "Customer GST Reg. No.";
                    TrdNm := "Bill-to Name";
                    Bno := "Bill-to Address";
                    Bnm := "Bill-to Address 2";
                    Flno := '';
                    Loc := "Bill-to City";
                    Dst := "Bill-to City";
                    Customer.GET("Sell-to Customer No.");
                    IF Customer."Pin Code" <> '' THEN
                        Pin := COPYSTR(Customer."Pin Code", 1, 6)
                    ELSE
                        ERROR('Customer Pin doesnot exist');
                    SalesCrMemoLine.SETRANGE("Document No.", "No.");
                    SalesCrMemoLine.SETFILTER(Quantity, '<>%1', 0);
                    IF SalesCrMemoLine.FINDFIRST THEN
                        IF SalesCrMemoLine."GST Place of Supply" = SalesCrMemoLine."GST Place of Supply"::"Bill-to Address" THEN BEGIN
                            IF NOT ("GST Customer Type" = "GST Customer Type"::Export) THEN BEGIN
                                StateBuff.GET("GST Bill-to State Code");
                                Stcd := StateBuff."State Code (GST Reg. No.)";
                                Stcddes := StateBuff.Description;
                            END ELSE
                                Stcd := '';
                            IF Contact.GET("Bill-to Contact No.") THEN BEGIN
                                Ph := COPYSTR(Contact."Phone No.", 1, 10);
                                Em := COPYSTR(Contact."E-Mail", 1, 50);
                            END ELSE BEGIN
                                Ph := '';
                                Em := '';
                            END;
                        END ELSE
                            IF SalesCrMemoLine."GST Place of Supply" = SalesCrMemoLine."GST Place of Supply"::"Ship-to Address" THEN BEGIN
                                IF NOT (SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Export) THEN BEGIN
                                    StateBuff.GET("GST Ship-to State Code");
                                    Stcd := StateBuff."State Code (GST Reg. No.)";
                                    Stcddes := StateBuff.Description;
                                END ELSE
                                    Stcd := '';
                                IF ShipToAddr.GET("Sell-to Customer No.", "Ship-to Code") THEN BEGIN
                                    Ph := COPYSTR(ShipToAddr."Phone No.", 1, 10);
                                    Em := COPYSTR(ShipToAddr."E-Mail", 1, 50);
                                END ELSE BEGIN
                                    Ph := '';
                                    Em := '';
                                END;
                            END ELSE BEGIN
                                Stcd := '';
                                Ph := '';
                                Em := '';
                            END;
                END;
        Ph := RemoveSpecialChar(Ph);
        GlbTrdNm := TrdNm;
        GlbBno := Bno;
        GlbBnm := Bnm;
        GlbFlno := Flno;
        GlbLoc := Loc;
        GlbDst := Dst;
        GlbPin := Pin;
        GlbStcd := Stcd;
        GlbPh := Ph;
        GlbEm := Em;
        GlbStcddes := Stcddes;

        IF IsExport THEN BEGIN
            Stcd := '96';
            Gstin := 'URP';
        END;
        //WriteBuyerDtls(Gstin,TrdNm,Bno,Bnm,Flno,Loc,Dst,Pin,Stcd,Ph,Em);
        WriteBuyerDtls(Gstin, TrdNm, Bno, Bnm, Flno, Loc, Dst, Pin, Stcd, Ph, Em, Stcddes);
    end;

    local procedure WriteBuyerDtls(Gstin: Text[15]; TrdNm: Text[100]; Bno: Text[60]; Bnm: Text[60]; Flno: Text[60]; Loc: Text[60]; Dst: Text[60]; Pin: Text[6]; Stcd: Text[2]; Ph: Text[10]; Em: Text[50]; Stcddes: Text)
    begin
        if Gstin <> '' then
            JHeaderObject.Add('custGstin', Gstin)
        else
            JHeaderObject.Add('custGstin', JGlobalNull);
        if TrdNm <> '' then
            JHeaderObject.Add('custOrSupName', TrdNm)
        else
            JHeaderObject.Add('custOrSupName', JGlobalNull);
        if TrdNm <> '' then
            JHeaderObject.Add('custTradeName', TrdNm)
        else
            JHeaderObject.Add('custTradeName', JGlobalNull);
        if Bno <> '' then
            JHeaderObject.add('custOrSupAddr1', Bno)
        else
            JHeaderObject.add('custOrSupAddr1', JGlobalNull);
        if Bnm <> '' then
            JHeaderObject.add('custOrSupAddr2', Bnm)
        else
            if Bno <> '' then
                JHeaderObject.add('custOrSupAddr2', Bno);

        if Loc <> '' then
            JHeaderObject.Add('custOrSupAddr4', Loc)
        else
            JHeaderObject.Add('custOrSupAddr4', JGlobalNull);
        if Pin <> '' then begin
            IF ConverttexttoInteger(Pin) <> 0 THEN
                JHeaderObject.add('custPincode', ConverttexttoInteger(Pin));
        end else
            JHeaderObject.Add('custPincode', JGlobalNull);

        IF Stcd <> '' THEN BEGIN
            IF ConverttexttoInteger(Stcd) <> 0 THEN
                JHeaderObject.Add('billToState', ConverttexttoInteger(Stcd));//rohan
        END
        ELSE
            JHeaderObject.Add('billToState', JGlobalNull);

        IF Stcd <> '' THEN BEGIN
            IF ConverttexttoInteger(Stcd) <> 0 THEN
                JHeaderObject.add('pos', Stcd);//rohan
        END
        ELSE
            JHeaderObject.add('pos', JGlobalNull);//rohan

        IF Ph <> '' THEN BEGIN
            IF ConverttexttoInteger(Ph) <> 0 THEN
                JHeaderObject.Add('custPhone', ConverttexttoInteger(Ph))
            ELSE
                JHeaderObject.Add('custPhone', JGlobalNull);
        END
        ELSE
            JHeaderObject.Add('custPhone', JGlobalNull);

        IF Em <> '' THEN
            JHeaderObject.add('custEmail', Em)
        ELSE
            JHeaderObject.add('custEmail', JGlobalNull)

        //JsonTextWriter.WriteEndObject;
    end;

    local procedure ReadShipDtls()
    var
        ShipToAddr: Record 222;
        LocationBuff: Record 14;
        StateBuff: Record State;
        Gstin: Text[15];
        TrdNm: Text[100];
        Bno: Text[60];
        Bnm: Text[60];
        Flno: Text[60];
        Loc: Text[60];
        Dst: Text[60];
        Pin: Text[6];
        Stcd: Text[2];
        Ph: Text[10];
        Em: Text[50];
        stcddes: Text;
    begin
        IF IsInvoice AND (ShipToModel) THEN BEGIN
            WITH SalesInvoiceHeader DO BEGIN
                IF ShipToAddr.GET("Sell-to Customer No.", "Ship-to Code") THEN;
                Gstin := ShipToAddr."GST Registration No.";
                IF Gstin = '' THEN
                    Gstin := "Ship-to GST Reg. No.";
                TrdNm := "Ship-to Name";
                Bno := "Ship-to Address";
                Bnm := "Ship-to Address 2";
                Flno := '';
                Loc := "Ship-to City";
                Dst := "Ship-to City";
                Pin := COPYSTR("Ship to Pin", 1, 6);
                StateBuff.GET("GST Ship-to State Code");
                Stcd := StateBuff."State Code (GST Reg. No.)";
                stcddes := StateBuff.Description;
                Ph := COPYSTR(ShipToAddr."Phone No.", 1, 10);
                Em := COPYSTR(ShipToAddr."E-Mail", 1, 50);
            END;
            IF IsExport THEN BEGIN
                Stcd := '96';
                Gstin := 'URP';
                stcddes := '96';
            END;
            IF IsEWB THEN
                Stcd := '97';

            WriteShipDtls(Gstin, TrdNm, Bno, Bnm, Flno, Loc, Dst, Pin, Stcd, Ph, Em, stcddes);
        END ELSE
            IF IsTransferInvoice THEN
                WITH TransferShipmentHeader DO BEGIN
                    LocationBuff.GET("Transfer-to Code");
                    Gstin := LocationBuff."GST Registration No.";
                    TrdNm := LocationBuff.Name;
                    Bno := LocationBuff.Address;
                    Bnm := LocationBuff."Address 2";
                    Flno := '';
                    Loc := LocationBuff.City;
                    Dst := LocationBuff.City;
                    Pin := COPYSTR(LocationBuff."Post Code", 1, 6);
                    StateBuff.GET(LocationBuff."State Code");
                    Stcd := StateBuff."State Code (GST Reg. No.)";
                    stcddes := StateBuff.Description;
                    Ph := COPYSTR(LocationBuff."Phone No.", 1, 10);
                    Em := COPYSTR(LocationBuff."E-Mail", 1, 50);
                END
            ELSE
                IF SalesCrMemoHeader."Ship-to Code" <> '' THEN BEGIN
                    WITH SalesCrMemoHeader DO BEGIN
                        ShipToAddr.GET("Sell-to Customer No.", "Ship-to Code");
                        Gstin := ShipToAddr."GST Registration No.";
                        TrdNm := "Ship-to Name";
                        Bno := "Ship-to Address";
                        Bnm := "Ship-to Address 2";
                        Flno := '';
                        Loc := "Ship-to City";
                        Dst := "Ship-to City";
                        Pin := COPYSTR("Ship-to Post Code", 1, 6);
                        StateBuff.GET("GST Ship-to State Code");
                        Stcd := StateBuff."State Code (GST Reg. No.)";
                        stcddes := StateBuff.Description;
                        Ph := COPYSTR(ShipToAddr."Phone No.", 1, 10);
                        Em := COPYSTR(ShipToAddr."E-Mail", 1, 50);
                    END;
                    WriteShipDtls(Gstin, TrdNm, Bno, Bnm, Flno, Loc, Dst, Pin, Stcd, Ph, Em, stcddes);
                END;

        IF IsExport THEN BEGIN
            GlbStcddes := '96';
            GlbStcd := '96';
        END;
        /*IF TrdNm='' THEN
          WriteShipDtls(GSTNNo,GlbTrdNm,GlbBno,GlbBnm,GlbFlno,GlbLoc,GlbDst,GlbPin,GlbStcd,GlbPh,GlbEm,stcddes);
        */
    end;

    local procedure WriteShipDtls(Gstin: Text[15]; TrdNm: Text[100]; Bno: Text[60]; Bnm: Text[60]; Flno: Text[60]; Loc: Text[60]; Dst: Text[60]; Pin: Text[6]; Stcd: Text[2]; Ph: Text[10]; Em: Text[50]; stcddes: Text)
    begin

        IF Gstin <> '' THEN
            JHeaderObject.add('shipToGstin', Gstin)//rohan
        ELSE
            JHeaderObject.add('shipToGstin', JGlobalNull);

        IF TrdNm <> '' THEN
            JHeaderObject.add('shipToLegalName', TrdNm)
        ELSE
            JHeaderObject.add('shipToLegalName', JGlobalNull);

        IF TrdNm <> '' THEN
            JHeaderObject.add('shipToTradeName', TrdNm)
        ELSE
            JHeaderObject.add('shipToTradeName', JGlobalNull);

        IF Bno <> '' THEN
            JHeaderObject.add('shipToBuildingNo', Bno)
        ELSE
            JHeaderObject.add('shipToBuildingNo', JGlobalNull);

        IF Bnm <> '' THEN
            JHeaderObject.add('shipToBuildingName', Bnm)
        ELSE
            JHeaderObject.add('shipToBuildingName', JGlobalNull);

        IF Loc <> '' THEN
            JHeaderObject.add('shipToLocation', Loc)
        ELSE
            JHeaderObject.add('shipToLocation', JGlobalNull);

        IF Pin <> '' THEN
            JHeaderObject.add('shipToPincode', Pin)
        ELSE
            JHeaderObject.add('shipToPincode', JGlobalNull);

        IF Stcd <> '' THEN
            JHeaderObject.add('shipToState', Stcd)//rohan
        ELSE
            JHeaderObject.add('shipToState', JGlobalNull);

        /*
        JsonTextWriter.WritePropertyName('phone_number');
        IF Ph <> '' THEN
          IF ConverttexttoInteger(Ph)<>0 THEN
          JsonTextWriter.WriteValue(ConverttexttoInteger(Ph))
          ELSE
            JsonTextWriter.WriteValue(GlobalNULL)
        ELSE
          JsonTextWriter.WriteValue(GlobalNULL);

        JsonTextWriter.WritePropertyName('email');
        IF Em <> '' THEN
          JsonTextWriter.WriteValue(Em)
        ELSE
          JsonTextWriter.WriteValue(GlobalNULL);
        */
        //JsonTextWriter.WriteEndObject;
    end;

    local procedure WriteEWBDtls(IRN: Text; transporterID: Text; transporterName: Text; transportMode: Code[10]; transportDocNo: Text; transportDocDate: Text; distance: Integer; vehicleNo: Code[20]; vehicleType: Text)
    begin

        IF IRN <> '' THEN
            JHeaderObject.Add('irn', IRN)
        ELSE
            JHeaderObject.Add('irn', JGlobalNull);

        IF transporterID <> '' THEN
            JHeaderObject.Add('transporterID', transporterID)
        ELSE
            JHeaderObject.Add('transporterID', JGlobalNull);
        ;

        IF transporterName <> '' THEN
            JHeaderObject.Add('transporterName', transporterName)
        ELSE
            JHeaderObject.Add('transporterName', JGlobalNull);

        IF transportMode <> '' THEN
            JHeaderObject.Add('transportMode', transportMode)
        ELSE
            JHeaderObject.Add('transportMode', JGlobalNull);

        IF transportDocNo <> '' THEN
            JHeaderObject.Add('transportDocNo', transportDocNo)
        ELSE
            JHeaderObject.Add('transportDocNo', JGlobalNull);

        IF transportDocDate <> '' THEN
            JHeaderObject.Add('transportDocDate', transportDocDate)
        ELSE
            JHeaderObject.Add('transportDocDate', JGlobalNull);

        IF distance <> 0 THEN
            JHeaderObject.Add('distance', distance)
        ELSE
            JHeaderObject.Add('distance', 0);

        IF vehicleNo <> '' THEN
            JHeaderObject.Add('vehicleNo', vehicleNo)
        ELSE
            JHeaderObject.Add('vehicleNo', JGlobalNull);

        IF vehicleType <> '' THEN
            JHeaderObject.Add('vehicleType', vehicleType)
        ELSE
            JHeaderObject.Add('vehicleType', JGlobalNull);
    end;

    local procedure ReadValDtls()
    var
        AssVal: Decimal;
        CgstVal: Decimal;
        SgstVal: Decimal;
        IgstVal: Decimal;
        CesVal: Decimal;
        StCesVal: Decimal;
        CesNonAdval: Decimal;
        Disc: Decimal;
        OthChrg: Decimal;
        TotInvVal: Decimal;
        TCSAmt: Decimal;
        RndOffAmt: Decimal;
    begin
        GetGSTVal(AssVal, CgstVal, SgstVal, IgstVal, CesVal, StCesVal, CesNonAdval, Disc, OthChrg, TotInvVal, TCSAmt, RndOffAmt);
        WriteValDtls(AssVal, CgstVal, SgstVal, IgstVal, CesVal, StCesVal, CesNonAdval, Disc, OthChrg, TotInvVal, TCSAmt, RndOffAmt);
    end;

    local procedure WriteValDtls(Assval: Decimal; CgstVal: Decimal; SgstVAl: Decimal; IgstVal: Decimal; CesVal: Decimal; StCesVal: Decimal; CesNonAdVal: Decimal; Disc: Decimal; OthChrg: Decimal; TotInvVal: Decimal; TCSAmt: Decimal; RndOffAmt: Decimal)
    var
        ReportCheck: Report "Check Report";
        AmtinWord: array[5] of Text;
    begin

        IF NOT IsExport THEN
            JHeaderObject.add('invAssessableAmt', abs(Assval))
        ELSE
            JHeaderObject.add('invAssessableAmt', abs(TotInvVal));
        JHeaderObject.add('invCgstAmt', CgstVal);
        JHeaderObject.add('invSgstAmt', SgstVAl);
        JHeaderObject.add('invIgstAmt', IgstVal);
        JHeaderObject.add('invCessAdvaloremAmt', CesVal);
        JHeaderObject.add('invStateCessSpecificAmt', CesNonAdVal);
        ReportCheck.InitTextVariable();
        ReportCheck.FormatNoText(AmtinWord, TotInvVal, '');
        JHeaderObject.add('totalInvValueInWords', uppercase(AmtinWord[1]));
        JHeaderObject.add('invStateCessAmt', StCesVal);
        JHeaderObject.add('RoundOff', RndOffAmt);
        JHeaderObject.Add('invOtherCharges', OthChrg + TCSAmt);
        //JsonTextWriter.WriteEndObject();
    end;

    local procedure GetGSTVal(var AssVal: Decimal; var CgstVal: Decimal; var SgstVal: Decimal; var IgstVal: Decimal; var CesVal: Decimal; var StCesVal: Decimal; var CesNonAdval: Decimal; var Disc: Decimal; var OthChrg: Decimal; var TotInvVal: Decimal; var TCSAmt: Decimal; var RndOffAmt: Decimal)
    var
        SalesInvoiceLine: Record 113;
        SalesCrMemoLine: Record 115;
        GSTLedgerEntry: Record "GST Ledger Entry";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CurrExchRate: Record 330;
        CustLedgerEntry: Record 21;
        //GSTComponent: Record 16405;
        TotGSTAmt: Decimal;
        TransferShipmentLine: Record 5745;
        GSTAmount: Decimal;
        GSTBaseAmount: Decimal;
        TCSAmount: Decimal;
        TGSTAmt: Decimal;
        SalesInvLine: Record "Sales Invoice Line";
        SCrGSTAmount: Decimal;
        SCrGSTBaseAmount: Decimal;
        SCrTCSAmount: Decimal;
        DiscouAmt: Decimal;
        GSTBAmt: Decimal;
        GSTBCrAmt: Decimal;
    begin
        GSTLedgerEntry.SETRANGE("Document No.", DocumentNo);

        GSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
        IF GSTLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                CgstVal += ABS(GSTLedgerEntry."GST Amount");
            UNTIL GSTLedgerEntry.NEXT = 0;
        END ELSE
            CgstVal := 0;

        GSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
        IF GSTLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                SgstVal += ABS(GSTLedgerEntry."GST Amount")
            UNTIL GSTLedgerEntry.NEXT = 0;
        END ELSE
            SgstVal := 0;

        GSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
        IF GSTLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                IgstVal += ABS(GSTLedgerEntry."GST Amount")
            UNTIL GSTLedgerEntry.NEXT = 0;
        END ELSE
            IgstVal := 0;

        CesVal := 0;
        CesNonAdval := 0;

        GSTLedgerEntry.SETRANGE("GST Component Code", 'INTERCESS');
        IF GSTLedgerEntry.FINDSET THEN
            REPEAT
                CesVal += ABS(GSTLedgerEntry."GST Amount")
            UNTIL GSTLedgerEntry.NEXT = 0;

        DetailedGSTLedgerEntry.SETRANGE("Document No.", DocumentNo);
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CESS');
        IF DetailedGSTLedgerEntry.FINDFIRST THEN
            REPEAT
                IF DetailedGSTLedgerEntry."GST %" > 0 THEN
                    CesVal += ABS(DetailedGSTLedgerEntry."GST Amount")
                ELSE
                    CesNonAdval += ABS(DetailedGSTLedgerEntry."GST Amount");
            UNTIL GSTLedgerEntry.NEXT = 0;

        /* GSTLedgerEntry.SETFILTER("GST Component Code", '<>CGST&<>SGST&<>IGST&<>CESS&<>INTERCESS');
        IF GSTLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                IF GSTComponent.GET(GSTLedgerEntry."GST Component Code") THEN
                    IF GSTComponent."Exclude from Reports" THEN
                        StCesVal += ABS(GSTLedgerEntry."GST Amount");
            UNTIL GSTLedgerEntry.NEXT = 0;
        END; */ // 15800 StCess Value Asking
        StCesVal := 0;

        IF IsInvoice THEN BEGIN
            SalesInvoiceLine.SETRANGE("Document No.", DocumentNo);
            SalesInvoiceLine.SETFILTER(Quantity, '<>%1', 0);
            SalesInvoiceLine.SETFILTER("No.", '<>%1', '');
            IF SalesInvoiceLine.FINDSET THEN BEGIN
                REPEAT
                    GSTValueSalesHeader(SalesInvoiceLine, GSTBaseAmount, GSTAmount, DiscouAmt, GSTBAmt);
                    GetTCSAmt(SalesInvoiceLine, TCSAmount);
                    IF SalesInvoiceLine."GST Assessable Value (LCY)" <> 0 THEN
                        AssVal += SalesInvoiceLine."GST Assessable Value (LCY)"
                    ELSE
                        AssVal := GSTBAmt;
                    TotGSTAmt := GSTAmount;
                    Disc += SalesInvoiceLine."Inv. Discount Amount";
                    IF SalesInvoiceLine."No." = '51157000' THEN
                        RndOffAmt += SalesInvoiceLine.Amount;
                    OthChrg := 0;
                    /* SalesInvLine.Reset();
                    SalesInvLine.SetRange("Document No.", DocumentNo);
                    SalesInvLine.SetFilter("No.", '%1|%2', 'INSURANCE', '61462000');
                    if SalesInvLine.FindSet() then
                        repeat
                            OthChrg += SalesInvLine."Line Amount";
                        until SalesInvLine.Next() = 0; */ // 15800 
                    TCSAmt := TCSAmount;


                    /* IF (SalesInvoiceLine."GST Base Amount" = (SalesInvoiceLine.Amount + SalesInvoiceLine."Charges To Customer" + (SalesInvoiceLine."GST Base Amount" - SalesInvoiceLine.Amount - SalesInvoiceLine."Charges To Customer"))) THEN
                        OthChrg += (-SalesInvoiceLine."GST Base Amount" + SalesInvoiceLine.Amount + SalesInvoiceLine."Charges To Customer")
                    ELSE
                        IF SalesInvoiceLine."GST Base Amount" <> SalesInvoiceLine.Amount + SalesInvoiceLine."Charges To Customer" THEN
                            OthChrg += SalesInvoiceLine."Charges To Customer"
                        ELSE
                     */     // 15800 Need To Asking Functional What is the Alternate of Charge To Customer Filed In BC.
                    OthChrg += 0;
                UNTIL SalesInvoiceLine.NEXT = 0;
            END;

            AssVal := ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  WORKDATE, SalesInvoiceHeader."Currency Code", AssVal, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
            TotGSTAmt := ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  WORKDATE, SalesInvoiceHeader."Currency Code", TotGSTAmt, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
            Disc := ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  WORKDATE, SalesInvoiceHeader."Currency Code", Disc, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
        END ELSE
            IF IsTransferInvoice THEN BEGIN
                TransferShipmentLine.SETRANGE("Document No.", DocumentNo);
                IF TransferShipmentLine.FINDSET THEN BEGIN
                    REPEAT
                        GetGSTValueTransferHedaer(TransferShipmentLine, TGSTAmt);
                        AssVal += TransferShipmentLine.Amount;
                        TotGSTAmt := TGSTAmt;
                        Disc += 0;
                    UNTIL TransferShipmentLine.NEXT = 0;
                END;
            END
            ELSE BEGIN
                SalesCrMemoLine.SETRANGE("Document No.", DocumentNo);
                SalesCrMemoLine.SETFILTER(Quantity, '<>%1', 0);
                SalesCrMemoLine.SETFILTER("No.", '<>%1', '');
                IF SalesCrMemoLine.FINDSET THEN BEGIN
                    REPEAT
                        GSTValueSalesCrHeader(SalesCrMemoLine, SCrGSTBaseAmount, SCrGSTAmount, GSTBCrAmt);
                        GetTCSSaleCRAmt(SalesCrMemoLine, SCrTCSAmount);
                        AssVal := GSTBCrAmt;

                        TotGSTAmt := SCrGSTAmount;
                        Disc += SalesCrMemoLine."Inv. Discount Amount";
                        TCSAmt := SCrTCSAmount;
                    UNTIL SalesCrMemoLine.NEXT = 0;
                END;

                AssVal := ROUND(
                    CurrExchRate.ExchangeAmtFCYToLCY(
                      WORKDATE, SalesCrMemoHeader."Currency Code", AssVal, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
                TotGSTAmt := ROUND(
                    CurrExchRate.ExchangeAmtFCYToLCY(
                      WORKDATE, SalesCrMemoHeader."Currency Code", TotGSTAmt, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
                Disc := ROUND(
                    CurrExchRate.ExchangeAmtFCYToLCY(
                      WORKDATE, SalesCrMemoHeader."Currency Code", Disc, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
            END;

        CustLedgerEntry.SETCURRENTKEY("Document No.");
        CustLedgerEntry.SETRANGE("Document No.", DocumentNo);
        IF IsInvoice THEN BEGIN
            CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
            CustLedgerEntry.SETRANGE("Customer No.", SalesInvoiceHeader."Bill-to Customer No.");
        END ELSE BEGIN
            CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::"Credit Memo");
            CustLedgerEntry.SETRANGE("Customer No.", SalesCrMemoHeader."Bill-to Customer No.");
        END;
        IF CustLedgerEntry.FINDFIRST THEN BEGIN
            CustLedgerEntry.CALCFIELDS("Amount (LCY)");
            TotInvVal := ABS(CustLedgerEntry."Amount (LCY)");
            GbFinalinvoiceValue := TotInvVal;
        END;

        IF IsTransferInvoice THEN BEGIN
            TransferShipmentLine.SETRANGE("Document No.", DocumentNo);
            IF TransferShipmentLine.FINDFIRST THEN
                REPEAT
                    GetGSTValueTransferHedaer(TransferShipmentLine, TGSTAmt);
                    TotInvVal += TransferShipmentLine.Amount;
                UNTIL TransferShipmentLine.NEXT = 0;
            TotInvVal += TGSTAmt;
            GbFinalinvoiceValue := TotInvVal
        END;

        OthChrg := 0;
    end;

    local procedure ReadItemList()
    var
        SalesInvoiceLine: Record 113;
        SalesCrMemoLine: Record 115;
        TransferShipmentLine: Record 5745;
        GstRt: Decimal;
        CgstAmt: Decimal;
        SgstAmt: Decimal;
        IgstAmt: Decimal;
        CesRt: Decimal;
        CesAmt: Decimal;
        CesNonAdvalAmt: Decimal;
        StateCesRt: Decimal;
        StateCesAmt: Decimal;
        StateCesNonAdvalAmt: Decimal;
        AssAmt: Decimal;
        FreeQty: Decimal;
        ItmNo: Code[20];
        NotChargeAmt: Decimal;
        DecAssAmt: Decimal;
        STCessValAmt: Decimal;
        DiscAmt: Decimal;
        OtherChrAmt: Decimal;
        TotalInvValue: Decimal;
        SLGSTBaseAmt: Decimal;
        SLGSTAmt: Decimal;
        TLGSTBaseAmt: Decimal;
        TLGSTAmt: Decimal;
        SCLGSTBaseAmt: Decimal;
        SCLGSTAmt: Decimal;
        DiscountAmt: Decimal;
        DiscAmtCrLine: Decimal;
    begin
        IF IsInvoice THEN BEGIN
            SalesInvoiceLine.SETRANGE("Document No.", DocumentNo);

            SalesInvoiceLine.SETFILTER("System-Created Entry", '%1', FALSE);
            SalesInvoiceLine.SETFILTER(Quantity, '<>%1', 0);
            // 15800  SalesInvoiceLine.SetFilter("No.", '<>%1&<>%2&<>%3', '61462000', 'INSURANCE', '51157000');
            IF SalesInvoiceLine.FINDSET THEN BEGIN
                IF SalesInvoiceLine.COUNT > 1000 THEN
                    ERROR(SalesLinesErr, SalesInvoiceLine.COUNT);
                REPEAT
                    GetGSTAmtSalesLine(SalesInvoiceLine, SLGSTBaseAmt, SLGSTAmt, DiscountAmt);
                    IF SalesInvoiceLine."GST Assessable Value (LCY)" <> 0 THEN
                        AssAmt := SalesInvoiceLine."GST Assessable Value (LCY)"
                    ELSE
                        // 15800    AssAmt := SLGSTBaseAmt - DiscountAmt; 
                        AssAmt := ((SalesInvoiceLine.Quantity * SalesInvoiceLine."Unit Price") - SalesInvoiceLine."Line Discount Amount" - SalesInvoiceLine."Inv. Discount Amount");
                    /*  IF SalesInvoiceLine."Free Supply" THEN
                         FreeQty := SalesInvoiceLine.Quantity
                     ELSE*/
                    FreeQty := 0;
                    ItmNo := FORMAT(SalesInvoiceLine."Line No.");

                    /* IF SalesInvoiceLine."Charges To Customer" <> 0 THEN BEGIN
                        IF NOT IsExport THEN BEGIN
                            IF (SalesInvoiceLine."GST Base Amount" = (SalesInvoiceLine.Amount + SalesInvoiceLine."Charges To Customer")) THEN
                                NotChargeAmt := SalesInvoiceLine."Charges To Customer"
                            ELSE
                                IF (SalesInvoiceLine."GST Base Amount" = (SalesInvoiceLine.Amount + SalesInvoiceLine."Charges To Customer" + (SalesInvoiceLine."GST Base Amount" - SalesInvoiceLine.Amount - SalesInvoiceLine."Charges To Customer"))) THEN
                                    NotChargeAmt := SalesInvoiceLine."Charges To Customer" + (SalesInvoiceLine."GST Base Amount" - SalesInvoiceLine.Amount - SalesInvoiceLine."Charges To Customer")
                                ELSE
                                    NotChargeAmt := 0;
                        END
                        ELSE
                            NotChargeAmt := SalesInvoiceLine."Charges To Customer";
                    END; */ // 15800 Need To Asking Functional What is the Alternate od Charge To Customer Filed In BC.
                    NotChargeAmt := 0;

                    GetGSTCompRate(SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.", GstRt,
                    CgstAmt, SgstAmt, IgstAmt, CesRt, CesAmt, CesNonAdvalAmt, StateCesRt, StateCesAmt, StateCesNonAdvalAmt);
                    CgstAmt := 0;
                    SgstAmt := 0;
                    IgstAmt := 0;
                    CesAmt := 0;
                    DiscAmt := 0;
                    CesNonAdvalAmt := 0;
                    StateCesAmt := 0;
                    StateCesNonAdvalAmt := 0;
                    OtherChrAmt := 0;
                    GetGSTValLine(SalesInvoiceLine."Document No.", SalesInvoiceLine."Line No.", DecAssAmt,
                    CgstAmt, SgstAmt, IgstAmt, CesAmt, STCessValAmt, CesNonAdvalAmt, DiscAmt, OtherChrAmt, TotalInvValue);

                    WriteItem(ItmNo,
                      SalesInvoiceLine.Description + SalesInvoiceLine."Description 2", (SalesInvoiceLine."GST Group Type" = SalesInvoiceLine."GST Group Type"::Service),
                      SalesInvoiceLine."HSN/SAC Code", '',
                      SalesInvoiceLine.Quantity, FreeQty,
                      COPYSTR(GetUOM(SalesInvoiceLine."Unit of Measure Code"), 1, 3),
                      SalesInvoiceLine."Unit Price",
                      SalesInvoiceLine."Line Amount" + SalesInvoiceLine."Line Discount Amount" + NotChargeAmt,
                      DiscAmt, OtherChrAmt,
                      AssAmt, GstRt, CgstAmt, SgstAmt, IgstAmt, CesRt, CesAmt, CesNonAdvalAmt, StateCesRt, StateCesAmt, StateCesNonAdvalAmt,
                      (SalesInvoiceLine."Line Amount" + abs(SLGSTAmt)) - DiscountAmt + /* SalesInvoiceLine."Charges To Customer" */ 0,
                      SalesInvoiceLine."Line No.");
                UNTIL SalesInvoiceLine.NEXT = 0;
            END;
        END ELSE
            IF IsTransferInvoice THEN BEGIN
                TransferShipmentLine.SETRANGE("Document No.", DocumentNo);
                TransferShipmentLine.SETFILTER(Quantity, '<>%1', 0);
                IF TransferShipmentLine.FINDFIRST THEN BEGIN
                    IF TransferShipmentLine.COUNT > 1000 THEN
                        ERROR(SalesLinesErr, TransferShipmentLine.COUNT);

                    REPEAT
                        GetGSTAmtTransferLine(TransferShipmentLine, TLGSTBaseAmt, TLGSTAmt);
                        // ItmNo:=TransferShipmentLine."Item No.";
                        ItmNo := FORMAT(TransferShipmentLine."Line No.");
                        IF TransferShipmentLine."GST Assessable Value" <> 0 THEN
                            AssAmt := TransferShipmentLine."GST Assessable Value"
                        ELSE
                            AssAmt := TLGSTBaseAmt;

                        GetGSTCompRate(TransferShipmentLine."Document No.", TransferShipmentLine."Line No.", GstRt,
                          CgstAmt, SgstAmt, IgstAmt, CesRt, CesAmt, CesNonAdvalAmt, StateCesRt, StateCesAmt, StateCesNonAdvalAmt);
                        WriteItem(ItmNo,
                          TransferShipmentLine.Description + TransferShipmentLine."Description 2", FALSE,
                          TransferShipmentLine."HSN/SAC Code", '',
                          TransferShipmentLine.Quantity, FreeQty,
                          COPYSTR(GetUOM(TransferShipmentLine."Unit of Measure Code"), 1, 3),
                          TransferShipmentLine."Unit Price",
                          TransferShipmentLine.Quantity * TransferShipmentLine."Unit Price",
                          0, 0,
                           AssAmt, GstRt, CgstAmt, SgstAmt, IgstAmt, CesRt, CesAmt, CesNonAdvalAmt, StateCesRt, StateCesAmt, StateCesNonAdvalAmt,
                          TransferShipmentLine.Amount + abs(TLGSTAmt),
                          TransferShipmentLine."Line No.");
                    UNTIL TransferShipmentLine.NEXT = 0;
                END;
            END
            ELSE BEGIN
                SalesCrMemoLine.SETRANGE("Document No.", DocumentNo);
                SalesCrMemoLine.SETFILTER(Type, '<>%1', SalesCrMemoLine.Type::" ");
                SalesCrMemoLine.SETFILTER("System-Created Entry", '%1', FALSE);
                SalesCrMemoLine.SETFILTER(Quantity, '<>%1', 0);
                IF SalesCrMemoLine.FIND('-') THEN BEGIN
                    IF SalesCrMemoLine.COUNT > 1000 THEN
                        ERROR(SalesLinesErr, SalesCrMemoLine.COUNT);

                    REPEAT
                        GetGSTAmtSalesCrLine(SalesCrMemoLine, SCLGSTBaseAmt, SCLGSTAmt, DiscAmtCrLine);
                        IF SalesCrMemoLine."GST Assessable Value (LCY)" <> 0 THEN
                            AssAmt := SalesCrMemoLine."GST Assessable Value (LCY)"
                        ELSE
                            // 15800 AssAmt := SCLGSTBaseAmt;
                            AssAmt := ((SalesCrMemoLine.Quantity * SalesCrMemoLine."Unit Price") - SalesCrMemoLine."Line Discount Amount" - SalesCrMemoLine."Inv. Discount Amount");
                        /* IF SalesCrMemoLine."Free Supply" THEN
                            FreeQty := SalesCrMemoLine.Quantity
                        ELSE */ // 15800
                        FreeQty := 0;
                        ItmNo := SalesCrMemoLine."No.";

                        /* IF SalesCrMemoLine."Charges To Customer" <> 0 THEN BEGIN
                            IF (SalesCrMemoLine."GST Base Amount" = (SalesCrMemoLine.Amount + SalesCrMemoLine."Charges To Customer")) THEN
                                NotChargeAmt := SalesCrMemoLine."Charges To Customer"
                            ELSE
                                IF (SalesCrMemoLine."GST Base Amount" = (SalesCrMemoLine.Amount + SalesCrMemoLine."Charges To Customer" + (SalesCrMemoLine."GST Base Amount" - SalesCrMemoLine.Amount - SalesCrMemoLine."Charges To Customer"))) THEN
                                    NotChargeAmt := SalesCrMemoLine."Charges To Customer" + (SalesCrMemoLine."GST Base Amount" - SalesCrMemoLine.Amount - SalesCrMemoLine."Charges To Customer")
                                ELSE
                                    NotChargeAmt := 0;
                        END; */ // 15800 Charge to Customer
                        NotChargeAmt := 0;
                        GetGSTCompRate(SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.", GstRt,
                          CgstAmt, SgstAmt, IgstAmt, CesRt, CesAmt, CesNonAdvalAmt, StateCesRt, StateCesAmt, StateCesNonAdvalAmt);
                        CgstAmt := 0;
                        SgstAmt := 0;
                        IgstAmt := 0;
                        CesAmt := 0;
                        DiscAmt := 0;
                        CesNonAdvalAmt := 0;
                        StateCesAmt := 0;
                        StateCesNonAdvalAmt := 0;
                        OtherChrAmt := 0;
                        GetGSTValLine(SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.", DecAssAmt,
                        CgstAmt, SgstAmt, IgstAmt, CesAmt, STCessValAmt, CesNonAdvalAmt, DiscAmt, OtherChrAmt, TotalInvValue);
                        WriteItem(ItmNo,
                          SalesCrMemoLine.Description + SalesCrMemoLine."Description 2", (SalesCrMemoLine."GST Group Type" = SalesCrMemoLine."GST Group Type"::Service),
                          SalesCrMemoLine."HSN/SAC Code", '',
                          SalesCrMemoLine.Quantity, FreeQty,
                          COPYSTR(GetUOM(SalesCrMemoLine."Unit of Measure Code"), 1, 3),
                          SalesCrMemoLine."Unit Price",
                          SalesCrMemoLine."Line Amount" + SalesCrMemoLine."Line Discount Amount" + NotChargeAmt,
                          DiscAmt, OtherChrAmt,
                          AssAmt, GstRt, CgstAmt, SgstAmt, IgstAmt, CesRt, CesAmt, CesNonAdvalAmt, StateCesRt, StateCesAmt, StateCesNonAdvalAmt,
                         (SalesCrMemoLine."Line Amount" + abs(SCLGSTAmt) - DiscAmtCrLine),
                          SalesCrMemoLine."Line No.");
                    UNTIL SalesCrMemoLine.NEXT = 0;
                END;
            END;
    end;

    local procedure GetUOM(UOMCode: Code[10]): Text
    var
        UnitofMeasure: Record 204;
    begin
        IF ((UnitofMeasure.GET(UOMCode)) AND (UnitofMeasure."E-Way Code" <> '')) THEN
            EXIT(UnitofMeasure."E-Way Code");
        if UOMCode = '' then
            exit('OTH');
        //  ERROR('Unit of measure code must have value %1', UnitofMeasure.Code);
    end;

    local procedure WriteItem(ItmNo: Code[20]; PrdNm: Text[100]; IsService: Boolean; HsnCd: Text[8]; Barcde: Text[30]; Qty: Decimal; FreeQty: Decimal; Unit: Text[3]; UnitPrice: Decimal; TotAmt: Decimal; Discount: Decimal; OthChrg: Decimal; AssAmt: Decimal; GstRt: Decimal; CgstAmt: Decimal; SgstAmt: Decimal; IgstAmt: Decimal; CesRt: Decimal; CesAmt: Decimal; CesNonAdvalAmt: Decimal; StateCesRt: Decimal; StateCesAmt: Decimal; StateCesNonAdvalAmt: Decimal; TotItemVal: Decimal; SILineNo: Integer)
    begin
        SerialNo += 1;

        IF ItmNo <> '' THEN
            JLineObject.add('supplyType', SubSuppType)
        ELSE
            JLineObject.add('supplyType', JGlobalNull);
        ;

        IF ItmNo <> '' THEN
            JLineObject.add('itemNo', SerialNo)
        ELSE
            JLineObject.add('itemNo', JGlobalNull);

        IF PrdNm <> '' THEN
            JLineObject.Add('productName', PrdNm)
        ELSE
            JLineObject.Add('productName', JGlobalNull);

        IF IsService THEN
            JLineObject.Add('isService', 'Y')
        ELSE
            JLineObject.Add('isService', 'N');

        IF HsnCd <> '' THEN
            JLineObject.Add('hsnsacCode', HsnCd)
        ELSE
            JLineObject.Add('hsnsacCode', JGlobalNull);

        IF Barcde <> '' THEN
            JLineObject.Add('Barcode', Barcde);
        JLineObject.Add('itemQty', Qty);

        JLineObject.Add('freeQuantity', FreeQty);

        IF Unit <> '' THEN
            JLineObject.Add('itemUqc', Unit)
        ELSE
            JLineObject.Add('itemUqc', JGlobalNull);

        JLineObject.Add('unitPrice', ROUND(UnitPrice * CurrExRate, 0.01, '='));

        IF Discount > 0 THEN BEGIN
            JLineObject.Add('itemAmt', ROUND(TotAmt * CurrExRate, 0.01, '='));
            JLineObject.Add('itemDiscount', ABS(Discount));
        END
        ELSE BEGIN
            JLineObject.Add('itemAmt', ROUND((TotAmt * CurrExRate) + ABS(Discount), 0.01, '='));
            JLineObject.Add('itemDiscount', ABS(0));
        END;
        JLineObject.Add('otherValues', ABS(OthChrg * CurrExRate));

        IF NOT IsExport THEN
            JLineObject.Add('taxableVal', (abs(AssAmt) * CurrExRate))
        ELSE
            JLineObject.Add('taxableVal', ROUND(TotItemVal * CurrExRate, 0.01, '='));

        IF (CgstAmt <> 0) AND (SgstAmt <> 0) THEN BEGIN
            JLineObject.Add('cgstRt', GstRt / 2);
            JLineObject.Add('sgstRt', GstRt / 2);
        END
        ELSE BEGIN
            JLineObject.Add('cgstRt', JGlobalNull);
            JLineObject.Add('sgstRt', JGlobalNull)
        END;

        IF (IgstAmt <> 0) THEN BEGIN
            JLineObject.Add('igstRt', GstRt);
        END
        ELSE BEGIN
            JLineObject.Add('igstRt', GstRt);
        END;
        JLineObject.Add('cgstAmt', CgstAmt);
        JLineObject.Add('sgstAmt', SgstAmt);
        JLineObject.Add('igstAmt', IgstAmt);
        JLineObject.Add('cessRtAdvalorem', CesRt);
        JLineObject.Add('cessAmtAdvalorem', CesAmt);

        //JsonTextWriter.WritePropertyName('CESNONADVALAMT');
        //JsonTextWriter.WriteValue(CesNonAdvalAmt);
        JLineObject.Add('stateCessRt', StateCesRt);
        JLineObject.Add('stateCessAmt', StateCesAmt);

        //JsonTextWriter.WritePropertyName('StateCesNonAdvlAmt');
        //JsonTextWriter.WriteValue(StateCesNonAdvalAmt);
        JLineObject.Add('totalItemAmt', (TotItemVal * CurrExRate));
        JLineObject.Add('lineItemAmt', GbFinalinvoiceValue);
        JLineArray.add(JLineObject);
        Clear(JLineObject);
    end;

    procedure GetIRNNo()
    var
        IRNNo: Text[100];
        SalesInvoiceHeader: Record 112;
        rLocation: Record 14;
        EinvoiceHttpClient: HttpClient;
        EinvoiceHttpRequest: HttpRequestMessage;
        EinvoiceHttpContent: HttpContent;
        EinvoiceHttpHeader: HttpHeaders;
        EinvoiceHttpResponse: HttpResponseMessage;
        JOutputObject: JsonObject;
        JOutputToken: JsonToken;
        JResultToken: JsonToken;
        JResultObject: JsonObject;
        OutputMessage: Text;
        ResultMessage: Text;
        Ackdate: DateTime;
        AckNo: Code[50];
        AckDateText: Text;
        DayCode: Integer;
        MonthCode: Integer;
        YearCode: Integer;
        QRText: Text;
        RecRef: RecordRef;
        FldRef: FieldRef;
        QRGenerator: Codeunit "QR Generator";
        TempBlob: Codeunit "Temp Blob";
        JResultArray: JsonArray;
    begin
        // JFinalLoad.WriteTo(Body);
        //PayloadOutPut := DelChr(Body, '=', '1');
        //Message(Body);
        rLocation.GET(LocationCode);
        rLocation.TESTFIELD("E-InvGenerateURL");
        EinvoiceHttpContent.WriteFrom(PayloadOutPut);
        EinvoiceHttpContent.GetHeaders(EinvoiceHttpHeader);
        EinvoiceHttpHeader.Clear();
        EinvoiceHttpHeader.Add('accessToken', access_token);

        EinvoiceHttpHeader.Add('apiaccesskey', rLocation.apiaccesskey);
        EinvoiceHttpHeader.Add('Content-Type', 'application/json');

        EinvoiceHttpRequest.Content := EinvoiceHttpContent;

        EinvoiceHttpRequest.SetRequestUri(rLocation."E-InvGenerateURL");
        EinvoiceHttpRequest.Method := 'POST';
        if EinvoiceHttpClient.Send(EinvoiceHttpRequest, EinvoiceHttpResponse) then begin
            EinvoiceHttpResponse.Content.ReadAs(ResultMessage);
            JResultObject.ReadFrom(ResultMessage);
            if JResultObject.Get('status', JResultToken) then
                if JResultToken.AsValue().AsInteger() = 1 then begin
                    if JResultObject.Get('AckDt', JResultToken) then begin
                        AckDateText := JResultToken.AsValue().AsText();
                        Evaluate(YearCode, CopyStr(AckDateText, 1, 4));
                        Evaluate(MonthCode, CopyStr(AckDateText, 6, 2));
                        Evaluate(DayCode, CopyStr(AckDateText, 9, 2));
                        Evaluate(AckDate, Format(DMY2Date(DayCode, MonthCode, YearCode)) + ' ' + Copystr(AckDateText, 12, 8));
                    end;
                    if JResultObject.Get('Irn', JResultToken) then
                        IRNNo := JResultToken.AsValue().AsText();
                    if JResultObject.get('AckNo', JResultToken) then
                        AckNo := JResultToken.AsValue().AsText();
                    if JResultObject.Get('SignedQRCode', JResultToken) then
                        QRText := JResultToken.AsValue().AsText();
                end else begin
                    if JResultObject.Get('errorDetails', JOutputToken) then
                        if JOutputToken.IsArray then begin
                            JOutputToken.WriteTo(OutputMessage);
                            JResultArray.ReadFrom(OutputMessage);
                            if JResultArray.Get(0, JOutputToken) then begin
                                if JOutputToken.IsObject then begin
                                    JOutputToken.WriteTo(OutputMessage);
                                    JOutputObject.ReadFrom(OutputMessage);
                                end;
                            end;
                        end;
                    if JOutputObject.Get('errorDesc', JOutputToken) then
                        //Message(JOutputToken.AsValue().AsText());
                    Message(OutputMessage);
                end;
            IF IsInvoice THEN BEGIN
                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETRANGE("No.", DocumentNo);
                IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                    Clear(RecRef);
                    RecRef.Get(SalesInvoiceHeader.RecordId);
                    if QRGenerator.GenerateQRCodeImage(QRText, TempBlob) then begin
                        if TempBlob.HasValue() then begin
                            FldRef := RecRef.Field(SalesInvoiceHeader.FieldNo("QR Code"));
                            TempBlob.ToRecordRef(RecRef, SalesInvoiceHeader.FieldNo("QR Code"));
                            RecRef.Field(SalesInvoiceHeader.FieldNo("IRN Hash")).Value := IRNNo;
                            RecRef.Field(SalesInvoiceHeader.FieldNo("Acknowledgement No.")).Value := AckNo;
                            RecRef.Field(SalesInvoiceHeader.FieldNo("Acknowledgement Date")).Value := AckDate;
                            RecRef.Modify();
                            Message('E-Invoice Generated Successfully!!');
                        end;
                    end else
                        Message('E-Invoice Genreration Failed');
                END;
            END ELSE
                IF IsTransferInvoice THEN BEGIN
                    TransferShipmentHeader.RESET;
                    TransferShipmentHeader.SETRANGE("No.", DocumentNo);
                    IF TransferShipmentHeader.FINDFIRST THEN BEGIN
                        Clear(RecRef);
                        RecRef.Get(TransferShipmentHeader.RecordId);
                        if QRGenerator.GenerateQRCodeImage(QRText, TempBlob) then begin
                            if TempBlob.HasValue() then begin
                                FldRef := RecRef.Field(TransferShipmentHeader.FieldNo("QR Code"));
                                TempBlob.ToRecordRef(RecRef, TransferShipmentHeader.FieldNo("QR Code"));
                                RecRef.Field(TransferShipmentHeader.FieldNo("IRN Hash")).Value := IRNNo;
                                RecRef.Field(TransferShipmentHeader.FieldNo("Acknowledgement No.")).Value := AckNo;
                                RecRef.Field(TransferShipmentHeader.FieldNo("Acknowledgement Date")).Value := AckDate;
                                RecRef.Modify();
                                Message('E-Invoice Generated Successfully!!');
                            end;
                        end else
                            Message('E-Invoice Genreration Failed');
                    END;
                END ELSE BEGIN
                    SalesCrMemoHeader.RESET;
                    SalesCrMemoHeader.SETRANGE("No.", DocumentNo);
                    IF SalesCrMemoHeader.FINDFIRST THEN BEGIN
                        Clear(RecRef);
                        RecRef.Get(SalesCrMemoHeader.RecordId);
                        if QRGenerator.GenerateQRCodeImage(QRText, TempBlob) then begin
                            if TempBlob.HasValue() then begin
                                FldRef := RecRef.Field(SalesCrMemoHeader.FieldNo("QR Code"));
                                TempBlob.ToRecordRef(RecRef, SalesCrMemoHeader.FieldNo("QR Code"));
                                RecRef.Field(SalesCrMemoHeader.FieldNo("IRN Hash")).Value := IRNNo;
                                RecRef.Field(SalesCrMemoHeader.FieldNo("Acknowledgement No.")).Value := AckNo;
                                RecRef.Field(SalesCrMemoHeader.FieldNo("Acknowledgement Date")).Value := AckDate;
                                RecRef.Modify();
                                Message('E-Invoice Generated Successfully!!');
                            end;
                        end else
                            Message('E-Invoice Genreration Failed');
                    END;
                END;
        end else
            Message(APIError);
    end;

    local procedure GetGSTCompRate(DocNo: Code[20]; LineNo: Integer; var GstRt: Decimal; var CgstAmt: Decimal; var SgstAmt: Decimal; var IgstAmt: Decimal; var CesRt: Decimal; var CesAmt: Decimal; var CesNonAdvalAmt: Decimal; var StateCesRt: Decimal; var StateCesAmt: Decimal; var StateCesNonAdvalAmt: Decimal)
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    //GSTComponent: Record 16405;
    begin
        GstRt := 0;

        DetailedGSTLedgerEntry.SETRANGE("Document No.", DocNo);
        DetailedGSTLedgerEntry.SETRANGE("Document Line No.", LineNo);

        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
        IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
            GstRt += DetailedGSTLedgerEntry."GST %";
            CgstAmt := ABS(DetailedGSTLedgerEntry."GST Amount");
        END
        ELSE
            CgstAmt := 0;

        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
        IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
            GstRt += DetailedGSTLedgerEntry."GST %";
            SgstAmt := ABS(DetailedGSTLedgerEntry."GST Amount");
        END
        ELSE
            SgstAmt := 0;

        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
        IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
            GstRt := DetailedGSTLedgerEntry."GST %";
            IgstAmt := ABS(DetailedGSTLedgerEntry."GST Amount");
        END
        ELSE
            IgstAmt := 0;

        CesRt := 0;
        CesAmt := 0;
        CesNonAdvalAmt := 0;
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CESS');
        IF DetailedGSTLedgerEntry.FINDFIRST THEN
            IF DetailedGSTLedgerEntry."GST %" > 0 THEN BEGIN
                CesRt := DetailedGSTLedgerEntry."GST %";
                CesAmt := ABS(DetailedGSTLedgerEntry."GST Amount");
            END
            ELSE
                CesNonAdvalAmt := ABS(DetailedGSTLedgerEntry."GST Amount");

        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'INTERCESS');
        IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
            CesRt := DetailedGSTLedgerEntry."GST %";
            CesAmt := ABS(DetailedGSTLedgerEntry."GST Amount");
        END;

        StateCesRt := 0;
        StateCesNonAdvalAmt := 0;
        StateCesAmt := 0;
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code");
        IF DetailedGSTLedgerEntry.FINDSET THEN
            REPEAT
                IF NOT (DetailedGSTLedgerEntry."GST Component Code" IN ['CGST', 'SGST', 'IGST', 'CESS', 'INTERCESS'])
                THEN
                    //IF GSTComponent.GET(DetailedGSTLedgerEntry."GST Component Code") THEN BEGIN // 15800
                        IF DetailedGSTLedgerEntry."GST %" > 0 THEN BEGIN
                        StateCesRt := DetailedGSTLedgerEntry."GST %";
                        StateCesAmt := ABS(DetailedGSTLedgerEntry."GST Amount");
                    END
                    ELSE
                        StateCesNonAdvalAmt := ABS(DetailedGSTLedgerEntry."GST Amount");

            //END;
            //IF GSTComponent."Exclude from Reports" THEN Rohan
            UNTIL DetailedGSTLedgerEntry.NEXT = 0;
    end;

    local procedure GSTValueSalesHeader(SalesInvline: Record "Sales Invoice Line"; var GSTBaseAmount: Decimal; Var GSTAmount: Decimal; Var DiscountHedaer: Decimal; var GSTBAmt: Decimal)
    var
        DetailedGSTLedger: Record "Detailed GST Ledger Entry";
        SalesILine: Record "Sales Invoice Line";
    begin
        Clear(DiscountHedaer);
        Clear(GSTAmount);
        Clear(GSTBaseAmount);
        Clear(GSTBAmt);
        SalesILine.Reset();
        SalesILine.SetRange("Document No.", SalesInvline."Document No.");
        if SalesILine.FindSet() then
            repeat
                DiscountHedaer += SalesILine."Inv. Discount Amount";
                GSTBAmt += ((SalesILine.Quantity * SalesILine."Unit Price") - SalesILine."Line Discount Amount" - SalesILine."Inv. Discount Amount")
            until SalesILine.Next() = 0;
        DetailedGSTLedger.Reset();
        DetailedGSTLedger.SetRange("Document No.", SalesInvline."Document No.");
        if DetailedGSTLedger.FindSet() then
            repeat
                if DetailedGSTLedger."GST Component Code" = 'CGST' then
                    GSTBaseAmount += abs(DetailedGSTLedger."GST Base Amount")
                else
                    if DetailedGSTLedger."GST Component Code" = 'IGST' then
                        GSTBaseAmount += abs(DetailedGSTLedger."GST Base Amount");
                GSTAmount += abs(DetailedGSTLedger."GST Amount");
            until DetailedGSTLedger.Next() = 0;
    end;

    local procedure GetTCSAmt(SalesInvLine: Record "Sales Invoice Line"; var TCSAmount: Decimal)
    var
        TCSEnty: Record "TCS Entry";
    begin
        Clear(TCSAmount);
        TCSEnty.Reset();
        TCSEnty.SetRange("Document No.", SalesInvLine."Document No.");
        if TCSEnty.FindSet() then
            repeat
                TCSAmount += TCSEnty."Total TCS Including SHE CESS";
            until TCSEnty.Next() = 0;
    end;

    local procedure GetGSTValueTransferHedaer(TransferShipmentLine: Record "Transfer Shipment Line"; Var GSTAmt: Decimal)
    var
        DetailedGStLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        Clear(GSTAmt);
        DetailedGStLedgerEntry.Reset();
        DetailedGStLedgerEntry.SetRange("Document No.", TransferShipmentLine."Document No.");
        if DetailedGStLedgerEntry.FindSet() then
            repeat
                GSTAmt += abs(DetailedGStLedgerEntry."GST Amount");
            until DetailedGStLedgerEntry.Next() = 0;
    end;

    local procedure GSTValueSalesCrHeader(SalesCrMemoLine: Record "Sales Cr.Memo Line"; var GSTBaseAmount: Decimal; Var GSTAmount: Decimal; var GSTBAmt: Decimal)
    var
        DetailedGSTLedger: Record "Detailed GST Ledger Entry";
        SalesILine: Record "Sales Cr.Memo Line";
    begin
        Clear(GSTAmount);
        Clear(GSTBaseAmount);
        Clear(GSTBAmt);
        SalesILine.Reset();
        SalesILine.SetRange("Document No.", SalesCrMemoLine."Document No.");
        if SalesILine.FindSet() then
            repeat

                GSTBAmt += ((SalesILine.Quantity * SalesILine."Unit Price") - SalesILine."Line Discount Amount" - SalesILine."Inv. Discount Amount")
            until SalesILine.Next() = 0;
        DetailedGSTLedger.Reset();
        DetailedGSTLedger.SetRange("Document No.", SalesCrMemoLine."Document No.");
        if DetailedGSTLedger.FindSet() then
            repeat
                if DetailedGSTLedger."GST Component Code" = 'CGST' then
                    GSTBaseAmount += abs(DetailedGSTLedger."GST Base Amount")
                else
                    if DetailedGSTLedger."GST Component Code" = 'IGST' then
                        GSTBaseAmount += abs(DetailedGSTLedger."GST Base Amount");
                GSTAmount += abs(DetailedGSTLedger."GST Amount");
            until DetailedGSTLedger.Next() = 0;
    end;

    local procedure GetTCSSaleCRAmt(SalesCrMemoLine: Record "Sales Cr.Memo Line"; var TCSAmount: Decimal)
    var
        TCSEnty: Record "TCS Entry";
    begin
        Clear(TCSAmount);
        TCSEnty.Reset();
        TCSEnty.SetRange("Document No.", SalesCrMemoLine."Document No.");
        if TCSEnty.FindSet() then
            repeat
                TCSAmount += TCSEnty."Total TCS Including SHE CESS";
            until TCSEnty.Next() = 0;
    end;

    local procedure GetGSTAmtSalesLine(SalesInvline: Record "Sales Invoice Line"; var LGSTBaseAmt: Decimal; var LGSTAmt: Decimal; var DiscountAmt: Decimal)
    var
        DetailedGSTLedger: Record "Detailed GST Ledger Entry";
        SalesILine: Record "Sales Invoice Line";
    begin
        Clear(LGSTBaseAmt);
        Clear(DiscountAmt);
        Clear(LGSTAmt);
        SalesILine.Reset();
        SalesILine.SetRange("Document No.", SalesInvline."Document No.");
        SalesILine.SetRange("Line No.", SalesInvline."Line No.");
        if SalesILine.FindFirst() then
            DiscountAmt := SalesILine."Inv. Discount Amount";
        DetailedGSTLedger.Reset();
        DetailedGSTLedger.SetRange("Document No.", SalesInvline."Document No.");
        DetailedGSTLedger.SetRange("Document Line No.", SalesInvline."Line No.");
        if DetailedGSTLedger.FindSet() then
            repeat
                if DetailedGSTLedger."GST Component Code" = 'CGST' then
                    LGSTBaseAmt += abs(DetailedGSTLedger."GST Base Amount")
                else
                    if DetailedGSTLedger."GST Component Code" = 'IGST' then
                        LGSTBaseAmt += abs(DetailedGSTLedger."GST Base Amount");
                LGSTAmt += abs(DetailedGSTLedger."GST Amount");
            until DetailedGSTLedger.Next() = 0;
    end;

    local procedure GetGSTAmtTransferLine(SalesInvline: Record "Transfer Shipment Line"; var LGSTBaseAmt: Decimal; var LGSTAmt: Decimal)
    var
        DetailedGSTLedger: Record "Detailed GST Ledger Entry";
    begin
        Clear(LGSTBaseAmt);
        Clear(LGSTAmt);
        DetailedGSTLedger.Reset();
        DetailedGSTLedger.SetRange("Document No.", SalesInvline."Document No.");
        DetailedGSTLedger.SetRange("Document Line No.", SalesInvline."Line No.");
        if DetailedGSTLedger.FindSet() then
            repeat
                if DetailedGSTLedger."GST Component Code" = 'CGST' then
                    LGSTBaseAmt += abs(DetailedGSTLedger."GST Base Amount")
                else
                    if DetailedGSTLedger."GST Component Code" = 'IGST' then
                        LGSTBaseAmt += abs(DetailedGSTLedger."GST Base Amount");
                LGSTAmt += abs(DetailedGSTLedger."GST Amount");
            until DetailedGSTLedger.Next() = 0;
    end;

    local procedure GetGSTAmtSalesCrLine(SalesInvline: Record "Sales Cr.Memo Line"; var LGSTBaseAmt: Decimal; var LGSTAmt: Decimal; var DiscountAmt: Decimal)
    var
        DetailedGSTLedger: Record "Detailed GST Ledger Entry";
        SalesILine: Record "Sales Cr.Memo Line";
    begin
        Clear(LGSTBaseAmt);
        Clear(LGSTAmt);
        Clear(DiscountAmt);
        SalesILine.Reset();
        SalesILine.SetRange("Document No.", SalesInvline."Document No.");
        SalesILine.SetRange("Line No.", SalesInvline."Line No.");
        if SalesILine.FindFirst() then
            DiscountAmt := SalesILine."Inv. Discount Amount";
        DetailedGSTLedger.Reset();
        DetailedGSTLedger.SetRange("Document No.", SalesInvline."Document No.");
        DetailedGSTLedger.SetRange("Document Line No.", SalesInvline."Line No.");
        if DetailedGSTLedger.FindSet() then
            repeat
                if DetailedGSTLedger."GST Component Code" = 'CGST' then
                    LGSTBaseAmt += abs(DetailedGSTLedger."GST Base Amount")
                else
                    if DetailedGSTLedger."GST Component Code" = 'IGST' then
                        LGSTBaseAmt += abs(DetailedGSTLedger."GST Base Amount");
                LGSTAmt += abs(DetailedGSTLedger."GST Amount");
            until DetailedGSTLedger.Next() = 0;
    end;

    local procedure GetGSTValLine(DocumentNo: Code[20]; DocumentLineNo: Integer; var AssVal: Decimal; var CgstVal: Decimal; var SgstVal: Decimal; var IgstVal: Decimal; var CesVal: Decimal; var StCesVal: Decimal; var CesNonAdval: Decimal; var Disc: Decimal; var OthChrg: Decimal; var TotInvVal: Decimal)
    var
        SalesInvoiceLine: Record 113;
        SalesCrMemoLine: Record 115;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CurrExchRate: Record 330;
        CustLedgerEntry: Record 21;
        // GSTComponent: Record 16405;
        TotGSTAmt: Decimal;
    begin
        DetailedGSTLedgerEntry.SETRANGE("Document No.", DocumentNo);
        DetailedGSTLedgerEntry.SETRANGE("Document Line No.", DocumentLineNo);
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CGST');
        IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                CgstVal += ABS(DetailedGSTLedgerEntry."GST Amount");
            UNTIL DetailedGSTLedgerEntry.NEXT = 0;
        END ELSE
            CgstVal := 0;

        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'SGST');
        IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                SgstVal += ABS(DetailedGSTLedgerEntry."GST Amount")
            UNTIL DetailedGSTLedgerEntry.NEXT = 0;
        END ELSE
            SgstVal := 0;

        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'IGST');
        IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                IgstVal += ABS(DetailedGSTLedgerEntry."GST Amount")
            UNTIL DetailedGSTLedgerEntry.NEXT = 0;
        END ELSE
            IgstVal := 0;

        CesVal := 0;
        CesNonAdval := 0;

        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'INTERCESS');
        IF DetailedGSTLedgerEntry.FINDSET THEN
            REPEAT
                CesVal += ABS(DetailedGSTLedgerEntry."GST Amount")
            UNTIL DetailedGSTLedgerEntry.NEXT = 0;

        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", 'CESS');
        IF DetailedGSTLedgerEntry.FINDFIRST THEN
            REPEAT
                IF DetailedGSTLedgerEntry."GST %" > 0 THEN
                    CesVal += ABS(DetailedGSTLedgerEntry."GST Amount")
                ELSE
                    CesNonAdval += ABS(DetailedGSTLedgerEntry."GST Amount");
            UNTIL DetailedGSTLedgerEntry.NEXT = 0;

        /* DetailedGSTLedgerEntry.SETFILTER("GST Component Code", '<>CGST|<>SGST|<>IGST|<>CESS|<>INTERCESS');
        IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                IF GSTComponent.GET(DetailedGSTLedgerEntry."GST Component Code") THEN
                    IF GSTComponent."Exclude from Reports" THEN
                        StCesVal += ABS(DetailedGSTLedgerEntry."GST Amount"); //
            UNTIL DetailedGSTLedgerEntry.NEXT = 0;
        END; */ // 15800 StateCessAmount Field is Asking
        StCesVal := 0;
        IF IsInvoice THEN BEGIN
            SalesInvoiceLine.SETRANGE("Document No.", DocumentNo);
            SalesInvoiceLine.SETFILTER(Quantity, '<>%1', 0);
            SalesInvoiceLine.SETFILTER("System-Created Entry", '%1', FALSE);
            SalesInvoiceLine.SETRANGE("Line No.", DocumentLineNo);
            IF SalesInvoiceLine.FINDSET THEN BEGIN
                REPEAT
                    AssVal += SalesInvoiceLine.Amount;
                    TotGSTAmt := GetGSTValAmtLine(DocumentNo, DocumentLineNo);
                    Disc := SalesInvoiceLine."Inv. Discount Amount" + SalesInvoiceLine."Line Discount Amount";

                    /* IF SalesInvoiceLine."Charges To Customer" <> 0 THEN BEGIN
                        IF IsExport THEN
                            OthChrg += 0
                        ELSE BEGIN
                            IF (SalesInvoiceLine."GST Base Amount" = (SalesInvoiceLine.Amount + SalesInvoiceLine."Charges To Customer" + (SalesInvoiceLine."GST Base Amount" - SalesInvoiceLine.Amount - SalesInvoiceLine."Charges To Customer"))) THEN
                                OthChrg += (-SalesInvoiceLine."GST Base Amount" + SalesInvoiceLine.Amount + SalesInvoiceLine."Charges To Customer")
                            ELSE
                                IF SalesInvoiceLine."GST Base Amount" <> SalesInvoiceLine.Amount + SalesInvoiceLine."Charges To Customer" THEN
                                    OthChrg += SalesInvoiceLine."Charges To Customer"
                                ELSE
                                    OthChrg += 0;
                        END;
                    END; */ // 15800 Charge to Customer
                    OthChrg := 0;
                UNTIL SalesInvoiceLine.NEXT = 0;
            END;

            AssVal := ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  WORKDATE, SalesInvoiceHeader."Currency Code", AssVal, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
            TotGSTAmt := ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  WORKDATE, SalesInvoiceHeader."Currency Code", TotGSTAmt, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
            Disc := ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  WORKDATE, SalesInvoiceHeader."Currency Code", Disc, SalesInvoiceHeader."Currency Factor"), 0.01, '=');
        END ELSE BEGIN
            SalesCrMemoLine.SETRANGE("Document No.", DocumentNo);
            SalesCrMemoLine.SETRANGE("Line No.", DocumentLineNo);
            IF SalesCrMemoLine.FINDSET THEN BEGIN
                REPEAT
                    AssVal += SalesCrMemoLine.Amount;
                    TotGSTAmt := GetGSTValAmtLine(DocumentNo, DocumentLineNo);
                    Disc := SalesCrMemoLine."Inv. Discount Amount" + SalesCrMemoLine."Line Discount Amount";
                UNTIL SalesCrMemoLine.NEXT = 0;
            END;

            AssVal := ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  WORKDATE, SalesCrMemoHeader."Currency Code", AssVal, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
            TotGSTAmt := ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  WORKDATE, SalesCrMemoHeader."Currency Code", TotGSTAmt, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
            Disc := ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  WORKDATE, SalesCrMemoHeader."Currency Code", Disc, SalesCrMemoHeader."Currency Factor"), 0.01, '=');
        END;

        CustLedgerEntry.SETCURRENTKEY("Document No.");
        CustLedgerEntry.SETRANGE("Document No.", DocumentNo);
        IF IsInvoice THEN BEGIN
            CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
            CustLedgerEntry.SETRANGE("Customer No.", SalesInvoiceHeader."Bill-to Customer No.");
        END ELSE BEGIN
            CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::"Credit Memo");
            CustLedgerEntry.SETRANGE("Customer No.", SalesCrMemoHeader."Bill-to Customer No.");
        END;
        IF CustLedgerEntry.FINDFIRST THEN BEGIN
            CustLedgerEntry.CALCFIELDS("Amount (LCY)");
            TotInvVal := ABS(CustLedgerEntry."Amount (LCY)");
        END;

        ///OthChrg := 0;
    end;

    local procedure GetGSTValAmtLine(DocumentNo: Code[20]; DocumentLineNo: Integer): Decimal
    var
        DetailedGSTLedger: Record "Detailed GST Ledger Entry";
        SLGstamt: Decimal;
    begin
        Clear(SLGstamt);
        DetailedGSTLedger.Reset();
        DetailedGSTLedger.SetRange("Document No.", DocumentNo);
        DetailedGSTLedger.SetRange("Document Line No.", DocumentLineNo);
        if DetailedGSTLedger.FindSet() then
            repeat
                SLGstamt += DetailedGSTLedger."GST Amount";
            until DetailedGSTLedger.Next() = 0;
        exit(SLGstamt);
    end;

    procedure SetTransferShipHeader(TransShipmentHeaderBuff: Record 5744)
    begin
        TransferShipmentHeader := TransShipmentHeaderBuff;
        IsTransferInvoice := TRUE;
        IsEWB := FALSE;
        LocationCode := TransShipmentHeaderBuff."Transfer-from Code";
    end;

    procedure SetSalesInvHeader(SalesInvoiceHeaderBuff: Record 112)
    begin
        SalesInvoiceHeader := SalesInvoiceHeaderBuff;
        IsInvoice := TRUE;
        IsEWB := FALSE;
        LocationCode := SalesInvoiceHeaderBuff."Location Code";
    end;

    procedure SetCrMemoHeader(SalesCrMemoHeaderBuff: Record 114)
    begin
        SalesCrMemoHeader := SalesCrMemoHeaderBuff;
        IsInvoice := FALSE;
        LocationCode := SalesCrMemoHeaderBuff."Location Code";
    end;

    local procedure RoundGSTInvoicePrecision(SalesInvLine: Record "Sales Invoice Line"; GSTAmount: decimal): Decimal
    var
        DGL: Record "Detailed GST Ledger Entry";
        GSTRoundingPrecision: Decimal;
        GSTRoundingDirection: text;
    begin
        DGL.Reset();
        DGL.SetRange("Document No.", SalesInvLine."No.");
        if DGL.findset() then begin
            repeat
                if GSTAmount = 0 then
                    exit(0);
                IF DGL."GST Inv. Rounding Precision" = 0 THEN
                    EXIT;
                CASE DGL."GST Inv. Rounding Type" OF
                    DGL."GST Inv. Rounding Type"::Nearest:
                        GSTRoundingDirection := '=';
                    DGL."GST Inv. Rounding Type"::Up:
                        GSTRoundingDirection := '>';
                    DGL."GST Inv. Rounding Type"::Down:
                        GSTRoundingDirection := '<';
                END;
                GSTRoundingPrecision := DGL."GST Inv. Rounding Precision";
            until DGL.Next() = 0;
            EXIT(ROUND(GSTAmount, GSTRoundingPrecision, GSTRoundingDirection));
        end;
    end;

    procedure GenerateSalesCreditJSONSchema(var SalesCrMemoHeader: Record 114)
    begin
        CurrExRate := 1;
        IF (GetGSTNNo(SalesCrMemoHeader."Location Code") <> '') THEN
            GSTNNo := GetGSTNNo(SalesCrMemoHeader."Location Code"); //MSKS
        DocumentNo := SalesCrMemoHeader."No.";
        Authenticate1();

        WriteFileHeader;
        ReadTransDtls(SalesCrMemoHeader."GST Customer Type", SalesCrMemoHeader."Ship-to Code");
        ReadDocDtls;

        ReadSellerDtls;
        ReadBuyerDtls;
        ReadShipDtls;
        ReadValDtls;
        ReadItemList();
        JFinalArray.Add(JHeaderObject);
        JHeaderObject.Add('lineItems', JLineArray);
        JFinalLoad.Add('req', JFinalArray);
        JFinalLoad.WriteTo(MessageText);
        PayloadOutPut := DelChr(MessageText, '=', '#');
        Message(PayloadOutPut);

        GetIRNNo();
    end;

    procedure GenerateTransferInvoiceJSONSchema(var TransferShipmentHeader: Record 5744)
    begin
        CurrExRate := 1;
        IF (GetGSTNNo(TransferShipmentHeader."Transfer-from Code") <> '') THEN
            GSTNNo := GetGSTNNo(TransferShipmentHeader."Transfer-from Code"); //MSKS
        DocumentNo := TransferShipmentHeader."No.";
        Authenticate1();

        WriteFileHeader;
        ReadTransDtls(0, '');
        ReadDocDtls;

        ReadSellerDtls;
        ReadBuyerDtls;
        ReadShipDtls;
        WriteEWBDtls('', '', '', '', '', '', 0, '', '');//Keshav0402021
        ReadValDtls;
        ReadItemList();
        JFinalArray.Add(JHeaderObject);
        JHeaderObject.Add('lineItems', JLineArray);
        JFinalLoad.Add('req', JFinalArray);
        JFinalLoad.WriteTo(MessageText);
        PayloadOutPut := DelChr(MessageText, '=', '#');
        Message(PayloadOutPut);

        GetIRNNo();
    end;

    procedure CancelSalesIRNNo(var SalesInvoiceHeader: Record 112)
    var
        rLocation: Record 14;
        EinvoiceHttpClient: HttpClient;
        EinvoiceHttpRequest: HttpRequestMessage;
        EinvoiceHttpContent: HttpContent;
        EinvoiceHttpHeader: HttpHeaders;
        EinvoiceHttpResponse: HttpResponseMessage;
        JResultToken: JsonToken;
        JResultObject: JsonObject;
        ResultMessage: Text;
        Ackdate: DateTime;
        AckDateText: Text;
        DayCode: Integer;
        MonthCode: Integer;
        YearCode: Integer;
    begin
        IF SalesInvoiceHeader."IRN Hash" = '' THEN
            EXIT;
        Authenticate1;
        LocationCode := SalesInvoiceHeader."Location Code";
        GenerateCancelRequest(SalesInvoiceHeader."IRN Hash");
        JHeaderObject.WriteTo(CancelBody);
        //  Message(CancelBody);
        rLocation.GET(SalesInvoiceHeader."Location Code");
        rLocation.TESTFIELD("E-InvCancelURL");
        EinvoiceHttpContent.WriteFrom(CancelBody);
        EinvoiceHttpContent.GetHeaders(EinvoiceHttpHeader);
        EinvoiceHttpHeader.Clear();
        EinvoiceHttpHeader.Add('accessToken', access_token);
        EinvoiceHttpHeader.Add('apiaccesskey', rLocation.apiaccesskey);
        EinvoiceHttpHeader.Add('Content-Type', 'application/json');
        EinvoiceHttpRequest.Content := EinvoiceHttpContent;
        EinvoiceHttpRequest.SetRequestUri(rLocation."E-InvCancelURL");
        EinvoiceHttpRequest.Method := 'POST';
        if EinvoiceHttpClient.Send(EinvoiceHttpRequest, EinvoiceHttpResponse) then begin
            EinvoiceHttpResponse.Content.ReadAs(ResultMessage);
            JResultObject.ReadFrom(ResultMessage);
            if JResultObject.Get('status', JResultToken) then
                if JResultToken.AsValue().AsInteger() = 1 then begin
                    if JResultObject.Get('cancelDate', JResultToken) then begin
                        AckDateText := JResultToken.AsValue().AsText();
                        Evaluate(YearCode, CopyStr(AckDateText, 1, 4));
                        Evaluate(MonthCode, CopyStr(AckDateText, 6, 2));
                        Evaluate(DayCode, CopyStr(AckDateText, 9, 2));
                        Evaluate(AckDate, Format(DMY2Date(DayCode, MonthCode, YearCode)) + ' ' + Copystr(AckDateText, 12, 8));
                    end;
                    SalesInvoiceHeader."IRN Hash" := '';
                    SalesInvoiceHeader."Acknowledgement No." := '';
                    SalesInvoiceHeader."Acknowledgement Date" := AckDate;
                    SalesInvoiceHeader.Modify();
                    Message('IRN Cancelled');
                end else
                    Message(ResultMessage);
        end else
            Message(APIError);
    end;

    procedure CancelSalesCreditIRNNo(var SalesCrMemoHeader: Record 114)
    var
        rLocation: Record 14;
        EinvoiceHttpClient: HttpClient;
        EinvoiceHttpRequest: HttpRequestMessage;
        EinvoiceHttpContent: HttpContent;
        EinvoiceHttpHeader: HttpHeaders;
        EinvoiceHttpResponse: HttpResponseMessage;
        JResultToken: JsonToken;
        JResultObject: JsonObject;
        ResultMessage: Text;
        Ackdate: DateTime;
        AckDateText: Text;
        DayCode: Integer;
        MonthCode: Integer;
        YearCode: Integer;
    begin
        IF SalesCrMemoHeader."IRN Hash" = '' THEN
            EXIT;
        Authenticate1;
        LocationCode := SalesCrMemoHeader."Location Code";
        GenerateCancelRequest(SalesCrMemoHeader."IRN Hash");
        JHeaderObject.WriteTo(CancelBody);
        //Message(CancelBody);
        rLocation.GET(SalesCrMemoHeader."Location Code");
        rLocation.TESTFIELD("E-InvCancelURL");
        EinvoiceHttpContent.WriteFrom(CancelBody);
        EinvoiceHttpContent.GetHeaders(EinvoiceHttpHeader);
        EinvoiceHttpHeader.Clear();
        EinvoiceHttpHeader.Add('accessToken', access_token);
        EinvoiceHttpHeader.Add('apiaccesskey', rLocation.apiaccesskey);
        EinvoiceHttpHeader.Add('Content-Type', 'application/json');
        EinvoiceHttpRequest.Content := EinvoiceHttpContent;
        EinvoiceHttpRequest.SetRequestUri(rLocation."E-InvCancelURL");
        EinvoiceHttpRequest.Method := 'POST';
        if EinvoiceHttpClient.Send(EinvoiceHttpRequest, EinvoiceHttpResponse) then begin
            EinvoiceHttpResponse.Content.ReadAs(ResultMessage);
            JResultObject.ReadFrom(ResultMessage);
            if JResultObject.Get('status', JResultToken) then
                if JResultToken.AsValue().AsInteger() = 1 then begin
                    if JResultObject.Get('cancelDate', JResultToken) then begin
                        AckDateText := JResultToken.AsValue().AsText();
                        Evaluate(YearCode, CopyStr(AckDateText, 1, 4));
                        Evaluate(MonthCode, CopyStr(AckDateText, 6, 2));
                        Evaluate(DayCode, CopyStr(AckDateText, 9, 2));
                        Evaluate(AckDate, Format(DMY2Date(DayCode, MonthCode, YearCode)) + ' ' + Copystr(AckDateText, 12, 8));
                    end;
                    SalesCrMemoHeader."IRN Hash" := '';
                    SalesCrMemoHeader."Acknowledgement No." := '';
                    SalesCrMemoHeader."Acknowledgement Date" := AckDate;
                    SalesCrMemoHeader.Modify();
                    Message('IRN Cancelled');
                end else
                    Message(ResultMessage);
        end else
            Message(APIError);
    end;

    procedure CancelTrfShipIRNNo(var TransferShipmentHeader: Record "Transfer Shipment Header")
    var
        rLocation: Record 14;
        EinvoiceHttpClient: HttpClient;
        EinvoiceHttpRequest: HttpRequestMessage;
        EinvoiceHttpContent: HttpContent;
        EinvoiceHttpHeader: HttpHeaders;
        EinvoiceHttpResponse: HttpResponseMessage;
        JResultToken: JsonToken;
        JResultObject: JsonObject;
        ResultMessage: Text;
        AckDateText: Text;
        DayCode: Integer;
        DateText: Text;
        MonthCode: Integer;
        YearCode: Integer;
    begin
        IF TransferShipmentHeader."IRN Hash" = '' THEN
            EXIT;
        Authenticate1;
        LocationCode := TransferShipmentHeader."Transfer-from Code";
        GenerateCancelRequest(TransferShipmentHeader."IRN Hash");
        JHeaderObject.WriteTo(CancelBody);
        // Message(CancelBody);
        rLocation.GET(TransferShipmentHeader."Transfer-from Code");
        rLocation.TESTFIELD("E-InvCancelURL");
        EinvoiceHttpContent.WriteFrom(CancelBody);
        EinvoiceHttpContent.GetHeaders(EinvoiceHttpHeader);
        EinvoiceHttpHeader.Clear();
        EinvoiceHttpHeader.Add('accessToken', access_token);
        EinvoiceHttpHeader.Add('apiaccesskey', rLocation.apiaccesskey);
        EinvoiceHttpHeader.Add('Content-Type', 'application/json');
        EinvoiceHttpRequest.Content := EinvoiceHttpContent;
        EinvoiceHttpRequest.SetRequestUri(rLocation."E-InvCancelURL");
        EinvoiceHttpRequest.Method := 'POST';
        if EinvoiceHttpClient.Send(EinvoiceHttpRequest, EinvoiceHttpResponse) then begin
            EinvoiceHttpResponse.Content.ReadAs(ResultMessage);
            JResultObject.ReadFrom(ResultMessage);
            if JResultObject.Get('status', JResultToken) then
                if JResultToken.AsValue().AsInteger() = 1 then begin
                    if JResultObject.Get('cancelDate', JResultToken) then begin
                        AckDateText := JResultToken.AsValue().AsText();
                        Evaluate(YearCode, CopyStr(AckDateText, 1, 4));
                        Evaluate(MonthCode, CopyStr(AckDateText, 6, 2));
                        Evaluate(DayCode, CopyStr(AckDateText, 9, 2));
                        DateText := Format(DMY2Date(DayCode, MonthCode, YearCode)) + ' ' + Copystr(AckDateText, 12, 8);
                    end;
                    TransferShipmentHeader."IRN Hash" := '';
                    TransferShipmentHeader."Acknowledgement No." := '';
                    TransferShipmentHeader."Acknowledgement Date" := DateText;
                    TransferShipmentHeader.Modify();
                    Message('IRN Cancelled');
                end else
                    Message(ResultMessage);
        end else
            Message(APIError);
    end;

    local procedure GenerateCancelRequest(IRNNo: Text)
    begin
        ReadCredentials(1);
        JHeaderObject.Add('Irn', IRNNo);
        JHeaderObject.Add('canReason', '1');
        JHeaderObject.Add('canRemarks', 'Wrong Entry')
    end;

    local procedure ReadEWBDtls()
    var
        transporterID: Text;
        transporterName: Text;
        transportMode: Code[10];
        transportDocNo: Text;
        transportDocDate: Text;
        distance: Integer;
        vehicleNo: Code[20];
        vehicleType: Text;
        Vendor: Record 23;
        TransportMethod: Record 259;
        Location: Record 14;
        IRN: Text;
    begin
        IF IsInvoice THEN BEGIN
            WITH SalesInvoiceHeader DO BEGIN
                SalesInvoiceHeader.TESTFIELD("Truck No.");
                SalesInvoiceHeader.TESTFIELD("Transport Method");
                IF TransportMethod.GET(SalesInvoiceHeader."Transport Method") THEN;
                IF Location.GET(SalesInvoiceHeader."Location Code") THEN;
                TransportMethod.TESTFIELD("E-Way transport method");

                IRN := SalesInvoiceHeader."IRN Hash";

                IF Vendor.GET(SalesInvoiceHeader."Transporter's Name") THEN;
                IF Vendor.Transporter1 THEN
                    transporterID := Vendor."GST No."
                ELSE
                    transporterID := Vendor."GST Registration No.";

                transporterName := SalesInvoiceHeader."Transporter Name";
                transportMode := TransportMethod."E-Way transport method";
                transportDocNo := SalesInvoiceHeader."GR No.";
                transportDocDate := FORMAT(SalesInvoiceHeader."GR Date", 0, '<Closing><Day,2>/<Month,2>/<Year4>');
                IF SalesInvoiceHeader."Ship to Pin" = Location."Pin Code" THEN
                    distance := 90
                ELSE
                    distance := SalesInvoiceHeader."Distance (Km)";

                vehicleNo := DELCHR(SalesInvoiceHeader."Truck No.", '=', ' ,/-<>  !@#$%^&*()_+{}');
                vehicleType := 'R';
            END;
        END ELSE
            IF IsTransferInvoice THEN BEGIN
                WITH TransferShipmentHeader DO BEGIN
                    TransferShipmentHeader.TESTFIELD("Truck No.");
                    TransferShipmentHeader.TESTFIELD("Transport Method");
                    IF TransportMethod.GET(TransferShipmentHeader."Transport Method") THEN;
                    IF Location.GET(TransferShipmentHeader."Transfer-from Code") THEN;
                    TransportMethod.TESTFIELD("E-Way transport method");

                    IRN := TransferShipmentHeader."IRN Hash";

                    IF Vendor.GET(TransferShipmentHeader."Transporter's Name") THEN;
                    transporterName := Vendor.Name;
                    IF Vendor.Transporter1 THEN
                        transporterID := Vendor."GST No."
                    ELSE
                        transporterID := Vendor."GST Registration No.";

                    transportMode := TransportMethod."E-Way transport method";
                    transportDocNo := TransferShipmentHeader."GR No.";
                    transportDocDate := FORMAT(TransferShipmentHeader."GR Date", 0, '<Closing><Day,2>/<Month,2>/<Year4>');

                    distance := TransferShipmentHeader."Distance (Km)";

                    vehicleNo := DELCHR(TransferShipmentHeader."Truck No.", '=', ' ,/-<>  !@#$%^&*()_+{}');
                    vehicleType := 'R';
                END;
            END ELSE BEGIN
            END;

        WriteEWBDtls(IRN, transporterID, transporterName, transportMode, transportDocNo, transportDocDate, distance, vehicleNo, vehicleType);
    end;

    procedure GenerateSalesInvJSONSchemaEWB(SalesInvoiceHeader: Record 112)
    begin
        IsEWB := TRUE;

        IF (GetGSTNNo(SalesInvoiceHeader."Location Code") <> '') THEN
            GSTNNo := GetGSTNNo(SalesInvoiceHeader."Location Code"); //MSKS

        DocumentNo := SalesInvoiceHeader."No.";
        LocationCode := SalesInvoiceHeader."Location Code";
        Authenticate1();

        //ReadCredentials(1);

        WriteFileHeader;
        ReadTransDtls(SalesInvoiceHeader."GST Customer Type", SalesInvoiceHeader."Ship-to Code");
        ReadDocDtls;
        ReadExpDtls;
        ReadSellerDtls;
        ReadBuyerDtls;
        ReadShipDtls;
        ReadEWBDtls;//Keshav04022021
        ReadValDtls;
        ReadItemList();
        JFinalArray.Add(JHeaderObject);
        JHeaderObject.Add('lineItems', JLineArray);
        JFinalLoad.Add('req', JFinalArray);
        JFinalLoad.WriteTo(MessageText);
        PayloadOutPut := DelChr(MessageText, '=', '#');
        Message(PayloadOutPut);

        GetEWBNo();
    end;

    procedure GetEWBNo()
    var
        SalesInvoiceHeader: Record 112;
        OutputMessage: Text;
        JResultArray: JsonArray;
        rLocation: Record 14;
        EinvoiceHttpClient: HttpClient;
        EinvoiceHttpRequest: HttpRequestMessage;
        EinvoiceHttpContent: HttpContent;
        EinvoiceHttpHeader: HttpHeaders;
        EinvoiceHttpResponse: HttpResponseMessage;
        JResultToken: JsonToken;
        JResultObject: JsonObject;
        ResultMessage: Text;
        Ackdate: DateTime;
        AckDateText: Text;
        DayCode: Integer;
        MonthCode: Integer;
        YearCode: Integer;
        EWBNo: Text;
        JOutputToken: JsonToken;
        EWBValidity: Text;
        JOutputObject: JsonObject;
    begin
        // JFinalLoad.WriteTo(Body);
        //Message(Body);
        rLocation.GET(LocationCode);
        rLocation.TESTFIELD("E-InvGenerateURL");
        EinvoiceHttpContent.WriteFrom(PayloadOutPut);
        EinvoiceHttpContent.GetHeaders(EinvoiceHttpHeader);
        EinvoiceHttpHeader.Clear();
        EinvoiceHttpHeader.Add('accessToken', access_token);
        EinvoiceHttpHeader.Add('apiaccesskey', rLocation.apiaccesskey);
        EinvoiceHttpHeader.Add('Content-Type', 'application/json');
        EinvoiceHttpRequest.Content := EinvoiceHttpContent;
        EinvoiceHttpRequest.SetRequestUri(rLocation."E-InvGenerateURL");
        EinvoiceHttpRequest.Method := 'POST';
        if EinvoiceHttpClient.Send(EinvoiceHttpRequest, EinvoiceHttpResponse) then begin
            EinvoiceHttpResponse.Content.ReadAs(ResultMessage);
            JResultObject.ReadFrom(ResultMessage);
            // Message(ResultMessage);
            if JResultObject.Get('status', JResultToken) then
                if JResultToken.AsValue().AsInteger() = 1 then begin
                    if JResultObject.Get('EwbNo', JResultToken) then
                        if JResultToken.AsValue().AsText() <> '' then begin
                            EWBNo := JResultToken.AsValue().AsText();
                            if JResultObject.Get('EwbDt', JResultToken) then begin
                                AckDateText := JResultToken.AsValue().AsText();
                                Evaluate(YearCode, CopyStr(AckDateText, 1, 4));
                                Evaluate(MonthCode, CopyStr(AckDateText, 6, 2));
                                Evaluate(DayCode, CopyStr(AckDateText, 9, 2));
                                Evaluate(AckDate, Format(DMY2Date(DayCode, MonthCode, YearCode)) + ' ' + Copystr(AckDateText, 12, 8));
                            end;
                            if JResultObject.Get('EwbValidTill', JResultToken) then
                                EWBValidity := JResultToken.AsValue().AsText();
                        end;
                end else begin
                    if JResultObject.Get('errorDetails', JOutputToken) then
                        if JOutputToken.IsArray then begin
                            JOutputToken.WriteTo(OutputMessage);
                            JResultArray.ReadFrom(OutputMessage);
                            if JResultArray.Get(0, JOutputToken) then begin
                                if JOutputToken.IsObject then begin
                                    JOutputToken.WriteTo(OutputMessage);
                                    JOutputObject.ReadFrom(OutputMessage);

                                end;
                            end;
                        end;
                    if JOutputObject.Get('errorDesc', JOutputToken) then
                        // Message(JOutputToken.AsValue().AsText());
                     Message(OutputMessage);
                end;

            // Message(ResultMessage);
            IF IsInvoice THEN BEGIN
                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETRANGE("No.", DocumentNo);
                IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                    //Keshav04022021>>
                    IF EWBNo <> '' THEN BEGIN
                        SalesInvoiceHeader."E-Way Bill No." := EWBNo;
                        SalesInvoiceHeader."E-Way Bill Date" := format(AckDate);
                        SalesInvoiceHeader."E-Way Bill Validity" := EWBValidity;
                        SalesInvoiceHeader."E-Way Generated" := TRUE;
                        SalesInvoiceHeader."E-Way Canceled" := FALSE;
                    END;
                    SalesInvoiceHeader.MODIFY;
                    Message('E-Way Bill Generated Successfully');
                    //Keshav04022021<<
                END;
            END ELSE
                IF IsTransferInvoice THEN BEGIN
                    TransferShipmentHeader.RESET;
                    TransferShipmentHeader.SETRANGE("No.", DocumentNo);
                    IF TransferShipmentHeader.FINDFIRST THEN BEGIN
                        //Keshav05022021>>
                        IF EWBNo <> '' THEN BEGIN
                            TransferShipmentHeader."E-Way Bill No." := EWBNo;
                            TransferShipmentHeader."E-Way Bill Date" := Format(AckDate);
                            TransferShipmentHeader."E-Way Bill Validity" := EWBValidity;
                            TransferShipmentHeader."E-Way Generated" := TRUE;
                            TransferShipmentHeader."E-Way Canceled" := FALSE;
                            //MESSAGE(GetJsonNodeValue('InfoDtls.infoDesc'));
                        END;
                        TransferShipmentHeader.MODIFY;
                        Message('E-Way Bill Generated Successfully');
                        //Keshav05022021<<
                    END;
                end;
        end else
            Message(APIError);
    end;

    procedure TroubleshootSalesInvJSONSchemaEWB(SalesInvoiceHeader: Record 112)
    begin
        IsEWB := TRUE;
        IF (GetGSTNNo(SalesInvoiceHeader."Location Code") <> '') THEN
            GSTNNo := GetGSTNNo(SalesInvoiceHeader."Location Code"); //MSKS

        DocumentNo := SalesInvoiceHeader."No.";
        LocationCode := SalesInvoiceHeader."Location Code";
        // Authenticate1();
        //ReadCredentials(1);

        WriteFileHeader;
        ReadTransDtls(SalesInvoiceHeader."GST Customer Type", SalesInvoiceHeader."Ship-to Code");
        ReadDocDtls;
        ReadExpDtls;
        ReadSellerDtls;
        ReadBuyerDtls;
        ReadShipDtls;
        ReadEWBDtls;//Keshav04022021
        ReadValDtls;
        ReadItemList();
        JFinalArray.Add(JHeaderObject);
        JHeaderObject.Add('lineItems', JLineArray);
        JFinalLoad.Add('req', JFinalArray);
        JFinalLoad.WriteTo(MessageText);
        PayloadOutPut := DelChr(MessageText, '=', '#');
        Message(PayloadOutPut);

        //GetEWBNo();
    end;

    procedure GenerateTransferInvoiceJSONSchemaEWB(var TransferShipmentHeader: Record 5744)
    begin
        IsEWB := TRUE;

        IF (GetGSTNNo(TransferShipmentHeader."Transfer-from Code") <> '') THEN
            GSTNNo := GetGSTNNo(TransferShipmentHeader."Transfer-from Code"); //MSKS
        DocumentNo := TransferShipmentHeader."No.";
        Authenticate1();
        //ReadCredentials(1);
        WriteFileHeader;
        ReadTransDtls(0, '');
        ReadDocDtls;

        ReadSellerDtls;
        ReadBuyerDtls;
        ReadShipDtls;
        ReadEWBDtls;//Keshav05022021
        ReadValDtls;
        ReadItemList();
        JFinalArray.Add(JHeaderObject);
        JHeaderObject.Add('lineItems', JLineArray);
        JFinalLoad.Add('req', JFinalArray);
        JFinalLoad.WriteTo(MessageText);
        PayloadOutPut := DelChr(MessageText, '=', '#');
        Message(PayloadOutPut);

        GetEWBNo();
    end;

    procedure TroubleShootTransferInvoiceJSONSchemaEWB(var TransferShipmentHeader: Record 5744)
    begin
        IsEWB := TRUE;

        IF (GetGSTNNo(TransferShipmentHeader."Transfer-from Code") <> '') THEN
            GSTNNo := GetGSTNNo(TransferShipmentHeader."Transfer-from Code"); //MSKS
        DocumentNo := TransferShipmentHeader."No.";
        //Authenticate1();
        //ReadCredentials(1);
        WriteFileHeader;
        ReadTransDtls(0, '');
        ReadDocDtls;

        ReadSellerDtls;
        ReadBuyerDtls;
        ReadShipDtls;
        ReadEWBDtls;//Keshav05022021
        ReadValDtls;
        ReadItemList();
        JFinalArray.Add(JHeaderObject);
        JHeaderObject.Add('lineItems', JLineArray);
        JFinalLoad.Add('req', JFinalArray);
        JFinalLoad.WriteTo(MessageText);
        PayloadOutPut := DelChr(MessageText, '=', '#');
        Message(PayloadOutPut);

        //GetEWBNo();
    end;

    procedure CancelEWaySalesInvoice(SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        SalesInvoiceHeader2: Record "Sales Invoice Header";
        rLocation: Record Location;
        EWBUser: Text;
        EWBPass: Text;
        EWBAPIKey: Text;
        CompanyInformation: Record "Company Information";
        EwayObject: JsonObject;
        EwayArray: JsonArray;
        EObject: JsonObject;
        Body: Text;

        EinvoiceHttpClient: HttpClient;
        EinvoiceHttpRequest: HttpRequestMessage;
        EinvoiceHttpContent: HttpContent;
        EinvoiceHttpHeader: HttpHeaders;
        EinvoiceHttpResponse: HttpResponseMessage;
        JOutputObject: JsonObject;
        JOutputToken: JsonToken;
        JResultToken: JsonToken;
        JResultObject: JsonObject;
        OutputMessage: Text;
        ResultMessage: Text;

    begin
        IF rLocation.GET(SalesInvoiceHeader."Location Code") THEN;
        LocationCode := SalesInvoiceHeader."Location Code";
        EWBUser := rLocation.Username;
        EWBPass := rLocation.Password;
        EWBAPIKey := rLocation.apiaccesskey;

        CompanyInformation.GET;
        SalesInvoiceHeader.TESTFIELD("E-Way Bill No.");
        SalesInvoiceHeader.TESTFIELD("Reason of Cancel");

        AddHeaderDetails;
        EObject.Add('ewbNo', SalesInvoiceHeader."E-Way Bill No.");

        IF SalesInvoiceHeader."Reason of Cancel" = SalesInvoiceHeader."Reason of Cancel"::"Data Entry mistake" THEN
            EObject.Add('cancelRsnCode', '1')
        ELSE
            IF SalesInvoiceHeader."Reason of Cancel" = SalesInvoiceHeader."Reason of Cancel"::Duplicate THEN
                EObject.Add('cancelRsnCode', '2')
            ELSE
                IF SalesInvoiceHeader."Reason of Cancel" = SalesInvoiceHeader."Reason of Cancel"::"Order Cancelled" THEN
                    EObject.Add('cancelRsnCode', '3')
                ELSE
                    IF SalesInvoiceHeader."Reason of Cancel" = SalesInvoiceHeader."Reason of Cancel"::Others THEN
                        EObject.Add('cancelRsnCode', '4');
        EObject.Add('cancelRmrk', 'Cancelled the order');
        EwayArray.Add(EObject);
        Clear(EObject);
        EwayObject.Add('ewaybills', EwayArray);
        EwayObject.WriteTo(Body);
        // Message(Body);

        rLocation.GET(LocationCode);
        rLocation.TESTFIELD("E-InvGenerateURL");
        EinvoiceHttpContent.WriteFrom(Body);
        EinvoiceHttpContent.GetHeaders(EinvoiceHttpHeader);
        EinvoiceHttpHeader.Clear();
        EinvoiceHttpHeader.Add('accessToken', access_token);
        EinvoiceHttpHeader.Add('apiaccesskey', rLocation.apiaccesskey);
        EinvoiceHttpHeader.Add('Content-Type', 'application/json');
        EinvoiceHttpRequest.Content := EinvoiceHttpContent;
        //EinvoiceHttpRequest.SetRequestUri('https://eapi.eyasp.com/eapi/v1.0/cancelEWB');
        EinvoiceHttpRequest.SetRequestUri('https://eapi.eyasp.com/ewbms/v1.0/cancel');
        EinvoiceHttpRequest.Method := 'POST';
        if EinvoiceHttpClient.Send(EinvoiceHttpRequest, EinvoiceHttpResponse) then begin
            EinvoiceHttpResponse.Content.ReadAs(ResultMessage);
            JResultObject.ReadFrom(ResultMessage);
            // Message(ResultMessage);
            if JResultObject.Get('data', JResultToken) then
                if JResultToken.IsObject then begin
                    JResultToken.WriteTo(OutputMessage);
                    JOutputObject.ReadFrom(OutputMessage);
                end;
            if JOutputObject.Get('error', JOutputToken) then
                if JOutputToken.IsArray then begin
                    JOutputToken.WriteTo(OutputMessage);
                    if OutputMessage = '[]' then begin
                        SalesInvoiceHeader2.GET(SalesInvoiceHeader."No.");
                        SalesInvoiceHeader2."E-Way Bill No." := '';//FORMAT(EWayBillNo);
                        SalesInvoiceHeader2."E-Way Bill Date" := '';// EWayBillDateTime;
                        SalesInvoiceHeader2."E-Way Bill Validity" := '';//EWayExpiryDateTime;
                        SalesInvoiceHeader2."E-Way URL" := '';//
                        SalesInvoiceHeader2."E-Way Generated" := FALSE;//TRUE;
                        SalesInvoiceHeader2."E-Way Canceled" := TRUE;
                        SalesInvoiceHeader2."Reason of Cancel" := SalesInvoiceHeader2."Reason of Cancel"::" ";
                        SalesInvoiceHeader2.MODIFY;
                        MESSAGE('E-Way Bill Canceled');
                    END ELSE
                        Message(OutputMessage);
                end;
        end else
            Message(APIError);
    end;

    procedure AddHeaderDetails()
    var
        EinvoiceHttpClient: HttpClient;
        EinvoiceHttpRequest: HttpRequestMessage;
        EinvoiceHttpContent: HttpContent;
        EinvoiceHttpHeader: HttpHeaders;
        EinvoiceHttpResponse: HttpResponseMessage;
        JOutputObject: JsonObject;
        JResultToken: JsonToken;
        JResultObject: JsonObject;
        OutputMessage: Text;
        ResultMessage: Text;
        rLocation: Record 14;
    begin
        rLocation.GET(LocationCode);
        rLocation.TESTFIELD("E-InvAuthenticateURL");
        rLocation.TESTFIELD(Username);
        rLocation.TESTFIELD(Password);
        rLocation.TESTFIELD(apiaccesskey);

        EinvoiceHttpContent.GetHeaders(EinvoiceHttpHeader);
        EinvoiceHttpHeader.Clear();
        //EinvoiceHttpHeader.Add('username', 'manmohan.khare@orientbell.eyasp.com');
        //EinvoiceHttpHeader.Add('password', 'T0JMQDIwMjA=');
        //EinvoiceHttpHeader.Add('apiaccesskey', 'l7xx1521cf8bc25c4e18a0e8f3abba019451');
        EinvoiceHttpHeader.Add('username', rLocation.Username);
        EinvoiceHttpHeader.Add('password', rLocation.Password);
        EinvoiceHttpHeader.Add('apiaccesskey', rLocation.apiaccesskey);
        EinvoiceHttpHeader.Add('Content-Type', 'application/json');
        EinvoiceHttpRequest.Content := EinvoiceHttpContent;
        // EinvoiceHttpRequest.SetRequestUri('https://eapi.eyasp.com/eapi/v2.0/authenticate');
        EinvoiceHttpRequest.SetRequestUri(rLocation."E-InvAuthenticateURL");
        EinvoiceHttpRequest.Method := 'POST';
        if EinvoiceHttpClient.Send(EinvoiceHttpRequest, EinvoiceHttpResponse) then begin
            EinvoiceHttpResponse.Content.ReadAs(ResultMessage);
            JResultObject.ReadFrom(ResultMessage);

            if JResultObject.Get('status', JResultToken) then
                if JResultToken.AsValue().AsInteger() = 1 then begin
                    if JResultObject.Get('accessToken', JResultToken) then
                        access_token := JResultToken.AsValue().AsText();
                end else
                    Message(Format(JResultToken));
            if JResultToken.IsObject then begin
                JResultToken.WriteTo(OutputMessage);
                JOutputObject.ReadFrom(OutputMessage);
            end;
        end else
            Error('Error When Contacting API');
    end;

    procedure TroublenshootCancelEWaySalesInvoice(SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        rLocation: Record Location;
        EWBUser: Text;
        EWBPass: Text;
        EWBAPIKey: Text;
        CompanyInformation: Record "Company Information";
        EwayObject: JsonObject;
        EwayArray: JsonArray;
        EObject: JsonObject;
        Body: Text;

    begin
        IF rLocation.GET(SalesInvoiceHeader."Location Code") THEN;
        LocationCode := SalesInvoiceHeader."Location Code";
        EWBUser := rLocation.Username;
        EWBPass := rLocation.Password;
        EWBAPIKey := rLocation.apiaccesskey;

        CompanyInformation.GET;
        SalesInvoiceHeader.TESTFIELD("E-Way Bill No.");
        SalesInvoiceHeader.TESTFIELD("Reason of Cancel");

        // AddHeaderDetails;
        EObject.Add('ewbNo', SalesInvoiceHeader."E-Way Bill No.");

        IF SalesInvoiceHeader."Reason of Cancel" = SalesInvoiceHeader."Reason of Cancel"::"Data Entry mistake" THEN
            EObject.Add('cancelRsnCode', '1')
        ELSE
            IF SalesInvoiceHeader."Reason of Cancel" = SalesInvoiceHeader."Reason of Cancel"::Duplicate THEN
                EObject.Add('cancelRsnCode', '2')
            ELSE
                IF SalesInvoiceHeader."Reason of Cancel" = SalesInvoiceHeader."Reason of Cancel"::"Order Cancelled" THEN
                    EObject.Add('cancelRsnCode', '3')
                ELSE
                    IF SalesInvoiceHeader."Reason of Cancel" = SalesInvoiceHeader."Reason of Cancel"::Others THEN
                        EObject.Add('cancelRsnCode', '4');
        EObject.Add('cancelRmrk', 'Cancelled the order');
        EwayArray.Add(EObject);
        Clear(EObject);
        EwayObject.Add('ewaybills', EwayArray);
        EwayObject.WriteTo(Body);
        Message(Body);
        /* rLocation.GET(LocationCode);
        rLocation.TESTFIELD("E-InvGenerateURL");
        EinvoiceHttpContent.WriteFrom(Body);
        EinvoiceHttpContent.GetHeaders(EinvoiceHttpHeader);
        EinvoiceHttpHeader.Clear();
        EinvoiceHttpHeader.Add('accessToken', access_token);
        EinvoiceHttpHeader.Add('apiaccesskey', rLocation.apiaccesskey);
        EinvoiceHttpHeader.Add('Content-Type', 'application/json');
        EinvoiceHttpRequest.Content := EinvoiceHttpContent;
        EinvoiceHttpRequest.SetRequestUri('https://eapi.eyasp.com/eapi/v1.0/cancelEWB');
        EinvoiceHttpRequest.Method := 'POST';
        if EinvoiceHttpClient.Send(EinvoiceHttpRequest, EinvoiceHttpResponse) then begin
            EinvoiceHttpResponse.Content.ReadAs(ResultMessage);
            JResultObject.ReadFrom(ResultMessage);
            Message(ResultMessage);
            if JResultObject.Get('data.error..errorDesc', JResultToken) then
                if JResultToken.AsValue().AsText() = '' THEN BEGIN
                    SalesInvoiceHeader2.GET(SalesInvoiceHeader."No.");
                    SalesInvoiceHeader2."E-Way Bill No." := '';//FORMAT(EWayBillNo);
                    SalesInvoiceHeader2."E-Way Bill Date" := '';// EWayBillDateTime;
                    SalesInvoiceHeader2."E-Way Bill Validity" := '';//EWayExpiryDateTime;
                    SalesInvoiceHeader2."E-Way URL" := '';//
                    SalesInvoiceHeader2."E-Way Generated" := FALSE;//TRUE;
                    SalesInvoiceHeader2."E-Way Canceled" := TRUE;
                    SalesInvoiceHeader2."Reason of Cancel" := SalesInvoiceHeader2."Reason of Cancel"::" ";
                    SalesInvoiceHeader2.MODIFY;
                    MESSAGE('E-Way Bill Canceled');
                END ELSE
                    Message(JResultToken.AsValue().AsText());
        end else
            Message(APIError); */
    end;

    procedure DownloadEWBSalesInv(SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        CompanyInformation: Record "Company Information";
        IntVal: Integer;
        EWBUser: Text;
        EWBPass: Text;
        EWBAPIKey: Text;
        rLocation: Record Location;
        DownloadObject: JsonObject;
        DownloadArray: JsonArray;
        EinvoiceHttpClient: HttpClient;
        EinvoiceHttpRequest: HttpRequestMessage;
        EinvoiceHttpContent: HttpContent;
        EinvoiceHttpHeader: HttpHeaders;
        EinvoiceHttpResponse: HttpResponseMessage;
        Body: Text;
        Instr: InStream;
        FileName: text;
    begin
        IF rLocation.GET(SalesInvoiceHeader."Location Code") THEN;
        LocationCode := SalesInvoiceHeader."Location Code";
        EWBUser := rLocation.Username;
        EWBPass := rLocation.Password;
        EWBAPIKey := rLocation.apiaccesskey;
        DownloadArray.Add(SalesInvoiceHeader."E-Way Bill No.");
        DownloadObject.Add('ewbNos', DownloadArray);
        IntVal := STRMENU('Details,Summary', 2);
        IF IntVal = 2 THEN BEGIN
            DownloadObject.Add('reportType', 'Summary');
        END ELSE
            IF IntVal = 1 THEN BEGIN
                DownloadObject.Add('reportType', 'Detail');
            END ELSE BEGIN
                EXIT;
            END;
        DownloadObject.WriteTo(Body);
        //Message(Body);

        CompanyInformation.GET;
        AddHeaderDetails;
        rLocation.GET(LocationCode);
        rLocation.TESTFIELD("E-InvGenerateURL");
        EinvoiceHttpContent.WriteFrom(Body);
        EinvoiceHttpContent.GetHeaders(EinvoiceHttpHeader);
        EinvoiceHttpHeader.Clear();
        EinvoiceHttpHeader.Add('accessToken', access_token);
        EinvoiceHttpHeader.Add('apiaccesskey', rLocation.apiaccesskey);
        EinvoiceHttpHeader.Add('Content-Type', 'application/json');
        EinvoiceHttpRequest.Content := EinvoiceHttpContent;
        EinvoiceHttpRequest.SetRequestUri('https://eapi.eyasp.com/ewbms/v1.0/downloadEWBPDF');
        EinvoiceHttpRequest.Method := 'POST';
        if EinvoiceHttpClient.Send(EinvoiceHttpRequest, EinvoiceHttpResponse) then begin
            EinvoiceHttpResponse.Content.ReadAs(Instr);
            FileName := SalesInvoiceHeader."E-Way Bill No." + '.pdf';
            DownloadFromStream(Instr, 'Export', '', 'All Files (*.*)|*.*', FileName);
        end else
            Message('Not Responding');
    end;

    procedure CreateJSONPurchReturn(PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    var
        VendorL: Record Vendor;

        EinvoiceHttpClient: HttpClient;
        EinvoiceHttpRequest: HttpRequestMessage;
        EinvoiceHttpContent: HttpContent;
        EinvoiceHttpHeader: HttpHeaders;
        EinvoiceHttpResponse: HttpResponseMessage;
        JOutputObject: JsonObject;
        JOutputToken: JsonToken;
        JResultToken: JsonToken;
        JResultObject: JsonObject;
        OutputMessage: Text;
        ResultMessage: Text;

        PurchCrMemoLineL: Record "Purch. Cr. Memo Line";
        CustGstin: Code[15];
        EWayBillNo: Text[30];
        EWayBillDateTime: Variant;
        EWayExpiryDateTime: Variant;
        PurchCrMemoHdrL2: Record "Purch. Cr. Memo Hdr.";
        TransportMethod: Record "Transport Method";
        Location: Record Location;
        State_Gst: Code[2];
        State_rec: Record State;
        rLocation: Record Location;
        EWBUser: Text;
        EWBAPIKey: Text;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        TotalInAmt: Decimal;
        EWBPass: Text;
        GetCompanyInfo: Record "Company Information";
        PCMObject: JsonObject;
        PCMObjectLine: JsonObject;
        JLineArray: JsonArray;
        JFinalArray: JsonArray;
        intSlNo: Integer;
        GSTBaseAmt: Decimal;
        JResultArray: JsonArray;
    begin
        IF rLocation.GET(PurchCrMemoHdr."Location Code") THEN;
        LocationCode := PurchCrMemoHdr."Location Code";
        EWBUser := rLocation.Username;
        EWBPass := rLocation.Password;
        EWBAPIKey := rLocation.apiaccesskey;

        GetCompanyInfo.get();
        IF TransportMethod.GET(PurchCrMemoHdr."Transport Method") THEN;
        // IF ShippingAgent.GET(PurchCrMemoHdr."Shipping Agent CodeBase") THEN;
        IF Location.GET(PurchCrMemoHdr."Location Code") THEN;
        PurchCrMemoHdr.TESTFIELD("E-Way Bill No.", '');
        PurchCrMemoHdr.TESTFIELD("Truck No.");
        PurchCrMemoHdr.TESTFIELD("Transport Method");
        //PurchCrMemoHdr.TESTFIELD("Distance (Km)");
        // AddToJason('userGstin',GetGSTIN(PurchCrMemoHdr."Location Code"));//Test
        AddHeaderDetails;

        TotalInAmt := 0;

        PCMObject.add('sourceIdentifier', '');
        PCMObject.add('division', '');
        PCMObject.add('subDivision', '');
        PCMObject.add('profitCenter1', '');//Test
        PCMObject.add('profitCenter2', '');
        PCMObject.add('plantCode', '');
        // PCMObject.add('fromGstin','29AAACO0305P1ZD');//Test
        PCMObject.add('fromGstin', Location."GST Registration No.");
        PCMObject.add('docCategory', 'REG');
        PCMObject.add('fromTrdName', Location.Name);                       //CompanyInformation.Name);
        PCMObject.add('supplierAddress1', Location.Address);                    //CompanyInformation.Address);
        PCMObject.add('supplierAddress2', Location."Address 2");                //CompanyInformation."Address 2");
        //PCMObject.add('ORIGIN_STATE',GetStateCode(Location."State Code"));         //CompanyInformation.State));
        PCMObject.add('supplierPlace', Location.City);                           //CompanyInformation.City);
        PCMObject.add('supplierPin', Location."Pin Code");                     //CompanyInformation."Post Code");
        // PCMObject.add('supplierPin','560063');//Test

        PCMObject.add('dispatcherGstin', CustGstin);
        PCMObject.add('dispatcherName', PurchCrMemoHdr."Buy-from Vendor Name");
        PCMObject.add('dispatcherAddress1', PurchCrMemoHdr."Ship-to Address");
        PCMObject.add('dispatcherAddress2', PurchCrMemoHdr."Ship-to Address 2");

        IF VendorL.GET(PurchCrMemoHdr."Pay-to Vendor No.") THEN
            IF VendorL."GST Registration No." <> '' THEN BEGIN
                CustGstin := VendorL."GST Registration No.";
            END ELSE
                CustGstin := 'URP';

        State_Gst := '';
        State_Gst := COPYSTR(CustGstin, 1, 2);
        VendorL.GET(PurchCrMemoHdr."Buy-from Vendor No.");
        State_rec.RESET;
        //State_rec.SETRANGE("State Code (GST Reg. No.)",State_Gst);
        State_rec.SETRANGE(Code, VendorL."State Code");
        IF State_rec.FINDFIRST THEN;
        VendorLedgerEntry.SETRANGE("Document Type", VendorLedgerEntry."Document Type"::"Credit Memo");
        VendorLedgerEntry.SETRANGE(VendorLedgerEntry."Document No.", PurchCrMemoHdr."No.");
        VendorLedgerEntry.SetRange("Posting Date", PurchCrMemoHdr."Posting Date");
        IF VendorLedgerEntry.FINDFIRST THEN BEGIN
            VendorLedgerEntry.CALCFIELDS("Amount (LCY)");
            TotalInAmt := ABS(VendorLedgerEntry."Amount (LCY)");
        END;
        // PCMObject.add('actFromStateCode','29');//Test
        PCMObject.add('actFromStateCode', COPYSTR(Location."GST Registration No.", 1, 2));
        // PCMObject.add('fromStateCode','29');//Test
        PCMObject.add('fromStateCode', COPYSTR(Location."GST Registration No.", 1, 2));
        PCMObject.add('dispatcherPlace', PurchCrMemoHdr."Ship-to City");
        PCMObject.add('dispatcherPin', VendorL."Pin Code");
        // PCMObject.add('dispatcherPin','560063');//Test
        PCMObject.add('supplyType', 'O');
        PCMObject.add('subSupplyType', 'OTH');
        PCMObject.add('docType', 'OTH');
        PCMObject.add('otherSupplyTypeDescription', 'NO');
        PCMObject.add('docNo', PurchCrMemoHdr."No.");
        PCMObject.add('docDate', PurchCrMemoHdr."Posting Date");
        //PCMObject.add('recepientGSTIN','08ABSFS3250K1ZN');//Test
        PCMObject.add('recepientGSTIN', PurchCrMemoHdr."Vendor GST Reg. No.");
        PCMObject.add('recepientName', PurchCrMemoHdr."Ship-to Name");
        // PCMObject.add('shipToGSTIN','08ABSFS3250K1ZN');//test
        PCMObject.add('shipToGSTIN', PurchCrMemoHdr."Vendor GST Reg. No.");
        PCMObject.add('shipToTradeName', PurchCrMemoHdr."Ship-to Name");
        PCMObject.add('shipToAddress1', PurchCrMemoHdr."Ship-to Address");
        PCMObject.add('shipToAddress2', PurchCrMemoHdr."Ship-to Address 2");
        PCMObject.add('toPlace', PurchCrMemoHdr."Ship-to City");
        PCMObject.add('toPincode', VendorL."Pin Code");
        // PCMObject.add('toPincode','302001');
        // PCMObject.add('toStateCode','08');//Test
        PCMObject.add('toStateCode', COPYSTR(PurchCrMemoHdr."Vendor GST Reg. No.", 1, 2));
        // PCMObject.add('actToStateCode','08');//Test
        PCMObject.add('actToStateCode', COPYSTR(PurchCrMemoHdr."Vendor GST Reg. No.", 1, 2));
        //  PurchCrMemoHdr.CALCFIELDS("Amount to Vendor");
        PCMObject.Add('totInvValue', TotalInAmt);
        PCMObject.add('otherValue', 0);//NeedToChange
        PCMObject.add('transMode', TransportMethod."E-Way transport method");//SalesInvoiceHeader."Mode of Transport");
        PCMObject.add('transporterId', '');
        PCMObject.add('transporterName', '');
        PCMObject.add('transDocNo', PurchCrMemoHdr."GR No.");
        // AddToJason('transDocNo','');//Test
        PCMObject.add('transDocDate', PurchCrMemoHdr."Document Date");
        // AddToJason('transDocDate','');//Test
        PCMObject.add('transDistance', PurchCrMemoHdr."Distance (Km)");
        PCMObject.add('vehicleNo', DELCHR(PurchCrMemoHdr."Truck No.", '=', ' ,/-<>  !@#$%^&*()_+{}'));
        PCMObject.add('vehicleType', 'R');
        PCMObject.add('userDefinedFiled1', '');
        PCMObject.add('userDefinedFiled2', '');

        intSlNo := 0;
        PurchCrMemoLineL.RESET;
        PurchCrMemoLineL.SETRANGE("Document No.", PurchCrMemoHdr."No.");
        PurchCrMemoLineL.SETRANGE(Type, PurchCrMemoLineL.Type::Item);
        PurchCrMemoLineL.SETFILTER(Quantity, '<>%1', 0);
        IF PurchCrMemoLineL.FINDSET THEN BEGIN
            REPEAT
                GetGSTAmtPurchaseLine(PurchCrMemoLineL, GSTBaseAmt);
                intSlNo += 1;

                PCMObjectLine.Add('lineNo', intSlNo);
                PCMObjectLine.Add('productName', PurchCrMemoLineL.Description);
                PCMObjectLine.Add('productDesc', '');
                // PCMObjectLine.Add('hsnCode', PurchCrMemoLineL."HSN/SAC Code"); //85030010
                PCMObjectLine.Add('hsnCode', '85030010');
                PCMObjectLine.Add('qtyUnit', GetUOM(PurchCrMemoLineL."Unit of Measure Code"));
                PCMObjectLine.Add('quantity', PurchCrMemoLineL.Quantity);
                //    PCMObjectLine.Add('taxableAmount',PurchCrMemoLineL.Amount);
                PCMObjectLine.Add('taxableAmount', abs(GSTBaseAmt));
                PCMObjectLine.Add('igstRate', GetGSTRate(PurchCrMemoLineL."Document No.", 'IGST', PurchCrMemoLineL."Line No."));
                PCMObjectLine.Add('igstValue', GetGSTAmountLine(PurchCrMemoHdr."No.", 'IGST', PurchCrMemoLineL."Line No."));
                PCMObjectLine.Add('cgstRate', GetGSTRate(PurchCrMemoLineL."Document No.", 'CGST', PurchCrMemoLineL."Line No."));
                PCMObjectLine.Add('cgstValue', GetGSTAmountLine(PurchCrMemoHdr."No.", 'CGST', PurchCrMemoLineL."Line No."));
                PCMObjectLine.Add('sgstRate', GetGSTRate(PurchCrMemoLineL."Document No.", 'SGST', PurchCrMemoLineL."Line No."));
                PCMObjectLine.Add('sgstValue', GetGSTAmountLine(PurchCrMemoHdr."No.", 'SGST', PurchCrMemoLineL."Line No."));
                PCMObjectLine.Add('cessRateAdvol', 0);
                PCMObjectLine.Add('cessAmtAdvol', GetGSTAmount(PurchCrMemoHdr."No.", 'CESS'));
                PCMObjectLine.Add('cessRateSpec', 0);
                PCMObjectLine.Add('cessAmtSpec', 0);
                JLineArray.Add(PCMObjectLine);
                Clear(PCMObjectLine);
            UNTIL PurchCrMemoLineL.NEXT = 0;
        END;

        IF CONFIRM('Do you want instant generate the E-way') THEN BEGIN
            JFinalArray.Add(PCMObject);
            PCMObject.Add('itemList', JLineArray);
            JFinalLoad.Add('invoices', JFinalArray);
            JFinalLoad.WriteTo(MessageText);
            Message(MessageText);
            LocationCode := PurchCrMemoHdr."Location Code";

            rLocation.GET(LocationCode);
            rLocation.TESTFIELD("E-InvGenerateURL");
            EinvoiceHttpContent.WriteFrom(MessageText);
            EinvoiceHttpContent.GetHeaders(EinvoiceHttpHeader);
            EinvoiceHttpHeader.Clear();
            EinvoiceHttpHeader.Add('accessToken', access_token);
            EinvoiceHttpHeader.Add('apiaccesskey', rLocation.apiaccesskey);
            EinvoiceHttpHeader.Add('Content-Type', 'application/json');
            EinvoiceHttpRequest.Content := EinvoiceHttpContent;
            EinvoiceHttpRequest.SetRequestUri('https://eapi.eyasp.com/ewbms/v1.0/generate');
            EinvoiceHttpRequest.Method := 'POST';
            if EinvoiceHttpClient.Send(EinvoiceHttpRequest, EinvoiceHttpResponse) then begin
                EinvoiceHttpResponse.Content.ReadAs(ResultMessage);
                JResultObject.ReadFrom(ResultMessage);
                Message(ResultMessage);
                if JResultObject.Get('data', JResultToken) then
                    if JResultToken.IsObject then begin
                        JResultToken.WriteTo(OutputMessage);
                        JOutputObject.ReadFrom(OutputMessage);
                    end;
                if JOutputObject.Get('error', JOutputToken) then
                    if JOutputToken.IsArray then begin
                        JOutputToken.WriteTo(OutputMessage);
                        if OutputMessage = '[]' then begin
                            //JResultArray.ReadFrom(OutputMessage);
                            if JOutputObject.Get('success', JOutputToken) then
                                if JOutputToken.IsArray then begin
                                    JOutputToken.WriteTo(OutputMessage);
                                    JResultArray.ReadFrom(OutputMessage);
                                    if JResultArray.Get(0, JOutputToken) then begin
                                        if JOutputToken.IsObject then begin
                                            JOutputToken.WriteTo(OutputMessage);
                                            JOutputObject.ReadFrom(OutputMessage);
                                        end;
                                    end;
                                end;
                            if JOutputObject.Get('ewb', JOutputToken) then
                                EWayBillNo := JOutputToken.AsValue().AsText();
                            if JOutputObject.Get('ewbDate', JOutputToken) then
                                EWayBillDateTime := JOutputToken.AsValue().AsText();
                            if JOutputObject.Get('validUpTo', JOutputToken) then
                                EWayExpiryDateTime := JOutputToken.AsValue().AsText();
                        end else
                            Message(OutputMessage);
                    end;
            end;
            COMMIT;
            IF EWayBillNo <> '' THEN BEGIN
                PurchCrMemoHdrL2.GET(PurchCrMemoHdr."No.");
                PurchCrMemoHdrL2."E-Way Bill No.1" := FORMAT(EWayBillNo);
                PurchCrMemoHdrL2."E-Way Bill Date1" := EWayBillDateTime;
                PurchCrMemoHdrL2."E-Way Bill Validity" := EWayExpiryDateTime;
                PurchCrMemoHdrL2."E-Way Generated" := TRUE;
                PurchCrMemoHdrL2."E-Way Canceled" := FALSE;
                PurchCrMemoHdrL2.MODIFY;
                MESSAGE('E-Way Bill Generated');
            END else
                Message('E-Way Bill Generated Failed');
        end else
            Message(APIError);
    end;


    local procedure GetGSTRate(DocNo: Code[20]; CompCode: Code[10]; LineNo: Integer): Decimal
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        GSTAmt: Decimal;
    begin
        GSTAmt := 0;
        DetailedGSTLedgerEntry.RESET;
        DetailedGSTLedgerEntry.SETRANGE("Document No.", DocNo);
        DetailedGSTLedgerEntry.SETRANGE("Document Line No.", LineNo);
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", CompCode);
        IF DetailedGSTLedgerEntry.FINDFIRST THEN
            EXIT(ROUND(DetailedGSTLedgerEntry."GST %", 0.01));
        EXIT(0);
    end;

    local procedure GetGSTAmountLine(DocNo: Code[20]; CompCode: Code[10]; DocLine: Integer): Decimal
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        GSTAmt: Decimal;
    begin
        GSTAmt := 0;
        DetailedGSTLedgerEntry.RESET;
        DetailedGSTLedgerEntry.SETRANGE("Document No.", DocNo);
        DetailedGSTLedgerEntry.SETRANGE("Document Line No.", DocLine);
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", CompCode);
        IF DetailedGSTLedgerEntry.FINDSET THEN
            REPEAT
                GSTAmt += ABS(DetailedGSTLedgerEntry."GST Amount");
            UNTIL DetailedGSTLedgerEntry.NEXT = 0;
        EXIT(GSTAmt);
    end;

    local procedure GetGSTAmount(DocNo: Code[20]; CompCode: Code[10]): Decimal
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        GSTAmt: Decimal;
    begin
        GSTAmt := 0;
        DetailedGSTLedgerEntry.RESET;
        DetailedGSTLedgerEntry.SETRANGE("Document No.", DocNo);
        DetailedGSTLedgerEntry.SETRANGE("GST Component Code", CompCode);
        IF DetailedGSTLedgerEntry.FINDSET THEN
            REPEAT
                GSTAmt += ABS(DetailedGSTLedgerEntry."GST Amount");
            UNTIL DetailedGSTLedgerEntry.NEXT = 0;
        EXIT(GSTAmt);
    end;

    local procedure GetGSTAmtPurchaseLine(PurCrMemLine: Record "Purch. Cr. Memo Line"; var LGSTBaseAmt: Decimal)
    var
        DetailedGSTLedger: Record "Detailed GST Ledger Entry";
    begin
        Clear(LGSTBaseAmt);
        DetailedGSTLedger.Reset();
        DetailedGSTLedger.SetRange("Document No.", PurCrMemLine."Document No.");
        DetailedGSTLedger.SetRange("Document Line No.", PurCrMemLine."Line No.");
        if DetailedGSTLedger.FindSet() then
            repeat
                if DetailedGSTLedger."GST Component Code" = 'CGST' then
                    LGSTBaseAmt += abs(DetailedGSTLedger."GST Base Amount")
                else
                    if DetailedGSTLedger."GST Component Code" = 'IGST' then
                        LGSTBaseAmt += abs(DetailedGSTLedger."GST Base Amount");
            until DetailedGSTLedger.Next() = 0;
    end;

    procedure CancelEWayTransfer(TransferShipmentHeader: Record "Transfer Shipment Header")
    var
        TransferShipmentHeader2: Record "Transfer Shipment Header";
        rLocation: Record Location;
        EWBUser: Text;
        EWBPass: Text;
        EWBAPIKey: Text;
        CompanyInformation: Record "Company Information";
        EwayObject: JsonObject;
        EwayArray: JsonArray;
        EObject: JsonObject;
        Body: Text;

        EinvoiceHttpClient: HttpClient;
        EinvoiceHttpRequest: HttpRequestMessage;
        EinvoiceHttpContent: HttpContent;
        EinvoiceHttpHeader: HttpHeaders;
        EinvoiceHttpResponse: HttpResponseMessage;
        JOutputObject: JsonObject;
        JOutputToken: JsonToken;
        JResultToken: JsonToken;
        JResultObject: JsonObject;
        OutputMessage: Text;
        ResultMessage: Text;

    begin
        IF rLocation.GET(TransferShipmentHeader."Transfer-from Code") THEN;
        LocationCode := TransferShipmentHeader."Transfer-from Code";
        EWBUser := rLocation.Username;
        EWBPass := rLocation.Password;
        EWBAPIKey := rLocation.apiaccesskey;

        CompanyInformation.GET;
        TransferShipmentHeader.TESTFIELD("E-Way Bill No.");
        TransferShipmentHeader.TESTFIELD("Reason of Cancel");

        AddHeaderDetails;
        EObject.Add('ewbNo', TransferShipmentHeader."E-Way Bill No.");

        IF TransferShipmentHeader."Reason of Cancel" = TransferShipmentHeader."Reason of Cancel"::"Data Entry mistake" THEN
            EObject.Add('cancelRsnCode', '1')
        ELSE
            IF TransferShipmentHeader."Reason of Cancel" = TransferShipmentHeader."Reason of Cancel"::Duplicate THEN
                EObject.Add('cancelRsnCode', '2')
            ELSE
                IF TransferShipmentHeader."Reason of Cancel" = SalesInvoiceHeader."Reason of Cancel"::"Order Cancelled" THEN
                    EObject.Add('cancelRsnCode', '3')
                ELSE
                    IF TransferShipmentHeader."Reason of Cancel" = TransferShipmentHeader."Reason of Cancel"::Others THEN
                        EObject.Add('cancelRsnCode', '4');
        EObject.Add('cancelRmrk', 'Cancelled the order');
        EwayArray.Add(EObject);
        Clear(EObject);
        EwayObject.Add('ewaybills', EwayArray);
        EwayObject.WriteTo(Body);
        // Message(Body);

        rLocation.GET(LocationCode);
        rLocation.TESTFIELD("E-InvGenerateURL");
        EinvoiceHttpContent.WriteFrom(Body);
        EinvoiceHttpContent.GetHeaders(EinvoiceHttpHeader);
        EinvoiceHttpHeader.Clear();
        EinvoiceHttpHeader.Add('accessToken', access_token);
        EinvoiceHttpHeader.Add('apiaccesskey', rLocation.apiaccesskey);
        EinvoiceHttpHeader.Add('Content-Type', 'application/json');
        EinvoiceHttpRequest.Content := EinvoiceHttpContent;
        EinvoiceHttpRequest.SetRequestUri('https://eapi.eyasp.com/ewbms/v1.0/cancel');
        EinvoiceHttpRequest.Method := 'POST';
        if EinvoiceHttpClient.Send(EinvoiceHttpRequest, EinvoiceHttpResponse) then begin
            EinvoiceHttpResponse.Content.ReadAs(ResultMessage);
            JResultObject.ReadFrom(ResultMessage);
            // Message(ResultMessage);
            if JResultObject.Get('data', JResultToken) then
                if JResultToken.IsObject then begin
                    JResultToken.WriteTo(OutputMessage);
                    JOutputObject.ReadFrom(OutputMessage);
                end;
            if JOutputObject.Get('error', JOutputToken) then
                if JOutputToken.IsArray then begin
                    JOutputToken.WriteTo(OutputMessage);
                    if OutputMessage = '[]' then begin
                        TransferShipmentHeader2.GET(TransferShipmentHeader."No.");
                        TransferShipmentHeader2."E-Way Bill No." := '';//FORMAT(EWayBillNo);
                        TransferShipmentHeader2."E-Way Bill Date" := '';// EWayBillDateTime;
                        TransferShipmentHeader2."E-Way Bill Validity" := '';//EWayExpiryDateTime;
                        TransferShipmentHeader2."E-Way URL" := '';//
                        TransferShipmentHeader2."E-Way Generated" := FALSE;//TRUE;
                        TransferShipmentHeader2."E-Way Canceled" := TRUE;
                        TransferShipmentHeader2."Reason of Cancel" := TransferShipmentHeader2."Reason of Cancel"::" ";
                        TransferShipmentHeader2.MODIFY;
                        MESSAGE('E-Way Bill Canceled');
                    END ELSE
                        Message(OutputMessage);
                end;
        end else
            Message(APIError);
    end;

    procedure TroubleshootJSON(TransferShipmentHeader: Record "Transfer Shipment Header")
    var
        rLocation: Record Location;
        EWBUser: Text;
        EWBPass: Text;
        EWBAPIKey: Text;
        CompanyInformation: Record "Company Information";
        EwayObject: JsonObject;
        EwayArray: JsonArray;
        EObject: JsonObject;
        Body: Text;

    begin
        IF rLocation.GET(TransferShipmentHeader."Transfer-from Code") THEN;
        LocationCode := TransferShipmentHeader."Transfer-from Code";
        EWBUser := rLocation.Username;
        EWBPass := rLocation.Password;
        EWBAPIKey := rLocation.apiaccesskey;

        CompanyInformation.GET;
        TransferShipmentHeader.TESTFIELD("E-Way Bill No.");
        TransferShipmentHeader.TESTFIELD("Reason of Cancel");

        // AddHeaderDetails;
        EObject.Add('ewbNo', TransferShipmentHeader."E-Way Bill No.");

        IF TransferShipmentHeader."Reason of Cancel" = TransferShipmentHeader."Reason of Cancel"::"Data Entry mistake" THEN
            EObject.Add('cancelRsnCode', '1')
        ELSE
            IF TransferShipmentHeader."Reason of Cancel" = TransferShipmentHeader."Reason of Cancel"::Duplicate THEN
                EObject.Add('cancelRsnCode', '2')
            ELSE
                IF TransferShipmentHeader."Reason of Cancel" = SalesInvoiceHeader."Reason of Cancel"::"Order Cancelled" THEN
                    EObject.Add('cancelRsnCode', '3')
                ELSE
                    IF TransferShipmentHeader."Reason of Cancel" = TransferShipmentHeader."Reason of Cancel"::Others THEN
                        EObject.Add('cancelRsnCode', '4');
        EObject.Add('cancelRmrk', 'Cancelled the order');
        EwayArray.Add(EObject);
        Clear(EObject);
        EwayObject.Add('ewaybills', EwayArray);
        EwayObject.WriteTo(Body);
        Message(Body);
    end;

    procedure DownloadEWBTransferInv(TransferShipmentHeader: Record "Transfer Shipment Header")
    var
        CompanyInformation: Record "Company Information";
        IntVal: Integer;
        EWBUser: Text;
        EWBPass: Text;
        EWBAPIKey: Text;
        rLocation: Record Location;
        DownloadObject: JsonObject;
        DownloadArray: JsonArray;
        EinvoiceHttpClient: HttpClient;
        EinvoiceHttpRequest: HttpRequestMessage;
        EinvoiceHttpContent: HttpContent;
        EinvoiceHttpHeader: HttpHeaders;
        EinvoiceHttpResponse: HttpResponseMessage;
        Body: Text;
        Instr: InStream;
        FileName: text;
    begin
        IF rLocation.GET(TransferShipmentHeader."Transfer-from Code") THEN;
        LocationCode := TransferShipmentHeader."Transfer-from Code";
        EWBUser := rLocation.Username;
        EWBPass := rLocation.Password;
        EWBAPIKey := rLocation.apiaccesskey;
        DownloadArray.Add(TransferShipmentHeader."E-Way Bill No.");
        DownloadObject.Add('ewbNos', DownloadArray);
        IntVal := STRMENU('Details,Summary', 2);
        IF IntVal = 2 THEN BEGIN
            DownloadObject.Add('reportType', 'Summary');
        END ELSE
            IF IntVal = 1 THEN BEGIN
                DownloadObject.Add('reportType', 'Detail');
            END ELSE BEGIN
                EXIT;
            END;
        DownloadObject.WriteTo(Body);
        //Message(Body);

        CompanyInformation.GET;
        AddHeaderDetails;
        rLocation.GET(LocationCode);
        rLocation.TESTFIELD("E-InvGenerateURL");
        EinvoiceHttpContent.WriteFrom(Body);
        EinvoiceHttpContent.GetHeaders(EinvoiceHttpHeader);
        EinvoiceHttpHeader.Clear();
        EinvoiceHttpHeader.Add('accessToken', access_token);
        EinvoiceHttpHeader.Add('apiaccesskey', rLocation.apiaccesskey);
        EinvoiceHttpHeader.Add('Content-Type', 'application/json');
        EinvoiceHttpRequest.Content := EinvoiceHttpContent;
        EinvoiceHttpRequest.SetRequestUri('https://eapi.eyasp.com/ewbms/v1.0/downloadEWBPDF');
        EinvoiceHttpRequest.Method := 'POST';
        if EinvoiceHttpClient.Send(EinvoiceHttpRequest, EinvoiceHttpResponse) then begin
            EinvoiceHttpResponse.Content.ReadAs(Instr);
            FileName := TransferShipmentHeader."E-Way Bill No." + '.pdf';
            DownloadFromStream(Instr, 'Export', '', 'All Files (*.*)|*.*', FileName);
        end else
            Message('Not Responding');
    end;

    procedure DownloadEWBPurchaseRet(PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    var
        rLocation: Record Location;
        EWBPass: text;
        EWBUser: Text;
        EWBAPIKey: Text;
        CompanyInformation: Record "Company Information";
        DownlodO: JsonObject;
        DownloadArray: JsonArray;
        EinvoiceHttpClient: HttpClient;
        EinvoiceHttpRequest: HttpRequestMessage;
        EinvoiceHttpContent: HttpContent;
        EinvoiceHttpHeader: HttpHeaders;
        EinvoiceHttpResponse: HttpResponseMessage;
        Instr: InStream;
        FileName: Text;
    begin
        IF rLocation.GET(PurchCrMemoHdr."Location Code") THEN;
        EWBUser := rLocation.Username;
        EWBPass := rLocation.Password;
        EWBAPIKey := rLocation.apiaccesskey;
        LocationCode := PurchCrMemoHdr."Location Code";
        CompanyInformation.GET;
        AddHeaderDetails;

        DownloadArray.Add(PurchCrMemoHdr."E-Way Bill No.1");
        DownlodO.Add('ewbNos', DownloadArray);
        DownlodO.Add('reportType', 'Detail');
        DownlodO.WriteTo(MessageText);
        // Message(MessageText);
        rLocation.GET(LocationCode);
        rLocation.TESTFIELD("E-InvGenerateURL");
        EinvoiceHttpContent.WriteFrom(MessageText);
        EinvoiceHttpContent.GetHeaders(EinvoiceHttpHeader);
        EinvoiceHttpHeader.Clear();
        EinvoiceHttpHeader.Add('accessToken', access_token);
        EinvoiceHttpHeader.Add('apiaccesskey', rLocation.apiaccesskey);
        EinvoiceHttpHeader.Add('Content-Type', 'application/json');
        EinvoiceHttpRequest.Content := EinvoiceHttpContent;
        EinvoiceHttpRequest.SetRequestUri('https://eapi.eyasp.com/ewbms/v1.0/downloadEWBPDF');
        EinvoiceHttpRequest.Method := 'POST';
        if EinvoiceHttpClient.Send(EinvoiceHttpRequest, EinvoiceHttpResponse) then begin
            EinvoiceHttpResponse.Content.ReadAs(Instr);
            FileName := PurchCrMemoHdr."E-Way Bill No.1" + '.pdf';
            DownloadFromStream(Instr, 'Export', '', 'All Files (*.*)|*.*', FileName);
        end else
            Message('Not Responding');
    end;

    procedure CancelEWayReturn(PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    var

        EWBUser: Text;
        EWBPass: Text;
        EWBAPIKey: Text;
        CompanyInformation: Record "Company Information";
        EwayObject: JsonObject;
        EwayArray: JsonArray;
        EObject: JsonObject;
        Body: Text;

        EinvoiceHttpClient: HttpClient;
        EinvoiceHttpRequest: HttpRequestMessage;
        EinvoiceHttpContent: HttpContent;
        EinvoiceHttpHeader: HttpHeaders;
        EinvoiceHttpResponse: HttpResponseMessage;
        JOutputObject: JsonObject;
        JOutputToken: JsonToken;
        JResultToken: JsonToken;
        JResultObject: JsonObject;
        OutputMessage: Text;
        ResultMessage: Text;
        PurchCrMemoHdr2: Record "Purch. Cr. Memo Hdr.";
        rLocation: Record Location;
    begin
        IF rLocation.GET(PurchCrMemoHdr."Location Code") THEN;
        LocationCode := PurchCrMemoHdr."Location Code";
        EWBUser := rLocation.Username;
        EWBPass := rLocation.Password;
        EWBAPIKey := rLocation.apiaccesskey;

        CompanyInformation.GET;
        PurchCrMemoHdr.TESTFIELD("E-Way Bill No.1");
        PurchCrMemoHdr.TESTFIELD("Reason of Cancel");

        AddHeaderDetails;
        EObject.Add('ewbNo', PurchCrMemoHdr."E-Way Bill No.1");

        IF PurchCrMemoHdr."Reason of Cancel" = PurchCrMemoHdr."Reason of Cancel"::"Data Entry mistake" THEN
            EObject.Add('cancelRsnCode', '1')
        ELSE
            IF PurchCrMemoHdr."Reason of Cancel" = PurchCrMemoHdr."Reason of Cancel"::Duplicate THEN
                EObject.Add('cancelRsnCode', '2')
            ELSE
                IF PurchCrMemoHdr."Reason of Cancel" = PurchCrMemoHdr."Reason of Cancel"::"Order Cancelled" THEN
                    EObject.Add('cancelRsnCode', '3')
                ELSE
                    IF PurchCrMemoHdr."Reason of Cancel" = PurchCrMemoHdr."Reason of Cancel"::Others THEN
                        EObject.Add('cancelRsnCode', '4');
        EObject.Add('cancelRmrk', 'Cancelled the order');
        EwayArray.Add(EObject);
        Clear(EObject);
        EwayObject.Add('ewaybills', EwayArray);
        EwayObject.WriteTo(Body);
        // Message(Body);

        rLocation.GET(LocationCode);
        rLocation.TESTFIELD("E-InvGenerateURL");
        EinvoiceHttpContent.WriteFrom(Body);
        EinvoiceHttpContent.GetHeaders(EinvoiceHttpHeader);
        EinvoiceHttpHeader.Clear();
        EinvoiceHttpHeader.Add('accessToken', access_token);
        EinvoiceHttpHeader.Add('apiaccesskey', rLocation.apiaccesskey);
        EinvoiceHttpHeader.Add('Content-Type', 'application/json');
        EinvoiceHttpRequest.Content := EinvoiceHttpContent;
        EinvoiceHttpRequest.SetRequestUri('https://eapi.eyasp.com/ewbms/v1.0/cancel');
        EinvoiceHttpRequest.Method := 'POST';
        if EinvoiceHttpClient.Send(EinvoiceHttpRequest, EinvoiceHttpResponse) then begin
            EinvoiceHttpResponse.Content.ReadAs(ResultMessage);
            JResultObject.ReadFrom(ResultMessage);
            // Message(ResultMessage);
            if JResultObject.Get('data', JResultToken) then
                if JResultToken.IsObject then begin
                    JResultToken.WriteTo(OutputMessage);
                    JOutputObject.ReadFrom(OutputMessage);
                end;
            if JOutputObject.Get('error', JOutputToken) then
                if JOutputToken.IsArray then begin
                    JOutputToken.WriteTo(OutputMessage);
                    if OutputMessage = '[]' then begin
                        PurchCrMemoHdr2.GET(PurchCrMemoHdr."No.");
                        PurchCrMemoHdr2."E-Way Bill No.1" := '';//FORMAT(EWayBillNo);
                        PurchCrMemoHdr2."E-Way Bill Date1" := '';// EWayBillDateTime;
                        PurchCrMemoHdr2."E-Way Bill Validity" := '';//EWayExpiryDateTime;
                        PurchCrMemoHdr2."E-Way URL" := '';//
                        PurchCrMemoHdr2."E-Way Generated" := FALSE;//TRUE;
                        PurchCrMemoHdr2."E-Way Canceled" := TRUE;
                        PurchCrMemoHdr2."Reason of Cancel" := PurchCrMemoHdr2."Reason of Cancel"::" ";
                        PurchCrMemoHdr2.MODIFY;
                        MESSAGE('E-Way Bill Canceled');
                    END ELSE
                        Message(OutputMessage);
                end;
        end else
            Message(APIError);
    end;
}