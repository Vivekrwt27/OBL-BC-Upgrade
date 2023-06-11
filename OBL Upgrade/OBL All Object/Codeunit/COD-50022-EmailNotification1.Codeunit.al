codeunit 50022 "Email Notification1"
{

    trigger OnRun()
    var
        SIH: Record "Service Invoice Header";
        GenJnlLine: Record "Gen. Journal Line";
        Customer: Record Customer;
        AsOnDate: Date;
    begin
        //IndentHeader.RESET;

        //IndentHeader.SETRANGE(IndentHeader."No.",'IMIN\1415\0079');
        MailSendRejection(IndentHeader);
    end;

    var
        OutStandingAmt: Decimal;
        Customer: Record Customer;
        Statement: Codeunit "Post Auto Application";
        IndentHeader: Record "Indent Header";


    procedure MailSendRejection(IndentHeader: Record "Indent Header")
    var
        //     SMTPMailCodeunit: Codeunit 400;
        SrNo: Integer;
        RecCust: Record Customer;
        //    SMTPMailSetup: Record 409;
        CompInfo: Record "Company Information";
        Usersetup1: Record "User Setup";
        RecIndentHeader: Record "Indent Header";
        Usersetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        RecIndentHeader1: Record "Indent Header";
        RecIndentHeader2: Record "Indent Header";
        EmailTo: Text[150];
        EmailCC: Text[150];
        Text50002: Label 'sanuj.sharma@orientbell.com';
        Text50000: Label 'Indent Details :';
        Text50010: Label ' <br/> ';
        Text50011: Label 'Description :-  ';
        Text50012: Label 'Remarks :-  ';
        IndentDesc: Text[80];
        IndentRemarks: Text[80];
        Text50013: Label 'Reason:';

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

        RecIndentHeader1.RESET;
        RecIndentHeader1.SETRANGE("No.", IndentHeader."No.");
        IF RecIndentHeader1.FINDFIRST THEN BEGIN
            IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorization1 THEN BEGIN
                IF Usersetup1.GET(RecIndentHeader1."User ID") THEN
                    EmailTo := Usersetup1."E-Mail";

                RecIndentHeader1."Mail Authorization1" := TRUE;
                //  RecIndentHeader1.MODIFY;
            END;
            IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorization2 THEN BEGIN
                IF Usersetup1.GET(RecIndentHeader1."User ID") THEN
                    EmailTo := Usersetup1."E-Mail";

                IF Usersetup2.GET(RecIndentHeader1."Authorization 1") THEN
                    EmailCC := Usersetup2."E-Mail";
                //MESSAGE('%1',EmailTo);
                //MESSAGE('%1',EmailCC);
                RecIndentHeader1."Mail Authorization2" := TRUE;
                //    RecIndentHeader1.MODIFY;

            END;

            IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorization3 THEN BEGIN
                //MESSAGE('hello');
                IF Usersetup1.GET(RecIndentHeader1."Authorization 1") THEN
                    EmailCC := Usersetup1."E-Mail";
                IF Usersetup2.GET(RecIndentHeader1."User ID") THEN
                    EmailTo := Usersetup2."E-Mail";

                IF UserSetup3.GET(RecIndentHeader1."Authorization 2") THEN
                    //  EmailCC:=EmailCC+UserSetup3."E-Mail";
                    //MESSAGE('%1',EmailTo);
                    //MESSAGE('%1',EmailCC);


                    RecIndentHeader1."Mail Authorization3" := TRUE;
                //  RecIndentHeader1.MODIFY;
            END;
            IndentDesc := RecIndentHeader1.Description;
            IndentRemarks := RecIndentHeader1.Remarks;
        END;
        //EmailTo:='kulwant@mindshell.info';
        // EmailCC := 'Kulbhushan.Sharma@orientbell.com';

        /*    IF (EmailTo <> '') OR (EmailCC <> '') THEN BEGIN
                SMTPMailSetup.GET;
                SMTPMailSetup.TESTFIELD("User ID");
                SrNo := 1;
                CLEAR(SMTPMailCodeunit);
                SMTPMailCodeunit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
                EmailTo, 'Indent No ' + IndentHeader."No." + ' ' + IndentHeader.Description + ' Rejected', '', TRUE);

                SMTPMailCodeunit.AppendBody('Dear User,');
                SMTPMailCodeunit.AppendBody(Text50010);
                SMTPMailCodeunit.AppendBody(FORMAT(IndentHeader."No.") + ' has been Rejected.');
                SMTPMailCodeunit.AppendBody(Text50010);
                SMTPMailCodeunit.AppendBody(Text50010);
                SMTPMailCodeunit.AppendBody(Text50013);
                SMTPMailCodeunit.AppendBody(RecIndentHeader1."Reason of Rejection");
                SMTPMailCodeunit.AppendBody(Text50010);
                SMTPMailCodeunit.AppendBody(Text50010);
                SMTPMailCodeunit.AppendBody(Text50000);
                SMTPMailCodeunit.AppendBody(Text50010);
                SMTPMailCodeunit.AppendBody(Text50011);
                SMTPMailCodeunit.AppendBody(IndentDesc);
                SMTPMailCodeunit.AppendBody(Text50010);
                SMTPMailCodeunit.AppendBody(Text50012);
                SMTPMailCodeunit.AppendBody(IndentRemarks);

                IF EmailCC <> '' THEN
                    SMTPMailCodeunit.AddCC(EmailCC);

                SLEEP(3000);
                SMTPMailCodeunit.Send();
                SLEEP(1000);
                MESSAGE('Mail Sent For Rejection');
            END;*/ // 15578


        IF (EmailTo <> '') OR (EmailCC <> '') THEN BEGIN
            /* SMTPMailSetup.GET;
             SMTPMailSetup.TESTFIELD("User ID");
             SrNo := 1;
             CLEAR(SMTPMailCodeunit);
             SMTPMailCodeunit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
             EmailTo, 'Indent No ' + IndentHeader."No." + ' ' + IndentHeader.Description + ' Rejected', '', TRUE);*/
            EmailAddressList.Add('donotreply@orientbell.com');
            BodyText := 'Dear User,';
            BodyText += Text50010;
            BodyText += FORMAT(IndentHeader."No.") + ' has been Rejected.';
            BodyText += Text50010;
            BodyText += Text50010;
            BodyText += Text50013;
            BodyText += RecIndentHeader1."Reason of Rejection";
            BodyText += Text50010;
            BodyText += Text50010;
            BodyText += Text50000;
            BodyText += Text50010;
            BodyText += Text50011;
            BodyText += IndentDesc;
            BodyText += Text50010;
            BodyText += Text50012;
            BodyText += IndentRemarks;

            IF EmailCC <> '' THEN
                // EmailCCList.AddCC(EmailCC);
                EmailCCList.Add(EmailCC);

            SLEEP(3000);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
            SLEEP(1000);
            MESSAGE('Mail Sent For Rejection');
        END;
    end;
}

