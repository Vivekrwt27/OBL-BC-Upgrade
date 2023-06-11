codeunit 50041 "Send Incentive Mails"
{
    // --MSVRN 301117-- V1.00


    trigger OnRun()
    begin
        IF GUIALLOWED THEN
            IF CONFIRM('Do you want to send Incentive mail?') THEN
                GenerateFiles;
        MailtoZone;
        // 15578 MailtoPCH;
        MailtoSPs;
    end;

    var
        SchemeJobQueue: Codeunit "Scheme Job Queue";
        pchvar: Code[20];


    procedure GenerateFiles()
    var
        SalesPersons: Record "Salesperson/Purchaser";
        SalesPersonTarget: Record "Budget Master";
        Cust: Record Customer;
        Report50373: Report "Salesmen Incentive Report";
        txtfile: Text[250];
        SchemeMaster: Record "Scheme Master";
        SalePersonIncentiveDetailsREC: Record "Payment Terms Location Wise";
        CustREC: Record Customer;
    begin
        //Akash -201217
        SalesPersonTarget.RESET;
        // 15578    SalesPersonTarget.SETFILTER("Amount Utilised", '%1', CALCDATE('CM', TODAY));
        IF SalesPersonTarget.FINDFIRST THEN
            REPEAT
                SalePersonIncentiveDetailsREC.RESET;
                SalePersonIncentiveDetailsREC.SETRANGE(SalePersonIncentiveDetailsREC."Location Code", SalesPersonTarget."No.");
                // 15578     SalePersonIncentiveDetailsREC.SETRANGE(SalePersonIncentiveDetailsREC."Effective Month", SalesPersonTarget."Amount Utilised");
                IF SalePersonIncentiveDetailsREC.FINDFIRST THEN
                    REPEAT
                    /*   IF CustREC.GET(SalePersonIncentiveDetailsREC."Customer No.") THEN BEGIN
                           SalesPersonTarget."ZONAL MANAGER" := CustREC."Zonal Manager";
                           SalesPersonTarget.PCH := CustREC."PCH Code";
                           SalesPersonTarget."ZONAL HEAD" := CustREC."Zonal Head";
                           SalesPersonTarget.MODIFY;
                       END;*/ // 15578
                    UNTIL SalePersonIncentiveDetailsREC.NEXT = 0;
            UNTIL SalesPersonTarget.NEXT = 0;
        //Akash -201217

        //--Zonal-->>
        SalesPersons.RESET;
        SalesPersons.SETRANGE(SalesPersons.Status, SalesPersons.Status::Enable);
        IF SalesPersons.FINDFIRST THEN
            REPEAT
                SalesPersonTarget.RESET;
                /*    SalesPersonTarget.SETRANGE(SalesPersonTarget."ZONAL MANAGER", SalesPersons.Code);
                    SalesPersonTarget.SETFILTER("Amount Utilised", '%1', CALCDATE('CM', TODAY));*/ // 15578
                IF SalesPersonTarget.FINDFIRST THEN BEGIN
                    CLEAR(Report50373);
                    Report50373.SETTABLEVIEW(SalesPersonTarget);
                    txtfile := CONVERTSTR(SalesPersons.Code, '\', '_');
                    // Report50373.SAVEASEXCEL('C:\MailIncentive\Zonal\' + txtfile + '.xlsx'); //--1110017_1110010
                END;
            UNTIL SalesPersons.NEXT = 0;
        //--Zonal--<<

        //--PCH-->>
        SalesPersons.RESET;
        SalesPersons.SETRANGE(SalesPersons.Status, SalesPersons.Status::Enable);
        IF SalesPersons.FINDFIRST THEN
            REPEAT
                SalesPersonTarget.RESET;
                /*    SalesPersonTarget.SETRANGE(SalesPersonTarget.PCH, SalesPersons.Code);
                    SalesPersonTarget.SETRANGE(AssistEdit, SalesPersonTarget.AssistEdit::"1");
                    SalesPersonTarget.SETFILTER("Amount Utilised", '%1', CALCDATE('CM', TODAY));*/ // 15578
                IF SalesPersonTarget.FINDFIRST THEN BEGIN
                    CLEAR(Report50373);
                    Report50373.SETTABLEVIEW(SalesPersonTarget);
                    txtfile := CONVERTSTR(SalesPersons.Code, '\', '_');
                    // Report50373.SAVEASEXCEL('C:\MailIncentive\PCH\' + txtfile + '.xlsx');
                END;
            UNTIL SalesPersons.NEXT = 0;

        //--PCH--<<

        //--Sales Person-->>
        SalesPersons.RESET;
        SalesPersons.SETRANGE(SalesPersons.Status, SalesPersons.Status::Enable);
        IF SalesPersons.FINDFIRST THEN
            REPEAT
                SalesPersonTarget.RESET;
                SalesPersonTarget.SETFILTER("No.", '%1', SalesPersons.Code);
                /*    SalesPersonTarget.SETRANGE(AssistEdit, SalesPersonTarget.AssistEdit::"1");
                    SalesPersonTarget.SETFILTER("Amount Utilised", '%1', CALCDATE('CM', TODAY));*/ // 15578
                IF SalesPersonTarget.FINDFIRST THEN BEGIN
                    CLEAR(Report50373);
                    Report50373.SETTABLEVIEW(SalesPersonTarget);
                    txtfile := CONVERTSTR(SalesPersons.Code, '\', '_');
                    // Report50373.SAVEASEXCEL('C:\MailIncentive\SalesPerson\' + txtfile + '.xlsx');
                END;
            UNTIL SalesPersons.NEXT = 0;
        //--Sales Person--<<
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
        // SMTPMailCodeUnit: Codeunit 400;
        SalesPersonTarget: Record "Budget Master";
    begin
        SalesPersons.RESET;
        SalesPersons.SETRANGE(SalesPersons.Status, SalesPersons.Status::Enable);
        //SalesPersons.SETRANGE(Type, SalesPersons.Type::"Zone Manager");
        IF SalesPersons.FINDFIRST THEN
            REPEAT
                SalesPersonTarget.RESET;
                // 15578   SalesPersonTarget.SETFILTER("Amount Utilised", '%1', CALCDATE('CM', TODAY));
                SalesPersonTarget.SETRANGE("No.", SalesPersons.Code);
                IF SalesPersonTarget.FINDFIRST THEN BEGIN
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
                    /* 15578 IF InCorrectMail = FALSE THEN BEGIN
                         IF (STRPOS(SalesPersons."E-Mail", ' ') = 0) AND (SalesPersons."E-Mail" <> '') THEN BEGIN //--
                             SMTPSetup.GET();
                             SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', SMTPSetup."User ID",
                                   SalesPersons."E-Mail", 'Incentive Details - ' + SalesPersons.Name + 'For the Month Ending ' + FORMAT(SalesPersonTarget."Amount Utilised"), '', TRUE);
                             // 'virendra.kumar@mindshell.info','Scheme Details'+SchemeMaster.Code,'',TRUE); //--
                         END ELSE BEGIN
                             SMTPSetup.GET();
                             SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', SMTPSetup."User ID",
                                   SalesPersons."E-Mail", 'Incentive Details - ' + SalesPersons.Name + 'For the Month Ending ' + FORMAT(SalesPersonTarget."Amount Utilised"), '', TRUE);
                         END;
                         //SMTPMailCodeUnit.AddCC('donotreply@orientbell.com'); //--  041217
                         //SMTPMailCodeUnit.AddCC('erp@orientbell.com');
                         //SMTPMailCodeUnit.AddCC('rakesh.kumar@orientbell.com'); //-- 041217
                         //SMTPMailCodeUnit.AddCC('saurabh.batra@orientbell.com');
                         IF SalesPersons.Name <> '' THEN
                             SMTPMailCodeUnit.AppendBody('Dear  ' + SalesPersons.Name)
                         ELSE
                             SMTPMailCodeUnit.AppendBody('Dear  ');
                         SMTPMailCodeUnit.AppendBody('<br><br>');
                         SMTPMailCodeUnit.AppendBody('Please find the enclosed detail of Incentives. ');
                         SMTPMailCodeUnit.AppendBody('<br><br>');
                         SMTPMailCodeUnit.AppendBody('This is for your records');
                         SMTPMailCodeUnit.AppendBody('<br><br>');
                         SMTPMailCodeUnit.AppendBody('Regards, <br>');
                         SMTPMailCodeUnit.AppendBody('Orient Bell Limited <br>');
                         SMTPMailCodeUnit.AppendBody('Iris House, 16 Business Center, Nangal Raya <br>');
                         SMTPMailCodeUnit.AppendBody('New Delhi 110046, India <br>');
                         SMTPMailCodeUnit.AppendBody('Tel. +91 11 4711 9100 <br>');
                         SMTPMailCodeUnit.AppendBody('Fax. +91 11 2852 1273 <br>');
                         txtfile := CONVERTSTR(SalesPersons.Code, '\', '_');
                         IF (EXISTS('C:\MailIncentive\SalesPerson\' + txtfile + '.xlsx')) THEN BEGIN //--1110017_1110010
                                                                                                     // IF (EXISTS('C:\MailIncentive\PCH\'+'1110017_1110010'+'.xlsx')) THEN BEGIN
                                                                                                     //MESSAGE(txtfile); //--
                             SMTPMailCodeUnit.AddAttachment('C:\MailIncentive\SalesPerson\' + txtfile + '.xlsx', txtfile + '.xlsx');// --1110017_1110010
                                                                                                                                    // SMTPMailCodeUnit.AddAttachment('C:\MailIncentive\PCH\'+'1110017_1110010'+'.xlsx');
                             SMTPMailCodeUnit.Send();
                         END;
                     END;*/ // 15578
                END;
            UNTIL SalesPersons.NEXT = 0;
    end;


    /* 15578 begin
    procedure MailtoPCH()
    var
        SalesPersons: Record 13;
        DealerSchemeDetails: Record 50078;
        txtfile: Text[250];
        SchemeMaster: Record 50074;
        EmailAddress: Text[250];
        InCorrectMail: Boolean;
        NoOfAtSigns: Integer;
        i: Integer;
        // SMTPSetup: Record 409;
        // SMTPMailCodeUnit: Codeunit 400;
        SalesPersonTarget: Record 50084;
        SalesPersons.RESET;
        IF SalesPersons.FINDFIRST THEN
               REPEAT
                SalesPersonTarget.RESET;
                   SalesPersonTarget.SETRANGE(AssistEdit, SalesPersonTarget.AssistEdit::"1");
                   SalesPersonTarget.SETFILTER("Amount Utilised", '%1', CALCDATE('CM', TODAY));
                   SalesPersonTarget.SETRANGE(PCH, SalesPersons.Code);
                IF SalesPersonTarget.FINDFIRST THEN BEGIN
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
                    IF InCorrectMail = FALSE THEN BEGIN
                    IF (STRPOS(SalesPersons."E-Mail", ' ') = 0) AND (SalesPersons."E-Mail" <> '') THEN BEGIN //--
                            SMTPSetup.GET();
                            SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', SMTPSetup."User ID",
                              SalesPersons."E-Mail", 'Incentive Details - ' + SalesPersons.Name + 'For the Month Ending ' + FORMAT(SalesPersonTarget."Amount Utilised"), '', TRUE);
                            // 'virendra.kumar@mindshell.info','Scheme Details'+SchemeMaster.Code,'',TRUE); //--
                        END ELSE BEGIN
                            SMTPSetup.GET();
                            SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', SMTPSetup."User ID",
                                SMTPSetup."User ID", 'Incentive Details - ' + SalesPersons.Name + 'For the Month Ending ' + FORMAT(SalesPersonTarget."Amount Utilised"), '', TRUE);
                        END;
                        //SMTPMailCodeUnit.AddCC('donotreply@orientbell.com'); //--  041217
                        //SMTPMailCodeUnit.AddCC('erp@orientbell.com');
                        //SMTPMailCodeUnit.AddCC('rakesh.kumar@orientbell.com'); //-- 041217
                        //SMTPMailCodeUnit.AddCC('saurabh.batra@orientbell.com');
                        IF SalesPersons.Name <> '' THEN
                            SMTPMailCodeUnit.AppendBody('Dear  ' + SalesPersons.Name)
                        ELSE
                            SMTPMailCodeUnit.AppendBody('Dear  ');
                        SMTPMailCodeUnit.AppendBody('<br><br>');
                        SMTPMailCodeUnit.AppendBody('Please find the enclosed detail of Incentive. ');
                        SMTPMailCodeUnit.AppendBody('<br><br>');
                        SMTPMailCodeUnit.AppendBody('This is for your records');
                        SMTPMailCodeUnit.AppendBody('<br><br>');
                        SMTPMailCodeUnit.AppendBody('Regards, <br>');
                        SMTPMailCodeUnit.AppendBody('Orient Bell Limited <br>');
                        SMTPMailCodeUnit.AppendBody('Iris House, 16 Business Center, Nangal Raya <br>');
                        SMTPMailCodeUnit.AppendBody('New Delhi 110046, India <br>');
                        SMTPMailCodeUnit.AppendBody('Tel. +91 11 4711 9100 <br>');
                        SMTPMailCodeUnit.AppendBody('Fax. +91 11 2852 1273 <br>');
                        txtfile := CONVERTSTR(SalesPersons.Code, '\', '_');
                        IF (EXISTS('C:\MailIncentive\PCH\' + txtfile + '.xlsx')) THEN BEGIN //--1110017_1110010
                                                                                            // IF (EXISTS('C:\MailIncentive\PCH\'+'1110017_1110010'+'.xlsx')) THEN BEGIN
                                                                                            //MESSAGE(txtfile); //--
                            SMTPMailCodeUnit.AddAttachment('C:\MailIncentive\PCH\' + txtfile + '.xlsx', txtfile + '.xlsx');// --1110017_1110010
                                                                                                                           // SMTPMailCodeUnit.AddAttachment('C:\MailIncentive\PCH\'+'1110017_1110010'+'.xlsx');
                            SMTPMailCodeUnit.Send();
                        END;
                    END;
                    //END; //--
                    //END; //--
                END;
            UNTIL SalesPersons.NEXT = 0;
    end;*/


    procedure MailtoZone()
    var
        SalesPersons: Record "Salesperson/Purchaser";
        DealerSchemeDetails: Record "Customer Scheme Details";
        txtfile: Text[250];
        SchemeMaster: Record "Scheme Master";
        EmailAddress: Text[250];
        InCorrectMail: Boolean;
        NoOfAtSigns: Integer;
        i: Integer;
        //    SMTPSetup: Record 409;
        //   SMTPMailCodeUnit: Codeunit 400;
        SalesPersonTarget: Record "Budget Master";
    begin
        SalesPersons.RESET;
        IF SalesPersons.FINDFIRST THEN
            REPEAT
                SalesPersonTarget.RESET;
                /*     SalesPersonTarget.SETRANGE(SalesPersonTarget.AssistEdit, SalesPersonTarget.AssistEdit::"1", SalesPersonTarget.AssistEdit::"2");
                     SalesPersonTarget.SETRANGE(SalesPersonTarget."Amount Utilised", CALCDATE('CM', TODAY));
                     SalesPersonTarget.SETRANGE(SalesPersonTarget."ZONAL MANAGER", SalesPersons.Code);*/ // 15578
                IF SalesPersonTarget.FINDFIRST THEN BEGIN
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
                    /* 15578  IF InCorrectMail = FALSE THEN BEGIN
                          IF (STRPOS(SalesPersons."E-Mail", ' ') = 0) AND (SalesPersons."E-Mail" <> '') THEN BEGIN //--
                              SMTPSetup.GET();
                              SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', SMTPSetup."User ID",
                                  SalesPersons."E-Mail", 'Incentive Details - ' + SalesPersons.Name + 'For the Month Ending ' + FORMAT(SalesPersonTarget."Amount Utilised"), '', TRUE);
                              //'virendra.kumar@mindshell.info','Scheme Details'+SchemeMaster.Code,'',TRUE); //--
                          END ELSE BEGIN
                              SMTPSetup.GET();
                              SMTPMailCodeUnit.CreateMessage('Orient Bell Limited.', SMTPSetup."User ID",
                                  SalesPersons."E-Mail", 'Incentive Details - ' + SalesPersons.Name + 'For the Month Ending ' + FORMAT(SalesPersonTarget."Amount Utilised"), '', TRUE);
                          END;
                          //SMTPMailCodeUnit.AddCC('donotreply@orientbell.com'); //--  041217
                          SMTPMailCodeUnit.AddCC('erp@orientbell.com');
                          SMTPMailCodeUnit.AddCC('rakesh.kumar@orientbell.com'); //-- 041217
                          SMTPMailCodeUnit.AddCC('saurabh.batra@orientbell.com');
                          IF SalesPersons.Name <> '' THEN
                              SMTPMailCodeUnit.AppendBody('Dear  ' + SalesPersons.Name)
                          ELSE
                              SMTPMailCodeUnit.AppendBody('Dear  ');
                          SMTPMailCodeUnit.AppendBody('<br><br>');
                          SMTPMailCodeUnit.AppendBody('Please find the enclosed detail of Incentives. ');
                          SMTPMailCodeUnit.AppendBody('<br><br>');
                          SMTPMailCodeUnit.AppendBody('This is for your records');
                          SMTPMailCodeUnit.AppendBody('<br><br>');
                          SMTPMailCodeUnit.AppendBody('Regards, <br>');
                          SMTPMailCodeUnit.AppendBody('Orient Bell Limited <br>');
                          SMTPMailCodeUnit.AppendBody('Iris House, 16 Business Center, Nangal Raya <br>');
                          SMTPMailCodeUnit.AppendBody('New Delhi 110046, India <br>');
                          SMTPMailCodeUnit.AppendBody('Tel. +91 11 4711 9100 <br>');
                          SMTPMailCodeUnit.AppendBody('Fax. +91 11 2852 1273 <br>');
                          txtfile := CONVERTSTR(SalesPersons.Code, '\', '_');
                          IF (EXISTS('C:\MailIncentive\Zonal\' + txtfile + '.xlsx')) THEN BEGIN //--1110017_1110010
                                                                                                //IF (EXISTS('C:\MailIncentive\PCH\'+'1110017_1110010'+'.xlsx')) THEN BEGIN
                                                                                                //MESSAGE(txtfile); //--
                              SMTPMailCodeUnit.AddAttachment('C:\MailIncentive\Zonal\' + txtfile + '.xlsx', txtfile + '.xlsx');// --1110017_1110010
                                                                                                                               //SMTPMailCodeUnit.AddAttachment('C:\MailIncentive\PCH\'+'1110017_1110010'+'.xlsx');
                              SMTPMailCodeUnit.Send();
                          END;
                      END;*/ // 15578
                END;
            UNTIL SalesPersons.NEXT = 0;
    end;
}

