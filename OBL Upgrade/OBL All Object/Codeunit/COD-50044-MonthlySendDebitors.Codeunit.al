codeunit 50044 "Monthly Send (Debitors)"
{

    trigger OnRun()
    begin
        SendProdAlertReport;

        IF DATE2DMY(TODAY, 1) = 1 THEN BEGIN

            GenerateReportSummary;

            //CreateSP_CityWiseSales;  //For SP File Creation
            //CreatePCH_CityWiseSales;  //For PCH File Creation
            //Create_CityWiseSales_All;  //For Complete File Creation
            //SendSP_CityWiseSales;     //For Email to SP
            //SendPCH_CityWiseSales;    //For Email to Branch Head
            //SendALL_CityWiseSales;    //For Email to Management}

            //  Send_SalesGVT;        // GVT Scoreboard
            //  Send_SalesGVTPCH;     // GVT Scoreboard
        END;

        IF DATE2DMY(TODAY, 1) = 16 THEN BEGIN
            Send_SalesGVT;        // GVT Scoreboardhiman
            Send_SalesGVTPCH;     // GVT Scoreboard
        END;

        SendMGTMISReport;

        IF GUIALLOWED THEN
            MESSAGE('Done');
    end;

    var
        txtfile: Text;
        SalesPerson: Record "Salesperson/Purchaser";
        CompletePath: Text;


    procedure GenerateReportSummary()
    var
        AgeingReportNotification: Report "Debtors Report MIS";
    begin

        //ZH
        SalesPerson.RESET;
        SalesPerson.SETRANGE("Customer No.", '');
        SalesPerson.SETRANGE(Status, SalesPerson.Status::Enable);
        IF SalesPerson.FINDFIRST THEN BEGIN
            REPEAT
                CLEAR(AgeingReportNotification);
                AgeingReportNotification.SetParameters(TODAY + 1, CALCDATE('CM', TODAY + 1), '', SalesPerson.Code, '', '', '', FALSE);
                txtfile := 'DEBTORAGE_ZH_' + SalesPerson.Code;
                // AgeingReportNotification.SAVEASEXCEL('C:\StateWiseReport\' + txtfile + '.xlsx');
                SendEmailSummary(SalesPerson, txtfile, FALSE);

            UNTIL SalesPerson.NEXT = 0;
        END;

        //ZM
        SalesPerson.RESET;
        SalesPerson.SETRANGE("Customer No.", '');
        SalesPerson.SETRANGE(Status, SalesPerson.Status::Enable);
        IF SalesPerson.FINDFIRST THEN BEGIN
            REPEAT
                CLEAR(AgeingReportNotification);
                AgeingReportNotification.SetParameters(TODAY + 1, CALCDATE('CM', TODAY + 1), '', '', SalesPerson.Code, '', '', FALSE);
                txtfile := 'DEBTORAGE_ZM_' + SalesPerson.Code;
                // AgeingReportNotification.SAVEASEXCEL('C:\StateWiseReport\' + txtfile + '.xlsx');
                SendEmailSummary(SalesPerson, txtfile, FALSE);
            UNTIL SalesPerson.NEXT = 0;
        END;

        //PCH
        SalesPerson.RESET;
        SalesPerson.SETRANGE("Customer No.", '');
        SalesPerson.SETRANGE(Status, SalesPerson.Status::Enable);
        IF SalesPerson.FINDFIRST THEN BEGIN
            REPEAT
                CLEAR(AgeingReportNotification);
                AgeingReportNotification.SetParameters(TODAY + 1, CALCDATE('CM', TODAY + 1), '', '', '', SalesPerson.Code, '', FALSE);
                txtfile := 'DEBTORAGE_PCH_' + SalesPerson.Code;
                // AgeingReportNotification.SAVEASEXCEL('C:\StateWiseReport\' + txtfile + '.xlsx');
                SendEmailSummary(SalesPerson, txtfile, FALSE);
            UNTIL SalesPerson.NEXT = 0;
        END;

        //SP
        SalesPerson.RESET;
        SalesPerson.SETRANGE("Customer No.", '');
        SalesPerson.SETRANGE(Status, SalesPerson.Status::Enable);
        IF SalesPerson.FINDFIRST THEN BEGIN
            REPEAT
                CLEAR(AgeingReportNotification);
                AgeingReportNotification.SetParameters(TODAY + 1, CALCDATE('CM', TODAY + 1), '', '', '', '', SalesPerson.Code, FALSE);
                txtfile := 'DEBTORAGE_SP_' + SalesPerson.Code;
                // AgeingReportNotification.SAVEASEXCEL('C:\StateWiseReport\' + txtfile + '.xlsx');
                SendEmailSummary(SalesPerson, txtfile, FALSE);
            UNTIL SalesPerson.NEXT = 0;
        END;

        //Summary
        CLEAR(AgeingReportNotification);
        AgeingReportNotification.SetParameters(TODAY + 1, CALCDATE('CM', TODAY + 1), '', '', '', '', '', FALSE);
        txtfile := 'DEBTORAGE_ALL_' + 'ALL';
        // AgeingReportNotification.SAVEASEXCEL('C:\StateWiseReport\' + txtfile + '.xlsx');
        SendEmailSummary(SalesPerson, txtfile, TRUE);
    end;


    procedure SendEmailSummary(LocalSalesPerson: Record "Salesperson/Purchaser"; FileName: Text; SendSummary: Boolean)
    var
        //   SMTPMail: Codeunit 400;
        //   SMTPMailSetup: Record 409;
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

        IF SendSummary THEN BEGIN

            //Send Summary.
            /*   SMTPMailSetup.GET;
               SMTPMailSetup.TESTFIELD("User ID");
               CLEAR(SMTPMail);
               SMTPMail.CreateMessage('CFO Office - OBL.', 'cfooffice@orientbell.com', 'donotreply@orientbell.com', 'Debtor Ageing Report', '', TRUE);*/
            EmailAddressList.Add('cfooffice@orientbell.com');
            EmailCCList.Add('aditya.gupta@orientbell.com');
            EmailCCList.Add('pinaki.nandy@orientbell.com');
            EmailCCList.Add('himanshu.jindal@orientbell.com');
            EmailCCList.Add('sandeep.jhanwar@orientbell.com');
            EmailCCList.Add('amit.gupta@orientbell.com');
            EmailCCList.Add('pushpender.kumar@orientbell.com');
            EmailCCList.Add('Dharmendra.Singh@orientbell.com');
            EmailCCList.Add('rakesh.kumar@orientbell.com');
            EmailCCList.Add('narayan.jha@orientbell.com');
            EmailCCList.Add('bs.negi@orientbell.com');
            EmailCCList.Add('amit.goel@orientbell.com');
            EmailCCList.Add('donotreply@orientbell.com');
            BodyText := 'Dear All <br>';
            //BodyText :=('There was a bug in the report, which has been fixed now, please find the correct report');
            //  BodyText +='Please find enclosed information on debtors showing customer wise and day wise amounts getting due during ' + FORMATTODAY, 0, '<Month Text>' + '<br><br>';
            BodyText += 'Thank You and Have a Good Day!';
            BodyText += 'Regards, <br>';
            BodyText += 'CFO Office, <br>';
            BodyText += 'Orient Bell Limited <br>';
            BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
            BodyText += 'New Delhi 110046, India <br>';
            BodyText += 'Tel. +91 11 4711 9252 <br>';
            BodyText += 'Fax. +91 11 2852 1273 <br>';
            // if File.Exists('C:\StateWiseReport\' + FileName + '.xlsx') THEN BEGIN
            // FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\StateWiseReport\' + FileName + '.xlsx');
            if TempBlobCU.HasValue() then begin
                TempBlobCU.CreateInStream(InstreamVar);
                EmailMsg.Create(EmailAddressList, 'Sales Invoice', BodyText, true, EmailBccList, EmailCCList);
                // if File.Exists('C:\Broucher\' + 'OrientBellNewLaunches.jpg') THEN
                EmailMsg.AddAttachment('C:\StateWiseReport\' + FileName + '.xlsx' + 'Debtor Ageing Report', 'application/pdf', InstreamVar);//JD
                EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
            END;
        END ELSE BEGIN
            //PCH
            IF LocalSalesPerson."E-Mail" <> '' THEN BEGIN
                /* SMTPMailSetup.GET;
                 SMTPMailSetup.TESTFIELD("User ID");
                 CLEAR(SMTPMail);
                 SMTPMail.CreateMessage('CFO Office - OBL.', 'cfooffice@orientbell.com', LocalSalesPerson."E-Mail", 'Debtor Ageing Report', '', TRUE);*/
                EmailAddressList.Add('cfooffice@orientbell.com');
                EmailCCList.Add('donotreply@orientbell.com');
                BodyText := 'Dear ' + LocalSalesPerson.Name + '<br>';
                BodyText += 'Please find enclosed information on debtors showing customer wise and day wise amounts getting due during ' + FORMAT(TODAY, 0, '<Month Text>') + '<br><br>';
                //BodyText +='There was a bug in the report, which has been fixed now, please find the correct report';
                BodyText += 'You should take a printout of this and keep it with you.';
                BodyText += 'This information will help you tracking customer dues well in advance and plan its collection much before order booking and its faster processing';
                BodyText += 'Regards, <br>';
                BodyText += 'CFO Office, <br>';
                BodyText += 'Orient Bell Limited <br>';
                BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
                BodyText += 'New Delhi 110046, India <br>';
                BodyText += 'Tel. +91 11 4711 9252 <br>';
                BodyText += 'Fax. +91 11 2852 1273 <br>';
                /* if File.Exists('C:\StateWiseReport\' + FileName + '.xlsx') THEN BEGIN
                    FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\StateWiseReport\' + FileName + '.xlsx');
                    if TempBlobCU.HasValue() then begin
                        TempBlobCU.CreateInStream(InstreamVar);
                        EmailMsg.Create(EmailAddressList, 'Debtor Ageing Report', BodyText, true, EmailBccList, EmailCCList);
                        if File.Exists('C:\StateWiseReport\' + FileName + '.xlsx') THEN
                            EmailMsg.AddAttachment('C:\StateWiseReport\' + FileName + '.xlsx', 'application/pdf', InstreamVar);
                        EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                    END;


                END;
*/
            END;
        end;
        //end;
    end;


    procedure SendMGTMISReport()
    var
        //  SMTPMail: Codeunit "400";
        //  SMTPMailSetup: Record "409";
        Docno6: Code[20];
        Docno7: Code[20];
        FileName: Text;
        ManagementSalesReport: Report "Management Sales Report (MIS)";
        SubJect: Text;
        SalesJournalData: Query "Sales Journal Data";
        AsonDate: Date;
        DebtorsCollectionMGT: Query "Debtors Collection MGT";
        DebtorBalAmt: Decimal;
        SalesASOnDate: Decimal;
        SAlesForMonth: Decimal;
        Collection: Decimal;
        SalesReturnJournalData: Query "Sales Return Journal Data";

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

        AsonDate := TODAY - 1;

        FileName := 'MGTMIS_' + FORMAT(AsonDate);
        FileName := CONVERTSTR(FileName, '/', '_');
        // ManagementSalesReport.SAVEASEXCEL('C:\StateWiseReport\' + FileName + '.xlsx');

        CLEAR(DebtorsCollectionMGT);
        DebtorsCollectionMGT.SETFILTER(DebtorsCollectionMGT.PostDateFilter, '%1..%2', 0D, CALCDATE('CM', AsonDate));
        DebtorsCollectionMGT.SETFILTER(Sum_Amount, '>%1', 0);
        DebtorsCollectionMGT.OPEN;
        WHILE DebtorsCollectionMGT.READ DO BEGIN
            DebtorBalAmt += DebtorsCollectionMGT.Sum_Amount / 10000000;
        END;


        //MonthStartDate := CALCDATE('-CM',ASonDate);
        //MonthEndDate := CALCDATE('CM',ASonDate);

        SalesJournalData.SETFILTER(SalesJournalData.PostingDate, '%1..%2', CALCDATE('-CM', AsonDate), AsonDate);
        SalesJournalData.OPEN;
        WHILE SalesJournalData.READ DO BEGIN
            IF SalesJournalData.PostingDate = AsonDate THEN
                SalesASOnDate += SalesJournalData.LineAmount;
            SAlesForMonth += SalesJournalData.LineAmount;
        END;

        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.PostingDate, '%1..%2', CALCDATE('-CM', AsonDate), AsonDate);
        SalesReturnJournalData.OPEN;
        WHILE SalesReturnJournalData.READ DO BEGIN
            IF SalesReturnJournalData.PostingDate = AsonDate THEN
                SalesASOnDate -= SalesReturnJournalData.LineAmount;
            SAlesForMonth -= SalesReturnJournalData.LineAmount;
        END;

        SalesASOnDate := ROUND(SalesASOnDate / 10000000, 0.01, '=');
        SAlesForMonth := ROUND(SAlesForMonth / 10000000, 0.01, '=');

        ManagementSalesReport.GetCollectionData1('', CALCDATE('-CM', AsonDate), AsonDate, Collection);
        Collection := ROUND(Collection / 10000000, 0.01, '=');

        SubJect := 'Sales for ' + FORMAT(AsonDate, 0, '<Month Text>') + ' is ' + FORMAT(SAlesForMonth) + ' Crores, sale on ' + FORMAT(AsonDate) + ' is ' + FORMAT(SalesASOnDate) + ' Cr. Debtors ' + FORMAT(ROUND(DebtorBalAmt, 0.01, '=')) + ' Cr, Collection MTD '
                    + FORMAT(Collection) + ' Cr.';

        /*  SMTPMailSetup.GET;
          SMTPMailSetup.TESTFIELD("User ID");
          CLEAR(SMTPMail);
          SMTPMail.CreateMessage('CFO Office - OBL.', 'cfooffice@orientbell.com', 'anuj.prashar@orientbell.com', SubJect, '', TRUE);*/
        EmailCCList.Add('himanshu.jindal@orientbell.com');
        EmailCCList.Add('kulbhushan.sharma@orientbell.com');
        EmailCCList.Add('sandeep.jhanwar@orientbell.com');

        EmailCCList.Add('Vivek.Shrivastav@orientbell.com');
        BodyText := 'Hi,<br>';
        BodyText += 'Please find enclosed Sales information as on ' + FORMAT(AsonDate, 0, '<Month Text>') + '<br><br>';
        BodyText += 'Thank You and Have a Good Day!';
        BodyText += 'Regards, <br>';
        BodyText += 'CFO Office, <br>';
        BodyText += 'Orient Bell Limited <br>';
        BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
        BodyText += 'New Delhi 110046, India <br>';
        BodyText += 'Tel. +91 11 4711 9252 <br>';
        BodyText += 'Fax. +91 11 2852 1273 <br>';

        // if File.Exists('C:\StateWiseReport\' + FileName + '.xlsx') THEN BEGIN
        //  FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\StateWiseReport\' + FileName + '.xlsx');
        if TempBlobCU.HasValue() then begin
            TempBlobCU.CreateInStream(InstreamVar);
            EmailMsg.Create(EmailAddressList, SubJect, BodyText, true, EmailBccList, EmailCCList);
            // if File.Exists('C:\Broucher\' + 'OrientBellNewLaunches.jpg') THEN
            EmailMsg.AddAttachment('C:\StateWiseReport\' + FileName + '.xlsx', 'application/pdf', InstreamVar);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
        END;
        // end;
    end;


    procedure SendSP_CityWiseSales()
    var
        //   SMTPMail: Codeunit "400";
        //   SMTPMailSetup: Record "409";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Text100: Label 'SP_CityWise_Sales_';
        Filepath: Text;

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

        SalespersonPurchaser.RESET;
        //SalespersonPurchaser.SETFILTER(Code, '%1|%2', '1110076', 'VAC-SET');
        //SalespersonPurchaser.SETFILTER(Code, '%1', '1110076');
        SalespersonPurchaser.SETFILTER(Status, '%1', SalespersonPurchaser.Status::Enable);
        IF SalespersonPurchaser.FINDFIRST THEN
            REPEAT
                IF (SalespersonPurchaser."E-Mail" <> '') AND ISActiveSalesPerson(SalespersonPurchaser.Code) THEN BEGIN
                    /* SMTPMailSetup.GET;
                     SMTPMailSetup.TESTFIELD("User ID");
                     CLEAR(SMTPMail);
                     SMTPMail.CreateMessage('CSO Office - OBL.', 'donotreply@orientbell.com', SalespersonPurchaser."E-Mail", 'SP CityWise Sales_' + SalespersonPurchaser.Code + '_' + SalespersonPurchaser.Name, '', TRUE);*/
                    //SMTPMail.CreateMessage('CSO Office - OBL.',SMTPMailSetup."User ID",'laxman.singh@orientbell.com','SP CityWise Sales_'+SalespersonPurchaser.Code+'_'+SalespersonPurchaser.Name,'', TRUE);
                    EmailAddressList.Add('donotreply@orientbell.com');
                    EmailCCList.Add('donotreply@orientbell.com');
                    BodyText := 'Hi,<br>';
                    BodyText += 'Please find Enclosed Town wise Product wise Performance of your Territory<br>';
                    BodyText += 'Thank You and Have a Good Day!<br>';
                    BodyText += '<br><br>';
                    BodyText += 'Regards, <br>';
                    BodyText += 'CSO Office, <br>';
                    BodyText += 'Orient Bell Limited <br>';
                    BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
                    BodyText += 'New Delhi 110046, India <br>';
                    BodyText += 'Tel. +91 11 4711 9190 <br>';
                    BodyText += 'Fax. +91 11 2852 1273 <br>';
                    Filepath := 'C:\Population Wise Sales\SP_CityWiseSales\' + Text100 + SalespersonPurchaser.Code + '.xlsx';
                    // if File.Exists(Filepath) THEN BEGIN
                    // FileMgmt.BLOBExportToServerFile(TempBlobCU, Filepath);
                    if TempBlobCU.HasValue() then begin
                        TempBlobCU.CreateInStream(InstreamVar);
                        EmailMsg.Create(EmailAddressList, 'SP CityWise Sales_' + SalespersonPurchaser.Code + '_' + SalespersonPurchaser.Name, BodyText, true, EmailBccList, EmailCCList);
                        // if File.Exists(Filepath) THEN
                        EmailMsg.AddAttachment(Filepath, 'application/pdf', InstreamVar);
                        EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
                    END;
                    // END;
                end;
            UNTIL SalespersonPurchaser.NEXT = 0;
    end;


    procedure SendPCH_CityWiseSales()
    var
        // SMTPMail: Codeunit "400";
        // SMTPMailSetup: Record "409";
        Customer: Record Customer;
        TempPCHCode: Code[20];
        Filepath: Text;
        Text100: Label 'PCH_CityWise_Sales_';
        SalespersonPurchaser: Record "Salesperson/Purchaser";

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

        Customer.RESET;
        Customer.SETCURRENTKEY("PCH Code");
        //Customer.SETFILTER("PCH Code", '%1', '1111882');
        IF Customer.FINDFIRST THEN
            REPEAT
                SalespersonPurchaser.RESET;
                IF SalespersonPurchaser.GET(Customer."PCH Code") THEN BEGIN
                    IF TempPCHCode <> Customer."PCH Code" THEN BEGIN
                        TempPCHCode := Customer."PCH Code";
                        /* SMTPMailSetup.GET;
                         SMTPMailSetup.TESTFIELD("User ID");
                         CLEAR(SMTPMail);
                         SMTPMail.CreateMessage('CSO Office - OBL.', 'donotreply@orientbell.com', SalespersonPurchaser."E-Mail", 'Branch Head, CityWise Sales_' + SalespersonPurchaser.Code + '_' + SalespersonPurchaser.Name, '', TRUE);*/
                        //SMTPMail.CreateMessage('CFO Office - OBL.',SMTPMailSetup."User ID",'laxman.singh@orientbell.com','PCH CityWise Sales_'+SalespersonPurchaser.Code +'_' +SalespersonPurchaser.Name,'', TRUE);
                        EmailAddressList.Add('donotreply@orientbell.com');
                        BodyText := 'Hi,<br>';
                        BodyText += 'Please find Enclosed Town wise Product wise Performance of your Territory<br>';
                        BodyText += 'Thank You and Have a Good Day!<br>';
                        BodyText += '<br><br>';
                        BodyText += 'Regards, <br>';
                        BodyText += 'CSO Office, <br>';
                        BodyText += 'Orient Bell Limited <br>';
                        BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
                        BodyText += 'New Delhi 110046, India <br>';
                        BodyText += 'Tel. +91 11 4711 9190 <br>';
                        BodyText += 'Fax. +91 11 2852 1273 <br>';
                        Filepath := 'C:\Population Wise Sales\PCH_CityWiseSales\' + Text100 + Customer."PCH Code" + '.xlsx';

                        // if File.Exists(Filepath) THEN BEGIN
                        // FileMgmt.BLOBExportToServerFile(TempBlobCU, Filepath);
                        if TempBlobCU.HasValue() then begin
                            TempBlobCU.CreateInStream(InstreamVar);
                            EmailMsg.Create(EmailAddressList, 'Branch Head', BodyText, true, EmailBccList, EmailCCList);
                            // if File.Exists('C:\Broucher\' + 'OrientBellNewLaunches.jpg') THEN
                            EmailMsg.AddAttachment(Filepath, 'application/pdf', InstreamVar);
                            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                        END;


                    END;
                END;
            // end;
            UNTIL Customer.NEXT = 0;

    end;


    procedure SendALL_CityWiseSales()
    var
        //  SMTPMail: Codeunit "400";
        //  SMTPMailSetup: Record "409";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Text100: Label 'CityWise_Sales';
        Filepath: Text;

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

        /* SMTPMailSetup.GET;
         SMTPMailSetup.TESTFIELD("User ID");
         CLEAR(SMTPMail);
         //SMTPMail.CreateMessage('CSO Office - OBL.',SMTPMailSetup."User ID",SalespersonPurchaser."E-Mail",'SP CityWise Sales','', TRUE);
         SMTPMail.CreateMessage('CFO Office - OBL.', 'donotreply@orientbell.com', 'sougata.ghosh@orientbell.com', 'SP/Branch Head CityWise Sales', '', TRUE);*/
        //SMTPMail.AddCC('kulbhushan.sharma@orientbell.com');
        EmailAddressList.Add('donotreply@orientbell.com');
        EmailCCList.add('donotreply@orientbell.com');
        BodyText := 'Hi,<br>';
        BodyText += 'Please find Enclosed Town wise Product wise Performance<br>';
        BodyText += 'Thank You and Have a Good Day!<br>';
        BodyText += '<br><br>';
        BodyText += 'Regards, <br>';
        BodyText += 'CSO Office, <br>';
        BodyText += 'Orient Bell Limited <br>';
        BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
        BodyText += 'New Delhi 110046, India <br>';
        BodyText += 'Tel. +91 11 4711 9190 <br>';
        BodyText += 'Fax. +91 11 2852 1273 <br>';
        Filepath := 'C:\Population Wise Sales\CityWiseSales_ALL\' + Text100 + '.xlsx';

        // if File.Exists(Filepath) THEN BEGIN
        // FileMgmt.BLOBExportToServerFile(TempBlobCU, Filepath);
        if TempBlobCU.HasValue() then begin
            TempBlobCU.CreateInStream(InstreamVar);
            EmailMsg.Create(EmailAddressList, 'SP/Branch Head CityWise Sales', BodyText, true, EmailBccList, EmailCCList);
            // if File.Exists('C:\Broucher\' + 'OrientBellNewLaunches.jpg') THEN
            EmailMsg.AddAttachment(Filepath, 'application/pdf', InstreamVar);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
        END;
        // END;
    end;


    procedure CreateSP_CityWiseSales()
    var
        //  SMTPMail: Codeunit "400";
        //  SMTPMailSetup: Record "409";
        // SPPCHCityWiseSales: Report 50045;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Text100: Label 'SP_CityWise_Sales_';
        Filepath: Text;
        LCLSalespersonPurchaser: Record "Salesperson/Purchaser";
    begin
        SalespersonPurchaser.RESET;
        SalespersonPurchaser.SETFILTER(Status, '%1', SalespersonPurchaser.Status::Enable);
        IF SalespersonPurchaser.FINDFIRST THEN
            REPEAT
                IF ISActiveSalesPerson(SalespersonPurchaser.Code) THEN BEGIN
                    //  CLEAR(SPPCHCityWiseSales);
                    LCLSalespersonPurchaser.RESET;
                    LCLSalespersonPurchaser.SETRANGE(Code, SalespersonPurchaser.Code);
                    IF LCLSalespersonPurchaser.FINDFIRST THEN BEGIN
                        //   SPPCHCityWiseSales.SETTABLEVIEW(LCLSalespersonPurchaser);
                        Filepath := 'C:\Population Wise Sales\SP_CityWiseSales\' + Text100 + LCLSalespersonPurchaser.Code + '.xlsx';
                        //   SPPCHCityWiseSales.SAVEASEXCEL(Filepath);
                    END;
                END;
            UNTIL SalespersonPurchaser.NEXT = 0;
    end;


    procedure CreatePCH_CityWiseSales()
    var
        Customer: Record Customer;
        //  SPPCHCityWiseSales: Report 50045;
        Filepath: Text;
        Text100: Label 'PCH_CityWise_Sales_';
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        TempPCHCode: Code[20];
        LClCustomer: Record Customer;

    begin
        Customer.RESET;
        Customer.SETCURRENTKEY("PCH Code");
        IF Customer.FINDFIRST THEN
            REPEAT
                IF TempPCHCode <> Customer."PCH Code" THEN BEGIN
                    TempPCHCode := Customer."PCH Code";
                    //    CLEAR(SPPCHCityWiseSales);
                    LClCustomer.RESET;
                    LClCustomer.SETCURRENTKEY("PCH Code");
                    LClCustomer.SETRANGE("PCH Code", Customer."PCH Code");
                    IF LClCustomer.FINDFIRST THEN BEGIN
                        //    SPPCHCityWiseSales.SETTABLEVIEW(LClCustomer);
                        Filepath := 'C:\Population Wise Sales\PCH_CityWiseSales\' + Text100 + LClCustomer."PCH Code" + '.xlsx';
                        //   SPPCHCityWiseSales.SAVEASEXCEL(Filepath);
                    END;
                END;
            UNTIL Customer.NEXT = 0;
    end;


    procedure Create_CityWiseSales_All()
    var
        // SPPCHCityWiseSales: Report 50045;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Filepath: Text;
        Text100: Label 'CityWise_Sales';
    begin
        SalespersonPurchaser.RESET;
        /*  CLEAR(SPPCHCityWiseSales);
          SPPCHCityWiseSales.SETTABLEVIEW(SalespersonPurchaser);
          Filepath := 'C:\Population Wise Sales\CityWiseSales_ALL\' + Text100 + '.xlsx';
          SPPCHCityWiseSales.SAVEASEXCEL(Filepath);*/// 15578
    end;

    local procedure ISActiveSalesPerson(SPCOde: Code[20]): Boolean
    var
        Customer: Record Customer;
    begin
        Customer.RESET;
        Customer.SETCURRENTKEY("Salesperson Code");
        Customer.SETRANGE("Salesperson Code", SPCOde);
        IF Customer.FINDFIRST THEN
            EXIT(TRUE);
    end;

    local procedure ISActivePCH(SPCOde: Code[20]): Boolean
    var
        Customer: Record Customer;
    begin
        Customer.RESET;
        Customer.SETCURRENTKEY("PCH Code");
        Customer.SETRANGE("PCH Code", SPCOde);
        IF Customer.FINDFIRST THEN
            EXIT(TRUE);
    end;


    procedure Send_SalesGVTPCH()
    var
        //  SMTPMail: Codeunit "400";
        //  SMTPMailSetup: Record "409";
        MatrixMaster: Record "Matrix Master";
        Text101: Label 'SalesGVTPCH';
        Filepath: Text;
        GVTScorecardPCHFinal: Report "GVT Scorecard PCH Final";

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

        MatrixMaster.RESET;
        Filepath := 'C:\SalesGVTPCH\' + Text101 + '.xlsx';
        // GVTScorecardPCHFinal.SAVEASEXCEL(Filepath);

        COMMIT;

        SLEEP(200);

        /*SMTPMailSetup.GET;
        SMTPMailSetup.TESTFIELD("User ID");
        CLEAR(SMTPMail);
        //SMTPMail.CreateMessage('CFO Office - OBL.',SMTPMailSetup."User ID",SalespersonPurchaser."E-Mail",'SP CityWise Sales','', TRUE);
        //SMTPMail.CreateMessage('CFO Office - OBL.',SMTPMailSetup."User ID",'laxman.singh@orientbell.com','SP CityWise Sales','', TRUE);
        SMTPMail.CreateMessage('', 'donotreply@orientbell.com', 'sumit.thapar@orientbell.com', 'Sales GVT PCH Wise', '', TRUE);*/
        EmailAddressList.Add('donotreply@orientbell.com');
        EmailCCList.Add('kulbhushan.sharma@orientbell.com');
        EmailCCList.Add('divya.chauhan@orientbell.com');
        //SMTPMail.AppendBody('Hi,<br>');
        BodyText := 'Please find the attached file.<br>';
        // if File.Exists(Filepath) THEN BEGIN
        // FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\SalesGVTPCH\' + Text101 + '.xlsx');
        if TempBlobCU.HasValue() then begin
            TempBlobCU.CreateInStream(InstreamVar);
            EmailMsg.Create(EmailAddressList, 'SP CityWise Sales', BodyText, true, EmailBccList, EmailCCList);
            // if File.Exists('C:\SalesGVTPCH\' + Text101 + '.xlsx') THEN
            EmailMsg.AddAttachment('C:\SalesGVTPCH\' + Text101 + '.xlsx', 'application/pdf', InstreamVar);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
        END;
        // end;
    end;


    procedure Send_SalesGVT()
    var
        // SMTPMail: Codeunit "400";
        // SMTPMailSetup: Record "409";
        Text102: Label 'SalesGVT';
        Filepath: Text;
        GVTScorecardFinal: Report "GVT Scorecard Final";

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
        Filepath := 'C:\SalesGVT\' + Text102 + '.xlsx';
        // GVTScorecardFinal.SAVEASEXCEL(Filepath);

        COMMIT;

        SLEEP(200);

        /*  SMTPMailSetup.GET;
          SMTPMailSetup.TESTFIELD("User ID");
          CLEAR(SMTPMail);
          //SMTPMail.CreateMessage('CFO Office - OBL.',SMTPMailSetup."User ID",SalespersonPurchaser."E-Mail",'SP CityWise Sales','', TRUE);
          //SMTPMail.CreateMessage('CFO Office - OBL.',SMTPMailSetup."User ID",'laxman.singh@orientbell.com','SP CityWise Sales','', TRUE);
          SMTPMail.CreateMessage('', 'donotreply@orientbell.com', 'deepak.m@orientbell.com', 'Sales GVT All', '', TRUE);*/

        EmailAddressList.add('kulbhushan.sharma@orientbell.com');
        //SMTPMail.AppendBody('Hi,<br>');
        BodyText := 'Please find the attached file.<br>';
        // if File.Exists(Filepath) THEN BEGIN
        // FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\SalesGVT\' + Text102 + '.xlsx');
        if TempBlobCU.HasValue() then begin
            TempBlobCU.CreateInStream(InstreamVar);
            EmailMsg.Create(EmailAddressList, 'SP CityWise Sales', BodyText, true, EmailBccList, EmailCCList);
            // if File.Exists('C:\SalesGVT\' + Text102 + '.xlsx') THEN
            EmailMsg.AddAttachment('C:\Broucher\' + 'OrientBellNewLaunches.jpg', 'application/pdf', InstreamVar);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
        END;
        /* IF (EXISTS(Filepath)) THEN BEGIN
             SMTPMail.AddAttachment('C:\SalesGVT\' + Text102 + '.xlsx', Text102 + '.xlsx');
             SLEEP(1000);
             SMTPMail.Send();
         END;*/
        // end;
    end;


    procedure SendProdAlertReport()
    var
        // SMTPMail: Codeunit "400";
        // SMTPMailSetup: Record "409";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Text100: Label 'ProdAlert';
        Filepath: Text;
        Location: Record Location;
        ProductionAlertSixMonth: Report "Production Alert Six Month";
        FIleAttached: Boolean;

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

        /*  SMTPMailSetup.GET;
          SMTPMailSetup.TESTFIELD("User ID");*/
        Location.RESET;
        Location.SETFILTER(Code, '%1|%2|%3', 'SKD-WH-MFG', 'DRA-WH-MFG', 'HSK-WH-MFG');
        IF Location.FINDFIRST THEN BEGIN
            // CLEAR(SMTPMail);
            //SMTPMail.CreateMessage('CSO Office - OBL.',SMTPMailSetup."User ID",SalespersonPurchaser."E-Mail",'SP CityWise Sales','', TRUE);
            //   SMTPMail.CreateMessage('Production Planning', 'donotreply@orientbell.com', 'amit.gupta@orientbell.com', 'Production Alert Report As on Date - ' + FORMAT(TODAY, 9), '', TRUE);
            EmailAddressList.Add('donotreply@orientbell.com');
            EmailCCList.Add('alok.agarwal@orientbell.com');

            EmailCCList.Add('kulbhushan.sharma@orientbell.com');
            BodyText := 'Hi,<br>';
            BodyText += 'Please find Enclosed the Production Alert Report as on date.<br>';
            BodyText += '<br>';
            BodyText += 'Thank You and Have a Good Day!<br>';
            BodyText += '<br><br>';
            BodyText += 'Regards, <br>';
            BodyText += 'Production Planning Team, <br>';
            BodyText += 'Orient Bell Limited <br>';
            BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
            BodyText += 'New Delhi 110046, India <br>';
            BodyText += 'Tel. +91 11 4711 9190 <br>';
            BodyText += 'Fax. +91 11 2852 1273 <br>';
            REPEAT
                Filepath := 'C:\AutoMail\ProductionAlert\' + Text100 + '_' + Location.Code + '.xlsx';
                CLEAR(ProductionAlertSixMonth);
                ProductionAlertSixMonth.SetLocationFilter(Location.Code);
                // ProductionAlertSixMonth.SAVEASEXCEL(Filepath);
                // if File.Exists(Filepath) THEN BEGIN
                // FileMgmt.BLOBExportToServerFile(TempBlobCU, Filepath);
                if TempBlobCU.HasValue() then begin
                    TempBlobCU.CreateInStream(InstreamVar);
                    EmailMsg.Create(EmailAddressList, 'Production Alert Report As on Date - ' + FORMAT(TODAY, 9), BodyText, true, EmailBccList, EmailCCList);
                    // if File.Exists('C:\Broucher\' + 'OrientBellNewLaunches.jpg') THEN
                    EmailMsg.AddAttachment(Filepath, 'application/pdf', InstreamVar);
                    EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
                    FIleAttached := TRUE;
                END;


            /*   IF (EXISTS(Filepath)) THEN BEGIN
                   SMTPMail.AddAttachment(Filepath, Text100 + '_' + Location.Code + '.xlsx');
                   FIleAttached := TRUE;
               END;*/
            // end;
            UNTIL Location.NEXT = 0;
            /*  IF FIleAttached THEN
                  SMTPMail.Send();*/

        END;
    end;
}

