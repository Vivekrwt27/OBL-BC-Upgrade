codeunit 50030 SendStateWiseReport
{

    trigger OnRun()
    var
        MatrixMaster: Record "Matrix Master";
        ZHCode: Code[10];
        PendingApprovalNotification: Codeunit "Pending Approval Notification";
        UserSetup: Record "User Setup";
    begin

        /*
        //Notification Start
        UserSetup.RESET;
        //UserSetup.SETRANGE("User ID",'PU004');
        IF UserSetup.FINDFIRST THEN
          REPEAT
            PendingApprovalNotification.SendIndentGRNNotification(UserSetup);
          UNTIL UserSetup.NEXT=0;
        //Notification End
         */
        GlbFromDate := CALCDATE('-CM', TODAY - 1);
        GlbToDate := TODAY - 1;

        //MSAK 190919 Run report id 50031
        REPORT.RUN(50031, FALSE, FALSE);
        //MSAK 190919 Run report id 50031

        //Generate Detail Sheets Caption
        GenerateReportDetailed;


        //Generate Target Report Caption
        MatrixMaster.RESET;
        MatrixMaster.SETCURRENTKEY(ZH, PCH);
        MatrixMaster.SETFILTER("Type 1", '<>%1', '');
        MatrixMaster.SETFILTER(Description, '<>%1', '');
        IF MatrixMaster.FINDFIRST THEN BEGIN
            GenerateTargetVSAchieveReport('', FALSE); //vale
            GenerateTargetVSAchieveReport('', TRUE); //gvt
            //GenerateTargetVSAchieveReporthsk('',TRUE); //hsk Report
            SLEEP(10);
            SendEmailTargetVsAchieve('1111688', '', FALSE); //send mail complete
            SendEmailTargetVsAchieve('1111739', '', FALSE); //send mail complete
            SendEmailTargetVsAchieve('1111808', '', FALSE); //send mail complete
            SendEmailTargetVsAchieve('1111894', '', FALSE); //send mail complete
            SendEmailTargetVsAchieve('1111283', '', FALSE); //send mail complete
            SendEmailTargetVsAchieve('1110088', '', FALSE); //send mail complete
            SendEmailTargetVsAchieve('1110089', '', FALSE); //send mail complete
            SendEmailTargetVsAchieve('1112520', '', FALSE); //send mail complete
            SendEmailTargetVsAchieve('1112303', '', FALSE); //send mail complete
            SendEmailTargetVsAchieve('1111030', '', FALSE); //send mail complete 
            SendEmailTargetVsAchieve('1110175', '', FALSE); //send mail complete

            REPEAT
                //MatrixMaster.CALCFIELDS(PCH);
                IF MatrixMaster.ZH <> ZHCode THEN BEGIN
                    ZHCode := MatrixMaster.ZH;
                    GenerateZHTargetVSAchieveReport(ZHCode, FALSE);
                    GenerateZHTargetVSAchieveReport(ZHCode, TRUE);
                    SLEEP(10);
                    SendEmailZHTargetVsAchieve(ZHCode, MatrixMaster."Type 1", FALSE);

                END;
                GenerateTargetVSAchieveReport(MatrixMaster."Type 1", FALSE);
                GenerateTargetVSAchieveReport(MatrixMaster."Type 1", TRUE);
                SLEEP(10);
                SendEmailTargetVsAchieve(MatrixMaster.PCH, MatrixMaster."Type 1", FALSE);
            UNTIL MatrixMaster.NEXT = 0;
        END;


        // Mail to SP With Summary and Detail
        MailtoSPs;
        SLEEP(1000);
        // Mail to PCH With Summary and Detail
        MailtoPCH;
        SLEEP(1000);
        // Mail to ZH With Summary and Detail
        MailtoZH;
        SLEEP(1000);
        MailtoCSO;
        //MESSAGE('Done');

    end;

    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesPerson: Record "Salesperson/Purchaser";
        txtfile: Text[100];
        Customer: Record Customer;
        //   SMTPSetup: Record 409;
        GlbFromDate: Date;
        GlbToDate: Date;
        tamt: Decimal;
        UpdateMatrixMaster: Report "Update Matrix Master";
        MatrixMaster: Record "Matrix Master";


    procedure GenerateReportDetailed()
    var
        Report50033: Report "Sales TGT vs Achvmnt";
        Report50034: Report "Debtors Report MIS";
        Docno: Code[20];
        Docno1: Code[20];
        Report50036: Report "Sales Data (Sales Journal)";
    begin

        //PCH
        SalesPerson.RESET;
        SalesPerson.SETRANGE(Status, SalesPerson.Status::Enable);
        IF SalesPerson.FINDFIRST THEN
            REPEAT
                CLEAR(Report50036);
                Report50036.SetParameters(GlbFromDate, GlbToDate, '', '', SalesPerson.Code, '', FALSE);
                txtfile := 'BH_' + SalesPerson.Code;
            // Report50036.SAVEASEXCEL('C:\StateWiseReport\' + txtfile + '.xlsx');
            //IF GUIALLOWED THEN
            //MESSAGE('PCH Report Generated');
            UNTIL SalesPerson.NEXT = 0;

        //SP
        SalesPerson.RESET;
        SalesPerson.SETRANGE(Status, SalesPerson.Status::Enable);
        IF SalesPerson.FINDFIRST THEN
            REPEAT
                CLEAR(Report50036);
                Report50036.SetParameters(GlbFromDate, GlbToDate, '', '', '', SalesPerson.Code, FALSE);
                txtfile := 'SP_' + SalesPerson.Code;
            // Report50036.SAVEASEXCEL('C:\StateWiseReport\' + txtfile + '.xlsx');
            //IF GUIALLOWED THEN
            //MESSAGE('PCH Report Generated');
            UNTIL SalesPerson.NEXT = 0;

        //ZH
        SalesPerson.RESET;
        SalesPerson.SETRANGE(Status, SalesPerson.Status::Enable);
        IF SalesPerson.FINDFIRST THEN
            REPEAT
                CLEAR(Report50036);
                Report50036.SetParameters(GlbFromDate, GlbToDate, '', SalesPerson.Code, '', '', FALSE);
                txtfile := 'ZH_' + SalesPerson.Code;
            // Report50036.SAVEASEXCEL('C:\StateWiseReport\' + txtfile + '.xlsx');
            //IF GUIALLOWED THEN
            //MESSAGE('PCH Report Generated');
            UNTIL SalesPerson.NEXT = 0;

        CLEAR(Report50036);
        Report50036.SetParameters(GlbFromDate, GlbToDate, '', '', '', '', FALSE);
        txtfile := 'CSO_' + FORMAT(GlbToDate);
        txtfile := CONVERTSTR(txtfile, '/', '_');
        // Report50036.SAVEASEXCEL('C:\StateWiseReport\' + txtfile + '.xlsx');
    end;


    procedure SendEmailDetailed()
    var
        //  SMTPMail: Codeunit 400;
        //  SMTPMailSetup: Record 409;
        Docno2: Code[20];
        Docno3: Code[20];
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
        //PCH
        SalesPerson.RESET;
        IF SalesPerson.FINDFIRST THEN
            REPEAT
                IF SalesPerson."E-Mail" <> '' THEN BEGIN
                    /*   SMTPMailSetup.GET;
                       SMTPMailSetup.TESTFIELD("User ID");
                       CLEAR(SMTPMail);
                       SMTPMail.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com', SalesPerson."E-Mail", 'State Wise Report', '', TRUE);*/
                    //        SMTPMail.CreateMessage('Orient Bell Limited.','donotreply@orientbell.com','akash.kumar@mindshell.info','State Wise Report','', TRUE);
                    BodyText := 'Dear Sir <br>';
                    BodyText += 'Please find the attached report with this email. <br><br>';
                    BodyText += 'Thank You and Have a Good Day!';

                    txtfile := 'BH_' + Customer."PCH Code";
                    // if File.Exists('C:\StateWiseReport\' + txtfile + '.xlsx') THEN begin
                    // FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\StateWiseReport\' + txtfile + '.xlsx');
                    if TempBlobCU.HasValue() then begin
                        TempBlobCU.CreateInStream(InstreamVar);
                        EmailMsg.Create(EmailAddressList, 'State Wise Report', BodyText, true, EmailBccList, EmailCCList);
                        // if File.Exists('C:\StateWiseReport\' + txtfile + '.xlsx') THEN
                        EmailMsg.AddAttachment('C:\StateWiseReport\' + txtfile + '.xlsx', 'application/pdf', InstreamVar);
                        EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                        // END;
                        /* IF (EXISTS('C:\StateWiseReport\' + txtfile + '.xlsx')) THEN BEGIN
                             SMTPMail.AddAttachment('C:\StateWiseReport\' + txtfile + '.xlsx', txtfile + '.xlsx');
                             SMTPMail.Send();
                         END;*/ // 15578
                    END;
                end;
            UNTIL SalesPerson.NEXT = 0;

        //ZH
        SalesPerson.RESET;
        IF SalesPerson.FINDFIRST THEN
            REPEAT
                IF SalesPerson."E-Mail" <> '' THEN BEGIN
                    // SMTPMailSetup.GET;
                    // SMTPMailSetup.TESTFIELD("User ID");
                    // CLEAR(SMTPMail);
                    // 15578 SMTPMail.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com', SalesPerson."E-Mail", 'State Wise Report', '', TRUE);
                    //        SMTPMail.CreateMessage('Orient Bell Limited.','donotreply@orientbell.com','akash.kumar@mindshell.info','State Wise Report','', TRUE);
                    EmailAddressList.Add('donotreply@orientbell.com');
                    BodyText := 'Dear Sir <br>';
                    BodyText += 'Please find the attached report with this email. <br><br>';
                    BodyText += 'Thank You and Have a Good Day!';
                    txtfile := 'ZH_' + Customer."Zonal Head";
                    /* if File.Exists('C:\StateWiseReport\' + txtfile + '.xlsx') THEN begin
                        FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\StateWiseReport\' + txtfile + '.xlsx');
                        if TempBlobCU.HasValue() then begin
                            TempBlobCU.CreateInStream(InstreamVar);
                            EmailMsg.Create(EmailAddressList, 'State Wise Report', BodyText, true, EmailBccList, EmailCCList);
                            if File.Exists('C:\StateWiseReport\' + txtfile + '.xlsx') THEN
                                EmailMsg.AddAttachment('C:\StateWiseReport\' + txtfile + '.xlsx', 'application/pdf', InstreamVar);
                            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                        END;
                    end;
 */
                    /*IF (EXISTS('C:\StateWiseReport\' + txtfile + '.xlsx')) THEN BEGIN
                        SMTPMail.AddAttachment('C:\StateWiseReport\' + txtfile + '.xlsx', txtfile + '.xlsx');
                        SMTPMail.Send();
                    END;*/ // 15578
                END;
            UNTIL SalesPerson.NEXT = 0;

        //SP
        SalesPerson.RESET;
        IF SalesPerson.FINDFIRST THEN
            REPEAT
                IF SalesPerson."E-Mail" <> '' THEN BEGIN
                    Customer.RESET;
                    Customer.SETRANGE("Salesperson Code", SalesPerson.Code);
                    //Customer.SETRANGE("Salesperson Code", '1110479');
                    IF Customer.FINDFIRST THEN
                        REPEAT
                            IF (Docno3 <> Customer."Salesperson Code") THEN BEGIN
                                Docno3 := Customer."Salesperson Code";
                                //  SMTPMailSetup.GET;
                                //  SMTPMailSetup.TESTFIELD("User ID");
                                //  CLEAR(SMTPMail);
                                // 15578  SMTPMail.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com', SalesPerson."E-Mail", 'State Wise Report', '', TRUE);
                                //SMTPMail.CreateMessage('Orient Bell Limited.','donotreply@orientbell.com','akash.kumar@mindshell.info','State Wise Report','', TRUE);
                                EmailAddressList.Add('donotreply@orientbell.com');
                                BodyText := 'Dear Sir <br>';
                                BodyText += 'Please find the attached report with this email. <br><br>';
                                BodyText += 'Thank You and Have a Good Day!';
                                txtfile := 'SP_' + Customer."Salesperson Code";
                                /*  if File.Exists('C:\StateWiseReport\' + txtfile + '.xlsx') THEN begin
                                     FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\StateWiseReport\' + txtfile + '.xlsx');
                                     if TempBlobCU.HasValue() then begin
                                         TempBlobCU.CreateInStream(InstreamVar);
                                         EmailMsg.Create(EmailAddressList, 'State Wise Report', BodyText, true, EmailBccList, EmailCCList);
                                         if File.Exists('C:\StateWiseReport\' + txtfile + '.xlsx') THEN
                                             EmailMsg.AddAttachment('C:\StateWiseReport\' + txtfile + '.xlsx', 'application/pdf', InstreamVar);
                                         EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                                     END;
                                 end;
  */
                                /*  IF (EXISTS('C:\StateWiseReport\' + txtfile + '.xlsx')) THEN BEGIN
                                      SMTPMail.AddAttachment('C:\StateWiseReport\' + txtfile + '.xlsx', txtfile + '.xlsx');
                                      SMTPMail.Send();
                                      MESSAGE('SP Mail Sent');
                                  END;*/ // 15578
                            END;
                        UNTIL Customer.NEXT = 0;
                END;
            UNTIL SalesPerson.NEXT = 0;
    end;


    procedure GenerateReportSummary()
    var
        Report50033: Report "Sales TGT vs Achvmnt";
        Report50034: Report "Debtors Report MIS";
        Docno4: Code[20];
        Docno5: Code[20];
    begin
        //PCH
        SalesPerson.RESET;
        IF SalesPerson.FINDFIRST THEN
            REPEAT
                Customer.RESET;
                Customer.SETRANGE("PCH Code", SalesPerson.Code);
                //Customer.SETRANGE("PCH Code", '1110479');
                IF Customer.FINDFIRST THEN
                    REPEAT
                        IF (Docno4 <> Customer."PCH Code") THEN BEGIN
                            Docno4 := Customer."PCH Code";
                            SalesInvoiceHeader.RESET;
                            SalesInvoiceHeader.SETRANGE("Posting Date", 20180110D, 20181030D);
                            IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                                CLEAR(Report50034);
                                Report50034.SETTABLEVIEW(Customer);
                                Report50034.SETTABLEVIEW(SalesInvoiceHeader);
                                //txtfile :=  CONVERTSTR(SalesInvoiceHeader."No.",'/','_');
                                txtfile := 'Summary_BH_' + Customer."PCH Code";
                                // Report50034.SAVEASEXCEL('C:\StateWiseReport\' + txtfile + '.xlsx');
                                // MESSAGE('BH Report Generated');
                            END;
                        END;
                    UNTIL Customer.NEXT = 0;
            UNTIL SalesPerson.NEXT = 0;

        //ZH
        SalesPerson.RESET;
        IF SalesPerson.FINDFIRST THEN
            REPEAT
                Customer.RESET;
                Customer.SETRANGE("Zonal Head", SalesPerson.Code);
                //Customer.SETRANGE("PCH Code", '1110479');
                IF Customer.FINDFIRST THEN
                    REPEAT
                        IF (Docno4 <> Customer."Zonal Head") THEN BEGIN
                            Docno4 := Customer."Zonal Head";
                            SalesInvoiceHeader.RESET;
                            SalesInvoiceHeader.SETRANGE("Posting Date", 20180101D, 20181030D);
                            IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                                CLEAR(Report50034);
                                Report50034.SETTABLEVIEW(Customer);
                                Report50034.SETTABLEVIEW(SalesInvoiceHeader);
                                //txtfile :=  CONVERTSTR(SalesInvoiceHeader."No.",'/','_');
                                txtfile := 'Summary_ZH_' + Customer."Zonal Head";
                                // Report50034.SAVEASEXCEL('C:\StateWiseReport\' + txtfile + '.xlsx');
                                MESSAGE('ZH Report Generated');
                            END;
                        END;
                    UNTIL Customer.NEXT = 0;
            UNTIL SalesPerson.NEXT = 0;

        //SP
        SalesPerson.RESET;
        IF SalesPerson.FINDFIRST THEN
            REPEAT
                Customer.RESET;
                Customer.SETRANGE("Salesperson Code", SalesPerson.Code);
                //Customer.SETRANGE("Salesperson Code", '1110479');
                IF Customer.FINDFIRST THEN
                    REPEAT
                        IF (Docno5 <> Customer."Salesperson Code") THEN BEGIN
                            Docno5 := Customer."Salesperson Code";
                            SalesInvoiceHeader.RESET;
                            SalesInvoiceHeader.SETRANGE("Posting Date", 20181001D, 20180130D);
                            IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                                CLEAR(Report50034);
                                Report50034.SETTABLEVIEW(Customer);
                                Report50034.SETTABLEVIEW(SalesInvoiceHeader);
                                //txtfile :=  CONVERTSTR(SalesInvoiceHeader."No.",'/','_');
                                txtfile := 'Summary_SP_' + Customer."Salesperson Code";
                                // Report50034.SAVEASEXCEL('C:\StateWiseReport\' + txtfile + '.xlsx');
                                MESSAGE('SP Report Generated');
                            END;
                        END;
                    UNTIL Customer.NEXT = 0;
            UNTIL SalesPerson.NEXT = 0;
    end;


    procedure SendEmailSummary()
    var
        // SMTPMail: Codeunit 400;
        // SMTPMailSetup: Record 409;
        Docno6: Code[20];
        Docno7: Code[20];
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

        //PCH
        SalesPerson.RESET;
        IF SalesPerson.FINDFIRST THEN
            REPEAT
                IF SalesPerson."E-Mail" <> '' THEN BEGIN
                    Customer.RESET;
                    Customer.SETRANGE("PCH Code", SalesPerson.Code);
                    //Customer.SETRANGE("PCH Code", '1110479');
                    IF Customer.FINDFIRST THEN
                        REPEAT
                            IF (Docno6 <> Customer."PCH Code") THEN BEGIN
                                Docno6 := Customer."PCH Code";
                                //   SMTPMailSetup.GET;
                                //   SMTPMailSetup.TESTFIELD("User ID");
                                //   CLEAR(SMTPMail);
                                //SMTPMail.CreateMessage('Orient Bell Limited.','donotreply@orientbell.com',SalesPerson."E-Mail",'State Wise Report','', TRUE);
                                //SMTPMail.CreateMessage('Orient Bell Limited.','donotreply@orientbell.com','akash.kumar@mindshell.info','State Wise Report','', TRUE);
                                BodyText := 'Dear Sir <br>';
                                BodyText += 'Please find the attached report with this email. <br><br>';
                                BodyText += 'Thank You and Have a Good Day!';
                                txtfile := 'Summary_BH_' + Customer."PCH Code";
                                /* if File.Exists('C:\StateWiseReport\' + txtfile + '.xlsx') THEN
                                    FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\StateWiseReport\' + txtfile + '.xlsx');
                                if TempBlobCU.HasValue() then begin
                                    TempBlobCU.CreateInStream(InstreamVar);
                                    EmailMsg.Create(EmailAddressList, '', BodyText, true, EmailBccList, EmailCCList);
                                    if File.Exists('C:\StateWiseReport\' + txtfile + '.xlsx') THEN
                                        EmailMsg.AddAttachment('C:\StateWiseReport\' + txtfile + '.xlsx', 'application/pdf', InstreamVar);
                                    EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                                END;
 */

                                /*   IF (EXISTS('C:\StateWiseReport\' + txtfile + '.xlsx')) THEN BEGIN
                                       SMTPMail.AddAttachment('C:\StateWiseReport\' + txtfile + '.xlsx', txtfile + '.xlsx');
                                       SMTPMail.Send();
                                       MESSAGE('Mail Sent');
                                   END;*/ // 15578
                            END;
                        UNTIL Customer.NEXT = 0;
                END;
            UNTIL SalesPerson.NEXT = 0;


        //ZH
        SalesPerson.RESET;
        IF SalesPerson.FINDFIRST THEN
            REPEAT
                IF SalesPerson."E-Mail" <> '' THEN BEGIN
                    Customer.RESET;
                    Customer.SETRANGE("Zonal Head", SalesPerson.Code);
                    //Customer.SETRANGE("PCH Code", '1110479');
                    IF Customer.FINDFIRST THEN
                        REPEAT
                            IF (Docno6 <> Customer."Zonal Head") THEN BEGIN
                                Docno6 := Customer."Zonal Head";
                                //  SMTPMailSetup.GET;
                                //  SMTPMailSetup.TESTFIELD("User ID");
                                //  CLEAR(SMTPMail);
                                //SMTPMail.CreateMessage('Orient Bell Limited.','donotreply@orientbell.com',SalesPerson."E-Mail",'State Wise Report','', TRUE);
                                //SMTPMail.CreateMessage('Orient Bell Limited.','donotreply@orientbell.com','akash.kumar@mindshell.info','State Wise Report','', TRUE);
                                /*  SMTPMail.AppendBody('Dear Sir <br>');
                                  SMTPMail.AppendBody('Please find the attached report with this email. <br><br>');
                                  SMTPMail.AppendBody('Thank You and Have a Good Day!');

                                  txtfile := 'Summary_ZH_' + Customer."PCH Code";
                                  IF (EXISTS('C:\StateWiseReport\' + txtfile + '.xlsx')) THEN BEGIN
                                      SMTPMail.AddAttachment('C:\StateWiseReport\' + txtfile + '.xlsx', txtfile + '.xlsx');
                                      SMTPMail.Send();
                                      MESSAGE('Mail Sent');
                                  END;*/ // 15578
                            END;
                        UNTIL Customer.NEXT = 0;
                END;
            UNTIL SalesPerson.NEXT = 0;

        //SP
        SalesPerson.RESET;
        IF SalesPerson.FINDFIRST THEN
            REPEAT
                IF SalesPerson."E-Mail" <> '' THEN BEGIN
                    Customer.RESET;
                    Customer.SETRANGE("Salesperson Code", SalesPerson.Code);
                    //Customer.SETRANGE("Salesperson Code", '1110479');
                    IF Customer.FINDFIRST THEN
                        REPEAT
                            IF (Docno7 <> Customer."Salesperson Code") THEN BEGIN
                                Docno7 := Customer."Salesperson Code";
                                /*   SMTPMailSetup.GET;
                                   SMTPMailSetup.TESTFIELD("User ID");
                                   CLEAR(SMTPMail);*/ //15578
                                                      //SMTPMail.CreateMessage('Orient Bell Limited.','donotreply@orientbell.com',SalesPerson."E-Mail",'State Wise Report','', TRUE);
                                                      //SMTPMail.CreateMessage('Orient Bell Limited.','donotreply@orientbell.com','akash.kumar@mindshell.info','State Wise Report','', TRUE);
                                                      /*  SMTPMail.AppendBody('Dear Sir <br>');
                                                        SMTPMail.AppendBody('Please find the attached report with this email. <br><br>');
                                                        SMTPMail.AppendBody('Thank You and Have a Good Day!');

                                                        txtfile := 'Summary_SP_' + Customer."Salesperson Code";
                                                        IF (EXISTS('C:\StateWiseReport\' + txtfile + '.xlsx')) THEN BEGIN
                                                            SMTPMail.AddAttachment('C:\StateWiseReport\' + txtfile + '.xlsx', txtfile + '.xlsx');
                                                            SMTPMail.Send();
                                                            MESSAGE('SP Mail Sent');
                                                        END;*/ // 15578
                            END;
                        UNTIL Customer.NEXT = 0;
                END;
            UNTIL SalesPerson.NEXT = 0;
    end;


    procedure GenerateTotalReportDetailed()
    var
        Report50033: Report "Sales TGT vs Achvmnt";
        Report50034: Report "Debtors Report MIS";
        Docno: Code[20];
        Docno1: Code[20];
    begin
        /*SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETCURRENTKEY("Posting Date");
        SalesInvoiceHeader.SETRANGE("Posting Date", 011018D, 311018D);
        IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
          CLEAR(Report50033);
          Report50033.SetDateRange(011018D, 311018D);
          Report50033.SETTABLEVIEW(SalesInvoiceHeader);
          //txtfile :=  CONVERTSTR(SalesInvoiceHeader."No.",'/','_');
          txtfile := 'TotalReport';
          Report50033.SAVEASEXCEL('C:\StateWiseReport\'+txtfile+'.xlsx');
          IF GUIALLOWED THEN
          MESSAGE('Total Report Generated');
        END;
        
        */

    end;

    local procedure SendPCHMails(AreaCode: Code[10]; PCHCode: Code[10]; SPCode: Code[10])
    var
        SalesData: Query "Sales Data";
    begin
        CLEAR(SalesData);
        SalesData.SETFILTER(SalesData.Area_Code, AreaCode);
        IF PCHCode <> '' THEN
            SalesData.SETFILTER(SalesData.PCH_Code, PCHCode);
        IF SPCode <> '' THEN
            SalesData.SETFILTER(SalesData.Salesperson_Code, SPCode);
        SalesData.SETFILTER(SalesData.Posting_Date, '%1..%2', TODAY - 100, TODAY);
        WHILE SalesData.READ DO BEGIN


        END;
    end;


    procedure MailtoSPs()
    var
        SalesPersons: Record "Salesperson/Purchaser";
        DealerSchemeDetails: Record "Customer Scheme Details";
        txtfile: Text[250];
        SchemeMaster: Record "Scheme Master";
        EmailAddress: Text[250];
        InCorrectMail: Boolean;
        NoOfAtSigns: Integer;
        i: Integer;
        //  SMTPSetup: Record 409;
        //  SMTPMailCodeUnit: Codeunit 400;
        SalesData: Query "Sales Data";
        Text50000: Label 'Sales Details :';
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
        FromDate: Date;
        ToDate: Date;
        fileName: Text;
        CompletePath: Text;
        TotQty: Decimal;
        TotAmt: Decimal;
        BlnSendMail: Boolean;
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

        FromDate := GlbFromDate;
        ToDate := GlbToDate;
        SalesPersons.RESET;
        //SalesPersons.SETFILTER(Code,'%1|%2','1111601','1111679');
        SalesPersons.SETRANGE(SalesPersons.Status, SalesPersons.Status::Enable);
        IF SalesPersons.FINDFIRST THEN
            REPEAT
                EmailAddress := SalesPersons."E-Mail";
                InCorrectMail := FALSE;
                NoOfAtSigns := 0;
                FOR i := 1 TO STRLEN(EmailAddress) DO BEGIN
                    IF EmailAddress[i] = '@' THEN
                        NoOfAtSigns := NoOfAtSigns + 1;
                    IF (((EmailAddress[i] >= 'a') AND (EmailAddress[i] <= 'z')) OR
                      ((EmailAddress[i] >= 'A') AND (EmailAddress[i] <= 'Z')) OR
                      ((EmailAddress[i] >= '0') AND (EmailAddress[i] <= '9')) OR
                      (EmailAddress[i] IN ['@', '.', '-', '_']))
                    THEN BEGIN
                    END ELSE BEGIN
                        InCorrectMail := TRUE;
                    END
                END;
                CLEAR(SalesData);
                //SalesData.SETFILTER(SalesData.Area_Code,AreaCode);
                SalesData.SETFILTER(SalesData.Salesperson_Code, SalesPersons.Code);
                SalesData.SETFILTER(SalesData.Posting_Date, '%1..%2', FromDate, GlbToDate);
                SalesData.OPEN;
                //IF SalesData.READ THEN BEGIN
                //MESSAGE(SalesPersons.Code);
                IF InCorrectMail = FALSE THEN BEGIN
                    TotQty := 0;
                    TotAmt := 0;
                    IF (STRPOS(SalesPersons."E-Mail", ' ') = 0) AND (SalesPersons."E-Mail" <> '') THEN BEGIN
                        /*SMTPSetup.GET();
                        SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
                                                      SalesPersons."E-Mail", ' - Sales Details - ' + SalesPersons.Name, '', TRUE);*/
                        EmailAddressList.Add(SalesPersons."E-Mail");
                        EmailMsg.Create(EmailAddressList, ' - Sales Details - ' + SalesPersons.Name, BodyText, true, EmailBccList, EmailCCList);
                    END ELSE BEGIN
                        /*SMTPSetup.GET();
                        SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
                                                      'donotreply@orientbell.com', ' - Sales Details - ' + SalesPersons.Name, '', TRUE);*/
                        EmailMsg.Create(EmailAddressList, ' - Sales Details - ' + SalesPersons.Name, BodyText, true, EmailBccList, EmailCCList);
                        EmailAddressList.Add('donotreply@orientbell.com');
                    END;

                    EmailCCList.add('donotreply@orientbell.com');
                    IF SalesPersons.Name <> '' THEN
                        BodyText := 'Dear  ' + SalesPersons.Name
                    ELSE
                        BodyText += 'Dear  ';
                    BodyText += '<br><br>';
                    BodyText += 'Please find the enclosed detail of Sales Data for the Current Month. ';
                    BodyText += '<br><br>';
                    //Table Start
                    BodyText += Text60005;
                    BodyText += Text60006;
                    BodyText += Text50027 + Text50026 + Text50041 + Text60012 + 'S.No.' + Text60013 + Text60003;
                    BodyText += Text50030 + Text60012 + 'Territory' + Text60013 + Text60003;
                    BodyText += Text50030 + Text60012 + 'Customer Name' + Text60013 + Text60003;
                    SrNo := 1;
                    BodyText += Text50030 + Text60012 + 'Sum of Sq. Mtr.' + Text60013 + Text60003;
                    BodyText += Text50030 + Text60012 + 'Value' + Text60013 + Text60003;

                    BodyText += Text60004;

                    WHILE SalesData.READ DO BEGIN
                        BodyText += Text50026 + Text50041 + FORMAT(SrNo) + Text60003;
                        BodyText += Text50041 + FORMAT(SalesData.Description_2) + Text60003;
                        BodyText += Text50041 + FORMAT(SalesData.Name) + Text60003;
                        BodyText += Text50041 + FORMAT(SalesData.Sum_Quantity_Base) + Text60003;
                        // 15578    BodyText +=Text50041 + FORMAT(ROUND(SalesData.Sum_Tax_Base_Amount / 100000, 0.01, '=')) + Text60003;
                        TotQty += SalesData.Sum_Quantity_Base;
                        // 15578   TotAmt += ROUND(SalesData.Sum_Tax_Base_Amount / 100000, 0.01, '=');
                        SrNo += 1;
                        BlnSendMail := TRUE;
                    END;
                    BodyText += Text50026 + Text50041 + FORMAT('Total -->>') + Text60003;
                    BodyText += Text50041 + FORMAT('') + Text60003;
                    BodyText += Text50041 + FORMAT('') + Text60003;
                    BodyText += Text50041 + FORMAT(TotQty) + Text60003;
                    BodyText += Text50041 + FORMAT(ROUND(TotAmt, 0.01, '=')) + Text60003;

                    //MSKS
                    BodyText += Text60004;

                    BodyText += Text60005;

                    BodyText += Text60006;
                    BodyText += Text60011;

                    BodyText += '<br><br>';
                    BodyText += 'This is for your records';
                    BodyText += '<br><br>';
                    BodyText += 'Regards, <br>';
                    BodyText += 'Orient Bell Limited <br>';
                    BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
                    BodyText += 'New Delhi 110046, India <br>';
                    BodyText += 'Tel. +91 11 4711 9100 <br>';
                    BodyText += 'Fax. +91 11 2852 1273 <br>';
                    fileName := '';
                    fileName := 'SP_' + SalesPersons.Code + '.xlsx';
                    // if File.Exists('C:\StateWiseReport\' + fileName) THEN begin
                    // FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\StateWiseReport\' + fileName);
                    if TempBlobCU.HasValue() then begin
                        TempBlobCU.CreateInStream(InstreamVar);
                        EmailMsg.Create(EmailAddressList, '', BodyText, true, EmailBccList, EmailCCList);
                        // if File.Exists('C:\StateWiseReport\' + fileName) THEN
                        EmailMsg.AddAttachment(CompletePath, 'application/pdf', InstreamVar);
                        EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                    END;
                    /* IF (EXISTS('C:\StateWiseReport\' + fileName)) THEN BEGIN
                         CompletePath := 'C:\StateWiseReport\' + fileName;
                         SMTPMailCodeUnit.AddAttachment(CompletePath, fileName);
                     END;
                     IF TotAmt <> 0 THEN
                         SMTPMailCodeUnit.Send();*/ // 15578
                                                    // END;
                                                    //END;
                end;
            UNTIL SalesPersons.NEXT = 0;
    end;


    procedure MailtoPCH()
    var
        SalesPersons: Record "Salesperson/Purchaser";
        DealerSchemeDetails: Record "Customer Scheme Details";
        txtfile: Text[250];
        SchemeMaster: Record "Scheme Master";
        EmailAddress: Text[250];
        InCorrectMail: Boolean;
        NoOfAtSigns: Integer;
        i: Integer;
        //  SMTPSetup: Record 409;
        // SMTPMailCodeUnit: Codeunit 400;
        SalesData: Query "Sales Data";
        Text50000: Label 'Sales Details :';
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
        fromDate: Date;
        ToDate: Date;
        fileName: Text;
        CompletePath: Text;
        TotQty: Decimal;
        TotAmt: Decimal;
        BlnSendMail: Boolean;
    begin
        fromDate := GlbFromDate;
        ToDate := GlbToDate;

        SalesPersons.RESET;
        //SalesPersons.SETFILTER(Code,'%1|%2','VAC-DEHRA','1111622');
        SalesPersons.SETRANGE(SalesPersons.Status, SalesPersons.Status::Enable);
        IF SalesPersons.FINDFIRST THEN
            REPEAT
                EmailAddress := SalesPersons."E-Mail";
                InCorrectMail := FALSE;
                NoOfAtSigns := 0;
                FOR i := 1 TO STRLEN(EmailAddress) DO BEGIN
                    IF EmailAddress[i] = '@' THEN
                        NoOfAtSigns := NoOfAtSigns + 1;
                    IF (((EmailAddress[i] >= 'a') AND (EmailAddress[i] <= 'z')) OR
                      ((EmailAddress[i] >= 'A') AND (EmailAddress[i] <= 'Z')) OR
                      ((EmailAddress[i] >= '0') AND (EmailAddress[i] <= '9')) OR
                      (EmailAddress[i] IN ['@', '.', '-', '_']))
                    THEN BEGIN
                    END ELSE BEGIN
                        InCorrectMail := TRUE;
                    END
                END;
                CLEAR(SalesData);
                //SalesData.SETFILTER(SalesData.Area_Code,AreaCode);
                SalesData.SETFILTER(SalesData.PCH_Code, '%1', SalesPersons.Code);
                SalesData.SETFILTER(SalesData.Posting_Date, '%1..%2', fromDate, GlbToDate);
                SalesData.OPEN;
            //          IF SalesData.READ THEN BEGIN
            //MESSAGE(SalesPersons.Code);
            /*    IF InCorrectMail = FALSE THEN BEGIN
                    TotQty := 0;
                    TotAmt := 0;
                   IF (STRPOS(SalesPersons."E-Mail", ' ') = 0) AND (SalesPersons."E-Mail" <> '') THEN BEGIN
                        SMTPSetup.GET();
                        SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
                                                      SalesPersons."E-Mail", ' - BH Sales Details - ' + SalesPersons.Name, '', TRUE);

                    END ELSE BEGIN
                        SMTPSetup.GET();
                        SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
                                                      'donotreply@orientbell.com', 'Sales Details - ' + SalesPersons.Name, '', TRUE);
                    END;

                    SMTPMailCodeUnit.AddCC('donotreply@orientbell.com');
                    IF SalesPersons.Name <> '' THEN
                        SMTPMailCodeUnit.AppendBody('Dear  ' + SalesPersons.Name)
                    ELSE
                        SMTPMailCodeUnit.AppendBody('Dear  ');
                    SMTPMailCodeUnit.AppendBody('<br><br>');
                    SMTPMailCodeUnit.AppendBody('Please find the enclosed detail of Sales Data for the Current Month. ');
                    SMTPMailCodeUnit.AppendBody('<br><br>');
                    //Table Start
                    SMTPMailCodeUnit.AppendBody(Text60005);
                    SMTPMailCodeUnit.AppendBody(Text60006);
                    SMTPMailCodeUnit.AppendBody(Text50027 + Text50026 + Text50041 + Text60012 + 'S.No.' + Text60013 + Text60003);
                    SMTPMailCodeUnit.AppendBody(Text50030 + Text60012 + 'Territory' + Text60013 + Text60003);
                    SMTPMailCodeUnit.AppendBody(Text50030 + Text60012 + 'Customer Name' + Text60013 + Text60003);
                    SrNo := 1;
                    SMTPMailCodeUnit.AppendBody(Text50030 + Text60012 + 'Sum of Sq. Mtr.' + Text60013 + Text60003);
                    SMTPMailCodeUnit.AppendBody(Text50030 + Text60012 + 'Value' + Text60013 + Text60003);

                    SMTPMailCodeUnit.AppendBody(Text60004);

                    WHILE SalesData.READ DO BEGIN
                        SMTPMailCodeUnit.AppendBody(Text50026 + Text50041 + FORMAT(SrNo) + Text60003);
                        SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT(SalesData.Description_2) + Text60003);
                        SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT(SalesData.Name) + Text60003);
                        SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT(SalesData.Sum_Quantity_Base) + Text60003);
                        SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT(ROUND(SalesData.Sum_Tax_Base_Amount / 100000, 0.01, '=')) + Text60003);
                        TotQty += SalesData.Sum_Quantity_Base;
                        TotAmt += ROUND(SalesData.Sum_Tax_Base_Amount / 100000, 0.01, '=');
                        BlnSendMail := TRUE;
                        SrNo += 1;
                    END;
                    SMTPMailCodeUnit.AppendBody(Text50026 + Text50041 + FORMAT('Total -->>') + Text60003);
                    SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT('') + Text60003);
                    SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT('') + Text60003);
                    SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT(TotQty) + Text60003);
                    SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT(ROUND(TotAmt, 0.01, '=')) + Text60003);

                    //MSKS
                    SMTPMailCodeUnit.AppendBody(Text60004);

                    SMTPMailCodeUnit.AppendBody(Text60005);

                    SMTPMailCodeUnit.AppendBody(Text60006);
                    SMTPMailCodeUnit.AppendBody(Text60011);

                    SMTPMailCodeUnit.AppendBody('<br><br>');
                    SMTPMailCodeUnit.AppendBody('This is for your records');
                    SMTPMailCodeUnit.AppendBody('<br><br>');
                    SMTPMailCodeUnit.AppendBody('Regards, <br>');
                    SMTPMailCodeUnit.AppendBody('Orient Bell Limited <br>');
                    SMTPMailCodeUnit.AppendBody('Iris House, 16 Business Center, Nangal Raya <br>');
                    SMTPMailCodeUnit.AppendBody('New Delhi 110046, India <br>');
                    SMTPMailCodeUnit.AppendBody('Tel. +91 11 4711 9100 <br>');
                    SMTPMailCodeUnit.AppendBody('Fax. +91 11 2852 1273 <br>');
                    fileName := '';
                    fileName := 'BH_' + SalesPersons.Code + '.xlsx';
                    IF (EXISTS('C:\StateWiseReport\' + fileName)) THEN BEGIN
                        CompletePath := 'C:\StateWiseReport\' + fileName;
                        SMTPMailCodeUnit.AddAttachment(CompletePath, fileName);
                    END;
                    IF TotAmt <> 0 THEN
                        SMTPMailCodeUnit.Send();
                END;*/ // 15578
                       //  END;
            UNTIL SalesPersons.NEXT = 0;
    end;


    procedure MailtoCSO()
    var
        SalesPersons: Record "Salesperson/Purchaser";
        DealerSchemeDetails: Record "Customer Scheme Details";
        txtfile: Text[250];
        SchemeMaster: Record "Scheme Master";
        EmailAddress: Text[250];
        InCorrectMail: Boolean;
        NoOfAtSigns: Integer;
        i: Integer;
        //   SMTPSetup: Record 409;
        //   SMTPMailCodeUnit: Codeunit 400;
        SalesData: Query "Sales Data";
        Text50000: Label 'Sales Details :';
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
        FromDate: Date;
        ToDate: Date;
        fileName: Text;
        CompletePath: Text;
        TotQty: Decimal;
        TotAmt: Decimal;
        BlnSendMail: Boolean;
    begin
        FromDate := GlbFromDate;
        ToDate := GlbToDate;
        EmailAddress := 'bs.negi@orientbell.com';
        InCorrectMail := FALSE;
        NoOfAtSigns := 0;
        FOR i := 1 TO STRLEN(EmailAddress) DO BEGIN
            IF EmailAddress[i] = '@' THEN
                NoOfAtSigns := NoOfAtSigns + 1;
            IF (((EmailAddress[i] >= 'a') AND (EmailAddress[i] <= 'z')) OR
              ((EmailAddress[i] >= 'A') AND (EmailAddress[i] <= 'Z')) OR
              ((EmailAddress[i] >= '0') AND (EmailAddress[i] <= '9')) OR
              (EmailAddress[i] IN ['@', '.', '-', '_']))
            THEN BEGIN
            END ELSE BEGIN
                InCorrectMail := TRUE;
            END
        END;
        CLEAR(SalesData);
        //SalesData.SETFILTER(SalesData.Area_Code,AreaCode);
        SalesData.SETFILTER(SalesData.Posting_Date, '%1..%2', FromDate, TODAY - 1);
        SalesData.OPEN;
        //IF SalesData.READ THEN BEGIN
        //MESSAGE(SalesPersons.Code);
        /*   IF InCorrectMail = FALSE THEN BEGIN

               SMTPSetup.GET();
               SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
                                             'bs.negi@orientbell.com', 'Sales Details', '', TRUE);

               SMTPMailCodeUnit.AddCC('donotreply@orientbell.com');
               SMTPMailCodeUnit.AddCC('pushpender.kumar@orientbell.com');
               SMTPMailCodeUnit.AddCC('rachit.vij@orientbell.com');
               SMTPMailCodeUnit.AddCC('divya.chauhan@orientbell.com');
               SMTPMailCodeUnit.AddCC('jegatheeswaran.palsamy@orientbell.com');
               SMTPMailCodeUnit.AddCC('amit.goel@orientbell.com');
               SMTPMailCodeUnit.AppendBody('Dear  ');
               SMTPMailCodeUnit.AppendBody('<br><br>');
               SMTPMailCodeUnit.AppendBody('Please find the enclosed detail of Sales Data for the Current Month. ');
               SMTPMailCodeUnit.AppendBody('<br><br>');
               //Table Start
               SMTPMailCodeUnit.AppendBody(Text60005);
               SMTPMailCodeUnit.AppendBody(Text60006);
               SMTPMailCodeUnit.AppendBody(Text50027 + Text50026 + Text50041 + Text60012 + 'S.No.' + Text60013 + Text60003);
               SMTPMailCodeUnit.AppendBody(Text50030 + Text60012 + 'Territory' + Text60013 + Text60003);
               SMTPMailCodeUnit.AppendBody(Text50030 + Text60012 + 'Customer Name' + Text60013 + Text60003);
               SrNo := 1;
               SMTPMailCodeUnit.AppendBody(Text50030 + Text60012 + 'Sum of Sq. Mtr.' + Text60013 + Text60003);
               SMTPMailCodeUnit.AppendBody(Text50030 + Text60012 + 'Value' + Text60013 + Text60003);

               SMTPMailCodeUnit.AppendBody(Text60004);

               WHILE SalesData.READ DO BEGIN
                   SMTPMailCodeUnit.AppendBody(Text50026 + Text50041 + FORMAT(SrNo) + Text60003);
                   SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT(SalesData.Description_2) + Text60003);
                   SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT(SalesData.Name) + Text60003);
                   SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT(SalesData.Sum_Quantity_Base) + Text60003);
                   SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT(ROUND(SalesData.Sum_Tax_Base_Amount / 100000, 0.01, '=')) + Text60003);
                   TotQty += SalesData.Sum_Quantity_Base;
                   TotAmt += ROUND(SalesData.Sum_Tax_Base_Amount / 100000, 0.01, '=');
                   SrNo += 1;
                   BlnSendMail := TRUE;
               END;
               SMTPMailCodeUnit.AppendBody(Text50026 + Text50041 + FORMAT('Total -->>') + Text60003);
               SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT('') + Text60003);
               SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT('') + Text60003);
               SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT(TotQty) + Text60003);
               SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT(ROUND(TotAmt, 0.01, '=')) + Text60003);
               //MSKS
               SMTPMailCodeUnit.AppendBody(Text60004);

               SMTPMailCodeUnit.AppendBody(Text60005);

               SMTPMailCodeUnit.AppendBody(Text60006);
               SMTPMailCodeUnit.AppendBody(Text60011);

               SMTPMailCodeUnit.AppendBody('<br><br>');
               SMTPMailCodeUnit.AppendBody('This is for your records');
               SMTPMailCodeUnit.AppendBody('<br><br>');
               SMTPMailCodeUnit.AppendBody('Regards, <br>');
               SMTPMailCodeUnit.AppendBody('Orient Bell Limited <br>');
               SMTPMailCodeUnit.AppendBody('Iris House, 16 Business Center, Nangal Raya <br>');
               SMTPMailCodeUnit.AppendBody('New Delhi 110046, India <br>');
               SMTPMailCodeUnit.AppendBody('Tel. +91 11 4711 9100 <br>');
               SMTPMailCodeUnit.AppendBody('Fax. +91 11 2852 1273 <br>');
               fileName := '';
               fileName := 'CSO_' + FORMAT(ToDate) + '.xlsx';
               fileName := CONVERTSTR(fileName, '/', '_');
               IF (EXISTS('C:\StateWiseReport\' + fileName)) THEN BEGIN
                   CompletePath := 'C:\StateWiseReport\' + fileName;
                   SMTPMailCodeUnit.AddAttachment(CompletePath, fileName);
               END;
               IF TotAmt <> 0 THEN
                   SMTPMailCodeUnit.Send();
               //END;
           END;*/ // 15578
    end;

    local procedure GenerateTargetVSAchieveReport(AreaCode: Code[20]; Qty: Boolean)
    var
        TargetVsAchievement: Report "Target Vs Achievement GVT";
        MatrixMaster: Record "Matrix Master";
        TargetVsAchievementhsk: Report "Target Vs Achie HSK DRA";
        TargetVsAchievementwz: Report "Target Vs Achie West Zone";
    begin
        IF Qty THEN BEGIN
            MatrixMaster.RESET;
            IF AreaCode <> '' THEN
                MatrixMaster.SETRANGE("Type 1", AreaCode);
            IF MatrixMaster.FINDFIRST THEN BEGIN
                CLEAR(TargetVsAchievement);
                TargetVsAchievement.SetReportType(TRUE);
                TargetVsAchievement.SETTABLEVIEW(MatrixMaster);
                IF AreaCode = '' THEN
                    txtfile := 'SKDReport ' ELSE
                    txtfile := 'SKDReport ' + AreaCode;
                // TargetVsAchievement.SAVEASEXCEL('C:\StateWiseReport\' + txtfile + '.xlsx');

                //New
                CLEAR(TargetVsAchievementhsk);
                TargetVsAchievementhsk.SetReportType(TRUE);
                TargetVsAchievementhsk.SETTABLEVIEW(MatrixMaster);
                IF AreaCode = '' THEN
                    txtfile := 'HSK_DRA_Report ' ELSE
                    txtfile := 'HSK_DRA_Report ' + AreaCode;
                // TargetVsAchievementhsk.SAVEASEXCEL('C:\StateWiseReport\' + txtfile + '.xlsx');
                //New

                //New
                CLEAR(TargetVsAchievementwz);
                TargetVsAchievementwz.SetReportType(TRUE);
                TargetVsAchievementwz.SETTABLEVIEW(MatrixMaster);
                IF AreaCode = '' THEN
                    txtfile := 'WZ_Report ' ELSE
                    txtfile := 'WZ_Report ' + AreaCode;
                // TargetVsAchievementwz.SAVEASEXCEL('C:\StateWiseReport\' + txtfile + '.xlsx');
                //New


            END;
        END ELSE BEGIN
            MatrixMaster.RESET;
            IF AreaCode <> '' THEN
                MatrixMaster.SETRANGE("Type 1", AreaCode);
            IF MatrixMaster.FINDFIRST THEN BEGIN
                CLEAR(TargetVsAchievement);
                TargetVsAchievement.SetReportType(FALSE);
                TargetVsAchievement.SETTABLEVIEW(MatrixMaster);
                IF AreaCode = '' THEN
                    txtfile := 'TerritorySale ' ELSE
                    txtfile := 'TerritorySale ' + AreaCode;
                // TargetVsAchievement.SAVEASEXCEL('C:\StateWiseReport\' + txtfile + '.xlsx');
            END;
        END;
    end;


    procedure SendEmailTargetVsAchieve(PCHCode: Code[10]; AREACode: Code[20]; Qty: Boolean)
    var
        //  SMTPMail: Codeunit 400;
        //  SMTPMailSetup: Record 409;
        Docno2: Code[20];
        Docno3: Code[20];
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
        //PCH
        Clear(EmailAddressList);
        Clear(EmailCCList);
        Clear(EmailBccList);

        SalesPerson.RESET;
        SalesPerson.SETRANGE(Code, PCHCode);
        IF SalesPerson.FINDFIRST THEN BEGIN
            IF SalesPerson."E-Mail" <> '' THEN BEGIN
                //   SMTPMailSetup.GET;
                //   SMTPMailSetup.TESTFIELD("User ID");
                //   CLEAR(SMTPMail);
                //SMTPMail.CreateMessage('Orient Bell Limited.','donotreply@orientbell.com',SalesPerson."E-Mail",'State Wise Report','', TRUE);
                //    SMTPMail.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com', SalesPerson."E-Mail", 'TGT V/S Achvmt|SKD Report|HSK and Dora Report- ' + FORMAT(TODAY - 1), '', TRUE);
                //SMTPMail.CreateMessage('Orient Bell Limited.','donotreply@orientbell.com','kulwant@mindshell.info','TGT V/S Achvmt|GVT Sales Tracker - '+FORMAT(TODAY -1),'', TRUE);
                //SMTPMail.AddCC('bs.negi@orientbell.com');
                //   SMTPMail.AddCC('donotreply@orientbell.com');
                EmailCCList.Add('donotreply@orientbell.com');

                BodyText := 'Dear Sir <br>';
                BodyText += 'Please find the attached report with this email. <br><br>';
                BodyText += 'Thank You and Have a Good Day!';

                BodyText += '<br><br>';
                BodyText += 'This is for your records';
                BodyText += '<br><br>';
                BodyText += 'Regards, <br>';
                BodyText += 'Orient Bell Limited <br>';
                BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
                BodyText += 'New Delhi 110046, India <br>';
                BodyText += 'Tel. +91 11 4711 9100 <br>';
                BodyText += 'Fax. +91 11 2852 1273 <br>';
                txtfile := 'TerritorySale ' + AREACode;
                /* if File.Exists('C:\StateWiseReport\' + txtfile + '.xlsx') THEN BEGIN
                    FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\StateWiseReport\' + txtfile + '.xlsx');
                    if TempBlobCU.HasValue() then begin
                        TempBlobCU.CreateInStream(InstreamVar);
                        EmailMsg.Create(EmailAddressList, 'Sales Invoice', BodyText, true, EmailCCList, EmailBccList);

                        txtfile := 'SKDReport ' + AREACode;
                        if File.Exists('C:\StateWiseReport\' + txtfile + '.xlsx') THEN BEGIN
                            FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\StateWiseReport\' + txtfile + '.xlsx');
                            if TempBlobCU.HasValue() then begin
                                TempBlobCU.CreateInStream(InstreamVar);
                                EmailMsg.Create(EmailAddressList, 'Sales Invoice', BodyText, true, EmailCCList, EmailBccList);

                            END;
                            txtfile := 'HSK_DRA_Report ' + AREACode;
                            if File.Exists('C:\StateWiseReport\' + txtfile + '.xlsx') THEN BEGIN
                                FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\StateWiseReport\' + txtfile + '.xlsx');
                                if TempBlobCU.HasValue() then begin
                                    TempBlobCU.CreateInStream(InstreamVar);
                                    EmailMsg.Create(EmailAddressList, 'Sales Invoice', BodyText, true, EmailCCList, EmailBccList);

                                END;
                                txtfile := 'WZ_Report ' + AREACode;
                                if File.Exists('C:\StateWiseReport\' + txtfile + '.xlsx') THEN BEGIN
                                    FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\StateWiseReport\' + txtfile + '.xlsx');
                                    if TempBlobCU.HasValue() then begin
                                        TempBlobCU.CreateInStream(InstreamVar);
                                        EmailMsg.Create(EmailAddressList, 'Sales Invoice', BodyText, true, EmailCCList, EmailBccList);
                                        EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);

                                    END;

                                END;
                            END;
                        END;
                    end;
                end;*/
            end;
        end;
    end;

    local procedure GenerateZHTargetVSAchieveReport(ZHCode: Code[20]; Qty: Boolean)
    var
        TargetVsAchievement: Report "Target Vs Achievement GVT";
        MatrixMaster: Record "Matrix Master";
        TargetVsAchievementhsk: Report "Target Vs Achie HSK DRA";
        TargetVsAchievementwz: Report "Target Vs Achie West Zone";
    begin
        IF Qty THEN BEGIN
            MatrixMaster.RESET;
            IF ZHCode <> '' THEN
                MatrixMaster.SETRANGE(ZH, ZHCode);
            IF MatrixMaster.FINDFIRST THEN BEGIN
                CLEAR(TargetVsAchievement);
                TargetVsAchievement.SetReportType(TRUE);
                TargetVsAchievement.SETTABLEVIEW(MatrixMaster);
                txtfile := 'SKDReport ' + ZHCode;
                // TargetVsAchievement.SAVEASEXCEL('C:\StateWiseReport\' + txtfile + '.xlsx');
                //New
                CLEAR(TargetVsAchievementhsk);
                TargetVsAchievementhsk.SetReportType(TRUE);
                TargetVsAchievementhsk.SETTABLEVIEW(MatrixMaster);
                IF ZHCode = '' THEN
                    txtfile := 'HSK_DRA_Report ' ELSE
                    txtfile := 'HSK_DRA_Report ' + ZHCode;
                // TargetVsAchievementhsk.SAVEASEXCEL('C:\StateWiseReport\' + txtfile + '.xlsx');
                //New
                CLEAR(TargetVsAchievementwz);
                TargetVsAchievementwz.SetReportType(TRUE);
                TargetVsAchievementwz.SETTABLEVIEW(MatrixMaster);
                IF ZHCode = '' THEN
                    txtfile := 'WZ_Report ' ELSE
                    txtfile := 'WZ_Report ' + ZHCode;
                // TargetVsAchievementwz.SAVEASEXCEL('C:\StateWiseReport\' + txtfile + '.xlsx');
            END;
        END ELSE BEGIN
            MatrixMaster.RESET;
            IF ZHCode <> '' THEN
                MatrixMaster.SETRANGE(ZH, ZHCode);
            IF MatrixMaster.FINDFIRST THEN BEGIN
                CLEAR(TargetVsAchievement);
                TargetVsAchievement.SetReportType(FALSE);
                TargetVsAchievement.SETTABLEVIEW(MatrixMaster);
                txtfile := 'TerritorySale ' + ZHCode;
                // TargetVsAchievement.SAVEASEXCEL('C:\StateWiseReport\' + txtfile + '.xlsx');
            END;
        END;
    end;


    procedure SendEmailZHTargetVsAchieve(PCHCode: Code[10]; AREACode: Code[20]; Qty: Boolean)
    var
        //  SMTPMail: Codeunit 400;
        //  SMTPMailSetup: Record 409;
        Docno2: Code[20];
        Docno3: Code[20];
    begin
        //PCH
        SalesPerson.RESET;
        SalesPerson.SETRANGE(Code, PCHCode);
        /*  IF SalesPerson.FINDFIRST THEN BEGIN
              IF SalesPerson."E-Mail" <> '' THEN BEGIN
                  SMTPMailSetup.GET;
                  SMTPMailSetup.TESTFIELD("User ID");
                  CLEAR(SMTPMail);
                  //SMTPMail.CreateMessage('Orient Bell Limited.','donotreply@orientbell.com',SalesPerson."E-Mail",'State Wise Report','', TRUE);
                  SMTPMail.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com', SalesPerson."E-Mail", 'TGT V/S Achvmt|SKD Report|HSK and Dora Report - ' + FORMAT(TODAY - 1), '', TRUE);
                  //SMTPMail.CreateMessage('Orient Bell Limited.','donotreply@orientbell.com','kulwant@mindshell.info','TGT V/S Achvmt|GVT Sales Tracker - '+FORMAT(TODAY -1),'', TRUE);
                  //SMTPMail.AddCC('bs.negi@orientbell.com');
                  SMTPMail.AddCC('donotreply@orientbell.com');
                  SMTPMail.AppendBody('Dear Sir <br>');
                  SMTPMail.AppendBody('Please find the attached report with this email. <br><br>');
                  SMTPMail.AppendBody('Thank You and Have a Good Day!');

                  SMTPMail.AppendBody('<br><br>');
                  SMTPMail.AppendBody('This is for your records');
                  SMTPMail.AppendBody('<br><br>');
                  SMTPMail.AppendBody('Regards, <br>');
                  SMTPMail.AppendBody('Orient Bell Limited <br>');
                  SMTPMail.AppendBody('Iris House, 16 Business Center, Nangal Raya <br>');
                  SMTPMail.AppendBody('New Delhi 110046, India <br>');
                  SMTPMail.AppendBody('Tel. +91 11 4711 9100 <br>');
                  SMTPMail.AppendBody('Fax. +91 11 2852 1273 <br>');

                  txtfile := 'TerritorySale ' + PCHCode;
                  IF (EXISTS('C:\StateWiseReport\' + txtfile + '.xlsx')) THEN BEGIN
                      SMTPMail.AddAttachment('C:\StateWiseReport\' + txtfile + '.xlsx', txtfile + '.xlsx');
                      txtfile := 'SKDReport ' + PCHCode;
                      IF (EXISTS('C:\StateWiseReport\' + txtfile + '.xlsx')) THEN BEGIN
                          SMTPMail.AddAttachment('C:\StateWiseReport\' + txtfile + '.xlsx', txtfile + '.xlsx');
                      END;
                      txtfile := 'HSK_DRA_Report ' + PCHCode;
                      IF (EXISTS('C:\StateWiseReport\' + txtfile + '.xlsx')) THEN BEGIN
                          SMTPMail.AddAttachment('C:\StateWiseReport\' + txtfile + '.xlsx', txtfile + '.xlsx');
                      END;
                      txtfile := 'WZ_Report ' + PCHCode;
                      IF (EXISTS('C:\StateWiseReport\' + txtfile + '.xlsx')) THEN BEGIN
                          SMTPMail.AddAttachment('C:\StateWiseReport\' + txtfile + '.xlsx', txtfile + '.xlsx');
                      END;
                      SMTPMail.Send();
                  END;
              END;
          END;*/ // 15578
    end;


    procedure MailtoZH()
    var
        SalesPersons: Record "Salesperson/Purchaser";
        DealerSchemeDetails: Record "Customer Scheme Details";
        txtfile: Text[250];
        SchemeMaster: Record "Scheme Master";
        EmailAddress: Text[250];
        InCorrectMail: Boolean;
        NoOfAtSigns: Integer;
        i: Integer;
        // SMTPSetup: Record 409;
        // SMTPMailCodeUnit: Codeunit 400;
        SalesData: Query "Sales Data";
        Text50000: Label 'Sales Details :';
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
        fromDate: Date;
        ToDate: Date;
        fileName: Text;
        CompletePath: Text;
        TotQty: Decimal;
        TotAmt: Decimal;
        BlnSendMail: Boolean;
    begin
        fromDate := GlbFromDate;
        ToDate := GlbToDate;

        SalesPersons.RESET;
        //SalesPersons.SETFILTER(Code,'%1|%2','VAC-DEHRA','1111622');
        SalesPersons.SETRANGE(SalesPersons.Status, SalesPersons.Status::Enable);
        IF SalesPersons.FINDFIRST THEN
            REPEAT
                EmailAddress := SalesPersons."E-Mail";
                InCorrectMail := FALSE;
                NoOfAtSigns := 0;
                FOR i := 1 TO STRLEN(EmailAddress) DO BEGIN
                    IF EmailAddress[i] = '@' THEN
                        NoOfAtSigns := NoOfAtSigns + 1;
                    IF (((EmailAddress[i] >= 'a') AND (EmailAddress[i] <= 'z')) OR
                      ((EmailAddress[i] >= 'A') AND (EmailAddress[i] <= 'Z')) OR
                      ((EmailAddress[i] >= '0') AND (EmailAddress[i] <= '9')) OR
                      (EmailAddress[i] IN ['@', '.', '-', '_']))
                    THEN BEGIN
                    END ELSE BEGIN
                        InCorrectMail := TRUE;
                    END
                END;
                CLEAR(SalesData);
                //SalesData.SETFILTER(SalesData.Area_Code,AreaCode);
                SalesData.SETFILTER(SalesData.Zonal_Head, '%1', SalesPersons.Code);
                SalesData.SETFILTER(SalesData.Posting_Date, '%1..%2', fromDate, GlbToDate);
                SalesData.OPEN;
            //          IF SalesData.READ THEN BEGIN
            //MESSAGE(SalesPersons.Code);
            /* 15578  IF InCorrectMail = FALSE THEN BEGIN
                  TotQty := 0;
                  TotAmt := 0;
                  IF (STRPOS(SalesPersons."E-Mail", ' ') = 0) AND (SalesPersons."E-Mail" <> '') THEN BEGIN
                      SMTPSetup.GET();
                      SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
                                                    SalesPersons."E-Mail", ' - ZH Sales Details - ' + SalesPersons.Name, '', TRUE);

                  END ELSE BEGIN
                      SMTPSetup.GET();
                      SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
                                                    'donotreply@orientbell.com', 'Sales Details - ' + SalesPersons.Name, '', TRUE);
                  END;

                  SMTPMailCodeUnit.AddCC('donotreply@orientbell.com');
                  IF SalesPersons.Name <> '' THEN
                      SMTPMailCodeUnit.AppendBody('Dear  ' + SalesPersons.Name)
                  ELSE
                      SMTPMailCodeUnit.AppendBody('Dear  ');
                  SMTPMailCodeUnit.AppendBody('<br><br>');
                  SMTPMailCodeUnit.AppendBody('Please find the enclosed detail of Sales Data for the Current Month. ');
                  SMTPMailCodeUnit.AppendBody('<br><br>');
                  //Table Start
                  SMTPMailCodeUnit.AppendBody(Text60005);
                  SMTPMailCodeUnit.AppendBody(Text60006);
                  SMTPMailCodeUnit.AppendBody(Text50027 + Text50026 + Text50041 + Text60012 + 'S.No.' + Text60013 + Text60003);
                  SMTPMailCodeUnit.AppendBody(Text50030 + Text60012 + 'Territory' + Text60013 + Text60003);
                  SMTPMailCodeUnit.AppendBody(Text50030 + Text60012 + 'Customer Name' + Text60013 + Text60003);
                  SrNo := 1;
                  SMTPMailCodeUnit.AppendBody(Text50030 + Text60012 + 'Sum of Sq. Mtr.' + Text60013 + Text60003);
                  SMTPMailCodeUnit.AppendBody(Text50030 + Text60012 + 'Value' + Text60013 + Text60003);

                  SMTPMailCodeUnit.AppendBody(Text60004);

                  WHILE SalesData.READ DO BEGIN
                      SMTPMailCodeUnit.AppendBody(Text50026 + Text50041 + FORMAT(SrNo) + Text60003);
                      SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT(SalesData.Description_2) + Text60003);
                      SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT(SalesData.Name) + Text60003);
                      SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT(SalesData.Sum_Quantity_Base) + Text60003);
                      SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT(ROUND(SalesData.Sum_Tax_Base_Amount / 100000, 0.01, '=')) + Text60003);
                      TotQty += SalesData.Sum_Quantity_Base;
                      TotAmt += ROUND(SalesData.Sum_Tax_Base_Amount / 100000, 0.01, '=');
                      BlnSendMail := TRUE;
                      SrNo += 1;
                  END;
                  SMTPMailCodeUnit.AppendBody(Text50026 + Text50041 + FORMAT('Total -->>') + Text60003);
                  SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT('') + Text60003);
                  SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT('') + Text60003);
                  SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT(TotQty) + Text60003);
                  SMTPMailCodeUnit.AppendBody(Text50041 + FORMAT(ROUND(TotAmt, 0.01, '=')) + Text60003);

                  //MSKS
                  SMTPMailCodeUnit.AppendBody(Text60004);

                  SMTPMailCodeUnit.AppendBody(Text60005);

                  SMTPMailCodeUnit.AppendBody(Text60006);
                  SMTPMailCodeUnit.AppendBody(Text60011);

                  SMTPMailCodeUnit.AppendBody('<br><br>');
                  SMTPMailCodeUnit.AppendBody('This is for your records');
                  SMTPMailCodeUnit.AppendBody('<br><br>');
                  SMTPMailCodeUnit.AppendBody('Regards, <br>');
                  SMTPMailCodeUnit.AppendBody('Orient Bell Limited <br>');
                  SMTPMailCodeUnit.AppendBody('Iris House, 16 Business Center, Nangal Raya <br>');
                  SMTPMailCodeUnit.AppendBody('New Delhi 110046, India <br>');
                  SMTPMailCodeUnit.AppendBody('Tel. +91 11 4711 9100 <br>');
                  SMTPMailCodeUnit.AppendBody('Fax. +91 11 2852 1273 <br>');
                  fileName := '';
                  fileName := 'ZH_' + SalesPersons.Code + '.xlsx';
                  IF (EXISTS('C:\StateWiseReport\' + fileName)) THEN BEGIN
                      CompletePath := 'C:\StateWiseReport\' + fileName;
                      SMTPMailCodeUnit.AddAttachment(CompletePath, fileName);
                  END;
                  IF TotAmt <> 0 THEN
                      SMTPMailCodeUnit.Send();
              END;*/ // 15578
                     //  END;
            UNTIL SalesPersons.NEXT = 0;
    end;
}

