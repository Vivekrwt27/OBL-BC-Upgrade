codeunit 50057 "IBOT Functions"
{

    trigger OnRun()
    begin

        UpdateCustomerCard;
        UpdateItemDetails;
        GetQuicklookData(TODAY, TODAY);
        UpdateQuickCustomerData; //update SPData
        DailyIndentAuthorisationEmail;
    end;

    var
        Customer: Record Customer;
        NotReq: Decimal;
        //  SMTPMailCodeUnit: Codeunit 400;
        //  SMTPSetup: Record 409;
        UserSetup: Record "User Setup";
        IndentHeader: Record "Indent Header";
        Report50250: Report "Daily Indent Authorised report";
        Text001: Label 'Daily Indent Authorised Report';
        Text002: Label 'Daily Indent Authorised Report';
        Text003: Label 'Please find the attached Daily Indent Authorised Report.';
        Text004: Label 'Daily Indent Authorised Report';
        Text005: Label 'Dear Sir/Madam,';
        Text006: Label 'Regards';
        Text007: Label 'Mail sent!';
        SalespersonPurchaser: Record "Salesperson/Purchaser";

    local procedure UpdateCustomerCard()
    begin
        Customer.RESET;
        Customer.SETFILTER("Customer Type", '<>%1&<>%2&<>%3', 'MISC.', 'LEGAL', 'COCO');
        IF Customer.FINDFIRST THEN
            WITH Customer DO BEGIN
                REPEAT
                    Customer."Outstanding IBOT" := 0;
                    Customer."DSO IBOT" := 0;
                    Customer."OverDue Amt IBOT" := 0;
                    Customer."MTD Collection IBOT" := 0;
                    Customer."PYTD Sale IBOT" := 0;
                    Customer."YTD Sale IBOT" := 0;
                    Customer."Available Credit Limit IBOT" := 0;
                    Customer."MTD Sales IBOT" := 0;
                    Customer."QTD Sales IBOT" := 0;

                    GetCustomerInformation(Customer."No.", TODAY, Customer."DSO IBOT", Customer."Outstanding IBOT");
                    Customer."As on Date IBOT" := TODAY;
                    Customer.CALCFIELDS("Balance (LCY)");
                    IF Customer."Balance (LCY)" > 0 THEN BEGIN
                        Customer."OverDue Amt IBOT" := GetOverDueAmount(Customer."No.")
                    END ELSE BEGIN
                        Customer."OverDue Amt IBOT" := 0;
                        Customer."Outstanding IBOT" := 0;
                    END;
                    GetRevenue(Customer."No.", 20200104D, CALCDATE('-1Y', TODAY - 1), Customer."PYTD Sale IBOT", NotReq, NotReq, NotReq, NotReq, NotReq);
                    GetRevenue(Customer."No.", 20210104D, TODAY - 1, Customer."YTD Sale IBOT", NotReq, NotReq, NotReq, NotReq, NotReq);
                    GetRevenue(Customer."No.", CALCDATE('-CM', TODAY - 1), TODAY - 1, Customer."MTD Sales IBOT", NotReq, NotReq, NotReq, NotReq, NotReq);
                    GetRevenue(Customer."No.", CALCDATE('-CQ', TODAY - 1), TODAY - 1, Customer."QTD Sales IBOT", NotReq, NotReq, NotReq, NotReq, NotReq);
                    Customer."Available Credit Limit IBOT" := Customer."Credit Limit (LCY)" - (GetOutStandingSalesOrder(Customer."No.", 20220104D, CALCDATE('-1Y', TODAY - 1))
                    + Customer."Outstanding IBOT");

                    Customer."MTD Collection IBOT" := GetCollectionAmt(Customer."No.", CALCDATE('-CM', TODAY - 1), TODAY - 1);
                    Customer."Last Billing Date" := GetLastBillingDate(Customer."No.");
                    Customer.MODIFY;
                UNTIL NEXT = 0;
            END;
        IF GUIALLOWED THEN
            MESSAGE('Done');
    end;


    procedure GetCustomerInformation(CustNo: Code[20]; AsonDate: Date; var DSO: Decimal; var OutStanding: Decimal)
    var
        Customer: Record Customer;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        SalesAmt: Decimal;
        SalesQty: Decimal;
        OthAmt: Decimal;
    begin
        IF AsonDate = 0D THEN
            AsonDate := TODAY - 1;

        IF Customer.GET(CustNo) THEN BEGIN
            Customer.CALCFIELDS(Balance, "Balance (LCY)");
            OutStanding := Customer."Balance (LCY)";
            GetRevenue(CustNo, AsonDate - 90, AsonDate, SalesAmt, SalesQty, OthAmt, OthAmt, OthAmt, OthAmt);
            IF SalesAmt <> 0 THEN
                DSO := (OutStanding / SalesAmt) * 90
            ELSE
                DSO := 0;
            //  CollectionAmt := SalesAmt;
        END;
    end;

    local procedure GetRevenue(CustCode: Code[20]; FromDate: Date; ToDate: Date; var SalesAmt: Decimal; var SalesQty: Decimal; var CDSales: Decimal; var CDQty: Decimal; var PMTSales: Decimal; var PMTQty: Decimal)
    var
        SalesJournalData: Query "Sales Journal Data";
        FieldForceCode: Code[20];
        MonthDate: Date;
        SalesJournalData1: Query "Sales Return Journal Data";
    begin
        PMTQty := 0;
        PMTSales := 0;
        CDQty := 0;
        CDSales := 0;
        SalesAmt := 0;
        SalesQty := 0;
        CLEAR(SalesJournalData);
        SalesJournalData.SETFILTER(SalesJournalData.CustomerNo, '%1', CustCode); //MSKS
        SalesJournalData.SETFILTER(PostingDateFilter, '%1..%2', FromDate, ToDate);

        SalesJournalData.OPEN;
        WHILE SalesJournalData.READ DO BEGIN
            SalesAmt += SalesJournalData.LineAmount;
            SalesQty += SalesJournalData.Quantity_Base;

            IF SalesJournalData.Discount_Charges <> 0 THEN BEGIN
                CDSales += SalesJournalData.LineAmount;
                CDQty += SalesJournalData.Quantity_Base;
            END;
            IF SalesJournalData.PMTCode <> '' THEN BEGIN
                PMTSales += SalesJournalData.LineAmount;
                PMTQty += SalesJournalData.Quantity_Base;
            END;
        END;

        CLEAR(SalesJournalData1);
        SalesJournalData1.SETFILTER(SalesJournalData1.CustomerNo, '%1', CustCode); //MSKS
        SalesJournalData1.SETFILTER(PostingDateFilter, '%1..%2', FromDate, ToDate);
        SalesJournalData1.OPEN;
        WHILE SalesJournalData1.READ DO BEGIN
            SalesAmt -= SalesJournalData1.LineAmount;
            SalesQty -= SalesJournalData1.Quantity_Base;
        END;
    end;


    procedure GetOverDueAmount(CustNo: Code[20]) OverDueAmt: Decimal
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        CLEAR(OverDueAmt);
        OverDueAmt := 0;
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETRANGE("Customer No.", CustNo);
        //    CustLedgerEntry.SETFILTER("Remaining Amt. (LCY)", '<>%1', 0);
        IF CustLedgerEntry.FINDSET THEN
            REPEAT
                CustLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                //OVERDUE AMOUNT
                IF (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Invoice) AND
                  (CustLedgerEntry."Due Date" <= CALCDATE('-1D', TODAY)) THEN
                    OverDueAmt += CustLedgerEntry."Remaining Amt. (LCY)";
            UNTIL CustLedgerEntry.NEXT = 0;
    end;

    local procedure GetCollectionAmt(CustNo: Code[20]; FromDate: Date; ToDate: Date) CollectionAmt: Decimal
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        CollectionAmt := 0;
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETRANGE("Customer No.", CustNo);
        CustLedgerEntry.SETFILTER("Document Type", '%1|%2', CustLedgerEntry."Document Type"::Payment, CustLedgerEntry."Document Type"::Refund);
        CustLedgerEntry.SETRANGE("Posting Date", FromDate, ToDate); //Kulbhushan
        IF CustLedgerEntry.FINDSET THEN
            REPEAT
                CustLedgerEntry.CALCFIELDS(Amount);
                CollectionAmt += CustLedgerEntry.Amount;
            UNTIL CustLedgerEntry.NEXT = 0;

        EXIT(CollectionAmt);
    end;

    local procedure GetOutStandingSalesOrder(CustNo: Code[20]; FromDate: Date; ToDate: Date) OutStandAmt: Decimal
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.RESET;
        SalesLine.SETFILTER("Sell-to Customer No.", '%1', CustNo);
        SalesLine.SETFILTER("Document Type", '%1', SalesLine."Document Type"::Order);
        SalesLine.SETFILTER("Outstanding Quantity", '>%1', 0);
        IF SalesLine.FINDFIRST THEN
            REPEAT
                OutStandAmt += SalesLine."Outstanding Amount";
            UNTIL SalesLine.NEXT = 0;
    end;

    local procedure UpdateItemDetails()
    var
        ItemDetailsIBOT: Query "Item Details - IBOT";
        RecItemDetailsIBOT: Record "Item Details - IBOT";
        SalesInvoiceLine: Record "Sales Invoice Line";
        ItemSalesPrice1: Record "Item Sales Price1";
        Location: Record Location;
        DiscountSetups: Record "Discount Setups";
        UOMMgt: Codeunit "Unit of Measure Management";
        Item: Record Item;
        MRPItem: Record Item;
    begin
        RecItemDetailsIBOT.RESET;
        RecItemDetailsIBOT.DELETEALL;
        CLEAR(ItemDetailsIBOT);
        ItemDetailsIBOT.OPEN;
        WHILE ItemDetailsIBOT.READ DO BEGIN
            RecItemDetailsIBOT.INIT;
            RecItemDetailsIBOT."Location Code" := ItemDetailsIBOT.Code;
            RecItemDetailsIBOT."Item No." := ItemDetailsIBOT.No;
            RecItemDetailsIBOT.Description := ItemDetailsIBOT.Design_Code_Desc + ' ' + ItemDetailsIBOT.Color_Code_Desc;
            RecItemDetailsIBOT.Inventory := ItemDetailsIBOT.Sum_Quantity;
            RecItemDetailsIBOT."Inventory In Cartons" := ItemDetailsIBOT.Sum_Qty_In_Carton;
            RecItemDetailsIBOT."Reserved Qty." := ItemDetailsIBOT.Sum_Reserved_Quantity;
            RecItemDetailsIBOT."Item Classification" := ItemDetailsIBOT.Item_Classification;
            RecItemDetailsIBOT."Type Catogery Code" := ItemDetailsIBOT.Type_Catogery_Code;
            RecItemDetailsIBOT."Size Code" := ItemDetailsIBOT.Size_Code;
            RecItemDetailsIBOT."Design Code" := ItemDetailsIBOT.Design_Code;
            RecItemDetailsIBOT."Color Code" := ItemDetailsIBOT.Color_Code;
            RecItemDetailsIBOT."Packing Code" := ItemDetailsIBOT.Packing_Code;
            RecItemDetailsIBOT."Quality Code" := ItemDetailsIBOT.Quality_Code;
            RecItemDetailsIBOT."Plant Code" := ItemDetailsIBOT.Plant_Code;
            RecItemDetailsIBOT."Size Code Desc." := ItemDetailsIBOT.Size_Code_Desc;
            RecItemDetailsIBOT."Type Category Code Desc." := ItemDetailsIBOT.Type_Category_Code_Desc;
            RecItemDetailsIBOT."Design Code Desc." := ItemDetailsIBOT.Design_Code_Desc;
            RecItemDetailsIBOT."Color Code Desc." := ItemDetailsIBOT.Color_Code_Desc;
            RecItemDetailsIBOT."Packing Code Desc." := ItemDetailsIBOT.Packing_Code_Desc;
            RecItemDetailsIBOT."Quality Code Desc." := ItemDetailsIBOT.Quality_Code_Desc;
            RecItemDetailsIBOT."Plant Code Desc." := ItemDetailsIBOT.Plant_Code_Desc;
            RecItemDetailsIBOT."Tableau Product Group" := ItemDetailsIBOT.Tableau_Product_Group;
            RecItemDetailsIBOT."Gross Weight" := ItemDetailsIBOT.Gross_Weight;
            RecItemDetailsIBOT."Gross Weight Inventory" := ItemDetailsIBOT.Gross_Weight * ItemDetailsIBOT.Sum_Quantity;
            RecItemDetailsIBOT."Group Code" := ItemDetailsIBOT.Group_Code;
            RecItemDetailsIBOT."Group code Desc" := ItemDetailsIBOT.Group_code_Desc;
            //RecItemDetailsIBOT."Manufacturer Name" := ItemDetailsIBOT.Manufacturer_Name;
            RecItemDetailsIBOT."Default Prod. Plant Code" := ItemDetailsIBOT.Default_Prod_Plant_Code;
            RecItemDetailsIBOT.NPD := ItemDetailsIBOT.NPD;
            RecItemDetailsIBOT."Manuf. Strategy" := ItemDetailsIBOT.Manuf_Strategy;
            RecItemDetailsIBOT.Liquidaton := ItemDetailsIBOT.Liquidaton;
            RecItemDetailsIBOT."Inventory In Hand" := RecItemDetailsIBOT.Inventory - RecItemDetailsIBOT."Reserved Qty.";


            CASE ItemDetailsIBOT.ITC OF
                'M001':
                    RecItemDetailsIBOT."Manufacturer Name" := 'Sikandrabad Plant';
                'D001':
                    RecItemDetailsIBOT."Manufacturer Name" := 'Dora Plant';
                'T001':
                    RecItemDetailsIBOT."Manufacturer Name" := 'West Zone';
                'H001':
                    RecItemDetailsIBOT."Manufacturer Name" := 'Hoskote Plant';
            END;

            IF Item.GET(RecItemDetailsIBOT."Item No.") THEN BEGIN
                RecItemDetailsIBOT.Conversion := UOMMgt.GetQtyPerUnitOfMeasure(Item, 'CRT');
                RecItemDetailsIBOT."Weight Per Carton" := ROUND(RecItemDetailsIBOT.Conversion * RecItemDetailsIBOT."Gross Weight", 0.01, '=');
                Item."Sales Price" := UpdateSalesPriceOnItem(Item."No.");
                Item.MODIFY;
            END;
            DiscountSetups.RESET;
            DiscountSetups.SETFILTER("Customer No.", '%1', '');
            DiscountSetups.SETFILTER("Item Classification", '%1', ItemDetailsIBOT.Item_Classification);
            DiscountSetups.SETFILTER("Manuf. Strategy", '%1', ItemDetailsIBOT.Manuf_Strategy);
            DiscountSetups.SETFILTER("Starting Date", '%1..%2', 0D, TODAY);
            IF DiscountSetups.FINDLAST THEN BEGIN
                RecItemDetailsIBOT.Discount := DiscountSetups."PreApproved Discount";
            END;
            IF Location.GET(ItemDetailsIBOT.Code) THEN;
            ItemSalesPrice1.RESET;
            ItemSalesPrice1.SETCURRENTKEY("Sales Code", "Quality 4 Classification Code", "Item Classification No.");
            ItemSalesPrice1.SETFILTER("Sales Type", '%1', ItemSalesPrice1."Sales Type"::"Customer Price Group");
            IF RecItemDetailsIBOT."Location Code" = 'HSK-WH-MFG' THEN
                ItemSalesPrice1.SETFILTER("Sales Code", '%1', 'HSK_D') ELSE
                ItemSalesPrice1.SETFILTER("Sales Code", '%1', Location."Customer Price Group");
            ItemSalesPrice1.SETFILTER("Item Classification No.", '%1', ItemDetailsIBOT.Item_Classification);

            IF ItemSalesPrice1.FINDLAST THEN BEGIN
                RecItemDetailsIBOT."Last Sales Price" := ItemSalesPrice1."Unit Price";
                RecItemDetailsIBOT."Last MRP" := ItemSalesPrice1.MRP;
                RecItemDetailsIBOT.INSERT;
                IF MRPItem.GET(RecItemDetailsIBOT."Item No.") THEN BEGIN
                    MRPItem."N.R.V" := ItemSalesPrice1.MRP;
                    MRPItem.MODIFY;
                END;
            END;
        END;
    end;

    local procedure CalculateReserveQty(LocationCode: Code[20]; ItemNo: Code[20]): Decimal
    var
        ReservationEntry: Record "Reservation Entry";
    begin
        //ReservationEntry.RESET;
    end;

    local procedure GetLastBillingDate(CustNo: Code[20]): Date
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETFILTER("Customer No.", '%1', CustNo);
        CustLedgerEntry.SETFILTER("Document Type", '%1', CustLedgerEntry."Document Type"::Invoice);
        IF CustLedgerEntry.FINDLAST THEN
            EXIT(CustLedgerEntry."Posting Date")
        ELSE
            EXIT(0D);
    end;


    procedure GetQuicklookData(Fromdate: Date; EndDate: Date)
    var
        URL: Text;
        reqText: Text;
        HttpWebRequestMgt: Codeunit "Http Web Request Mgt.";
        ReqBodyOutStream: OutStream;
        ReqBodyInStream: InStream;
        RespBodyInStream: InStream;
        /*   ResponseXmlDoc: DotNet XmlDocument;
          TempBlob: Codeunit "Temp Blob";
          HttpStatusCode_L: DotNet HttpStatusCode;
          ResponseHeaders_L: DotNet NameValueCollection; */
        BGText: BigText;
        FileName: Text;
        ResponseText: Text;
        JSONManagement: Codeunit "JSON Management";
        // Json: DotNet String;
        DataExch: Record "Data Exch. Field" temporary;
        FileManagement: Codeunit "File Management";
        //  streamReader: DotNet StreamReader;
        // 15578  encoding: DotNet Encoding;
        XMLFile: File;
        QuickLookAPIData: Record "QuickLook API Data";
    begin
        URL := 'http://quicklook.orientbell.com/analytics/tileanalytics_new.php?';


        reqText := 'datefrom=' + FORMAT('2023-02-01') + '&dateto=' + FORMAT('2023-02-28') + '&Type=xml';


        /*  CLEAR(HttpWebRequestMgt);
         HttpWebRequestMgt.Initialize(URL + reqText);
         HttpWebRequestMgt.DisableUI;
         HttpWebRequestMgt.SetMethod('POST');
         HttpWebRequestMgt.SetReturnType('application/json');
         HttpWebRequestMgt.SetContentType('application/json');
  */
        //    TempBlob.INIT;
        //    TempBlob.Blob.CREATEINSTREAM(ReqBodyInStream);

        // IF HttpWebRequestMgt.GetResponse(ReqBodyInStream, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
        // 15578  BGText.ADDTEXT(TempBlob.ReadAsText('', TEXTENCODING::UTF8));
        //MESSAGE('%1',BGText);
        // FileManagement.BLOBExportToServerFile(TempBlob,'c:\abc.xml');
        ReadXml(BGText);
        // END
        // ELSE
        ERROR('Something went wrong');
    end;

    local procedure InsertData(MonthDt: Date; CustomerNo: Code[50]; ItemNo: Code[50]; DSCount: Decimal; DVCount: Decimal)
    var
        QuickLookAPIData: Record "QuickLook API Data";
        Customer: Record Customer;
    begin

        QuickLookAPIData.RESET;
        QuickLookAPIData.SETRANGE("Month Date", MonthDt);
        QuickLookAPIData.SETRANGE("Customer No.", CustomerNo);
        QuickLookAPIData.SETRANGE("Item No.", ItemNo);
        IF NOT QuickLookAPIData.FINDFIRST THEN BEGIN
            QuickLookAPIData.INIT;
            QuickLookAPIData."Month Date" := MonthDt;
            QuickLookAPIData."Customer No." := CustomerNo;
            IF Customer.GET(CustomerNo) THEN BEGIN
                QuickLookAPIData."Salesperson Code" := Customer."Salesperson Code";
                IF SalespersonPurchaser.GET(QuickLookAPIData."Salesperson Code") THEN
                    QuickLookAPIData."Salesperson Description" := SalespersonPurchaser.Name;
                QuickLookAPIData."PCH Code" := Customer."PCH Code";
                IF SalespersonPurchaser.GET(QuickLookAPIData."PCH Code") THEN
                    QuickLookAPIData."PCH Name" := SalespersonPurchaser.Name;
                QuickLookAPIData."Zohal Head" := Customer."Zonal Head";
                IF SalespersonPurchaser.GET(QuickLookAPIData."Zohal Head") THEN
                    QuickLookAPIData.Zonal_Head := SalespersonPurchaser.Name;
                QuickLookAPIData."Zonal Manager" := Customer."Zonal Manager";
                IF SalespersonPurchaser.GET(QuickLookAPIData."Zonal Manager") THEN
                    QuickLookAPIData.Zonal_Manager := SalespersonPurchaser.Name;
            END;
            QuickLookAPIData."Item No." := ItemNo;
            QuickLookAPIData."DS Count" := DSCount;
            QuickLookAPIData."DV Count" := DVCount;
            QuickLookAPIData.INSERT;
        END;
    end;

    local procedure ReadXml(ResponseText: BigText)
    var
    // ResponseXmlDocument: DotNet XmlDocument;
    begin
        /* ResponseXmlDocument := ResponseXmlDocument.XmlDocument();
        ResponseXmlDocument.LoadXml('<Root1>' + COPYSTR(FORMAT(ResponseText), STRPOS(FORMAT(ResponseText), '<Root>')) + '</Root1>');
        SetResponseText(ResponseXmlDocument, 'Root'); */
    end;

    /*  local procedure SetResponseText(ResponseXmlDocument: DotNet XmlDocument; RootData: Text)
     var
         ResponseXMLNodeList: DotNet XmlNodeList;
         ResponseXMLElement: DotNet XmlElement;
         i: Integer;
         ParentNode: DotNet XmlNode;
         NodeList: DotNet XmlNodeList;
         ChildNode: DotNet XmlNode;
         ChildNodeList: DotNet XmlNodeList;
         j: Integer;
         CustomerNo: Code[50];
         ItemNo: Code[50];
         QuickLookAPIData: Record "QuickLook API Data";
         MonthDate: Date;
         DsCount: Decimal;
         DVCount: Decimal;
     begin
         ResponseXMLNodeList := ResponseXmlDocument.GetElementsByTagName(RootData);

         IF NOT ISNULL(ResponseXMLNodeList) THEN BEGIN
             FOR i := 0 TO ResponseXMLNodeList.Count - 1 DO BEGIN

                 ChildNode := ResponseXMLNodeList.ItemOf(i);
                 ChildNodeList := ChildNode.ChildNodes();

                 FOR j := 0 TO ChildNodeList.Count - 1 DO BEGIN
                     ChildNode := ChildNodeList.ItemOf(j);

                     IF (ChildNode.Name = 'Monthdate') THEN
                         EVALUATE(MonthDate, ChildNode.InnerText);
                     IF (ChildNode.Name = 'PartyNo') THEN
                         CustomerNo := ChildNode.InnerText;
                     IF (ChildNode.Name = 'ItemNo') THEN
                         ItemNo := ChildNode.InnerText;
                     IF (ChildNode.Name = 'DSCount') THEN
                         EVALUATE(DsCount, ChildNode.InnerText);
                     IF (ChildNode.Name = 'DVCount') THEN
                         EVALUATE(DVCount, ChildNode.InnerText);
                 END;
                 InsertData(MonthDate, CustomerNo, ItemNo, DsCount, DVCount);
             END;
         END;
     end;
  */
    local procedure DailyIndentAuthorisationEmail()
    var
        Subject: Text;
        SendEmail: Text;
        IndentHeader: Record "Indent Header";
        InstreamVar: InStream;
        OutstreamVar: OutStream;
        TempBlobCU: Codeunit "Temp Blob";
        FileMgmt: Codeunit "File Management";
        EmailObj: Codeunit Email; // 15578TEXT
        EmailMsg: codeunit "Email Message";
        EmailCCList: List of [Text];
        BodyText: Text;
        EmailAddressList: List of [Text];
        EmailBccList: list of [Text];
    begin
        //  SMTPSetup.GET;
        //  CLEAR(SMTPMailCodeUnit);
        Subject := Text001 + '-' + FORMAT(TODAY - 1);
        //SMTPMailCodeUnit.CreateMessage(Text002,'donotreply@orientbell.com','g.vaidyanathan@orientbell.com',Text004,'',TRUE);
        //  SMTPMailCodeUnit.CreateMessage('COO Office - OBL.', 'coo.office@orientbell.com', 'g.vaidyanathan@orientbell.com', Text004, '', TRUE);
        EmailAddressList.Add('coo.office@orientbell.com');
        EmailCCList.add('donotreply@orientbell.com');
        EmailCCList.add('g.vaidyanathan@orientbell.com');
        EmailCCList.add('ak.sharma@orientbell.com');
        EmailCCList.add('dimpi.kumar@orientbell.com');
        EmailCCList.add('kuldeep.kumar@orientbell.com');
        EmailCCList.add('rajendra.sharma@orientbell.com');
        EmailCCList.add('mallikarjunaiah.mn@orientbell.com');
        EmailCCList.add('sandeep.kedia@orientbell.com');
        EmailCCList.add('amit.kumar3@orientbell.com');
        EmailCCList.add('muralidhar.db@orientbell.com');
        EmailCCList.add('pradeep.kumar@orientbell.com');
        //SMTPMailCodeUnit.AddCC('g.vaidyanathan@orientbell.com');
        Report50250.SETTABLEVIEW(IndentHeader);
        /* Report50250.SAVEASEXCEL('C:\IndentExcel\' + Subject + '.xlsx');
        if File.Exists('C:\IndentExcel\' + Subject + '.xlsx') THEN begin
            FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\IndentExcel\' + Subject + '.xlsx');
         */
        if TempBlobCU.HasValue() then begin
            TempBlobCU.CreateInStream(InstreamVar);
            EmailMsg.Create(EmailAddressList, Text004, BodyText, true, EmailBccList, EmailCCList);
            // if File.Exists('C:\IndentExcel\' + Subject + '.xlsx') THEN
            EmailMsg.AddAttachment('C:\IndentExcel\' + Subject + '.xlsx', 'application/pdf', InstreamVar);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
        END;


    end;

    /* IF EXISTS('C:\IndentExcel\' + Subject + '.xlsx') THEN
         SMTPMailCodeUnit.AddAttachment('C:\IndentExcel\' + Subject + '.xlsx', Subject + '.xlsx');*/
    /* 15578  SMTPMailCodeUnit.AppendBody(Text005);
      //SMTPMailCodeUnit.AppendBody('');
      SMTPMailCodeUnit.AppendBody('<br><br>');
      //SMTPMailCodeUnit.AppendBody('<br><br>');
      SMTPMailCodeUnit.AppendBody(Text003);
      SMTPMailCodeUnit.AppendBody('<br><br>');
      //SMTPMailCodeUnit.AppendBody('<br><br>');
      //SMTPMailCodeUnit.AppendBody('<br><br>');
      //SMTPMailCodeUnit.AppendBody('Kindly acknowledge.');
      SMTPMailCodeUnit.AppendBody('<br><br>');
      SMTPMailCodeUnit.AppendBody(Text006);
      SMTPMailCodeUnit.AppendBody('<br><br>');
      SMTPMailCodeUnit.AppendBody('Orient Bell Limited <br>');
      SMTPMailCodeUnit.AppendBody('Iris House, 16 Business Center, Nangal Raya <br>');
      SMTPMailCodeUnit.AppendBody('New Delhi 110046, India <br>');
      SMTPMailCodeUnit.AppendBody('Tel. +91 11 4711 9100 <br>');
      SMTPMailCodeUnit.AppendBody('Fax. +91 11 2852 1273 <br>');
      SMTPMailCodeUnit.Send;*/ // 15578
                               // end;

    local procedure UpdateQuickCustomerData()
    var
        QuickLookAPIData: Record "QuickLook API Data";
    begin
        QuickLookAPIData.RESET;
        IF QuickLookAPIData.FINDFIRST THEN
            REPEAT
                UpdateCustomerData(QuickLookAPIData);
                QuickLookAPIData.MODIFY;
            UNTIL QuickLookAPIData.NEXT = 0;
    end;

    local procedure UpdateCustomerData(var QuickLookAPIData: Record "QuickLook API Data")
    var
        Customer: Record Customer;
    begin
        IF Customer.GET(QuickLookAPIData."Customer No.") THEN BEGIN
            QuickLookAPIData."Salesperson Code" := Customer."Salesperson Code";
            IF SalespersonPurchaser.GET(QuickLookAPIData."Salesperson Code") THEN
                QuickLookAPIData."Salesperson Description" := SalespersonPurchaser.Name;
            QuickLookAPIData."PCH Code" := Customer."PCH Code";
            IF SalespersonPurchaser.GET(QuickLookAPIData."PCH Code") THEN
                QuickLookAPIData."PCH Name" := SalespersonPurchaser.Name;
            QuickLookAPIData."Zohal Head" := Customer."Zonal Head";
            IF SalespersonPurchaser.GET(QuickLookAPIData."Zohal Head") THEN
                QuickLookAPIData.Zonal_Head := SalespersonPurchaser.Name;
            QuickLookAPIData."Zonal Manager" := Customer."Zonal Manager";
            IF SalespersonPurchaser.GET(QuickLookAPIData."Zonal Manager") THEN
                QuickLookAPIData.Zonal_Manager := SalespersonPurchaser.Name;
            QuickLookAPIData."Customer Name" := Customer.Name;
            QuickLookAPIData."City Name" := Customer.City;
            QuickLookAPIData."State Name" := Customer."State Desc.";
            QuickLookAPIData.OBTB := Customer."Coco Customer";
        END;
    end;

    local procedure UpdateSalesPriceOnItem(ItemCode: Code[20]): Decimal
    var
        ItemSalesPrice1: Record "Item Sales Price1";
        Item: Record Item;
    begin
        IF Item.GET(ItemCode) THEN;
        ItemSalesPrice1.RESET;
        ItemSalesPrice1.SETCURRENTKEY("Sales Code", "Quality 4 Classification Code", "Item Classification No.");
        ItemSalesPrice1.SETFILTER("Sales Type", '%1', ItemSalesPrice1."Sales Type"::"Customer Price Group");
        ItemSalesPrice1.SETFILTER("Item Classification No.", '%1', Item."Item Classification");
        CASE Item."Item Category Code" OF
            'D001':
                ItemSalesPrice1.SETFILTER("Sales Code", '%1', 'DRA_D');
            'H001':
                ItemSalesPrice1.SETFILTER("Sales Code", '%1', 'HSK_D');
            'T001':
                ItemSalesPrice1.SETFILTER("Sales Code", '%1', 'WZ_D');
            'M001':
                ItemSalesPrice1.SETFILTER("Sales Code", '%1', 'SKD_D');
        END;
        IF ItemSalesPrice1.FINDLAST THEN BEGIN
            EXIT(ItemSalesPrice1."Unit Price");
        END;
    end;
}

