codeunit 50067 "Notification Mgt."
{

    trigger OnRun()
    var
        NotificationEntryTable: Record "Notification Entry Table";
        LastDocNo: Code[20];
    begin
        CreateNoMaterialNotification;
        //SOGM/2122/004251

        NotificationEntryTable.RESET;
        NotificationEntryTable.SETCURRENTKEY("Notification Code", "Document No.", "Document Line No.", Notify);
        NotificationEntryTable.SETRANGE("Notification Code", 'NOMAT');
        //NotificationEntryTable.SETRANGE("Document No.",'SOGM/2122/004251');
        NotificationEntryTable.SETRANGE(Notify, FALSE);
        IF NotificationEntryTable.FINDFIRST THEN
            REPEAT
                IF LastDocNo <> NotificationEntryTable."Document No." THEN BEGIN
                    SendNoMATMail(NotificationEntryTable);
                    LastDocNo := NotificationEntryTable."Document No.";
                END;
            UNTIL NotificationEntryTable.NEXT = 0;
        IF GUIALLOWED THEN
            MESSAGE('Done');
    end;

    local procedure CreateNoMaterialNotification()
    var
        SalesOrderArchive: Query "Sales Order Archive";
        NotifyManagement: Codeunit "Notify Management";
        SalesLine: Record "Sales Line Archive";
        RecCustomer: Record Customer;
        Inventory: Decimal;
    begin
        CLEAR(SalesOrderArchive);
        SalesOrderArchive.SETFILTER(SalesOrderArchive.Order_Date, '%1..%2', 20211225D, TODAY - 4);
        SalesOrderArchive.OPEN;
        WHILE SalesOrderArchive.READ DO BEGIN
            Inventory := 0;
            CLEAR(NotifyManagement);
            IF RecCustomer.GET(SalesOrderArchive.Sell_to_Customer_No) THEN;
            IF SalesLine.GET(SalesLine."Document Type"::Order, SalesOrderArchive.No, SalesOrderArchive.Doc_No_Occurrence, SalesOrderArchive.Max_Version_No, SalesOrderArchive.Line_No) THEN
                IF NOT ISNotificationEntryExists('NOMAT', SalesLine.RECORDID) THEN BEGIN
                    Inventory := GetInventory(SalesLine."No.", SalesLine."Location Code");
                    NotifyManagement.CreateNotificationEntry('NOMAT', SalesLine.RECORDID, 37, SalesLine."Document Type"::Order.AsInteger(), SalesOrderArchive.No, SalesOrderArchive.Line_No,
                    CreateTextMsg(SalesLine), 1, 1, SalesOrderArchive.Location_Code, SalesLine."Sell-to Customer No.", RecCustomer."E-Mail", Inventory);
                END;
        END;
    end;

    local procedure CreateTextMsg(SAlesLine: Record "Sales Line Archive") txt: Text
    begin
        txt := 'Material which you have ordered by Order No. ' + SAlesLine."Document No." + ' - Code ' + SAlesLine."No." + ' - ' + SAlesLine.Description + 'is now availble You can Order Now.';
    end;

    local procedure ISNotificationEntryExists(NotifyCode: Code[10]; RecID: RecordID): Boolean
    var
        NotificationEntry: Record "Notification Entry Table";
    begin
        NotificationEntry.RESET;
        NotificationEntry.SETCURRENTKEY("Notification Code", "Record ID");
        NotificationEntry.SETRANGE("Notification Code", NotifyCode);
        NotificationEntry.SETRANGE("Record ID", RecID);
        IF NOT NotificationEntry.FINDFIRST THEN
            EXIT(FALSE)
        ELSE
            EXIT(TRUE);
    end;


    procedure SendNoMATMail(RecNotificationEntryTable: Record "Notification Entry Table")
    var
        // cduSMTPMail: Codeunit 400;
        rUserSetup: Record "User Setup";
        txtEmailID: Text;
        rPurchaseLine: Record "Purchase Line";
        rIndentHeader: Record "Indent Header";
        rApprovalEntry: Record "Approval Entry";
        xIndentNo: Text;
        IndentList: Text;
        recApprovalEntry: Record "Approval Entry";
        txtApprName: Text;
        recUser: Record User;
        AttachmentManagment: Record "Attachment Management";
        FilePath: Text;
        FileName: Text;
        ApprovalEntry1: Record "Approval Entry";
        Text50002: Label 'sanuj.sharma@orientbell.com';
        Text50000: Label 'Puchase Order Details :';
        Text50010: Label ' <br/> ';
        Text50011: Label 'Description :-  ';
        Text50012: Label 'Remarks :-  ';
        Text50013: Label 'Reason:';
        Text59999: Label '<html>';
        Text60000: Label '<Table>';
        Text60001: Label '<TR Border=4>';
        Text60002: Label '<TD  width=200 Align=Left>';
        Text60003: Label '</TD>';
        Text60004: Label '</TR>';
        Text60005: Label '</Table>';
        Text60006: Label '</html>';
        Text60007: Label '<TD  width=500 Align=Left>';
        Text60008: Label '<TD  width=100 Align=Center>';
        Text60009: Label '<TD Align=Left>';
        Text60010: Label '<TD  width=800 Align=right>';
        Text60011: Label '<BR>';
        Text60012: Label '<B>';
        Text60013: Label '</B>';
        Text60014: Label '<TD  width=850 Align=right>';
        Text60015: Label '<font size="3"> ';
        Text60016: Label '</font>';
        Text50022: Label 'Mail Sent Successfully !!!!';
        Text50023: Label 'This is to advice that the following shipment is being despatched from our factory as follows.';
        Text50024: Label '<TD  width=1000 Align=Left>';
        Text50025: Label 'This e-Mail is auto generated from Microsoft Dynamics Navison ERP.';
        Text50026: Label '<TR>';
        Text50027: Label '<table border="1" width="70%">';
        Text50028: Label '<TH>';
        Text50029: Label '</TH>';
        Text50030: Label '<td width="20%">';
        Text50031: Label '<td width="50%">';
        Text50032: Label '<FONT SIZE=6 FACE="Sans Serif">';
        Text50041: Label '<TD  width=5 Align=Center>';
        SrNo: Integer;
        PurchaseLine: Record "Purchase Line";
        Amt: Decimal;
        SalesHeaderArchive: Record "Sales Header Archive";
        NotificationEntryTable: Record "Notification Entry Table";
        TableSalesLineArchive: Record "Sales Line Archive";
        SLQRecRef: RecordRef;
        Customer: Record Customer;
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
        Clear(EmailAddressList);
        Clear(EmailCCList);
        Clear(EmailBccList);

        ///  CLEAR(cduSMTPMail);

        IF TableSalesLineArchive.GET(RecNotificationEntryTable."Record ID") THEN
            //IF SalesHeaderArchive.GET(TableSalesLineArchive."Document Type",TableSalesLineArchive."Document No.",TableSalesLineArchive."Doc. No. Occurrence",TableSalesLineArchive."Version No.") THEN;
            IF Customer.GET(TableSalesLineArchive."Sell-to Customer No.") THEN
                IF Customer."E-Mail" <> '' THEN BEGIN
                    //txtEmailID := 'kulwant@mindshell.info';
                    txtEmailID := Customer."E-Mail";
                    //cduSMTPMail.CreateMessage('Orient Bell Limited.','donotreply@orientbell.com',
                    //txtEmailID,'Approval Mail ' + SalesHeaderArchive."No." ,'',TRUE);
                    /*cduSMTPMail.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
                                              txtEmailID, 'Stock Available ', '', TRUE);*/// 15578
                    EmailAddressList.Add('donotreply@orientbell.com');
                    NotificationEntryTable.RESET;
                    NotificationEntryTable.SETRANGE("Notification Code", 'NOMAT');
                    NotificationEntryTable.SETRANGE("Document No.", RecNotificationEntryTable."Document No.");
                    NotificationEntryTable.SETRANGE(Notify, FALSE);
                    IF NotificationEntryTable.FIND('-') THEN BEGIN
                        IF TableSalesLineArchive.GET(NotificationEntryTable."Record ID") THEN
                            IF SalesHeaderArchive.GET(TableSalesLineArchive."Document Type", TableSalesLineArchive."Document No.", TableSalesLineArchive."Doc. No. Occurrence", TableSalesLineArchive."Version No.") THEN;
                        BodyText := 'Dear ' + SalesHeaderArchive."Sell-to Customer Name" + ',';
                        BodyText += '<br><br>';
                        BodyText += 'You had ordered the below mentioned Item(s),  which is now available. Given below are current stock details of an old order which could not be supplied.';

                        BodyText += '<br><br>';
                        //Table Start
                        BodyText += Text60005;
                        BodyText += Text60006;
                        BodyText += Text50027 + Text50026 + Text50041 + Text60012 + 'S.No.' + Text60013 + Text60003;
                        BodyText += Text50030 + Text60012 + 'Order No.' + Text60013 + Text60003;
                        BodyText += Text50030 + Text60012 + 'Order Date' + Text60013 + Text60003;
                        SrNo := 1;
                        BodyText += Text50030 + Text60012 + 'Item Description' + Text60013 + Text60003;
                        BodyText += Text50030 + Text60012 + 'Order Qty. (Sqm)' + Text60013 + Text60003;
                        BodyText += Text50030 + Text60012 + 'Available Qty. (Sqm) on ' + FORMAT(TODAY) + Text60013 + Text60003;
                        BodyText += Text60004;
                        REPEAT
                            IF TableSalesLineArchive.GET(NotificationEntryTable."Record ID") THEN BEGIN
                                IF SalesHeaderArchive.GET(TableSalesLineArchive."Document Type", TableSalesLineArchive."Document No.", TableSalesLineArchive."Doc. No. Occurrence", TableSalesLineArchive."Version No.") THEN;
                                BodyText += Text50026 + Text50041 + FORMAT(SrNo) + Text60003;
                                BodyText += Text50041 + FORMAT(TableSalesLineArchive."Document No.") + Text60003;
                                BodyText += Text50041 + FORMAT(SalesHeaderArchive."Order Date") + Text60003;
                                BodyText += Text50041 + FORMAT(TableSalesLineArchive.Description) + Text60003;
                                BodyText += Text50041 + FORMAT(TableSalesLineArchive."Outstanding Qty. (Base)") + Text60003;

                                BodyText += Text50041 + FORMAT(NotificationEntryTable."Available Inventory") + Text60003;
                                BodyText += Text60004;
                                SrNo += 1;
                            END;
                            NotificationEntryTable.VALIDATE(Notify, TRUE);
                            NotificationEntryTable.MODIFY;
                        UNTIL NotificationEntryTable.NEXT = 0;

                    END;
                    //
                    //MSKS
                    //MSKS
                    BodyText += Text60004;
                    BodyText += Text60005;
                    BodyText += Text60006;
                    BodyText += Text60011;
                    //Table End
                    BodyText += Text60011;

                    BodyText += '<br><br>';
                    //BodyText +='<br><br>';
                    BodyText += 'For your information and action if any.<br>';
                    BodyText += 'Yours Truely, <br>';
                    BodyText += '<br><br>';
                    BodyText += 'Team Orient Bell Limited  <br>';

                    EmailCCList.add('donotreply@orientbell.com');
                    //cduSMTPMail.AddCC('kulbhushan.sharma@orientbell.com');
                    EmailMsg.Create(EmailAddressList, 'Stock Available ', BodyText, true, EmailBccList, EmailCCList);
                    EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                END;

    end;

    local procedure GetInventory(ItemCode: Code[20]; LocFilter: Code[20]): Decimal
    var
        Item: Record Item;
    begin
        Item.SETRANGE("No.", ItemCode);
        Item.SETFILTER("Location Filter", LocFilter);
        IF Item.FINDFIRST THEN BEGIN
            Item.CALCFIELDS(Inventory);
            EXIT(Item.Inventory);
        END;
    end;
}

