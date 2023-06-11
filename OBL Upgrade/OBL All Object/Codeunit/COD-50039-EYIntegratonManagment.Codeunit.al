codeunit 50039 "EY Integraton Managment"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        EYAIM_PurcahseRegister: Record EYAIM_PurcahseRegister;
    begin
        //GetReconcilationDetails('AAACO0305P');
        //GetReconcilationReport('1','100150870');
        //GetReconcilationReport('1','243590023');
        //GenratePurchaseRegisterJson;

        CASE REC."Parameter String" OF
            'SYNC PR DATA':
                SyncPRDataWithJobqueue;
            'RECODATA':
                SyncReconDataJobqueue;
        END;
    end;

    var
        /*  JSONTextWriter: DotNet JsonTextWriter;
         StringBuilder: DotNet StringBuilder;
         StringWriter: DotNet StringWriter;
         */
        RecRef: RecordRef;
        FRef: FieldRef;
        requestId: Text;

    /*  local procedure GenerateToken(var AccessToken: Text)
     var
         HttpWebRequest: DotNet HttpWebRequest;
         HttpWebResponse: DotNet HttpWebResponse;
         StreamReader: DotNet StreamReader;
         ResponseText: Text;
         DataExch: Record "Data Exch. Field";
         MessageText: Text;
         MessageText2: Text;
         JObject: DotNet JObject;
         PurchaseSetup: Record "Purchases & Payables Setup";
     begin
         //Error handling needed if API Fails otherwsie not working with Jobs will handle
         PurchaseSetup.GET;
         PurchaseSetup.TESTFIELD("EY Token URL");
         PurchaseSetup.TESTFIELD("EY Token User Name");
         PurchaseSetup.TESTFIELD("EY Toekn Password");
         PurchaseSetup.TESTFIELD("EY Api Access Key");
         HttpWebRequest := HttpWebRequest.Create(PurchaseSetup."EY Token URL");
         HttpWebRequest.Method := 'POST';
         HttpWebRequest.Headers.Add('username', PurchaseSetup."EY Token User Name");
         HttpWebRequest.Headers.Add('password', PurchaseSetup."EY Toekn Password");
         HttpWebRequest.Headers.Add('apiaccesskey', PurchaseSetup."EY Api Access Key");
         HttpWebResponse := HttpWebRequest.GetResponse;
         StreamReader := StreamReader.StreamReader(HttpWebResponse.GetResponseStream);
         ResponseText := StreamReader.ReadToEnd();
         StreamReader.Close();
         IF ResponseText <> '' THEN BEGIN
             JObject := JObject.Parse(ResponseText);
             AccessToken := JObject.GetValue('accessToken').ToString;
         END;
         IF AccessToken = '' THEN
             ERROR('somthing went wrong in token API');
     end;

  */
    /*  procedure ReadJSon(var String: DotNet String; var TempPostingExchField: Record "Data Exch. Field" temporary)
     var
         // JsonToken: DotNet JsonToken;
         PrefixArray: DotNet Array;
         PrefixString: DotNet String;
         PropertyName: Text;
         ColumnNo: Integer;
         InArray: array[1000] of Boolean;
         StringReader: DotNet StringReader;
         JsonTextReader: DotNet JsonTextReader;
     begin
         PrefixArray := PrefixArray.CreateInstance(GETDOTNETTYPE(String), 250);
         StringReader := StringReader.StringReader(String);
         JsonTextReader := JsonTextReader.JsonTextReader(StringReader);

          end;
  */
    local procedure CreateJSONAttribute(AttributeName: Text; Value: Variant)
    begin
        /*  JSONTextWriter.WritePropertyName(AttributeName);
         JSONTextWriter.WriteValue(Value); */
    end;


    procedure GetReconcilationDetails(panNo: Text): Text
    var
        ResponseText: Text;
        TextURL: Text;
        DataExch: Record "Data Exch. Field";
        // JObject: DotNet JObject;
        Text001: Text;
        // JObject2: DotNet JObject;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        //Error handling needed if API Fails otherwsie not working with Jobs will handle
        PurchasesPayablesSetup.GET;
        PurchasesPayablesSetup.TESTFIELD("EY Reconcilation Detail URL");

        //TextURL := ResourcesSetup."EY Reconcilation Detail URL"+'?'+'panNo='+P1+'&requestId='+P2+'&fromDate='+P3+'&toDate='+P4;
        TextURL := PurchasesPayablesSetup."EY Reconcilation Detail URL" + '?' + 'panNo=' + panNo;//+'&fromDate='+P3+'&toDate='+P4;
        /* IF CallingAPI(TextURL, ResponseText, 'GET', '', '') THEN BEGIN
            JObject := JObject.Parse(ResponseText);
            JObject2 := JObject2.Parse(DELCHR(JObject.GetValue('recReqDetails').ToString, '=', '[]'));
            requestId := JObject2.GetValue('requestId').ToString;
            //MESSAGE(requestId);
            EXIT(requestId);
        END; */
    end;


    procedure GetReconcilationReport(requestId: Text; fileCount: Text)
    var
        TextURL: Text;
        ResponseText: Text;
        PurchaseSetup: Record "Purchases & Payables Setup";
    begin
        //Error handling needed if API Fails otherwsie not working with Jobs will handle
        PurchaseSetup.GET;
        PurchaseSetup.TESTFIELD("EY Reconcilation Detail URL");
        TextURL := PurchaseSetup."EY Reconcilation Report URL" + '?' + 'requestId=' + requestId + '&fileCount=' + fileCount;
        //CallingAPI(TextURL,ResponseText,'GET','','');
        // CallingAPIForReconciliation(TextURL, ResponseText, 'GET', '', '');
    end;

    [TryFunction]
    local procedure CallingAPI(TextURL: Text; var ResponseText: Text; Method: Text; ContentType: Text; Body: Text)
    var
        /*  HttpWebRequest: DotNet HttpWebRequest;
         HttpWebResponse: DotNet HttpWebResponse;
         StreamReader: DotNet StreamReader;
         AccessToken: Text;
         Encoding: DotNet Encoding;
         Bytes: DotNet Array;
         TextString: DotNet String;
         */
        InputText: BigText;
        SubText: BigText;
        TextPosition: Integer;
        OutputText: BigText;
        TextToFind: Text;
        TextToReplace: BigText;
        LoopCount: Integer;
        EntryNo: Integer;
        GSTRecon: Record "EYAIM_ERP 108DFs Report";
        LineCount: Integer;
        PurchaseSetup: Record "Purchases & Payables Setup";
    begin
        //Error handling needed if API fails otherwsie not working with Jobs will handle
        PurchaseSetup.GET;
        PurchaseSetup.TESTFIELD("EY Api Access Key");
        /* GenerateToken(AccessToken);
        HttpWebRequest := HttpWebRequest.Create(TextURL);
        HttpWebRequest.Method := Method;
        HttpWebRequest.Headers.Add('accesstoken', AccessToken);
        HttpWebRequest.Headers.Add('apiaccesskey', PurchaseSetup."EY Api Access Key");
        IF ContentType <> '' THEN
            HttpWebRequest.ContentType := ContentType;
        IF Body <> '' THEN BEGIN
            TextString := STRSUBSTNO(Body);
            Encoding := Encoding.UTF8();
            Bytes := Encoding.GetEncoding('iso-8859-1').GetBytes(TextString.ToString);
            HttpWebRequest.ContentLength := TextString.Length;
            HttpWebRequest.GetRequestStream.Write(Bytes, 0, Bytes.Length);
        END;
        HttpWebResponse := HttpWebRequest.GetResponse;
        StreamReader := StreamReader.StreamReader(HttpWebResponse.GetResponseStream);
        ResponseText := StreamReader.ReadToEnd();
        StreamReader.Close(); */
    end;


    /*  procedure GenratePurchaseRegisterJson(var EYAIM_PurcahseRegister: Record EYAIM_PurcahseRegister)
     var
         JSON: DotNet String;
         ResponseText: Text[1024];
         EYAIM_PurcahseRegister2: Record EYAIM_PurcahseRegister;
         i: Integer;
         SubString: Text;
         DataExch: Record "Data Exch. Field";
         PRRequestData: BigText;
         OStream: OutStream;
         PRResponseData: BigText;
         PurchaseSetup: Record "Purchases & Payables Setup";
     begin
         //Error handling needed if API Fails mark status failed and retry mechanism otherwsie not working with Jobs will handle
         IF EYAIM_PurcahseRegister2.GET(EYAIM_PurcahseRegister.DocumentType, EYAIM_PurcahseRegister.DocumentNumber, EYAIM_PurcahseRegister."Line No.") THEN;
         PurchaseSetup.GET;
         PurchaseSetup.TESTFIELD("EY Purchase Register URL");
         StringBuilder := StringBuilder.StringBuilder;
         StringWriter := StringWriter.StringWriter(StringBuilder);
         JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);
         JSONTextWriter.WriteStartObject;
         JSONTextWriter.WritePropertyName('req');
         JSONTextWriter.WriteStartArray;
         JSONTextWriter.WriteStartObject;
         CreateJSONAttribute('userId', USERID);
         CreateJSONAttribute('srcFileName', '');
         CreateJSONAttribute('srcIdentifier', '');
         CreateJSONAttribute('returnPeriod', EYAIM_PurcahseRegister2.ReturnPeriod);
         CreateJSONAttribute('suppGstin', EYAIM_PurcahseRegister2.SupplierGSTIN);
         CreateJSONAttribute('docType', EYAIM_PurcahseRegister2.DocumentType);
         CreateJSONAttribute('docNo', EYAIM_PurcahseRegister2.DocumentNumber);
         CreateJSONAttribute('docDate', FORMAT(EYAIM_PurcahseRegister2.DocumentDate));
         CreateJSONAttribute('orgDocType', '');
         CreateJSONAttribute('crDrPreGst', '');
         CreateJSONAttribute('custGstin', EYAIM_PurcahseRegister2.CustomerGSTIN);
         CreateJSONAttribute('supType', '');
         CreateJSONAttribute('diffPercent', '');
         CreateJSONAttribute('orgSgstin', '');
         CreateJSONAttribute('custOrSupName', '');
         CreateJSONAttribute('supCode', '');
         CreateJSONAttribute('custOrSupAddr1', '');
         CreateJSONAttribute('custOrSupAddr2', '');
         CreateJSONAttribute('custOrSupAddr4', '');
         CreateJSONAttribute('billToState', '');
         CreateJSONAttribute('shipToState', '');
         CreateJSONAttribute('pos', '');
         CreateJSONAttribute('stateApplyingCess', '');
         CreateJSONAttribute('portCode', EYAIM_PurcahseRegister2.PortCode);
         CreateJSONAttribute('billOfEntry', EYAIM_PurcahseRegister2.BillOfEntry);
         CreateJSONAttribute('billOfEntryDate', FORMAT(EYAIM_PurcahseRegister2.BillOfEntryDate));
         CreateJSONAttribute('sec7OfIgstFlag', EYAIM_PurcahseRegister2.Section7OfIGSTFlag);
         CreateJSONAttribute('reverseCharge', EYAIM_PurcahseRegister2.ReverseChargeFlag);
         CreateJSONAttribute('tcsFlag', '');
         CreateJSONAttribute('ecomGSTIN', '');
         CreateJSONAttribute('claimRefundFlag', EYAIM_PurcahseRegister2.ClaimRefundFlag);
         CreateJSONAttribute('autoPopToRefundFlag', EYAIM_PurcahseRegister2.AutoPopulateToRefund);
         CreateJSONAttribute('accVoucherNo', '');
         CreateJSONAttribute('accVoucherDate', '');
         CreateJSONAttribute('ewbNo', '');
         CreateJSONAttribute('ewbDate', '');
         CreateJSONAttribute('irn', '');
         CreateJSONAttribute('irnDate', '');
         CreateJSONAttribute('taxScheme', '');
         CreateJSONAttribute('docCat', '');
         CreateJSONAttribute('supTradeName', '');
         CreateJSONAttribute('supLegalName', '');
         CreateJSONAttribute('supBuildingNo', '');
         CreateJSONAttribute('supBuildingName', '');
         CreateJSONAttribute('supLocation', '');
         CreateJSONAttribute('supPincode', '');
         CreateJSONAttribute('supStateCode', '');
         CreateJSONAttribute('supPhone', '');
         CreateJSONAttribute('supEmail', '');
         CreateJSONAttribute('custTradeName', '');
         CreateJSONAttribute('custPincode', '');
         CreateJSONAttribute('custEmail', '');
         CreateJSONAttribute('dispatcherGstin', '');
         CreateJSONAttribute('dispatcherTradeName', '');
         CreateJSONAttribute('dispatcherBuildingNo', '');
         CreateJSONAttribute('dispatcherBuildingName', '');
         CreateJSONAttribute('dispatcherLocation', '');
         CreateJSONAttribute('dispatcherPincode', '');
         CreateJSONAttribute('dispatcherStateCode', '');
         CreateJSONAttribute('shipToGstin', '');
         CreateJSONAttribute('shipToTradeName', '');
         CreateJSONAttribute('shipToLegalName', '');
         CreateJSONAttribute('shipToBuildingNo', '');
         CreateJSONAttribute('shipToBuildingName', '');
         CreateJSONAttribute('shipToLocation', '');
         CreateJSONAttribute('shipToPincode', '');
         CreateJSONAttribute('invOtherCharges', '');
         CreateJSONAttribute('invAssessableAmt', '');
         CreateJSONAttribute('invIgstAmt', '');
         CreateJSONAttribute('invCgstAmt', '');
         CreateJSONAttribute('invSgstAmt', '');
         CreateJSONAttribute('invCessAdvaloremAmt', '');
         CreateJSONAttribute('invCessSpecificAmt', '');
         CreateJSONAttribute('invStateCessAmt', '');
         CreateJSONAttribute('roundOff', '');
         CreateJSONAttribute('totalInvValueInWords', '');
         CreateJSONAttribute('foreignCurrency', '');
         CreateJSONAttribute('countryCode', '');
         CreateJSONAttribute('invValueFc', '');
         CreateJSONAttribute('invPeriodStartDate', '');
         CreateJSONAttribute('invPeriodEndDate', '');
         CreateJSONAttribute('payeeName', '');
         CreateJSONAttribute('modeOfPayment', '');
         CreateJSONAttribute('branchOrIfscCode', '');
         CreateJSONAttribute('paymentTerms', '');
         CreateJSONAttribute('paymentInstruction', '');
         CreateJSONAttribute('creditTransfer', '');
         CreateJSONAttribute('directDebit', '');
         CreateJSONAttribute('creditDays', '');
         CreateJSONAttribute('paymentDueDate', '');
         CreateJSONAttribute('accDetail', '');
         CreateJSONAttribute('tdsFlag', '');
         CreateJSONAttribute('tranType', '');
         CreateJSONAttribute('subsupplyType', '');
         CreateJSONAttribute('otherSupplyTypeDesc', '');
         CreateJSONAttribute('transporterID', '');
         CreateJSONAttribute('transporterName', '');
         CreateJSONAttribute('transportMode', '');
         CreateJSONAttribute('transportDocNo', '');
         CreateJSONAttribute('transportDocDate', '');
         CreateJSONAttribute('distance', '');
         CreateJSONAttribute('vehicleNo', '');
         CreateJSONAttribute('vehicleType', '');
         CreateJSONAttribute('exchangeRt', '');
         CreateJSONAttribute('companyCode', '');
         CreateJSONAttribute('glPostingDate', '');
         CreateJSONAttribute('invStateCessSpecificAmt', '');
         CreateJSONAttribute('tcsFlagIncomeTax', '');
         CreateJSONAttribute('glStateCessSpecific', '');
         CreateJSONAttribute('glCodeIgst', '');
         CreateJSONAttribute('glCodeCgst', '');
         CreateJSONAttribute('glCodeSgst', '');
         CreateJSONAttribute('glCodeAdvCess', '');
         CreateJSONAttribute('glCodeSpCess', '');
         CreateJSONAttribute('glCodeStateCess', '');
         CreateJSONAttribute('location', '');
         CreateJSONAttribute('division', '');
         CreateJSONAttribute('prchaseOrg', '');
         CreateJSONAttribute('profitCentre1', '');
         CreateJSONAttribute('profitCentre2', '');
         CreateJSONAttribute('invRemarks', '');
         CreateJSONAttribute('purOrdValue', '');
         JSONTextWriter.WritePropertyName('lineItems');
         JSONTextWriter.WriteStartArray;
         JSONTextWriter.WriteStartObject;
         CreateJSONAttribute('itemNo', '');
         CreateJSONAttribute('glCodeTaxableVal', '');
         CreateJSONAttribute('supplyType', EYAIM_PurcahseRegister2.SupplyType);
         CreateJSONAttribute('cif', '');
         CreateJSONAttribute('customDuty', '');
         CreateJSONAttribute('hsnsacCode', EYAIM_PurcahseRegister2.HSN);
         CreateJSONAttribute('productCode', EYAIM_PurcahseRegister2."Item Code");
         CreateJSONAttribute('itemDesc', '');
         CreateJSONAttribute('itemType', '');
         CreateJSONAttribute('itemUqc', '');
         CreateJSONAttribute('itemQty', '');
         CreateJSONAttribute('taxableVal', '');
         CreateJSONAttribute('igstRt', FORMAT(EYAIM_PurcahseRegister2.IGSTRate));
         CreateJSONAttribute('igstAmt', FORMAT(EYAIM_PurcahseRegister2.IGSTAmount));
         CreateJSONAttribute('cgstRt', FORMAT(EYAIM_PurcahseRegister2.CGSTRate));
         CreateJSONAttribute('cgstAmt', FORMAT(EYAIM_PurcahseRegister2.CGSTAmount));
         CreateJSONAttribute('sgstRt', FORMAT(EYAIM_PurcahseRegister2.SGSTRate));
         CreateJSONAttribute('sgstAmt', FORMAT(EYAIM_PurcahseRegister2.SGSTAmount));
         CreateJSONAttribute('cessRtAdvalorem', FORMAT(EYAIM_PurcahseRegister2.CessAdvaloremRate));
         CreateJSONAttribute('cessAmtAdvalorem', FORMAT(EYAIM_PurcahseRegister2.CessAdvaloremAmount));
         CreateJSONAttribute('cessRtSpecific', FORMAT(EYAIM_PurcahseRegister2.CessSpecificRate));
         CreateJSONAttribute('cessAmtSpecfic', FORMAT(EYAIM_PurcahseRegister2.CessSpecificAmount));
         CreateJSONAttribute('stateCessRt', FORMAT(EYAIM_PurcahseRegister2.StateCessAdvaloremRate));
         CreateJSONAttribute('stateCessAmt', FORMAT(EYAIM_PurcahseRegister2.StateCessAdvaloremRate));
         CreateJSONAttribute('otherValues', '');
         CreateJSONAttribute('lineItemAmt', FORMAT(EYAIM_PurcahseRegister2.ItemAssessableAmount));
         CreateJSONAttribute('tcsAmt', '');
         CreateJSONAttribute('crDrReason', '');
         CreateJSONAttribute('plantCode', '');
         CreateJSONAttribute('serialNoII', ''); // Check This node
         CreateJSONAttribute('productName', '');
         CreateJSONAttribute('isService', '');
         CreateJSONAttribute('barcode', '');
         CreateJSONAttribute('batchNameOrNo', '');
         CreateJSONAttribute('batchExpiryDate', '');
         CreateJSONAttribute('warrantyDate', '');
         CreateJSONAttribute('originCountry', '');
         CreateJSONAttribute('freeQuantity', '');
         CreateJSONAttribute('unitPrice', '');
         CreateJSONAttribute('itemAmt', '');
         CreateJSONAttribute('itemDiscount', '');
         CreateJSONAttribute('preTaxAmt', '');
         CreateJSONAttribute('totalItemAmt', '');
         CreateJSONAttribute('preceedingInvNo', '');
         CreateJSONAttribute('preceedingInvDate', '');
         CreateJSONAttribute('orderLineRef', '');
         CreateJSONAttribute('supportingDocURL', '');
         CreateJSONAttribute('supportingDocBase64', '');
         CreateJSONAttribute('tcsIgstAmnt', '');
         CreateJSONAttribute('tcsCgstAmt', '');
         CreateJSONAttribute('tcsSgstAmt', '');
         CreateJSONAttribute('tdsIgstAmt', '');
         CreateJSONAttribute('tdsCgstAmt', '');
         CreateJSONAttribute('tdsSgstAmt', '');
         CreateJSONAttribute('subDivision', '');
         CreateJSONAttribute('eligIndicator', FORMAT(EYAIM_PurcahseRegister2.EligibilityIndicator));
         CreateJSONAttribute('comnSupIndicator', '');
         CreateJSONAttribute('availIgst', FORMAT(EYAIM_PurcahseRegister2.AvailableIGST));
         CreateJSONAttribute('availCgst', FORMAT(EYAIM_PurcahseRegister2.AvailableCGST));
         CreateJSONAttribute('availSgst', FORMAT(EYAIM_PurcahseRegister2.AvailableSGST));
         CreateJSONAttribute('availCess', FORMAT(EYAIM_PurcahseRegister2.AvailableCess));
         CreateJSONAttribute('itcEntitlement', '');
         CreateJSONAttribute('itcRevIdentifier', '');
         CreateJSONAttribute('udf1', '');
         CreateJSONAttribute('udf2', '');
         CreateJSONAttribute('udf3', '');
         CreateJSONAttribute('udf4', '');
         CreateJSONAttribute('udf5', '');
         CreateJSONAttribute('udf6', '');
         CreateJSONAttribute('udf7', '');
         CreateJSONAttribute('udf8', '');
         CreateJSONAttribute('udf9', '');
         CreateJSONAttribute('udf10', '');
         CreateJSONAttribute('udf11', '');
         CreateJSONAttribute('udf12', '');
         CreateJSONAttribute('udf13', '');
         CreateJSONAttribute('udf14', '');
         CreateJSONAttribute('udf15', '');
         CreateJSONAttribute('udf16', '');
         CreateJSONAttribute('udf17', '');
         CreateJSONAttribute('udf18', '');
         CreateJSONAttribute('udf19', '');
         CreateJSONAttribute('udf20', '');
         CreateJSONAttribute('udf21', '');
         CreateJSONAttribute('udf22', '');
         CreateJSONAttribute('udf23', '');
         CreateJSONAttribute('udf24', '');
         CreateJSONAttribute('udf25', '');
         CreateJSONAttribute('udf26', '');
         CreateJSONAttribute('udf27', '');
         CreateJSONAttribute('udf28', '');
         CreateJSONAttribute('udf29', '');
         CreateJSONAttribute('udf30', '');
         CreateJSONAttribute('attributeName', '');
         CreateJSONAttribute('attributeValue', '');
         CreateJSONAttribute('stateCessSpecificRt', FORMAT(EYAIM_PurcahseRegister2.StateCessSpecificRate));
         CreateJSONAttribute('stateCessSpecificAmt', FORMAT(EYAIM_PurcahseRegister2.StateCessSpecificAmount));
         CreateJSONAttribute('tcsRtIncomeTax', '');
         CreateJSONAttribute('tcsAmtIncomeTax', '');
         CreateJSONAttribute('receiptAdviceDate', '');
         CreateJSONAttribute('addlInfo', '');
         CreateJSONAttribute('docRefNo', '');
         CreateJSONAttribute('receiptAdviceRef', '');
         CreateJSONAttribute('contractRef', '');
         CreateJSONAttribute('externalRef', '');
         CreateJSONAttribute('projectRef', '');
         CreateJSONAttribute('custPoRefNo', '');
         CreateJSONAttribute('invRef', '');
         CreateJSONAttribute('tenderRef', '');
         CreateJSONAttribute('paidAmt', '');
         CreateJSONAttribute('balanceAmt', '');
         CreateJSONAttribute('custPoRefDate', '');
         CreateJSONAttribute('profitCentre3', '');
         CreateJSONAttribute('profitCentre4', '');
         CreateJSONAttribute('profitCentre5', '');
         CreateJSONAttribute('profitCentre6', '');
         CreateJSONAttribute('profitCentre7', '');
         CreateJSONAttribute('profitCentre8', '');
         JSONTextWriter.WriteEndObject;
         JSONTextWriter.WriteEndArray;
         JSONTextWriter.WriteEndObject;
         JSONTextWriter.WriteEndArray;
         JSONTextWriter.WriteEndObject;
         JSON := StringBuilder.ToString();
         DataExch.DELETEALL;
         IF CallingAPI(PurchaseSetup."EY Purchase Register URL", ResponseText, 'POST', 'application/json', FORMAT(JSON)) THEN BEGIN
             DataExch.DELETEALL;
             // ReadJSon(ResponseText, DataExch);
             DataExch.RESET;
             DataExch.SETRANGE("Node ID", 'X_REQUEST_ID');
             IF DataExch.FINDFIRST THEN
                 EYAIM_PurcahseRegister2.X_REQUEST_ID := DataExch.Value;
             DataExch.RESET;
             DataExch.SETRANGE("Node ID", 'status');
             IF DataExch.FINDFIRST THEN
                 EYAIM_PurcahseRegister2.status := DataExch.Value;
             DataExch.RESET;
             DataExch.SETRANGE("Node ID", 'AckNo');
             IF DataExch.FINDFIRST THEN
                 EYAIM_PurcahseRegister2.AckNo := DataExch.Value;
             DataExch.RESET;
             DataExch.SETRANGE("Node ID", 'AckDt');
             IF DataExch.FINDFIRST THEN
                 EYAIM_PurcahseRegister2.AckDt := DataExch.Value;
             DataExch.RESET;
             DataExch.SETRANGE("Node ID", 'errorDetails');
             IF DataExch.FINDFIRST THEN
                 EYAIM_PurcahseRegister2.errorDetails := COPYSTR(DataExch.Value, 1, 250);

             IF EYAIM_PurcahseRegister2.status = '1' THEN
                 EYAIM_PurcahseRegister2."Sync Status" := EYAIM_PurcahseRegister2."Sync Status"::Success;
             IF EYAIM_PurcahseRegister2.status = '0' THEN
                 EYAIM_PurcahseRegister2."Sync Status" := EYAIM_PurcahseRegister2."Sync Status"::Error;

             PRRequestData.ADDTEXT(FORMAT(JSON));
             EYAIM_PurcahseRegister2."Request Json".CREATEOUTSTREAM(OStream);
             PRRequestData.WRITE(OStream);

             PRResponseData.ADDTEXT(ResponseText);
             EYAIM_PurcahseRegister2."Response Json".CREATEOUTSTREAM(OStream);
             PRResponseData.WRITE(OStream);
         END ELSE BEGIN
             EYAIM_PurcahseRegister2."Sync Status" := EYAIM_PurcahseRegister2."Sync Status"::Error;
             EYAIM_PurcahseRegister2."Sync Error Description" := COPYSTR(GETLASTERRORTEXT, 1, 250);
         END;
         EYAIM_PurcahseRegister2.MODIFY;
         // IF STRPOS(ResponseText,',') > 0 THEN BEGIN
         //  ResponseText := DELSTR(ResponseText,1,STRPOS(ResponseText,','));
         //  ResponseText := DELSTR(ResponseText,STRPOS(ResponseText,'}'),STRLEN(ResponseText));
         //  ResponseText := DELCHR(ResponseText,'=','"');
         //  //FOR i := 1 TO STRLEN(ResponseText) DO BEGIN
         //  WHILE (STRLEN(ResponseText) > 0) DO BEGIN
         //    IF STRPOS(ResponseText,',') > 0 THEN
         //      SubString :=  COPYSTR(ResponseText,1,STRPOS(ResponseText,',')-1)
         //    ELSE
         //      SubString := ResponseText;
         //     IF COPYSTR(SubString,1,STRPOS(SubString,':')-1) = 'status' THEN
         //      EVALUATE(EYAIM_PurcahseRegister.Status,COPYSTR(SubString,STRPOS(SubString,':')+1,STRLEN(SubString)))
         //     ELSE IF COPYSTR(SubString,1,STRPOS(SubString,':')-1) = 'AckNo' THEN
         //       EYAIM_PurcahseRegister."Acknowladgement No." := COPYSTR(SubString,STRPOS(SubString,':')+1,STRLEN(SubString))
         //     ELSE IF COPYSTR(SubString,1,STRPOS(SubString,':')-1) = 'AckDt' THEN
         //       EYAIM_PurcahseRegister."Acknowladgement Date" := COPYSTR(SubString,STRPOS(SubString,':')+1,STRLEN(SubString))
         //     ELSE IF COPYSTR(SubString,1,STRPOS(SubString,':')-1) = 'errorDetails' THEN BEGIN
         //       EYAIM_PurcahseRegister.Error  := COPYSTR(COPYSTR(SubString,STRPOS(SubString,':')+1,STRLEN(SubString)),1,250);
         //       IF EYAIM_PurcahseRegister.Error = 'null' THEN
         //         CLEAR(EYAIM_PurcahseRegister.Error);
         //     END;
         //     IF STRPOS(ResponseText,',') > 0 THEN
         //       ResponseText := DELSTR(ResponseText,1,STRPOS(ResponseText,','))
         //     ELSE
         //       ResponseText := DELSTR(ResponseText,1,STRLEN(ResponseText));
         //  END;
         //  EYAIM_PurcahseRegister.MODIFY;
         // END;
         //MESSAGE(ResponseText);
     end;
  */
    local procedure SyncPRDataWithJobqueue()
    var
        EYAIM_PurcahseRegister: Record EYAIM_PurcahseRegister;
        I: Integer;
    begin
        EYAIM_PurcahseRegister.RESET;
        EYAIM_PurcahseRegister.SETFILTER("Sync Status", '%1|%2', EYAIM_PurcahseRegister."Sync Status"::Pending, EYAIM_PurcahseRegister."Sync Status"::Error);
        IF EYAIM_PurcahseRegister.FINDSET THEN
            REPEAT
                I += 1;
            // GenratePurchaseRegisterJson(EYAIM_PurcahseRegister);
            UNTIL EYAIM_PurcahseRegister.NEXT = 10;
    end;

    local procedure SyncReconDataJobqueue()
    var
        CompanyInformation: Record "Company Information";
    begin
        CompanyInformation.GET;
        GetReconcilationReport(GetReconcilationDetails(CompanyInformation."P.A.N. No."), '1');
    end;

    local procedure InsertData(FieldNo: Integer; FieldValue: Text)
    begin
        IF FieldValue = '""' THEN
            CLEAR(FieldValue);
        FRef := RecRef.FIELD(FieldNo);
        FRef.VALUE := FieldValue;
    end;

    // [TryFunction]
    /*  local procedure CallingAPIForReconciliation(TextURL: Text; var ResponseText: Text; Method: Text; ContentType: Text; Body: Text)
     var
         HttpWebRequest: DotNet HttpWebRequest;
         HttpWebResponse: DotNet HttpWebResponse;
         StreamReader: DotNet StreamReader;
         AccessToken: Text;
         Encoding: DotNet Encoding;
         Bytes: DotNet Array;
         TextString: DotNet String;
         InputText: BigText;
         SubText: BigText;
         TextPosition: Integer;
         OutputText: BigText;
         TextToFind: Text;
         TextToReplace: BigText;
         LoopCount: Integer;
         EntryNo: Integer;
         GSTRecon: Record "EYAIM_ERP 108DFs Report";
         LineCount: Integer;
         PurchaseSetup: Record "Purchases & Payables Setup";
     begin
         //Error handling needed if API fails otherwsie not working with Jobs will handle
         PurchaseSetup.GET;
         PurchaseSetup.TESTFIELD("EY Api Access Key");
         GenerateToken(AccessToken);
         HttpWebRequest := HttpWebRequest.Create(TextURL);
         HttpWebRequest.Method := Method;
         HttpWebRequest.Headers.Add('accesstoken', AccessToken);
         HttpWebRequest.Headers.Add('apiaccesskey', PurchaseSetup."EY Api Access Key");
         IF ContentType <> '' THEN
             HttpWebRequest.ContentType := ContentType;
         IF Body <> '' THEN BEGIN
             TextString := STRSUBSTNO(Body);
             Encoding := Encoding.UTF8();
             Bytes := Encoding.GetEncoding('iso-8859-1').GetBytes(TextString.ToString);
             HttpWebRequest.ContentLength := TextString.Length;
             HttpWebRequest.GetRequestStream.Write(Bytes, 0, Bytes.Length);
         END;

         HttpWebResponse := HttpWebRequest.GetResponse;
         //MESSAGE('%1',HttpWebResponse);
         StreamReader := StreamReader.StreamReader(HttpWebResponse.GetResponseStream);
         TextToFind := ',';
         IF GSTRecon.FINDLAST THEN
             EntryNo := GSTRecon."Entry No." + 1
         ELSE
             EntryNo := 1;
         //LoopCount :=1;
         REPEAT
             ResponseText := StreamReader.ReadLine;//StreamReader.ReadToEnd();
             InputText.ADDTEXT(StreamReader.ReadLine);
             IF LineCount > 0 THEN BEGIN
                 TextPosition := InputText.TEXTPOS(TextToFind);
                 RecRef.OPEN(50096);

                 WHILE TextPosition <> 0 DO BEGIN
                     IF LoopCount = 0 THEN BEGIN
                         RecRef.INIT;
                         FRef := RecRef.FIELD(110);
                         FRef.VALUE := EntryNo;
                     END;
                     LoopCount += 1;
                     InputText.GETSUBTEXT(SubText, 1, TextPosition - 1);
                     OutputText.ADDTEXT(SubText);
                     InsertData(LoopCount, FORMAT(SubText));
                     OutputText.ADDTEXT(TextToReplace);
                     InputText.GETSUBTEXT(InputText, TextPosition + STRLEN(TextToFind));
                     TextPosition := InputText.TEXTPOS(TextToFind);
                     IF LoopCount = 107 THEN
                         TextPosition := 2;
                     IF LoopCount = 108 THEN BEGIN
                         LoopCount := 0;
                         RecRef.INSERT;
                         EntryNo += 1;
                     END;
                 END;
                 //OutputText.ADDTEXT(InputText);

             END;
             IF LineCount > 0 THEN
                 RecRef.CLOSE;
             LineCount += 1;
         UNTIL StreamReader.EndOfStream;
         StreamReader.Close();

     end; */
}

