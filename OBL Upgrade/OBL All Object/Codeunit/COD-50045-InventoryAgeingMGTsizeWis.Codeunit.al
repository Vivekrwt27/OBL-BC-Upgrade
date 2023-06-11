codeunit 50045 "Inventory Ageing -MGT size Wis"
{

    trigger OnRun()
    begin
        SendInventoryAgeingReport_SizeWise;
        SendDepotSalesTrend_Depot;
    end;

    var
        //  SMTPSetup: Record 409;
        GlbFromDate: Date;
        GlbToDate: Date;


    procedure GenerateInventoryAgeingReport_SizeWise(LocCode: Code[20])
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
        //SMTPMailCodeUnit: Codeunit 400;
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
        SalesValue: Decimal;
        SalesQty: Decimal;
        MonthlyAverage: Decimal;
        ASP: Decimal;
        InventoryAgeingMGT: Report "Inventory Ageing -MGT size Wis";
        Location: Record Location;
        MatrixMaster: Record "Matrix Master";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        fileName2: Text;
        CompletePath2: Text;

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
        EmailAddress := 'donotreply@orientbell.com';

        InCorrectMail := FALSE;
        CLEAR(Location);

        Location.RESET;
        IF LocCode <> '' THEN BEGIN
            Location.SETFILTER(Code, LocCode);
            Location.SETRANGE(Depot, TRUE);
        END;
        IF Location.FINDFIRST THEN BEGIN
            fileName := '';
            IF LocCode = '' THEN
                fileName := 'AgeWise_Detail' + FORMAT(ToDate) + '.xlsx'
            ELSE
                fileName := 'AGE_SizeWise_' + FORMAT(Location.Code) + FORMAT(ToDate) + '.xlsx';
            fileName := CONVERTSTR(fileName, '/', '_');
            CompletePath := 'C:\InventorySizeWise\' + fileName;
            CLEAR(InventoryAgeingMGT);//MSAK150319
            InventoryAgeingMGT.SETTABLEVIEW(Location);
            //InventoryAgeingMGT.SetValues(LocCode<>'');
            InventoryAgeingMGT.SetValues(TRUE);//MSAK150319
            // InventoryAgeingMGT.SAVEASEXCEL(CompletePath);

            //MSAK190319
            fileName2 := '';
            IF LocCode = '' THEN
                fileName2 := 'DepotSale_Summary' + FORMAT(ToDate) + '.xlsx'
            ELSE
                fileName2 := 'AGE_SizeWise_' + FORMAT(Location.Code) + FORMAT(ToDate) + '.xlsx';
            fileName2 := CONVERTSTR(fileName2, '/', '_');
            CompletePath2 := 'C:\InventorySizeWise\' + fileName2;
            CLEAR(InventoryAgeingMGT);//MSAK150319
            InventoryAgeingMGT.SETTABLEVIEW(Location);
            //InventoryAgeingMGT.SetValues(LocCode<>'');
            InventoryAgeingMGT.SetValues(FALSE);//MSAK150319
            // InventoryAgeingMGT.SAVEASEXCEL(CompletePath2);
            //MSAK190319

            MatrixMaster.RESET;
            MatrixMaster.SETRANGE("Type 1", Location."Sales Territory");
            IF MatrixMaster.FINDFIRST THEN BEGIN
                SalespersonPurchaser.SETRANGE(Code, MatrixMaster.PCH);
                IF SalespersonPurchaser.FINDFIRST THEN
                    EmailAddress := SalespersonPurchaser."E-Mail";
            END;

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
                //   SMTPSetup.GET();
                IF LocCode = '' THEN BEGIN
                    //SMTPMailCodeUnit.CreateMessage('CEO Office - OBL','ceooffice@orientbell.com','anurag.maithani@orientbell.com',' Depot Sales Summary Report/Detailed Report  -'+FORMAT(LocCode),'',TRUE);
                    //  SMTPMailCodeUnit.CreateMessage('CSO Office - OBL', 'csooffice@orientbell.com', 'anurag.maithani@orientbell.com', ' Depot Stock Ageing Report ' + FORMAT(LocCode), '', TRUE);
                    EmailAddressList.Add('csooffice@orientbell.com');
                    EmailCCList.add('kulbhushan.sharma@orientbell.com');
                    EmailCCList.add('pushpender.kumar@orientbell.com');
                    EmailCCList.add('amit.goel@orientbell.com');

                END ELSE BEGIN
                    //SMTPMailCodeUnit.CreateMessage('CEO Office - OBL','ceooffice@orientbell.com','anurag.maithani@orientbell.com',' Depot Sales Summary Report/Detailed Report  -'+FORMAT(LocCode),'',TRUE);
                    //  SMTPMailCodeUnit.CreateMessage('CSO Office - OBL', 'csooffice@orientbell.com', 'anurag.maithani@orientbell.com', ' Depot Stock Ageing Report ' + FORMAT(LocCode), '', TRUE);
                    EmailAddressList.Add('csooffice@orientbell.com');
                    EmailCCList.add('kulbhushan.sharma@orientbell.com');
                    EmailCCList.add('pushpender.kumar@orientbell.com');
                    EmailCCList.add('amit.goel@orientbell.com');
                END;

                BodyText := 'Dear Sir,';
                BodyText += '<br><br>';
                BodyText += 'Please find the enclosed detail of Size Wise sales with ageing for the Current Month. ';
                BodyText += '<br><br>';
                BodyText += 'This is for your records';
                BodyText += '<br><br>';
                BodyText += 'Regards, <br>';
                BodyText += 'CSO Office, <br>';
                BodyText += 'Orient Bell Limited <br>';
                BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
                BodyText += 'New Delhi 110046, India <br>';
                BodyText += 'Tel. +91 11 4711 9257 <br>';
                BodyText += 'Fax. +91 11 2852 1273 <br>';
                // if File.Exists('C:\InventorySizeWise\' + fileName) THEN BEGIN
                // FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\InventorySizeWise\' + fileName);
                if TempBlobCU.HasValue() then begin
                    TempBlobCU.CreateInStream(InstreamVar);
                    EmailMsg.Create(EmailAddressList, ' Depot Stock Ageing Report ' + FORMAT(LocCode), BodyText, true, EmailBccList, EmailCCList);
                    // if File.Exists('C:\InventorySizeWise\' + fileName) THEN
                    EmailMsg.AddAttachment(CompletePath, 'application/pdf', InstreamVar);
                    EmailMsg.AddAttachment(CompletePath2, 'application/pdf', InstreamVar);
                    EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                    // END;


                    /* IF (EXISTS('C:\InventorySizeWise\' + fileName)) THEN BEGIN
                         SMTPMailCodeUnit.AddAttachment(CompletePath, fileName);
                         SMTPMailCodeUnit.AddAttachment(CompletePath2, fileName2);
                         SMTPMailCodeUnit.Send();
                         //MESSAGE('Mail Sent- All');
                     END;*/
                END;
            END;
        end;
    end;


    procedure SendInventoryAgeingReport_SizeWise()
    var
        Location: Record Location;
        TempZHCode: Code[10];
        MatrixMaster: Record "Matrix Master";
        TempLocation: Record Location;
        TempPCHCode: Code[10];
    begin
        GenerateInventoryAgeingReport_SizeWise('');

        UpdateLocationListUnderZH_SizeWise;

        Location.RESET;
        Location.SETCURRENTKEY(ZH);
        Location.SETFILTER(ZH, '<>%1', '');
        Location.SETRANGE(Depot, TRUE);
        IF Location.FINDFIRST THEN BEGIN
            REPEAT
                IF Location.ZH <> TempZHCode THEN BEGIN
                    TempZHCode := Location.ZH; //MSAK150319
                    GenerateInventoryAgeingReportZH_SizeWise(TempLocation, Location.ZH);
                END;
            UNTIL Location.NEXT = 0;
        END;

        //MSAK150319
        Location.RESET;
        Location.SETCURRENTKEY(ZH, PCH);
        Location.SETFILTER(PCH, '<>%1', '');
        Location.SETRANGE(Depot, TRUE);
        IF Location.FINDFIRST THEN BEGIN
            REPEAT
                IF Location.PCH <> TempPCHCode THEN BEGIN
                    TempPCHCode := Location.PCH;
                    GenerateInventoryAgeingReportPCH_SizeWise(TempLocation, Location.PCH);
                END;
            UNTIL Location.NEXT = 0;
        END;
        //MSAK150319
    end;


    procedure GenerateInventoryAgeingReportZH_SizeWise(Location: Record Location; ZHCode: Code[10])
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
        SalesValue: Decimal;
        SalesQty: Decimal;
        MonthlyAverage: Decimal;
        ASP: Decimal;
        InventoryAgeingMGT: Report "Inventory Ageing -MGT size Wis";
        RecLocation: Record Location;
        MatrixMaster: Record "Matrix Master";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        ZHName: Text;
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
        EmailAddress := 'donotreply@orientbell.com';

        InCorrectMail := FALSE;
        Location.RESET;
        Location.SETFILTER(ZH, '%1', ZHCode);
        Location.SETRANGE(Depot, TRUE);
        IF Location.FINDFIRST THEN BEGIN
            fileName := 'AgeWise' + FORMAT(ZHCode) + FORMAT(ToDate) + '.xlsx';
            fileName := CONVERTSTR(fileName, '/', '_');
            CompletePath := 'C:\InventorySizeWise\' + fileName;
            CLEAR(InventoryAgeingMGT);//MSAK150319
            InventoryAgeingMGT.SETTABLEVIEW(Location);
            InventoryAgeingMGT.SetValues(TRUE);
            // InventoryAgeingMGT.SAVEASEXCEL(CompletePath);

            MatrixMaster.RESET;
            MatrixMaster.SETRANGE("Type 1", Location."Sales Territory");
            IF MatrixMaster.FINDFIRST THEN BEGIN
                SalespersonPurchaser.SETRANGE(Code, MatrixMaster.ZH);
                IF SalespersonPurchaser.FINDFIRST THEN
                    EmailAddress := SalespersonPurchaser."E-Mail";
            END;
        END;
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
        //MSAK150319
        CLEAR(ZHName);
        SalespersonPurchaser.RESET;
        SalespersonPurchaser.SETRANGE(Code, ZHCode);
        IF SalespersonPurchaser.FINDFIRST THEN
            ZHName := SalespersonPurchaser.Name;
        //MSAK150319
        IF InCorrectMail = FALSE THEN BEGIN
            //SMTPSetup.GET();
            //SMTPMailCodeUnit.CreateMessage('CSO Office - OBL','csooffice@orientbell.com','kulbhushan.sharma@orientbell.com',' Depot Size wise Sales -'+FORMAT(ZHCode),'',TRUE);
            // SMTPMailCodeUnit.CreateMessage('CSO Office - OBL', 'csooffice@orientbell.com', EmailAddress, ' Depot Size wise Sales -' + FORMAT(ZHCode), '', TRUE);
            EmailCCList.add('kulbhushan.sharma@orientbell.com');
            EmailAddressList.Add('csooffice@orientbell.com');
            BodyText := 'Dear ' + ZHName + ',';
            BodyText += '<br><br>';
            BodyText += 'Please find the enclosed detail of Size Wise sales with ageing for the Current Month.';
            BodyText += '<br><br>';
            BodyText += 'This is for your records';
            BodyText += '<br><br>';
            BodyText += 'Regards, <br>';
            BodyText += 'CSO Office, <br>';
            BodyText += 'Orient Bell Limited <br>';
            BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
            BodyText += 'New Delhi 110046, India <br>';
            BodyText += 'Tel. +91 11 4711 9257 <br>';
            BodyText += 'Fax. +91 11 2852 1273 <br>';
            // if File.Exists('C:\InventorySizeWise\' + fileName) THEN BEGIN
            // FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\InventorySizeWise\' + fileName);
            if TempBlobCU.HasValue() then begin
                TempBlobCU.CreateInStream(InstreamVar);
                EmailMsg.Create(EmailAddressList, ' Depot Size wise Sales -' + FORMAT(ZHCode), BodyText, true, EmailBccList, EmailCCList);
                // if File.Exists('C:\InventorySizeWise\' + fileName) THEN
                EmailMsg.AddAttachment(CompletePath, 'application/pdf', InstreamVar);
                EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                // END;


                /*  IF (EXISTS('C:\InventorySizeWise\' + fileName)) THEN BEGIN
                      SMTPMailCodeUnit.AddAttachment(CompletePath, fileName);
                      SMTPMailCodeUnit.Send();//MSAK150319
                                              //MESSAGE('Mail Sent');
                  END;*/
            END;
        end;
    end;

    local procedure UpdateLocationListUnderZH_SizeWise()
    var
        MatrixMaster: Record "Matrix Master";
        TempZHCode: Code[10];
        UpdLocation: Record Location;
    begin
        MatrixMaster.RESET;
        MatrixMaster.SETCURRENTKEY(ZH, PCH);
        IF MatrixMaster.FINDFIRST THEN
            REPEAT
                UpdLocation.RESET;
                UpdLocation.SETRANGE("Sales Territory", MatrixMaster."Type 1");
                IF UpdLocation.FINDFIRST THEN BEGIN
                    UpdLocation.ZH := MatrixMaster.ZH;
                    UpdLocation.PCH := MatrixMaster.PCH;
                    UpdLocation.MODIFY;
                END;
            UNTIL MatrixMaster.NEXT = 0;
    end;


    procedure GenerateInventoryAgeingReportPCH_SizeWise(Location: Record Location; PCHCode: Code[10])
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
        SalesValue: Decimal;
        SalesQty: Decimal;
        MonthlyAverage: Decimal;
        ASP: Decimal;
        InventoryAgeingMGT: Report "Inventory Ageing -MGT size Wis";
        RecLocation: Record Location;
        MatrixMaster: Record "Matrix Master";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        PCHName: Text;

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
        EmailAddress := 'donotreply@orientbell.com';

        InCorrectMail := FALSE;
        Location.RESET;
        Location.SETFILTER(PCH, '%1', PCHCode);
        Location.SETRANGE(Depot, TRUE);
        IF Location.FINDFIRST THEN BEGIN
            fileName := 'AgeWise' + FORMAT(PCHCode) + FORMAT(ToDate) + '.xlsx';
            fileName := CONVERTSTR(fileName, '/', '_');
            CompletePath := 'C:\InventorySizeWise\' + fileName;
            CLEAR(InventoryAgeingMGT);//MSAK150319
            InventoryAgeingMGT.SETTABLEVIEW(Location);
            InventoryAgeingMGT.SetValues(TRUE);
            // InventoryAgeingMGT.SAVEASEXCEL(CompletePath);

            MatrixMaster.RESET;
            MatrixMaster.SETRANGE("Type 1", Location."Sales Territory");
            IF MatrixMaster.FINDFIRST THEN BEGIN
                SalespersonPurchaser.SETRANGE(Code, MatrixMaster.PCH);
                IF SalespersonPurchaser.FINDFIRST THEN
                    EmailAddress := SalespersonPurchaser."E-Mail";
            END;
        END;
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
        //MSAK150319
        CLEAR(PCHName);
        SalespersonPurchaser.RESET;
        SalespersonPurchaser.SETRANGE(Code, PCHCode);
        IF SalespersonPurchaser.FINDFIRST THEN
            PCHName := SalespersonPurchaser.Name;
        //MSAK150319

        IF InCorrectMail = FALSE THEN BEGIN
            //  SMTPSetup.GET();
            //SMTPMailCodeUnit.CreateMessage('CSO Office - OBL','csooffice@orientbell.com','kulbhushan.sharma@orientbell.com',' Depot Performance Report -'+FORMAT(PCHCode),'',TRUE);
            // SMTPMailCodeUnit.CreateMessage('CSO Office - OBL', 'csooffice@orientbell.com', EmailAddress, ' Depot Size wise Sales -' + FORMAT(PCHCode), '', TRUE);
            // SMTPMailCodeUnit.AddCC('kulbhushan.sharma@orientbell.com');
            EmailAddressList.Add('csooffice@orientbell.com');
            EmailCCList.Add('kulbhushan.sharma@orientbell.com');
            BodyText := 'Dear ' + PCHName + ',';
            BodyText += '<br><br>';
            BodyText += 'Please find the enclosed detail of Size Wise sales with ageing for the Current Month.';
            BodyText += '<br><br>';
            BodyText += 'This is for your records';
            BodyText += '<br><br>';
            BodyText += 'Regards, <br>';
            BodyText += 'CSO Office, <br>';
            BodyText += 'Orient Bell Limited <br>';
            BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
            BodyText += 'New Delhi 110046, India <br>';
            BodyText += 'Tel. +91 11 4711 9257 <br>';
            BodyText += 'Fax. +91 11 2852 1273 <br>';
            // if File.Exists('C:\InventorySizeWise\' + fileName) THEN BEGIN
            // FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\InventorySizeWise\' + fileName);
            if TempBlobCU.HasValue() then begin
                TempBlobCU.CreateInStream(InstreamVar);
                EmailMsg.Create(EmailAddressList, ' Depot Size wise Sales -' + FORMAT(PCHCode), BodyText, true, EmailBccList, EmailCCList);
                // if File.Exists('C:\InventorySizeWise\' + fileName) THEN
                EmailMsg.AddAttachment(CompletePath, 'application/pdf', InstreamVar);
                EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                // END;


                /*    IF (EXISTS('C:\InventorySizeWise\' + fileName)) THEN BEGIN
                        SMTPMailCodeUnit.AddAttachment(CompletePath, fileName);
                        SMTPMailCodeUnit.Send();//MSAK150319
                                                //MESSAGE('Mail Sent');
                    END;*/
            END;
        end;
    end;


    procedure GenerateDepotSalesTrend_Depot(LocCode: Code[20])
    var
        SalesPersons: Record "Salesperson/Purchaser";
        DealerSchemeDetails: Record "Customer Scheme Details";
        txtfile: Text[250];
        SchemeMaster: Record "Scheme Master";
        EmailAddress: Text[250];
        InCorrectMail: Boolean;
        NoOfAtSigns: Integer;
        i: Integer;
        //  SMTPSetup: Record "409";
        //  SMTPMailCodeUnit: Codeunit "400";
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
        SalesValue: Decimal;
        SalesQty: Decimal;
        MonthlyAverage: Decimal;
        ASP: Decimal;
        InventoryAgeingMGT: Report "Depot Sales Trend Report";
        Location: Record Location;
        MatrixMaster: Record "Matrix Master";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        fileName2: Text;
        CompletePath2: Text;

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
        EmailAddress := 'donotreply@orientbell.com';
        InCorrectMail := FALSE;
        CLEAR(Location);
        Location.RESET;
        IF LocCode <> '' THEN BEGIN
            Location.SETFILTER(Code, LocCode);
            Location.SETRANGE(Depot, TRUE);
        END;
        IF Location.FINDFIRST THEN BEGIN
            fileName := '';
            IF LocCode = '' THEN
                fileName := 'DepotSalesTrend' + '.xlsx'
            ELSE
                fileName := 'SalesTrendDepot_' + FORMAT(Location.Code) + '.xlsx';
            fileName := CONVERTSTR(fileName, '/', '_');
            CompletePath := 'C:\InventorySizeWise\' + fileName;
            CLEAR(InventoryAgeingMGT);
            InventoryAgeingMGT.SETTABLEVIEW(Location);
            // InventoryAgeingMGT.SAVEASEXCEL(CompletePath);

            fileName2 := '';
            IF LocCode = '' THEN
                fileName2 := 'DepotsalesTrend' + '.xlsx'
            ELSE
                fileName2 := 'SalesTrendDepot_' + FORMAT(Location.Code) + '.xlsx';
            fileName2 := CONVERTSTR(fileName2, '/', '_');
            CompletePath2 := 'C:\InventorySizeWise\' + fileName2;
            CLEAR(InventoryAgeingMGT);
            InventoryAgeingMGT.SETTABLEVIEW(Location);
            // InventoryAgeingMGT.SAVEASEXCEL(CompletePath2);
            /*
            MatrixMaster.RESET;
            MatrixMaster.SETRANGE("Type 1",Location."Sales Territory");
            IF MatrixMaster.FINDFIRST THEN BEGIN
              SalespersonPurchaser.SETRANGE(Code,MatrixMaster.PCH);
              IF SalespersonPurchaser.FINDFIRST THEN
                EmailAddress := SalespersonPurchaser."E-Mail";
            END;
            */
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
                // SMTPSetup.GET();
                IF LocCode = '' THEN BEGIN
                    //SMTPMailCodeUnit.CreateMessage('CEO Office - OBL','ceooffice@orientbell.com','anurag.maithani@orientbell.com',' Depot Sales Summary Report/Detailed Report  -'+FORMAT(LocCode),'',TRUE);
                    /*  SMTPMailCodeUnit.CreateMessage('CSO Office - OBL', 'csooffice@orientbell.com', 'anurag.maithani@orientbell.com', ' Depot Report: Sales Trend' + FORMAT(LocCode), '', TRUE);
                      SMTPMailCodeUnit.AddCC('kulbhushan.sharma@orientbell.com');
                      SMTPMailCodeUnit.AddCC('pushpender.kumar@orientbell.com');
                      SMTPMailCodeUnit.AddCC('amit.goal@orientbell.com');*/
                    EmailAddressList.Add('csooffice@orientbell.com');
                    EmailCCList.Add('kulbhushan.sharma@orientbell.com');
                    EmailCCList.Add('pushpender.kumar@orientbell.com');
                    EmailCCList.Add('amit.goal@orientbell.com');
                END ELSE BEGIN
                    //SMTPMailCodeUnit.CreateMessage('CEO Office - OBL','ceooffice@orientbell.com','anurag.maithani@orientbell.com',' Depot Sales Summary Report/Detailed Report  -'+FORMAT(LocCode),'',TRUE);
                    /* SMTPMailCodeUnit.CreateMessage('CSO Office - OBL', 'csooffice@orientbell.com', 'anurag.maithani@orientbell.com', ' Depot Report: Sales Trend ' + FORMAT(LocCode), '', TRUE);
                     SMTPMailCodeUnit.AddCC('kulbhushan.sharma@orientbell.com');
                     SMTPMailCodeUnit.AddCC('pushpender.kumar@orientbell.com');
                     SMTPMailCodeUnit.AddCC('amit.goel@orientbell.com');*/
                    EmailAddressList.Add('csooffice@orientbell.com');

                    EmailCCList.Add('kulbhushan.sharma@orientbell.com');
                    EmailCCList.Add('pushpender.kumar@orientbell.com');
                    EmailCCList.Add('amit.goal@orientbell.com');

                END;

                BodyText := 'Dear Sir,';
                BodyText += '<br><br>';
                BodyText += 'Please find the enclosed Deport Sales Trend Report. ';
                BodyText += '<br><br>';
                BodyText += 'This is for your records';
                BodyText += '<br><br>';
                BodyText += 'Regards, <br>';
                BodyText += 'CSO Office, <br>';
                BodyText += 'Orient Bell Limited <br>';
                BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
                BodyText += 'New Delhi 110046, India <br>';
                BodyText += 'Tel. +91 11 4711 9257 <br>';
                BodyText += 'Fax. +91 11 2852 1273 <br>';

                // if File.Exists('C:\InventorySizeWise\' + fileName) THEN BEGIN
                // FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\InventorySizeWise\' + fileName);
                if TempBlobCU.HasValue() then begin
                    TempBlobCU.CreateInStream(InstreamVar);
                    EmailMsg.Create(EmailAddressList, ' Depot Report: Sales Trend ' + FORMAT(LocCode), BodyText, true, EmailBccList, EmailCCList);
                    // if File.Exists('C:\InventorySizeWise\' + fileName) THEN
                    EmailMsg.AddAttachment(CompletePath, 'application/pdf', InstreamVar);
                    EmailMsg.AddAttachment(CompletePath2, 'application/pdf', InstreamVar);
                    EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                    // END;


                    /*  IF (EXISTS('C:\InventorySizeWise\' + fileName)) THEN BEGIN
                          SMTPMailCodeUnit.AddAttachment(CompletePath, fileName);
                          SMTPMailCodeUnit.AddAttachment(CompletePath2, fileName2);
                          SMTPMailCodeUnit.Send();
                          //MESSAGE('Mail Sent- All');
                      END;*/
                END;
            END;

        end;
    end;


    procedure SendDepotSalesTrend_Depot()
    var
        Location: Record Location;
        TempZHCode: Code[10];
        MatrixMaster: Record "Matrix Master";
        TempLocation: Record Location;
        TempPCHCode: Code[10];
    begin
        //GenerateInventoryAgeingReport_SizeWise('');
        GenerateDepotSalesTrend_Depot('');
        UpdateDepotLocationListUnderZH_SDepot;
        //UpdateLocationListUnderZH_SizeWise;

        Location.RESET;
        Location.SETCURRENTKEY(ZH);
        Location.SETFILTER(ZH, '<>%1', '');
        Location.SETRANGE(Depot, TRUE);
        IF Location.FINDFIRST THEN BEGIN
            REPEAT
                IF Location.ZH <> TempZHCode THEN BEGIN
                    TempZHCode := Location.ZH;
                    GenerateDepotSalesTrendZH_Depot(TempLocation, Location.ZH);
                    //GenerateInventoryAgeingReportZH_SizeWise(TempLocation,Location.ZH);
                END;
            UNTIL Location.NEXT = 0;
        END;

        Location.RESET;
        Location.SETCURRENTKEY(ZH, PCH);
        Location.SETFILTER(PCH, '<>%1', '');
        Location.SETRANGE(Depot, TRUE);
        IF Location.FINDFIRST THEN BEGIN
            REPEAT
                IF Location.PCH <> TempPCHCode THEN BEGIN
                    TempPCHCode := Location.PCH;
                    GenerateDepotSalesTrendPCH_Depot(TempLocation, Location.PCH);
                    //GenerateInventoryAgeingReportPCH_SizeWise(TempLocation,Location.PCH);
                END;
            UNTIL Location.NEXT = 0;
        END;
    end;


    procedure GenerateDepotSalesTrendZH_Depot(Location: Record Location; ZHCode: Code[10])
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
        SalesValue: Decimal;
        SalesQty: Decimal;
        MonthlyAverage: Decimal;
        ASP: Decimal;
        InventoryAgeingMGT: Report "Depot Sales Trend Report";
        RecLocation: Record Location;
        MatrixMaster: Record "Matrix Master";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        ZHName: Text;

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
        EmailAddress := 'donotreply@orientbell.com';

        InCorrectMail := FALSE;
        Location.RESET;
        Location.SETFILTER(ZH, '%1', ZHCode);
        Location.SETRANGE(Depot, TRUE);
        IF Location.FINDFIRST THEN BEGIN
            fileName := 'DepotsalesTrend' + FORMAT(ZHCode) + '.xlsx';
            fileName := CONVERTSTR(fileName, '/', '_');
            CompletePath := 'C:\InventorySizeWise\' + fileName;
            CLEAR(InventoryAgeingMGT);
            InventoryAgeingMGT.SETTABLEVIEW(Location);
            // InventoryAgeingMGT.SAVEASEXCEL(CompletePath);

            MatrixMaster.RESET;
            MatrixMaster.SETRANGE("Type 1", Location."Sales Territory");
            IF MatrixMaster.FINDFIRST THEN BEGIN
                SalespersonPurchaser.SETRANGE(Code, MatrixMaster.ZH);
                IF SalespersonPurchaser.FINDFIRST THEN
                    EmailAddress := SalespersonPurchaser."E-Mail";
            END;
        END;
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

        CLEAR(ZHName);
        SalespersonPurchaser.RESET;
        SalespersonPurchaser.SETRANGE(Code, ZHCode);
        IF SalespersonPurchaser.FINDFIRST THEN
            ZHName := SalespersonPurchaser.Name;

        IF InCorrectMail = FALSE THEN BEGIN
            // SMTPSetup.GET();
            //SMTPMailCodeUnit.CreateMessage('CSO Office - OBL','csooffice@orientbell.com','kulbhushan.sharma@orientbell.com',' Depot Size wise Sales -'+FORMAT(ZHCode),'',TRUE);
            /* SMTPMailCodeUnit.CreateMessage('CSO Office - OBL', 'csooffice@orientbell.com', EmailAddress, ' Depot Size wise Sales -' + FORMAT(ZHCode), '', TRUE);
             SMTPMailCodeUnit.AddCC('kulbhushan.sharma@orientbell.com');*/
            EmailAddressList.Add('csooffice@orientbell.com');
            EmailCCList.Add('kulbhushan.sharma@orientbell.com');

            BodyText := 'Dear ' + ZHName + ',';
            BodyText += '<br><br>';
            BodyText += 'Please find the enclosed Depot Sales Trend Report.';
            BodyText += '<br><br>';
            BodyText += 'This is for your records';
            BodyText += '<br><br>';
            BodyText += 'Regards, <br>';
            BodyText += 'CSO Office, <br>';
            BodyText += 'Orient Bell Limited <br>';
            BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
            BodyText += 'New Delhi 110046, India <br>';
            BodyText += 'Tel. +91 11 4711 9257 <br>';
            BodyText += 'Fax. +91 11 2852 1273 <br>';

            // if File.Exists('C:\InventorySizeWise\' + fileName) THEN BEGIN
            // FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\InventorySizeWise\' + fileName);
            if TempBlobCU.HasValue() then begin
                TempBlobCU.CreateInStream(InstreamVar);
                EmailMsg.Create(EmailAddressList, ' Depot Size wise Sales -' + FORMAT(ZHCode), BodyText, true, EmailBccList, EmailCCList);
                // if File.Exists('C:\InventorySizeWise\' + fileName) THEN
                EmailMsg.AddAttachment(CompletePath, 'application/pdf', InstreamVar);
                EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                // END;


                /*   IF (EXISTS('C:\InventorySizeWise\' + fileName)) THEN BEGIN
                       SMTPMailCodeUnit.AddAttachment(CompletePath, fileName);
                       SMTPMailCodeUnit.Send();
                       //MESSAGE('Mail Sent');
                   END;*/
            END;
        end;
    end;

    local procedure UpdateDepotLocationListUnderZH_SDepot()
    var
        MatrixMaster: Record "Matrix Master";
        TempZHCode: Code[10];
        UpdLocation: Record Location;
    begin
        MatrixMaster.RESET;
        MatrixMaster.SETCURRENTKEY(ZH, PCH);
        IF MatrixMaster.FINDFIRST THEN
            REPEAT
                UpdLocation.RESET;
                UpdLocation.SETRANGE("Sales Territory", MatrixMaster."Type 1");
                IF UpdLocation.FINDFIRST THEN BEGIN
                    UpdLocation.ZH := MatrixMaster.ZH;
                    UpdLocation.PCH := MatrixMaster.PCH;
                    UpdLocation.MODIFY;
                END;
            UNTIL MatrixMaster.NEXT = 0;
    end;


    procedure GenerateDepotSalesTrendPCH_Depot(Location: Record Location; PCHCode: Code[10])
    var
        SalesPersons: Record "Salesperson/Purchaser";
        DealerSchemeDetails: Record "Customer Scheme Details";
        txtfile: Text[250];
        SchemeMaster: Record "Scheme Master";
        EmailAddress: Text[250];
        InCorrectMail: Boolean;
        NoOfAtSigns: Integer;
        i: Integer;
        //  SMTPSetup: Record "409";
        //  SMTPMailCodeUnit: Codeunit "400";
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
        SalesValue: Decimal;
        SalesQty: Decimal;
        MonthlyAverage: Decimal;
        ASP: Decimal;
        InventoryAgeingMGT: Report "Depot Sales Trend Report";
        RecLocation: Record Location;
        MatrixMaster: Record "Matrix Master";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        PCHName: Text;
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
        EmailAddress := 'donotreply@orientbell.com';

        InCorrectMail := FALSE;
        Location.RESET;
        Location.SETFILTER(PCH, '%1', PCHCode);
        Location.SETRANGE(Depot, TRUE);
        IF Location.FINDFIRST THEN BEGIN
            fileName := 'DepotsalesTrend' + FORMAT(PCHCode) + '.xlsx';
            fileName := CONVERTSTR(fileName, '/', '_');
            CompletePath := 'C:\InventorySizeWise\' + fileName;
            CLEAR(InventoryAgeingMGT);
            InventoryAgeingMGT.SETTABLEVIEW(Location);
            // InventoryAgeingMGT.SAVEASEXCEL(CompletePath);

            MatrixMaster.RESET;
            MatrixMaster.SETRANGE("Type 1", Location."Sales Territory");
            IF MatrixMaster.FINDFIRST THEN BEGIN
                SalespersonPurchaser.SETRANGE(Code, MatrixMaster.PCH);
                IF SalespersonPurchaser.FINDFIRST THEN
                    EmailAddress := SalespersonPurchaser."E-Mail";
            END;
        END;
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

        CLEAR(PCHName);
        SalespersonPurchaser.RESET;
        SalespersonPurchaser.SETRANGE(Code, PCHCode);
        IF SalespersonPurchaser.FINDFIRST THEN
            PCHName := SalespersonPurchaser.Name;

        IF InCorrectMail = FALSE THEN BEGIN
            //  SMTPSetup.GET();
            //SMTPMailCodeUnit.CreateMessage('CSO Office - OBL','csooffice@orientbell.com','kulbhushan.sharma@orientbell.com',' Depot Performance Report -'+FORMAT(PCHCode),'',TRUE);
            /*  SMTPMailCodeUnit.CreateMessage('CSO Office - OBL', 'csooffice@orientbell.com', EmailAddress, ' Depot Performance Report -' + FORMAT(PCHCode), '', TRUE);
              SMTPMailCodeUnit.AddCC('kulbhushan.sharma@orientbell.com');*/
            EmailAddressList.Add('csooffice@orientbell.com');
            EmailCCList.Add('kulbhushan.sharma@orientbell.com');

            BodyText := 'Dear ' + PCHName + ',';
            BodyText += '<br><br>';
            BodyText += 'Please find the enclosed Depot Sales Trend Report.';
            BodyText += '<br><br>';
            BodyText += 'This is for your records';
            BodyText += '<br><br>';
            BodyText += 'Regards, <br>';
            BodyText += 'CSO Office, <br>';
            BodyText += 'Orient Bell Limited <br>';
            BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
            BodyText += 'New Delhi 110046, India <br>';
            BodyText += 'Tel. +91 11 4711 9257 <br>';
            BodyText += 'Fax. +91 11 2852 1273 <br>';

            // if File.Exists('C:\InventorySizeWise\' + fileName) THEN BEGIN
            // FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\InventorySizeWise\' + fileName);
            if TempBlobCU.HasValue() then begin
                TempBlobCU.CreateInStream(InstreamVar);
                EmailMsg.Create(EmailAddressList, ' Depot Performance Report -' + FORMAT(PCHCode), BodyText, true, EmailBccList, EmailCCList);
                // if File.Exists('C:\InventorySizeWise\' + fileName) THEN
                EmailMsg.AddAttachment(CompletePath, 'application/pdf', InstreamVar);
                EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default)
                // END;


                /* IF (EXISTS('C:\InventorySizeWise\' + fileName)) THEN BEGIN
                     SMTPMailCodeUnit.AddAttachment(CompletePath, fileName);
                     SMTPMailCodeUnit.Send();
                     //MESSAGE('Mail Sent');
                 END;*/
            END;
        end;
    end;
}

