codeunit 50051 "SP  PCH Goal Sheet Calculation"
{

    trigger OnRun()
    begin
        StartProcessDate := 20230101D;
        EndProcessDate := 20230131D;
        //1110076

        //  DeleteOldData(1,'',StartProcessDate);
        //   GenerateFFData(1,'',StartProcessDate,EndProcessDate); //Process of Sales Person

        DeleteOldData(2, '1112598', StartProcessDate);
        GenerateFFData(2, '1112598', StartProcessDate, EndProcessDate); // Process for PCH

        //  DeleteOldData(3,'',StartProcessDate);
        //  GenerateFFData(3,'',StartProcessDate,EndProcessDate); // Process for Zonal Manager

        // DeleteOldData(4,'',StartProcessDate);
        //  GenerateFFData(4,'',StartProcessDate,EndProcessDate); //Zonal Head

        IF GUIALLOWED THEN
            MESSAGE('Done');
    end;

    var
        SalesJournalData: Query "Sales Journal Data";
        StartProcessDate: Date;
        EndProcessDate: Date;
        SalesPersonGoalTarget: Record "Sales Person Goal Target";
        NoOfRecords2: Integer;
        YTDRevenueStartDate: Date;
        JoiningDate: Date;
        FocSale: Decimal;
        FocSAlesQty: Decimal;
        FocSalesCount: Decimal;
        OnceTime: Boolean;
        GlbFieldType: Option " ",LYFocusSale,FocusTarget,FocusSale;


    procedure GenerateFFData(FFType: Option " ",SP,PCH,ZM,ZH; FFCode: Code[20]; FromDate: Date; ToDate: Date)
    var
        SalesPersonGoalDetails: Record "Sales Person Goal Details";
        SalesPersonGoalDetailsDataExists: Record "Sales Person Goal Details";
        FieldForceCode: Code[20];
        MonthDate: Date;
        YearStartDate: Date;
        YearEndDate: Date;
        CDQty: Decimal;
        PMTQty: Decimal;
        NoOfRecords: Integer;
        a: Integer;
        SalesPersonGoalTarget: Record "Sales Person Goal Target";
        b: Integer;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        LastYearSales: Decimal;
        NotReq: Decimal;
        NoOfSalesPersons: Integer;
        NoOFMonth: Decimal;
        LYSale: Decimal;
        CYSale: Decimal;
        MatrixMaster: Record "Matrix Master";
        LastYearStDate: Date;
        LastYearEndDate: Date;
        PrevYearSale: Decimal;
        CurrYearSale: Decimal;
    begin
        MonthDate := CALCDATE('-CM', ToDate);
        YearStartDate := CALCDATE('-CM-12M', ToDate);

        LastYearStDate := CALCDATE('-CM-12M', ToDate);
        LastYearEndDate := CALCDATE('CM', LastYearStDate);
        //ERROR('%1--%2', LastYearStDate,LastYearEndDate);

        YearEndDate := CALCDATE('-CM-1d', ToDate);
        //ERROR('%1', YearEndDate);
        //YearEndDate := ToDate;

        CLEAR(SalesJournalData);
        //SalesJournalData.SETFILTER(SalesJournalData.TableauZone,'<>%1','CKA'); //MSKS
        SalesJournalData.SETFILTER(PostingDateFilter, '%1..%2', FromDate, ToDate);
        CASE FFType OF
            FFType::SP:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesPersonFilter, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;
            FFType::PCH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(PCHFilter, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;
            FFType::ZH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.Zonal_Head, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;
            FFType::ZM:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.Zonal_Manager, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;

        END;

        SalesJournalData.OPEN;
        WHILE SalesJournalData.READ DO BEGIN
            CASE FFType OF
                FFType::SP:
                    BEGIN
                        FieldForceCode := SalesJournalData.SPCode;
                    END;
                FFType::PCH:
                    BEGIN
                        FieldForceCode := SalesJournalData.PCHCode;
                    END;
                FFType::ZM:
                    BEGIN
                        FieldForceCode := SalesJournalData.Zonal_Manager;
                    END;
                FFType::ZH:
                    BEGIN
                        FieldForceCode := SalesJournalData.Zonal_Head;
                    END;
            END;

            YTDRevenueStartDate := 20220104D;
            JoiningDate := 0D;
            IF SalespersonPurchaser.GET(FieldForceCode) THEN BEGIN
                YTDRevenueStartDate := (SalespersonPurchaser."Joining Date");
                JoiningDate := SalespersonPurchaser."Joining Date";
            END;

            IF YTDRevenueStartDate < 20220104D THEN
                YTDRevenueStartDate := 20220104D;

            SalesPersonGoalDetailsDataExists.RESET;
            SalesPersonGoalDetailsDataExists.SETFILTER("FF Type", '%1', FFType);
            SalesPersonGoalDetailsDataExists.SETFILTER("Field Force Code", '%1', FieldForceCode);
            SalesPersonGoalDetailsDataExists.SETFILTER("For Month", '%1', MonthDate);
            IF NOT SalesPersonGoalDetailsDataExists.FINDFIRST THEN BEGIN
                SalesPersonGoalDetails.INIT;
                SalesPersonGoalDetails."FF Type" := FFType;
                SalesPersonGoalDetails."Field Force Code" := FieldForceCode;

                SalesPersonGoalDetails.PCH := SalesJournalData.PCHCode;
                SalesPersonGoalDetails.ZM := SalesJournalData.Zonal_Manager;
                SalesPersonGoalDetails.ZH := SalesJournalData.Zonal_Head;
                SalesPersonGoalDetails."Last Year DSO" := SalespersonPurchaser."Last Year DSO";
                SalesPersonGoalDetails."Last Year ASP" := SalespersonPurchaser."Last Year ASP";
                SalesPersonGoalDetails.Territory := SalesJournalData.AreaCode;
                MatrixMaster.RESET;
                MatrixMaster.SETRANGE("Mapping Type", MatrixMaster."Mapping Type"::City);
                MatrixMaster.SETRANGE("Type 1", SalesJournalData.AreaCode);
                IF MatrixMaster.FINDFIRST THEN
                    SalesPersonGoalDetails."Strong Market" := MatrixMaster."Strong Market";

                SalesPersonGoalDetails."For Month" := MonthDate;
                //    SalesPersonGoalDetails."Last 12 Month Sale" := GetYearlyRevenue(FFType,FFCode,YearStartDate,YearEndDate);
                SalesPersonGoalDetails."Revenue for the Start Date" := YearStartDate;
                SalesPersonGoalDetails."Revenue for the End Date" := YearEndDate;
                SalesPersonGoalDetails."Revenue for the Year Date" := YTDRevenueStartDate;//SalesPersonGoalTarget.UpdatePeriod(1,MonthDate);

                IF FFType IN [FFType::ZH, FFType::ZM] THEN BEGIN
                    //SalesPersonGoalDetails."Last Revenue 90 Days" := GetYearlyRevenue(FFType,FieldForceCode,StartProcessDate-90,StartProcessDate);
                    PrevYearSale := 0;
                    CurrYearSale := 0;
                    GetMonthlyRevenue(FFType, SalesPersonGoalDetails."Field Force Code", EndProcessDate - 90, EndProcessDate,
                    CurrYearSale, NotReq,
                    NotReq, NotReq,
                    NotReq, NotReq,
                    NotReq, NotReq, NotReq, TRUE);

                    PrevYearSale := GetLastRevenue(FFType, SalesPersonGoalDetails."Field Force Code", EndProcessDate, EndProcessDate); // Last year Sales from Seperate history
                    SalesPersonGoalDetails."Last Revenue 90 Days" := PrevYearSale + CurrYearSale;

                END;
                SalesPersonGoalDetails.VALIDATE("Joining Date", JoiningDate);
                NoOFMonth := 1;
                NoOFMonth := ROUND((ToDate - YTDRevenueStartDate) / 30, 1.0, '=');
                IF NoOFMonth = 0 THEN
                    NoOFMonth := 1;
                SalesPersonGoalDetails."No. of Months" := NoOFMonth;

                SalesPersonGoalDetails.INSERT;
            END;
        END;
        SalesPersonGoalTarget.RESET;
        SalesPersonGoalTarget.SETFILTER("FF Type", '%1', FFType);
        IF FFCode <> '' THEN
            SalesPersonGoalTarget.SETFILTER("Field Force Code", '%1', FFCode);
        SalesPersonGoalTarget.SETFILTER(Period, '%1', MonthDate);
        SalesPersonGoalTarget.SETFILTER("Target Type", '%1', SalesPersonGoalTarget."Target Type"::Monthly);
        IF SalesPersonGoalTarget.FINDFIRST THEN BEGIN
            REPEAT
                YTDRevenueStartDate := 0D;
                IF SalespersonPurchaser.GET(SalesPersonGoalTarget."Field Force Code") THEN
                    YTDRevenueStartDate := (SalespersonPurchaser."Joining Date");

                IF YTDRevenueStartDate < 20220104D THEN
                    YTDRevenueStartDate := 20220104D;

                SalesPersonGoalDetailsDataExists.RESET;
                SalesPersonGoalDetailsDataExists.SETFILTER("FF Type", '%1', FFType);
                SalesPersonGoalDetailsDataExists.SETFILTER("Field Force Code", '%1', SalesPersonGoalTarget."Field Force Code");
                SalesPersonGoalDetailsDataExists.SETFILTER("For Month", '%1', MonthDate);
                IF NOT SalesPersonGoalDetailsDataExists.FINDFIRST THEN BEGIN
                    SalesPersonGoalDetails.INIT;
                    SalesPersonGoalDetails."FF Type" := FFType;
                    SalesPersonGoalDetails."Field Force Code" := SalesPersonGoalTarget."Field Force Code";
                    SalesPersonGoalDetails."For Month" := MonthDate;
                    SalesPersonGoalDetails."Revenue for the Start Date" := YearStartDate;
                    SalesPersonGoalDetails."Revenue for the End Date" := YearEndDate;
                    SalesPersonGoalDetails."Revenue for the Year Date" := YTDRevenueStartDate;//SalesPersonGoalTarget.UpdatePeriod(1,MonthDate);
                                                                                              //SalesPersonGoalDetails."Last Year Focus Sales (Same P)" := SalesPersonGoalTarget."Last Year Focus Sales";
                    NoOFMonth := 1;
                    NoOFMonth := ROUND((ToDate - YTDRevenueStartDate) / 30, 1.0, '=');
                    IF NoOFMonth = 0 THEN
                        NoOFMonth := 1;
                    SalesPersonGoalDetails."No. of Months" := NoOFMonth;
                    SalesPersonGoalDetails."Focus Sale Target" := SalesPersonGoalTarget."Base Range Sales Target";
                    SalesPersonGoalDetails."No. of Attrition" := SalesPersonGoalTarget.Attrition;
                    SalesPersonGoalDetails."Total Team Members" := SalesPersonGoalTarget."Total Team Members";
                    SalesPersonGoalDetails.INSERT;
                END ELSE BEGIN
                    SalesPersonGoalDetailsDataExists.RESET;
                    SalesPersonGoalDetailsDataExists.SETFILTER("FF Type", '%1', FFType);
                    SalesPersonGoalDetailsDataExists.SETFILTER("Field Force Code", '%1', SalesPersonGoalTarget."Field Force Code");
                    SalesPersonGoalDetailsDataExists.SETFILTER("For Month", '%1', MonthDate);
                    IF SalesPersonGoalDetailsDataExists.FINDFIRST THEN BEGIN
                        SalesPersonGoalDetailsDataExists."No. of Attrition" := SalesPersonGoalTarget.Attrition;
                        SalesPersonGoalDetailsDataExists."Total Team Members" := SalesPersonGoalTarget."Total Team Members";
                        //SalesPersonGoalDetailsDataExists."Last Year Focus Sales (Same P)" := SalesPersonGoalTarget."Last Year Focus Sales";
                        SalesPersonGoalDetailsDataExists.MODIFY;
                    END;
                END;
            UNTIL SalesPersonGoalTarget.NEXT = 0;
        END;

        SalesPersonGoalDetailsDataExists.RESET;
        SalesPersonGoalDetailsDataExists.SETFILTER("FF Type", '%1', FFType);
        IF FFCode <> '' THEN
            SalesPersonGoalDetailsDataExists.SETFILTER("Field Force Code", '%1', FFCode);
        SalesPersonGoalDetailsDataExists.SETFILTER("For Month", '%1', MonthDate);
        IF SalesPersonGoalDetailsDataExists.FINDFIRST THEN BEGIN
            REPEAT
                InitialiseRecords(SalesPersonGoalDetailsDataExists);

                SalesPersonGoalDetailsDataExists."Revenue Target" := GetRevenueTarget(FFType, SalesPersonGoalDetailsDataExists."Field Force Code", MonthDate);

                SalesPersonGoalDetailsDataExists."YTD Target" := SalesPersonGoalDetailsDataExists."Revenue Target" + GetYTDTarget(FFType, SalesPersonGoalDetailsDataExists."Field Force Code", MonthDate);

                SalesPersonGoalDetailsDataExists."Focus Sale Target" := GetRangeTarget(FFType, SalesPersonGoalDetailsDataExists."Field Force Code", MonthDate);
                SalesPersonGoalDetailsDataExists."Annual Revenue Target" := GetAnnualRevenueTarget(FFType, SalesPersonGoalDetailsDataExists."Field Force Code", SalesPersonGoalDetailsDataExists."Revenue for the Year Date");

                GetMonthlyRevenue(FFType, SalesPersonGoalDetailsDataExists."Field Force Code", StartProcessDate, EndProcessDate,
                SalesPersonGoalDetailsDataExists."Revenue Achieved", SalesPersonGoalDetailsDataExists."Revenue Qty.",
                SalesPersonGoalDetailsDataExists."CD Sales", SalesPersonGoalDetailsDataExists."CD Qty.",
                SalesPersonGoalDetailsDataExists."PMT Sales", SalesPersonGoalDetailsDataExists."PMT Qty.",
                SalesPersonGoalDetailsDataExists."Focus Sale", SalesPersonGoalDetailsDataExists."Focus Sale Qty", SalesPersonGoalDetailsDataExists."Focus Sale Count", FALSE);
                //FocSale,FocSAlesQty,FocSalesCount,TRUE);

                //12 month DAys Changed to 90D 05-082019 MSKS
                //ERROR('%1..%2',EndProcessDate-90,EndProcessDate);
                SalesPersonGoalDetailsDataExists."90 Days Sale" :=
                                    GetLastRevenue(FFType, SalesPersonGoalDetailsDataExists."Field Force Code", EndProcessDate, EndProcessDate) + // Last year Sales from Seperate history
                                    GetYearlyRevenue(FFType, SalesPersonGoalDetailsDataExists."Field Force Code", EndProcessDate - 90, EndProcessDate);

                SalesPersonGoalDetailsDataExists."Percentage Achieved" := CalculatePercentage(SalesPersonGoalDetailsDataExists."Revenue Achieved", SalesPersonGoalDetailsDataExists."Revenue Target");
                //MSKS
                SalesPersonGoalDetailsDataExists.ASP := SalesPersonGoalDetailsDataExists.CalculateASP(SalesPersonGoalDetailsDataExists."Revenue Achieved", SalesPersonGoalDetailsDataExists."Revenue Qty.");
                SalesPersonGoalDetailsDataExists."Points on ASP" := SalesPersonGoalDetailsDataExists.CalculatePointsONASP(SalesPersonGoalDetailsDataExists.ASP);
                SalesPersonGoalDetailsDataExists."Points on Revenue" := SalesPersonGoalDetailsDataExists.CalculatePointsONRevenue(SalesPersonGoalDetailsDataExists."FF Type", SalesPersonGoalDetailsDataExists."Percentage Achieved");
                SalesPersonGoalDetailsDataExists.VALIDATE(Outstanding, CalculateOutstanding(FFType, SalesPersonGoalDetailsDataExists."Field Force Code"));
                SalesPersonGoalDetailsDataExists.UpdateOtherFields;


                GetMonthlyRevenue(FFType, SalesPersonGoalDetailsDataExists."Field Force Code", SalesPersonGoalDetailsDataExists."Revenue for the Year Date", EndProcessDate,
                SalesPersonGoalDetailsDataExists."YTD Revenue Achieved", SalesPersonGoalDetailsDataExists."YTD Revenue Qty.",
                SalesPersonGoalDetailsDataExists."YTD CD Sales", SalesPersonGoalDetailsDataExists."YTD CD Qty.",
                SalesPersonGoalDetailsDataExists."YTD PMT Sales", SalesPersonGoalDetailsDataExists."YTD PMT Qty.", FocSale, FocSAlesQty, FocSalesCount, FALSE);
                //Kulwant
                SalesPersonGoalDetailsDataExists."YTD Revenue Achieved" := 0;
                SalesPersonGoalDetailsDataExists."YTD Revenue Qty." := 0;
                GetYTDRevenueAchieve(FFType, SalesPersonGoalDetailsDataExists."Field Force Code", EndProcessDate, SalesPersonGoalDetailsDataExists."YTD Revenue Achieved"
                , SalesPersonGoalDetailsDataExists."YTD Revenue Qty.");
                SalesPersonGoalDetailsDataExists."YTD Revenue Achieved" += SalesPersonGoalDetailsDataExists."Revenue Achieved";
                SalesPersonGoalDetailsDataExists."YTD Revenue Qty." += SalesPersonGoalDetailsDataExists."Revenue Qty.";
                //Kulwant
                SalesPersonGoalDetailsDataExists.UpdateOtherFields;


                //    GetMonthlyRevenue(FFType,SalesPersonGoalDetailsDataExists."Field Force Code",010421D,310322D,
                //    SalesPersonGoalDetailsDataExists."Base Line Last Year",NotReq,NotReq,NotReq,NotReq,NotReq,NotReq,NotReq,NotReq,FALSE);
                //GetLastYearRevenue(
                GetLastYearRevenue(FFType, SalesPersonGoalDetailsDataExists."Field Force Code", LastYearStDate, LastYearEndDate,
                SalesPersonGoalDetailsDataExists."Base Line Last Year", NotReq, NotReq, NotReq, NotReq, NotReq, SalesPersonGoalDetailsDataExists."Last Year Focus Sales (Same P)",
                NotReq, NotReq, FALSE);

                SalesPersonGoalDetailsDataExists."AOP % Age Total Revenue" := CalculateIncDecPercentage(SalesPersonGoalDetailsDataExists."Base Line Last Year", SalesPersonGoalDetailsDataExists."Revenue Target");

                SalesPersonGoalDetailsDataExists."Focus Sale Target" := SalesPersonGoalDetailsDataExists."Last Year Focus Sales (Same P)" + (SalesPersonGoalDetailsDataExists."Last Year Focus Sales (Same P)" * SalesPersonGoalDetailsDataExists."AOP % Age Total Revenue" / 100);

                SalesPersonGoalDetailsDataExists."PMT Opportunity Qty." := CalculatePMTExpSales(SalesPersonGoalDetailsDataExists."FF Type", SalesPersonGoalDetailsDataExists."Field Force Code");
                SalesPersonGoalDetailsDataExists."PMT Opportunity Value" := SalesPersonGoalDetailsDataExists."PMT Opportunity Qty." * SalesPersonGoalDetailsDataExists."Last Year ASP";

                IF IsEligibleforPMTPoints(SalesPersonGoalDetailsDataExists."PMT Opportunity Value", SalesPersonGoalDetailsDataExists."Annual Revenue Target") THEN BEGIN
                    SalesPersonGoalDetailsDataExists."PMT Opportunity Percentage" := CalculatePercentage(SalesPersonGoalDetailsDataExists."PMT Sales", SalesPersonGoalDetailsDataExists."Revenue Achieved");
                END ELSE
                    SalesPersonGoalDetailsDataExists."PMT Opportunity Percentage" := 0;

                IF FFType IN [FFType::PCH, FFType::ZM] THEN
                    NoOfSalesPersons := GetNoofSalesForce(SalesPersonGoalDetailsDataExists."Field Force Code")
                ELSE
                    NoOfSalesPersons := 1;

                IF NoOfSalesPersons = 0 THEN
                    NoOfSalesPersons := 1;

                GetCreationRevivalRevenue(FFType, SalesPersonGoalDetailsDataExists."Field Force Code", StartProcessDate, EndProcessDate, SalesPersonGoalDetailsDataExists."Creation Sales", SalesPersonGoalDetailsDataExists."Revival Sales");

                GetCreationRevivalRevenue(FFType, SalesPersonGoalDetailsDataExists."Field Force Code", 20220104D, EndProcessDate, SalesPersonGoalDetailsDataExists."YTD Creation Sales", SalesPersonGoalDetailsDataExists."YTD Revival Sales");

                //ERROR('%1--%2',ToDate,YTDRevenueStartDate);
                SalesPersonGoalDetailsDataExists."No. of Sales Force" := NoOfSalesPersons;

                SalesPersonGoalDetailsDataExists."Revival Sales Contribution %ag" := CalculatePercentage(SalesPersonGoalDetailsDataExists."Revival Sales", SalesPersonGoalDetailsDataExists."Revenue Achieved");

                SalesPersonGoalDetailsDataExists."Points on Creation/Revival" := SalesPersonGoalDetailsDataExists.CalculatePointsOnRevivalSales(FFType, (SalesPersonGoalDetailsDataExists."Revival Sales Contribution %ag"));
                SalesPersonGoalDetailsDataExists."YTD Creation/Revival Points" := SalesPersonGoalDetailsDataExists.CalculatePointsOnRevivalSales(FFType, CalculatePercentage(SalesPersonGoalDetailsDataExists."YTD Revival Sales", SalesPersonGoalDetailsDataExists."YTD Revenue Achieved"));

                LYSale := 0;
                CYSale := 0;
                IF FFType IN [FFType::PCH, FFType::ZH, FFType::ZM] THEN
                    SalesPersonGoalDetailsDataExists."Total No. CP Count Week Mkt CY" := NoofCountCPWeekMarket(FFType, SalesPersonGoalDetailsDataExists."Field Force Code", FALSE);

                /*   IF FFType IN  [FFType::PCH,FFType::ZM] THEN BEGIN
                    IF SalesPersonGoalDetailsDataExists."Strong Market" THEN BEGIN
                    GatherDataforStongMkt(SalesPersonGoalDetailsDataExists."FF Type",SalesPersonGoalDetailsDataExists."Field Force Code",StartProcessDate,EndProcessDate,
                                       SalesPersonGoalDetailsDataExists."CY Cust. Count",LYSale,CYSale);

                    GatherDataforStongMkt(SalesPersonGoalDetailsDataExists."FF Type",SalesPersonGoalDetailsDataExists."Field Force Code",010422D,EndProcessDate,
                                       SalesPersonGoalDetailsDataExists."YTD CY Cust. Count",SalesPersonGoalDetailsDataExists."YTD LY Sales",SalesPersonGoalDetailsDataExists."YTD CY Sales");

                     SalesPersonGoalDetailsDataExists."LY Sales" := LYSale;
                     SalesPersonGoalDetailsDataExists."CY Sales" := CYSale;

                    // SalesPersonGoalDetailsDataExists."Points on Market Type" :=
                    // SalesPersonGoalDetailsDataExists.CalculatePointsonMarket(FFType,StartProcessDate,SalesPersonGoalDetailsDataExists."Strong Market",LYSale,CYSale,SalesPersonGoalDetailsDataExists."CY Cust. Count");

               //      SalesPersonGoalDetailsDataExists."YTD Points on Market Type" :=
                //     SalesPersonGoalDetailsDataExists.CalculatePointsonMarket(FFType,StartProcessDate,SalesPersonGoalDetailsDataExists."Strong Market",
                                                      SalesPersonGoalDetailsDataExists."YTD LY Sales",SalesPersonGoalDetailsDataExists."YTD CY Sales",SalesPersonGoalDetailsDataExists."YTD CY Cust. Count");


                   END ELSE BEGIN
                    GatherDataforWeekMkt(SalesPersonGoalDetailsDataExists."FF Type",SalesPersonGoalDetailsDataExists."Field Force Code",StartProcessDate,EndProcessDate,
                                       SalesPersonGoalDetailsDataExists."CY Cust. Count",LYSale,CYSale);
                    GatherDataforWeekMkt(SalesPersonGoalDetailsDataExists."FF Type",SalesPersonGoalDetailsDataExists."Field Force Code",010422D,EndProcessDate,
                                       SalesPersonGoalDetailsDataExists."YTD CY Cust. Count",SalesPersonGoalDetailsDataExists."YTD LY Sales",SalesPersonGoalDetailsDataExists."YTD CY Sales");

                     SalesPersonGoalDetailsDataExists."LY Sales" := LYSale;
                     SalesPersonGoalDetailsDataExists."CY Sales" := CYSale;

                     SalesPersonGoalDetailsDataExists."Points on Market Type" :=
                     SalesPersonGoalDetailsDataExists.CalculatePointsonMarket(FFType,StartProcessDate,SalesPersonGoalDetailsDataExists."Strong Market",LYSale,CYSale,SalesPersonGoalDetailsDataExists."Total No. CP Count Week Mkt CY");

                     SalesPersonGoalDetailsDataExists."YTD Points on Market Type" :=
                     SalesPersonGoalDetailsDataExists.CalculatePointsonMarket(FFType,StartProcessDate,SalesPersonGoalDetailsDataExists."Strong Market",
                                                      SalesPersonGoalDetailsDataExists."YTD LY Sales",SalesPersonGoalDetailsDataExists."YTD CY Sales"/SalesPersonGoalDetailsDataExists."No. of Months",SalesPersonGoalDetailsDataExists."YTD CY Cust. Count");

                   END;
                   END;*/
                //ZH Calculation
                IF FFType IN [FFType::ZH, FFType::ZM] THEN BEGIN
                    //Same Store
                    GatherDataforStongMkt(SalesPersonGoalDetailsDataExists."FF Type", SalesPersonGoalDetailsDataExists."Field Force Code", StartProcessDate, EndProcessDate,
                                       SalesPersonGoalDetailsDataExists."CY Cust. Count", SalesPersonGoalDetailsDataExists."LY Sales", SalesPersonGoalDetailsDataExists."CY Sales");
                    // LYSale := GetLastRevenue(SalesPersonGoalDetailsDataExists."FF Type",SalesPersonGoalDetailsDataExists."Field Force Code",LastYearStDate,LastYearEndDate);

                    //SalesPersonGoalDetailsDataExists."LY Sales" := LYSale;
                    //new Store
                    GatherDataforWeekMkt(SalesPersonGoalDetailsDataExists."FF Type", SalesPersonGoalDetailsDataExists."Field Force Code", StartProcessDate, EndProcessDate,
                                       SalesPersonGoalDetailsDataExists."CY Cust. Count New Market", SalesPersonGoalDetailsDataExists."LY Sales New Market", SalesPersonGoalDetailsDataExists."CY Sales New Market");
                    //LYSale := GetLastRevenue();

                    //Pt. Same Store
                    SalesPersonGoalDetailsDataExists."Points on Same Sales Growth" :=
                    SalesPersonGoalDetailsDataExists.CalculatePointsonSameStoreGrowth(FFType, StartProcessDate, SalesPersonGoalDetailsDataExists."Strong Market",
                                                                                    SalesPersonGoalDetailsDataExists."LY Sales", SalesPersonGoalDetailsDataExists."CY Sales", SalesPersonGoalDetailsDataExists."CY Cust. Count");
                    //Pt. New Store
                    SalesPersonGoalDetailsDataExists."Points on New SAles Growth" :=
                    SalesPersonGoalDetailsDataExists.CalculatePointsonNewStoreGrowth(FFType, StartProcessDate, SalesPersonGoalDetailsDataExists."Strong Market",
                                                                                    SalesPersonGoalDetailsDataExists."LY Sales New Market", SalesPersonGoalDetailsDataExists."CY Sales New Market", SalesPersonGoalDetailsDataExists."Total No. CP Count Week Mkt CY");

                    //YTD Same Store
                    GatherDataforStongMkt(SalesPersonGoalDetailsDataExists."FF Type", SalesPersonGoalDetailsDataExists."Field Force Code", 20220104D, EndProcessDate,
                                       SalesPersonGoalDetailsDataExists."YTD CY Cust. Count", SalesPersonGoalDetailsDataExists."YTD LY Sales", SalesPersonGoalDetailsDataExists."YTD CY Sales");

                    //YTD Pt. Same Store
                    SalesPersonGoalDetailsDataExists."YTDPoints on Same Sales Growth" :=
                    SalesPersonGoalDetailsDataExists.CalculatePointsonSameStoreGrowth(SalesPersonGoalDetailsDataExists."FF Type", StartProcessDate, SalesPersonGoalDetailsDataExists."Strong Market",
                                                     SalesPersonGoalDetailsDataExists."YTD LY Sales", SalesPersonGoalDetailsDataExists."YTD CY Sales", SalesPersonGoalDetailsDataExists."YTD CY Cust. Count");

                    //YTD Pt. New Store Wrong
                    SalesPersonGoalDetailsDataExists."YTDPoints on New SAles Growth" :=
                    SalesPersonGoalDetailsDataExists.CalculatePointsonSameStoreGrowth(FFType, StartProcessDate, SalesPersonGoalDetailsDataExists."Strong Market",
                                                     SalesPersonGoalDetailsDataExists."YTD CY Cust. Count New Market", SalesPersonGoalDetailsDataExists."YTD LY Sales New Market", SalesPersonGoalDetailsDataExists."YTD CY Sales New Market");
                    //YTD new Store
                    GatherDataforWeekMkt(SalesPersonGoalDetailsDataExists."FF Type", SalesPersonGoalDetailsDataExists."Field Force Code", 20220104D, EndProcessDate,
                                        SalesPersonGoalDetailsDataExists."YTD CY Cust. Count New Market", SalesPersonGoalDetailsDataExists."YTD LY Sales New Market", SalesPersonGoalDetailsDataExists."YTD CY Sales New Market");

                    SalesPersonGoalDetailsDataExists."YTDPoints on New SAles Growth" :=
                    SalesPersonGoalDetailsDataExists.CalculatePointsonNewStoreGrowth(FFType, StartProcessDate, SalesPersonGoalDetailsDataExists."Strong Market",
                                                                                  SalesPersonGoalDetailsDataExists."YTD LY Sales New Market" / SalesPersonGoalDetailsDataExists."No. of Months", SalesPersonGoalDetailsDataExists."YTD CY Sales New Market", SalesPersonGoalDetailsDataExists."YTD CY Cust. Count New Market");

                    //    CalculateCPCount(FFType,SalesPersonGoalDetailsDataExists."Field Force Code",StartProcessDate,EndProcessDate,
                    //                    SalesPersonGoalDetailsDataExists."Total No. of CP",SalesPersonGoalDetailsDataExists."Total No. of CP Greater 2L",NotReq,
                    //                    NotReq);

                    //    SalesPersonGoalDetailsDataExists."Pt. on CP Counts":=  SalesPersonGoalDetailsDataExists.CalculatePointsonCP2L(SalesPersonGoalDetailsDataExists."Total No. of CP Greater 2L",SalesPersonGoalDetailsDataExists."Total No. of CP");
                    //    SalesPersonGoalDetailsDataExists."Pts. on Attrition":=  SalesPersonGoalDetailsDataExists.CalculatePointsonAttritions(
                    //                                                            SalesPersonGoalDetailsDataExists."No. of Attrition",SalesPersonGoalDetailsDataExists."Total Team Members");
                    //SalesPersonGoalDetailsDataExists."Last Revenue 90 Days" := GetYearlyRevenue(FFType,SalesPersonGoalDetailsDataExists."Field Force Code",StartProcessDate-90,StartProcessDate);
                    /*
                        IF FFType= FFType::ZH THEN BEGIN
                        //SalesPersonGoalDetails."Last Revenue 90 Days" := GetYearlyRevenue(FFType,FieldForceCode,StartProcessDate-90,StartProcessDate);
                        GetMonthlyRevenue(FFType,SalesPersonGoalDetailsDataExists."Field Force Code",EndProcessDate-90,EndProcessDate,
                        SalesPersonGoalDetailsDataExists."Last Revenue 90 Days",NotReq,
                        NotReq,NotReq,
                        NotReq,NotReq,
                        NotReq,NotReq,NotReq,TRUE);

                        END;
                        */

                    SalesPersonGoalDetailsDataExists."Outstanding 75 DAys" := Calculate75DayOutstanding(FFType, SalesPersonGoalDetailsDataExists."Field Force Code", EndProcessDate - 75);



                    SalesPersonGoalDetailsDataExists."Pts. on Increase Cash FLow" := SalesPersonGoalDetailsDataExists.CalculatePointsonCashFlowIncrease
                                                                                  (SalesPersonGoalDetailsDataExists."FF Type", SalesPersonGoalDetailsDataExists."Last Year DSO", CalculatePercentage(SalesPersonGoalDetailsDataExists."Outstanding 75 DAys", SalesPersonGoalDetailsDataExists."90 Days Sale"));
                END;

                SalesPersonGoalDetailsDataExists."Focus AOP Growth %age" := CalculateIncDecPercentage(SalesPersonGoalDetailsDataExists."Last Year Focus Sales (Same P)", SalesPersonGoalDetailsDataExists."Focus Sale");

                SalesPersonGoalDetailsDataExists."Focus Sale Points" :=
                   SalesPersonGoalDetailsDataExists.CalculatePointsOnRangeSales(FFType, SalesPersonGoalDetailsDataExists."Focus Sale", SalesPersonGoalDetailsDataExists."Focus Sale Target");

                GetLastYearRevenue(FFType, SalesPersonGoalDetailsDataExists."Field Force Code", 20220104D, LastYearEndDate,
                SalesPersonGoalDetailsDataExists."YTD Base Line Sales", NotReq, NotReq, NotReq, NotReq, NotReq, NotReq,
                NotReq, NotReq, FALSE);


                SalesPersonGoalDetailsDataExists."YTD LY Focus Target" := SalesPersonGoalDetailsDataExists."Focus Sale Target" +
                    CalculateYTDData(GlbFieldType::FocusTarget, FFType, SalesPersonGoalDetailsDataExists."Field Force Code", 20220104D, EndProcessDate);

                SalesPersonGoalDetailsDataExists."YTD Focus Sales" := SalesPersonGoalDetailsDataExists."Focus Sale" +
                    CalculateYTDData(GlbFieldType::FocusSale, FFType, SalesPersonGoalDetailsDataExists."Field Force Code", 20220104D, EndProcessDate);

                SalesPersonGoalDetailsDataExists."YTD Last Year Focus Sale" := SalesPersonGoalDetailsDataExists."Last Year Focus Sales (Same P)" +
                    CalculateYTDData(GlbFieldType::LYFocusSale, FFType, SalesPersonGoalDetailsDataExists."Field Force Code", YTDRevenueStartDate, EndProcessDate);

                SalesPersonGoalDetailsDataExists."YTD Focus AOP Growth %age" :=
                    CalculateIncDecPercentage(SalesPersonGoalDetailsDataExists."YTD Last Year Focus Sale", SalesPersonGoalDetailsDataExists."YTD Focus Sales");

                IF SalesPersonGoalDetailsDataExists."PMT Opportunity Percentage" <> 0 THEN
                    SalesPersonGoalDetailsDataExists."Points on PMT" := SalesPersonGoalDetailsDataExists.CalculatePointsOnPMT(SalesPersonGoalDetailsDataExists."FF Type", CalculatePercentage(SalesPersonGoalDetailsDataExists."PMT Sales", SalesPersonGoalDetailsDataExists."Revenue Achieved"));

                GatherDataforNewCustomerGrowth(SalesPersonGoalDetailsDataExists."FF Type", SalesPersonGoalDetailsDataExists."Field Force Code", StartProcessDate, EndProcessDate,
                                   SalesPersonGoalDetailsDataExists."CY Cust. Count New Market", SalesPersonGoalDetailsDataExists."LY Sales New Market", SalesPersonGoalDetailsDataExists."CY Sales New Market");

                GatherDataforSameCustomerGrowth(SalesPersonGoalDetailsDataExists."FF Type", SalesPersonGoalDetailsDataExists."Field Force Code", StartProcessDate, EndProcessDate,
                                   SalesPersonGoalDetailsDataExists."OBTP Count - Same Growth", SalesPersonGoalDetailsDataExists."OBTP LY Sales - Same Growth", SalesPersonGoalDetailsDataExists."OBTP Sales - Same Growth");

                SalesPersonGoalDetailsDataExists."Points on New SAles Growth" :=
                                    SalesPersonGoalDetailsDataExists.CalculatePointsonNewStoreGrowth(SalesPersonGoalDetailsDataExists."FF Type", StartProcessDate,
                                    FALSE, SalesPersonGoalDetailsDataExists."LY Sales New Market", SalesPersonGoalDetailsDataExists."CY Sales New Market", SalesPersonGoalDetailsDataExists."CY Cust. Count New Market");

                SalesPersonGoalDetailsDataExists."Points on Same Sales Growth" :=
                                    SalesPersonGoalDetailsDataExists.CalculatePointsonSameStoreGrowth(SalesPersonGoalDetailsDataExists."FF Type", StartProcessDate,
                                    FALSE, SalesPersonGoalDetailsDataExists."OBTP LY Sales - Same Growth", SalesPersonGoalDetailsDataExists."OBTP Sales - Same Growth",
                                    SalesPersonGoalDetailsDataExists."OBTP Count - Same Growth");

                SalesPersonGoalDetailsDataExists."YTD AOP % Age Total Revenue" :=
                    CalculateIncDecPercentage(SalesPersonGoalDetailsDataExists."YTD Base Line Sales", SalesPersonGoalDetailsDataExists."YTD Target");

                SalesPersonGoalDetailsDataExists.MODIFY;
            UNTIL SalesPersonGoalDetailsDataExists.NEXT = 0;
        END;

        /*
        SalesPersonGoalDetailsDataExists.RESET;
        SalesPersonGoalDetailsDataExists.SETCURRENTKEY("For Month","Total Points Earned");
        SalesPersonGoalDetailsDataExists.SETFILTER("FF Type",'%1',FFType);
        SalesPersonGoalDetailsDataExists.SETFILTER("For Month",'%1',MonthDate);
        IF SalesPersonGoalDetailsDataExists.FINDFIRST THEN BEGIN
          NoOfRecords := SalesPersonGoalDetailsDataExists.COUNT;
          REPEAT
            SalesPersonGoalDetailsDataExists.Ranking := NoOfRecords-a;
            a+=1;
            SalesPersonGoalDetailsDataExists.MODIFY;
          UNTIL SalesPersonGoalDetailsDataExists.NEXT=0;
        END;
        
        //YTD Ranking MSAK 020819
              SalesPersonGoalDetailsDataExists.RESET;
              SalesPersonGoalDetailsDataExists.SETCURRENTKEY("For Month","Total YTD Points Earned");
              SalesPersonGoalDetailsDataExists.SETFILTER("FF Type",'%1',FFType);
              SalesPersonGoalDetailsDataExists.SETFILTER("For Month",'%1',MonthDate);
              IF SalesPersonGoalDetailsDataExists.FINDFIRST THEN BEGIN
                NoOfRecords2 := SalesPersonGoalDetailsDataExists.COUNT;
                REPEAT
                  SalesPersonGoalDetailsDataExists."YTD Ranking" := NoOfRecords2-b;
                  b+=1;
                  SalesPersonGoalDetailsDataExists.MODIFY;
                UNTIL SalesPersonGoalDetailsDataExists.NEXT=0;
              END;
        //YTD Ranking END MSAK 020819
        */

    end;


    procedure GetYearlyRevenue(FFType: Option " ",SP,PCH,ZM,ZH; FFCode: Code[20]; FromDate: Date; ToDate: Date) Amt: Decimal
    var
        SalesJournalData: Query "Sales Journal Data";
        FieldForceCode: Code[20];
        MonthDate: Date;
        SalesJournalData1: Query "Sales Return Journal Data";
    begin
        CLEAR(SalesJournalData);
        SalesJournalData.SETFILTER(SalesJournalData.TableauZone, '<>%1', 'Enterprise'); //MSKS
        SalesJournalData.SETFILTER(PostingDateFilter, '%1..%2', FromDate, ToDate);
        CASE FFType OF
            FFType::SP:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesPersonFilter, '%1', FFCode);
                END;
            FFType::PCH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(PCHFilter, '%1', FFCode);
                END;
            FFType::ZH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.Zonal_Head, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;
            FFType::ZM:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.Zonal_Manager, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;

        END;

        SalesJournalData.OPEN;
        WHILE SalesJournalData.READ DO BEGIN
            CASE FFType OF
                FFType::SP:
                    BEGIN
                        FieldForceCode := SalesJournalData.SPCode;
                    END;
                FFType::PCH:
                    BEGIN
                        FieldForceCode := SalesJournalData.PCHCode;
                    END;
                FFType::ZH:
                    BEGIN
                        FieldForceCode := SalesJournalData.Zonal_Head;
                    END;
                FFType::ZM:
                    BEGIN
                        FieldForceCode := SalesJournalData.Zonal_Manager;
                    END;
            END;
            // 15578  Amt += SalesJournalData.AmountToCustomer;
        END;

        CLEAR(SalesJournalData1);
        SalesJournalData.SETFILTER(SalesJournalData.TableauZone, '<>%1', 'Enterprise'); //MSKS
        SalesJournalData1.SETFILTER(PostingDateFilter, '%1..%2', FromDate, ToDate);
        CASE FFType OF
            FFType::SP:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData1.SETFILTER(SalesPersonFilter, '%1', FFCode);
                END;
            FFType::PCH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData1.SETFILTER(PCHFilter, '%1', FFCode);
                END;
            FFType::ZH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData1.SETFILTER(SalesJournalData1.Zonal_Head, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;
            FFType::ZM:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData1.SETFILTER(SalesJournalData1.Zonal_Manager, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;

        END;

        SalesJournalData1.OPEN;
        WHILE SalesJournalData1.READ DO BEGIN
            CASE FFType OF
                FFType::SP:
                    BEGIN
                        FieldForceCode := SalesJournalData1.SPCode;
                    END;
                FFType::PCH:
                    BEGIN
                        FieldForceCode := SalesJournalData1.PCHCode;
                    END;
                FFType::ZM:
                    BEGIN
                        FieldForceCode := SalesJournalData1.Zonal_Manager;
                    END;
                FFType::ZH:
                    BEGIN
                        FieldForceCode := SalesJournalData1.Zonal_Head;
                    END;

            END;
            // 15578  Amt -= SalesJournalData1.Amount_To_Customer;
        END;
        EXIT(Amt);
    end;


    procedure GetMonthlyRevenue(FFType: Option " ",SP,PCH,ZM,ZH; FFCode: Code[20]; FromDate: Date; ToDate: Date; var SalesAmt: Decimal; var SalesQty: Decimal; var CDSales: Decimal; var CDQty: Decimal; var PMTSales: Decimal; var PMTQty: Decimal; var RangeSale: Decimal; var RangeSaleQty: Decimal; var RangeSaleCount: Decimal; IncGST: Boolean)
    var
        SalesJournalData: Query "Sales Journal Data";
        FieldForceCode: Code[20];
        MonthDate: Date;
        SalesJournalData1: Query "Sales Return Journal Data";
        LastGoalCode: Code[20];
        LastDealerCode: Code[20];
        RangeProdSalesSqlMt: Decimal;
        QryFocusCount: Query "Focus Count";
        TotGSTAmt: Decimal;
    begin
        PMTQty := 0;
        PMTSales := 0;
        CDQty := 0;
        CDSales := 0;
        SalesAmt := 0;
        SalesQty := 0;
        FocSale := 0;
        FocSalesCount := 0;
        FocSAlesQty := 0;
        RangeSale := 0;
        RangeSaleCount := 0;
        RangeSaleQty := 0;
        TotGSTAmt := 0;
        CLEAR(SalesJournalData);
        //IF FFType=FFType::PCH THEN
        SalesJournalData.SETFILTER(SalesJournalData.TableauZone, '<>%1', 'Enterprise'); //MSKS
        SalesJournalData.SETFILTER(PostingDateFilter, '%1..%2', FromDate, ToDate);
        CASE FFType OF
            FFType::SP:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesPersonFilter, '%1', FFCode);
                END;
            FFType::PCH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(PCHFilter, '%1', FFCode);
                END;
            FFType::ZH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.Zonal_Head, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;
            FFType::ZM:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.Zonal_Manager, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;

        END;

        SalesJournalData.OPEN;
        WHILE SalesJournalData.READ DO BEGIN
            CASE FFType OF
                FFType::SP:
                    BEGIN
                        FieldForceCode := SalesJournalData.SPCode;
                    END;
                FFType::PCH:
                    BEGIN
                        FieldForceCode := SalesJournalData.PCHCode;
                    END;
                FFType::ZH:
                    BEGIN
                        FieldForceCode := SalesJournalData.Zonal_Head;
                    END;
                FFType::ZM:
                    BEGIN
                        FieldForceCode := SalesJournalData.Zonal_Manager;
                    END;
            END;
            SalesAmt += SalesJournalData.LineAmount;
            SalesQty += SalesJournalData.Quantity_Base;
            // 15578    TotGSTAmt += SalesJournalData.Total_GST_Amount;

            IF SalesJournalData.Discount_Charges <> 0 THEN BEGIN
                CDSales += SalesJournalData.LineAmount;
                CDQty += SalesJournalData.Quantity_Base;
            END;
            IF SalesJournalData.PMTCode <> '' THEN BEGIN
                PMTSales += SalesJournalData.LineAmount;
                PMTQty += SalesJournalData.Quantity_Base;
            END;

            IF IsFocusProduct(SalesJournalData.SizeCodeDesc, SalesJournalData.TabProdGrp, SalesJournalData.TypeCatCodeDesc) THEN BEGIN
                RangeSale += SalesJournalData.LineAmount;
                RangeSaleQty += SalesJournalData.Quantity_Base;
            END;
        END;

        CLEAR(SalesJournalData1);
        //IF FFType=FFType::PCH THEN
        SalesJournalData1.SETFILTER(SalesJournalData1.TableauZone, '<>%1', 'Enterprise'); //MSKS
        SalesJournalData1.SETFILTER(PostingDateFilter, '%1..%2', FromDate, ToDate);
        CASE FFType OF
            FFType::SP:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData1.SETFILTER(SalesPersonFilter, '%1', FFCode);
                END;
            FFType::PCH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData1.SETFILTER(PCHFilter, '%1', FFCode);
                END;
            FFType::ZH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData1.SETFILTER(SalesJournalData1.Zonal_Head, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;
            FFType::ZM:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData1.SETFILTER(SalesJournalData1.Zonal_Manager, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;

        END;

        SalesJournalData1.OPEN;
        WHILE SalesJournalData1.READ DO BEGIN
            CASE FFType OF
                FFType::SP:
                    BEGIN
                        FieldForceCode := SalesJournalData1.SPCode;
                    END;
                FFType::PCH:
                    BEGIN
                        FieldForceCode := SalesJournalData1.PCHCode;
                    END;
                FFType::ZM:
                    BEGIN
                        FieldForceCode := SalesJournalData1.Zonal_Manager;
                    END;
                FFType::ZH:
                    BEGIN
                        FieldForceCode := SalesJournalData1.Zonal_Head;
                    END;

            END;
            SalesAmt -= SalesJournalData1.LineAmount;
            SalesQty -= SalesJournalData1.Quantity_Base;
            // 15578    TotGSTAmt -= SalesJournalData1.Total_GST_Amount;


            IF IsFocusProduct(SalesJournalData1.SizeCodeDesc, SalesJournalData1.TabProdGrp, SalesJournalData1.TypeCatCodeDesc) THEN BEGIN
                RangeSale -= SalesJournalData1.LineAmount;
                RangeSaleQty -= SalesJournalData1.Quantity_Base;
            END;
            /*
            IF SalesJournalData1.Discount_Charges<>0 THEN BEGIN
              CDSales += SalesJournalData1.LineAmount;
              CDQty += SalesJournalData1.Quantity_Base;
            END;*/
            /*
            IF SalesJournalData1.PMTCode <>'' THEN BEGIN
              PMTSales += SalesJournalData1.LineAmount;
              PMTQty += SalesJournalData1.Quantity_Base;
            END;
            */
        END;

        IF IncGST THEN BEGIN
            SalesAmt := SalesAmt + TotGSTAmt;
        END;

        /*
        IF CalcRangeData THEN BEGIN
        CLEAR(QryFocusCount);
        QryFocusCount.SETFILTER(QryFocusCount.TableauZoneFilter,'<>%1','CKA');
        QryFocusCount.SETFILTER(PostingDateFilter,'%1..%2',FromDate,ToDate);
        CASE FFType OF
        FFType::SP:
          BEGIN
            IF FFCode<>'' THEN
              QryFocusCount.SETFILTER(QryFocusCount.SalesPersonFilter,'%1',FFCode);
          END;
        FFType::PCH:
          BEGIN
            IF FFCode<>'' THEN
              QryFocusCount.SETFILTER(QryFocusCount.PCHFilter,'%1',FFCode);
          END;
        FFType::ZM:
          BEGIN
            IF FFCode<>'' THEN
              QryFocusCount.SETFILTER(QryFocusCount.Zonal_Manager ,'%1',FFCode);
          END;
        FFType::ZH:
          BEGIN
            IF FFCode<>'' THEN
              QryFocusCount.SETFILTER(QryFocusCount.Zonal_Head,'%1',FFCode);
          END;
        END;
        QryFocusCount.OPEN;
        WHILE QryFocusCount.READ DO BEGIN
        
          RangeSaleCount +=1;
          RangeSaleQty += QryFocusCount.Sum_Quantity_Base;
          RangeSale += QryFocusCount.Sum_Line_Amount;
        END;
        
        END;
        */

    end;

    local procedure InitialiseRecords(var SalesPersonGoalDetailsDataExists: Record "Sales Person Goal Details")
    begin
        SalesPersonGoalDetailsDataExists."CD Sales" := 0;
        SalesPersonGoalDetailsDataExists."Revenue Target" := 0;
        SalesPersonGoalDetailsDataExists."Revenue Achieved" := 0;
        SalesPersonGoalDetailsDataExists.ASP := 0;
        SalesPersonGoalDetailsDataExists."90 Days Sale" := 0;
        SalesPersonGoalDetailsDataExists.Outstanding := 0;
        SalesPersonGoalDetailsDataExists."Outstanding per Day" := 0;
        //SalesPersonGoalDetailsDataExists.PCH:='';
        SalesPersonGoalDetailsDataExists."Percentage Achieved" := 0;
        SalesPersonGoalDetailsDataExists."PMT Sales" := 0;
        SalesPersonGoalDetailsDataExists."Points on ASP" := 0;
        SalesPersonGoalDetailsDataExists."Point on CD" := 0;
        SalesPersonGoalDetailsDataExists."Points on Outstanding" := 0;
        SalesPersonGoalDetailsDataExists."Points on PMT" := 0;
        SalesPersonGoalDetailsDataExists."Points on Revenue" := 0;
        SalesPersonGoalDetailsDataExists."CY Cust. Count" := 0;
        SalesPersonGoalDetailsDataExists."CY Sales" := 0;
        SalesPersonGoalDetailsDataExists."LY Sales" := 0;
        IF SalesPersonGoalDetailsDataExists."Joining Date" > 20220104D THEN
            SalesPersonGoalDetailsDataExists."Revenue for the Year Date" := SalesPersonGoalDetailsDataExists."Joining Date"
        ELSE
            SalesPersonGoalDetailsDataExists."Revenue for the Year Date" := 20220104D;
        SalesPersonGoalDetailsDataExists."Creation Sales" := 0;
        SalesPersonGoalDetailsDataExists."Revival Sales" := 0;

        SalesPersonGoalDetailsDataExists."YTD Revival Sales" := 0;
        SalesPersonGoalDetailsDataExists."YTD Creation Sales" := 0;
        SalesPersonGoalDetailsDataExists."Points on Creation/Revival" := 0;
        SalesPersonGoalDetailsDataExists."YTD Creation/Revival Points" := 0;

        SalesPersonGoalDetailsDataExists."Points on Market Type" := 0;
        SalesPersonGoalDetailsDataExists."CY Cust. Count" := 0;
        SalesPersonGoalDetailsDataExists."CY Sales" := 0;
        SalesPersonGoalDetailsDataExists."LY Sales" := 0;
    end;


    procedure CalculatePercentage(a: Decimal; b: Decimal): Decimal
    begin
        IF b <> 0 THEN
            EXIT(ROUND((a / b) * 100, 0.01, '='));
    end;


    procedure CalculateOutstanding(FFType: Option " ",SP,PCH,ZM,ZH; FFCode: Code[20]) Amt: Decimal
    var
        Customer: Record Customer;
        OldBalance: Decimal;
        CustBalance: Decimal;
    begin
        Customer.RESET;
        Customer.SETCURRENTKEY("PCH Code", "Salesperson Code");
        CASE FFType OF
            FFType::SP:
                Customer.SETFILTER("Salesperson Code", '%1', FFCode);
            FFType::PCH:
                Customer.SETFILTER("PCH Code", '%1', FFCode);
            FFType::ZM:
                Customer.SETFILTER("Zonal Manager", '%1', FFCode);
            FFType::ZH:
                Customer.SETFILTER("Zonal Head", '%1', FFCode);
        END;
        Customer.SETFILTER("Tableau Zone", '<>%1', 'Enterprise');
        IF Customer.FINDFIRST THEN
            REPEAT
                // Customer.CALCFIELDS("Balance (LCY)",Balance);
                //OldBalance := CalcOutstandingON(Customer."No.",010119D);
                // IF (Customer.Balance ) > 0 THEN
                CustBalance := 0;
                CustBalance := CalcActualBalance(Customer."No.", TODAY);
                IF CustBalance > 10 THEN
                    Amt += (CustBalance);
            UNTIL Customer.NEXT = 0;
        EXIT(Amt);
    end;


    procedure GetRevenueTarget(FFType: Option " ",SP,PCH,ZM,ZH; FFCode: Code[20]; ForPeriod: Date): Decimal
    var
        SalesPersonGoalTarget: Record "Sales Person Goal Target";
    begin
        SalesPersonGoalTarget.RESET;
        //IF FFType= FFType::SP THEN
        SalesPersonGoalTarget.SETFILTER("FF Type", '%1', FFType);
        SalesPersonGoalTarget.SETFILTER("Field Force Code", '%1', FFCode);
        SalesPersonGoalTarget.SETFILTER(Period, '%1', ForPeriod);
        SalesPersonGoalTarget.SETFILTER("Target Type", '%1', SalesPersonGoalTarget."Target Type"::Monthly);
        IF SalesPersonGoalTarget.FINDFIRST THEN
            EXIT(SalesPersonGoalTarget."Revenue Target");
    end;


    procedure GetRangeTarget(FFType: Option " ",SP,PCH,ZM,ZH; FFCode: Code[20]; ForPeriod: Date): Decimal
    var
        SalesPersonGoalTarget: Record "Sales Person Goal Target";
    begin
        SalesPersonGoalTarget.RESET;
        //IF FFType= FFType::SP THEN
        SalesPersonGoalTarget.SETFILTER("FF Type", '%1', FFType);
        SalesPersonGoalTarget.SETFILTER("Field Force Code", '%1', FFCode);
        SalesPersonGoalTarget.SETFILTER(Date, '%1', ForPeriod);
        SalesPersonGoalTarget.SETFILTER("Target Type", '%1', SalesPersonGoalTarget."Target Type"::Monthly);
        IF SalesPersonGoalTarget.FINDFIRST THEN
            EXIT(SalesPersonGoalTarget."Base Range Sales Target");
    end;


    procedure GetAnnualRevenueTarget(FFType: Option " ",SP,PCH,ZM,ZH; FFCode: Code[20]; ForPeriod: Date): Decimal
    var
        SalesPersonGoalTarget: Record "Sales Person Goal Target";
    begin
        SalesPersonGoalTarget.RESET;
        //IF FFType= FFType::SP THEN BEGIN
        SalesPersonGoalTarget.SETFILTER("FF Type", '%1', FFType);
        SalesPersonGoalTarget.SETFILTER("Field Force Code", '%1', FFCode);
        SalesPersonGoalTarget.SETFILTER(Date, '%1..%2', 20220104D, 20230331D);
        SalesPersonGoalTarget.SETFILTER("Target Type", '%1', SalesPersonGoalTarget."Target Type"::Annually);
        IF SalesPersonGoalTarget.FINDFIRST THEN
            EXIT(SalesPersonGoalTarget."Revenue Target");
        //END;
    end;


    procedure GetYTDTarget(FFType: Option " ",SP,PCH,ZM,ZH; FFCode: Code[20]; ForPeriod: Date) YTDTarget: Decimal
    var
        SalesPersonGoalDetails: Record "Sales Person Goal Details";
    begin
        SalesPersonGoalDetails.RESET;
        SalesPersonGoalDetails.SETFILTER("For Month", '%1..%2', YTDRevenueStartDate, ForPeriod);
        SalesPersonGoalDetails.SETFILTER("FF Type", '%1', FFType);
        SalesPersonGoalDetails.SETFILTER("Field Force Code", '%1', FFCode);
        IF SalesPersonGoalDetails.FINDFIRST THEN
            REPEAT
                YTDTarget += SalesPersonGoalDetails."Revenue Target";
            UNTIL SalesPersonGoalDetails.NEXT = 0;
    end;


    procedure GetRevenueStartDate(DtofJoin: Date) StDate1: Date
    begin
        StDate1 := 20220104D;
        IF DtofJoin <> 0D THEN
            IF DtofJoin >= StDate1 THEN
                EXIT(DtofJoin)
            ELSE
                EXIT(StDate1)
        ELSE
            EXIT(StDate1);
    end;

    local procedure GenerateSalesRevenueTargetData(FFType: Option " ",SP,PCH,ZM,ZH; FFCode: Code[20]; DtDate: Date)
    var
        SalesPersonGoalTarget: Record "Sales Person Goal Target";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        SalesAmt: Decimal;
        SalesQty: Decimal;
        StDate: Date;
        EDate: Date;
        NotReq: Decimal;
    begin
        StDate := CALCDATE('-CM-12M', DtDate);
        EDate := CALCDATE('CM', StDate);
        //ERROR('%1--%2',StDate,EDate);
        SalespersonPurchaser.RESET;
        IF FFCode <> '' THEN
            SalespersonPurchaser.SETFILTER(Code, '%1', FFCode);
        SalespersonPurchaser.SETFILTER("Customer No.", '%1', '');
        IF SalespersonPurchaser.FINDFIRST THEN BEGIN
            REPEAT
                SalesPersonGoalTarget.RESET;
                SalesPersonGoalTarget.SETFILTER(Period, '%1', DtDate);
                IF FFType = FFType::SP THEN
                    SalesPersonGoalTarget.SETFILTER("FF Type", '%1', SalesPersonGoalTarget."FF Type"::"Sales Person");
                IF FFType = FFType::PCH THEN
                    SalesPersonGoalTarget.SETFILTER("FF Type", '%1', SalesPersonGoalTarget."FF Type"::PCH);

                SalesPersonGoalTarget.SETFILTER("Field Force Code", '%1', SalespersonPurchaser.Code);
                IF NOT SalesPersonGoalTarget.FINDFIRST THEN BEGIN
                    GetMonthlyRevenue(FFType, SalespersonPurchaser.Code, StDate, EDate, SalesAmt, SalesQty, NotReq, NotReq, NotReq, NotReq, NotReq, NotReq, NotReq, FALSE);
                    SalesPersonGoalTarget.INIT;
                    SalesPersonGoalTarget."FF Type" := FFType;
                    SalesPersonGoalTarget."Field Force Code" := SalespersonPurchaser.Code;
                    SalesPersonGoalTarget."Target Type" := SalesPersonGoalTarget."Target Type"::Monthly;
                    SalesPersonGoalTarget.Period := DtDate;
                    SalesPersonGoalTarget.Date := DtDate;
                    SalesPersonGoalTarget.Name := SalespersonPurchaser.Name;
                    SalesPersonGoalTarget."Revenue Target" := SalesAmt;
                    IF SalesAmt <> 0 THEN
                        SalesPersonGoalTarget.INSERT;
                END;
            UNTIL SalespersonPurchaser.NEXT = 0;
        END;
    end;

    local procedure GetCreationRevivalRevenue(FFType: Option " ",SP,PCH,ZM,ZH; FFCode: Code[20]; FromDate: Date; ToDate: Date; var CreationAmt: Decimal; var RevivalAmt: Decimal)
    var
        SalesJournalData: Query "Sales Journal Data";
        FieldForceCode: Code[20];
        MonthDate: Date;
        SalesJournalData1: Query "Sales Return Journal Data";
    begin
        CreationAmt := 0;
        RevivalAmt := 0;
        CLEAR(SalesJournalData);
        SalesJournalData.SETFILTER(SalesJournalData.TableauZone, '<>%1', 'Enterprise'); //MSKS
        SalesJournalData.SETFILTER(PostingDateFilter, '%1..%2', FromDate, ToDate);
        SalesJournalData.SETFILTER(SalesJournalData.AWS, '%1|%2', 'Ashvamedha-3', 'Ashvamedha-4');
        CASE FFType OF
            FFType::SP:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesPersonFilter, '%1', FFCode);
                END;
            FFType::PCH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(PCHFilter, '%1', FFCode);
                END;
            FFType::ZH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.Zonal_Head, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;
            FFType::ZM:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.Zonal_Manager, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;

        END;

        SalesJournalData.OPEN;
        WHILE SalesJournalData.READ DO BEGIN
            // IF (SalesJournalData.Revival_Date <>0D)  THEN
            RevivalAmt += SalesJournalData.LineAmount;
        END;

        CLEAR(SalesJournalData1);
        SalesJournalData1.SETFILTER(SalesJournalData1.TableauZone, '<>%1', 'Enterprise'); //MSKS
        SalesJournalData1.SETFILTER(PostingDateFilter, '%1..%2', FromDate, ToDate);
        SalesJournalData1.SETFILTER(AWS, '%1|%2', 'Ashvamedha-3', 'Ashvamedha-4');
        CASE FFType OF
            FFType::SP:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData1.SETFILTER(SalesPersonFilter, '%1', FFCode);
                END;
            FFType::PCH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData1.SETFILTER(PCHFilter, '%1', FFCode);
                END;
            FFType::ZM:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData1.SETFILTER(SalesJournalData1.Zonal_Manager, '%1', FFCode);
                END;
            FFType::ZH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData1.SETFILTER(SalesJournalData1.Zonal_Head, '%1', FFCode);
                END;
        END;

        SalesJournalData1.OPEN;
        WHILE SalesJournalData1.READ DO BEGIN
            //IF SalesJournalData1.Revival_Date <>0D THEN
            RevivalAmt -= SalesJournalData1.LineAmount;
        END;
    end;

    local procedure GetNoofSalesForce(PCHCode: Code[20]) CountSP: Integer
    var
        PCHSalesPerson: Query "PCH SalesPerson";
    begin
        CLEAR(PCHSalesPerson);
        PCHSalesPerson.SETFILTER(PCHSalesPerson.PCHFilters, '%1', PCHCode);
        PCHSalesPerson.OPEN;
        WHILE PCHSalesPerson.READ DO BEGIN
            CountSP += 1;
        END;
    end;

    local procedure DeleteOldData(FFType: Option " ",SP,PCH,ZM,ZH; FFCode: Code[20]; MonthDate: Date): Decimal
    var
        SalesPersonGoalDetails: Record "Sales Person Goal Details";
    begin
        SalesPersonGoalDetails.RESET;
        SalesPersonGoalDetails.SETFILTER("FF Type", '%1', FFType);
        IF FFCode <> '' THEN
            SalesPersonGoalDetails.SETFILTER("Field Force Code", '%1', FFCode);
        SalesPersonGoalDetails.SETFILTER("For Month", '%1', MonthDate);
        IF SalesPersonGoalDetails.FINDFIRST THEN
            SalesPersonGoalDetails.DELETEALL;
    end;

    local procedure GetYTDRevenueAchieve(FFType: Option " ",SP,PCH,ZM,ZH; FFCode: Code[20]; MonthDate: Date; var YtdRevenue: Decimal; var YTDQty: Decimal)
    var
        SalesPersonGoalDetails: Record "Sales Person Goal Details";
        Amt: Decimal;
        Qty: Decimal;
    begin
        SalesPersonGoalDetails.RESET;
        SalesPersonGoalDetails.SETFILTER("FF Type", '%1', FFType);
        IF FFCode <> '' THEN
            SalesPersonGoalDetails.SETFILTER("Field Force Code", '%1', FFCode);
        SalesPersonGoalDetails.SETFILTER("For Month", '%1..%2', 20220104D, MonthDate);
        IF SalesPersonGoalDetails.FINDFIRST THEN
            REPEAT
                YtdRevenue += SalesPersonGoalDetails."Revenue Achieved";
                YTDQty += SalesPersonGoalDetails."Revenue Qty.";
            UNTIL SalesPersonGoalDetails.NEXT = 0;
    end;

    local procedure GatherDataforStongMkt(FFType: Option " ",SP,PCH,ZM,ZH; FFCode: Code[20]; FromDate: Date; ToDate: Date; var Cnt: Decimal; var LYSales: Decimal; var CYSales: Decimal): Decimal
    var
        SalesJournalData: Query "Sales Journal Data";
        SalesJournalData1: Query "Sales Return Journal Data";
        LYSalesJournalData: Query "Last Year Data";
        TmpCustomerAmount: Record "Sales Invoice Line" temporary;
        LYStartDate: Date;
        LYEndDate: Date;
        LastDealerCode: Code[20];
        Mnth: Integer;
        MatrixMaster: Record "Matrix Master";
    begin
        LYSales := 0;
        CYSales := 0;
        TmpCustomerAmount.DELETEALL;
        LYStartDate := CALCDATE('-CM', CALCDATE('-1Y', FromDate));
        LYEndDate := CALCDATE('CM', CALCDATE('-1Y', ToDate));
        Mnth := DATE2DMY(FromDate, 2);
        CLEAR(TmpCustomerAmount);
        CLEAR(LYSalesJournalData);
        LYSalesJournalData.SETFILTER(LYSalesJournalData.DocumentType, '%1', LYSalesJournalData.DocumentType::Invoice); //MSKS
        LYSalesJournalData.SETFILTER(LYSalesJournalData.Tableau_Zone, '<>%1', 'CKA'); //MSKS
        LYSalesJournalData.SETFILTER(LYSalesJournalData.PostingDate, '%1..%2', LYStartDate, LYEndDate);
        CASE FFType OF
            FFType::SP:
                BEGIN
                    IF FFCode <> '' THEN
                        LYSalesJournalData.SETFILTER(LYSalesJournalData.SPCode, '%1', FFCode);
                END;
            FFType::PCH:
                BEGIN
                    IF FFCode <> '' THEN
                        LYSalesJournalData.SETFILTER(LYSalesJournalData.PCHCode, '%1', FFCode);
                END;
            FFType::ZH:
                BEGIN
                    IF FFCode <> '' THEN
                        LYSalesJournalData.SETFILTER(LYSalesJournalData.Zonal_Head, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;
            FFType::ZM:
                BEGIN
                    IF FFCode <> '' THEN
                        LYSalesJournalData.SETFILTER(LYSalesJournalData.Zonal_Manager, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;
        END;

        LYSalesJournalData.OPEN;
        WHILE LYSalesJournalData.READ DO BEGIN
            IF (LYSalesJournalData.OBTB_Joining_Date <= 20210104D) AND ((LYSalesJournalData.OBTB_Joining_Date <> 0D)) THEN BEGIN
                TmpCustomerAmount.RESET;
                TmpCustomerAmount.SETFILTER("Document No.", '%1', LYSalesJournalData.CustomerNo);
                TmpCustomerAmount.SETFILTER("Sell-to Customer No.", '%1', LYSalesJournalData.CustomerNo);
                IF NOT TmpCustomerAmount.FINDFIRST THEN BEGIN
                    TmpCustomerAmount.INIT;
                    TmpCustomerAmount."Document No." := LYSalesJournalData.CustomerNo;
                    TmpCustomerAmount."Sell-to Customer No." := LYSalesJournalData.CustomerNo;
                    TmpCustomerAmount."Line Amount" := LYSalesJournalData.Sum_LineAmount;
                    TmpCustomerAmount.INSERT;
                END ELSE BEGIN
                    TmpCustomerAmount.RESET;
                    TmpCustomerAmount.SETFILTER("Document No.", '%1', LYSalesJournalData.CustomerNo);
                    TmpCustomerAmount.SETFILTER("Sell-to Customer No.", '%1', LYSalesJournalData.CustomerNo);
                    IF TmpCustomerAmount.FINDFIRST THEN BEGIN
                        TmpCustomerAmount."Line Amount" += LYSalesJournalData.Sum_LineAmount;
                        TmpCustomerAmount.MODIFY;
                    END;
                END;
            END;
        END;

        CLEAR(LYSalesJournalData);
        LYSalesJournalData.SETFILTER(LYSalesJournalData.DocumentType, '%1', LYSalesJournalData.DocumentType::"Cr. Memo"); //MSKS
        LYSalesJournalData.SETFILTER(LYSalesJournalData.Tableau_Zone, '<>%1', 'CKA'); //MSKS
        LYSalesJournalData.SETFILTER(PostingDate, '%1..%2', LYStartDate, LYEndDate);
        CASE FFType OF
            FFType::SP:
                BEGIN
                    IF FFCode <> '' THEN
                        LYSalesJournalData.SETFILTER(SPCode, '%1', FFCode);
                END;
            FFType::PCH:
                BEGIN
                    IF FFCode <> '' THEN
                        LYSalesJournalData.SETFILTER(PCHCode, '%1', FFCode);
                END;
            FFType::ZM:
                BEGIN
                    IF FFCode <> '' THEN
                        LYSalesJournalData.SETFILTER(LYSalesJournalData.Zonal_Manager, '%1', FFCode);
                END;
            FFType::ZH:
                BEGIN
                    IF FFCode <> '' THEN
                        LYSalesJournalData.SETFILTER(LYSalesJournalData.Zonal_Head, '%1', FFCode);
                END;
        END;

        LYSalesJournalData.OPEN;
        WHILE LYSalesJournalData.READ DO BEGIN
            TmpCustomerAmount.RESET;
            TmpCustomerAmount.SETFILTER("Document No.", '%1', LYSalesJournalData.CustomerNo);
            TmpCustomerAmount.SETFILTER("Sell-to Customer No.", '%1', LYSalesJournalData.CustomerNo);
            IF TmpCustomerAmount.FINDFIRST THEN BEGIN
                TmpCustomerAmount."Line Amount" -= LYSalesJournalData.Sum_LineAmount;
                TmpCustomerAmount.MODIFY;
            END;
        END;

        CLEAR(SalesJournalData);
        SalesJournalData.SETFILTER(SalesJournalData.TableauZone, '<>%1', 'Enterprise'); //MSKS
        SalesJournalData.SETFILTER(PostingDateFilter, '%1..%2', FromDate, ToDate);
        CASE FFType OF
            FFType::SP:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesPersonFilter, '%1', FFCode);
                END;
            FFType::PCH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(PCHFilter, '%1', FFCode);
                END;
            FFType::ZH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.Zonal_Head, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;
            FFType::ZM:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.Zonal_Manager, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;

        END;

        SalesJournalData.OPEN;
        WHILE SalesJournalData.READ DO BEGIN
            IF (SalesJournalData.OBTB_Joining_Date <= 20210104D) AND (SalesJournalData.OBTB_Joining_Date <> 0D) THEN BEGIN
                TmpCustomerAmount.RESET;
                TmpCustomerAmount.SETFILTER("Document No.", '%1', SalesJournalData.CustomerNo);
                TmpCustomerAmount.SETFILTER("Sell-to Customer No.", '%1', SalesJournalData.CustomerNo);
                IF NOT TmpCustomerAmount.FINDFIRST THEN BEGIN
                    TmpCustomerAmount.INIT;
                    TmpCustomerAmount."Document No." := SalesJournalData.CustomerNo;
                    TmpCustomerAmount."Sell-to Customer No." := SalesJournalData.CustomerNo;
                    TmpCustomerAmount.Amount := SalesJournalData.LineAmount;
                    TmpCustomerAmount.INSERT;
                END ELSE BEGIN
                    TmpCustomerAmount.RESET;
                    TmpCustomerAmount.SETFILTER("Document No.", '%1', SalesJournalData.CustomerNo);
                    TmpCustomerAmount.SETFILTER("Sell-to Customer No.", '%1', SalesJournalData.CustomerNo);
                    IF TmpCustomerAmount.FINDFIRST THEN BEGIN
                        TmpCustomerAmount.Amount += SalesJournalData.LineAmount;
                        TmpCustomerAmount.MODIFY;
                    END;
                END;
            END;
        END;

        TmpCustomerAmount.RESET;
        //IF Mnth IN [1,2,3,7,8,9,10,11,12] THEN
        //TmpCustomerAmount.SETFILTER(Amount,'<>%1',0);
        IF TmpCustomerAmount.FINDFIRST THEN BEGIN
            Cnt := TmpCustomerAmount.COUNT;
            REPEAT
                LYSales += TmpCustomerAmount."Line Amount";
                CYSales += TmpCustomerAmount.Amount;
            UNTIL TmpCustomerAmount.NEXT = 0;
        END;
    end;

    local procedure GatherDataforWeekMkt(FFType: Option " ",SP,PCH,ZM,ZH; FFCode: Code[20]; FromDate: Date; ToDate: Date; var Cnt: Decimal; var LYSales: Decimal; var CYSales: Decimal): Decimal
    var
        SalesJournalData: Query "Sales Journal Data";
        SalesJournalData1: Query "Sales Return Journal Data";
        TmpCustomerAmount: Record "Sales Invoice Line" temporary;
        LYStartDate: Date;
        LYEndDate: Date;
        LastDealerCode: Code[20];
        Mnth: Integer;
        MAtrixMaster: Record "Matrix Master";
    begin
        LYSales := 0;
        CYSales := 0;
        TmpCustomerAmount.DELETEALL;
        LYStartDate := CALCDATE('-CM', CALCDATE('-1Y', FromDate));
        LYEndDate := CALCDATE('CM', CALCDATE('-1Y', ToDate));
        Mnth := DATE2DMY(FromDate, 2);
        CLEAR(TmpCustomerAmount);
        CLEAR(SalesJournalData);
        SalesJournalData.SETFILTER(SalesJournalData.TableauZone, '<>%1', 'Enterprise'); //MSKS
        SalesJournalData.SETFILTER(PostingDateFilter, '%1..%2', LYStartDate, LYEndDate);
        CASE FFType OF
            FFType::SP:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesPersonFilter, '%1', FFCode);
                END;
            FFType::PCH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(PCHFilter, '%1', FFCode);
                END;
            FFType::ZH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.Zonal_Head, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;
            FFType::ZM:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.Zonal_Manager, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;

        END;

        SalesJournalData.OPEN;
        WHILE SalesJournalData.READ DO BEGIN
            IF SalesJournalData.OBTB_Joining_Date >= 20200104D THEN BEGIN
                MAtrixMaster.RESET;
                MAtrixMaster.SETRANGE("Mapping Type", MAtrixMaster."Mapping Type"::City);
                MAtrixMaster.SETRANGE("Type 1", SalesJournalData.AreaCode);
                IF MAtrixMaster.FINDFIRST THEN
                    IF NOT MAtrixMaster."Strong Market" THEN BEGIN

                        TmpCustomerAmount.RESET;
                        TmpCustomerAmount.SETFILTER("Document No.", '%1', SalesJournalData.CustomerNo);
                        TmpCustomerAmount.SETFILTER("Sell-to Customer No.", '%1', SalesJournalData.CustomerNo);
                        IF NOT TmpCustomerAmount.FINDFIRST THEN BEGIN
                            TmpCustomerAmount.INIT;
                            TmpCustomerAmount."Document No." := SalesJournalData.CustomerNo;
                            TmpCustomerAmount."Sell-to Customer No." := SalesJournalData.CustomerNo;
                            TmpCustomerAmount."Line Amount" := SalesJournalData.LineAmount;
                            TmpCustomerAmount.INSERT;
                        END ELSE BEGIN
                            TmpCustomerAmount.RESET;
                            TmpCustomerAmount.SETFILTER("Document No.", '%1', SalesJournalData.CustomerNo);
                            TmpCustomerAmount.SETFILTER("Sell-to Customer No.", '%1', SalesJournalData.CustomerNo);
                            IF TmpCustomerAmount.FINDFIRST THEN BEGIN
                                TmpCustomerAmount."Line Amount" += SalesJournalData.LineAmount;
                                TmpCustomerAmount.MODIFY;
                            END;
                        END;
                    END;
            END;
        END;

        CLEAR(SalesJournalData1);
        SalesJournalData1.SETFILTER(SalesJournalData1.TableauZoneFilter, '<>%1', 'Enterprise'); //MSKS
        SalesJournalData1.SETFILTER(PostingDateFilter, '%1..%2', LYStartDate, LYEndDate);
        CASE FFType OF
            FFType::SP:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData1.SETFILTER(SalesPersonFilter, '%1', FFCode);
                END;
            FFType::PCH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData1.SETFILTER(PCHFilter, '%1', FFCode);
                END;
            FFType::ZM:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData1.SETFILTER(SalesJournalData1.Zonal_Manager, '%1', FFCode);
                END;
            FFType::ZH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData1.SETFILTER(SalesJournalData1.Zonal_Head, '%1', FFCode);
                END;
        END;

        SalesJournalData1.OPEN;
        WHILE SalesJournalData1.READ DO BEGIN
            TmpCustomerAmount.RESET;
            TmpCustomerAmount.SETFILTER("Document No.", '%1', SalesJournalData1.CustomerNo);
            TmpCustomerAmount.SETFILTER("Sell-to Customer No.", '%1', SalesJournalData1.CustomerNo);
            IF TmpCustomerAmount.FINDFIRST THEN BEGIN
                TmpCustomerAmount."Line Amount" -= SalesJournalData1.LineAmount;
                TmpCustomerAmount.MODIFY;
            END;
        END;

        CLEAR(SalesJournalData);
        SalesJournalData.SETFILTER(SalesJournalData.TableauZone, '<>%1', 'CKA'); //MSKS
        SalesJournalData.SETFILTER(PostingDateFilter, '%1..%2', FromDate, ToDate);
        CASE FFType OF
            FFType::SP:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesPersonFilter, '%1', FFCode);
                END;
            FFType::PCH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(PCHFilter, '%1', FFCode);
                END;
            FFType::ZH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.Zonal_Head, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;
            FFType::ZM:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.Zonal_Manager, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;

        END;

        SalesJournalData.OPEN;
        WHILE SalesJournalData.READ DO BEGIN
            MAtrixMaster.RESET;
            MAtrixMaster.SETRANGE("Mapping Type", MAtrixMaster."Mapping Type"::City);
            MAtrixMaster.SETRANGE("Type 1", SalesJournalData.AreaCode);
            IF MAtrixMaster.FINDFIRST THEN
                IF NOT MAtrixMaster."Strong Market" THEN BEGIN

                    IF SalesJournalData.OBTB_Joining_Date >= 20200104D THEN BEGIN
                        TmpCustomerAmount.RESET;
                        TmpCustomerAmount.SETFILTER("Document No.", '%1', SalesJournalData.CustomerNo);
                        TmpCustomerAmount.SETFILTER("Sell-to Customer No.", '%1', SalesJournalData.CustomerNo);
                        IF NOT TmpCustomerAmount.FINDFIRST THEN BEGIN
                            TmpCustomerAmount.INIT;
                            TmpCustomerAmount."Document No." := SalesJournalData.CustomerNo;
                            TmpCustomerAmount."Sell-to Customer No." := SalesJournalData.CustomerNo;
                            TmpCustomerAmount.Amount := SalesJournalData.LineAmount;
                            TmpCustomerAmount.INSERT;
                        END ELSE BEGIN
                            TmpCustomerAmount.RESET;
                            TmpCustomerAmount.SETFILTER("Document No.", '%1', SalesJournalData.CustomerNo);
                            TmpCustomerAmount.SETFILTER("Sell-to Customer No.", '%1', SalesJournalData.CustomerNo);
                            IF TmpCustomerAmount.FINDFIRST THEN BEGIN
                                TmpCustomerAmount.Amount += SalesJournalData.LineAmount;
                                TmpCustomerAmount.MODIFY;
                            END;
                        END;
                    END;
                END;
        END;

        TmpCustomerAmount.RESET;
        //IF Mnth IN [1,2,3,7,8,9,10,11,12] THEN
        //TmpCustomerAmount.SETFILTER(Amount,'<>%1',0);
        IF TmpCustomerAmount.FINDFIRST THEN BEGIN
            Cnt := TmpCustomerAmount.COUNT;
            REPEAT
                LYSales += TmpCustomerAmount."Line Amount";
                CYSales += TmpCustomerAmount.Amount;
            UNTIL TmpCustomerAmount.NEXT = 0;
        END;
    end;


    procedure CalculateCPCount(FFType: Option " ",SP,PCH,ZM,ZH; FFCode: Code[20]; FromDate: Date; ToDate: Date; var TotalNoOfCount: Decimal; var CountGreaterthan2L: Decimal; var CYSales: Decimal; var CountofWeekMkt: Decimal)
    var
        NoofCPBilled: Query "No. of CP Billed";
    begin
        CLEAR(NoofCPBilled);
        TotalNoOfCount := 0;
        CountGreaterthan2L := 0;
        NoofCPBilled.SETFILTER(NoofCPBilled.TableauZoneFilter, '<>%1', 'Enterprise'); //MSKS
        NoofCPBilled.SETFILTER(NoofCPBilled.CustomerTypeFilter, '%1|%2', 'DEALER', 'DISTIBUTOR');
        NoofCPBilled.SETFILTER(PostingDateFilter, '%1..%2', FromDate, ToDate);
        CASE FFType OF
            FFType::SP:
                BEGIN
                    IF FFCode <> '' THEN
                        NoofCPBilled.SETFILTER(SalesPersonFilter, '%1', FFCode);
                END;
            FFType::PCH:
                BEGIN
                    IF FFCode <> '' THEN
                        NoofCPBilled.SETFILTER(PCHFilter, '%1', FFCode);
                END;
            FFType::ZH:
                BEGIN
                    IF FFCode <> '' THEN
                        NoofCPBilled.SETFILTER(NoofCPBilled.Zonal_Head, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;
            FFType::ZM:
                BEGIN
                    IF FFCode <> '' THEN
                        NoofCPBilled.SETFILTER(NoofCPBilled.Zonal_Manager, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;

        END;

        NoofCPBilled.OPEN;
        WHILE NoofCPBilled.READ DO BEGIN
            TotalNoOfCount += 1;
            IF NoofCPBilled.Sum_Line_Amount > 200000 THEN BEGIN
                CountGreaterthan2L += 1;
                CYSales += NoofCPBilled.Sum_Line_Amount;
            END;
        END;
    end;


    procedure Calculate75DayOutstanding(FFType: Option " ",SP,PCH,ZM,ZH; FFCode: Code[20]; DtDate: Date) Amt: Decimal
    var
        Customer: Record Customer;
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        Customer.RESET;
        Customer.SETCURRENTKEY("Zonal Head", "Zonal Manager", "PCH Code", "Salesperson Code");
        CASE FFType OF
            FFType::SP:
                Customer.SETFILTER("Salesperson Code", '%1', FFCode);
            FFType::PCH:
                Customer.SETFILTER("PCH Code", '%1', FFCode);
            FFType::ZM:
                Customer.SETFILTER("Zonal Manager", '%1', FFCode);
            FFType::ZH:
                Customer.SETFILTER("Zonal Head", '%1', FFCode);
        END;
        Customer.SETFILTER("Tableau Zone", '<>%1', 'Enterprise');
        Customer.SETFILTER("Customer Type", '%1|%2', 'DEALER', 'DISTIBUTOR');
        IF Customer.FINDFIRST THEN
            REPEAT
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Currency Code");
                CustLedgerEntry.SETFILTER("Customer No.", '%1', Customer."No.");
                CustLedgerEntry.SETFILTER("Posting Date", '%1..%2', 0D, DtDate);
                IF CustLedgerEntry.FINDFIRST THEN
                    REPEAT
                        CustLedgerEntry.CALCFIELDS("Amount (LCY)", "Remaining Amount");
                        Amt += CustLedgerEntry."Amount (LCY)"//CustLedgerEntry."Amount (LCY)"
                    UNTIL CustLedgerEntry.NEXT = 0;
            /*
            DetailedCustLedgEntry.RESET;
            DetailedCustLedgEntry.SETCURRENTKEY("Customer No.","Currency Code","Initial Entry Global Dim. 1","Initial Entry Global Dim. 2","Initial Entry Due Date","Posting Date");
            DetailedCustLedgEntry.SETRANGE("Customer No.",Customer."No.");
            DetailedCustLedgEntry.SETFILTER("Posting Date",'%1..%2',0D,DtDate);
            DetailedCustLedgEntry.SETFILTER("Entry Type",'<>%1',DetailedCustLedgEntry."Entry Type"::Application);
            IF DetailedCustLedgEntry.FINDFIRST THEN
              REPEAT
                Amt+=DetailedCustLedgEntry."Amount (LCY)";
              UNTIL DetailedCustLedgEntry.NEXT=0;
              */
            UNTIL Customer.NEXT = 0;
        EXIT(Amt);

    end;


    procedure NoofCountCPWeekMarket(FFType: Option " ",SP,PCH,ZM,ZH; FFCode: Code[20]; StrongMKTCOunt: Boolean) Cnt: Decimal
    var
        Customer: Record Customer;
        MatrixMaster: Record "Matrix Master";
    begin
        Cnt := 0;
        MatrixMaster.RESET;
        MatrixMaster.SETRANGE("Strong Market", StrongMKTCOunt);
        IF MatrixMaster.FINDFIRST THEN
            REPEAT
                Customer.RESET;
                Customer.SETCURRENTKEY("Area Code");
                Customer.SETFILTER("Area Code", '%1', MatrixMaster."Type 1");
                Customer.SETFILTER("Tableau Zone", '<>%1', 'Enterprise');
                Customer.SETFILTER("Customer Type", '%1|%2', 'DEALER', 'DISTIBUTOR');
                IF StrongMKTCOunt THEN
                    Customer.SETFILTER("OBTB Joining Date", '<>%1&<%2', 0D, 20200104D) ELSE
                    Customer.SETFILTER("OBTB Joining Date", '>%1', 20200104D);
                //Customer.SETCURRENTKEY("Zonal Head","Zonal Manager","PCH Code","Salesperson Code");
                CASE FFType OF
                    FFType::SP:
                        Customer.SETFILTER("Salesperson Code", '%1', FFCode);
                    FFType::PCH:
                        Customer.SETFILTER("PCH Code", '%1', FFCode);
                    FFType::ZM:
                        Customer.SETFILTER("Zonal Manager", '%1', FFCode);
                    FFType::ZH:
                        Customer.SETFILTER("Zonal Head", '%1', FFCode);
                END;
                IF Customer.FINDFIRST THEN
                    REPEAT
                        Cnt += 1;
                    UNTIL Customer.NEXT = 0;
            UNTIL MatrixMaster.NEXT = 0;
        EXIT(Cnt);
    end;

    local procedure CalcOutstandingON(CustNo: Code[20]; AsOnDate: Date) Amt: Decimal
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Currency Code");
        CustLedgerEntry.SETFILTER("Customer No.", '%1', CustNo);
        CustLedgerEntry.SETFILTER("Posting Date", '%1..%2', 0D, AsOnDate);
        IF CustLedgerEntry.FINDFIRST THEN
            REPEAT
                CustLedgerEntry.CALCFIELDS("Remaining Amount");
                IF CustLedgerEntry."Remaining Amount" <> 0 THEN
                    Amt += CustLedgerEntry."Remaining Amount";
            UNTIL CustLedgerEntry.NEXT = 0;
    end;


    procedure CalcActualBalance(CustNo: Code[20]; AsOnDate: Date) Amt: Decimal
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        SkippedAmt: Decimal;
    begin
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Currency Code");
        CustLedgerEntry.SETFILTER("Customer No.", '%1', CustNo);
        CustLedgerEntry.SETFILTER("Posting Date", '%1..%2', 0D, AsOnDate);
        IF CustLedgerEntry.FINDFIRST THEN
            REPEAT
                CustLedgerEntry.CALCFIELDS("Remaining Amount");
                IF CustLedgerEntry."Remaining Amount" <> 0 THEN
                    Amt += CustLedgerEntry."Remaining Amount";
                IF (CustLedgerEntry."Entry Skipped") AND (CustLedgerEntry.Open) THEN
                    SkippedAmt += CustLedgerEntry."Remaining Amount";
            UNTIL CustLedgerEntry.NEXT = 0;
        EXIT(Amt - SkippedAmt);
    end;


    procedure IsFocusProduct(SizeCode: Code[20]; TabProdGrp: Code[20]; ITemCatCode: Code[10]): Boolean
    begin
        IF SizeCode IN ['250X375', '300X450', '300X600'] THEN //Wall
            EXIT(TRUE);

        IF SizeCode IN ['800X1600', '800X2400'] THEN //Slabs
            EXIT(TRUE);

        IF SizeCode IN ['145X600', '195X1200'] THEN //Planks
            EXIT(TRUE);

        IF (SizeCode IN ['600X600']) AND (TabProdGrp IN ['GVT', 'FBVT']) THEN // GVT+FBVT
            EXIT(TRUE);

        IF (SizeCode IN ['600X1200']) AND (TabProdGrp IN ['GVT']) THEN // GVT All ITem Catogries Code
            EXIT(TRUE);

        IF (SizeCode IN ['600X600']) AND (ITemCatCode IN ['D001', 'M001', 'H001']) THEN //FT/GFT
            EXIT(TRUE);
    end;


    procedure GetLastYearRevenue(FFType: Option " ",SP,PCH,ZM,ZH; FFCode: Code[20]; FromDate: Date; ToDate: Date; var SalesAmt: Decimal; var SalesQty: Decimal; var CDSales: Decimal; var CDQty: Decimal; var PMTSales: Decimal; var PMTQty: Decimal; var RangeSale: Decimal; var RangeSaleQty: Decimal; var RangeSaleCount: Decimal; CalcRangeData: Boolean)
    var
        LastSalesJournalData: Query "Last Year Data";
        FieldForceCode: Code[20];
        MonthDate: Date;
        SalesJournalData1: Query "Sales Return Journal Data";
        LastGoalCode: Code[20];
        LastDealerCode: Code[20];
        RangeProdSalesSqlMt: Decimal;
        QryFocusCount: Query "Focus Count";
    begin
        PMTQty := 0;
        PMTSales := 0;
        CDQty := 0;
        CDSales := 0;
        SalesAmt := 0;
        SalesQty := 0;
        FocSale := 0;
        FocSalesCount := 0;
        FocSAlesQty := 0;
        RangeSale := 0;
        RangeSaleCount := 0;
        RangeSaleQty := 0;
        CLEAR(LastSalesJournalData);
        //IF FFType=FFType::PCH THEN
        LastSalesJournalData.SETFILTER(LastSalesJournalData.Tableau_Zone, '<>%1', 'CKA'); //MSKS
        LastSalesJournalData.SETRANGE(LastSalesJournalData.DocumentType, LastSalesJournalData.DocumentType::Invoice);
        LastSalesJournalData.SETFILTER(LastSalesJournalData.PostingDate, '%1..%2', FromDate, ToDate);
        CASE FFType OF
            FFType::SP:
                BEGIN
                    IF FFCode <> '' THEN
                        LastSalesJournalData.SETFILTER(LastSalesJournalData.SPCode, '%1', FFCode);
                END;
            FFType::PCH:
                BEGIN
                    IF FFCode <> '' THEN
                        LastSalesJournalData.SETFILTER(LastSalesJournalData.PCHCode, '%1', FFCode);
                END;
            FFType::ZH:
                BEGIN
                    IF FFCode <> '' THEN
                        LastSalesJournalData.SETFILTER(LastSalesJournalData.Zonal_Head, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;
            FFType::ZM:
                BEGIN
                    IF FFCode <> '' THEN
                        LastSalesJournalData.SETFILTER(LastSalesJournalData.Zonal_Manager, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;

        END;

        LastSalesJournalData.OPEN;
        WHILE LastSalesJournalData.READ DO BEGIN
            SalesAmt += LastSalesJournalData.Sum_LineAmount;
            SalesQty += LastSalesJournalData.Sum_Quantity_Base;

            IF LastSalesJournalData.PMTCode <> '' THEN BEGIN
                PMTSales += LastSalesJournalData.Sum_LineAmount;
                PMTQty += LastSalesJournalData.Sum_Quantity_Base;
            END;

            IF IsFocusProduct(LastSalesJournalData.SizeCodeDesc, LastSalesJournalData.TabProdGrp, LastSalesJournalData.ItemCatCode) THEN BEGIN
                RangeSale += LastSalesJournalData.Sum_LineAmount;
                RangeSaleQty += LastSalesJournalData.Sum_Quantity_Base;
            END;
        END;

        CLEAR(LastSalesJournalData);
        //IF FFType=FFType::PCH THEN
        LastSalesJournalData.SETFILTER(LastSalesJournalData.Tableau_Zone, '<>%1', 'CKA'); //MSKS
        LastSalesJournalData.SETRANGE(LastSalesJournalData.DocumentType, LastSalesJournalData.DocumentType::"Cr. Memo");
        LastSalesJournalData.SETFILTER(LastSalesJournalData.PostingDate, '%1..%2', FromDate, ToDate);
        CASE FFType OF
            FFType::SP:
                BEGIN
                    IF FFCode <> '' THEN
                        LastSalesJournalData.SETFILTER(LastSalesJournalData.SPCode, '%1', FFCode);
                END;
            FFType::PCH:
                BEGIN
                    IF FFCode <> '' THEN
                        LastSalesJournalData.SETFILTER(LastSalesJournalData.PCHCode, '%1', FFCode);
                END;
            FFType::ZH:
                BEGIN
                    IF FFCode <> '' THEN
                        LastSalesJournalData.SETFILTER(LastSalesJournalData.Zonal_Head, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;
            FFType::ZM:
                BEGIN
                    IF FFCode <> '' THEN
                        LastSalesJournalData.SETFILTER(LastSalesJournalData.Zonal_Manager, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;

        END;

        LastSalesJournalData.OPEN;
        WHILE LastSalesJournalData.READ DO BEGIN
            SalesAmt -= LastSalesJournalData.Sum_LineAmount;
            SalesQty -= LastSalesJournalData.Sum_Quantity_Base;

            IF LastSalesJournalData.PMTCode <> '' THEN BEGIN
                PMTSales -= LastSalesJournalData.Sum_LineAmount;
                PMTQty -= LastSalesJournalData.Sum_Quantity_Base;
            END;

            IF IsFocusProduct(LastSalesJournalData.SizeCodeDesc, LastSalesJournalData.TabProdGrp, LastSalesJournalData.ItemCatCode) THEN BEGIN
                RangeSale -= LastSalesJournalData.Sum_LineAmount;
                RangeSaleQty -= LastSalesJournalData.Sum_Quantity_Base;
            END;
        END;
    end;


    procedure CalculateIncDecPercentage(LY: Decimal; CY: Decimal): Decimal
    begin
        IF LY = 0 THEN EXIT(0);

        EXIT(((CY - LY) / LY) * 100);
    end;

    local procedure IsEligibleforPMTPoints(PMTSales: Decimal; TotSales: Decimal): Boolean
    begin
        IF CalculatePercentage(PMTSales, TotSales) >= 25 THEN
            EXIT(TRUE) ELSE
            EXIT(FALSE);
    end;

    local procedure CalculatePMTExpSales(FFType: Option " ",SP,PCH,ZM,ZH; SPCode: Code[20]): Decimal
    var
        PMTGoalSheetData: Record "PMT Goal Sheet Data";
    begin
        PMTGoalSheetData.RESET;
        PMTGoalSheetData.SETCURRENTKEY("Created By");
        CASE FFType OF
            FFType::SP:
                PMTGoalSheetData.SETRANGE("Created By", SPCode);
            FFType::PCH:
                PMTGoalSheetData.SETRANGE(BH, SPCode);
            FFType::ZM:
                PMTGoalSheetData.SETRANGE(ZM, SPCode);
            FFType::ZH:
                PMTGoalSheetData.SETRANGE(ZH, SPCode);
        END;
        PMTGoalSheetData.CALCSUMS("PMT Qty.");
        EXIT(PMTGoalSheetData."PMT Qty.");
    end;


    procedure GetLastRevenue(FFType: Option " ",SP,PCH,ZM,ZH; FFCode: Code[20]; FromDate: Date; ToDate: Date) SalesAmt: Decimal
    var
        SalesJournalData: Query "Last Year Data";
        FieldForceCode: Code[20];
        MonthDate: Date;
        SalesJournalData1: Query "Sales Return Journal Data";
        LastGoalCode: Code[20];
        LastDealerCode: Code[20];
        RangeProdSalesSqlMt: Decimal;
        QryFocusCount: Query "Focus Count";
        SalesQty: Decimal;
    begin
        IF DATE2DMY(ToDate, 2) IN [4, 5] THEN BEGIN
            FromDate := ToDate - 89;
            //ToDate := DMY2DATE(DATE2DMY(ToDate,3),DATE2DMY(ToDate,2),DATE2DMY(ToDate,3));
        END ELSE
            EXIT;
        SalesAmt := 0;
        SalesQty := 0;
        CLEAR(SalesJournalData);
        //IF FFType=FFType::PCH THEN
        SalesJournalData.SETFILTER(SalesJournalData.Tableau_Zone, '<>%1', 'CKA'); //MSKS
        SalesJournalData.SETRANGE(SalesJournalData.DocumentType, SalesJournalData.DocumentType::Invoice);
        SalesJournalData.SETFILTER(SalesJournalData.PostingDate, '%1..%2', FromDate, ToDate);
        CASE FFType OF
            FFType::SP:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.SPCode, '%1', FFCode);
                END;
            FFType::PCH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.PCHCode, '%1', FFCode);
                END;
            FFType::ZH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.Zonal_Head, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;
            FFType::ZM:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.Zonal_Manager, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;

        END;

        SalesJournalData.OPEN;
        WHILE SalesJournalData.READ DO BEGIN
            SalesAmt += SalesJournalData.Sum_LineAmount;
            SalesQty += SalesJournalData.Sum_Quantity_Base;
        END;

        CLEAR(SalesJournalData);
        //IF FFType=FFType::PCH THEN
        SalesJournalData.SETFILTER(SalesJournalData.Tableau_Zone, '<>%1', 'CKA'); //MSKS
        SalesJournalData.SETRANGE(SalesJournalData.DocumentType, SalesJournalData.DocumentType::"Cr. Memo");
        SalesJournalData.SETFILTER(SalesJournalData.PostingDate, '%1..%2', FromDate, ToDate);
        CASE FFType OF
            FFType::SP:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.SPCode, '%1', FFCode);
                END;
            FFType::PCH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.PCHCode, '%1', FFCode);
                END;
            FFType::ZH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.Zonal_Head, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;
            FFType::ZM:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.Zonal_Manager, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;
        END;

        SalesJournalData.OPEN;
        WHILE SalesJournalData.READ DO BEGIN
            SalesAmt -= SalesJournalData.Sum_LineAmount;
            SalesQty -= SalesJournalData.Sum_Quantity_Base;
        END;
    end;

    local procedure CalculateYTDData(FieldType: Option " ",LYFocusSale,FocusTarget,FocusSale; FFType: Option " ",SP,PCH,ZM,ZH; FFCode: Code[20]; FromDate: Date; ToDate: Date): Decimal
    var
        SalesPersonGoalDetailsDataExists: Record "Sales Person Goal Details";
    begin
        SalesPersonGoalDetailsDataExists.RESET;
        SalesPersonGoalDetailsDataExists.SETFILTER("FF Type", '%1', FFType);
        SalesPersonGoalDetailsDataExists.SETFILTER("Field Force Code", '%1', FFCode);
        SalesPersonGoalDetailsDataExists.SETFILTER("For Month", '%1..%2', FromDate, ToDate);
        IF SalesPersonGoalDetailsDataExists.FINDFIRST THEN BEGIN
            SalesPersonGoalDetailsDataExists.CALCSUMS(SalesPersonGoalDetailsDataExists."Last Year Focus Sales (Same P)",
                                                      SalesPersonGoalDetailsDataExists."Focus Sale Target");
            CASE FieldType OF
                FieldType::LYFocusSale:
                    EXIT(SalesPersonGoalDetailsDataExists."Last Year Focus Sales (Same P)");
                FieldType::FocusTarget:
                    EXIT(SalesPersonGoalDetailsDataExists."Focus Sale Target");
                FieldType::FocusSale:
                    EXIT(SalesPersonGoalDetailsDataExists."Focus Sale");

            END;
        END;
    end;

    local procedure GatherDataforSameCustomerGrowth(FFType: Option " ",SP,PCH,ZM,ZH; FFCode: Code[20]; FromDate: Date; ToDate: Date; var Cnt: Decimal; var LYSales: Decimal; var CYSales: Decimal): Decimal
    var
        SalesJournalData: Query "Sales Journal Data";
        SalesJournalData1: Query "Sales Return Journal Data";
        LYSalesJournalData: Query "Last Year Data";
        TmpCustomerAmount: Record "Sales Invoice Line" temporary;
        LYStartDate: Date;
        LYEndDate: Date;
        LastDealerCode: Code[20];
        Mnth: Integer;
        MatrixMaster: Record "Matrix Master";
    begin
        LYSales := 0;
        CYSales := 0;
        TmpCustomerAmount.DELETEALL;
        LYStartDate := CALCDATE('-CM', CALCDATE('-1Y', FromDate));
        LYEndDate := CALCDATE('CM', CALCDATE('-1Y', ToDate));
        Mnth := DATE2DMY(FromDate, 2);
        CLEAR(TmpCustomerAmount);
        CLEAR(LYSalesJournalData);
        LYSalesJournalData.SETFILTER(LYSalesJournalData.DocumentType, '%1', LYSalesJournalData.DocumentType::Invoice); //MSKS
        LYSalesJournalData.SETFILTER(LYSalesJournalData.Tableau_Zone, '<>%1', 'CKA'); //MSKS
        LYSalesJournalData.SETFILTER(LYSalesJournalData.PostingDate, '%1..%2', LYStartDate, LYEndDate);
        CASE FFType OF
            FFType::SP:
                BEGIN
                    IF FFCode <> '' THEN
                        LYSalesJournalData.SETFILTER(LYSalesJournalData.SPCode, '%1', FFCode);
                END;
            FFType::PCH:
                BEGIN
                    IF FFCode <> '' THEN
                        LYSalesJournalData.SETFILTER(LYSalesJournalData.PCHCode, '%1', FFCode);
                END;
            FFType::ZH:
                BEGIN
                    IF FFCode <> '' THEN
                        LYSalesJournalData.SETFILTER(LYSalesJournalData.Zonal_Head, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;
            FFType::ZM:
                BEGIN
                    IF FFCode <> '' THEN
                        LYSalesJournalData.SETFILTER(LYSalesJournalData.Zonal_Manager, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;
        END;

        LYSalesJournalData.OPEN;
        WHILE LYSalesJournalData.READ DO BEGIN
            IF (LYSalesJournalData.OBTB_Joining_Date < 20220104D) AND ((LYSalesJournalData.OBTB_Joining_Date <> 0D)) THEN BEGIN
                TmpCustomerAmount.RESET;
                TmpCustomerAmount.SETFILTER("Document No.", '%1', LYSalesJournalData.CustomerNo);
                TmpCustomerAmount.SETFILTER("Sell-to Customer No.", '%1', LYSalesJournalData.CustomerNo);
                IF NOT TmpCustomerAmount.FINDFIRST THEN BEGIN
                    TmpCustomerAmount.INIT;
                    TmpCustomerAmount."Document No." := LYSalesJournalData.CustomerNo;
                    TmpCustomerAmount."Sell-to Customer No." := LYSalesJournalData.CustomerNo;
                    TmpCustomerAmount."Line Amount" := LYSalesJournalData.Sum_LineAmount;
                    TmpCustomerAmount.INSERT;
                END ELSE BEGIN
                    TmpCustomerAmount.RESET;
                    TmpCustomerAmount.SETFILTER("Document No.", '%1', LYSalesJournalData.CustomerNo);
                    TmpCustomerAmount.SETFILTER("Sell-to Customer No.", '%1', LYSalesJournalData.CustomerNo);
                    IF TmpCustomerAmount.FINDFIRST THEN BEGIN
                        TmpCustomerAmount."Line Amount" += LYSalesJournalData.Sum_LineAmount;
                        TmpCustomerAmount.MODIFY;
                    END;
                END;
            END;
        END;

        CLEAR(LYSalesJournalData);
        LYSalesJournalData.SETFILTER(LYSalesJournalData.DocumentType, '%1', LYSalesJournalData.DocumentType::"Cr. Memo"); //MSKS
        LYSalesJournalData.SETFILTER(LYSalesJournalData.Tableau_Zone, '<>%1', 'CKA'); //MSKS
        LYSalesJournalData.SETFILTER(PostingDate, '%1..%2', LYStartDate, LYEndDate);
        CASE FFType OF
            FFType::SP:
                BEGIN
                    IF FFCode <> '' THEN
                        LYSalesJournalData.SETFILTER(SPCode, '%1', FFCode);
                END;
            FFType::PCH:
                BEGIN
                    IF FFCode <> '' THEN
                        LYSalesJournalData.SETFILTER(PCHCode, '%1', FFCode);
                END;
            FFType::ZM:
                BEGIN
                    IF FFCode <> '' THEN
                        LYSalesJournalData.SETFILTER(LYSalesJournalData.Zonal_Manager, '%1', FFCode);
                END;
            FFType::ZH:
                BEGIN
                    IF FFCode <> '' THEN
                        LYSalesJournalData.SETFILTER(LYSalesJournalData.Zonal_Head, '%1', FFCode);
                END;
        END;

        LYSalesJournalData.OPEN;
        WHILE LYSalesJournalData.READ DO BEGIN
            TmpCustomerAmount.RESET;
            TmpCustomerAmount.SETFILTER("Document No.", '%1', LYSalesJournalData.CustomerNo);
            TmpCustomerAmount.SETFILTER("Sell-to Customer No.", '%1', LYSalesJournalData.CustomerNo);
            IF TmpCustomerAmount.FINDFIRST THEN BEGIN
                TmpCustomerAmount."Line Amount" -= LYSalesJournalData.Sum_LineAmount;
                TmpCustomerAmount.MODIFY;
            END;
        END;

        CLEAR(SalesJournalData);
        SalesJournalData.SETFILTER(SalesJournalData.TableauZone, '<>%1', 'Enterprise'); //MSKS
        SalesJournalData.SETFILTER(PostingDateFilter, '%1..%2', FromDate, ToDate);
        CASE FFType OF
            FFType::SP:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesPersonFilter, '%1', FFCode);
                END;
            FFType::PCH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(PCHFilter, '%1', FFCode);
                END;
            FFType::ZH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.Zonal_Head, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;
            FFType::ZM:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.Zonal_Manager, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;

        END;

        SalesJournalData.OPEN;
        WHILE SalesJournalData.READ DO BEGIN
            IF (SalesJournalData.OBTB_Joining_Date < 20220104D) AND (SalesJournalData.OBTB_Joining_Date <> 0D) THEN BEGIN
                TmpCustomerAmount.RESET;
                TmpCustomerAmount.SETFILTER("Document No.", '%1', SalesJournalData.CustomerNo);
                TmpCustomerAmount.SETFILTER("Sell-to Customer No.", '%1', SalesJournalData.CustomerNo);
                IF NOT TmpCustomerAmount.FINDFIRST THEN BEGIN
                    TmpCustomerAmount.INIT;
                    TmpCustomerAmount."Document No." := SalesJournalData.CustomerNo;
                    TmpCustomerAmount."Sell-to Customer No." := SalesJournalData.CustomerNo;
                    TmpCustomerAmount.Amount := SalesJournalData.LineAmount;
                    TmpCustomerAmount.INSERT;
                END ELSE BEGIN
                    TmpCustomerAmount.RESET;
                    TmpCustomerAmount.SETFILTER("Document No.", '%1', SalesJournalData.CustomerNo);
                    TmpCustomerAmount.SETFILTER("Sell-to Customer No.", '%1', SalesJournalData.CustomerNo);
                    IF TmpCustomerAmount.FINDFIRST THEN BEGIN
                        TmpCustomerAmount.Amount += SalesJournalData.LineAmount;
                        TmpCustomerAmount.MODIFY;
                    END;
                END;
            END;
        END;

        TmpCustomerAmount.RESET;
        //IF Mnth IN [1,2,3,7,8,9,10,11,12] THEN
        //TmpCustomerAmount.SETFILTER(Amount,'<>%1',0);
        IF TmpCustomerAmount.FINDFIRST THEN BEGIN
            Cnt := TmpCustomerAmount.COUNT;
            REPEAT
                LYSales += TmpCustomerAmount."Line Amount";
                CYSales += TmpCustomerAmount.Amount;
            UNTIL TmpCustomerAmount.NEXT = 0;
        END;
    end;

    local procedure GatherDataforNewCustomerGrowth(FFType: Option " ",SP,PCH,ZM,ZH; FFCode: Code[20]; FromDate: Date; ToDate: Date; var Cnt: Decimal; var LYSales: Decimal; var CYSales: Decimal): Decimal
    var
        SalesJournalData: Query "Sales Journal Data";
        SalesJournalData1: Query "Sales Return Journal Data";
        LYSalesJournalData: Query "Last Year Data";
        TmpCustomerAmount: Record "Sales Invoice Line" temporary;
        LYStartDate: Date;
        LYEndDate: Date;
        LastDealerCode: Code[20];
        Mnth: Integer;
        MatrixMaster: Record "Matrix Master";
    begin
        LYSales := 0;
        CYSales := 0;
        TmpCustomerAmount.DELETEALL;
        LYStartDate := CALCDATE('-CM', CALCDATE('-1Y', FromDate));
        LYEndDate := CALCDATE('CM', CALCDATE('-1Y', ToDate));
        Mnth := DATE2DMY(FromDate, 2);
        CLEAR(TmpCustomerAmount);
        /*
        CLEAR(LYSalesJournalData);
        LYSalesJournalData.SETFILTER(LYSalesJournalData.DocumentType,'%1',LYSalesJournalData.DocumentType::Invoice); //MSKS
        LYSalesJournalData.SETFILTER(LYSalesJournalData.Tableau_Zone,'<>%1','CKA'); //MSKS
        LYSalesJournalData.SETFILTER(LYSalesJournalData.PostingDate,'%1..%2',LYStartDate,LYEndDate);
        CASE FFType OF
          FFType::SP:
            BEGIN
              IF FFCode<>'' THEN
                LYSalesJournalData.SETFILTER(LYSalesJournalData.SPCode,'%1',FFCode);
            END;
          FFType::PCH:
            BEGIN
              IF FFCode<>'' THEN
                LYSalesJournalData.SETFILTER(LYSalesJournalData.PCHCode,'%1',FFCode);
            END;
          FFType::ZH:
            BEGIN
              IF FFCode<>'' THEN
                LYSalesJournalData.SETFILTER(LYSalesJournalData.Zonal_Head,'%1',FFCode);
              //FieldForceCode := FFCode;
            END;
          FFType::ZM:
            BEGIN
              IF FFCode<>'' THEN
                LYSalesJournalData.SETFILTER(LYSalesJournalData.Zonal_Manager,'%1',FFCode);
              //FieldForceCode := FFCode;
            END;
        END;
        
        LYSalesJournalData.OPEN;
        WHILE LYSalesJournalData.READ DO BEGIN
          IF (LYSalesJournalData.OBTB_Joining_Date>= 010421D) AND ((LYSalesJournalData.OBTB_Joining_Date<>0D)) THEN BEGIN
              TmpCustomerAmount.RESET;
              TmpCustomerAmount.SETFILTER("Document No.",'%1',LYSalesJournalData.CustomerNo);
              TmpCustomerAmount.SETFILTER("Sell-to Customer No.",'%1',LYSalesJournalData.CustomerNo);
              IF NOT TmpCustomerAmount.FINDFIRST THEN BEGIN
                TmpCustomerAmount.INIT;
                TmpCustomerAmount."Document No." := LYSalesJournalData.CustomerNo;
                TmpCustomerAmount."Sell-to Customer No." := LYSalesJournalData.CustomerNo;
                TmpCustomerAmount."Line Amount" := LYSalesJournalData.Sum_LineAmount;
                TmpCustomerAmount.INSERT;
              END ELSE BEGIN
                TmpCustomerAmount.RESET;
                TmpCustomerAmount.SETFILTER("Document No.",'%1',LYSalesJournalData.CustomerNo);
                TmpCustomerAmount.SETFILTER("Sell-to Customer No.",'%1',LYSalesJournalData.CustomerNo);
                IF TmpCustomerAmount.FINDFIRST THEN BEGIN
                  TmpCustomerAmount."Line Amount" += LYSalesJournalData.Sum_LineAmount;
                  TmpCustomerAmount.MODIFY;
                END;
              END;
          END;
        END;
        
        CLEAR(LYSalesJournalData);
        LYSalesJournalData.SETFILTER(LYSalesJournalData.DocumentType,'%1',LYSalesJournalData.DocumentType::"Cr. Memo"); //MSKS
        LYSalesJournalData.SETFILTER(LYSalesJournalData.Tableau_Zone,'<>%1','CKA'); //MSKS
        LYSalesJournalData.SETFILTER(PostingDate,'%1..%2',LYStartDate,LYEndDate);
        CASE FFType OF
          FFType::SP:
            BEGIN
              IF FFCode<>'' THEN
                LYSalesJournalData.SETFILTER(SPCode,'%1',FFCode);
            END;
          FFType::PCH:
            BEGIN
              IF FFCode<>'' THEN
                LYSalesJournalData.SETFILTER(PCHCode,'%1',FFCode);
            END;
          FFType::ZM:
            BEGIN
              IF FFCode<>'' THEN
                LYSalesJournalData.SETFILTER(LYSalesJournalData.Zonal_Manager,'%1',FFCode);
            END;
          FFType::ZH:
            BEGIN
              IF FFCode<>'' THEN
                LYSalesJournalData.SETFILTER(LYSalesJournalData.Zonal_Head,'%1',FFCode);
            END;
        END;
        
        LYSalesJournalData.OPEN;
        WHILE LYSalesJournalData.READ DO BEGIN
            TmpCustomerAmount.RESET;
            TmpCustomerAmount.SETFILTER("Document No.",'%1',LYSalesJournalData.CustomerNo);
            TmpCustomerAmount.SETFILTER("Sell-to Customer No.",'%1',LYSalesJournalData.CustomerNo);
            IF TmpCustomerAmount.FINDFIRST THEN BEGIN
              TmpCustomerAmount."Line Amount" -= LYSalesJournalData.Sum_LineAmount;
              TmpCustomerAmount.MODIFY;
            END;
        END;
        */
        CLEAR(SalesJournalData);
        SalesJournalData.SETFILTER(SalesJournalData.TableauZone, '<>%1', 'Enterprise'); //MSKS
        SalesJournalData.SETFILTER(PostingDateFilter, '%1..%2', FromDate, ToDate);
        CASE FFType OF
            FFType::SP:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesPersonFilter, '%1', FFCode);
                END;
            FFType::PCH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(PCHFilter, '%1', FFCode);
                END;
            FFType::ZH:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.Zonal_Head, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;
            FFType::ZM:
                BEGIN
                    IF FFCode <> '' THEN
                        SalesJournalData.SETFILTER(SalesJournalData.Zonal_Manager, '%1', FFCode);
                    //FieldForceCode := FFCode;
                END;

        END;

        SalesJournalData.OPEN;
        WHILE SalesJournalData.READ DO BEGIN
            IF (SalesJournalData.OBTB_Joining_Date >= 20220104D) AND (SalesJournalData.OBTB_Joining_Date <> 0D) THEN BEGIN
                IF SalesJournalData.OBTB_Joining_Date <= ToDate THEN BEGIN
                    TmpCustomerAmount.RESET;
                    TmpCustomerAmount.SETFILTER("Document No.", '%1', SalesJournalData.CustomerNo);
                    TmpCustomerAmount.SETFILTER("Sell-to Customer No.", '%1', SalesJournalData.CustomerNo);
                    IF NOT TmpCustomerAmount.FINDFIRST THEN BEGIN
                        TmpCustomerAmount.INIT;
                        TmpCustomerAmount."Document No." := SalesJournalData.CustomerNo;
                        TmpCustomerAmount."Sell-to Customer No." := SalesJournalData.CustomerNo;
                        TmpCustomerAmount.Amount := SalesJournalData.LineAmount;
                        TmpCustomerAmount.INSERT;
                    END ELSE BEGIN
                        TmpCustomerAmount.RESET;
                        TmpCustomerAmount.SETFILTER("Document No.", '%1', SalesJournalData.CustomerNo);
                        TmpCustomerAmount.SETFILTER("Sell-to Customer No.", '%1', SalesJournalData.CustomerNo);
                        IF TmpCustomerAmount.FINDFIRST THEN BEGIN
                            TmpCustomerAmount.Amount += SalesJournalData.LineAmount;
                            TmpCustomerAmount.MODIFY;
                        END;
                    END;
                END;
            END;
        END;

        TmpCustomerAmount.RESET;
        //IF Mnth IN [1,2,3,7,8,9,10,11,12] THEN
        //TmpCustomerAmount.SETFILTER(Amount,'<>%1',0);
        IF TmpCustomerAmount.FINDFIRST THEN BEGIN
            Cnt := TmpCustomerAmount.COUNT;
            REPEAT
                LYSales += TmpCustomerAmount."Line Amount";
                CYSales += TmpCustomerAmount.Amount;
            UNTIL TmpCustomerAmount.NEXT = 0;
        END;

    end;
}

