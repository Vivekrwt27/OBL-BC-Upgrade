codeunit 50066 "Pending Approval Notification"
{
    Permissions = TableData "Purch. Rcpt. Line" = rimd;

    trigger OnRun()
    var
        UserSetup: Record "User Setup";
    begin
        CLEAR(TempApprovalEntry);
        GetPendingApprovalEntries(0);
        UserSetup.RESET;
        //UserSetup.SETRANGE("User ID",'FA001');
        IF UserSetup.FINDFIRST THEN
            REPEAT
                SendNotificationMail(UserSetup);
            UNTIL UserSetup.NEXT = 0;


        UserSetup.RESET;
        //UserSetup.SETRANGE("User ID",'PU004');
        IF UserSetup.FINDFIRST THEN
            REPEAT
                SendIndentGRNNotification(UserSetup);
            UNTIL UserSetup.NEXT = 0;

        IF GUIALLOWED THEN
            MESSAGE('Done');
    end;

    var
        TempApprovalEntry: Record "Approval Entry" temporary;

    local procedure GetPendingApprovalEntries(TableID: Integer)
    var
        PendingApprovalEntries: Query "Pending Approval Entries";
        ApprovalEntry: Record "Approval Entry";
        IndentHeader: Record "Indent Header";
        ApprovalRequired: Boolean;
        SalesHeader: Record "Sales Header";
        PurchaseHeader: Record "Purchase Header";
        BudgetMaster: Record "Budget Master";
    begin
        CLEAR(PendingApprovalEntries);
        PendingApprovalEntries.OPEN;
        WHILE PendingApprovalEntries.READ DO BEGIN
            ApprovalEntry.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Sequence No.", "Record ID to Approve");
            ApprovalEntry.SETRANGE("Table ID", PendingApprovalEntries.Table_ID);
            ApprovalEntry.SETRANGE("Document No.", PendingApprovalEntries.Document_No);
            ApprovalEntry.SETRANGE("Sequence No.", PendingApprovalEntries.Min_Sequence_No);
            ApprovalEntry.SETFILTER(Status, '%1|%2', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created);
            IF ApprovalEntry.FINDFIRST THEN BEGIN
                ApprovalRequired := FALSE;
                CASE ApprovalEntry."Table ID" OF
                    50016:
                        BEGIN
                            IF IndentHeader.GET(ApprovalEntry."Document No.") THEN BEGIN
                                IF IndentHeader.Status IN [IndentHeader.Status::Authorization1, IndentHeader.Status::Authorization2, IndentHeader.Status::Authorization3] THEN
                                    ApprovalRequired := TRUE;
                            END;
                        END;
                    36:
                        BEGIN
                            IF SalesHeader.GET(ApprovalEntry."Document Type", ApprovalEntry."Document No.") THEN BEGIN
                                IF SalesHeader.Status IN [SalesHeader.Status::"Pending Approval"] THEN
                                    ApprovalRequired := TRUE;
                            END;
                        END;
                    38:
                        BEGIN
                            IF PurchaseHeader.GET(ApprovalEntry."Document Type", ApprovalEntry."Document No.") THEN BEGIN
                                IF PurchaseHeader.Status IN [PurchaseHeader.Status::"Pending Approval"] THEN
                                    ApprovalRequired := TRUE;
                            END;
                        END;
                    50084:
                        BEGIN
                            IF BudgetMaster.GET(BudgetMaster."Capex Request", ApprovalEntry."Document No.") THEN BEGIN
                                IF BudgetMaster.Status IN [BudgetMaster.Status::"Pending for Approval"] THEN
                                    ApprovalRequired := TRUE;
                            END;
                        END;
                END;
                IF ApprovalRequired THEN BEGIN
                    TempApprovalEntry.INIT;
                    TempApprovalEntry.TRANSFERFIELDS(ApprovalEntry);
                    TempApprovalEntry.INSERT;
                END;
            END;
        END;
    end;


    procedure SendNotificationMail(UserSetup: Record "User Setup")
    var
        // cduSMTPMail: Codeunit "400";
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
        TextW50010: Label '<td width="10%">';
        Text50030: Label '<td width="18%">';
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
        Text50045: Label '<a href=';
        Text50046: Label '>Approve Or Reject';
        Text50047: Label '</a>';
        SUserSetup: Record "User Setup";
        AppEntry: Record "Approval Entry";
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

        ///    CLEAR(cduSMTPMail);
        TempApprovalEntry.RESET;
        TempApprovalEntry.SETCURRENTKEY("Table ID", "Document Type", "Document No.", "Sequence No.", "Record ID to Approve");
        TempApprovalEntry.SETRANGE(EmailID, UserSetup."E-Mail");
        IF TempApprovalEntry.FINDFIRST THEN BEGIN
            IF UserSetup."E-Mail" <> '' THEN BEGIN
                //    txtEmailID := 'kulwant@mindshell.info';
                txtEmailID := UserSetup."E-Mail";
                //cduSMTPMail.CreateMessage('Orient Bell Limited.','donotreply@orientbell.com',
                //txtEmailID,'Approval Mail ' + SalesHeaderArchive."No." ,'',TRUE);
                /* cduSMTPMail.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
                                           txtEmailID, 'Pending Approval Notifications', '', TRUE);*/ // 15578
                EmailAddressList.Add('donotreply@orientbell.com');
                BodyText := 'Dear ' + UserSetup."User Name" + ',';
                BodyText += '<br><br>';
                BodyText += 'Following documents are pending for your Approval. You are requested to Please clear the Pendencies at the earliest!!';

                BodyText += '<br><br>';
                //Table Start
                BodyText += Text60005;
                BodyText += Text60006;
                BodyText += Text50027 + Text50026 + Text50041 + Text60012 + 'S.No.' + Text60013 + Text60003;
                BodyText += TextW50010 + Text60012 + 'Type' + Text60013 + Text60003;
                BodyText += Text50030 + Text60012 + 'Document No.' + Text60013 + Text60003;
                SrNo := 1;
                BodyText += Text50030 + Text60012 + 'Date' + Text60013 + Text60003;
                BodyText += Text50030 + Text60012 + 'Created' + Text60013 + Text60003;
                BodyText += Text50030 + Text60012 + 'Last Appr. By' + Text60013 + Text60003;
                BodyText += Text50030 + Text60012 + 'Last Appr.Dt.' + Text60013 + Text60003;
                BodyText += Text50030 + Text60012 + 'Approval Link ' + Text60013 + Text60003;
                BodyText += Text60004;
                REPEAT
                    BodyText += Text50026 + Text50041 + FORMAT(SrNo) + Text60003;
                    CASE
                    TempApprovalEntry."Table ID" OF
                        50016:
                            BodyText += Text50041 + FORMAT('Indent') + Text60003;
                        36:
                            BodyText += Text50041 + FORMAT('Sales Order') + Text60003;
                        38:
                            BodyText += Text50041 + FORMAT('Purchase Order') + Text60003;
                        50084:
                            BodyText += Text50041 + FORMAT('Capex') + Text60003;
                        ELSE
                            BodyText += Text50041 + FORMAT('Others') + Text60003;

                    END;
                    BodyText += Text50041 + FORMAT(TempApprovalEntry."Document No.") + Text60003;
                    BodyText += Text50041 + FORMAT(TempApprovalEntry."Date-Time Sent for Approval") + Text60003;
                    IF SUserSetup.GET(TempApprovalEntry."Sender ID") THEN
                        BodyText += Text50041 + FORMAT(SUserSetup."User Name") + Text60003;

                    AppEntry.RESET;
                    AppEntry.SETRANGE("Table ID", TempApprovalEntry."Table ID");
                    AppEntry.SETRANGE("Document No.", TempApprovalEntry."Document No.");
                    AppEntry.SETFILTER("Sequence No.", '<%1', TempApprovalEntry."Sequence No.");
                    IF AppEntry.FINDLAST THEN BEGIN
                        IF SUserSetup.GET(AppEntry."Approver ID") THEN BEGIN
                            BodyText += Text50041 + FORMAT(SUserSetup."User Name") + Text60003;
                            BodyText += Text50041 + FORMAT(AppEntry."Last TimeStamp") + Text60003;
                        END ELSE BEGIN
                            BodyText += Text50041 + FORMAT(' ') + Text60003;
                            BodyText += Text50041 + FORMAT(AppEntry."Last TimeStamp") + Text60003;
                        END;
                    END ELSE BEGIN
                        BodyText += Text50041 + FORMAT(' ') + Text60003;
                        BodyText += Text50041 + FORMAT(' ') + Text60003;
                    END;
                    //SMTPMail.AppendBody(Text50045+getApprovalLink(36,SalesHeader."No.",1)+Text50046+Text50047);
                    BodyText += Text50041 + Text50045 + FORMAT('http://erp.orientapps.com/mailapproval/?ref=' + FORMAT(TempApprovalEntry."GUID Key")) + Text50046 + Text50047 + Text60003;
                    BodyText += Text60004;
                    SrNo += 1;
                UNTIL TempApprovalEntry.NEXT = 0;

            END;

            BodyText += Text60004;
            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text60011;
            //Table End
            BodyText += Text60011;

            BodyText += '<br><br>';
            //BodyText +='<br><br>');
            BodyText += 'For your information and action if any.<br>';
            BodyText += 'Yours Truely, <br>';
            BodyText += '<br><br>';
            BodyText += 'Team Orient Bell Limited  <br>';

            EmailCCList.add('donotreply@orientbell.com');
            EmailBccList.add('kulbhushan.sharma@orientbell.com');
            EmailMsg.Create(EmailAddressList, 'Pending Approval Notifications', BodyText, true, EmailBccList, EmailCCList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        END;
    end;


    procedure SendIndentGRNNotification(UserSetup: Record "User Setup")
    var
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
        Text50030: Label '<td width="15%">';
        Text50031: Label '<td width="50%">';
        Text50032: Label '<FONT SIZE=6 FACE="Sans Serif">';
        Text50041: Label '<TD  width=5 Align=Center>';
        Text50045: Label '<a href=';
        Text50046: Label '>Approve Or Reject';
        Text50047: Label '</a>';
        //   cduSMTPMail: Codeunit "400";
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
        SrNo: Integer;
        PurchaseLine: Record "Purchase Line";
        Amt: Decimal;
        SalesHeaderArchive: Record "Sales Header Archive";
        NotificationEntryTable: Record "Notification Entry Table";
        Customer: Record Customer;
        SUserSetup: Record "User Setup";
        GRNIndentNotification: Query "GRN Indent Notification";
        IntimateSKDStore: Boolean;
        IntimateDRAStore: Boolean;
        IntimateHSKStore: Boolean;
        PurchRcptLine: Record "Purch. Rcpt. Line";
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
        CLEAR(GRNIndentNotification);
       // GRNIndentNotification.SETFILTER(GRNIndentNotification.IndentorFilter, '%1', UserSetup."User ID");
        //GRNIndentNotification.SETFILTER(GRNIndentNotification.PostDateFilter,'%1',TODAY-5);
        GRNIndentNotification.SETFILTER(GRNIndentNotification.Mailed, '%1', FALSE);
        GRNIndentNotification.OPEN;
        IF NOT GRNIndentNotification.READ THEN
            EXIT;

        IF UserSetup."E-Mail" <> '' THEN BEGIN
            //      txtEmailID := 'kulwant@mindshell.info';
            txtEmailID := UserSetup."E-Mail";
            //cduSMTPMail.CreateMessage('Orient Bell Limited.','donotreply@orientbell.com',
            //txtEmailID,'Approval Mail ' + SalesHeaderArchive."No." ,'',TRUE);
            /* cduSMTPMail.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
                                       txtEmailID, 'Indent Receipt Notifications -[' + FORMAT(TODAY, 9) + ']', '', TRUE);*/ // 15578
            EmailAddressList.Add('donotreply@orientbell.com');

            BodyText := 'Dear ' + UserSetup."User Name" + ',';
            BodyText += '<br><br>';
            BodyText += 'Following Material have been arrived at Store against Your Indents. You are requested to Please contact Store for Quality Check and Material Confirmation!!';

            BodyText += '<br><br>';
            //Table Start
            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text50027 + Text50026 + Text50041 + Text60012 + 'S.No.' + Text60013 + Text60003;
            BodyText += Text50030 + Text60012 + 'Store Location' + Text60013 + Text60003;
            BodyText += Text50030 + Text60012 + 'GRN No.' + Text60013 + Text60003;
            SrNo := 1;
            BodyText += Text50030 + Text60012 + 'GRN Date' + Text60013 + Text60003;
            BodyText += Text50030 + Text60012 + 'Indent No.' + Text60013 + Text60003;
            BodyText += Text50030 + Text60012 + 'Item No.' + Text60013 + Text60003;
            BodyText += Text50030 + Text60012 + 'Description' + Text60013 + Text60003;
            BodyText += Text50030 + Text60012 + 'GRN Qty.' + Text60013 + Text60003;
            BodyText += Text60004;
           // GRNIndentNotification.SETFILTER(GRNIndentNotification.IndentorFilter, '%1', UserSetup."User ID");
            //GRNIndentNotification.SETFILTER(GRNIndentNotification.PostDateFilter,'%1',TODAY-1);
            GRNIndentNotification.SETFILTER(GRNIndentNotification.Mailed, '%1', FALSE);
            GRNIndentNotification.OPEN;
            WHILE GRNIndentNotification.READ DO BEGIN
                BodyText += Text50026 + Text50041 + FORMAT(SrNo) + Text60003;
                BodyText += Text50041 + FORMAT(GRNIndentNotification.Location_Code) + Text60003;
                BodyText += Text50041 + FORMAT(GRNIndentNotification.Document_No) + Text60003;
                BodyText += Text50041 + FORMAT(GRNIndentNotification.Posting_Date) + Text60003;
                BodyText += Text50041 + FORMAT(GRNIndentNotification.Indent_No) + Text60003;
                BodyText += Text50041 + FORMAT(GRNIndentNotification.No) + Text60003;
                BodyText += Text50041 + FORMAT(GRNIndentNotification.Description) + Text60003;
                BodyText += Text50041 + FORMAT(GRNIndentNotification.Actual_Quantity) + Text60003;
                BodyText += Text60004;
                SrNo += 1;
                IF GRNIndentNotification.Location_Code IN ['SKD-STORE'] THEN IntimateSKDStore := TRUE;
                IF GRNIndentNotification.Location_Code IN ['DRA-STORE'] THEN IntimateDRAStore := TRUE;
                IF GRNIndentNotification.Location_Code IN ['HSK-STORE'] THEN IntimateHSKStore := TRUE;
                PurchRcptLine.RESET;
                PurchRcptLine.SETRANGE("Document No.", GRNIndentNotification.Document_No);
                PurchRcptLine.SETRANGE("Line No.", GRNIndentNotification.PPRLineNo);
                IF PurchRcptLine.FINDFIRST THEN BEGIN
                    PurchRcptLine.Mailed := TRUE;
                    PurchRcptLine.MODIFY;
                END;

            END;

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
            EmailCCList.add('kulbhushan.sharma@orientbell.com');
            //cduSMTPMail.AddBCC('kulwant@mindshell.info');

            IF IntimateSKDStore THEN
                EmailCCList.add('omvir.singh@orientbell.com');
            IF IntimateDRAStore THEN
                EmailCCList.add('sanjay.maheshwari@orientbell.com');
            IF IntimateHSKStore THEN
                EmailCCList.add('mallikarjunaiah.mn@orientbell.com');
            EmailMsg.Create(EmailAddressList, 'Indent Receipt Notifications -[' + FORMAT(TODAY, 9) + ']', BodyText, true, EmailBccList, EmailCCList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
        END;
    end;
}

