codeunit 50058 "API Management -EY 2.6"
{
    // http://EinvSandbox.webtel.in/v1.01/PrintEInvByIRN

    Permissions = TableData "Sales Invoice Header" = rimd,
                  TableData "Sales Cr.Memo Header" = rimd;

    trigger OnRun()
    begin
        //Authenticate();
    end;

    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        TransferShipmentHeader: Record "Transfer Shipment Header";
        /*  StringBuilder: DotNet StringBuilder;
         StringWriter: DotNet StringWriter;
         JsonTextWriter: DotNet JsonTextWriter;
         JsonFormatting: DotNet Formatting; */
        GlobalNULL: Variant;
        IsInvoice: Boolean;
        IsTransferInvoice: Boolean;
        DocumentNo: Text[20];
        // Json: DotNet String;
        HttpWebRequestMgt: Codeunit "Http Web Request Mgt.";
        TmpBlob: Codeunit "Temp Blob";
        /*  RequestStr: DotNet Stream;
         StringReader: DotNet StringReader;
         JsonTextReader: DotNet JsonTextReader;
         ServicePointManager: DotNet ServicePointManager;
         SecurityProtocol: DotNet SecurityProtocolType;
         */
        MessageText: Text;
        UnRegCusrErr: Label 'E-Invoicing is not applicable for Unregistered Customer.';
        RecIsEmptyErr: Label 'Record variable uninitialized.';
        SalesLinesErr: Label 'E-Invoice allowes only 100 lines per Invoice. Curent transaction is having %1 lines.', Comment = '%1 = Sales Lines count';
        GSTNNo: Code[20];
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
        username: Text;
        Password: Text;
        client_id: Text;
        client_secret: Text;
        grant_type: Text;
        access_token: Text;
        GlbStcddes: Text;
        // HttpWebRequest21: DotNet HttpWebRequest;
        GbFinalinvoiceValue: Decimal;
        JSONManagement: Codeunit "JSON Management";
        FileManagement: Codeunit "File Management";
        LocationCode: Text;
        CurrExRate: Decimal;
        SubSuppType: Code[10];
        IsExport: Boolean;
        ShipToModel: Boolean;
        IsEWB: Boolean;
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";

    local procedure Initialize()
    begin
        /*  CLEAR(StringBuilder);
         CLEAR(JsonTextWriter);
         CLEAR(JsonTextReader);
         CLEAR(JsonFormatting);
         CLEAR(StringWriter);
         CLEAR(StringReader);
         CurrExRate := 1;
         StringBuilder := StringBuilder.StringBuilder;
         StringWriter := StringWriter.StringWriter(StringBuilder);
         JsonTextWriter := JsonTextWriter.JsonTextWriter(StringWriter);
         JsonTextWriter.Formatting := JsonFormatting.Indented;
  */
        CLEAR(GlobalNULL);
    end;

    local procedure WriteFileHeader()
    begin
        ReadCredentials(0);
    end;

    local procedure ReadTransDtls(GSTCustType: Option " ",Registered,Unregistered,Export,"Deemed Export",Exempted,"SEZ Development","SEZ Unit"; ShipToCode: Code[12])
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        catg: Text[6];
        Typ: Text[5];
        ECMGSTN: Text;
        ExpCat: Text;
        WithPay: Text;
        Customer: Record Customer;
    begin
        SubSuppType := 'TAX';
        IF IsInvoice THEN BEGIN
            catg := 'B2B';
            //catg = TypeofSupp
            IF GSTCustType IN [SalesInvoiceHeader."GST Customer Type"::Registered.AsInteger(), SalesInvoiceHeader."GST Customer Type"::Exempted.AsInteger()] THEN
                catg := 'B2B'
            ELSE BEGIN
                IF GSTCustType IN [SalesInvoiceHeader."GST Customer Type"::Export.AsInteger(), SalesInvoiceHeader."GST Customer Type"::"Deemed Export".AsInteger(), SalesInvoiceHeader."GST Customer Type"::"SEZ Unit".AsInteger(),
                    SalesInvoiceHeader."GST Customer Type"::"SEZ Development".AsInteger()]
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
            IF (GSTCustType IN [SalesInvoiceHeader."GST Customer Type"::Unregistered.AsInteger()]) AND (IsEWB) THEN
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
                IF GSTCustType IN [SalesCrMemoHeader."GST Customer Type"::Registered.AsInteger(), SalesCrMemoHeader."GST Customer Type"::Exempted.AsInteger()] THEN
                    catg := 'B2B'
                ELSE BEGIN
                    IF GSTCustType IN [SalesCrMemoHeader."GST Customer Type"::Export.AsInteger(), SalesCrMemoHeader."GST Customer Type"::"Deemed Export".AsInteger(), SalesCrMemoHeader."GST Customer Type"::"SEZ Unit".AsInteger(),
                      SalesCrMemoHeader."GST Customer Type"::"SEZ Development".AsInteger()]
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
        //JsonTextWriter.WritePropertyName('TPAPITRANDTLS');

        //JsonTextWriter.WriteStartObject();
        /*  JsonTextWriter.WritePropertyName('docCat');
         JsonTextWriter.WriteValue(Typ);

         JsonTextWriter.WritePropertyName('reverseCharge');
         JsonTextWriter.WriteValue(RegRev);

         JsonTextWriter.WritePropertyName('taxScheme');
         JsonTextWriter.WriteValue('GST'); */
        /*IF IsExport THEN BEGIN
          JsonTextWriter.WritePropertyName('subSupplyType');
          JsonTextWriter.WriteValue('EXP');
        END;*/
        /*JsonTextWriter.WritePropertyName('IgstOnIntra');
        JsonTextWriter.WriteValue(RegRev);
        
        JsonTextWriter.WritePropertyName('ecommerce_gstin');
        IF EcmGstin <> '' THEN
          JsonTextWriter.WriteValue(EcmGstin)
        ELSE
          JsonTextWriter.WriteValue('');*/
        //JsonTextWriter.WriteEndObject;

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

    local procedure WriteDocDtls(Typ: Text[3]; No: Text[16]; Dt: Text[10]; OrgInvNo: Text[16])
    begin
        //JsonTextWriter.WritePropertyName('TPAPIDOCDTLS');

        //JsonTextWriter.WriteStartObject();
        /*  JsonTextWriter.WritePropertyName('docType');
         JsonTextWriter.WriteValue(Typ);
         JsonTextWriter.WritePropertyName('docNo');
         JsonTextWriter.WriteValue(No);
         JsonTextWriter.WritePropertyName('docDate');
         JsonTextWriter.WriteValue(Dt); */

        /*JsonTextWriter.WritePropertyName('original_document_number');
        
        IF OrgInvNo<>'' THEN
          JsonTextWriter.WriteValue(OrgInvNo)
        ELSE
          JsonTextWriter.WriteValue('');*/


        //JsonTextWriter.WriteEndObject();

    end;

    local procedure ReadExpDtls()
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        //  GSTManagement: Codeunit "16401";
        ExpCat: Text[3];
        WithPay: Text[1];
        ShipBNo: Text[16];
        ShipBDt: Text[10];
        Port: Text[10];
        InvForCur: Decimal;
        ForCur: Text[3];
        CntCode: Text[2];
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
                        /*  IF GSTManagement.IsGSTApplicable(Structure) THEN
                              InvForCur := RoundGSTInvoicePrecision(InvForCur + SalesInvoiceLine.Amount)
                          ELSE
                              InvForCur := InvForCur + SalesInvoiceLine.Amount;*/ // 15578
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
                        /*   IF GSTManagement.IsGSTApplicable(Structure) THEN
                               InvForCur := InvForCur + SalesCrMemoLine.Amount
                           ELSE
                               InvForCur := InvForCur + SalesCrMemoLine.Amount;*/
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
        //JsonTextWriter.WritePropertyName('TpApiExpDtls');
        //JsonTextWriter.WriteStartObject;

        /*JsonTextWriter.WritePropertyName('export_category');
        IF ExpCat <> '' THEN
          JsonTextWriter.WriteValue(ExpCat)
        ELSE
          JsonTextWriter.WriteValue('');*/

        /* JsonTextWriter.WritePropertyName('shippingBillNo');
        IF ShipBNo <> '' THEN
            JsonTextWriter.WriteValue(ShipBNo)
        ELSE
            JsonTextWriter.WriteValue(GlobalNULL);

        JsonTextWriter.WritePropertyName('shippingBillDate');
        IF ShipBDt <> '' THEN
            JsonTextWriter.WriteValue(ShipBDt)
        ELSE
            JsonTextWriter.WriteValue(GlobalNULL);

        JsonTextWriter.WritePropertyName('countryCode');
        IF CntCode <> '' THEN
            JsonTextWriter.WriteValue(CntCode)
        ELSE
            JsonTextWriter.WriteValue(GlobalNULL);

        JsonTextWriter.WritePropertyName('foreignCurrency');
        IF ForCur <> '' THEN
            JsonTextWriter.WriteValue(ForCur)
        ELSE
            JsonTextWriter.WriteValue(GlobalNULL);

        JsonTextWriter.WritePropertyName('invValueFc');
        JsonTextWriter.WriteValue(InvForCur);

        JsonTextWriter.WritePropertyName('portCode');
        IF Port <> '' THEN
            JsonTextWriter.WriteValue(Port)
        ELSE
            JsonTextWriter.WriteValue(GlobalNULL);
 */
        /*JsonTextWriter.WritePropertyName('RefundClaim');
        IF WithPay <> '' THEN
          JsonTextWriter.WriteValue(WithPay)
        ELSE
          JsonTextWriter.WriteValue(GlobalNULL);*/

        //JsonTextWriter.WriteEndObject;

    end;

    local procedure ReadSellerDtls()
    var
        CompanyInformationBuff: Record "Company Information";
        LocationBuff: Record Location;
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
        //JsonTextWriter.WritePropertyName('TPAPISELLERDTLS');

        //JsonTextWriter.WriteStartObject();
        //Keshav04022021>>
        /*   JsonTextWriter.WritePropertyName('suppGstin');
          IF Gstin <> '' THEN
              JsonTextWriter.WriteValue(Gstin)
          ELSE
              JsonTextWriter.WriteValue(GlobalNULL);
          //Keshav04022021<<

          JsonTextWriter.WritePropertyName('supTradeName');
          IF TrdNm <> '' THEN
              JsonTextWriter.WriteValue(TrdNm)
          ELSE
              JsonTextWriter.WriteValue(GlobalNULL);

          JsonTextWriter.WritePropertyName('supLegalName');
          IF TrdNm <> '' THEN
              JsonTextWriter.WriteValue(TrdNm)
          ELSE
              JsonTextWriter.WriteValue(GlobalNULL);

          JsonTextWriter.WritePropertyName('supBuildingNo');
          IF TrdNm <> '' THEN
              JsonTextWriter.WriteValue(Bno)
          ELSE
              JsonTextWriter.WriteValue(GlobalNULL);

          JsonTextWriter.WritePropertyName('supBuildingName');
          IF TrdNm <> '' THEN
              JsonTextWriter.WriteValue(Bnm)
          ELSE
              JsonTextWriter.WriteValue(GlobalNULL);
   */
        /*JsonTextWriter.WritePropertyName('ADDRESS1');
        IF Bno <> '' THEN
          JsonTextWriter.WriteValue(Bno)
        ELSE
          JsonTextWriter.WriteValue(GlobalNULL);
        
        
        JsonTextWriter.WritePropertyName('ADDRESS2');
        IF Bnm <> '' THEN
          JsonTextWriter.WriteValue(Bnm)
        ELSE
          JsonTextWriter.WriteValue(GlobalNULL);*/

        /*   JsonTextWriter.WritePropertyName('supLocation');
          IF Loc <> '' THEN
              JsonTextWriter.WriteValue(Loc)
          ELSE
              JsonTextWriter.WriteValue(GlobalNULL);

          JsonTextWriter.WritePropertyName('supPincode');
          IF Pin <> 0 THEN
              JsonTextWriter.WriteValue(Pin)//Rohan
          ELSE
              JsonTextWriter.WriteValue(GlobalNULL);

          JsonTextWriter.WritePropertyName('supStateCode');
          IF Stcd <> '' THEN
              JsonTextWriter.WriteValue(Stcd) //rohan
          ELSE
              JsonTextWriter.WriteValue(GlobalNULL);

          JsonTextWriter.WritePropertyName('supPhone');
          IF Ph <> '' THEN BEGIN
              //IF ConverttexttoInteger(Ph)<>0 THEN
              JsonTextWriter.WriteValue(Ph)
          END
          ELSE
              JsonTextWriter.WriteValue(GlobalNULL);
          JsonTextWriter.WritePropertyName('supEmail');
          IF Em <> '' THEN
              JsonTextWriter.WriteValue(Em)
          ELSE
              JsonTextWriter.WriteValue(GlobalNULL);
   */
        //JsonTextWriter.WriteEndObject;

    end;

    local procedure ReadBuyerDtls()
    var
        Contact: Record Contact;
        LocationBuff: Record Location;
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        ShipToAddr: Record "Ship-to Address";
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
        Customer: Record Customer;
        Stcddes: Text;
        RecLocation: Record Location;
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
        //JsonTextWriter.WritePropertyName('TPAPIBUYERDTLS');

        //JsonTextWriter.WriteStartObject();
        /*  JsonTextWriter.WritePropertyName('custGstin');
         IF Gstin <> '' THEN
             //JsonTextWriter.WriteValue('06AAACB0652N007')//rohan
             JsonTextWriter.WriteValue(Gstin)//rohan
         ELSE
             JsonTextWriter.WriteValue(GlobalNULL);

         JsonTextWriter.WritePropertyName('custOrSupName');
         IF TrdNm <> '' THEN
             JsonTextWriter.WriteValue(TrdNm)
         ELSE
             JsonTextWriter.WriteValue(GlobalNULL);

         JsonTextWriter.WritePropertyName('custTradeName');
         IF TrdNm <> '' THEN
             JsonTextWriter.WriteValue(TrdNm)
         ELSE
             JsonTextWriter.WriteValue(GlobalNULL);


         JsonTextWriter.WritePropertyName('custOrSupAddr1');
         IF Bno <> '' THEN
             JsonTextWriter.WriteValue(Bno)
         ELSE
             JsonTextWriter.WriteValue(GlobalNULL);


         JsonTextWriter.WritePropertyName('custOrSupAddr2');
         IF Bnm <> '' THEN
             JsonTextWriter.WriteValue(Bnm)
         ELSE
             IF Bno <> '' THEN
                 JsonTextWriter.WriteValue(Bno);


         JsonTextWriter.WritePropertyName('custOrSupAddr4');
         IF Loc <> '' THEN
             JsonTextWriter.WriteValue(Loc)
         ELSE
             JsonTextWriter.WriteValue(GlobalNULL);

         JsonTextWriter.WritePropertyName('custPincode');

         IF Pin <> '' THEN BEGIN
             IF ConverttexttoInteger(Pin) <> 0 THEN
                 JsonTextWriter.WriteValue(ConverttexttoInteger(Pin)); //rohan
         END
         ELSE
             JsonTextWriter.WriteValue(GlobalNULL);

         JsonTextWriter.WritePropertyName('billToState');
         IF Stcd <> '' THEN BEGIN
             IF ConverttexttoInteger(Stcd) <> 0 THEN
                 JsonTextWriter.WriteValue(ConverttexttoInteger(Stcd));//rohan
         END
         ELSE
             JsonTextWriter.WriteValue(GlobalNULL);

         JsonTextWriter.WritePropertyName('pos');
         IF Stcd <> '' THEN BEGIN
             IF ConverttexttoInteger(Stcd) <> 0 THEN
                 JsonTextWriter.WriteValue(Stcd);//rohan
         END
         ELSE
             JsonTextWriter.WriteValue(GlobalNULL);

         JsonTextWriter.WritePropertyName('custPhone');
         IF Ph <> '' THEN BEGIN
             IF ConverttexttoInteger(Ph) <> 0 THEN
                 JsonTextWriter.WriteValue(ConverttexttoInteger(Ph))
             ELSE
                 JsonTextWriter.WriteValue(GlobalNULL);
         END
         ELSE
             JsonTextWriter.WriteValue(GlobalNULL);

         JsonTextWriter.WritePropertyName('custEmail');
         IF Em <> '' THEN
             JsonTextWriter.WriteValue(Em)
         ELSE
             JsonTextWriter.WriteValue(GlobalNULL);
  */
        //JsonTextWriter.WriteEndObject;
    end;

    local procedure ReadShipDtls()
    var
        ShipToAddr: Record "Ship-to Address";
        LocationBuff: Record Location;
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
        //JsonTextWriter.WritePropertyName('TpApiShipDtls');

        //JsonTextWriter.WriteStartObject();
        /* JsonTextWriter.WritePropertyName('shipToGstin');
        IF Gstin <> '' THEN
            JsonTextWriter.WriteValue(Gstin)//rohan
        ELSE
            JsonTextWriter.WriteValue(GlobalNULL);

        JsonTextWriter.WritePropertyName('shipToLegalName');
        IF TrdNm <> '' THEN
            JsonTextWriter.WriteValue(TrdNm)
        ELSE
            JsonTextWriter.WriteValue(GlobalNULL);

        JsonTextWriter.WritePropertyName('shipToTradeName');
        IF TrdNm <> '' THEN
            JsonTextWriter.WriteValue(TrdNm)
        ELSE
            JsonTextWriter.WriteValue(GlobalNULL);


        JsonTextWriter.WritePropertyName('shipToBuildingNo');
        IF Bno <> '' THEN
            JsonTextWriter.WriteValue(Bno)
        ELSE
            JsonTextWriter.WriteValue(GlobalNULL);


        JsonTextWriter.WritePropertyName('shipToBuildingName');
        IF Bnm <> '' THEN
            JsonTextWriter.WriteValue(Bnm)
        ELSE
            JsonTextWriter.WriteValue(GlobalNULL);

        JsonTextWriter.WritePropertyName('shipToLocation');
        IF Loc <> '' THEN
            JsonTextWriter.WriteValue(Loc)
        ELSE
            JsonTextWriter.WriteValue(GlobalNULL);

        JsonTextWriter.WritePropertyName('shipToPincode');
        IF Pin <> '' THEN
            JsonTextWriter.WriteValue(Pin)
        ELSE
            JsonTextWriter.WriteValue(GlobalNULL);

        JsonTextWriter.WritePropertyName('shipToState');
        IF Stcd <> '' THEN
            JsonTextWriter.WriteValue(Stcd)//rohan
        ELSE
            JsonTextWriter.WriteValue(GlobalNULL);
 */
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
        //JsonTextWriter.WritePropertyName('TPAPIVALDTLS');

        //JsonTextWriter.WriteStartObject();

        /*  JsonTextWriter.WritePropertyName('invAssessableAmt');
         IF NOT IsExport THEN
             JsonTextWriter.WriteValue(Assval)
         ELSE
             JsonTextWriter.WriteValue(TotInvVal);

         JsonTextWriter.WritePropertyName('invCgstAmt');
         JsonTextWriter.WriteValue(CgstVal);

         JsonTextWriter.WritePropertyName('invSgstAmt');
         JsonTextWriter.WriteValue(SgstVAl);

         JsonTextWriter.WritePropertyName('invIgstAmt');
         JsonTextWriter.WriteValue(IgstVal);

         JsonTextWriter.WritePropertyName('invCessAdvaloremAmt');
         JsonTextWriter.WriteValue(CesVal);

         JsonTextWriter.WritePropertyName('invStateCessSpecificAmt');
         JsonTextWriter.WriteValue(CesNonAdVal);

         ReportCheck.InitTextVariable();
         ReportCheck.FormatNoText(AmtinWord, TotInvVal, '');
         JsonTextWriter.WritePropertyName('totalInvValueInWords');
         JsonTextWriter.WriteValue(AmtinWord[1]);//rohan

         JsonTextWriter.WritePropertyName('invStateCessAmt');
         JsonTextWriter.WriteValue(StCesVal);

         JsonTextWriter.WritePropertyName('RoundOff');
         JsonTextWriter.WriteValue(RndOffAmt);

         JsonTextWriter.WritePropertyName('invOtherCharges');
         JsonTextWriter.WriteValue(OthChrg + TCSAmt);
  */
        //JsonTextWriter.WriteEndObject();
    end;

    local procedure ReadItemList()
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        TransferShipmentLine: Record "Transfer Shipment Line";
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
    begin
        IF IsInvoice THEN BEGIN
            SalesInvoiceLine.SETRANGE("Document No.", DocumentNo);
            SalesInvoiceLine.SETFILTER("No.", '<>%1', '');
            SalesInvoiceLine.SETFILTER("System-Created Entry", '%1', FALSE);
            SalesInvoiceLine.SETFILTER(Quantity, '<>%1', 0);
            IF SalesInvoiceLine.FINDSET THEN BEGIN
                IF SalesInvoiceLine.COUNT > 1000 THEN
                    ERROR(SalesLinesErr, SalesInvoiceLine.COUNT);

                /* JsonTextWriter.WritePropertyName('lineItems');
                JsonTextWriter.WriteStartArray(); */

                REPEAT
                    IF SalesInvoiceLine."GST Assessable Value (LCY)" <> 0 THEN
                        AssAmt := SalesInvoiceLine."GST Assessable Value (LCY)"
                    ELSE
                        // 15578  AssAmt := SalesInvoiceLine."GST Base Amount";
                        /*   IF SalesInvoiceLine."Free Supply" THEN
                               FreeQty := SalesInvoiceLine.Quantity
                           ELSE
                               FreeQty := 0;
                           ItmNo := FORMAT(SalesInvoiceLine."Line No.");*/ // 15578


                        /*    IF SalesInvoiceLine."Charges To Customer" <> 0 THEN BEGIN
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
                            END;*/ // 15778


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
                /*
                                    WriteItem(ItmNo,
                                      SalesInvoiceLine.Description + SalesInvoiceLine."Description 2", (SalesInvoiceLine."GST Group Type" = SalesInvoiceLine."GST Group Type"::Service),
                                      SalesInvoiceLine."HSN/SAC Code", '',
                                      SalesInvoiceLine.Quantity, FreeQty,
                                      COPYSTR(GetUOM(SalesInvoiceLine."Unit of Measure Code"), 1, 3),
                                      SalesInvoiceLine."Unit Price",
                                      SalesInvoiceLine."Line Amount" + SalesInvoiceLine."Line Discount Amount" + NotChargeAmt,
                                      DiscAmt, OtherChrAmt,
                                      AssAmt, GstRt, CgstAmt, SgstAmt, IgstAmt, CesRt, CesAmt, CesNonAdvalAmt, StateCesRt, StateCesAmt, StateCesNonAdvalAmt,
                                      // 15578     SalesInvoiceLine."Amount Including Tax" + SalesInvoiceLine."Total GST Amount" + SalesInvoiceLine."Charges To Customer",
                                      SalesInvoiceLine."Line No.");
                                      */
                UNTIL SalesInvoiceLine.NEXT = 0;

                // JsonTextWriter.WriteEndArray();
            END;
        END ELSE
            IF IsTransferInvoice THEN BEGIN
                TransferShipmentLine.SETRANGE("Document No.", DocumentNo);
                TransferShipmentLine.SETFILTER(Quantity, '<>%1', 0);
                IF TransferShipmentLine.FINDFIRST THEN BEGIN
                    IF TransferShipmentLine.COUNT > 1000 THEN
                        ERROR(SalesLinesErr, TransferShipmentLine.COUNT);

                    // JsonTextWriter.WritePropertyName('lineItems');
                    // JsonTextWriter.WriteStartArray();

                    REPEAT
                        // ItmNo:=TransferShipmentLine."Item No.";
                        ItmNo := FORMAT(TransferShipmentLine."Line No.");
                        IF TransferShipmentLine."GST Assessable Value" <> 0 THEN
                            AssAmt := TransferShipmentLine."GST Assessable Value"
                        ELSE
                            // 15578    AssAmt := TransferShipmentLine."GST Base Amount";

                            GetGSTCompRate(TransferShipmentLine."Document No.", TransferShipmentLine."Line No.", GstRt,
                          CgstAmt, SgstAmt, IgstAmt, CesRt, CesAmt, CesNonAdvalAmt, StateCesRt, StateCesAmt, StateCesNonAdvalAmt);
                    /*
                     WriteItem(ItmNo,
                       TransferShipmentLine.Description + TransferShipmentLine."Description 2", FALSE,
                       TransferShipmentLine."HSN/SAC Code", '',
                       TransferShipmentLine.Quantity, FreeQty,
                       COPYSTR(GetUOM(TransferShipmentLine."Unit of Measure Code"), 1, 3),
                       TransferShipmentLine."Unit Price",
                       TransferShipmentLine.Quantity * TransferShipmentLine."Unit Price",
                       0, 0,
                        AssAmt, GstRt, CgstAmt, SgstAmt, IgstAmt, CesRt, CesAmt, CesNonAdvalAmt, StateCesRt, StateCesAmt, StateCesNonAdvalAmt,
                       // 15578      TransferShipmentLine.Amount + TransferShipmentLine."Total GST Amount",
                       TransferShipmentLine."Line No.");
                       */

                    UNTIL TransferShipmentLine.NEXT = 0;
                    // JsonTextWriter.WriteEndArray();
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

                    // JsonTextWriter.WritePropertyName('lineItems');
                    // JsonTextWriter.WriteStartArray();
                    REPEAT
                        /*   IF SalesCrMemoLine."GST Assessable Value (LCY)" <> 0 THEN
                               AssAmt := SalesCrMemoLine."GST Assessable Value (LCY)"
                           ELSE
                               AssAmt := SalesCrMemoLine."GST Base Amount";
                           IF SalesCrMemoLine."Free Supply" THEN
                               FreeQty := SalesCrMemoLine.Quantity
                           ELSE
                               FreeQty := 0;
                           ItmNo := SalesCrMemoLine."No.";

                           IF SalesCrMemoLine."Charges To Customer" <> 0 THEN BEGIN
                               IF (SalesCrMemoLine."GST Base Amount" = (SalesCrMemoLine.Amount + SalesCrMemoLine."Charges To Customer")) THEN
                                   NotChargeAmt := SalesCrMemoLine."Charges To Customer"
                               ELSE
                                   IF (SalesCrMemoLine."GST Base Amount" = (SalesCrMemoLine.Amount + SalesCrMemoLine."Charges To Customer" + (SalesCrMemoLine."GST Base Amount" - SalesCrMemoLine.Amount - SalesCrMemoLine."Charges To Customer"))) THEN
                                       NotChargeAmt := SalesCrMemoLine."Charges To Customer" + (SalesCrMemoLine."GST Base Amount" - SalesCrMemoLine.Amount - SalesCrMemoLine."Charges To Customer")
                                   ELSE
                                       NotChargeAmt := 0;
                           END;*/ // 15578
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
                    /*
                    WriteItem(ItmNo,
                      SalesCrMemoLine.Description + SalesCrMemoLine."Description 2", (SalesCrMemoLine."GST Group Type" = SalesCrMemoLine."GST Group Type"::Service),
                      SalesCrMemoLine."HSN/SAC Code", '',
                      SalesCrMemoLine.Quantity, FreeQty,
                      COPYSTR(GetUOM(SalesCrMemoLine."Unit of Measure Code"), 1, 3),
                      SalesCrMemoLine."Unit Price",
                      SalesCrMemoLine."Line Amount" + SalesCrMemoLine."Line Discount Amount" + NotChargeAmt,
                      DiscAmt, OtherChrAmt,
                      AssAmt, GstRt, CgstAmt, SgstAmt, IgstAmt, CesRt, CesAmt, CesNonAdvalAmt, StateCesRt, StateCesAmt, StateCesNonAdvalAmt,
                      // 15578     SalesCrMemoLine."Amount Including Tax" + SalesCrMemoLine."Total GST Amount" + SalesCrMemoLine."Charges To Customer",
                      SalesCrMemoLine."Line No.");
                      */
                    UNTIL SalesCrMemoLine.NEXT = 0;
                    // JsonTextWriter.WriteEndArray();
                END;
            END;
    end;

    local procedure WriteItem(ItmNo: Code[20]; PrdNm: Text[100]; IsService: Boolean; HsnCd: Text[8]; Barcde: Text[30]; Qty: Decimal; FreeQty: Decimal; Unit: Text[3]; UnitPrice: Decimal; TotAmt: Decimal; Discount: Decimal; OthChrg: Decimal; AssAmt: Decimal; GstRt: Decimal; CgstAmt: Decimal; SgstAmt: Decimal; IgstAmt: Decimal; CesRt: Decimal; CesAmt: Decimal; CesNonAdvalAmt: Decimal; StateCesRt: Decimal; StateCesAmt: Decimal; StateCesNonAdvalAmt: Decimal; TotItemVal: Decimal; SILineNo: Integer)
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ValueEntryRelation: Record "Value Entry Relation";
        ItemTrackingManagement: Codeunit "Item Tracking Management";
        InvoiceRowID: Text[250];
    begin
        SerialNo += 1;
        // JsonTextWriter.WriteStartObject;

        /*IF NOT IsExport THEN
          SubSuppType := 'TAX';
        IF SubSuppType = '' THEN
          SubSuppType := 'TAX';*/
        /*  JsonTextWriter.WritePropertyName('supplyType');
         IF ItmNo <> '' THEN
             JsonTextWriter.WriteValue(SubSuppType)
         ELSE
             JsonTextWriter.WriteValue(GlobalNULL);

         JsonTextWriter.WritePropertyName('itemNo');
         IF ItmNo <> '' THEN
             JsonTextWriter.WriteValue(SerialNo)
         ELSE
             JsonTextWriter.WriteValue(GlobalNULL);

         JsonTextWriter.WritePropertyName('productName');
         IF PrdNm <> '' THEN
             JsonTextWriter.WriteValue(PrdNm)
         ELSE
             JsonTextWriter.WriteValue(GlobalNULL);

         JsonTextWriter.WritePropertyName('isService');
         IF IsService THEN
             JsonTextWriter.WriteValue('Y')
         ELSE
             JsonTextWriter.WriteValue('N');

         JsonTextWriter.WritePropertyName('hsnsacCode');
         IF HsnCd <> '' THEN
             JsonTextWriter.WriteValue(HsnCd)
         ELSE
             JsonTextWriter.WriteValue(GlobalNULL);

         IF Barcde <> '' THEN
             JsonTextWriter.WritePropertyName('Barcode');
         IF Barcde <> '' THEN
             JsonTextWriter.WriteValue(Barcde);

         JsonTextWriter.WritePropertyName('itemQty');
         JsonTextWriter.WriteValue(Qty);

         JsonTextWriter.WritePropertyName('freeQuantity');
         JsonTextWriter.WriteValue(FreeQty);

         JsonTextWriter.WritePropertyName('itemUqc');
         IF Unit <> '' THEN
             JsonTextWriter.WriteValue(Unit)
         ELSE
             JsonTextWriter.WriteValue(GlobalNULL);

         JsonTextWriter.WritePropertyName('unitPrice');
         JsonTextWriter.WriteValue(ROUND(UnitPrice * CurrExRate, 0.01, '='));

         IF Discount > 0 THEN BEGIN
             JsonTextWriter.WritePropertyName('itemAmt');
             JsonTextWriter.WriteValue(ROUND(TotAmt * CurrExRate, 0.01, '='));

             JsonTextWriter.WritePropertyName('itemDiscount');
             JsonTextWriter.WriteValue(ABS(Discount));
         END
         ELSE BEGIN
             JsonTextWriter.WritePropertyName('itemAmt');
             JsonTextWriter.WriteValue(ROUND((TotAmt * CurrExRate) + ABS(Discount), 0.01, '='));

             JsonTextWriter.WritePropertyName('itemDiscount');
             JsonTextWriter.WriteValue(ABS(0));
         END;
         JsonTextWriter.WritePropertyName('otherValues');
         JsonTextWriter.WriteValue(ABS(OthChrg * CurrExRate));

         JsonTextWriter.WritePropertyName('taxableVal');
         IF NOT IsExport THEN
             JsonTextWriter.WriteValue(AssAmt * CurrExRate)
         ELSE
             JsonTextWriter.WriteValue(ROUND(TotItemVal * CurrExRate, 0.01, '='));

         IF (CgstAmt <> 0) AND (SgstAmt <> 0) THEN BEGIN
             JsonTextWriter.WritePropertyName('cgstRt');
             JsonTextWriter.WriteValue(GstRt / 2);
             JsonTextWriter.WritePropertyName('sgstRt');
             JsonTextWriter.WriteValue(GstRt / 2);
         END
         ELSE BEGIN
             JsonTextWriter.WritePropertyName('cgstRt');
             JsonTextWriter.WriteValue(GlobalNULL);
             JsonTextWriter.WritePropertyName('sgstRt');
             JsonTextWriter.WriteValue(GlobalNULL);
         END;

         IF (IgstAmt <> 0) THEN BEGIN
             JsonTextWriter.WritePropertyName('igstRt');
             JsonTextWriter.WriteValue(GstRt);
         END
         ELSE BEGIN
             JsonTextWriter.WritePropertyName('igstRt');
             JsonTextWriter.WriteValue(GlobalNULL);
         END;
         JsonTextWriter.WritePropertyName('cgstAmt');
         JsonTextWriter.WriteValue(CgstAmt);
         JsonTextWriter.WritePropertyName('sgstAmt');
         JsonTextWriter.WriteValue(SgstAmt);
         JsonTextWriter.WritePropertyName('igstAmt');
         JsonTextWriter.WriteValue(IgstAmt);

         JsonTextWriter.WritePropertyName('cessRtAdvalorem');
         JsonTextWriter.WriteValue(CesRt);

         JsonTextWriter.WritePropertyName('cessAmtAdvalorem');
         JsonTextWriter.WriteValue(CesAmt);

         //JsonTextWriter.WritePropertyName('CESNONADVALAMT');
         //JsonTextWriter.WriteValue(CesNonAdvalAmt);

         JsonTextWriter.WritePropertyName('stateCessRt');
         JsonTextWriter.WriteValue(StateCesRt);

         JsonTextWriter.WritePropertyName('stateCessAmt');
         JsonTextWriter.WriteValue(StateCesAmt);

         //JsonTextWriter.WritePropertyName('StateCesNonAdvlAmt');
         //JsonTextWriter.WriteValue(StateCesNonAdvalAmt);

         JsonTextWriter.WritePropertyName('totalItemAmt');
         JsonTextWriter.WriteValue(TotItemVal * CurrExRate);
         JsonTextWriter.WritePropertyName('lineItemAmt');
         JsonTextWriter.WriteValue(GbFinalinvoiceValue);
         */ /*
         IF IsInvoice THEN
           InvoiceRowID := ItemTrackingManagement.ComposeRowID(DATABASE::"Sales Invoice Line",0,DocumentNo,'',0,SILineNo)
         ELSE
           InvoiceRowID := ItemTrackingManagement.ComposeRowID(DATABASE::"Sales Cr.Memo Line",0,DocumentNo,'',0,SILineNo);
         ValueEntryRelation.SETCURRENTKEY("Source RowId");
         ValueEntryRelation.SETRANGE("Source RowId",InvoiceRowID);
         IF ValueEntryRelation.FINDSET THEN BEGIN
           JsonTextWriter.WritePropertyName('TpApiBchDtls');
           JsonTextWriter.WriteStartObject;
           REPEAT
             ValueEntry.GET(ValueEntryRelation."Value Entry No.");
             ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.");
             WriteBchDtls(
               COPYSTR(ItemLedgerEntry."Lot No." + ItemLedgerEntry."Serial No.",1,20),
               FORMAT(ItemLedgerEntry."Expiration Date",0,'<Year4>-<Month,2>-<Day,2>'),
               FORMAT(ItemLedgerEntry."Warranty Date",0,'<Year4>-<Month,2>-<Day,2>'));
           UNTIL ValueEntryRelation.NEXT = 0;
           JsonTextWriter.WriteEndObject;
         END;
         */
            // JsonTextWriter.WriteEndObject();

    end;

    local procedure WriteBchDtls(Nm: Text[20]; ExpDt: Text[10]; WrDt: Text[10])
    begin
        /*     JsonTextWriter.WritePropertyName('batchNameOrNo');
            IF Nm <> '' THEN
                JsonTextWriter.WriteValue(Nm)
            ELSE
                JsonTextWriter.WriteValue(GlobalNULL);
            JsonTextWriter.WritePropertyName('batchExpiryDate');
            IF ExpDt <> '' THEN
                JsonTextWriter.WriteValue(ExpDt)
            ELSE
                JsonTextWriter.WriteValue(GlobalNULL);
            JsonTextWriter.WritePropertyName('warrantyDate');
            IF WrDt <> '' THEN
                JsonTextWriter.WriteValue(WrDt)
            ELSE
                JsonTextWriter.WriteValue(GlobalNULL); */
    end;

    local procedure ExportAsJson(FileName: Text[20])
    var
        TempFile: File;
        ToFile: Variant;
        NewStream: InStream;
    begin
        /*   TempFile.CREATETEMPFILE;
          // 15578 TempFile.WRITE(StringBuilder.ToString);
          TempFile.CREATEINSTREAM(NewStream);
          ToFile := FileName + '.json';
          DOWNLOADFROMSTREAM(NewStream, 'e-Invoice', '', 'JSON files|*.json|All files (*.*)|*.*', ToFile);
          TempFile.CLOSE; */
    end;


    procedure SetTransferShipHeader(TransShipmentHeaderBuff: Record "Transfer Shipment Header")
    begin
        TransferShipmentHeader := TransShipmentHeaderBuff;
        IsTransferInvoice := TRUE;
        IsEWB := FALSE;
        LocationCode := TransShipmentHeaderBuff."Transfer-from Code";
    end;


    procedure SetSalesInvHeader(SalesInvoiceHeaderBuff: Record "Sales Invoice Header")
    begin
        SalesInvoiceHeader := SalesInvoiceHeaderBuff;
        IsInvoice := TRUE;
        IsEWB := FALSE;
        LocationCode := SalesInvoiceHeaderBuff."Location Code";
    end;


    procedure SetCrMemoHeader(SalesCrMemoHeaderBuff: Record "Sales Cr.Memo Header")
    begin
        SalesCrMemoHeader := SalesCrMemoHeaderBuff;
        IsInvoice := FALSE;
        LocationCode := SalesCrMemoHeaderBuff."Location Code";
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

    local procedure GetGSTCompRate(DocNo: Code[20]; LineNo: Integer; var GstRt: Decimal; var CgstAmt: Decimal; var SgstAmt: Decimal; var IgstAmt: Decimal; var CesRt: Decimal; var CesAmt: Decimal; var CesNonAdvalAmt: Decimal; var StateCesRt: Decimal; var StateCesAmt: Decimal; var StateCesNonAdvalAmt: Decimal)
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    // GSTComponent: Record "16405";
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
                    // IF GSTComponent.GET(DetailedGSTLedgerEntry."GST Component Code") THEN 
                    IF DetailedGSTLedgerEntry."GST %" > 0 THEN BEGIN
                        StateCesRt := DetailedGSTLedgerEntry."GST %";
                        StateCesAmt := ABS(DetailedGSTLedgerEntry."GST Amount");
                    END
                    ELSE
                        StateCesNonAdvalAmt := ABS(DetailedGSTLedgerEntry."GST Amount");


            //IF GSTComponent."Exclude from Reports" THEN Rohan
            UNTIL DetailedGSTLedgerEntry.NEXT = 0;
    end;

    local procedure GetGSTVal(var AssVal: Decimal; var CgstVal: Decimal; var SgstVal: Decimal; var IgstVal: Decimal; var CesVal: Decimal; var StCesVal: Decimal; var CesNonAdval: Decimal; var Disc: Decimal; var OthChrg: Decimal; var TotInvVal: Decimal; var TCSAmt: Decimal; var RndOffAmt: Decimal)
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        GSTLedgerEntry: Record "GST Ledger Entry";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CurrExchRate: Record "Currency Exchange Rate";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        //   GSTComponent: Record "16405";
        TotGSTAmt: Decimal;
        TransferShipmentLine: Record "Transfer Shipment Line";
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

        GSTLedgerEntry.SETFILTER("GST Component Code", '<>CGST&<>SGST&<>IGST&<>CESS&<>INTERCESS');
        IF GSTLedgerEntry.FINDSET THEN BEGIN
            REPEAT
            /*  IF GSTComponent.GET(GSTLedgerEntry."GST Component Code") THEN
                  IF GSTComponent."Exclude from Reports" THEN
                      StCesVal += ABS(GSTLedgerEntry."GST Amount");*/ // 15578
            UNTIL GSTLedgerEntry.NEXT = 0;
        END;

        IF IsInvoice THEN BEGIN
            SalesInvoiceLine.SETRANGE("Document No.", DocumentNo);
            SalesInvoiceLine.SETFILTER(Quantity, '<>%1', 0);
            SalesInvoiceLine.SETFILTER("No.", '<>%1', '');
            IF SalesInvoiceLine.FINDSET THEN BEGIN
                /*  REPEAT
                      IF SalesInvoiceLine."GST Assessable Value (LCY)" <> 0 THEN
                          AssVal += SalesInvoiceLine."GST Assessable Value (LCY)"
                      ELSE
                         AssVal += SalesInvoiceLine."GST Base Amount";
                      TotGSTAmt += SalesInvoiceLine."Total GST Amount";
                      Disc += SalesInvoiceLine."Inv. Discount Amount";
                      IF SalesInvoiceLine."No." = '51157000' THEN
                          RndOffAmt += SalesInvoiceLine.Amount;
                      TCSAmt += SalesInvoiceLine."Total TDS/TCS Incl. SHE CESS";

                      IF (SalesInvoiceLine."GST Base Amount" = (SalesInvoiceLine.Amount + SalesInvoiceLine."Charges To Customer" + (SalesInvoiceLine."GST Base Amount" - SalesInvoiceLine.Amount - SalesInvoiceLine."Charges To Customer"))) THEN
                          OthChrg += (-SalesInvoiceLine."GST Base Amount" + SalesInvoiceLine.Amount + SalesInvoiceLine."Charges To Customer")
                      ELSE
                          IF SalesInvoiceLine."GST Base Amount" <> SalesInvoiceLine.Amount + SalesInvoiceLine."Charges To Customer" THEN
                              OthChrg += SalesInvoiceLine."Charges To Customer"
                          ELSE
                              OthChrg += 0;
                  UNTIL SalesInvoiceLine.NEXT = 0;*/ // 15578
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
                        AssVal += TransferShipmentLine.Amount;
                        // 15578    TotGSTAmt += TransferShipmentLine."Total GST Amount";
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
                    /*    AssVal += SalesCrMemoLine."GST Base Amount";
                        TotGSTAmt += SalesCrMemoLine."Total GST Amount";
                        Disc += SalesCrMemoLine."Inv. Discount Amount";
                        TCSAmt += SalesCrMemoLine."Total TDS/TCS Incl SHE CESS";*/ // 15578
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
                // 15578   TotInvVal += TransferShipmentLine.Amount + TransferShipmentLine."Total GST Amount";
                UNTIL TransferShipmentLine.NEXT = 0;
            GbFinalinvoiceValue := TotInvVal
        END;

        OthChrg := 0;
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
        RecLocation: Record Location;
    begin
        IF LocationCode = '' THEN
            ERROR('Location Code cannot be blank');
        RecLocation.GET(LocationCode);
        RecLocation.TESTFIELD("GST Registration No.");
        /* JsonTextWriter.WritePropertyName('suppGstin');
        //JsonTextWriter.WriteValue('29AAACO0305P1ZD');//RecLocation."GST Registration No."
        JsonTextWriter.WriteValue(RecLocation."GST Registration No.");
        IF RequestType = RequestType::CreateRequest THEN BEGIN
            JsonTextWriter.WritePropertyName('VERSION');
            JsonTextWriter.WriteValue(VERSION); */
        // END;
    end;

    local procedure RemoveSpecialChar(TxtDoc: Text): Text
    begin
        EXIT(DELCHR(TxtDoc, '=', './,-\!@#$%^&*()+ '));
    end;

    local procedure ConverttexttoInteger(text: Text) inttext: BigInteger
    begin
        EVALUATE(inttext, text);
    end;

    local procedure GetJason()
    begin
        // Json := StringBuilder.ToString;
    end;

    local procedure GetClientFile(): Text
    var
    // [RunOnClient]
    // ClientAppFile: DotNet Path;
    begin
        //EXIT(ClientAppFile.GetTempPath);
        EXIT('C:\\WebRequest');
    end;



    local procedure GetJsonNodeValue(NodeId: Text[30]): Text
    var
        DataExch: Record "Data Exch. Field";
    begin
        CLEAR(MessageText);
        DataExch.RESET;
        DataExch.SETRANGE("Node ID", NodeId);
        IF DataExch.FINDFIRST THEN
            MessageText := DataExch.Value;
        EXIT(MessageText);
    end;


    procedure GetIRNNo()
    var
        FL: File;
        ResponseInStream_L: InStream;
        /*    HttpStatusCode_L: DotNet HttpStatusCode;
           ResponseHeaders_L: DotNet NameValueCollection;
         */
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        DataExch: Record "Data Exch. Field";
        IRNNo: Text[30];
        EWayBillDateTime: Variant;
        EWayExpiryDateTime: Variant;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        TempBlob: codeunit "Temp Blob";
        BText: BigText;
        InStream: InStream;
        OutStream1: OutStream;
        OutStream2: OutStream;
        QRTempBlob: Codeunit "Temp Blob";
        rSalInvHdr: Record "Sales Invoice Header";
        rSalCrMemoHdr: Record "Sales Cr.Memo Header";
        rTrfShpHdr: Record "Transfer Shipment Header";
        rLocation: Record Location;
    begin
        GetJason;
        /*   IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
              ERASE(GetClientFile + 'J.txt');
          FL.CREATE(GetClientFile + 'J.txt');
          FL.CREATEOUTSTREAM(OutStrm);
          OutStrm.WRITETEXT('{');
          OutStrm.WRITETEXT(FORMAT(Json));
          OutStrm.WRITETEXT('}');
          MESSAGE('%1', FORMAT(Json));
          FL.CLOSE;
          //IF SalesInvoiceHeader."No." = 'SIGM/2021/004488' THEN ERROR('');
          //HYPERLINK(GetClientFile + 'J.txt');
          ServicePointManager.SecurityProtocol(SecurityProtocol.Tls12); // new line
         */  //Keshav30Sep2020
             /*
             IF IsInvoice THEN BEGIN
               rSalInvHdr.RESET;
               rSalInvHdr.SETRANGE("No.",DocumentNo);
               IF rSalInvHdr.FIND('-') THEN;
               rLocation.GET(rSalInvHdr."Location Code");
             END ELSE IF IsTransferInvoice THEN BEGIN
               rTrfShpHdr.RESET;
               rTrfShpHdr.SETRANGE("No.",DocumentNo);
               IF rTrfShpHdr.FIND('-') THEN;
               rLocation.GET(rTrfShpHdr."Transfer-from Code");
             END ELSE BEGIN
               rSalCrMemoHdr.RESET;
               rSalCrMemoHdr.SETRANGE("No.",DocumentNo);
               IF rSalCrMemoHdr.FIND('-') THEN;
               rLocation.GET(rSalCrMemoHdr."Location Code");
             END;
             */
        rLocation.GET(LocationCode);
        rLocation.TESTFIELD("E-InvGenerateURL");
        // HttpWebRequestMgt.Initialize(rLocation."E-InvGenerateURL");
        // HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/einvoiceapi/v2.0/generateIRN');
        //Keshav30Sep2020
        HttpWebRequestMgt.DisableUI;
        /* HttpWebRequestMgt.SetMethod('POST');
        HttpWebRequestMgt.SetReturnType('application/json');
        //HttpWebRequestMgt.SetContentType('application/json');

        HttpWebRequestMgt.AddHeader('accessToken', access_token);
        HttpWebRequestMgt.AddHeader('Content-Type', 'application/json');
        //HttpWebRequestMgt.AddHeader('apiaccesskey','l7xx1f28e29b18a64623aef38dcf4f9b1ac3');
        HttpWebRequestMgt.AddHeader('apiaccesskey', rLocation.apiaccesskey);
        HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');


        //   TmpBlob.INIT;
        // 15578   TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
        IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
            ResponseInStream_L.READ(ResponseText);
            Json := ResponseText;
            //MESSAGE(ResponseText);
            ReadJSon(Json, DataExch);
            //Added
            IF (ResponseText = '') OR (ResponseText = '[]') THEN
                EXIT;
            CLEAR(JSONManagement);
            JSONManagement.InitializeObject(ResponseText);
            //Added

        END
        ELSE
            ERROR('Network Issue, Please try again');

        */
        IF GetJsonNodeValue('status') = '1' THEN BEGIN
            //IF GetJsonNodeValue('results.message.alert')<>'' THEN
            //  MESSAGE(GetJsonNodeValue('results.message.alert'))
            //ELSE BEGIN
            IF IsInvoice THEN BEGIN
                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETRANGE("No.", DocumentNo);
                IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                    SalesInvoiceHeader."IRN Hash" := JSONManagement.GetValue('Irn');

                    SalesInvoiceHeader."Acknowledgement No." := GetJsonNodeValue('AckNo');
                    // 15578   SalesInvoiceHeader."Acknowledgement Date" := GetJsonNodeValue('AckDt');

                    CLEAR(QRTempBlob);
                    // 15578   QRTempBlob.CALCFIELDS(Blob);
                    GenrateQRCode(JSONManagement.GetValue('SignedQRCode'), QRTempBlob);

                    // 15578    SalesInvoiceHeader."QR Code" := QRTempBlob.Blob;
                    SalesInvoiceHeader.MODIFY;
                END;
            END ELSE
                IF IsTransferInvoice THEN BEGIN
                    TransferShipmentHeader.RESET;
                    TransferShipmentHeader.SETRANGE("No.", DocumentNo);
                    IF TransferShipmentHeader.FINDFIRST THEN BEGIN
                        TransferShipmentHeader."IRN Hash" := JSONManagement.GetValue('Irn');
                        TransferShipmentHeader."Acknowledgement No." := GetJsonNodeValue('AckNo');
                        TransferShipmentHeader."Acknowledgement Date" := GetJsonNodeValue('AckDt');

                        CLEAR(QRTempBlob);
                        // 15578    QRTempBlob.CALCFIELDS(Blob);
                        GenrateQRCode(JSONManagement.GetValue('SignedQRCode'), QRTempBlob);

                        // 15578   TransferShipmentHeader."QR Code" := QRTempBlob.Blob;
                        TransferShipmentHeader.MODIFY;
                    END;

                END ELSE BEGIN
                    SalesCrMemoHeader.RESET;
                    SalesCrMemoHeader.SETRANGE("No.", DocumentNo);
                    IF SalesCrMemoHeader.FINDFIRST THEN BEGIN
                        SalesCrMemoHeader."IRN Hash" := JSONManagement.GetValue('Irn');
                        SalesCrMemoHeader."Acknowledgement No." := GetJsonNodeValue('AckNo');
                        // 15578   SalesCrMemoHeader."Acknowledgement Date" := GetJsonNodeValue('AckDt');

                        CLEAR(QRTempBlob);
                        // 15578    QRTempBlob.CALCFIELDS(Blob);
                        GenrateQRCode(JSONManagement.GetValue('SignedQRCode'), QRTempBlob);
                        // 15578    SalesCrMemoHeader."QR Code" := QRTempBlob.Blob;
                        SalesCrMemoHeader.MODIFY;
                    END;
                END;
            MESSAGE('IRN Updated')
            // END;
        END ELSE BEGIN
            ERROR(GetJsonNodeValue('errorDetails..errorDesc'));
        END;

    end;

    local procedure GenerateCancelRequest(IRNNo: Text)
    begin
        //IF ISNULL(StringBuilder) THEN
        Initialize;
        /*  JsonTextWriter.WriteStartObject;
         ReadCredentials(1);
         JsonTextWriter.WritePropertyName('Irn');
         JsonTextWriter.WriteValue(IRNNo);
         JsonTextWriter.WritePropertyName('canReason');
         JsonTextWriter.WriteValue('1');
         JsonTextWriter.WritePropertyName('canRemarks');
         JsonTextWriter.WriteValue('Wrong Entry');
         JsonTextWriter.WriteEndObject;
         JsonTextWriter.Flush; */
    end;


    procedure CancelSalesIRNNo(var SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        FL: File;
        ResponseInStream_L: InStream;
        /*  HttpStatusCode_L: DotNet HttpStatusCode;
         ResponseHeaders_L: DotNet NameValueCollection; */
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        DataExch: Record "Data Exch. Field";
        IRNNo: Text[30];
        rLocation: Record Location;
    begin
        IF SalesInvoiceHeader."IRN Hash" = '' THEN
            EXIT;
        Authenticate;
        LocationCode := SalesInvoiceHeader."Location Code";
        GenerateCancelRequest(SalesInvoiceHeader."IRN Hash");
        GetJason;
        /* IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
            ERASE(GetClientFile + 'J.txt');
        FL.CREATE(GetClientFile + 'J.txt');
        FL.CREATEOUTSTREAM(OutStrm);
        //OutStrm.WRITETEXT(BeginWTRequest);
        OutStrm.WRITETEXT(FORMAT(Json));
        //OutStrm.WRITETEXT(EndWTRequest);
        FL.CLOSE; */
        //HYPERLINK(GetClientFile + 'J.txt');
        //Keshav30Sep2020
        rLocation.GET(SalesInvoiceHeader."Location Code");
        rLocation.TESTFIELD("E-InvCancelURL");
        /*  HttpWebRequestMgt.Initialize(rLocation."E-InvCancelURL");
         // HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/einvoiceapi/v2.0/cancelIRN');
         //Keshav30Sep2020
         HttpWebRequestMgt.DisableUI;

         HttpWebRequestMgt.SetMethod('POST');
         HttpWebRequestMgt.SetReturnType('application/json');
         //HttpWebRequestMgt.SetContentType('application/json');
         HttpWebRequestMgt.AddHeader('accessToken', access_token);
         HttpWebRequestMgt.AddHeader('Content-Type', 'application/json');
         //HttpWebRequestMgt.AddHeader('apiaccesskey','l7xx1f28e29b18a64623aef38dcf4f9b1ac3');
         HttpWebRequestMgt.AddHeader('apiaccesskey', rLocation.apiaccesskey);
         HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
  */
        // 15578    TmpBlob.INIT;
        // 15578    TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
        /*   IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
              ResponseInStream_L.READ(ResponseText);
              Json := ResponseText;
              ReadJSon(Json, DataExch);
         */
        IF GetJsonNodeValue('status') = '1' THEN BEGIN
            SalesInvoiceHeader."IRN Hash" := '';
            //SalesInvoiceHeader.Inv
            SalesInvoiceHeader."Acknowledgement No." := '';
            // 15578    SalesInvoiceHeader."Acknowledgement Date" := GetJsonNodeValue('cancelDate');
            SalesInvoiceHeader.MODIFY;
            MESSAGE('IRN Cancelled')
        END ELSE BEGIN
            ERROR('%1', GetJsonNodeValue('errorDetails..errorDesc'));
        END;

        // END

        ERROR('Network Issue, Please try again');
    end;


    procedure CancelSalesCreditIRNNo(var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        FL: File;
        ResponseInStream_L: InStream;
        /*   HttpStatusCode_L: DotNet HttpStatusCode;
          ResponseHeaders_L: DotNet NameValueCollection;
         */
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        DataExch: Record "Data Exch. Field";
        IRNNo: Text[30];
        rLocation: Record Location;
    begin
        IF SalesCrMemoHeader."IRN Hash" = '' THEN
            EXIT;
        Authenticate;
        LocationCode := SalesCrMemoHeader."Location Code";
        GenerateCancelRequest(SalesCrMemoHeader."IRN Hash");
        GetJason;
        /*  IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
             ERASE(GetClientFile + 'J.txt');
         FL.CREATE(GetClientFile + 'J.txt');
         FL.CREATEOUTSTREAM(OutStrm); */
        //OutStrm.WRITETEXT(BeginWTRequest);
        /*  OutStrm.WRITETEXT(FORMAT(Json));
         //OutStrm.WRITETEXT(EndWTRequest);
         FL.CLOSE; */
        //HYPERLINK(GetClientFile + 'J.txt');
        //Keshav30Sep2020
        rLocation.GET(SalesCrMemoHeader."Location Code");
        rLocation.TESTFIELD("E-InvCancelURL");
        // HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/einvoiceapi/v2.0/cancelIRN');
        /*   HttpWebRequestMgt.Initialize(rLocation."E-InvCancelURL");
          //Keshav30Sep2020
          HttpWebRequestMgt.DisableUI;
          HttpWebRequestMgt.SetMethod('POST');
          HttpWebRequestMgt.SetReturnType('application/json');
          //HttpWebRequestMgt.SetContentType('application/json');
          HttpWebRequestMgt.AddHeader('accesstoken', access_token);
          HttpWebRequestMgt.AddHeader('Content-Type', 'application/json');
          //HttpWebRequestMgt.AddHeader('apiaccesskey','l7xx1f28e29b18a64623aef38dcf4f9b1ac3');
          HttpWebRequestMgt.AddHeader('apiaccesskey', rLocation.apiaccesskey);
          HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt'); */

        // 15578   TmpBlob.INIT;
        // 15578   TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
        /*  IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
             ResponseInStream_L.READ(ResponseText);
             Json := ResponseText;
             ReadJSon(Json, DataExch); */
        IF GetJsonNodeValue('status') = '1' THEN BEGIN
            SalesCrMemoHeader."IRN Hash" := '';
            SalesCrMemoHeader."Acknowledgement No." := '';
            // 15578    SalesCrMemoHeader."Acknowledgement Date" := GetJsonNodeValue('cancelDate');
            SalesCrMemoHeader.MODIFY;
            MESSAGE('IRN Cancelled')
        END ELSE BEGIN
            ERROR('%1', GetJsonNodeValue('errorDetails..errorDesc'));
        END;
        // END
        /* ELSE
            ERROR('Network Issue, Please try again'); */
    end;


    procedure CancelTrfShipIRNNo(var TransferShipmentHeader: Record "Transfer Shipment Header")
    var
        FL: File;
        ResponseInStream_L: InStream;
        /*  HttpStatusCode_L: DotNet HttpStatusCode;
         ResponseHeaders_L: DotNet NameValueCollection; */
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        DataExch: Record "Data Exch. Field";
        IRNNo: Text[30];
        rLocation: Record Location;
    begin
        IF TransferShipmentHeader."IRN Hash" = '' THEN
            EXIT;
        Authenticate;
        LocationCode := TransferShipmentHeader."Transfer-from Code";
        GenerateCancelRequest(TransferShipmentHeader."IRN Hash");
        GetJason;
        /*     IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
                ERASE(GetClientFile + 'J.txt');
            FL.CREATE(GetClientFile + 'J.txt');
            FL.CREATEOUTSTREAM(OutStrm);
            //OutStrm.WRITETEXT(BeginWTRequest);
            OutStrm.WRITETEXT(FORMAT(Json));
            //OutStrm.WRITETEXT(EndWTRequest);
            FL.CLOSE; */
        //HYPERLINK(GetClientFile + 'J.txt');
        //Keshav30Sep2020
        rLocation.GET(TransferShipmentHeader."Transfer-from Code");
        rLocation.TESTFIELD("E-InvCancelURL");
        // HttpWebRequestMgt.Initialize(rLocation."E-InvCancelURL");
        // HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/einvoiceapi/v2.0/cancelIRN');
        //Keshav30Sep2020
        HttpWebRequestMgt.DisableUI;
        /*   HttpWebRequestMgt.SetMethod('POST');
          HttpWebRequestMgt.SetReturnType('application/json');
          //HttpWebRequestMgt.SetContentType('application/json');
          HttpWebRequestMgt.AddHeader('accessToken', access_token);
          HttpWebRequestMgt.AddHeader('Content-Type', 'application/json');
          HttpWebRequestMgt.AddHeader('apiaccesskey', rLocation.apiaccesskey);

          HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
   */
        // 15578    TmpBlob.INIT;
        // 15578    TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
        /*    IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
               ResponseInStream_L.READ(ResponseText);
               Json := ResponseText;
               ReadJSon(Json, DataExch); */
        IF GetJsonNodeValue('status') = '1' THEN BEGIN
            TransferShipmentHeader."IRN Hash" := '';
            TransferShipmentHeader."Acknowledgement No." := '';
            TransferShipmentHeader."Acknowledgement Date" := GetJsonNodeValue('cancelDate');
            TransferShipmentHeader.MODIFY;
            MESSAGE('IRN Cancelled')
        END ELSE BEGIN
            ERROR('%1', GetJsonNodeValue('errorDetails..errorDesc'));
        END;
        // END

    end;

    local procedure GeneratePrintingRequest(IRNNo: Text)
    begin
        IF (GetGSTNNo(SalesInvoiceHeader."Location Code") <> '') THEN
            GSTNNo := GetGSTNNo(SalesInvoiceHeader."Location Code"); //MSKS

        DocumentNo := SalesInvoiceHeader."No.";
        // IF ISNULL(StringBuilder) THEN
        Initialize;

        // JsonTextWriter.WriteStartObject;

        WriteFileHeader;
        ReadTransDtls(SalesInvoiceHeader."GST Customer Type", SalesInvoiceHeader."Ship-to Code");
        ReadDocDtls;

        ReadSellerDtls;
        ReadBuyerDtls;
        ReadShipDtls;
        ReadExpDtls;
        ReadValDtls;
        ReadItemList();
        /* 
                JsonTextWriter.WriteEndObject;
                JsonTextWriter.Flush; */
    end;


    procedure PrintSalesIRNNo(var SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        FL: File;
        ResponseInStream_L: InStream;
        /*  HttpStatusCode_L: DotNet HttpStatusCode;
         ResponseHeaders_L: DotNet NameValueCollection; */
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        DataExch: Record "Data Exch. Field";
        IRNNo: Text[30];
    begin
        GenerateSalesInvJSONSchema(SalesInvoiceHeader);
        HYPERLINK(GetJsonNodeValue('results.message.EinvoicePdf'));
    end;


    procedure PrintSalesCreditIRNNo(var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        FL: File;
        ResponseInStream_L: InStream;
        /*  HttpStatusCode_L: DotNet HttpStatusCode;
         ResponseHeaders_L: DotNet NameValueCollection; */
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        DataExch: Record "Data Exch. Field";
        IRNNo: Text[30];
    begin
        GenerateSalesCreditJSONSchema(SalesCrMemoHeader);
        HYPERLINK(GetJsonNodeValue('results.message.EinvoicePdf'));
    end;

    local procedure BeginWTRequest(): Text
    begin
        EXIT(' {   "Push_Data_List": {     "Data": [ ');
    end;

    local procedure EndWTRequest(): Text
    begin
        EXIT(' ]  } }');
    end;

    local procedure GetGSTNNo(LocationCode: Code[10]): Text
    var
        Location: Record Location;
        CompanyInformation: Record "Company Information";
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


    procedure GenerateSalesInvJSONSchema(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        IF (GetGSTNNo(SalesInvoiceHeader."Location Code") <> '') THEN
            GSTNNo := GetGSTNNo(SalesInvoiceHeader."Location Code"); //MSKS

        DocumentNo := SalesInvoiceHeader."No.";
        LocationCode := SalesInvoiceHeader."Location Code";
        Authenticate();

        /*   IF ISNULL(StringBuilder) THEN
              Initialize;
          JsonTextWriter.WritePropertyName('req');
          JsonTextWriter.WriteStartArray();
          JsonTextWriter.WriteStartObject; */
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

        /*  JsonTextWriter.WriteEndObject;
         JsonTextWriter.WriteEndArray();
         JsonTextWriter.Flush;
  */
        GetIRNNo();
    end;


    procedure GenerateSalesCreditJSONSchema(var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        IF (GetGSTNNo(SalesCrMemoHeader."Location Code") <> '') THEN
            GSTNNo := GetGSTNNo(SalesCrMemoHeader."Location Code"); //MSKS
        DocumentNo := SalesCrMemoHeader."No.";
        Authenticate();

        // IF ISNULL(StringBuilder) THEN
        Initialize;
        /*  JsonTextWriter.WritePropertyName('req');
         JsonTextWriter.WriteStartArray();
         JsonTextWriter.WriteStartObject; */
        //ReadCredentials(1);

        WriteFileHeader;
        ReadTransDtls(SalesCrMemoHeader."GST Customer Type", SalesCrMemoHeader."Ship-to Code");
        ReadDocDtls;

        ReadSellerDtls;
        ReadBuyerDtls;
        ReadShipDtls;
        ReadValDtls;
        ReadItemList();

        /*   JsonTextWriter.WriteEndObject;
          JsonTextWriter.WriteEndArray();
          JsonTextWriter.Flush;
   */
        GetIRNNo();
    end;

    local procedure FormatDate(PostDate: Date): Text
    begin
        EXIT(FORMAT(PostDate, 0, '<Day,2>/<Month,2>/<Year4>'));
    end;


    procedure GenerateTransferInvoiceJSONSchema(var TransferShipmentHeader: Record "Transfer Shipment Header")
    begin
        IF (GetGSTNNo(TransferShipmentHeader."Transfer-from Code") <> '') THEN
            GSTNNo := GetGSTNNo(TransferShipmentHeader."Transfer-from Code"); //MSKS
        DocumentNo := TransferShipmentHeader."No.";
        Authenticate();

        /*  IF ISNULL(StringBuilder) THEN
             Initialize;
         JsonTextWriter.WritePropertyName('req');
         JsonTextWriter.WriteStartArray();
         JsonTextWriter.WriteStartObject; */
        //ReadCredentials(1);

        WriteFileHeader;
        ReadTransDtls(0, '');
        ReadDocDtls;

        ReadSellerDtls;
        ReadBuyerDtls;
        ReadShipDtls;
        WriteEWBDtls('', '', '', '', '', '', 0, '', '');//Keshav0402021
        ReadValDtls;
        ReadItemList();

        /*  JsonTextWriter.WriteEndObject;
         JsonTextWriter.WriteEndArray;
         JsonTextWriter.Flush;
  */
        GetIRNNo();
    end;


    procedure CreateQRCode(QRCodeInput: Text[1024]; var TempBLOB: codeunit "Temp Blob")
    var
        QRCodeFileName: Text[1024];
    begin
        CLEAR(TempBLOB);
        QRCodeFileName := GetQRCode(QRCodeInput);
        UploadFileBLOBImportandDeleteServerFile(TempBLOB, QRCodeFileName);
    end;


    procedure UploadFileBLOBImportandDeleteServerFile(var TempBlob: codeunit "Temp Blob"; FileName: Text[1024])
    var
        FileManagement: Codeunit "File Management";
    begin
        // 15578    FileName := FileManagement.UploadFileSilent(FileName);
        // FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
        DeleteServerFile(FileName);
    end;

    local procedure DeleteServerFile(ServerFileName: Text)
    begin
        // IF ERASE(ServerFileName) THEN;
    end;

    local procedure GetQRCode(QRCodeInput: Text) QRCodeFileName: Text
    var

    //        IBarCodeProvider: DotNet IBarcodeProvider;
    begin
        //      GetBarCodeProvider(IBarCodeProvider);
        //    QRCodeFileName := IBarCodeProvider.GetBarcode(QRCodeInput);
    end;


    // procedure GetBarCodeProvider(var IBarCodeProvider: DotNet IBarcodeProvider)
    //var

    //  QRCodeProvider: DotNet QRCodeProvider;
    //begin
    //  CLEAR(QRCodeProvider);
    //QRCodeProvider := QRCodeProvider.QRCodeProvider;
    //IBarCodeProvider := QRCodeProvider;
    //end;

    local procedure GenrateQRCode(QRCodeTxt: Text; var TempBlob: Codeunit "Temp Blob")
    var
        FieldRef: FieldRef;
        QRCodeInput: Text;
        QRCodeFileName: Text;
    begin
        // Save a QR code image into a file in a temporary folder.
        QRCodeInput := QRCodeTxt;
        QRCodeFileName := GetQRCode(QRCodeInput);
        QRCodeFileName := MoveToMagicPath(QRCodeFileName); // To avoid confirmation dialogue on RTC.

        // Load the image from file into the BLOB field.
        CLEAR(TempBlob);
        // TempBlob.CALCFIELDS(Blob);
        FileManagement.BLOBImport(TempBlob, QRCodeFileName);

        // Erase the temporary file.
        // IF NOT ISSERVICETIER THEN
        /* IF EXISTS(QRCodeFileName) THEN
            ERASE(QRCodeFileName); */
    end;


    procedure MoveToMagicPath(SourceFileName: Text) DestinationFileName: Text[1024]
    var
    // FileSystemObject: Automation;
    begin
        /*
                // User Temp Path
                DestinationFileName := COPYSTR(FileManagement.ClientTempFileName(''), 1, 1024);
                IF ISCLEAR(FileSystemObject) THEN
                    CREATE(FileSystemObject, TRUE, TRUE);
                FileSystemObject.MoveFile(SourceFileName, DestinationFileName);
                */
    end;


    procedure Authenticate(): Text
    var
        FL: File;
        OutStrm: OutStream;
        ResponseInStream_L: InStream;
        /*    HttpStatusCode_L: DotNet HttpStatusCode;
           ResponseHeaders_L: DotNet NameValueCollection;
    */
        ResponseText: Text;
        DataExch: Record "Data Exch. Field";
        JSONManagement: Codeunit "JSON Management";
        rSalInvHdr: Record "Sales Invoice Header";
        rSalCrMemoHdr: Record "Sales Cr.Memo Header";
        rTrfShpHdr: Record "Transfer Shipment Header";
        rLocation: Record Location;
    begin
        //Initialize();

        //ReadCredentialsForActiveUser();

        //GetJason;
        /*IF FILE.EXISTS(GetClientFile + 'accesstoken.txt') THEN
          ERASE(GetClientFile + 'accesstoken.txt');
        FL.CREATE(GetClientFile + 'accesstoken.txt');
        FL.CREATEOUTSTREAM(OutStrm);
        OutStrm.WRITETEXT('{');
        OutStrm.WRITETEXT(FORMAT(Json));
        OutStrm.WRITETEXT('}');
        FL.CLOSE;*/
        //FL.OPEN(GetClientFile + 'J.txt'); //rohan
        //HYPERLINK(GetClientFile + 'accesstoken.txt');
        CLEAR(HttpWebRequestMgt);
        //Keshav30Sep2020
        /*
        IF IsInvoice THEN BEGIN
          rSalInvHdr.RESET;
          rSalInvHdr.SETRANGE("No.",DocumentNo);
          IF rSalInvHdr.FIND('-') THEN
          rLocation.GET(rSalInvHdr."Location Code");
        END ELSE IF IsTransferInvoice THEN BEGIN
          rTrfShpHdr.RESET;
          rTrfShpHdr.SETRANGE("No.",DocumentNo);
          IF rTrfShpHdr.FIND('-') THEN
          rLocation.GET(rTrfShpHdr."Transfer-from Code");
        END ELSE BEGIN
          rSalCrMemoHdr.RESET;
          rSalCrMemoHdr.SETRANGE("No.",DocumentNo);
          IF rSalCrMemoHdr.FIND('-') THEN
          rLocation.GET(rSalCrMemoHdr."Location Code");
        END;
        */
        rLocation.GET(LocationCode);
        rLocation.TESTFIELD("E-InvAuthenticateURL");
        rLocation.TESTFIELD(Username);
        rLocation.TESTFIELD(Password);
        rLocation.TESTFIELD(apiaccesskey);

        // HttpWebRequestMgt.Initialize(rLocation."E-InvAuthenticateURL");
        //Keshav30Sep2020
        // HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/einvoiceapi/v2.0/authenticate');
        HttpWebRequestMgt.DisableUI;
        /*   HttpWebRequestMgt.SetMethod('POST');
          HttpWebRequestMgt.SetReturnType('application/json');
          HttpWebRequestMgt.SetContentType('application/json'); */
        //HttpWebRequestMgt.AddHeader('Content-Type','application/x-www-form-urlencoded');
        //Keshav30Sep2020
        // HttpWebRequestMgt.AddHeader('username','himanshu.jindal@orientbell.eyasp.in');
        // HttpWebRequestMgt.AddHeader('password','T0JkaWdpZ3N0QDgx');
        // HttpWebRequestMgt.AddHeader('apiaccesskey','l7xx1f28e29b18a64623aef38dcf4f9b1ac3');
        /*  HttpWebRequestMgt.AddHeader('username', rLocation.Username);
         HttpWebRequestMgt.AddHeader('password', rLocation.Password);
         HttpWebRequestMgt.AddHeader('apiaccesskey', rLocation.apiaccesskey); */
        //Keshav30Sep2020
        //HttpWebRequestMgt.AddBody(GetClientFile + 'accesstoken.txt');
        // ServicePointManager.SecurityProtocol(SecurityProtocol.Tls12); // new line
        CLEAR(JSONManagement);
        // 15578  TmpBlob.INIT;
        // 15578   TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
        /* IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
            ResponseInStream_L.READ(ResponseText);
            Json := ResponseText;
            //Added
            IF (ResponseText = '') OR (ResponseText = '[]') THEN
                EXIT;
            JSONManagement.InitializeObject(ResponseText);
            //Added
            //MESSAGE(JSONManagement.GetValue('accessToken'));
            ReadJSon(Json, DataExch);
            IF GetJsonNodeValue('status') = '0' THEN
                ERROR(GetJsonNodeValue('errorDetails..errorDesc'))
            ELSE BEGIN
                access_token := JSONManagement.GetValue('accessToken');//GetJsonNodeValue('accessToken')
            END;
        END
        ELSE
            ERROR('Network Issue, Please try again');
 */
    end;


    procedure ReadCredentialsForActiveUser()
    var
        GSTIN: Text;
        "Action": Text;
    begin
        username := 'binarygsp';
        Password := 'Binarygsp@2020';
        Action := 'ACCESSTOKEN';
        GSTIN := '29AAACB0652N000';
        WriteCredentialsForActiveUser(username, Password, Action, GSTIN);
    end;


    procedure WriteCredentialsForActiveUser(username: Text; password: Text; "action": Text; gstin: Text)
    var
    /*   StringBuilder1: DotNet StringBuilder;
      StringWriter1: DotNet StringWriter;
      JsonTextWriter1: DotNet JsonTextWriter;
      JsonFormatting1: DotNet Formatting;
   */
    begin
        /*     StringBuilder1 := StringBuilder1.StringBuilder;
            StringWriter1 := StringWriter1.StringWriter(StringBuilder1);
            JsonTextWriter1 := JsonTextWriter1.JsonTextWriter(StringWriter1);
            JsonTextWriter1.Formatting := JsonFormatting1.Indented;

            JsonTextWriter1.WritePropertyName('UserName');
            JsonTextWriter1.WriteValue(username);

            JsonTextWriter1.WritePropertyName('Password');
            JsonTextWriter1.WriteValue(password);

            JsonTextWriter1.WritePropertyName('action');
            JsonTextWriter1.WriteValue(action);

            JsonTextWriter1.WritePropertyName('Gstin');
            JsonTextWriter1.WriteValue(gstin);

            Json := StringBuilder1.ToString();
        */
    end;

    local procedure GetUOM(UOMCode: Code[10]): Text
    var
        UnitofMeasure: Record "Unit of Measure";
    begin
        IF ((UnitofMeasure.GET(UOMCode)) AND (UnitofMeasure."E-Way Code" <> '')) THEN
            EXIT(UnitofMeasure."E-Way Code");
        ERROR('Unit of measure code must have value %1', UnitofMeasure.Code);
    end;

    local procedure GetGSTValLine(DocumentNo: Code[20]; DocumentLineNo: Integer; var AssVal: Decimal; var CgstVal: Decimal; var SgstVal: Decimal; var IgstVal: Decimal; var CesVal: Decimal; var StCesVal: Decimal; var CesNonAdval: Decimal; var Disc: Decimal; var OthChrg: Decimal; var TotInvVal: Decimal)
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        GSTLedgerEntry: Record "GST Ledger Entry";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CurrExchRate: Record "Currency Exchange Rate";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        // 15578    GSTComponent: Record "16405";
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

        DetailedGSTLedgerEntry.SETFILTER("GST Component Code", '<>CGST|<>SGST|<>IGST|<>CESS|<>INTERCESS');
        IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
            REPEAT
            /*   IF GSTComponent.GET(DetailedGSTLedgerEntry."GST Component Code") THEN
                   IF GSTComponent."Exclude from Reports" THEN
                       StCesVal += ABS(DetailedGSTLedgerEntry."GST Amount");*/// 15578
            UNTIL DetailedGSTLedgerEntry.NEXT = 0;
        END;

        IF IsInvoice THEN BEGIN
            SalesInvoiceLine.SETRANGE("Document No.", DocumentNo);
            SalesInvoiceLine.SETFILTER(Quantity, '<>%1', 0);
            SalesInvoiceLine.SETFILTER("System-Created Entry", '%1', FALSE);
            SalesInvoiceLine.SETRANGE("Line No.", DocumentLineNo);
            IF SalesInvoiceLine.FINDSET THEN BEGIN
                REPEAT
                /*    AssVal += SalesInvoiceLine.Amount;
                    TotGSTAmt += SalesInvoiceLine."Total GST Amount";
                    Disc := SalesInvoiceLine."Inv. Discount Amount" + SalesInvoiceLine."Line Discount Amount";

                    IF SalesInvoiceLine."Charges To Customer" <> 0 THEN BEGIN
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
                    END;*/ // 15578
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
                    // 15578    TotGSTAmt += SalesCrMemoLine."Total GST Amount";
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


    procedure GenerateSalesInvJSONSchemaforChecking(SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        FL: File;
        OutStrm: OutStream;
    begin
        IF (GetGSTNNo(SalesInvoiceHeader."Location Code") <> '') THEN
            GSTNNo := GetGSTNNo(SalesInvoiceHeader."Location Code"); //MSKS

        DocumentNo := SalesInvoiceHeader."No.";
        LocationCode := SalesInvoiceHeader."Location Code";
        //Authenticate();

        /*   IF ISNULL(StringBuilder) THEN
              Initialize;
          JsonTextWriter.WritePropertyName('req');
          JsonTextWriter.WriteStartArray();
          JsonTextWriter.WriteStartObject; */
        //ReadCredentials(1);

        WriteFileHeader;
        ReadTransDtls(SalesInvoiceHeader."GST Customer Type", SalesInvoiceHeader."Ship-to Code");
        ReadDocDtls;
        ReadExpDtls;
        ReadSellerDtls;
        ReadBuyerDtls;
        ReadShipDtls;
        ReadValDtls;
        ReadItemList();

        /*   JsonTextWriter.WriteEndObject;
          JsonTextWriter.WriteEndArray();
          JsonTextWriter.Flush;
          GetJason;
          IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
              ERASE(GetClientFile + 'J.txt');
          FL.CREATE(GetClientFile + 'J.txt');
          FL.CREATEOUTSTREAM(OutStrm);
          OutStrm.WRITETEXT('{');
          OutStrm.WRITETEXT(FORMAT(Json));
          OutStrm.WRITETEXT('}');
          MESSAGE('%1', FORMAT(Json));
          FL.CLOSE; */
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
        Vendor: Record Vendor;
        TransportMethod: Record "Transport Method";
        Location: Record Location;
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

    local procedure WriteEWBDtls(IRN: Text; transporterID: Text; transporterName: Text; transportMode: Code[10]; transportDocNo: Text; transportDocDate: Text; distance: Integer; vehicleNo: Code[20]; vehicleType: Text)
    begin
        /*    JsonTextWriter.WritePropertyName('irn');
           IF IRN <> '' THEN
               JsonTextWriter.WriteValue(IRN)
           ELSE
               JsonTextWriter.WriteValue(GlobalNULL);

           JsonTextWriter.WritePropertyName('transporterID');
           IF transporterID <> '' THEN
               JsonTextWriter.WriteValue(transporterID)
           ELSE
               JsonTextWriter.WriteValue(GlobalNULL);

           JsonTextWriter.WritePropertyName('transporterName');
           IF transporterName <> '' THEN
               JsonTextWriter.WriteValue(transporterName)
           ELSE
               JsonTextWriter.WriteValue(GlobalNULL);

           JsonTextWriter.WritePropertyName('transportMode');
           IF transportMode <> '' THEN
               JsonTextWriter.WriteValue(transportMode)
           ELSE
               JsonTextWriter.WriteValue(GlobalNULL);

           JsonTextWriter.WritePropertyName('transportDocNo');
           IF transportDocNo <> '' THEN
               JsonTextWriter.WriteValue(transportDocNo)
           ELSE
               JsonTextWriter.WriteValue(GlobalNULL);

           JsonTextWriter.WritePropertyName('transportDocDate');
           IF transportDocDate <> '' THEN
               JsonTextWriter.WriteValue(transportDocDate)
           ELSE
               JsonTextWriter.WriteValue(GlobalNULL);

           JsonTextWriter.WritePropertyName('distance');
           IF distance <> 0 THEN
               JsonTextWriter.WriteValue(distance)
           ELSE
               JsonTextWriter.WriteValue(0);

           JsonTextWriter.WritePropertyName('vehicleNo');
           IF vehicleNo <> '' THEN
               JsonTextWriter.WriteValue(vehicleNo)
           ELSE
               JsonTextWriter.WriteValue(GlobalNULL);

           JsonTextWriter.WritePropertyName('vehicleType');
           IF vehicleType <> '' THEN
               JsonTextWriter.WriteValue(vehicleType)
           ELSE
               JsonTextWriter.WriteValue(GlobalNULL);
       */
    end;


    procedure GenerateSalesInvJSONSchemaEWB(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        IsEWB := TRUE;

        IF (GetGSTNNo(SalesInvoiceHeader."Location Code") <> '') THEN
            GSTNNo := GetGSTNNo(SalesInvoiceHeader."Location Code"); //MSKS

        DocumentNo := SalesInvoiceHeader."No.";
        LocationCode := SalesInvoiceHeader."Location Code";
        Authenticate();

        /*  IF ISNULL(StringBuilder) THEN
             Initialize;
         JsonTextWriter.WritePropertyName('req');
         JsonTextWriter.WriteStartArray();
         JsonTextWriter.WriteStartObject;
         //ReadCredentials(1); */

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

        /*    JsonTextWriter.WriteEndObject;
           JsonTextWriter.WriteEndArray();
           JsonTextWriter.Flush; */

        GetEWBNo();
    end;


    procedure GenerateTransferInvoiceJSONSchemaEWB(var TransferShipmentHeader: Record "Transfer Shipment Header")
    begin
        IsEWB := TRUE;

        IF (GetGSTNNo(TransferShipmentHeader."Transfer-from Code") <> '') THEN
            GSTNNo := GetGSTNNo(TransferShipmentHeader."Transfer-from Code"); //MSKS
        DocumentNo := TransferShipmentHeader."No.";
        Authenticate();

        /*  IF ISNULL(StringBuilder) THEN
             Initialize;
         JsonTextWriter.WritePropertyName('req');
         JsonTextWriter.WriteStartArray();
         JsonTextWriter.WriteStartObject;
         //ReadCredentials(1); */

        WriteFileHeader;
        ReadTransDtls(0, '');
        ReadDocDtls;

        ReadSellerDtls;
        ReadBuyerDtls;
        ReadShipDtls;
        ReadEWBDtls;//Keshav05022021
        ReadValDtls;
        ReadItemList();

        /*    JsonTextWriter.WriteEndObject;
           JsonTextWriter.WriteEndArray;
           JsonTextWriter.Flush;
    */
        GetEWBNo();
    end;


    procedure GetEWBNo()
    var
        FL: File;
        ResponseInStream_L: InStream;
        /*  HttpStatusCode_L: DotNet HttpStatusCode;
         ResponseHeaders_L: DotNet NameValueCollection; */
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        DataExch: Record "Data Exch. Field";
        IRNNo: Text[30];
        EWayBillDateTime: Variant;
        EWayExpiryDateTime: Variant;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        TempBlob: Codeunit "Temp Blob";
        BText: BigText;
        InStream: InStream;
        OutStream1: OutStream;
        OutStream2: OutStream;
        QRTempBlob: Codeunit "Temp Blob";
        rSalInvHdr: Record "Sales Invoice Header";
        rSalCrMemoHdr: Record "Sales Cr.Memo Header";
        rTrfShpHdr: Record "Transfer Shipment Header";
        rLocation: Record Location;
    begin
        GetJason;
        /*  IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
             ERASE(GetClientFile + 'J.txt');
         FL.CREATE(GetClientFile + 'J.txt');
         FL.CREATEOUTSTREAM(OutStrm);
         OutStrm.WRITETEXT('{');
         OutStrm.WRITETEXT(FORMAT(Json));
         OutStrm.WRITETEXT('}');
         MESSAGE('%1', FORMAT(Json));
         FL.CLOSE;
         //IF SalesInvoiceHeader."No." = 'SIGM/2021/004488' THEN ERROR('');
         //HYPERLINK(GetClientFile + 'J.txt');
         ServicePointManager.SecurityProtocol(SecurityProtocol.Tls12); // new line
         //Keshav30Sep2020 */
        /*
        IF IsInvoice THEN BEGIN
          rSalInvHdr.RESET;
          rSalInvHdr.SETRANGE("No.",DocumentNo);
          IF rSalInvHdr.FIND('-') THEN;
          rLocation.GET(rSalInvHdr."Location Code");
        END ELSE IF IsTransferInvoice THEN BEGIN
          rTrfShpHdr.RESET;
          rTrfShpHdr.SETRANGE("No.",DocumentNo);
          IF rTrfShpHdr.FIND('-') THEN;
          rLocation.GET(rTrfShpHdr."Transfer-from Code");
        END ELSE BEGIN
          rSalCrMemoHdr.RESET;
          rSalCrMemoHdr.SETRANGE("No.",DocumentNo);
          IF rSalCrMemoHdr.FIND('-') THEN;
          rLocation.GET(rSalCrMemoHdr."Location Code");
        END;
        */
        rLocation.GET(LocationCode);
        rLocation.TESTFIELD("E-InvGenerateURL");
        /*  HttpWebRequestMgt.Initialize(rLocation."E-InvGenerateURL");
         // HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/einvoiceapi/v2.0/generateIRN');
         //Keshav30Sep2020
         HttpWebRequestMgt.DisableUI;
         HttpWebRequestMgt.SetMethod('POST');
         HttpWebRequestMgt.SetReturnType('application/json');
         //HttpWebRequestMgt.SetContentType('application/json');

         HttpWebRequestMgt.AddHeader('accessToken', access_token);
         HttpWebRequestMgt.AddHeader('Content-Type', 'application/json');
         //HttpWebRequestMgt.AddHeader('apiaccesskey','l7xx1f28e29b18a64623aef38dcf4f9b1ac3');
         HttpWebRequestMgt.AddHeader('apiaccesskey', rLocation.apiaccesskey);
         HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');

         // 15578   TmpBlob.INIT;
         // 15578   TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
         IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
             ResponseInStream_L.READ(ResponseText);
             Json := ResponseText;
             //MESSAGE(ResponseText);
             ReadJSon(Json, DataExch); */
        //Added
        IF (ResponseText = '') OR (ResponseText = '[]') THEN
            EXIT;
        CLEAR(JSONManagement);
        JSONManagement.InitializeObject(ResponseText);
        //Added

        /*    END ELSE
               ERROR('Network Issue, Please try again');
    */
        //IF GetJsonNodeValue('status')= '1' THEN BEGIN
        IF GetJsonNodeValue('EwbNo') <> '' THEN BEGIN
            IF IsInvoice THEN BEGIN
                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETRANGE("No.", DocumentNo);
                IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                    //Keshav04022021>>
                    IF GetJsonNodeValue('EwbNo') <> '' THEN BEGIN
                        SalesInvoiceHeader."E-Way Bill No." := GetJsonNodeValue('EwbNo');
                        SalesInvoiceHeader."E-Way Bill Date" := GetJsonNodeValue('EwbDt');
                        SalesInvoiceHeader."E-Way Bill Validity" := GetJsonNodeValue('EwbValidTill');
                        SalesInvoiceHeader."E-Way Generated" := TRUE;
                        SalesInvoiceHeader."E-Way Canceled" := FALSE;
                        MESSAGE(GetJsonNodeValue('InfoDtls.infoDesc'));
                    END;
                    SalesInvoiceHeader.MODIFY;
                    //Keshav04022021<<
                END;
            END ELSE
                IF IsTransferInvoice THEN BEGIN
                    TransferShipmentHeader.RESET;
                    TransferShipmentHeader.SETRANGE("No.", DocumentNo);
                    IF TransferShipmentHeader.FINDFIRST THEN BEGIN
                        //Keshav05022021>>
                        IF GetJsonNodeValue('EwbNo') <> '' THEN BEGIN
                            TransferShipmentHeader."E-Way Bill No." := GetJsonNodeValue('EwbNo');
                            TransferShipmentHeader."E-Way Bill Date" := GetJsonNodeValue('EwbDt');
                            TransferShipmentHeader."E-Way Bill Validity" := GetJsonNodeValue('EwbValidTill');
                            TransferShipmentHeader."E-Way Generated" := TRUE;
                            TransferShipmentHeader."E-Way Canceled" := FALSE;
                            //MESSAGE(GetJsonNodeValue('InfoDtls.infoDesc'));
                        END;
                        TransferShipmentHeader.MODIFY;
                        //Keshav05022021<<
                    END;
                END ELSE BEGIN
                    /*
                    SalesCrMemoHeader.RESET;
                    SalesCrMemoHeader.SETRANGE("No.",DocumentNo);
                    IF SalesCrMemoHeader.FINDFIRST THEN BEGIN
                      SalesCrMemoHeader."IRN Hash" := JSONManagement.GetValue('Irn');
                      SalesCrMemoHeader."Acknowledgement No." := GetJsonNodeValue('AckNo');
                      SalesCrMemoHeader."Acknowledgement Date" := GetJsonNodeValue('AckDt');

                      CLEAR(QRTempBlob);
                      QRTempBlob.CALCFIELDS(Blob);
                      GenrateQRCode(JSONManagement.GetValue('SignedQRCode'),QRTempBlob);
                      SalesCrMemoHeader."QR Code":=QRTempBlob.Blob;
                      SalesCrMemoHeader.MODIFY;
                    END;
                    */
                END;
            MESSAGE('E-Way Bill Updated')
        END ELSE BEGIN
            ERROR(GetJsonNodeValue('errorDetails..errorDesc'));
        END;

    end;


    procedure TroubleshootSalesInvJSONSchemaEWB(SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        FL: File;
        OutStrm: OutStream;
    begin
        IsEWB := TRUE;

        IF (GetGSTNNo(SalesInvoiceHeader."Location Code") <> '') THEN
            GSTNNo := GetGSTNNo(SalesInvoiceHeader."Location Code"); //MSKS

        DocumentNo := SalesInvoiceHeader."No.";
        LocationCode := SalesInvoiceHeader."Location Code";
        Authenticate();

        /*    IF ISNULL(StringBuilder) THEN
               Initialize;
           JsonTextWriter.WritePropertyName('req');
           JsonTextWriter.WriteStartArray();
           JsonTextWriter.WriteStartObject; */
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

        /*   JsonTextWriter.WriteEndObject;
          JsonTextWriter.WriteEndArray();
          JsonTextWriter.Flush;
          GetJason;
          IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
              ERASE(GetClientFile + 'J.txt');
          FL.CREATE(GetClientFile + 'J.txt');
          FL.CREATEOUTSTREAM(OutStrm);
          OutStrm.WRITETEXT('{');
          OutStrm.WRITETEXT(FORMAT(Json));
          OutStrm.WRITETEXT('}');
          //HYPERLINK(GetClientFile + 'J.txt');
          MESSAGE('%1', Json);
          FL.CLOSE; */

        //GetEWBNo();
    end;


    procedure CreateB2CQRPaymentURL(SalesInvoiceHeader: Record "Sales Invoice Header"; DynamicURL: Boolean) PaymentText: Text
    var
        amttocustomer: Decimal;
        Cust: Record Customer;
        CompanyInformation: Record "Company Information";
        DynamicsPAYID: Text;
    begin
        IF Cust."GST Registration No." = '' THEN BEGIN
            // 15578    SalesInvoiceHeader.CALCFIELDS("Amount to Customer");
            // 15578    amttocustomer := SalesInvoiceHeader."Amount to Customer";
            CompanyInformation.GET;
            DynamicsPAYID := CompanyInformation."UPI ID" + '.' + DELCHR(SalesInvoiceHeader."No.", '=', '/\-') + FORMAT(SalesInvoiceHeader."Posting Date", 0, '<Day,2><Month,2><Year4>') + CompanyInformation."UPI Bank Payment Name";
            IF DynamicURL THEN
                PaymentText := 'upi://pay?cu=INR&pa=' + DynamicsPAYID + '&pn=' + CompanyInformation."UPI Payment Name" + '&am=' + FORMAT(amttocustomer) + '&tr=' + SalesInvoiceHeader."No."
            ELSE
                PaymentText := 'upi://pay?cu=INR&pa=' + CompanyInformation."UPI ID" + CompanyInformation."UPI Bank Payment Name" + '&pn=' + CompanyInformation."UPI Payment Name" + '&am=' + FORMAT(amttocustomer) + '&tr=' + SalesInvoiceHeader."No.";
        END;
    end;
}

