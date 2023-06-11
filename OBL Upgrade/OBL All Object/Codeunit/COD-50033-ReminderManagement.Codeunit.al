codeunit 50033 "Reminder Management"
{
    // 50276


    trigger OnRun()
    begin
        CreateReminders;

        CLEAR(OrderFullFill);
        OrderFullFill.RUN;
        GeneratePDF;
        COMMIT;
        SendMail;
        IF GUIALLOWED THEN
            MESSAGE('Done');
    end;

    var
        ReminderDetails: Record "Reminder Details";
        Customer: Record Customer;
        PDFReminderDetails: Record "Reminder Details";
        OrderFullFill: Codeunit "Order Fulfillment Send Mail";


    procedure CreateReminders()
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        EntryNo: Integer;
    begin
        Customer.RESET;
        Customer.SETFILTER("E-Mail", '<>%1', '');
        //Customer.SETRANGE("State Code",'34'); //Need Comment Kulbhushan
        Customer.SETFILTER("Customer Type", '<>%1', 'LEGAL');
        Customer.SETFILTER("Stop Mail Comunication PCH SP", '%1', FALSE);
        //Customer.SETFILTER("No.",'%1|%2','C101313029504569','C101104007400082');
        IF Customer.FINDFIRST THEN BEGIN
            REPEAT
                Customer.CALCFIELDS(Balance);
                IF Customer.Balance > 50000 THEN BEGIN
                    EntryNo := GetFirstCustomerEntryOverDue(Customer."No.");

                    IF EntryNo > 0 THEN BEGIN
                        InsertReminderEntries(Customer."No.", EntryNo);
                    END;
                END;
            UNTIL Customer.NEXT = 0;
        END;
    end;


    procedure InsertReminderEntries(CustomerNo: Code[20]; CustEntryNo: Integer)
    var
        InsertReminder: Record "Reminder Details";
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        IF CustEntryNo = 0 THEN
            EXIT;
        ReminderDetails.RESET;
        ReminderDetails.SETRANGE("Customer No.", CustomerNo);
        ReminderDetails.SETRANGE("Customer Entry No.", CustEntryNo);
        IF ReminderDetails.FINDLAST THEN BEGIN
            IF (TODAY - ReminderDetails."Original Reminder Date") > GetCalculationDays(ReminderDetails."No. of Reminders" + 1) THEN BEGIN
                InsertReminder.INIT;
                InsertReminder.TRANSFERFIELDS(ReminderDetails);
                InsertReminder."No. of Reminders" := ReminderDetails."No. of Reminders" + 1;
                InsertReminder."Date of Reminder" := TODAY;
                InsertReminder."Mail Sent" := FALSE;
                InsertReminder."PDF Generated" := FALSE;
                //    ERROR('%1',InsertReminder);
                IF (InsertReminder."No. of Reminders" <= 3) THEN
                    IF NOT ReminderDataExists(ReminderDetails."Customer No.", TODAY) THEN
                        InsertReminder.INSERT;
            END;
        END ELSE BEGIN
            InsertReminder.INIT;
            InsertReminder."No. of Reminders" := 1;
            InsertReminder."Date of Reminder" := TODAY;
            InsertReminder."Customer Entry No." := CustEntryNo;
            InsertReminder."Customer No." := CustomerNo;
            InsertReminder."Original Reminder Date" := TODAY;
            CustLedgEntry.GET(CustEntryNo);
            CustLedgEntry.CALCFIELDS("Remaining Amount");
            InsertReminder."Date of Invoice" := CustLedgEntry."Posting Date";
            InsertReminder."Document No." := CustLedgEntry."Document No.";
            InsertReminder."Due date" := CustLedgEntry."Due Date";
            InsertReminder.Amount := CustLedgEntry."Remaining Amount";
            IF NOT ReminderDataExists(InsertReminder."Customer No.", TODAY) THEN
                InsertReminder.INSERT;
        END;
    end;


    procedure GetCalculationDays(ReminderType: Option " ",First,Second,Third): Integer
    begin
        //Set Reminder Days Durations
        CASE ReminderType OF
            ReminderType::First:
                EXIT(1);
            ReminderType::Second:
                EXIT(16);
            ReminderType::Third:
                EXIT(31);
        END;
    end;


    procedure GetFirstCustomerEntryOverDue(CustomerNo: Code[20]) EntryNo: Integer
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DueExists: Boolean;
        Customer: Record Customer;
        TotDue: Decimal;
    begin

        DueExists := FALSE;
        //MSKS2507
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETCURRENTKEY("Customer No.", Open, Positive, "Due Date", "Currency Code");
        CustLedgerEntry.SETRANGE("Customer No.", CustomerNo);
        CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SETRANGE("Due Date", 0D, TODAY);

        IF CustLedgerEntry.FINDFIRST THEN BEGIN
            REPEAT
                CustLedgerEntry.CALCFIELDS("Remaining Amount");
                TotDue += CustLedgerEntry."Remaining Amount";
            UNTIL CustLedgerEntry.NEXT = 0;
        END;

        IF TotDue < 5000 THEN
            EXIT;
        //MSKS2507
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETCURRENTKEY("Customer No.", Open, Positive, "Due Date", "Currency Code");
        CustLedgerEntry.SETRANGE("Customer No.", CustomerNo);
        CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
        IF CustLedgerEntry.FINDFIRST THEN BEGIN
            REPEAT
                CustLedgerEntry.CALCFIELDS("Remaining Amount");
                IF (TODAY - CustLedgerEntry."Due Date") > GetCalculationDays(1) THEN
                    IF ABS(CustLedgerEntry."Remaining Amount") > 100 THEN BEGIN // Remaining Amount should be greater than Rs. 100
                        EXIT(CustLedgerEntry."Entry No.");
                        DueExists := TRUE;
                    END;
            UNTIL (CustLedgerEntry.NEXT = 0) OR DueExists;
        END;
    end;


    procedure ReminderDataExists(CustomerNo: Code[20]; DTofIssue: Date): Boolean
    var
        RemDetails: Record "Reminder Details";
    begin
        IF RemDetails.GET(CustomerNo, DTofIssue) THEN
            EXIT(TRUE);
    end;


    procedure "---Mails---"()
    begin
    end;


    procedure SendMail()
    var
        ReSIH: Record "Sales Invoice Header";
        SalesInvHeader: Record "Sales Invoice Header";
        mycust: Record Customer;
        txtFile: Text[30];
        Leng: Integer;
        i: Integer;
        Flag: Integer;
        PCHEmail: Text[100];
        SPEmail: Text[100];
    begin
        ReminderDetails.RESET;
        ReminderDetails.SETRANGE(ReminderDetails."Mail Sent", FALSE);
        IF ReminderDetails.FINDFIRST THEN BEGIN
            REPEAT
                CreateMail(ReminderDetails);
                ReminderDetails."Mail Sent" := TRUE;
                ReminderDetails."Date of Issue" := TODAY;
                ReminderDetails.MODIFY;
                COMMIT;
            UNTIL ReminderDetails.NEXT = 0;
        END;
    end;


    procedure CreateMail(var RemDetails: Record "Reminder Details")
    var
        //  SMTPSetup: Record 409;
        //  SMTPMail: Codeunit 400;
        Cust: Record Customer;
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
        CustLedgEntry: Record "Cust. Ledger Entry";
        Text1: Text;
        DueAmt: Decimal;
        txtfile: Text;
        SalesPur: Record "Salesperson/Purchaser";
        OrgAmt: Decimal;
        FormatOrgAmt: Text;
        FormatDueAmt: Text;
        TxtPCH: Text;
    begin
        /*    SMTPSetup.GET();
            Cust.GET(RemDetails."Customer No.");
            IF IsValidEmail(Cust."E-Mail") THEN BEGIN
                //IF Cust."E-Mail"='' THEN
                //EXIT;
                Cust.CALCFIELDS(Balance);
                IF RemDetails."No. of Reminders" >= 3 THEN
                    SMTPMail.CreateMessage('Orient Bell Limited', 'donotreply@orientbell.com',
                                                  //                              Cust."E-Mail",'Un-Paid Dues of INR OF Rs. '+FORMAT(Cust.Balance),'',TRUE);
                                                  Cust."E-Mail", 'Un-Paid Dues of INR OF Rs. ' + FORMAT(Cust.Balance) + '. FINAL REMINDER', '', TRUE)

                ELSE
                    SMTPMail.CreateMessage('Orient Bell Limited', 'donotreply@orientbell.com',
                                                  //                              Cust."E-Mail",'Un-Paid Dues of INR OF Rs. '+FORMAT(Cust.Balance),'',TRUE);
                                                  Cust."E-Mail", 'Un-Paid Dues of INR OF Rs. ' + FORMAT(Cust.Balance) + '. REMINDER - ' + FORMAT(RemDetails."No. of Reminders"), '', TRUE);
                //SMTPMail.AddCC('amit.gupta@orientbell.com');
                SMTPMail.AddCC('creditcontrol@orientbell.com');
                //SMTPMail.AddCC('rakesh.kumar@orientbell.com');
                SMTPMail.AddCC('donotreply@orientbell.com');
                //Remove Comment while Live
                IF RemDetails."No. of Reminders" > 1 THEN BEGIN
                    //  IF GetSpEmailID(Cust,0) <>'' THEN
                    //    SMTPMail.AddCC(GetSpEmailID(Cust,0));
                    //Customer,SP,PCH,ZonalManager,PSM,Finance
                    IF GetSPEmailID(Cust, 1) <> '' THEN // SP
                        SMTPMail.AddCC(GetSPEmailID(Cust, 1));
                    IF GetSPEmailID(Cust, 2) <> '' THEN //PCH
                        SMTPMail.AddCC(GetSPEmailID(Cust, 2));
                    IF GetSPEmailID(Cust, 3) <> '' THEN //Zonal
                        SMTPMail.AddCC(GetSPEmailID(Cust, 3));
                    IF GetSPEmailID(Cust, 4) <> '' THEN //PSM
                        SMTPMail.AddCC(GetSPEmailID(Cust, 4));
                    IF RemDetails."No. of Reminders" > 2 THEN BEGIN
                        IF GetSPEmailID(Cust, 5) <> '' THEN //Finance
                            SMTPMail.AddCC(GetSPEmailID(Cust, 5));
                    END;
                END ELSE BEGIN
                    IF GetSPEmailID(Cust, 1) <> '' THEN
                        SMTPMail.AddCC(GetSPEmailID(Cust, 1));
                    IF GetSPEmailID(Cust, 2) <> '' THEN
                        SMTPMail.AddCC(GetSPEmailID(Cust, 2));
                    IF GetSPEmailID(Cust, 3) <> '' THEN
                        SMTPMail.AddCC(GetSPEmailID(Cust, 3));
                END;
                IF Cust.Name <> '' THEN
                    SMTPMail.AppendBody(Text60012 + 'M/S.  ' + Cust.Name + ',' + Text60013)
                ELSE
                    SMTPMail.AppendBody('Dear  ');
                SMTPMail.AppendBody('<br><br>');
                CustLedgEntry.RESET;
                CustLedgEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Currency Code");

                CustLedgEntry.SETRANGE("Customer No.", RemDetails."Customer No.");
                CustLedgEntry.SETFILTER("Document Type", '%1', CustLedgEntry."Document Type"::Invoice);
                CustLedgEntry.SETFILTER("Due Date", '<%1', TODAY);

                IF CustLedgEntry.FINDFIRST THEN BEGIN
                    REPEAT
                        CustLedgEntry.CALCFIELDS("Remaining Amount");
                        IF CustLedgEntry."Remaining Amount" > 0 THEN
                            DueAmt += CustLedgEntry."Remaining Amount";
                    UNTIL CustLedgEntry.NEXT = 0;
                END;
                SMTPMail.AppendBody('We remind you hereby that out of the total outstanding balance of INR ' + FORMAT(Cust.Balance));
                SMTPMail.AppendBody(', our books of accounts are showing an overdue bill value of INR ' + FORMAT(DueAmt) + '.');
                DueAmt := 0;

                SMTPMail.AppendBody('<br><br>');
                SMTPMail.AppendBody('The details are as listed as below:');
                SMTPMail.AppendBody('<br><br>');
                //Table Start
                SMTPMail.AppendBody(Text60005);
                SMTPMail.AppendBody(Text60006);
                SMTPMail.AppendBody(Text60011);
                SMTPMail.AppendBody(Text50027 + Text50026 + Text50030 + Text60012 + 'Invoice No.' + Text60013 + Text60003);
                SMTPMail.AppendBody(Text50030 + Text60012 + 'Invoice Date' + Text60013 + Text60003);
                SMTPMail.AppendBody(Text50030 + Text60012 + 'Original Amount(INR)' + Text60013 + Text60003);
                // SMTPMail.AppendBody(Text50041+Text60012+'Remaining Due(INR)' +Text60013+Text60003);
                SMTPMail.AppendBody(Text50041 + Text60012 + 'Overdue Amt (INR)' + Text60013 + Text60003);
                SMTPMail.AppendBody(Text50041 + Text60012 + ' Payment Delay Days' + Text60013 + Text60003);
                SMTPMail.AppendBody(Text60004);
                //  CustLedgEntry.RESET;
                CustLedgEntry.SETRANGE("Customer No.", RemDetails."Customer No.");
                CustLedgEntry.SETFILTER("Document Type", '%1', CustLedgEntry."Document Type"::Invoice);
                CustLedgEntry.SETFILTER("Due Date", '<%1', TODAY);
                CustLedgEntry.SETCURRENTKEY("Due Date");
                IF CustLedgEntry.FINDFIRST THEN BEGIN
                    REPEAT
                        CustLedgEntry.CALCFIELDS(CustLedgEntry."Remaining Amount", "Original Amount", "Amount (LCY)");
                        IF CustLedgEntry."Remaining Amount" > 0 THEN BEGIN
                            SMTPMail.AppendBody(Text50026 + Text50041 + FORMAT(CustLedgEntry."Document No.") + Text60003);
                            SMTPMail.AppendBody(Text50041 + FORMAT(CustLedgEntry."Posting Date") + Text60003);
                            SMTPMail.AppendBody(Text50041 + FORMAT(CustLedgEntry."Original Amount") + Text60003);
                            SMTPMail.AppendBody(Text50041 + FORMAT(CustLedgEntry."Remaining Amount") + Text60003);
                            //      SMTPMail.AppendBody(Text50041+FORMAT(CustLedgEntry."Remaining Amount")+Text60003);
                            SMTPMail.AppendBody(Text50041 + FORMAT(TODAY - CustLedgEntry."Due Date") + Text60003);
                            SMTPMail.AppendBody(Text60004);
                            DueAmt += CustLedgEntry."Remaining Amount";
                            OrgAmt += CustLedgEntry."Original Amount";
                        END;
                    UNTIL CustLedgEntry.NEXT = 0;
                END;
                //

                SMTPMail.AppendBody(Text50026 + Text60012 + '' + Text60013 + Text60003);
                SMTPMail.AppendBody(Text50041 + Text60012 + '' + Text60013 + Text60003);
                SMTPMail.AppendBody(Text50041 + Text60012 + 'Sub-Total' + Text60013 + Text60003);
                SMTPMail.AppendBody(Text50041 + Text60012 + FORMAT(ROUND(OrgAmt, 0.01, '=')) + Text60013 + Text60003);
                // SMTPMail.AppendBody(Text50041+Text60012+FORMAT(ROUND(DueAmt,0.01,'=')) +Text60013+Text60003);
                SMTPMail.AppendBody(Text50041 + Text60012 + FORMAT(ROUND(DueAmt, 0.01, '=')) + Text60013 + Text60003);
                SMTPMail.AppendBody(Text50041 + Text60012 + '' + Text60013 + Text60003);
                SMTPMail.AppendBody(Text60004);

                //
                SMTPMail.AppendBody(Text60004);
                SMTPMail.AppendBody(Text60005);

                SMTPMail.AppendBody(Text60006);
                SMTPMail.AppendBody(Text60011);

                //Table End

                Text1 := '';
                Text1 := 'You are requested to clear the overdue amount of INR ';
                Text1 := Text1 + FORMAT(DueAmt);
                Text1 := Text1 + ' immediately without further delay and release the RTGS / Cheque / DD  (Payable at New Delhi). <br> <br>';

                Text1 := Text1 + 'In case of non-payment of overdues, your credit score rating with OBL may get downgraded leading to lowering of credit limits for future business.';


                SMTPMail.AppendBody(Text50031 + Text1 + Text60003);

                SMTPMail.AppendBody(Text60011);

                //SMTPMail.AppendBody('For any assistance, you can get in touch with Anil Mishra, Delhi,on his Mobile No. 8373914430 or Mr. Amit Gupta Credit Control Department at Head office, New Delhi at Phone No. 011-47119100. <br> <br> ');
                IF SalesPur.GET(Cust."PCH Code") THEN;

                TxtPCH := 'Mr. ' + SalesPur.Name + ', ' + Cust."State Desc." + ', on his Mobile No. ' + SalesPur."Phone No.";
                //SMTPMail.AppendBody(Text50031+Text1+Text60003);

                //SMTPMail.AppendBody('For any assistance, you can get in touch with Anil Mishra, Delhi,on his Mobile No. 8373914430 or Mr. Amit Gupta Credit Control Department at Head office, New Delhi at Phone No. 011-47119100. <br> <br> ');
                SMTPMail.AppendBody('For any assistance, you can get in touch with ' + TxtPCH + ' or Mr. Amit Gupta Credit Control Department at Head office, New Delhi at Phone No. 011-47119100. <br> <br> ');


                SMTPMail.AppendBody('Yours Truly, <br>');
                SMTPMail.AppendBody('For Orient Bell Limited <br>');
                SMTPMail.AppendBody('<br><br>');
                SMTPMail.AppendBody('Credit Control Team <br>');
                SMTPMail.AppendBody('IRIS House, 16 Business Centre, Nangal Raya <br>');
                SMTPMail.AppendBody('New Delhi - 110046. Ph. No. 011-47119100<br>');
                SMTPMail.AppendBody('<br><br>');

                SMTPMail.AppendBody('In Case of any query please write to us at creditcontrol@orientbell.com');
                //SMTPMail.AppendBody('<br>');
                //SMTPMail.AppendBody('Cc: Mr. Ashish Mehta - President (Sales & Marketing) <br>');
                //SMTPMail.AppendBody('Mr. Jaywant Puri - VP (Finance and Accounts) <br>');
                //SMTPMail.AppendBody('Mr. Amit Gupta - DGM (Sales Accounting & Credit Control) <br>');

                //SMTPMail.AppendBody('Mr.'+SalesPur.Name +'PCH - '+ Cust."State Desc." +'<br>');
                SMTPMail.AppendBody('<br><br>');
                SMTPMail.AppendBody('********This is a computer generated letter, does not require signatures*********** <br>');

                //
                txtfile := CONVERTSTR(RemDetails."Customer No." + '-' + FORMAT(RemDetails."Date of Reminder") + '-' + FORMAT(RemDetails."No. of Reminders"), '/', '_');
                txtfile := CONVERTSTR(txtfile, '\', '_');
                //    DunningLetter.SAVEASPDF('C:\MailPDF\DunningLetters\'+txtFile+'.pdf');

                //
                IF (EXISTS('C:\DunningLetter\' + txtfile + '.pdf')) THEN BEGIN
                    SMTPMail.AddAttachment('C:\DunningLetter\' + txtfile + '.pdf', txtfile + '.pdf');
                END;
                SMTPMail.Send();
            END;*/ // 15578

    end;


    procedure GetSPEmailID(Cust: Record Customer; Type: Option Customer,SP,PCH,ZonalManager,PSM,Finance): Text
    var
        SalesPerson: Record "Salesperson/Purchaser";
        SPCode: Code[20];
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        CASE Type OF
            Type::Customer:
                EXIT(Cust."E-Mail");
            Type::SP:
                SPCode := Cust."Salesperson Code";
            Type::PCH:
                SPCode := Cust."PCH Code";
            Type::ZonalManager:
                SPCode := Cust."Zonal Manager";
            Type::PSM:
                BEGIN
                    SalesSetup.GET;
                    IF Cust."Zonal Head" <> '' THEN
                        SPCode := Cust."Zonal Head" ELSE
                        SPCode := SalesSetup."PSM Code";
                END;
            Type::Finance:
                EXIT('creditcontrol@orientbell.com');
        //EXIT
        END;
        IF SalesPerson.GET(SPCode) THEN
            IF IsValidEmail(SalesPerson."E-Mail") THEN
                EXIT(SalesPerson."E-Mail");
    end;


    procedure GeneratePDF()
    var
        Text000: Label 'Generating';
        Text005: Label 'Report';
        DunningLetter: Report "Dunning Letter";
        ReminderDetails: Record "Reminder Details";
        DocNoNew: Code[50];
        txtFile: Text;
    begin
        //SendMail();
        ReminderDetails.RESET;
        ReminderDetails.SETRANGE(ReminderDetails."PDF Generated", FALSE);
        IF ReminderDetails.FINDFIRST THEN BEGIN
            REPEAT
                CLEAR(Customer);
                txtFile := '';
                Customer.SETRANGE("No.", ReminderDetails."Customer No.");
                IF Customer.FINDFIRST THEN BEGIN
                    CLEAR(DunningLetter);
                    DunningLetter.SETTABLEVIEW(Customer);
                    DunningLetter.SetAsonDate(TODAY);
                    txtFile := CONVERTSTR(ReminderDetails."Customer No." + '-' + FORMAT(ReminderDetails."Date of Reminder") + '-' + FORMAT(ReminderDetails."No. of Reminders"), '/', '_');
                    txtFile := CONVERTSTR(txtFile, '\', '_');
                    // DunningLetter.SAVEASPDF('C:\DunningLetter\' + txtFile + '.pdf');
                    SLEEP(1000);
                END;
            UNTIL ReminderDetails.NEXT = 0;
        END;
        COMMIT;
        PDFReminderDetails.RESET;
        //PDFReminderDetails.SETRANGE("PDF Generated",FALSE);
        IF PDFReminderDetails.FINDFIRST THEN BEGIN
            PDFReminderDetails.MODIFYALL("PDF Generated", TRUE);
        END;
    end;


    procedure SendMailfromWord()
    begin
    end;


    procedure IsValidEmail(EmailAddress: Text) InCorrectMail: Boolean
    var
        NoOfAtSigns: Integer;
        i: Integer;
    begin

        InCorrectMail := FALSE;//MSKS020313
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
        IF (STRPOS(EmailAddress, ' ') = 0) AND (EmailAddress <> '') THEN
            InCorrectMail := TRUE;
    end;
}

