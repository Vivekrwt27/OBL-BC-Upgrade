report 50291 "Inventory Ageing -MGT size Wis"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\InventoryAgeingMGTsizeWis.rdl';

    dataset
    {
        dataitem(Location; Location)
        {
            DataItemTableView = WHERE(Depot = CONST(true));
            column(Cnt; Cnt)
            {
            }
            column(SalesGrandTotal; SalesGrandTotal)
            {
            }
            column(SalesValueFYGrandTotal; SalesValueFYGrandTotal)
            {
            }
            column(MonthlyAvgSaleGrandTotal; MonthlyAvgSaleGrandTotal)
            {
            }
            column(OpeningQtySummaryGrandTotal; OpeningQtySummaryGrandTotal)
            {
            }
            column(PurchQtySummaryGrandTotal; PurchQtySummaryGrandTotal)
            {
            }
            column(TransferQtySummaryGrandTotal; TransferQtySummaryGrandTotal)
            {
            }
            column(ASPGrandTotal; ASPGrandTotal)
            {
            }
            column(SalesQtyGrandTotal; SalesQtyGrandTotal)
            {
            }
            column(OpeningQtySummary; OpeningQtySummary)
            {
            }
            column(SDSales; DATE2DMY(SDSales, 3))
            {
            }
            column(EDSales; DATE2DMY(EDSales, 3))
            {
            }
            column(Area_Location; Location.Area)
            {
            }
            column(StartDate; FORMAT(StartDate))
            {
            }
            column(EndDate; FORMAT(EndDate))
            {
            }
            column(Month; Month)
            {
            }
            column(Year; Year)
            {
            }
            column(ASOnDate; ASOnDate)
            {
            }
            column(Location; Location.Code)
            {
            }
            column(BlnDetailed; BlnDetailed)
            {
            }
            column(SaleValue; SalesValue)
            {
            }
            column(DailyAvgSale; DailyAvgSale)
            {
            }
            column(Aread_sqft; Area)
            {
            }
            column(SaleQty; SalesQty)
            {
            }
            column(ASP; ASP)
            {
            }
            column(Sales; Sales)
            {
            }
            column(SalesValueFY; SalesValueFY)
            {
            }
            column(MonthlyAvgSale; MonthlyAvgSale)
            {
            }
            column(TransferQtySummary; TransferQtySummary)
            {
            }
            column(PurchQtySummary; PurchQtySummary)
            {
            }
            dataitem(ItemMasters; Integer)
            {
                UseTemporary = false;
                column(PurchQtyTPG; PurchQtyTPG)
                {
                }
                column(TransferQtyTPG; TransferQtyTPG)
                {
                }
                column(SalesTPG; SalesTPG)
                {
                }
                column(SaleQty2; SalesQty2)
                {
                }
                column(ASP2; ASP2)
                {
                }
                column(SaleQty1; SalesQty1)
                {
                }
                column(ASP1; ASP1)
                {
                }
                column(Sales1; Sales1)
                {
                }
                column(PurchQty; PurchQty)
                {
                }
                column(TransferQty; TransferQty)
                {
                }
                column(OpeningQtyTPG; OpeningQtyTPG)
                {
                }
                column(OpeningQty; OpeningQty)
                {
                }
                column(ItemCatCode; ItemGroupMaster.Item_Category_Code)
                {
                }
                column(TabProdGrp; ItemGroupMaster.Tableau_Product_Group)
                {
                }
                column(SizeCode; ItemGroupMaster.Size_Code)
                {
                }
                column(SizeDescCode; ItemGroupMaster.Name)
                {
                }
                dataitem(Integer; Integer)
                {
                    column(ItemNo; InventoryAgeingMGT.No)
                    {
                    }
                    column(ItemDesc; InventoryAgeingMGT.Description)
                    {
                    }
                    column(PostDate; InventoryAgeingMGT.Posting_Date)
                    {
                    }
                    column(Qty1; Qty[1])
                    {
                    }
                    column(Qty2; Qty[2])
                    {
                    }
                    column(Qty3; Qty[3])
                    {
                    }
                    column(Qty4; Qty[4])
                    {
                    }
                    column(TotQty; Qty[3] + Qty[4])
                    {
                    }
                    column(TotQty1; Qty[3] + Qty[4])
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF NOT InventoryAgeingMGT.READ THEN
                            CurrReport.BREAK;
                        /*
                          IF InventoryAgeingMGT.Posting_Date < StartDate-1 THEN
                            OpeningQty += InventoryAgeingMGT.Sum_Quantity;
                        
                        IF (SC <> InventoryAgeingMGT.Size_Code)  THEN BEGIN
                          SC := InventoryAgeingMGT.Size_Code;
                        END;
                        */

                        IF BlnDetailed = FALSE THEN BEGIN
                            CLEAR(Qty);
                            CASE ASOnDate - InventoryAgeingMGT.Posting_Date OF
                                0 .. 90:
                                    Qty[1] := InventoryAgeingMGT.Sum_Remaining_Quantity;
                                91 .. 180:
                                    Qty[2] := InventoryAgeingMGT.Sum_Remaining_Quantity;
                                181 .. 300:
                                    Qty[3] := InventoryAgeingMGT.Sum_Remaining_Quantity;
                                301 .. 999999:
                                    Qty[4] := InventoryAgeingMGT.Sum_Remaining_Quantity;
                            END;
                        END ELSE BEGIN
                            CLEAR(Qty);
                            CASE ASOnDate - InventoryAgeingMGT.Posting_Date OF
                                181 .. 300:
                                    Qty[3] := InventoryAgeingMGT.Sum_Remaining_Quantity;
                                301 .. 999999:
                                    Qty[4] := InventoryAgeingMGT.Sum_Remaining_Quantity;
                            END;
                        END;

                    end;
                }

                trigger OnAfterGetRecord()
                begin

                    IF NOT ItemGroupMaster.READ THEN
                        CurrReport.BREAK;
                    InventoryAgeingMGT.SETRANGE(InventoryAgeingMGT.Location_Code, Location.Code);
                    InventoryAgeingMGT.SETRANGE(InventoryAgeingMGT.Item_Category_Code, ItemGroupMaster.Item_Category_Code);
                    InventoryAgeingMGT.SETRANGE(InventoryAgeingMGT.Tableau_Product_Group, ItemGroupMaster.Tableau_Product_Group);
                    InventoryAgeingMGT.SETRANGE(InventoryAgeingMGT.Size_Code, ItemGroupMaster.Size_Code);
                    InventoryAgeingMGT.OPEN;
                    OpeningQty := 0;


                    CLEAR(InventoryAgeingMGTSizeWise);
                    InventoryAgeingMGTSizeWise.SETFILTER(InventoryAgeingMGTSizeWise.Location_Code, '%1', Location.Code);
                    InventoryAgeingMGTSizeWise.SETFILTER(InventoryAgeingMGTSizeWise.Size_Code, '%1', ItemGroupMaster.Size_Code);
                    InventoryAgeingMGTSizeWise.SETRANGE(InventoryAgeingMGTSizeWise.Tableau_Product_Group, ItemGroupMaster.Tableau_Product_Group); //MSAK1103
                    InventoryAgeingMGTSizeWise.SETFILTER(InventoryAgeingMGTSizeWise.Posting_Date, '%1..%2', 0D, StartDate - 1);
                    InventoryAgeingMGTSizeWise.OPEN;
                    WHILE InventoryAgeingMGTSizeWise.READ DO BEGIN
                        OpeningQty += InventoryAgeingMGTSizeWise.Sum_Quantity;
                    END;


                    CLEAR(PurchQty);
                    CLEAR(PurchaseJournalData);
                    PurchaseJournalData.SETRANGE(PurchaseJournalData.LocationCode, Location.Code);
                    ///  PurchaseJournalData.SETRANGE(PurchaseJournalData.Size_Code, ItemGroupMaster.Size_Code);
                    ///  PurchaseJournalData.SETRANGE(PurchaseJournalData.TabProdGrp, ItemGroupMaster.Tableau_Product_Group); //MSAK 1103
                    PurchaseJournalData.SETRANGE(PurchaseJournalData.PostingDate, StartDate, EndDate);
                    PurchaseJournalData.OPEN;
                    WHILE PurchaseJournalData.READ DO BEGIN
                        ///    PurchQty += PurchaseJournalData.Quantity_Base;
                    END;

                    CLEAR(TransferQty);
                    CLEAR(TransferJournalData);
                    TransferJournalData.SETRANGE(TransferJournalData.Transfer_to_Code, Location.Code);
                    TransferJournalData.SETRANGE(TransferJournalData.Size_Code, ItemGroupMaster.Size_Code);
                    TransferJournalData.SETRANGE(TransferJournalData.TabProdGrp, ItemGroupMaster.Tableau_Product_Group); //MSAK1103
                    TransferJournalData.SETRANGE(TransferJournalData.PostingDate, StartDate, EndDate);
                    TransferJournalData.OPEN;
                    WHILE TransferJournalData.READ DO BEGIN
                        TransferQty += TransferJournalData.Quantity_Base;
                    END;

                    IF BlnDetailed = TRUE THEN BEGIN
                        //      IF BlnDetailed = TRUE THEN BEGIN
                        IF TPG <> ItemGroupMaster.Tableau_Product_Group THEN BEGIN
                            TPG := ItemGroupMaster.Tableau_Product_Group;
                            OpeningQtyTPG := 0;
                            SalesQty2 := 0;
                            SalesValue2 := 0;
                            ASP2 := 0;
                            CLEAR(SalesJournalData);
                            SalesJournalData.SETRANGE(SalesJournalData.LocationCode, Location.Code);
                            SalesJournalData.SETRANGE(SalesJournalData.TabProdGrp, ItemGroupMaster.Tableau_Product_Group);
                            SalesJournalData.SETRANGE(SalesJournalData.PostingDate, StartDate, EndDate);
                            SalesJournalData.OPEN;
                            WHILE SalesJournalData.READ DO BEGIN
                                SalesQty2 += SalesJournalData.Quantity_Base;
                                SalesValue2 += SalesJournalData.LineAmount;
                            END;
                            IF SalesQty2 <> 0 THEN
                                ASP2 := SalesValue2 / SalesQty2;

                            CLEAR(InventoryAgeingMGTSizeWise);
                            InventoryAgeingMGTSizeWise.SETFILTER(InventoryAgeingMGTSizeWise.Location_Code, '%1', Location.Code);
                            InventoryAgeingMGTSizeWise.SETRANGE(InventoryAgeingMGTSizeWise.Tableau_Product_Group, ItemGroupMaster.Tableau_Product_Group); //MSAK1103
                            InventoryAgeingMGTSizeWise.SETFILTER(InventoryAgeingMGTSizeWise.Posting_Date, '%1..%2', 0D, StartDate - 1);
                            InventoryAgeingMGTSizeWise.OPEN;
                            WHILE InventoryAgeingMGTSizeWise.READ DO BEGIN
                                OpeningQtyTPG += InventoryAgeingMGTSizeWise.Sum_Quantity;
                            END;
                            //220319
                            CLEAR(PurchQtyTPG);
                            CLEAR(PurchaseJournalData);
                            PurchaseJournalData.SETRANGE(PurchaseJournalData.LocationCode, Location.Code);
                            ///    PurchaseJournalData.SETRANGE(PurchaseJournalData.TabProdGrp, ItemGroupMaster.Tableau_Product_Group);
                            PurchaseJournalData.SETRANGE(PurchaseJournalData.PostingDate, StartDate, EndDate);
                            PurchaseJournalData.OPEN;
                            WHILE PurchaseJournalData.READ DO BEGIN
                                ///     PurchQtyTPG += PurchaseJournalData.Quantity_Base;
                            END;

                            CLEAR(TransferQtyTPG);
                            CLEAR(TransferJournalData);
                            TransferJournalData.SETRANGE(TransferJournalData.Transfer_to_Code, Location.Code);
                            TransferJournalData.SETRANGE(TransferJournalData.TabProdGrp, ItemGroupMaster.Tableau_Product_Group);
                            TransferJournalData.SETRANGE(TransferJournalData.PostingDate, StartDate, EndDate);
                            TransferJournalData.OPEN;
                            WHILE TransferJournalData.READ DO BEGIN
                                TransferQtyTPG += TransferJournalData.Quantity_Base;
                            END;
                            //220319

                            SalesTPG := 0;
                            CLEAR(SalesJournalData);
                            SalesJournalData.SETRANGE(SalesJournalData.LocationCode, Location.Code);
                            SalesJournalData.SETRANGE(SalesJournalData.TabProdGrp, ItemGroupMaster.Tableau_Product_Group);
                            SalesJournalData.SETRANGE(SalesJournalData.PostingDate, SDSales, EDSales);
                            SalesJournalData.OPEN;
                            WHILE SalesJournalData.READ DO BEGIN
                                SalesTPG += SalesJournalData.Quantity_Base;
                            END;
                        END;
                        // END;

                        SalesQty1 := 0;
                        SalesValue1 := 0;
                        ASP1 := 0;
                        CLEAR(SalesJournalData);
                        SalesJournalData.SETRANGE(SalesJournalData.LocationCode, Location.Code);
                        SalesJournalData.SETRANGE(SalesJournalData.Size_Code, ItemGroupMaster.Size_Code);
                        SalesJournalData.SETRANGE(SalesJournalData.TabProdGrp, ItemGroupMaster.Tableau_Product_Group); //MSAK1103
                        SalesJournalData.SETRANGE(SalesJournalData.PostingDate, StartDate, EndDate);
                        SalesJournalData.OPEN;
                        WHILE SalesJournalData.READ DO BEGIN
                            SalesQty1 += SalesJournalData.Quantity_Base;
                            SalesValue1 += (SalesJournalData.LineAmount + SalesJournalData.System_Discount_Amount);
                        END;

                        Sales1 := 0;
                        CLEAR(SalesJournalData);
                        SalesJournalData.SETRANGE(SalesJournalData.LocationCode, Location.Code);
                        SalesJournalData.SETRANGE(SalesJournalData.Size_Code, ItemGroupMaster.Size_Code);
                        SalesJournalData.SETRANGE(SalesJournalData.TabProdGrp, ItemGroupMaster.Tableau_Product_Group);
                        SalesJournalData.SETRANGE(SalesJournalData.PostingDate, SDSales, EDSales);
                        SalesJournalData.OPEN;
                        WHILE SalesJournalData.READ DO BEGIN
                            Sales1 += SalesJournalData.Quantity_Base;
                        END;
                        IF SalesQty1 <> 0 THEN
                            ASP1 := SalesValue1 / SalesQty1;
                    END;
                    //END;
                end;

                trigger OnPreDataItem()
                begin
                    CLEAR(ItemGroupMaster);
                    CLEAR(InventoryAgeingMGT);

                    ItemGroupMaster.OPEN;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Cnt += 1;
                IF BlnDetailed = FALSE THEN BEGIN
                    SalesQty := 0;
                    SalesValue := 0;
                    ASP := 0;
                    PurchQtySummary := 0;
                    TransferQtySummary := 0;
                    CLEAR(SalesJournalData);
                    SalesJournalData.SETRANGE(SalesJournalData.LocationCode, Location.Code);
                    SalesJournalData.SETRANGE(SalesJournalData.PostingDate, StartDate, EndDate);
                    SalesJournalData.OPEN;
                    WHILE SalesJournalData.READ DO BEGIN
                        SalesQty += SalesJournalData.Quantity_Base;
                        SalesValue += SalesJournalData.LineAmount;
                        IF SalesQty <> 0 THEN
                            ASP := SalesValue / SalesQty;
                    END;
                    ASPGrandTotal += ASP;//220319
                    SalesQtyGrandTotal += SalesQty;//220319

                    Sales := 0;
                    SalesValueFY := 0;
                    MonthlyAvgSale := 0;
                    CLEAR(SalesJournalData);
                    SalesJournalData.SETRANGE(SalesJournalData.LocationCode, Location.Code);
                    SalesJournalData.SETRANGE(SalesJournalData.PostingDate, SDSales, EDSales);
                    SalesJournalData.OPEN;
                    WHILE SalesJournalData.READ DO BEGIN
                        Sales += SalesJournalData.Quantity_Base;
                        SalesValueFY += SalesJournalData.LineAmount;
                    END;
                    MonthlyAvgSale := (Sales / Mnth) * 30;
                    SalesGrandTotal += Sales; //220319
                    SalesValueFYGrandTotal += SalesValueFY;
                    MonthlyAvgSaleGrandTotal += MonthlyAvgSale;

                    CLEAR(OpeningQtySummary);
                    CLEAR(InventoryAgeingMGTSizeWise);
                    InventoryAgeingMGTSizeWise.SETFILTER(InventoryAgeingMGTSizeWise.Location_Code, '%1', Location.Code);
                    InventoryAgeingMGTSizeWise.SETFILTER(InventoryAgeingMGTSizeWise.Posting_Date, '%1..%2', 0D, StartDate - 1);
                    InventoryAgeingMGTSizeWise.OPEN;
                    WHILE InventoryAgeingMGTSizeWise.READ DO BEGIN
                        OpeningQtySummary += InventoryAgeingMGTSizeWise.Sum_Quantity;
                    END;
                    OpeningQtySummaryGrandTotal += OpeningQtySummary;//220319
                    CLEAR(PurchQtySummary);
                    CLEAR(PurchaseJournalData);
                    PurchaseJournalData.SETRANGE(PurchaseJournalData.LocationCode, Location.Code);
                    PurchaseJournalData.SETRANGE(PurchaseJournalData.PostingDate, StartDate, EndDate);
                    PurchaseJournalData.OPEN;
                    WHILE PurchaseJournalData.READ DO BEGIN
                        ///   PurchQtySummary += PurchaseJournalData.Quantity_Base;
                    END;
                    PurchQtySummaryGrandTotal += PurchQtySummary; //220319

                    CLEAR(TransferQtySummary);
                    CLEAR(TransferJournalData);
                    TransferJournalData.SETRANGE(TransferJournalData.Transfer_to_Code, Location.Code);
                    TransferJournalData.SETRANGE(TransferJournalData.PostingDate, StartDate, EndDate);
                    TransferJournalData.OPEN;
                    WHILE TransferJournalData.READ DO BEGIN
                        TransferQtySummary += TransferJournalData.Quantity_Base;
                    END;
                    TransferQtySummaryGrandTotal += TransferQtySummary;//220319
                END;
            end;

            trigger OnPreDataItem()
            begin
                CLEAR(SalesGrandTotal);
                CLEAR(SalesValueFYGrandTotal);
                CLEAR(MonthlyAvgSaleGrandTotal);
                CLEAR(OpeningQtySummaryGrandTotal);
                CLEAR(PurchQtySummaryGrandTotal);
                CLEAR(TransferQtySummaryGrandTotal);
                CLEAR(ASPGrandTotal);
                CLEAR(SalesQtyGrandTotal);
                CLEAR(Cnt);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(Detailed; BlnDetailed)
                    {
                        ApplicationArea = All;
                    }
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

    trigger OnInitReport()
    begin
        //BlnDetailed := TRUE;//
        ASOnDate := TODAY - 1;

        EndDate := CALCDATE('+CM', ASOnDate);
        StartDate := CALCDATE('-CM', ASOnDate);
        IF (DATE2DMY(TODAY, 2) < 4) THEN BEGIN
            SDSales := DMY2DATE(1, 4, DATE2DMY(ASOnDate, 3) - 1);
            EDSales := DMY2DATE(31, 3, DATE2DMY(ASOnDate, 3));
        END ELSE BEGIN
            SDSales := DMY2DATE(1, 4, DATE2DMY(ASOnDate, 3));
            EDSales := DMY2DATE(31, 3, DATE2DMY(ASOnDate, 3) + 1);
        END;
        Mnth := ROUND((ASOnDate - SDSales), 1.0, '>');
    end;

    var
        ASOnDate: Date;
        YearStartDDate: Date;
        YearEndDate: Date;
        InventoryAgeingMGT: Query "Inventory Ageing MGT_50291";
        Qty: array[4] of Decimal;
        BlnDetailed: Boolean;
        MonthlyAvgSale: Decimal;
        ASP: Decimal;
        SalesJournalData: Query "Sales Journal Data_R50291";
        SalesQty: Decimal;
        SalesValue: Decimal;
        Days: Integer;
        Mnth: Decimal;
        ItemCode: Code[20];
        DailyAvgSale: Decimal;
        day: Integer;
        Year: Integer;
        Month: Text[20];
        StartDate: Date;
        EndDate: Date;
        ItemLedgerEntry: Record "Item Ledger Entry";
        OpeningQty: Decimal;
        PurchaseJournalData: Query "Purchase Journal Data";
        PurchQty: Decimal;
        TransferJournalData: Query "Transfer Journal Data";
        TransferQty: Decimal;
        amt: Decimal;
        SC: Code[10];
        ASP1: Decimal;
        SalesQty1: Decimal;
        SalesValue1: Decimal;
        InventoryAgeingMGTSizeWise: Query "Inventory Ageing MGT Size Wise";
        SC1: Code[10];
        InventoryAgeingMGTSizeWise1: Query "Inventory Ageing MGT Size Wise";
        SalesQty2: Decimal;
        SalesValue2: Decimal;
        ASP2: Decimal;
        TPG: Code[20];
        SDSales: Date;
        EDSales: Date;
        Sales: Decimal;
        Sales1: Decimal;
        SalesValueFY: Decimal;
        SalesTPG: Decimal;
        ItemGroupMaster: Query "Item Group Master";
        OpeningQtyTPG: Decimal;
        OpeningQtySummary: Decimal;
        PurchQtySummary: Decimal;
        TransferQtySummary: Decimal;
        SalesGrandTotal: Decimal;
        SalesValueFYGrandTotal: Decimal;
        MonthlyAvgSaleGrandTotal: Decimal;
        OpeningQtySummaryGrandTotal: Decimal;
        PurchQtySummaryGrandTotal: Decimal;
        TransferQtySummaryGrandTotal: Decimal;
        ASPGrandTotal: Decimal;
        SalesQtyGrandTotal: Decimal;
        PurchQtyTPG: Decimal;
        TransferQtyTPG: Decimal;
        Cnt: Integer;

    local procedure GetSalesValue(AreaCode: Code[10]; Sdate: Date; Edate: Date; var SalesQty: Decimal; var SalesValue: Decimal; HVP: Boolean)
    var
        SalesDataMGT: Query "Sales Data -MGT";
    begin
        CLEAR(SalesDataMGT);
        IF AreaCode <> '' THEN
            IF AreaCode <> 'CKA' THEN BEGIN
                SalesDataMGT.SETFILTER(SalesDataMGT.CustomerTypeFilter, '<>%1&<>%2&<>%3', 'MISC.', 'CKA', 'DIRECTPROJ');
                SalesDataMGT.SETFILTER(SalesDataMGT.AreaFilter, AreaCode);
            END ELSE BEGIN
                SalesDataMGT.SETFILTER(SalesDataMGT.CustomerTypeFilter, '%1|%2|%3', 'MISC.', 'CKA', 'DIRECTPROJ');
            END;
        SalesDataMGT.SETRANGE(SalesDataMGT.PostDateFilter, Sdate, Edate);
        IF HVP THEN
            SalesDataMGT.SETRANGE(SalesDataMGT.HVPFilter, TRUE);
        SalesDataMGT.OPEN;
        WHILE SalesDataMGT.READ DO BEGIN
            SalesValue += SalesDataMGT.Sum_Line_Amount;
            SalesQty += SalesDataMGT.Sum_Quantity_Base;
        END;
    end;


    procedure SetValues(BlnLocalDetail: Boolean)
    begin
        BlnDetailed := BlnLocalDetail;
    end;
}

