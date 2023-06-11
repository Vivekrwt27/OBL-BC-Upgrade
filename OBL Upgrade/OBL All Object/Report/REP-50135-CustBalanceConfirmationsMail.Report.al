report 50135 "Cust. BalanceConfirmationsMail"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = WHERE("Stop Mail Comunication PCH SP" = FILTER(false));
            RequestFilterFields = "No.", Name, "Customer Type", "Area Code";

            trigger OnAfterGetRecord()
            begin
                MailGeneration(Customer);
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET;
                IF dtAsOn = 0D THEN
                    dtAsOn := TODAY;

                IF decOutstndAmt < 0 THEN
                    ERROR('Outstanding Amount must be greater then zero');

                // Customer.SETRANGE("Date Filter",0D,dtAsOn);
                Customer.SETFILTER("E-Mail", '<>%1', '');
                // Customer.CALCFIELDS(Balance);
                // Customer.SETFILTER(Balance,'>%1',decOutstndAmt);
                intCOunt := 0;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field("Request Date"; dtAsOn)
                {
                }
                field("Outstanding Amount"; decOutstndAmt)
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        IF (UPPERCASE(USERID) <> 'FA007') AND (UPPERCASE(USERID) <> 'ADMIN') THEN
            ERROR('You are not allowed');
    end;

    var
        CompanyInformation: Record 79;
        dtAsOn: Date;
        decOutstndAmt: Decimal;
        intCnt: Text;
        intCOunt: Integer;

    local procedure MailGeneration(var Customer: Record 18)
    var
        decCustOutstndAmt: Decimal;
        //16767recSMTPMailSetup: Record 409;
        //16767 SMTPMail: Codeunit 400;
        TextCons001: Label '<nbsp>';
        TextCons002: Label '<br>';
        TextCons003: Label '</Table>';
        TextCons004: Label '</HTML>';
        TextCons005: Label '<TR>';
        TextCons006: Label '<table border="1" width="25%" align="right">';
        TextCons007: Label '</TR>';
        txtFileName: Text;
        rCustomer: Record 18;
        rptCustmerBalances: Report 50134;
        //16767 TempBlob: Record 99008535 temporary;
        rSalesReceivablesSetup: Record 311;
        txtImageName: Text;
        FileManagment: Codeunit 419;
        rCLE: Record 21;
        recSalesperson: Record 13;
        BodyText: Text;
        TomailID: List of [Text];
        CCMailID: List of [Text];
        BCCMailID: List of [Text];

        Email: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        TempBlobCU: Codeunit "Temp Blob";
        OutstreamVar: OutStream;
        InstreamVar: InStream;



    begin
        Clear(TempBlobCU);
        Clear(OutstreamVar);
        Clear(InstreamVar);
        TempBlobCU.CreateInStream(InstreamVar);
        TempBlobCU.CreateOutStream(OutstreamVar);

        // Customer.CALCFIELDS(Balance);
        // decCustOutstndAmt:=Customer.Balance;
        rCLE.RESET;
        rCLE.SETRANGE("Customer No.", Customer."No.");
        rCLE.SETRANGE("Posting Date", 0D, dtAsOn);
        IF rCLE.FIND('-') THEN BEGIN
            REPEAT
                rCLE.CALCFIELDS(Amount);
                decCustOutstndAmt += rCLE.Amount;
            UNTIL rCLE.NEXT = 0;
        END;
        IF decCustOutstndAmt < decOutstndAmt THEN
            CurrReport.SKIP;

        //16767 recSMTPMailSetup.GET;
        TomailID.Add('creditcontrol@orientbell.com');
        //SMTPMail.CreateMessage('Orient Bell',recSMTPMailSetup."Sender Email",'keshav.sri@mindshell.info','Balance Confirmation','',TRUE);
        //SMTPMail.CreateMessage('Orient Bell Limited',recSMTPMailSetup."Sender Email",Customer."E-Mail",'Balance Confirmation','',TRUE);
        EmailMsg.Create(TomailID, 'Orient Bell Limited' + 'Balance Confirmation - ' + Customer.Name, BodyText, true, CcmailId, BCCMailID);
        //16767 SMTPMail.CreateMessage('Orient Bell Limited','creditcontrol@orientbell.com',Customer."E-Mail",'Balance Confirmation - '+Customer.Name,' ',TRUE);
        //SMTPMail.CreateMessage('Orient Bell Limited','creditcontrol@orientbell.com','amit.gupta@orientbell.com','Balance Confirmation','',TRUE);
        //16767 SMTPMail.AddCC('donotreply@orientbell.com');
        CCMailID.Add('donotreply@orientbell.com');
        Customer.CALCFIELDS("SP E-Maill ID");
        //16767 SMTPMail.AddCC(Customer."SP E-Maill ID");
        BCCMailID.Add(Customer."SP E-Maill ID");
        //16767 SMTPMail.AddCC(Customer."PCH E-Maill ID");
        BCCMailID.Add(Customer."PCH E-Maill ID");


        recSalesperson.RESET;
        IF recSalesperson.GET(Customer."CC Team") THEN
            IF recSalesperson."E-Mail" <> '' THEN
                //16767 SMTPMail.AddCC(recSalesperson."E-Mail");
                CCMailID.Add(recSalesperson."E-Mail");

        /*
        recSalesperson.RESET;
        IF recSalesperson.GET(Customer."Zonal Manager") THEN
          IF recSalesperson."E-Mail"<>'' THEN
            SMTPMail.AddCC(recSalesperson."E-Mail");
        */

        intCOunt := intCOunt + 1;
        IF STRLEN(FORMAT(intCOunt)) = 1 THEN BEGIN
            intCnt := '000' + FORMAT(intCOunt);
        END ELSE
            IF STRLEN(FORMAT(intCOunt)) = 2 THEN BEGIN
                intCnt := '00' + FORMAT(intCOunt);
            END ELSE
                IF STRLEN(FORMAT(intCOunt)) = 3 THEN BEGIN
                    intCnt := '0' + FORMAT(intCOunt);
                END ELSE
                    IF STRLEN(FORMAT(intCOunt)) = 4 THEN BEGIN
                        intCnt := FORMAT(intCOunt);
                    END;

        BodyText := ('OBL/ACCS/BC/Q3/2022-23/' + FORMAT(intCnt) + '                                                                ,  New Delhi-' + FORMAT(dtAsOn) + TextCons002 + TextCons002);
        BodyText := ('<b>' + Customer.Name + '</b>' + TextCons002);
        BodyText += (Customer.Address + TextCons002);
        BodyText += (Customer.City + ' - ' + Customer."Pin Code" + TextCons002);
        BodyText += (Customer."State Desc." + TextCons002);
        BodyText += (Customer.Contact + ' (M) ' + Customer."Phone No." + TextCons002 + TextCons002);
        BodyText += ('<b>Sub:- Balance Confirmation as on ' + FORMAT(dtAsOn) + ' ' + 'Recoverable Amount Rs. ' + FORMAT(decCustOutstndAmt) + TextCons002 + TextCons002 + '</b>');
        BodyText += ('Dear Sir/Madam,' + TextCons002);
        BodyText += ('We cherish our business relationship and thanking you for the patronage!' + TextCons002);
        BodyText += ('We wish you and your family a very Happy New Year!' + TextCons002 + TextCons002);
        BodyText += ('This is with respect to the Monthly/Quarterly requirement of balance confirmations. ' + TextCons002);
        BodyText += ('This is with respect to the requirement of quarterly/annualized requirement of balance confirmations. We request you to confirm the above stated recoverable amount from you as per our books of accounts' + TextCons002);
        BodyText += ('as on ' + FORMAT(dtAsOn) + '. In case of any variance, please provide us the details for the variance along with' + TextCons002);
        BodyText += ('a statement of our account in your books for reconciliation.' + TextCons002 + TextCons002);
        BodyText += ('ou may opt to mail the printout of this letter vide courier/post to our below stated auditors at mentioned address or email the letter in pdf/JPG ' + TextCons002);
        BodyText += ('format in reply to our original email to our office Id: <b>creditcontrol@orientbell.com</b>.' + TextCons002 + TextCons002);
        BodyText += ('Please also note that in case you do not reply within 10 days of receipt of this letter, the balance stated' + TextCons002);
        BodyText += ('above shall be assumed correct and final.' + TextCons002 + TextCons002);
        BodyText += ('<b>It’s further requested to please provide us all pending statutory forms, failing which tax liability </b>' + TextCons002);
        BodyText += ('<b>along with applicable interest/penalty shall become recoverable from you.</b>' + TextCons002 + TextCons002);
        BodyText += ('Your prompt compliance with this request will be highly appreciated!' + TextCons002 + TextCons002);
        BodyText += ('Please Make a note of our PAN <b>' + CompanyInformation."P.A.N. No." + '</b>' + TextCons002 + TextCons002);

        //SMTPMail.AppendBody('Post implementations of GST, all are requested to file the GSTR-I and deposit the GST within stipulated time on your bills (issued by you) so that we also get the '+TextCons002);
        //SMTPMail.AppendBody('proper credit and it will to fulfill statutory obligation. In case we unable to receive the GST credit thru GST portal said amount along with interest and penalty will be recovered from you.'+TextCons002+TextCons002);

        //SMTPMail.AppendBody('<u>Also, find enclosed here with details of pending C-forms up to 30.06.17. You are requested to immediately provide all the forms.</u>'+TextCons002+TextCons002);

        //SMTPMail.AppendBody('Your prompt compliance with this request will be appreciated.'+TextCons002+TextCons001+TextCons001);
        BodyText += ('<b>For Orient Bell Limited</b>' + TextCons002 + TextCons001 + TextCons001);
        BodyText += (TextCons004);
        BodyText += (TextCons003);
        BodyText += (TextCons006 + TextCons005);
        BodyText += (TextCons001 + TextCons001 + TextCons001 + '<b>C/C To,  Our AUDITORS</b>' + TextCons002);
        BodyText += (TextCons001 + TextCons001 + TextCons001 + '<b>M/S S.R. Dinodia and Co. LLP</b>' + TextCons002);
        BodyText += (TextCons001 + TextCons001 + TextCons001 + TextCons001 + TextCons001 + TextCons001 + '<b>Chartered Accountants</b>' + TextCons002);
        BodyText += (TextCons001 + TextCons001 + TextCons001 + TextCons001 + TextCons001 + TextCons001 + 'K-39, Connaught Place' + TextCons002);
        BodyText += (TextCons001 + TextCons001 + TextCons001 + TextCons001 + TextCons001 + TextCons001 + 'New Delhi - 110001' + TextCons002);
        BodyText += (TextCons007);
        BodyText += (TextCons003);
        BodyText += (TextCons004);

        // rSalesReceivablesSetup.GET;
        // rSalesReceivablesSetup.CALCFIELDS(Signature);
        // IF rSalesReceivablesSetup.Signature.HASVALUE THEN BEGIN
        //  TempBlob.INIT;
        //  TempBlob.Blob:=rSalesReceivablesSetup.Signature;
        //  TempBlob.INSERT;
        //  txtImageName := FileManagment.BLOBExport(TempBlob,'Signature.jpg',FALSE);
        // END;
        //BodyText+=('<IMG style="HEIGHT: 153px; WIDTH: 445px" src="file:///'+ txtImageName +'"'+ 'width="20%" height="2%">'+TextCons002);
        BodyText += ('<b>Amit Gupta</b>' + TextCons002 + TextCons001 + TextCons001 + TextCons001);
        BodyText += ('<b>(DGM - Sales Accounting & Credit Control)</b>' + TextCons002 + TextCons002);

        BodyText += (TextCons002 + TextCons002 + TextCons002 + TextCons002 + '<b>Please tick the appropriate Option</b>' + TextCons002);
        BodyText += ('1. The Balance of INR_______________ as of  ' + FORMAT(dtAsOn) + 'as per OBL books is correct.' + TextCons002);
        BodyText += ('2.           The above balance is not in agreement with our records which shows a balance of INR …………………………… (Debit/Credit) as on' + TextCons002);
        BodyText += (FORMAT(dtAsOn) + ' The statement of account is attached for reconciliation' + TextCons002);
        //SMTPMail.AppendBody('  Date………/………/2022'+TextCons002+TextCons002);
        BodyText += ('' + TextCons002);
        BodyText += ('Customer Name and Signatures under Firm’s rubber stamp…………………………………………….' + TextCons002);
        //SMTPMail.AppendBody('Name………………………………….   '+TextCons002);
        BodyText += ('Customer PAN……………………………………….       GST Number……………………………………….');


        // txtFileName := TEMPORARYPATH + Customer."No." + '.docx';
        rCustomer.RESET;
        rCustomer.SETRANGE("No.", Customer."No.");
        IF rCustomer.FIND('-') THEN BEGIN
            // REPORT.SAVEASWORD(50134,txtFileName,rCustomer);
            //rptCustmerBalances.SetSerialNumber(intCOunt);
            rptCustmerBalances.SetDate(dtAsOn, intCOunt);

            rptCustmerBalances.SETTABLEVIEW(rCustomer);
            // rptCustmerBalances.SAVEASWORD(txtFileName);
            EmailMsg.AddAttachment(txtFileName, rCustomer."No." + '.docx', InstreamVar);
            //16767 SMTPMail.AddAttachment(txtFileName,rCustomer."No."+'.docx');
            //16767 SMTPMail.Send;
            Email.Send(EmailMsg, Enum::"Email Scenario"::Default);

        END;

    end;
}

