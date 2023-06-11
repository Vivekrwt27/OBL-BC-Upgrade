report 50066 "Depot Sales Trend Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\DepotSalesTrendReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Location; 14)
        {
            DataItemTableView = SORTING(Code)
                                WHERE(Depot = FILTER(true));
            column(AsOnDate; AsOnDate)
            {
            }
            column(LocationCode; Code)
            {
            }
            column(SalesTerritory; Location."Sales Territory")
            {
            }
            column(YTDSalesAmt; YTDSalesAmt)
            {
            }
            column(YTDSalesQty; YTDSalesQty)
            {
            }
            column(MTDSalesAmt; MTDSalesAmt)
            {
            }
            column(MTDSalesQty; MTDSalesQty)
            {
            }
            column(MTDLocalSalesAmt; MTDLocalSalesAmt)
            {
            }
            column(ClosingStock; ClosingStock)
            {
            }
            column(NoofCP; NoofCP)
            {
            }
            column(NoofCities; NoofCities)
            {
            }
            column(LocalCPCount; "Local CP Count")
            {
            }
            column(PanIndiaCPCount; "Pan India CP Count")
            {
            }
            column(LocalSalesTarget; "Local Sales Target")
            {
            }
            column(PanIndiaSalesTarget; "Pan India Sales Target")
            {
            }
            column(TargetSaleAnnual; ("Local Sales Target" + "Pan India Sales Target") * 12)
            {
            }
            column(TargetMTDNoofCP; TargetMTDNoofCP)
            {
            }
            column(TargetMTDNoofCPLocal; TargetMTDNoofCPLocal)
            {
            }
            column(TargetMTDNoofCities; TargetMTDNoofCities)
            {
            }
            column(TargetMTDNoofCitiesLocal; TargetMTDNoofCitiesLocal)
            {
            }
            column(txtFocusProdName1; txtFocusProdName[1])
            {
            }
            column(txtFocusProdName2; txtFocusProdName[2])
            {
            }
            column(txtFocusProdName3; txtFocusProdName[3])
            {
            }
            column(txtFocusProdName4; txtFocusProdName[4])
            {
            }
            column(txtFocusProdName5; txtFocusProdName[5])
            {
            }
            column(txtFocusProdName6; txtFocusProdName[6])
            {
            }
            column(txtFocusProdName7; txtFocusProdName[7])
            {
            }
            column(txtFocusProdName8; txtFocusProdName[8])
            {
            }
            column(txtFocusProdName9; txtFocusProdName[9])
            {
            }
            column(txtFocusProdName10; txtFocusProdName[10])
            {
            }
            column(txtFocusProdName11; txtFocusProdName[11])
            {
            }
            column(txtFocusProdName12; txtFocusProdName[12])
            {
            }
            column(txtFocusProdName13; txtFocusProdName[13])
            {
            }
            column(MTDFocusSalesValues1; MTDFocusSalesValues[1])
            {
            }
            column(MTDFocusSalesValues2; MTDFocusSalesValues[2])
            {
            }
            column(MTDFocusSalesValues3; MTDFocusSalesValues[3])
            {
            }
            column(MTDFocusSalesValues4; MTDFocusSalesValues[4])
            {
            }
            column(MTDFocusSalesValues5; MTDFocusSalesValues[5])
            {
            }
            column(MTDFocusSalesValues6; MTDFocusSalesValues[6])
            {
            }
            column(MTDFocusSalesValues7; MTDFocusSalesValues[7])
            {
            }
            column(MTDFocusSalesValues8; MTDFocusSalesValues[8])
            {
            }
            column(MTDFocusSalesValues9; MTDFocusSalesValues[9])
            {
            }
            column(MTDFocusSalesValues10; MTDFocusSalesValues[10])
            {
            }
            column(MTDFocusSalesValues11; MTDFocusSalesValues[11])
            {
            }
            column(MTDFocusSalesValues12; MTDFocusSalesValues[12])
            {
            }
            column(MTDFocusSalesValues13; MTDFocusSalesValues[13])
            {
            }
            column(YTDFocusSalesValues1; YTDFocusSalesValues[1])
            {
            }
            column(YTDFocusSalesValues2; YTDFocusSalesValues[2])
            {
            }
            column(YTDFocusSalesValues3; YTDFocusSalesValues[3])
            {
            }
            column(YTDFocusSalesValues4; YTDFocusSalesValues[4])
            {
            }
            column(YTDFocusSalesValues5; YTDFocusSalesValues[5])
            {
            }
            column(YTDFocusSalesValues6; YTDFocusSalesValues[6])
            {
            }
            column(YTDFocusSalesValues7; YTDFocusSalesValues[7])
            {
            }
            column(YTDFocusSalesValues8; YTDFocusSalesValues[8])
            {
            }
            column(YTDFocusSalesValues9; YTDFocusSalesValues[9])
            {
            }
            column(YTDFocusSalesValues10; YTDFocusSalesValues[10])
            {
            }
            column(YTDFocusSalesValues11; YTDFocusSalesValues[11])
            {
            }
            column(YTDFocusSalesValues12; YTDFocusSalesValues[12])
            {
            }
            column(YTDFocusSalesValues13; YTDFocusSalesValues[13])
            {
            }
            column(MTDFocusSalesTerrValues1; MTDFocusSalesTerrValues[1])
            {
            }
            column(MTDFocusSalesTerrValues2; MTDFocusSalesTerrValues[2])
            {
            }
            column(MTDFocusSalesTerrValues3; MTDFocusSalesTerrValues[3])
            {
            }
            column(MTDFocusSalesTerrValues4; MTDFocusSalesTerrValues[4])
            {
            }
            column(MTDFocusSalesTerrValues5; MTDFocusSalesTerrValues[5])
            {
            }
            column(MTDFocusSalesTerrValues6; MTDFocusSalesTerrValues[6])
            {
            }
            column(MTDFocusSalesTerrValues7; MTDFocusSalesTerrValues[7])
            {
            }
            column(MTDFocusSalesTerrValues8; MTDFocusSalesTerrValues[8])
            {
            }
            column(MTDFocusSalesTerrValues9; MTDFocusSalesTerrValues[9])
            {
            }
            column(MTDFocusSalesTerrValues10; MTDFocusSalesTerrValues[10])
            {
            }
            column(MTDFocusSalesTerrValues11; MTDFocusSalesTerrValues[11])
            {
            }
            column(MTDFocusSalesTerrValues12; MTDFocusSalesTerrValues[12])
            {
            }
            column(MTDFocusSalesTerrValues13; MTDFocusSalesTerrValues[13])
            {
            }
            column(FocusStockValues1; FocusStockValues[1])
            {
            }
            column(FocusStockValues2; FocusStockValues[2])
            {
            }
            column(FocusStockValues3; FocusStockValues[3])
            {
            }
            column(FocusStockValues4; FocusStockValues[4])
            {
            }
            column(FocusStockValues5; FocusStockValues[5])
            {
            }
            column(FocusStockValues6; FocusStockValues[6])
            {
            }
            column(FocusStockValues7; FocusStockValues[7])
            {
            }
            column(FocusStockValues8; FocusStockValues[8])
            {
            }
            column(FocusStockValues9; FocusStockValues[9])
            {
            }
            column(FocusStockValues10; FocusStockValues[10])
            {
            }
            column(FocusStockValues11; FocusStockValues[11])
            {
            }
            column(FocusStockValues12; FocusStockValues[12])
            {
            }
            column(FocusStockValues13; FocusStockValues[13])
            {
            }
            column(AgedStockTot; AgedStockTot)
            {
            }

            trigger OnAfterGetRecord()
            begin
                YTDSalesAmt := 0;
                YTDSalesQty := 0;
                MTDSalesAmt := 0;
                MTDSalesQty := 0;
                CLEAR(ClosingStock);
                CLEAR(NoofCP);
                CLEAR(NoofCities);
                CLEAR(TargetMTDNoofCP);
                CLEAR(TargetMTDNoofCities);
                TargetMTDNoofCities := 0;
                TargetMTDNoofCitiesLocal := 0;
                AgedStockTot := 0;
                CLEAR(AgedStock);


                GetMonthlyRevenue(Location.Code, CALCDATE('-CM', AsOnDate), AsOnDate, MTDSalesAmt, MTDSalesQty, MTDLocalSalesAmt, MTDLocalSalesQty, NotDefined, FALSE);
                GetMonthlyRevenue(Location.Code, FYStartDate, AsOnDate, YTDSalesAmt, YTDSalesQty, YTDLocalSalesAmt, YTDLocalSalesQty, NotDefined, FALSE);
                ClosingStock := CalculateStock(Location.Code, AsOnDate);
                CalcNoOFCPBilled(Location.Code, CALCDATE('-CM', AsOnDate), AsOnDate, TargetMTDNoofCP, TargetMTDNoofCPLocal);
                CalcNoOFCPBilled(Location.Code, FYStartDate, AsOnDate, NoofCP, NoOfCPLocal);


                CalcNoOFCitiesBilled(Location.Code, CALCDATE('-CM', AsOnDate), AsOnDate, TargetMTDNoofCities, TargetMTDNoofCitiesLocal);
                CalcNoOFCitiesBilled(Location.Code, FYStartDate, AsOnDate, NoofCities, NoofCitiesLocal);

                CLEAR(MTDFocusSalesValues);
                CLEAR(YTDFocusSalesValues);
                GetfocusSalesData(Location.Code, CALCDATE('-CM', AsOnDate), AsOnDate, MTDFocusSalesValues, NotRequired, FALSE);
                GetfocusSalesData(Location.Code, FYStartDate, AsOnDate, YTDFocusSalesValues, NotRequired, FALSE);

                CLEAR(MTDFocusSalesTerrValues);
                GetfocusSalesData(Location.Code, CALCDATE('-CM', AsOnDate), AsOnDate, MTDFocusSalesTerrValues, NotRequired, TRUE);

                CLEAR(FocusStockValues);
                GetFocusStockData(Location.Code, 0D, AsOnDate, FocusStockValues);

                FOR i := 1 TO 14 DO BEGIN
                    AgedStockTot += AgedStock[i];
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("As On Date"; AsOnDate)
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

    trigger OnPreReport()
    var
        DimensionValue: Record "Dimension Value";
    begin
        IF AsOnDate = 0D THEN
            AsOnDate := TODAY
        ELSE
            AsOnDate := AsOnDate;
        //AsOnDate := 300422D;
        //FYStartDate := 010421D;

        Month := DATE2DMY(AsOnDate, 2);
        Year := DATE2DMY(AsOnDate, 3);

        IF Month > 3 THEN
            FYStartDate := DMY2DATE(1, 4, Year)
        ELSE
            FYStartDate := DMY2DATE(1, 4, Year - 1);

        FYEndDate := AsOnDate;

        //ERROR('StartDate %1 = EndDate %2',FYStartDate,FYEndDate);

        i := 1;
        DimensionValue.RESET;
        DimensionValue.SETFILTER("Dimension Code", '%1', 'GOALSHEET');
        IF DimensionValue.FINDFIRST THEN BEGIN
            REPEAT
                txtFocusProdCode[i] := DimensionValue.Code;
                txtFocusProdName[i] := DimensionValue.Name;
                i += 1;
            UNTIL (DimensionValue.NEXT = 0) OR (i > 14);
        END;
    end;

    var
        AsOnDate: Date;
        FYStartDate: Date;
        FYEndDate: Date;
        Year: Integer;
        Month: Integer;
        SalesJournalData: Query "Sales Journal Data";
        SalesReturnJournalData: Query "Sales Return Journal Data";
        YTDSalesQty: Decimal;
        YTDSalesAmt: Decimal;
        MTDSalesQty: Decimal;
        MTDSalesAmt: Decimal;
        NotDefined: Decimal;
        ClosingStock: Decimal;
        NoofCP: Integer;
        NoOfCPLocal: Integer;
        NoofCities: Integer;
        NoofCitiesLocal: Integer;
        TargetMTDNoofCP: Integer;
        TargetMTDNoofCPLocal: Integer;
        TargetMTDNoofCities: Integer;
        TargetMTDNoofCitiesLocal: Integer;
        MTDLocalSalesQty: Decimal;
        MTDLocalSalesAmt: Decimal;
        YTDLocalSalesQty: Decimal;
        YTDLocalSalesAmt: Decimal;
        txtFocusProdCode: array[15] of Code[10];
        txtFocusProdName: array[15] of Text;
        FocusStockValues: array[15] of Decimal;
        MTDFocusSalesValues: array[15] of Decimal;
        YTDFocusSalesValues: array[15] of Decimal;
        NotRequired: array[15] of Decimal;
        i: Integer;
        MTDFocusSalesTerrValues: array[15] of Decimal;
        AgedStock: array[20] of Decimal;
        AgedStockTot: Decimal;

    procedure GetMonthlyRevenue(LocCode: Code[20]; FromDate: Date; ToDate: Date; var SalesAmt: Decimal; var SalesQty: Decimal; var LocalSale: Decimal; var LocalSaleQty: Decimal; var RangeSaleCount: Decimal; CalcRangeData: Boolean)
    var
        SalesJournalData: Query "Sales Journal Data";
        FieldForceCode: Code[20];
        MonthDate: Date;
        SalesJournalData1: Query "Sales Return Journal Data";
        LastGoalCode: Code[20];
        LastDealerCode: Code[20];
        RangeProdSalesSqlMt: Decimal;
        QryFocusCount: Query "Focus Count";
        Location: Record Location;
    begin
        SalesAmt := 0;
        SalesQty := 0;
        LocalSale := 0;
        RangeSaleCount := 0;
        LocalSaleQty := 0;
        IF Location.GET(LocCode) THEN;
        CLEAR(SalesJournalData);
        SalesJournalData.SETFILTER(SalesJournalData.LocationCode, '%1', LocCode); //MSKS
        SalesJournalData.SETFILTER(PostingDateFilter, '%1..%2', FromDate, ToDate);
        SalesJournalData.OPEN;
        WHILE SalesJournalData.READ DO BEGIN
            SalesAmt += SalesJournalData.LineAmount;
            SalesQty += SalesJournalData.Quantity_Base;
            IF Location."Post Code" = SalesJournalData.PostCode THEN BEGIN
                LocalSale += SalesJournalData.LineAmount;
                LocalSaleQty += SalesJournalData.Quantity_Base;
            END;
        END;

        CLEAR(SalesJournalData1);
        SalesJournalData1.SETFILTER(LocationCode, '%1', LocCode); //MSKS
        SalesJournalData1.SETFILTER(PostingDateFilter, '%1..%2', FromDate, ToDate);
        SalesJournalData1.OPEN;
        WHILE SalesJournalData1.READ DO BEGIN
            SalesAmt -= SalesJournalData1.LineAmount;
            SalesQty -= SalesJournalData1.Quantity_Base;
        END;
    end;

    local procedure CalcNoOFCPBilled(LocCode: Code[20]; FromDate: Date; ToDate: Date; var TotalNoOfCount: Integer; var LocalNoOfCount: Integer)
    var
        NoOFCPBilled: Query "No. of CP Billed";
        LastPostCode: Code[10];
    begin
        CLEAR(TotalNoOfCount);
        CLEAR(LocalNoOfCount);
        IF Location.GET(LocCode) THEN;
        CLEAR(NoOFCPBilled);
        NoOFCPBilled.SETFILTER(LocationCodeFilter, '%1', LocCode); //MSKS
        NoOFCPBilled.SETFILTER(PostingDateFilter, '%1..%2', FromDate, ToDate);
        NoOFCPBilled.OPEN;
        WHILE NoOFCPBilled.READ DO BEGIN
            //IF LastPostCode <> NoOFCPBilled.Post_Code THEN BEGIN
            TotalNoOfCount += 1;
            IF NoOFCPBilled.Post_Code = Location."Post Code" THEN
                LocalNoOfCount += 1;
            // LastPostCode := NoOFCPBilled.Post_Code;
            // END;
        END;
    end;

    local procedure CalculateStock(LocCode: Code[20]; AsOnDate: Date) Qty: Decimal
    var
        ItemStock: Query "Item Stock";
    begin
        CLEAR(ItemStock);
        ItemStock.SETFILTER(ItemStock.Location_Code, '%1', LocCode);
        ItemStock.OPEN;

        WHILE ItemStock.READ DO BEGIN
            Qty += ItemStock.Sum_Remaining_Quantity;
        END;
    end;

    local procedure CalcNoOFCitiesBilled(LocCode: Code[20]; FromDate: Date; ToDate: Date; var NoOfCount: Integer; var LocalNoOfCount: Integer)
    var
        NoofCitiesBilled: Query "No. of Cities Billed";
        LastPostCode: Code[10];
    begin
        CLEAR(NoOfCount);
        CLEAR(LocalNoOfCount);
        IF Location.GET(LocCode) THEN;
        CLEAR(NoofCitiesBilled);
        NoofCitiesBilled.SETFILTER(LocationCodeFilter, '%1', LocCode); //MSKS
        NoofCitiesBilled.SETFILTER(PostingDateFilter, '%1..%2', FromDate, ToDate);
        NoofCitiesBilled.OPEN;
        WHILE NoofCitiesBilled.READ DO BEGIN
            IF LastPostCode <> NoofCitiesBilled.Post_Code THEN BEGIN
                NoOfCount += 1;
                IF Location."Post Code" = NoofCitiesBilled.Post_Code THEN BEGIN
                    LocalNoOfCount += 1;
                END;
                LastPostCode := NoofCitiesBilled.Post_Code;
            END;
        END;
    end;

    procedure GetfocusSalesData(LocCode: Code[20]; FromDate: Date; ToDate: Date; var SalesQty: array[15] of Decimal; var SalesData: array[15] of Decimal; BlnSalesTeritory: Boolean)
    var
        SalesJournalData: Query "Sales Journal Data";
        FieldForceCode: Code[20];
        MonthDate: Date;
        SalesJournalData1: Query "Sales Return Journal Data";
        LastGoalCode: Code[20];
        LastDealerCode: Code[20];
        RangeProdSalesSqlMt: Decimal;
        QryFocusCount: Query "Focus Count";
        Location: Record Location;
    begin
        CLEAR(SalesData);
        IF Location.GET(LocCode) THEN;
        CLEAR(SalesJournalData);
        IF BlnSalesTeritory THEN
            SalesJournalData.SETFILTER(SalesJournalData.Sales_Territory, '%1', Location."Sales Territory") //MSKS
        ELSE
            SalesJournalData.SETFILTER(SalesJournalData.LocationCode, '%1', LocCode); //MSKS
        SalesJournalData.SETFILTER(PostingDateFilter, '%1..%2', FromDate, ToDate);
        SalesJournalData.OPEN;
        WHILE SalesJournalData.READ DO BEGIN
            FOR i := 1 TO 14 DO BEGIN
                IF txtFocusProdCode[i] = SalesJournalData.Goal_Sheet_Focused_Product THEN BEGIN
                    SalesQty[i] += SalesJournalData.Quantity_Base;
                    SalesData[i] += SalesJournalData.LineAmount;
                END;
            END;
        END;

        CLEAR(SalesJournalData1);
        IF BlnSalesTeritory THEN
            SalesJournalData1.SETFILTER(Sales_Territory, '%1', Location."Sales Territory") //MSKS
        ELSE
            SalesJournalData1.SETFILTER(LocationCode, '%1', LocCode); //MSKS
        //SalesJournalData1.SETFILTER(LocationCode,'%1',LocCode); //MSKS
        SalesJournalData1.SETFILTER(PostingDateFilter, '%1..%2', FromDate, ToDate);
        SalesJournalData1.OPEN;
        WHILE SalesJournalData1.READ DO BEGIN
            FOR i := 1 TO 14 DO BEGIN
                IF txtFocusProdCode[i] = SalesJournalData1.Goal_Sheet_Focused_Product THEN BEGIN
                    SalesQty[i] -= SalesJournalData1.Quantity_Base;
                    SalesData[i] -= SalesJournalData1.LineAmount;
                END;
            END;
        END;
    end;

    local procedure GetFocusStockData(LocCode: Code[20]; FromDate: Date; ToDate: Date; var StockQty: array[15] of Decimal)
    var
        ItemStock: Query "Item Stock";
    begin
        CLEAR(ItemStock);
        ItemStock.SETFILTER(ItemStock.Location_Code, '%1', LocCode);
        ItemStock.OPEN;
        WHILE ItemStock.READ DO BEGIN
            FOR i := 1 TO 14 DO BEGIN
                IF txtFocusProdCode[i] = ItemStock.Goal_Sheet_Focused_Product THEN BEGIN
                    StockQty[i] += ItemStock.Sum_Remaining_Quantity;
                    IF (ToDate - ItemStock.Posting_Date) > 180 THEN
                        AgedStock[i] += ItemStock.Sum_Remaining_Quantity;
                END;
            END;
        END;
    end;
}

