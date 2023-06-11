codeunit 50048 "TGT VS Achievement"
{

    trigger OnRun()
    begin
        SendToPCH; //--
        SendToZHorZM; //--
        //SendToCKA;
        SendToAll;

        SendEmailSalesDetails;
        MESSAGE('mails sent!');
    end;

    var
        //   SMTPSetup: Record 409;
        GlbFromDate: Date;
        GlbToDate: Date;
        MatrixMaster: Record "Matrix Master";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        MatrixMaster2: Record "Matrix Master";
        //  SMTPMailCodeUnit: Codeunit 400;
        ZHCode: Code[20];
        DescCode: Code[20];
        SalesTGTvsAchvmnt: Report "Sales TGT vs Achvmnt";
        EmailAddress: Text[100];
        Customer: Record Customer;
        DescCode1: Code[20];
        RepCollection: Report Collection;
        TODTgtVsAch: Report "TOD Tgt Vs Ach";
        EmailAddressZH: Text;
        RepEnterprise: Report Enterprise;
        textfile: array[5] of Text;
        filpath: array[5] of Text;
        Subject: Text;
        PendingOrders: Report "Pending Orders";

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

    local procedure SendToPCH()
    begin
        Clear(EmailAddressList);
        Clear(EmailCCList);
        Clear(EmailBccList);
        ///PCH
        CLEAR(textfile);
        CLEAR(filpath);
        MatrixMaster.RESET;
        MatrixMaster.SETCURRENTKEY("Mapping Type", "Type 1", "Type 2");
        MatrixMaster.ASCENDING;
        MatrixMaster.SETFILTER(ZH, '<>%1', '');
        //MatrixMaster.SETRANGE("Type 1", 'AGRA');
        MatrixMaster.SETFILTER(Description, '<>%1', '');
        IF MatrixMaster.FINDSET THEN
            REPEAT
                MatrixMaster2.RESET;
                MatrixMaster2.SETRANGE(PCH, MatrixMaster.PCH);
                MatrixMaster2.SETRANGE("Type 1", MatrixMaster."Type 1");
                IF MatrixMaster2.FINDFIRST THEN BEGIN
                    //------All 4 Reports---->>
                    //    CLEAR(SalespersonPurchaser);
                    IF SalespersonPurchaser.GET(MatrixMaster2.PCH) THEN;
                    //--1st Report--->>
                    CLEAR(SalesTGTvsAchvmnt);
                    SalesTGTvsAchvmnt.SETTABLEVIEW(MatrixMaster2);
                    textfile[1] := '-PCH-' + MatrixMaster2.PCH + 'Sales';
                    filpath[1] := 'C:\AutoMail\DailySalesReport\' + textfile[1] + '.xlsx';
                    // SalesTGTvsAchvmnt.SAVEASEXCEL('C:\AutoMail\DailySalesReport\' + textfile[1] + '.xlsx');
                    //--1st Report---<<

                    //--2nd Report--->>
                    CLEAR(RepCollection);
                    RepCollection.SETTABLEVIEW(MatrixMaster2);
                    textfile[2] := '-PCH-' + MatrixMaster2.PCH + 'Collection';
                    filpath[2] := 'C:\AutoMail\DailyCollection\' + textfile[2] + '.xlsx';
                    // RepCollection.SAVEASEXCEL('C:\AutoMail\DailyCollection\' + textfile[2] + '.xlsx');
                    //--2nd Report---<<

                    //--3rd Report--->> //MSVRN 060919 -->>
                    CLEAR(PendingOrders);
                    PendingOrders.SETTABLEVIEW(MatrixMaster2);
                    textfile[3] := '-PCH-' + MatrixMaster2.PCH + 'PendingOrders';
                    filpath[3] := 'C:\AutoMail\PendingOrders\' + textfile[3] + '.xlsx';
                    // PendingOrders.SAVEASEXCEL('C:\AutoMail\PendingOrders\' + textfile[3] + '.xlsx');
                    //--3rd Report---<<

                    //--4th Report--->>
                    Customer.RESET;
                    Customer.SETRANGE("PCH Code", MatrixMaster2.PCH);
                    IF Customer.FINDFIRST THEN BEGIN
                        CLEAR(TODTgtVsAch);
                        TODTgtVsAch.SETTABLEVIEW(Customer);
                        textfile[4] := '-PCH-' + MatrixMaster2.PCH + 'TgtVsAch';
                        filpath[4] := 'C:\AutoMail\TgtVsAch\' + textfile[4] + '.xlsx';
                        // TODTgtVsAch.SAVEASEXCEL('C:\AutoMail\TgtVsAch\' + textfile[4] + '.xlsx');
                    END;
                    //--4th Report---<<
                    //------All 4 Reports----<<

                    //Send PCH Mail
                    Subject := MatrixMaster2."Type 1" + 'Territory_Daliy Sales Tracker for the month of ' + CalcMonth(DATE2DMY(TODAY - 1, 2)) + ', ' +
                                  FORMAT(DATE2DMY(TODAY - 1, 3)) + ' as on ' + FORMAT(TODAY - 1);
                    /* SMTPSetup.GET;
                     SMTPSetup.TESTFIELD("User ID");
                     CLEAR(SMTPMailCodeUnit);*/

                    //   SMTPMailCodeUnit.CreateMessage('CSO Office - OBL', 'donotreply@orientbell.com', SalespersonPurchaser."E-Mail", Subject, '', TRUE);
                    EmailAddressList.Add('donotreply@orientbell.com');
                    //SMTPMailCodeUnit.CreateMessage('CSO Office - OBL',SMTPSetup."User ID",'virendra.kumar@mindshell.info',Subject,'',TRUE);
                    //SMTPMailCodeUnit.AddCC('kulbhushan.chaudhary@mindshell.info');
                    //SMTPMailCodeUnit.AddCC('Laxman.singh@orientbell.com');

                    //SMTPMailCodeUnit.AddCC('donotreply@orientbell.com');
                    EmailCCList.Add('donotreply@orientbell.com');
                    //SMTPMailCodeUnit.AddCC('bs.negi@orientbell.com'); //BS Negi

                    //--Body-->>
                    BodyText := 'Dear Mr. ' + SalespersonPurchaser.Name + ',';
                    BodyText += '<br><br>';
                    BodyText += 'Please find attached Daily Sales Tracker_ ' + CalcMonth(DATE2DMY(TODAY - 1, 2)) + ', ' +
                                                FORMAT(DATE2DMY(TODAY - 1, 3)) + ' as on ' + FORMAT(TODAY - 1);
                    BodyText += '<br><br>';
                    BodyText += 'Enclosed herewith below Tracker sheets:';
                    BodyText += '<br>';
                    BodyText += '1- Territory wise Sales Tracker <br>';
                    //SMTPMailCodeUnit.AppendBody('<br>');
                    BodyText += '2- Territory wise Collection Tracker <br>';
                    //SMTPMailCodeUnit.AppendBody('<br>');
                    BodyText += '3- Territory wise Pending Orders Tracker <br>';
                    //SMTPMailCodeUnit.AppendBody('4 - AOP Target Vs Achvmt Tracker <br>');
                    BodyText += '<br>';
                    BodyText += 'Thanks & Regards <br>';
                    //SMTPMailCodeUnit.AppendBody('<br>');
                    BodyText += 'CSO Office';
                    BodyText += '<br>';
                    BodyText += 'Orient Bell Ltd.';
                    //--Body--<<
                    /* if File.Exists(filpath[1]) THEN begin
                        FileMgmt.BLOBExportToServerFile(TempBlobCU, filpath[1]);
                        if TempBlobCU.HasValue() then begin
                            TempBlobCU.CreateInStream(InstreamVar);
                            EmailMsg.Create(EmailAddressList, Subject, BodyText, true, EmailBccList, EmailCCList);
                            if File.Exists(filpath[1]) THEN
                                EmailMsg.AddAttachment(filpath[1], 'application/pdf', InstreamVar);
                            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                        END;
                    end;
                    if File.Exists(filpath[2]) THEN begin
                        FileMgmt.BLOBExportToServerFile(TempBlobCU, filpath[1]);
                        if TempBlobCU.HasValue() then begin
                            TempBlobCU.CreateInStream(InstreamVar);
                            EmailMsg.Create(EmailAddressList, Subject, BodyText, true, EmailBccList, EmailCCList);
                            if File.Exists(filpath[2]) THEN
                                EmailMsg.AddAttachment(filpath[2], 'application/pdf', InstreamVar);
                            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                        END;
                    end;
                    if File.Exists(filpath[3]) THEN begin
                        FileMgmt.BLOBExportToServerFile(TempBlobCU, filpath[1]);
                        if TempBlobCU.HasValue() then begin
                            TempBlobCU.CreateInStream(InstreamVar);
                            EmailMsg.Create(EmailAddressList, Subject, BodyText, true, EmailBccList, EmailCCList);
                            if File.Exists(filpath[3]) THEN
                                EmailMsg.AddAttachment(filpath[3], 'application/pdf', InstreamVar);
                            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                        END;
                    end;
                    if File.Exists(filpath[4]) THEN begin
                        FileMgmt.BLOBExportToServerFile(TempBlobCU, filpath[1]);
                        if TempBlobCU.HasValue() then begin
                            TempBlobCU.CreateInStream(InstreamVar);
                            EmailMsg.Create(EmailAddressList, Subject, BodyText, true, EmailBccList, EmailCCList);
                            if File.Exists(filpath[4]) THEN
                                EmailMsg.AddAttachment(filpath[4], 'application/pdf', InstreamVar);
                            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                        END;
                    end;
 */
                    /*  IF (EXISTS(filpath[1])) THEN
                          SMTPMailCodeUnit.AddAttachment(filpath[1], filpath[1]);
                      IF (EXISTS(filpath[2])) THEN
                          SMTPMailCodeUnit.AddAttachment(filpath[2], filpath[2]);
                      IF (EXISTS(filpath[3])) THEN
                          SMTPMailCodeUnit.AddAttachment(filpath[3], filpath[3]);
                      IF (EXISTS(filpath[4])) THEN
                          SMTPMailCodeUnit.AddAttachment(filpath[4], filpath[4]);
                      SMTPMailCodeUnit.Send;*/ // 15578
                                               //MESSAGE('Sent');
                END;
            UNTIL MatrixMaster.NEXT = 0;
        ///PCH
    end;

    local procedure SendToZHorZM()
    var
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
        /////ZH
        CLEAR(textfile);
        CLEAR(filpath);
        MatrixMaster.RESET;
        MatrixMaster.SETCURRENTKEY(ZH, "Sorting Order", PCH);
        MatrixMaster.ASCENDING;
        MatrixMaster.SETFILTER(ZH, '<>%1', '');
        MatrixMaster.SETFILTER(Description, '<>%1', '');
        IF MatrixMaster.FINDSET THEN BEGIN
            REPEAT
                IF DescCode <> MatrixMaster.ZH THEN BEGIN
                    DescCode := MatrixMaster.ZH;
                    MatrixMaster2.RESET;
                    MatrixMaster2.SETRANGE(ZH, MatrixMaster.ZH);
                    MatrixMaster2.SETRANGE(Description, MatrixMaster.Description);
                    IF MatrixMaster2.FINDFIRST THEN BEGIN
                        CLEAR(SalespersonPurchaser);
                        IF SalespersonPurchaser.GET(MatrixMaster.ZH) THEN;
                        //EmailAddressZH := SalespersonPurchaser."E-Mail";

                        //--1st Report--->>
                        CLEAR(SalesTGTvsAchvmnt);
                        SalesTGTvsAchvmnt.SETTABLEVIEW(MatrixMaster2);
                        textfile[1] := '-ZH-' + MatrixMaster2.ZH + 'Sales';
                        filpath[1] := 'C:\AutoMail\DailySalesReport\' + textfile[1] + '.xlsx';
                        // SalesTGTvsAchvmnt.SAVEASEXCEL('C:\AutoMail\DailySalesReport\' + textfile[1] + '.xlsx');
                        //--1st Report---<<

                        //--2nd Report--->>
                        CLEAR(RepCollection);
                        RepCollection.SETTABLEVIEW(MatrixMaster2);
                        textfile[2] := '-ZH-' + MatrixMaster2.ZH + 'Collection';
                        filpath[2] := 'C:\AutoMail\DailyCollection\' + textfile[2] + '.xlsx';
                        // RepCollection.SAVEASEXCEL('C:\AutoMail\DailyCollection\' + textfile[2] + '.xlsx');
                        //--2nd Report---<<

                        //--3rd Report--->> //MSVRN 060919 -->>
                        CLEAR(PendingOrders);
                        PendingOrders.SETTABLEVIEW(MatrixMaster2);
                        textfile[3] := '-ZH-' + MatrixMaster2.ZH + 'PendingOrders';
                        filpath[3] := 'C:\AutoMail\PendingOrders\' + textfile[3] + '.xlsx';
                        // PendingOrders.SAVEASEXCEL('C:\AutoMail\PendingOrders\' + textfile[3] + '.xlsx');
                        //--3rd Report---<<

                        //--4th Report--->>
                        Customer.RESET;
                        Customer.SETRANGE("Zonal Head", MatrixMaster2.ZH);
                        IF Customer.FINDFIRST THEN BEGIN
                            CLEAR(TODTgtVsAch);
                            TODTgtVsAch.SETTABLEVIEW(Customer);
                            textfile[4] := '-ZH-' + MatrixMaster2.ZH + 'TgtVsAch';
                            filpath[4] := 'C:\AutoMail\TgtVsAch\' + textfile[4] + '.xlsx';
                            // TODTgtVsAch.SAVEASEXCEL('C:\AutoMail\TgtVsAch\' + textfile[4] + '.xlsx');
                        END;
                        //--4th Report---<<

                        //Send ZH Mail
                        Subject := MatrixMaster2.Description + ' Zone_Daliy Sales Tracker for the month of ' + CalcMonth(DATE2DMY(TODAY - 1, 2)) + ', ' +
                                  FORMAT(DATE2DMY(TODAY - 1, 3)) + ' as on ' + FORMAT(TODAY - 1);
                        /*  SMTPSetup.GET;
                          SMTPSetup.TESTFIELD("User ID");
                          CLEAR(SMTPMailCodeUnit);
                          SMTPMailCodeUnit.CreateMessage('CSO Office - OBL', 'donotreply@orientbell.com', SalespersonPurchaser."E-Mail", Subject, '', TRUE);//MSVRN open*/
                        //SMTPMailCodeUnit.CreateMessage('CSO Office - OBL',SMTPSetup."User ID",'virendra.kumar@mindshell.info',Subject,'',TRUE);

                        EmailAddressList.Add('donotreply@orientbell.com');
                        EmailCCList.add('donotreply@orientbell.com');
                        //SMTPMailCodeUnit.AddCC('bs.negi@orientbell.com'); //BS Negi

                        //--Body-->>
                        BodyText := 'Dear Mr. ' + SalespersonPurchaser.Name + ',';
                        BodyText += '<br><br>';
                        BodyText += 'Please find attached Daily Sales Tracker_ ' + CalcMonth(DATE2DMY(TODAY - 1, 2)) + ', ' +
                                                    FORMAT(DATE2DMY(TODAY - 1, 3)) + ' as on ' + FORMAT(TODAY - 1);
                        BodyText += '<br><br>';
                        BodyText += 'Enclosed herewith below Tracker sheets:';
                        BodyText += '<br>';
                        BodyText += '1- Zone wise Sales Tracker <br>';
                        //BodyText +='<br>';
                        BodyText += '2- Zone wise Collection Tracker <br>';
                        //BodyText +='<br>';
                        BodyText += '3- Zone wise Pending Orders <br>';
                        //BodyText +='4- AOP Target Vs Achvmt Tracker <br>';
                        BodyText += '<br>';
                        BodyText += 'Thanks & Regards <br>';
                        //BodyText +='<br>';
                        BodyText += 'CSO Office';
                        BodyText += '<br>';
                        BodyText += 'Orient Bell Ltd.';
                        //--Body--<<
                        /*   if File.Exists(filpath[1]) THEN begin
                              FileMgmt.BLOBExportToServerFile(TempBlobCU, filpath[1]);
                              if TempBlobCU.HasValue() then begin
                                  TempBlobCU.CreateInStream(InstreamVar);
                                  EmailMsg.Create(EmailAddressList, Subject, BodyText, true, EmailBccList, EmailCCList);
                                  if File.Exists(filpath[1]) THEN
                                      EmailMsg.AddAttachment(filpath[1], 'application/pdf', InstreamVar);
                                  EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                              END;
                          end;
                          if File.Exists(filpath[2]) THEN begin
                              FileMgmt.BLOBExportToServerFile(TempBlobCU, filpath[1]);
                              if TempBlobCU.HasValue() then begin
                                  TempBlobCU.CreateInStream(InstreamVar);
                                  EmailMsg.Create(EmailAddressList, Subject, BodyText, true, EmailBccList, EmailCCList);
                                  if File.Exists(filpath[2]) THEN
                                      EmailMsg.AddAttachment(filpath[2], 'application/pdf', InstreamVar);
                                  EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                              END;
                          end;
                          if File.Exists(filpath[3]) THEN begin
                              FileMgmt.BLOBExportToServerFile(TempBlobCU, filpath[1]);
                              if TempBlobCU.HasValue() then begin
                                  TempBlobCU.CreateInStream(InstreamVar);
                                  EmailMsg.Create(EmailAddressList, Subject, BodyText, true, EmailBccList, EmailCCList);
                                  if File.Exists(filpath[3]) THEN
                                      EmailMsg.AddAttachment(filpath[3], 'application/pdf', InstreamVar);
                                  EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                              END;
                          end;
                          if File.Exists(filpath[4]) THEN begin
                              FileMgmt.BLOBExportToServerFile(TempBlobCU, filpath[1]);
                              if TempBlobCU.HasValue() then begin
                                  TempBlobCU.CreateInStream(InstreamVar);
                                  EmailMsg.Create(EmailAddressList, Subject, BodyText, true, EmailBccList, EmailCCList);
                                  if File.Exists(filpath[4]) THEN
                                      EmailMsg.AddAttachment(filpath[4], 'application/pdf', InstreamVar);
                                  EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                              END;
                          end;

                         */  /*   IF (EXISTS(filpath[1])) THEN
                                 SMTPMailCodeUnit.AddAttachment(filpath[1], filpath[1]);
                             IF (EXISTS(filpath[2])) THEN
                                 SMTPMailCodeUnit.AddAttachment(filpath[2], filpath[2]);
                             IF (EXISTS(filpath[3])) THEN
                                 SMTPMailCodeUnit.AddAttachment(filpath[3], filpath[3]);
                             IF (EXISTS(filpath[4])) THEN
                                 SMTPMailCodeUnit.AddAttachment(filpath[4], filpath[4]);

                             SMTPMailCodeUnit.Send;*/
                    END;
                END;
            UNTIL MatrixMaster.NEXT = 0;
        END;
        //END;
        ////ZH
    end;

    local procedure SendToCKA()
    var
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
        ///PCH
        CLEAR(textfile);
        CLEAR(filpath);
        MatrixMaster.RESET;
        //MatrixMaster.SETCURRENTKEY("Mapping Type","Type 1","Type 2");
        //MatrixMaster.ASCENDING;
        //MatrixMaster.SETRANGE(Description, 'NC');
        //MatrixMaster.SETFILTER(ZH, '<>%1', '');
        //MatrixMaster.SETFILTER(Description, '<>%1', '');
        MatrixMaster.SETFILTER("Type 1", 'CKA');
        IF MatrixMaster.FINDSET THEN
            REPEAT
                MatrixMaster2.RESET;
                //MatrixMaster2.SETRANGE(PCH, MatrixMaster.PCH);
                MatrixMaster2.SETRANGE("Type 1", MatrixMaster."Type 1");
                IF MatrixMaster2.FINDFIRST THEN BEGIN
                    //------All 5 Reports---->>
                    CLEAR(SalespersonPurchaser);
                    IF SalespersonPurchaser.GET(MatrixMaster2.PCH) THEN;
                    //--1st Report--->>
                    CLEAR(SalesTGTvsAchvmnt);
                    SalesTGTvsAchvmnt.SETTABLEVIEW(MatrixMaster2);
                    textfile[1] := 'SalesTGTvsAchmt';//'-PCH-'+MatrixMaster2.PCH+'Sales';
                    filpath[1] := 'C:\AutoMail\DailySalesReport\' + textfile[1] + '.xlsx';
                    // SalesTGTvsAchvmnt.SAVEASEXCEL('C:\AutoMail\DailySalesReport\' + textfile[1] + '.xlsx');
                    //--1st Report---<<

                    //--2nd Report--->>
                    CLEAR(RepCollection);
                    RepCollection.SETTABLEVIEW(MatrixMaster2);
                    textfile[2] := 'Collection';//'-PCH-' + MatrixMaster2.PCH + 'Collection';
                    filpath[2] := 'C:\AutoMail\DailyCollection\' + textfile[2] + '.xlsx';
                    // RepCollection.SAVEASEXCEL('C:\AutoMail\DailyCollection\' + textfile[2] + '.xlsx');
                    //--2nd Report---<<

                    //--3rd Report--->>
                    Customer.RESET;
                    Customer.SETFILTER("Customer Type", 'CKA');
                    IF Customer.FINDFIRST THEN BEGIN
                        CLEAR(TODTgtVsAch);
                        TODTgtVsAch.SETTABLEVIEW(Customer);
                        textfile[3] := 'TODTgtVsAch';//'-PCH-' + MatrixMaster2.PCH+'TgtVsAch';
                        filpath[3] := 'C:\AutoMail\TgtVsAch\' + textfile[3] + '.xlsx';
                        // TODTgtVsAch.SAVEASEXCEL('C:\AutoMail\TgtVsAch\' + textfile[3] + '.xlsx');
                    END;
                    //--3rd Report---<<

                    //--4rd Report--->>
                    CLEAR(RepEnterprise);
                    //RepEnterprise.SETTABLEVIEW(Customer);
                    textfile[4] := 'EnterpriseReport';
                    filpath[4] := 'C:\AutoMail\Enterprise\' + textfile[4] + '.xlsx';
                    // RepEnterprise.SAVEASEXCEL('C:\AutoMail\Enterprise\' + textfile[4] + '.xlsx');
                    //--4rd Report---<<
                    /*
                    //--5th Report--->> //MSVRN 060919 -->>
                      CLEAR(PendingOrders);
                      PendingOrders.SETTABLEVIEW(MatrixMaster2);
                      //textfile[3] := '-PCH-'+MatrixMaster2.PCH+'PendingOrders';
                      textfile[5] := 'PendingOrders';
                      filpath[5] := 'C:\AutoMail\PendingOrders\'+textfile[5]+'.xlsx';
                      PendingOrders.SAVEASEXCEL('C:\AutoMailPendingOrders\'+textfile[5]+'.xlsx');
                    //--5th Report---<<
                    */
                    //------All 5 Reports----<<

                    //Send PCH Mail
                    Subject := MatrixMaster2."Type 1" + ' Territory_Daliy Sales Tracker for the month of ' + CalcMonth(DATE2DMY(TODAY - 1, 2)) + ', ' +
                                  FORMAT(DATE2DMY(TODAY - 1, 3)) + ' as on ' + FORMAT(TODAY - 1);
                    //  SMTPSetup.GET;
                    //  SMTPSetup.TESTFIELD("User ID");
                    // CLEAR(SMTPMailCodeUnit);

                    //SMTPMailCodeUnit.CreateMessage('CSO Office - OBL',SMTPSetup."User ID",SalespersonPurchaser."E-Mail",Subject,'',TRUE);//MSVRN open
                    // SMTPMailCodeUnit.CreateMessage('CSO Office - OBL', 'donotreply@orientbell.com', 'donotreply@orientbell.com', Subject, '', TRUE);
                    EmailAddressList.Add('donotreply@orientbell.com');
                    EmailCCList.add('donotreply@orientbell.com');
                    //SMTPMailCodeUnit.AddCC('bs.negi@orientbell.com'); //BS Negi

                    //--Body-->>
                    BodyText := 'Dear Mr. Manish Verma,';
                    BodyText += '<br><br>';
                    BodyText += 'Please find attached Daily Sales Tracker_ ' + CalcMonth(DATE2DMY(TODAY - 1, 2)) + ', ' +
                                                FORMAT(DATE2DMY(TODAY - 1, 3)) + ' as on ' + FORMAT(TODAY - 1);
                    BodyText += '<br><br>';
                    BodyText += 'Enclosed herewith below Tracker sheets:';
                    BodyText += '<br>';
                    BodyText += '1- Territory wise Sales Tracker';
                    BodyText += '<br>';
                    BodyText += '2- Collection Tracker ';
                    BodyText += '<br>';
                    //BodyText +='3- AOP Target Vs Achvmt Tracker';
                    BodyText += '<br>';
                    BodyText += '3- Enterprise Tracker ';
                    BodyText += '<br><br>';
                    BodyText += 'Thanks & Regards ';
                    BodyText += '<br>';
                    BodyText += 'CSO Office';
                    BodyText += '<br>';
                    BodyText += 'Orient Bell Ltd.';
                    //--Body--<<
                    /* if File.Exists(filpath[1]) THEN begin
                        FileMgmt.BLOBExportToServerFile(TempBlobCU, filpath[1]);
                        if TempBlobCU.HasValue() then begin
                            TempBlobCU.CreateInStream(InstreamVar);
                            EmailMsg.Create(EmailAddressList, Subject, BodyText, true, EmailBccList, EmailCCList);
                            if File.Exists(filpath[1]) THEN
                                EmailMsg.AddAttachment(filpath[1], 'application/pdf', InstreamVar);
                            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                        END;
                    end;
                    if File.Exists(filpath[2]) THEN begin
                        FileMgmt.BLOBExportToServerFile(TempBlobCU, filpath[1]);
                        if TempBlobCU.HasValue() then begin
                            TempBlobCU.CreateInStream(InstreamVar);
                            EmailMsg.Create(EmailAddressList, Subject, BodyText, true, EmailBccList, EmailCCList);
                            if File.Exists(filpath[2]) THEN
                                EmailMsg.AddAttachment(filpath[2], 'application/pdf', InstreamVar);
                            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                        END;
                    end;
                    if File.Exists(filpath[3]) THEN begin
                        FileMgmt.BLOBExportToServerFile(TempBlobCU, filpath[1]);
                        if TempBlobCU.HasValue() then begin
                            TempBlobCU.CreateInStream(InstreamVar);
                            EmailMsg.Create(EmailAddressList, Subject, BodyText, true, EmailBccList, EmailCCList);
                            if File.Exists(filpath[3]) THEN
                                EmailMsg.AddAttachment(filpath[3], 'application/pdf', InstreamVar);
                            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                        END;
                    end;
                    if File.Exists(filpath[4]) THEN begin
                        FileMgmt.BLOBExportToServerFile(TempBlobCU, filpath[1]);
                        if TempBlobCU.HasValue() then begin
                            TempBlobCU.CreateInStream(InstreamVar);
                            EmailMsg.Create(EmailAddressList, Subject, BodyText, true, EmailBccList, EmailCCList);
                            if File.Exists(filpath[4]) THEN
                                EmailMsg.AddAttachment(filpath[4], 'application/pdf', InstreamVar);
                            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                        END;
                    end; */

                    /*  IF (EXISTS(filpath[1])) THEN
                          SMTPMailCodeUnit.AddAttachment(filpath[1], filpath[1]);
                      IF (EXISTS(filpath[2])) THEN
                          SMTPMailCodeUnit.AddAttachment(filpath[2], filpath[2]);
                      IF (EXISTS(filpath[3])) THEN
                          SMTPMailCodeUnit.AddAttachment(filpath[3], filpath[3]);
                      IF (EXISTS(filpath[4])) THEN
                          SMTPMailCodeUnit.AddAttachment(filpath[4], filpath[4]);
                      IF (EXISTS(filpath[5])) THEN
                          SMTPMailCodeUnit.AddAttachment(filpath[5], filpath[5]);
                      SMTPMailCodeUnit.Send;
                      //MESSAGE('Sent');*/
                END;
            UNTIL MatrixMaster.NEXT = 0;

        /*
        CLEAR(textfile);
        CLEAR(filpath);
        CLEAR(RepEnterprise);
        //RepEnterprise.SETTABLEVIEW(Customer);
        textfile[4] := 'EnterpriseReport';
        filpath[4] := 'C:\AutoMail\Enterprise\' + textfile[4] + '.xlsx';
        RepEnterprise.SAVEASEXCEL('C:\AutoMail\Enterprise\' + textfile[4] + '.xlsx');
        
        SMTPSetup.GET;
        SMTPSetup.TESTFIELD("User ID");
        CLEAR(SMTPMailCodeUnit);
        {SMTPMailCodeUnit.CreateMessage('Orient Bell Ltd', SMTPSetup."User ID", 'manish.verma@orientbell.com',
                                        'Enterprise Report','',TRUE);}
        
        SMTPMailCodeUnit.CreateMessage('Orient Bell Ltd', SMTPSetup."User ID", 'kulbhushan.sharma@orientbell.com',
                                        'Enterprise Report','',TRUE);
        
        //--Body-->>
          SMTPMailCodeUnit.AppendBody('Dear Mr. Manish Verma,');
          SMTPMailCodeUnit.AppendBody('<br><br>');
          SMTPMailCodeUnit.AppendBody('Please find attached Daily Sales Tracker_ ' + CalcMonth(DATE2DMY(TODAY - 1, 2)) + ', ' +
                                      FORMAT(DATE2DMY(TODAY - 1, 3)) + ' as on ' + FORMAT(TODAY - 1));
          SMTPMailCodeUnit.AppendBody('<br><br>');
          SMTPMailCodeUnit.AppendBody('Enclosed herewith below Tracker sheets:');
          SMTPMailCodeUnit.AppendBody('<br>');
          SMTPMailCodeUnit.AppendBody('1- Territory wise Sales Tracker <br>');
          //SMTPMailCodeUnit.AppendBody('<br>');
          SMTPMailCodeUnit.AppendBody('2- Territory wise Collection Tracker <br>');
          //SMTPMailCodeUnit.AppendBody('<br>');
          SMTPMailCodeUnit.AppendBody('3- AOP Target Vs Achvmt Tracker <br>');
          SMTPMailCodeUnit.AppendBody('<br>');
          SMTPMailCodeUnit.AppendBody('Thanks & Regards <br>');
          //SMTPMailCodeUnit.AppendBody('<br>');
          SMTPMailCodeUnit.AppendBody('IT Department');
          SMTPMailCodeUnit.AppendBody('<br>');
          SMTPMailCodeUnit.AppendBody('Orient Bell Ltd.');
        //--Body--<<
        */

    end;

    local procedure SendToAll()
    var
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
        CLEAR(textfile);
        CLEAR(filpath);
        //--1st Report--->>

        SLEEP(200);
        CLEAR(SalesTGTvsAchvmnt);
        textfile[1] := 'SalesReport';
        filpath[1] := 'C:\AutoMail\DailySalesReport\' + textfile[1] + '.xlsx';
        // SalesTGTvsAchvmnt.SAVEASEXCEL('C:\AutoMail\DailySalesReport\' + textfile[1] + '.xlsx');
        //--1st Report---<<
        SLEEP(100);
        //--2nd Report--->>
        CLEAR(RepCollection);
        textfile[2] := 'CollectionReport';
        filpath[2] := 'C:\AutoMail\DailyCollection\' + textfile[2] + '.xlsx';
        // RepCollection.SAVEASEXCEL('C:\AutoMail\DailyCollection\' + textfile[2] + '.xlsx');
        //--2nd Report---<<
        //SLEEP(1000);

        //--3rd Report-->> //MSVRN 060919
        CLEAR(PendingOrders);
        textfile[3] := 'PendingOrders';
        filpath[3] := 'C:\AutoMail\PendingOrders\' + textfile[3] + '.xlsx';
        // PendingOrders.SAVEASEXCEL('C:\AutoMail\PendingOrders\' + textfile[3] + '.xlsx');
        //--3rd Report--<<


        SLEEP(1000);

        //--4th Report--->>
        CLEAR(TODTgtVsAch);
        textfile[4] := 'TGTTgtVsAch';
        filpath[4] := 'C:\AutoMail\TgtVsAch\' + textfile[4] + '.xlsx';
        // TODTgtVsAch.SAVEASEXCEL('C:\AutoMail\TgtVsAch\' + textfile[4] + '.xlsx');
        //--4th Report---<<
        SLEEP(1000);
        ///////------<<<<<<<<<<<<<<<<<<

        /*
        //Customer.RESET;
        //IF Customer.FINDFIRST THEN BEGIN
          CLEAR(RepEnterprise);
          //RepEnterprise.SETTABLEVIEW(Customer);
          textfile[4] := 'EnterpriseReport';
          filpath[4] := 'C:\AutoMail\Enterprise\' + textfile[4] + '.xlsx';
          RepEnterprise.SAVEASEXCEL('C:\AutoMail\Enterprise\' + textfile[4] + '.xlsx');
          */

        Subject := 'Sales Territory_Daliy Sales Tracker for the month of ' + CalcMonth(DATE2DMY(TODAY - 1, 2)) + ', ' +
                     FORMAT(DATE2DMY(TODAY - 1, 3)) + ' as on ' + FORMAT(TODAY - 1); //=today()-1

        /*  SMTPSetup.GET;
          SMTPSetup.TESTFIELD("User ID");
          CLEAR(SMTPMailCodeUnit);
          SMTPMailCodeUnit.CreateMessage('CSO Office - OBL', 'donotreply@orientbell.com', 'pinaki.nandy@orientbell.com', Subject, '', TRUE);*/
        //SMTPMailCodeUnit.CreateMessage('CSO Office - OBL', SMTPSetup."User ID", 'donotreply@orientbell.com', Subject,'',TRUE);
        EmailAddressList.Add('donotreply@orientbell.com');

        EmailCCList.add('aditya.gupta@orientbell.com');
        EmailCCList.add('alok.agarwal@orientbell.com');
        EmailCCList.add('himanshu.jindal@orientbell.com');
        EmailCCList.add('sandeep.jhanwar@orientbell.com');
        EmailCCList.add('amit.gupta@orientbell.com');
        EmailCCList.add('pushpender.kumar@orientbell.com');
        EmailCCList.add('bs.negi@orientbell.com');
        EmailCCList.add('amit.goel@orientbell.com');
        EmailBccList.add('jegatheeswaran.palsamy@orientbell.com');
        EmailCCList.add('donotreply@orientbell.com');


        //SMTPMailCodeUnit.AddBCC('virendra.kumar@mindshell.info');
        //--Body-->>
        BodyText := 'Dear Sir,';
        BodyText += '<br><br>';
        BodyText += 'Please find attached Daily Sales Tracker_ ' + CalcMonth(DATE2DMY(TODAY - 1, 2)) + ', ' +
                                    FORMAT(DATE2DMY(TODAY - 1, 3)) + ' as on ' + FORMAT(TODAY - 1);
        BodyText += '<br><br>';
        BodyText += 'Enclosed herewith below Tracker sheets:';
        BodyText += '<br>';
        BodyText += '1- Territory wise Sales Tracker <br>';
        //BodyText +='<br>';
        BodyText += '2- Territory wise Collection Tracker <br>';
        //BodyText +='<br>';
        BodyText += '3- Territory wise Pending Orders Tracker <br>';
        //BodyText +='4- AOP Target Vs Achvmt Tracker <br>';
        BodyText += '<br>';
        BodyText += 'Thanks & Regards <br>';
        //BodyText +='<br>';
        BodyText += 'CSO Office';
        BodyText += '<br>';
        BodyText += 'Orient Bell Ltd.';
        //--Body--<<
        /* if File.Exists(filpath[1]) THEN begin
            FileMgmt.BLOBExportToServerFile(TempBlobCU, filpath[1]);
            if TempBlobCU.HasValue() then begin
                TempBlobCU.CreateInStream(InstreamVar);
                EmailMsg.Create(EmailAddressList, 'Subject', BodyText, true, EmailBccList, EmailCCList);
                if File.Exists(filpath[1]) THEN
                    EmailMsg.AddAttachment(filpath[1], 'application/pdf', InstreamVar);
                EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
            END;
        end;
        if File.Exists(filpath[2]) THEN begin
            FileMgmt.BLOBExportToServerFile(TempBlobCU, filpath[1]);
            if TempBlobCU.HasValue() then begin
                TempBlobCU.CreateInStream(InstreamVar);
                EmailMsg.Create(EmailAddressList, Subject, BodyText, true, EmailBccList, EmailCCList);
                if File.Exists(filpath[2]) THEN
                    EmailMsg.AddAttachment(filpath[2], 'application/pdf', InstreamVar);
                EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
            END;
        end;
        if File.Exists(filpath[3]) THEN begin
            FileMgmt.BLOBExportToServerFile(TempBlobCU, filpath[1]);
            if TempBlobCU.HasValue() then begin
                TempBlobCU.CreateInStream(InstreamVar);
                EmailMsg.Create(EmailAddressList, Subject, BodyText, true, EmailBccList, EmailCCList);
                if File.Exists(filpath[3]) THEN
                    EmailMsg.AddAttachment(filpath[3], 'application/pdf', InstreamVar);
                EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
            END;
        end;
        if File.Exists(filpath[4]) THEN begin
            FileMgmt.BLOBExportToServerFile(TempBlobCU, filpath[1]);
            if TempBlobCU.HasValue() then begin
                TempBlobCU.CreateInStream(InstreamVar);
                EmailMsg.Create(EmailAddressList, Subject, BodyText, true, EmailBccList, EmailCCList);
                if File.Exists(filpath[4]) THEN
                    EmailMsg.AddAttachment(filpath[4], 'application/pdf', InstreamVar);
                EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
            END;
        end;

 */
        /*   IF (EXISTS(filpath[1])) THEN
               SMTPMailCodeUnit.AddAttachment(filpath[1], filpath[1]);
           IF (EXISTS(filpath[2])) THEN
               SMTPMailCodeUnit.AddAttachment(filpath[2], filpath[2]);
           IF (EXISTS(filpath[3])) THEN
               SMTPMailCodeUnit.AddAttachment(filpath[3], filpath[3]);
           IF (EXISTS(filpath[4])) THEN
               SMTPMailCodeUnit.AddAttachment(filpath[4], filpath[4]);

           SMTPMailCodeUnit.Send;*/

        //END;
        ////---Enterprise--<<

    end;

    local procedure CalcMonth(Month: Integer) MonthText: Text[10]
    begin
        CASE Month OF
            1:
                MonthText := 'Jan';
            2:
                MonthText := 'Feb';
            3:
                MonthText := 'Mar';
            4:
                MonthText := 'April';
            5:
                MonthText := 'May';
            6:
                MonthText := 'June';
            7:
                MonthText := 'July';
            8:
                MonthText := 'Aug';
            9:
                MonthText := 'Sep';
            10:
                MonthText := 'Oct';
            11:
                MonthText := 'Nov';
            12:
                MonthText := 'Dec';
        END;
    end;

    local procedure SendEmailSalesDetails()
    var
        rptSalesDetails: Report "Sales Details";
        // SMTPMail: Codeunit 400;
        filePath: Text;
        fileName: Text;
        intYear: Integer;
        dtfrom: Date;
        dtTo: Date;
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

        //Keshav05Nov2020>>
        intYear := 0;
        dtfrom := 0D;
        dtTo := 0D;
        filePath := '';
        fileName := '';
        filePath := 'C:\AutoMail\NPDOrderBookingandDespatch\';
        fileName := 'NPDOrderBookingandDespatch' + FORMAT(TODAY) + '.xlsx';

        IF DATE2DMY(TODAY, 2) < 4 THEN
            intYear := DATE2DMY(TODAY, 3) - 1
        ELSE
            intYear := DATE2DMY(TODAY, 3);

        dtfrom := DMY2DATE(1, 4, intYear);
        dtTo := TODAY;
        //MESSAGE('%1..%2',dtfrom,dtTo);

        CLEAR(rptSalesDetails);
        rptSalesDetails.SetReportFilter(dtfrom, dtTo);
        // rptSalesDetails.SAVEASEXCEL(filePath + fileName);
        COMMIT;
        // CLEAR(SMTPMail);
        // IF SMTPSetup.FINDFIRST THEN;
        // SMTPMail.CreateMessage('Orient Bell Limited', 'donotreply@orientbell.com', 'santosh.upadhyay@orientbell.com', 'NPD Order Booking and Despatch', '', TRUE);
        EmailAddressList.Add('donotreply@orientbell.com');
        EmailCCList.add('donotreply@orientbell.com');
        EmailCCList.add('robin.samuel@orientbell.com');
        EmailCCList.add('rachit.vij@orientbell.com');
        EmailCCList.add('divya.chauhan@orientbell.com');
        BodyText := 'Dear Sir,';
        BodyText += '<br><br>';
        BodyText += 'Please find attached NPD Order Booking and Despatch';
        BodyText += '<br><br>';
        BodyText += 'Orient Bell Limited <br>';
        BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
        BodyText += 'New Delhi 110046, India <br>';
        BodyText += 'Tel. +91 11 4711 9100 <br>';
        BodyText += 'Fax. +91 11 2852 1273 <br>';
        //--Body--<<

        //Attachment>>
        /* if File.Exists(filePath + fileName) THEN
            FileMgmt.BLOBExportToServerFile(TempBlobCU, filePath + fileName);
        if TempBlobCU.HasValue() then begin
            TempBlobCU.CreateInStream(InstreamVar);
            EmailMsg.Create(EmailAddressList, 'NPD Order Booking and Despatch', BodyText, true, EmailBccList, EmailCCList);
            if File.Exists(filePath + fileName) THEN
                EmailMsg.AddAttachment(filePath + fileName, 'application/pdf', InstreamVar);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
        END;
 */
        /* IF EXISTS(filePath + fileName) THEN
             SMTPMail.AddAttachment(filePath + fileName, fileName);

         //Attachment<<
         SMTPMail.Send;*/
        //Keshav05Nov2020<<
    end;
}

