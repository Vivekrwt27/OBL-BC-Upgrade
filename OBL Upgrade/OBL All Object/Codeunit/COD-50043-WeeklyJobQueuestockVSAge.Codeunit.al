codeunit 50043 "Weekly Job Queue stock VS Age"
{

    trigger OnRun()
    begin
        SendInventoryAgeingReport;  //Inventory Ageing
        SendVendorduedatepaymentReport;//Vendor Due Payment
                                       // 15578  SendIndentTrackingReport;



        // SendNPDDashboard;//NPD DashBoard
        //  SendProdVsSalesReport;//Production VS Sales ceo
    end;

    var
        GlbFromDate: Date;
        GlbToDate: Date;

    procedure GenerateInventoryAgeingReport(LocCode: Code[20])
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
        InventoryAgeingMGT: Report "Inventory Ageing -MGT";
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
        FromDate := GlbFromDate;
        ToDate := GlbToDate;
        EmailAddress := 'donotreply@orientbell.com';

        InCorrectMail := FALSE;
        CLEAR(Location);

        Location.RESET;
        IF LocCode <> '' THEN BEGIN
            Location.SETFILTER(Code, LocCode);
            Location.SETRANGE("Tableau Location", TRUE);
        END;
        IF Location.FINDFIRST THEN BEGIN
            fileName := '';
            IF LocCode = '' THEN
                fileName := 'AGE_ALL_Detailed' + FORMAT(ToDate) + '.xlsx';
            // ELSE
            // fileName := 'AGE_'+FORMAT(Location.Code)+FORMAT(ToDate)+'.xlsx';
            fileName := CONVERTSTR(fileName, '/', '_');
            CompletePath := 'C:\StateWiseReport\' + fileName;
            CLEAR(InventoryAgeingMGT);
            InventoryAgeingMGT.SETTABLEVIEW(Location);
            InventoryAgeingMGT.SetValues(TRUE);
            // InventoryAgeingMGT.SAVEASEXCEL(CompletePath);

            //MSAK190319
            fileName2 := '';
            IF LocCode = '' THEN
                fileName2 := 'AGE_ALL_Summary' + FORMAT(ToDate) + '.xlsx';
            // ELSE
            // fileName2 := 'AGE_'+FORMAT(Location.Code)+FORMAT(ToDate)+'.xlsx';
            fileName2 := CONVERTSTR(fileName2, '/', '_');
            CompletePath2 := 'C:\StateWiseReport\' + fileName2;
            CLEAR(InventoryAgeingMGT);
            InventoryAgeingMGT.SETTABLEVIEW(Location);
            InventoryAgeingMGT.SetValues(FALSE);
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
                //  SMTPSetup.GET();
                IF LocCode = '' THEN BEGIN
                    //SMTPMailCodeUnit.CreateMessage('Stock Report','donotreply@orientbell.com','donotreply@orientbell.com',' Stock/Ageing Report -'+FORMAT(LocCode),'',TRUE);
                    // SMTPMailCodeUnit.CreateMessage(' ', 'donotreply@orientbell.com.', 'anurag.maithani@orientbell.com', ' Stock/Ageing Report -' + FORMAT(LocCode), '', TRUE);
                    // SMTPMailCodeUnit.AddCC('pushpender.kumar@orientbell.com');
                    //  SMTPMailCodeUnit.AddCC('santosh.upadhyay@orientbell.com');
                    // SMTPMailCodeUnit.AddCC('divya.chauhan@orientbell.com');
                    //  SMTPMailCodeUnit.AddCC('rachit.vij@orientbell.com');
                    //  SMTPMailCodeUnit.AddCC('amit.goel@orientbell.com');
                    //  SMTPMailCodeUnit.AddCC('donotreply@orientbell.com');
                    EmailAddressList.Add('donotreply@orientbell.com.');
                    ///  EmailTo.Add('anurag.maithani@orientbell.com');
                    EmailCCList.Add('pushpender.kumar@orientbell.com');
                    EmailCCList.Add('santosh.upadhyay@orientbell.com');
                    EmailCCList.Add('divya.chauhan@orientbell.com');
                    EmailCCList.Add('rachit.vij@orientbell.com');
                    EmailCCList.Add('amit.goel@orientbell.com');
                    EmailCCList.Add('donotreply@orientbell.com');

                END ELSE BEGIN
                    //SMTPMailCodeUnit.CreateMessage('Stock Report','donotreply@orientbell.com','donotreply@orientbell.com',' Stock/Ageing Report -'+FORMAT(LocCode),'',TRUE);
                    // SMTPMailCodeUnit.CreateMessage(' ', 'donotreply@orientbell.com', 'anurag.maithani@orientbell.com', ' Stock/Ageing Report -' + FORMAT(LocCode), '', TRUE);
                    //  SMTPMailCodeUnit.AddCC('pushpender.kumar@orientbell.com');
                    //  SMTPMailCodeUnit.AddCC('santosh.upadhyay@orientbell.com');
                    //  SMTPMailCodeUnit.AddCC('rachit.vij@orientbell.com');
                    //  SMTPMailCodeUnit.AddCC('donotreply@orientbell.com');
                    //  SMTPMailCodeUnit.AddCC('amit.goel@orientbell.com');
                    //  SMTPMailCodeUnit.AddCC('divya.chauhan@orientbell.com');
                    EmailAddressList.Add('donotreply@orientbell.com.');
                    ///    EmailTo.Add('anurag.maithani@orientbell.com');
                    EmailCCList.Add('pushpender.kumar@orientbell.com');
                    EmailCCList.Add('santosh.upadhyay@orientbell.com');
                    EmailCCList.Add('divya.chauhan@orientbell.com');
                    EmailCCList.Add('rachit.vij@orientbell.com');
                    EmailCCList.Add('amit.goel@orientbell.com');
                    EmailCCList.Add('donotreply@orientbell.com');


                END;

                BodyText := 'Dear All,';
                BodyText += '<br><br>';
                BodyText += 'Please find the enclosed detail of sales vs stock comparison with ageing for the Current Month. ';
                BodyText += '<br><br>';
                BodyText += 'This is for your records';
                BodyText += '<br><br>';
                BodyText += 'Regards, <br>';
                BodyText += 'CFO Office, <br>';
                BodyText += 'Orient Bell Limited <br>';
                BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
                BodyText += 'New Delhi 110046, India <br>';
                BodyText += 'Tel. +91 11 4711 9252 <br>';
                BodyText += 'Fax. +91 11 2852 1273 <br>';

                // if File.Exists('C:\StateWiseReport\' + fileName) THEN BEGIN
                // FileMgmt.BLOBExportToServerFile(TempBlobCU, CompletePath);
                // FileMgmt.BLOBExportToServerFile(TempBlobCU, CompletePath2);
                if TempBlobCU.HasValue() then begin
                    TempBlobCU.CreateInStream(InstreamVar);
                    EmailMsg.Create(EmailAddressList, ' Stock/Ageing Report -' + FORMAT(LocCode), BodyText, true, EmailCCList, EmailBccList);
                    EmailMsg.AddAttachment(CompletePath, 'application/pdf', InstreamVar);
                    EmailMsg.AddAttachment(CompletePath2, 'application/pdf', InstreamVar);
                    EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
                end;
                // end;
                /*  IF (EXISTS('C:\StateWiseReport\' + fileName)) THEN BEGIN
                      SMTPMailCodeUnit.AddAttachment(CompletePath, fileName);
                      SMTPMailCodeUnit.AddAttachment(CompletePath2, fileName2);
                      SMTPMailCodeUnit.Send();
                      //MESSAGE('Mail Sent');
                  END;*/
            END;
        END;
    end;


    procedure SendInventoryAgeingReport()
    var
        Location: Record Location;
        TempZHCode: Code[10];
        MatrixMaster: Record "Matrix Master";
        TempLocation: Record Location;
    begin
        GenerateInventoryAgeingReport('');
        /*
        UpdateLocationListUnderZH;
        
        Location.RESET;
        Location.SETRANGE(Depot,TRUE);
        //Location.SETRANGE(Code,'DP-CALICUT');
        IF Location.FINDFIRST THEN BEGIN
        REPEAT
          GenerateInventoryAgeingReport(Location.Code);
        UNTIL Location.NEXT=0;
        END;
        
        Location.RESET;
        Location.SETCURRENTKEY(ZH);
        Location.SETFILTER(ZH,'<>%1','');
        Location.SETRANGE(Depot,TRUE);
        IF Location.FINDFIRST THEN BEGIN
        REPEAT
          IF Location.ZH <> TempZHCode THEN BEGIN
            TempLocation.RESET;
            TempLocation.SETRANGE(ZH,Location.ZH);
            IF TempLocation.FINDFIRST THEN
              GenerateInventoryAgeingReportZH(TempLocation,Location.ZH);
          END;
        UNTIL Location.NEXT=0;
        END;
        */

    end;


    procedure GenerateInventoryAgeingReportZH(Location: Record Location; ZHCode: Code[10])
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
        InventoryAgeingMGT: Report "Inventory Ageing -MGT";
        RecLocation: Record Location;
        MatrixMaster: Record "Matrix Master";
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
        FromDate := GlbFromDate;
        ToDate := GlbToDate;
        EmailAddress := 'donotreply@orientbell.com';

        InCorrectMail := FALSE;

        fileName := 'AGE_' + FORMAT(ZHCode) + FORMAT(ToDate) + '.xlsx';
        fileName := CONVERTSTR(fileName, '/', '_');
        CompletePath := 'C:\StateWiseReport\' + fileName;
        InventoryAgeingMGT.SETTABLEVIEW(Location);
        InventoryAgeingMGT.SetValues(FALSE);
        // InventoryAgeingMGT.SAVEASEXCEL(CompletePath);

        MatrixMaster.RESET;
        MatrixMaster.SETRANGE("Type 1", Location."Sales Territory");
        IF MatrixMaster.FINDFIRST THEN BEGIN
            SalespersonPurchaser.SETRANGE(Code, MatrixMaster.ZH);
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
            /*  SMTPSetup.GET();
              SMTPMailCodeUnit.CreateMessage('CFO Office - OBL', 'cfooffice@orientbell.com',
                                            EmailAddress, ' Depot Performance Report -' + FORMAT(ZHCode), '', TRUE);
              SMTPMailCodeUnit.AddCC('donotreply@orientbell.com');*/
            EmailAddressList.Add('cfooffice@orientbell.com');
            EmailCCList.Add('donotreply@orientbell.com');


            BodyText := 'Dear All,';
            BodyText += '<br><br>';
            BodyText += 'Please find the enclosed detail of sales vs stock comparison with ageing for the Current Month. ';
            BodyText += '<br><br>';
            BodyText += 'This is for your records';
            BodyText += '<br><br>';
            BodyText += 'Regards, <br>';
            BodyText += 'CFO Office, <br>';
            BodyText += 'Orient Bell Limited <br>';
            BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
            BodyText += 'New Delhi 110046, India <br>';
            BodyText += 'Tel. +91 11 4711 9252 <br>';
            BodyText += 'Fax. +91 11 2852 1273 <br>';

            // if File.Exists('C:\StateWiseReport\' + fileName) THEN BEGIN
            // FileMgmt.BLOBExportToServerFile(TempBlobCU, CompletePath);
            if TempBlobCU.HasValue() then begin
                TempBlobCU.CreateInStream(InstreamVar);
                EmailMsg.Create(EmailAddressList, 'Sales Invoice', BodyText, true, EmailCCList, EmailBccList);
                EmailMsg.AddAttachment(CompletePath, 'application/pdf', InstreamVar);
                EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
            end;
            // end;
            /* IF (EXISTS('C:\StateWiseReport\' + fileName)) THEN BEGIN
                 SMTPMailCodeUnit.AddAttachment(CompletePath, fileName);
                 //     SMTPMailCodeUnit.Send();
             END;*/
        END;
    end;

    local procedure UpdateLocationListUnderZH()
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
                    UpdLocation.MODIFY;
                END;
            UNTIL MatrixMaster.NEXT = 0;
    end;


    procedure SendVendorduedatepaymentReport()
    var
        Location: Record Location;
        TempZHCode: Code[10];
        MatrixMaster: Record "Matrix Master";
        TempLocation: Record Location;
        emailcc: Text;
        CreditorsReportMIS: Report "Creditors Report MIS";
        // SMTPMailCodeUnit: Codeunit 400;
        path: Text;
        filename: Text;

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

        CLEAR(CreditorsReportMIS);

        filename := 'Vendor_Payment_due.xlsx';
        path := 'C:\StateWiseReport\' + filename;
        // CreditorsReportMIS.SAVEASEXCEL(path);
        // SMTPMailCodeUnit.CreateMessage('CFO Office - OBL.', 'cfooffice@orientbell.com', 'donotreply@orientbell.com', ' Vendor Payment Due Date Report -', '', TRUE);
        //  SMTPMailCodeUnit.AddCC('himanshu.jindal@orientbell.com');
        //  SMTPMailCodeUnit.AddCC('sandeep.jhanwar@orientbell.com');
        // SMTPMailCodeUnit.AddCC('sumit.sharma@orientbell.com');
        // SMTPMailCodeUnit.AddCC('sandeep.narula@orientbell.com');
        // SMTPMailCodeUnit.AddCC('jatin.chhabra@orientbell.com');
        // SMTPMailCodeUnit.AddCC('kulbhushan.sharma@orientbell.com');
        EmailAddressList.Add('cfooffice@orientbell.com');
        EmailCCList.Add('himanshu.jindal@orientbell.com');
        EmailCCList.Add('sandeep.jhanwar@orientbell.com');
        EmailCCList.Add('sumit.sharma@orientbell.com');
        EmailCCList.Add('sandeep.narula@orientbell.com');
        EmailCCList.Add('jatin.chhabra@orientbell.com');
        EmailCCList.Add('kulbhushan.sharma@orientbell.com');


        BodyText := 'Dear All,';
        BodyText += '<br><br>';
        BodyText += 'Please find the enclosed detail of Vendor Payment Due Date Report as on Date. ';
        BodyText += '<br><br>';
        BodyText += 'This is for your records and necessary action please';
        BodyText += '<br><br>';
        BodyText += 'Regards, <br>';
        BodyText += 'Orient Bell Limited <br>';
        BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
        BodyText += 'New Delhi 110046, India <br>';
        BodyText += 'Tel. +91 11 4711 9252 <br>';
        BodyText += 'Fax. +91 11 2852 1273 <br>';
        // if File.Exists('C:\StateWiseReport\' + filename) THEN BEGIN
        // FileMgmt.BLOBExportToServerFile(TempBlobCU, path);
        if TempBlobCU.HasValue() then begin
            TempBlobCU.CreateInStream(InstreamVar);
            EmailMsg.Create(EmailAddressList, 'Sales Invoice', BodyText, true, EmailCCList, EmailBccList);
            EmailMsg.AddAttachment(path, 'application/pdf', InstreamVar);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        end;
        // end;

        /*IF (EXISTS('C:\StateWiseReport\' + filename)) THEN BEGIN
            SMTPMailCodeUnit.AddAttachment(path, filename);
            SMTPMailCodeUnit.Send();
            //MESSAGE('Mail Sent');
        END;*/
    end;

    local procedure SendProdVsSalesReport()
    var
        InventoryAgeingDataCalc: Codeunit "Inventory Ageing Data Calc.";
        recInventoryReportAgeingData: Record "EYAIM_ERP 108DFs Report";
        InventoryAgeingReport: Report "Inventory Ageing Report";
        // SMTPMail: Codeunit 400;
        PeriodText: Text;
        AsOnDate: Date;

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
        InventoryAgeingDataCalc.RUN;
        AsOnDate := TODAY - 1;
        PeriodText := FORMAT(AsOnDate, 0, '<Month Text>') + '-' + FORMAT(DATE2DMY(TODAY, 3));
        recInventoryReportAgeingData.RESET;
        // recInventoryReportAgeingData.SETRANGE(Month,PeriodText);
        recInventoryReportAgeingData.SETRANGE(MatchReason, 'DORA');
        IF recInventoryReportAgeingData.FIND('-') THEN BEGIN
            CLEAR(InventoryAgeingReport);
            InventoryAgeingReport.SETTABLEVIEW(recInventoryReportAgeingData);
            // InventoryAgeingReport.SAVEASEXCEL('C:\StateWiseReport\DRA_Prod_VS_Sales.xlsx');
        END;
        recInventoryReportAgeingData.RESET;
        // recInventoryReportAgeingData.SETRANGE(Month,PeriodText);
        recInventoryReportAgeingData.SETRANGE(MatchReason, 'HOSKOTE');
        IF recInventoryReportAgeingData.FIND('-') THEN BEGIN
            CLEAR(InventoryAgeingReport);
            InventoryAgeingReport.SETTABLEVIEW(recInventoryReportAgeingData);
            // InventoryAgeingReport.SAVEASEXCEL('C:\StateWiseReport\HSK_Prod_VS_Sales.xlsx');
        END;
        recInventoryReportAgeingData.RESET;
        // recInventoryReportAgeingData.SETRANGE(Month,PeriodText);
        recInventoryReportAgeingData.SETRANGE(MatchReason, 'SIKANDRABAD');
        IF recInventoryReportAgeingData.FIND('-') THEN BEGIN
            CLEAR(InventoryAgeingReport);
            InventoryAgeingReport.SETTABLEVIEW(recInventoryReportAgeingData);
            // InventoryAgeingReport.SAVEASEXCEL('C:\StateWiseReport\SKD_Prod_VS_Sales.xlsx');
        END;
        // SMTPMail.CreateMessage('CEO Office - OBL.','ceooffice@orientbell.com','kulbhushan.sharma@orientbell.com',' Production Planning Efficiency Report -'+PeriodText,'',TRUE);

        //  SMTPMail.CreateMessage('CEO Office - OBL.', 'ceooffice@orientbell.com', 'sanjeev.gupta@orientbell.com', ' Production Planning Efficiency Report -' + PeriodText, '', TRUE);
        EmailAddressList.Add('ceooffice@orientbell.com');
        /// EmailTo.Add('sanjeev.gupta@orientbell.com');
        BodyText := 'aditya.gupta@orientbell.com';
        BodyText += 'himanshu.jindal@orientbell.com';
        BodyText += 'anil.agarwal@orientbell.com';
        BodyText += 'alok.agarwal@orientbell.com';
        BodyText += 'pinaki.nandy@orientbell.com';
        BodyText += 'amit.gupta@orientbell.com';
        BodyText += 'santosh.upadhyay@orientbell.com';
        BodyText += 'ghanshyam.gupta@orientbell.com';
        BodyText += 'manoj.goyal@orientbell.com';
        BodyText += 'jagdish.pal@orientbell.com';
        BodyText += 'sumit.thapar@orientbell.com';
        BodyText += 'rachit.vij@orientbell.com';
        BodyText += 'jegatheeswaran.palsamy@orientbell.com';
        BodyText += 'anuj.prashar@orientbell.com';
        BodyText += 'pushpender.kumar@orientbell.com';
        BodyText += 'amit.goel@orientbell.com';
        BodyText += 'amitkumar.shukla@orientbell.com';
        BodyText += 'kulbhushan.sharma@orientbell.com';


        BodyText += 'Dear Sir,';
        BodyText += '<br><br>';
        BodyText += 'Please find the enclosed detail of Production Planning Efficiency Report as on Date.' + FORMAT(AsOnDate);
        BodyText += '<br><br>';
        BodyText += 'This is for your records and necessary action please, please note this includes only MTO and MTS (Only Premium Quality Stocks & Sales.';
        BodyText += '<br><br>';
        BodyText += 'Regards, <br>';
        BodyText += 'Orient Bell Limited <br>';
        BodyText += 'Iris House, 16 Business Center, Nangal Raya <br>';
        BodyText += 'New Delhi 110046, India <br>';
        BodyText += 'Tel. +91 11 4711 9252 <br>';
        BodyText += 'Fax. +91 11 2852 1273 <br>';
        // if File.Exists('C:\StateWiseReport\SKD_Prod_VS_Sales.xlsx') THEN begin
        // FileMgmt.BLOBExportToServerFile(TempBlobCU, 'C:\StateWiseReport\SKD_Prod_VS_Sales.xlsx');
        if TempBlobCU.HasValue() then begin
            TempBlobCU.CreateInStream(InstreamVar);
            // 15578    EmailMsg.Create(EmailAddressList, ' Production Planning Efficiency Report -' + PeriodText, ' Production Planning Efficiency Report -' + PeriodText, BodyText, true, EmailCCList, EmailBccList);
            // 15578    EmailMsg.AddAttachment(MPDFDetail."Document No." + '.pdf', 'application/pdf', InstreamVar);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        end;
        // end;
    end;
    /*   IF (EXISTS('C:\StateWiseReport\SKD_Prod_VS_Sales.xlsx')) THEN
           SMTPMail.AddAttachment('C:\StateWiseReport\SKD_Prod_VS_Sales.xlsx', 'SKD_Prod_VS_Sales.xlsx');

       IF (EXISTS('C:\StateWiseReport\HSK_Prod_VS_Sales.xlsx')) THEN
           SMTPMail.AddAttachment('C:\StateWiseReport\HSK_Prod_VS_Sales.xlsx', 'HSK_Prod_VS_Sales.xlsx');

       IF (EXISTS('C:\StateWiseReport\DRA_Prod_VS_Sales.xlsx')) THEN
           SMTPMail.AddAttachment('C:\StateWiseReport\DRA_Prod_VS_Sales.xlsx', 'DRA_Prod_VS_Sales.xlsx');

       SMTPMail.Send();
       //MESSAGE('Mail Sent');

   end;*/ // 15578

    local procedure SendNPDDashboard()
    var
        NPDDashboard: Report "NPD Dashboard";
        //   SMTPMail: Codeunit 400;
        PeriodText: Text;
        AsOnDate: Date;
        Customer: Record Customer;
    begin
        AsOnDate := TODAY - 1;
        PeriodText := FORMAT(AsOnDate, 0, '<Month Text>') + '-' + FORMAT(DATE2DMY(TODAY, 3));

        CLEAR(NPDDashboard);
        // NPDDashboard.SAVEASEXCEL('C:\StateWiseReport\NPDDashBoard.xlsx');

        /* 15578   SMTPMail.CreateMessage('Marketting - OBL.', 'donotreply@orientbell.com', 'rachit.vij@orientbell.com', 'NPD Dashboard -' + PeriodText, '', TRUE);
           SMTPMail.AddCC('kulbhushan.sharma@orientbell.com');


           SMTPMail.AppendBody('Dear Sir,');
           SMTPMail.AppendBody('<br><br>');
           SMTPMail.AppendBody('Please find the enclosed detail of NPD Dashboard as on Date.' + FORMAT(AsOnDate));
           SMTPMail.AppendBody('<br><br>');
           SMTPMail.AppendBody('Regards, <br>');
           SMTPMail.AppendBody('Orient Bell Limited <br>');
           SMTPMail.AppendBody('Iris House, 16 Business Center, Nangal Raya <br>');
           SMTPMail.AppendBody('New Delhi 110046, India <br>');
           SMTPMail.AppendBody('Tel. +91 11 4711 9252 <br>');
           SMTPMail.AppendBody('Fax. +91 11 2852 1273 <br>');
           IF (EXISTS('C:\StateWiseReport\NPDDashBoard.xlsx')) THEN
               SMTPMail.AddAttachment('C:\StateWiseReport\NPDDashBoard.xlsx', 'NPDDashBoard.xlsx');

           SMTPMail.Send();*/ // 15578
                              //MESSAGE('Mail Sent');
    end;


    procedure SendIndentTrackingReport()
    var
        txtfile: Text[250];
        EmailAddress: Text[250];
        InCorrectMail: Boolean;
        NoOfAtSigns: Integer;
        i: Integer;
        //  SMTPSetup: Record 409;
        //  SMTPMailCodeUnit: Codeunit 400;
        MSMDEData: Query "WS Inventory";
        SrNo: Integer;
        FromDate: Date;
        ToDate: Date;
        fileName: Text;
        CompletePath: Text;
        TotQty: Decimal;
        TotAmt: Decimal;
        BlnSendMail: Boolean;
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
        Text50030: Label '<td width="15%">';
        Width8: Label '<td width="8%">';
        Width30: Label '<td width="30%">';
        Text50031: Label '<td width="50%">';
        Text50032: Label '<FONT SIZE=6 FACE="Sans Serif">';
        Text50041: Label '<TD  width=5 Align=Center>';
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        PONo: Code[20];
        UserLocationMatrix: Record "Item Classification";
        UserSetup: Record "User Setup";
        User: Record User;
        Item: Record Item;
        ItemAgeCompositionQty: Report "Item Age Composition - Qty.";
        DtForm: DateFormula;
        IndentSummary: Report "Indent Summary";
        IndentHeader: Record "Indent Header";
    begin
        //IF CALCDATE('CM',TODAY) <> TODAY THEN
        //  EXIT;
        //EVALUATE(DtForm,'1M');
        CLEAR(ItemAgeCompositionQty);
        //fileName := 'C:\StateWiseReport\IndentTrackingReport.xlsx';
        fileName := 'C:\StateWiseReport\Pending Line Items Status_MTD.xlsx';
        IndentHeader.RESET;
        /* IF IndentHeader.FINDFIRST THEN BEGIN
            IndentSummary.SAVEASEXCEL(fileName);
        END; */
        /*
        
          InCorrectMail:=FALSE;
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID",UserLocationMatrix."User ID");
            IF UserSetup.FINDFIRST THEN
              EmailAddress := UserSetup."E-Mail";
        
          NoOfAtSigns:=0;
          FOR i := 1 TO STRLEN(EmailAddress) DO BEGIN
          IF EmailAddress[i] = '@' THEN
            NoOfAtSigns := NoOfAtSigns + 1;
          IF (((EmailAddress[i] >='a') AND (EmailAddress[i] <='z')) OR
            ((EmailAddress[i] >='A') AND (EmailAddress[i] <='Z')) OR
            ((EmailAddress[i] >='0') AND (EmailAddress[i] <='9')) OR
            (EmailAddress[i] IN ['@','.','-','_']))
          THEN BEGIN
            END ELSE BEGIN
                InCorrectMail:=TRUE;
            END
          END;
          */
        IF InCorrectMail = FALSE THEN BEGIN

            /* 15578   SMTPSetup.GET();
               SMTPMailCodeUnit.CreateMessage('COO Office - OBL.', 'cooffice@orientbell.com', 'anil.agarwal@orientbell.com',
                                             'Indent Tracking Report ' + FORMAT(TODAY), '', TRUE);
               SMTPMailCodeUnit.AddCC('kulbhushan.sharma@orientbell.com');
               SMTPMailCodeUnit.AddCC('nitin.kharya@orientbell.com');
               SMTPMailCodeUnit.AddCC('satyaprakash.gupta@orientbell.com');
               SMTPMailCodeUnit.AddCC('santosh.singh@orientbell.com');


               User.RESET;
               User.SETRANGE("User Name", UserSetup."User ID");
               IF User.FINDFIRST THEN
                   SMTPMailCodeUnit.AppendBody('Dear  ' + User."Full Name")
               ELSE
                   SMTPMailCodeUnit.AppendBody('Dear Sir, ');

               SMTPMailCodeUnit.AppendBody('<br><br>');

               SMTPMailCodeUnit.AppendBody('Please find the enclosed detail of Indent Tracking Report as on Date.' + FORMAT(TODAY));
               SMTPMailCodeUnit.AppendBody('<br>');
               //SMTPMailCodeUnit.AppendBody('Please submit the original documents at the earliest. Otherwise all transaction related to this vendor will be blocked.');
               //SMTPMailCodeUnit.AppendBody('<br>');

               SMTPMailCodeUnit.AppendBody(Text60006);
               SMTPMailCodeUnit.AppendBody(Text60011);

               SMTPMailCodeUnit.AppendBody('<br>');
               SMTPMailCodeUnit.AppendBody('This is for your information only');
               SMTPMailCodeUnit.AppendBody('<br><br>');
               SMTPMailCodeUnit.AppendBody('Regards, <br>');
               SMTPMailCodeUnit.AppendBody('Orient Bell Limited <br>');
               SMTPMailCodeUnit.AppendBody('Iris House, 16 Business Center, Nangal Raya <br>');
               SMTPMailCodeUnit.AppendBody('New Delhi 110046, India <br>');
               SMTPMailCodeUnit.AppendBody('Tel. +91 11 4711 9252 <br>');
               SMTPMailCodeUnit.AppendBody('Fax. +91 11 2852 1273 <br>');

               IF EXISTS(fileName) THEN BEGIN
                   SMTPMailCodeUnit.AddAttachment(fileName, COPYSTR(fileName, 20, 36));
               END;

               SMTPMailCodeUnit.Send();*/
        END;

    end;
}

