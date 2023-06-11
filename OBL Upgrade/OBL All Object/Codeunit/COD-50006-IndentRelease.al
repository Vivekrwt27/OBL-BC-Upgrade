codeunit 50006 IndentRelease
{
    // //-- 1. Tri36.1 PG 14112006 -- New Code Added In "OnRun()" -- Stage Wise Auth. Date & Time

    Permissions = TableData "Approval Entry" = rm;
    TableNo = "Indent Header";

    trigger OnRun()
    begin


        IF rec.Hold = TRUE THEN
            ERROR('This is Indent is on Hold, Please Unhold for Authorization');

        IF (rec.Status <> rec.Status::Open) AND (rec."Mail Approval") THEN
            ERROR('Approval through Mail is required');

        IF rec.Status <> rec.Status::Authorized THEN BEGIN
            rec.TESTFIELD("Validity Period");
            rec.TESTFIELD("Validate Upto");

            IF rec."Indent Date" > 20180705D THEN
                rec.TESTFIELD("Created By");

            IF (COPYSTR((rec."No."), 1, 6) = 'INDCAP') THEN BEGIN
                IF (rec."Capex No." = '') THEN
                    ERROR('Pls mention the Capex No.');
            END;

            IndentLines.RESET;
            IndentLines.SETFILTER(IndentLines."Document No.", '%1', rec."No.");
            IF IndentLines.FIND('-') THEN BEGIN
                REPEAT
                    //MSAK.BEGIN 071213
                    IF COPYSTR(IndentLines."Document No.", 1, 4) = 'JRPL' THEN BEGIN
                        IF IndentLines.Type = IndentLines.Type::"Non Stock Item" THEN
                            IndentLines.TESTFIELD(IndentLines.Amount);
                    END;
                    IF rec."Indent Date" > 20180705D THEN
                        IF IndentLines.Type = IndentLines.Type::Item THEN
                            IndentLines.TESTFIELD(Amount);
                    //MSAK.END 071213
                    IF (IndentLines.Type = IndentLines.Type::Item) OR (IndentLines.Type = IndentLines.Type::"Non Stock Item") THEN
                        IndentLines.TESTFIELD(IndentLines.Quantity);
                    IF IndentLines.Type = IndentLines.Type::" " THEN BEGIN
                        IF (IndentLines."New Item" = TRUE) THEN BEGIN
                            //        ERROR('Type must be specify for Document No.=''%1'', Line No.=''%2.''',
                            //               IndentLines."Document No.",IndentLines."Line No.");
                        END;
                    END;
                UNTIL IndentLines.NEXT = 0;
            END ELSE BEGIN
                ERROR('There is nothing to release.');
            END;

            IF NOT (USERID IN [rec."User ID", rec."Authorization 1", rec."Authorization 2", rec."Authorization 3"]) THEN
                ERROR('You are not authorised');

            UserSetup.RESET;
            UserSetup.SETFILTER(UserSetup."User ID", '%1', rec."User ID");
            IF UserSetup.FIND('-') THEN BEGIN
                CASE rec.Status OF
                    rec.Status::Open:
                        IF UserSetup."User ID" = UPPERCASE(USERID) THEN
                            IF UserSetup."Authorization 1" <> '' THEN BEGIN //-- 1. Tri36.1 PG 14112006
                                rec.VALIDATE(Status, rec.Status::Authorization1);
                                rec.VALIDATE("Authorization 1 Date", TODAY); //-- 1. Tri36.1 PG 14112006
                                rec.VALIDATE("Authorization 1 Time", TIME);  //-- 1. Tri36.1 PG 14112006
                                rec.VALIDATE(Commented, FALSE);
                                rec.VALIDATE(Replied, FALSE);
                                // AutoRelease(Rec,1, UserSetup."Authorization 1");
                            END //-- 1. Tri36.1 PG 14112006
                            ELSE
                                IF UserSetup."Authorization 2" <> '' THEN BEGIN //-- 1. Tri36.1 PG 14112006
                                    rec.VALIDATE(Status, rec.Status::Authorization2);
                                    rec.VALIDATE("Authorization 2 Date", TODAY); //-- 1. Tri36.1 PG 14112006
                                    rec.VALIDATE("Authorization 2 Time", TIME);  //-- 1. Tri36.1 PG 14112006
                                    rec.VALIDATE(Commented, FALSE);
                                    rec.VALIDATE(Replied, FALSE);
                                    AutoRelease(Rec, 2, UserSetup."Authorization 2");
                                END  //-- 1. Tri36.1 PG 14112006
                                ELSE BEGIN //-- 1. Tri36.1 PG 14112006
                                    rec.VALIDATE(Status, rec.Status::Authorized);
                                    rec.VALIDATE("Authorization Date", TODAY); //-- 1. Tri36.1 PG 14112006
                                    rec.VALIDATE("Authorization Time", TIME);  //-- 1. Tri36.1 PG 14112006
                                    rec.VALIDATE(Commented, FALSE);
                                    rec.VALIDATE(Replied, FALSE);

                                END; //-- 1. Tri36.1 PG 14112006

                    rec.Status::Authorization1:
                        IF UserSetup."Authorization 1" = UPPERCASE(USERID) THEN
                            IF UserSetup."Authorization 2" <> '' THEN BEGIN //-- 1. Tri36.1 PG 14112006
                                rec.VALIDATE(Status, rec.Status::Authorization2);
                                rec.VALIDATE("Authorization 2 Date", TODAY); //-- 1. Tri36.1 PG 14112006
                                rec.VALIDATE("Authorization 2 Time", TIME);  //-- 1. Tri36.1 PG 14112006
                                rec.VALIDATE(Commented, FALSE);
                                rec.VALIDATE(Replied, FALSE);
                                AutoRelease(Rec, 1, UserSetup."Authorization 1");
                            END //-- 1. Tri36.1 PG 14112006
                            ELSE BEGIN //-- 1. Tri36.1 PG 14112006
                                rec.VALIDATE(Status, rec.Status::Authorized);
                                rec.VALIDATE("Authorization Date", TODAY); //-- 1. Tri36.1 PG 14112006
                                rec.VALIDATE("Authorization Time", TIME);  //-- 1. Tri36.1 PG 14112006
                                rec.VALIDATE(Commented, FALSE);
                                rec.VALIDATE(Replied, FALSE);

                            END; //-- 1. Tri36.1 PG 14112006



                    //MS-PB BEGIN For Third level Authorization
                    rec.Status::Authorization2:
                        IF UserSetup."Authorization 2" = UPPERCASE(USERID) THEN
                            IF UserSetup."Authorization 3" <> '' THEN BEGIN
                                rec.VALIDATE(Status, rec.Status::Authorization3);
                                rec.VALIDATE("Authorization 3 Date", TODAY);
                                rec.VALIDATE("Authorization 3 Time", TIME);

                                rec.VALIDATE(Commented, FALSE);
                                rec.VALIDATE(Replied, FALSE);
                                AutoRelease(Rec, 2, UserSetup."Authorization 2");
                            END
                            ELSE BEGIN
                                rec.VALIDATE(Status, rec.Status::Authorized);
                                rec.VALIDATE("Authorization Date", TODAY);
                                rec.VALIDATE("Authorization Time", TIME);
                                rec.VALIDATE(Commented, FALSE);
                                rec.VALIDATE(Replied, FALSE);

                            END;

                    rec.Status::Authorization3:
                        IF UserSetup."Authorization 3" = UPPERCASE(USERID) THEN BEGIN
                            rec.VALIDATE(Status, rec.Status::Authorized);
                            rec.VALIDATE("Authorization Date", TODAY);
                            rec.VALIDATE("Authorization Time", TIME);
                            rec.VALIDATE(Commented, FALSE);
                            rec.VALIDATE(Replied, FALSE);
                            AutoRelease(Rec, 3, UserSetup."Authorization 3");
                        END;

                    //MS-PB END For Third level;

                    rec.Status::Authorized:
                        BEGIN //-- 1. Tri36.1 PG 14112006
                            rec.VALIDATE(Status, rec.Status::Authorized);
                            rec.VALIDATE("Authorization Date", TODAY); //-- 1. Tri36.1 PG 14112006
                            rec.VALIDATE("Authorization Time", TIME);  //-- 1. Tri36.1 PG 14112006
                            rec.VALIDATE(Commented, FALSE);
                            rec.VALIDATE(Replied, FALSE);

                        END; //-- 1. Tri36.1 PG 14112006

                    rec.Status::Closed:
                        BEGIN //-- 1. Tri36.1 PG 14112006
                            rec.VALIDATE(Status, rec.Status::Closed);
                            rec.VALIDATE("Closed Date", TODAY); //-- 1. Tri36.1 PG 14112006
                            rec.VALIDATE("Closed Time", TIME);  //-- 1. Tri36.1 PG 14112006
                            rec.VALIDATE(Commented, FALSE);
                            rec.VALIDATE(Replied, FALSE);

                        END; //-- 1. Tri36.1 PG 14112006

                END;

            END;
        END;
        //sash 05 start
        IndentLine2.RESET;
        IndentLine2.SETRANGE(IndentLine2."Document No.", rec."No.");
        IndentLine2.SETFILTER(IndentLine2."No.", '<>%1', '');
        IF IndentLine2.FIND('-') THEN BEGIN
            REPEAT
                IF IndentLine2.Status <> IndentLine2.Status::Closed THEN BEGIN
                    IndentLine2.Status := rec.Status;
                    IndentLine2.MODIFY;
                END;
            UNTIL IndentLine2.NEXT = 0;
        END;
        // sash 05 end


        rec.MODIFY;

        //SendNotification(Rec);

        //MSAK.BEGIN 081213
        RecIndentHeader.RESET;
        RecIndentHeader.SETRANGE(Status, RecIndentHeader.Status::Authorization1);
        RecIndentHeader.SETRANGE("No.", rec."No.");
        RecIndentHeader.SETFILTER("Mail Authorization1", '%1', FALSE);
        IF RecIndentHeader.FINDFIRST THEN
            IF UserSetup1.GET(RecIndentHeader."Authorization 1") THEN
                IF UserSetup1."E-Mail" <> '' THEN
                    SendNotification(RecIndentHeader);
        RecIndentHeader1.RESET;
        RecIndentHeader1.SETRANGE(Status, RecIndentHeader1.Status::Authorization2);
        RecIndentHeader1.SETRANGE("No.", rec."No.");
        RecIndentHeader1.SETFILTER("Mail Authorization2", '%1', FALSE);
        IF RecIndentHeader1.FINDFIRST THEN
            IF UserSetup1.GET(RecIndentHeader1."Authorization 1") THEN
                IF UserSetup1."E-Mail" <> '' THEN
                    SendNotification(RecIndentHeader1);
        RecIndentHeader2.RESET;
        RecIndentHeader2.SETRANGE(Status, RecIndentHeader2.Status::Authorization3);
        RecIndentHeader2.SETRANGE("No.", rec."No.");
        RecIndentHeader2.SETFILTER("Mail Authorization3", '%1', FALSE);
        IF RecIndentHeader2.FINDFIRST THEN
            IF UserSetup1.GET(RecIndentHeader2."Authorization 1") THEN
                IF UserSetup1."E-Mail" <> '' THEN
                    SendNotification(RecIndentHeader2);
        RecIndentHeader3.RESET;
        RecIndentHeader3.SETRANGE(Status, RecIndentHeader3.Status::Authorized);
        RecIndentHeader3.SETRANGE("No.", rec."No.");
        RecIndentHeader3.SETFILTER("Mail Authorized", '%1', FALSE);
        IF RecIndentHeader3.FINDFIRST THEN
            IF UserSetup1.GET(RecIndentHeader3."User ID") THEN
                IF UserSetup1."E-Mail" <> '' THEN
                    SendNotificationtoAll(RecIndentHeader3);


        //MSSACHINS   280814
        /*RecIndentHeader.RESET;
        RecIndentHeader.SETRANGE(Status,RecIndentHeader.Status::Authorization1);
        RecIndentHeader.SETRANGE("No.","No.");
        RecIndentHeader.SETFILTER("Mail Authorization1",'%1',FALSE);
        IF RecIndentHeader.FINDFIRST THEN
        IF UserSetup1.GET(RecIndentHeader."Authorization 1") THEN
         IF UserSetup1."E-Mail" <> '' THEN
          SendNotification(RecIndentHeader);*/
        RecIndentHeader1.RESET;
        RecIndentHeader1.SETRANGE(Status, RecIndentHeader1.Status::Authorization2);
        RecIndentHeader1.SETRANGE("No.", rec."No.");
        RecIndentHeader1.SETFILTER("Mail Authorization2", '%1', FALSE);
        IF RecIndentHeader1.FINDFIRST THEN BEGIN
            IF UserSetup1.GET(RecIndentHeader."User ID") THEN
                IF UserSetup1."E-Mail" <> '' THEN
                    IF UserSetup1.GET(RecIndentHeader1."Authorization 1") THEN
                        IF UserSetup1."E-Mail" <> '' THEN
                            SendNotification(RecIndentHeader1);
        END;
        RecIndentHeader2.RESET;
        RecIndentHeader2.SETRANGE(Status, RecIndentHeader2.Status::Authorization3);
        RecIndentHeader2.SETRANGE("No.", rec."No.");
        RecIndentHeader2.SETFILTER("Mail Authorization3", '%1', FALSE);
        IF RecIndentHeader2.FINDFIRST THEN BEGIN
            IF UserSetup1.GET(RecIndentHeader."User ID") THEN
                IF UserSetup1."E-Mail" <> '' THEN
                    IF UserSetup1.GET(RecIndentHeader1."Authorization 1") THEN
                        IF UserSetup1."E-Mail" <> '' THEN
                            IF UserSetup1.GET(RecIndentHeader."Authorization 2") THEN
                                IF UserSetup1."E-Mail" <> '' THEN
                                    SendNotification(RecIndentHeader2);
        END;

        /*
      RecIndentHeader3.RESET;
      RecIndentHeader3.SETRANGE(Status,RecIndentHeader3.Status::Authorized);
      RecIndentHeader3.SETRANGE("No.","No.");
      RecIndentHeader3.SETFILTER("Mail Authorized",'%1',FALSE);
      IF RecIndentHeader3.FINDFIRST THEN
      IF UserSetup1.GET(RecIndentHeader3."User ID") THEN
       IF UserSetup1."E-Mail" <> '' THEN
         SendMail(RecIndentHeader3);

          */
        //MSSACHINS    280814

    end;

    var
        UserSetup: Record "User Setup";
        IndentLines: Record "Indent Line";
        RecIndentHeader: Record "Indent Header";
        RecIndentHeader1: Record "Indent Header";
        RecIndentHeader2: Record "Indent Header";
        RecIndentHeader3: Record "Indent Header";
        UserSetup1: Record "User Setup";
        IndentLine2: Record "Indent Line";
        SubJectLine: Text;
        UserSetup6: Record "User Setup";
        ApprovalMgt: Codeunit "QD Test, PDF Creation & Email";
        skdlpdate: Date;
        hsklpdate: Date;
        dralpdate: Date;
        qtychange: Decimal;
        rUser: Record User;


    /* procedure HTMLBody(FileName: Text[100]; RecIndentHeader: Record 50016): Text[1024]
     var
         Text50001: Label 'Please Check Information';
         Text50002: Label 'Please do not reply to this mail as it has been generated automatically, If you have any queries, Please contact the Purchase Department. ';
         Text50003: Label 'Dear Sir/Madam,';
         i: Integer;
         Text50004: Label 'The Indent Has been Authorized.';
         RecIndentHeader1: Record 50016;
      begin
          i := 1;
       //   "Var"[i] := Text50003 + '</B><BR>';
          RecIndentHeader1.RESET;
          RecIndentHeader1.SETRANGE("No.", RecIndentHeader."No.");
          IF RecIndentHeader1.FINDFIRST THEN
              IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorized THEN
                  "Var"[i + 1] := "Var"[i] + '<BR>' + Text50004 + FileName + '<B>' + '.<BR><BR><BR>'
              ELSE
                  "Var"[i + 1] := "Var"[i] + '<BR>' + Text50001 + FileName + '<B>' + '.<BR><BR><BR>';
          "Var"[i + 2] := "Var"[i + 1] + '<B>' + Text50002 + '<B>';
          EXIT("Var"[3]);
      end;*/ // 15578


    procedure AutoMail(var RecIndentHeader: Record "Indent Header")
    var
        Text50001: Label 'Indent No.- ';
        RecIndentHeader1: Record "Indent Header";
        RecUserSetup: Record "User Setup";
        Subject: Text[100];
        EmailTo: Text[1024];
        EmailCC: Text[1024];
        EmailBCC: Text[1024];
        CCMail: Text[1024];
        Text50002: Label 'erp@orientbell.com;';
    begin
        /*CLEAR(EmailTo);
        CLEAR(EmailCC);
        CLEAR(EmailBCC);
        CLEAR(CCMail);
        IF ISCLEAR(objApp) THEN CREATE(objApp);
          objMail := objApp.CreateItem(0);
          Subject:=' '+Text50001+' '+RecIndentHeader."No.";
          objMail.Subject(Subject);
        
          RecIndentHeader1.RESET;
          RecIndentHeader1.SETRANGE("No.",RecIndentHeader."No.");
          IF RecIndentHeader1.FINDFIRST THEN
           IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorization1 THEN BEGIN
            IF RecUserSetup.GET(RecIndentHeader1."Authorization 1") THEN
             EmailTo:=EmailTo+RecUserSetup."E-Mail"+';';
             CCMail:=Text50002;
             objMail.HTMLBody(HTMLBody(Subject,RecIndentHeader1));
             RecIndentHeader1."Mail Authorization1":=TRUE;
             RecIndentHeader1.MODIFY;
           END;
           IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorization2 THEN BEGIN
           IF RecUserSetup.GET(RecIndentHeader1."Authorization 2") THEN
            EmailTo:=EmailTo+RecUserSetup."E-Mail"+';';
            CCMail:=Text50002;
            objMail.HTMLBody(HTMLBody(Subject,RecIndentHeader1));
            RecIndentHeader1."Mail Authorization2":=TRUE;
            RecIndentHeader1.MODIFY;
           END;
           IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorization3 THEN BEGIN
           IF RecUserSetup.GET(RecIndentHeader1."Authorization 3") THEN
            EmailTo:=EmailTo+RecUserSetup."E-Mail"+';';
            CCMail:=Text50002;
            objMail.HTMLBody(HTMLBody(Subject,RecIndentHeader1));
            RecIndentHeader1."Mail Authorization3":=TRUE;
            RecIndentHeader1.MODIFY;
           END;
           IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorized THEN BEGIN
            IF RecUserSetup.GET(RecIndentHeader1."User ID") THEN
             EmailTo:=EmailTo+RecUserSetup."E-Mail"+';';
            IF RecUserSetup.GET(RecIndentHeader1."Authorization 1") THEN
             EmailBCC:=EmailBCC+RecUserSetup."E-Mail"+';';
            IF RecUserSetup.GET(RecIndentHeader1."Authorization 2") THEN
             EmailCC:=EmailCC+RecUserSetup."E-Mail"+';';
             CCMail:=EmailCC+EmailBCC+Text50002;
             objMail.HTMLBody(HTMLBody(Subject,RecIndentHeader1));
             RecIndentHeader1."Mail Authorized":=TRUE;
             RecIndentHeader1.MODIFY;
           END;
        
          objMail."To"(EmailTo);
          objMail.CC(CCMail);
          objMail.Display;
          objMail.Send();
        
             {EmailBCC:=EmailBCC+RecUserSetup."E-Mail";
            IF RecUserSetup.GET(RecIndentHeader1."Authorization 2") THEN
             EmailCC:=EmailCC+RecUserSetup."E-Mail";
             //CCMail:=EmailCC+EmailBCC+Text50002;
             //objMail.HTMLBody(HTMLBody(Subject,RecIndentHeader1));
             RecIndentHeader1."Mail Authorized":=TRUE;
             RecIndentHeader1.MODIFY;
           END;
        
         //IF ReSIH.FINDFIRST THEN BEGIN
          IF cLocation.GET(RecIndentHeader1."Location Code") THEN
          BEGIN
               IF RecIndentHeader1.Status <> RecIndentHeader1.Status::Authorized THEN
              IndentText:= ' requires your approval'
              ELSE
               IndentText:= ' has been Authorized';
               IndentDesc:= RecIndentHeader1.Description;
               IndentRemarks:= RecIndentHeader1.Remarks;}
         */

    end;


    procedure SendMail(RecIndentHeader: Record "Indent Header")
    var
        RecIndentHeader1: Record "Indent Header";
        // SMTPMailCodeUnit: Codeunit "400";
        Subject: Text[100];
        EmailTo: Text[1024];
        EmailCC: Text[1024];
        EmailBCC: Text[1024];
        CCMail: Text[1024];
        RecUserSetup: Record "User Setup";
        cLocation: Record Location;
        Text50002: Label 'sanuj.sharma@orientbell.com';
        Text50000: Label 'Indent Details :';
        Text50010: Label ' <br/> ';
        Text50011: Label 'Description :-  ';
        Text50012: Label 'Remarks :-  ';
        IndentText: Text[150];
        IndentDesc: Text[150];
        IndentRemarks: Text[150];
        EmailToName: Text[100];
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

        /*CLEAR(EmailTo);
        CLEAR(EmailCC);
        CLEAR(EmailBCC);*/ // 15578
        EmailToName := '';
        //CLEAR(CCMail);
        /*
        EmailBCC:=EmailBCC+RecUserSetup."E-Mail";
            IF RecUserSetup.GET(RecIndentHeader1."Authorization 2") THEN
             EmailCC:=EmailCC+RecUserSetup."E-Mail";
             //CCMail:=EmailCC+EmailBCC+Text50002;
             //objMail.HTMLBody(HTMLBody(Subject,RecIndentHeader1));
             RecIndentHeader1."Mail Authorized":=TRUE;
             RecIndentHeader1.MODIFY;
           END;
        
         //IF ReSIH.FINDFIRST THEN BEGIN
          IF cLocation.GET(RecIndentHeader1."Location Code") THEN
          BEGIN
               IF RecIndentHeader1.Status <> RecIndentHeader1.Status::Authorized THEN
              IndentText:= ' requires your approval'
              ELSE
               IndentText:= ' has been Authorized';
               IndentDesc:= RecIndentHeader1.Description;
               IndentRemarks:= RecIndentHeader1.Remarks;
                */

        //CLEAR(SMTPMailCodeUnit);

        RecIndentHeader1.RESET;
        RecIndentHeader1.SETRANGE("No.", RecIndentHeader."No.");
        IF RecIndentHeader1.FINDFIRST THEN
            IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorization1 THEN BEGIN
                IF RecUserSetup.GET(RecIndentHeader1."Authorization 1") THEN
                    EmailTo := RecUserSetup."E-Mail";

                /*cLogin.RESET;
                cLogin.SETRANGE(cLogin."User ID",RecUserSetup."User ID");
                IF cLogin.FIND('-') THEN
                   EmailToName:= cLogin.Name;*/
                IF RecUserSetup.GET(RecIndentHeader1."User ID") THEN
                    EmailCC := EmailCC + RecUserSetup."E-Mail";

                //CCMail:=Text50002;
                //objMail.HTMLBody(HTMLBody(Subject,RecIndentHeader1));
                RecIndentHeader1."Mail Authorization1" := TRUE;
                RecIndentHeader1.MODIFY;
            END;
        IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorization2 THEN BEGIN
            IF RecUserSetup.GET(RecIndentHeader1."Authorization 2") THEN
                EmailTo := RecUserSetup."E-Mail";

            IF RecUserSetup.GET(RecIndentHeader1."User ID") THEN
                EmailCC := EmailCC + RecUserSetup."E-Mail";
            IF RecUserSetup.GET(RecIndentHeader1."Authorization 1") THEN
                EmailBCC := EmailBCC + RecUserSetup."E-Mail";

            //objMail.HTMLBody(HTMLBody(Subject,RecIndentHeader1));
            RecIndentHeader1."Mail Authorization2" := TRUE;
            RecIndentHeader1.MODIFY;
        END;
        IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorization3 THEN BEGIN
            IF RecUserSetup.GET(RecIndentHeader1."Authorization 3") THEN
                EmailTo := RecUserSetup."E-Mail";

            IF RecUserSetup.GET(RecIndentHeader1."User ID") THEN
                EmailCC := EmailCC + RecUserSetup."E-Mail";

            IF RecUserSetup.GET(RecIndentHeader1."Authorization 2") THEN
                EmailBCC := EmailBCC + RecUserSetup."E-Mail";

            //objMail.HTMLBody(HTMLBody(Subject,RecIndentHeader1));
            RecIndentHeader1."Mail Authorization3" := TRUE;
            RecIndentHeader1.MODIFY;
        END;

        IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorized THEN BEGIN
            IF RecUserSetup.GET(RecIndentHeader1."User ID") THEN
                EmailTo := RecUserSetup."E-Mail";
            IF RecUserSetup.GET(RecIndentHeader1."Authorization 1") THEN
                EmailBCC := EmailBCC + RecUserSetup."E-Mail";
            IF RecUserSetup.GET(RecIndentHeader1."Authorization 2") THEN
                EmailCC := EmailCC + RecUserSetup."E-Mail";
            //CCMail:=EmailCC+EmailBCC+Text50002;
            //objMail.HTMLBody(HTMLBody(Subject,RecIndentHeader1));
            RecIndentHeader1."Mail Authorized" := TRUE;
            RecIndentHeader1.MODIFY;
        END;

        //IF ReSIH.FINDFIRST THEN BEGIN
        IF cLocation.GET(RecIndentHeader1."Location Code") THEN BEGIN
            IF RecIndentHeader1.Status <> RecIndentHeader1.Status::Authorized THEN
                IndentText := ' requires your approval'
            ELSE
                IndentText := ' has been Authorized';
            IndentDesc := RecIndentHeader1.Description;
            IndentRemarks := RecIndentHeader1.Remarks;

            //SalesInvHeader.CALCFIELDS("Amount to Customer","Qty In carton","Sq. Meter");
            /*  SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
              EmailTo, 'Indent :' + RecIndentHeader."No.", '', TRUE);
              SMTPMailCodeUnit.AddCC('donotreply@orientbell.com');//Kulbhushan*/ // 15578
                                                                                 // MESSAGE('%1',EmailTo);
                                                                                 // SMTPMailCodeUnit.AppendBody('Dear ' +EmailToName );
            EmailAddressList.Add('donotreply@orientbell.com');
            BodyText := 'Dear Sir, ';
            BodyText += Text50010;
            BodyText += FORMAT(RecIndentHeader."No.") + IndentText;
            BodyText += Text50010;
            BodyText += Text50010;
            BodyText += Text50000;
            BodyText += Text50010;
            BodyText += Text50011;
            BodyText += IndentDesc;
            BodyText += Text50010;
            BodyText += Text50012;
            BodyText += IndentRemarks;
            EmailMsg.Create(EmailAddressList, 'Indent :' + RecIndentHeader."No.", BodyText, true, EmailBccList, EmailCCList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
            MESSAGE('Mail Sent For Approval');
            /*
            IF EmailBCC<>'' THEN
            SMTPMailCodeUnit.AddCC(EmailCC);
            IF EmailBCC<>'' THEN
            SMTPMailCodeUnit.AddBCC(EmailBCC);
            */
            //SMTPMailCodeUnit.AppendBody(RecCustomer."PCH Name");
            //SMTPMailCodeUnit.AppendBody(Text50010);
            //SMTPMailCodeUnit.AppendBody(Text50010);
            //SMTPMailCodeUnit.AppendBody(Text50001);
            //SMTPMailCodeUnit.AppendBody(Text50002);
            ///  SMTPMailCodeUnit.Send();

            // PCHMailed:=TRUE;

        END;
        // else
        // Message('');
        // END;


    end;


    procedure SendMailRejection(RecIndentHeader: Record "Indent Header")
    var
        RecIndentHeader1: Record "Indent Header";
        //SMTPMailCodeUnit: Codeunit "400";
        Subject: Text[100];
        EmailTo: Text[500];
        EmailCC: Text[500];
        EmailBCC: Text[500];
        CCMail: Text[500];
        RecUserSetup: Record "User Setup";
        cLocation: Record Location;
        Text50002: Label 'sanuj.sharma@orientbell.com';
        Text50000: Label 'Indent Details :';
        Text50010: Label ' <br/> ';
        Text50011: Label 'Description :-  ';
        Text50012: Label 'Remarks :-  ';
        Text60003: Label '</TD>';
        Text60004: Label '</TR>';
        Text60005: Label '</Table>';
        Text60006: Label '</html>';
        Text60011: Label '<BR>';
        Text60012: Label '<B>';
        Text60013: Label '</B>';
        Text50041: Label '<TD  width=5 Align=Center>';
        Text50026: Label '<TR>';
        IndentText: Text[150];
        IndentDesc: Text[150];
        IndentRemarks: Text[150];
        EmailToName: Text[100];
        recApprovalEntry: Record "Approval Entry";
        Text50027: Label '<table border="1" width="70%">';
        Text50030: Label '<td width="20%">';
        CommentLine: Record "Comment Line";
        i: Integer;
        Comments: Text;
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

        // CLEAR(EmailTo);
        // CLEAR(EmailCC);
        // CLEAR(EmailBCC);
        EmailToName := '';
        //CLEAR(CCMail);

        //CLEAR(SMTPMailCodeUnit);

        RecIndentHeader1.RESET;
        RecIndentHeader1.SETRANGE("No.", RecIndentHeader."No.");
        IF RecIndentHeader1.FINDFIRST THEN BEGIN
            IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorization1 THEN BEGIN
                IF RecUserSetup.GET(RecIndentHeader."User ID") THEN
                    EmailTo := RecUserSetup."E-Mail";

                //CCMail:=Text50002;
                //objMail.HTMLBody(HTMLBody(Subject,RecIndentHeader1));
                RecIndentHeader1."Mail Authorization1" := TRUE;
                RecIndentHeader1.MODIFY;
            END ELSE
                IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorization2 THEN BEGIN
                    IF RecUserSetup.GET(RecIndentHeader."User ID") THEN
                        EmailTo := RecUserSetup."E-Mail";

                    IF RecUserSetup.GET(RecIndentHeader."Authorization 1") THEN
                        EmailCC := EmailCC + RecUserSetup."E-Mail";

                    //objMail.HTMLBody(HTMLBody(Subject,RecIndentHeader1));
                    RecIndentHeader1."Mail Authorization2" := TRUE;
                    RecIndentHeader1.MODIFY;
                END ELSE
                    IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorization3 THEN BEGIN
                        IF RecUserSetup.GET(RecIndentHeader."Authorization 1") THEN
                            EmailCC := EmailCC + RecUserSetup."E-Mail";

                        IF RecUserSetup.GET(RecIndentHeader1."User ID") THEN
                            EmailTo := EmailTo + RecUserSetup."E-Mail";

                        IF RecUserSetup.GET(RecIndentHeader1."Authorization 2") THEN
                            EmailCC := EmailCC + RecUserSetup."E-Mail";

                        //objMail.HTMLBody(HTMLBody(Subject,RecIndentHeader1));
                        RecIndentHeader1."Mail Authorization3" := TRUE;
                        RecIndentHeader1.MODIFY;
                    END;

            /*
               IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorized THEN BEGIN
                IF RecUserSetup.GET(RecIndentHeader1."User ID") THEN
                 EmailTo:=EmailTo+RecUserSetup."E-Mail";
                IF RecUserSetup.GET(RecIndentHeader1."Authorization 1") THEN
                 EmailBCC:=EmailBCC+RecUserSetup."E-Mail";
                IF RecUserSetup.GET(RecIndentHeader1."Authorization 2") THEN
                 EmailCC:=EmailCC+RecUserSetup."E-Mail";
                 //CCMail:=EmailCC+EmailBCC+Text50002;
                 //objMail.HTMLBody(HTMLBody(Subject,RecIndentHeader1));
                 RecIndentHeader1."Mail Authorized":=TRUE;
                 RecIndentHeader1.MODIFY;
               END;

            */

            /*
             //IF ReSIH.FINDFIRST THEN BEGIN
              IF cLocation.GET(RecIndentHeader1."Location Code") THEN
              BEGIN
                   IF RecIndentHeader1.Status <> RecIndentHeader1.Status::Authorized THEN
                  IndentText:= ' requires your approval'
                  ELSE
                   IndentText:= ' has been Authorized';
                   IndentDesc:= RecIndentHeader1.Description;
                   IndentRemarks:= RecIndentHeader1.Remarks;

            */
            //SalesInvHeader.CALCFIELDS("Amount to Customer","Qty In carton","Sq. Meter");
            /*  SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
              EmailTo, 'Rejection Mail' + RecIndentHeader."No.", '', TRUE);*/ // 15578
            EmailAddressList.Add('donotreply@orientbell.com');
            EmailBccList.add('donotreply@orientbell.com');
            // SMTPMailCodeUnit.AppendBody('Dear ' +EmailToName );
            BodyText := 'Dear Sir, ';
            BodyText += Text50010;
            BodyText += FORMAT(RecIndentHeader."No." + 'has been Rejected.');
            BodyText += Text50010;
            BodyText += Text50010;
            BodyText += Text50000;
            BodyText += Text50010;
            BodyText += Text50011;
            BodyText += IndentDesc;
            BodyText += Text50010;
            BodyText += Text50012;
            BodyText += IndentRemarks;
            BodyText += 'Remarks :-' + ' ' + RecIndentHeader.Remarks;
            BodyText += '<br>';

            CommentLine.RESET;
            CommentLine.SETRANGE(CommentLine."No.", RecIndentHeader."No.");
            IF CommentLine.FINDFIRST THEN BEGIN
                i := 1;
                REPEAT
                    Comments += CommentLine.Comment;
                UNTIL (CommentLine.NEXT = 0) OR (i = 2);
            END;
            BodyText += 'Indentor Comment:-' + ' ' + Comments;
            BodyText += '<br>';
            //Keshav16062020
            BodyText += 'Approver Comments:-';
            BodyText += '<br>';
            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text50027 + Text50026 + Text50030 + Text60012 + ' User Name' + Text60013 + Text60003;
            BodyText += Text50041 + Text60012 + 'Comments' + Text60013 + Text60003;
            //    BodyText +=Text50041+Text60012+'Status'+Text60013+Text60003);
            BodyText += Text60004;

            recApprovalEntry.RESET;
            recApprovalEntry.SETFILTER("Comment Text", '<>%1', '');
            recApprovalEntry.SETRANGE("Document No.", RecIndentHeader."No.");
            recApprovalEntry.SETRANGE("Table ID", 50016);
            recApprovalEntry.SETRANGE("Document Type", recApprovalEntry."Document Type"::Order);
            IF recApprovalEntry.FIND('-') THEN BEGIN
                REPEAT
                    rUser.RESET;
                    rUser.SETRANGE("User Name", recApprovalEntry."Approver ID");
                    IF rUser.FINDFIRST THEN;
                    BodyText += Text50026 + Text50041 + rUser."Full Name" + Text60003;
                    BodyText += Text50041 + FORMAT(recApprovalEntry."Comment Text") + Text60003;
                    //        BodyText +=Text50041+FORMAT(recApprovalEntry.Status+Text60003;
                    BodyText += Text60004;
                UNTIL recApprovalEntry.NEXT = 0;
            END;

            BodyText += Text60005;
            BodyText += Text60006;
            BodyText += Text60011;
            //Keshav16062020
            IF EmailCC <> '' THEN
                EmailCCList.add(EmailCC);
            //IF EmailBCC<>'' THEN
            //SMTPMailCodeUnit.AddBCC(EmailBCC);

            //SMTPMailCodeUnit.AppendBody(RecCustomer."PCH Name");
            //SMTPMailCodeUnit.AppendBody(Text50010);
            //SMTPMailCodeUnit.AppendBody(Text50010);
            //SMTPMailCodeUnit.AppendBody(Text50001);

            //SMTPMailCodeUnit.AppendBody(Text50002);

            //    //Keshav16062020
            //    SMTPMailCodeUnit.AppendBody(Text60005);
            //    SMTPMailCodeUnit.AppendBody(Text60006);
            //    SMTPMailCodeUnit.AppendBody(Text50041+Text60012+' User Name'+Text60013+Text60003);
            //    SMTPMailCodeUnit.AppendBody(Text50041+Text60012+'Comment Text'+Text60013+Text60003);
            //    SMTPMailCodeUnit.AppendBody(Text50041+Text60012+'Status'+Text60013+Text60003);
            //
            //    recApprovalEntry.RESET;
            //    recApprovalEntry.SETFILTER("Comment Text",'<>%1','');
            //    recApprovalEntry.SETRANGE("Document No.",RecIndentHeader."No.");
            //    recApprovalEntry.SETRANGE("Approval Code",'INDENT');
            //    IF recApprovalEntry.FIND('-') THEN BEGIN
            //      REPEAT
            //        SMTPMailCodeUnit.AppendBody(Text50026+Text50041+recApprovalEntry."Approver ID"+Text60003);
            //        SMTPMailCodeUnit.AppendBody(Text50041+FORMAT(recApprovalEntry."Comment Text")+Text60003);
            //        SMTPMailCodeUnit.AppendBody(Text50041+FORMAT(recApprovalEntry.Status)+Text60003);
            //      UNTIL recApprovalEntry.NEXT=0;
            //    END;
            //    SMTPMailCodeUnit.AppendBody(Text60004);
            //    SMTPMailCodeUnit.AppendBody(Text60005);
            //    SMTPMailCodeUnit.AppendBody(Text60006);
            //    SMTPMailCodeUnit.AppendBody(Text60011);
            //    //Keshav16062020

            // SMTPMailCodeUnit.Send();
            EmailMsg.Create(EmailAddressList, 'Rejection Mail' + RecIndentHeader."No.", BodyText, true, EmailBccList, EmailCCList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
            MESSAGE('Mail Sent For Rejection');
            // PCHMailed:=TRUE;

        END;
        // else
        // Message('');
        // END;

        /*
       //CLEAR(SMTPMailCodeUnit);
         // PCHMailed:=FALSE;
       CLEAR(SMTPMailCodeUnit);
       ReSIH.RESET;
       ReSIH.SETRANGE("No.",SalesInvHeader."No.");
       ReSIH.SETRANGE("PCH Mailed",FALSE);
       ReSIH.SETFILTER("Posting Date",'>=%1',022813D);
       IF ReSIH.FINDFIRST THEN BEGIN
         IF RecCustomer.GET(SalesInvHeader."Sell-to Customer No.") THEN
         BEGIN
          SalesInvHeader.CALCFIELDS("Amount to Customer","Qty In carton","Sq. Meter");
          SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.','donotreply@orientbell.com',
          RecCustomer."PCH E-Maill ID",'Sales Invocie','',TRUE);
          SMTPMailCodeUnit.AppendBody(Text50000);
          SMTPMailCodeUnit.AppendBody(RecCustomer."PCH Name");
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50001);
          SMTPMailCodeUnit.AppendBody(Text50002);
          SMTPMailCodeUnit.AppendBody(Text50011);
          SMTPMailCodeUnit.AppendBody(SalesInvHeader."Sell-to Customer No.");
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50012);
          SMTPMailCodeUnit.AppendBody(SalesInvHeader."Bill-to Name");
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50013);
          SMTPMailCodeUnit.AppendBody(FORMAT(SalesInvHeader."Amount to Customer"));
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50019);
          SMTPMailCodeUnit.AppendBody(FORMAT(SalesInvHeader."Order Date"));
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50020);
          SMTPMailCodeUnit.AppendBody(SalesInvHeader."Order No.");
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50014);
          SMTPMailCodeUnit.AppendBody(FORMAT(SalesInvHeader."Posting Date"));
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50015);
          SMTPMailCodeUnit.AppendBody(SalesInvHeader."No.");
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50016);
          SMTPMailCodeUnit.AppendBody(FORMAT(SalesInvHeader."Qty In carton"));
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50031);
          SMTPMailCodeUnit.AppendBody(FORMAT(SalesInvHeader."Sq. Meter"));
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50017);
          SMTPMailCodeUnit.AppendBody(SalesInvHeader."Transporter Name");
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50018);
          SMTPMailCodeUnit.AppendBody(SalesInvHeader."Truck No.");
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50010);
          SMTPMailCodeUnit.AppendBody(Text50004);
          SMTPMailCodeUnit.AppendBody(Text50005);
          SMTPMailCodeUnit.AppendBody(Text50006);
          SMTPMailCodeUnit.AppendBody(Text50007);
          SMTPMailCodeUnit.AppendBody(Text50008);
          SMTPMailCodeUnit.AppendBody(Text50009);
          SMTPMailCodeUnit.Send();
          MESSAGE('Mail Sent');
          PCHMailed:=TRUE;

         END;
       END ELSE BEGIN
         IF SalesInvHeader."Posting Date" <= 011713D THEN;

           MESSAGE('Already sent the mail to PCH Head');
       END;

       ReSIH.RESET;
       ReSIH.SETRANGE("No.",SalesInvHeader."No.");
       IF ReSIH.FINDFIRST THEN
       BEGIN
          ReSIH."PCH Mailed":=PCHMailed;
       //   ReSIH."Invoiced Mailed":=PCHMailed;
          ReSIH.MODIFY;
       END;
        */

    end;


    procedure SendNotification(IndentHeader: Record "Indent Header")///15578
    var
        //  SMTPMailCodeunit: Codeunit "400";
        SrNo: Integer;
        RecCust: Record Customer;
        // SMTPMailSetup: Record "409";
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
        IndentLine: Record "Indent Line";
        Email3: Text;
        UserSetup6: Record "User Setup";
        CommentLine: Record "Comment Line";
        I: Integer;
        Comments: Text;
        Amt: Decimal;
        EmailCC1: Text[150];
        IndentAppLink: Text[250];
        ShortLink: Text[250];
        LocFilter: Code[50];
        recApprovalEntry: Record "Approval Entry";
        Text50090: Label '<td width="20%" bgcolor="#80ff80"> ';
        Text50091: Label '<td width="50%" bgcolor="#80ff80"> ';
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

        RecIndentHeader1.RESET;
        RecIndentHeader1.SETRANGE("No.", IndentHeader."No.");
        IF RecIndentHeader1.FINDFIRST THEN BEGIN
            IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorization1 THEN BEGIN
                IF Usersetup1.GET(RecIndentHeader1."Authorization 1") THEN
                    EmailTo := Usersetup1."E-Mail";
            END;

            IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorization2 THEN BEGIN
                //IF Usersetup1.GET(RecIndentHeader1."User ID") THEN
                //   EmailTo:=Usersetup1."E-Mail";

                IF Usersetup2.GET(RecIndentHeader1."Authorization 2") THEN
                    EmailTo := Usersetup2."E-Mail";
            END;

            IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorization3 THEN BEGIN
                IF Usersetup1.GET(RecIndentHeader1."Authorization 3") THEN BEGIN
                    EmailTo := Usersetup1."E-Mail";
                    EmailCC1 := 'coo.office@orientbell.com';
                END;
            END;

            IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorized THEN BEGIN
                IF Usersetup1.GET(RecIndentHeader1."Authorization 3") THEN BEGIN
                    EmailCC := Usersetup1."E-Mail";
                    EmailCC1 := 'coo.office@orientbell.com';
                END;
                IF Usersetup2.GET(RecIndentHeader1."User ID") THEN
                    EmailTo := Usersetup2."E-Mail";

                IF UserSetup3.GET(RecIndentHeader1."Authorization 2") THEN
                    IF UserSetup3."E-Mail" <> '' THEN
                        Email3 := UserSetup3."E-Mail";
            END;

            IndentDesc := RecIndentHeader1.Description;
            IndentRemarks := RecIndentHeader1.Remarks;
        END;

        CommentLine.RESET;
        CommentLine.SETRANGE(CommentLine."No.", IndentHeader."No.");
        IF CommentLine.FINDFIRST THEN BEGIN
            I := 1;
            REPEAT
                Comments += CommentLine.Comment;
            UNTIL (CommentLine.NEXT = 0) OR (I = 2);
        END;
        IF (EmailTo <> '') OR (EmailCC <> '') THEN BEGIN
            //SMTPMailSetup.GET;
            //SMTPMailSetup.TESTFIELD("User ID");
            SrNo := 1;
            // CLEAR(SMTPMailCodeunit);
            EmailCCList.Add('donotreply@orientbell.com');
            EmailAddressList.Add(EmailTo);
            EmailAddressList.Add('donotreply@orientbell.com');
            //SMTPMailCodeunit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com', EmailTo, 'Indent No ' + IndentHeader."No." + ' ' + IndentHeader.Description + ' - ' + FORMAT(IndentHeader.Status), '', TRUE);



            //SMTPMailCodeunit.AddCC('donotreply@orientbell.com');//keshav10112020
            BodyText := ('Dear Sir,');
            BodyText += (Text50010);


            IndentHeader.CALCFIELDS(Amount);
            BodyText += ('<br><br>');
            BodyText += ('The Indent No. ' + FORMAT(IndentHeader."No.") + ' Amounting Rs. ' + FORMAT(ROUND(IndentHeader.Amount, 0.01, '=')) + ' has been raised for Your Approval, The Current Status of Indent is -' + FORMAT(IndentHeader.Status));
            BodyText += (' .The details of Indented Items are listed below:');
            BodyText += ('<br><br>');
            //Table Start
            BodyText += (Text60005);
            BodyText += (Text60006);
            BodyText += ('Created By:-' + ' ' + IndentHeader."Created By" + ',' + ' Location' + ' - ' + IndentHeader."Location Code");
            BodyText += (Text60006);
            BodyText += ('Remarks :-' + ' ' + IndentHeader.Remarks);
            BodyText += ('<br>');
            BodyText += ('Requisition Type' + ' ' + FORMAT(IndentHeader."Requition Type"));
            BodyText += ('<br>');
            BodyText += ('Indentor Comment :-' + ' ' + Comments);
            BodyText += ('<br>');
            //Keshav16062020
            BodyText += ('Approver Comments:-');
            BodyText += ('<br>');
            BodyText += (Text60005);
            BodyText += (Text60006);
            BodyText += (Text50027 + Text50026 + Text50030 + Text60012 + ' User Name' + Text60013 + Text60003);
            BodyText += (Text50041 + Text60012 + 'Comments' + Text60013 + Text60003);
            //    BodyText +=(Text50041+Text60012+'Status'+Text60013+Text60003);
            BodyText += (Text60004);

            recApprovalEntry.RESET;
            recApprovalEntry.SETFILTER("Comment Text", '<>%1', '');
            recApprovalEntry.SETRANGE("Document No.", IndentHeader."No.");
            recApprovalEntry.SETRANGE("Table ID", 50016);
            recApprovalEntry.SETRANGE("Document Type", recApprovalEntry."Document Type"::Order);
            IF recApprovalEntry.FIND('-') THEN BEGIN
                REPEAT
                    rUser.RESET;
                    rUser.SETRANGE("User Name", recApprovalEntry."Approver ID");
                    IF rUser.FINDFIRST THEN;
                    BodyText += (Text50026 + Text50041 + rUser."Full Name" + Text60003);
                    BodyText += (Text50041 + FORMAT(recApprovalEntry."Comment Text") + Text60003);
                    //        BodyText +=(Text50041+FORMAT(recApprovalEntry.Status)+Text60003);
                    BodyText += (Text60004);
                UNTIL recApprovalEntry.NEXT = 0;
            END;

            BodyText += (Text60005);
            BodyText += (Text60006);
            BodyText += (Text60011);
            //Keshav16062020

            BodyText += (Text50027 + Text50026 + Text50041 + Text60012 + 'S.No.' + Text60013 + Text60003);
            BodyText += (Text50030 + Text60012 + 'Item No.' + Text60013 + Text60003);
            BodyText += (Text50030 + Text60012 + 'Not To Executed' + Text60013 + Text60003);
            SrNo := 1;
            BodyText += (Text50030 + Text60012 + 'Description' + Text60013 + Text60003);
            BodyText += (Text50030 + Text60012 + 'Description 2' + Text60013 + Text60003);

            BodyText += (Text50030 + Text60012 + 'Quantity' + Text60013 + Text60003);
            BodyText += (Text50041 + Text60012 + 'Rate' + Text60013 + Text60003);
            BodyText += (Text50041 + Text60012 + ' Amount' + Text60013 + Text60003);
            BodyText += (Text50041 + Text60012 + ' Stock' + Text60013 + Text60003);
            BodyText += (Text50041 + Text60012 + ' Cons.( 4Months)' + Text60013 + Text60003);
            BodyText += (Text50041 + Text60012 + ' Cons.(12Months)' + Text60013 + Text60003);
            BodyText += (Text60004);
            IndentLine.SETRANGE("Document No.", IndentHeader."No.");
            IF IndentLine.FINDFIRST THEN BEGIN
                LocFilter := GetMainStore(IndentHeader."Created By");
                REPEAT
                    BodyText += (Text50026 + Text50041 + FORMAT(SrNo) + Text60003);
                    BodyText += (Text50041 + FORMAT(IndentLine."No.") + Text60003);
                    BodyText += (Text50041 + FORMAT(IndentLine.Deleted) + Text60003);
                    BodyText += (Text50041 + FORMAT(IndentLine.Description) + Text60003);
                    BodyText += (Text50041 + FORMAT(IndentLine."Description 2") + Text60003);
                    BodyText += (Text50041 + FORMAT(IndentLine.Quantity) + Text60003);
                    BodyText += (Text50041 + FORMAT(ROUND(IndentLine.Rate, 0.01, '=')) + Text60003);
                    BodyText += (Text50041 + FORMAT(ROUND(IndentLine.Amount, 0.01, '=')) + Text60003);

                    BodyText += (Text50090 + FORMAT(ROUND(CalculateMainLocationStock(IndentLine."No.", IndentHeader."Location Code"), 0.01, '=')) + Text60003);
                    BodyText += (Text50041 + FORMAT(ROUND(CalculateConsumption(IndentLine."No.", IndentHeader."Location Code", 121), 0.01, '=')) + Text60003);
                    BodyText += (Text50041 + FORMAT(ROUND(CalculateConsumption(IndentLine."No.", IndentHeader."Location Code", 365), 0.01, '=')) + Text60003);
                    BodyText += (Text60004);
                    SrNo += 1;
                    Amt += ROUND(IndentLine.Amount, 0.01, '=');
                UNTIL IndentLine.NEXT = 0;
            END;
            //
            //MSKS
            BodyText += (Text50026 + Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('Total') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT(Amt) + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text60004);
            //MSKS
            BodyText += (Text60004);

            BodyText += (Text60005);

            BodyText += (Text60006);
            BodyText += (Text60011);

            //Table End
            //  BodyText +=(Comments);

            BodyText += (Text60011);

            BodyText += ('Yours Truly, <br>');


            BodyText += ('For Orient Bell Limited  <br>');
            IF UserSetup6.GET(USERID) THEN
                BodyText += (FORMAT(UserSetup6."User Name") + '<br>');

            //SMTPMailCodeunit.AppendBody(ApprovalMgt.getApprovalLink(50016,IndentHeader."No.",0)); //MSVRN 230818 //Old code
            //MSVRN 230818 //New code >>
            IF IndentHeader."Indent Date" > 20180208D THEN BEGIN
                IndentAppLink := '';
                IndentAppLink := ApprovalMgt.getApprovalLink(50016, IndentHeader."No.", 0);
                ShortLink := '<a href="' + IndentAppLink + '">Indent Approve/Reject</a>';
                BodyText += (ShortLink);
            END;
            //MSVRN 230818 <<

            IF EmailCC <> '' THEN
                EmailCCList.Add(EmailCC);
            IF EmailCC1 <> '' THEN
                EmailCCList.Add(EmailCC1); //MSKS2310
                                           //SMTPMailCodeunit.AddBCC('kulwant@mindshell.info');
            IF Email3 <> '' THEN
                EmailCCList.Add(Email3);
            //SMTPMailCodeunit.AddCC('kulwant@mindshell.info');
            //SMTPMailCodeunit.AddCC('virendra.kumar@mindshell.info');
            SLEEP(3000);
            //SMTPMailCodeunit.Send();
            EmailMsg.Create(EmailAddressList, 'Indent No' + IndentHeader."No." + ' ' + IndentHeader.Description + ' - ' + FORMAT(IndentHeader.Status), BodyText, true, EmailCCList, EmailBccList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
            SLEEP(1000);
            IF GUIALLOWED THEN
                MESSAGE('Mail Sent!');
        END;
    end;


    procedure SendNotificationHold(IndentHeader: Record "Indent Header")
    var
        //SMTPMailCodeunit: Codeunit "400";
        SrNo: Integer;
        RecCust: Record Customer;
        // SMTPMailSetup: Record 409;
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
        IndentLine: Record "Indent Line";
        Amt: Decimal;
    begin
        IF NOT IndentHeader.Hold THEN
            EXIT;

        RecIndentHeader1.RESET;
        RecIndentHeader1.SETRANGE("No.", IndentHeader."No.");
        IF RecIndentHeader1.FINDFIRST THEN BEGIN
            IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorization1 THEN BEGIN
                IF Usersetup1.GET(RecIndentHeader1."User ID") THEN
                    EmailTo := Usersetup1."E-Mail";
            END;

            IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorization2 THEN BEGIN

                IF Usersetup2.GET(RecIndentHeader1."Authorization 1") THEN
                    EmailTo := Usersetup2."E-Mail";
            END;

            IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorization3 THEN BEGIN
                IF Usersetup1.GET(RecIndentHeader1."Authorization 2") THEN
                    EmailTo := Usersetup1."E-Mail";

            END;
            IndentDesc := RecIndentHeader1.Description;
            IndentRemarks := RecIndentHeader1.Remarks;
        END;

        IndentHeader.CALCFIELDS(Amount);
        /*   SMTPMailCodeunit.AppendBody('<br><br>');
           SMTPMailCodeunit.AppendBody('The Indent No. ' + FORMAT(IndentHeader."No.") + ' amounting Rs. ' + FORMAT(IndentHeader.Amount) + ' has been ' + SubJectLine + ', New Status of the Indent is -' + FORMAT(IndentHeader.Status));
           SMTPMailCodeunit.AppendBody(' .The details of Indented Items are listed below:');
           SMTPMailCodeunit.AppendBody('<br><br>');
           //Table Start
           SMTPMailCodeunit.AppendBody(Text60005);
           SMTPMailCodeunit.AppendBody(Text60006);
           SMTPMailCodeunit.AppendBody(Text60011);
           SMTPMailCodeunit.AppendBody(Text50027 + Text50026 + Text50041 + Text60012 + 'S.No.' + Text60013 + Text60003);
           SMTPMailCodeunit.AppendBody(Text50030 + Text60012 + 'Item No.' + Text60013 + Text60003);
           SrNo := 1;
           SMTPMailCodeunit.AppendBody(Text50030 + Text60012 + 'Description' + Text60013 + Text60003);
           SMTPMailCodeunit.AppendBody(Text50030 + Text60012 + 'Description 2' + Text60013 + Text60003);
           SMTPMailCodeunit.AppendBody(Text50030 + Text60012 + 'Quantity' + Text60013 + Text60003);
           SMTPMailCodeunit.AppendBody(Text50041 + Text60012 + 'Rate' + Text60013 + Text60003);
           SMTPMailCodeunit.AppendBody(Text50041 + Text60012 + ' Amount' + Text60013 + Text60003);
           SMTPMailCodeunit.AppendBody(Text60004);
           IndentLine.SETRANGE("Document No.", IndentHeader."No.");
           IF IndentLine.FINDFIRST THEN BEGIN
               REPEAT
                   SMTPMailCodeunit.AppendBody(Text50026 + Text50041 + FORMAT(SrNo) + Text60003);
                   SMTPMailCodeunit.AppendBody(Text50041 + FORMAT(IndentLine."No.") + Text60003);
                   SMTPMailCodeunit.AppendBody(Text50041 + FORMAT(IndentLine.Description) + Text60003);
                   SMTPMailCodeunit.AppendBody(Text50041 + FORMAT(IndentLine."Description 2") + Text60003);
                   SMTPMailCodeunit.AppendBody(Text50041 + FORMAT(IndentLine.Quantity) + Text60003);
                   SMTPMailCodeunit.AppendBody(Text50041 + FORMAT(IndentLine.Rate) + Text60003);
                   SMTPMailCodeunit.AppendBody(Text50041 + FORMAT(IndentLine.Amount) + Text60003);
                   SMTPMailCodeunit.AppendBody(Text60004);
                   SrNo += 1;
                   Amt += IndentLine.Amount;
               UNTIL IndentLine.NEXT = 0;
           END;
           //
           //MSKS
           SMTPMailCodeunit.AppendBody(Text50026 + Text50041 + FORMAT('') + Text60003);
           SMTPMailCodeunit.AppendBody(Text50041 + FORMAT('') + Text60003);
           SMTPMailCodeunit.AppendBody(Text50041 + FORMAT('') + Text60003);
           SMTPMailCodeunit.AppendBody(Text50041 + FORMAT('') + Text60003);
           SMTPMailCodeunit.AppendBody(Text50041 + FORMAT('') + Text60003);
           SMTPMailCodeunit.AppendBody(Text50041 + FORMAT('') + Text60003);
           SMTPMailCodeunit.AppendBody(Text50041 + FORMAT(Amt) + Text60003);
           SMTPMailCodeunit.AppendBody(Text60004);
           //MSKS

           SMTPMailCodeunit.AppendBody(Text60004);

           SMTPMailCodeunit.AppendBody(Text60005);

           SMTPMailCodeunit.AppendBody(Text60006);
           SMTPMailCodeunit.AppendBody(Text60011);

           //Table End


           SMTPMailCodeunit.AppendBody(Text60011);


           SMTPMailCodeunit.AppendBody('Yours Truly, <br>');

           SMTPMailCodeunit.AppendBody('For Orient Bell Limited  <br>');
           IF UserSetup6.GET(USERID) THEN
               SMTPMailCodeunit.AppendBody(FORMAT(UserSetup6."User Name") + '<br>');




           IF EmailCC <> '' THEN
               SMTPMailCodeunit.AddCC(EmailCC);

           SLEEP(3000);
           SMTPMailCodeunit.Send();
           SLEEP(1000);
           MESSAGE('Mail Sent!');
       END;*/ // 15578

    end;


    procedure SendNotificationtoAll(IndentHeader: Record "Indent Header")
    var
        //SMTPMailCodeunit: Codeunit "400";
        SrNo: Integer;
        RecCust: Record Customer;
        //SMTPMailSetup: Record "409";
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
        IndentLine: Record "Indent Line";
        Email3: Text;
        UserSetup6: Record "User Setup";
        CommentLine: Record "Comment Line";
        I: Integer;
        Comments: Text;
        PlantHeadEmail: Text;
        Amt: Decimal;
        EmailCC1: Text[150];
        PlantHeadEmail1: Text;
        recApprovalEntry: Record "Approval Entry";
        PlantHeadEmail2: Text;
        PlantHeadEmail3: Text;
        PlantHeadEmail4: Text;
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
                IF Usersetup1.GET(RecIndentHeader1."Authorization 1") THEN
                    EmailTo := Usersetup1."E-Mail";
            END;

            IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorization2 THEN BEGIN
                //IF Usersetup1.GET(RecIndentHeader1."User ID") THEN
                //   EmailTo:=Usersetup1."E-Mail";

                IF Usersetup2.GET(RecIndentHeader1."Authorization 2") THEN
                    EmailTo := Usersetup2."E-Mail";
            END;

            IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorization3 THEN BEGIN
                IF Usersetup1.GET(RecIndentHeader1."Authorization 3") THEN BEGIN
                    EmailTo := Usersetup1."E-Mail";
                    EmailCC1 := 'coo.office@orientbell.com';
                END;
                /*
                IF Usersetup2.GET(RecIndentHeader1."User ID") THEN
                   EmailTo:=Usersetup2."E-Mail";

                IF UserSetup3.GET(RecIndentHeader1."Authorization 2") THEN
                  RecIndentHeader1."Mail Authorization3":=TRUE;
                //  RecIndentHeader1.MODIFY;
                */
            END;
            IF RecIndentHeader1.Status = RecIndentHeader1.Status::Authorized THEN BEGIN
                IF Usersetup1.GET(RecIndentHeader1."Authorization 3") THEN
                    EmailCC := Usersetup1."E-Mail";

                IF Usersetup2.GET(RecIndentHeader1."User ID") THEN
                    EmailTo := Usersetup2."E-Mail";

                IF UserSetup3.GET(RecIndentHeader1."Authorization 2") THEN
                    IF UserSetup3."E-Mail" <> '' THEN
                        Email3 := UserSetup3."E-Mail";
            END;

            IndentDesc := RecIndentHeader1.Description;
            IndentRemarks := RecIndentHeader1.Remarks;
        END;
        // EmailTo:='kulwant@mindshell.info';
        // EmailCC := 'erp@orientbell.com';
        //  EmailCC :='';

        CommentLine.RESET;
        CommentLine.SETRANGE(CommentLine."No.", IndentHeader."No.");
        IF CommentLine.FINDFIRST THEN BEGIN
            I := 1;
            REPEAT
                Comments += CommentLine.Comment;
            UNTIL (CommentLine.NEXT = 0) OR (I = 2);
        END;
        IF (EmailTo <> '') OR (EmailCC <> '') THEN BEGIN
            // SMTPMailSetup.GET;
            //SMTPMailSetup.TESTFIELD("User ID");
            SrNo := 1;
            // CLEAR(SMTPMailCodeunit);
            // SMTPMailCodeunit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',EmailTo, 'Indent No ' + IndentHeader."No." + ' ' + IndentHeader.Description + ' - ' + FORMAT(IndentHeader.Status), '', TRUE);
            EmailAddressList.Add(EmailTo);
            EmailCCList.add('donotreply@orientbell.com');
            BodyText := ('Dear User,');
            BodyText += (Text50010);

            IndentHeader.CALCFIELDS(Amount);
            BodyText += ('<br><br>');
            BodyText += ('The Indent No. ' + FORMAT(IndentHeader."No.") + ' amounting Rs. ' + FORMAT(IndentHeader.Amount) + ' has been Approved, The Current Satus of Indent is -' + FORMAT(IndentHeader.Status));
            BodyText += (' .The details of Indented Items are listed below:');
            BodyText += ('<br><br>');
            BodyText += ('Indetor Comments :-' + ' ' + Comments);
            BodyText += ('<br>');

            //Keshav16062020
            BodyText += ('Approver Comments:-');
            BodyText += ('<br>');
            BodyText += (Text60005);
            BodyText += (Text60006);
            BodyText += (Text50027 + Text50026 + Text50030 + Text60012 + ' User Name' + Text60013 + Text60003);
            BodyText += (Text50041 + Text60012 + 'Comments' + Text60013 + Text60003);
            //    BodyText +=(Text50041+Text60012+'Status'+Text60013+Text60003);
            BodyText += (Text60004);

            recApprovalEntry.RESET;
            recApprovalEntry.SETFILTER("Comment Text", '<>%1', '');
            recApprovalEntry.SETRANGE("Document No.", IndentHeader."No.");
            recApprovalEntry.SETRANGE("Table ID", 50016);
            recApprovalEntry.SETRANGE("Document Type", recApprovalEntry."Document Type"::Order);
            IF recApprovalEntry.FIND('-') THEN BEGIN
                REPEAT
                    rUser.RESET;
                    rUser.SETRANGE("User Name", recApprovalEntry."Approver ID");
                    IF rUser.FINDFIRST THEN;
                    BodyText += (Text50026 + Text50041 + rUser."Full Name" + Text60003);
                    BodyText += (Text50041 + FORMAT(recApprovalEntry."Comment Text") + Text60003);
                    //        BodyText +=(Text50041+FORMAT(recApprovalEntry.Status)+Text60003);
                    BodyText += (Text60004);
                UNTIL recApprovalEntry.NEXT = 0;
            END;

            BodyText += (Text60005);
            BodyText += (Text60006);
            BodyText += (Text60011);
            //Keshav16062020
            //Table Start
            BodyText += (Text60005);
            BodyText += (Text60006);
            BodyText += (Text60011);
            BodyText += (Text50027 + Text50026 + Text50041 + Text60012 + 'S.No.' + Text60013 + Text60003);
            BodyText += (Text50030 + Text60012 + 'Item No.' + Text60013 + Text60003);
            SrNo := 1;
            BodyText += (Text50030 + Text60012 + 'Description' + Text60013 + Text60003);
            BodyText += (Text50030 + Text60012 + 'Description 2' + Text60013 + Text60003);
            BodyText += (Text50030 + Text60012 + 'Quantity' + Text60013 + Text60003);
            BodyText += (Text50041 + Text60012 + 'Rate' + Text60013 + Text60003);
            BodyText += (Text50041 + Text60012 + ' Amount' + Text60013 + Text60003);
            BodyText += (Text60004);
            IndentLine.SETRANGE("Document No.", IndentHeader."No.");
            IF IndentLine.FINDFIRST THEN BEGIN
                REPEAT
                    BodyText += (Text50026 + Text50041 + FORMAT(SrNo) + Text60003);
                    BodyText += (Text50041 + FORMAT(IndentLine."No.") + Text60003);
                    BodyText += (Text50041 + FORMAT(IndentLine.Description) + Text60003);
                    BodyText += (Text50041 + FORMAT(IndentLine."Description 2") + Text60003);
                    BodyText += (Text50041 + FORMAT(IndentLine.Quantity) + Text60003);
                    BodyText += (Text50041 + FORMAT(IndentLine.Rate) + Text60003);
                    BodyText += (Text50041 + FORMAT(IndentLine.Amount) + Text60003);
                    BodyText += (Text60004);
                    SrNo += 1;
                    Amt += IndentLine.Amount;
                UNTIL IndentLine.NEXT = 0;
            END;
            //
            //MSKS
            BodyText += (Text50026 + Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT(Amt) + Text60003);
            BodyText += (Text60004);
            //MSKS

            BodyText += (Text60004);

            BodyText += (Text60005);

            BodyText += (Text60006);
            BodyText += (Text60011);

            //Table End
            BodyText += (Comments);

            BodyText += (Text60011);

            //  //Keshav16062020
            //  SMTPMailCodeunit.AppendBody(Text60005);
            //  SMTPMailCodeunit.AppendBody(Text60006);
            //  SMTPMailCodeunit.AppendBody(Text50041+Text60012+' User Name'+Text60013+Text60003);
            //  SMTPMailCodeunit.AppendBody(Text50041+Text60012+'Comment Text'+Text60013+Text60003);
            //  SMTPMailCodeunit.AppendBody(Text50041+Text60012+'Status'+Text60013+Text60003);
            //  SMTPMailCodeunit.AppendBody(Text60004);
            //  recApprovalEntry.RESET;
            //  recApprovalEntry.SETFILTER("Comment Text",'<>%1','');
            //  recApprovalEntry.SETRANGE("Document No.",IndentLine."Document No.");
            //  recApprovalEntry.SETRANGE("Approval Code",'INDENT');
            //  IF recApprovalEntry.FIND('-') THEN BEGIN
            //    REPEAT
            //      SMTPMailCodeunit.AppendBody(Text50026+Text50041+recApprovalEntry."Approver ID"+Text60003);
            //      SMTPMailCodeunit.AppendBody(Text50041+FORMAT(recApprovalEntry."Comment Text")+Text60003);
            //      SMTPMailCodeunit.AppendBody(Text50041+FORMAT(recApprovalEntry.Status)+Text60003);
            //      SMTPMailCodeunit.AppendBody(Text60004);
            //    UNTIL recApprovalEntry.NEXT=0;
            //  END;
            //  SMTPMailCodeunit.AppendBody(Text60004);
            //  SMTPMailCodeunit.AppendBody(Text60005);
            //  SMTPMailCodeunit.AppendBody(Text60006);
            //  SMTPMailCodeunit.AppendBody(Text60011);
            //  //Keshav16062020


            BodyText += ('Yours Truly, <br>');


            BodyText += ('For Orient Bell Limited  <br>');
            IF UserSetup6.GET(USERID) THEN
                BodyText += (FORMAT(UserSetup6."User Name") + '<br>');


            IF EmailCC <> '' THEN
                EmailCCList.add(EmailCC);

            IF Email3 <> '' THEN
                EmailCCList.add(Email3);

            IF EmailCC1 <> '' THEN
                EmailCCList.add(EmailCC1);

            PlantHeadEmail := '';
            PlantHeadEmail1 := '';
            PlantHeadEmail2 := '';
            PlantHeadEmail3 := '';
            PlantHeadEmail4 := '';

            CASE IndentHeader."Location Code" OF
                'SKD-STORE':
                    BEGIN
                        PlantHeadEmail := 'ak.sharma@orientbell.com';
                        PlantHeadEmail2 := 'sanjeev.gupta@orientbell.com';
                    END;
                'HEADOFFICE':
                    BEGIN
                        PlantHeadEmail := 'ak.sharma@orientbell.com';
                        PlantHeadEmail1 := 'shubham.jain@orientbell.com';
                    END;
                'DRA-STORE':
                    BEGIN
                        PlantHeadEmail := 'sandeep.kedia@orientbell.com';
                        PlantHeadEmail3 := 'sanjay.maheshwari@orientbell.com';
                    END;
                'HSK-STORE':
                    BEGIN
                        PlantHeadEmail := 'g.vaidyanathan@orientbell.com';
                        PlantHeadEmail4 := 'jagdish.pal@orientbell.com';
                    END;
            END;

            IF PlantHeadEmail <> '' THEN
                EmailCCList.add(PlantHeadEmail);
            IF PlantHeadEmail1 <> '' THEN
                EmailCCList.add(PlantHeadEmail1);
            IF PlantHeadEmail2 <> '' THEN
                EmailCCList.add(PlantHeadEmail2);
            IF PlantHeadEmail3 <> '' THEN
                EmailCCList.add(PlantHeadEmail3);
            IF PlantHeadEmail4 <> '' THEN
                EmailCCList.add(PlantHeadEmail4);

            EmailMsg.Create(EmailAddressList, 'Indent No ' + IndentHeader."No." + ' ' + IndentHeader.Description + ' - ' + FORMAT(IndentHeader.Status), BodyText, true, EmailCCList, EmailBccList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);

            SLEEP(500);
            //SMTPMailCodeunit.Send();
            SLEEP(1500);
            //MESSAGE('Mail Sent!');
        END;

    end;


    procedure AutoRelease(var IndentHeader: Record "Indent Header"; Level: Integer; VarUserID: Code[50]) AutoRel: Boolean
    var
        UserSetup: Record "User Setup";
    begin
        //IF NOT IndentHeader."Job Indent" THEN
        //  EXIT;
        IF Level = 0 THEN
            EXIT;
        IndentHeader.CALCFIELDS(Amount);
        UserSetup.GET(VarUserID);
        IF (IndentHeader.Amount <= UserSetup."Indent Limit") AND (UserSetup."Indent Limit" <> 0) THEN BEGIN
            AutoRel := TRUE;
            IndentHeader.VALIDATE(Status, IndentHeader.Status::Authorized);
            IndentHeader.VALIDATE("Authorization Date", TODAY);
            IndentHeader.VALIDATE("Authorization Time", TIME);
            IndentHeader.VALIDATE(Commented, FALSE);
            IndentHeader.VALIDATE(Replied, FALSE);
            IF Level = 1 THEN BEGIN
                AutoApproveAppEntries(IndentHeader."No.", IndentHeader."Authorization 1");
                AutoApproveAppEntries(IndentHeader."No.", IndentHeader."Authorization 2");
                AutoApproveAppEntries(IndentHeader."No.", IndentHeader."Authorization 3");
                IndentHeader.VALIDATE("Authorization 1", '');
                IndentHeader.VALIDATE("Authorization 2", '');
                IndentHeader.VALIDATE("Authorization 3", '');
            END;
            IF Level = 2 THEN BEGIN
                AutoApproveAppEntries(IndentHeader."No.", IndentHeader."Authorization 2");
                AutoApproveAppEntries(IndentHeader."No.", IndentHeader."Authorization 3");
                IndentHeader.VALIDATE("Authorization 2", '');
                IndentHeader.VALIDATE("Authorization 3", '');
            END;
            IF Level = 3 THEN BEGIN
                AutoApproveAppEntries(IndentHeader."No.", IndentHeader."Authorization 3");
                IndentHeader.VALIDATE("Authorization 3", '');
            END;
            //MESSAGE('In Loop %1-%2',UserSetup."User ID",UserSetup."Indent Limit");
        END ELSE BEGIN
            //MESSAGE('Out Loop');
            EXIT;
        END;


    end;

    local procedure "--Approval---"()
    begin
    end;


    procedure ApproveIndent(var IndentHeader: Record "Indent Header"; USERIDCode: Code[50])
    begin
        WITH IndentHeader DO BEGIN
            //TESTFIELD(Hold,FALSE);

            IF Hold = TRUE THEN
                ERROR('This is Indent is on Hold, Please Unhold for Authorization');

            IF Status <> Status::Authorized THEN
            //IF CONFIRM('Do you want to release Indent %1?',TRUE,"No.") THEN
            BEGIN
                TESTFIELD("Validity Period");
                TESTFIELD("Validate Upto");

                IF "Indent Date" > 20180705D THEN
                    TESTFIELD("Created By");

                IF (COPYSTR(("No."), 1, 6) = 'INDCAP') THEN BEGIN
                    IF ("Capex No." = '') THEN
                        ERROR('Pls mention the Capex No.');
                END;


                IndentLines.RESET;
                IndentLines.SETFILTER(IndentLines."Document No.", "No.");
                IF IndentLines.FIND('-') THEN BEGIN
                    REPEAT
                        //MSAK.BEGIN 071213
                        IF COPYSTR(IndentLines."Document No.", 1, 4) = 'JRPL' THEN BEGIN
                            IF IndentLines.Type = IndentLines.Type::"Non Stock Item" THEN
                                IndentLines.TESTFIELD(IndentLines.Amount);
                        END;
                        IF "Indent Date" > 20180705D THEN
                            IF IndentLines.Type = IndentLines.Type::Item THEN
                                IndentLines.TESTFIELD(Amount);
                        //MSAK.END 071213
                        IF (IndentLines.Type = IndentLines.Type::Item) OR (IndentLines.Type = IndentLines.Type::"Non Stock Item") THEN
                            IndentLines.TESTFIELD(IndentLines.Quantity);
                        IF IndentLines.Type = IndentLines.Type::" " THEN BEGIN
                            IF (IndentLines."New Item" = TRUE) THEN BEGIN
                                //        ERROR('Type must be specify for Document No.=''%1'', Line No.=''%2.''',
                                //               IndentLines."Document No.",IndentLines."Line No.");
                            END;
                        END;
                    UNTIL IndentLines.NEXT = 0;
                END ELSE BEGIN
                    ERROR('There is nothing to release.');
                END;

                UserSetup.RESET;
                UserSetup.SETFILTER(UserSetup."User ID", "User ID");
                IF UserSetup.FIND('-') THEN BEGIN
                    CASE Status OF
                        Status::Open:
                            BEGIN
                                IF UserSetup."User ID" = UPPERCASE(USERIDCode) THEN
                                    //IF (NOT AutoRelease(IndentHeader,1,UPPERCASE(USERIDCode))) THEN
                                    IF UserSetup."Authorization 1" <> '' THEN BEGIN //-- 1. Tri36.1 PG 14112006
                                        VALIDATE(Status, Status::Authorization1);
                                        VALIDATE("Authorization 1 Date", TODAY); //-- 1. Tri36.1 PG 14112006
                                        VALIDATE("Authorization 1 Time", TIME);  //-- 1. Tri36.1 PG 14112006

                                        VALIDATE(Commented, FALSE);
                                        VALIDATE(Replied, FALSE);
                                        //AutoRelease(IndentHeader,1,UserSetup."Authorization 1");
                                    END //-- 1. Tri36.1 PG 14112006
                                    ELSE
                                        IF UserSetup."Authorization 2" <> '' THEN BEGIN //-- 1. Tri36.1 PG 14112006
                                            VALIDATE(Status, Status::Authorization2);
                                            VALIDATE("Authorization 2 Date", TODAY); //-- 1. Tri36.1 PG 14112006
                                            VALIDATE("Authorization 2 Time", TIME);  //-- 1. Tri36.1 PG 14112006
                                            VALIDATE(Commented, FALSE);
                                            VALIDATE(Replied, FALSE);
                                            //AutoRelease(IndentHeader,2,UserSetup."Authorization 2");
                                        END  //-- 1. Tri36.1 PG 14112006
                                        ELSE BEGIN //-- 1. Tri36.1 PG 14112006
                                            VALIDATE(Status, Status::Authorized);
                                            VALIDATE("Authorization Date", TODAY); //-- 1. Tri36.1 PG 14112006
                                            VALIDATE("Authorization Time", TIME);  //-- 1. Tri36.1 PG 14112006
                                            VALIDATE(Commented, FALSE);
                                            VALIDATE(Replied, FALSE);

                                        END; //-- 1. Tri36.1 PG 14112006
                            END;
                        Status::Authorization1:
                            IF UserSetup."Authorization 1" = UPPERCASE(USERIDCode) THEN
                                IF (NOT AutoRelease(IndentHeader, 1, UserSetup."Authorization 1")) THEN
                                    IF UserSetup."Authorization 2" <> '' THEN BEGIN //-- 1. Tri36.1 PG 14112006
                                        VALIDATE(Status, Status::Authorization2);
                                        VALIDATE("Authorization 2 Date", TODAY); //-- 1. Tri36.1 PG 14112006
                                        VALIDATE("Authorization 2 Time", TIME);  //-- 1. Tri36.1 PG 14112006
                                        VALIDATE(Commented, FALSE);
                                        VALIDATE(Replied, FALSE);
                                        //AutoRelease(IndentHeader,2,UserSetup."Authorization 2");
                                    END //-- 1. Tri36.1 PG 14112006
                                    ELSE BEGIN //-- 1. Tri36.1 PG 14112006
                                        VALIDATE(Status, Status::Authorized);
                                        VALIDATE("Authorization Date", TODAY); //-- 1. Tri36.1 PG 14112006
                                        VALIDATE("Authorization Time", TIME);  //-- 1. Tri36.1 PG 14112006
                                        VALIDATE(Commented, FALSE);
                                        VALIDATE(Replied, FALSE);

                                    END; //-- 1. Tri36.1 PG 14112006



                        //MS-PB BEGIN For Third level Authorization
                        Status::Authorization2:
                            IF UserSetup."Authorization 2" = UPPERCASE(USERIDCode) THEN
                                IF (NOT AutoRelease(IndentHeader, 2, UserSetup."Authorization 2")) THEN
                                    IF UserSetup."Authorization 3" <> '' THEN BEGIN
                                        VALIDATE(Status, Status::Authorization3);
                                        VALIDATE("Authorization 3 Date", TODAY);
                                        VALIDATE("Authorization 3 Time", TIME);
                                        VALIDATE(Commented, FALSE);
                                        VALIDATE(Replied, FALSE);
                                        //AutoRelease(IndentHeader,3,UserSetup."Authorization 3");
                                    END
                                    ELSE BEGIN
                                        VALIDATE(Status, Status::Authorized);
                                        VALIDATE("Authorization Date", TODAY);
                                        VALIDATE("Authorization Time", TIME);
                                        VALIDATE(Commented, FALSE);
                                        VALIDATE(Replied, FALSE);

                                    END;

                        Status::Authorization3:
                            IF UserSetup."Authorization 3" = UPPERCASE(USERIDCode) THEN
                                IF (NOT AutoRelease(IndentHeader, 3, UserSetup."Authorization 3")) THEN BEGIN
                                    VALIDATE(Status, Status::Authorized);
                                    VALIDATE("Authorization Date", TODAY);
                                    VALIDATE("Authorization Time", TIME);
                                    VALIDATE(Commented, FALSE);
                                    VALIDATE(Replied, FALSE);
                                    //AutoRelease(IndentHeader,3,UserSetup."Authorization 3");
                                END;

                        //MS-PB END For Third level;

                        Status::Authorized:
                            BEGIN //-- 1. Tri36.1 PG 14112006
                                VALIDATE(Status, Status::Authorized);
                                VALIDATE("Authorization Date", TODAY); //-- 1. Tri36.1 PG 14112006
                                VALIDATE("Authorization Time", TIME);  //-- 1. Tri36.1 PG 14112006
                                VALIDATE(Commented, FALSE);
                                VALIDATE(Replied, FALSE);

                            END; //-- 1. Tri36.1 PG 14112006

                        Status::Closed:
                            BEGIN //-- 1. Tri36.1 PG 14112006
                                VALIDATE(Status, Status::Closed);
                                VALIDATE("Closed Date", TODAY); //-- 1. Tri36.1 PG 14112006
                                VALIDATE("Closed Time", TIME);  //-- 1. Tri36.1 PG 14112006
                                VALIDATE(Commented, FALSE);
                                VALIDATE(Replied, FALSE);

                            END; //-- 1. Tri36.1 PG 14112006

                    END;

                END;
            END;
            //sash 05 start
            IndentLine2.RESET;
            IndentLine2.SETRANGE(IndentLine2."Document No.", "No.");
            IndentLine2.SETFILTER(IndentLine2."No.", '<>%1', '');
            IF IndentLine2.FIND('-') THEN BEGIN
                REPEAT
                    IF IndentLine2.Status <> IndentLine2.Status::Closed THEN BEGIN
                        IndentLine2.Status := Status;
                        IndentLine2.MODIFY;
                    END;
                UNTIL IndentLine2.NEXT = 0;
            END;
            // sash 05 end
            MODIFY;

            RecIndentHeader.RESET;
            RecIndentHeader.SETRANGE(Status, RecIndentHeader.Status::Authorization1);
            RecIndentHeader.SETRANGE("No.", "No.");
            RecIndentHeader.SETFILTER("Mail Authorization1", '%1', FALSE);
            IF RecIndentHeader.FINDFIRST THEN
                IF UserSetup1.GET(RecIndentHeader."Authorization 1") THEN
                    IF UserSetup1."E-Mail" <> '' THEN
                        SendNotification(RecIndentHeader);

            RecIndentHeader1.RESET;
            RecIndentHeader1.SETRANGE(Status, RecIndentHeader1.Status::Authorization2);
            RecIndentHeader1.SETRANGE("No.", "No.");
            RecIndentHeader1.SETFILTER("Mail Authorization2", '%1', FALSE);
            IF RecIndentHeader1.FINDFIRST THEN
                IF UserSetup1.GET(RecIndentHeader1."Authorization 1") THEN
                    IF UserSetup1."E-Mail" <> '' THEN
                        SendNotification(RecIndentHeader1);

            RecIndentHeader2.RESET;
            RecIndentHeader2.SETRANGE(Status, RecIndentHeader2.Status::Authorization3);
            RecIndentHeader2.SETRANGE("No.", "No.");
            RecIndentHeader2.SETFILTER("Mail Authorization3", '%1', FALSE);
            IF RecIndentHeader2.FINDFIRST THEN
                IF UserSetup1.GET(RecIndentHeader2."Authorization 1") THEN
                    IF UserSetup1."E-Mail" <> '' THEN
                        SendNotification(RecIndentHeader2);

            RecIndentHeader3.RESET;
            RecIndentHeader3.SETRANGE(Status, RecIndentHeader3.Status::Authorized);
            RecIndentHeader3.SETRANGE("No.", "No.");
            RecIndentHeader3.SETFILTER("Mail Authorized", '%1', FALSE);
            IF RecIndentHeader3.FINDFIRST THEN
                IF UserSetup1.GET(RecIndentHeader3."User ID") THEN
                    IF UserSetup1."E-Mail" <> '' THEN
                        SendNotificationtoAll(RecIndentHeader3);


            //MSSACHINS   280814
            RecIndentHeader.RESET;
            RecIndentHeader.SETRANGE(Status, RecIndentHeader.Status::Authorization1);
            RecIndentHeader.SETRANGE("No.", "No.");
            RecIndentHeader.SETFILTER("Mail Authorization1", '%1', FALSE);
            IF RecIndentHeader.FINDFIRST THEN
                IF UserSetup1.GET(RecIndentHeader."Authorization 1") THEN
                    IF UserSetup1."E-Mail" <> '' THEN
                        SendNotification(RecIndentHeader);

            RecIndentHeader1.RESET;
            RecIndentHeader1.SETRANGE(Status, RecIndentHeader1.Status::Authorization2);
            RecIndentHeader1.SETRANGE("No.", "No.");
            RecIndentHeader1.SETFILTER("Mail Authorization2", '%1', FALSE);
            IF RecIndentHeader1.FINDFIRST THEN BEGIN
                IF UserSetup1.GET(RecIndentHeader."User ID") THEN
                    IF UserSetup1."E-Mail" <> '' THEN
                        IF UserSetup1.GET(RecIndentHeader1."Authorization 1") THEN
                            IF UserSetup1."E-Mail" <> '' THEN
                                SendNotification(RecIndentHeader1);
            END;

            RecIndentHeader2.RESET;
            RecIndentHeader2.SETRANGE(Status, RecIndentHeader2.Status::Authorization3);
            RecIndentHeader2.SETRANGE("No.", "No.");
            RecIndentHeader2.SETFILTER("Mail Authorization3", '%1', FALSE);
            IF RecIndentHeader2.FINDFIRST THEN BEGIN
                IF UserSetup1.GET(RecIndentHeader."User ID") THEN
                    IF UserSetup1."E-Mail" <> '' THEN
                        IF UserSetup1.GET(RecIndentHeader1."Authorization 1") THEN
                            IF UserSetup1."E-Mail" <> '' THEN
                                IF UserSetup1.GET(RecIndentHeader."Authorization 2") THEN
                                    IF UserSetup1."E-Mail" <> '' THEN
                                        SendNotification(RecIndentHeader2);
            END;
        END;
    end;

    local procedure AutoApproveAppEntries(DocNo: Code[20]; VarUserID: Code[50])
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE("Document No.", DocNo);
        ApprovalEntry.SETRANGE("Approver ID", VarUserID);
        ApprovalEntry.SETFILTER(Status, '%1|%2', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created);
        IF ApprovalEntry.FINDFIRST THEN BEGIN
            ApprovalEntry.Status := ApprovalEntry.Status::Approved;
            ApprovalEntry."Auto Approved" := TRUE;
            ApprovalEntry.MODIFY;
        END;
    end;

    local procedure CalculateMainLocationStock(ItemNo: Code[20]; Locationcode: Code[50]): Decimal
    var
        Item: Record Item;
        ILE: Record "Item Ledger Entry";
    begin
        ILE.RESET;
        //ILE.SETCURRENTKEY("Item No.",Open,"Variant Code",Positive,"Location Code","Posting Date");
        ILE.SETRANGE("Item No.", ItemNo);
        ILE.SETRANGE("Location Code", Locationcode);
        IF ILE.FINDLAST THEN
            ILE.CALCSUMS("Remaining Quantity");
        EXIT(ILE."Remaining Quantity")
        /*
        Item.RESET;
        Item.SETRANGE("No.",ItemNo);
        Item.SETFILTER("Location Filter",'%1',Locationcode);
        IF Item.FINDFIRST THEN BEGIN
          Item.CALCFIELDS(Inventory);
          EXIT(Item.Inventory);
        END;
        */

    end;

    local procedure CalculateConsumption(ItemNo: Code[20]; Locationcode: Code[50]; Days: Integer) ConsQty: Decimal
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
        ItemLedgerEntry.SETRANGE("Item No.", ItemNo);
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
        //ItemLedgerEntry.SETFILTER(Positive,'%1',FALSE);
        ItemLedgerEntry.SETRANGE("Location Code", Locationcode);
        ItemLedgerEntry.SETRANGE("Posting Date", TODAY - Days, TODAY);
        ItemLedgerEntry.SETRANGE("External Transfer", FALSE);
        IF ItemLedgerEntry.FINDFIRST THEN
            REPEAT
                ConsQty -= ItemLedgerEntry.Quantity;
            UNTIL ItemLedgerEntry.NEXT = 0;
        EXIT(ConsQty);
    end;

    local procedure GetMainStore(CdUserID: Code[50]): Code[10]
    var
        UserSetup: Record "User Setup";
    begin
        IF UserSetup.GET(CdUserID) THEN BEGIN
            CASE UserSetup.Plant OF
                UserSetup.Plant::SKD:
                    EXIT('SKD-STORE');
                UserSetup.Plant::DRA:
                    EXIT('DRA-STORE');
                UserSetup.Plant::HSK:
                    EXIT('HSK-STORE');
            END;
        END;
    end;

    local procedure "--PO--"()
    begin
    end;


    procedure CreateMailforPO1(PurchaseHeader: Record "Purchase Header")
    var
        UserSetup: Record "User Setup";
        ApprovalMgt: Codeunit "QD Test, PDF Creation & Email";
        PurchaseLine2: Record "Purchase Line";
        RecPurchaseHeader: Record "Purchase Header";
        RecPurchaseHeader1: Record "Purchase Header";
        RecPurchaseHeader2: Record "Purchase Header";
        RecPurchaseHeader3: Record "Purchase Header";
        ApprovalEntrySetup: Record "Approval Entry";
    begin
        ///----- Code according to Apprpoval Entry  >>
        ApprovalEntrySetup.RESET;
        ApprovalEntrySetup.SETRANGE("Table ID", 38);
        ApprovalEntrySetup.SETRANGE(Status, ApprovalEntrySetup.Status::Created);
        ApprovalEntrySetup.SETRANGE("Document No.", PurchaseHeader."No.");
        IF ApprovalEntrySetup.FINDFIRST THEN

            //ApprovalEntrySetup.VALIDATE(
            ///----- Code according to Apprpoval Entry  

            UserSetup.RESET;
        UserSetup.SETFILTER(UserSetup."User ID", PurchaseHeader."User Id");
        IF UserSetup.FIND('-') THEN BEGIN
            CASE PurchaseHeader.Status OF
                PurchaseHeader.Status::Open:
                    IF UserSetup."User ID" = UPPERCASE(USERID) THEN
                        IF UserSetup."Authorization 1" <> '' THEN BEGIN //-- 1. Tri36.1 PG 14112006
                            PurchaseHeader.VALIDATE(Status, PurchaseHeader.Status::Authorization1);
                            //PurchaseHeader.VALIDATE("Authorization 1 Date",TODAY); //-- 1. Tri36.1 PG 14112006
                            //VALIDATE("Authorization 1 Time",TIME);  //-- 1. Tri36.1 PG 14112006
                            //VALIDATE(Commented,FALSE);
                            //PurchaseHeader.VALIDATE(Replied,FALSE);

                        END //-- 1. Tri36.1 PG 14112006
                        ELSE
                            IF UserSetup."Authorization 2" <> '' THEN BEGIN //-- 1. Tri36.1 PG 14112006
                                PurchaseHeader.VALIDATE(Status, PurchaseHeader.Status::Approved);
                                //VALIDATE("Authorization 2 Date",TODAY); //-- 1. Tri36.1 PG 14112006
                                //VALIDATE("Authorization 2 Time",TIME);  //-- 1. Tri36.1 PG 14112006
                                //VALIDATE(Commented,FALSE);
                                //VALIDATE(Replied,FALSE);
                                //AutoRelease(PurchaseHeader); //MSVRN //open
                            END  //-- 1. Tri36.1 PG 14112006
                            ELSE BEGIN //-- 1. Tri36.1 PG 14112006
                                       // 15578    PurchaseHeader.VALIDATE(Status, PurchaseHeader.Status::Authorized);
                                       //VALIDATE("Authorization Date",TODAY); //-- 1. Tri36.1 PG 14112006
                                       //VALIDATE("Authorization Time",TIME);  //-- 1. Tri36.1 PG 14112006
                                       //VALIDATE(Commented,FALSE);
                                       //VALIDATE(Replied,FALSE);

                            END; //-- 1. Tri36.1 PG 14112006

                PurchaseHeader.Status::Authorization1:
                    IF UserSetup."Authorization 1" = UPPERCASE(USERID) THEN
                        IF UserSetup."Authorization 2" <> '' THEN BEGIN //-- 1. Tri36.1 PG 14112006
                            PurchaseHeader.VALIDATE(Status, PurchaseHeader.Status::Approved);

                        END //-- 1. Tri36.1 PG 14112006
                        ELSE BEGIN //-- 1. Tri36.1 PG 14112006
                            PurchaseHeader.VALIDATE(Status, PurchaseHeader.Status::Authorized);

                        END; //-- 1. Tri36.1 PG 14112006



                //MS-PB BEGIN For Third level Authorization
                PurchaseHeader.Status::Approved:
                    IF UserSetup."Authorization 2" = UPPERCASE(USERID) THEN
                        IF UserSetup."Authorization 3" <> '' THEN BEGIN
                            PurchaseHeader.VALIDATE(Status, PurchaseHeader.Status::Authorization3);
                            //VALIDATE("Authorization 3 Date",TODAY);
                            //VALIDATE("Authorization 3 Time",TIME);

                            //VALIDATE(Commented,FALSE);
                            //VALIDATE(Replied,FALSE);
                            AutoReleasePO(PurchaseHeader);
                        END
                        ELSE BEGIN
                            PurchaseHeader.VALIDATE(Status, PurchaseHeader.Status::Authorized);
                            //VALIDATE("Authorization Date",TODAY);
                            //VALIDATE("Authorization Time",TIME);
                            //VALIDATE(Commented,FALSE);
                            //VALIDATE(Replied,FALSE);

                        END;

                PurchaseHeader.Status::Authorization3:
                    IF UserSetup."Authorization 3" = UPPERCASE(USERID) THEN BEGIN
                        PurchaseHeader.VALIDATE(Status, PurchaseHeader.Status::Authorized);
                        //VALIDATE("Authorization Date",TODAY);
                        //VALIDATE("Authorization Time",TIME);
                        //VALIDATE(Commented,FALSE);
                        //VALIDATE(Replied,FALSE);

                    END;

                //MS-PB END For Third level;

                PurchaseHeader.Status::Authorized:
                    BEGIN //-- 1. Tri36.1 PG 14112006
                        PurchaseHeader.VALIDATE(Status, PurchaseHeader.Status::Authorized);
                        //VALIDATE("Authorization Date",TODAY); //-- 1. Tri36.1 PG 14112006
                        //VALIDATE("Authorization Time",TIME);  //-- 1. Tri36.1 PG 14112006
                        //VALIDATE(Commented,FALSE);
                        //VALIDATE(Replied,FALSE);

                    END; //-- 1. Tri36.1 PG 14112006

                PurchaseHeader.Status::Closed:
                    BEGIN //-- 1. Tri36.1 PG 14112006
                        PurchaseHeader.VALIDATE(Status, PurchaseHeader.Status::Closed);
                        //VALIDATE("Closed Date",TODAY); //-- 1. Tri36.1 PG 14112006
                        //VALIDATE("Closed Time",TIME);  //-- 1. Tri36.1 PG 14112006
                        //VALIDATE(Commented,FALSE);
                        //VALIDATE(Replied,FALSE);

                    END; //-- 1. Tri36.1 PG 14112006

            END;
        END;
        //END;

        //sash 05 start
        PurchaseLine2.RESET;
        PurchaseLine2.SETRANGE(PurchaseLine2."Document No.", PurchaseHeader."No.");
        PurchaseLine2.SETFILTER(PurchaseLine2."No.", '<>%1', '');
        IF IndentLine2.FIND('-') THEN BEGIN
            REPEAT
                IF IndentLine2.Status <> IndentLine2.Status::Closed THEN BEGIN
                    // 15578  PurchaseLine2.Status := PurchaseHeader.Status;
                    PurchaseLine2.MODIFY;
                END;
            UNTIL PurchaseLine2.NEXT = 0;
        END;
        // sash 05 end


        //PurchaseHeader.MODIFY; //MSVRN /Open-----


        //SendNotification(Rec);
        /*
        //MSAK.BEGIN 081213
        RecPurchaseHeader.RESET;
        RecPurchaseHeader.SETRANGE(Status,RecPurchaseHeader.Status::Authorization1);
        RecPurchaseHeader.SETRANGE("No.",PurchaseHeader."No.");
        //RecPurchaseHeader.SETFILTER("Mail Authorization1",'%1',FALSE);
        IF RecPurchaseHeader.FINDFIRST THEN
          IF UserSetup1.GET(RecPurchaseHeader."Authorization 1") THEN
            IF UserSetup1."E-Mail" <> '' THEN
              SendNotificationforPurch(RecPurchaseHeader);
        
        RecPurchaseHeader1.RESET;
        RecPurchaseHeader1.SETRANGE(Status,RecPurchaseHeader1.Status::Authorization2);
        RecPurchaseHeader1.SETRANGE("No.", PurchaseHeader."No.");
        //RecPurchaseHeader1.SETFILTER("Mail Authorization2",'%1',FALSE);
        IF RecPurchaseHeader1.FINDFIRST THEN
          IF UserSetup1.GET(RecPurchaseHeader1."Authorization 1") THEN
            IF UserSetup1."E-Mail" <> '' THEN
              SendNotificationforPurch(RecPurchaseHeader);
        
        RecPurchaseHeader2.RESET;
        RecPurchaseHeader2.SETRANGE(Status,RecPurchaseHeader2.Status::Authorization3);
        RecPurchaseHeader2.SETRANGE("No.",PurchaseHeader."No.");
        //RecPurchaseHeader2.SETFILTER("Mail Authorization3",'%1',FALSE);
        IF RecPurchaseHeader2.FINDFIRST THEN
          IF UserSetup1.GET(RecPurchaseHeader2."Authorization 1") THEN
            IF UserSetup1."E-Mail" <> '' THEN
              SendNotificationforPurch(RecPurchaseHeader);
        
        //MSVRN 290818 /open
        
        RecPurchaseHeader3.RESET;
        RecPurchaseHeader3.SETRANGE(Status,RecPurchaseHeader3.Status::Authorized);
        RecPurchaseHeader3.SETRANGE("No.", PurchaseHeader."No.");
        //RecPurchaseHeader3.SETFILTER("Mail Authorized",'%1',FALSE);
        IF RecPurchaseHeader3.FINDFIRST THEN
        IF UserSetup1.GET(RecPurchaseHeader3."User ID") THEN
         IF UserSetup1."E-Mail" <> '' THEN
           SendNotificationtoAll(RecPurchaseHeader3);
        */

        //MSVRN /Double mailing stopped ---
        /*
        //MSSACHINS   280814
        RecPurchaseHeader.RESET;
        RecPurchaseHeader.SETRANGE(Status,RecPurchaseHeader.Status::Authorization1);
        RecPurchaseHeader.SETRANGE("No.",PurchaseHeader."No.");
        //RecPurchaseHeader.SETFILTER("Mail Authorization1",'%1',FALSE);
        IF RecPurchaseHeader.FINDFIRST THEN
          IF UserSetup1.GET(RecPurchaseHeader."Authorization 1") THEN
            IF UserSetup1."E-Mail" <> '' THEN
              SendNotificationforPurch(RecPurchaseHeader);
        
        RecPurchaseHeader1.RESET;
        RecPurchaseHeader1.SETRANGE(Status,RecPurchaseHeader1.Status::Authorization2);
        RecPurchaseHeader1.SETRANGE("No.",PurchaseHeader."No.");
        //RecPurchaseHeader1.SETFILTER("Mail Authorization2",'%1',FALSE);
        IF RecPurchaseHeader1.FINDFIRST THEN  BEGIN
          IF UserSetup1.GET(RecPurchaseHeader."User Id") THEN
            IF UserSetup1."E-Mail" <> '' THEN
              IF UserSetup1.GET(RecPurchaseHeader1."Authorization 1") THEN
                IF UserSetup1."E-Mail" <> '' THEN
                  SendNotificationforPurch(RecPurchaseHeader1);
        END;
        
        RecPurchaseHeader2.RESET;
        RecPurchaseHeader2.SETRANGE(Status,RecPurchaseHeader2.Status::Authorization3);
        RecPurchaseHeader2.SETRANGE("No.",PurchaseHeader."No.");
        //RecPurchaseHeader2.SETFILTER("Mail Authorization3",'%1',FALSE);
        IF RecPurchaseHeader2.FINDFIRST THEN  BEGIN
          IF UserSetup1.GET(RecPurchaseHeader."User Id") THEN
            IF UserSetup1."E-Mail" <> '' THEN
              IF UserSetup1.GET(RecPurchaseHeader1."Authorization 1") THEN
                IF UserSetup1."E-Mail" <> '' THEN
        
          IF UserSetup1.GET(RecPurchaseHeader."Authorization 2") THEN
            IF UserSetup1."E-Mail" <> '' THEN
              SendNotificationforPurch(RecPurchaseHeader2);
        END;
        */

        /*
        //MSVRN /290818>>
        RecPurchaseHeader.RESET;
        RecPurchaseHeader.SETRANGE(Status,RecPurchaseHeader.Status::Authorization1);
        RecPurchaseHeader.SETRANGE("No.",PurchaseHeader."No.");
        //RecPurchaseHeader.SETFILTER("Mail Authorization1",'%1',FALSE);
        IF RecPurchaseHeader.FINDFIRST THEN BEGIN
          ApprovalEntrySetup.RESET;
          ApprovalEntrySetup.SETRANGE("Table ID", 38);
          ApprovalEntrySetup.SETRANGE("Document No.", RecPurchaseHeader."No.");
          ApprovalEntrySetup.SETRANGE(Status, ApprovalEntrySetup.Status::Created);
          IF ApprovalEntrySetup.FINDFIRST THEN
          //IF ApprovalEntrySetup.GET(RecPurchaseHeader."Authorization 1") THEN
            //IF ApprovalEntrySetup. <> '' THEN
            //UserSetup1.GET(ApprovalEntrySetup."Approver ID");
            SendNotificationforPurch(RecPurchaseHeader);
        END;
        //MSVRN /290818<<
        */

    end;


    procedure SendNotificationforPurch(PurchaseHeader: Record "Purchase Header")///15578
    var
        //SMTPMailCodeunit: Codeunit "400";
        SrNo: Integer;
        RecCust: Record Customer;
        //SMTPMailSetup: Record "409";
        CompInfo: Record "Company Information";
        Usersetup1: Record "User Setup";
        RecIndentHeader: Record "Purchase Header";
        Usersetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        RecPurchaseHeader1: Record "Purchase Header";
        RecPurchaseHeader2: Record "Purchase Header";
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
        PurchaseLine: Record "Purchase Line";
        Email3: Text;
        UserSetup6: Record "User Setup";
        CommentLine: Record "Comment Line";
        I: Integer;
        Comments: Text;
        Amt: Decimal;
        EmailCC1: Text[150];
        IndentAppLink: Text[250];
        ShortLink: Text[250];
        ApprovalEntry: Record "Approval Entry";
        PurchaseLine1: Record "Purchase Line";
        TxtBoldBegin: Text;
        TxtBoldEnd: Text;
        PurchaseLine3: Record "Purchase Line";
        Amt2: Decimal;
        ApproverName: Code[100];
        ApprovalEntry1: Record "Approval Entry";
        UserName: Text[100];
        UserSetup7: Record "User Setup";
        ApprovalEntry2: Record "Approval Entry";
        DRAPrice: Decimal;
        SKDPrice: Decimal;
        HSKPrice: Decimal;
        AttachmentManagment: Record "Attachment Management";
        FilePath: Text;
        FileName: Text;
        Text50090: Label '<TR  bgcolor="#80ff80">';
        Text50091: Label '<TD  width=5 Align=Center bgcolor="#80ff80"> ';
        AppDtTime: DateTime;
        EmailObj: Codeunit Email; // 15578TEXT
        EmailMsg: codeunit "Email Message";
        EmailCCList: List of [Text];
        BodyText: Text;
        EmailAddressList: List of [Text];
        EmailBccList: list of [Text];
        InstreamVar: InStream;
        OutstreamVar: OutStream;
        TempBlobCU: Codeunit "Temp Blob";
        FileMgmt: Codeunit 419;

    //SendNotification

    begin
        RecPurchaseHeader1.RESET;
        RecPurchaseHeader1.SETRANGE("No.", PurchaseHeader."No.");
        IF RecPurchaseHeader1.FINDFIRST THEN BEGIN
            ApprovalEntry.RESET;
            ApprovalEntry.SETRANGE("Table ID", 38);
            ApprovalEntry.SETRANGE("Document No.", PurchaseHeader."No.");
            ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Created);
            IF ApprovalEntry.FINDFIRST THEN BEGIN
                IF Usersetup1.GET(ApprovalEntry."Approver ID") THEN BEGIN
                    EmailTo := Usersetup1."E-Mail";
                    //ApproverName := Usersetup1."User Name"; //MSAK
                END;
                RecPurchaseHeader1."Approver ID" := ApprovalEntry."Approver ID"; //MSAK
                RecPurchaseHeader1."Approver Name" := Usersetup1."User Name"; //MSAK
                                                                              //RecPurchaseHeader1.VALIDATE(Status, RecPurchaseHeader1.Status::"Pending Approval"); //MSAK
                RecPurchaseHeader1.MODIFY; //MSAK
                IndentDesc := 'RecPurchaseHeader1.Description';
                IndentRemarks := 'RecPurchaseHeader1.Remarks';
            END;
        END;
        CommentLine.RESET;
        CommentLine.SETRANGE(CommentLine."No.", PurchaseHeader."No.");
        IF CommentLine.FINDFIRST THEN BEGIN
            I := 1;
            REPEAT
                Comments += CommentLine.Comment;
            UNTIL (CommentLine.NEXT = 0) OR (I = 2);
        END;
        IF (EmailTo <> '') OR (EmailCC <> '') THEN BEGIN
            // SMTPMailSetup.GET;
            // SMTPMailSetup.TESTFIELD("User ID");
            SrNo := 1;
            //CLEAR(SMTPMailCodeunit);

            //EmailAddressList.Add('Orient Bell Limited.');
            EmailAddressList.Add(EmailTo);
            //SMTPMailCodeunit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',EmailTo, 'Purchase Order No. ' + PurchaseHeader."No." + ' ' + ' - ' + FORMAT(PurchaseHeader.Status), '', TRUE);


            EmailCCList.add('donotreply@orientbell.com');//keshav02062020
            BodyText := ('Dear Sir,');
            BodyText += (Text50010);
            //MSAK
            PurchaseLine3.SETRANGE("Document No.", PurchaseHeader."No.");
            IF PurchaseLine3.FINDFIRST THEN
                REPEAT
                    Amt2 += PurchaseLine3.Amount;
                UNTIL PurchaseLine3.NEXT = 0;
            //MSAK
            BodyText += ('<br><br>');
            //MSAK
            IF RecPurchaseHeader1.Status = RecPurchaseHeader1.Status::Open THEN BEGIN
                UserSetup7.RESET;
                IF UserSetup7.GET(RecPurchaseHeader1."User Id") THEN
                    UserName := UserSetup7."User Name";
                //  SMTPMailCodeunit.AppendBody('The Purchase Order No. '+FORMAT(PurchaseHeader."No.")+' amounting Rs. '+ FORMAT(Amt2)+' has been raised by '+
                //  UserName +' for location '+ PurchaseHeader."Location Code" +' for Your Approval.');

                BodyText += ('The Purchase Order No. ' + FORMAT(PurchaseHeader."No.") + ' For Vendor Name ' + FORMAT(PurchaseHeader."Buy-from Vendor Name") + ' has been raised by ' + UserName + 'for Your Approval.');

                RecPurchaseHeader1.VALIDATE(Status, RecPurchaseHeader1.Status::"Pending Approval");
                RecPurchaseHeader1.MODIFY;
            END ELSE BEGIN
                ApprovalEntry1.SETRANGE("Table ID", 38);
                ApprovalEntry1.SETRANGE("Document No.", PurchaseHeader."No.");
                ApprovalEntry1.SETRANGE(Status, ApprovalEntry.Status::Approved);
                IF ApprovalEntry1.FINDLAST THEN BEGIN
                    IF Usersetup1.GET(ApprovalEntry1."Approver ID") THEN BEGIN
                        // PurchaseHeader."Approver ID" := ApprovalEntry1."Approver ID";
                        //PurchaseHeader."Approver Name" := Usersetup1."User Name";
                        //PurchaseHeader.MODIFY;
                        ApproverName := Usersetup1."User Name";
                    END;
                    BodyText += ('The Purchase Order No. ' + FORMAT(PurchaseHeader."No.") + ' for vendor Name ' + FORMAT(PurchaseHeader."Buy-from Vendor Name") + ' has been approved by ' + ApproverName + 'for Your Approval.');
                END;
            END;
            ApprovalEntry1.SETRANGE("Table ID", 38);
            ApprovalEntry1.SETRANGE("Document No.", PurchaseHeader."No.");
            ApprovalEntry1.SETRANGE(Status, ApprovalEntry.Status::Created);
            IF ApprovalEntry1.FINDFIRST THEN BEGIN
                AppDtTime := ApprovalEntry1."Date-Time Sent for Approval";
            END;

            //MSAK
            BodyText += (Text60005);
            BodyText += (Text60005);
            BodyText += (' The details of Purchase Order Items are listed below:');
            BodyText += (Text60006);
            BodyText += (Text60006);
            BodyText += ('<br>');
            BodyText += ('Vendor Name    : ' + PurchaseHeader."Buy-from Vendor Name");
            BodyText += ('<br><br>');
            BodyText += (Text60006);
            BodyText += ('Vendor Address : ' + PurchaseHeader."Buy-from Address" + ',' + PurchaseHeader."Buy-from Address 2");
            BodyText += ('<br>');
            BodyText += (Text60006);
            BodyText += ('Vendor City    : ' + PurchaseHeader."Buy-from City");
            BodyText += ('<br>');
            BodyText += (Text60006);
            BodyText += ('P.O. Value     : ' + FORMAT(Amt2));
            BodyText += ('<br>');
            BodyText += (Text60006);
            BodyText += ('Location       : ' + PurchaseHeader."Location Code");
            BodyText += ('<br>');
            BodyText += (Text60006);
            BodyText += ('Payment Terms  : ' + PurchaseHeader."Payment Terms Code");
            BodyText += ('<br>');
            BodyText += (Text60006);
            BodyText += ('Payment Method : ' + PurchaseHeader."Payment Method Code");
            BodyText += ('<br>');
            BodyText += (Text60006);
            BodyText += (Text60006);
            BodyText += ('Approval Sent Date & Time : ' + FORMAT(AppDtTime));
            BodyText += ('<br>');
            BodyText += (Text60006);
            BodyText += (Text60006);
            BodyText += (Text50027 + Text50026 + Text50041 + Text60012 + 'S.No.' + Text60013 + Text60003);
            BodyText += (Text50030 + Text60012 + 'Item No.' + Text60013 + Text60003);
            BodyText += (Text50030 + Text60012 + 'Indent No.' + Text60013 + Text60003);
            SrNo := 1;
            BodyText += (Text50030 + Text60012 + 'Description' + Text60013 + Text60003);
            BodyText += (Text50030 + Text60012 + 'Description 2' + Text60013 + Text60003);
            BodyText += (Text50030 + Text60012 + 'Quantity' + Text60013 + Text60003);
            BodyText += (Text50030 + Text60012 + 'Qty.Increased' + Text60013 + Text60003);
            BodyText += (Text50041 + Text60012 + 'Rate' + Text60013 + Text60003);
            BodyText += (Text50041 + Text60012 + 'Amount' + Text60013 + Text60003);
            BodyText += (Text50041 + Text60012 + 'SKD-LP' + Text60013 + Text60003);
            BodyText += (Text50041 + Text60012 + 'SKD-LP Date' + Text60013 + Text60003);
            BodyText += (Text50041 + Text60012 + 'DRA-LP' + Text60013 + Text60003);
            BodyText += (Text50041 + Text60012 + 'DRA-LP Date' + Text60013 + Text60003);
            BodyText += (Text50041 + Text60012 + 'HSK-LP' + Text60013 + Text60003);
            BodyText += (Text50041 + Text60012 + 'HSK-LP Date' + Text60013 + Text60003);
            BodyText += (Text50041 + Text60012 + 'Days Taken for PO' + Text60013 + Text60003);
            BodyText += (Text60004);
            PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
            IF PurchaseLine.FINDFIRST THEN BEGIN
                REPEAT
                    IF PurchaseLine."No." <> '' THEN BEGIN//KEshav08062020
                        CLEAR(qtychange);
                        IF (PurchaseLine.Quantity > PurchaseLine."Original PO Qty") AND (PurchaseLine."Original PO Qty" <> 0) THEN
                            qtychange := PurchaseLine.Quantity - PurchaseLine."Original PO Qty";
                        IF qtychange > 0 THEN BEGIN
                            GetLastPurchasePrice(PurchaseLine."No.", SKDPrice, DRAPrice, HSKPrice);
                            BodyText += (Text50090 + Text50041 + FORMAT(SrNo) + Text60003);
                            BodyText += (Text50091 + FORMAT(PurchaseLine."No.") + Text60003);
                            BodyText += (Text50091 + FORMAT(PurchaseLine."Indent No.") + Text60003);
                            BodyText += (Text50091 + FORMAT(PurchaseLine.Description) + Text60003);
                            BodyText += (Text50091 + FORMAT(PurchaseLine."Description 2") + Text60003);
                            BodyText += (Text50091 + FORMAT(PurchaseLine.Quantity) + Text60003);
                            BodyText += (Text50091 + FORMAT(qtychange) + Text60003);
                            BodyText += (Text50091 + FORMAT(PurchaseLine."Unit Cost (LCY)") + Text60003);
                            BodyText += (Text50091 + FORMAT(PurchaseLine.Amount) + Text60003);

                        END ELSE BEGIN
                            qtychange := 0;
                            GetLastPurchasePrice(PurchaseLine."No.", SKDPrice, DRAPrice, HSKPrice);
                            BodyText += (Text50026 + Text50041 + FORMAT(SrNo) + Text60003);
                            BodyText += (Text50041 + FORMAT(PurchaseLine."No.") + Text60003);
                            BodyText += (Text50041 + FORMAT(PurchaseLine."Indent No.") + Text60003);
                            BodyText += (Text50041 + FORMAT(PurchaseLine.Description) + Text60003);
                            BodyText += (Text50041 + FORMAT(PurchaseLine."Description 2") + Text60003);
                            BodyText += (Text50041 + FORMAT(PurchaseLine.Quantity) + Text60003);
                            BodyText += (Text50041 + FORMAT(qtychange) + Text60003);
                            BodyText += (Text50041 + FORMAT(PurchaseLine."Unit Cost (LCY)") + Text60003);
                            BodyText += (Text50041 + FORMAT(PurchaseLine.Amount) + Text60003);
                        END;
                        //Keshav08062020
                        IF SKDPrice = 0 THEN
                            skdlpdate := 0D;
                        IF DRAPrice = 0 THEN
                            dralpdate := 0D;
                        IF HSKPrice = 0 THEN
                            hsklpdate := 0D;
                        //Keshav08062020
                        BodyText += (Text50041 + FORMAT(SKDPrice) + Text60003);
                        BodyText += (Text50041 + FORMAT(skdlpdate) + Text60003);
                        BodyText += (Text50041 + FORMAT(DRAPrice) + Text60003);
                        BodyText += (Text50041 + FORMAT(dralpdate) + Text60003);
                        BodyText += (Text50041 + FORMAT(HSKPrice) + Text60003);
                        BodyText += (Text50041 + FORMAT(hsklpdate) + Text60003);
                        RecIndentHeader1.GET(PurchaseLine."Indent No.");
                        //SMTPMailCodeunit.AppendBody(Text50041+FORMAT(PurchaseHeader."Order Date" - RecIndentHeader1."Authorization Date"));
                        BodyText += (Text50041 + FORMAT(DT2DATE(AppDtTime) - RecIndentHeader1."Authorization Date"));

                        BodyText += (Text60004);
                        SrNo += 1;
                        Amt += PurchaseLine.Amount;
                    END;
                UNTIL PurchaseLine.NEXT = 0;
            END;
            //
            //MSKS
            BodyText += (Text50026 + Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('Total') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003); //MSAK
            BodyText += (Text50041 + FORMAT(Amt) + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text50041 + FORMAT('') + Text60003);
            BodyText += (Text60004);
            //MSKS
            BodyText += (Text60004);
            BodyText += (Text60005);
            BodyText += (Text60006);
            BodyText += (Text60011);
            //Table End
            BodyText += (Comments);
            BodyText += (Text60011);
            //MSAK
            ApprovalEntry2.RESET;
            ApprovalEntry2.SETRANGE("Table ID", 38);
            ApprovalEntry2.SETRANGE("Document No.", PurchaseHeader."No.");
            ApprovalEntry2.SETRANGE(Status, ApprovalEntry1.Status::Rejected);
            ApprovalEntry2.SETFILTER("Comment Text", '<>%1', '');
            IF ApprovalEntry2.FINDLAST THEN BEGIN
                BodyText += ('Query: ' + ApprovalEntry2."Comment Text" + '<br>');
                BodyText += ('Answer: ' + PurchaseHeader."Reason for Approval" + '<br><br>');
            END;
            //MSAK
            BodyText += ('Yours Truly, <br>');
            BodyText += ('For Orient Bell Limited  <br>');
            IF UserSetup6.GET(USERID) THEN
                BodyText += (FORMAT(UserSetup6."User Name") + '<br>');
            //SMTPMailCodeunit.AppendBody(ApprovalMgt.getApprovalLink(50016,IndentHeader."No.",0)); //MSVRN 230818 //Old code
            //MSVRN 230818 //New code >>
            IndentAppLink := '';
            IndentAppLink := ApprovalMgt.getApprovalLink(38, PurchaseHeader."No.", 0);
            ShortLink := '<a href="' + IndentAppLink + '">Purchase Approve/Reject</a>';
            BodyText += (ShortLink);
            //MSVRN 230818 <<

            //Keshav_Add_Attchment28042020
            //  AttachmentManagment.ExportAttachmentAsFile(PurchaseHeader.RECORDID, FilePath, FileName);
            IF AttachmentManagment.Get(PurchaseHeader.RecordId) then begin
                IF AttachmentManagment.Attachment.HasValue then begin
                    AttachmentManagment.Attachment.CreateInStream(InstreamVar);
                    //AttachmentManagment.ExportAttachment(PurchaseHeader.RECORDID); 
                    EmailMsg.AddAttachment(AttachmentManagment."File Name", 'application/pdf', InstreamVar);
                end;
            end;
            // if File.Exists(FilePath + '\' + FileName) then begin
            //FileMgmt.BLOBExportToServerFile(TempBlobCU, FilePath + '\' + FileName + '.pdf');
            //AttachmentManagment.          

            //TempBlobCU.CreateInStream(InstreamVar);
            // EmailMsg.Create(EmailAddressList, 'Purchase Order No. ', BodyText, true, EmailBccList, EmailCCList);
            //if File.Exists(FilePath + '\' + FileName) THEN
            // EmailMsg.AddAttachment(FilePath + '\' + FileName, 'application/pdf', InstreamVar);
            // EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
            //END;

            /* IF FILE.EXISTS(FilePath + '\' + FileName) THEN
                SMTPMailCodeunit.AddAttachment(FilePath + '\' + FileName, FileName);
             */  ///  15578 
            //Keshav_Add_Attchment28042020

            IF EmailCC <> '' THEN
                EmailCCList.add(EmailCC);
            IF EmailCC1 <> '' THEN
                EmailCCList.add(EmailCC1); //MSKS2310
                                           //SMTPMailCodeunit.AddCC('kulwant@mindshell.info');
            IF Email3 <> '' THEN
                EmailCCList.add(Email3);
            //SMTPMailCodeunit.AddBCC('kulwant@mindshell.info');
            //    SMTPMailCodeunit.AddBCC('virendra.kumar@mindshell.info');
            EmailMsg.Create(EmailAddressList, 'Purchase Order No. ' + PurchaseHeader."No." + ' ' + ' - ' + FORMAT(PurchaseHeader.Status), BodyText, true, EmailCCList, EmailBccList);///15578
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
            SLEEP(100);
            //SMTPMailCodeunit.Send();
            SLEEP(1000);
            IF GUIALLOWED THEN
                MESSAGE('Mail sent for PO approval!');
        END;
    end;


    procedure SendNotificationforPurch1(PurchaseHeader: Record "Purchase Header"; ApprovalEntry1: Record "Approval Entry")
    var
        //SMTPMailCodeunit: Codeunit "400";
        SrNo: Integer;
        RecCust: Record Customer;
        //SMTPMailSetup: Record "409";
        CompInfo: Record "Company Information";
        Usersetup1: Record "User Setup";
        RecIndentHeader: Record "Purchase Header";
        Usersetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        RecPurchaseHeader1: Record "Purchase Header";
        RecPurchaseHeader2: Record "Purchase Header";
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
        IndentLine: Record "Purchase Line";
        Email3: Text;
        CommentLine: Record "Comment Line";
        I: Integer;
        Comments: Text;
        Amt: Decimal;
        EmailCC1: Text[150];
        IndentAppLink: Text[250];
        ShortLink: Text[250];
        ApprovalEntry: Record "Approval Entry";
        ApprovalEntry2: Record "Approval Entry";
        UserSetup: Record "User Setup";
        TxtBoldBegin: Text;
        TxtBoldEnd: Text;
        PurchaseLine1: Record "Purchase Line";
    begin
        RecPurchaseHeader1.RESET;
        RecPurchaseHeader1.SETRANGE("No.", PurchaseHeader."No.");
        IF RecPurchaseHeader1.FINDFIRST THEN BEGIN
            IF UserSetup.GET(PurchaseHeader."User Id") THEN;
            ApprovalEntry.RESET;
            ApprovalEntry.SETRANGE("Table ID", 38);
            ApprovalEntry.SETRANGE("Document No.", PurchaseHeader."No.");
            //ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Created);
            IF ApprovalEntry.FINDFIRST THEN
                //IF RecPurchaseHeader1.Status = RecPurchaseHeader1.Status::Authorization1 THEN BEGIN
                IF Usersetup1.GET(ApprovalEntry."Approver ID") THEN;
            //EmailTo:=Usersetup1."E-Mail";
            //END;



            ApprovalEntry2.RESET;
            ApprovalEntry2.SETRANGE("Table ID", ApprovalEntry1."Table ID");
            ApprovalEntry2.SETRANGE("Document No.", ApprovalEntry1."Document No.");
            //ApprovalEntry2.SETRANGE(Status, ApprovalEntry2.Status::Created);
            ApprovalEntry2.SETRANGE("Sequence No.", ApprovalEntry1."Sequence No." + 1);
            IF NOT ApprovalEntry2.FINDFIRST THEN BEGIN
                PurchaseHeader.VALIDATE(Status, PurchaseHeader.Status::Approved);
                EmailTo := UserSetup."E-Mail";
            END ELSE
                PurchaseHeader.VALIDATE("Approver ID", ApprovalEntry2."Approver ID");
            PurchaseHeader.MODIFY;
            EmailTo := ApprovalEntry2.EmailID;

            IndentDesc := 'RecPurchaseHeader1.Description';
            IndentRemarks := 'RecPurchaseHeader1.Remarks';
        END;

        CommentLine.RESET;
        CommentLine.SETRANGE(CommentLine."No.", PurchaseHeader."No.");
        IF CommentLine.FINDFIRST THEN BEGIN
            I := 1;
            REPEAT
                Comments += CommentLine.Comment;
            UNTIL (CommentLine.NEXT = 0) OR (I = 2);
        END;
        /* 15578 IF (EmailTo <> '') OR (EmailCC <> '') THEN BEGIN
             SMTPMailSetup.GET;
             SMTPMailSetup.TESTFIELD("User ID");
             SrNo := 1;
             CLEAR(SMTPMailCodeunit);
             SMTPMailCodeunit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
             EmailTo, 'Purchase No. ' + PurchaseHeader."No." + ' ' + ' - ' + FORMAT(PurchaseHeader.Status), '', TRUE);

             SMTPMailCodeunit.AppendBody('Dear Sir,');
             SMTPMailCodeunit.AppendBody(Text50010);


             PurchaseHeader.CALCFIELDS(Amount);
             SMTPMailCodeunit.AppendBody('<br><br>');
             SMTPMailCodeunit.AppendBody('The Purchase No. ' + FORMAT(PurchaseHeader."No.") + ' amounting Rs. ' + FORMAT(PurchaseHeader.Amount) + ' has been raised for Your Approval, The Current Status of Purchasing is -' + FORMAT(PurchaseHeader.Status));
             SMTPMailCodeunit.AppendBody(' .The details of Purchasing Items are listed below:');
             SMTPMailCodeunit.AppendBody('<br><br>');
             //Table Start
             SMTPMailCodeunit.AppendBody(Text60005);
             SMTPMailCodeunit.AppendBody(Text60006);
             //SMTPMailCodeunit.AppendBody('Remarks :-'+' '+IndentHeader.Remarks); //MSVRN 290818
             SMTPMailCodeunit.AppendBody('Created By:-' + ' ' + PurchaseHeader."User Id" + ',' + ' Location' + '-' + PurchaseHeader."Location Code");

             SMTPMailCodeunit.AppendBody(Text50027 + Text50026 + Text50041 + Text60012 + 'S.No.' + Text60013 + Text60003);
             SMTPMailCodeunit.AppendBody(Text50030 + Text60012 + 'Item No.' + Text60013 + Text60003);
             SMTPMailCodeunit.AppendBody(Text50030 + Text60012 + 'Not To Executed' + Text60013 + Text60003);
             SrNo := 1;
             SMTPMailCodeunit.AppendBody(Text50030 + Text60012 + 'Description' + Text60013 + Text60003);
             SMTPMailCodeunit.AppendBody(Text50030 + Text60012 + 'Description 2' + Text60013 + Text60003);

             SMTPMailCodeunit.AppendBody(Text50030 + Text60012 + 'Quantity' + Text60013 + Text60003);
             SMTPMailCodeunit.AppendBody(Text50041 + Text60012 + 'Rate' + Text60013 + Text60003);
             SMTPMailCodeunit.AppendBody(Text50041 + Text60012 + 'Amount' + Text60013 + Text60003);
             SMTPMailCodeunit.AppendBody(Text60004);
             IndentLine.SETRANGE("Document No.", PurchaseHeader."No.");
             IF IndentLine.FINDFIRST THEN BEGIN
                 REPEAT
                     SMTPMailCodeunit.AppendBody(Text50026 + Text50041 + FORMAT(SrNo) + Text60003);
                     SMTPMailCodeunit.AppendBody(Text50041 + FORMAT(IndentLine."No.") + Text60003);
                     SMTPMailCodeunit.AppendBody(Text50041 + FORMAT('IndentLine.Deleted') + Text60003);
                     SMTPMailCodeunit.AppendBody(Text50041 + FORMAT(IndentLine.Description) + Text60003);
                     SMTPMailCodeunit.AppendBody(Text50041 + FORMAT(IndentLine."Description 2") + Text60003);
                     SMTPMailCodeunit.AppendBody(Text50041 + FORMAT(IndentLine.Quantity) + Text60003);
                     SMTPMailCodeunit.AppendBody(Text50041 + FORMAT(IndentLine."Direct Unit Cost") + Text60003);
                     SMTPMailCodeunit.AppendBody(Text50041 + FORMAT(IndentLine.Amount) + Text60003);
                     SMTPMailCodeunit.AppendBody(Text60004);
                     SrNo += 1;
                     Amt += IndentLine.Amount;
                 UNTIL IndentLine.NEXT = 0;
             END;
             //
             //MSKS
             SMTPMailCodeunit.AppendBody(Text50026 + Text50041 + FORMAT('') + Text60003);
             SMTPMailCodeunit.AppendBody(Text50041 + FORMAT('') + Text60003);
             SMTPMailCodeunit.AppendBody(Text50041 + FORMAT('') + Text60003);
             SMTPMailCodeunit.AppendBody(Text50041 + FORMAT('') + Text60003);
             SMTPMailCodeunit.AppendBody(Text50041 + FORMAT('Total') + Text60003);
             SMTPMailCodeunit.AppendBody(Text50041 + FORMAT('') + Text60003);
             SMTPMailCodeunit.AppendBody(Text50041 + FORMAT(Amt) + Text60003);
             SMTPMailCodeunit.AppendBody(Text60004);
             //MSKS
             SMTPMailCodeunit.AppendBody(Text60004);

             SMTPMailCodeunit.AppendBody(Text60005);

             SMTPMailCodeunit.AppendBody(Text60006);
             SMTPMailCodeunit.AppendBody(Text60011);

             //Table End
             SMTPMailCodeunit.AppendBody(Comments);

             SMTPMailCodeunit.AppendBody(Text60011);

             SMTPMailCodeunit.AppendBody('Yours Truly, <br>');

             SMTPMailCodeunit.AppendBody('For Orient Bell Limited  <br>');
             IF UserSetup6.GET(USERID) THEN
                 SMTPMailCodeunit.AppendBody(FORMAT(UserSetup6."User Name") + '<br>');

             //SMTPMailCodeunit.AppendBody(ApprovalMgt.getApprovalLink(50016,IndentHeader."No.",0)); //MSVRN 230818 //Old code
             //MSVRN 230818 //New code >>
             SMTPMailCodeunit.AppendBody('');
             SMTPMailCodeunit.AppendBody('');

             IF PurchaseHeader.Status = PurchaseHeader.Status::Approved THEN
                 SMTPMailCodeunit.AppendBody('Purchase Order successfully approved!<br>');
             //ELSE
             //SMTPMailCodeunit.AppendBody('The next Approver is ' + ApprovalEntry1."Approver ID" + '<br>');

             IndentAppLink := '';
             IndentAppLink := ApprovalMgt.getApprovalLink(38, PurchaseHeader."No.", 0);
             ShortLink := '<a href="' + IndentAppLink + '">Purchase Approve/Reject</a>';
             SMTPMailCodeunit.AppendBody(ShortLink);
             //MSVRN 230818 <<

             IF EmailCC <> '' THEN
                 SMTPMailCodeunit.AddCC(EmailCC);
             IF EmailCC1 <> '' THEN
                 SMTPMailCodeunit.AddCC(EmailCC1); //MSKS2310
             SMTPMailCodeunit.AddCC('kulbhushan.sharma@orientbell.com');
             IF Email3 <> '' THEN
                 SMTPMailCodeunit.AddCC(Email3);
             SMTPMailCodeunit.AddCC('kulbhushan.sharma@orientbell.com');
             SLEEP(2000);
             SMTPMailCodeunit.Send();
             SLEEP(2000);
             IF GUIALLOWED THEN
                 MESSAGE('Mail sent for PO approval!');
         END;*/ // 15578


    end;

    local procedure AutoReleasePO(var IndentHeader: Record "Purchase Header")
    var
        UserSetup: Record "User Setup";
    begin
        IndentHeader.CALCFIELDS(Amount);
        UserSetup.GET(IndentHeader."User Id");
        IF (IndentHeader.Amount <= UserSetup."Indent Limit") AND (UserSetup."Indent Limit" <> 0) THEN BEGIN
            IndentHeader.VALIDATE(Status, IndentHeader.Status::Approved);
            //IndentHeader.VALIDATE("Authorization Date",TODAY);
            //IndentHeader.VALIDATE("Authorization Time",TIME);
            //IndentHeader.VALIDATE(Commented,FALSE);
            //IndentHeader.VALIDATE(Replied,FALSE);
            //MESSAGE('In Loop %1-%2',UserSetup."User ID",UserSetup."Indent Limit");
        END ELSE BEGIN
            //MESSAGE('Out Loop');
            EXIT;
        END;



    end;


    procedure GetLastPurchasePrice(ItemNo: Code[20]; var SkdPrice: Decimal; var DRAPrice: Decimal; var HSKPrice: Decimal)
    var
        PurchInvLine: Record "Purch. Inv. Line";
    begin
        IF ItemNo = '' THEN
            EXIT;
        PurchInvLine.RESET;
        PurchInvLine.SETCURRENTKEY("No.", "Posting Date");
        PurchInvLine.SETRANGE(Type, PurchInvLine.Type::Item);
        PurchInvLine.SETFILTER("No.", '%1', ItemNo);
        PurchInvLine.SETFILTER("Location Code", '%1', 'SKD-STORE');
        IF PurchInvLine.FINDLAST THEN
            SkdPrice := PurchInvLine."Direct Unit Cost";
        skdlpdate := PurchInvLine."Posting Date";

        PurchInvLine.SETFILTER("Location Code", '%1', 'DRA-STORE');
        IF PurchInvLine.FINDLAST THEN
            DRAPrice := PurchInvLine."Direct Unit Cost";
        dralpdate := PurchInvLine."Posting Date";

        PurchInvLine.SETFILTER("Location Code", '%1', 'HSK-STORE');
        IF PurchInvLine.FINDLAST THEN
            HSKPrice := PurchInvLine."Direct Unit Cost";
        hsklpdate := PurchInvLine."Posting Date";
    end;
}

