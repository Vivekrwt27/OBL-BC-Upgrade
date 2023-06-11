codeunit 50065 "Vehicle Notification"
{

    trigger OnRun()
    var
        SalesJournalReport: Report "Sales Journal Report";
        FileName: Text;
        SalesJpurnalData: Record "Sales Jpurnal Data";
        FileMgmt: Codeunit "File Management";
    begin

        FileName := '\\192.168.1.176\PN_master\SalesJournalReport_' + FORMAT(TODAY - 1) + '.xlsx';
        CLEAR(FileMgmt);
        SalesJpurnalData.RESET;
        SalesJpurnalData.SETFILTER("Posting Date", '%1..%2', 20220104D, TODAY - 1);
        IF SalesJpurnalData.FINDFIRST THEN BEGIN
            // ServerTempFile := FileMgmt.ServerTempFileName('xlsx');
            SalesJournalReport.SETTABLEVIEW(SalesJpurnalData);
            //REPORT.SAVEASEXCEL(50249,ServerTempFile,SalesJpurnalData);
            SalesJournalReport.USEREQUESTPAGE(FALSE);
            /*  IF SalesJournalReport.SAVEASEXCEL(ServerTempFile) THEN
                  FileMgmt.DownloadToFile(ServerTempFile, FileName); */ // 15578//copy to my network folder
        END;
        IF GUIALLOWED THEN
            MESSAGE('Done');
        SendVehicleNotificationByJobQueue;
    end;

    var
        RecSOHdr: Record "Sales Header";
        cdeSMSSendMessage: Codeunit "SMS - Send Message";
        Text0001: Label 'This is to inform you that Material is available against order no. ';
        Text0002: Label 'Pleaase arrange the Vehicle';
        ServerTempFile: Text;


    procedure SendVehicleNotification(SalesHeader: Record "Sales Header")
    var
        recCustomer: Record Customer;
        // CdeUnitSMTPMail: Codeunit 400;
        txtMess: Text[250];
        txtSndEmailId: Text[250];
        txtRecvEmailId: Text[250];
        txtCCEmailId: Text[250];
        txtBCCEmailId: Text[250];
        txtSenderName: Text[250];
        txtSubj: Text[100];
        //  RecSMTPMailSetup: Record 409;
        RecItem: Record Item;
        recSalespersonPurchaser: Record "Salesperson/Purchaser";
        recVehicleNotificationEntries: Record "Vehicle Notification  Entries";
        recVehicleNotificationLastEntry: Record "Vehicle Notification  Entries";
    begin

        txtBCCEmailId := '';
        txtCCEmailId := '';
        txtRecvEmailId := '';
        txtSndEmailId := '';
        txtSubj := 'REMINDER-' + FORMAT(SalesHeader."No. of Vehicle Notification" + 1) + '  Vehicle Notification for Sales Order No. ' + SalesHeader."No.";

        ///  CLEAR(CdeUnitSMTPMail);
        ///  RecSMTPMailSetup.GET();
        ///   txtSndEmailId := RecSMTPMailSetup."Sender Email";
        //txtRecvEmailId:='rohan.garg@mindshell.info';
        txtSenderName := 'Team Morbi';
        ///    CdeUnitSMTPMail.CreateMessage(txtSenderName, txtSndEmailId, txtRecvEmailId, txtSubj, '', TRUE);
        recCustomer.GET(SalesHeader."Sell-to Customer No.");

        recVehicleNotificationEntries.INIT;
        recVehicleNotificationEntries."Sales Order No." := SalesHeader."No.";
        recVehicleNotificationEntries."Sales Order Date" := SalesHeader."Document Date";
        recVehicleNotificationEntries."Releasing Date" := SalesHeader."Payment Date 3";
        recVehicleNotificationEntries."Customer No." := SalesHeader."Sell-to Customer No.";
        recVehicleNotificationEntries."Customer Name" := SalesHeader."Sell-to Customer Name";

        //Branch Head
        IF recCustomer."PCH Code" <> '' THEN BEGIN
            recSalespersonPurchaser.GET(recCustomer."PCH Code");
            IF recSalespersonPurchaser."E-Mail" <> '' THEN
                /// CdeUnitSMTPMail.AddRecipients(recSalespersonPurchaser."E-Mail");
                IF recSalespersonPurchaser."Phone No." <> '' THEN
                    cdeSMSSendMessage.SendMessage(recSalespersonPurchaser."Phone No.", Text0001 + ' ' + SalesHeader."No." + ' ' + Text0002, 1, '');
            recVehicleNotificationEntries."Branch Head" := recSalespersonPurchaser."E-Mail";

        END;

        IF recCustomer."Salesperson Code" <> '' THEN BEGIN
            recSalespersonPurchaser.GET(recCustomer."Salesperson Code");
            IF recSalespersonPurchaser."E-Mail" <> '' THEN
                ///   CdeUnitSMTPMail.AddRecipients(recSalespersonPurchaser."E-Mail");
                IF recSalespersonPurchaser."Phone No." <> '' THEN
                    cdeSMSSendMessage.SendMessage(recSalespersonPurchaser."Phone No.", Text0001 + ' ' + SalesHeader."No." + ' ' + Text0002, 1, '');
            recVehicleNotificationEntries.Salesperson := recSalespersonPurchaser."E-Mail";

        END;
        IF SalesHeader."No. of Vehicle Notification" = 0 THEN BEGIN
            ///  CdeUnitSMTPMail.AddRecipients('morbi@orientbell.com');
            ///  CdeUnitSMTPMail.AddRecipients('donotreply@orientbell.com');

        END;
        recSalespersonPurchaser.GET(recCustomer."Salesperson Code");
        /*  CdeUnitSMTPMail.AppendBody('REMINDER-' + FORMAT(SalesHeader."No. of Vehicle Notification" + 1));
          CdeUnitSMTPMail.AppendBody('<br><br>Dear ' + recSalespersonPurchaser.Name + ' ,');
          CdeUnitSMTPMail.AppendBody('<br><br>This inform you that Material is available against order no. ' + SalesHeader."No." + 'Order Date ' + FORMAT(SalesHeader."Order Date") +
                                     'Order Process Date' + FORMAT(SalesHeader."Payment Date 3") + 'for Channel Partner -' + SalesHeader."Sell-to Customer Name");
          CdeUnitSMTPMail.AppendBody('<br><br>You are requested to please arrange / place vehicle for despatch the material on priority.<br><br>');

          CdeUnitSMTPMail.AppendBody('Regards');
          CdeUnitSMTPMail.AppendBody('<br>Team Morbi<br>');
          CdeUnitSMTPMail.AppendBody('Orient Bell Limited<br>');
          //CdeUnitSMTPMail.AddAttachment('E:\Rohan\Schedule Gross Requirement.pdf','Schedule Gross Requirement.pdf');*/ // 15578

        ///   IF CdeUnitSMTPMail.TrySend THEN BEGIN
        //MESSAGE('Mail Send Successfully!');

        recVehicleNotificationLastEntry.RESET;
        recVehicleNotificationLastEntry.SETCURRENTKEY("No. of Reminder");
        recVehicleNotificationLastEntry.SETRANGE("Sales Order No.", SalesHeader."No.");
        IF recVehicleNotificationLastEntry.FINDLAST THEN
            recVehicleNotificationEntries."No. of Reminder" := recVehicleNotificationLastEntry."No. of Reminder" + 1
        ELSE
            recVehicleNotificationEntries."No. of Reminder" := 1;

        recVehicleNotificationEntries.INSERT(TRUE);
        SalesHeader."No. of Vehicle Notification" += 1;
        SalesHeader.MODIFY;
        MESSAGE('Mail Not Send Yet');
    END;

    local procedure Addattachment()
    begin

        /*DestinationFileName := ClientAppFile.GetTempPath+'Enquiry.pdf';
        
        IF FILE.EXISTS(DestinationFileName) THEN
          ERASE(DestinationFileName);
        
        EnquiryReport.SETTABLEVIEW(RFQHeader);
        EnquiryReport.SAVEASPDF(DestinationFileName);
        //MESSAGE(DestinationFileName);
        CdeUnitSMTPMail.AddAttachment(DestinationFileName,'Enquiry-'+RFQHeader."No."+'.pdf');*/

    end;

    procedure SendVehicleNotificationByJobQueue()
    begin
        RecSOHdr.RESET;
        RecSOHdr.SETRANGE("Location Code", 'DP-MORBI');
        RecSOHdr.SETRANGE("Truck No.", '');
        RecSOHdr.SETRANGE("Document Type", RecSOHdr."Document Type"::Order);
        RecSOHdr.SETFILTER("No. of Vehicle Notification", '>=%1&<4', 1, 4);
        IF RecSOHdr.FINDFIRST THEN
            REPEAT
                SendVehicleNotification(RecSOHdr);
            UNTIL RecSOHdr.NEXT = 0;
    end;


    procedure SendVendorNotification(SalesHeader: Record "Sales Header")
    var
        recCustomer: Record Customer;
        //  CdeUnitSMTPMail: Codeunit 400;
        txtMess: Text[250];
        txtSndEmailId: Text[250];
        txtRecvEmailId: Text[250];
        txtCCEmailId: Text[250];
        txtBCCEmailId: Text[250];
        txtSenderName: Text[250];
        txtSubj: Text[100];
        //   RecSMTPMailSetup: Record 409;
        RecItem: Record Item;
        recSalespersonPurchaser: Record "Salesperson/Purchaser";
        recVehicleNotificationEntries: Record "Vehicle Notification  Entries";
        recVehicleNotificationLastEntry: Record "Vehicle Notification  Entries";
        Vendor: Record Vendor;
        SalesLine: Record "Sales Line";
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
        Amt: Decimal;
        LastVendorNo: Code[20];
    begin
        SalesLine.RESET;
        SalesLine.SETCURRENTKEY("Document Type", "Document No.", "Vendor Code");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETFILTER("Vendor Code", '<>%1', '');
        IF SalesLine.FINDFIRST THEN BEGIN
            REPEAT
                IF LastVendorNo <> SalesLine."Vendor Code" THEN BEGIN
                    CreateVendorNotificationMail(SalesHeader, SalesLine."Vendor Code");
                    LastVendorNo := SalesLine."Vendor Code";
                END;
            UNTIL SalesLine.NEXT = 0;
        END;
    end;


    procedure CreateVendorNotificationMail(SalesHeader: Record "Sales Header"; VendorNo: Code[20])
    var
        recCustomer: Record Customer;
        UserSetup: Record "User Setup";
        //  CdeUnitSMTPMail: Codeunit 400;
        txtMess: Text[250];
        txtSndEmailId: Text[250];
        txtRecvEmailId: Text[250];
        txtCCEmailId: Text[250];
        txtBCCEmailId: Text[250];
        txtSenderName: Text[250];
        txtSubj: Text[100];
        ///   RecSMTPMailSetup: Record 409;
        RecItem: Record Item;
        recSalespersonPurchaser: Record "Salesperson/Purchaser";
        recVehicleNotificationEntries: Record "Vehicle Notification  Entries";
        recVehicleNotificationLastEntry: Record "Vehicle Notification  Entries";
        Vendor: Record Vendor;
        SalesLine: Record "Sales Line";
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
        Text50041: Label '<TD  width="5%" Align=Center>';
        SrNo: Integer;
        Amt: Decimal;
        Location: Record Location;
        TransportMethod: Record "Shipping Agent";
        Text50042: Label '<table border="1" width="10%">';
        Text50043: Label '<td width="5%">';
        Text50044: Label '<td width="25%" Align=Center>';
        EmailObj: Codeunit Email; // 15578TEXT
        EmailMsg: Codeunit "Email Message";
        EmailCCList: List of [Text];
        BodyText: Text;
        EmailAddressList: List of [Text];
        FileMgmt: Codeunit "File Management";
        EmailBccList: list of [Text];
        TempBlobCU: Codeunit "Temp Blob";
        InstreamVar: InStream;
        OutstreamVar: OutStream;


    begin
        Clear(EmailAddressList);
        Clear(EmailCCList);
        Clear(EmailBccList);

        txtBCCEmailId := '';
        //txtCCEmailId:='kulbhushan.sharma@orientbell.com';
        txtCCEmailId := 'donotreply@orientbell.com';

        txtRecvEmailId := '';
        txtSndEmailId := '';
        txtSubj := 'Loading against Sales Order No. ' + SalesHeader."No." + ' ' + 'Ship To City ' + SalesHeader."Ship-to City";

        Vendor.GET(GetVendorCode(VendorNo));
        IF STRLEN(Vendor."Contact Mail ID") <= 3 THEN
            EXIT;

        ///     CLEAR(CdeUnitSMTPMail);
        ///     RecSMTPMailSetup.GET();
        txtSndEmailId := 'morbi@orientbell.com';
        //txtSndEmailId:=RecSMTPMailSetup."Sender Email";
        txtRecvEmailId := Vendor."Contact Mail ID";
        txtSenderName := 'Team Morbi';
        ///     CdeUnitSMTPMail.CreateMessage(txtSenderName, txtSndEmailId, txtRecvEmailId, txtSubj, '', TRUE);
        recCustomer.GET(SalesHeader."Sell-to Customer No.");
        EmailAddressList.Add(txtSndEmailId);
        EmailMsg.Create(EmailAddressList, txtSubj, BodyText, true, EmailBccList, EmailCCList);
        //CdeUnitSMTPMail.AddCC('kulbhushan.sharma@orientbell.com');
        EmailCCList.add('donotreply@orientbell.com');
        EmailCCList.add('morbi@orientbell.com');
        EmailCCList.add('surender.mantri@orientbell.com');

        Location.GET(SalesHeader."Location Code");

        IF txtCCEmailId <> '' THEN
            EmailCCList.add(txtCCEmailId);
        EmailCCList.add('<br>Dear ' + Vendor.Name + ' ,');

        IF TransportMethod.GET(SalesHeader."Shipping Agent Code") THEN;
        BodyText := '<br><br>This inform you that Following Material need to despatch against order no. ' + SalesHeader."No." + ' Order Date ' + FORMAT(SalesHeader."Order Date") + '.';
        BodyText += '<br>';
        BodyText += '<br>' + 'Billing To : ';
        BodyText += '<br>' + 'Orient Bell Limited';
        BodyText += '<br>' + Location.Address;
        BodyText += '<br>' + Location."Address 2";
        BodyText += '<br>' + 'GST No.' + ' ' + Location."GST Registration No." + '<br><br>';
        BodyText += '<br>';
        BodyText += 'Transporter Detail as Under :';
        BodyText += '<br>';
        BodyText += 'Vehicle No. -' + SalesHeader."Truck No.";
        BodyText += '<br>';
        BodyText += 'Transporter Name - ' + SalesHeader."Transporter Name";
        BodyText += '<br>';
        BodyText += '<br>';
        BodyText += '<br>';
        //CdeUnitSMTPMail.AppendBody('Capacity of Vehicle -'+ TransportMethod.Name);
        BodyText += '<br>';

        //
        BodyText += Text50027 + Text50026 + Text50041 + Text60012 + 'S.No.' + Text60013 + Text60003;
        //CdeUnitSMTPMail.AppendBody(Text50030+Text60012+'Item No.' +Text60013+Text60003);
        // CdeUnitSMTPMail.AppendBody(Text50030+Text60012+'Not To Executed' +Text60013+Text60003);
        SrNo := 1;
        BodyText += Text50044 + Text60012 + 'Description' + Text60013 + Text60003;
        BodyText += Text50044 + Text60012 + 'Description 2' + Text60013 + Text60003;
        BodyText += Text50044 + Text60012 + 'Batch No.' + Text60013 + Text60003;
        BodyText += Text50043 + Text60012 + 'Quantity' + Text60013 + Text60003;
        BodyText += Text50041 + Text60012 + 'MRP' + Text60013 + Text60003;
        BodyText += Text50041 + Text60012 + 'Dispatch Priority' + Text60013 + Text60003;
        BodyText += Text60004;
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETFILTER("Vendor Code", '%1', VendorNo);
        IF SalesLine.FINDFIRST THEN BEGIN
            REPEAT
                IF SalesLine."Outstanding Quantity" > 0 THEN BEGIN
                    BodyText += Text50026 + Text50041 + FORMAT(SrNo) + Text60003;
                    BodyText += Text50041 + FORMAT(SalesLine.Description) + Text60003;
                    BodyText += Text50041 + FORMAT(SalesLine."Description 2") + Text60003;
                    BodyText += Text50041 + FORMAT(SalesLine."Morbi Batch No.") + Text60003;
                    BodyText += Text50041 + FORMAT(SalesLine."Outstanding Quantity") + Text60003;
                    ///    BodyText +=Text50041 + FORMAT(SalesLine."MRP Price") + Text60003;
                    IF FORMAT(SalesLine."Despatch Periority") = '1' THEN
                        BodyText += Text50041 + FORMAT('First Load') + Text60003
                    ELSE
                        IF FORMAT(SalesLine."Despatch Periority") = '2' THEN
                            BodyText += Text50041 + FORMAT('Second Load') + Text60003
                        ELSE
                            IF FORMAT(SalesLine."Despatch Periority") = '3' THEN
                                BodyText += Text50041 + FORMAT('Third Load') + Text60003
                            ELSE
                                IF FORMAT(SalesLine."Despatch Periority") = '4' THEN
                                    BodyText += Text50041 + FORMAT('Forth Load') + Text60003
                                ELSE
                                    IF FORMAT(SalesLine."Despatch Periority") = '5' THEN
                                        BodyText += Text50041 + FORMAT('Last Load') + Text60003;
                    BodyText += Text60004;
                    SrNo += 1;
                    Amt += ROUND(SalesLine.Amount, 0.01, '=');
                END;
            UNTIL SalesLine.NEXT = 0;
        END;

        //
        BodyText += Text60004;
        BodyText += Text60005;
        BodyText += Text50026 + Text50041 + FORMAT('') + Text60003;
        UserSetup.GET(USERID);
        BodyText += '<br>' + 'Regards';
        BodyText += '<br>' + 'Contact Person :- ' + UserSetup."User Name";
        BodyText += '<br>Team Morbi<br>';
        BodyText += 'Orient Bell Limited<br>';
        IF EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default) THEN BEGIN
            MESSAGE('Mail Send Successfully!');
        END
        ELSE
            MESSAGE('Mail Not Send Yet');
    end;

    local procedure GetVendorCode(LocCode: Code[20]): Code[20]
    var
        Vendor: Record Vendor;
    begin
        Vendor.RESET;
        Vendor.SETFILTER("Morbi Location Code", '%1', LocCode);
        IF Vendor.FINDFIRST THEN
            EXIT(Vendor."No.");
    end;
}

