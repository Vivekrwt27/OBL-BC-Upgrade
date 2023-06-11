report 50173 "Management Sales Report (MIS)1"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\ManagementSalesReportMIS1.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(TargetVsAchievement; 50003)
        {
            DataItemTableView = SORTING("Mapping Type", Description, "Type 1");
            column(N; N)
            {
            }
            column(ReportType; 'Report1')
            {
            }
            column(ASonDate; (ASonDate))
            {
            }
            column(MonthStartDate; MonthStartDate)
            {
            }
            column(MonthEndDate; MonthEndDate)
            {
            }
            column(Zone; TabZone)
            {
            }
            column(AreaCode; "Type 1")
            {
            }
            column(AreaDescription; "Description 2")
            {
            }
            column(Target; Target)
            {
            }
            column(ValueForDay; ValueForDay / 100000)
            {
            }
            column(ValueForDay_1; "ValueForDay-1" / 100000)
            {
            }
            column(QtyForDay; QtyForDay)
            {
            }
            column(QtyForDay_1; "QtyForDay-1")
            {
            }
            column(LYDebtorBalance; LYDebtorBalance)
            {
            }
            column(DebtorBalanceN; DebtorBalAmt / 100)
            {
            }
            column(QTRQty; QTRQty)
            {
            }
            column(QTRSales; QTRSales)
            {
            }
            column(LYQTRQty; LYQTRQty)
            {
            }
            column(LYQTRSales; LYQTRSales)
            {
            }
            column(MTDSales; MTDSales / 100000)
            {
            }
            column(MTDASPSales; MTDASPSales)
            {
            }
            column(YTDSales; YTDSales / 100000)
            {
            }
            column(YTDASPSales; YTDASPSales)
            {
            }
            column(Collection; Collection / 100000)
            {
            }
            column(HVPPercentage; HVPPercentage)
            {
            }
            column(HVPASP; HVPASP)
            {
            }
            column(HVPASPForDay; HVPASPForDay)
            {
            }
            column(HVPASPForDay1; "HVPASPForDay-1")
            {
            }
            column(LastYearMTDQty; LastYearMTDQty)
            {
            }
            column(LastYearMTDSales; LastYearMTDSales / 100000)
            {
            }
            column(LYMonthSales; LYMonthSales / 100000)
            {
            }
            column(LastYearQTDQty; LastYearQTDQty)
            {
            }
            column(LastYearQTDSales; LastYearQTDSales / 100000)
            {
            }
            column(CYInventory; CYInventory / 100000)
            {
            }
            column(LYInventory; LYInventory / 100000)
            {
            }
            column(AsOnDt1; ASonDate - 1)
            {
            }
            column(AsOnDt2; ASonDate - 2)
            {
            }
            column(AsOnDt3; ASonDate - 3)
            {
            }
            column(AsOnDt4; ASonDate - 4)
            {
            }
            column(AsOnDt5; ASonDate - 5)
            {
            }
            column(AsOnDt6; ASonDate - 6)
            {
            }
            column(AsOnDt7; ASonDate - 7)
            {
            }
            column(AsOnDt8; ASonDate - 8)
            {
            }
            column(AsOnDt9; ASonDate - 9)
            {
            }
            column(AsOnDt10; ASonDate - 10)
            {
            }
            column(MTDSalesQtyM001; MTDSalesQtyM001)
            {
            }
            column(MTDSalesQtyD001; MTDSalesQtyD001)
            {
            }
            column(MTDSalesQtyH001; MTDSalesQtyH001)
            {
            }
            column(MTDSalesM001; MTDSalesM001 / 100000)
            {
            }
            column(MTDSalesD001; MTDSalesD001 / 100000)
            {
            }
            column(MTDSalesH001; MTDSalesH001 / 100000)
            {
            }
            column(YTDSalesQtyM001; YTDSalesQtyM001)
            {
            }
            column(YTDSalesQtyD001; YTDSalesQtyD001)
            {
            }
            column(YTDSalesQtyH001; YTDSalesQtyH001)
            {
            }
            column(YTDSalesM001; YTDSalesM001 / 100000)
            {
            }
            column(YTDSalesD001; YTDSalesD001 / 100000)
            {
            }
            column(YTDSalesH001; YTDSalesH001 / 100000)
            {
            }
            column(M001StockQty; M001StockQty)
            {
            }
            column(D001StockQty; D001StockQty)
            {
            }
            column(H001StockQty; H001StockQty)
            {
            }
            column(MTDFocusM001; MTDFocusM001)
            {
            }
            column(MTDFocusD001; MTDFocusD001)
            {
            }
            column(MTDFocusH001; MTDFocusH001)
            {
            }
            column(LYFocusM001; LYFocusM001)
            {
            }
            column(LYFocusD001; LYFocusD001)
            {
            }
            column(LYFocusH001; LYFocusH001)
            {
            }

            trigger OnAfterGetRecord()
            var
                SalesDataMGT: Query "Sales Data -MGT";
                MTDSalesDataMGT: Query "Sales Data -MGT";
                YTDSalesDataMGT: Query "Sales Data -MGT";
                CSalesDataMGT: Query "Sales Data -MGT";
                CMTDSalesDataMGT: Query "Sales Data -MGT";
                CYTDSalesDataMGT: Query "Sales Data -MGT";
            begin
                InitializeVariables;
                IF NOT FirstTime THEN BEGIN
                    FirstTime := TRUE;
                    //Value of Date
                    GetSalesValue('', ASonDate, ASonDate, QtyForDay, ValueForDay, FALSE);
                    //GetCollectionData('',MonthStartDate,MonthEndDate,Collection);

                    //Value of Date-1
                    GetSalesValue('', ASonDate - 1, ASonDate - 1, "QtyForDay-1", "ValueForDay-1", FALSE);
                    GetCollectionData1('', MonthStartDate, ASonDate, Collection);

                    //Month
                    GetSalesValue('', MonthStartDate, ASonDate, MTDQty, MTDSales, FALSE);

                    GetSalesValue('', MonthStartDate, MonthEndDate, MTDHVPQty, MTDHVPSales, TRUE); //HVP

                    GetSalesValue('', ASonDate, ASonDate, HVPQtyForDay, HVPValueForDay, TRUE);
                    GetSalesValue('', ASonDate - 1, ASonDate - 1, "HVPQtyForDay-1", "HVPValueForDay-1", TRUE); //HVP

                    //QTR
                    GetSalesValue('', QTRStartDDate, QTREndDate, QTRQty, QTRSales, FALSE);

                    //Year
                    GetSalesValue('', YearStartDDate, YearEndDate, YTDQty, YTDSales, FALSE);

                    //Last Month
                    GetSalesValue('', LYMonthStartDate, LYMonthEndDate, LastYearMTDQty, LastYearMTDSales, FALSE);
                    GetSalesValue('', LYMonthStartDate, CALCDATE('-1Y+CM', ASonDate), TempVariable, LYMonthSales, FALSE);
                    //Last QRT
                    GetSalesValue('', LYQTRStartDate, LYQTREndDate, LYQTRQty, LYQTRSales, FALSE);

                    //TotalCYSales += YTDSales;
                    IF MTDQty <> 0 THEN
                        MTDASPSales := ROUND(MTDSales / MTDQty, 0.01, '=');

                    IF YTDQty <> 0 THEN
                        YTDASPSales := ROUND(YTDSales / YTDQty, 0.01, '=');


                    IF HVPQtyForDay <> 0 THEN
                        HVPASPForDay := ROUND(HVPValueForDay / HVPQtyForDay, 0.01, '=');

                    IF "HVPQtyForDay-1" <> 0 THEN
                        "HVPASPForDay-1" := ROUND("HVPValueForDay-1" / "HVPQtyForDay-1", 0.01, '=');

                    IF MTDHVPQty <> 0 THEN
                        HVPASP := ROUND(MTDHVPSales / MTDHVPQty, 0.01, '=');

                    IF MTDSales <> 0 THEN
                        HVPPercentage := ROUND((MTDHVPSales / MTDSales) * 100, 0.01, '=');
                END;
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.BREAK;
                CLEAR(CalculateSummaryInventory);
                CalculateSummaryInventory.SETFILTER(CalculateSummaryInventory.Item_Category_Code, '%1|%2|%3|%4|%5', 'M001', 'T001', 'H001', 'D001');
                CalculateSummaryInventory.SETFILTER(CalculateSummaryInventory.Posting_Date, '%1..%2', 0D, LYMonthEndDate);
                CalculateSummaryInventory.OPEN;
                WHILE CalculateSummaryInventory.READ DO BEGIN
                    LYInventory += CalculateSummaryInventory.Sum_Quantity;
                END;

                CLEAR(CalculateSummaryInventory);
                CalculateSummaryInventory.SETFILTER(CalculateSummaryInventory.Item_Category_Code, '%1|%2|%3|%4|%5', 'M001', 'T001', 'H001', 'D001');
                CalculateSummaryInventory.SETFILTER(CalculateSummaryInventory.Posting_Date, '%1..%2', 0D, MonthEndDate);
                CalculateSummaryInventory.OPEN;
                WHILE CalculateSummaryInventory.READ DO BEGIN
                    CYInventory += CalculateSummaryInventory.Sum_Quantity;
                END;
            end;
        }
        dataitem(Integer; 2000000026)
        {
            column(ReportType2; 'Report2')
            {
            }
            column(ITemCatCode; QryMonthlySales.TypeCatCodeDesc)
            {
            }
            column(PostDate; QryMonthlySales.PostingDate)
            {
            }
            column(TotQty; QryMonthlySales.Quantity_Base)
            {
            }
            column(SalesRetT001; SalesRetT001)
            {
            }
            column(SalesRetH001; SalesRetH001)
            {
            }
            column(SalesRetD001; SalesRetD001)
            {
            }
            column(SalesRetM001; SalesRetM001)
            {
            }
            column(TotAmt; LineAmt)
            {
            }
            column(Catogry; Catogry)
            {
            }
            column(ValueForDtN1; ValueForDt[1])
            {
            }
            column(ValueForDtN2; ValueForDt[2])
            {
            }
            column(ValueForDt1; QtyForDtChart[1])
            {
            }
            column(ValueForDt2; QtyForDtChart[2])
            {
            }
            column(ValueForDt3; QtyForDtChart[3])
            {
            }
            column(ValueForDt4; QtyForDtChart[4])
            {
            }
            column(ValueForDt5; QtyForDtChart[5])
            {
            }
            column(ValueForDt6; QtyForDtChart[6])
            {
            }
            column(ValueForDt7; QtyForDtChart[7])
            {
            }
            column(ValueForDt8; QtyForDtChart[8])
            {
            }
            column(ValueForDt9; QtyForDtChart[9])
            {
            }
            column(ValueForDt10; QtyForDtChart[10])
            {
            }
            column(ValueForDt11; QtyForDtChart[11])
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF NOT QryMonthlySales.READ THEN
                    CurrReport.BREAK;
                /*
                LineAmt :=0;
                IF (ASonDate-10) < MonthStartDate THEN
                  LineAmt :=0
                  ELSE*/
                LineAmt := QryMonthlySales.LineAmount;

                Catogry := 'OTHER';
                CASE QryMonthlySales.TypeCatCodeDesc OF
                    'T001':
                        Catogry := 'Trading';
                    'M001':
                        Catogry := 'SKD';
                    'H001':
                        Catogry := 'HosKote';
                    'D001':
                        Catogry := 'Dora';
                END;

                IF QryMonthlySales.TypeCatCodeDesc = 'T001' THEN BEGIN
                    LineAmt += SalesRetT001;
                    SalesRetT001 := 0;
                END;

                IF QryMonthlySales.TypeCatCodeDesc = 'D001' THEN BEGIN
                    LineAmt += SalesRetD001;
                    SalesRetD001 := 0;
                END;

                IF QryMonthlySales.TypeCatCodeDesc = 'H001' THEN BEGIN
                    LineAmt += SalesRetH001;
                    SalesRetH001 := 0;
                END;

                IF QryMonthlySales.TypeCatCodeDesc = 'M001' THEN BEGIN
                    LineAmt += SalesRetM001;
                    SalesRetM001 := 0;
                END;




                CLEAR(ValueForDt);
                CLEAR(QtyForDtChart);
                CASE QryMonthlySales.PostingDate OF
                    ASonDate:
                        BEGIN
                            ValueForDt[1] := QryMonthlySales.LineAmount;
                            QtyForDtChart[1] := QryMonthlySales.Quantity_Base;
                        END;
                    ASonDate - 1:
                        BEGIN
                            ValueForDt[2] := QryMonthlySales.LineAmount;
                            QtyForDtChart[2] := QryMonthlySales.Quantity_Base;
                        END;
                    ASonDate - 2:
                        BEGIN
                            ValueForDt[3] := QryMonthlySales.LineAmount;
                            QtyForDtChart[3] := QryMonthlySales.Quantity_Base;
                        END;
                    ASonDate - 3:
                        BEGIN
                            ValueForDt[4] := QryMonthlySales.LineAmount;
                            QtyForDtChart[4] := QryMonthlySales.Quantity_Base;
                        END;
                    ASonDate - 4:
                        BEGIN
                            ValueForDt[5] := QryMonthlySales.LineAmount;
                            QtyForDtChart[5] := QryMonthlySales.Quantity_Base;
                        END;
                    ASonDate - 5:
                        BEGIN
                            ValueForDt[6] := QryMonthlySales.LineAmount;
                            QtyForDtChart[6] := QryMonthlySales.Quantity_Base;
                        END;
                    ASonDate - 6:
                        BEGIN
                            ValueForDt[7] := QryMonthlySales.LineAmount;
                            QtyForDtChart[7] := QryMonthlySales.Quantity_Base;
                        END;
                    ASonDate - 7:
                        BEGIN
                            ValueForDt[8] := QryMonthlySales.LineAmount;
                            QtyForDtChart[8] := QryMonthlySales.Quantity_Base;
                        END;
                    ASonDate - 8:
                        BEGIN
                            ValueForDt[9] := QryMonthlySales.LineAmount;
                            QtyForDtChart[9] := QryMonthlySales.Quantity_Base;
                        END;
                    ASonDate - 9:
                        BEGIN
                            ValueForDt[10] := QryMonthlySales.LineAmount;
                            QtyForDtChart[10] := QryMonthlySales.Quantity_Base;
                        END;
                    ASonDate - 10:
                        BEGIN
                            ValueForDt[11] := QryMonthlySales.LineAmount;
                            QtyForDtChart[11] := QryMonthlySales.Quantity_Base;
                        END;
                END;

            end;

            trigger OnPreDataItem()
            var
                SalesReturnJournalData: Query "Sales Return Journal Data";
            begin
                //CurrReport.BREAK;
                //Location Wise
                CLEAR(QryMonthlySales);
                QryMonthlySales.SETRANGE(QryMonthlySales.PostingDateFilter, MonthStartDate, ASonDate);
                QryMonthlySales.OPEN;
                CLEAR(AsOnDt);

                CLEAR(SalesReturnJournalData);
                SalesReturnJournalData.SETRANGE(SalesReturnJournalData.PostingDateFilter, MonthStartDate, ASonDate);
                SalesReturnJournalData.OPEN;
                WHILE SalesReturnJournalData.READ DO BEGIN
                    CASE SalesReturnJournalData.TypeCatCodeDesc OF
                        'T001':
                            SalesRetT001 -= SalesReturnJournalData.LineAmount;
                        'M001':
                            SalesRetM001 -= SalesReturnJournalData.LineAmount;
                        'H001':
                            SalesRetH001 -= SalesReturnJournalData.LineAmount;
                        'D001':
                            SalesRetD001 -= SalesReturnJournalData.LineAmount;
                    END;
                END;
            end;
        }
        dataitem(CollectionZone; 2000000026)
        {
            column(ReportType3; 'Report3')
            {
            }
            column(ColZone; DebtorsCollectionMGT.Tableau_Zone)
            {
            }
            column(ColArea; DebtorsCollectionMGT.Area_Code)
            {
            }
            column(OBDebtorBalance; OBDebtorBalance)
            {
            }
            column(OBCKADebtorBalance; OBCKADebtorBalance)
            {
            }
            column(Month1; TxtDate[1])
            {
            }
            column(Month2; TxtDate[2])
            {
            }
            column(Month3; TxtDate[3])
            {
            }
            column(Month4; TxtDate[4])
            {
            }
            column(Month5; TxtDate[5])
            {
            }
            column(Month6; TxtDate[6])
            {
            }
            column(Month7; TxtDate[7])
            {
            }
            column(Month8; TxtDate[8])
            {
            }
            column(Month9; TxtDate[9])
            {
            }
            column(Month10; TxtDate[10])
            {
            }
            column(Month11; TxtDate[11])
            {
            }
            column(Month12; TxtDate[12])
            {
            }
            column(DebtorBalance1; DebtorBalance[1])
            {
            }
            column(DebtorBalance2; DebtorBalance[2])
            {
            }
            column(DebtorBalance3; DebtorBalance[3])
            {
            }
            column(DebtorBalance4; DebtorBalance[4])
            {
            }
            column(DebtorBalance5; DebtorBalance[5])
            {
            }
            column(DebtorBalance6; DebtorBalance[6])
            {
            }
            column(DebtorBalance7; DebtorBalance[7])
            {
            }
            column(DebtorBalance8; DebtorBalance[8])
            {
            }
            column(DebtorBalance9; DebtorBalance[9])
            {
            }
            column(DebtorBalance10; DebtorBalance[10])
            {
            }
            column(DebtorBalance11; DebtorBalance[11])
            {
            }
            column(DebtorBalance12; DebtorBalance[12])
            {
            }
            column(DebtorBalance_1; DebtorBalance1[1])
            {
            }
            column(DebtorBalance_2; DebtorBalance1[2])
            {
            }
            column(DebtorBalance_3; DebtorBalance1[3])
            {
            }
            column(DebtorBalance_4; DebtorBalance1[4])
            {
            }
            column(DebtorBalance_5; DebtorBalance1[5])
            {
            }
            column(DebtorBalance_6; DebtorBalance1[6])
            {
            }
            column(DebtorBalance_7; DebtorBalance1[7])
            {
            }
            column(DebtorBalance_8; DebtorBalance1[8])
            {
            }
            column(DebtorBalance_9; DebtorBalance1[9])
            {
            }
            column(DebtorBalance_10; DebtorBalance1[10])
            {
            }
            column(DebtorBalance_11; DebtorBalance1[11])
            {
            }
            column(DebtorBalance_12; DebtorBalance1[12])
            {
            }

            trigger OnAfterGetRecord()
            var
                DIMDebtorsCollectionMGT: Query "Debtors Collection MGT";
            begin
                IF NOT DebtorsCollectionMGT.READ THEN
                    CurrReport.BREAK;
                CLEAR(OBDebtorBalance);
                CLEAR(DebtorBalance);
                CLEAR(DebtorBalance1);
                /*
                IF CollectionZone."Type 1" <> 'CKA' THEN BEGIN
                  DebtorsCollectionMGT.SETRANGE(DebtorsCollectionMGT.Area_Code,CollectionZone."Type 1");
                  DebtorsCollectionMGT.SETRANGE(DebtorsCollectionMGT.PostDateFilter,0D,YearStartDDate-1);
                  DebtorsCollectionMGT.SETFILTER(DebtorsCollectionMGT.Customer_Type,'<>%1&<>%2&<>%3','MISC.','CKA','DIRECTPROJ');
                  DebtorsCollectionMGT.OPEN;
                  WHILE DebtorsCollectionMGT.READ DO BEGIN
                    OBDebtorBalance += DebtorsCollectionMGT.Sum_Amount_LCY;
                  END;
                  FOR i := 1 TO 12 DO BEGIN
                    CLEAR(DebtorsCollectionMGT);
                    DebtorsCollectionMGT.SETRANGE(DebtorsCollectionMGT.Area_Code,CollectionZone."Type 1");
                    DebtorsCollectionMGT.SETFILTER(DebtorsCollectionMGT.Customer_Type,'<>%1&<>%2&<>%3','MISC.','CKA','DIRECTPROJ');
                    DebtorsCollectionMGT.SETFILTER(DebtorsCollectionMGT.PostDateFilter,'%1..%2',YearStartDDate,TxtDate[i]);
                    DebtorsCollectionMGT.OPEN;
                    WHILE DebtorsCollectionMGT.READ DO BEGIN
                      DebtorBalance[i] += DebtorsCollectionMGT.Sum_Amount_LCY
                    END;
                  END;
                END ELSE BEGIN
                  //DebtorsCollectionMGT.SETRANGE(DebtorsCollectionMGT.Area_Code,CollectionZone."Type 1");
                  DebtorsCollectionMGT.SETFILTER(DebtorsCollectionMGT.Customer_Type,'%1|%2|%3','MISC.','CKA','DIRECTPROJ');
                  DebtorsCollectionMGT.SETRANGE(DebtorsCollectionMGT.PostDateFilter,0D,YearStartDDate-1);
                  DebtorsCollectionMGT.OPEN;
                  WHILE DebtorsCollectionMGT.READ DO BEGIN
                    OBDebtorBalance += DebtorsCollectionMGT.Sum_Amount_LCY;
                  END;
                
                  FOR i := 1 TO 12 DO BEGIN
                    CLEAR(DebtorsCollectionMGT);
                   // DebtorsCollectionMGT.SETRANGE(DebtorsCollectionMGT.Area_Code,CollectionZone."Type 1");
                    DebtorsCollectionMGT.SETFILTER(DebtorsCollectionMGT.Customer_Type,'%1|%2|%3','MISC.','CKA','DIRECTPROJ');
                    DebtorsCollectionMGT.SETFILTER(DebtorsCollectionMGT.PostDateFilter,'%1..%2',YearStartDDate,TxtDate[i]);
                    DebtorsCollectionMGT.OPEN;
                    WHILE DebtorsCollectionMGT.READ DO BEGIN
                      DebtorBalance[i] += DebtorsCollectionMGT.Sum_Amount_LCY
                    END;
                  END;
                END;
                */
                /*
                  DebtorsCollectionMGT.SETRANGE(DebtorsCollectionMGT.PostDateFilter,0D,YearStartDDate-1);
                  DebtorsCollectionMGT.OPEN;
                  WHILE DebtorsCollectionMGT.READ DO BEGIN
                    OBDebtorBalance += DebtorsCollectionMGT.Sum_Amount_LCY;
                  END;
                  */
                IF ZoneDesc <> DebtorsCollectionMGT.Tableau_Zone THEN BEGIN
                    OBDebtorBalance := 0;
                    ZoneDesc := DebtorsCollectionMGT.Tableau_Zone;
                    FOR i := 1 TO 12 DO BEGIN
                        CLEAR(DIMDebtorsCollectionMGT);
                        DIMDebtorsCollectionMGT.SETRANGE(DIMDebtorsCollectionMGT.Tableau_Zone, DebtorsCollectionMGT.Tableau_Zone);
                        //DIMDebtorsCollectionMGT.SETFILTER(DIMDebtorsCollectionMGT.Customer_Type,'<>%1','LEGAL');
                        DIMDebtorsCollectionMGT.SETFILTER(PostDateFilter, '%1..%2', 0D, TxtDate[i]);
                        DIMDebtorsCollectionMGT.SETFILTER(Sum_Amount, '>%1', 0);
                        DIMDebtorsCollectionMGT.OPEN;
                        WHILE DIMDebtorsCollectionMGT.READ DO BEGIN
                            DebtorBalance[i] += DIMDebtorsCollectionMGT.Sum_Amount;

                        END;
                        DebtorBalance[i] := (DebtorBalance[i]) / 10000000; //MSKS
                    END;

                    //For 120Days >>>>>>
                    FOR i := 1 TO 12 DO BEGIN
                        CLEAR(DIMDebtorsCollectionMGT);
                        DIMDebtorsCollectionMGT.SETRANGE(DIMDebtorsCollectionMGT.Tableau_Zone, DebtorsCollectionMGT.Tableau_Zone);
                        //DIMDebtorsCollectionMGT.SETFILTER(DIMDebtorsCollectionMGT.Customer_Type,'<>%1','LEGAL');
                        DIMDebtorsCollectionMGT.SETFILTER(DIMDebtorsCollectionMGT.DueDateFilter, '%1..%2', 0D, TxtDate1[i]);
                        DIMDebtorsCollectionMGT.SETFILTER(Sum_Remaining_Amt_LCY, '>%1', 0);
                        DIMDebtorsCollectionMGT.OPEN;
                        WHILE DIMDebtorsCollectionMGT.READ DO BEGIN
                            DebtorBalance1[i] += DIMDebtorsCollectionMGT.Sum_Remaining_Amt_LCY;

                        END;
                        DebtorBalance1[i] := (DebtorBalance1[i]) / 10000000; //MSKS
                    END;
                    //For 120Days <<<<<<
                    /*
                  FOR i := 1 TO 12 DO
                    DebtorBalance[i] := (DebtorBalance[i] )/100000;*/

                END;
                OBDebtorBalance := 0;
                //  OBDebtorBalance += DebtorsCollectionMGT.Sum_Amount_LCY /100000;
                /*
                DIMDebtorsCollectionMGT[i].SETRANGE(Area_Code,CollectionZone."Type 1");
                
                FOR i := 1 TO 12 DO BEGIN
                  DIMDebtorsCollectionMGT[i].SETFILTER(DIMDebtorsCollectionMGT[i].PostDateFilter,'%1..%2',0D,TxtDate[i]);
                  DIMDebtorsCollectionMGT[i].OPEN;
                  WHILE DIMDebtorsCollectionMGT[i].READ DO BEGIN
                  DebtorBalance[i] += DIMDebtorsCollectionMGT[i].Sum_Amount_LCY;
                  CKADebtorBalance[i] += DIMDebtorsCollectionMGT[i].Sum_Amount_LCY;
                  END;
                END;
                */

            end;

            trigger OnPreDataItem()
            begin
                CLEAR(DebtorsCollectionMGT);
                //DebtorsCollectionMGT.SETRANGE(DebtorsCollectionMGT.PostDateFilter,0D,YearStartDDate-1);
                DebtorsCollectionMGT.SETRANGE(DebtorsCollectionMGT.PostDateFilter, 0D, TODAY);
                DebtorsCollectionMGT.SETFILTER(DebtorsCollectionMGT.Sum_Amount, '>%1', 0);
                DebtorsCollectionMGT.OPEN;
            end;
        }
        dataitem(Premium; 2000000026)
        {
            DataItemTableView = SORTING(Number);
            column(ReportType4; 'Report4')
            {
            }
            column(Number; Number)
            {
            }
            column(Date; TxtDate[Number])
            {
            }
            column(PerSKD; PerM001[Number])
            {
            }
            column(PerHSK; PerH001[Number])
            {
            }
            column(PerDRA; PerD001[Number])
            {
            }
            column(PerTRA; PerT001[Number])
            {
            }
            column(PerSKD11; PerM0011)
            {
            }
            column(PerHSK11; PerH0011)
            {
            }
            column(PerDRA11; PerD0011)
            {
            }
            column(PerTRA11; PerT0011)
            {
            }
            column(PerSKD12; PerM0012)
            {
            }
            column(PerHSK12; PerH0012)
            {
            }
            column(PerDRA12; PerD0012)
            {
            }
            column(PerTRA12; PerT0012)
            {
            }
            column(ASPSKD; ASPM001[Number])
            {
            }
            column(ASPHSK; ASPH001[Number])
            {
            }
            column(ASPDRA; ASPD001[Number])
            {
            }
            column(ASPTRA; ASPT001[Number])
            {
            }
            column(TotalASP; TotalASP[Number])
            {
            }
            column(ASPSKD11; ASPM0011)
            {
            }
            column(ASPHSK11; ASPH0011)
            {
            }
            column(ASPDRA11; ASPD0011)
            {
            }
            column(ASPTRA11; ASPT0011)
            {
            }
            column(ASPSKD12; ASPM0012)
            {
            }
            column(ASPHSK12; ASPH0012)
            {
            }
            column(ASPDRA12; ASPD0012)
            {
            }
            column(ASPTRA12; ASPT0012)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //CurrReport.BREAK;
                CLEAR(PerD001);
                CLEAR(PerM001);
                CLEAR(PerH001);
                CLEAR(PerT001);
                CLEAR(TotalASP);
                PerD001[Number] := CalculatePremiumData('D001', CALCDATE('-CM', TxtDate[Premium.Number]), TxtDate[Premium.Number], 1);
                PerM001[Number] := CalculatePremiumData('M001', CALCDATE('-CM', TxtDate[Premium.Number]), TxtDate[Premium.Number], 1);
                PerH001[Number] := CalculatePremiumData('H001', CALCDATE('-CM', TxtDate[Premium.Number]), TxtDate[Premium.Number], 1);
                PerT001[Number] := CalculatePremiumData('T001', CALCDATE('-CM', TxtDate[Premium.Number]), TxtDate[Premium.Number], 1);

                CLEAR(ASPD001);
                CLEAR(ASPM001);
                CLEAR(ASPH001);
                CLEAR(ASPT001);
                ASPD001[Number] := CalculatePremiumData('D001', CALCDATE('-CM', TxtDate[Premium.Number]), TxtDate[Premium.Number], 2);
                ASPM001[Number] := CalculatePremiumData('M001', CALCDATE('-CM', TxtDate[Premium.Number]), TxtDate[Premium.Number], 2);
                ASPH001[Number] := CalculatePremiumData('H001', CALCDATE('-CM', TxtDate[Premium.Number]), TxtDate[Premium.Number], 2);
                ASPT001[Number] := CalculatePremiumData('T001', CALCDATE('-CM', TxtDate[Premium.Number]), TxtDate[Premium.Number], 2);
                TotalASP[Number] := CalculatePremiumData('', CALCDATE('-CM', TxtDate[Premium.Number]), TxtDate[Premium.Number], 2);
                /*
                CLEAR(ASPD0011);
                CLEAR(ASPM0011);
                CLEAR(ASPH0011);
                CLEAR(ASPT0011);
                IF Premium.Number>1 THEN
                IF Premium.Number = N THEN BEGIN
                  ASPD0011 := ASPD001[N] - ASPD001[N-1];
                  ASPM0011 := ASPM001[N] - ASPM001[N-1];
                  ASPH0011 := ASPH001[N] - ASPH001[N-1];
                  ASPT0011 := ASPT001[N] - ASPT001[N-1];
                END;
                */
                CLEAR(PerD0011);
                CLEAR(PerH0011);
                CLEAR(PerT0011);
                CLEAR(PerM0011);
                CLEAR(PerD0012);
                CLEAR(PerH0012);
                CLEAR(PerT0012);
                CLEAR(PerM0012);

                CLEAR(ASPD0011);
                CLEAR(ASPM0011);
                CLEAR(ASPH0011);
                CLEAR(ASPT0011);
                IF Premium.Number > 1 THEN
                    IF Premium.Number = N - 1 THEN BEGIN
                        ASPD0011 := ASPD001[N - 1];
                        ASPM0011 := ASPM001[N - 1];
                        ASPH0011 := ASPH001[N - 1];
                        ASPT0011 := ASPT001[N - 1];
                        PerD0011 := PerD001[N - 1];
                        PerH0011 := PerH001[N - 1];
                        PerT0011 := PerT001[N - 1];
                        PerM0011 := PerM001[N - 1];

                    END;
                CLEAR(ASPD0012);
                CLEAR(ASPM0012);
                CLEAR(ASPH0012);
                CLEAR(ASPT0012);
                IF Premium.Number > 1 THEN
                    IF Premium.Number = N THEN BEGIN
                        ASPD0012 := ASPD001[N];
                        ASPM0012 := ASPM001[N];
                        ASPH0012 := ASPH001[N];
                        ASPT0012 := ASPT001[N];
                        PerD0012 := PerD001[N];
                        PerH0012 := PerH001[N];
                        PerT0012 := PerT001[N];
                        PerM0012 := PerM001[N];
                    END;

            end;

            trigger OnPreDataItem()
            begin
                SETRANGE(Number, 1, N);
            end;
        }
    }

    requestpage
    {

        layout
        {
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
        ASonDate := TODAY - 1;
        //ASonDate := 300621D;
        //ASonDate := 280219D;
        //MESSAGE('%1-%2-%3-%4',MonthStartDate,MonthEndDate,YearStartDDate,YearEndDate);

        MonthStartDate := CALCDATE('-CM', ASonDate);
        MonthEndDate := CALCDATE('CM', ASonDate);
        IF DATE2DMY(ASonDate, 2) IN [1, 2, 3] THEN BEGIN
            YearStartDDate := DMY2DATE(1, 4, DATE2DMY(ASonDate, 3) - 1);
            YearStartDDate1 := DMY2DATE(1, 4, DATE2DMY(ASonDate, 3) - 2);

            StartYearPart := DATE2DMY(ASonDate, 3) - 1;
            ENDYearPart := DATE2DMY(ASonDate, 3);
        END ELSE BEGIN
            YearStartDDate := DMY2DATE(1, 4, DATE2DMY(ASonDate, 3));
            YearStartDDate1 := DMY2DATE(1, 4, DATE2DMY(ASonDate, 3) - 1);
            YearEndDate := DMY2DATE(31, 3, DATE2DMY(ASonDate, 3) + 1);
            StartYearPart := DATE2DMY(ASonDate, 3);
            ENDYearPart := DATE2DMY(ASonDate, 3) + 1;

        END;

        QTRStartDDate := CALCDATE('-CQ', ASonDate);
        QTREndDate := CALCDATE('CQ', ASonDate);

        LYMonthStartDate := CALCDATE('-1Y', MonthStartDate);
        //LYMonthEndDate := CALCDATE('-1Y',MonthEndDate);
        LYMonthEndDate := CALCDATE('-1Y', ASonDate);
        //ERROR('%1-%2-%3-%4-%5-%6',MonthStartDate,MonthEndDate,YearStartDDate,YearEndDate,QTRStartDDate,QTREndDate);
        //RK
        LYQTRStartDate := CALCDATE('-1Y', QTRStartDDate);
        //LYQTREndDate := CALCDATE('-1Y',QTREndDate);
        LYQTREndDate := CALCDATE('-1Y', ASonDate);

        FOR i := 1 TO 12 DO BEGIN
            TxtDate[i] := (CALCDATE('CM', YearStartDDate + ((i - 1) * 31)));
        END;

        FOR i := 1 TO 12 DO BEGIN
            IF DATE2DMY(TxtDate[i], 2) = DATE2DMY(ASonDate, 2) THEN
                TxtDate1[i] := ASonDate - 120
            ELSE
                TxtDate1[i] := (CALCDATE('CM', TxtDate[i] - (123)));
        END;
        //ERROR('%1,%2,%3,%4,%5,%6,%7,%8',TxtDate1[1],TxtDate1[2],TxtDate1[3],TxtDate1[4],TxtDate1[5],TxtDate1[6],TxtDate1[7],TxtDate1[8]);

        /*FOR i := 1 TO 12 DO
          IF TxtDate[i] <= ASonDate THEN
            N := i+1;*/

    end;

    trigger OnPreReport()
    begin
        FOR i := 1 TO 12 DO BEGIN
            IF TxtDate[i] = CALCDATE('CM', ASonDate) THEN BEGIN
                N := i;
            END;
        END;

        DebtorBalAmt := 0;
        CLEAR(DebtorsCollectionMGT);
        //DebtorsCollectionMGT.SETFILTER(DebtorsCollectionMGT.Customer_Type,'<>%1','LEGAL');
        DebtorsCollectionMGT.SETFILTER(DebtorsCollectionMGT.PostDateFilter, '%1..%2', 0D, TxtDate[N]);
        DebtorsCollectionMGT.SETFILTER(Sum_Amount, '>%1', 0);
        DebtorsCollectionMGT.OPEN;
        WHILE DebtorsCollectionMGT.READ DO BEGIN
            DebtorBalAmt += DebtorsCollectionMGT.Sum_Amount / 100000;
        END;
        CLEAR(DebtorsCollectionMGT);
        //DebtorsCollectionMGT.SETFILTER(DebtorsCollectionMGT.Customer_Type,'<>%1','LEGAL');
        DebtorsCollectionMGT.SETFILTER(DebtorsCollectionMGT.PostDateFilter, '%1..%2', 0D, YearStartDDate - 1);
        DebtorsCollectionMGT.OPEN;
        WHILE DebtorsCollectionMGT.READ DO BEGIN
            LYDebtorBalance += DebtorsCollectionMGT.Sum_Amount;
        END;

        GetBadSalesValue('M001', MonthStartDate, ASonDate, MTDSalesQtyM001, MTDSalesM001, FALSE);
        GetBadSalesValue('D001', MonthStartDate, ASonDate, MTDSalesQtyD001, MTDSalesD001, FALSE);
        GetBadSalesValue('H001', MonthStartDate, ASonDate, MTDSalesQtyH001, MTDSalesH001, FALSE);

        GetBadSalesValue('M001', YearStartDDate, ASonDate, YTDSalesQtyM001, YTDSalesM001, FALSE);
        GetBadSalesValue('D001', YearStartDDate, ASonDate, YTDSalesQtyD001, YTDSalesD001, FALSE);
        GetBadSalesValue('H001', YearStartDDate, ASonDate, YTDSalesQtyH001, YTDSalesH001, FALSE);

        CLEAR(CalculateSummaryInventory);
        CalculateSummaryInventory.SETFILTER(CalculateSummaryInventory.Item_Category_Code, '%1|%2|%3', 'M001', 'H001', 'D001');
        CalculateSummaryInventory.SETFILTER(CalculateSummaryInventory.Posting_Date, '%1..%2', 0D, ASonDate);
        CalculateSummaryInventory.SETFILTER(CalculateSummaryInventory.Quality_Code, '<>%1', '1');
        CalculateSummaryInventory.OPEN;
        WHILE CalculateSummaryInventory.READ DO BEGIN
            CASE CalculateSummaryInventory.Item_Category_Code OF
                'M001':
                    M001StockQty += CalculateSummaryInventory.Sum_Remaining_Quantity;
                'D001':
                    D001StockQty += CalculateSummaryInventory.Sum_Remaining_Quantity;
                'H001':
                    H001StockQty += CalculateSummaryInventory.Sum_Remaining_Quantity;

            END;
        END;

        CLEAR(CalculateSummaryInventory);
        CalculateSummaryInventory.SETFILTER(CalculateSummaryInventory.Item_Category_Code, '%1|%2|%3', 'M001', 'H001', 'D001');
        CalculateSummaryInventory.SETFILTER(CalculateSummaryInventory.Quality_Code, '%1', '1');
        CalculateSummaryInventory.SETFILTER(CalculateSummaryInventory.Manuf_Strategy, '%1', CalculateSummaryInventory.Manuf_Strategy::"Non Retained ");
        CalculateSummaryInventory.SETFILTER(CalculateSummaryInventory.Posting_Date, '%1..%2', 0D, ASonDate);
        CalculateSummaryInventory.OPEN;
        WHILE CalculateSummaryInventory.READ DO BEGIN
            CASE CalculateSummaryInventory.Item_Category_Code OF
                'M001':
                    M001StockQty += CalculateSummaryInventory.Sum_Remaining_Quantity;
                'D001':
                    D001StockQty += CalculateSummaryInventory.Sum_Remaining_Quantity;
                'H001':
                    H001StockQty += CalculateSummaryInventory.Sum_Remaining_Quantity;

            END;
        END;

        //FocusPt 200821 >>>>>

        CLEAR(QryMonthlySales);
        QryMonthlySales.SETFILTER(QryMonthlySales.TypeCatCodeDesc, '%1|%2|%3', 'M001', 'H001', 'D001');
        QryMonthlySales.SETFILTER(QryMonthlySales.PostingDateFilter, '%1..%2', MonthStartDate, MonthEndDate);
        QryMonthlySales.SETFILTER(QryMonthlySales.Goal_Sheet_Focused_Product, '<>%1', '');
        QryMonthlySales.OPEN;
        WHILE QryMonthlySales.READ DO BEGIN
            CASE QryMonthlySales.TypeCatCodeDesc OF
                'M001':
                    MTDFocusM001 += QryMonthlySales.Quantity_Base;
                'D001':
                    MTDFocusD001 += QryMonthlySales.Quantity_Base;
                'H001':
                    MTDFocusH001 += QryMonthlySales.Quantity_Base;

            END;
        END;


        CLEAR(QryMonthlySales);
        QryMonthlySales.SETFILTER(QryMonthlySales.TypeCatCodeDesc, '%1|%2|%3', 'M001', 'H001', 'D001');
        QryMonthlySales.SETFILTER(QryMonthlySales.PostingDateFilter, '%1..%2', 0D, LYMonthEndDate);
        QryMonthlySales.SETFILTER(QryMonthlySales.Goal_Sheet_Focused_Product, '<>%1', '');
        QryMonthlySales.OPEN;
        WHILE QryMonthlySales.READ DO BEGIN
            CASE QryMonthlySales.TypeCatCodeDesc OF
                'M001':
                    LYFocusM001 += QryMonthlySales.Quantity_Base;
                'D001':
                    LYFocusD001 += QryMonthlySales.Quantity_Base;
                'H001':
                    LYFocusH001 += QryMonthlySales.Quantity_Base;
            END;
        END;
    end;

    var
        ASonDate: Date;
        QtyForDay: Decimal;
        ValueForDay: Decimal;
        HVPQtyForDay: Decimal;
        HVPValueForDay: Decimal;
        HVPASPForDay: Decimal;
        "QtyForDay-1": Decimal;
        "ValueForDay-1": Decimal;
        "HVPASPForDay-1": Decimal;
        MonthTarget: Decimal;
        MTDSales: Decimal;
        MTDQty: Decimal;
        QTRSales: Decimal;
        QTRQty: Decimal;
        YTDSales: Decimal;
        YTDQty: Decimal;
        MTDASPSales: Decimal;
        YTDASPSales: Decimal;
        Collection: Decimal;
        DebtorBalAmt: Decimal;
        HVPPercentage: Decimal;
        HVPASP: Decimal;
        MonthStartDate: Date;
        MonthEndDate: Date;
        YearStartDDate: Date;
        YearEndDate: Date;
        QTRStartDDate: Date;
        QTREndDate: Date;
        LYMonthStartDate: Date;
        LYMonthEndDate: Date;
        LYQTRStartDate: Date;
        LYQTREndDate: Date;
        LYQTRQty: Decimal;
        LYQTRSales: Decimal;
        MTDHVPSales: Decimal;
        MTDHVPQty: Decimal;
        LastYearMTDQty: Decimal;
        LastYearMTDSales: Decimal;
        LYMonthSales: Decimal;
        LastYearQTDQty: Decimal;
        LastYearQTDSales: Decimal;
        TotalCYSales: Decimal;
        ItemLedgerEntry: Record "Item Ledger Entry";
        CalculateSummaryInventory: Query "Calculate Summary Inventory";
        LYInventory: Decimal;
        CYInventory: Decimal;
        QryMonthlySales: Query "Sales Journal Data";
        ValueForDt: array[11] of Decimal;
        "ValueForDt-1": Decimal;
        Catogry: Text;
        AsOnDt: array[11] of Date;
        i: Integer;
        ReportType: Text;
        DebtorsCollectionMGT: Query "Debtors Collection MGT";
        ZoneDesc: Text;
        MatrixMaster: Record "Matrix Master";
        OBDebtorBalance: Decimal;
        OBCKADebtorBalance: Decimal;
        DebtorBalance: array[12] of Decimal;
        DebtorBalance1: array[12] of Decimal;
        CKADebtorBalance: array[12] of Decimal;
        StartYearPart: Integer;
        ENDYearPart: Integer;
        TabZone: Code[20];
        TxtDate: array[12] of Date;
        PerT001: array[12] of Decimal;
        PerD001: array[12] of Decimal;
        PerH001: array[12] of Decimal;
        PerM001: array[12] of Decimal;
        PerT0011: Decimal;
        PerD0011: Decimal;
        PerH0011: Decimal;
        PerM0011: Decimal;
        PerT0012: Decimal;
        PerD0012: Decimal;
        PerH0012: Decimal;
        PerM0012: Decimal;
        ASPT001: array[12] of Decimal;
        ASPD001: array[12] of Decimal;
        ASPH001: array[12] of Decimal;
        ASPM001: array[12] of Decimal;
        ASPT0011: Decimal;
        ASPD0011: Decimal;
        ASPH0011: Decimal;
        ASPM0011: Decimal;
        N: Integer;
        ASPT0012: Decimal;
        ASPD0012: Decimal;
        ASPH0012: Decimal;
        ASPM0012: Decimal;
        FirstTime: Boolean;
        TotalASP: array[12] of Decimal;
        "HVPQtyForDay-1": Decimal;
        "HVPValueForDay-1": Decimal;
        LYDebtorBalance: Decimal;
        LineAmt: Decimal;
        TempVariable: Decimal;
        QtyForDtChart: array[11] of Decimal;
        SalesRetT001: Decimal;
        SalesRetH001: Decimal;
        SalesRetD001: Decimal;
        SalesRetM001: Decimal;
        YearStartDDate1: Date;
        TxtDate1: array[12] of Date;
        MTDSalesM001: Decimal;
        MTDSalesD001: Decimal;
        MTDSalesH001: Decimal;
        MTDSalesQtyM001: Decimal;
        MTDSalesQtyD001: Decimal;
        MTDSalesQtyH001: Decimal;
        YTDSalesM001: Decimal;
        YTDSalesD001: Decimal;
        YTDSalesH001: Decimal;
        YTDSalesQtyM001: Decimal;
        YTDSalesQtyD001: Decimal;
        YTDSalesQtyH001: Decimal;
        M001StockQty: Decimal;
        D001StockQty: Decimal;
        H001StockQty: Decimal;
        MTDFocusM001: Decimal;
        MTDFocusD001: Decimal;
        MTDFocusH001: Decimal;
        LYFocusM001: Decimal;
        LYFocusD001: Decimal;
        LYFocusH001: Decimal;
        Doctypeenum: Enum "Document Type Enum";

    local procedure InitializeVariables()
    begin
        QtyForDay := 0;
        "QtyForDay-1" := 0;
        ValueForDay := 0;
        MTDSales := 0;
        MTDASPSales := 0;
        YTDSales := 0;
        YTDASPSales := 0;
        MTDQty := 0;
        YTDQty := 0;
        MTDHVPQty := 0;
        MTDHVPSales := 0;
        HVPASP := 0;
        HVPPercentage := 0;
        QTRQty := 0;
        QTRSales := 0;
        LastYearMTDQty := 0;
        LastYearMTDSales := 0;
        LastYearQTDQty := 0;
        LastYearQTDSales := 0;
        LYQTRQty := 0;
        LYQTRSales := 0;
        HVPQtyForDay := 0;
        HVPValueForDay := 0;
        "HVPQtyForDay-1" := 0;
        "HVPValueForDay-1" := 0;
    end;

    local procedure GetSalesValue(AreaCode: Code[10]; Sdate: Date; Edate: Date; var SalesQty: Decimal; var SalesValue: Decimal; HVP: Boolean)
    var
        SalesJournalData: Query "Sales Journal Data";
        SalesDataMGT: Query "Sales Journal Data";
        SalesReturnJournalData: Query "Sales Return Journal Data";
    begin
        CLEAR(SalesDataMGT);
        IF AreaCode <> '' THEN
            IF AreaCode <> 'CKA' THEN BEGIN
                SalesDataMGT.SETFILTER(SalesDataMGT.CustomerType, '<>%1&<>%2&<>%3', 'MISC.', 'CKA', 'DIRECTPROJ');
                SalesDataMGT.SETFILTER(SalesDataMGT.AreaFilter, AreaCode);
            END ELSE BEGIN
                SalesDataMGT.SETFILTER(SalesDataMGT.CustomerType, '%1|%2|%3', 'MISC.', 'CKA', 'DIRECTPROJ');
            END;
        SalesDataMGT.SETRANGE(SalesDataMGT.PostingDateFilter, Sdate, Edate);
        IF HVP THEN
            SalesDataMGT.SETRANGE(SalesDataMGT.QualityCode, '1');
        SalesDataMGT.OPEN;
        WHILE SalesDataMGT.READ DO BEGIN
            SalesValue += SalesDataMGT.LineAmount;
            SalesQty += SalesDataMGT.Quantity_Base;
            TabZone := SalesDataMGT.TableauZone;
        END;

        CLEAR(SalesReturnJournalData);
        IF AreaCode <> '' THEN
            IF AreaCode <> 'CKA' THEN BEGIN
                SalesReturnJournalData.SETFILTER(SalesReturnJournalData.CustomerType, '<>%1&<>%2&<>%3', 'MISC.', 'CKA', 'DIRECTPROJ');
                SalesReturnJournalData.SETFILTER(SalesReturnJournalData.AreaFilter, AreaCode);
            END ELSE BEGIN
                SalesReturnJournalData.SETFILTER(SalesReturnJournalData.CustomerType, '%1|%2|%3', 'MISC.', 'CKA', 'DIRECTPROJ');
            END;
        SalesReturnJournalData.SETRANGE(SalesReturnJournalData.PostingDateFilter, Sdate, Edate);
        IF HVP THEN
            SalesReturnJournalData.SETRANGE(SalesReturnJournalData.QualityCode, '1');
        SalesReturnJournalData.OPEN;
        WHILE SalesReturnJournalData.READ DO BEGIN
            SalesValue -= SalesReturnJournalData.LineAmount;
            SalesQty -= SalesReturnJournalData.Quantity_Base;
        END;

        /*
        CLEAR(SalesDataMGT);
        IF AreaCode <>'' THEN
          IF AreaCode <> 'CKA' THEN BEGIN
            SalesDataMGT.SETFILTER(CustomerTypeFilter,'<>%1&<>%2&<>%3','MISC.','CKA','DIRECTPROJ');
            SalesDataMGT.SETFILTER(SalesDataMGT.AreaFilter,AreaCode);
          END ELSE BEGIN
          SalesDataMGT.SETFILTER(CustomerTypeFilter,'%1|%2|%3','MISC.','CKA','DIRECTPROJ');
          END;
        SalesDataMGT.SETRANGE(PostDateFilter,Sdate,Edate);
        IF HVP THEN
          SalesDataMGT.SETRANGE(SalesDataMGT.HVPFilter,TRUE);
        SalesDataMGT.OPEN;
        WHILE SalesDataMGT.READ DO BEGIN
          SalesValue += SalesDataMGT.Sum_Line_Amount;
          SalesQty += SalesDataMGT.Sum_Quantity_Base;
        END;
        */

    end;

    local procedure GetCollectionData(AreaCode: Code[10]; Sdate: Date; Edate: Date; var Amt: Decimal)
    var
        DebtorsCollectionMGT: Query "Debtors Collection MGT";
    begin
        CLEAR(DebtorsCollectionMGT);
        IF AreaCode <> '' THEN
            IF AreaCode <> 'CKA' THEN BEGIN
                DebtorsCollectionMGT.SETFILTER(DebtorsCollectionMGT.Customer_Type, '<>%1&<>%2&<>%3', 'MISC.', 'CKA', 'DIRECTPROJ');
                DebtorsCollectionMGT.SETFILTER(DebtorsCollectionMGT.Area_Code, AreaCode);
            END ELSE BEGIN
                DebtorsCollectionMGT.SETFILTER(DebtorsCollectionMGT.Customer_Type, '%1|%2|%3', 'MISC.', 'CKA', 'DIRECTPROJ');
            END;
        DebtorsCollectionMGT.SETRANGE(DebtorsCollectionMGT.PostDateFilter, Sdate, Edate);
        DebtorsCollectionMGT.OPEN;
        WHILE DebtorsCollectionMGT.READ DO
            Amt += DebtorsCollectionMGT.Sum_Amount;
    end;

    local procedure CalculatePremiumData(Plant: Code[10]; DtFrom: Date; DtTo: Date; Type: Integer): Decimal
    var
        QryMonthlyWiseSalesData: Query "MonthlyWise  Sales Data";
        Amt: Decimal;
        TotQty: Decimal;
        Qty: Decimal;
        TotAmt: Decimal;
    begin
        QryMonthlyWiseSalesData.SETRANGE(QryMonthlyWiseSalesData.PostingDateFilter, DtFrom, DtTo);
        IF Plant <> '' THEN
            QryMonthlyWiseSalesData.SETFILTER(QryMonthlyWiseSalesData.TypeCatCodeDesc, '%1', Plant);
        QryMonthlyWiseSalesData.OPEN;
        WHILE QryMonthlyWiseSalesData.READ DO BEGIN
            IF QryMonthlyWiseSalesData.QualityCode = '1' THEN
                Amt += QryMonthlyWiseSalesData.Sum_Quantity_Base;
            TotAmt += QryMonthlyWiseSalesData.LineAmount;
            TotQty += QryMonthlyWiseSalesData.Sum_Quantity_Base;
        END;

        IF (Type = 1) AND (TotAmt <> 0) THEN
            EXIT((Amt / TotQty) * 100);
        IF (Type = 2) AND (TotQty <> 0) THEN
            EXIT(TotAmt / TotQty);
    end;

    procedure GetCollectionData1(AreaCode: Code[10]; Sdate: Date; Edate: Date; var Amt: Decimal)
    var
        CustAgeingMGT: Query "Cust. Ageing MGT";
    begin
        CLEAR(CustAgeingMGT);
        CustAgeingMGT.SETRANGE(CustAgeingMGT.Posting_Date, Sdate, Edate);
        CustAgeingMGT.SETFILTER(CustAgeingMGT.Document_Type, '%1|%2', Doctypeenum::Payment, Doctypeenum::Refund);
        CustAgeingMGT.OPEN;
        WHILE CustAgeingMGT.READ DO
            Amt -= CustAgeingMGT.Sum_Amount;
    end;

    local procedure GetBadSalesValue(PlantCode: Code[10]; Sdate: Date; Edate: Date; var SalesQty: Decimal; var SalesValue: Decimal; HVP: Boolean)
    var
        SalesJournalData: Query "Sales Journal Data";
        SalesDataMGT: Query "Sales Journal Data";
        SalesReturnJournalData: Query "Sales Return Journal Data";
    begin
        CLEAR(SalesDataMGT);
        SalesDataMGT.SETRANGE(SalesDataMGT.PostingDateFilter, Sdate, Edate);
        IF PlantCode <> '' THEN
            SalesDataMGT.SETFILTER(SalesDataMGT.Item_Category_Code_Filter, '%1', PlantCode);
        SalesDataMGT.OPEN;
        WHILE SalesDataMGT.READ DO BEGIN
            IF SalesDataMGT.QualityCode = '1' THEN BEGIN
                IF SalesDataMGT.Manuf_stategy = SalesDataMGT.Manuf_stategy::"Non Retained " THEN BEGIN
                    SalesValue += SalesDataMGT.LineAmount;
                    SalesQty += SalesDataMGT.Quantity_Base;
                END;
                TabZone := SalesDataMGT.TableauZone;
            END ELSE BEGIN
                IF SalesDataMGT.QualityCode <> '1' THEN BEGIN
                    SalesValue += SalesDataMGT.LineAmount;
                    SalesQty += SalesDataMGT.Quantity_Base;
                END;
            END;
        END;

        CLEAR(SalesReturnJournalData);
        SalesReturnJournalData.SETRANGE(SalesReturnJournalData.PostingDateFilter, Sdate, Edate);
        IF PlantCode <> '' THEN
            SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code_Filter, '%1', PlantCode);
        SalesReturnJournalData.OPEN;
        WHILE SalesReturnJournalData.READ DO BEGIN
            IF SalesReturnJournalData.QualityCode = '1' THEN BEGIN
                IF SalesReturnJournalData.Manuf_Strategy = SalesReturnJournalData.Manuf_Strategy::"Non Retained " THEN BEGIN
                    SalesValue += SalesReturnJournalData.LineAmount;
                    SalesQty += SalesReturnJournalData.Quantity_Base;
                END;
                TabZone := SalesReturnJournalData.TableauZone;
            END ELSE BEGIN
                IF SalesReturnJournalData.QualityCode <> '1' THEN BEGIN
                    SalesValue += SalesReturnJournalData.LineAmount;
                    SalesQty += SalesReturnJournalData.Quantity_Base;
                END;
            END;
        END;
    end;
}

