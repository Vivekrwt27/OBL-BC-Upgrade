codeunit 50042 "Order Fulfillment Send Mail"
{
    // --MSVRN 301117-- V1.00


    trigger OnRun()
    begin

        //IF GUIALLOWED THEN
        //IF CONFIRM('Do you want to send order fulfillment mail?',TRUE) THEN


        IF (TIME < 010100T) THEN BEGIN
            GenerateFiles;
            MailtoSPs;
        END;

        IF (TIME > 110100T) AND (TIME < 120100T) THEN BEGIN
            GenerateFilesCC;
            MailtoCC;
        END;
    end;


    procedure GenerateFiles()
    var
        R50010: Report "Closing Stock Marketing";
        RecItem: Record Item;
        Date1: Date;
        txtfile: Text;
        txtfile2: Text;
        txtfile3: Text;
        RecSalesLine: Record "Sales Line";
        R50402: Report "Sales Line Details";
        RecSalesHeader: Record "Sales Header";
        R50403: Report "Sales Order List";
        r50065: Report "Customer - Ageing Due Date";
        reccustomer: Record Customer;
        txtfile4: Text;
        r50296: Report "SO Line Combined Report";
        txtfile5: Text;
    begin
        RecItem.RESET;

        RecItem.SETFILTER(RecItem."Plant Code", '%1|%2|%3', 'M', 'D', 'H');
        RecItem.SETFILTER(RecItem."Location Filter", '%1|%2|%3', 'SKD-WH-MFG', 'DRA-WH-MFG', 'HSK-WH-MFG');
        IF RecItem.FINDFIRST THEN BEGIN
            CLEAR(R50010);
            R50010.SETTABLEVIEW(RecItem);
            txtfile := ' Items';
            // R50010.SAVEASEXCEL('C:\OrderFF\' + txtfile + '.xlsx');
        END;
        RecSalesLine.CALCFIELDS(RecSalesLine."Posting Date");
        RecSalesLine.RESET;
        //RecSalesLine.SETRANGE(RecSalesLine."Posting Date", (TODAY));
        IF RecSalesLine.FINDFIRST THEN BEGIN
            CLEAR(R50402);
            R50402.SETTABLEVIEW(RecSalesLine);
            txtfile2 := ' Sales Line Details';
            // R50402.SAVEASEXCEL('C:\OrderFF\' + txtfile2 + '.xlsx');

        END;
        RecSalesHeader.RESET;
        IF RecSalesHeader.FINDFIRST THEN BEGIN
            CLEAR(R50403);
            R50403.SETTABLEVIEW(RecSalesHeader);
            txtfile3 := ' Sales Order Details';
            // R50403.SAVEASEXCEL('C:\OrderFF\' + txtfile3 + '.xlsx');
        END;
        IF reccustomer.FINDFIRST THEN BEGIN
            CLEAR(r50065);
            r50065.SETTABLEVIEW(reccustomer);
            txtfile4 := ' Customer';
            // r50065.SAVEASEXCEL('C:\OrderFF\' + txtfile4 + '.xlsx');
        END;

        CLEAR(r50296);
        txtfile5 := 'SOLineCombined';
        // r50296.SAVEASEXCEL('C:\OrderFF\' + txtfile5 + '.xlsx');
        MESSAGE('Done');
    end;


    procedure MailtoSPs()
    var
        txtfile: Text[250];
        //   SMTPSetup: Record "409";
        //   SMTPMailCodeUnit: Codeunit "400";
        SalesPersonTarget: Record "Budget Master";
        txtfile2: Text;
        txtfile3: Text;
        txtfile4: Text;
        txtfile5: Text;

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
        EmailAddressList.Add('donotreply@orientbell.com');
        /// EmailTo.Add('tara.chand@orientbell.com');
        EmailCCList.Add('vivek.shrivastav@orientbell.com'); //--  041217);
        EmailCCList.Add('amit.gupta@orientbell.com'); //--  041217);
        EmailCCList.Add('kulbhushan.sharma@orientbell.com'); //--  041217);

        // SMTPSetup.GET();
        // SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com', 'tara.chand@orientbell.com', 'Order Fulfillment Details', '', TRUE);
        // SMTPMailCodeUnit.AddCC('vivek.shrivastav@orientbell.com'); //--  041217
        // SMTPMailCodeUnit.AddCC('amit.gupta@orientbell.com'); //--  041217
        // SMTPMailCodeUnit.AddCC('kulbhushan.sharma@orientbell.com'); //--  041217
        BodyText := 'Dear  ';
        BodyText += '<br><br>';
        BodyText += 'Please find the enclosed detail with this email. ';
        BodyText += '<br><br>';
        BodyText += 'This is for your records';
        BodyText += '<br><br>';
        BodyText += 'Regards, <br>';
        BodyText += 'Orient Bell Limited <br>';
        BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
        BodyText += 'New Delhi 110046, India <br>';
        BodyText += 'Tel. +91 11 4711 9100 <br>';
        BodyText += 'Fax. +91 11 2852 1273 <br>';
        txtfile := ' Items';
        txtfile2 := ' Sales Line Details';
        txtfile3 := ' Sales Order Details';
        txtfile4 := ' Customer';
        txtfile5 := 'SOLineCombined';

        /* if File.Exists('C:\OrderFF\' + txtfile + '.xlsx') OR (EXISTS('C:\OrderFF\' + txtfile2 + '.xlsx')) OR (EXISTS('C:\OrderFF\' + txtfile3 + '.xlsx')) OR (EXISTS('C:\OrderFF\' + txtfile4 + '.xlsx')) OR (EXISTS('C:\OrderFF\' + txtfile5 + '.xlsx')) THEN BEGIN
            FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\OrderFF\' + txtfile + '.xlsx');
            FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\OrderFF\' + txtfile2 + '.xlsx');
            FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\OrderFF\' + txtfile3 + '.xlsx');
            FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\OrderFF\' + txtfile4 + '.xlsx');
            FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\OrderFF\' + txtfile5 + '.xlsx');
            if TempBlobCU.HasValue() then begin
                TempBlobCU.CreateInStream(InstreamVar);
                EmailMsg.Create(EmailAddressList, 'Order Fulfillment Details', BodyText, true, EmailCCList, EmailBccList);
                EmailMsg.AddAttachment('C:\OrderFF\' + txtfile + '.xlsx', 'application/pdf', InstreamVar);
                EmailMsg.AddAttachment('C:\OrderFF\' + txtfile2 + '.xlsx', 'application/pdf', InstreamVar);
                EmailMsg.AddAttachment('C:\OrderFF\' + txtfile3 + '.xlsx', 'application/pdf', InstreamVar);
                EmailMsg.AddAttachment('C:\OrderFF\' + txtfile4 + '.xlsx', 'application/pdf', InstreamVar);
                EmailMsg.AddAttachment('C:\OrderFF\' + txtfile5 + '.xlsx', 'application/pdf', InstreamVar);
                EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);


                // IF ((EXISTS('C:\OrderFF\' + txtfile + '.xlsx')) OR (EXISTS('C:\OrderFF\' + txtfile2 + '.xlsx')) OR (EXISTS('C:\OrderFF\' + txtfile3 + '.xlsx')) OR (EXISTS('C:\OrderFF\' + txtfile4 + '.xlsx')) OR (EXISTS('C:\OrderFF\' + txtfile5 + '.xlsx'))) THEN BEGIN
                //  SMTPMailCodeUnit.AddAttachment('C:\OrderFF\' + txtfile + '.xlsx', txtfile + '.xlsx');
                //  SMTPMailCodeUnit.AddAttachment('C:\OrderFF\' + txtfile2 + '.xlsx', txtfile2 + '.xlsx');
                //  SMTPMailCodeUnit.AddAttachment('C:\OrderFF\' + txtfile3 + '.xlsx', txtfile3 + '.xlsx');
                //  SMTPMailCodeUnit.AddAttachment('C:\OrderFF\' + txtfile4 + '.xlsx', txtfile4 + '.xlsx');
                //  SMTPMailCodeUnit.AddAttachment('C:\OrderFF\' + txtfile5 + '.xlsx', txtfile5 + '.xlsx');

                //  SMTPMailCodeUnit.Send();
            END;
        end;
 */
    end;


    procedure GenerateFilesCC()
    var
        R50010: Report "Closing Stock Marketing";
        RecItem: Record Item;
        Date1: Date;
        txtfile: Text;
        txtfile2: Text;
        txtfile3: Text;
        RecSalesLine: Record "Sales Line";
        R50402: Report "Sales Line Details";
        RecSalesHeader: Record "Sales Header";
        R50403: Report "Sales Order List";
        r50065: Report "Customer - Ageing Due Date";
        reccustomer: Record Customer;
        txtfile4: Text;
        R50296: Report "SO Line Combined Report";
        R50292: Report "Credit Billing Exception New";
    begin
        CLEAR(R50292);
        txtfile := 'PaymentCreditIssue';
        // R50292.SAVEASEXCEL('C:\OrderFF\' + txtfile + '.xlsx');
        MESSAGE('Done');
    end;


    procedure MailtoCC()
    var
        txtfile: Text[250];
        // SMTPSetup: Record "409";
        // SMTPMailCodeUnit: Codeunit "400";
        SalesPersonTarget: Record "Budget Master";
        txtfile2: Text;
        txtfile3: Text;
        txtfile4: Text;

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
        // SMTPSetup.GET();
        //  SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com', 'tara.chand@orientbell.com', 'Payment & Credit Issue', '', TRUE);
        EmailAddressList.Add('donotreply@orientbell.com');
        EmailCCList.Add('vivek.shrivastav@orientbell.com'); //--  041217);
        EmailCCList.Add('amit.gupta@orientbell.com'); //--  041217);
        EmailCCList.Add('kulbhushan.sharma@orientbell.com'); //--  041217);

        BodyText := 'Dear  ';
        BodyText += '<br><br>';
        BodyText += 'Please find the enclosed Payment & Credit Issue Report. ';
        BodyText += '<br><br>';
        BodyText += 'This is for your records';
        BodyText += '<br><br>';
        BodyText += 'Regards, <br>';
        BodyText += 'Orient Bell Limited <br>';
        BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
        BodyText += 'New Delhi 110046, India <br>';
        BodyText += 'Tel. +91 11 4711 9100 <br>';
        BodyText += 'Fax. +91 11 2852 1273 <br>';
        txtfile := 'PaymentCreditIssue';

        /* if File.Exists('C:\OrderFF\' + txtfile + '.xlsx') THEN BEGIN
            FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\OrderFF\' + txtfile + '.xlsx');
            if TempBlobCU.HasValue() then begin
                TempBlobCU.CreateInStream(InstreamVar);
                EmailMsg.Create(EmailAddressList, 'Payment & Credit Issue', BodyText, true, EmailCCList, EmailBccList);
                EmailMsg.AddAttachment('C:\OrderFF\' + txtfile + '.xlsx', 'application/pdf', InstreamVar);
                EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
            end;

        end; */
    end;
}

