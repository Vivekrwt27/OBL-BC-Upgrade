codeunit 50060 "MIPL-API Consumer E-Way BillEY"
{
    Permissions = TableData "Sales Invoice Header" = rim,
                  TableData "Purch. Cr. Memo Hdr." = rimd,
                  TableData "Transfer Shipment Header" = rimd;

    trigger OnRun()
    var
        ParamString: Text;
    begin
    end;

    var
        CompanyInformation: Record "Company Information";
        /*   StringBuilder: DotNet StringBuilder;
          StringWriter: DotNet StringWriter;
          StringReader: DotNet StringReader;
          Json: DotNet String;
          JsonTextWriter: DotNet JsonTextWriter;
          JsonTextReader: DotNet JsonTextReader;
          StreamWriter: DotNet StreamWriter;
          StreamReader: DotNet StreamReader;
          Encoding: DotNet Encoding;
          MessageText: Text;
          HttpWebRequestMgt: Codeunit "Http Web Request Mgt.";
          //TmpBlob: Record TempBlob temporary;
          RequestStr: DotNet Stream;
          CompanyInformation: Record "Company Information";
          ShippingAgent: Record "Shipping Agent";
          HSNSAC: Record "HSN/SAC";
          StateRec: Record State;
          null: Label 'null';
          GlobalNULL: Variant;
          ServicePointManager: DotNet ServicePointManager;
          SecurityProtocol: DotNet SecurityProtocolType; */
        JSONManagement: Codeunit "JSON Management";
        access_token: Text;
        intSlNo: Integer;
        EWBUser: Text;
        EWBPass: Text;
        EWBAPIKey: Text;
        rLocation: Record Location;
        TcsAmt: Decimal;
        IntVal: Integer;

    local procedure SetINIT()
    begin
        /* CLEAR(StringBuilder);
        CLEAR(StringWriter);
        CLEAR(JsonTextWriter);
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JsonTextWriter := JsonTextWriter.JsonTextWriter(StringWriter);
 */
    end;

    local procedure StartJason()
    begin
        SetINIT;
        // JsonTextWriter.WriteStartObject;
    end;

    local procedure AddToJason(Variablename: Text; Variable: Variant)
    begin
        // JsonTextWriter.WritePropertyName(Variablename);
        // JsonTextWriter.WriteValue(FORMAT(Variable, 0, 9));
    end;

    local procedure EndJason()
    begin
        // JsonTextWriter.WriteEndObject;
    end;

    local procedure GetJason()
    begin
        // Json := StringBuilder.ToString;
    end;

    local procedure GetClientFile(): Text
    var
    // ClientAppFile: DotNet Path;
    begin
        // EXIT(ClientAppFile.GetTempPath);
    end;


    procedure AddHeaderDetails()
    var
        FL: File;
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        ResponseInStream_L: InStream;
        // HttpStatusCode_L: DotNet HttpStatusCode;
        // ResponseHeaders_L: DotNet NameValueCollection;
        DataExch: Record "Data Exch. Field";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        Validity: Text;
        ValidSec: Integer;
    begin
        StartJason;
        /*  IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
             ERASE(GetClientFile + 'J.txt');
         FL.CREATE(GetClientFile + 'J.txt');
         FL.CREATEOUTSTREAM(OutStrm);
         OutStrm.WRITETEXT(FORMAT(Json));
         FL.CLOSE; */

        //HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/einvoiceapi/v2.0/authenticate'); //Test
        /* HttpWebRequestMgt.Initialize('https://eapi.eyasp.com/eapi/v2.0/authenticate'); //Prod
        HttpWebRequestMgt.DisableUI;
        HttpWebRequestMgt.SetMethod('POST');
        HttpWebRequestMgt.SetReturnType('application/json');
        ServicePointManager.SecurityProtocol(SecurityProtocol.Tls12); // new line
        HttpWebRequestMgt.AddHeader('username', EWBUser);//'himanshu.jindal@orientbell.eyasp.in');
        HttpWebRequestMgt.AddHeader('password', EWBPass);//'T0JkaWdpZ3N0QDgx');
        HttpWebRequestMgt.AddHeader('apiaccesskey', EWBAPIKey);//'l7xx1f28e29b18a64623aef38dcf4f9b1ac3');
        HttpWebRequestMgt.AddHeader('Content-Type', 'application/json');

        // TmpBlob.INIT;
        //TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
        IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
            ResponseInStream_L.READ(ResponseText);
            Json := ResponseText;
            //KeshavNewEY>>
            JSONManagement.InitializeObject(ResponseText);
            ReadJSon(Json, DataExch);
            IF GetJsonNodeValue('status') = '0' THEN
                ERROR(GetJsonNodeValue('errorDetails..errorDesc'))
            ELSE BEGIN
                access_token := JSONManagement.GetValue('accessToken');//GetJsonNodeValue('accessToken')
            END;
            //KeshavNewEY<<
        END ELSE
            ERROR('Govt Network Issue');
        EndJason; */
    end;


    procedure GenerateEWay(JsonString: Text)
    var
        ResponseInStream_L: InStream;
        // HttpStatusCode_L: DotNet HttpStatusCode;
        // ResponseHeaders_L: DotNet NameValueCollection;
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        DataExch: Record "Data Exch. Field";
        EWayBillNo: Text[30];
        EWayBillDateTime: Variant;
        EWayExpiryDateTime: Variant;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        FL: File;
    begin
        GetJason;
        /*  IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
             ERASE(GetClientFile + 'J.txt');
         FL.CREATE(GetClientFile + 'J.txt');
         FL.CREATEOUTSTREAM(OutStrm);
         OutStrm.WRITETEXT(FORMAT(Json));
         FL.CLOSE;
         IF CONFIRM('Do you want view the JSON') THEN
             MESSAGE('%1', Json);

         //Header for EWB Json----
         HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/intg/ewbmsapi/v1.0/generate'); //Test
         HttpWebRequestMgt.DisableUI;
         HttpWebRequestMgt.SetMethod('POST');
         HttpWebRequestMgt.SetReturnType('application/json');
         ServicePointManager.SecurityProtocol(SecurityProtocol.Tls12); // new line
         HttpWebRequestMgt.AddHeader('accesstoken', access_token);
         HttpWebRequestMgt.AddHeader('apiaccesskey', 'l7xx1f28e29b18a64623aef38dcf4f9b1ac3');
         HttpWebRequestMgt.AddHeader('Content-Type', 'application/json');
         //HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');

         // TmpBlob.INIT;
         //TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
         IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
             ResponseInStream_L.READ(ResponseText);
             Json := ResponseText;
         END ELSE
             ERROR('Govt Network Issue');
         EndJason;
  */        //Header for EWB Json----
    end;

    // 15578  [EventSubscriber(ObjectType::Page, 50400, 'UpdateVehicleNoEvent', '', false, false)]

    procedure UpdateVehicleNo(SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        FL: File;
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        ResponseInStream_L: InStream;
        // HttpStatusCode_L: DotNet HttpStatusCode;
        // ResponseHeaders_L: DotNet NameValueCollection;
        DataExch: Record "Data Exch. Field";
        TknNo: Text[50];
        TransportMethod: Record "Transport Method";
    begin
        SalesInvoiceHeader.TESTFIELD("E-Way Bill No.");
        SalesInvoiceHeader.TESTFIELD("New Vechile No.");
        SalesInvoiceHeader.TESTFIELD("Vechile No. Update Remark");
        TransportMethod.GET(SalesInvoiceHeader."Transport Method");
        // CompanyInformation.GET;

        AddHeaderDetails;

        StartJason;
        // JsonTextWriter.WritePropertyName('vehicledetails');
        // JsonTextWriter.WriteStartArray;
        // JsonTextWriter.WriteStartObject;

        AddToJason('gstin', '29AAACO0305P1ZD');//Test
        AddToJason('documentNumber', SalesInvoiceHeader."No.");
        AddToJason('ewbNo', SalesInvoiceHeader."E-Way Bill No.");
        AddToJason('fromPlace', SalesInvoiceHeader."Ship-to City");
        // AddToJason('fromState',COPYSTR(SalesInvoiceHeader."Ship-to GST Reg. No.",1,2));
        AddToJason('fromState', '29');
        AddToJason('vehicleNo', DELCHR(SalesInvoiceHeader."New Vechile No.", '=', ' /\.<>-!@#$%^&*()_+'));

        IF SalesInvoiceHeader."Vechile No. Update Remark" = SalesInvoiceHeader."Vechile No. Update Remark"::"Due to Break Down" THEN BEGIN
            AddToJason('reasonCode', '1');
            AddToJason('reasonRem', 'Due to Break Down');
        END ELSE
            IF SalesInvoiceHeader."Vechile No. Update Remark" = SalesInvoiceHeader."Vechile No. Update Remark"::"Due to Transhipment" THEN BEGIN
                AddToJason('reasonCode', '2');
                AddToJason('reasonRem', 'Due to Transhipment');
            END ELSE
                IF SalesInvoiceHeader."Vechile No. Update Remark" = SalesInvoiceHeader."Vechile No. Update Remark"::"First Time" THEN BEGIN
                    AddToJason('reasonCode', '3');
                    AddToJason('reasonRem', 'First Time');
                END ELSE
                    IF SalesInvoiceHeader."Vechile No. Update Remark" = SalesInvoiceHeader."Vechile No. Update Remark"::Others THEN BEGIN
                        AddToJason('reasonCode', '4');
                        AddToJason('reasonRem', 'Others');
                    END;

        AddToJason('transMode', TransportMethod."E-Way transport method");
        AddToJason('vehicleType', 'R');
        AddToJason('transDocNo', SalesInvoiceHeader."LR/RR No.");
        AddToJason('transDocDate', FORMAT(SalesInvoiceHeader."LR/RR Date", 0, 7));

        // JsonTextWriter.WriteEndObject;
        EndJason;
        GetJason;
        /* IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
            ERASE(GetClientFile + 'J.txt');
        FL.CREATE(GetClientFile + 'J.txt');
        FL.CREATEOUTSTREAM(OutStrm);
        OutStrm.WRITETEXT(FORMAT(Json));
        FL.CLOSE; */

        IF CONFIRM('Do you wanna View JSON') THEN
            // MESSAGE('%1', Json);
            /*  HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/intg/ewbmsapi/v1.0/updatePartB');
             HttpWebRequestMgt.DisableUI;
             HttpWebRequestMgt.SetMethod('POST');
             HttpWebRequestMgt.SetReturnType('application/json');
             // HttpWebRequestMgt.SetContentType('application/json');
             HttpWebRequestMgt.AddHeader('accesstoken', access_token);
             HttpWebRequestMgt.AddHeader('apiaccesskey', 'l7xx1f28e29b18a64623aef38dcf4f9b1ac3');
             HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');

             // TmpBlob.INIT;
             //TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
             IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
                 ResponseInStream_L.READ(ResponseText);
                 Json := ResponseText;
                 ReadJSon(Json, DataExch);
             END;
      */
           IF GetJsonNodeValue('data.errorDesc') = '' THEN BEGIN
                SalesInvoiceHeader."Vehicle No." := SalesInvoiceHeader."New Vechile No.";
                SalesInvoiceHeader.MODIFY;
                MESSAGE('Vechile No. Updated')
            END ELSE
                ERROR('%1, in Document No. : %2', GetJsonNodeValue('data.errorDesc'), SalesInvoiceHeader."No.");
    end;


    procedure CancelEWay("E-Way_BillNo": Text[30])
    var
        FL: File;
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        ResponseInStream_L: InStream;
        // HttpStatusCode_L: DotNet HttpStatusCode;
        // ResponseHeaders_L: DotNet NameValueCollection;
        DataExch: Record "Data Exch. Field";
        TknNo: Text[50];
        EWayBillNo: Text[30];
        EWayBillDateTime: Variant;
        EWayExpiryDateTime: Variant;
    begin
        // CompanyInformation.GET;
        StartJason;
        // AddToJason('userGstin',CompanyInformation."GST Registration No.");
        AddToJason('userGstin', '05AAABB0639G1Z8'); //Test
        AddToJason('eway_bill_number', "E-Way_BillNo");
        AddToJason('reason_of_cancel', 'Others');
        AddToJason('cancel_remark', 'Cancelled the order');
        AddToJason('data_source', 'erp');
        EndJason;
        GetJason;
        /*   IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
              ERASE(GetClientFile + 'J.txt');
          FL.CREATE(GetClientFile + 'J.txt');
          FL.CREATEOUTSTREAM(OutStrm);
          OutStrm.WRITETEXT(FORMAT(Json));
          FL.CLOSE;
          MESSAGE('%1', Json);
          // HttpWebRequestMgt.Initialize('https://pro.mastersindia.co/ewayBillCancel');
          HttpWebRequestMgt.Initialize('https://clientbasic.mastersindia.co/ewayBillCancel');//Test
          HttpWebRequestMgt.DisableUI;
          HttpWebRequestMgt.SetMethod('POST');
          HttpWebRequestMgt.SetReturnType('application/json');
          HttpWebRequestMgt.SetContentType('application/json');
          HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');

         */  //  TmpBlob.INIT;
             //TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
             /*   IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
                   ResponseInStream_L.READ(ResponseText);
                   Json := ResponseText;
                   //  MESSAGE('%1',ResponseText);
                   ReadJSon(Json, DataExch);
        */
        EWayBillNo := GetJsonNodeValue('results.message.ewayBillNo');
        EWayBillDateTime := GetJsonNodeValue('results.message.cancelDate');
        // END;
    end;

    local procedure ConsolitedEWayBill(JsonString: Text)
    var
        ResponseInStream_L: InStream;
        // HttpStatusCode_L: DotNet HttpStatusCode;
        // ResponseHeaders_L: DotNet NameValueCollection;
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        DataExch: Record "Data Exch. Field";
        EWayBillNo: Text[30];
        EWayBillDateTime: Variant;
        EWayExpiryDateTime: Variant;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        FL: File;
    begin
        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETRANGE("E-Way-to generate", TRUE);
        IF SalesInvoiceHeader.FINDSET THEN
            REPEAT
                CreateJSONSalesInvoice(SalesInvoiceHeader);
                GetJason;
                /*  IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
                     ERASE(GetClientFile + 'J.txt');
                 FL.CREATE(GetClientFile + 'J.txt');
                 FL.CREATEOUTSTREAM(OutStrm);
                 OutStrm.WRITETEXT(FORMAT(Json));
                 FL.CLOSE;
                 MESSAGE('%1', Json);
                 //    HttpWebRequestMgt.Initialize('https://pro.mastersindia.co/ewayBillsGenerate');
                 HttpWebRequestMgt.Initialize('https://clientbasic.mastersindia.co/ewayBillsGenerate');
                 HttpWebRequestMgt.DisableUI;
                 HttpWebRequestMgt.SetMethod('POST');
                 HttpWebRequestMgt.SetReturnType('application/json');
                 HttpWebRequestMgt.SetContentType('application/json');
                 HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt'); */
                //HttpWebRequestMgt.AddBody( 'E:\JSS2.txt');
                ////  MESSAGE('%1',ResponseText);
                // TmpBlob.INIT;
                //TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
                /* IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
                    ResponseInStream_L.READ(ResponseText);
                    ////  MESSAGE('%1',ResponseText);
                    Json := ResponseText;
                    //  MESSAGE('%1',ResponseText);
                    ReadJSon(Json, DataExch);
 */
                EWayBillNo := GetJsonNodeValue('results.message.ewayBillNo');
                EWayBillDateTime := GetJsonNodeValue('results.message.ewayBillDate');
                EWayExpiryDateTime := GetJsonNodeValue('results.message.validUpto');


                SalesInvoiceHeader."E-Way Bill No." := FORMAT(EWayBillNo);
                SalesInvoiceHeader."E-Way Bill Date" := EWayBillDateTime;
                SalesInvoiceHeader."E-Way Bill Validity" := EWayExpiryDateTime;
                SalesInvoiceHeader."E-Way Generated" := TRUE;
                SalesInvoiceHeader.MODIFY;
            // END;
            UNTIL SalesInvoiceHeader.NEXT = 0;
        SalesInvoiceHeader.MODIFYALL("E-Way-to generate", FALSE);
    end;




    /* procedure ReadFirstJSonValue(var String: DotNet String; ParameterName: Text) ParameterValue: Text
    var
        //JsonToken: DotNet JsonToken;
        PropertyName: Text;
    begin

        StringReader := StringReader.StringReader(String);
        JsonTextReader := JsonTextReader.JsonTextReader(StringReader);
        WHILE JsonTextReader.Read DO
            CASE TRUE OF
                // JsonTextReader.TokenType.CompareTo(JsonToken.PropertyName) = 0:
                //PropertyName := FORMAT(JsonTextReader.Value, 0, 9);
                NOT ISNULL(JsonTextReader.Value):
                    //JsonTextReader.TokenType.CompareTo(JsonToken.) = 0 :
                    BEGIN
                        ParameterValue := FORMAT(JsonTextReader.Value, 0, 9);
                        EXIT;
                    END;
            END;
    end;
 */

    procedure ConvertXMLToJSON(var TempBlob: Codeunit "Temp Blob")
    var
        /*  XmlDocument: DotNet XmlDocument;
         JSONConvert: DotNet JsonConvert;
         JSONFormatting: DotNet Formatting;
         */
        myInStream: InStream;
        myOutStream: OutStream;
        myJSON: Text;
        FL: File;
        OutStrm: OutStream;
    begin
        // 15578    TempBlob.Blob.CREATEINSTREAM(myInStream);
        /*  XmlDocument := XmlDocument.XmlDocument;
         XmlDocument.Load(myInStream);
         myJSON := JSONConvert.SerializeXmlNode(XmlDocument.DocumentElement, JSONFormatting.Indented, TRUE);
         // 15578   TempBlob.INIT;
         // 15578   TempBlob.Blob.CREATEOUTSTREAM(myOutStream, TEXTENCODING::UTF8);
         myOutStream.WRITETEXT(myJSON);

         IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
             ERASE(GetClientFile + 'J.txt');
         FL.CREATE(GetClientFile + 'J.txt');
         FL.CREATEOUTSTREAM(OutStrm);
         OutStrm.WRITETEXT(FORMAT(myJSON));
         FL.CLOSE;
         */ //MESSAGE('%1',FORMAT(myJSON));
    end;


    procedure XMLPortToJSON(myXMLPort: Integer)
    var
        myOutStream: OutStream;
        myInStream: InStream;
        tempBlob: Codeunit "Temp Blob";
        myJSON: Text;
    begin
        // 15578    tempBlob.INIT;
        // 15578    tempBlob.Blob.CREATEOUTSTREAM(myOutStream);
        XMLPORT.EXPORT(myXMLPort, myOutStream);
        ConvertXMLToJSON(tempBlob);
        // 15578  myJSON := tempBlob.ReadAsText('', TEXTENCODING::UTF8);
    end;

    local procedure GetJsonNodeValue(NodeId: Text[30]): Text
    var
        DataExch: Record "Data Exch. Field";
    begin
        // CLEAR(MessageText);
        DataExch.RESET;
        DataExch.SETRANGE("Node ID", NodeId);
        IF DataExch.FINDFIRST THEN
            // MessageText := DataExch.Value;
        EXIT('');
    end;

    local procedure AddToJasonArray(Variablename: Text; Variable: Variant)
    var
    /*  JsonTextWriter2: DotNet JsonTextWriter;
     StringWriter2: DotNet StringWriter;
     StringBuilder2: DotNet StringBuilder;
 */
    begin

        /*      JsonTextWriter.WritePropertyName(Variablename);
             JsonTextWriter.WriteValue(FORMAT(Variable));
         */
    end;

    [EventSubscriber(ObjectType::Page, 50237, 'CreateJSONSalesInvoiceEvent', '', false, false)]

    procedure CreateJSONSalesInvoice(SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        CustomerL: Record Customer;
        SalesInvoiceLineL: Record "Sales Invoice Line";
        ShiptoAddressL: Record "Ship-to Address";
        CustGstin: Code[15];
        TknNo: Text[50];
        SalesInvoiceHeader2: Record "Sales Invoice Header";
        ResponseInStream_L: InStream;
        /*    HttpStatusCode_L: DotNet HttpStatusCode;
           ResponseHeaders_L: DotNet NameValueCollection;
         */
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        DataExch: Record "Data Exch. Field";
        EWayBillNo: Text[30];
        EWayBillDateTime: Variant;
        EWayExpiryDateTime: Variant;
        FL: File;
        Mnth: Text[2];
        Day: Text[2];
        TransportMethod: Record "Transport Method";
        Location: Record Location;
        State_Gst: Code[2];
        State_rec: Record State;
        EWayURL: Text[250];
        ShiptoAddress: Record "Ship-to Address";
        ItemCategory: Record "Item Category";
        Vendor: Record Vendor;
        RequestId: Text;
        DocNo: Code[20];
        GSTN_Generator: Code[20];
    begin
        IF rLocation.GET(SalesInvoiceHeader."Location Code") THEN;
        EWBUser := rLocation.Username;
        EWBPass := rLocation.Password;
        EWBAPIKey := rLocation.apiaccesskey;

        GetCompanyInfo;

        IF TransportMethod.GET(SalesInvoiceHeader."Transport Method") THEN;
        // IF ShippingAgent.GET(SalesInvoiceHeader."Shipping Agent Code") THEN;
        IF Location.GET(SalesInvoiceHeader."Location Code") THEN;
        TransportMethod.TESTFIELD("E-Way transport method");
        SalesInvoiceHeader.TESTFIELD("Truck No.");
        //SalesInvoiceHeader.TESTFIELD("Distance (Km)"); //Kulbhushan Sharma
        SalesInvoiceHeader.TESTFIELD("E-Way Generated", FALSE);
        SalesInvoiceHeader.TESTFIELD("E-Way Bill No.", '');
        //SalesInvoiceHeader.TESTFIELD("E-Way Transaction Type");//
        AddHeaderDetails;

        StartJason;
        /*   JsonTextWriter.WritePropertyName('invoices');
          JsonTextWriter.WriteStartArray;
          JsonTextWriter.WriteStartObject;
   */
        AddToJason('sourceIdentifier', '');
        AddToJason('division', '');
        AddToJason('subDivision', '');
        AddToJason('profitCenter1', '');//Test
        AddToJason('profitCenter2', '');
        AddToJason('plantCode', '');
        // AddToJason('fromGstin','29AAACO0305P1ZD');//Test
        AddToJason('fromGstin', Location."GST Registration No.");
        AddToJason('docCategory', 'REG');
        AddToJason('fromTrdName', Location.Name);                       //CompanyInformation.Name);
        AddToJason('supplierAddress1', Location.Address);                    //CompanyInformation.Address);
        AddToJason('supplierAddress2', Location."Address 2");                //CompanyInformation."Address 2");
        //AddToJason('ORIGIN_STATE',GetStateCode(Location."State Code"));         //CompanyInformation.State));
        AddToJason('supplierPlace', Location.City);                           //CompanyInformation.City);
        AddToJason('supplierPin', Location."Pin Code");                     //CompanyInformation."Post Code");
        // AddToJason('supplierPin','560063');//Test

        AddToJason('dispatcherGstin', CustGstin);
        AddToJason('dispatcherName', SalesInvoiceHeader."Sell-to Customer Name");
        AddToJason('dispatcherAddress1', SalesInvoiceHeader."Ship-to Address");
        AddToJason('dispatcherAddress2', SalesInvoiceHeader."Ship-to Address 2");

        State_Gst := '';
        State_Gst := COPYSTR(CustGstin, 1, 2);
        CustomerL.GET(SalesInvoiceHeader."Bill-to Customer No.");
        State_rec.RESET;
        //State_rec.SETRANGE("State Code (GST Reg. No.)",State_Gst);
        State_rec.SETRANGE(Code, CustomerL."State Code");
        IF State_rec.FINDFIRST THEN;

        // AddToJason('actFromStateCode','29');//Test
        // AddToJason('fromStateCode','29');//Test
        AddToJason('actFromStateCode', COPYSTR(Location."GST Registration No.", 1, 2));
        AddToJason('fromStateCode', COPYSTR(Location."GST Registration No.", 1, 2));
        AddToJason('dispatcherPlace', SalesInvoiceHeader."Ship-to City");
        AddToJason('dispatcherPin', SalesInvoiceHeader."Ship-to Post Code");
        // AddToJason('dispatcherPin','560063');//Test
        AddToJason('supplyType', 'O');
        AddToJason('subSupplyType', 'Tax');
        AddToJason('docType', 'INV');
        AddToJason('otherSupplyTypeDescription', 'NO');
        AddToJason('docNo', SalesInvoiceHeader."No.");
        AddToJason('docDate', SalesInvoiceHeader."Posting Date");
        // AddToJason('docDate',FORMAT(SalesInvoiceHeader."Posting Date",0,7));//Day+'/'+Mnth+'/'+FORMAT(DATE2DMY(SalesInvoiceHeader."Posting Date",3)));//'20/03/2018');//FORMAT(SalesInvoiceHeader."Posting Date",0,1));
        // AddToJason('recepientGSTIN','08ABSFS3250K1ZN');//Test
        AddToJason('recepientGSTIN', SalesInvoiceHeader."Customer GST Reg. No.");
        AddToJason('recepientName', SalesInvoiceHeader."Ship-to Name");
        // AddToJason('shipToGSTIN','08ABSFS3250K1ZN');
        AddToJason('shipToGSTIN', SalesInvoiceHeader."Ship-to GST Reg. No.");
        AddToJason('shipToTradeName', SalesInvoiceHeader."Ship-to Name");
        AddToJason('shipToAddress1', SalesInvoiceHeader."Ship-to Address");
        AddToJason('shipToAddress2', SalesInvoiceHeader."Ship-to Address 2");
        AddToJason('toPlace', SalesInvoiceHeader."Ship-to City");
        AddToJason('toPincode', SalesInvoiceHeader."Ship to Pin");
        // AddToJason('toPincode','302001');//Test
        // AddToJason('toStateCode','08');//Test
        // AddToJason('actToStateCode','08');//Test
        AddToJason('toStateCode', COPYSTR(SalesInvoiceHeader."Customer GST Reg. No.", 1, 2));

        IF SalesInvoiceHeader."Ship-to Code" = '' THEN BEGIN
            AddToJason('actToStateCode', COPYSTR(SalesInvoiceHeader."Customer GST Reg. No.", 1, 2));

        END ELSE BEGIN

            AddToJason('actToStateCode', COPYSTR(SalesInvoiceHeader."Ship-to GST Reg. No.", 1, 2));
        END;


        TcsAmt := CalculateTCSAmt(SalesInvoiceHeader."No.");
        // 15578   SalesInvoiceHeader.CALCFIELDS("Amount to Customer");
        // 15578   AddToJason('totInvValue', SalesInvoiceHeader."Amount to Customer");
        AddToJason('otherValue', TcsAmt);//NeedToChange
        AddToJason('transMode', TransportMethod."E-Way transport method");//SalesInvoiceHeader."Mode of Transport");

        IF Vendor.GET(SalesInvoiceHeader."Transporter's Name") THEN;
        IF Vendor.Transporter1 THEN
            AddToJason('transporterId', Vendor."GST No.")
        ELSE
            AddToJason('transporterId', Vendor."GST Registration No.");

        //AddToJason('transporter_id',ShippingAgent."Transporter GST No.");
        //AddToJason('transporter_id','05AAABB0639G1Z8');//alle
        AddToJason('transporterName', SalesInvoiceHeader."Transporter Name");

        // AddToJason('transporterId','');
        // AddToJason('transporterName','');
        AddToJason('transDocNo', SalesInvoiceHeader."GR No.");
        AddToJason('transDocDate', SalesInvoiceHeader."GR Date");
        //AddToJason('transDistance',SalesInvoiceHeader."Distance (Km)"); Kulbhushan Sharma
        AddToJason('vehicleNo', DELCHR(SalesInvoiceHeader."Truck No.", '=', ' ,/-<>  !@#$%^&*()_+{}'));
        AddToJason('vehicleType', 'R');
        AddToJason('userDefinedFiled1', '');
        AddToJason('userDefinedFiled2', '');

        intSlNo := 0;
        SalesInvoiceLineL.RESET;
        SalesInvoiceLineL.SETRANGE("Document No.", SalesInvoiceHeader."No.");
        SalesInvoiceLineL.SETRANGE(Type, SalesInvoiceLineL.Type::Item);
        SalesInvoiceLineL.SETFILTER(Quantity, '<>%1', 0);
        IF SalesInvoiceLineL.FINDSET THEN BEGIN
            // JsonTextWriter.WritePropertyName('itemList');
            // JsonTextWriter.WriteStartArray;
            REPEAT
                intSlNo += 1;
                // JsonTextWriter.WriteStartObject;
                AddToJason('lineNo', intSlNo);
                AddToJason('productName', SalesInvoiceLineL.Description);
                AddToJason('productDesc', '');
                AddToJason('hsnCode', SalesInvoiceLineL."HSN/SAC Code");
                AddToJason('qtyUnit', GetUOM(SalesInvoiceLineL."Unit of Measure Code"));
                AddToJason('quantity', SalesInvoiceLineL.Quantity);
                //    AddToJason('taxableAmount',SalesInvoiceLineL.Amount);
                // 15578    AddToJason('taxableAmount', SalesInvoiceLineL."GST Base Amount");
                AddToJason('igstRate', GetGSTRate(SalesInvoiceLineL."Document No.", 'IGST', SalesInvoiceLineL."Line No."));
                AddToJason('igstValue', GetGSTAmountLine(SalesInvoiceHeader."No.", 'IGST', SalesInvoiceLineL."Line No."));
                AddToJason('cgstRate', GetGSTRate(SalesInvoiceLineL."Document No.", 'CGST', SalesInvoiceLineL."Line No."));
                AddToJason('cgstValue', GetGSTAmountLine(SalesInvoiceHeader."No.", 'CGST', SalesInvoiceLineL."Line No."));
                AddToJason('sgstRate', GetGSTRate(SalesInvoiceLineL."Document No.", 'SGST', SalesInvoiceLineL."Line No."));
                AddToJason('sgstValue', GetGSTAmountLine(SalesInvoiceHeader."No.", 'SGST', SalesInvoiceLineL."Line No."));
                AddToJason('cessRateAdvol', 0);
                AddToJason('cessAmtAdvol', GetGSTAmount(SalesInvoiceHeader."No.", 'CESS'));
                AddToJason('cessRateSpec', 0);
                AddToJason('cessAmtSpec', 0);

            // JsonTextWriter.WriteEndObject;
            UNTIL SalesInvoiceLineL.NEXT = 0;
        END;
        EndJason;

        IF CONFIRM('Do you want instant generate the E-way') THEN BEGIN
            GetJason;
            /* IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
                ERASE(GetClientFile + 'J.txt');
            FL.CREATE(GetClientFile + 'J.txt');
            FL.CREATEOUTSTREAM(OutStrm);
            OutStrm.WRITETEXT(FORMAT(Json));
            FL.CLOSE;
            IF CONFIRM('Do you want view the JSON') THEN
                MESSAGE('%1', Json);
 */
            //Header for EWB Json----
            //HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/intg/ewbmsapi/v1.0/generate'); //Test
            /*             HttpWebRequestMgt.Initialize('https://eapi.eyasp.com/ewbms/v1.0/generate');//Prod Normal
                        HttpWebRequestMgt.DisableUI;
                        HttpWebRequestMgt.SetMethod('POST');
                        HttpWebRequestMgt.SetReturnType('application/json');
                        ServicePointManager.SecurityProtocol(SecurityProtocol.Tls12); //newline
                        HttpWebRequestMgt.AddHeader('accesstoken', access_token);
                        HttpWebRequestMgt.AddHeader('apiaccesskey', EWBAPIKey);//'l7xx1f28e29b18a64623aef38dcf4f9b1ac3');
                        HttpWebRequestMgt.AddHeader('Content-Type', 'application/json');
                        HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');

             */            // TmpBlob.INIT;
                           //TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
                           /*   IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
                                 ResponseInStream_L.READ(ResponseText);
                                 Json := ResponseText;

                                 ReadJSon(Json, DataExch);
                            */
            IF GetJsonNodeValue('data.error..errors..errCode') <> '' THEN
                ERROR('Error Code : %1, Error Message : %2, in Document No. %3', GetJsonNodeValue('data.error..errors..errCode'),
                        GetJsonNodeValue('data.error..errors..errDesc'), GetJsonNodeValue('data.error..docNo'));

            //GSTN_Generator:='05AAACE3061A1ZH';

            EWayBillNo := GetJsonNodeValue('data.success..ewb');
            EWayBillDateTime := GetJsonNodeValue('data.success..ewbDate');
            EWayExpiryDateTime := GetJsonNodeValue('data.success..validUpTo');

            COMMIT;
            IF EWayBillNo <> '' THEN BEGIN
                SalesInvoiceHeader2.GET(SalesInvoiceHeader."No.");
                SalesInvoiceHeader2."E-Way Bill No." := FORMAT(EWayBillNo);
                SalesInvoiceHeader2."E-Way Bill Date" := EWayBillDateTime;
                SalesInvoiceHeader2."E-Way Bill Validity" := EWayExpiryDateTime;
                SalesInvoiceHeader2."E-Way Generated" := TRUE;
                SalesInvoiceHeader2."E-Way Canceled" := FALSE;
                //SalesInvoiceHeader2."E-Way URL" := EWayURL;
                //IF SalesInvoiceHeader2."E-Way-to generate" THEN
                //SalesInvoiceHeader2."E-Way-to generate" := FALSE; // Consolidation Case
                SalesInvoiceHeader2.MODIFY;
                MESSAGE('E-Way Bill Generated');
            END ELSE
                ERROR('%1', GetJsonNodeValue('data.error..errors..errCode'));
        END ELSE BEGIN
            ERROR('Not Responding');
        END;
        // END;
    end;

    local procedure GetCompanyInfo()
    begin
        // CompanyInformation.GET;
    end;

    local procedure GetStateCode(StateCode: Code[20]): Text
    var
        StateL: Record State;
    begin
        IF StateL.GET(StateCode) THEN
            EXIT(UPPERCASE(StateL.Description));
        EXIT('');
    end;

    local procedure GetGSTAmount(DocNo: Code[20]; CompCode: Code[10]): Decimal
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        GSTAmt: Decimal;
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        CGSTPer: Decimal;
        IGSTPer: Decimal;
        SGSTPer: Decimal;
        CessPer: Decimal;
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

    local procedure GetGSTRate(DocNo: Code[20]; CompCode: Code[10]; LineNo: Integer): Decimal
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        GSTAmt: Decimal;
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        CGSTPer: Decimal;
        IGSTPer: Decimal;
        SGSTPer: Decimal;
        CessPer: Decimal;
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

    local procedure GetTaxableAmountSalesInvoice(DocNo: Code[20]): Decimal
    var
        SalesInvoiceLineL: Record "Sales Invoice Line";
    begin
        SalesInvoiceLineL.RESET;
        SalesInvoiceLineL.SETRANGE("Document No.", DocNo);
        SalesInvoiceLineL.SETFILTER(Quantity, '<>%1', 0);
        // 15578   SalesInvoiceLineL.CALCSUMS("GST Base Amount");
        // 15578   IF SalesInvoiceLineL."GST Base Amount" <> 0 THEN
        // 15578       EXIT(SalesInvoiceLineL."GST Base Amount");

        SalesInvoiceLineL.CALCSUMS(Amount);
        EXIT(SalesInvoiceLineL.Amount);
    end;

    // 15578  [EventSubscriber(ObjectType::Page, 50238, 'CreateJSONPurchaseReturnEvent', '', false, false)]

    procedure CreateJSONPurchReturn(PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    var
        VendorL: Record Vendor;
        PurchCrMemoLineL: Record "Purch. Cr. Memo Line";
        ShiptoAddressL: Record "Ship-to Address";
        CustGstin: Code[15];
        TknNo: Text[50];
        ResponseInStream_L: InStream;
        // HttpStatusCode_L: DotNet HttpStatusCode;
        // ResponseHeaders_L: DotNet NameValueCollection;
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        DataExch: Record "Data Exch. Field";
        EWayBillNo: Text[30];
        EWayBillDateTime: Variant;
        EWayExpiryDateTime: Variant;
        FL: File;
        PurchCrMemoHdrL2: Record "Purch. Cr. Memo Hdr.";
        Mnth: Text[2];
        TransportMethod: Record "Transport Method";
        Location: Record Location;
        State_Gst: Code[2];
        State_rec: Record State;
        ItemCategory: Record "Item Category";
        EwayURL: Text[200];
    begin
        IF rLocation.GET(PurchCrMemoHdr."Location Code") THEN;
        EWBUser := rLocation.Username;
        EWBPass := rLocation.Password;
        EWBAPIKey := rLocation.apiaccesskey;

        GetCompanyInfo;
        IF TransportMethod.GET(PurchCrMemoHdr."Transport Method") THEN;
        // 15578    IF ShippingAgent.GET(PurchCrMemoHdr."Shipping Agent CodeBase") THEN;
        IF Location.GET(PurchCrMemoHdr."Location Code") THEN;
        PurchCrMemoHdr.TESTFIELD("E-Way Bill No.", '');
        PurchCrMemoHdr.TESTFIELD("Truck No.");
        PurchCrMemoHdr.TESTFIELD("Transport Method");
        //PurchCrMemoHdr.TESTFIELD("Distance (Km)");
        // AddToJason('userGstin',GetGSTIN(PurchCrMemoHdr."Location Code"));//Test
        AddHeaderDetails;

        StartJason;
        /*    JsonTextWriter.WritePropertyName('invoices');
           JsonTextWriter.WriteStartArray;
           JsonTextWriter.WriteStartObject;
    */
        AddToJason('sourceIdentifier', '');
        AddToJason('division', '');
        AddToJason('subDivision', '');
        AddToJason('profitCenter1', '');//Test
        AddToJason('profitCenter2', '');
        AddToJason('plantCode', '');
        // AddToJason('fromGstin','29AAACO0305P1ZD');//Test
        AddToJason('fromGstin', Location."GST Registration No.");
        AddToJason('docCategory', 'REG');
        AddToJason('fromTrdName', Location.Name);                       //CompanyInformation.Name);
        AddToJason('supplierAddress1', Location.Address);                    //CompanyInformation.Address);
        AddToJason('supplierAddress2', Location."Address 2");                //CompanyInformation."Address 2");
        //AddToJason('ORIGIN_STATE',GetStateCode(Location."State Code"));         //CompanyInformation.State));
        AddToJason('supplierPlace', Location.City);                           //CompanyInformation.City);
        AddToJason('supplierPin', Location."Pin Code");                     //CompanyInformation."Post Code");
        // AddToJason('supplierPin','560063');//Test

        AddToJason('dispatcherGstin', CustGstin);
        AddToJason('dispatcherName', PurchCrMemoHdr."Buy-from Vendor Name");
        AddToJason('dispatcherAddress1', PurchCrMemoHdr."Ship-to Address");
        AddToJason('dispatcherAddress2', PurchCrMemoHdr."Ship-to Address 2");

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

        // AddToJason('actFromStateCode','29');//Test
        AddToJason('actFromStateCode', COPYSTR(Location."GST Registration No.", 1, 2));
        // AddToJason('fromStateCode','29');//Test
        AddToJason('fromStateCode', COPYSTR(Location."GST Registration No.", 1, 2));
        AddToJason('dispatcherPlace', PurchCrMemoHdr."Ship-to City");
        AddToJason('dispatcherPin', VendorL."Pin Code");
        // AddToJason('dispatcherPin','560063');//Test
        AddToJason('supplyType', 'O');
        AddToJason('subSupplyType', 'OTH');
        AddToJason('docType', 'OTH');
        AddToJason('otherSupplyTypeDescription', 'NO');
        AddToJason('docNo', PurchCrMemoHdr."No.");
        AddToJason('docDate', PurchCrMemoHdr."Posting Date");
        //AddToJason('recepientGSTIN','08ABSFS3250K1ZN');//Test
        AddToJason('recepientGSTIN', PurchCrMemoHdr."Vendor GST Reg. No.");
        AddToJason('recepientName', PurchCrMemoHdr."Ship-to Name");
        // AddToJason('shipToGSTIN','08ABSFS3250K1ZN');//test
        AddToJason('shipToGSTIN', PurchCrMemoHdr."Vendor GST Reg. No.");
        AddToJason('shipToTradeName', PurchCrMemoHdr."Ship-to Name");
        AddToJason('shipToAddress1', PurchCrMemoHdr."Ship-to Address");
        AddToJason('shipToAddress2', PurchCrMemoHdr."Ship-to Address 2");
        AddToJason('toPlace', PurchCrMemoHdr."Ship-to City");
        AddToJason('toPincode', VendorL."Pin Code");
        // AddToJason('toPincode','302001');
        // AddToJason('toStateCode','08');//Test
        AddToJason('toStateCode', COPYSTR(PurchCrMemoHdr."Vendor GST Reg. No.", 1, 2));
        // AddToJason('actToStateCode','08');//Test
        AddToJason('actToStateCode', COPYSTR(PurchCrMemoHdr."Vendor GST Reg. No.", 1, 2));
        //  PurchCrMemoHdr.CALCFIELDS("Amount to Vendor");
        //  AddToJason('totInvValue', PurchCrMemoHdr."Amount to Vendor");
        AddToJason('otherValue', 0);//NeedToChange
        AddToJason('transMode', TransportMethod."E-Way transport method");//SalesInvoiceHeader."Mode of Transport");
        AddToJason('transporterId', '');
        AddToJason('transporterName', '');
        AddToJason('transDocNo', PurchCrMemoHdr."GR No.");
        // AddToJason('transDocNo','');//Test
        AddToJason('transDocDate', PurchCrMemoHdr."Document Date");
        // AddToJason('transDocDate','');//Test
        AddToJason('transDistance', PurchCrMemoHdr."Distance (Km)");
        AddToJason('vehicleNo', DELCHR(PurchCrMemoHdr."Truck No.", '=', ' ,/-<>  !@#$%^&*()_+{}'));
        AddToJason('vehicleType', 'R');
        AddToJason('userDefinedFiled1', '');
        AddToJason('userDefinedFiled2', '');

        intSlNo := 0;
        PurchCrMemoLineL.RESET;
        PurchCrMemoLineL.SETRANGE("Document No.", PurchCrMemoHdr."No.");
        PurchCrMemoLineL.SETRANGE(Type, PurchCrMemoLineL.Type::Item);
        PurchCrMemoLineL.SETFILTER(Quantity, '<>%1', 0);
        IF PurchCrMemoLineL.FINDSET THEN BEGIN
            /*   JsonTextWriter.WritePropertyName('itemList');
              JsonTextWriter.WriteStartArray;
             */
            REPEAT
                intSlNo += 1;
                // JsonTextWriter.WriteStartObject;
                AddToJason('lineNo', intSlNo);
                AddToJason('productName', PurchCrMemoLineL.Description);
                AddToJason('productDesc', '');
                AddToJason('hsnCode', PurchCrMemoLineL."HSN/SAC Code");
                AddToJason('qtyUnit', GetUOM(PurchCrMemoLineL."Unit of Measure Code"));
                AddToJason('quantity', PurchCrMemoLineL.Quantity);
                //    AddToJason('taxableAmount',PurchCrMemoLineL.Amount);
                // 15578    AddToJason('taxableAmount', PurchCrMemoLineL."GST Base Amount");
                AddToJason('igstRate', GetGSTRate(PurchCrMemoLineL."Document No.", 'IGST', PurchCrMemoLineL."Line No."));
                AddToJason('igstValue', GetGSTAmountLine(PurchCrMemoHdr."No.", 'IGST', PurchCrMemoLineL."Line No."));
                AddToJason('cgstRate', GetGSTRate(PurchCrMemoLineL."Document No.", 'CGST', PurchCrMemoLineL."Line No."));
                AddToJason('cgstValue', GetGSTAmountLine(PurchCrMemoHdr."No.", 'CGST', PurchCrMemoLineL."Line No."));
                AddToJason('sgstRate', GetGSTRate(PurchCrMemoLineL."Document No.", 'SGST', PurchCrMemoLineL."Line No."));
                AddToJason('sgstValue', GetGSTAmountLine(PurchCrMemoHdr."No.", 'SGST', PurchCrMemoLineL."Line No."));
                AddToJason('cessRateAdvol', 0);
                AddToJason('cessAmtAdvol', GetGSTAmount(PurchCrMemoHdr."No.", 'CESS'));
                AddToJason('cessRateSpec', 0);
                AddToJason('cessAmtSpec', 0);

            // JsonTextWriter.WriteEndObject;
            UNTIL PurchCrMemoLineL.NEXT = 0;
        END;
        EndJason;

        IF CONFIRM('Do you want instant generate the E-way') THEN BEGIN
            GetJason;
            /*  IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
                 ERASE(GetClientFile + 'J.txt');
             FL.CREATE(GetClientFile + 'J.txt');
             FL.CREATEOUTSTREAM(OutStrm);
             OutStrm.WRITETEXT(FORMAT(Json));
             FL.CLOSE;
             IF CONFIRM('Do you want view the JSON') THEN
                 MESSAGE('%1', Json);
             */ //Header for EWB Json----
                //HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/intg/ewbmsapi/v1.0/generate'); //Test
                /*  HttpWebRequestMgt.Initialize('https://eapi.eyasp.com/ewbms/v1.0/generate');//Prod
                 HttpWebRequestMgt.DisableUI;
                 HttpWebRequestMgt.SetMethod('POST');
                 HttpWebRequestMgt.SetReturnType('application/json');
                 ServicePointManager.SecurityProtocol(SecurityProtocol.Tls12); // new line
                 HttpWebRequestMgt.AddHeader('accesstoken', access_token);
                 HttpWebRequestMgt.AddHeader('apiaccesskey', EWBAPIKey);//'l7xx1f28e29b18a64623aef38dcf4f9b1ac3');
                 HttpWebRequestMgt.AddHeader('Content-Type', 'application/json');
                 HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
      */
                // TmpBlob.INIT;
                //TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
                /* IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
                    ResponseInStream_L.READ(ResponseText);
                    Json := ResponseText;

                    ReadJSon(Json, DataExch);
                 */
            IF GetJsonNodeValue('data.error..errors..errCode') <> '' THEN
                ERROR('Error Code : %1, Error Message : %2, in Document No. %3', GetJsonNodeValue('data.error..errors..errCode'),
                        GetJsonNodeValue('data.error..errors..errDesc'), GetJsonNodeValue('data.error..docNo'));

            IF GetJsonNodeValue('data.errorDesc') <> '' THEN
                ERROR('Error Code : %1 , Error Description : %2', GetJsonNodeValue('data.errorCode'), GetJsonNodeValue('data.errorDesc'));

            IF GetJsonNodeValue('statusCd') = '0' THEN
                ERROR('Status id Failed Please Contact your Administrator');
            //GSTN_Generator:='05AAACE3061A1ZH';

            EWayBillNo := GetJsonNodeValue('data.success..ewb');
            EWayBillDateTime := GetJsonNodeValue('data.success..ewbDate');
            EWayExpiryDateTime := GetJsonNodeValue('data.success..validUpTo');

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
            END ELSE
                ERROR('%1', GetJsonNodeValue('data.error..errors..errCode'));

        END ELSE BEGIN
            ERROR('Not Responding');
        END;
        // END;
    end;

    // 15578  [EventSubscriber(ObjectType::Page, 50239, 'CreateJSONTransferShipmentEvent', '', false, false)]

    procedure CreateJSONTransferShipment(var TransferShipmentHeaderL: Record "Transfer Shipment Header")
    var
        VendorL: Record Vendor;
        TransferShipmentLineL: Record "Transfer Shipment Line";
        ShiptoAddressL: Record "Ship-to Address";
        CustGstin: Code[15];
        TknNo: Text[50];
        ResponseInStream_L: InStream;
        /*  HttpStatusCode_L: DotNet HttpStatusCode;
         ResponseHeaders_L: DotNet NameValueCollection;
         */
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        DataExch: Record "Data Exch. Field";
        EWayBillNo: Text[30];
        EWayBillDateTime: Variant;
        EWayExpiryDateTime: Variant;
        FL: File;
        TransferShipmentHeader2: Record "Transfer Shipment Header";
        Mnth: Text[2];
        Day: Text[2];
        Location: Record Location;
        TransportMethod: Record "Transport Method";
        State_Gst: Code[2];
        State_rec: Record State;
        ResponsibilityCenter: Record "Responsibility Center";
        LocationTo: Record Location;
        EWayURL: Text[200];
        Vendor: Record Vendor;
        RequestId: Text;
        DocNo: Code[20];
        GSTN_Generator: Code[20];
    begin
        IF rLocation.GET(TransferShipmentHeaderL."Transfer-from Code") THEN;
        EWBUser := rLocation.Username;
        EWBPass := rLocation.Password;
        EWBAPIKey := rLocation.apiaccesskey;

        GetCompanyInfo;
        IF TransportMethod.GET(TransferShipmentHeaderL."Transport Method") THEN;
        // IF ShippingAgent.GET(TransferShipmentHeaderL."Shipping Agent Code") THEN;
        IF Location.GET(TransferShipmentHeaderL."Transfer-from Code") THEN;

        TransferShipmentHeaderL.TESTFIELD("E-Way Bill No.", '');
        TransferShipmentHeaderL.TESTFIELD("Vehicle No.");
        TransferShipmentHeaderL.TESTFIELD("Transport Method");
        //TransferShipmentHeaderL.TESTFIELD("Distance (Km)");
        AddHeaderDetails;

        StartJason;
        /*  JsonTextWriter.WritePropertyName('invoices');
         JsonTextWriter.WriteStartArray;
         JsonTextWriter.WriteStartObject;
  */
        AddToJason('sourceIdentifier', '');
        AddToJason('division', '');
        AddToJason('subDivision', '');
        AddToJason('profitCenter1', '');//Test
        AddToJason('profitCenter2', '');
        AddToJason('plantCode', '');
        // AddToJason('fromGstin','29AAACO0305P1ZD');//Test
        AddToJason('fromGstin', GetGSTIN(TransferShipmentHeaderL."Transfer-from Code"));
        AddToJason('docCategory', 'REG');
        AddToJason('fromTrdName', Location.Name);                       //CompanyInformation.Name);
        AddToJason('supplierAddress1', Location.Address);                    //CompanyInformation.Address);
        AddToJason('supplierAddress2', Location."Address 2");                //CompanyInformation."Address 2");
        //AddToJason('ORIGIN_STATE',GetStateCode(Location."State Code"));         //CompanyInformation.State));
        AddToJason('supplierPlace', Location.City);                           //CompanyInformation.City);
        AddToJason('supplierPin', Location."Pin Code");                     //CompanyInformation."Post Code");
        // AddToJason('supplierPin','560063');//Test

        IF LocationTo.GET(TransferShipmentHeaderL."Transfer-to Code") THEN
            CustGstin := LocationTo."GST Registration No.";
        //    CustGstin := '05AAABC0181E1ZE';//TEst

        AddToJason('dispatcherGstin', CustGstin);
        AddToJason('dispatcherName', TransferShipmentHeaderL."Transfer-to Name");
        AddToJason('dispatcherAddress1', TransferShipmentHeaderL."Transfer-to Address");
        AddToJason('dispatcherAddress2', TransferShipmentHeaderL."Transfer-to Address 2");

        State_Gst := '';
        State_Gst := COPYSTR(CustGstin, 1, 2);
        // vendorL.GET(PurchCrMemoHdr."Buy-from Vendor No.");
        // State_rec.RESET;
        // //State_rec.SETRANGE("State Code (GST Reg. No.)",State_Gst);
        // State_rec.SETRANGE(Code,vendorl."State Code");
        // IF State_rec.FINDFIRST THEN;

        // AddToJason('actFromStateCode','29');//Test
        AddToJason('actFromStateCode', COPYSTR(GetGSTIN(TransferShipmentHeaderL."Transfer-from Code"), 1, 2));
        // AddToJason('fromStateCode','29');//Test
        AddToJason('fromStateCode', COPYSTR(GetGSTIN(TransferShipmentHeaderL."Transfer-from Code"), 1, 2));
        AddToJason('dispatcherPlace', TransferShipmentHeaderL."Transfer-to City");
        AddToJason('dispatcherPin', Location."Pin Code");
        // AddToJason('dispatcherPin','560063');//Test
        AddToJason('supplyType', 'O');
        AddToJason('subSupplyType', 'Tax');
        AddToJason('docType', 'INV');
        AddToJason('otherSupplyTypeDescription', 'NO');
        AddToJason('docNo', TransferShipmentHeaderL."No.");
        AddToJason('docDate', TransferShipmentHeaderL."Posting Date");
        // AddToJason('recepientGSTIN','08ABSFS3250K1ZN');//Test
        AddToJason('recepientGSTIN', CustGstin);
        AddToJason('recepientName', TransferShipmentHeaderL."Transfer-to Name");
        // AddToJason('shipToGSTIN','08ABSFS3250K1ZN');//Test
        AddToJason('shipToGSTIN', CustGstin);
        AddToJason('shipToTradeName', TransferShipmentHeaderL."Transfer-to Name");
        AddToJason('shipToAddress1', TransferShipmentHeaderL."Transfer-to Address");
        AddToJason('shipToAddress2', TransferShipmentHeaderL."Transfer-to Address 2");
        AddToJason('toPlace', TransferShipmentHeaderL."Transfer-to City");
        AddToJason('toPincode', LocationTo."Pin Code");
        // AddToJason('toPincode','302001');
        // AddToJason('toStateCode','08');//Test
        AddToJason('toStateCode', COPYSTR(CustGstin, 1, 2));
        // AddToJason('actToStateCode','08');//Test
        AddToJason('actToStateCode', COPYSTR(CustGstin, 1, 2));//Test

        TransferShipmentHeaderL.CALCFIELDS(Amount);
        TransferShipmentLineL.RESET;
        TransferShipmentLineL.SETRANGE("Document No.", TransferShipmentHeaderL."No.");
        IF TransferShipmentLineL.FINDSET THEN BEGIN
            // 15578    TransferShipmentLineL.CALCSUMS("GST Base Amount", "Total GST Amount");
        END;

        /*   IF TransferShipmentLineL."GST Base Amount" <> 0 THEN BEGIN
               AddToJason('totInvValue', TransferShipmentLineL."GST Base Amount" + TransferShipmentLineL."Total GST Amount");
           END ELSE BEGIN
               TransferShipmentLineL.CALCSUMS(Amount);
               AddToJason('totInvValue', TransferShipmentLineL.Amount);
           END;*/ // 15578
        AddToJason('otherValue', 0);//NeedToChange
        AddToJason('transMode', TransportMethod."E-Way transport method");//SalesInvoiceHeader."Mode of Transport");
        IF Vendor.GET(TransferShipmentHeaderL."Transporter's Name") THEN;
        IF Vendor.Transporter1 THEN BEGIN
            AddToJason('transporterId', Vendor."GST No.");
            AddToJason('transporterName', Vendor.Name);
        END ELSE BEGIN
            AddToJason('transporterId', Vendor."GST Registration No.");
            AddToJason('transporterName', Vendor.Name);
        END;

        // AddToJason('transporterId',);

        AddToJason('transDocNo', TransferShipmentHeaderL."GR No.");
        AddToJason('transDocDate', TransferShipmentHeaderL."GR Date");
        AddToJason('transDistance', TransferShipmentHeaderL."Distance (Km)");
        AddToJason('vehicleNo', DELCHR(TransferShipmentHeaderL."Truck No.", '=', ' ,/-<>  !@#$%^&*()_+{}'));
        AddToJason('vehicleType', 'R');
        AddToJason('userDefinedFiled1', '');
        AddToJason('userDefinedFiled2', '');

        intSlNo := 0;
        TransferShipmentLineL.RESET;
        TransferShipmentLineL.SETRANGE("Document No.", TransferShipmentHeaderL."No.");
        // TransferShipmentLineL.SETRANGE(Type,TransferShipmentLineL.Type::Item);
        TransferShipmentLineL.SETFILTER(Quantity, '<>%1', 0);
        IF TransferShipmentLineL.FINDSET THEN BEGIN
            /*   JsonTextWriter.WritePropertyName('itemList');
              JsonTextWriter.WriteStartArray;
             */
            REPEAT
                intSlNo += 1;
                // JsonTextWriter.WriteStartObject;
                AddToJason('lineNo', intSlNo);
                AddToJason('productName', TransferShipmentLineL.Description);
                AddToJason('productDesc', '');
                AddToJason('hsnCode', TransferShipmentLineL."HSN/SAC Code");
                AddToJason('qtyUnit', GetUOM(TransferShipmentLineL."Unit of Measure Code"));
                AddToJason('quantity', TransferShipmentLineL.Quantity);
                //    AddToJason('taxableAmount',TransferShipmentLineL.Amount);
                // 15578    AddToJason('taxableAmount', TransferShipmentLineL."GST Base Amount");
                AddToJason('igstRate', GetGSTRate(TransferShipmentLineL."Document No.", 'IGST', TransferShipmentLineL."Line No."));
                AddToJason('igstValue', GetGSTAmount(TransferShipmentHeaderL."No.", 'IGST'));
                AddToJason('cgstRate', GetGSTRate(TransferShipmentLineL."Document No.", 'CGST', TransferShipmentLineL."Line No."));
                AddToJason('cgstValue', GetGSTAmount(TransferShipmentHeaderL."No.", 'CGST'));
                AddToJason('sgstRate', GetGSTRate(TransferShipmentLineL."Document No.", 'SGST', TransferShipmentLineL."Line No."));
                AddToJason('sgstValue', GetGSTAmount(TransferShipmentHeaderL."No.", 'SGST'));
                AddToJason('cessRateAdvol', 0);
                AddToJason('cessAmtAdvol', GetGSTAmount(TransferShipmentHeaderL."No.", 'CESS'));
                AddToJason('cessRateSpec', 0);
                AddToJason('cessAmtSpec', 0);

            // JsonTextWriter.WriteEndObject;
            UNTIL TransferShipmentLineL.NEXT = 0;
        END;
        EndJason;

        IF CONFIRM('Do you want instant generate the E-way') THEN BEGIN
            GetJason;
            /*  IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
                 ERASE(GetClientFile + 'J.txt');
             FL.CREATE(GetClientFile + 'J.txt');
             FL.CREATEOUTSTREAM(OutStrm);
             OutStrm.WRITETEXT(FORMAT(Json));
             FL.CLOSE;
             IF CONFIRM('Do you want view the JSON') THEN
                 MESSAGE('%1', Json);
  */
            //Header for EWB Json----
            //HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/intg/ewbmsapi/v1.0/generate'); //Test
            /*  HttpWebRequestMgt.Initialize('https://eapi.eyasp.com/ewbms/v1.0/generate');//Prod
             HttpWebRequestMgt.DisableUI;
             HttpWebRequestMgt.SetMethod('POST');
             HttpWebRequestMgt.SetReturnType('application/json');
             ServicePointManager.SecurityProtocol(SecurityProtocol.Tls12); //newline
             HttpWebRequestMgt.AddHeader('accesstoken', access_token);
             HttpWebRequestMgt.AddHeader('apiaccesskey', EWBAPIKey);//'l7xx1f28e29b18a64623aef38dcf4f9b1ac3');
             HttpWebRequestMgt.AddHeader('Content-Type', 'application/json');
             HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');

             // TmpBlob.INIT;
             //TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
             IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
                 ResponseInStream_L.READ(ResponseText);
                 Json := ResponseText;

                 ReadJSon(Json, DataExch);
                 IF GetJsonNodeValue('data.error..errors..errCode') <> '' THEN
             */
            ERROR('Error Code : %1, Error Message : %2, in Document No. %3', GetJsonNodeValue('data.error..errors..errCode'),
                 GetJsonNodeValue('data.error..errors..errDesc'), GetJsonNodeValue('data.error..docNo'));

            EWayBillNo := GetJsonNodeValue('data.success..ewb');
            EWayBillDateTime := GetJsonNodeValue('data.success..ewbDate');
            EWayExpiryDateTime := GetJsonNodeValue('data.success..validUpTo');

            COMMIT;
            IF EWayBillNo <> '' THEN BEGIN
                TransferShipmentHeader2.GET(TransferShipmentHeaderL."No.");
                TransferShipmentHeader2."E-Way Bill No." := FORMAT(EWayBillNo);
                TransferShipmentHeader2."E-Way Bill Date" := EWayBillDateTime;
                TransferShipmentHeader2."E-Way Bill Validity" := EWayExpiryDateTime;
                TransferShipmentHeader2."E-Way Generated" := TRUE;
                TransferShipmentHeader2."E-Way Canceled" := FALSE;
                TransferShipmentHeader2.MODIFY;
                MESSAGE('E-Way Bill Generated');
            END ELSE
                ERROR('%1', GetJsonNodeValue('data.error..errors..errCode'));
        END ELSE BEGIN
            ERROR('Not Responding');
        END;
    END;
    // end;

    // 15578   [EventSubscriber(ObjectType::Page, 50401, 'UpdateVehicleNo_Purchase_ReturnEvent', '', false, false)]

    procedure UpdateVehicleNo_Purchase_Return(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    var
        FL: File;
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        ResponseInStream_L: InStream;
        /*    HttpStatusCode_L: DotNet HttpStatusCode;
           ResponseHeaders_L: DotNet NameValueCollection;
         */
        DataExch: Record "Data Exch. Field";
        TknNo: Text[50];
        Location: Record Location;
        TransportMethod: Record "Transport Method";
    begin
        // 15578   PurchCrMemoHdr.TESTFIELD("E-Way Bill No.Base");
        PurchCrMemoHdr.TESTFIELD("New Vechile No.");
        PurchCrMemoHdr.TESTFIELD("Vechile No. Update Remark");
        Location.GET(PurchCrMemoHdr."Location Code");

        // CompanyInformation.GET;
        TransportMethod.GET(PurchCrMemoHdr."Transport Method");

        StartJason;
        AddToJason('action', 'UPDATEPARTB');
        /*   JsonTextWriter.WritePropertyName('Data');
          JsonTextWriter.WriteStartArray;
          JsonTextWriter.WriteStartObject;

         */  // AddToJason('Generator_Gstin',GetGSTIN(PurchCrMemoHdr."Location Code"));
        AddToJason('Generator_Gstin', '05AAACE3061A1ZH');//Test
                                                         // 15578  AddToJason('EwbNo', PurchCrMemoHdr."E-Way Bill No.Base");
        AddToJason('TransportMode', PurchCrMemoHdr."Transport Method");
        AddToJason('VehicleNo', DELCHR(PurchCrMemoHdr."New Vechile No.", '=', ' .,/-<>()\!@#$%^&*()_+{}|?><'));

        AddToJason('VehicleType', 'Normal');
        AddToJason('TransDocNumber', PurchCrMemoHdr."Applies-to Doc. No.");
        AddToJason('TransDocDate', GetDateFormated(PurchCrMemoHdr."Posting Date"));
        // 15578   AddToJason('StateName', GetStateCode(PurchCrMemoHdr.State));
        AddToJason('FromCityPlace', PurchCrMemoHdr."Ship-to City");
        //AddToJason('state_of_consignor',GetStateCode(Location."State Code"));

        IF PurchCrMemoHdr."Vechile No. Update Remark" = PurchCrMemoHdr."Vechile No. Update Remark"::"Due to Break Down" THEN
            AddToJason('VehicleReason', 'due to break down')
        ELSE
            IF PurchCrMemoHdr."Vechile No. Update Remark" = PurchCrMemoHdr."Vechile No. Update Remark"::"Due to Transhipment" THEN
                AddToJason('VehicleReason', 'due to Transhipment')
            ELSE
                IF PurchCrMemoHdr."Vechile No. Update Remark" = PurchCrMemoHdr."Vechile No. Update Remark"::"First Time" THEN
                    AddToJason('VehicleReason', 'first time')
                ELSE
                    IF PurchCrMemoHdr."Vechile No. Update Remark" = PurchCrMemoHdr."Vechile No. Update Remark"::Others THEN BEGIN
                        AddToJason('VehicleReason', 'Others');
                        AddToJason('VehicleReason', 'vehicle broke down');
                    END;
        AddToJason('Remarks', '');
        // JsonTextWriter.WriteEndObject;
        EndJason;
        GetJason;
        /*         IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
                    ERASE(GetClientFile + 'J.txt');
                FL.CREATE(GetClientFile + 'J.txt');
                FL.CREATEOUTSTREAM(OutStrm);
                OutStrm.WRITETEXT(FORMAT(Json));
                FL.CLOSE;
                IF CONFIRM('Do you wanna View JSON') THEN
                    MESSAGE('%1', Json);

                HttpWebRequestMgt.Initialize('http://182.76.79.236:35001/EWBTPApi-UAT/EwayBill/');
                HttpWebRequestMgt.DisableUI;
                HttpWebRequestMgt.SetMethod('POST');
                HttpWebRequestMgt.SetReturnType('application/json');
                // HttpWebRequestMgt.SetContentType('application/json');
                HttpWebRequestMgt.AddHeader('PRIVATEKEY', 'AeeA1214A5fgHB543rg');
                HttpWebRequestMgt.AddHeader('PRIVATEVALUE', 'qBKLSB1psdsmgIEzyFOksLlTg');
                HttpWebRequestMgt.AddHeader('IP', '10.1.0.5');
                HttpWebRequestMgt.AddHeader('Content-Type', 'application/json');
                HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');

                //  TmpBlob.INIT;
                //TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
                IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
                    ResponseInStream_L.READ(ResponseText);
                    //  MESSAGE('%1',ResponseText);
                    Json := ResponseText;
                    ReadJSon(Json, DataExch);
         */
        // END;
        IF GetJsonNodeValue('Data..Remarks') = '' THEN BEGIN
            // 15578   PurchCrMemoHdr."Vehicle No.Base" := PurchCrMemoHdr."New Vechile No.";
            PurchCrMemoHdr.MODIFY;
            MESSAGE('Vechile No. Updated')
        END ELSE
            ERROR('%1, in Document No. : ', GetJsonNodeValue('Data..Remarks'), PurchCrMemoHdr."No.");
    end;

    // 15578  [EventSubscriber(ObjectType::Page, 50402, 'UpdateVehicleNo_TransferShipmentEvent', '', false, false)]

    procedure UpdateVehicleNo_TransferShipment(var TransferShipmentHeader: Record "Transfer Shipment Header")
    var
        FL: File;
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        ResponseInStream_L: InStream;
        /*  HttpStatusCode_L: DotNet HttpStatusCode;
         ResponseHeaders_L: DotNet NameValueCollection;
         */
        DataExch: Record "Data Exch. Field";
        TknNo: Text[50];
        Location: Record Location;
        TransportMethod: Record "Transport Method";
    begin
        TransferShipmentHeader.TESTFIELD("E-Way Bill No.");
        TransferShipmentHeader.TESTFIELD("New Vechile No.");
        TransferShipmentHeader.TESTFIELD("Vechile No. Update Remark");
        IF TransportMethod.GET(TransferShipmentHeader."Transport Method") THEN;
        CompanyInformation.GET;
        IF Location.GET(TransferShipmentHeader."Transfer-from Code") THEN;
        StartJason;
        AddToJason('action', 'UPDATEPARTB');
        /*   JsonTextWriter.WritePropertyName('Data');
          JsonTextWriter.WriteStartArray;
          JsonTextWriter.WriteStartObject;
   */
        AddToJason('Generator_Gstin', '05AAACE3061A1ZH');//Test
        // AddToJason('Generator_Gstin',GetGSTIN(TransferShipmentHeader."Transfer-from Code"));
        AddToJason('EwbNo', TransferShipmentHeader."E-Way Bill No.");
        AddToJason('TransportMode', TransportMethod."E-Way transport method");
        AddToJason('VehicleNo', DELCHR(TransferShipmentHeader."New Vechile No.", '=', ' .,/-<>()\!@#$%^&*()_+'));
        AddToJason('VehicleType', 'Normal');
        AddToJason('TransDocNumber', TransferShipmentHeader."External Document No.");
        AddToJason('TransDocDate', GetDateFormated(TransferShipmentHeader."Posting Date"));
        AddToJason('StateName', GetStateCode(Location."State Code"));  //TransferShipmentHeader."Transfer-to Code"));
        AddToJason('FromCityPlace', Location.City);                        //TransferShipmentHeader."Transfer-to City");

        IF TransferShipmentHeader."Vechile No. Update Remark" = TransferShipmentHeader."Vechile No. Update Remark"::"Due to Break Down" THEN
            AddToJason('VehicleReason', 'due to break down')
        ELSE
            IF TransferShipmentHeader."Vechile No. Update Remark" = TransferShipmentHeader."Vechile No. Update Remark"::"Due to Transhipment" THEN
                AddToJason('VehicleReason', 'due to Transhipment')
            ELSE
                IF TransferShipmentHeader."Vechile No. Update Remark" = TransferShipmentHeader."Vechile No. Update Remark"::"First Time" THEN
                    AddToJason('VehicleReason', 'first time')
                ELSE
                    IF TransferShipmentHeader."Vechile No. Update Remark" = TransferShipmentHeader."Vechile No. Update Remark"::Others THEN BEGIN
                        AddToJason('VehicleReason', 'Others');
                        AddToJason('VehicleReason', 'vehicle broke down');
                    END;
        AddToJason('Remarks', '');

        /* JsonTextWriter.WriteEndObject;
        EndJason;
        GetJason;
        IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
            ERASE(GetClientFile + 'J.txt');
        FL.CREATE(GetClientFile + 'J.txt');
        FL.CREATEOUTSTREAM(OutStrm);
        OutStrm.WRITETEXT(FORMAT(Json));
        FL.CLOSE;
        IF CONFIRM('Do you wanna View JSON') THEN
            MESSAGE('%1', Json);

        HttpWebRequestMgt.Initialize('http://182.76.79.236:35001/EWBTPApi-UAT/EwayBill/');
        HttpWebRequestMgt.DisableUI;
        HttpWebRequestMgt.SetMethod('POST');
        HttpWebRequestMgt.SetReturnType('application/json');
        // HttpWebRequestMgt.SetContentType('application/json');
        HttpWebRequestMgt.AddHeader('PRIVATEKEY', 'AeeA1214A5fgHB543rg');
        HttpWebRequestMgt.AddHeader('PRIVATEVALUE', 'qBKLSB1psdsmgIEzyFOksLlTg');
        HttpWebRequestMgt.AddHeader('IP', '10.1.0.5');
        HttpWebRequestMgt.AddHeader('Content-Type', 'application/json');
        HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');

        // TmpBlob.INIT;
        //TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
        IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
            ResponseInStream_L.READ(ResponseText);
            Json := ResponseText;
            ReadJSon(Json, DataExch);
        END;
         */
        IF GetJsonNodeValue('Data..Remarks') = '' THEN BEGIN
            TransferShipmentHeader."Vehicle No." := TransferShipmentHeader."New Vechile No.";
            TransferShipmentHeader.MODIFY;
            MESSAGE('Vechile No. Updated')
        END ELSE
            ERROR('%1, in Document No. : ', GetJsonNodeValue('Data..Remarks'), TransferShipmentHeader."No.");
    end;

    [EventSubscriber(ObjectType::Page, 50237, 'CancelEwaySalesInvoiceEvent', '', false, false)]

    procedure CancelEWaySalesInvoice(SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        FL: File;
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        ResponseInStream_L: InStream;
        // HttpStatusCode_L: DotNet HttpStatusCode;
        // ResponseHeaders_L: DotNet NameValueCollection;
        DataExch: Record "Data Exch. Field";
        TknNo: Text[50];
        EWayBillNo: Text[30];
        EWayBillDateTime: Variant;
        EWayExpiryDateTime: Variant;
        SalesInvoiceHeader2: Record "Sales Invoice Header";
    begin
        IF rLocation.GET(SalesInvoiceHeader."Location Code") THEN;
        EWBUser := rLocation.Username;
        EWBPass := rLocation.Password;
        EWBAPIKey := rLocation.apiaccesskey;

        CompanyInformation.GET;
        SalesInvoiceHeader.TESTFIELD("E-Way Bill No.");
        SalesInvoiceHeader.TESTFIELD("Reason of Cancel");

        AddHeaderDetails;

        StartJason;
        /*  JsonTextWriter.WritePropertyName('ewaybills');
         JsonTextWriter.WriteStartArray;
         JsonTextWriter.WriteStartObject;
  */
        AddToJason('ewbNo', SalesInvoiceHeader."E-Way Bill No.");
        IF SalesInvoiceHeader."Reason of Cancel" = SalesInvoiceHeader."Reason of Cancel"::"Data Entry mistake" THEN
            AddToJason('cancelRsnCode', '1')
        ELSE
            IF SalesInvoiceHeader."Reason of Cancel" = SalesInvoiceHeader."Reason of Cancel"::Duplicate THEN
                AddToJason('cancelRsnCode', '2')
            ELSE
                IF SalesInvoiceHeader."Reason of Cancel" = SalesInvoiceHeader."Reason of Cancel"::"Order Cancelled" THEN
                    AddToJason('cancelRsnCode', '3')
                ELSE
                    IF SalesInvoiceHeader."Reason of Cancel" = SalesInvoiceHeader."Reason of Cancel"::Others THEN
                        AddToJason('cancelRsnCode', '4');
        AddToJason('cancelRmrk', 'Cancelled the order');

        // JsonTextWriter.WriteEndObject;

        EndJason;
        GetJason;
        /* IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
            ERASE(GetClientFile + 'J.txt');
        FL.CREATE(GetClientFile + 'J.txt');
        FL.CREATEOUTSTREAM(OutStrm);
        OutStrm.WRITETEXT(FORMAT(Json));
        FL.CLOSE;
        MESSAGE('%1', Json);
         *///Old>>
           //HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/intg/ewbmsapi/v1.0/cancel');//TestOldKeshav05022021
           //HttpWebRequestMgt.Initialize('https://eapi.eyasp.com/ewbms/v1.0/cancel');//Prod
           //Old<<

        //HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/einvoiceapi/v1.0/cancelEWB');//TestNewKeshav05022021
        /*   HttpWebRequestMgt.Initialize('https://eapi.eyasp.com/eapi/v1.0/cancelEWB');//Prod_NewKeshav05022021
          HttpWebRequestMgt.DisableUI;
          HttpWebRequestMgt.SetMethod('POST');
          HttpWebRequestMgt.SetReturnType('application/json');
          // HttpWebRequestMgt.SetContentType('application/json');
          HttpWebRequestMgt.AddHeader('accesstoken', access_token);
          HttpWebRequestMgt.AddHeader('apiaccesskey', EWBAPIKey);//'l7xx1f28e29b18a64623aef38dcf4f9b1ac3');
          HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');

          // TmpBlob.INIT;
          //TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
          IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
              ResponseInStream_L.READ(ResponseText);
              Json := ResponseText;
              //  MESSAGE('%1',ResponseText);
              ReadJSon(Json, DataExch);
   */
        EWayBillNo := GetJsonNodeValue('data.success..ewb');
        //  EWayBillDateTime :=GetJsonNodeValue ('results.message.cancelDate');
        // END;
        IF GetJsonNodeValue('data.error..errorDesc') = '' THEN BEGIN
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
            ERROR('%1', GetJsonNodeValue('data.error..errorDesc'));
    end;

    [EventSubscriber(ObjectType::Page, 50238, 'CancelEwayReturnEvent', '', false, false)]

    procedure CancelEWayReturn(PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    var
        FL: File;
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        ResponseInStream_L: InStream;
        // HttpStatusCode_L: DotNet HttpStatusCode;
        // ResponseHeaders_L: DotNet NameValueCollection;
        DataExch: Record "Data Exch. Field";
        TknNo: Text[50];
        EWayBillNo: Text[30];
        EWayBillDateTime: Variant;
        EWayExpiryDateTime: Variant;
        PurchCrMemoHdr2: Record "Purch. Cr. Memo Hdr.";
    begin
        IF rLocation.GET(PurchCrMemoHdr."Location Code") THEN;
        EWBUser := rLocation.Username;
        EWBPass := rLocation.Password;
        EWBAPIKey := rLocation.apiaccesskey;

        CompanyInformation.GET;
        PurchCrMemoHdr.TESTFIELD("E-Way Bill No.");
        PurchCrMemoHdr.TESTFIELD("Reason of Cancel");
        AddHeaderDetails;

        StartJason;
        /* JsonTextWriter.WritePropertyName('ewaybills');
        JsonTextWriter.WriteStartArray;
        JsonTextWriter.WriteStartObject;
 */
        AddToJason('ewbNo', PurchCrMemoHdr."E-Way Bill No.");
        IF PurchCrMemoHdr."Reason of Cancel" = PurchCrMemoHdr."Reason of Cancel"::"Data Entry mistake" THEN
            AddToJason('cancelRsnCode', '1')
        ELSE
            IF PurchCrMemoHdr."Reason of Cancel" = PurchCrMemoHdr."Reason of Cancel"::Duplicate THEN
                AddToJason('cancelRsnCode', '2')
            ELSE
                IF PurchCrMemoHdr."Reason of Cancel" = PurchCrMemoHdr."Reason of Cancel"::"Order Cancelled" THEN
                    AddToJason('cancelRsnCode', '3')
                ELSE
                    IF PurchCrMemoHdr."Reason of Cancel" = PurchCrMemoHdr."Reason of Cancel"::Others THEN
                        AddToJason('cancelRsnCode', '4');
        AddToJason('cancelRmrk', 'Cancelled the order');

        // JsonTextWriter.WriteEndObject;

        EndJason;
        GetJason;
        /*   IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
              ERASE(GetClientFile + 'J.txt');
          FL.CREATE(GetClientFile + 'J.txt');
          FL.CREATEOUTSTREAM(OutStrm);
          OutStrm.WRITETEXT(FORMAT(Json));
          FL.CLOSE;
         */  // MESSAGE('%1',Json);
             // HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/intg/ewbmsapi/v1.0/cancel');//Test
             /*   HttpWebRequestMgt.Initialize('https://eapi.eyasp.com/ewbms/v1.0/cancel');//Prod
               HttpWebRequestMgt.DisableUI;
               HttpWebRequestMgt.SetMethod('POST');
               HttpWebRequestMgt.SetReturnType('application/json');
               // HttpWebRequestMgt.SetContentType('application/json');
               HttpWebRequestMgt.AddHeader('accesstoken', access_token);
               HttpWebRequestMgt.AddHeader('apiaccesskey', EWBAPIKey);//'l7xx1f28e29b18a64623aef38dcf4f9b1ac3');
               HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');

              */  // TmpBlob.INIT;
                  //TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
                  /* IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
                      ResponseInStream_L.READ(ResponseText);
                      Json := ResponseText;
                      //  MESSAGE('%1',ResponseText);
                      ReadJSon(Json, DataExch);

                      EWayBillNo := GetJsonNodeValue('data.success..ewb');
                      //  EWayBillDateTime :=GetJsonNodeValue ('results.message.cancelDate');
                  END;
                   */
        IF GetJsonNodeValue('data.error..errorDesc') = '' THEN BEGIN
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
            ERROR('%1', GetJsonNodeValue('data.error..errorDesc'));
    end;

    // 15578[EventSubscriber(ObjectType::Page, 50239, 'CancelEwayTransferEvent', '', false, false)]

    procedure CancelEWayTransfer(TransferShipmentHeader: Record "Transfer Shipment Header")
    var
        FL: File;
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        ResponseInStream_L: InStream;
        /*   HttpStatusCode_L: DotNet HttpStatusCode;
          ResponseHeaders_L: DotNet NameValueCollection;
         */
        DataExch: Record "Data Exch. Field";
        TknNo: Text[50];
        EWayBillNo: Text[30];
        EWayBillDateTime: Variant;
        EWayExpiryDateTime: Variant;
        TransferShipmentHeader2: Record "Transfer Shipment Header";
    begin
        IF rLocation.GET(TransferShipmentHeader."Transfer-from Code") THEN;
        EWBUser := rLocation.Username;
        EWBPass := rLocation.Password;
        EWBAPIKey := rLocation.apiaccesskey;

        CompanyInformation.GET;
        TransferShipmentHeader.TESTFIELD("E-Way Bill No.");
        TransferShipmentHeader.TESTFIELD("Reason of Cancel");
        AddHeaderDetails;
        StartJason;
        /*    JsonTextWriter.WritePropertyName('ewaybills');
           JsonTextWriter.WriteStartArray;
           JsonTextWriter.WriteStartObject;

         */
        AddToJason('ewbNo', TransferShipmentHeader."E-Way Bill No.");
        IF TransferShipmentHeader."Reason of Cancel" = TransferShipmentHeader."Reason of Cancel"::"Data Entry mistake" THEN
            AddToJason('cancelRsnCode', '1')
        ELSE
            IF TransferShipmentHeader."Reason of Cancel" = TransferShipmentHeader."Reason of Cancel"::Duplicate THEN
                AddToJason('cancelRsnCode', '2')
            ELSE
                IF TransferShipmentHeader."Reason of Cancel" = TransferShipmentHeader."Reason of Cancel"::"Order Cancelled" THEN
                    AddToJason('cancelRsnCode', '3')
                ELSE
                    IF TransferShipmentHeader."Reason of Cancel" = TransferShipmentHeader."Reason of Cancel"::Others THEN
                        AddToJason('cancelRsnCode', '4');
        AddToJason('cancelRmrk', 'Cancelled the order');

        /* JsonTextWriter.WriteEndObject;

        EndJason;
        GetJason;
        IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
            ERASE(GetClientFile + 'J.txt');
        FL.CREATE(GetClientFile + 'J.txt');
        FL.CREATEOUTSTREAM(OutStrm);
        OutStrm.WRITETEXT(FORMAT(Json));
        FL.CLOSE;
         */// MESSAGE('%1',Json);
           //Old>>
           //HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/intg/ewbmsapi/v1.0/cancel');//Test
           //HttpWebRequestMgt.Initialize('https://eapi.eyasp.com/ewbms/v1.0/cancel');//Prod
           //Old<<
           //HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/einvoiceapi/v1.0/cancelEWB');//TestNewKeshav05022021
           /*   HttpWebRequestMgt.Initialize('https://eapi.eyasp.com/eapi/v1.0/cancelEWB');//Prod_NewKeshav05022021

             HttpWebRequestMgt.DisableUI;
             HttpWebRequestMgt.SetMethod('POST');
             HttpWebRequestMgt.SetReturnType('application/json');
             // HttpWebRequestMgt.SetContentType('application/json');
             HttpWebRequestMgt.AddHeader('accesstoken', access_token);
             HttpWebRequestMgt.AddHeader('apiaccesskey', EWBAPIKey);//'l7xx1f28e29b18a64623aef38dcf4f9b1ac3');
             HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');

             // TmpBlob.INIT;
             //TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
             IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
                 ResponseInStream_L.READ(ResponseText);
                 Json := ResponseText;
                 //  MESSAGE('%1',ResponseText);
                 ReadJSon(Json, DataExch);

                 EWayBillNo := GetJsonNodeValue('data.success..ewb');
                 //  EWayBillDateTime :=GetJsonNodeValue ('results.message.cancelDate');
             END;
            */
        IF GetJsonNodeValue('data.error..errorDesc') = '' THEN BEGIN
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
            ERROR('%1', GetJsonNodeValue('data.error..errorDesc'));
    end;

    local procedure GetDateFormated(Originaldate: Date): Text
    var
        Day: Text[2];
        mnth: Text[2];
    begin
        IF DATE2DMY(Originaldate, 2) > 9 THEN
            mnth := FORMAT(DATE2DMY(Originaldate, 2))
        ELSE
            mnth := '0' + FORMAT(DATE2DMY(Originaldate, 2));

        IF DATE2DMY(Originaldate, 1) > 9 THEN
            Day := FORMAT(DATE2DMY(Originaldate, 1))
        ELSE
            Day := '0' + FORMAT(DATE2DMY(Originaldate, 1));

        EXIT(Day + '/' + mnth + '/' + FORMAT(DATE2DMY(Originaldate, 3)));
    end;

    local procedure GetGSTIN(LocCode: Code[20]): Text
    var
        Location: Record Location;
        CompanyInformation: Record "Company Information";
    begin
        IF Location.GET(LocCode) THEN BEGIN
            Location.TESTFIELD("GST Registration No.");
            EXIT(Location."GST Registration No.");
        END;
        CompanyInformation.GET;
        EXIT(CompanyInformation."GST Registration No.");
    end;

    local procedure InsertRequestId(RequestId: Text[250]; DocumentNo: Code[20])
    var
        EWayRequestID: Record "E-Way Request ID";
        EntryNo: Integer;
    begin
        EWayRequestID.RESET;
        IF EWayRequestID.FINDLAST THEN
            EntryNo := EWayRequestID."Entry No.";
        WITH EWayRequestID DO BEGIN
            "Entry No." := EntryNo + 1;
            "Document No." := DocumentNo;
            "Request Id" := RequestId;
            "Request Date" := WORKDATE;
            "Request Time" := TIME;
            INSERT;
        END;
    end;

    local procedure SaveCreatedManualJSON()
    var
        FL: File;
        OutStrm: OutStream;
        InStrm: InStream;
        FilePath: Text;
    begin
        GetJason;
        /*   IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
              ERASE(GetClientFile + 'J.txt');
          FL.CREATE(GetClientFile + 'J.txt');
          FL.CREATEOUTSTREAM(OutStrm);
          OutStrm.WRITETEXT(FORMAT(Json));
          FilePath := 'C:\' + 'E-way.JSON';
          FL.CREATEINSTREAM(InStrm);
          IF NOT DOWNLOADFROMSTREAM(InStrm, 'Save JSON file to', '', 'JSON File *.JSON| *.json', FilePath) THEN//'Text File *.txt| *.txt',FilePath) THEN
              ERROR('Please save the file')
          ELSE
              MESSAGE('E-way Bill File Saved');
          FL.CLOSE;
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

    local procedure SyncEwayBillSalesInv(var DocNo: Code[20]; var GSTN_Generator: Code[20])
    var
        FL: File;
        OutStrm: OutStream;
    begin

        StartJason;
        AddToJason('action', 'SYNCEWAYBILL');
        /*    JsonTextWriter.WritePropertyName('Data');
           JsonTextWriter.WriteStartArray;
           JsonTextWriter.WriteStartObject;

           AddToJason('GENERATOR_GSTIN', '05AAACE3061A1ZH');
           AddToJason('DOC_NO', DocNo);
           AddToJason('DOC_TYPE', 'Tax Invoice');
           JsonTextWriter.WriteEndObject;
           EndJason;

           GetJason;
           IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
               ERASE(GetClientFile + 'J.txt');
           FL.CREATE(GetClientFile + 'J.txt');
           FL.CREATEOUTSTREAM(OutStrm);
           OutStrm.WRITETEXT(FORMAT(Json));
           FL.CLOSE;
           IF CONFIRM('Do you want view the JSON') THEN
               MESSAGE('%1', Json);

           HttpWebRequestMgt.Initialize('http://182.76.79.236:35001/EWBTPApi-UAT/EwayBill/'); //Test
           HttpWebRequestMgt.DisableUI;
           HttpWebRequestMgt.SetMethod('POST');
           HttpWebRequestMgt.SetReturnType('application/json');
           // HttpWebRequestMgt.SetContentType('application/json');
           HttpWebRequestMgt.AddHeader('PRIVATEKEY', 'AeeA1214A5fgHB543rg');
           HttpWebRequestMgt.AddHeader('PRIVATEVALUE', 'qBKLSB1psdsmgIEzyFOksLlTg');
           HttpWebRequestMgt.AddHeader('IP', '10.1.0.5');
           HttpWebRequestMgt.AddHeader('Content-Type', 'application/json');
           HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
       */
    end;

    // 15578  [EventSubscriber(ObjectType::Page, 50237, 'CreateJSONSalesInvEventViaIRN', '', false, false)]

    procedure CreateJsonSalesInvViaIRN(SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        CustomerL: Record Customer;
        SalesInvoiceLineL: Record "Sales Invoice Line";
        ShiptoAddressL: Record "Ship-to Address";
        CustGstin: Code[15];
        TknNo: Text[50];
        SalesInvoiceHeader2: Record "Sales Invoice Header";
        ResponseInStream_L: InStream;
        /*     HttpStatusCode_L: DotNet HttpStatusCode;
            ResponseHeaders_L: DotNet NameValueCollection;
         */
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        DataExch: Record "Data Exch. Field";
        EWayBillNo: Text[30];
        EWayBillDateTime: Variant;
        EWayExpiryDateTime: Variant;
        FL: File;
        Mnth: Text[2];
        Day: Text[2];
        TransportMethod: Record "Transport Method";
        Location: Record Location;
        State_Gst: Code[2];
        State_rec: Record State;
        EWayURL: Text[250];
        ShiptoAddress: Record "Ship-to Address";
        ItemCategory: Record "Item Category";
        Vendor: Record Vendor;
        RequestId: Text;
        DocNo: Code[20];
        GSTN_Generator: Code[20];
    begin
        IF rLocation.GET(SalesInvoiceHeader."Location Code") THEN;
        EWBUser := rLocation.Username;
        EWBPass := rLocation.Password;
        EWBAPIKey := rLocation.apiaccesskey;
        /*
        EWBUser := 'himanshu.jindal@orientbell.eyasp.in';
        EWBPass := 'T0JkaWdpZ3N0QDgx';
        EWBAPIKey := 'l7xx1f28e29b18a64623aef38dcf4f9b1ac3';
        */
        GetCompanyInfo;

        IF TransportMethod.GET(SalesInvoiceHeader."Transport Method") THEN;
        // IF ShippingAgent.GET(SalesInvoiceHeader."Shipping Agent Code") THEN;
        IF Location.GET(SalesInvoiceHeader."Location Code") THEN;
        TransportMethod.TESTFIELD("E-Way transport method");
        SalesInvoiceHeader.TESTFIELD("Vehicle No.");
        //SalesInvoiceHeader.TESTFIELD("Distance (Km)");
        SalesInvoiceHeader.TESTFIELD("E-Way Generated", FALSE);
        SalesInvoiceHeader.TESTFIELD("E-Way Bill No.", '');
        SalesInvoiceHeader.TESTFIELD("IRN Hash");
        //SalesInvoiceHeader.TESTFIELD("E-Way Transaction Type");//

        AddHeaderDetails;

        StartJason;
        // JsonTextWriter.WritePropertyName('invoices');
        // JsonTextWriter.WriteStartArray;
        // JsonTextWriter.WriteStartObject;

        AddToJason('irn', SalesInvoiceHeader."IRN Hash");
        AddToJason('suppGstin', SalesInvoiceHeader."Location GST Reg. No.");
        // AddToJason('suppGstin','29AAACO0305P1ZD');//Test
        AddToJason('docNo', SalesInvoiceHeader."No.");
        AddToJason('docDate', SalesInvoiceHeader."Posting Date");
        AddToJason('docType', 'INV');

        IF Vendor.GET(SalesInvoiceHeader."Transporter's Name") THEN;
        IF Vendor.Transporter1 THEN
            AddToJason('transporterId', Vendor."GST No.")
        ELSE
            AddToJason('transporterId', Vendor."GST Registration No.");

        AddToJason('transporterName', SalesInvoiceHeader."Transporter Name");

        AddToJason('transportMode', TransportMethod."E-Way transport method");//SalesInvoiceHeader."Mode of Transport");
        AddToJason('transportDocNo', SalesInvoiceHeader."GR No.");
        AddToJason('transportDocDate', FORMAT(SalesInvoiceHeader."GR Date", 0, '<Closing><Day,2>/<Month,2>/<Year4>'));
        IF SalesInvoiceHeader."Ship to Pin" = Location."Pin Code" THEN
            AddToJason('distance', '90')
        ELSE
            AddToJason('distance', SalesInvoiceHeader."Distance (Km)");
        AddToJason('vehicleNo', DELCHR(SalesInvoiceHeader."Vehicle No.", '=', ' ,/-<>  !@#$%^&*()_+{}'));
        AddToJason('vehicleType', 'R');
        // JsonTextWriter.WriteEndObject;
        EndJason;

        IF CONFIRM('Do you want instant generate the E-way') THEN BEGIN
            //  GenerateEWay('');
            GetJason;
            /*    IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
                   ERASE(GetClientFile + 'J.txt');
               FL.CREATE(GetClientFile + 'J.txt');
               FL.CREATEOUTSTREAM(OutStrm);
               OutStrm.WRITETEXT(FORMAT(Json));
               FL.CLOSE;
               IF CONFIRM('Do you want view the JSON') THEN
                   MESSAGE('%1', Json);
               ServicePointManager.SecurityProtocol(SecurityProtocol.Tls12); // new line
                                                                             //Header for EWB Json----
                                                                             //HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/einvoiceapi/v1.0/generateEWBfromIRN'); //Test
               HttpWebRequestMgt.Initialize('https://eapi.eyasp.com/eapi/v1.0/generateEWBfromIRN');//Prod via irn

               HttpWebRequestMgt.DisableUI;
               HttpWebRequestMgt.SetMethod('POST');
               HttpWebRequestMgt.SetReturnType('application/json');
               HttpWebRequestMgt.AddHeader('accesstoken', access_token);
               //HttpWebRequestMgt.AddHeader('apiaccesskey','l7xx1f28e29b18a64623aef38dcf4f9b1ac3');
               HttpWebRequestMgt.AddHeader('apiaccesskey', EWBAPIKey);
               HttpWebRequestMgt.AddHeader('Content-Type', 'application/json');
               HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');

               //  TmpBlob.INIT;
               //TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
               IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
                   ResponseInStream_L.READ(ResponseText);
                   Json := ResponseText;

                   ReadJSon(Json, DataExch);
             */
            IF GetJsonNodeValue('status') <> '1' THEN
                ERROR('Error Code : %1, Error Message : %2, in Document No. %3', GetJsonNodeValue('errorDetails..errorCode'),
                        GetJsonNodeValue('errorDetails..errorDesc'), GetJsonNodeValue('docNo'));

            EWayBillNo := GetJsonNodeValue('EwbNo');
            EWayBillDateTime := GetJsonNodeValue('EwbDt');
            EWayExpiryDateTime := GetJsonNodeValue('EwbValidTill');

            IF GetJsonNodeValue('status') = '1' THEN BEGIN

                SalesInvoiceHeader2.GET(SalesInvoiceHeader."No.");
                SalesInvoiceHeader2."E-Way Bill No." := FORMAT(EWayBillNo);
                SalesInvoiceHeader2."E-Way Bill Date" := EWayBillDateTime;
                SalesInvoiceHeader2."E-Way Bill Validity" := EWayExpiryDateTime;
                SalesInvoiceHeader2."E-Way Generated" := TRUE;
                SalesInvoiceHeader2."E-Way Canceled" := FALSE;
                //SalesInvoiceHeader2."E-Way URL" := EWayURL;
                //IF SalesInvoiceHeader2."E-Way-to generate" THEN
                //SalesInvoiceHeader2."E-Way-to generate" := FALSE; // Consolidation Case
                SalesInvoiceHeader2.MODIFY;
                MESSAGE('E-Way Bill Generated');

            END ELSE
                ERROR('%1', GetJsonNodeValue('errorDetails..errorDesc'));

        END ELSE BEGIN
            ERROR('Network Issue..');
        END;
    END;

    // end;

    [EventSubscriber(ObjectType::Page, 50237, 'DownloadEWBSalesInv', '', false, false)]
    local procedure DownloadEWBSalesInv(SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        FL: File;
        OutStrm: OutStream;
        ResponseInStream_L: InStream;
        /*   HttpStatusCode_L: DotNet HttpStatusCode;
          ResponseHeaders_L: DotNet NameValueCollection;
         */
        ResponseText: Text;
        DataExch: Record "Data Exch. Field";
        EWayBillNo: Text[30];
        EWayBillDateTime: Variant;
        EWayExpiryDateTime: Variant;
        FileManagement: Codeunit "File Management";
    begin
        IF rLocation.GET(SalesInvoiceHeader."Location Code") THEN;
        EWBUser := rLocation.Username;
        EWBPass := rLocation.Password;
        EWBAPIKey := rLocation.apiaccesskey;

        CompanyInformation.GET;
        AddHeaderDetails;

        StartJason;
        /*     JsonTextWriter.WritePropertyName('ewbNos');
            JsonTextWriter.WriteStartArray;
            JsonTextWriter.WriteValue(SalesInvoiceHeader."E-Way Bill No.");
            JsonTextWriter.WriteEndArray;
         */    //Keshav
        IntVal := STRMENU('Details,Summary', 2);
        IF IntVal = 2 THEN BEGIN
            AddToJason('reportType', 'Summary')
        END ELSE
            IF IntVal = 1 THEN BEGIN
                AddToJason('reportType', 'Detail');
            END ELSE BEGIN
                EXIT;
            END;

        //Keshav
        EndJason;
        GetJason;
        /*    IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
               ERASE(GetClientFile + 'J.txt');
           FL.CREATE(GetClientFile + 'J.txt');
           FL.CREATEOUTSTREAM(OutStrm);
           OutStrm.WRITETEXT(FORMAT(Json));
           FL.CLOSE;
         */   // MESSAGE('%1',Json);
              //HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/intg/ewbmsapi/v1.0/downloadEWBPDF');//Test
              /*   HttpWebRequestMgt.Initialize('https://eapi.eyasp.com/ewbms/v1.0/downloadEWBPDF');//Prod
                HttpWebRequestMgt.DisableUI;
                HttpWebRequestMgt.SetMethod('POST');
                ServicePointManager.SecurityProtocol(SecurityProtocol.Tls12); //newline
                HttpWebRequestMgt.SetReturnType('application/json');
                HttpWebRequestMgt.AddHeader('accesstoken', access_token);
                HttpWebRequestMgt.AddHeader('apiaccesskey', EWBAPIKey);//'l7xx1f28e29b18a64623aef38dcf4f9b1ac3');
                HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');

                //  TmpBlob.INIT;
                //TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
                IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
                    ResponseInStream_L.READ(ResponseText);
                    Json := ResponseText;
                     //  ReadJSon(Json,DataExch);
                    // TmpBlob.INSERT;
                    //TmpBlob.CALCFIELDS(Blob);
                    // 15578    FileManagement.BLOBExport(TmpBlob, 'c:\' + SalesInvoiceHeader."No." + '.pdf', TRUE);
                END ELSE
                    ERROR('Not Responding');
        */
        IF GetJsonNodeValue('data.error..errorDesc') = '' THEN BEGIN

        END ELSE
            ERROR('%1', GetJsonNodeValue('data.error..errorDesc'));
    end;

    [EventSubscriber(ObjectType::Page, 50238, 'DownloadEWBPurchRetEvent', '', false, false)]
    local procedure DownloadEWBPurchaseRet(PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    var
        FL: File;
        OutStrm: OutStream;
        ResponseInStream_L: InStream;
        /*   HttpStatusCode_L: DotNet HttpStatusCode;
          ResponseHeaders_L: DotNet NameValueCollection; */
        ResponseText: Text;
        DataExch: Record "Data Exch. Field";
        EWayBillNo: Text[30];
        EWayBillDateTime: Variant;
        EWayExpiryDateTime: Variant;
        FileManagement: Codeunit "File Management";
    begin
        IF rLocation.GET(PurchCrMemoHdr."Location Code") THEN;
        EWBUser := rLocation.Username;
        EWBPass := rLocation.Password;
        EWBAPIKey := rLocation.apiaccesskey;

        CompanyInformation.GET;
        AddHeaderDetails;

        StartJason;
        /*   JsonTextWriter.WritePropertyName('ewbNos');
          JsonTextWriter.WriteStartArray;
          JsonTextWriter.WriteValue(PurchCrMemoHdr."E-Way Bill No.");
          JsonTextWriter.WriteEndArray; */
        AddToJason('reportType', 'Detail');
        EndJason;
        GetJason;
        /*    IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
               ERASE(GetClientFile + 'J.txt');
           FL.CREATE(GetClientFile + 'J.txt');
           FL.CREATEOUTSTREAM(OutStrm);
           OutStrm.WRITETEXT(FORMAT(Json));
           FL.CLOSE; */
        // MESSAGE('%1',Json);
        // HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/intg/ewbmsapi/v1.0/downloadEWBPDF');//Test
        /*   HttpWebRequestMgt.Initialize('https://eapi.eyasp.com/ewbms/v1.0/downloadEWBPDF');//Prod
          HttpWebRequestMgt.DisableUI;
          HttpWebRequestMgt.SetMethod('POST');
          ServicePointManager.SecurityProtocol(SecurityProtocol.Tls12); //newline
          HttpWebRequestMgt.SetReturnType('application/json');
          HttpWebRequestMgt.AddHeader('accesstoken', access_token);
          HttpWebRequestMgt.AddHeader('apiaccesskey', EWBAPIKey);//'l7xx1f28e29b18a64623aef38dcf4f9b1ac3');
          HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');

          // TmpBlob.INIT;
          //TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
          IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
              ResponseInStream_L.READ(ResponseText);
              Json := ResponseText; 
              //  ReadJSon(Json,DataExch);
              //  TmpBlob.INSERT;
              //            TmpBlob.CALCFIELDS(Blob);
              // 15578    FileManagement.BLOBExport(TmpBlob, 'c:\' + PurchCrMemoHdr."No." + '.pdf', TRUE);
          END ELSE
              ERROR('Not Responding');*/

        IF GetJsonNodeValue('data.error..errorDesc') = '' THEN BEGIN

        END ELSE
            ERROR('%1', GetJsonNodeValue('data.error..errorDesc'));
    end;

    // 15578  [EventSubscriber(ObjectType::Page, 50239, 'PrintEWBTransferShipEvent', '', false, false)]
    local procedure DownloadEWBTransferShip(var TransferShipmentHeaderL: Record "Transfer Shipment Header")
    var
        FL: File;
        OutStrm: OutStream;
        ResponseInStream_L: InStream;
        // HttpStatusCode_L: DotNet HttpStatusCode;
        // ResponseHeaders_L: DotNet NameValueCollection;
        ResponseText: Text;
        DataExch: Record "Data Exch. Field";
        EWayBillNo: Text[30];
        EWayBillDateTime: Variant;
        EWayExpiryDateTime: Variant;
        FileManagement: Codeunit "File Management";
    begin
        IF rLocation.GET(TransferShipmentHeaderL."Transfer-from Code") THEN;
        EWBUser := rLocation.Username;
        EWBPass := rLocation.Password;
        EWBAPIKey := rLocation.apiaccesskey;

        CompanyInformation.GET;
        AddHeaderDetails;

        StartJason;
        /*     JsonTextWriter.WritePropertyName('ewbNos');
            JsonTextWriter.WriteStartArray;
            JsonTextWriter.WriteValue(TransferShipmentHeaderL."E-Way Bill No.");
            JsonTextWriter.WriteEndArray; */
        AddToJason('reportType', 'Detail');
        EndJason;
        GetJason;
        /*    IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
               ERASE(GetClientFile + 'J.txt');
           FL.CREATE(GetClientFile + 'J.txt');
           FL.CREATEOUTSTREAM(OutStrm);
           OutStrm.WRITETEXT(FORMAT(Json));
           FL.CLOSE; */
        // MESSAGE('%1',Json);
        //HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/intg/ewbmsapi/v1.0/downloadEWBPDF');//Test
        /*   HttpWebRequestMgt.Initialize('https://eapi.eyasp.com/ewbms/v1.0/downloadEWBPDF');//Prod
          HttpWebRequestMgt.DisableUI;
          HttpWebRequestMgt.SetMethod('POST');
          ServicePointManager.SecurityProtocol(SecurityProtocol.Tls12); //newline
          HttpWebRequestMgt.SetReturnType('application/json');
          HttpWebRequestMgt.AddHeader('accesstoken', access_token);
          HttpWebRequestMgt.AddHeader('apiaccesskey', EWBAPIKey);//'l7xx1f28e29b18a64623aef38dcf4f9b1ac3');
          HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');

          // TmpBlob.INIT;
          //TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
          IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
              ResponseInStream_L.READ(ResponseText);
              Json := ResponseText;
              //  ReadJSon(Json,DataExch);
              //  TmpBlob.INSERT;
              //TmpBlob.CALCFIELDS(Blob);
              // 15578    FileManagement.BLOBExport(TmpBlob, 'c:\' + TransferShipmentHeaderL."No." + '.pdf', TRUE);
          END ELSE
              ERROR('Not Responding');
   */
        IF GetJsonNodeValue('data.error..errorDesc') = '' THEN BEGIN

        END ELSE
            ERROR('%1', GetJsonNodeValue('data.error..errorDesc'));
    end;

    local procedure GetGSTAmountLine(DocNo: Code[20]; CompCode: Code[10]; DocLine: Integer): Decimal
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        GSTAmt: Decimal;
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        CGSTPer: Decimal;
        IGSTPer: Decimal;
        SGSTPer: Decimal;
        CessPer: Decimal;
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

    local procedure CalculateTCSAmt(DocNo: Code[20]) TCSAmt: Decimal
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.RESET;
        SalesInvoiceLine.SETFILTER("Document No.", '%1', DocNo);
        IF SalesInvoiceLine.FINDFIRST THEN
            REPEAT
            // 15578   TCSAmt += SalesInvoiceLine."Total TDS/TCS Incl. SHE CESS";
            UNTIL SalesInvoiceLine.NEXT = 0;
    end;

    // 15578   [EventSubscriber(ObjectType::Page, 50239, 'CreateJSONTransferShipmentEventViaIRN', '', false, false)]

    procedure CreateJsonTrfInvViaIRN(var TransferShipmentHeaderL: Record "Transfer Shipment Header")
    var
        CustomerL: Record Customer;
        SalesInvoiceLineL: Record "Sales Invoice Line";
        ShiptoAddressL: Record "Ship-to Address";
        CustGstin: Code[15];
        TknNo: Text[50];
        SalesInvoiceHeader2: Record "Sales Invoice Header";
        ResponseInStream_L: InStream;
        /*    HttpStatusCode_L: DotNet HttpStatusCode;
           ResponseHeaders_L: DotNet NameValueCollection; */
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        DataExch: Record "Data Exch. Field";
        EWayBillNo: Text[30];
        EWayBillDateTime: Variant;
        EWayExpiryDateTime: Variant;
        FL: File;
        Mnth: Text[2];
        Day: Text[2];
        TransportMethod: Record "Transport Method";
        Location: Record Location;
        State_Gst: Code[2];
        State_rec: Record State;
        EWayURL: Text[250];
        ShiptoAddress: Record "Ship-to Address";
        ItemCategory: Record "Item Category";
        Vendor: Record Vendor;
        RequestId: Text;
        DocNo: Code[20];
        GSTN_Generator: Code[20];
        TransferShipmentHeaderL2: Record "Transfer Shipment Header";
    begin
        IF rLocation.GET(TransferShipmentHeaderL."Transfer-from Code") THEN;
        EWBUser := rLocation.Username;
        EWBPass := rLocation.Password;
        EWBAPIKey := rLocation.apiaccesskey;
        /*
        EWBUser := 'himanshu.jindal@orientbell.eyasp.in';
        EWBPass := 'T0JkaWdpZ3N0QDgx';
        EWBAPIKey := 'l7xx1f28e29b18a64623aef38dcf4f9b1ac3';
        */
        GetCompanyInfo;

        IF TransportMethod.GET(TransferShipmentHeaderL."Transport Method") THEN;
        // IF ShippingAgent.GET(TransferShipmentHeaderL."Shipping Agent Code") THEN;
        IF Location.GET(TransferShipmentHeaderL."Transfer-from Code") THEN;
        TransportMethod.TESTFIELD("E-Way transport method");
        TransferShipmentHeaderL.TESTFIELD("Truck No.");
        //SalesInvoiceHeader.TESTFIELD("Distance (Km)");
        TransferShipmentHeaderL.TESTFIELD("E-Way Generated", FALSE);
        TransferShipmentHeaderL.TESTFIELD("E-Way Bill No.", '');
        TransferShipmentHeaderL.TESTFIELD("IRN Hash");
        //SalesInvoiceHeader.TESTFIELD("E-Way Transaction Type");//

        AddHeaderDetails;

        StartJason;
        // JsonTextWriter.WritePropertyName('invoices');
        // JsonTextWriter.WriteStartArray;
        // JsonTextWriter.WriteStartObject;

        AddToJason('irn', TransferShipmentHeaderL."IRN Hash");
        AddToJason('suppGstin', Location."GST Registration No.");
        // AddToJason('suppGstin','29AAACO0305P1ZD');//Test
        AddToJason('docNo', TransferShipmentHeaderL."No.");
        AddToJason('docDate', TransferShipmentHeaderL."Posting Date");
        AddToJason('docType', 'INV');

        IF Vendor.GET(TransferShipmentHeaderL."Transporter's Name") THEN;
        IF Vendor.Transporter1 THEN BEGIN
            AddToJason('transporterId', Vendor."GST No.");
            AddToJason('transporterName', Vendor.Name);
        END ELSE BEGIN
            AddToJason('transporterId', Vendor."GST Registration No.");
            AddToJason('transporterName', Vendor.Name);
        END;



        AddToJason('transportMode', TransportMethod."E-Way transport method");//SalesInvoiceHeader."Mode of Transport");
        AddToJason('transportDocNo', TransferShipmentHeaderL."GR No.");
        AddToJason('transportDocDate', FORMAT(TransferShipmentHeaderL."GR Date", 0, '<Closing><Day,2>/<Month,2>/<Year4>'));
        // IF SalesInvoiceHeader."Ship to Pin" = Location."Pin Code" THEN
        //  AddToJason('distance','90')
        // ELSE
        //  AddToJason('distance',SalesInvoiceHeader."Distance (Km)");

        AddToJason('distance', TransferShipmentHeaderL."Distance (Km)");
        AddToJason('vehicleNo', DELCHR(TransferShipmentHeaderL."Truck No.", '=', ' ,/-<>  !@#$%^&*()_+{}'));
        AddToJason('vehicleType', 'R');
        // JsonTextWriter.WriteEndObject;
        EndJason;

        IF CONFIRM('Do you want instant generate the E-way') THEN BEGIN
            //  GenerateEWay('');
            GetJason;
            /*     IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
                    ERASE(GetClientFile + 'J.txt');
                FL.CREATE(GetClientFile + 'J.txt');
                FL.CREATEOUTSTREAM(OutStrm);
                OutStrm.WRITETEXT(FORMAT(Json));
                FL.CLOSE;
                IF CONFIRM('Do you want view the JSON') THEN
                    MESSAGE('%1', Json);
                ServicePointManager.SecurityProtocol(SecurityProtocol.Tls12); // new line
                                                                              //Header for EWB Json----
                                                                              //HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/einvoiceapi/v1.0/generateEWBfromIRN'); //Test
                HttpWebRequestMgt.Initialize('https://eapi.eyasp.com/eapi/v1.0/generateEWBfromIRN');//Prod via irn
                                                                                                    //HttpWebRequestMgt.Initialize('https://eapi.eyasp.com/eapi/v2.0/generateIRN');//Prod via irn

                HttpWebRequestMgt.DisableUI;
                HttpWebRequestMgt.SetMethod('POST');
                HttpWebRequestMgt.SetReturnType('application/json');
                HttpWebRequestMgt.AddHeader('accesstoken', access_token);
                //HttpWebRequestMgt.AddHeader('apiaccesskey','l7xx1f28e29b18a64623aef38dcf4f9b1ac3');
                HttpWebRequestMgt.AddHeader('apiaccesskey', EWBAPIKey);
                HttpWebRequestMgt.AddHeader('Content-Type', 'application/json');
                HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
     */
            // TmpBlob.INIT;
            //TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
            /*   IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
                  ResponseInStream_L.READ(ResponseText);
                  Json := ResponseText;

                  ReadJSon(Json, DataExch);
                  IF GetJsonNodeValue('status') <> '1' THEN */
            ERROR('Error Code : %1, Error Message : %2, in Document No. %3', GetJsonNodeValue('errorDetails..errorCode'),
                    GetJsonNodeValue('errorDetails..errorDesc'), GetJsonNodeValue('docNo'));

            EWayBillNo := GetJsonNodeValue('EwbNo');
            EWayBillDateTime := GetJsonNodeValue('EwbDt');
            EWayExpiryDateTime := GetJsonNodeValue('EwbValidTill');

            IF GetJsonNodeValue('status') = '1' THEN BEGIN

                TransferShipmentHeaderL2.GET(TransferShipmentHeaderL."No.");
                TransferShipmentHeaderL2."E-Way Bill No." := FORMAT(EWayBillNo);
                TransferShipmentHeaderL2."E-Way Bill Date" := EWayBillDateTime;
                TransferShipmentHeaderL2."E-Way Bill Validity" := EWayExpiryDateTime;
                TransferShipmentHeaderL2."E-Way Generated" := TRUE;
                TransferShipmentHeaderL2."E-Way Canceled" := FALSE;
                //SalesInvoiceHeader2."E-Way URL" := EWayURL;
                //IF SalesInvoiceHeader2."E-Way-to generate" THEN
                //SalesInvoiceHeader2."E-Way-to generate" := FALSE; // Consolidation Case
                TransferShipmentHeaderL2.MODIFY;
                MESSAGE('E-Way Bill Generated');

            END ELSE
                ERROR('%1', GetJsonNodeValue('errorDetails..errorDesc'));

        END ELSE BEGIN
            ERROR('Network Issue..');
        END;
        // END;

    end;

    // 15578 [EventSubscriber(ObjectType::Page, 50239, 'TroubleshootJSON', '', false, false)]

    procedure GenerateJsonTrfInvViaIRNForTroubleshoot(var TransferShipmentHeaderL: Record "Transfer Shipment Header")
    var
        CustomerL: Record Customer;
        SalesInvoiceLineL: Record "Sales Invoice Line";
        ShiptoAddressL: Record "Ship-to Address";
        CustGstin: Code[15];
        TknNo: Text[50];
        SalesInvoiceHeader2: Record "Sales Invoice Header";
        ResponseInStream_L: InStream;
        // HttpStatusCode_L: DotNet HttpStatusCode;
        // ResponseHeaders_L: DotNet NameValueCollection;
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        DataExch: Record "Data Exch. Field";
        EWayBillNo: Text[30];
        EWayBillDateTime: Variant;
        EWayExpiryDateTime: Variant;
        FL: File;
        Mnth: Text[2];
        Day: Text[2];
        TransportMethod: Record "Transport Method";
        Location: Record Location;
        State_Gst: Code[2];
        State_rec: Record State;
        EWayURL: Text[250];
        ShiptoAddress: Record "Ship-to Address";
        ItemCategory: Record "Item Category";
        Vendor: Record Vendor;
        RequestId: Text;
        DocNo: Code[20];
        GSTN_Generator: Code[20];
        TransferShipmentHeaderL2: Record "Transfer Shipment Header";
    begin
        IF rLocation.GET(TransferShipmentHeaderL."Transfer-from Code") THEN;
        EWBUser := rLocation.Username;
        EWBPass := rLocation.Password;
        EWBAPIKey := rLocation.apiaccesskey;
        /*
        EWBUser := 'himanshu.jindal@orientbell.eyasp.in';
        EWBPass := 'T0JkaWdpZ3N0QDgx';
        EWBAPIKey := 'l7xx1f28e29b18a64623aef38dcf4f9b1ac3';
        */
        GetCompanyInfo;

        IF TransportMethod.GET(TransferShipmentHeaderL."Transport Method") THEN;
        // IF ShippingAgent.GET(TransferShipmentHeaderL."Shipping Agent Code") THEN;
        IF Location.GET(TransferShipmentHeaderL."Transfer-from Code") THEN;
        TransportMethod.TESTFIELD("E-Way transport method");
        TransferShipmentHeaderL.TESTFIELD("Truck No.");
        //SalesInvoiceHeader.TESTFIELD("Distance (Km)");
        // TransferShipmentHeaderL.TESTFIELD("E-Way Generated",FALSE);
        // TransferShipmentHeaderL.TESTFIELD("E-Way Bill No.",'');
        TransferShipmentHeaderL.TESTFIELD("IRN Hash");
        //SalesInvoiceHeader.TESTFIELD("E-Way Transaction Type");//

        AddHeaderDetails;

        StartJason;
        // JsonTextWriter.WritePropertyName('invoices');
        // JsonTextWriter.WriteStartArray;
        // JsonTextWriter.WriteStartObject;

        AddToJason('irn', TransferShipmentHeaderL."IRN Hash");
        AddToJason('suppGstin', Location."GST Registration No.");
        // AddToJason('suppGstin','29AAACO0305P1ZD');//Test
        AddToJason('docNo', TransferShipmentHeaderL."No.");
        AddToJason('docDate', TransferShipmentHeaderL."Posting Date");
        AddToJason('docType', 'INV');

        IF Vendor.GET(TransferShipmentHeaderL."Transporter's Name") THEN;
        IF Vendor.Transporter1 THEN BEGIN
            AddToJason('transporterId', Vendor."GST No.");
            AddToJason('transporterName', Vendor.Name);
        END ELSE BEGIN
            AddToJason('transporterId', Vendor."GST Registration No.");
            AddToJason('transporterName', Vendor.Name);
        END;



        AddToJason('transportMode', TransportMethod."E-Way transport method");//SalesInvoiceHeader."Mode of Transport");
        AddToJason('transportDocNo', TransferShipmentHeaderL."GR No.");
        AddToJason('transportDocDate', FORMAT(TransferShipmentHeaderL."GR Date", 0, '<Closing><Day,2>/<Month,2>/<Year4>'));
        // IF SalesInvoiceHeader."Ship to Pin" = Location."Pin Code" THEN
        //  AddToJason('distance','90')
        // ELSE
        //  AddToJason('distance',SalesInvoiceHeader."Distance (Km)");

        AddToJason('distance', TransferShipmentHeaderL."Distance (Km)");
        AddToJason('vehicleNo', DELCHR(TransferShipmentHeaderL."Truck No.", '=', ' ,/-<>  !@#$%^&*()_+{}'));
        AddToJason('vehicleType', 'R');
        // JsonTextWriter.WriteEndObject;
        EndJason;

        GetJason;
        /*   IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
              ERASE(GetClientFile + 'J.txt');
          FL.CREATE(GetClientFile + 'J.txt');
          FL.CREATEOUTSTREAM(OutStrm);
          OutStrm.WRITETEXT(FORMAT(Json));
          FL.CLOSE;
          IF CONFIRM('Do you want view the JSON') THEN
              MESSAGE('%1', Json); */

    end;

    // 15578  [EventSubscriber(ObjectType::Page, 50237, 'TroubleShootJSON', '', false, false)]

    procedure GenerateJsonSalInvViaIRNForTroubleshoot(SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        CustomerL: Record Customer;
        SalesInvoiceLineL: Record "Sales Invoice Line";
        ShiptoAddressL: Record "Ship-to Address";
        CustGstin: Code[15];
        TknNo: Text[50];
        SalesInvoiceHeader2: Record "Sales Invoice Header";
        ResponseInStream_L: InStream;
        // HttpStatusCode_L: DotNet HttpStatusCode;
        // ResponseHeaders_L: DotNet NameValueCollection;
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        DataExch: Record "Data Exch. Field";
        EWayBillNo: Text[30];
        EWayBillDateTime: Variant;
        EWayExpiryDateTime: Variant;
        FL: File;
        Mnth: Text[2];
        Day: Text[2];
        TransportMethod: Record "Transport Method";
        Location: Record Location;
        State_Gst: Code[2];
        State_rec: Record State;
        EWayURL: Text[250];
        ShiptoAddress: Record "Ship-to Address";
        ItemCategory: Record "Item Category";
        Vendor: Record Vendor;
        RequestId: Text;
        DocNo: Code[20];
        GSTN_Generator: Code[20];
        TransferShipmentHeaderL2: Record "Transfer Shipment Header";
    begin
        IF rLocation.GET(SalesInvoiceHeader."Location Code") THEN;
        EWBUser := rLocation.Username;
        EWBPass := rLocation.Password;
        EWBAPIKey := rLocation.apiaccesskey;
        /*
        EWBUser := 'himanshu.jindal@orientbell.eyasp.in';
        EWBPass := 'T0JkaWdpZ3N0QDgx';
        EWBAPIKey := 'l7xx1f28e29b18a64623aef38dcf4f9b1ac3';
        */
        GetCompanyInfo;

        IF TransportMethod.GET(SalesInvoiceHeader."Transport Method") THEN;
        // IF ShippingAgent.GET(TransferShipmentHeaderL."Shipping Agent Code") THEN;
        IF Location.GET(SalesInvoiceHeader."Location Code") THEN;
        TransportMethod.TESTFIELD("E-Way transport method");
        SalesInvoiceHeader.TESTFIELD("Truck No.");
        //SalesInvoiceHeader.TESTFIELD("Distance (Km)");
        // TransferShipmentHeaderL.TESTFIELD("E-Way Generated",FALSE);
        // TransferShipmentHeaderL.TESTFIELD("E-Way Bill No.",'');
        SalesInvoiceHeader.TESTFIELD("IRN Hash");
        //SalesInvoiceHeader.TESTFIELD("E-Way Transaction Type");//

        AddHeaderDetails;

        StartJason;
        // JsonTextWriter.WritePropertyName('invoices');
        // JsonTextWriter.WriteStartArray;
        // JsonTextWriter.WriteStartObject;

        AddToJason('irn', SalesInvoiceHeader."IRN Hash");
        AddToJason('suppGstin', SalesInvoiceHeader."Location GST Reg. No.");
        // AddToJason('suppGstin','29AAACO0305P1ZD');//Test
        AddToJason('docNo', SalesInvoiceHeader."No.");
        AddToJason('docDate', SalesInvoiceHeader."Posting Date");
        AddToJason('docType', 'INV');

        IF Vendor.GET(SalesInvoiceHeader."Transporter's Name") THEN;
        IF Vendor.Transporter1 THEN BEGIN
            AddToJason('transporterId', Vendor."GST No.");
            AddToJason('transporterName', Vendor.Name);
        END ELSE BEGIN
            AddToJason('transporterId', Vendor."GST Registration No.");
            AddToJason('transporterName', Vendor.Name);
        END;



        AddToJason('transportMode', TransportMethod."E-Way transport method");//SalesInvoiceHeader."Mode of Transport");
        AddToJason('transportDocNo', SalesInvoiceHeader."GR No.");
        AddToJason('transportDocDate', FORMAT(SalesInvoiceHeader."GR Date", 0, '<Closing><Day,2>/<Month,2>/<Year4>'));
        // IF SalesInvoiceHeader."Ship to Pin" = Location."Pin Code" THEN
        //  AddToJason('distance','90')
        // ELSE
        //  AddToJason('distance',SalesInvoiceHeader."Distance (Km)");

        AddToJason('distance', SalesInvoiceHeader."Distance (Km)");
        AddToJason('vehicleNo', DELCHR(SalesInvoiceHeader."Truck No.", '=', ' ,/-<>  !@#$%^&*()_+{}'));
        AddToJason('vehicleType', 'R');
        // JsonTextWriter.WriteEndObject;
        EndJason;

        GetJason;
        /*   IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
              ERASE(GetClientFile + 'J.txt');
          FL.CREATE(GetClientFile + 'J.txt');
          FL.CREATEOUTSTREAM(OutStrm);
          OutStrm.WRITETEXT(FORMAT(Json));
          FL.CLOSE;
          IF CONFIRM('Do you want view the JSON') THEN
              MESSAGE('%1', Json); */

    end;


    procedure TroublenshootCancelEWaySalesInvoice(SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        FL: File;
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        ResponseInStream_L: InStream;
        // HttpStatusCode_L: DotNet HttpStatusCode;
        // ResponseHeaders_L: DotNet NameValueCollection;
        DataExch: Record "Data Exch. Field";
        TknNo: Text[50];
        EWayBillNo: Text[30];
        EWayBillDateTime: Variant;
        EWayExpiryDateTime: Variant;
        SalesInvoiceHeader2: Record "Sales Invoice Header";
    begin
        IF rLocation.GET(SalesInvoiceHeader."Location Code") THEN;
        EWBUser := rLocation.Username;
        EWBPass := rLocation.Password;
        EWBAPIKey := rLocation.apiaccesskey;

        CompanyInformation.GET;

        AddHeaderDetails;

        StartJason;
        /*    JsonTextWriter.WritePropertyName('ewaybills');
           JsonTextWriter.WriteStartArray;
           JsonTextWriter.WriteStartObject; */

        AddToJason('ewbNo', SalesInvoiceHeader."E-Way Bill No.");
        IF SalesInvoiceHeader."Reason of Cancel" = SalesInvoiceHeader."Reason of Cancel"::"Data Entry mistake" THEN
            AddToJason('cancelRsnCode', '1')
        ELSE
            IF SalesInvoiceHeader."Reason of Cancel" = SalesInvoiceHeader."Reason of Cancel"::Duplicate THEN
                AddToJason('cancelRsnCode', '2')
            ELSE
                IF SalesInvoiceHeader."Reason of Cancel" = SalesInvoiceHeader."Reason of Cancel"::"Order Cancelled" THEN
                    AddToJason('cancelRsnCode', '3')
                ELSE
                    IF SalesInvoiceHeader."Reason of Cancel" = SalesInvoiceHeader."Reason of Cancel"::Others THEN
                        AddToJason('cancelRsnCode', '4');
        AddToJason('cancelRmrk', 'Cancelled the order');

        /*  JsonTextWriter.WriteEndObject;

         EndJason;
         GetJason;
         IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
             ERASE(GetClientFile + 'J.txt');
         FL.CREATE(GetClientFile + 'J.txt');
         FL.CREATEOUTSTREAM(OutStrm);
         OutStrm.WRITETEXT(FORMAT(Json));
         FL.CLOSE;
         MESSAGE('%1', Json); */

        /*
        //Old>>
        //HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/intg/ewbmsapi/v1.0/cancel');//TestOldKeshav05022021
        //HttpWebRequestMgt.Initialize('https://eapi.eyasp.com/ewbms/v1.0/cancel');//Prod
        //Old<<
        
        //HttpWebRequestMgt.Initialize('https://einvoicesyncapi.eyasp.in/einvoiceapi/v1.0/cancelEWB');//TestNewKeshav05022021
        HttpWebRequestMgt.Initialize('https://eapi.eyasp.com/eapi/v1.0/cancelEWB');//Prod_NewKeshav05022021
        HttpWebRequestMgt.DisableUI;
        HttpWebRequestMgt.SetMethod('POST');
        HttpWebRequestMgt.SetReturnType('application/json');
        // HttpWebRequestMgt.SetContentType('application/json');
        HttpWebRequestMgt.AddHeader('accesstoken',access_token);
        HttpWebRequestMgt.AddHeader('apiaccesskey',EWBAPIKey);//'l7xx1f28e29b18a64623aef38dcf4f9b1ac3');
        HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');
        
        TmpBlob.INIT;
        TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
        IF HttpWebRequestMgt.GetResponse(ResponseInStream_L,HttpStatusCode_L,ResponseHeaders_L) THEN BEGIN
          ResponseInStream_L.READ(ResponseText);
          Json := ResponseText;
          //  MESSAGE('%1',ResponseText);
          ReadJSon(Json,DataExch);
        
          EWayBillNo := GetJsonNodeValue('data.success..ewb');
        //  EWayBillDateTime :=GetJsonNodeValue ('results.message.cancelDate');
        END;
        IF GetJsonNodeValue('data.error..errorDesc')='' THEN BEGIN
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
            ERROR('%1',GetJsonNodeValue('data.error..errorDesc'));
        */

    end;
}

