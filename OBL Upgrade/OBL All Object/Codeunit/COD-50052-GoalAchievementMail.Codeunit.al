codeunit 50052 "Goal Achievement Mail"
{

    trigger OnRun()
    begin
        StartProcessDate := 20230101D;
        EndProcessDate := 20230131D;
        //StartProcessDate := CALCDATE('-1M', CALCDATE('-CM',TODAY));
        //EndProcessDate := CALCDATE('+CM', StartProcessDate);

        IF GUIALLOWED THEN
            IF CONFIRM('Do you want to send Goal Achievement mail?') THEN BEGIN
                GenerateFiles_ForGoalAchmnt;
                MailtoSP_SalesPersonGoalAchmnt;

                MailtoPCH_PCHGoalAchmnt;
                MailtoZH_PCHGoalAchmnt;
                MailtoZM_GoalAchmnt; //MSKS

                MESSAGE('Done');
            END;
    end;

    var
        SchemeJobQueue: Codeunit "Scheme Job Queue";
        pchvar: Code[20];
        Text0001: Label 'At the beginning of the year, we shared the goal sheet for Year 2022-23 with you. Now, it is very essential for you to know where you stand at the end of every month against those goals. To keep you updated on your performance, we are pleased to start Monthly / YTD Performance goal sheet score (attached).';
        Text0002: Label 'This would be mailed to you at the end of every month which would help you to track your performance levels against all the agreed goals. I am sure that it would be of immediate help to you to track your own performance & improve on the same. A copy of the same would also be sent to your Reporting Manager so that there can be constructive discussion and planning to increase your YTD Score.*';
        Text0003: Label '* The Year and appraisals will be based on the relative score. Employees with higher score will get better ratings and rewards.';
        StartProcessDate: Date;
        EndProcessDate: Date;
        PCHGoalAchvmnt: Record "Sales Person Goal Details";
        Report50313: Report "Sales Person Goal Sheet BH";


    procedure GenerateFiles_ForGoalAchmnt()
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Report50155: Report "Sales Person Goal Sheet SP";
        SalesPersonGoalDetails: Record "Sales Person Goal Details";
        txtfile: Text;
        CurrentMonth: Date;
        Report50098: Report "Sales Person Goal Sheet ZH/ZM";
    begin
        //Generate files for Sales Person
        SalespersonPurchaser.RESET;
        SalespersonPurchaser.SETRANGE(Status, SalespersonPurchaser.Status::Enable);
        //SalespersonPurchaser.SETRANGE(Code, '1110076');
        IF SalespersonPurchaser.FINDFIRST THEN
            REPEAT
                SalesPersonGoalDetails.RESET;
                SalesPersonGoalDetails.SETRANGE("FF Type", SalesPersonGoalDetails."FF Type"::"Sales Person");
                SalesPersonGoalDetails.SETRANGE("Field Force Code", SalespersonPurchaser.Code);
                SalesPersonGoalDetails.SETFILTER("For Month", '%1', StartProcessDate);

                IF SalesPersonGoalDetails.FINDFIRST THEN BEGIN
                    SalesPersonGoalDetails.CALCFIELDS("Tableau Zone");
                    IF SalesPersonGoalDetails."Revenue Achieved" <> 0 THEN BEGIN
                        IF SalesPersonGoalDetails."Tableau Zone" <> 'CKA' THEN BEGIN //MSKS Added 01082019
                            CLEAR(Report50155);
                            Report50155.SetReportDate(StartProcessDate);
                            Report50155.SETTABLEVIEW(SalesPersonGoalDetails);
                            txtfile := CONVERTSTR(SalesPersonGoalDetails."Field Force Code", '\', '_');
                            // Report50155.SAVEASEXCEL('C:\SalesPersonGoalAchievement\' + 'GS_' + txtfile + '.xlsx');
                        END;
                    END;
                END;
            UNTIL SalespersonPurchaser.NEXT = 0;

        //Generate files for PCH

        SalespersonPurchaser.RESET;
        SalespersonPurchaser.SETRANGE(Status, SalespersonPurchaser.Status::Enable);
        IF SalespersonPurchaser.FINDFIRST THEN
            REPEAT
                PCHGoalAchvmnt.RESET;
                PCHGoalAchvmnt.SETRANGE("FF Type", PCHGoalAchvmnt."FF Type"::PCH);
                PCHGoalAchvmnt.SETRANGE("Field Force Code", SalespersonPurchaser.Code);
                PCHGoalAchvmnt.SETFILTER("For Month", '%1', StartProcessDate);
                IF PCHGoalAchvmnt.FINDFIRST THEN BEGIN
                    CLEAR(Report50313);
                    Report50313.SetReportDate(StartProcessDate);
                    Report50313.SETTABLEVIEW(PCHGoalAchvmnt);
                    txtfile := CONVERTSTR(PCHGoalAchvmnt."Field Force Code", '\', '_');
                    // Report50313.SAVEASEXCEL('C:\SalesPersonGoalAchievement\' + 'GS_' + txtfile + '.xlsx');
                END;
            UNTIL SalespersonPurchaser.NEXT = 0;

        //ZM Start

        SalespersonPurchaser.RESET;
        SalespersonPurchaser.SETRANGE(Status, SalespersonPurchaser.Status::Enable);
        IF SalespersonPurchaser.FINDFIRST THEN
            REPEAT
                PCHGoalAchvmnt.RESET;
                PCHGoalAchvmnt.SETRANGE("FF Type", PCHGoalAchvmnt."FF Type"::"Zonal Manager");
                PCHGoalAchvmnt.SETRANGE("Field Force Code", SalespersonPurchaser.Code);
                PCHGoalAchvmnt.SETFILTER("For Month", '%1', StartProcessDate);
                IF PCHGoalAchvmnt.FINDFIRST THEN BEGIN
                    CLEAR(Report50313);
                    Report50313.SetReportDate(StartProcessDate);
                    Report50313.SETTABLEVIEW(PCHGoalAchvmnt);
                    txtfile := CONVERTSTR(PCHGoalAchvmnt."Field Force Code", '\', '_');
                    // Report50313.SAVEASEXCEL('C:\SalesPersonGoalAchievement\' + 'GS_' + txtfile + '.xlsx');
                END;
            UNTIL SalespersonPurchaser.NEXT = 0;
        //ZM End


        SalespersonPurchaser.RESET;
        SalespersonPurchaser.SETRANGE(Status, SalespersonPurchaser.Status::Enable);
        IF SalespersonPurchaser.FINDFIRST THEN
            REPEAT
                PCHGoalAchvmnt.RESET;
                PCHGoalAchvmnt.SETRANGE("FF Type", PCHGoalAchvmnt."FF Type"::ZH);
                PCHGoalAchvmnt.SETRANGE("Field Force Code", SalespersonPurchaser.Code);
                PCHGoalAchvmnt.SETFILTER("For Month", '%1', StartProcessDate);
                IF PCHGoalAchvmnt.FINDFIRST THEN BEGIN
                    CLEAR(Report50098);
                    Report50098.SetReportDate(StartProcessDate);
                    Report50098.SETTABLEVIEW(PCHGoalAchvmnt);
                    txtfile := CONVERTSTR(PCHGoalAchvmnt."Field Force Code", '\', '_');
                    // Report50098.SAVEASEXCEL('C:\SalesPersonGoalAchievement\' + 'GS_' + txtfile + '.xlsx');
                END;
            UNTIL SalespersonPurchaser.NEXT = 0;

        /*
        SalespersonPurchaser.RESET;
        SalespersonPurchaser.SETRANGE(Status, SalespersonPurchaser.Status::Enable);
        IF SalespersonPurchaser.FINDFIRST THEN REPEAT
          SalesPersonGoalDetails.RESET;
          SalesPersonGoalDetails.SETRANGE("FF Type", SalesPersonGoalDetails."FF Type"::PCH);
          SalesPersonGoalDetails.SETRANGE("Field Force Code", SalespersonPurchaser.Code);
          SalesPersonGoalDetails.SETFILTER("For Month", '%1', StartProcessDate);
        
          IF SalesPersonGoalDetails.FINDFIRST THEN BEGIN
            SalesPersonGoalDetails.CALCFIELDS("Tableau Zone");
            IF SalesPersonGoalDetails."Revenue Achieved"<>0 THEN BEGIN
            IF SalesPersonGoalDetails."Tableau Zone"<>'CKA' THEN BEGIN //MSKS Added 01082019
            CLEAR(Report50155);
            Report50155.SetReportDate(StartProcessDate);
            Report50155.SETTABLEVIEW(SalesPersonGoalDetails);
            txtfile :=  CONVERTSTR(SalesPersonGoalDetails."Field Force Code",'\','_');
            Report50155.SAVEASEXCEL('C:\SalesPersonGoalAchievement\'+'GS_'+txtfile+'.xlsx');
            END;
            END;
          END;
        UNTIL SalespersonPurchaser.NEXT=0;
        */

    end;


    procedure MailtoSP_SalesPersonGoalAchmnt()
    var
        //  SMTPSetup: Record 409;
        //  SMTPMailCodeUnit: Codeunit 400;
        SalesPersons: Record "Salesperson/Purchaser";
        SalesPersonGoalDetails: Record "Sales Person Goal Details";
        CurrentMonth: Date;
        EmailAddress: Text[250];
        InCorrectMail: Boolean;
        NoOfAtSigns: Integer;
        i: Integer;
        txtfile: Text;
        PCHMaster: Record "Salesperson/Purchaser";
        ZHMaster: Record "Salesperson/Purchaser";

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
        SalesPersons.RESET;
        //SalesPersons.SETFILTER(Code,'%1','1110076');
        SalesPersons.SETRANGE(SalesPersons.Status, SalesPersons.Status::Enable);
        IF SalesPersons.FINDFIRST THEN
            REPEAT
                SalesPersonGoalDetails.RESET;
                SalesPersonGoalDetails.SETRANGE("FF Type", SalesPersonGoalDetails."FF Type"::"Sales Person");
                SalesPersonGoalDetails.SETFILTER("For Month", '%1', StartProcessDate);
                SalesPersonGoalDetails.SETRANGE("Field Force Code", SalesPersons.Code);
                IF SalesPersonGoalDetails.FINDFIRST THEN BEGIN
                    SalesPersonGoalDetails.CALCFIELDS("Tableau Zone");
                    IF SalesPersonGoalDetails."Revenue Achieved" <> 0 THEN BEGIN
                        IF SalesPersonGoalDetails."Tableau Zone" <> 'CKA' THEN BEGIN //MSKS Added 01082019
                            IF PCHMaster.GET(SalesPersonGoalDetails.PCH) THEN
                                EmailAddress := SalesPersons."E-Mail";
                            InCorrectMail := FALSE;
                            NoOfAtSigns := 0;
                            FOR i := 1 TO STRLEN(EmailAddress) DO BEGIN
                                IF EmailAddress[i] = '@' THEN
                                    NoOfAtSigns := NoOfAtSigns + 1;
                                IF (((EmailAddress[i] >= 'a') AND (EmailAddress[i] <= 'z')) OR ((EmailAddress[i] >= 'A') AND (EmailAddress[i] <= 'Z')) OR
                                  ((EmailAddress[i] >= '0') AND (EmailAddress[i] <= '9')) OR (EmailAddress[i] IN ['@', '.', '-', '_'])) THEN BEGIN
                                END ELSE BEGIN
                                    InCorrectMail := TRUE;
                                END
                            END;
                            IF InCorrectMail = FALSE THEN BEGIN
                                //  SMTPSetup.GET();
                                //SMTPMailCodeUnit.CreateMessage('Pinaki Nandy',SMTPSetup."User ID",
                                //SalesPersons."E-Mail",'Sales Person Goal Achievement - '+SalesPersons.Name+'For the Month Ending '+FORMAT(CurrentMonth),'',TRUE);
                                /* SMTPMailCodeUnit.CreateMessage('Pinaki Nandy', SMTPSetup."Sender Email",
                                       SalesPersons."E-Mail", 'SP Goal Achievement - ' + FORMAT(StartProcessDate, 0, '<Month Text> <Year4>') + ' - ' + SalesPersons.Name, '', TRUE);*/ // 15578
                                EmailAddressList.Add(SalesPersons."E-Mail");
                                EmailCCList.add('Kulbhushan.sharma@orientbell.com');
                                // SMTPMailCodeUnit.AddCC('ithelpdesk@orientbell.com');
                                IF PCHMaster."E-Mail" <> '' THEN
                                    EmailCCList.add(PCHMaster."E-Mail");

                                IF ZHMaster.GET(SalesPersonGoalDetails.ZH) THEN
                                    IF ZHMaster."E-Mail" <> '' THEN
                                        EmailCCList.add(ZHMaster."E-Mail");

                                IF SalesPersons.Name <> '' THEN
                                    BodyText := 'Dear  ' + SalesPersons.Name
                                ELSE
                                    BodyText := 'Dear';
                                BodyText += '<br><br>';
                                BodyText += Text0001;
                                BodyText += '<br><br>';
                                BodyText += Text0002;
                                BodyText += '<br><br>';
                                //BodyText +='@Reporting Manager – '+PCHMaster.Name + Text0003;
                                //BodyText +='<br><br>';
                                BodyText += 'Regards, <br>';
                                BodyText += 'Orient Bell Limited <br>';
                                BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
                                BodyText += 'New Delhi 110046, India <br>';
                                BodyText += 'Tel. +91 11 4711 9100 <br>';
                                BodyText += 'Fax. +91 11 2852 1273 <br>';
                                BodyText += '<br>';
                                //BodyText +='CC - PCH/ZH/CHRO<br>';
                                BodyText += '<br>';
                                BodyText += Text0003;
                                txtfile := 'GS_' + CONVERTSTR(SalesPersons.Code, '\', '_');
                                /* if File.Exists('C:\SalesPersonGoalAchievement\' + txtfile + '.xlsx') THEN BEGIN
                                    FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\SalesPersonGoalAchievement\' + txtfile + '.xlsx');
                                    if TempBlobCU.HasValue() then begin
                                        TempBlobCU.CreateInStream(InstreamVar);
                                        EmailMsg.Create(EmailAddressList, 'SP Goal Achievement - ', BodyText, true, EmailBccList, EmailCCList);
                                        if File.Exists('C:\SalesPersonGoalAchievement\' + txtfile + '.xlsx') THEN
                                            EmailMsg.AddAttachment('C:\SalesPersonGoalAchievement\' + txtfile + '.xlsx', 'application/pdf', InstreamVar);
                                        EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                                    END;

 */
                                /* IF (EXISTS('C:\SalesPersonGoalAchievement\' + txtfile + '.xlsx')) THEN BEGIN
                                     SMTPMailCodeUnit.AddAttachment('C:\SalesPersonGoalAchievement\' + txtfile + '.xlsx', txtfile + '.xlsx');
                                     SMTPMailCodeUnit.Send();
                                 END;*/
                                // END;
                            END;
                        END;
                    END; //MSKS
                end;
            UNTIL SalesPersons.NEXT = 0;
    end;


    procedure MailtoPCH_PCHGoalAchmnt()
    var
        //  SMTPSetup: Record 409;
        //  SMTPMailCodeUnit: Codeunit 400;
        SalesPersons: Record "Salesperson/Purchaser";
        SalesPersonGoalDetails: Record "Sales Person Goal Details";
        CurrentMonth: Date;
        EmailAddress: Text[250];
        InCorrectMail: Boolean;
        NoOfAtSigns: Integer;
        i: Integer;
        txtfile: Text;
        ZHMaster: Record "Salesperson/Purchaser";
        ZMMaster: Record "Salesperson/Purchaser";
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
        SalesPersons.RESET;
        SalesPersons.SETRANGE(SalesPersons.Status, SalesPersons.Status::Enable);
        IF SalesPersons.FINDFIRST THEN
            REPEAT
                PCHGoalAchvmnt.RESET;
                PCHGoalAchvmnt.SETRANGE("FF Type", PCHGoalAchvmnt."FF Type"::PCH);
                PCHGoalAchvmnt.SETFILTER("For Month", '%1', StartProcessDate);
                PCHGoalAchvmnt.SETRANGE("Field Force Code", SalesPersons.Code);
                IF PCHGoalAchvmnt.FINDFIRST THEN
                    REPEAT
                        EmailAddress := SalesPersons."E-Mail";
                        InCorrectMail := FALSE;
                        NoOfAtSigns := 0;
                        FOR i := 1 TO STRLEN(EmailAddress) DO BEGIN
                            IF EmailAddress[i] = '@' THEN
                                NoOfAtSigns := NoOfAtSigns + 1;
                            IF (((EmailAddress[i] >= 'a') AND (EmailAddress[i] <= 'z')) OR ((EmailAddress[i] >= 'A') AND (EmailAddress[i] <= 'Z')) OR
                              ((EmailAddress[i] >= '0') AND (EmailAddress[i] <= '9')) OR (EmailAddress[i] IN ['@', '.', '-', '_'])) THEN BEGIN
                            END ELSE BEGIN
                                InCorrectMail := TRUE;
                            END
                        END;
                        IF InCorrectMail = FALSE THEN BEGIN
                            // SMTPSetup.GET();
                            //SMTPMailCodeUnit.CreateMessage('Pinaki Nandy',SMTPSetup."User ID",
                            //      SalesPersons."E-Mail",'Sales Person Goal Achievement - '+SalesPersons.Name+'For the Month Ending '+FORMAT(CurrentMonth),'',TRUE);
                            /*  SMTPMailCodeUnit.CreateMessage('Pinaki Nandy', SMTPSetup."Sender Email",
                                    SalesPersons."E-Mail", 'BH Goal Achievement - ' + FORMAT(StartProcessDate) + ' - ' + SalesPersons.Name, '', TRUE);*/ // 15578
                            EmailAddressList.Add(SalesPersons."E-Mail");
                            EmailCCList.add('Kulbhushan.sharma@orientbell.com');
                            ///  SMTPMailCodeUnit.AddCC('ithelpdesk@orientbell.com');

                            IF ZHMaster.GET(PCHGoalAchvmnt.ZH) THEN
                                IF ZHMaster."E-Mail" <> '' THEN
                                    EmailCCList.add(ZHMaster."E-Mail");

                            IF ZMMaster.GET(PCHGoalAchvmnt.ZM) THEN
                                IF ZMMaster."E-Mail" <> '' THEN
                                    EmailCCList.add(ZMMaster."E-Mail");

                            IF SalesPersons.Name <> '' THEN
                                BodyText := 'Dear  ' + SalesPersons.Name
                            ELSE
                                BodyText += 'Dear  ';
                            BodyText += '<br><br>';
                            BodyText += Text0001;
                            BodyText += '<br><br>';
                            BodyText += Text0002;
                            BodyText += '<br><br>';
                            //BodyText  +='@Reporting Manager – '+PCHMaster.Name + Text0003;
                            //BodyText  +='<br><br>';
                            BodyText += 'Regards, <br>';
                            BodyText += 'Orient Bell Limited <br>';
                            BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
                            BodyText += 'New Delhi 110046, India <br>';
                            BodyText += 'Tel. +91 11 4711 9100 <br>';
                            BodyText += 'Fax. +91 11 2852 1273 <br>';
                            BodyText += '<br>';
                            //BodyText  +='CC - PCH/ZH/CHRO<br>';
                            BodyText += '<br>';
                            BodyText += Text0003;
                            txtfile := 'GS_' + CONVERTSTR(SalesPersons.Code, '\', '_');
                            /* if File.Exists('C:\SalesPersonGoalAchievement\' + txtfile + '.xlsx') THEN BEGIN
                                FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\SalesPersonGoalAchievement\' + txtfile + '.xlsx');
                                if TempBlobCU.HasValue() then begin
                                    TempBlobCU.CreateInStream(InstreamVar);
                                    EmailMsg.Create(EmailAddressList, 'SP Goal Achievement - ' + FORMAT(StartProcessDate, 0, '<Month Text> <Year4>') + ' - ' + SalesPersons.Name, BodyText, true, EmailBccList, EmailCCList);
                                    if File.Exists('C:\SalesPersonGoalAchievement\' + txtfile + '.xlsx') THEN
                             */
                            EmailMsg.AddAttachment('C:\Broucher\' + 'OrientBellNewLaunches.jpg', 'application/pdf', InstreamVar);
                            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                        END;

                    /*  IF (EXISTS('C:\SalesPersonGoalAchievement\' + txtfile + '.xlsx')) THEN BEGIN
                          SMTPMailCodeUnit.AddAttachment('C:\SalesPersonGoalAchievement\' + txtfile + '.xlsx', txtfile + '.xlsx');
                          SMTPMailCodeUnit.Send();
                      END;*/
                    // END;
                    // end;
                    UNTIL PCHGoalAchvmnt.NEXT = 0;
            UNTIL SalesPersons.NEXT = 0;
    end;


    procedure MailtoZM_GoalAchmnt()
    var
        //  SMTPSetup: Record 409;
        // SMTPMailCodeUnit: Codeunit 400;
        SalesPersons: Record "Salesperson/Purchaser";
        SalesPersonGoalDetails: Record "Sales Person Goal Details";
        CurrentMonth: Date;
        EmailAddress: Text[250];
        InCorrectMail: Boolean;
        NoOfAtSigns: Integer;
        i: Integer;
        txtfile: Text;
        ZHMaster: Record "Salesperson/Purchaser";
        ZMMaster: Record "Salesperson/Purchaser";
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
        SalesPersons.RESET;
        SalesPersons.SETRANGE(SalesPersons.Status, SalesPersons.Status::Enable);
        IF SalesPersons.FINDFIRST THEN
            REPEAT
                PCHGoalAchvmnt.RESET;
                PCHGoalAchvmnt.SETRANGE("FF Type", PCHGoalAchvmnt."FF Type"::"Zonal Manager");
                PCHGoalAchvmnt.SETFILTER("For Month", '%1', StartProcessDate);
                PCHGoalAchvmnt.SETRANGE("Field Force Code", SalesPersons.Code);
                IF PCHGoalAchvmnt.FINDFIRST THEN
                    REPEAT
                        EmailAddress := SalesPersons."E-Mail";
                        InCorrectMail := FALSE;
                        NoOfAtSigns := 0;
                        FOR i := 1 TO STRLEN(EmailAddress) DO BEGIN
                            IF EmailAddress[i] = '@' THEN
                                NoOfAtSigns := NoOfAtSigns + 1;
                            IF (((EmailAddress[i] >= 'a') AND (EmailAddress[i] <= 'z')) OR ((EmailAddress[i] >= 'A') AND (EmailAddress[i] <= 'Z')) OR
                              ((EmailAddress[i] >= '0') AND (EmailAddress[i] <= '9')) OR (EmailAddress[i] IN ['@', '.', '-', '_'])) THEN BEGIN
                            END ELSE BEGIN
                                InCorrectMail := TRUE;
                            END
                        END;
                        IF InCorrectMail = FALSE THEN BEGIN
                            // SMTPSetup.GET();
                            //SMTPMailCodeUnit.CreateMessage('Pinaki Nandy',SMTPSetup."User ID",
                            //      SalesPersons."E-Mail",'Sales Person Goal Achievement - '+SalesPersons.Name+'For the Month Ending '+FORMAT(CurrentMonth),'',TRUE);
                            /*  SMTPMailCodeUnit.CreateMessage('Pinaki Nandy', SMTPSetup."Sender Email",
                                    SalesPersons."E-Mail", 'Zonal Manager Goal Achievement - ' + FORMAT(StartProcessDate) + ' - ' + SalesPersons.Name, '', TRUE);*/ // 15578
                            EmailAddressList.Add(SalesPersons."E-Mail");
                            EmailCCList.add('Kulbhushan.sharma@orientbell.com');
                            //      SMTPMailCodeUnit.AddCC('ithelpdesk@orientbell.com');
                            IF ZHMaster.GET(PCHGoalAchvmnt.ZH) THEN
                                IF ZHMaster."E-Mail" <> '' THEN
                                    EmailCCList.add(ZHMaster."E-Mail");

                            IF ZMMaster.GET(PCHGoalAchvmnt.ZM) THEN
                                IF ZMMaster."E-Mail" <> '' THEN
                                    EmailCCList.add(ZMMaster."E-Mail");

                            IF SalesPersons.Name <> '' THEN
                                BodyText := 'Dear  ' + SalesPersons.Name
                            ELSE
                                BodyText += 'Dear  ';
                            BodyText += '<br><br>';
                            BodyText += Text0001;
                            BodyText += '<br><br>';
                            BodyText += Text0002;
                            BodyText += '<br><br>';
                            //BodyText +='@Reporting Manager – '+PCHMaster.Name + Text0003;
                            //BodyText +='<br><br>';
                            BodyText += 'Regards, <br>';
                            BodyText += 'Orient Bell Limited <br>';
                            BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
                            BodyText += 'New Delhi 110046, India <br>';
                            BodyText += 'Tel. +91 11 4711 9100 <br>';
                            BodyText += 'Fax. +91 11 2852 1273 <br>';
                            BodyText += '<br>';
                            //BodyText +='CC - PCH/ZH/CHRO<br>';
                            BodyText += '<br>';
                            BodyText += Text0003;
                            txtfile := 'GS_' + CONVERTSTR(SalesPersons.Code, '\', '_');
                            /* if File.Exists('C:\SalesPersonGoalAchievement\' + txtfile + '.xlsx') THEN BEGIN
                                FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\SalesPersonGoalAchievement\' + txtfile + '.xlsx');
                                if TempBlobCU.HasValue() then begin
                                    TempBlobCU.CreateInStream(InstreamVar);
                                    EmailMsg.Create(EmailAddressList, 'Zonal Manager Goal Achievement - ' + FORMAT(StartProcessDate) + ' - ' + SalesPersons.Name, BodyText, true, EmailBccList, EmailCCList);
                                    if File.Exists('C:\SalesPersonGoalAchievement\' + txtfile + '.xlsx') THEN
                             */
                            EmailMsg.AddAttachment('C:\SalesPersonGoalAchievement\' + txtfile + '.xlsx', 'application/pdf', InstreamVar);
                            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                        END;
                    /* IF (EXISTS('C:\SalesPersonGoalAchievement\' + txtfile + '.xlsx')) THEN BEGIN
                         SMTPMailCodeUnit.AddAttachment('C:\SalesPersonGoalAchievement\' + txtfile + '.xlsx', txtfile + '.xlsx');
                         SMTPMailCodeUnit.Send();
                     END;*/
                    // END;
                    // end;
                    UNTIL PCHGoalAchvmnt.NEXT = 0;
            UNTIL SalesPersons.NEXT = 0;
    end;


    procedure MailtoZH_PCHGoalAchmnt()
    var
        //   SMTPSetup: Record 409;
        //  SMTPMailCodeUnit: Codeunit 400;
        SalesPersons: Record "Salesperson/Purchaser";
        SalesPersonGoalDetails: Record "Sales Person Goal Details";
        CurrentMonth: Date;
        EmailAddress: Text[250];
        InCorrectMail: Boolean;
        NoOfAtSigns: Integer;
        i: Integer;
        txtfile: Text;
        ZHMaster: Record "Salesperson/Purchaser";
        ZMMaster: Record "Salesperson/Purchaser";
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

        SalesPersons.RESET;
        //SalesPersons.SETFILTER(Code,'%1','1110017');
        SalesPersons.SETRANGE(SalesPersons.Status, SalesPersons.Status::Enable);
        IF SalesPersons.FINDFIRST THEN
            REPEAT
                PCHGoalAchvmnt.RESET;
                PCHGoalAchvmnt.SETRANGE("FF Type", PCHGoalAchvmnt."FF Type"::ZH);
                PCHGoalAchvmnt.SETFILTER("For Month", '%1', StartProcessDate);
                PCHGoalAchvmnt.SETRANGE("Field Force Code", SalesPersons.Code);
                IF PCHGoalAchvmnt.FINDFIRST THEN
                    REPEAT
                        EmailAddress := SalesPersons."E-Mail";
                        InCorrectMail := FALSE;
                        NoOfAtSigns := 0;
                        FOR i := 1 TO STRLEN(EmailAddress) DO BEGIN
                            IF EmailAddress[i] = '@' THEN
                                NoOfAtSigns := NoOfAtSigns + 1;
                            IF (((EmailAddress[i] >= 'a') AND (EmailAddress[i] <= 'z')) OR ((EmailAddress[i] >= 'A') AND (EmailAddress[i] <= 'Z')) OR
                              ((EmailAddress[i] >= '0') AND (EmailAddress[i] <= '9')) OR (EmailAddress[i] IN ['@', '.', '-', '_'])) THEN BEGIN
                            END ELSE BEGIN
                                InCorrectMail := TRUE;
                            END
                        END;
                        IF InCorrectMail = FALSE THEN BEGIN
                            //  SMTPSetup.GET();
                            //    SMTPMailCodeUnit.CreateMessage('Pinaki Nandy',SMTPSetup."User ID",
                            //         'kulwant@mindshell.info','ZH Goal Achievement - '+SalesPersons.Name+'For the Month Ending '+FORMAT(CurrentMonth),'',TRUE);
                            /*  SMTPMailCodeUnit.CreateMessage('Pinaki Nandy', SMTPSetup."Sender Email",
                                    SalesPersons."E-Mail", 'ZH Goal Achievement - ' + FORMAT(StartProcessDate) + ' - ' + SalesPersons.Name, '', TRUE);*/ // 15578
                            EmailAddressList.Add(SalesPersons."E-Mail");
                            EmailCCList.add('Kulbhushan.sharma@orientbell.com');
                            EmailCCList.add('ithelpdesk@orientbell.com');

                            /*
                            IF ZHMaster.GET(PCHGoalAchvmnt.ZH) THEN
                              IF ZHMaster."E-Mail"<>'' THEN
                                SMTPMailCodeUnit.AddCC(ZHMaster."E-Mail");

                            IF ZMMaster.GET(PCHGoalAchvmnt.ZM) THEN
                              IF ZMMaster."E-Mail"<>'' THEN
                                SMTPMailCodeUnit.AddCC(ZMMaster."E-Mail");
                            */
                            IF SalesPersons.Name <> '' THEN
                                BodyText := 'Dear  ' + SalesPersons.Name
                            ELSE
                                BodyText += 'Dear  ';
                            BodyText += '<br><br>';
                            BodyText += Text0001;
                            BodyText += '<br><br>';
                            BodyText += Text0002;
                            BodyText += '<br><br>';
                            //BodyText +='@Reporting Manager – '+PCHMaster.Name + Text0003;
                            //BodyText +='<br><br>';
                            BodyText += 'Regards, <br>';
                            BodyText += 'Orient Bell Limited <br>';
                            BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
                            BodyText += 'New Delhi 110046, India <br>';
                            BodyText += 'Tel. +91 11 4711 9100 <br>';
                            BodyText += 'Fax. +91 11 2852 1273 <br>';
                            BodyText += '<br>';
                            //BodyText +='CC - PCH/ZH/CHRO<br>';
                            BodyText += '<br>';
                            BodyText += Text0003;
                            txtfile := 'GS_' + CONVERTSTR(SalesPersons.Code, '\', '_');
                            /* if File.Exists('C:\SalesPersonGoalAchievement\' + txtfile + '.xlsx') THEN BEGIN
                                FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\SalesPersonGoalAchievement\' + txtfile + '.xlsx');
                             */
                            if TempBlobCU.HasValue() then begin
                                TempBlobCU.CreateInStream(InstreamVar);
                                EmailMsg.Create(EmailAddressList, 'ZH Goal Achievement - ' + FORMAT(StartProcessDate) + ' - ' + SalesPersons.Name, BodyText, true, EmailBccList, EmailCCList);
                                // if File.Exists('C:\SalesPersonGoalAchievement\' + txtfile + '.xlsx') THEN
                                EmailMsg.AddAttachment('C:\SalesPersonGoalAchievement\' + txtfile + '.xlsx', 'application/pdf', InstreamVar);
                                EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                                // END;


                                /*  IF (EXISTS('C:\SalesPersonGoalAchievement\' + txtfile + '.xlsx')) THEN BEGIN
                                      SMTPMailCodeUnit.AddAttachment('C:\SalesPersonGoalAchievement\' + txtfile + '.xlsx', txtfile + '.xlsx');
                                      SMTPMailCodeUnit.Send();
                                  END;*/
                            END;
                        end;
                    UNTIL PCHGoalAchvmnt.NEXT = 0;
            UNTIL SalesPersons.NEXT = 0;

    end;
}

