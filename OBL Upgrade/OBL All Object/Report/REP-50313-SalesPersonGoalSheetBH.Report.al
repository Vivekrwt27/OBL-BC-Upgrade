report 50313 "Sales Person Goal Sheet BH"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\SalesPersonGoalSheetBH.rdl';

    dataset
    {
        dataitem("Sales Person Goal Details"; "Sales Person Goal Details")
        {
            DataItemTableView = SORTING("FF Type", "Field Force Code", "For Month");
            RequestFilterFields = "FF Type", "Field Force Code";
            column(ShowSummary; ShowSummary)
            {
            }
            column(PCHTxt; PCHTxt)
            {
            }
            column(ForMonth; "For Month")
            {
            }
            column(ZMName; SalespersonPurchaser3.Name)
            {
            }
            column(FFname; SalespersonPurchaser.Name)
            {
            }
            column(Territory_SalesPersonGoalDetails; "Sales Person Goal Details".Territory)
            {
            }
            column(PCHName; SalespersonPurchaser.Name)
            {
            }
            column(LYDSO; SalespersonPurchaser."Last Year DSO")
            {
            }
            column(LYASP; SalespersonPurchaser."Last Year ASP")
            {
            }
            column(LYRangeTarget; SalespersonPurchaser."Last Year Range Target")
            {
            }
            column(RevenueTarget_SalesPersonGoalDetails; "Sales Person Goal Details"."Revenue Target" / 100000)
            {
            }
            column(RevenueAchieved_SalesPersonGoalDetails; "Sales Person Goal Details"."Revenue Achieved" / 100000)
            {
            }
            column(PercentageAchieved_SalesPersonGoalDetails; "Sales Person Goal Details"."Percentage Achieved")
            {
            }
            column(PointsonRevenue_SalesPersonGoalDetails; "Sales Person Goal Details"."Points on Revenue")
            {
            }
            column(PointsonOutstanding_SalesPersonGoalDetails; "Sales Person Goal Details"."Points on Outstanding")
            {
            }
            column(ASP_SalesPersonGoalDetails; "Sales Person Goal Details".ASP)
            {
            }
            column(YTDRangeTarget; YTDRangeTarget)
            {
            }
            column(YTDFocusAchieve; YTDFocusAchieve / 100000)
            {
            }
            column(YTDFocusPts; YTDFocusPts)
            {
            }
            column(FocusTarget; "Sales Person Goal Details"."Focus Sale Target" / 100000)
            {
            }
            column(FocusAchived; "Sales Person Goal Details"."Focus Sale" / 100000)
            {
            }
            column(FocusPoints; "Sales Person Goal Details"."Focus Sale Points")
            {
            }
            column(PointonCD_SalesPersonGoalDetails; "Sales Person Goal Details"."Point on CD")
            {
            }
            column(CDSales_SalesPersonGoalDetails; "Sales Person Goal Details"."CD Sales" / 100000)
            {
            }
            column(PointsonPMT_SalesPersonGoalDetails; "Sales Person Goal Details"."Points on PMT")
            {
            }
            column(PMTSales_SalesPersonGoalDetails; "Sales Person Goal Details"."PMT Sales" / 100000)
            {
            }
            column(OutstandingperDay_SalesPersonGoalDetails; "Sales Person Goal Details"."Outstanding per Day")
            {
            }
            column(PointsonASP_SalesPersonGoalDetails; "Sales Person Goal Details"."Points on ASP")
            {
            }
            column(FieldForceCode_SalesPersonGoalDetails; "Sales Person Goal Details"."Field Force Code")
            {
            }
            column(YTDRevenueTarget; "Sales Person Goal Details"."Annual Revenue Target" / 100000)
            {
            }
            column(YTDRevenueAchvment; "Sales Person Goal Details"."YTD Revenue Achieved" / 100000)
            {
            }
            column(YTDPMTSales_SalesPersonGoalDetails; "Sales Person Goal Details"."YTD PMT Sales" / 100000)
            {
            }
            column(BaseLineLY; "Sales Person Goal Details"."Base Line Last Year" / 100000)
            {
            }
            column(NoOfSalesForce; "Sales Person Goal Details"."No. of Sales Force")
            {
            }
            column(YTDTargetScore; YTDTargetScore)
            {
            }
            column(YTDASPScore; YTDASPScore)
            {
            }
            column(YTDCDScore; YTDCDScore)
            {
            }
            column(YTDPMTScore; YTDPMTScore)
            {
            }
            column(YTDASPAchvd; YTDASPAchvd)
            {
            }
            column(YTDCDAchvd; YTDCDAchvd / 100000)
            {
            }
            column(YTDPMTAchvd; YTDPMTAchvd / 100000)
            {
            }
            column(YTDTarget; YTDTarget / 100000)
            {
            }
            column(YTDDSO; YTDDSO)
            {
            }
            column(YTDDSOPoint; YTDDSOPoint)
            {
            }
            column(MaxRevenuePoint; MaxRevenuePoint)
            {
            }
            column(MaxOutstandingPoint; MaxOutstandingPoint)
            {
            }
            column(MaxCDPoint; MaxCDPoint)
            {
            }
            column(MaxASPPoint; MaxASPPoint)
            {
            }
            column(MaxPMTPoint; MaxPMTPoint)
            {
            }
            column(hq_name; SalespersonPurchaser."HQ Town")
            {
            }
            column(RevivalScore; "Sales Person Goal Details"."Points on Creation/Revival")
            {
            }
            column(YTDRevivalScore; "Sales Person Goal Details"."YTD Creation/Revival Points")
            {
            }
            column(RevivalSales; "Sales Person Goal Details"."Revival Sales" / 100000)
            {
            }
            column(YTDRevivalSales; ("Sales Person Goal Details"."YTD Revival Sales") / 100000)
            {
            }
            column(LYYTDSales; LYYTDSales / 100000)
            {
            }
            column(LYYTDRevivalSales; (LYSalesPersonGoalDetails."YTD Creation Sales" + LYSalesPersonGoalDetails."YTD Revival Sales") / 100000)
            {
            }
            column(LYYTDPMTSales; LYSalesPersonGoalDetails."YTD PMT Sales" / 100000)
            {
            }
            column(LYMonthSales; LYMSalesPersonGoalDetails."YTD Revenue Achieved" / 100000)
            {
            }
            column(LYMonthRevivalSales; (LYMSalesPersonGoalDetails."YTD Creation Sales" + LYMSalesPersonGoalDetails."YTD Revival Sales") / 100000)
            {
            }
            column(LYMonthPMTSales; LYMSalesPersonGoalDetails."YTD PMT Sales" / 100000)
            {
            }
            column(FocusAchievePer; FocusAchievePer)
            {
            }
            column(IncDecDSO; IncDecDSO)
            {
            }
            column(RevivalSalesPer; "Sales Person Goal Details"."Revival Sales Contribution %ag")
            {
            }
            column(PMTOppPerc; "Sales Person Goal Details"."PMT Opportunity Percentage")
            {
            }
            column(PMTOppValue; "Sales Person Goal Details"."PMT Opportunity Value" / 100000)
            {
            }
            column(FocusVsTolRevenue; FocusVsTolRevenue)
            {
            }
            column(YtdFocusVsTolRevenue; YTDFocusVsTolRevenue)
            {
            }
            column(YTDFocusScore; YTDFocusScore)
            {
            }
            column(ShowSuppData; ShowSuppData)
            {
            }
            column(ISEligibleforPMT; ISEligibleforPMT)
            {
            }
            column(LYOBTBSales; "Sales Person Goal Details"."OBTP LY Sales - Same Growth")
            {
            }
            column(CYOBTBSales; "Sales Person Goal Details"."OBTP Sales - Same Growth")
            {
            }
            column(CYOBTBCustCount; "Sales Person Goal Details"."OBTP Count - Same Growth")
            {
            }
            column(CYOBTBPointMkyType; "Sales Person Goal Details"."Points on Market Type")
            {
            }
            column(YTDLYOBTBSales; "Sales Person Goal Details"."YTD LY Sales")
            {
            }
            column(YTDCYOBTBSales; "Sales Person Goal Details"."YTD CY Sales")
            {
            }
            column(YTDCYOBTBCustCount; "Sales Person Goal Details"."YTD CY Cust. Count")
            {
            }
            column(OBTPSameGrowthPer; FieldForceGoalMgt.CalculateIncDecPercentage("Sales Person Goal Details"."OBTP LY Sales - Same Growth", "Sales Person Goal Details"."OBTP Sales - Same Growth"))
            {
            }
            column(OBTPnewGrowthPer; NewMarket / 100000)
            {
            }
            column(CYCustCount; "Sales Person Goal Details"."CY Cust. Count New Market")
            {
            }
            column(PtsOnSameSalesGrowth; "Sales Person Goal Details"."Points on Same Sales Growth")
            {
            }
            column(PtsonNewSAlesGrowth; "Sales Person Goal Details"."Points on New SAles Growth")
            {
            }
            column(YTDOBTBLYSalesSamesGrowth; YTDOBTBLYSalesSamesGrowth)
            {
            }
            column(YTDOBTPSalesSameGrowth; YTDOBTPSalesSameGrowth)
            {
            }
            column(YTDOBTPCountSameGrowth; YTDOBTPCountSameGrowth)
            {
            }
            column(CYNewMarketTotal; CYNewMarketTotal)
            {
            }
            column(CYCountNewMarketTotal; CYCountNewMarketTotal)
            {
            }
            column(YtdSameGrowthAcheivePt; YtdSameGrowthAcheivePt)
            {
            }
            column(YtdSameGrowthAcheive; YtdSameGrowthAcheive)
            {
            }
            column(YtdNewGrowthAcheivePt; YtdNewGrowthAcheivePt)
            {
            }
            column(YtdNewGrowthAcheive; YtdNewGrowthAcheive)
            {
            }
            column(YTDFocusSaleTarget; YTDRangeTarget / 100000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF "Sales Person Goal Details"."FF Type" = "Sales Person Goal Details"."FF Type"::PCH THEN
                    PCHTxt := '/ FLS'
                ELSE
                    PCHTxt := '';
                LYYTDSales := 0;
                YTDRangeTarget := 0;
                CLEAR(YTDFocusCount);//Rk

                CLEAR(SPPCHGoalSheetCalculation);
                SPPCHGoalSheetCalculation.GetMonthlyRevenue("Sales Person Goal Details"."FF Type", "Sales Person Goal Details"."Field Force Code",
                              20200104D, 20210331D, LYYTDSales, NotReq, NotReq, NotReq, NotReq, NotReq, NotReq, NotReq, NotReq, FALSE);//040120D, 310321D
                SalespersonPurchaser.RESET;
                IF SalespersonPurchaser.GET("Sales Person Goal Details"."Field Force Code") THEN;

                SalespersonPurchaser2.RESET;
                IF SalespersonPurchaser2.GET("Sales Person Goal Details".PCH) THEN;

                SalespersonPurchaser3.RESET;
                IF SalespersonPurchaser3.GET("Sales Person Goal Details".ZM) THEN;

                //Score Calculation
                CLEAR(YTDTargetScore);
                YTDTarget := 0;
                YTDDSO := 0;

                IncDecDSO := 0;
                YTDFocusVsTolRevenue := 0;
                YTDFocusScore := 0;
                NewMarket := 0;
                IncDecDSO := FieldForceGoalMgt.CalculateIncDecPercentage("Sales Person Goal Details"."Last Year DSO", "Sales Person Goal Details"."Outstanding per Day");

                FocusVsTolRevenue := FieldForceGoalMgt.CalculatePercentage("Sales Person Goal Details"."Focus AOP Growth %age", "Sales Person Goal Details"."AOP % Age Total Revenue");

                YTDFocusVsTolRevenue := FieldForceGoalMgt.CalculatePercentage("Sales Person Goal Details"."YTD Focus AOP Growth %age", "Sales Person Goal Details"."YTD AOP % Age Total Revenue");


                IF "Sales Person Goal Details"."CY Sales New Market" <> 0 THEN
                    NewMarket := "Sales Person Goal Details"."CY Sales New Market" / "Sales Person Goal Details"."CY Cust. Count New Market"
                ELSE
                    NewMarket := 0;
                /*
                CLEAR(LYSalesPersonGoalDetails);
                CLEAR(LYMSalesPersonGoalDetails);
                LYSalesPersonGoalDetails.RESET;
                LYSalesPersonGoalDetails.SETFILTER("For Month",'%1',010321D);
                LYSalesPersonGoalDetails.SETFILTER("FF Type",'%1',"Sales Person Goal Details"."FF Type");
                LYSalesPersonGoalDetails.SETFILTER("Field Force Code",'%1',"Sales Person Goal Details"."Field Force Code");
                IF LYSalesPersonGoalDetails.FINDFIRST THEN;
                
                LYMSalesPersonGoalDetails.RESET;
                LYMSalesPersonGoalDetails.SETFILTER("For Month",'%1',CALCDATE('-CM',CALCDATE('-1Y',AsOnDate)));
                LYMSalesPersonGoalDetails.SETFILTER("FF Type",'%1',"Sales Person Goal Details"."FF Type");
                LYMSalesPersonGoalDetails.SETFILTER("Field Force Code",'%1',"Sales Person Goal Details"."Field Force Code");
                IF LYMSalesPersonGoalDetails.FINDFIRST THEN;
                */

                YTDFocusPts := 0;
                YTDFocusAchieve := 0;
                YTDFocusCount := 0;
                YTDFocusCount := 0;
                YTDOBTBLYSalesSamesGrowth := 0;
                YTDOBTPSalesSameGrowth := 0;
                YTDOBTPCountSameGrowth := 0;
                CYNewMarketTotal := 0;
                CYCountNewMarketTotal := 0;
                YTDOBTPSalesNewGrowth := 0;
                YTDOBTPCountNewGrowth := 0;

                SalesPersonGoalDetails.RESET;
                SalesPersonGoalDetails.SETFILTER("For Month", '%1..%2', 20220104D, AsOnDate);//040122D
                SalesPersonGoalDetails.SETFILTER("FF Type", '%1', "Sales Person Goal Details"."FF Type");
                SalesPersonGoalDetails.SETFILTER("Field Force Code", '%1', "Sales Person Goal Details"."Field Force Code");
                IF SalesPersonGoalDetails.FINDFIRST THEN BEGIN
                    YtdDSOCnt := SalesPersonGoalDetails.COUNT;
                    REPEAT
                        YTDTarget += SalesPersonGoalDetails."Revenue Target";
                        //    YTDFocusCount+=SalesPersonGoalDetails."Focus Sale Count";//RK
                        YTDRangeTarget += SalesPersonGoalDetails."Focus Sale Target";
                        YTDFocusAchieve += SalesPersonGoalDetails."Focus Sale";
                        //   YTDDSO += SalesPersonGoalDetails."Outstanding per Day";
                        YTDOBTBLYSalesSamesGrowth += SalesPersonGoalDetails."OBTP LY Sales - Same Growth"; //Rk
                        YTDOBTPSalesSameGrowth += SalesPersonGoalDetails."OBTP Sales - Same Growth"; //Rk
                        YTDOBTPCountSameGrowth += SalesPersonGoalDetails."OBTP Count - Same Growth"; //Rk
                        CYNewMarketTotal += SalesPersonGoalDetails."CY Sales New Market"; //Rk
                        CYCountNewMarketTotal += SalesPersonGoalDetails."CY Cust. Count New Market"; //Rk
                        YTDOBTPSalesNewGrowth += SalesPersonGoalDetails."CY Sales New Market";
                        YTDOBTPCountNewGrowth += SalesPersonGoalDetails."CY Cust. Count New Market";

                    UNTIL SalesPersonGoalDetails.NEXT = 0;
                END;

                /*
                IF YTDRangeTarget <>0 THEN
                   YTDFocusAchieve := ((YTDFocusCount-YTDRangeTarget) / YTDRangeTarget)*100 ;
                
                IF "Sales Person Goal Details"."Focus Sale Target" <>0 THEN
                  FocusAchievePer := (("Sales Person Goal Details"."Focus Sale Count" - "Sales Person Goal Details"."Focus Sale Target" )
                                      /"Sales Person Goal Details"."Focus Sale Target")*100;
                
                IF "Sales Person Goal Details"."Focus Sale Points" = 0 THEN FocusAchievePer := 0;
                
                IF YTDFocusAchieve <0 THEN YTDFocusAchieve := 0;
                
                YTDFocusPts := SalesPersonGoalDetails.CalculatePointsOnRangeSales("Sales Person Goal Details"."FF Type",YTDFocusCount,YTDRangeTarget);
                
                IF YtdDSOCnt <>0 THEN
                  YTDDSO := YTDDSO/YtdDSOCnt;
                  YTDDSOPoint := SalesPersonGoalDetails.CalculatePointsOnOutstanding(YTDDSO,SalesPersonGoalDetails."Last Year DSO");
                */
                CLEAR(YTDASPScore);
                CLEAR(YTDCDScore);
                CLEAR(YTDPMTScore);
                CLEAR(YTDASPAchvd);
                CLEAR(YTDCDAchvd);
                CLEAR(YTDPMTAchvd);
                CLEAR(YtdSameGrowthAcheivePt);
                CLEAR(YtdSameGrowthAcheive);
                CLEAR(YtdNewGrowthAcheivePt);
                CLEAR(YtdNewGrowthAcheive);


                IF YTDTarget <> 0 THEN BEGIN
                    YTDTargetScore := ("Sales Person Goal Details"."YTD Revenue Achieved" / YTDTarget) * 100;
                    YTDTargetScore := CalculatePointsONRevenue("Sales Person Goal Details"."FF Type", YTDTargetScore);
                    YTDPMTAchvd := ("Sales Person Goal Details"."YTD PMT Sales");
                    YTDPMTScore := SalesPersonGoalDetails.CalculatePointsOnPMT("Sales Person Goal Details"."FF Type", SPPCHGoalSheetCalculation.CalculatePercentage(YTDPMTAchvd, "Sales Person Goal Details"."YTD Revenue Achieved"));
                END;

                IF "Sales Person Goal Details"."YTD Revenue Qty." <> 0 THEN BEGIN
                    YTDASPAchvd := ("Sales Person Goal Details"."YTD Revenue Achieved" / "Sales Person Goal Details"."YTD Revenue Qty.");
                    YTDASPScore := SalesPersonGoalDetails.CalculatePointsONASP(YTDASPAchvd);
                END;

                IF "Sales Person Goal Details"."YTD Revenue Achieved" <> 0 THEN BEGIN
                    YTDCDAchvd := ("Sales Person Goal Details"."YTD CD Sales");
                    YTDCDScore := SalesPersonGoalDetails.CalculatePointsOnCD(100 * YTDCDAchvd / "Sales Person Goal Details"."YTD Revenue Achieved");

                    //YTDPMTAchvd := ("Sales Person Goal Details"."YTD PMT Sales");
                    //YTDPMTScore := SalesPersonGoalDetails.CalculatePointsOnPMT(100*YTDPMTAchvd/"Sales Person Goal Details"."YTD Revenue Achieved");
                END;
                //Score Calculation

                YTDFocusScore := "Sales Person Goal Details".CalculatePointsOnRangeSales("Sales Person Goal Details"."FF Type", YTDFocusAchieve, YTDRangeTarget);
                YtdSameGrowthAcheivePt := SalesPersonGoalDetails.CalculatePointsonSameStoreGrowth("Sales Person Goal Details"."FF Type",
                                                                "Sales Person Goal Details"."For Month",
                                                                FALSE, YTDOBTBLYSalesSamesGrowth, YTDOBTPSalesSameGrowth, YTDOBTPCountSameGrowth);

                YtdSameGrowthAcheive := FieldForceGoalMgt.CalculateIncDecPercentage(YTDOBTBLYSalesSamesGrowth, YTDOBTPSalesSameGrowth);

                YtdNewGrowthAcheivePt := SalesPersonGoalDetails.CalculatePointsonNewStoreGrowth("Sales Person Goal Details"."FF Type",
                                                                "Sales Person Goal Details"."For Month",
                                                                FALSE, YTDOBTPSalesNewGrowth, YTDOBTPSalesNewGrowth, YTDOBTPCountNewGrowth);
                IF YTDOBTPCountNewGrowth <> 0 THEN
                    YtdNewGrowthAcheive := (YTDOBTPSalesNewGrowth / YTDOBTPCountNewGrowth)
                ELSE
                    YtdNewGrowthAcheive := 0;



                IF Cnt = 0 THEN BEGIN
                    Cnt += 1;
                    CLEAR(MaxRevenuePoint);
                    SalesPersonGoalDetails.RESET;
                    SalesPersonGoalDetails.SETCURRENTKEY("YTD Revenue Points");
                    SalesPersonGoalDetails.SETFILTER("For Month", '%1', "Sales Person Goal Details"."For Month");
                    IF SalesPersonGoalDetails.FINDLAST THEN
                        MaxRevenuePoint := SalesPersonGoalDetails."YTD Revenue Points";

                    CLEAR(MaxOutstandingPoint);
                    SalesPersonGoalDetails.RESET;
                    SalesPersonGoalDetails.SETCURRENTKEY("Points on Outstanding");
                    SalesPersonGoalDetails.SETFILTER("For Month", '%1', "Sales Person Goal Details"."For Month");
                    IF SalesPersonGoalDetails.FINDLAST THEN
                        MaxOutstandingPoint := SalesPersonGoalDetails."Points on Outstanding";

                    CLEAR(MaxCDPoint);
                    SalesPersonGoalDetails.RESET;
                    SalesPersonGoalDetails.SETCURRENTKEY("YTD CD Points");
                    SalesPersonGoalDetails.SETFILTER("For Month", '%1', "Sales Person Goal Details"."For Month");
                    IF SalesPersonGoalDetails.FINDLAST THEN
                        MaxCDPoint := SalesPersonGoalDetails."YTD CD Points";

                    CLEAR(MaxASPPoint);
                    SalesPersonGoalDetails.RESET;
                    SalesPersonGoalDetails.SETCURRENTKEY("YTD ASP Points");
                    SalesPersonGoalDetails.SETFILTER("For Month", '%1', "Sales Person Goal Details"."For Month");
                    IF SalesPersonGoalDetails.FINDLAST THEN
                        MaxASPPoint := SalesPersonGoalDetails."YTD ASP Points";

                    CLEAR(MaxPMTPoint);
                    SalesPersonGoalDetails.RESET;
                    SalesPersonGoalDetails.SETCURRENTKEY("YTD PMT Points");
                    SalesPersonGoalDetails.SETFILTER("For Month", '%1', "Sales Person Goal Details"."For Month");
                    IF SalesPersonGoalDetails.FINDLAST THEN
                        MaxPMTPoint := SalesPersonGoalDetails."YTD PMT Points";
                END;

            end;

            trigger OnPreDataItem()
            begin
                StartDate := DMY2DATE(1, 4, DATE2DMY(AsOnDate, 3));
                //EndDate := CALCDATE('+CM', AsOnDate);
                AsOnDate := CALCDATE('-CM', AsOnDate);
                IF AsOnDate <> 0D THEN
                    "Sales Person Goal Details".SETFILTER("Sales Person Goal Details"."For Month", '%1', AsOnDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(ASonDate; AsOnDate)
                {
                    ApplicationArea = All;
                }
                field("Show Supporting data"; ShowSuppData)
                {
                    ApplicationArea = All;
                }
                field("Show Summary"; ShowSummary)
                {
                    ApplicationArea = All;
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

    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        SalespersonPurchaser2: Record "Salesperson/Purchaser";
        StartDate: Date;
        EndDate: Date;
        SalesPersonGoalDetails: Record "Sales Person Goal Details";
        FieldForceGoalMgt: Codeunit "SP  PCH Goal Sheet Calculation";
        YTDTargetScore: Decimal;
        YTDRangeTarget: Decimal;
        YTDASPScore: Decimal;
        YTDCDScore: Decimal;
        YTDPMTScore: Decimal;
        YTDASPAchvd: Decimal;
        YTDCDAchvd: Decimal;
        YTDPMTAchvd: Decimal;
        AsOnDate: Date;
        YTDTarget: Decimal;
        MaxRevenuePoint: Decimal;
        MaxOutstandingPoint: Decimal;
        MaxCDPoint: Decimal;
        MaxASPPoint: Decimal;
        MaxPMTPoint: Decimal;
        Cnt: Integer;
        YTDDSO: Decimal;
        YtdDSOCnt: Integer;
        YTDDSOPoint: Decimal;
        PCHTxt: Text;
        LYSalesPersonGoalDetails: Record "Sales Person Goal Details";
        LYMSalesPersonGoalDetails: Record "Sales Person Goal Details";
        LYYTDSales: Decimal;
        SPPCHGoalSheetCalculation: Codeunit "SP  PCH Goal Sheet Calculation";
        NotReq: Decimal;
        YTDFocusCount: Decimal;
        YTDFocusAchieve: Decimal;
        YTDFocusPts: Decimal;
        FocusAchievePer: Decimal;
        IncDecDSO: Decimal;
        FocusVsTolRevenue: Decimal;
        YTDFocusVsTolRevenue: Decimal;
        YTDFocusScore: Decimal;
        ShowSuppData: Boolean;
        ISEligibleforPMT: Decimal;
        NewMarket: Decimal;
        YTDOBTBLYSalesSamesGrowth: Decimal;
        YTDOBTPSalesSameGrowth: Decimal;
        YTDOBTPCountSameGrowth: Decimal;
        CYNewMarketTotal: Decimal;
        CYCountNewMarketTotal: Decimal;
        YtdSameGrowthAcheive: Decimal;
        YtdSameGrowthAcheivePt: Decimal;
        YtdNewGrowthAcheive: Decimal;
        YtdNewGrowthAcheivePt: Decimal;
        YTDOBTBSalesNewGrowth: Decimal;
        YTDOBTPSalesNewGrowth: Decimal;
        YTDOBTPCountNewGrowth: Decimal;
        YTDFocusSalesTarget: Decimal;
        ShowSummary: Boolean;
        SalespersonPurchaser3: Record "Salesperson/Purchaser";


    procedure SetReportDate(DtDate: Date)
    begin
        AsOnDate := DtDate;
    end;
}

