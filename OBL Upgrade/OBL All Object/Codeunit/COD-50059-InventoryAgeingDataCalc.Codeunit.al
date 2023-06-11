codeunit 50059 "Inventory Ageing Data Calc."
{

    trigger OnRun()
    begin
        // ASonDate := 300622D;
        ASonDate := CALCDATE('-CM', (TODAY() - 1));
        MonthStDate := CALCDATE('-CM', ASonDate);
        MonthEndDate := CALCDATE('CM', ASonDate);
        //ERROR('%1-%2',MonthStDate,MonthEndDate);
        PeriodTxt := FORMAT(FORMAT(ASonDate, 0, '<Month Text>') + '-' + FORMAT(DATE2DMY(ASonDate, 3)));
        MonthNumber := DATE2DMY(ASonDate, 2);

        InventoryReportAgeingData.RESET;
        InventoryReportAgeingData.SETFILTER(SuggestedResponse, '%1', PeriodTxt);
        IF InventoryReportAgeingData.FINDFIRST THEN
            InventoryReportAgeingData.DELETEALL;

        GenerateData;
    end;

    var
        Item: Record Item;
        CalculateInventory: Query "Calculate Entry Inventory";
        ASonDate: Date;
        MonthStDate: Date;
        MonthEndDate: Date;
        PeriodTxt: Code[20];
        InventoryReportAgeingData: Record "EYAIM_ERP 108DFs Report";
        MonthNumber: Integer;
        i: Integer;

    local procedure GenerateData()
    var
        Inv: Decimal;
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemApplicationEntry: Record "Item Application Entry";
        PriorPeriodStockSales: Decimal;
        StockItemLedgerEntry: Record "Item Ledger Entry";
        SalesReturnQty: Decimal;
        ExcessSalesOrverCurrProd: Decimal;
    begin
        CalculateInventory.SETFILTER(CalculateInventory.Posting_Date, '%1..%2', MonthStDate, MonthEndDate);
        CalculateInventory.OPEN;
        WHILE CalculateInventory.READ DO BEGIN
            IF InventoryReportAgeingData.GET(PeriodTxt, CalculateInventory.No) THEN BEGIN
                //    InventoryReportAgeingData.DELETE;
                //    InventoryReportAgeingData.INIT;
                CASE CalculateInventory.Entry_Type OF
                    CalculateInventory.Entry_Type::"Negative Adjmt.", CalculateInventory.Entry_Type::"Positive Adjmt.":
                        BEGIN
                            // 15578    InventoryReportAgeingData."CGST(PR)" += -1 * (CalculateInventory.Sum_Quantity);
                        END;
                    CalculateInventory.Entry_Type::Purchase, CalculateInventory.Entry_Type::Output, CalculateInventory.Entry_Type::Transfer,
                    CalculateInventory.Entry_Type::Consumption:
                        BEGIN
                            // 15578    InventoryReportAgeingData."TaxableValue(2A)" += (CalculateInventory.Sum_Quantity);
                            IF (CalculateInventory.Mfg_Batch_No = 'M') THEN BEGIN
                                // 15578     InventoryReportAgeingData."Recon Generated Date" += CalculateInventory.Sum_Quantity;
                            END;
                        END;
                    CalculateInventory.Entry_Type::Sale:
                        BEGIN
                            // 15578  InventoryReportAgeingData."CGST(PR)" += -1 * (CalculateInventory.Sum_Quantity);
                            // 15578  InventoryReportAgeingData."BillOfEntry(PR)" += -1 * (CalculateInventory.Sum_Quantity);
                        END;
                END;
                InventoryReportAgeingData."TaxPeriod-GSTR 3B" := CalculateInventory.No;
                //Keshav>>
                IF CalculateInventory.Item_Category_Code = 'H001' THEN
                    InventoryReportAgeingData.MatchReason := 'Hoskote'
                ELSE
                    IF CalculateInventory.Item_Category_Code = 'D001' THEN
                        InventoryReportAgeingData.MatchReason := 'Dora'
                    ELSE
                        IF CalculateInventory.Item_Category_Code = 'M001' THEN
                            InventoryReportAgeingData.MatchReason := 'Sikandrabad'
                        ELSE
                            InventoryReportAgeingData.MatchReason := '';

                InventoryReportAgeingData.VendorRiskCategory := 'MonthNumber';
                //Keshav<<

                InventoryReportAgeingData.SuggestedResponse := PeriodTxt;
                InventoryReportAgeingData."TaxPeriod(2A)" := CalculateInventory.Size_Code_Desc;
                InventoryReportAgeingData.MODIFY;
            END ELSE BEGIN
                InventoryReportAgeingData.INIT;
                CASE CalculateInventory.Entry_Type OF
                    CalculateInventory.Entry_Type::"Negative Adjmt.", CalculateInventory.Entry_Type::"Positive Adjmt.":
                        BEGIN
                            // 15578      InventoryReportAgeingData."CGST(PR)" += -1 * CalculateInventory.Sum_Quantity;
                        END;
                    CalculateInventory.Entry_Type::Purchase, CalculateInventory.Entry_Type::Output, CalculateInventory.Entry_Type::Consumption:
                        BEGIN
                            // 15578    InventoryReportAgeingData."TaxableValue(2A)" += CalculateInventory.Sum_Quantity;
                            IF (CalculateInventory.Mfg_Batch_No = 'M') THEN BEGIN
                                // 15578      InventoryReportAgeingData."Recon Generated Date" += CalculateInventory.Sum_Quantity;
                            END;
                        END;
                    CalculateInventory.Entry_Type::Sale:
                        BEGIN
                            // 15578    InventoryReportAgeingData."CGST(PR)" += -1 * CalculateInventory.Sum_Quantity;
                            // 15578     InventoryReportAgeingData."BillOfEntry(PR)" += -1 * CalculateInventory.Sum_Quantity;
                        END;
                END;
                InventoryReportAgeingData."TaxPeriod-GSTR 3B" := CalculateInventory.No;
                //Keshav>>
                IF CalculateInventory.Item_Category_Code = 'H001' THEN
                    InventoryReportAgeingData.MatchReason := 'Hoskote'
                ELSE
                    IF CalculateInventory.Item_Category_Code = 'D001' THEN
                        InventoryReportAgeingData.MatchReason := 'Dora'
                    ELSE
                        IF CalculateInventory.Item_Category_Code = 'M001' THEN
                            InventoryReportAgeingData.MatchReason := 'Sikandrabad'
                        ELSE
                            InventoryReportAgeingData.MatchReason := '';

                InventoryReportAgeingData.VendorRiskCategory := 'MonthNumber';
                //Keshav<<
                InventoryReportAgeingData.SuggestedResponse := PeriodTxt;
                InventoryReportAgeingData."TaxPeriod(2A)" := CalculateInventory.Size_Code_Desc;
                InventoryReportAgeingData.INSERT;
            END;

        END;

        Item.RESET;
        Item.SETFILTER("Item Category Code", '%1|%2|%3', 'M001', 'D001', 'H001');
        Item.SETFILTER(Blocked, '%1', FALSE);
        Item.SETFILTER("Quality Code", '%1', '1');
        Item.SETFILTER("Manuf. Strategy", '%1|%2', Item."Manuf. Strategy"::"Make-to-Stock", Item."Manuf. Strategy"::MTO);
        IF Item.FINDFIRST THEN BEGIN
            REPEAT
                Inv := 0;
                IF InventoryReportAgeingData.GET(PeriodTxt, Item."No.") THEN BEGIN
                    CalculateInventory.SETFILTER(CalculateInventory.No, '%1', Item."No.");
                    CalculateInventory.SETFILTER(CalculateInventory.Posting_Date, '%1..%2', 0D, MonthStDate - 1);
                    CalculateInventory.OPEN;
                    WHILE CalculateInventory.READ DO BEGIN
                        Inv += CalculateInventory.Sum_Quantity;
                    END;
                    //    InventoryReportAgeingData."DocumentNumber(PR)" := Inv;
                    //     InventoryReportAgeingData."GSTR3B-FilingStatus" := InventoryReportAgeingData."DocumentNumber(PR)" + InventoryReportAgeingData."TaxableValue(2A)" - InventoryReportAgeingData."CGST(PR)";
                    InventoryReportAgeingData.MODIFY;
                END ELSE BEGIN
                    InventoryReportAgeingData.INIT;
                    InventoryReportAgeingData.VendorRiskCategory := 'MonthNumber';//Keshav
                    InventoryReportAgeingData.SuggestedResponse := PeriodTxt;
                    InventoryReportAgeingData."TaxPeriod-GSTR 3B" := Item."No.";
                    InventoryReportAgeingData."TaxPeriod(2A)" := Item."Size Code Desc.";//Keshav
                    CalculateInventory.SETFILTER(CalculateInventory.No, '%1', Item."No.");
                    CalculateInventory.SETFILTER(CalculateInventory.Posting_Date, '%1..%2', 0D, MonthStDate - 1);
                    CalculateInventory.OPEN;
                    WHILE CalculateInventory.READ DO BEGIN
                        Inv += CalculateInventory.Sum_Quantity;
                    END;
                    //    InventoryReportAgeingData."DocumentNumber(PR)" := Inv;
                    //    InventoryReportAgeingData."GSTR3B-FilingStatus" := InventoryReportAgeingData."DocumentNumber(PR)" + InventoryReportAgeingData."TaxableValue(2A)" - InventoryReportAgeingData."CGST(PR)";

                    //Keshav>>
                    IF Item."Item Category Code" = 'H001' THEN
                        InventoryReportAgeingData.MatchReason := 'Hoskote'
                    ELSE
                        IF Item."Item Category Code" = 'D001' THEN
                            InventoryReportAgeingData.MatchReason := 'Dora'
                        ELSE
                            IF Item."Item Category Code" = 'M001' THEN
                                InventoryReportAgeingData.MatchReason := 'Sikandrabad'
                            ELSE
                                InventoryReportAgeingData.MatchReason := '';
                    //Keshav<<

                    //    InventoryReportAgeingData."Reverse Integrated Date" := CalculateProjectSales(InventoryReportAgeingData."TaxPeriod-GSTR 3B");
                    InventoryReportAgeingData.INSERT;
                END;
            UNTIL Item.NEXT = 0;
        END;


        InventoryReportAgeingData.RESET;
        InventoryReportAgeingData.SETFILTER(SuggestedResponse, '%1', PeriodTxt);
        //   InventoryReportAgeingData.SETFILTER("BillOfEntry(PR)", '<>%1', 0);
        IF InventoryReportAgeingData.FINDFIRST THEN BEGIN
            REPEAT
                PriorPeriodStockSales := 0;
                SalesReturnQty := 0;
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETCURRENTKEY("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
                ItemLedgerEntry.SETFILTER("Item No.", '%1', InventoryReportAgeingData."TaxPeriod-GSTR 3B");
                ItemLedgerEntry.SETFILTER("Entry Type", '%1', ItemLedgerEntry."Entry Type"::Sale);
                ItemLedgerEntry.SETFILTER("Posting Date", '%1..%2', MonthStDate, MonthEndDate);
                IF ItemLedgerEntry.FINDFIRST THEN BEGIN
                    REPEAT
                        IF ItemLedgerEntry.Quantity < 0 THEN BEGIN
                            ItemApplicationEntry.RESET;
                            ItemApplicationEntry.SETCURRENTKEY("Item Ledger Entry No.", "Output Completely Invd. Date");
                            ItemApplicationEntry.SETFILTER("Item Ledger Entry No.", '%1', ItemLedgerEntry."Entry No.");
                            IF ItemApplicationEntry.FINDFIRST THEN BEGIN
                                REPEAT
                                    IF StockItemLedgerEntry.GET(ItemApplicationEntry."Inbound Item Entry No.") THEN
                                        IF StockItemLedgerEntry."Posting Date" < MonthStDate THEN
                                            PriorPeriodStockSales += ItemApplicationEntry.Quantity;
                                UNTIL ItemApplicationEntry.NEXT = 0;
                            END;
                        END;
                        IF ItemLedgerEntry.Quantity > 0 THEN
                            SalesReturnQty += ItemLedgerEntry.Quantity;
                    UNTIL ItemLedgerEntry.NEXT = 0;
                END;

                //     InventoryReportAgeingData.SourceIdentifier := -1 * PriorPeriodStockSales;
                //    InventoryReportAgeingData."SupplyType(PR)" := SalesReturnQty;
                // Current Month Prod. Sales -  Prod Qty. > 0
                /*
                  ExcessSalesOrverCurrProd := 0;

                  ExcessSalesOrverCurrProd := (InventoryReportAgeingData."Sales Qty.(Incl. Return)") - (InventoryReportAgeingData."Sales Qty.(Incl. Return)" -InventoryReportAgeingData."Prior Month Stock Sales") ;

                  IF ExcessSalesOrverCurrProd >0  THEN BEGIN
                      InventoryReportAgeingData."Prior Month Stock Sales" -= ExcessSalesOrverCurrProd;
                  END;  */
                InventoryReportAgeingData.MODIFY;
            UNTIL InventoryReportAgeingData.NEXT = 0;
        END;

    end;

    local procedure CalculateProjectSales(ItemNo: Code[20]) Qty: Decimal
    var
        SalesJournalData: Query "Sales Journal Data";
    begin
        CLEAR(SalesJournalData);
        SalesJournalData.SETFILTER(SalesJournalData.Tableau_Zone1, 'CKA');
        SalesJournalData.SETFILTER(SalesJournalData.ItemNo, ItemNo);
        SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', MonthStDate, MonthEndDate);
        SalesJournalData.OPEN;
        WHILE SalesJournalData.READ DO BEGIN
            Qty += SalesJournalData.Quantity_in_Sq_Mt;
        END;
        EXIT(Qty);
    end;
}

