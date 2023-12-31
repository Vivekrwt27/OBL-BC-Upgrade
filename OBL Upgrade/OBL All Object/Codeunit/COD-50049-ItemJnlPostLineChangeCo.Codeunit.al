codeunit 50049 "Item Jnl.-Post Line-Change Co."
{
    Permissions = TableData Item = imd,
                  TableData "Item Ledger Entry" = imd,
                  TableData "Item Register" = imd,
                  TableData "Phys. Inventory Ledger Entry" = imd,
                  TableData "Item Application Entry" = imd,
                  TableData "Dimension Set ID Filter Line" = imd,
                  TableData "Prod. Order Capacity Need" = imd,
                  TableData "Stockkeeping Unit" = imd,
                  TableData "Value Entry" = imd,
                  TableData "Avg. Cost Adjmt. Entry Point" = rim,
                  TableData "Post Value Entry to G/L" = ri,
                  TableData "Capacity Ledger Entry" = imd,
                  TableData "Inventory Adjmt. Entry (Order)" = rim;
    TableNo = "Item Journal Line";

    trigger OnRun()
    begin
        IF ChangeToCompany = '' THEN
            ChangeToCompany := 'Associate Vendors-Morbi';
        Rec.CHANGECOMPANY(ChangeToCompany);
        GetGLSetup;
        RunWithCheck(Rec);
    end;

    var
        Text000: Label 'cannot be less than zero';
        Text001: Label 'Item Tracking is signed wrongly.';
        Text003: Label 'Reserved item %1 is not on inventory.';
        Text004: Label 'is too low';
        Text011: Label 'Tracking Specification is missing.';
        Text012: Label 'Item %1 must be reserved on Line No.%2';
        Text014: Label 'Serial No. %1 is already on inventory.';
        SerialNoRequiredErr: Label 'You must assign a serial number for item %1.', Comment = '%1 - Item No.';
        LotNoRequiredErr: Label 'You must assign a lot number for item %1.', Comment = '%1 - Item No.';
        LineNoTxt: Label ' Line No. = ''%1''.', Comment = '%1 - Line No.';
        Text017: Label ' is before the posting date.';
        Text018: Label 'Item Tracking Serial No. %1 Lot No. %2 for Item No. %3 Variant %4 cannot be fully applied.';
        Text021: Label 'You must not define item tracking on %1 %2.';
        Text022: Label 'You cannot apply %1 to %2 on the same item %3 on Production Order %4.';
        Text100: Label 'Fatal error when retrieving Tracking Specification.';
        Text99000000: Label 'must not be filled out when reservations exist';
        GLSetup: Record "General Ledger Setup";
        Currency: Record Currency;
        InvtSetup: Record "Inventory Setup";
        MfgSetup: Record "Manufacturing Setup";
        Location: Record Location;
        NewLocation: Record Location;
        Item: Record Item;
        GlobalItemLedgEntry: Record "Item Ledger Entry";
        OldItemLedgEntry: Record "Item Ledger Entry";
        ItemReg: Record "Item Register";
        ItemJnlLine: Record "Item Journal Line";
        ItemJnlLineOrigin: Record "Item Journal Line";
        SourceCodeSetup: Record "Source Code Setup";
        GenPostingSetup: Record "General Posting Setup";
        ItemApplnEntry: Record "Item Application Entry";
        GlobalValueEntry: Record "Value Entry";
        DirCostValueEntry: Record "Value Entry";
        SKU: Record "Stockkeeping Unit";
        CurrExchRate: Record "Currency Exchange Rate";
        ItemTrackingCode: Record "Item Tracking Code";
        TempSplitItemJnlLine: Record "Item Journal Line" temporary;
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        TempValueEntryRelation: Record "Value Entry Relation" temporary;
        TempItemEntryRelation: Record "Item Entry Relation" temporary;
        WhseJnlLine: Record "Warehouse Journal Line";
        TouchedItemLedgerEntries: Record "Item Ledger Entry" temporary;
        TempItemApplnEntryHistory: Record "Item Application Entry History" temporary;
        PrevAppliedItemLedgEntry: Record "Item Ledger Entry";
        WMSMgmt: Codeunit "WMS Management";
        WhseJnlPostLine: Codeunit "Whse. Jnl.-Register Line";
        ItemJnlCheckLine: Codeunit "Item Jnl.-Check Line";
        ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
        ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
        ReserveProdOrderComp: Codeunit "Prod. Order Comp.-Reserve";
        ReserveProdOrderLine: Codeunit "Prod. Order Line-Reserve";
        JobPlanningLineReserve: Codeunit "Job Planning Line-Reserve";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        InvtPost: Codeunit "Inventory Posting To G/L";
        CostCalcMgt: Codeunit "Cost Calculation Management";
        ACYMgt: Codeunit "Additional-Currency Management";
        // 15578    ExciseInsertRGRegisters: Codeunit "Excise Insert RG Registers";
        ItemLedgEntryNo: Integer;
        PhysInvtEntryNo: Integer;
        CapLedgEntryNo: Integer;
        ValueEntryNo: Integer;
        ItemApplnEntryNo: Integer;
        TotalAppliedQty: Decimal;
        OverheadAmount: Decimal;
        VarianceAmount: Decimal;
        OverheadAmountACY: Decimal;
        VarianceAmountACY: Decimal;
        QtyPerUnitOfMeasure: Decimal;
        RoundingResidualAmount: Decimal;
        RoundingResidualAmountACY: Decimal;
        InvtSetupRead: Boolean;
        GLSetupRead: Boolean;
        MfgSetupRead: Boolean;
        SKUExists: Boolean;
        AverageTransfer: Boolean;
        SNRequired: Boolean;
        LotRequired: Boolean;
        PostponeReservationHandling: Boolean;
        VarianceRequired: Boolean;
        LastOperation: Boolean;
        DisableItemTracking: Boolean;
        CalledFromInvtPutawayPick: Boolean;
        CalledFromAdjustment: Boolean;
        PostToGL: Boolean;
        PostItemJnlLine: Boolean;
        ProdOrderCompModified: Boolean;
        Text023: Label 'Entries applied to an Outbound Transfer cannot be unapplied.';
        Text024: Label 'Entries applied to a Drop Shipment Order cannot be unapplied.';
        Text025: Label 'Entries applied to a Correction entry cannot be unapplied.';
        IsServUndoConsumption: Boolean;
        Text027: Label 'A fixed application was not unapplied and this prevented the reapplication. Use the Application Worksheet to remove the applications.';
        Text01: Label 'Checking for open entries.';
        Text029: Label '%1 %2 for %3 %4 is reserved for %5.';
        BlockRetrieveIT: Boolean;
        Text030: Label 'The quantity that you are trying to invoice is larger than the quantity in the item ledger with the entry number %1.';
        Text031: Label 'You cannot invoice the item %1 with item tracking number %2 %3 in this purchase order before the associated sales order %4 has been invoiced.', Comment = '%2 = Lot No. %3 = Serial No. Both are tracking numbers.';
        Text032: Label 'You cannot invoice item %1 in this purchase order before the associated sales order %2 has been invoiced.';
        Text16500: Label 'This transaction can not be posted because %1 is not a testing location.';
        Text16501: Label 'This transaction can not be posted because %1 & %2, both are testing locations.';
        Text16502: Label 'The Goods can not be transferred because %1 is a testing location and %2 is a Non-testing location.';
        Text16503: Label 'This transaction can not be posted because %1 & %2, both are Non-testing locations.';
        Text16504: Label 'This transaction can not be posted because the transfer is not for laboratory test.';
        Text16505: Label 'This transaction can not be posted because the transfer is for laboratory test.';
        // 15578   ECCNos: Record "13708";
        DetailedTaxEntryNo: Integer;
        MainComponentEntryNo: Integer;
        DocumentNo: Code[20];
        DocumentLineNo: Integer;
        SubconValue: Boolean;
        CalledFromSubconConsumption: Boolean;
        BEDAmt: Decimal;
        AEDGSIAmt: Decimal;
        AEDTTAAmt: Decimal;
        SEDAmt: Decimal;
        SAEDAmt: Decimal;
        CESSAmt: Decimal;
        NCCDAmt: Decimal;
        eCessAmt: Decimal;
        SHECessAmt: Decimal;
        ADETAmt: Decimal;
        ADEAmt: Decimal;
        ADCVATAmt: Decimal;
        ExciseBaseAmt: Decimal;
        ExciseAmt: Decimal;
        Text033: Label 'Quantity must be -1, 0 or 1 when Serial No. is stated.';
        ItemMas: Record Item;
        RecInbound: Integer;
        RecOutBound: Integer;
        RecItemLedger: Integer;
        RecTransferentry: Integer;
        "...tri1": Integer;
        ItemNo1: Code[20];
        TypeCode: Code[2];
        SizeCode: Code[3];
        PlantCode: Code[1];
        PackingCode: Code[2];
        DesignCode: Code[4];
        ColorCode: Code[4];
        QualityCode: Code[1];
        LocationRec: Record Location;
        ItemNo: Code[20];
        CheckiTemLed: Record "Item Ledger Entry";
        AfterCheckItemLed: Record "Item Ledger Entry";
        UpdatePlantCode: Report "Update Production Plant code";
        ProdOrder: Record "Production Order";
        OutPutLineNo: Integer;
        ConsLineNo: Integer;
        ProdJournal: Page "Production Journal";
        vItemJnlLine: Record "Item Journal Line";
        RecItemJournal: Record "Item Journal Line";
        tgAutomaticRPO: Record "Automatic RPO";
        MftgSetup: Record "Manufacturing Setup";
        CheckCount: Boolean;
        RecProductionOrder: Record "Production Order";
        Text0001: Label 'The quantity in Inventory is not sufficient to cover the net change in inventory in Line # %1.';
        Text0002: Label 'The quantity is not sufficient to cover the net change in Inventory in Line # %1 on date %2.';
        tgText001: Label 'Quanity in Cartoon %1 should not be in fraction.';
        SkipApplicationCheck: Boolean;
        CalledFromApplicationWorksheet: Boolean;
        ChangeToCompany: Text;


    procedure RunWithCheck(var ItemJnlLine2: Record "Item Journal Line"): Boolean
    var
        PostItemJnlLine: Boolean;
    begin
        ItemJnlLine.CHANGECOMPANY(ChangeToCompany);
        ItemJnlLine.COPY(ItemJnlLine2);

        PostItemJnlLine := SetupSplitJnlLine(ItemJnlLine2);
        IF NOT PostItemJnlLine THEN
            PostItemJnlLine := IsNotInternalWhseMovement(ItemJnlLine2);

        WHILE SplitJnlLine(ItemJnlLine, PostItemJnlLine) DO
            IF PostItemJnlLine THEN
                Code;
        ItemJnlLine2 := ItemJnlLine;
        //CorrectOutputValuationDate(GlobalItemLedgEntry);
        //RedoApplications;

        EXIT(PostItemJnlLine);
    end;

    local procedure "Code"()
    begin
        OnBeforePostItemJnlLine(ItemJnlLine);
        GlobalItemLedgEntry.CHANGECOMPANY(ChangeToCompany);
        Item.CHANGECOMPANY(ChangeToCompany);
        ItemJnlLine.CHANGECOMPANY(ChangeToCompany);
        WITH ItemJnlLine DO BEGIN
            IF EmptyLine AND NOT Correction AND NOT Adjustment THEN
                IF NOT IsValueEntryForDeletedItem THEN
                    EXIT;

            IF "Document Date" = 0D THEN
                "Document Date" := "Posting Date";

            IF ItemLedgEntryNo = 0 THEN BEGIN
                GlobalItemLedgEntry.LOCKTABLE;
                IF GlobalItemLedgEntry.FINDLAST THEN
                    ItemLedgEntryNo := GlobalItemLedgEntry."Entry No.";
            END;
            InitValueEntryNo;
            GetInvtSetup;
            IF NOT CalledFromAdjustment THEN
                PostToGL := InvtSetup."Automatic Cost Posting";
            IF SubconValue THEN BEGIN
                IF (SNRequired OR LotRequired) AND ("Quantity (Base)" <> 0) AND
                   ("Value Entry Type" = "Value Entry Type"::"Direct Cost") AND
                   NOT DisableItemTracking AND NOT Adjustment AND NOT IsServUndoConsumption AND
                   NOT IsAssemblyResourceConsumpLine
                THEN
                    CheckItemTracking;
            END ELSE
                IF (SNRequired OR LotRequired) AND ("Quantity (Base)" <> 0) AND
                   ("Value Entry Type" = "Value Entry Type"::"Direct Cost") AND
                   NOT DisableItemTracking AND NOT Adjustment AND
                   NOT Subcontracting AND NOT IsAssemblyResourceConsumpLine
                THEN
                    CheckItemTracking;

            IF Correction THEN
                UndoQuantityPosting;

            GenPostingSetup.CHANGECOMPANY(ChangeToCompany);
            IF ("Gen. Bus. Posting Group" <> GenPostingSetup."Gen. Bus. Posting Group") OR
               ("Gen. Prod. Posting Group" <> GenPostingSetup."Gen. Prod. Posting Group")
            THEN
                GenPostingSetup.GET("Gen. Bus. Posting Group", "Gen. Prod. Posting Group");

            IF "Qty. per Unit of Measure" = 0 THEN
                "Qty. per Unit of Measure" := 1;
            IF "Qty. per Cap. Unit of Measure" = 0 THEN
                "Qty. per Cap. Unit of Measure" := 1;

            Quantity := "Quantity (Base)";
            "Invoiced Quantity" := "Invoiced Qty. (Base)";
            "Setup Time" := "Setup Time (Base)";
            "Run Time" := "Run Time (Base)";
            "Stop Time" := "Stop Time (Base)";
            "Output Quantity" := "Output Quantity (Base)";
            "Scrap Quantity" := "Scrap Quantity (Base)";

            IF NOT Subcontracting AND
               (("Entry Type" = "Entry Type"::Output) OR
                IsAssemblyResourceConsumpLine)
            THEN
                QtyPerUnitOfMeasure := "Qty. per Cap. Unit of Measure"
            ELSE
                QtyPerUnitOfMeasure := "Qty. per Unit of Measure";

            RoundingResidualAmount := 0;
            RoundingResidualAmountACY := 0;
            Item.CHANGECOMPANY(ChangeToCompany);
            IF "Value Entry Type" = "Value Entry Type"::Revaluation THEN
                IF Item.GET("Item No.") AND (Item."Costing Method" = Item."Costing Method"::Average) THEN BEGIN
                    RoundingResidualAmount := Quantity *
                      ("Unit Cost" - ROUND("Unit Cost" / QtyPerUnitOfMeasure, GLSetup."Unit-Amount Rounding Precision"));
                    RoundingResidualAmountACY := Quantity *
                      ("Unit Cost (ACY)" - ROUND("Unit Cost (ACY)" / QtyPerUnitOfMeasure, Currency."Unit-Amount Rounding Precision"));
                    IF ABS(RoundingResidualAmount) < GLSetup."Amount Rounding Precision" THEN
                        RoundingResidualAmount := 0;
                    IF ABS(RoundingResidualAmountACY) < Currency."Amount Rounding Precision" THEN
                        RoundingResidualAmountACY := 0;
                END;

            "Unit Amount" := ROUND(
                "Unit Amount" / QtyPerUnitOfMeasure, GLSetup."Unit-Amount Rounding Precision");
            "Unit Cost" := ROUND(
                "Unit Cost" / QtyPerUnitOfMeasure, GLSetup."Unit-Amount Rounding Precision");
            "Unit Cost (ACY)" := ROUND(
                "Unit Cost (ACY)" / QtyPerUnitOfMeasure, Currency."Unit-Amount Rounding Precision");

            OverheadAmount := 0;
            VarianceAmount := 0;
            OverheadAmountACY := 0;
            VarianceAmountACY := 0;
            VarianceRequired := FALSE;
            LastOperation := FALSE;

            CASE TRUE OF
                IsAssemblyResourceConsumpLine:
                    PostAssemblyResourceConsump;
                Adjustment,
              "Value Entry Type" IN ["Value Entry Type"::Rounding, "Value Entry Type"::Revaluation],
              "Entry Type" = "Entry Type"::"Assembly Consumption",
              "Entry Type" = "Entry Type"::"Assembly Output":
                    PostItem;
                "Entry Type" = "Entry Type"::Consumption:
                    PostConsumption;
                "Entry Type" = "Entry Type"::Output:
                    PostOutput;
                NOT Correction:
                    PostItem;
            END;

            // Entry no. is returned to shipment/receipt
            IF Subcontracting THEN
                "Item Shpt. Entry No." := CapLedgEntryNo
            ELSE
                "Item Shpt. Entry No." := GlobalItemLedgEntry."Entry No.";
        END;
        OnAfterPostItemJnlLine(ItemJnlLine);
    end;

    local procedure PostConsumption()
    var
        ProdOrderComp: Record "Prod. Order Component";
        TempHandlingSpecification: Record "Tracking Specification" temporary;
        RemQtyToPost: Decimal;
        RemQtyToPostThisLine: Decimal;
        QtyToPost: Decimal;
        UseItemTrackingApplication: Boolean;
        LastLoop: Boolean;
        EndLoop: Boolean;
        NewRemainingQty: Decimal;
    begin
        WITH ProdOrderComp DO BEGIN
            ItemJnlLine.TESTFIELD("Order Type", ItemJnlLine."Order Type"::Production);
            SETCURRENTKEY(Status, "Prod. Order No.", "Prod. Order Line No.", "Item No.", "Line No.");
            SETRANGE(Status, Status::Released);
            SETRANGE("Prod. Order No.", ItemJnlLine."Order No.");
            SETRANGE("Prod. Order Line No.", ItemJnlLine."Order Line No.");
            SETRANGE("Item No.", ItemJnlLine."Item No.");
            IF ItemJnlLine."Prod. Order Comp. Line No." <> 0 THEN
                SETRANGE("Line No.", ItemJnlLine."Prod. Order Comp. Line No.");
            LOCKTABLE;

            RemQtyToPost := ItemJnlLine.Quantity;

            IF FINDSET THEN BEGIN
                IF ItemJnlLine.TrackingExists AND NOT BlockRetrieveIT THEN
                    UseItemTrackingApplication :=
                      ItemTrackingMgt.RetrieveConsumpItemTracking(ItemJnlLine, TempHandlingSpecification);

                IF UseItemTrackingApplication THEN BEGIN
                    TempHandlingSpecification.SETRANGE("Serial No.", ItemJnlLine."Serial No.");
                    TempHandlingSpecification.SETRANGE("Lot No.", ItemJnlLine."Lot No.");
                    LastLoop := FALSE;
                END ELSE
                    IF ReservationExists(ItemJnlLine) THEN BEGIN
                        IF SNRequired AND (ItemJnlLine."Serial No." = '') THEN
                            ERROR(SerialNoRequiredErr, ItemJnlLine."Item No.");
                        IF LotRequired AND (ItemJnlLine."Lot No." = '') THEN
                            ERROR(LotNoRequiredErr, ItemJnlLine."Item No.");
                    END;

                REPEAT
                    IF UseItemTrackingApplication THEN BEGIN
                        TempHandlingSpecification.SETRANGE("Source Ref. No.", "Line No.");
                        IF LastLoop THEN BEGIN
                            RemQtyToPostThisLine := "Remaining Qty. (Base)";
                            IF TempHandlingSpecification.FINDSET THEN
                                REPEAT
                                    CheckItemTrackingOfComp(TempHandlingSpecification, ItemJnlLine);
                                    RemQtyToPostThisLine += TempHandlingSpecification."Qty. to Handle (Base)";
                                UNTIL TempHandlingSpecification.NEXT = 0;
                            IF RemQtyToPostThisLine * RemQtyToPost < 0 THEN
                                ERROR(Text001); // Assertion: Test signing
                        END ELSE BEGIN
                            IF TempHandlingSpecification.FINDFIRST THEN BEGIN
                                RemQtyToPostThisLine := -TempHandlingSpecification."Qty. to Handle (Base)";
                                TempHandlingSpecification.DELETE;
                            END ELSE BEGIN
                                TempHandlingSpecification.SETRANGE("Serial No.");
                                TempHandlingSpecification.SETRANGE("Lot No.");
                                TempHandlingSpecification.FINDFIRST;
                                CheckItemTrackingOfComp(TempHandlingSpecification, ItemJnlLine);
                                RemQtyToPostThisLine := 0;
                            END;
                        END;
                        IF RemQtyToPostThisLine > RemQtyToPost THEN
                            RemQtyToPostThisLine := RemQtyToPost;
                    END ELSE BEGIN
                        RemQtyToPostThisLine := RemQtyToPost;
                        LastLoop := TRUE;
                    END;

                    QtyToPost := RemQtyToPostThisLine;
                    CALCFIELDS("Act. Consumption (Qty)");
                    NewRemainingQty := "Expected Qty. (Base)" - "Act. Consumption (Qty)" - QtyToPost;
                    NewRemainingQty := ROUND(NewRemainingQty, 0.00001);
                    IF (NewRemainingQty * "Expected Qty. (Base)") <= 0 THEN BEGIN
                        QtyToPost := "Remaining Qty. (Base)";
                        "Remaining Qty. (Base)" := 0;
                    END ELSE BEGIN
                        IF ("Remaining Qty. (Base)" * "Expected Qty. (Base)") >= 0 THEN
                            QtyToPost := "Remaining Qty. (Base)" - NewRemainingQty
                        ELSE
                            QtyToPost := NewRemainingQty;
                        "Remaining Qty. (Base)" := NewRemainingQty;
                    END;

                    "Remaining Quantity" := ROUND("Remaining Qty. (Base)" / "Qty. per Unit of Measure", 0.00001);

                    IF QtyToPost <> 0 THEN BEGIN
                        RemQtyToPost := RemQtyToPost - QtyToPost;
                        MODIFY;
                        Item.CHANGECOMPANY(ChangeToCompany);
                        Item.GET(ItemJnlLine."Item No.");
                        //15578 InsertRGRegisters;
                        IF ProdOrderCompModified THEN
                            InsertConsumpEntry(ProdOrderComp, "Line No.", QtyToPost, FALSE)
                        ELSE
                            InsertConsumpEntry(ProdOrderComp, "Line No.", QtyToPost, TRUE);
                    END ELSE
                        // 15578   InsertRGRegisters;
                        IF UseItemTrackingApplication THEN BEGIN
                            IF NEXT = 0 THEN BEGIN
                                EndLoop := LastLoop;
                                LastLoop := TRUE;
                                FINDFIRST;
                                TempHandlingSpecification.RESET;
                            END;
                        END ELSE
                            EndLoop := NEXT = 0;

                UNTIL EndLoop OR (RemQtyToPost = 0);
            END ELSE
                //15578   InsertRGRegisters;
                IF RemQtyToPost <> 0 THEN
                    InsertConsumpEntry(ProdOrderComp, ItemJnlLine."Prod. Order Comp. Line No.", RemQtyToPost, FALSE);
        END;
        ProdOrderCompModified := FALSE;
    end;


    procedure PostOutput()
    var
        MfgItem: Record Item;
        MfgSKU: Record "Stockkeeping Unit";
        MachCenter: Record "Machine Center";
        WorkCenter: Record "Work Center";
        CapLedgEntry: Record "Capacity Ledger Entry";
        ProdOrder: Record "Production Order";
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderRtngLine: Record "Prod. Order Routing Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        DirCostAmt: Decimal;
        IndirCostAmt: Decimal;
        ValuedQty: Decimal;
        MfgUnitCost: Decimal;
        ReTrack: Boolean;
        RecItemJournal: Record "Item Journal Line";
        ErrText001: Label 'Please Check the Lot No.Lot No. must be %1.';
    begin
        WITH ItemJnlLine DO BEGIN
            IF "Stop Time" <> 0 THEN BEGIN
                InsertCapLedgEntry(CapLedgEntry, "Stop Time", "Stop Time");
                IF OnlyStopTime THEN
                    EXIT;
            END;

            IF OutputValuePosting THEN BEGIN
                PostItem;
                EXIT;
            END;

            IF Subcontracting THEN
                ValuedQty := "Invoiced Quantity"
            ELSE
                ValuedQty := CalcCapQty;
            Item.CHANGECOMPANY(ChangeToCompany);
            IF Item.GET("Item No.") THEN
                IF NOT CalledFromAdjustment THEN
                    Item.TESTFIELD("Inventory Value Zero", FALSE);

            IF "Item Shpt. Entry No." <> 0 THEN
                CapLedgEntry.GET("Item Shpt. Entry No.")
            ELSE BEGIN
                TESTFIELD("Order Type", "Order Type"::Production);
                ProdOrder.GET(ProdOrder.Status::Released, "Order No.");
                ProdOrder.TESTFIELD(Blocked, FALSE);
                ProdOrderLine.LOCKTABLE;
                ProdOrderLine.GET(ProdOrder.Status::Released, "Order No.", "Order Line No.");

                "Inventory Posting Group" := ProdOrderLine."Inventory Posting Group";

                ProdOrderRtngLine.SETRANGE(Status, ProdOrderRtngLine.Status::Released);
                ProdOrderRtngLine.SETRANGE("Prod. Order No.", "Order No.");
                ProdOrderRtngLine.SETRANGE("Routing Reference No.", "Routing Reference No.");
                ProdOrderRtngLine.SETRANGE("Routing No.", "Routing No.");
                IF ProdOrderRtngLine.FINDFIRST THEN BEGIN
                    TESTFIELD("Operation No.");
                    TESTFIELD("No.");

                    IF Type = Type::"Machine Center" THEN BEGIN
                        MachCenter.GET("No.");
                        MachCenter.TESTFIELD(Blocked, FALSE);
                    END;
                    WorkCenter.GET("Work Center No.");
                    WorkCenter.TESTFIELD(Blocked, FALSE);

                    ApplyCapNeed("Setup Time (Base)", "Run Time (Base)");
                END;

                IF "Operation No." <> '' THEN BEGIN
                    ProdOrderRtngLine.GET(
                      ProdOrderRtngLine.Status::Released, "Order No.",
                      "Routing Reference No.", "Routing No.", "Operation No.");
                    IF Finished THEN
                        ProdOrderRtngLine."Routing Status" := ProdOrderRtngLine."Routing Status"::Finished
                    ELSE
                        ProdOrderRtngLine."Routing Status" := ProdOrderRtngLine."Routing Status"::"In Progress";
                    LastOperation := (NOT NextOperationExist(ProdOrderRtngLine));
                    ProdOrderRtngLine.MODIFY;
                END ELSE
                    LastOperation := TRUE;

                IF Subcontracting THEN
                    InsertCapLedgEntry(CapLedgEntry, Quantity, "Invoiced Quantity")
                ELSE
                    InsertCapLedgEntry(CapLedgEntry, ValuedQty, ValuedQty);

                IF "Output Quantity" > 0 THEN
                    FlushOperation(ProdOrder, ProdOrderLine);
            END;

            CalcDirAndIndirCostAmts(DirCostAmt, IndirCostAmt, ValuedQty, "Unit Cost", "Indirect Cost %", "Overhead Rate");

            InsertCapValueEntry(CapLedgEntry, "Value Entry Type"::"Direct Cost".AsInteger(), ValuedQty, ValuedQty, DirCostAmt);
            InsertCapValueEntry(CapLedgEntry, "Value Entry Type"::"Indirect Cost".AsInteger(), ValuedQty, 0, IndirCostAmt);

            IF LastOperation AND ("Output Quantity" <> 0) THEN BEGIN
                CheckItemTracking;
                IF ("Output Quantity" < 0) AND NOT Adjustment THEN BEGIN
                    TESTFIELD("Applies-to Entry");
                    ItemLedgerEntry.CHANGECOMPANY(ChangeToCompany);
                    ItemLedgerEntry.GET("Applies-to Entry");
                    TESTFIELD("Lot No.", ItemLedgerEntry."Lot No.");
                    TESTFIELD("Serial No.", ItemLedgerEntry."Serial No.");
                END;
                MfgItem.CHANGECOMPANY(ChangeToCompany);
                MfgItem.GET(ProdOrderLine."Item No.");
                MfgItem.TESTFIELD("Gen. Prod. Posting Group");

                IF NOT Subcontracting THEN BEGIN
                    IF MfgSKU.GET(ProdOrderLine."Location Code", ProdOrderLine."Item No.", ProdOrderLine."Variant Code") THEN
                        MfgUnitCost := MfgSKU."Unit Cost"
                    ELSE
                        MfgUnitCost := MfgItem."Unit Cost";
                    Amount := "Output Quantity" * MfgUnitCost;
                END;

                "Amount (ACY)" := ACYMgt.CalcACYAmt(Amount, "Posting Date", FALSE);
                "Gen. Bus. Posting Group" := ProdOrder."Gen. Bus. Posting Group";
                "Gen. Prod. Posting Group" := MfgItem."Gen. Prod. Posting Group";
                /*  IF Location.GET("Location Code") THEN
                      IF ECCNos.GET(Location."E.C.C. No.") THEN;
                  IF ECCNos."Type of Unit" = ECCNos."Type of Unit"::Manufacturer THEN
                      ExciseInsertRGRegisters.UpdateRT12ProdOutput(ItemJnlLine, "Output Quantity")
                  ELSE
                      IF ECCNos."Type of Unit" = ECCNos."Type of Unit"::"100% EOU" THEN
                          ExciseInsertRGRegisters.UpdateER2ProdOutput(ItemJnlLine, "Output Quantity");*/ // 15578
                IF "Output Quantity (Base)" * ProdOrderLine."Remaining Qty. (Base)" <= 0 THEN
                    ReTrack := TRUE
                ELSE
                    IF NOT CalledFromInvtPutawayPick THEN
                        ReserveProdOrderLine.TransferPOLineToItemJnlLine(
                          ProdOrderLine, ItemJnlLine, "Output Quantity (Base)");

                GetLocation("Location Code");
                IF Location."Bin Mandatory" AND (NOT CalledFromInvtPutawayPick) THEN BEGIN
                    WMSMgmt.CreateWhseJnlLineFromOutputJnl(ItemJnlLine, WhseJnlLine);
                    WMSMgmt.CheckWhseJnlLine(WhseJnlLine, 2, 0, FALSE);
                END;

                Description := ProdOrderLine.Description;
                IF Subcontracting THEN BEGIN
                    "Document Type" := "Document Type"::" ";
                    "Document No." := "Order No.";
                    "Document Line No." := 0;
                    "Invoiced Quantity" := 0;
                END;
                PostItem;
                UpdateProdOrderLine(ProdOrderLine, ReTrack);
                IF Location."Bin Mandatory" AND (NOT CalledFromInvtPutawayPick) THEN
                    WhseJnlPostLine.RUN(WhseJnlLine);



                //TRI S.R 18.02.10 - New Code Add Start
                /*ItemMas.GET("Item No.");
                IF ItemMas."Item Tracking Code" <> '' THEN
                   IF RecItemJournal.TGLotNoChange(ItemJnlLine) <> "Lot No." THEN
                    ERROR(ErrText001,RecItemJournal.TGLotNoChange(ItemJnlLine));*/

                //TRI-VKG ADD START
                MftgSetup.GET;
                MftgSetup.TESTFIELD(MftgSetup."Output Batch Name");
                MftgSetup.TESTFIELD(MftgSetup."Consumption Batch Name");
                //TRI-VKG ADD END

                IF "Commercial Quantity" <> 0 THEN BEGIN
                    ItemMas.GET("Item No.");
                    ItemMas.TESTFIELD(Premium, TRUE);
                    ItemMas.TESTFIELD(Commercial);
                    CreateRealeseProdOrder("Commercial Quantity", ItemMas.Commercial, "Order No.", "Location Code"
                                           , "Commercial Varient", "Posting Date", ItemJnlLine);
                END;
                IF "Economic Quantity" <> 0 THEN BEGIN
                    ItemMas.GET("Item No.");
                    ItemMas.TESTFIELD(Premium, TRUE);
                    ItemMas.TESTFIELD(Economic);
                    IF GUIALLOWED THEN MESSAGE('%1', ItemMas.Economic);
                    CreateRealeseProdOrder("Economic Quantity", ItemMas.Economic, "Order No.", "Location Code"
                                           , "Economic Varient", "Posting Date", ItemJnlLine);
                END;
                IF "Broken Tiles Quantity" <> 0 THEN BEGIN
                    ItemMas.GET("Item No.");
                    ItemMas.TESTFIELD(Premium, TRUE);
                    ItemMas.TESTFIELD("Broken Tiles");
                    CreateRealeseProdOrder("Broken Tiles Quantity", ItemMas."Broken Tiles", "Order No.", "Location Code"
                                           , "Broken Tiles Varient", "Posting Date", ItemJnlLine);

                END;
                //TRI S.R 18.02.10 - New Code Add Stop
            END;
        END;

    end;


    procedure PostItem()
    var
        MSErr0001: Label 'Item No %1 , Line No %2 discoutinued , Please contact to Costing Department.';
    begin
        SKU.CHANGECOMPANY(ChangeToCompany);
        Item.CHANGECOMPANY(ChangeToCompany);
        MfgSetup.CHANGECOMPANY(ChangeToCompany);

        WITH ItemJnlLine DO BEGIN
            SKUExists := SKU.GET("Location Code", "Item No.", "Variant Code");
            IF "Item Shpt. Entry No." <> 0 THEN BEGIN
                "Location Code" := '';
                "Variant Code" := '';
            END;
            IF Item.GET("Item No.") THEN BEGIN
                IF NOT CalledFromAdjustment THEN
                    IF (UPPERCASE(USERID) <> 'IT005') AND (UPPERCASE(USERID) <> 'ADMIN') THEN
                        Item.TESTFIELD(Blocked, FALSE);

                //MSBS.Rao Begin Dt. 11-04-13
                MfgSetup.CHANGECOMPANY(ChangeToCompany);
                MfgSetup.GET;
                IF MfgSetup."Allow Discoutinued" THEN BEGIN
                    IF ItemJnlLine."Document Type" <> ItemJnlLine."Document Type"::"Purchase Invoice" THEN
                        IF "Entry Type" IN ["Entry Type"::Purchase, "Entry Type"::Output] THEN
                            IF Item."Inventory Posting Group" IN ['MANUF', 'TRAD'] THEN
                                IF NOT Item.Retained THEN
                                    ERROR(MSErr0001, Item."No.", ItemJnlLine."Document Line No.");
                END;
                //MSBS.Rao End Dt. 11-04-13

                Item.CheckBlockedByApplWorksheet;
            END;

            IF ("Inventory Posting Group" = '') AND (Item.Type = Item.Type::Inventory) THEN BEGIN
                Item.TESTFIELD("Inventory Posting Group");
                "Inventory Posting Group" := Item."Inventory Posting Group";
            END;

            IF ("Entry Type" = "Entry Type"::Transfer) AND
               (Item."Costing Method" = Item."Costing Method"::Average) AND
               ("Applies-to Entry" = 0)
            THEN BEGIN
                AverageTransfer := TRUE;
                TotalAppliedQty := 0;
            END ELSE
                AverageTransfer := FALSE;

            IF Item."Costing Method" = Item."Costing Method"::Standard THEN BEGIN
                "Overhead Rate" := Item."Overhead Rate";
                "Indirect Cost %" := Item."Indirect Cost %";
            END;

            IF ("Value Entry Type" <> "Value Entry Type"::"Direct Cost") OR
               ("Item Charge No." <> '')
            THEN BEGIN
                "Overhead Rate" := 0;
                "Indirect Cost %" := 0;
            END;
            IF (Quantity <> 0) AND
               ("Item Charge No." = '') AND
               NOT ("Value Entry Type" IN ["Value Entry Type"::Revaluation, "Value Entry Type"::Rounding]) AND
               NOT Adjustment
            THEN
                ItemQtyPosting
            ELSE BEGIN
                IF ("Invoiced Quantity" <> 0) OR Adjustment OR
                   IsInterimRevaluation
                THEN BEGIN
                    IF "Value Entry Type" = "Value Entry Type"::"Direct Cost" THEN
                        GlobalItemLedgEntry.GET("Item Shpt. Entry No.")
                    ELSE
                        GlobalItemLedgEntry.GET("Applies-to Entry");
                    CorrectOutputValuationDate(GlobalItemLedgEntry);
                    InitValueEntry(GlobalValueEntry, GlobalItemLedgEntry);
                END;
            END;
            IF (Quantity <> 0) OR ("Invoiced Quantity" <> 0) THEN
                ItemValuePosting;
            /* IF "Entry Type" = "Entry Type"::Transfer THEN
                ItemJnlLine. "Transfer Cost" := GlobalValueEntry."Cost Amount (Actual)";*/ // 15578

            //UpdateUnitCost(GlobalValueEntry);
        END;
    end;

    local procedure InsertConsumpEntry(var ProdOrderComp: Record "Prod. Order Component"; ProdOrderCompLineNo: Integer; QtyBase: Decimal; ModifyProdOrderComp: Boolean)
    var
        PostWhseJnlLine: Boolean;
    begin
        WITH ItemJnlLine DO BEGIN
            //TRI
            IF CheckCount = TRUE THEN
                EXIT;
            //TRI
            Quantity := QtyBase;
            "Quantity (Base)" := QtyBase;
            "Invoiced Quantity" := QtyBase;
            "Invoiced Qty. (Base)" := QtyBase;
            "Prod. Order Comp. Line No." := ProdOrderCompLineNo;
            IF ModifyProdOrderComp THEN BEGIN
                IF NOT CalledFromInvtPutawayPick THEN
                    ReserveProdOrderComp.TransferPOCompToItemJnlLine(ProdOrderComp, ItemJnlLine, QtyBase);
                ProdOrderComp.MODIFY;
            END;

            IF "Value Entry Type" <> "Value Entry Type"::Revaluation THEN BEGIN
                GetLocation("Location Code");
                IF Location."Bin Mandatory" AND (NOT CalledFromInvtPutawayPick) THEN BEGIN
                    WMSMgmt.CreateWhseJnlLineFromConsumJnl(ItemJnlLine, WhseJnlLine);
                    WMSMgmt.CheckWhseJnlLine(WhseJnlLine, 3, 0, FALSE);
                    PostWhseJnlLine := TRUE;
                END;
            END;
        END;

        PostItem;
        IF PostWhseJnlLine THEN
            WhseJnlPostLine.RUN(WhseJnlLine);


        //TRI
        IF RecProductionOrder.GET(RecProductionOrder.Status::Released, ItemJnlLine."Order No.") THEN
            IF RecProductionOrder."Original Prod. No" <> '' THEN
                CheckCount := TRUE;
        //TRI
    end;

    local procedure CalcCapQty() CapQty: Decimal
    begin
        GetMfgSetup;

        WITH ItemJnlLine DO BEGIN
            IF "Unit Cost Calculation" = "Unit Cost Calculation"::Time THEN BEGIN
                IF MfgSetup."Cost Incl. Setup" THEN
                    CapQty := "Setup Time" + "Run Time"
                ELSE
                    CapQty := "Run Time";
            END ELSE
                CapQty := Quantity + "Scrap Quantity";
        END;
    end;

    local procedure CalcDirAndIndirCostAmts(var DirCostAmt: Decimal; var IndirCostAmt: Decimal; CapQty: Decimal; UnitCost: Decimal; IndirCostPct: Decimal; OvhdRate: Decimal)
    var
        CostAmt: Decimal;
    begin
        CostAmt := ROUND(CapQty * UnitCost);
        DirCostAmt := ROUND((CostAmt - CapQty * OvhdRate) / (1 + IndirCostPct / 100));
        IndirCostAmt := CostAmt - DirCostAmt;
    end;

    local procedure ApplyCapNeed(PostedSetupTime: Decimal; PostedRunTime: Decimal)
    var
        ProdOrderCapNeed: Record "Prod. Order Capacity Need";
        Qty: Decimal;
    begin
        WITH ItemJnlLine DO BEGIN
            ProdOrderCapNeed.LOCKTABLE;
            ProdOrderCapNeed.RESET;
            ProdOrderCapNeed.SETCURRENTKEY(
              Status, "Prod. Order No.", "Routing Reference No.", "Operation No.", Date, "Starting Time");
            ProdOrderCapNeed.SETRANGE(Status, ProdOrderCapNeed.Status::Released);
            ProdOrderCapNeed.SETRANGE("Prod. Order No.", "Order No.");
            ProdOrderCapNeed.SETRANGE("Requested Only", FALSE);
            ProdOrderCapNeed.SETRANGE("Routing No.", "Routing No.");
            ProdOrderCapNeed.SETRANGE("Routing Reference No.", "Routing Reference No.");
            ProdOrderCapNeed.SETRANGE("Operation No.", "Operation No.");

            IF Finished THEN
                ProdOrderCapNeed.MODIFYALL("Allocated Time", 0)
            ELSE BEGIN
                IF PostedSetupTime <> 0 THEN BEGIN
                    // 15578    ProdOrderCapNeed.SETRANGE("Time Type", ProdOrderCapNeed."Time Type"::Setup);
                    IF ProdOrderCapNeed.FINDSET THEN
                        REPEAT
                            IF ProdOrderCapNeed."Allocated Time" > PostedSetupTime THEN
                                Qty := PostedSetupTime
                            ELSE
                                Qty := ProdOrderCapNeed."Allocated Time";
                            ProdOrderCapNeed."Allocated Time" :=
                              ProdOrderCapNeed."Allocated Time" - Qty;
                            ProdOrderCapNeed.MODIFY;
                            PostedSetupTime := PostedSetupTime - Qty;
                        UNTIL (ProdOrderCapNeed.NEXT = 0) OR (PostedSetupTime = 0);
                END;

                IF PostedRunTime <> 0 THEN BEGIN
                    // 15578    ProdOrderCapNeed.SETRANGE("Time Type", ProdOrderCapNeed."Time Type"::Run);
                    IF ProdOrderCapNeed.FINDSET THEN
                        REPEAT
                            IF ProdOrderCapNeed."Allocated Time" > PostedRunTime THEN
                                Qty := PostedRunTime
                            ELSE
                                Qty := ProdOrderCapNeed."Allocated Time";
                            ProdOrderCapNeed."Allocated Time" :=
                              ProdOrderCapNeed."Allocated Time" - Qty;
                            ProdOrderCapNeed.MODIFY;
                            PostedRunTime := PostedRunTime - Qty;
                        UNTIL (ProdOrderCapNeed.NEXT = 0) OR (PostedRunTime = 0);
                END;
            END;
        END;
    end;

    local procedure UpdateProdOrderLine(var ProdOrderLine: Record "Prod. Order Line"; ReTrack: Boolean)
    var
        ReservMgt: Codeunit "Reservation Management";
    begin
        WITH ProdOrderLine DO BEGIN
            IF ItemJnlLine."Output Quantity (Base)" > "Remaining Qty. (Base)" THEN
                ReserveProdOrderLine.AssignForPlanning(ProdOrderLine);
            "Finished Qty. (Base)" := "Finished Qty. (Base)" + ItemJnlLine."Output Quantity (Base)";
            "Finished Quantity" := "Finished Qty. (Base)" / "Qty. per Unit of Measure";
            IF "Finished Qty. (Base)" < 0 THEN
                FIELDERROR("Finished Quantity", Text000);
            "Remaining Qty. (Base)" := "Quantity (Base)" - "Finished Qty. (Base)";
            IF "Remaining Qty. (Base)" < 0 THEN
                "Remaining Qty. (Base)" := 0;
            "Remaining Quantity" := "Remaining Qty. (Base)" / "Qty. per Unit of Measure";
            MODIFY;

        END;
    end;

    local procedure InsertCapLedgEntry(var CapLedgEntry: Record "Capacity Ledger Entry"; Qty: Decimal; InvdQty: Decimal)
    var
        RecItem: Record Item;
    begin
        WITH ItemJnlLine DO BEGIN
            IF CapLedgEntryNo = 0 THEN BEGIN
                CapLedgEntry.LOCKTABLE;
                IF CapLedgEntry.FINDLAST THEN
                    CapLedgEntryNo := CapLedgEntry."Entry No.";
            END;

            CapLedgEntryNo := CapLedgEntryNo + 1;

            CapLedgEntry.INIT;
            CapLedgEntry."Entry No." := CapLedgEntryNo;

            CapLedgEntry."Operation No." := "Operation No.";
            CapLedgEntry.Type := Type;
            CapLedgEntry."No." := "No.";
            CapLedgEntry.Description := Description;
            CapLedgEntry."Work Center No." := "Work Center No.";
            CapLedgEntry."Work Center Group Code" := "Work Center Group Code";
            CapLedgEntry.Subcontracting := Subcontracting;

            CapLedgEntry.Quantity := Qty;
            CapLedgEntry."Invoiced Quantity" := InvdQty;
            CapLedgEntry."Completely Invoiced" := CapLedgEntry."Invoiced Quantity" = CapLedgEntry.Quantity;

            CapLedgEntry."Setup Time" := "Setup Time";
            CapLedgEntry."Run Time" := "Run Time";
            CapLedgEntry."Stop Time" := "Stop Time";

            IF "Unit Cost Calculation" = "Unit Cost Calculation"::Time THEN BEGIN
                CapLedgEntry."Cap. Unit of Measure Code" := "Cap. Unit of Measure Code";
                CapLedgEntry."Qty. per Cap. Unit of Measure" := "Qty. per Cap. Unit of Measure";
            END;

            //TRI S.R 04.03.10 - New code Add Start
            RecItem.CHANGECOMPANY(ChangeToCompany);
            IF RecItem.GET("Item No.") THEN BEGIN
                CapLedgEntry.Commercial := RecItem.Commercial;
                CapLedgEntry.Economic := RecItem.Economic;
                CapLedgEntry."Broken Tiles" := RecItem."Broken Tiles";
            END;
            CapLedgEntry."Commercial Quantity" := "Commercial Quantity";
            CapLedgEntry."Economic Quantity" := "Economic Quantity";
            CapLedgEntry."Broken Tiles Quantity" := "Broken Tiles Quantity";
            CapLedgEntry."Gross Weight" := "Gross Weight";
            CapLedgEntry."Net Weight" := "Net Weight";
            //TRI S.R 04.03.10 - New code Add Stop

            CapLedgEntry."Production Order Comp Line No." := "Prod. Order Comp. Line No.";   //TRI DG 040910

            CapLedgEntry."Item No." := "Item No.";
            CapLedgEntry."Variant Code" := "Variant Code";
            CapLedgEntry."Output Quantity" := "Output Quantity";
            CapLedgEntry."Scrap Quantity" := "Scrap Quantity";
            CapLedgEntry."Unit of Measure Code" := "Unit of Measure Code";
            CapLedgEntry."Qty. per Unit of Measure" := "Qty. per Unit of Measure";

            CapLedgEntry."Order Type" := "Order Type";
            CapLedgEntry."Order No." := "Order No.";
            CapLedgEntry."Order Line No." := "Order Line No.";
            CapLedgEntry."Routing No." := "Routing No.";
            CapLedgEntry."Routing Reference No." := "Routing Reference No.";
            CapLedgEntry."Operation No." := "Operation No.";

            CapLedgEntry."Posting Date" := "Posting Date";
            CapLedgEntry."Document Date" := "Document Date";
            CapLedgEntry."Document No." := "Document No.";
            CapLedgEntry."External Document No." := "External Document No.";

            CapLedgEntry."Starting Time" := "Starting Time";
            CapLedgEntry."Ending Time" := "Ending Time";
            CapLedgEntry."Concurrent Capacity" := "Concurrent Capacity";
            CapLedgEntry."Work Shift Code" := "Work Shift Code";

            CapLedgEntry."Stop Code" := "Stop Code";
            CapLedgEntry."Scrap Code" := "Scrap Code";
            CapLedgEntry."Last Output Line" := LastOperation;

            CapLedgEntry."Global Dimension 1 Code" := "Shortcut Dimension 1 Code";
            CapLedgEntry."Global Dimension 2 Code" := "Shortcut Dimension 2 Code";
            CapLedgEntry."Dimension Set ID" := "Dimension Set ID";

            CapLedgEntry.INSERT;

            InsertItemReg(0, 0, 0, CapLedgEntry."Entry No.");
        END;
    end;

    local procedure InsertCapValueEntry(var CapLedgEntry: Record "Capacity Ledger Entry"; ValueEntryType: Option; ValuedQty: Decimal; InvdQty: Decimal; AdjdCost: Decimal)
    var
        ValueEntry: Record "Value Entry";
    begin
        WITH ItemJnlLine DO BEGIN
            IF (InvdQty = 0) AND (AdjdCost = 0) THEN
                EXIT;

            ValueEntryNo := ValueEntryNo + 1;

            ValueEntry.INIT;
            ValueEntry."Entry No." := ValueEntryNo;
            ValueEntry."Capacity Ledger Entry No." := CapLedgEntry."Entry No.";
            ValueEntry."Entry Type" := ValueEntryType;
            ValueEntry."Item Ledger Entry Type" := ValueEntry."Item Ledger Entry Type"::" ";

            ValueEntry.Type := Type;
            ValueEntry."No." := "No.";
            ValueEntry.Description := Description;
            ValueEntry."Order Type" := "Order Type";
            ValueEntry."Order No." := "Order No.";
            ValueEntry."Order Line No." := "Order Line No.";
            ValueEntry."Source Type" := "Source Type";
            ValueEntry."Source No." := GetSourceNo(ItemJnlLine);
            ValueEntry."Invoiced Quantity" := InvdQty;
            ValueEntry."Valued Quantity" := ValuedQty;

            ValueEntry."Cost Amount (Actual)" := AdjdCost;
            ValueEntry."Cost Amount (Actual) (ACY)" := ACYMgt.CalcACYAmt(AdjdCost, "Posting Date", FALSE);
            ValueEntry."Cost per Unit" :=
              CalcCostPerUnit(ValueEntry."Cost Amount (Actual)", ValueEntry."Valued Quantity", FALSE);
            ValueEntry."Cost per Unit (ACY)" :=
              CalcCostPerUnit(ValueEntry."Cost Amount (Actual) (ACY)", ValueEntry."Valued Quantity", TRUE);
            ValueEntry.Inventoriable := TRUE;

            IF Type = Type::Resource THEN
                TESTFIELD("Inventory Posting Group", '')
            ELSE
                TESTFIELD("Inventory Posting Group");
            ValueEntry."Inventory Posting Group" := "Inventory Posting Group";
            ValueEntry."Gen. Bus. Posting Group" := "Gen. Bus. Posting Group";
            ValueEntry."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";

            ValueEntry."Posting Date" := "Posting Date";
            ValueEntry."Valuation Date" := "Posting Date";
            ValueEntry."Source No." := GetSourceNo(ItemJnlLine);
            ValueEntry."Document Type" := "Document Type";
            IF ValueEntry."Expected Cost" OR ("Invoice No." = '') THEN
                ValueEntry."Document No." := "Document No."
            ELSE BEGIN
                ValueEntry."Document No." := "Invoice No.";
                IF "Document Type" IN
                   ["Document Type"::"Purchase Receipt", "Document Type"::"Purchase Return Shipment",
                    "Document Type"::"Sales Shipment", "Document Type"::"Sales Return Receipt",
                    "Document Type"::"Service Shipment"]
                THEN
                    ValueEntry."Document Type" := "Document Type" + 1;
            END;
            ValueEntry."Document Line No." := "Document Line No.";
            ValueEntry."Document Date" := "Document Date";
            ValueEntry."External Document No." := "External Document No.";
            ValueEntry."User ID" := USERID;
            ValueEntry."Source Code" := "Source Code";
            ValueEntry."Reason Code" := "Reason Code";
            ValueEntry."Journal Batch Name" := "Journal Batch Name";

            ValueEntry."Global Dimension 1 Code" := "Shortcut Dimension 1 Code";
            ValueEntry."Global Dimension 2 Code" := "Shortcut Dimension 2 Code";
            ValueEntry."Dimension Set ID" := "Dimension Set ID";

            ValueEntry."Machine Code" := "Machine Code";//SHAKTI
                                                        /*
                                                        InvtPost.SetRunOnlyCheck(TRUE,NOT InvtSetup."Automatic Cost Posting",FALSE);
                                                        IF InvtPost.BufferInvtPosting(ValueEntry) THEN
                                                          InvtPost.PostInvtPostBufPerEntry(ValueEntry);
                                                          */
            ValueEntry.INSERT(TRUE);

            //UpdateAdjmtProp(ValueEntry,CapLedgEntry."Posting Date");

            InsertItemReg(0, 0, ValueEntry."Entry No.", 0);
            //InsertPostValueEntryToGL(ValueEntry);
            IF Item."Item Tracking Code" <> '' THEN BEGIN
                TempValueEntryRelation.CHANGECOMPANY(ChangeToCompany);
                TempValueEntryRelation.INIT;
                TempValueEntryRelation."Value Entry No." := ValueEntry."Entry No.";
                TempValueEntryRelation.INSERT;
            END;
            IF ("Item Shpt. Entry No." <> 0) AND
               (ValueEntryType = "Value Entry Type"::"Direct Cost")
            THEN BEGIN
                CapLedgEntry."Invoiced Quantity" := CapLedgEntry."Invoiced Quantity" + "Invoiced Quantity";
                IF Subcontracting THEN
                    CapLedgEntry."Completely Invoiced" := CapLedgEntry."Invoiced Quantity" = CapLedgEntry."Output Quantity"
                ELSE
                    CapLedgEntry."Completely Invoiced" := CapLedgEntry."Invoiced Quantity" = CapLedgEntry.Quantity;
                CapLedgEntry.CHANGECOMPANY(ChangeToCompany);
                CapLedgEntry.MODIFY;
            END;
        END;

    end;

    local procedure ItemQtyPosting()
    var
        Transfered: Boolean;
    begin
        ItemJnlLine.CHANGECOMPANY(ChangeToCompany);
        WITH ItemJnlLine DO BEGIN
            IF Quantity <> "Invoiced Quantity" THEN
                TESTFIELD("Invoiced Quantity", 0);
            TESTFIELD("Item Shpt. Entry No.", 0);
            InitItemLedgEntry(GlobalItemLedgEntry);
            InitValueEntry(GlobalValueEntry, GlobalItemLedgEntry);

            IF Item.Type = Item.Type::Inventory THEN BEGIN
                GlobalItemLedgEntry."Remaining Quantity" := GlobalItemLedgEntry.Quantity;
                GlobalItemLedgEntry.Open := GlobalItemLedgEntry."Remaining Quantity" <> 0;
            END ELSE BEGIN
                GlobalItemLedgEntry."Remaining Quantity" := 0;
                GlobalItemLedgEntry.Open := FALSE;
            END;
            GlobalItemLedgEntry.Positive := GlobalItemLedgEntry.Quantity > 0;
            IF GlobalItemLedgEntry."Entry Type" = GlobalItemLedgEntry."Entry Type"::Transfer THEN
                GlobalItemLedgEntry."Completely Invoiced" := TRUE;

            IF GlobalItemLedgEntry.Quantity > 0 THEN
                IF GlobalItemLedgEntry."Entry Type" <> GlobalItemLedgEntry."Entry Type"::Transfer THEN
                    ReserveItemJnlLine.TransferItemJnlToItemLedgEntry(
                      ItemJnlLine, GlobalItemLedgEntry, "Quantity (Base)", TRUE);

            ApplyItemLedgEntry(GlobalItemLedgEntry, OldItemLedgEntry, GlobalValueEntry, FALSE);
            CheckApplFromInProduction(GlobalItemLedgEntry, "Applies-from Entry");
            AutoTrack(GlobalItemLedgEntry);

            IF ("Entry Type" = "Entry Type"::Transfer) AND AverageTransfer THEN
                InsertTransferEntry(GlobalItemLedgEntry, OldItemLedgEntry, TotalAppliedQty);

            IF "Entry Type" IN ["Entry Type"::"Assembly Output", "Entry Type"::"Assembly Consumption"] THEN
                InsertAsmItemEntryRelation(GlobalItemLedgEntry);
            IF (NOT "Phys. Inventory") OR (Quantity <> 0) THEN BEGIN
                InsertItemLedgEntry(GlobalItemLedgEntry, FALSE);
                IF GlobalItemLedgEntry.Positive THEN
                    InsertApplEntry(
                      GlobalItemLedgEntry."Entry No.", GlobalItemLedgEntry."Entry No.",
                      "Applies-from Entry", 0, GlobalItemLedgEntry."Posting Date",
                      GlobalItemLedgEntry.Quantity, TRUE);
            END;
        END;
    end;

    local procedure ItemValuePosting()
    begin
        ItemJnlLine.CHANGECOMPANY(ChangeToCompany);
        WITH ItemJnlLine DO BEGIN
            IF ("Value Entry Type" = "Value Entry Type"::"Direct Cost") AND
               ("Item Charge No." = '') AND
               NOT Adjustment
            THEN BEGIN
                IF (Quantity = 0) AND ("Invoiced Quantity" <> 0) THEN BEGIN
                    IF (GlobalValueEntry."Invoiced Quantity" < 0) AND
                       (Item."Costing Method" = Item."Costing Method"::Average)
                    THEN
                        ValuateAppliedAvgEntry(GlobalValueEntry, Item);
                END ELSE BEGIN
                    IF (GlobalValueEntry."Valued Quantity" < 0) AND ("Entry Type" <> "Entry Type"::Transfer) THEN
                        IF Item."Costing Method" = Item."Costing Method"::Average THEN
                            ValuateAppliedAvgEntry(GlobalValueEntry, Item);
                END;
            END;

            InsertValueEntry(GlobalValueEntry, GlobalItemLedgEntry, FALSE);

            IF ("Value Entry Type" <> "Value Entry Type"::"Direct Cost") OR
               ("Item Charge No." <> '')
            THEN BEGIN
                IF ("Value Entry Type" <> "Value Entry Type"::Rounding) AND (NOT Adjustment) THEN BEGIN
                    IF GlobalItemLedgEntry.Positive THEN
                        GlobalItemLedgEntry.MODIFY;
                    IF ((GlobalValueEntry."Valued Quantity" > 0) OR
                        (("Applies-to Entry" <> 0) AND ("Entry Type" IN ["Entry Type"::Purchase, "Entry Type"::"Assembly Output"]))) AND
                       (OverheadAmount <> 0)
                    THEN
                        InsertOHValueEntry(GlobalValueEntry, OverheadAmount, OverheadAmountACY);
                    IF (Item."Costing Method" = Item."Costing Method"::Standard) AND
                       ("Entry Type" = "Entry Type"::Purchase) AND
                       (GlobalValueEntry."Entry Type" <> GlobalValueEntry."Entry Type"::Revaluation)
                    THEN
                        InsertVarValueEntry(
                          GlobalValueEntry,
                          -GlobalValueEntry."Cost Amount (Actual)" + OverheadAmount,
                          -(GlobalValueEntry."Cost Amount (Actual) (ACY)" + OverheadAmountACY));
                END;
            END ELSE BEGIN
                IF IsBalanceExpectedCostFromRev(ItemJnlLine) THEN
                    InsertBalanceExpCostRevEntry(GlobalValueEntry);

                IF ((GlobalValueEntry."Valued Quantity" > 0) OR
                    (("Applies-to Entry" <> 0) AND ("Entry Type" IN ["Entry Type"::Purchase, "Entry Type"::"Assembly Output"]))) AND
                   (OverheadAmount <> 0)
                THEN
                    InsertOHValueEntry(GlobalValueEntry, OverheadAmount, OverheadAmountACY);

                IF ((GlobalValueEntry."Valued Quantity" > 0) OR ("Applies-to Entry" <> 0)) AND
                   ("Entry Type" = "Entry Type"::Purchase) AND
                   (Item."Costing Method" = Item."Costing Method"::Standard) AND
                   (ROUND(VarianceAmount, GLSetup."Amount Rounding Precision") <> 0) OR
                   VarianceRequired
                THEN
                    InsertVarValueEntry(GlobalValueEntry, VarianceAmount, VarianceAmountACY);
            END;
            IF (GlobalValueEntry."Valued Quantity" < 0) AND
               (GlobalItemLedgEntry.Quantity = GlobalItemLedgEntry."Invoiced Quantity")
            THEN
                UpdateItemApplnEntry(GlobalValueEntry."Item Ledger Entry No.", "Posting Date");
        END;
    end;

    local procedure FlushOperation(ProdOrder: Record "Production Order"; ProdOrderLine: Record "Prod. Order Line")
    var
        ProdOrderRtngLine: Record "Prod. Order Routing Line";
        ProdOrderComp: Record "Prod. Order Component";
        OldItemJnlLine: Record "Item Journal Line";
        OldTempSplitItemJnlLine: Record "Item Journal Line" temporary;
        OldItemTrackingCode: Record "Item Tracking Code";
        OldSNRequired: Boolean;
        OldLotRequired: Boolean;
        xCalledFromInvtPutawayPick: Boolean;
    begin
        IF ItemJnlLine."Operation No." = '' THEN
            EXIT;

        OldItemJnlLine := ItemJnlLine;
        OldTempSplitItemJnlLine.RESET;
        OldTempSplitItemJnlLine.DELETEALL;
        TempSplitItemJnlLine.RESET;
        IF TempSplitItemJnlLine.FINDSET THEN
            REPEAT
                OldTempSplitItemJnlLine := TempSplitItemJnlLine;
                OldTempSplitItemJnlLine.INSERT;
            UNTIL TempSplitItemJnlLine.NEXT = 0;
        OldSNRequired := SNRequired;
        OldLotRequired := LotRequired;
        OldItemTrackingCode := ItemTrackingCode;
        xCalledFromInvtPutawayPick := CalledFromInvtPutawayPick;
        CalledFromInvtPutawayPick := FALSE;

        ProdOrderRtngLine.GET(
          ProdOrderRtngLine.Status::Released,
          OldItemJnlLine."Order No.",
          OldItemJnlLine."Routing Reference No.",
          OldItemJnlLine."Routing No.",
          OldItemJnlLine."Operation No.");
        IF ProdOrderRtngLine."Routing Link Code" <> '' THEN BEGIN
            ProdOrderComp.SETCURRENTKEY(ProdOrderComp.Status, ProdOrderComp."Prod. Order No.", ProdOrderComp."Routing Link Code", ProdOrderComp."Flushing Method");
            ProdOrderComp.SETRANGE(ProdOrderComp."Flushing Method", ProdOrderComp."Flushing Method"::Forward, ProdOrderComp."Flushing Method"::"Pick + Backward");
            ProdOrderComp.SETRANGE(ProdOrderComp."Routing Link Code", ProdOrderRtngLine."Routing Link Code");
            ProdOrderComp.SETRANGE(ProdOrderComp.Status, ProdOrderComp.Status::Released);
            ProdOrderComp.SETRANGE(ProdOrderComp."Prod. Order No.", OldItemJnlLine."Order No.");
            ProdOrderComp.SETRANGE(ProdOrderComp."Prod. Order Line No.", OldItemJnlLine."Order Line No.");
            IF ProdOrderComp.FINDSET THEN BEGIN
                BlockRetrieveIT := TRUE;
                REPEAT
                    PostFlushedConsump(
                      ProdOrder, ProdOrderLine, ProdOrderComp,
                      OldItemJnlLine."Output Quantity (Base)" + OldItemJnlLine."Scrap Quantity (Base)",
                      OldItemJnlLine."Posting Date", OldItemJnlLine."Document No.");
                UNTIL ProdOrderComp.NEXT = 0;
                BlockRetrieveIT := FALSE;
            END;
        END;

        ItemJnlLine := OldItemJnlLine;
        TempSplitItemJnlLine.RESET;
        TempSplitItemJnlLine.DELETEALL;
        IF OldTempSplitItemJnlLine.FINDSET THEN
            REPEAT
                TempSplitItemJnlLine := OldTempSplitItemJnlLine;
                TempSplitItemJnlLine.INSERT;
            UNTIL OldTempSplitItemJnlLine.NEXT = 0;
        SNRequired := OldSNRequired;
        LotRequired := OldLotRequired;
        ItemTrackingCode := OldItemTrackingCode;
        CalledFromInvtPutawayPick := xCalledFromInvtPutawayPick;
    end;

    local procedure PostFlushedConsump(ProdOrder: Record "Production Order"; ProdOrderLine: Record "Prod. Order Line"; ProdOrderComp: Record "Prod. Order Component"; ActOutputQtyBase: Decimal; PostingDate: Date; DocumentNo: Code[20])
    var
        CompItem: Record Item;
        OldTempTrackingSpecification: Record "Tracking Specification" temporary;
        QtyToPost: Decimal;
        CalcBasedOn: Option "Actual Output","Expected Output";
        PostItemJnlLine: Boolean;
        DimsAreTaken: Boolean;
    begin
        CompItem.CHANGECOMPANY(ChangeToCompany);
        CompItem.GET(ProdOrderComp."Item No.");
        CompItem.TESTFIELD("Rounding Precision");

        IF ProdOrderComp."Flushing Method" IN
           [ProdOrderComp."Flushing Method"::Backward, ProdOrderComp."Flushing Method"::"Pick + Backward"]
        THEN
            QtyToPost :=
              CostCalcMgt.CalcActNeededQtyBase(ProdOrderLine, ProdOrderComp, ActOutputQtyBase) / ProdOrderComp."Qty. per Unit of Measure"
        ELSE
            QtyToPost := ProdOrderComp.GetNeededQty(CalcBasedOn::"Expected Output", TRUE);
        QtyToPost := ROUND(QtyToPost, CompItem."Rounding Precision", '>');

        IF QtyToPost = 0 THEN
            EXIT;

        ItemJnlLine.INIT;
        ItemJnlLine."Line No." := 0;
        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::Consumption;
        ItemJnlLine.VALIDATE(ItemJnlLine."Posting Date", PostingDate);
        ItemJnlLine."Document No." := DocumentNo;
        ItemJnlLine."Source No." := ProdOrderLine."Item No.";
        ItemJnlLine."Order Type" := ItemJnlLine."Order Type"::Production;
        ItemJnlLine."Order No." := ProdOrderLine."Prod. Order No.";
        ItemJnlLine.VALIDATE(ItemJnlLine."Order Line No.", ProdOrderLine."Line No.");
        ItemJnlLine.VALIDATE(ItemJnlLine."Item No.", ProdOrderComp."Item No.");
        ItemJnlLine.VALIDATE(ItemJnlLine."Prod. Order Comp. Line No.", ProdOrderComp."Line No.");
        ItemJnlLine.VALIDATE(ItemJnlLine."Unit of Measure Code", ProdOrderComp."Unit of Measure Code");
        ItemJnlLine.Description := ProdOrderComp.Description;
        ItemJnlLine.VALIDATE(ItemJnlLine.Quantity, QtyToPost);
        ItemJnlLine.VALIDATE(ItemJnlLine."Unit Cost", ProdOrderComp."Unit Cost");
        ItemJnlLine."Location Code" := ProdOrderComp."Location Code";
        ItemJnlLine."Bin Code" := ProdOrderComp."Bin Code";
        ItemJnlLine."Variant Code" := ProdOrderComp."Variant Code";
        ItemJnlLine."Source Code" := SourceCodeSetup.Flushing;
        ItemJnlLine."Gen. Bus. Posting Group" := ProdOrder."Gen. Bus. Posting Group";
        ItemJnlLine."Gen. Prod. Posting Group" := CompItem."Gen. Prod. Posting Group";

        OldTempTrackingSpecification.RESET;
        OldTempTrackingSpecification.DELETEALL;
        TempTrackingSpecification.RESET;
        IF TempTrackingSpecification.FINDSET THEN
            REPEAT
                OldTempTrackingSpecification := TempTrackingSpecification;
                OldTempTrackingSpecification.INSERT;
            UNTIL TempTrackingSpecification.NEXT = 0;
        ReserveProdOrderComp.TransferPOCompToItemJnlLine(
          ProdOrderComp, ItemJnlLine, ROUND(QtyToPost * ProdOrderComp."Qty. per Unit of Measure", 0.00001));
        PostItemJnlLine := SetupSplitJnlLine(ItemJnlLine);
        WHILE SplitJnlLine(ItemJnlLine, PostItemJnlLine) DO BEGIN
            IF SNRequired AND (ItemJnlLine."Serial No." = '') THEN
                ERROR(SerialNoRequiredErr, ItemJnlLine."Item No.");
            IF LotRequired AND (ItemJnlLine."Lot No." = '') THEN
                ERROR(LotNoRequiredErr, ItemJnlLine."Item No.");

            IF NOT DimsAreTaken THEN BEGIN
                ItemJnlLine."Dimension Set ID" := GetCombinedDimSetID(ProdOrderComp."Dimension Set ID", ProdOrderLine."Dimension Set ID");
                DimsAreTaken := TRUE;
            END;
            ItemJnlCheckLine.RunCheck(ItemJnlLine);
            ProdOrderCompModified := TRUE;
            ItemJnlLine.Quantity := ItemJnlLine."Quantity (Base)";
            ItemJnlLine."Invoiced Quantity" := ItemJnlLine."Invoiced Qty. (Base)";
            QtyPerUnitOfMeasure := ItemJnlLine."Qty. per Unit of Measure";

            ItemJnlLine."Unit Amount" := ROUND(
                ItemJnlLine."Unit Amount" / QtyPerUnitOfMeasure, GLSetup."Unit-Amount Rounding Precision");
            ItemJnlLine."Unit Cost" := ROUND(
                ItemJnlLine."Unit Cost" / QtyPerUnitOfMeasure, GLSetup."Unit-Amount Rounding Precision");
            ItemJnlLine."Unit Cost (ACY)" := ROUND(
                ItemJnlLine."Unit Cost (ACY)" / QtyPerUnitOfMeasure, Currency."Unit-Amount Rounding Precision");
            PostConsumption;
        END;

        TempTrackingSpecification.RESET;
        TempTrackingSpecification.DELETEALL;
        IF OldTempTrackingSpecification.FINDSET THEN
            REPEAT
                TempTrackingSpecification := OldTempTrackingSpecification;
                TempTrackingSpecification.INSERT;
            UNTIL OldTempTrackingSpecification.NEXT = 0;

    end;

    local procedure UpdateUnitCost(ValueEntry: Record "Value Entry")
    var
        ItemCostMgt: Codeunit ItemCostManagement;
        LastDirectCost: Decimal;
    begin
        IF (ValueEntry."Valued Quantity" > 0) AND NOT (ValueEntry."Expected Cost" OR ItemJnlLine.Adjustment) THEN BEGIN
            Item.CHANGECOMPANY(ChangeToCompany);
            Item.LOCKTABLE;
            IF NOT Item.FIND THEN
                EXIT;

            IF ((ValueEntry."Item Ledger Entry Type" IN
                 [ValueEntry."Item Ledger Entry Type"::Purchase,
                  ValueEntry."Item Ledger Entry Type"::"Positive Adjmt.",
                  ValueEntry."Item Ledger Entry Type"::"Assembly Output"]) OR
                (ValueEntry."Item Ledger Entry Type" = ValueEntry."Item Ledger Entry Type"::Output) AND (ValueEntry."Invoiced Quantity" > 0)) AND
               (ValueEntry."Cost Amount (Actual)" + ValueEntry."Discount Amount" > 0) AND
               (ItemJnlLine."Value Entry Type" = ItemJnlLine."Value Entry Type"::"Direct Cost") AND
               (ItemJnlLine."Item Charge No." = '') AND
               NOT Item."Inventory Value Zero"
            THEN
                LastDirectCost :=
                  ROUND(
                    (ItemJnlLine.Amount + ItemJnlLine."Discount Amount") / ValueEntry."Valued Quantity",
                    GLSetup."Unit-Amount Rounding Precision");
            IF ValueEntry."Drop Shipment" THEN BEGIN
                IF LastDirectCost <> 0 THEN BEGIN
                    Item."Last Direct Cost" := LastDirectCost;
                    Item.MODIFY;
                    ItemCostMgt.SetProperties(FALSE, ValueEntry."Invoiced Quantity");
                    ItemCostMgt.FindUpdateUnitCostSKU(Item, ValueEntry."Location Code", ValueEntry."Variant Code", TRUE, LastDirectCost);
                END;
            END ELSE BEGIN
                ItemCostMgt.SetProperties(FALSE, ValueEntry."Invoiced Quantity");
                ItemCostMgt.UpdateUnitCost(Item, ValueEntry."Location Code", ValueEntry."Variant Code", LastDirectCost, 0, TRUE, TRUE, FALSE, 0);
            END;
        END;
    end;


    procedure UnApply(Application: Record "Item Application Entry")
    var
        ItemLedgEntry1: Record "Item Ledger Entry";
        ItemLedgEntry2: Record "Item Ledger Entry";
        CostItemLedgEntry: Record "Item Ledger Entry";
        InventoryPeriod: Record "Inventory Period";
        Valuationdate: Date;
    begin
        IF NOT InventoryPeriod.IsValidDate(Application."Posting Date") THEN
            InventoryPeriod.ShowError(Application."Posting Date");
        ItemLedgEntry1.CHANGECOMPANY(ChangeToCompany);
        ItemLedgEntry2.CHANGECOMPANY(ChangeToCompany);
        Application.CHANGECOMPANY(ChangeToCompany);
        // If we can't get both entries then the application is not a real application or a date compression might have been done
        ItemLedgEntry1.GET(Application."Inbound Item Entry No.");
        ItemLedgEntry2.GET(Application."Outbound Item Entry No.");

        IF Application."Item Ledger Entry No." = Application."Inbound Item Entry No." THEN
            IF ItemLedgEntry1.Correction THEN
                ERROR(Text025);
        IF Application."Item Ledger Entry No." = Application."Outbound Item Entry No." THEN
            IF ItemLedgEntry2.Correction THEN
                ERROR(Text025);

        IF ItemLedgEntry1."Drop Shipment" AND ItemLedgEntry2."Drop Shipment" THEN
            ERROR(Text024);

        IF ItemLedgEntry2."Entry Type" = ItemLedgEntry2."Entry Type"::Transfer THEN
            ERROR(Text023);

        Application.TESTFIELD("Transferred-from Entry No.", 0);

        // We won't allow deletion of applications for deleted items
        Item.CHANGECOMPANY(ChangeToCompany);
        Item.GET(ItemLedgEntry1."Item No.");
        CostItemLedgEntry.GET(Application.CostReceiver); // costreceiver

        IF ItemLedgEntry1."Applies-to Entry" = ItemLedgEntry2."Entry No." THEN
            ItemLedgEntry1."Applies-to Entry" := 0;

        IF ItemLedgEntry2."Applies-to Entry" = ItemLedgEntry1."Entry No." THEN
            ItemLedgEntry2."Applies-to Entry" := 0;

        // only if real/quantity application
        IF NOT Application.CostApplication THEN BEGIN
            ItemLedgEntry1."Remaining Quantity" := ItemLedgEntry1."Remaining Quantity" - Application.Quantity;
            ItemLedgEntry1.Open := ItemLedgEntry1."Remaining Quantity" <> 0;
            ItemLedgEntry1.MODIFY;

            ItemLedgEntry2."Remaining Quantity" := ItemLedgEntry2."Remaining Quantity" + Application.Quantity;
            ItemLedgEntry2.Open := ItemLedgEntry2."Remaining Quantity" <> 0;
            ItemLedgEntry2.MODIFY;
        END ELSE BEGIN
            ItemLedgEntry2."Shipped Qty. Not Returned" := ItemLedgEntry2."Shipped Qty. Not Returned" - ABS(Application.Quantity);
            IF ABS(ItemLedgEntry2."Shipped Qty. Not Returned") > ABS(ItemLedgEntry2.Quantity) THEN
                ItemLedgEntry2.FIELDERROR("Shipped Qty. Not Returned", Text004); // Assert - should never happen
            ItemLedgEntry2.MODIFY;

            // If cost application we need to insert a 0 application instead if there is none before
            IF Application.Quantity > 0 THEN
                IF NOT ZeroApplication(Application."Item Ledger Entry No.") THEN
                    InsertApplEntry(
                      Application."Item Ledger Entry No.", Application."Inbound Item Entry No.",
                      0, 0, Application."Posting Date",
                      Application.Quantity, TRUE);
        END;

        IF Item."Costing Method" = Item."Costing Method"::Average THEN
            IF Application.Fixed THEN
                UpdateValuedByAverageCost(CostItemLedgEntry."Entry No.", TRUE);

        Application.InsertHistory;
        TouchEntry(Application."Inbound Item Entry No.");
        SaveTouchedEntry(Application."Inbound Item Entry No.", TRUE);
        IF Application."Outbound Item Entry No." <> 0 THEN BEGIN
            TouchEntry(Application."Outbound Item Entry No.");
            SaveTouchedEntry(Application."Inbound Item Entry No.", FALSE);
        END;
        Application.DELETE;

        Valuationdate := GetMaxAppliedValuationdate(CostItemLedgEntry);
        IF Valuationdate = 0D THEN
            Valuationdate := CostItemLedgEntry."Posting Date"
        ELSE
            Valuationdate := Max(CostItemLedgEntry."Posting Date", Valuationdate);

        SetValuationDateAllValueEntrie(CostItemLedgEntry."Entry No.", Valuationdate, FALSE);

        UpdateLinkedValuationUnapply(Valuationdate, CostItemLedgEntry."Entry No.", CostItemLedgEntry.Positive);
    end;


    procedure ReApply(ItemLedgEntry: Record "Item Ledger Entry"; ApplyWith: Integer)
    var
        ItemLedgEntry2: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        InventoryPeriod: Record "Inventory Period";
        SNInfoRequired: Boolean;
        LotInfoRequired: Boolean;
        CostApplication: Boolean;
    begin
        Item.CHANGECOMPANY(ChangeToCompany);
        ItemLedgEntry2.CHANGECOMPANY(ChangeToCompany);
        ItemLedgEntry.CHANGECOMPANY(ChangeToCompany);
        Item.GET(ItemLedgEntry."Item No.");

        IF NOT InventoryPeriod.IsValidDate(ItemLedgEntry."Posting Date") THEN
            InventoryPeriod.ShowError(ItemLedgEntry."Posting Date");

        ItemTrackingCode.Code := Item."Item Tracking Code";
        /*    ItemTrackingMgt.GetItemTrackingSettings(
              ItemTrackingCode, ItemJnlLine."Entry Type", ItemJnlLine.Signed(ItemJnlLine."Quantity (Base)") > 0,
              SNRequired, LotRequired, SNInfoRequired, LotInfoRequired);*/ // 15578

        TotalAppliedQty := 0;
        CostApplication := FALSE;
        IF ApplyWith <> 0 THEN BEGIN
            ItemLedgEntry2.GET(ApplyWith);
            IF ItemLedgEntry2.Quantity > 0 THEN BEGIN
                // Switch around so ItemLedgEntry is positive and ItemLedgEntry2 is negative
                OldItemLedgEntry := ItemLedgEntry;
                ItemLedgEntry := ItemLedgEntry2;
                ItemLedgEntry2 := OldItemLedgEntry;
            END;
            IF NOT ((ItemLedgEntry.Quantity > 0) AND // not(Costprovider(ItemLedgEntry))
                    ((ItemLedgEntry."Entry Type" = ItemLedgEntry2."Entry Type"::Purchase) OR
                     (ItemLedgEntry."Entry Type" = ItemLedgEntry2."Entry Type"::"Positive Adjmt.") OR
                     (ItemLedgEntry."Entry Type" = ItemLedgEntry2."Entry Type"::Output) OR
                     (ItemLedgEntry."Entry Type" = ItemLedgEntry2."Entry Type"::"Assembly Output"))
                    )
            THEN
                CostApplication := TRUE;
            IF (ItemLedgEntry."Remaining Quantity" <> 0) AND (ItemLedgEntry2."Remaining Quantity" <> 0) THEN
                CostApplication := FALSE;
            IF CostApplication THEN
                CostApply(ItemLedgEntry, ItemLedgEntry2)
            ELSE BEGIN
                CreateItemJNLLinefromEntry(ItemLedgEntry2, ItemLedgEntry2."Remaining Quantity", ItemJnlLine);
                IF ApplyWith = ItemLedgEntry2."Entry No." THEN
                    ItemLedgEntry2."Applies-to Entry" := ItemLedgEntry."Entry No."
                ELSE
                    ItemLedgEntry2."Applies-to Entry" := ApplyWith;
                ItemJnlLine."Applies-to Entry" := ItemLedgEntry2."Applies-to Entry";
                GlobalItemLedgEntry := ItemLedgEntry2;
                ApplyItemLedgEntry(ItemLedgEntry2, OldItemLedgEntry, ValueEntry, FALSE);
                TouchItemEntryCost(ItemLedgEntry2, FALSE);
                ItemLedgEntry2.MODIFY;
                EnsureValueEntryLoaded(ValueEntry, ItemLedgEntry2);
                GetValuationDate(ValueEntry, ItemLedgEntry);
                UpdateLinkedValuationDate(ValueEntry."Valuation Date", GlobalItemLedgEntry."Entry No.", GlobalItemLedgEntry.Positive);
            END;
            Item.CHANGECOMPANY(ChangeToCompany);
            IF ItemApplnEntry.Fixed AND (ItemApplnEntry.CostReceiver <> 0) THEN
                IF Item.GET(ItemLedgEntry."Item No.") THEN
                    IF Item."Costing Method" = Item."Costing Method"::Average THEN
                        UpdateValuedByAverageCost(ItemApplnEntry.CostReceiver, FALSE);
        END ELSE BEGIN  // ApplyWith is 0
            ItemLedgEntry."Applies-to Entry" := ApplyWith;
            CreateItemJNLLinefromEntry(ItemLedgEntry, ItemLedgEntry."Remaining Quantity", ItemJnlLine);
            ItemJnlLine."Applies-to Entry" := ItemLedgEntry."Applies-to Entry";
            GlobalItemLedgEntry := ItemLedgEntry;
            ApplyItemLedgEntry(ItemLedgEntry, OldItemLedgEntry, ValueEntry, FALSE);
            TouchItemEntryCost(ItemLedgEntry, FALSE);
            ItemLedgEntry.MODIFY;
            EnsureValueEntryLoaded(ValueEntry, ItemLedgEntry);
            GetValuationDate(ValueEntry, ItemLedgEntry);
            UpdateLinkedValuationDate(ValueEntry."Valuation Date", GlobalItemLedgEntry."Entry No.", GlobalItemLedgEntry.Positive);
        END;
    end;

    local procedure CostApply(var ItemLedgEntry: Record "Item Ledger Entry"; ItemLedgEntry2: Record "Item Ledger Entry")
    var
        ApplyWithItemLedgEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
    begin
        IF ItemLedgEntry.Quantity > 0 THEN BEGIN
            GlobalItemLedgEntry := ItemLedgEntry;
            ApplyWithItemLedgEntry := ItemLedgEntry2;
        END
        ELSE BEGIN
            GlobalItemLedgEntry := ItemLedgEntry2;
            ApplyWithItemLedgEntry := ItemLedgEntry;
        END;
        IF NOT ItemApplnEntry.CheckIsCyclicalLoop(ApplyWithItemLedgEntry, GlobalItemLedgEntry) THEN BEGIN
            CreateItemJNLLinefromEntry(GlobalItemLedgEntry, GlobalItemLedgEntry.Quantity, ItemJnlLine);
            InsertApplEntry(
              GlobalItemLedgEntry."Entry No.", GlobalItemLedgEntry."Entry No.",
              ApplyWithItemLedgEntry."Entry No.", 0, GlobalItemLedgEntry."Posting Date",
              GlobalItemLedgEntry.Quantity, TRUE);
            UpdateOutboundItemLedgEntry(ApplyWithItemLedgEntry."Entry No.");
            OldItemLedgEntry.GET(ApplyWithItemLedgEntry."Entry No.");
            EnsureValueEntryLoaded(ValueEntry, GlobalItemLedgEntry);
            ItemJnlLine."Applies-from Entry" := ApplyWithItemLedgEntry."Entry No.";
            GetAppliedFromValues(ValueEntry);
            SetValuationDateAllValueEntrie(GlobalItemLedgEntry."Entry No.", ValueEntry."Valuation Date", FALSE);
            UpdateLinkedValuationDate(ValueEntry."Valuation Date", GlobalItemLedgEntry."Entry No.", GlobalItemLedgEntry.Positive);
            TouchItemEntryCost(ItemLedgEntry2, FALSE);
        END;
    end;

    local procedure ZeroApplication(EntryNo: Integer): Boolean
    var
        Application: Record "Item Application Entry";
    begin
        Application.SETCURRENTKEY("Inbound Item Entry No.", "Item Ledger Entry No.");
        Application.SETRANGE("Item Ledger Entry No.", EntryNo);
        Application.SETRANGE("Inbound Item Entry No.", EntryNo);
        Application.SETRANGE("Outbound Item Entry No.", 0);
        EXIT(NOT Application.ISEMPTY);
    end;

    local procedure ApplyItemLedgEntry(var ItemLedgEntry: Record "Item Ledger Entry"; var OldItemLedgEntry: Record "Item Ledger Entry"; var ValueEntry: Record "Value Entry"; CausedByTransfer: Boolean)
    var
        ItemLedgEntry2: Record "Item Ledger Entry";
        OldValueEntry: Record "Value Entry";
        ReservEntry: Record "Reservation Entry";
        ReservEntry2: Record "Reservation Entry";
        AppliesFromItemLedgEntry: Record "Item Ledger Entry";
        EntryFindMethod: Text[1];
        AppliedQty: Decimal;
        FirstReservation: Boolean;
        FirstApplication: Boolean;
        StartApplication: Boolean;
        UseReservationApplication: Boolean;
    begin
        IF (ItemLedgEntry."Remaining Quantity" = 0) OR
           (ItemLedgEntry."Drop Shipment" AND (ItemLedgEntry."Applies-to Entry" = 0)) OR
           ((Item."Costing Method" = Item."Costing Method"::Specific) AND ItemLedgEntry.Positive)
        THEN
            EXIT;

        CLEAR(OldItemLedgEntry);
        FirstReservation := TRUE;
        FirstApplication := TRUE;
        StartApplication := FALSE;
        REPEAT
            ItemJnlLine.CALCFIELDS("Reserved Qty. (Base)");
            IF ItemJnlLine."Assemble to Order" THEN BEGIN
                ItemJnlLine.TESTFIELD("Reserved Qty. (Base)");
                ItemJnlLine.TESTFIELD("Applies-to Entry");
            END ELSE
                IF ItemJnlLine."Reserved Qty. (Base)" <> 0 THEN BEGIN
                    IF ItemLedgEntry."Applies-to Entry" <> 0 THEN
                        ItemLedgEntry.FIELDERROR(
                          "Applies-to Entry", Text99000000);
                END;

            IF NOT CausedByTransfer AND NOT PostponeReservationHandling THEN BEGIN
                IF Item."Costing Method" = Item."Costing Method"::Specific THEN
                    ItemJnlLine.TESTFIELD("Serial No.");

                IF FirstReservation THEN BEGIN
                    FirstReservation := FALSE;
                    ReservEntry.RESET;
                    ReservEntry.SETCURRENTKEY(
                      "Source ID", "Source Ref. No.", "Source Type", "Source Subtype",
                      "Source Batch Name", "Source Prod. Order Line", "Reservation Status");
                    ReservEntry.SETRANGE("Reservation Status", ReservEntry."Reservation Status"::Reservation);
                    //   ReserveItemJnlLine.FilterReservFor(ReservEntry, ItemJnlLine);
                END;

                UseReservationApplication := ReservEntry.FINDFIRST;

                IF NOT UseReservationApplication THEN BEGIN // No reservations exist
                    ReservEntry.SETRANGE(
                      "Reservation Status", ReservEntry."Reservation Status"::Tracking,
                      ReservEntry."Reservation Status"::Prospect);
                    IF ReservEntry.FINDSET THEN
                        REPEAT
                            ReservEngineMgt.CloseSurplusTrackingEntry(ReservEntry);
                        UNTIL ReservEntry.NEXT = 0;
                    StartApplication := TRUE;
                END;

                IF UseReservationApplication THEN BEGIN
                    ReservEntry2.GET(ReservEntry."Entry No.", NOT ReservEntry.Positive);
                    IF ReservEntry2."Source Type" <> DATABASE::"Item Ledger Entry" THEN
                        IF ItemLedgEntry.Quantity < 0 THEN
                            ERROR(Text003, ReservEntry."Item No.");
                    OldItemLedgEntry.CHANGECOMPANY(ChangeToCompany);
                    OldItemLedgEntry.GET(ReservEntry2."Source Ref. No.");
                    IF ItemLedgEntry.Quantity < 0 THEN
                        IF OldItemLedgEntry."Remaining Quantity" < ReservEntry2."Quantity (Base)" THEN
                            ERROR(Text003, ReservEntry2."Item No.");

                    OldItemLedgEntry.TESTFIELD("Item No.", ItemJnlLine."Item No.");
                    OldItemLedgEntry.TESTFIELD("Variant Code", ItemJnlLine."Variant Code");
                    //Ori UtOldItemLedgEntry.TESTFIELD("Location Code",ItemJnlLine."Location Code");
                    ReservEngineMgt.CloseReservEntry(ReservEntry, FALSE, FALSE);
                    OldItemLedgEntry.CALCFIELDS("Reserved Quantity");
                    ItemJnlLine.CALCFIELDS("Reserved Qty. (Base)");
                    AppliedQty := -ABS(ReservEntry."Quantity (Base)");
                END;
            END ELSE
                StartApplication := TRUE;

            IF StartApplication THEN BEGIN
                ItemLedgEntry.CALCFIELDS("Reserved Quantity");
                IF ItemLedgEntry."Applies-to Entry" <> 0 THEN BEGIN
                    IF FirstApplication THEN BEGIN
                        FirstApplication := FALSE;
                        OldItemLedgEntry.CHANGECOMPANY(ChangeToCompany);
                        OldItemLedgEntry.GET(ItemLedgEntry."Applies-to Entry");
                        OldItemLedgEntry.TESTFIELD("Item No.", ItemLedgEntry."Item No.");
                        OldItemLedgEntry.TESTFIELD("Variant Code", ItemLedgEntry."Variant Code");

                        OldItemLedgEntry.TESTFIELD(Positive, NOT ItemLedgEntry.Positive);
                        OldItemLedgEntry.TESTFIELD("Location Code", ItemLedgEntry."Location Code");
                        Location.CHANGECOMPANY(ChangeToCompany);
                        IF Location.GET(ItemLedgEntry."Location Code") THEN
                            IF Location."Use As In-Transit" THEN BEGIN
                                OldItemLedgEntry.TESTFIELD("Order Type", OldItemLedgEntry."Order Type"::Transfer);
                                OldItemLedgEntry.TESTFIELD("Order No.", ItemLedgEntry."Order No.");
                            END;

                        IF ItemTrackingCode."SN Specific Tracking" OR ItemLedgEntry."Drop Shipment" THEN
                            OldItemLedgEntry.TESTFIELD("Serial No.", ItemLedgEntry."Serial No.");
                        IF ItemTrackingCode."Lot Specific Tracking" OR ItemLedgEntry."Drop Shipment" THEN
                            OldItemLedgEntry.TESTFIELD("Lot No.", ItemLedgEntry."Lot No.");

                        IF NOT (OldItemLedgEntry.Open AND
                                 (ABS(OldItemLedgEntry."Remaining Quantity" - OldItemLedgEntry."Reserved Quantity") >=
                                  ABS(ItemLedgEntry."Remaining Quantity" - ItemLedgEntry."Reserved Quantity")))
                        THEN BEGIN
                            IF (ABS(OldItemLedgEntry."Remaining Quantity" - OldItemLedgEntry."Reserved Quantity") <=
                                 ABS(ItemLedgEntry."Remaining Quantity" - ItemLedgEntry."Reserved Quantity"))
                            THEN BEGIN
                                IF NOT MoveApplication(ItemLedgEntry, OldItemLedgEntry) THEN
                                    OldItemLedgEntry.FIELDERROR("Remaining Quantity", Text004);
                            END
                            ELSE
                                OldItemLedgEntry.TESTFIELD(Open, TRUE);
                        END;

                        OldItemLedgEntry.CALCFIELDS("Reserved Quantity");
                        CheckApplication(ItemLedgEntry, OldItemLedgEntry);

                        IF ABS(OldItemLedgEntry."Remaining Quantity") <= ABS(OldItemLedgEntry."Reserved Quantity") THEN
                            ReservationPreventsApplication(ItemLedgEntry."Applies-to Entry", ItemLedgEntry."Item No.", OldItemLedgEntry);

                        IF (OldItemLedgEntry."Order Type" = OldItemLedgEntry."Order Type"::Production) AND
                           (OldItemLedgEntry."Order No." <> '')
                        THEN
                            IF NOT ItemJnlLine.Subcontracting THEN
                                IF NOT AllowProdApplication(OldItemLedgEntry, ItemLedgEntry) THEN
                                    ERROR(
                                      Text022,
                                      ItemLedgEntry."Entry Type",
                                      OldItemLedgEntry."Entry Type",
                                      OldItemLedgEntry."Item No.",
                                     OldItemLedgEntry."Order No.")
                    END ELSE
                        EXIT;
                END ELSE BEGIN
                    IF FirstApplication THEN BEGIN
                        FirstApplication := FALSE;
                        ItemLedgEntry2.CHANGECOMPANY(ChangeToCompany);
                        ItemLedgEntry2.SETCURRENTKEY(
                          "Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
                        ItemLedgEntry2.SETRANGE("Item No.", ItemLedgEntry."Item No.");
                        ItemLedgEntry2.SETRANGE(Open, TRUE);
                        ItemLedgEntry2.SETRANGE("Variant Code", ItemLedgEntry."Variant Code");
                        ItemLedgEntry2.SETRANGE(Positive, NOT ItemLedgEntry.Positive);
                        ItemLedgEntry2.SETRANGE("Location Code", ItemLedgEntry."Location Code");

                        IF ItemLedgEntry."Job Purchase" THEN BEGIN
                            ItemLedgEntry2.SETRANGE("Job No.", ItemLedgEntry."Job No.");
                            ItemLedgEntry2.SETRANGE("Job Task No.", ItemLedgEntry."Job Task No.");
                            ItemLedgEntry2.SETRANGE("Document Type", ItemLedgEntry."Document Type");
                            ItemLedgEntry2.SETRANGE("Document No.", ItemLedgEntry."Document No.");
                        END;

                        IF ItemTrackingCode."SN Specific Tracking" THEN
                            ItemLedgEntry2.SETRANGE("Serial No.", ItemLedgEntry."Serial No.");
                        IF ItemTrackingCode."Lot Specific Tracking" THEN
                            ItemLedgEntry2.SETRANGE("Lot No.", ItemLedgEntry."Lot No.");
                        Location.CHANGECOMPANY(ChangeToCompany);
                        IF Location.GET(ItemLedgEntry."Location Code") THEN
                            IF Location."Use As In-Transit" THEN BEGIN
                                ItemLedgEntry2.SETRANGE("Order Type", ItemLedgEntry."Order Type"::Transfer);
                                ItemLedgEntry2.SETRANGE("Order No.", ItemLedgEntry."Order No.");
                            END;

                        IF Item."Costing Method" = Item."Costing Method"::LIFO THEN
                            EntryFindMethod := '+'
                        ELSE
                            EntryFindMethod := '-';
                        IF NOT ItemLedgEntry2.FIND(EntryFindMethod) THEN
                            EXIT;
                    END ELSE
                        CASE EntryFindMethod OF
                            '-':
                                IF ItemLedgEntry2.NEXT = 0 THEN
                                    EXIT;
                            '+':
                                IF ItemLedgEntry2.NEXT(-1) = 0 THEN
                                    EXIT;
                        END;
                    OldItemLedgEntry.COPY(ItemLedgEntry2)
                END;

                OldItemLedgEntry.CALCFIELDS("Reserved Quantity");

                IF ABS(OldItemLedgEntry."Remaining Quantity" - OldItemLedgEntry."Reserved Quantity") >
                   ABS(ItemLedgEntry."Remaining Quantity" - ItemLedgEntry."Reserved Quantity")
                THEN
                    AppliedQty := ItemLedgEntry."Remaining Quantity" - ItemLedgEntry."Reserved Quantity"
                ELSE
                    AppliedQty := -(OldItemLedgEntry."Remaining Quantity" - OldItemLedgEntry."Reserved Quantity");

                IF ItemLedgEntry."Entry Type" = ItemLedgEntry."Entry Type"::Transfer THEN
                    IF (OldItemLedgEntry."Entry No." > ItemLedgEntry."Entry No.") AND NOT ItemLedgEntry.Positive THEN
                        AppliedQty := 0;
                IF (OldItemLedgEntry."Order Type" = OldItemLedgEntry."Order Type"::Production) AND
                   (OldItemLedgEntry."Order No." <> '')
                THEN
                    IF NOT ItemJnlLine.Subcontracting THEN
                        IF NOT AllowProdApplication(OldItemLedgEntry, ItemLedgEntry) THEN
                            AppliedQty := 0;
                IF ItemJnlLine."Applies-from Entry" <> 0 THEN BEGIN
                    AppliesFromItemLedgEntry.CHANGECOMPANY(ChangeToCompany);
                    AppliesFromItemLedgEntry.GET(ItemJnlLine."Applies-from Entry");
                    IF ItemApplnEntry.CheckIsCyclicalLoop(AppliesFromItemLedgEntry, OldItemLedgEntry) THEN
                        AppliedQty := 0;
                END;
            END;

            CheckIsCyclicalLoop(ItemLedgEntry, OldItemLedgEntry, PrevAppliedItemLedgEntry, AppliedQty);

            IF AppliedQty <> 0 THEN BEGIN
                IF NOT OldItemLedgEntry.Positive AND
                   (OldItemLedgEntry."Remaining Quantity" = -AppliedQty) AND
                   (OldItemLedgEntry."Entry No." = ItemLedgEntry."Applies-to Entry")
                THEN BEGIN
                    OldValueEntry.CHANGECOMPANY(ChangeToCompany);
                    OldValueEntry.SETCURRENTKEY("Item Ledger Entry No.");
                    OldValueEntry.SETRANGE("Item Ledger Entry No.", OldItemLedgEntry."Entry No.");
                    IF OldValueEntry.FIND('-') THEN
                        REPEAT
                            IF OldValueEntry."Valued By Average Cost" THEN BEGIN
                                OldValueEntry."Valued By Average Cost" := FALSE;
                                OldValueEntry.MODIFY;
                            END;
                        UNTIL OldValueEntry.NEXT = 0;
                END;

                OldItemLedgEntry."Remaining Quantity" := OldItemLedgEntry."Remaining Quantity" + AppliedQty;
                OldItemLedgEntry.Open := OldItemLedgEntry."Remaining Quantity" <> 0;

                IF ItemLedgEntry.Positive THEN BEGIN
                    IF ItemLedgEntry."Posting Date" >= OldItemLedgEntry."Posting Date" THEN
                        InsertApplEntry(
                          OldItemLedgEntry."Entry No.", ItemLedgEntry."Entry No.",
                          OldItemLedgEntry."Entry No.", 0, ItemLedgEntry."Posting Date", -AppliedQty, FALSE)
                    ELSE
                        InsertApplEntry(
                          OldItemLedgEntry."Entry No.", ItemLedgEntry."Entry No.",
                          OldItemLedgEntry."Entry No.", 0, OldItemLedgEntry."Posting Date", -AppliedQty, FALSE);

                    IF ItemApplnEntry."Cost Application" THEN
                        ItemLedgEntry."Applied Entry to Adjust" := TRUE;
                END ELSE BEGIN
                    IF ItemTrackingCode."Strict Expiration Posting" AND (OldItemLedgEntry."Expiration Date" <> 0D) AND
                       NOT ItemLedgEntry.Correction AND
                       NOT (ItemLedgEntry."Document Type" IN
                            [ItemLedgEntry."Document Type"::"Purchase Return Shipment", ItemLedgEntry."Document Type"::"Purchase Credit Memo"])
                    THEN
                        IF ItemLedgEntry."Posting Date" > OldItemLedgEntry."Expiration Date" THEN
                            IF (ItemLedgEntry."Entry Type" <> ItemLedgEntry."Entry Type"::"Negative Adjmt.") AND
                               NOT ItemJnlLine.IsReclass(ItemJnlLine)
                            THEN
                                OldItemLedgEntry.FIELDERROR("Expiration Date", Text017);

                    InsertApplEntry(
                      ItemLedgEntry."Entry No.", OldItemLedgEntry."Entry No.", ItemLedgEntry."Entry No.", 0,
                      ItemLedgEntry."Posting Date", AppliedQty, TRUE);

                    IF ItemApplnEntry."Cost Application" THEN
                        OldItemLedgEntry."Applied Entry to Adjust" := TRUE;
                END;

                OldItemLedgEntry.MODIFY;
                AutoTrack(OldItemLedgEntry);

                EnsureValueEntryLoaded(ValueEntry, ItemLedgEntry);
                GetValuationDate(ValueEntry, OldItemLedgEntry);

                IF (ItemLedgEntry."Entry Type" = ItemLedgEntry."Entry Type"::Transfer) AND
                   (AppliedQty < 0) AND
                   NOT CausedByTransfer
                THEN BEGIN
                    IF ItemLedgEntry."Completely Invoiced" THEN
                        ItemLedgEntry."Completely Invoiced" := OldItemLedgEntry."Completely Invoiced";
                    IF AverageTransfer THEN
                        TotalAppliedQty := TotalAppliedQty + AppliedQty
                    ELSE
                        InsertTransferEntry(ItemLedgEntry, OldItemLedgEntry, AppliedQty);
                END;

                ItemLedgEntry."Remaining Quantity" := ItemLedgEntry."Remaining Quantity" - AppliedQty;
                ItemLedgEntry.Open := ItemLedgEntry."Remaining Quantity" <> 0;

                ItemLedgEntry.CALCFIELDS("Reserved Quantity");
                IF ItemLedgEntry."Remaining Quantity" + ItemLedgEntry."Reserved Quantity" = 0 THEN
                    EXIT;
            END;
        UNTIL FALSE;
    end;

    local procedure EnsureValueEntryLoaded(var ValueEntry: Record "Value Entry"; ItemLedgEntry: Record "Item Ledger Entry")
    begin
        ValueEntry.SETCURRENTKEY("Item Ledger Entry No.");
        ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
        IF ValueEntry.FIND('-') THEN;
    end;

    local procedure AllowProdApplication(OldItemLedgEntry: Record "Item Ledger Entry"; ItemLedgEntry: Record "Item Ledger Entry"): Boolean
    begin
        EXIT(
          (OldItemLedgEntry."Entry Type" = ItemLedgEntry."Entry Type") OR
          (OldItemLedgEntry."Order No." <> ItemLedgEntry."Order No.") OR
          ((OldItemLedgEntry."Order No." = ItemLedgEntry."Order No.") AND
           (OldItemLedgEntry."Order Line No." <> ItemLedgEntry."Order Line No.")));
    end;

    local procedure InitValueEntryNo()
    begin
        IF ValueEntryNo > 0 THEN
            EXIT;
        GlobalValueEntry.CHANGECOMPANY(ChangeToCompany);
        GlobalValueEntry.LOCKTABLE;
        IF GlobalValueEntry.FINDLAST THEN
            ValueEntryNo := GlobalValueEntry."Entry No.";
    end;

    local procedure InsertTransferEntry(var ItemLedgEntry: Record "Item Ledger Entry"; var OldItemLedgEntry: Record "Item Ledger Entry"; AppliedQty: Decimal)
    var
        NewItemLedgEntry: Record "Item Ledger Entry";
        NewValueEntry: Record "Value Entry";
        ItemLedgEntry2: Record "Item Ledger Entry";
        TransLine: Record "Transfer Line";
        Location2: Record Location;
    begin
        InitItemLedgEntry(NewItemLedgEntry);
        NewItemLedgEntry."Applies-to Entry" := 0;

        NewItemLedgEntry.Quantity := -AppliedQty;
        NewItemLedgEntry."Invoiced Quantity" := NewItemLedgEntry.Quantity;

        NewItemLedgEntry."Remaining Quantity" := NewItemLedgEntry.Quantity;
        NewItemLedgEntry.Open := NewItemLedgEntry."Remaining Quantity" <> 0;
        NewItemLedgEntry.Positive := NewItemLedgEntry."Remaining Quantity" > 0;

        NewItemLedgEntry."Location Code" := ItemJnlLine."New Location Code";
        NewItemLedgEntry."Country/Region Code" := ItemJnlLine."Country/Region Code";
        InsertCountryCode(NewItemLedgEntry, ItemLedgEntry);

        NewItemLedgEntry."Serial No." := ItemJnlLine."New Serial No.";
        NewItemLedgEntry."Lot No." := ItemJnlLine."New Lot No.";

        NewItemLedgEntry."Expiration Date" := ItemJnlLine."New Item Expiration Date";

        IF Item."Item Tracking Code" <> '' THEN BEGIN
            TempItemEntryRelation."Item Entry No." := NewItemLedgEntry."Entry No.";
            // Save Entry No. in a global variable
            TempItemEntryRelation."Serial No." := NewItemLedgEntry."Serial No.";
            TempItemEntryRelation."Lot No." := NewItemLedgEntry."Lot No.";
            TempItemEntryRelation.INSERT;
        END;
        /* IF (("Order Type" = "Order Type"::Transfer) AND ("Order No." <> '')) AND
            "From Transfer Order" AND (Location2.GET("New Location Code") AND NOT Location2."Use As In-Transit") AND
            "Rcpt. Posting"
         THEN BEGIN
             TransLine.GET("Order No.", "Document Line No.");
             TransLine."Qty. to Receive" := NewItemLedgEntry.Quantity;
               TransLine."BED Amount" := BEDAmt;
                TransLine."AED(GSI) Amount" := AEDGSIAmt;
                TransLine."AED(TTA) Amount" := AEDTTAAmt;
                TransLine."SED Amount" := SEDAmt;
                TransLine."SAED Amount" := SAEDAmt;
                TransLine."CESS Amount" := CESSAmt;
                TransLine."NCCD Amount" := NCCDAmt;
                TransLine."eCess Amount" := eCessAmt;
                TransLine."SHE Cess Amount" := SHECessAmt;
                TransLine."ADET Amount" := ADETAmt;
                TransLine."ADE Amount" := ADEAmt;
                TransLine."ADC VAT Amount" := ADCVATAmt;
                TransLine."Excise Base Amount" := ExciseBaseAmt;
                TransLine."Excise Amount" := ExciseAmt;
                ExciseInsertRGRegisters.SetILENo(ItemLedgEntryNo);
                ExciseInsertRGRegisters.InitRG23DTransferRcpt(TransLine, 1, 1, 0, '', "Document No.", 0);
                ExciseInsertRGRegisters.SetILENo(0);
         END;*/
        // 15578
        InitTransValueEntry(NewValueEntry, NewItemLedgEntry);

        IF AverageTransfer THEN BEGIN
            InsertApplEntry(
              NewItemLedgEntry."Entry No.", NewItemLedgEntry."Entry No.", ItemLedgEntry."Entry No.",
              0, NewItemLedgEntry."Posting Date", NewItemLedgEntry.Quantity, TRUE);
            NewItemLedgEntry."Completely Invoiced" := ItemLedgEntry."Completely Invoiced";
        END ELSE BEGIN
            InsertApplEntry(
              NewItemLedgEntry."Entry No.", NewItemLedgEntry."Entry No.", ItemLedgEntry."Entry No.",
              OldItemLedgEntry."Entry No.", NewItemLedgEntry."Posting Date", NewItemLedgEntry.Quantity, TRUE);
            NewItemLedgEntry."Completely Invoiced" := OldItemLedgEntry."Completely Invoiced";
        END;

        IF NewItemLedgEntry.Quantity > 0 THEN
            ReserveItemJnlLine.TransferItemJnlToItemLedgEntry(ItemJnlLine, NewItemLedgEntry,
              NewItemLedgEntry."Remaining Quantity", TRUE);

        ApplyItemLedgEntry(NewItemLedgEntry, ItemLedgEntry2, NewValueEntry, TRUE);
        AutoTrack(NewItemLedgEntry);

        OnBeforeInsertTransferEntry(NewItemLedgEntry, OldItemLedgEntry, ItemJnlLine);

        InsertItemLedgEntry(NewItemLedgEntry, TRUE);
        InsertValueEntry(NewValueEntry, NewItemLedgEntry, TRUE);

        UpdateUnitCost(NewValueEntry);

    end;

    local procedure InitItemLedgEntry(var ItemLedgEntry: Record "Item Ledger Entry")
    var
        Fromlocation: Record Location;
        Tolocation: Record Location;
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        ItemLedgEntryNo := ItemLedgEntryNo + 1;
        ItemLedgEntry.CHANGECOMPANY(ChangeToCompany);
        WITH ItemJnlLine DO BEGIN
            ItemLedgEntry.INIT;
            ItemLedgEntry."Entry No." := ItemLedgEntryNo;
            ItemLedgEntry."Item No." := "Item No.";
            ItemLedgEntry."Posting Date" := "Posting Date";
            ItemLedgEntry."Document Date" := "Document Date";
            ItemLedgEntry."Entry Type" := "Entry Type";
            ItemLedgEntry."Source No." := "Source No.";
            ItemLedgEntry."Document No." := "Document No.";
            ItemLedgEntry."Document Type" := "Document Type";
            ItemLedgEntry."Document Line No." := "Document Line No.";
            ItemLedgEntry."Order Type" := "Order Type";
            ItemLedgEntry."Order No." := "Order No.";
            ItemLedgEntry."Order Line No." := "Order Line No.";
            ItemLedgEntry."External Document No." := "External Document No.";
            ItemLedgEntry."Subcon Order No." := "Subcon Order No.";
            ItemLedgEntry.Description := Description;
            ItemLedgEntry."Location Code" := "Location Code";
            ItemLedgEntry."Applies-to Entry" := "Applies-to Entry";
            ItemLedgEntry."Source Type" := "Source Type";
            ItemLedgEntry."Transaction Type" := "Transaction Type";
            ItemLedgEntry."Transport Method" := "Transport Method";
            ItemLedgEntry."Country/Region Code" := "Country/Region Code";
            IF ("Entry Type" = "Entry Type"::Transfer) AND ("New Location Code" <> '') THEN BEGIN
                IF NewLocation.Code <> "New Location Code" THEN
                    NewLocation.GET("New Location Code");
                ItemLedgEntry."Country/Region Code" := NewLocation."Country/Region Code";
                // 15578   ItemLedgEntry."Captive Consumption" := "Captive Consumption";
            END;
            ItemLedgEntry."Entry/Exit Point" := "Entry/Exit Point";
            ItemLedgEntry.Area := Area;
            ItemLedgEntry."Transaction Specification" := "Transaction Specification";
            ItemLedgEntry."Drop Shipment" := "Drop Shipment";
            ItemLedgEntry."Assemble to Order" := "Assemble to Order";
            ItemLedgEntry."No. Series" := "Posting No. Series";
            IF ItemLedgEntry.Description = Item.Description THEN
                ItemLedgEntry.Description := '';
            ItemLedgEntry."Prod. Order Comp. Line No." := "Prod. Order Comp. Line No.";
            ItemLedgEntry."Variant Code" := "Variant Code";
            ItemLedgEntry."Unit of Measure Code" := "Unit of Measure Code";
            ItemLedgEntry."Qty. per Unit of Measure" := "Qty. per Unit of Measure";
            ItemLedgEntry."Derived from Blanket Order" := "Derived from Blanket Order";

            ItemLedgEntry."Production Plant Code" := "Production Plant Code";//TRI S.R 210310 - New Code Add
            ItemLedgEntry."Gross Weight" := "Gross Weight";//TRI S.R 210310 - New Code Add
            ItemLedgEntry."Net Weight" := "Net Weight";//TRI S.R 210310 - New Code Add
            ItemLedgEntry."Direct Consumption Entries" := "Direct Consumption Entries";//TRI S.R 210310 - New Code Add
            ItemLedgEntry.ReProcess := ReProcess;//TRI S.C
            ItemLedgEntry."Output Date" := "OutPut Date";  //TRI S.K  21.06.10
            ItemLedgEntry."Depot. Prod Order" := "Depot. Prod Order";//TRI S.R 210310 - New Code Add
                                                                     //ItemLedgerEntry."Capex No.":="Capex No.";//Ori Ut
                                                                     //TRI S.K Add New 23.06.10
            IF ProdOrder.GET(ProdOrder.Status::Released, "Order No.") THEN BEGIN
                ItemLedgEntry."Re Process Production Order" := ProdOrder."Re Process Production Order";
                ItemLedgEntry."Original Prod. No" := ProdOrder."Original Prod. No";
            END;
            ItemLedgEntry."Work Shift Code" := "Work Shift Code";

            /*   ItemLedgEntry."Assessable Value" := "Assessable Value";
               ItemLedgEntry."BED %" := "BED %";
               ItemLedgEntry."BED Amount" := "BED Amount";
               ItemLedgEntry."Other Duties Amount" := "Other Duties Amount";
               ItemLedgEntry."Other Duties %" := "Other Duties %";*/ // 15578

            ItemLedgEntry."External Transfer" := "External Transfer"; //ND

            //  ItemLedgEntry."Cross-Reference No." := "Cross-Reference No.";
            ItemLedgEntry."Originally Ordered No." := "Originally Ordered No.";
            ItemLedgEntry."Originally Ordered Var. Code" := "Originally Ordered Var. Code";
            ItemLedgEntry."Out-of-Stock Substitution" := "Out-of-Stock Substitution";
            ItemLedgEntry."Item Category Code" := "Item Category Code";
            ItemLedgEntry.Nonstock := Nonstock;
            ItemLedgEntry."Purchasing Code" := "Purchasing Code";
            ItemLedgEntry."Return Reason Code" := "Return Reason Code";
            // 15578    ItemLedgEntry."Product Group Code" := "Product Group Code";

            //TRI
            ItemLedgEntry."ILE Entry No. 3.7" := "ILE Entry No. 3.7";
            //TRI
            ItemLedgEntry."Capex No." := "Capex No.";//MSBS.Rao 081114

            ItemLedgEntry."Job No." := "Job No.";
            ItemLedgEntry."Job Task No." := "Job Task No.";
            ItemLedgEntry."Job Purchase" := "Job Purchase";
            ItemLedgEntry."Serial No." := "Serial No.";
            ItemLedgEntry."Lot No." := "Lot No.";
            ItemLedgEntry."Warranty Date" := "Warranty Date";
            ItemLedgEntry."Expiration Date" := "Item Expiration Date";

            ItemLedgEntry.Correction := Correction;

            /*  ItemLedgEntry."Other Usage" := "Other Usage";
              ItemLedgEntry."Nature of Disposal" := "Nature of Disposal";
              ItemLedgEntry."Routing Link Code" := "Routing Link Code"; //TRI-VKG ADD
              ItemLedgEntry."Type of Disposal" := "Type of Disposal";

              IF "Nature of Disposal" = '' THEN
                  ItemLedgEntry."Nature of Disposal" := GetNatureOfDisposal("Entry Type");
              ItemLedgEntry."Reason Code" := "Reason Code";
              ItemLedgEntry."Re-Dispatch" := "Re-Dispatch";*/ // 15578
            IF "Entry Type" IN
               ["Entry Type"::Sale,
                "Entry Type"::"Negative Adjmt.",
                "Entry Type"::Transfer,
                "Entry Type"::Consumption,
                "Entry Type"::"Assembly Consumption"]
            THEN BEGIN
                ItemLedgEntry.Quantity := -Quantity;
                ItemLedgEntry."Invoiced Quantity" := -"Invoiced Quantity";
            END ELSE BEGIN
                ItemLedgEntry.Quantity := Quantity;
                ItemLedgEntry."Invoiced Quantity" := "Invoiced Quantity";
            END;
            IF (ItemLedgEntry.Quantity < 0) AND ("Entry Type" <> "Entry Type"::Transfer) THEN
                ItemLedgEntry."Shipped Qty. Not Returned" := ItemLedgEntry.Quantity;
            /*   ItemLedgEntry."Laboratory Test" := "Laboratory Test";
               IF "Laboratory Test" = TRUE THEN BEGIN
                   Fromlocation.GET("Location Code");
                   Tolocation.GET("New Location Code");
                   IF "Applies-to Entry" = 0 THEN BEGIN
                       IF (Fromlocation."Testing Location" = FALSE) AND
                          (Tolocation."Testing Location" = FALSE)
                       THEN
                           ERROR(Text16500, Tolocation.Name);
                       IF (Fromlocation."Testing Location" = TRUE) AND
                          (Tolocation."Testing Location" = TRUE)
                       THEN
                           ERROR(Text16501, Fromlocation.Name, Tolocation.Name);
                       IF (Fromlocation."Testing Location" = TRUE) AND
                          (Tolocation."Testing Location" = FALSE)
                       THEN
                           ERROR(Text16502, Fromlocation.Name, Tolocation.Name);
                   END ELSE BEGIN
                       IF (Fromlocation."Testing Location" = FALSE) AND
                          (Tolocation."Testing Location" = FALSE)
                       THEN
                           ERROR(Text16503, Fromlocation.Name, Tolocation.Name);
                       IF (Fromlocation."Testing Location" = TRUE) AND
                          (Tolocation."Testing Location" = TRUE)
                       THEN
                           ERROR(Text16501);
                       IF ItemLedgerEntry.GET("Applies-to Entry") THEN
                           IF ItemLedgerEntry."Laboratory Test" = FALSE THEN
                               ERROR(Text16504);
                   END;
               END ELSE
                   IF "Applies-to Entry" <> 0 THEN
                       IF ItemLedgerEntry.GET("Applies-to Entry") THEN
                           IF ItemLedgerEntry."Laboratory Test" = TRUE THEN
                               ERROR(Text16505);*/ // 15578
        END;

        OnAfterInitItemLedgEntry(ItemLedgEntry, ItemJnlLine);
    end;

    local procedure InsertItemLedgEntry(var ItemLedgEntry: Record "Item Ledger Entry"; TransferItem: Boolean)
    begin
        ItemJnlLine.CHANGECOMPANY(ChangeToCompany);
        ItemLedgEntry.CHANGECOMPANY(ChangeToCompany);
        IF ItemLedgEntry.Open THEN BEGIN
            ItemLedgEntry.VerifyOnInventory;
            IF NOT ((ItemJnlLine."Document Type" IN [ItemJnlLine."Document Type"::"Purchase Return Shipment", ItemJnlLine."Document Type"::"Purchase Receipt"]) AND
                    (ItemJnlLine."Job No." <> ''))
            THEN
                IF (ItemLedgEntry.Quantity < 0) AND
                   (ItemTrackingCode."SN Specific Tracking" OR ItemTrackingCode."Lot Specific Tracking")
                THEN
                    ERROR(Text018, ItemJnlLine."Serial No.", ItemJnlLine."Lot No.", ItemJnlLine."Item No.", ItemJnlLine."Variant Code");

            IF ItemTrackingCode."SN Specific Tracking" THEN BEGIN
                IF ItemLedgEntry.Quantity > 0 THEN
                    IF ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Transfer THEN BEGIN
                        IF ItemTrackingMgt.FindInInventory(ItemJnlLine."Item No.", ItemJnlLine."Variant Code", ItemJnlLine."New Serial No.") THEN
                            ERROR(Text014, ItemJnlLine."New Serial No.");
                    END ELSE BEGIN
                        IF ItemTrackingMgt.FindInInventory(ItemJnlLine."Item No.", ItemJnlLine."Variant Code", ItemJnlLine."Serial No.") THEN
                            ERROR(Text014, ItemJnlLine."Serial No.");
                    END;

                IF NOT (ItemLedgEntry.Quantity IN [-1, 0, 1]) THEN
                    ERROR(Text033);
            END;


            IF ItemJnlLine."Inter Company" = TRUE THEN BEGIN
                Item.Reserve := Item.Reserve::Never
            END ELSE BEGIN
                IF (ItemJnlLine."Document Type" <> ItemJnlLine."Document Type"::"Purchase Return Shipment") AND (ItemJnlLine."Job No." = '') THEN BEGIN
                    IF (Item.Reserve = Item.Reserve::Always) AND
                       (ItemLedgEntry.Quantity < 0)
                    THEN
                        ERROR(Text012, ItemLedgEntry."Item No.", ItemJnlLine."Line No.");
                END;
            END;
        END;
        //MS-PB END
        IF TransferItem THEN BEGIN
            ItemLedgEntry."Global Dimension 1 Code" := ItemJnlLine."New Shortcut Dimension 1 Code";
            ItemLedgEntry."Global Dimension 2 Code" := ItemJnlLine."New Shortcut Dimension 2 Code";
            ItemLedgEntry."Dimension Set ID" := ItemJnlLine."New Dimension Set ID";
        END ELSE BEGIN
            ItemLedgEntry."Global Dimension 1 Code" := ItemJnlLine."Shortcut Dimension 1 Code";
            ItemLedgEntry."Global Dimension 2 Code" := ItemJnlLine."Shortcut Dimension 2 Code";
            ItemLedgEntry."Dimension Set ID" := ItemJnlLine."Dimension Set ID";
            ItemLedgEntry."Machine Code" := ItemJnlLine."Machine Code";
            //MSSS
        END;

        IF NOT (ItemJnlLine."Entry Type" IN [ItemJnlLine."Entry Type"::Transfer, ItemJnlLine."Entry Type"::Output]) AND
           (ItemLedgEntry.Quantity = ItemLedgEntry."Invoiced Quantity")
        THEN
            ItemLedgEntry."Completely Invoiced" := TRUE;

        IF (ItemJnlLine."Value Entry Type" = ItemJnlLine."Value Entry Type"::"Direct Cost") AND (ItemJnlLine."Item Charge No." = '') AND
           (ItemJnlLine."Invoiced Quantity" <> 0) AND (ItemJnlLine."Posting Date" > ItemLedgEntry."Last Invoice Date")
        THEN
            ItemLedgEntry."Last Invoice Date" := ItemJnlLine."Posting Date";

        IF ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Consumption THEN
            ItemLedgEntry."Applied Entry to Adjust" := TRUE;



        IF ItemLedgEntry.Quantity < 0 THEN
        //TRI P.G 18.05.2010 --NEW CODE ADDED TO STOP CHECK ON POSITIVE ENTRY
        BEGIN
            //Vipul Tri1.0 22.11.05 Start
            Item.SETFILTER(Item."Date Filter", '..%1', ItemJnlLine."Posting Date");
            Item.SETFILTER(Item."Location Filter", '%1', ItemLedgEntry."Location Code");
            Item.SETFILTER(Item."Variant Filter", '%1', ItemLedgEntry."Variant Code");

            Item.CALCFIELDS(Item."Net Change");
        END;
        //TRI P.G 18.05.2010 -- NEW CODE ADDED TO STOP CHECK ON POSITIVE ENTRY
        IF ItemLedgEntry."Remaining Quantity" < 0 THEN BEGIN
        END
        ELSE BEGIN
            //mo tri1.0 Customization no.40 end
            //mo tri1.0 Customization no.s-16 start
            ItemNo1 := ItemLedgEntry."Item No.";
            Item.RESET;
            Item.CHANGECOMPANY(ChangeToCompany);
            Item.SETRANGE(Item."No.", ItemNo);
            TypeCode := Item."Type Code";
            SizeCode := Item."Size Code";
            PlantCode := Item."Plant Code";
            DesignCode := Item."Design Code";
            QualityCode := Item."Quality Code";
            ColorCode := Item."Color Code";
            PackingCode := Item."Packing Code";
            ItemLedgEntry."Type Code" := TypeCode;
            ItemLedgEntry."Size Code" := SizeCode;
            ItemLedgEntry."Plant Code" := PlantCode;
            ItemLedgEntry."Design Code" := DesignCode;
            ItemLedgEntry."Packing Code" := PackingCode;
            ItemLedgEntry."Category Code" := Item."Type Catogery Code";
            //ND
            ItemLedgEntry."Color Code" := ColorCode;//rahul 160805
            ItemLedgEntry."Quality Code" := QualityCode;//rahul 160805
                                                        //TRI LM 100308 start
            ItemLedgEntry."Group Code" := ItemJnlLine."Group Code";
            //TRI LM 100308 End
        END;
        //mo tri1.0 Customization no.s-16 end
        //ND tri1.0 Start
        LocationRec.CHANGECOMPANY(ChangeToCompany);
        IF LocationRec.GET(ItemLedgEntry."Location Code") THEN BEGIN
            ItemLedgEntry."Main Location" := LocationRec."Main Location";
            ItemLedgEntry.InTransit := LocationRec."Use As In-Transit";
        END;

        ItemLedgEntry."Qty in Sq.Mt." := Item.UomToSqm(ItemLedgEntry."Item No.", Item."Base Unit of Measure",
                                         ItemLedgEntry.Quantity);

        ItemLedgEntry."Qty In Carton" := Item.UomToCart(ItemLedgEntry."Item No.", Item."Base Unit of Measure",
                                         ItemLedgEntry.Quantity);

        ItemLedgEntry."Qty in PCS." := Item.UomToPcs(ItemLedgEntry."Item No.", Item."Base Unit of Measure",
                                         ItemLedgEntry.Quantity);
        //ND tri1.0 End
        //mo tri1.0 Start
        LocationRec.CHANGECOMPANY(ChangeToCompany);
        IF LocationRec.GET(ItemLedgEntry."Location Code") THEN BEGIN
            IF LocationRec."Main Location" <> '' THEN
                ItemLedgEntry."Relational Location Code" := LocationRec."Main Location"
            ELSE
                ItemLedgEntry."Relational Location Code" := LocationRec.Code;
        END;
        //mo tri1.0 End
        IF ItemJnlLine."Job No." <> '' THEN BEGIN
            ItemLedgEntry."Job No." := ItemJnlLine."Job No.";
            ItemLedgEntry."Job Task No." := ItemJnlLine."Job Task No.";
        END;

        ItemLedgEntry.UpdateItemTracking;
        // ItemLedgEntry."Production Plant Code":=Item."Default Prod. Plant Code"; //MSKS1905
        //TRI V.D 23.08.10 START
        IF ItemLedgEntry."Entry Type" <> ItemLedgEntry."Entry Type"::Transfer THEN BEGIN
            IF ItemLedgEntry."Unit of Measure Code" = 'CRT' THEN BEGIN
                IF STRPOS(FORMAT(ItemLedgEntry."Qty In Carton"), '.') <> 0 THEN
                    ERROR(tgText001, ItemLedgEntry."Qty In Carton");
            END;
        END;
        ItemLedgEntry."Capex No." := ItemJnlLine."Capex No.";//Ori Ut
                                                             //MSKS0308 Start
        IF ItemJnlLine."Production Plant Code" <> '' THEN
            ItemLedgEntry."Production Plant Code" := ItemJnlLine."Production Plant Code";
        //MSKS0308 End
        //TRI V.D 23.08.10 STOP
        //MS-PB BEGIN
        ItemLedgEntry."Inter Company" := ItemJnlLine."Inter Company";
        ItemLedgEntry."IC Line No." := ItemJnlLine."IC Line No.";
        //MS-PB END
        ItemLedgEntry."Physical Journal Entry" := ItemJnlLine."Physical Journal Entry";
        ItemLedgEntry."Physical Journal Key" := ItemJnlLine."Physical Journal Key";
        ItemLedgEntry.CHANGECOMPANY(ChangeToCompany);
        ItemLedgEntry.INSERT(TRUE);
        OnAfterInsertItemLedgEntry(ItemLedgEntry, ItemJnlLine);
        InsertItemReg(ItemLedgEntry."Entry No.", 0, 0, 0);

    end;

    local procedure InsertItemReg(ItemLedgEntryNo: Integer; PhysInvtEntryNo: Integer; ValueEntryNo: Integer; CapLedgEntryNo: Integer)
    begin
        ItemReg.CHANGECOMPANY(ChangeToCompany);
        ItemJnlLine.CHANGECOMPANY(ChangeToCompany);
        WITH ItemJnlLine DO BEGIN
            IF ItemReg."No." = 0 THEN BEGIN
                ItemReg.LOCKTABLE;
                IF ItemReg.FINDLAST THEN
                    ItemReg."No." := ItemReg."No." + 1
                ELSE
                    ItemReg."No." := 1;
                ItemReg.INIT;
                ItemReg."From Entry No." := ItemLedgEntryNo;
                ItemReg."To Entry No." := ItemLedgEntryNo;
                ItemReg."From Phys. Inventory Entry No." := PhysInvtEntryNo;
                ItemReg."To Phys. Inventory Entry No." := PhysInvtEntryNo;
                ItemReg."From Value Entry No." := ValueEntryNo;
                ItemReg."To Value Entry No." := ValueEntryNo;
                ItemReg."From Capacity Entry No." := CapLedgEntryNo;
                ItemReg."To Capacity Entry No." := CapLedgEntryNo;
                ItemReg."Creation Date" := TODAY;
                ItemReg."Source Code" := "Source Code";
                ItemReg."Journal Batch Name" := "Journal Batch Name";
                ItemReg."User ID" := USERID;
                ItemReg.INSERT;
            END ELSE BEGIN
                IF ((ItemLedgEntryNo < ItemReg."From Entry No.") AND (ItemLedgEntryNo <> 0)) OR
                   ((ItemReg."From Entry No." = 0) AND (ItemLedgEntryNo > 0))
                THEN
                    ItemReg."From Entry No." := ItemLedgEntryNo;
                IF ItemLedgEntryNo > ItemReg."To Entry No." THEN
                    ItemReg."To Entry No." := ItemLedgEntryNo;

                IF ((PhysInvtEntryNo < ItemReg."From Phys. Inventory Entry No.") AND (PhysInvtEntryNo <> 0)) OR
                   ((ItemReg."From Phys. Inventory Entry No." = 0) AND (PhysInvtEntryNo > 0))
                THEN
                    ItemReg."From Phys. Inventory Entry No." := PhysInvtEntryNo;
                IF PhysInvtEntryNo > ItemReg."To Phys. Inventory Entry No." THEN
                    ItemReg."To Phys. Inventory Entry No." := PhysInvtEntryNo;

                IF ((ValueEntryNo < ItemReg."From Value Entry No.") AND (ValueEntryNo <> 0)) OR
                   ((ItemReg."From Value Entry No." = 0) AND (ValueEntryNo > 0))
                THEN
                    ItemReg."From Value Entry No." := ValueEntryNo;
                IF ValueEntryNo > ItemReg."To Value Entry No." THEN
                    ItemReg."To Value Entry No." := ValueEntryNo;
                IF ((CapLedgEntryNo < ItemReg."From Capacity Entry No.") AND (CapLedgEntryNo <> 0)) OR
                   ((ItemReg."From Capacity Entry No." = 0) AND (CapLedgEntryNo > 0))
                THEN
                    ItemReg."From Capacity Entry No." := CapLedgEntryNo;
                IF CapLedgEntryNo > ItemReg."To Capacity Entry No." THEN
                    ItemReg."To Capacity Entry No." := CapLedgEntryNo;
                ItemReg.CHANGECOMPANY(ChangeToCompany);
                ItemReg.MODIFY;
            END;
        END;
    end;

    local procedure InsertPhysInventoryEntry()
    var
        PhysInvtLedgEntry: Record "Phys. Inventory Ledger Entry";
    begin
        ItemJnlLineOrigin.CHANGECOMPANY(ChangeToCompany);

        WITH ItemJnlLineOrigin DO BEGIN
            IF PhysInvtEntryNo = 0 THEN BEGIN
                PhysInvtLedgEntry.LOCKTABLE;
                IF PhysInvtLedgEntry.FINDLAST THEN
                    PhysInvtEntryNo := PhysInvtLedgEntry."Entry No.";
            END;

            PhysInvtEntryNo := PhysInvtEntryNo + 1;
            PhysInvtLedgEntry.CHANGECOMPANY(ChangeToCompany);
            PhysInvtLedgEntry.INIT;
            PhysInvtLedgEntry."Entry No." := PhysInvtEntryNo;
            PhysInvtLedgEntry."Item No." := "Item No.";
            PhysInvtLedgEntry."Posting Date" := "Posting Date";
            PhysInvtLedgEntry."Document Date" := "Document Date";
            PhysInvtLedgEntry."Entry Type" := "Entry Type";
            PhysInvtLedgEntry."Document No." := "Document No.";
            PhysInvtLedgEntry."External Document No." := "External Document No.";
            PhysInvtLedgEntry.Description := Description;
            PhysInvtLedgEntry."Location Code" := "Location Code";
            PhysInvtLedgEntry."Inventory Posting Group" := "Inventory Posting Group";
            PhysInvtLedgEntry."Unit Cost" := "Unit Cost";
            PhysInvtLedgEntry.Amount := Amount;
            PhysInvtLedgEntry."Salespers./Purch. Code" := "Salespers./Purch. Code";
            PhysInvtLedgEntry."Source Code" := "Source Code";
            PhysInvtLedgEntry."Global Dimension 1 Code" := "Shortcut Dimension 1 Code";
            PhysInvtLedgEntry."Global Dimension 2 Code" := "Shortcut Dimension 2 Code";
            PhysInvtLedgEntry."Dimension Set ID" := "Dimension Set ID";
            PhysInvtLedgEntry."Journal Batch Name" := "Journal Batch Name";
            PhysInvtLedgEntry."Reason Code" := "Reason Code";
            PhysInvtLedgEntry."User ID" := USERID;
            PhysInvtLedgEntry."No. Series" := "Posting No. Series";
            IF PhysInvtLedgEntry.Description = Item.Description THEN
                PhysInvtLedgEntry.Description := '';
            PhysInvtLedgEntry."Variant Code" := "Variant Code";
            PhysInvtLedgEntry."Unit of Measure Code" := "Unit of Measure Code";

            PhysInvtLedgEntry.Quantity := Quantity;
            PhysInvtLedgEntry."Unit Amount" := "Unit Amount";
            PhysInvtLedgEntry."Qty. (Calculated)" := "Qty. (Calculated)";
            PhysInvtLedgEntry."Qty. (Phys. Inventory)" := "Qty. (Phys. Inventory)";
            PhysInvtLedgEntry."Last Item Ledger Entry No." := "Last Item Ledger Entry No.";

            PhysInvtLedgEntry."Phys Invt Counting Period Code" :=
              "Phys Invt Counting Period Code";
            PhysInvtLedgEntry."Phys Invt Counting Period Type" :=
              "Phys Invt Counting Period Type";

            PhysInvtLedgEntry.INSERT;

            InsertItemReg(0, PhysInvtLedgEntry."Entry No.", 0, 0);
        END;
    end;

    local procedure PostInventoryToGL(var ValueEntry: Record "Value Entry")
    begin
        WITH ValueEntry DO BEGIN
            IF CalledFromAdjustment AND NOT PostToGL THEN
                EXIT;
            InvtPost.SetRunOnlyCheck(TRUE, NOT PostToGL, FALSE);
            IF InvtPost.BufferInvtPosting(ValueEntry) THEN
                InvtPost.PostInvtPostBufPerEntry(ValueEntry);

            IF "Expected Cost" THEN BEGIN
                SetValueEntry(ValueEntry, "Cost Amount (Expected)", "Cost Amount (Expected) (ACY)", FALSE);
                InvtPost.SetRunOnlyCheck(TRUE, TRUE, FALSE);
                IF InvtPost.BufferInvtPosting(ValueEntry) THEN
                    InvtPost.PostInvtPostBufPerEntry(ValueEntry);
                SetValueEntry(ValueEntry, 0, 0, TRUE);
            END ELSE
                IF ("Cost Amount (Actual)" = 0) AND ("Cost Amount (Actual) (ACY)" = 0) THEN BEGIN
                    SetValueEntry(ValueEntry, 1, 1, FALSE);
                    InvtPost.SetRunOnlyCheck(TRUE, TRUE, FALSE);
                    IF InvtPost.BufferInvtPosting(ValueEntry) THEN
                        InvtPost.PostInvtPostBufPerEntry(ValueEntry);
                    SetValueEntry(ValueEntry, 0, 0, FALSE);
                END;
        END;
    end;

    local procedure SetValueEntry(var ValueEntry: Record "Value Entry"; CostAmtActual: Decimal; CostAmtActACY: Decimal; ExpectedCost: Boolean)
    begin
        ValueEntry."Cost Amount (Actual)" := CostAmtActual;
        ValueEntry."Cost Amount (Actual) (ACY)" := CostAmtActACY;
        ValueEntry."Expected Cost" := ExpectedCost;
    end;

    local procedure InsertApplEntry(ItemLedgEntryNo: Integer; InboundItemEntry: Integer; OutboundItemEntry: Integer; TransferedFromEntryNo: Integer; PostingDate: Date; Quantity: Decimal; CostToApply: Boolean)
    var
        ApplItemLedgEntry: Record "Item Ledger Entry";
        OldItemApplnEntry: Record "Item Application Entry";
        ItemApplHistoryEntry: Record "Item Application Entry History";
        ItemApplnEntryExists: Boolean;
        RecItemLedgentry: Record "Item Ledger Entry";
        RecItemLedgentryInbound: Record "Item Ledger Entry";
        RecItemLedg: Record "Item Ledger Entry";
        TgText0001: Label 'Item %1 is not on inventory on Posting Date %2.';
    begin

        //TRI S.R 220310 - New code Add Start
        RecInbound := InboundItemEntry;
        RecOutBound := OutboundItemEntry;
        RecItemLedger := ItemLedgEntryNo;
        RecTransferentry := TransferedFromEntryNo;
        //TRI S.R 220310 - New code Add Stop

        IF Item.Type = Item.Type::Service THEN
            EXIT;

        IF ItemApplnEntryNo = 0 THEN BEGIN
            ItemApplnEntry.RESET;
            ItemApplnEntry.CHANGECOMPANY(ChangeToCompany);
            ItemApplnEntry.LOCKTABLE;
            IF ItemApplnEntry.FINDLAST THEN BEGIN
                ItemApplnEntryNo := ItemApplnEntry."Entry No.";
                ItemApplHistoryEntry.RESET;
                ItemApplHistoryEntry.CHANGECOMPANY(ChangeToCompany);
                ItemApplHistoryEntry.LOCKTABLE;
                ItemApplHistoryEntry.SETCURRENTKEY("Entry No.");
                IF ItemApplHistoryEntry.FINDLAST THEN
                    IF ItemApplHistoryEntry."Entry No." > ItemApplnEntryNo THEN
                        ItemApplnEntryNo := ItemApplHistoryEntry."Entry No.";
            END
            ELSE
                ItemApplnEntryNo := 0;
        END;


        /*
        //TRI
        IF (GlobalItemLedgEntry."Entry Type" IN [GlobalItemLedgEntry."Entry Type"::Consumption,GlobalItemLedgEntry."Entry Type"::
        Wrong Expression
        BEGIN
            IF Quantity < 0 THEN BEGIN
            RecItemLedg.GET(InboundItemEntry);
            IF PostingDate < RecItemLedg."Posting Date" THEN
             ERROR(TgText0001,RecItemLedg."Item No.",PostingDate);
            END;
        END;
        //TRI
         */

        IF Quantity < 0 THEN BEGIN
            OldItemApplnEntry.CHANGECOMPANY(ChangeToCompany);
            OldItemApplnEntry.SETCURRENTKEY("Inbound Item Entry No.", "Item Ledger Entry No.", "Outbound Item Entry No.");
            OldItemApplnEntry.SETRANGE("Inbound Item Entry No.", InboundItemEntry);
            OldItemApplnEntry.SETRANGE("Item Ledger Entry No.", ItemLedgEntryNo);
            OldItemApplnEntry.SETRANGE("Outbound Item Entry No.", OutboundItemEntry);
            IF OldItemApplnEntry.FINDFIRST THEN BEGIN
                ItemApplnEntry := OldItemApplnEntry;
                ItemApplnEntry.Quantity := ItemApplnEntry.Quantity + Quantity;
                ItemApplnEntry."Last Modified Date" := CURRENTDATETIME;
                ItemApplnEntry."Last Modified By User" := USERID;
                ItemApplnEntry.MODIFY;
                ItemApplnEntryExists := TRUE;
            END;
        END;

        IF NOT ItemApplnEntryExists THEN BEGIN
            ItemApplnEntryNo := ItemApplnEntryNo + 1;
            ItemApplnEntry.INIT;
            ItemApplnEntry."Entry No." := ItemApplnEntryNo;
            ItemApplnEntry."Item Ledger Entry No." := ItemLedgEntryNo;
            ItemApplnEntry."Inbound Item Entry No." := InboundItemEntry;
            ItemApplnEntry."Outbound Item Entry No." := OutboundItemEntry;
            ItemApplnEntry."Transferred-from Entry No." := TransferedFromEntryNo;
            ItemApplnEntry.Quantity := Quantity;
            ItemApplnEntry."Posting Date" := PostingDate;
            ItemApplnEntry."Output Completely Invd. Date" := GetOutputComplInvcdDate(ItemApplnEntry);

            IF AverageTransfer THEN BEGIN
                IF (Quantity > 0) OR (ItemJnlLine."Document Type" = ItemJnlLine."Document Type"::"Transfer Receipt") THEN
                    ItemApplnEntry."Cost Application" := TRUE;
            END ELSE
                CASE TRUE OF
                    Item."Costing Method" <> Item."Costing Method"::Average,
                  ItemJnlLine.Correction AND (ItemJnlLine."Document Type" = ItemJnlLine."Document Type"::"Posted Assembly"):
                        ItemApplnEntry."Cost Application" := TRUE;
                    ItemJnlLine.Correction:
                        BEGIN
                            ApplItemLedgEntry.GET(ItemApplnEntry."Item Ledger Entry No.");
                            ItemApplnEntry."Cost Application" :=
                              (ApplItemLedgEntry.Quantity > 0) OR (ApplItemLedgEntry."Applies-to Entry" <> 0);
                        END;
                    ELSE
                        IF (ItemJnlLine."Applies-to Entry" <> 0) OR
                           (CostToApply AND ItemJnlLine.IsInbound)
                        THEN
                            ItemApplnEntry."Cost Application" := TRUE;
                END;

            ItemApplnEntry."Creation Date" := CURRENTDATETIME;
            ItemApplnEntry."Created By User" := USERID;
            ItemApplnEntry.INSERT(TRUE);
        END;

    end;

    local procedure UpdateItemApplnEntry(ItemLedgEntryNo: Integer; PostingDate: Date)
    var
        ItemApplnEntry: Record "Item Application Entry";
    begin
        ItemApplnEntry.CHANGECOMPANY(ChangeToCompany);
        WITH ItemApplnEntry DO BEGIN
            SETRANGE("Item Ledger Entry No.", ItemLedgEntryNo);
            SETRANGE("Output Completely Invd. Date", 0D);
            IF NOT ISEMPTY THEN
                MODIFYALL("Output Completely Invd. Date", PostingDate);
        END;
    end;

    local procedure GetOutputComplInvcdDate(ItemApplnEntry: Record "Item Application Entry"): Date
    var
        OutbndItemLedgEntry: Record "Item Ledger Entry";
    begin
        OutbndItemLedgEntry.CHANGECOMPANY(ChangeToCompany);
        WITH ItemApplnEntry DO BEGIN
            IF Quantity > 0 THEN
                EXIT("Posting Date");
            IF OutbndItemLedgEntry.GET("Outbound Item Entry No.") THEN
                IF OutbndItemLedgEntry."Completely Invoiced" THEN
                    EXIT(OutbndItemLedgEntry."Last Invoice Date");
        END;
    end;

    local procedure InitValueEntry(var ValueEntry: Record "Value Entry"; ItemLedgEntry: Record "Item Ledger Entry")
    var
        CalcUnitCost: Boolean;
        CostAmt: Decimal;
        CostAmtACY: Decimal;
    begin
        ValueEntryNo := ValueEntryNo + 1;
        ValueEntry.CHANGECOMPANY(ChangeToCompany);
        WITH ItemJnlLine DO BEGIN
            ValueEntry.INIT;
            ValueEntry."Entry No." := ValueEntryNo;
            IF "Value Entry Type" = "Value Entry Type"::Variance THEN
                ValueEntry."Variance Type" := "Variance Type";
            ValueEntry."Item Ledger Entry No." := ItemLedgEntry."Entry No.";
            ValueEntry."Item No." := "Item No.";
            ValueEntry."Item Charge No." := "Item Charge No.";
            ValueEntry."Order Type" := ItemLedgEntry."Order Type";
            ValueEntry."Order No." := ItemLedgEntry."Order No.";
            ValueEntry."Order Line No." := ItemLedgEntry."Order Line No.";
            ValueEntry."Item Ledger Entry Type" := "Entry Type";
            ValueEntry.Type := Type;
            ValueEntry."Posting Date" := "Posting Date";
            IF "Partial Revaluation" THEN
                ValueEntry."Partial Revaluation" := TRUE;

            IF (ItemLedgEntry.Quantity > 0) OR
               (ItemLedgEntry."Invoiced Quantity" > 0) OR
               (("Value Entry Type" = "Value Entry Type"::"Direct Cost") AND ("Item Charge No." = '')) OR
               ("Entry Type" IN ["Entry Type"::Output, "Entry Type"::"Assembly Output"]) OR
               Adjustment
            THEN
                ValueEntry.Inventoriable := Item.Type = Item.Type::Inventory;

            IF ((Quantity = 0) AND ("Invoiced Quantity" <> 0)) OR
               ("Value Entry Type" <> "Value Entry Type"::"Direct Cost") OR
               ("Item Charge No." <> '') OR Adjustment
            THEN BEGIN
                GetLastDirectCostValEntry(ValueEntry."Item Ledger Entry No.");
                IF ValueEntry.Inventoriable AND ("Item Charge No." = '') THEN
                    ValueEntry."Valued By Average Cost" := DirCostValueEntry."Valued By Average Cost";
            END;

            CASE TRUE OF
                ((Quantity = 0) AND ("Invoiced Quantity" <> 0)) OR
              (("Value Entry Type" = "Value Entry Type"::"Direct Cost") AND ("Item Charge No." <> '')) OR
              Adjustment OR ("Value Entry Type" = "Value Entry Type"::Rounding):
                    ValueEntry."Valuation Date" := DirCostValueEntry."Valuation Date";
                ("Value Entry Type" = "Value Entry Type"::Revaluation):
                    IF "Posting Date" < DirCostValueEntry."Valuation Date" THEN
                        ValueEntry."Valuation Date" := DirCostValueEntry."Valuation Date"
                    ELSE
                        ValueEntry."Valuation Date" := "Posting Date";
                (ItemLedgEntry.Quantity > 0) AND ("Applies-from Entry" <> 0):
                    GetAppliedFromValues(ValueEntry);
                ELSE
                    ValueEntry."Valuation Date" := "Posting Date";
            END;

            IF Description = Item.Description THEN
                ValueEntry.Description := ''
            ELSE
                ValueEntry.Description := Description;
            ValueEntry."Source Code" := "Source Code";
            ValueEntry."Source Type" := "Source Type";
            ValueEntry."Source No." := GetSourceNo(ItemJnlLine);
            IF ("Value Entry Type" = "Value Entry Type"::"Direct Cost") AND ("Item Charge No." = '') THEN
                ValueEntry."Inventory Posting Group" := "Inventory Posting Group"
            ELSE
                ValueEntry."Inventory Posting Group" := DirCostValueEntry."Inventory Posting Group";
            ValueEntry."Source Posting Group" := "Source Posting Group";
            ValueEntry."Salespers./Purch. Code" := "Salespers./Purch. Code";
            ValueEntry."Location Code" := ItemLedgEntry."Location Code";
            ValueEntry."Variant Code" := ItemLedgEntry."Variant Code";
            ValueEntry."Journal Batch Name" := "Journal Batch Name";
            ValueEntry."User ID" := USERID;
            ValueEntry."Drop Shipment" := "Drop Shipment";
            ValueEntry."Reason Code" := "Reason Code";
            /*    ValueEntry."Assessable Value" := "Assessable Value";
                ValueEntry."BED %" := "BED %";
                ValueEntry."BED Amount" := "BED Amount";
                ValueEntry."Other Duties Amount" := "Other Duties Amount";
                ValueEntry."Other Duties %" := "Other Duties %";*/ // 15578
            ValueEntry."Return Reason Code" := "Return Reason Code";
            ValueEntry."External Document No." := "External Document No.";
            ValueEntry."Document Date" := "Document Date";
            ValueEntry."Gen. Bus. Posting Group" := "Gen. Bus. Posting Group";
            ValueEntry."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
            ValueEntry."Discount Amount" := "Discount Amount";
            ValueEntry."Entry Type" := "Value Entry Type";

            ValueEntry.ReProcess := ReProcess;//TRI S.C
            ValueEntry."OutPut Date" := "OutPut Date";   //TRI S.K. 21.06.10
                                                         //TRI S.R 210610 - New Code Add
            IF ProdOrder.GET(ProdOrder.Status::Released, "Order No.") THEN BEGIN
                ValueEntry."Re Process Production Order" := ProdOrder."Re Process Production Order";
                ValueEntry."Original Prod. No" := ProdOrder."Original Prod. No";
            END;
            ValueEntry."Work Shift Code" := "Work Shift Code";
            //TRI S.R 210610 - New Code Add

            IF "Job No." <> '' THEN BEGIN
                ValueEntry."Job No." := "Job No.";
                ValueEntry."Job Task No." := "Job Task No.";
            END;
            IF "Invoiced Quantity" <> 0 THEN BEGIN
                ValueEntry."Valued Quantity" := "Invoiced Quantity";
                IF ("Value Entry Type" = "Value Entry Type"::"Direct Cost") AND
                   ("Item Charge No." = '')
                THEN
                    IF ("Entry Type" <> "Entry Type"::Output) OR
                       (ItemLedgEntry."Invoiced Quantity" = 0)
                    THEN
                        ValueEntry."Invoiced Quantity" := "Invoiced Quantity";
                ValueEntry."Expected Cost" := FALSE;
            END ELSE BEGIN
                ValueEntry."Valued Quantity" := Quantity;
                ValueEntry."Expected Cost" := "Value Entry Type" <> "Value Entry Type"::Revaluation;
            END;

            ValueEntry."Document Type" := "Document Type";
            IF ValueEntry."Expected Cost" OR ("Invoice No." = '') THEN
                ValueEntry."Document No." := "Document No."
            ELSE BEGIN
                ValueEntry."Document No." := "Invoice No.";
                IF "Document Type" IN [
                                       "Document Type"::"Purchase Receipt", "Document Type"::"Purchase Return Shipment",
                                       "Document Type"::"Sales Shipment", "Document Type"::"Sales Return Receipt",
                                       "Document Type"::"Service Shipment"]
                THEN
                    ValueEntry."Document Type" := "Document Type" + 1;
            END;
            ValueEntry."Document Line No." := "Document Line No.";

            IF Adjustment THEN BEGIN
                ValueEntry."Invoiced Quantity" := 0;
                ValueEntry."Applies-to Entry" := "Applies-to Value Entry";
                ValueEntry.Adjustment := TRUE;
            END;

            IF "Value Entry Type" <> "Value Entry Type"::Rounding THEN BEGIN
                IF ("Entry Type" = "Entry Type"::Output) AND
                   ("Value Entry Type" <> "Value Entry Type"::Revaluation)
                THEN BEGIN
                    CostAmt := Amount;
                    CostAmtACY := "Amount (ACY)";
                END ELSE BEGIN
                    ValueEntry."Cost per Unit" := RetrieveCostPerUnit;
                    IF GLSetup."Additional Reporting Currency" <> '' THEN
                        ValueEntry."Cost per Unit (ACY)" := RetrieveCostPerUnitACY(ValueEntry."Cost per Unit");

                    IF (ValueEntry."Valued Quantity" > 0) AND
                       (ValueEntry."Item Ledger Entry Type" IN [ValueEntry."Item Ledger Entry Type"::Purchase,
                                                                ValueEntry."Item Ledger Entry Type"::"Assembly Output"]) AND
                       (ValueEntry."Entry Type" = ValueEntry."Entry Type"::"Direct Cost") AND
                       NOT Adjustment
                    THEN BEGIN
                        IF Item."Costing Method" = Item."Costing Method"::Standard THEN
                            "Unit Cost" := ValueEntry."Cost per Unit";
                        CalcPosShares(
                          CostAmt, OverheadAmount, VarianceAmount, CostAmtACY, OverheadAmountACY, VarianceAmountACY,
                          CalcUnitCost, (Item."Costing Method" = Item."Costing Method"::Standard) AND
                          (NOT ValueEntry."Expected Cost"), ValueEntry."Expected Cost");
                        IF (OverheadAmount <> 0) OR
                           (ROUND(VarianceAmount, GLSetup."Amount Rounding Precision") <> 0) OR
                           CalcUnitCost OR ValueEntry."Expected Cost"
                        THEN BEGIN
                            ValueEntry."Cost per Unit" :=
                              CalcCostPerUnit(CostAmt, ValueEntry."Valued Quantity", FALSE);

                            IF GLSetup."Additional Reporting Currency" <> '' THEN
                                ValueEntry."Cost per Unit (ACY)" :=
                                  CalcCostPerUnit(CostAmtACY, ValueEntry."Valued Quantity", TRUE);
                        END;
                    END ELSE
                        IF NOT Adjustment THEN
                            CalcOutboundCostAmt(ValueEntry, CostAmt, CostAmtACY)
                        ELSE BEGIN
                            CostAmt := Amount;
                            CostAmtACY := "Amount (ACY)";
                        END;

                    IF ("Invoiced Quantity" < 0) AND ("Applies-to Entry" <> 0) AND
                       ("Entry Type" = "Entry Type"::Purchase) AND ("Item Charge No." = '') AND
                       (ValueEntry."Entry Type" = ValueEntry."Entry Type"::"Direct Cost")
                    THEN
                        CalcPurchCorrShares(OverheadAmount, OverheadAmountACY, VarianceAmount, VarianceAmountACY);
                END
            END ELSE BEGIN
                CostAmt := "Unit Cost";
                CostAmtACY := "Unit Cost (ACY)";
            END;

            IF (ValueEntry."Entry Type" <> ValueEntry."Entry Type"::Revaluation) AND NOT Adjustment THEN
                IF (ValueEntry."Item Ledger Entry Type" IN
                    [ValueEntry."Item Ledger Entry Type"::Sale,
                     ValueEntry."Item Ledger Entry Type"::"Negative Adjmt.",
                     ValueEntry."Item Ledger Entry Type"::Consumption,
                     ValueEntry."Item Ledger Entry Type"::"Assembly Consumption"]) OR
                   ((ValueEntry."Item Ledger Entry Type" = ValueEntry."Item Ledger Entry Type"::Transfer) AND
                    ("Value Entry Type" = "Value Entry Type"::"Direct Cost") AND ("Item Charge No." = ''))
                THEN BEGIN
                    ValueEntry."Valued Quantity" := -ValueEntry."Valued Quantity";
                    ValueEntry."Invoiced Quantity" := -ValueEntry."Invoiced Quantity";
                    IF ValueEntry."Item Ledger Entry Type" = ValueEntry."Item Ledger Entry Type"::Transfer THEN
                        ValueEntry."Discount Amount" := 0
                    ELSE
                        ValueEntry."Discount Amount" := -ValueEntry."Discount Amount";

                    IF "Value Entry Type" <> "Value Entry Type"::Rounding THEN BEGIN
                        CostAmt := -CostAmt;
                        CostAmtACY := -CostAmtACY;
                    END;
                END;
            IF NOT Adjustment THEN
                IF Item."Inventory Value Zero" OR
                   (("Entry Type" = "Entry Type"::Transfer) AND
                    (ValueEntry."Valued Quantity" < 0) AND NOT AverageTransfer) OR
                   (("Entry Type" = "Entry Type"::Sale) AND
                    ("Item Charge No." <> ''))
                THEN BEGIN
                    CostAmt := 0;
                    CostAmtACY := 0;
                    ValueEntry."Cost per Unit" := 0;
                    ValueEntry."Cost per Unit (ACY)" := 0;
                END;

            CASE TRUE OF
                (NOT ValueEntry."Expected Cost") AND ValueEntry.Inventoriable AND
                IsInterimRevaluation:
                    BEGIN
                        ValueEntry."Cost Amount (Expected)" := ROUND(CostAmt * "Applied Amount" / Amount);
                        ValueEntry."Cost Amount (Expected) (ACY)" := ROUND(CostAmtACY * "Applied Amount" / Amount,
                            Currency."Amount Rounding Precision");

                        CostAmt := ROUND(CostAmt);
                        CostAmtACY := ROUND(CostAmtACY, Currency."Amount Rounding Precision");
                        ValueEntry."Cost Amount (Actual)" := CostAmt - ValueEntry."Cost Amount (Expected)";
                        ValueEntry."Cost Amount (Actual) (ACY)" := CostAmtACY - ValueEntry."Cost Amount (Expected) (ACY)";
                    END;
                (NOT ValueEntry."Expected Cost") AND ValueEntry.Inventoriable:
                    BEGIN
                        IF NOT Adjustment AND ("Value Entry Type" = "Value Entry Type"::"Direct Cost") THEN
                            CASE "Entry Type" OF
                                "Entry Type"::Sale:
                                    ValueEntry."Sales Amount (Actual)" := Amount;
                                "Entry Type"::Purchase:
                                    ValueEntry."Purchase Amount (Actual)" := Amount;
                            END;
                        ValueEntry."Cost Amount (Actual)" := CostAmt;
                        ValueEntry."Cost Amount (Actual) (ACY)" := CostAmtACY;
                    END;
                ValueEntry."Expected Cost" AND ValueEntry.Inventoriable:
                    BEGIN
                        IF NOT Adjustment THEN
                            CASE "Entry Type" OF
                                "Entry Type"::Sale:
                                    ValueEntry."Sales Amount (Expected)" := Amount;
                                "Entry Type"::Purchase:
                                    ValueEntry."Purchase Amount (Expected)" := Amount;
                            END;
                        ValueEntry."Cost Amount (Expected)" := CostAmt;
                        ValueEntry."Cost Amount (Expected) (ACY)" := CostAmtACY;
                    END;
                (NOT ValueEntry."Expected Cost") AND (NOT ValueEntry.Inventoriable):
                    IF "Entry Type" = "Entry Type"::Sale THEN BEGIN
                        ValueEntry."Sales Amount (Actual)" := Amount;
                        IF Item.Type = Item.Type::Service THEN BEGIN
                            ValueEntry."Cost Amount (Non-Invtbl.)" := CostAmt;
                            ValueEntry."Cost Amount (Non-Invtbl.)(ACY)" := CostAmtACY;
                        END ELSE BEGIN
                            ValueEntry."Cost per Unit" := 0;
                            ValueEntry."Cost per Unit (ACY)" := 0;
                        END;
                    END ELSE BEGIN
                        IF "Entry Type" = "Entry Type"::Purchase THEN
                            ValueEntry."Purchase Amount (Actual)" := Amount;
                        ValueEntry."Cost Amount (Non-Invtbl.)" := CostAmt;
                        ValueEntry."Cost Amount (Non-Invtbl.)(ACY)" := CostAmtACY;
                    END;
            END;

            RoundAmtValueEntry(ValueEntry);
        END;
    end;

    local procedure CalcOutboundCostAmt(ValueEntry: Record "Value Entry"; var CostAmt: Decimal; var CostAmtACY: Decimal)
    begin
        IF ItemJnlLine."Item Charge No." <> '' THEN BEGIN
            CostAmt := ItemJnlLine.Amount;
            IF GLSetup."Additional Reporting Currency" <> '' THEN
                CostAmtACY := ACYMgt.CalcACYAmt(CostAmt, ValueEntry."Posting Date", FALSE);
        END ELSE BEGIN
            /*  IF ItemJnlLine."GST Availment (Goods)" THEN BEGIN
                  CostAmt := ItemJnlLine.Amount;
                  IF GLSetup."Additional Reporting Currency" <> '' THEN
                      CostAmtACY := ACYMgt.CalcACYAmt(CostAmt, ValueEntry."Posting Date", FALSE);
              END ELSE BEGIN
                  CostAmt :=
                    ValueEntry."Cost per Unit" * ValueEntry."Valued Quantity";
                  CostAmtACY :=
                    ValueEntry."Cost per Unit (ACY)" * ValueEntry."Valued Quantity";
              END;*/ // 15578
            IF (ValueEntry."Entry Type" = ValueEntry."Entry Type"::Revaluation) AND
               (Item."Costing Method" = Item."Costing Method"::Average)
            THEN BEGIN
                CostAmt += RoundingResidualAmount;
                CostAmtACY += RoundingResidualAmountACY;
            END;
        END;
    end;

    local procedure InsertValueEntry(var ValueEntry: Record "Value Entry"; var ItemLedgEntry: Record "Item Ledger Entry"; TransferItem: Boolean)
    var
        InvdValueEntry: Record "Value Entry";
        InvoicedQty: Decimal;
    begin
        ValueEntry.CHANGECOMPANY(ChangeToCompany);
        ItemLedgEntry.CHANGECOMPANY(ChangeToCompany);
        WITH ItemJnlLine DO BEGIN
            IF TransferItem THEN BEGIN
                ValueEntry."Global Dimension 1 Code" := "New Shortcut Dimension 1 Code";
                ValueEntry."Global Dimension 2 Code" := "New Shortcut Dimension 2 Code";
                ValueEntry."Dimension Set ID" := "New Dimension Set ID";
                ValueEntry."Machine Code" := "Machine Code";//MSSS
            END ELSE BEGIN
                IF (GlobalValueEntry."Entry Type" = GlobalValueEntry."Entry Type"::"Direct Cost") AND
                   (GlobalValueEntry."Item Charge No." <> '') AND
                   (ValueEntry."Entry Type" = ValueEntry."Entry Type"::Variance)
                THEN BEGIN
                    GetLastDirectCostValEntry(ValueEntry."Item Ledger Entry No.");
                    ValueEntry."Gen. Prod. Posting Group" := DirCostValueEntry."Gen. Prod. Posting Group";
                    MoveValEntryDimToValEntryDim(ValueEntry, DirCostValueEntry);
                END ELSE BEGIN
                    ValueEntry."Global Dimension 1 Code" := "Shortcut Dimension 1 Code";
                    ValueEntry."Global Dimension 2 Code" := "Shortcut Dimension 2 Code";
                    ValueEntry."Dimension Set ID" := "Dimension Set ID";
                END;
            END;
            RoundAmtValueEntry(ValueEntry);

            IF ValueEntry."Entry Type" = ValueEntry."Entry Type"::Rounding THEN BEGIN
                ValueEntry."Valued Quantity" := ItemLedgEntry.Quantity;
                ValueEntry."Invoiced Quantity" := 0;
                ValueEntry."Cost per Unit" := 0;
                ValueEntry."Sales Amount (Actual)" := 0;
                ValueEntry."Purchase Amount (Actual)" := 0;
                ValueEntry."Cost per Unit (ACY)" := 0;
                ValueEntry."Item Ledger Entry Quantity" := 0;
            END ELSE BEGIN
                IF IsFirstValueEntry(ValueEntry."Item Ledger Entry No.") THEN
                    ValueEntry."Item Ledger Entry Quantity" := ValueEntry."Valued Quantity"
                ELSE
                    ValueEntry."Item Ledger Entry Quantity" := 0;
                IF ValueEntry."Cost per Unit" = 0 THEN BEGIN
                    ValueEntry."Cost per Unit" :=
                      CalcCostPerUnit(ValueEntry."Cost Amount (Actual)", ValueEntry."Valued Quantity", FALSE);
                    ValueEntry."Cost per Unit (ACY)" :=
                      CalcCostPerUnit(ValueEntry."Cost Amount (Actual) (ACY)", ValueEntry."Valued Quantity", TRUE);
                END ELSE BEGIN
                    ValueEntry."Cost per Unit" := ROUND(
                        ValueEntry."Cost per Unit", GLSetup."Unit-Amount Rounding Precision");
                    ValueEntry."Cost per Unit (ACY)" := ROUND(
                        ValueEntry."Cost per Unit (ACY)", Currency."Unit-Amount Rounding Precision");
                    IF "Source Currency Code" = GLSetup."Additional Reporting Currency" THEN
                        IF ValueEntry."Expected Cost" THEN
                            ValueEntry."Cost per Unit" :=
                              CalcCostPerUnit(ValueEntry."Cost Amount (Expected)", ValueEntry."Valued Quantity", FALSE)
                        ELSE
                            IF ValueEntry."Entry Type" = ValueEntry."Entry Type"::Revaluation THEN
                                ValueEntry."Cost per Unit" :=
                                  CalcCostPerUnit(ValueEntry."Cost Amount (Actual)" + ValueEntry."Cost Amount (Expected)",
                                    ValueEntry."Valued Quantity", FALSE)
                            ELSE
                                ValueEntry."Cost per Unit" :=
                                  CalcCostPerUnit(ValueEntry."Cost Amount (Actual)", ValueEntry."Valued Quantity", FALSE);
                END;
                IF UpdateItemLedgEntry(ValueEntry, ItemLedgEntry) THEN
                    ItemLedgEntry.MODIFY;
            END;

            IF ((ValueEntry."Entry Type" = ValueEntry."Entry Type"::"Direct Cost") AND
                (ValueEntry."Item Charge No." = '')) AND
               (((Quantity = 0) AND ("Invoiced Quantity" <> 0)) OR
                (Adjustment AND NOT ValueEntry."Expected Cost"))
            THEN BEGIN
                IF ValueEntry."Invoiced Quantity" = 0 THEN BEGIN
                    InvdValueEntry.CHANGECOMPANY(ChangeToCompany);
                    IF InvdValueEntry.GET(ValueEntry."Applies-to Entry") THEN
                        InvoicedQty := InvdValueEntry."Invoiced Quantity"
                    ELSE
                        InvoicedQty := ValueEntry."Valued Quantity";
                END ELSE
                    InvoicedQty := ValueEntry."Invoiced Quantity";
                CalcExpectedCost(
                  ValueEntry,
                  ItemLedgEntry."Entry No.",
                  InvoicedQty,
                  ItemLedgEntry.Quantity,
                  ValueEntry."Cost Amount (Expected)",
                  ValueEntry."Cost Amount (Expected) (ACY)",
                  ValueEntry."Sales Amount (Expected)",
                  ValueEntry."Purchase Amount (Expected)",
                  ItemLedgEntry.Quantity = ItemLedgEntry."Invoiced Quantity");
            END;

            OnBeforeInsertValueEntry(ValueEntry, ItemJnlLine);

            //IF ValueEntry.Inventoriable THEN
            //  PostInventoryToGL(ValueEntry);
            ValueEntry.CHANGECOMPANY(ChangeToCompany);
            ValueEntry.INSERT;

            OnAfterInsertValueEntry(ValueEntry, ItemJnlLine);
            ItemApplnEntry.CHANGECOMPANY(ChangeToCompany);
            ItemApplnEntry.SetOutboundsNotUpdated(ItemLedgEntry);

            UpdateAdjmtProp(ValueEntry, ItemLedgEntry."Posting Date");

            InsertItemReg(0, 0, ValueEntry."Entry No.", 0);
            InsertPostValueEntryToGL(ValueEntry);
            IF Item."Item Tracking Code" <> '' THEN BEGIN
                TempValueEntryRelation.CHANGECOMPANY(ChangeToCompany);
                TempValueEntryRelation.INIT;
                TempValueEntryRelation."Value Entry No." := ValueEntry."Entry No.";
                TempValueEntryRelation.INSERT;
            END;
        END;
    end;

    local procedure InsertOHValueEntry(ValueEntry: Record "Value Entry"; OverheadAmount: Decimal; OverheadAmountACY: Decimal)
    begin
        IF Item."Inventory Value Zero" THEN
            EXIT;

        ValueEntryNo := ValueEntryNo + 1;

        ValueEntry."Entry No." := ValueEntryNo;
        ValueEntry."Item Charge No." := '';
        ValueEntry."Entry Type" := ValueEntry."Entry Type"::"Indirect Cost";
        ValueEntry.Description := '';
        ValueEntry."Cost per Unit" := 0;
        ValueEntry."Cost per Unit (ACY)" := 0;
        ValueEntry."Cost Posted to G/L" := 0;
        ValueEntry."Cost Posted to G/L (ACY)" := 0;
        ValueEntry."Invoiced Quantity" := 0;
        ValueEntry."Sales Amount (Actual)" := 0;
        ValueEntry."Sales Amount (Expected)" := 0;
        ValueEntry."Purchase Amount (Actual)" := 0;
        ValueEntry."Purchase Amount (Expected)" := 0;
        ValueEntry."Discount Amount" := 0;
        ValueEntry."Cost Amount (Actual)" := OverheadAmount;
        ValueEntry."Cost Amount (Expected)" := 0;
        ValueEntry."Cost Amount (Expected) (ACY)" := 0;

        IF GLSetup."Additional Reporting Currency" <> '' THEN
            ValueEntry."Cost Amount (Actual) (ACY)" :=
              ROUND(OverheadAmountACY, Currency."Amount Rounding Precision");

        InsertValueEntry(ValueEntry, GlobalItemLedgEntry, FALSE);
    end;

    local procedure InsertVarValueEntry(ValueEntry: Record "Value Entry"; VarianceAmount: Decimal; VarianceAmountACY: Decimal)
    begin
        IF (NOT ValueEntry.Inventoriable) OR Item."Inventory Value Zero" THEN
            EXIT;
        IF (VarianceAmount = 0) AND (VarianceAmountACY = 0) THEN
            EXIT;

        ValueEntryNo := ValueEntryNo + 1;

        ValueEntry."Entry No." := ValueEntryNo;
        ValueEntry."Item Charge No." := '';
        ValueEntry."Entry Type" := ValueEntry."Entry Type"::Variance;
        ValueEntry.Description := '';
        ValueEntry."Cost Posted to G/L" := 0;
        ValueEntry."Cost Posted to G/L (ACY)" := 0;
        ValueEntry."Invoiced Quantity" := 0;
        ValueEntry."Sales Amount (Actual)" := 0;
        ValueEntry."Sales Amount (Expected)" := 0;
        ValueEntry."Purchase Amount (Actual)" := 0;
        ValueEntry."Purchase Amount (Expected)" := 0;
        ValueEntry."Discount Amount" := 0;
        ValueEntry."Cost Amount (Actual)" := VarianceAmount;
        ValueEntry."Cost Amount (Expected)" := 0;
        ValueEntry."Cost Amount (Expected) (ACY)" := 0;
        ValueEntry."Variance Type" := ValueEntry."Variance Type"::Purchase;

        IF GLSetup."Additional Reporting Currency" <> '' THEN BEGIN
            IF ROUND(VarianceAmount, GLSetup."Amount Rounding Precision") =
               ROUND(-GlobalValueEntry."Cost Amount (Actual)", GLSetup."Amount Rounding Precision")
            THEN
                ValueEntry."Cost Amount (Actual) (ACY)" := -GlobalValueEntry."Cost Amount (Actual) (ACY)"
            ELSE
                ValueEntry."Cost Amount (Actual) (ACY)" :=
                  ROUND(VarianceAmountACY, Currency."Amount Rounding Precision");
        END;

        ValueEntry."Cost per Unit" :=
          CalcCostPerUnit(ValueEntry."Cost Amount (Actual)", ValueEntry."Valued Quantity", FALSE);
        ValueEntry."Cost per Unit (ACY)" :=
          CalcCostPerUnit(ValueEntry."Cost Amount (Actual) (ACY)", ValueEntry."Valued Quantity", TRUE);

        InsertValueEntry(ValueEntry, GlobalItemLedgEntry, FALSE);
    end;

    local procedure UpdateItemLedgEntry(ValueEntry: Record "Value Entry"; var ItemLedgEntry: Record "Item Ledger Entry") ModifyEntry: Boolean
    begin
        ItemLedgEntry.CHANGECOMPANY(ChangeToCompany);
        ValueEntry.CHANGECOMPANY(ChangeToCompany);
        WITH ItemLedgEntry DO
            IF NOT (ValueEntry."Entry Type" IN
                    [ValueEntry."Entry Type"::Variance,
                     ValueEntry."Entry Type"::"Indirect Cost",
                     ValueEntry."Entry Type"::Rounding])
            THEN BEGIN
                IF ValueEntry.Inventoriable AND (NOT ItemJnlLine.Adjustment OR ("Entry Type" = "Entry Type"::"Assembly Output")) THEN
                    UpdateAvgCostAdjmtEntryPoint(ItemLedgEntry, ValueEntry."Valuation Date");

                IF (Positive OR "Job Purchase") AND
                   (Quantity <> "Remaining Quantity") AND NOT "Applied Entry to Adjust" AND
                   (Item.Type = Item.Type::Inventory) AND
                   (NOT CalledFromAdjustment OR AppliedEntriesToReadjust(ItemLedgEntry))
                THEN BEGIN
                    "Applied Entry to Adjust" := TRUE;
                    ModifyEntry := TRUE;
                END;

                IF (ValueEntry."Entry Type" = ValueEntry."Entry Type"::"Direct Cost") AND
                   (ItemJnlLine."Item Charge No." = '') AND
                   (ItemJnlLine.Quantity = 0) AND (ValueEntry."Invoiced Quantity" <> 0)
                THEN BEGIN
                    IF ValueEntry."Invoiced Quantity" <> 0 THEN BEGIN
                        "Invoiced Quantity" := "Invoiced Quantity" + ValueEntry."Invoiced Quantity";
                        IF ABS("Invoiced Quantity") > ABS(Quantity) THEN
                            ERROR(Text030, "Entry No.");
                        VerifyInvoicedQty(ItemLedgEntry);
                        ModifyEntry := TRUE;
                    END;

                    IF ("Entry Type" <> "Entry Type"::Output) AND
                       ("Invoiced Quantity" = Quantity) AND
                       NOT "Completely Invoiced"
                    THEN BEGIN
                        "Completely Invoiced" := TRUE;
                        ModifyEntry := TRUE;
                    END;

                    IF "Last Invoice Date" < ValueEntry."Posting Date" THEN BEGIN
                        "Last Invoice Date" := ValueEntry."Posting Date";
                        ModifyEntry := TRUE;
                    END;
                END;
                IF ItemJnlLine."Applies-from Entry" <> 0 THEN
                    UpdateOutboundItemLedgEntry(ItemJnlLine."Applies-from Entry");
            END;

        EXIT(ModifyEntry);
    end;

    local procedure UpdateAvgCostAdjmtEntryPoint(OldItemLedgEntry: Record "Item Ledger Entry"; ValuationDate: Date)
    var
        AvgCostAdjmtEntryPoint: Record "Avg. Cost Adjmt. Entry Point";
        ValueEntry: Record "Value Entry";
    begin
        AvgCostAdjmtEntryPoint.CHANGECOMPANY(ChangeToCompany);
        WITH AvgCostAdjmtEntryPoint DO BEGIN
            //ValueEntry.CHANGECOMPANY(ChangeToCompany);
            ValueEntry."Item No." := OldItemLedgEntry."Item No.";
            ValueEntry."Valuation Date" := ValuationDate;
            ValueEntry."Location Code" := OldItemLedgEntry."Location Code";
            ValueEntry."Variant Code" := OldItemLedgEntry."Variant Code";

            LOCKTABLE;
            UpdateValuationDate(ValueEntry);
        END;
    end;

    local procedure UpdateOutboundItemLedgEntry(OutboundItemEntryNo: Integer)
    var
        OutboundItemLedgEntry: Record "Item Ledger Entry";
    begin
        WITH OutboundItemLedgEntry DO BEGIN
            OutboundItemLedgEntry.CHANGECOMPANY(ChangeToCompany);
            GET(OutboundItemEntryNo);
            IF Quantity > 0 THEN
                FIELDERROR(Quantity);
            IF GlobalItemLedgEntry.Quantity < 0 THEN
                GlobalItemLedgEntry.FIELDERROR(Quantity);

            "Shipped Qty. Not Returned" := "Shipped Qty. Not Returned" + ABS(ItemJnlLine.Quantity);
            IF "Shipped Qty. Not Returned" > 0 THEN
                FIELDERROR("Shipped Qty. Not Returned", Text004);
            "Applied Entry to Adjust" := TRUE;
            MODIFY;
        END;
    end;

    local procedure InitTransValueEntry(var ValueEntry: Record "Value Entry"; ItemLedgEntry: Record "Item Ledger Entry")
    var
        AdjCostInvoicedLCY: Decimal;
        AdjCostInvoicedACY: Decimal;
        DiscountAmount: Decimal;
    begin
        WITH GlobalValueEntry DO BEGIN
            InitValueEntry(ValueEntry, ItemLedgEntry);
            ValueEntry."Valued Quantity" := ItemLedgEntry.Quantity;
            ValueEntry."Invoiced Quantity" := ValueEntry."Valued Quantity";
            ValueEntry."Location Code" := ItemLedgEntry."Location Code";
            ValueEntry."Valuation Date" := "Valuation Date";
            IF AverageTransfer THEN BEGIN
                ValuateAppliedAvgEntry(GlobalValueEntry, Item);
                ValueEntry."Cost Amount (Actual)" := -"Cost Amount (Actual)";
                ValueEntry."Cost Amount (Actual) (ACY)" := -"Cost Amount (Actual) (ACY)";
                ValueEntry."Cost per Unit" := 0;
                ValueEntry."Cost per Unit (ACY)" := 0;
                ValueEntry."Valued By Average Cost" :=
                  NOT (ItemLedgEntry.Positive OR
                       (ValueEntry."Document Type" = ValueEntry."Document Type"::"Transfer Receipt"));
            END ELSE BEGIN
                CalcAdjustedCost(
                  OldItemLedgEntry, ValueEntry."Valued Quantity",
                  AdjCostInvoicedLCY, AdjCostInvoicedACY, DiscountAmount);
                ValueEntry."Cost Amount (Actual)" := AdjCostInvoicedLCY;
                ValueEntry."Cost Amount (Actual) (ACY)" := AdjCostInvoicedACY;
                ValueEntry."Cost per Unit" := 0;
                ValueEntry."Cost per Unit (ACY)" := 0;

                "Cost Amount (Actual)" := "Cost Amount (Actual)" - ValueEntry."Cost Amount (Actual)";
                IF GLSetup."Additional Reporting Currency" <> '' THEN
                    "Cost Amount (Actual) (ACY)" :=
                      CurrExchRate.ExchangeAmtLCYToFCY(
                        ValueEntry."Posting Date", GLSetup."Additional Reporting Currency",
                        ROUND("Cost Amount (Actual)", GLSetup."Amount Rounding Precision"),
                        CurrExchRate.ExchangeRate(
                          ValueEntry."Posting Date", GLSetup."Additional Reporting Currency"));
            END;

            "Discount Amount" := 0;
            ValueEntry."Discount Amount" := 0;
            "Cost per Unit" := 0;
            "Cost per Unit (ACY)" := 0;
        END;
    end;

    local procedure ValuateAppliedAvgEntry(var ValueEntry: Record "Value Entry"; Item: Record Item)
    begin
        ValueEntry.CHANGECOMPANY(ChangeToCompany);
        Item.CHANGECOMPANY(ChangeToCompany);
        WITH ValueEntry DO BEGIN
            IF (ItemJnlLine."Applies-to Entry" = 0) AND
               ("Item Ledger Entry Type" <> "Item Ledger Entry Type"::Output)
            THEN BEGIN
                IF (ItemJnlLine.Quantity = 0) AND (ItemJnlLine."Invoiced Quantity" <> 0) THEN BEGIN
                    GetLastDirectCostValEntry("Item Ledger Entry No.");
                    "Valued By Average Cost" := DirCostValueEntry."Valued By Average Cost";
                END ELSE
                    "Valued By Average Cost" := NOT ("Document Type" = "Document Type"::"Transfer Receipt");

                IF Item."Inventory Value Zero" THEN BEGIN
                    "Cost per Unit" := 0;
                    "Cost per Unit (ACY)" := 0;
                END ELSE BEGIN
                    IF "Item Ledger Entry Type" = "Item Ledger Entry Type"::Transfer THEN BEGIN
                        IF SKUExists AND (InvtSetup."Average Cost Calc. Type" <> InvtSetup."Average Cost Calc. Type"::Item) THEN
                            "Cost per Unit" := SKU."Unit Cost"
                        ELSE
                            "Cost per Unit" := Item."Unit Cost";
                    END ELSE
                        "Cost per Unit" := ItemJnlLine."Unit Cost";

                    IF GLSetup."Additional Reporting Currency" <> '' THEN BEGIN
                        IF (ItemJnlLine."Source Currency Code" = GLSetup."Additional Reporting Currency") AND
                           ("Item Ledger Entry Type" <> "Item Ledger Entry Type"::Transfer)
                        THEN
                            "Cost per Unit (ACY)" := ItemJnlLine."Unit Cost (ACY)"
                        ELSE
                            "Cost per Unit (ACY)" :=
                              ROUND(
                                CurrExchRate.ExchangeAmtLCYToFCY(
                                  "Posting Date", GLSetup."Additional Reporting Currency", "Cost per Unit",
                                  CurrExchRate.ExchangeRate(
                                    "Posting Date", GLSetup."Additional Reporting Currency")),
                                Currency."Unit-Amount Rounding Precision");
                    END;
                END;
                IF "Expected Cost" THEN BEGIN
                    "Cost Amount (Expected)" := "Valued Quantity" * "Cost per Unit";
                    "Cost Amount (Expected) (ACY)" := "Valued Quantity" * "Cost per Unit (ACY)";
                END ELSE BEGIN
                    "Cost Amount (Actual)" := "Valued Quantity" * "Cost per Unit";
                    "Cost Amount (Actual) (ACY)" := "Valued Quantity" * "Cost per Unit (ACY)";
                END;
            END;
        END;
    end;

    local procedure CalcAdjustedCost(PosItemLedgEntry: Record "Item Ledger Entry"; AppliedQty: Decimal; var AdjustedCostLCY: Decimal; var AdjustedCostACY: Decimal; var DiscountAmount: Decimal)
    var
        PosValueEntry: Record "Value Entry";
    begin
        AdjustedCostLCY := 0;
        AdjustedCostACY := 0;
        DiscountAmount := 0;
        WITH PosValueEntry DO BEGIN
            SETCURRENTKEY("Item Ledger Entry No.");
            SETRANGE("Item Ledger Entry No.", PosItemLedgEntry."Entry No.");
            FINDSET;
            REPEAT
                IF "Partial Revaluation" THEN BEGIN
                    AdjustedCostLCY := AdjustedCostLCY +
                      "Cost Amount (Actual)" / "Valued Quantity" * PosItemLedgEntry.Quantity;
                    AdjustedCostACY := AdjustedCostACY +
                      "Cost Amount (Actual) (ACY)" / "Valued Quantity" * PosItemLedgEntry.Quantity;
                END ELSE BEGIN
                    AdjustedCostLCY := AdjustedCostLCY + "Cost Amount (Actual)" + "Cost Amount (Expected)";
                    AdjustedCostACY := AdjustedCostACY + "Cost Amount (Actual) (ACY)" + "Cost Amount (Expected) (ACY)";
                    DiscountAmount := DiscountAmount - "Discount Amount";
                END;
            UNTIL NEXT = 0;

            AdjustedCostLCY := ROUND(AdjustedCostLCY * AppliedQty / PosItemLedgEntry.Quantity, GLSetup."Amount Rounding Precision");
            AdjustedCostACY := ROUND(AdjustedCostACY * AppliedQty / PosItemLedgEntry.Quantity, Currency."Amount Rounding Precision");
            DiscountAmount := ROUND(DiscountAmount * AppliedQty / PosItemLedgEntry.Quantity, GLSetup."Amount Rounding Precision");
        END;
    end;

    local procedure GetMaxValuationDate(ItemLedgerEntry: Record "Item Ledger Entry"): Date
    var
        ValueEntry: Record "Value Entry";
    begin
        ValueEntry.SETCURRENTKEY("Item Ledger Entry No.", "Entry Type");
        ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
        ValueEntry.SETRANGE("Entry Type", ValueEntry."Entry Type"::Revaluation);
        IF NOT ValueEntry.FINDLAST THEN BEGIN
            ValueEntry.SETRANGE("Entry Type");
            ValueEntry.FINDLAST;
        END;
        EXIT(ValueEntry."Valuation Date");
    end;

    local procedure GetValuationDate(var ValueEntry: Record "Value Entry"; OldItemLedgEntry: Record "Item Ledger Entry")
    var
        OldValueEntry: Record "Value Entry";
    begin
        WITH OldItemLedgEntry DO BEGIN
            OldValueEntry.CHANGECOMPANY(ChangeToCompany);
            OldValueEntry.SETCURRENTKEY("Item Ledger Entry No.", "Entry Type");
            OldValueEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
            OldValueEntry.SETRANGE("Entry Type", OldValueEntry."Entry Type"::Revaluation);
            IF NOT OldValueEntry.FINDLAST THEN BEGIN
                OldValueEntry.SETRANGE("Entry Type");
                OldValueEntry.FINDLAST;
            END;
            IF Positive THEN BEGIN
                IF (ValueEntry."Posting Date" < OldValueEntry."Valuation Date") OR
                   (ItemJnlLine."Applies-to Entry" <> 0)
                THEN BEGIN
                    ValueEntry."Valuation Date" := OldValueEntry."Valuation Date";
                    SetValuationDateAllValueEntrie(
                      ValueEntry."Item Ledger Entry No.",
                      OldValueEntry."Valuation Date",
                      ItemJnlLine."Applies-to Entry" <> 0)
                END ELSE BEGIN
                    ValueEntry."Valuation Date" := ValueEntry."Posting Date";
                    SetValuationDateAllValueEntrie(
                      ValueEntry."Item Ledger Entry No.",
                      ValueEntry."Posting Date",
                      ItemJnlLine."Applies-to Entry" <> 0)
                END
            END ELSE
                IF OldValueEntry."Valuation Date" < ValueEntry."Valuation Date" THEN BEGIN
                    UpdateAvgCostAdjmtEntryPoint(OldItemLedgEntry, OldValueEntry."Valuation Date");
                    OldValueEntry.MODIFYALL("Valuation Date", ValueEntry."Valuation Date");
                    UpdateLinkedValuationDate(ValueEntry."Valuation Date", "Entry No.", Positive);
                END;
        END;
    end;

    local procedure UpdateLinkedValuationDate(FromValuationDate: Date; FromItemledgEntryNo: Integer; FromInbound: Boolean)
    var
        ToItemApplnEntry: Record "Item Application Entry";
    begin
        ToItemApplnEntry.CHANGECOMPANY(ChangeToCompany);
        WITH ToItemApplnEntry DO BEGIN
            IF FromInbound THEN BEGIN
                SETCURRENTKEY("Inbound Item Entry No.", "Item Ledger Entry No.", "Outbound Item Entry No.");
                SETRANGE("Inbound Item Entry No.", FromItemledgEntryNo);
                SETFILTER("Outbound Item Entry No.", '<>%1', 0);
            END ELSE BEGIN
                SETCURRENTKEY("Outbound Item Entry No.", "Item Ledger Entry No.");
                SETRANGE("Outbound Item Entry No.", FromItemledgEntryNo);
            END;
            SETFILTER("Item Ledger Entry No.", '<>%1', FromItemledgEntryNo);
            IF FINDSET THEN
                REPEAT
                    IF FromInbound OR ("Inbound Item Entry No." <> 0) THEN BEGIN
                        GetLastDirectCostValEntry("Inbound Item Entry No.");
                        IF DirCostValueEntry."Valuation Date" < FromValuationDate THEN BEGIN
                            UpdateValuationDate(FromValuationDate, "Item Ledger Entry No.", FromInbound);
                            UpdateLinkedValuationDate(FromValuationDate, "Item Ledger Entry No.", NOT FromInbound);
                        END;
                    END;
                UNTIL NEXT = 0;
        END;
    end;

    local procedure UpdateLinkedValuationUnapply(FromValuationDate: Date; FromItemLedgEntryNo: Integer; FromInbound: Boolean)
    var
        ToItemApplnEntry: Record "Item Application Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        WITH ToItemApplnEntry DO BEGIN
            ToItemApplnEntry.CHANGECOMPANY(ChangeToCompany);
            IF FromInbound THEN BEGIN
                SETCURRENTKEY("Inbound Item Entry No.", "Item Ledger Entry No.", "Outbound Item Entry No.");
                SETRANGE("Inbound Item Entry No.", FromItemLedgEntryNo);
                SETFILTER("Outbound Item Entry No.", '<>%1', 0);
            END ELSE BEGIN
                SETCURRENTKEY("Outbound Item Entry No.", "Item Ledger Entry No.");
                SETRANGE("Outbound Item Entry No.", FromItemLedgEntryNo);
            END;
            SETFILTER("Item Ledger Entry No.", '<>%1', FromItemLedgEntryNo);
            IF FIND('-') THEN
                REPEAT
                    IF FromInbound OR ("Inbound Item Entry No." <> 0) THEN BEGIN
                        GetLastDirectCostValEntry("Inbound Item Entry No.");
                        IF DirCostValueEntry."Valuation Date" < FromValuationDate THEN BEGIN
                            UpdateValuationDate(FromValuationDate, "Item Ledger Entry No.", FromInbound);
                            UpdateLinkedValuationUnapply(FromValuationDate, "Item Ledger Entry No.", NOT FromInbound);
                        END
                        ELSE BEGIN
                            ItemLedgerEntry.GET("Inbound Item Entry No.");
                            FromValuationDate := GetMaxAppliedValuationdate(ItemLedgerEntry);
                            IF FromValuationDate < DirCostValueEntry."Valuation Date" THEN BEGIN
                                UpdateValuationDate(FromValuationDate, ItemLedgerEntry."Entry No.", FromInbound);
                                UpdateLinkedValuationUnapply(FromValuationDate, ItemLedgerEntry."Entry No.", NOT FromInbound);
                            END;
                        END;
                    END;
                UNTIL NEXT = 0;
        END;
    end;

    local procedure UpdateValuationDate(FromValuationDate: Date; FromItemLedgEntryNo: Integer; FromInbound: Boolean)
    var
        ToValueEntry2: Record "Value Entry";
    begin
        ToValueEntry2.CHANGECOMPANY(ChangeToCompany);
        ToValueEntry2.SETCURRENTKEY("Item Ledger Entry No.");
        ToValueEntry2.SETRANGE("Item Ledger Entry No.", FromItemLedgEntryNo);
        ToValueEntry2.FIND('-');
        IF FromInbound THEN BEGIN
            IF ToValueEntry2."Valuation Date" < FromValuationDate THEN
                ToValueEntry2.MODIFYALL("Valuation Date", FromValuationDate);
        END ELSE
            REPEAT
                IF ToValueEntry2."Entry Type" = ToValueEntry2."Entry Type"::Revaluation THEN BEGIN
                    IF ToValueEntry2."Valuation Date" < FromValuationDate THEN BEGIN
                        ToValueEntry2."Valuation Date" := FromValuationDate;
                        ToValueEntry2.MODIFY;
                    END;
                END ELSE BEGIN
                    ToValueEntry2."Valuation Date" := FromValuationDate;
                    ToValueEntry2.MODIFY;
                END;
            UNTIL ToValueEntry2.NEXT = 0;
    end;

    local procedure CreateItemJNLLinefromEntry(ItemLedgEntry: Record "Item Ledger Entry"; NewQuantity: Decimal; var ItemJnlLine: Record "Item Journal Line")
    begin
        CLEAR(ItemJnlLine);
        ItemJnlLine.CHANGECOMPANY(ChangeToCompany);
        WITH ItemJnlLine DO BEGIN
            "Entry Type" := ItemLedgEntry."Entry Type"; // no mapping needed
            Quantity := Signed(NewQuantity);
            "Item No." := ItemLedgEntry."Item No.";
            "Serial No." := ItemLedgEntry."Serial No.";
            "Lot No." := ItemLedgEntry."Lot No.";
        END;
    end;

    local procedure GetAppliedFromValues(var ValueEntry: Record "Value Entry")
    var
        NegValueEntry: Record "Value Entry";
    begin
        WITH NegValueEntry DO BEGIN
            NegValueEntry.CHANGECOMPANY(ChangeToCompany);
            SETCURRENTKEY("Item Ledger Entry No.", "Entry Type");
            SETRANGE("Item Ledger Entry No.", ItemJnlLine."Applies-from Entry");
            SETRANGE("Entry Type", "Entry Type"::Revaluation);
            IF NOT FINDLAST THEN BEGIN
                SETRANGE("Entry Type");
                FINDLAST;
            END;

            IF "Valuation Date" > ValueEntry."Posting Date" THEN
                ValueEntry."Valuation Date" := "Valuation Date"
            ELSE
                ValueEntry."Valuation Date" := ItemJnlLine."Posting Date";
        END;
    end;

    local procedure RoundAmtValueEntry(var ValueEntry: Record "Value Entry")
    begin
        WITH ValueEntry DO BEGIN
            "Sales Amount (Actual)" := ROUND("Sales Amount (Actual)");
            "Sales Amount (Expected)" := ROUND("Sales Amount (Expected)");
            "Purchase Amount (Actual)" := ROUND("Purchase Amount (Actual)");
            "Purchase Amount (Expected)" := ROUND("Purchase Amount (Expected)");
            "Discount Amount" := ROUND("Discount Amount");
            "Cost Amount (Actual)" := ROUND("Cost Amount (Actual)");
            "Cost Amount (Expected)" := ROUND("Cost Amount (Expected)");
            "Cost Amount (Non-Invtbl.)" := ROUND("Cost Amount (Non-Invtbl.)");
            "Cost Amount (Actual) (ACY)" := ROUND("Cost Amount (Actual) (ACY)", Currency."Amount Rounding Precision");
            "Cost Amount (Expected) (ACY)" := ROUND("Cost Amount (Expected) (ACY)", Currency."Amount Rounding Precision");
            "Cost Amount (Non-Invtbl.)(ACY)" := ROUND("Cost Amount (Non-Invtbl.)(ACY)", Currency."Amount Rounding Precision");
        END;
    end;

    local procedure RetrieveCostPerUnit(): Decimal
    begin
        WITH ItemJnlLine DO BEGIN
            IF (Item."Costing Method" = Item."Costing Method"::Standard) AND
               ("Value Entry Type" = "Value Entry Type"::"Direct Cost") AND
               ("Item Charge No." = '') AND
               ("Applies-from Entry" = 0) AND
               NOT Adjustment
            THEN BEGIN
                IF SKUExists THEN
                    EXIT(SKU."Unit Cost");
                EXIT(Item."Unit Cost");
            END;
            EXIT("Unit Cost");
        END;
    end;

    local procedure RetrieveCostPerUnitACY(CostPerUnit: Decimal): Decimal
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        PostingDate: Date;
    begin
        WITH ItemJnlLine DO BEGIN
            IF Adjustment OR ("Source Currency Code" = GLSetup."Additional Reporting Currency") AND
               ((Item."Costing Method" <> Item."Costing Method"::Standard) OR
                (("Discount Amount" = 0) AND ("Indirect Cost %" = 0) AND ("Overhead Rate" = 0)))
            THEN
                EXIT("Unit Cost (ACY)");
            IF ("Value Entry Type" = "Value Entry Type"::Revaluation) AND ItemLedgerEntry.GET("Applies-to Entry") THEN
                PostingDate := ItemLedgerEntry."Posting Date"
            ELSE
                PostingDate := "Posting Date";
            EXIT(ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                  PostingDate, GLSetup."Additional Reporting Currency",
                  CostPerUnit, CurrExchRate.ExchangeRate(
                    PostingDate, GLSetup."Additional Reporting Currency")),
                Currency."Unit-Amount Rounding Precision"));
        END;
    end;

    local procedure CalcCostPerUnit(Cost: Decimal; Quantity: Decimal; IsACY: Boolean): Decimal
    var
        RndgPrec: Decimal;
    begin
        GetGLSetup;

        IF IsACY THEN
            RndgPrec := Currency."Unit-Amount Rounding Precision"
        ELSE
            RndgPrec := GLSetup."Unit-Amount Rounding Precision";

        IF Quantity <> 0 THEN
            EXIT(ROUND(Cost / Quantity, RndgPrec));
        EXIT(0);
    end;

    local procedure CalcPosShares(var DirCost: Decimal; var OvhdCost: Decimal; var PurchVar: Decimal; var DirCostACY: Decimal; var OvhdCostACY: Decimal; var PurchVarACY: Decimal; var CalcUnitCost: Boolean; CalcPurchVar: Boolean; Expected: Boolean)
    var
        CostCalcMgt: Codeunit "Cost Calculation Management";
    begin
        WITH ItemJnlLine DO BEGIN
            IF Expected THEN BEGIN
                DirCost := "Unit Cost" * Quantity;
                PurchVar := 0;
                PurchVarACY := 0;
                OvhdCost := 0;
                OvhdCostACY := 0;
            END ELSE BEGIN
                OvhdCost :=
                  ROUND(
                    CostCalcMgt.CalcOvhdCost(
                      Amount, "Indirect Cost %", "Overhead Rate", "Invoiced Quantity"),
                    GLSetup."Amount Rounding Precision");
                DirCost := Amount;
                IF CalcPurchVar THEN
                    PurchVar := "Unit Cost" * "Invoiced Quantity" - DirCost - OvhdCost
                ELSE BEGIN
                    PurchVar := 0;
                    PurchVarACY := 0;
                END;
            END;

            IF GLSetup."Additional Reporting Currency" <> '' THEN BEGIN
                DirCostACY := ACYMgt.CalcACYAmt(DirCost, "Posting Date", FALSE);
                OvhdCostACY := ACYMgt.CalcACYAmt(OvhdCost, "Posting Date", FALSE);
                "Unit Cost (ACY)" :=
                  ROUND(
                    CurrExchRate.ExchangeAmtLCYToFCY(
                      "Posting Date", GLSetup."Additional Reporting Currency", "Unit Cost",
                      CurrExchRate.ExchangeRate(
                        "Posting Date", GLSetup."Additional Reporting Currency")),
                    Currency."Unit-Amount Rounding Precision");
                PurchVarACY := "Unit Cost (ACY)" * "Invoiced Quantity" - DirCostACY - OvhdCostACY;
            END;
            CalcUnitCost := (DirCost <> 0) AND ("Unit Cost" = 0);
        END;
    end;

    local procedure CalcPurchCorrShares(var OverheadAmount: Decimal; var OverheadAmountACY: Decimal; var VarianceAmount: Decimal; var VarianceAmountACY: Decimal)
    var
        OldItemLedgEntry: Record "Item Ledger Entry";
        OldValueEntry: Record "Value Entry";
        CostAmt: Decimal;
        CostAmtACY: Decimal;
    begin
        WITH ItemJnlLine DO BEGIN
            OldValueEntry.SETCURRENTKEY("Item Ledger Entry No.", "Entry Type");
            OldValueEntry.SETRANGE("Item Ledger Entry No.", "Applies-to Entry");
            OldValueEntry.SETRANGE("Entry Type", OldValueEntry."Entry Type"::"Indirect Cost");
            IF OldValueEntry.FINDSET THEN
                REPEAT
                    IF NOT OldValueEntry."Partial Revaluation" THEN BEGIN
                        CostAmt := CostAmt + OldValueEntry."Cost Amount (Actual)";
                        CostAmtACY := CostAmtACY + OldValueEntry."Cost Amount (Actual) (ACY)";
                    END;
                UNTIL OldValueEntry.NEXT = 0;
            IF (CostAmt <> 0) OR (CostAmtACY <> 0) THEN BEGIN
                OldItemLedgEntry.GET("Applies-to Entry");
                OverheadAmount := ROUND(
                    CostAmt / OldItemLedgEntry."Invoiced Quantity" * "Invoiced Quantity",
                    GLSetup."Amount Rounding Precision");
                OverheadAmountACY := ROUND(
                    CostAmtACY / OldItemLedgEntry."Invoiced Quantity" * "Invoiced Quantity",
                    Currency."Unit-Amount Rounding Precision");
                IF Item."Costing Method" = Item."Costing Method"::Standard THEN BEGIN
                    VarianceAmount := -OverheadAmount;
                    VarianceAmountACY := -OverheadAmountACY;
                END ELSE BEGIN
                    VarianceAmount := 0;
                    VarianceAmountACY := 0;
                END;
            END ELSE
                IF Item."Costing Method" = Item."Costing Method"::Standard THEN BEGIN
                    OldValueEntry.SETRANGE("Entry Type", OldValueEntry."Entry Type"::Variance);
                    VarianceRequired := OldValueEntry.FINDFIRST;
                END;
        END;
    end;

    local procedure GetLastDirectCostValEntry(ItemLedgEntryNo: Decimal)
    var
        Found: Boolean;
    begin
        IF ItemLedgEntryNo = DirCostValueEntry."Item Ledger Entry No." THEN
            EXIT;
        DirCostValueEntry.RESET;
        DirCostValueEntry.CHANGECOMPANY(ChangeToCompany);
        DirCostValueEntry.SETCURRENTKEY("Item Ledger Entry No.", "Entry Type");
        DirCostValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgEntryNo);
        DirCostValueEntry.SETRANGE("Entry Type", DirCostValueEntry."Entry Type"::"Direct Cost");
        DirCostValueEntry.SETFILTER("Item Charge No.", '%1', '');
        Found := DirCostValueEntry.FINDLAST;
        DirCostValueEntry.SETRANGE("Item Charge No.");
        IF NOT Found THEN
            DirCostValueEntry.FINDLAST;
    end;

    local procedure IsFirstValueEntry(ItemLedgEntryNo: Integer): Boolean
    var
        ValueEntry: Record "Value Entry";
    begin
        ValueEntry.SETCURRENTKEY("Item Ledger Entry No.");
        ValueEntry.CHANGECOMPANY(ChangeToCompany);
        ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgEntryNo);
        EXIT(ValueEntry.ISEMPTY);
    end;

    local procedure CalcExpectedCost(var InvdValueEntry: Record "Value Entry"; ItemLedgEntryNo: Integer; InvoicedQty: Decimal; Quantity: Decimal; var ExpectedCost: Decimal; var ExpectedCostACY: Decimal; var ExpectedSalesAmt: Decimal; var ExpectedPurchAmt: Decimal; CalcReminder: Boolean)
    var
        ValueEntry: Record "Value Entry";
    begin
        ExpectedCost := 0;
        ExpectedCostACY := 0;
        ExpectedSalesAmt := 0;
        ExpectedPurchAmt := 0;

        WITH ValueEntry DO BEGIN
            ValueEntry.CHANGECOMPANY(ChangeToCompany);
            SETCURRENTKEY("Item Ledger Entry No.", "Entry Type");
            SETRANGE("Item Ledger Entry No.", ItemLedgEntryNo);
            SETFILTER("Entry Type", '<>%1', "Entry Type"::Revaluation);
            IF FINDSET AND "Expected Cost" THEN
                IF CalcReminder THEN BEGIN
                    CALCSUMS(
                      "Cost Amount (Expected)", "Cost Amount (Expected) (ACY)",
                      "Sales Amount (Expected)", "Purchase Amount (Expected)");
                    ExpectedCost := -"Cost Amount (Expected)";
                    ExpectedCostACY := -"Cost Amount (Expected) (ACY)";
                    IF NOT CalledFromAdjustment THEN BEGIN
                        ExpectedSalesAmt := -"Sales Amount (Expected)";
                        ExpectedPurchAmt := -"Purchase Amount (Expected)";
                    END
                END ELSE
                    IF InvdValueEntry.Adjustment AND
                       (InvdValueEntry."Entry Type" = InvdValueEntry."Entry Type"::"Direct Cost")
                    THEN BEGIN
                        ExpectedCost := -InvdValueEntry."Cost Amount (Actual)";
                        ExpectedCostACY := -InvdValueEntry."Cost Amount (Actual) (ACY)";
                        IF NOT CalledFromAdjustment THEN BEGIN
                            ExpectedSalesAmt := -InvdValueEntry."Sales Amount (Actual)";
                            ExpectedPurchAmt := -InvdValueEntry."Purchase Amount (Actual)";
                        END
                    END ELSE BEGIN
                        REPEAT
                            IF "Expected Cost" AND NOT Adjustment THEN BEGIN
                                ExpectedCost := ExpectedCost + "Cost Amount (Expected)";
                                ExpectedCostACY := ExpectedCostACY + "Cost Amount (Expected) (ACY)";
                                IF NOT CalledFromAdjustment THEN BEGIN
                                    ExpectedSalesAmt := ExpectedSalesAmt + "Sales Amount (Expected)";
                                    ExpectedPurchAmt := ExpectedPurchAmt + "Purchase Amount (Expected)";
                                END;
                            END;
                        UNTIL NEXT = 0;
                        ExpectedCost :=
                          CalcExpCostToBalance(ExpectedCost, InvoicedQty, Quantity, GLSetup."Amount Rounding Precision");
                        ExpectedCostACY :=
                          CalcExpCostToBalance(ExpectedCostACY, InvoicedQty, Quantity, Currency."Amount Rounding Precision");
                        IF NOT CalledFromAdjustment THEN BEGIN
                            ExpectedSalesAmt :=
                              CalcExpCostToBalance(ExpectedSalesAmt, InvoicedQty, Quantity, GLSetup."Amount Rounding Precision");
                            ExpectedPurchAmt :=
                              CalcExpCostToBalance(ExpectedPurchAmt, InvoicedQty, Quantity, GLSetup."Amount Rounding Precision");
                        END;
                    END;
        END;
    end;

    local procedure CalcExpCostToBalance(ExpectedCost: Decimal; InvoicedQty: Decimal; Quantity: Decimal; RoundPrecision: Decimal): Decimal
    begin
        EXIT(-ROUND(InvoicedQty / Quantity * ExpectedCost, RoundPrecision));
    end;

    local procedure MoveValEntryDimToValEntryDim(var ToValueEntry: Record "Value Entry"; FromValueEntry: Record "Value Entry")
    begin
        ToValueEntry."Global Dimension 1 Code" := FromValueEntry."Global Dimension 1 Code";
        ToValueEntry."Global Dimension 2 Code" := FromValueEntry."Global Dimension 2 Code";
        ToValueEntry."Dimension Set ID" := FromValueEntry."Dimension Set ID";
    end;

    local procedure AutoTrack(var ItemLedgEntryRec: Record "Item Ledger Entry")
    var
        ReservMgt: Codeunit "Reservation Management";
    begin
        IF Item."Order Tracking Policy" = Item."Order Tracking Policy"::None THEN BEGIN
            // Ensure that Item Tracking is not left on the item ledger entry:
            // 15578   ReservMgt.SetItemLedgEntry(ItemLedgEntryRec);
            ReservMgt.SetItemTrackingHandling(1);
            ReservMgt.ClearSurplus;
            EXIT;
        END;

        // 15578  ReservMgt.SetItemLedgEntry(ItemLedgEntryRec);
        ReservMgt.SetItemTrackingHandling(1);
        ReservMgt.DeleteReservEntries(FALSE, ItemLedgEntryRec."Remaining Quantity");
        ReservMgt.ClearSurplus;
        ReservMgt.AutoTrack(ItemLedgEntryRec."Remaining Quantity");
    end;


    procedure SetPostponeReservationHandling(Postpone: Boolean)
    begin
        // Used when posting Transfer Order receipts
        PostponeReservationHandling := Postpone;
    end;

    local procedure SetupSplitJnlLine(var ItemJnlLine2: Record "Item Journal Line"): Boolean
    var
        LateBindingMgt: Codeunit "Late Binding Management";
        NonDistrQuantity: Decimal;
        NonDistrAmount: Decimal;
        NonDistrAmountACY: Decimal;
        NonDistrDiscountAmount: Decimal;
        SignFactor: Integer;
        CalcWarrantyDate: Date;
        CalcExpirationDate: Date;
        Invoice: Boolean;
        SNInfoRequired: Boolean;
        LotInfoRequired: Boolean;
        ExpirationDateChecked: Boolean;
        PostItemJnlLine: Boolean;
    begin
        ItemJnlLine2.CHANGECOMPANY(ChangeToCompany);
        ItemJnlLineOrigin := ItemJnlLine2;
        TempSplitItemJnlLine.CHANGECOMPANY(ChangeToCompany);
        ItemJnlLineOrigin.CHANGECOMPANY(ChangeToCompany);

        TempSplitItemJnlLine.RESET;
        TempSplitItemJnlLine.DELETEALL;

        GetGLSetup;
        GetInvtSetup;

        /*IF Item.GET(ItemJnlLine2."Item No.") THEN BEGIN
          IF NOT CalledFromAdjustment THEN
            Item.TESTFIELD(Blocked,FALSE);
        END ELSE
          Item.INIT;*/

        DisableItemTracking := NOT ItemJnlLine2.ItemPosting;

        ItemTrackingCode.Code := Item."Item Tracking Code";
        /* ItemTrackingMgt.GetItemTrackingSettings(
           ItemTrackingCode, ItemJnlLine."Entry Type", ItemJnlLine.Signed(ItemJnlLine."Quantity (Base)") > 0,
           SNRequired, LotRequired, SNInfoRequired, LotInfoRequired);*/ // 15578

        IF Item."Costing Method" = Item."Costing Method"::Specific THEN BEGIN
            Item.TESTFIELD("Item Tracking Code");
            ItemTrackingCode.TESTFIELD("SN Specific Tracking", TRUE);
        END;

        Invoice := ItemJnlLine2."Invoiced Qty. (Base)" <> 0;

        IF (ItemJnlLine2."Entry Type" = ItemJnlLine2."Entry Type"::Transfer) AND
           PostponeReservationHandling
        THEN
            SignFactor := 1
        ELSE
            SignFactor := ItemJnlLine2.Signed(1);

        // 15578  ItemTrackingMgt.SetSubcon(SubconValue);

        IF NOT ItemJnlLine2.Correction AND
           (ItemJnlLine2."Quantity (Base)" <> 0) AND
           ItemTrackingMgt.RetrieveItemTracking(ItemJnlLine2, TempTrackingSpecification)
        THEN BEGIN
            IF DisableItemTracking THEN BEGIN
                /*IF NOT TempTrackingSpecification.ISEMPTY THEN
                  ERROR(Text021,ItemJnlLine2.FIELDCAPTION("Operation No."),ItemJnlLine2."Operation No.");*/
            END ELSE BEGIN
                IF TempTrackingSpecification.ISEMPTY THEN
                    ERROR(Text100);
                //ItemJnlLine2.TESTFIELD("Serial No.",'');
                //ItemJnlLine2.TESTFIELD("Lot No.",'');
                //ItemJnlLine2.TESTFIELD("New Serial No.",'');
                //ItemJnlLine2.TESTFIELD("New Lot No.",'');

                IF FORMAT(ItemTrackingCode."Warranty Date Formula") <> '' THEN
                    CalcWarrantyDate := CALCDATE(ItemTrackingCode."Warranty Date Formula", ItemJnlLine2."Document Date");
                IF FORMAT(Item."Expiration Calculation") <> '' THEN
                    CalcExpirationDate := CALCDATE(Item."Expiration Calculation", ItemJnlLine2."Document Date");

                IF SignFactor * ItemJnlLine2.Quantity < 0 THEN // Demand
                    IF ItemTrackingCode."SN Specific Tracking" OR ItemTrackingCode."Lot Specific Tracking" THEN
                        LateBindingMgt.ReallocateTrkgSpecification(TempTrackingSpecification);

                TempTrackingSpecification.CALCSUMS(
                  "Qty. to Handle (Base)", "Qty. to Invoice (Base)", "Qty. to Handle", "Qty. to Invoice");
                TempTrackingSpecification.TestFieldError(TempTrackingSpecification.FIELDCAPTION("Qty. to Handle (Base)"),
                  TempTrackingSpecification."Qty. to Handle (Base)", SignFactor * ItemJnlLine2."Quantity (Base)");

                IF Invoice THEN
                    TempTrackingSpecification.TestFieldError(TempTrackingSpecification.FIELDCAPTION("Qty. to Invoice (Base)"),
                      TempTrackingSpecification."Qty. to Invoice (Base)", SignFactor * ItemJnlLine2."Invoiced Qty. (Base)");

                NonDistrQuantity := ItemJnlLine2.Quantity;
                NonDistrAmount := ItemJnlLine2.Amount;
                NonDistrAmountACY := ItemJnlLine2."Amount (ACY)";
                NonDistrDiscountAmount := ItemJnlLine2."Discount Amount";

                TempTrackingSpecification.FINDSET;
                REPEAT
                    IF ItemTrackingCode."Man. Warranty Date Entry Reqd." THEN
                        TempTrackingSpecification.TESTFIELD("Warranty Date");

                    CheckExpirationDate(ItemJnlLine2, SignFactor, CalcExpirationDate, ExpirationDateChecked);
                    CheckItemTrackingInfo(ItemJnlLine2, TempTrackingSpecification, SNInfoRequired, LotInfoRequired);

                    IF TempTrackingSpecification."Warranty Date" = 0D THEN
                        TempTrackingSpecification."Warranty Date" := CalcWarrantyDate;

                    TempTrackingSpecification.MODIFY;
                    TempSplitItemJnlLine := ItemJnlLine2;
                    SetupTempSplitItemJnlLine(ItemJnlLine2, SignFactor, NonDistrQuantity, NonDistrAmount,
                      NonDistrAmountACY, NonDistrDiscountAmount, Invoice, PostItemJnlLine);
                UNTIL TempTrackingSpecification.NEXT = 0;
            END;
        END ELSE BEGIN
            TempSplitItemJnlLine := ItemJnlLine2;
            TempSplitItemJnlLine.INSERT;
        END;

        EXIT(PostItemJnlLine);

    end;

    local procedure SplitJnlLine(var ItemJnlLine2: Record "Item Journal Line"; PostItemJnlLine: Boolean): Boolean
    var
        FreeEntryNo: Integer;
        JnlLineNo: Integer;
        SignFactor: Integer;
    begin
        IF (ItemJnlLine2."Quantity (Base)" <> 0) AND ItemJnlLine2.TrackingExists THEN BEGIN
            IF (ItemJnlLine2."Entry Type" IN
                [ItemJnlLine2."Entry Type"::Sale,
                 ItemJnlLine2."Entry Type"::"Negative Adjmt.",
                 ItemJnlLine2."Entry Type"::Consumption,
                 ItemJnlLine2."Entry Type"::"Assembly Consumption"]) OR
               ((ItemJnlLine2."Entry Type" = ItemJnlLine2."Entry Type"::Transfer) AND
                NOT PostponeReservationHandling)
            THEN
                SignFactor := -1
            ELSE
                SignFactor := 1;

            TempTrackingSpecification.SETRANGE("Serial No.", ItemJnlLine2."Serial No.");
            TempTrackingSpecification.SETRANGE("Lot No.", ItemJnlLine2."Lot No.");
            IF TempTrackingSpecification.FINDFIRST THEN BEGIN
                FreeEntryNo := TempTrackingSpecification."Entry No.";
                TempTrackingSpecification.DELETE;
                ItemJnlLine2.TESTFIELD("Serial No.", TempTrackingSpecification."Serial No.");
                ItemJnlLine2.TESTFIELD("Lot No.", TempTrackingSpecification."Lot No.");
                TempTrackingSpecification."Quantity (Base)" := SignFactor * ItemJnlLine2."Quantity (Base)";
                TempTrackingSpecification."Quantity Handled (Base)" := SignFactor * ItemJnlLine2."Quantity (Base)";
                TempTrackingSpecification."Quantity actual Handled (Base)" := SignFactor * ItemJnlLine2."Quantity (Base)";
                TempTrackingSpecification."Quantity Invoiced (Base)" := SignFactor * ItemJnlLine2."Invoiced Qty. (Base)";
                TempTrackingSpecification."Qty. to Invoice (Base)" :=
                  SignFactor * (ItemJnlLine2."Quantity (Base)" - ItemJnlLine2."Invoiced Qty. (Base)");
                TempTrackingSpecification."Qty. to Handle (Base)" := 0;
                TempTrackingSpecification."Qty. to Handle" := 0;
                TempTrackingSpecification."Qty. to Invoice" :=
                  SignFactor * (ItemJnlLine2.Quantity - ItemJnlLine2."Invoiced Quantity");
                TempTrackingSpecification."Item Ledger Entry No." := GlobalItemLedgEntry."Entry No.";
                TempTrackingSpecification."Transfer Item Entry No." := TempItemEntryRelation."Item Entry No.";
                IF PostItemJnlLine THEN
                    TempTrackingSpecification."Entry No." := TempTrackingSpecification."Item Ledger Entry No.";
                InsertTempTrkgSpecification(FreeEntryNo);
            END ELSE
                IF NOT (ItemJnlLine2."Item Charge No." = '') AND (ItemJnlLine2."Job No." = '') THEN
                    IF ItemJnlLine2.Correction THEN // Undo quantity posting.
                        ERROR(Text011);
        END;

        IF TempSplitItemJnlLine.FINDFIRST THEN BEGIN
            JnlLineNo := ItemJnlLine2."Line No.";
            ItemJnlLine2 := TempSplitItemJnlLine;
            ItemJnlLine2."Line No." := JnlLineNo;
            TempSplitItemJnlLine.DELETE;
            EXIT(TRUE);
        END;
        IF ItemJnlLine."Phys. Inventory" THEN
            InsertPhysInventoryEntry;
        EXIT(FALSE);
    end;


    procedure CollectTrackingSpecification(var TargetTrackingSpecification: Record "Tracking Specification" temporary): Boolean
    begin
        TempTrackingSpecification.RESET;
        TargetTrackingSpecification.RESET;
        TargetTrackingSpecification.DELETEALL;

        IF TempTrackingSpecification.FINDSET THEN
            REPEAT
                TargetTrackingSpecification := TempTrackingSpecification;
                TargetTrackingSpecification.INSERT;
            UNTIL TempTrackingSpecification.NEXT = 0
        ELSE
            EXIT(FALSE);

        TempTrackingSpecification.DELETEALL;

        EXIT(TRUE);
    end;


    procedure CollectValueEntryRelation(var TargetValueEntryRelation: Record "Value Entry Relation" temporary; RowId: Text[100]): Boolean
    begin
        TempValueEntryRelation.RESET;
        TargetValueEntryRelation.RESET;

        IF TempValueEntryRelation.FINDSET THEN
            REPEAT
                TargetValueEntryRelation := TempValueEntryRelation;
                TargetValueEntryRelation."Source RowId" := RowId;
                TargetValueEntryRelation.INSERT;
            UNTIL TempValueEntryRelation.NEXT = 0
        ELSE
            EXIT(FALSE);

        TempValueEntryRelation.DELETEALL;

        EXIT(TRUE);
    end;


    procedure CollectItemEntryRelation(var TargetItemEntryRelation: Record "Item Entry Relation" temporary): Boolean
    begin
        TempItemEntryRelation.RESET;
        TargetItemEntryRelation.RESET;

        IF TempItemEntryRelation.FINDSET THEN
            REPEAT
                TargetItemEntryRelation := TempItemEntryRelation;
                TargetItemEntryRelation.INSERT;
            UNTIL TempItemEntryRelation.NEXT = 0
        ELSE
            EXIT(FALSE);

        TempItemEntryRelation.DELETEALL;

        EXIT(TRUE);
    end;

    local procedure CheckExpirationDate(var ItemJnlLine2: Record "Item Journal Line"; SignFactor: Integer; CalcExpirationDate: Date; var ExpirationDateChecked: Boolean)
    var
        ExistingExpirationDate: Date;
        EntriesExist: Boolean;
        SumOfEntries: Decimal;
        SumLot: Decimal;
    begin
        /*   ExistingExpirationDate :=
            ItemTrackingMgt.ExistingExpirationDate(
              TempTrackingSpecification."Item No.",
              TempTrackingSpecification."Variant Code",
              TempTrackingSpecification."Lot No.",
              TempTrackingSpecification."Serial No.",
              TRUE,
              EntriesExist);
   */
        IF NOT (EntriesExist OR ExpirationDateChecked) THEN BEGIN
            ItemTrackingMgt.TestExpDateOnTrackingSpec(TempTrackingSpecification);
            ExpirationDateChecked := TRUE;
        END;
        IF ItemJnlLine2."Entry Type" = ItemJnlLine2."Entry Type"::Transfer THEN
            IF TempTrackingSpecification."Expiration Date" = 0D THEN
                TempTrackingSpecification."Expiration Date" := ExistingExpirationDate;

        // Supply
        IF SignFactor * ItemJnlLine2.Quantity > 0 THEN BEGIN        // Only expiration dates on supply.
            IF NOT (ItemJnlLine2."Entry Type" = ItemJnlLine2."Entry Type"::Transfer) THEN
                IF ItemTrackingCode."Man. Expir. Date Entry Reqd." THEN
                    IF NOT TempTrackingSpecification.Correction THEN
                        TempTrackingSpecification.TESTFIELD("Expiration Date");

            IF CalcExpirationDate <> 0D THEN
                IF ExistingExpirationDate <> 0D THEN
                    CalcExpirationDate := ExistingExpirationDate;

            IF ItemJnlLine2."Entry Type" = ItemJnlLine2."Entry Type"::Transfer THEN
                IF TempTrackingSpecification."New Expiration Date" = 0D THEN
                    TempTrackingSpecification."New Expiration Date" := ExistingExpirationDate;

            IF TempTrackingSpecification."Expiration Date" = 0D THEN
                TempTrackingSpecification."Expiration Date" := CalcExpirationDate;

            IF EntriesExist THEN
                TempTrackingSpecification.TESTFIELD("Expiration Date", ExistingExpirationDate);
        END ELSE BEGIN  // Demand
            IF ItemJnlLine2."Entry Type" = ItemJnlLine2."Entry Type"::Transfer THEN BEGIN
                /*  ExistingExpirationDate :=
                   ItemTrackingMgt.ExistingExpirationDateAndQty(
                     TempTrackingSpecification."Item No.",
                     TempTrackingSpecification."Variant Code",
                     TempTrackingSpecification."New Lot No.",
                     TempTrackingSpecification."New Serial No.",
                     SumOfEntries);
  */
                IF (ItemJnlLine2."Order Type" = ItemJnlLine2."Order Type"::Transfer) AND
                   (ItemJnlLine2."Order No." <> '')
                THEN
                    IF TempTrackingSpecification."New Expiration Date" = 0D THEN
                        TempTrackingSpecification."New Expiration Date" := ExistingExpirationDate;

                IF (TempTrackingSpecification."New Lot No." <> '') AND
                   ((ItemJnlLine2."Order Type" <> ItemJnlLine2."Order Type"::Transfer) OR
                    (ItemJnlLine2."Order No." = ''))
                THEN BEGIN
                    IF TempTrackingSpecification."New Serial No." <> '' THEN
                        SumLot := SignFactor * ItemTrackingMgt.SumNewLotOnTrackingSpec(TempTrackingSpecification)
                    ELSE
                        SumLot := SignFactor * TempTrackingSpecification."Quantity (Base)";
                    IF (SumOfEntries > 0) AND
                       ((SumOfEntries <> SumLot) OR (TempTrackingSpecification."New Lot No." <> TempTrackingSpecification."Lot No."))
                    THEN
                        TempTrackingSpecification.TESTFIELD("New Expiration Date", ExistingExpirationDate);
                    ItemTrackingMgt.TestExpDateOnTrackingSpecNew(TempTrackingSpecification);
                END;
            END;
        END;

        IF (ItemJnlLine2."Entry Type" = ItemJnlLine2."Entry Type"::Transfer) AND
           ((ItemJnlLine2."Order Type" <> ItemJnlLine2."Order Type"::Transfer) OR
            (ItemJnlLine2."Order No." = ''))
        THEN
            IF ItemTrackingCode."Man. Expir. Date Entry Reqd." THEN
                TempTrackingSpecification.TESTFIELD("New Expiration Date");
    end;

    local procedure GetGLSetup()
    begin
        IF NOT GLSetupRead THEN BEGIN
            GLSetup.CHANGECOMPANY(ChangeToCompany);
            GLSetup.GET;
            IF GLSetup."Additional Reporting Currency" <> '' THEN BEGIN
                Currency.GET(GLSetup."Additional Reporting Currency");
                Currency.TESTFIELD("Unit-Amount Rounding Precision");
                Currency.TESTFIELD("Amount Rounding Precision");
            END;
        END;
        GLSetupRead := TRUE;
    end;

    local procedure GetMfgSetup()
    begin
        MfgSetup.CHANGECOMPANY(ChangeToCompany);
        IF NOT MfgSetupRead THEN
            MfgSetup.GET;
        MfgSetupRead := TRUE;
    end;

    local procedure GetInvtSetup()
    begin
        InvtSetup.CHANGECOMPANY(ChangeToCompany);
        IF NOT InvtSetupRead THEN BEGIN
            InvtSetup.GET;
            SourceCodeSetup.GET;
        END;
        InvtSetupRead := TRUE;
    end;

    local procedure UndoQuantityPosting()
    var
        OldItemLedgEntry: Record "Item Ledger Entry";
        OldItemLedgEntry2: Record "Item Ledger Entry";
        NewItemLedgEntry: Record "Item Ledger Entry";
        OldValueEntry: Record "Value Entry";
        NewValueEntry: Record "Value Entry";
    begin
        IF ItemJnlLine."Entry Type" IN [ItemJnlLine."Entry Type"::"Assembly Consumption",
                                        ItemJnlLine."Entry Type"::"Assembly Output"]
        THEN
            EXIT;

        IF ItemJnlLine."Applies-to Entry" <> 0 THEN BEGIN
            OldItemLedgEntry.GET(ItemJnlLine."Applies-to Entry");
            IF NOT OldItemLedgEntry.Positive THEN
                ItemJnlLine."Applies-from Entry" := ItemJnlLine."Applies-to Entry";
        END ELSE
            OldItemLedgEntry.GET(ItemJnlLine."Applies-from Entry");
        Item.CHANGECOMPANY(ChangeToCompany);
        IF Item.GET(OldItemLedgEntry."Item No.") THEN BEGIN
            Item.TESTFIELD(Blocked, FALSE);
            Item.CheckBlockedByApplWorksheet;
        END;

        ItemJnlLine."Item No." := OldItemLedgEntry."Item No.";

        InitCorrItemLedgEntry(OldItemLedgEntry, NewItemLedgEntry);

        IF Item.Type = Item.Type::Service THEN BEGIN
            NewItemLedgEntry."Remaining Quantity" := 0;
            NewItemLedgEntry.Open := FALSE;
        END;

        InsertItemReg(NewItemLedgEntry."Entry No.", 0, 0, 0);
        GlobalItemLedgEntry := NewItemLedgEntry;

        CalcILEExpectedAmount(OldValueEntry, OldItemLedgEntry."Entry No.");
        IF OldItemLedgEntry."Invoiced Quantity" = 0 THEN BEGIN
            InsertCorrValueEntry(
              OldValueEntry, NewValueEntry, OldItemLedgEntry, OldValueEntry."Document Line No.", 1,
              0, OldItemLedgEntry.Quantity);
            InsertCorrValueEntry(
              OldValueEntry, NewValueEntry, NewItemLedgEntry, ItemJnlLine."Document Line No.", -1,
              NewItemLedgEntry.Quantity, 0);
            InsertCorrValueEntry(
              OldValueEntry, NewValueEntry, NewItemLedgEntry, ItemJnlLine."Document Line No.", -1,
              0, NewItemLedgEntry.Quantity);
        END ELSE
            InsertCorrValueEntry(
              OldValueEntry, NewValueEntry, NewItemLedgEntry, ItemJnlLine."Document Line No.", -1,
              NewItemLedgEntry.Quantity, NewItemLedgEntry.Quantity);

        UpdateOldItemLedgEntry(OldItemLedgEntry, NewItemLedgEntry."Posting Date");
        UpdateItemApplnEntry(OldItemLedgEntry."Entry No.", NewItemLedgEntry."Posting Date");

        IF GlobalItemLedgEntry.Quantity > 0 THEN
            ReserveItemJnlLine.TransferItemJnlToItemLedgEntry(
              ItemJnlLine, GlobalItemLedgEntry, ItemJnlLine."Quantity (Base)", TRUE);

        IF NOT ItemJnlLine.IsATOCorrection THEN BEGIN
            ApplyItemLedgEntry(NewItemLedgEntry, OldItemLedgEntry2, NewValueEntry, FALSE);
            AutoTrack(NewItemLedgEntry);
        END;

        NewItemLedgEntry.MODIFY;
        UpdateAdjmtProp(NewValueEntry, NewItemLedgEntry."Posting Date");

        IF NewItemLedgEntry.Positive THEN BEGIN
            UpdateOrigAppliedFromEntry(OldItemLedgEntry."Entry No.");
            InsertApplEntry(
              NewItemLedgEntry."Entry No.", NewItemLedgEntry."Entry No.",
              OldItemLedgEntry."Entry No.", 0, NewItemLedgEntry."Posting Date",
              -OldItemLedgEntry.Quantity, FALSE);
        END;
    end;


    procedure UndoValuePostingWithJob(OldItemLedgEntryNo: Integer; NewItemLedgEntryNo: Integer)
    var
        OldItemLedgEntry: Record "Item Ledger Entry";
        NewItemLedgEntry: Record "Item Ledger Entry";
        OldValueEntry: Record "Value Entry";
        NewValueEntry: Record "Value Entry";
    begin
        OldItemLedgEntry.GET(OldItemLedgEntryNo);
        NewItemLedgEntry.GET(NewItemLedgEntryNo);
        InitValueEntryNo;

        IF OldItemLedgEntry."Invoiced Quantity" = 0 THEN BEGIN
            CalcILEExpectedAmount(OldValueEntry, OldItemLedgEntry."Entry No.");
            InsertCorrValueEntry(
              OldValueEntry, NewValueEntry, OldItemLedgEntry, OldValueEntry."Document Line No.", 1,
              0, OldItemLedgEntry.Quantity);

            CalcILEExpectedAmount(OldValueEntry, NewItemLedgEntry."Entry No.");
            InsertCorrValueEntry(
              OldValueEntry, NewValueEntry, NewItemLedgEntry, NewItemLedgEntry."Document Line No.", 1,
              0, NewItemLedgEntry.Quantity);
        END ELSE
            InsertCorrValueEntry(
              OldValueEntry, NewValueEntry, NewItemLedgEntry, NewItemLedgEntry."Document Line No.", -1,
              NewItemLedgEntry.Quantity, NewItemLedgEntry.Quantity);

        UpdateOldItemLedgEntry(OldItemLedgEntry, NewItemLedgEntry."Posting Date");
        UpdateOldItemLedgEntry(NewItemLedgEntry, NewItemLedgEntry."Posting Date");
        UpdateItemApplnEntry(OldItemLedgEntry."Entry No.", NewItemLedgEntry."Posting Date");

        NewItemLedgEntry.MODIFY;
        UpdateAdjmtProp(NewValueEntry, NewItemLedgEntry."Posting Date");

        IF NewItemLedgEntry.Positive THEN
            UpdateOrigAppliedFromEntry(OldItemLedgEntry."Entry No.");
    end;

    local procedure InitCorrItemLedgEntry(OldItemLedgEntry: Record "Item Ledger Entry"; var NewItemLedgEntry: Record "Item Ledger Entry")
    var
        EntriesExist: Boolean;
    begin
        IF ItemLedgEntryNo = 0 THEN
            ItemLedgEntryNo := GlobalItemLedgEntry."Entry No.";

        ItemLedgEntryNo := ItemLedgEntryNo + 1;
        NewItemLedgEntry := OldItemLedgEntry;
        ItemTrackingMgt.RetrieveAppliedExpirationDate(NewItemLedgEntry);
        NewItemLedgEntry."Entry No." := ItemLedgEntryNo;
        NewItemLedgEntry.Quantity := -OldItemLedgEntry.Quantity;
        NewItemLedgEntry."Remaining Quantity" := -OldItemLedgEntry.Quantity;
        IF NewItemLedgEntry.Quantity > 0 THEN
            NewItemLedgEntry."Shipped Qty. Not Returned" := 0
        ELSE
            NewItemLedgEntry."Shipped Qty. Not Returned" := NewItemLedgEntry.Quantity;
        NewItemLedgEntry."Invoiced Quantity" := NewItemLedgEntry.Quantity;
        NewItemLedgEntry.Positive := NewItemLedgEntry."Remaining Quantity" > 0;
        NewItemLedgEntry.Open := NewItemLedgEntry."Remaining Quantity" <> 0;
        NewItemLedgEntry."Completely Invoiced" := TRUE;
        NewItemLedgEntry."Last Invoice Date" := NewItemLedgEntry."Posting Date";
        NewItemLedgEntry.Correction := TRUE;
        NewItemLedgEntry."Document Line No." := ItemJnlLine."Document Line No.";
        IF OldItemLedgEntry.Positive THEN
            NewItemLedgEntry."Applies-to Entry" := OldItemLedgEntry."Entry No."
        ELSE
            NewItemLedgEntry."Applies-to Entry" := 0;
        //TRI DG 110810 Add Start
        Item.CHANGECOMPANY(ChangeToCompany);
        Item.GET(NewItemLedgEntry."Item No.");
        NewItemLedgEntry."Qty in Sq.Mt." := Item.UomToSqm(NewItemLedgEntry."Item No.", Item."Base Unit of Measure",
                                                  NewItemLedgEntry.Quantity);

        NewItemLedgEntry."Qty In Carton" := Item.UomToCart(NewItemLedgEntry."Item No.", Item."Base Unit of Measure",
                                                  NewItemLedgEntry.Quantity);

        NewItemLedgEntry."Qty in PCS." := Item.UomToPcs(NewItemLedgEntry."Item No.", Item."Base Unit of Measure",
                                                  NewItemLedgEntry.Quantity);
        //TRI DG 110810 Add Stop

        OnBeforeInsertCorrItemLedgEntry(NewItemLedgEntry, OldItemLedgEntry, ItemJnlLine);
        NewItemLedgEntry.INSERT;

        OnAfterInsertCorrItemLedgEntry(NewItemLedgEntry, ItemJnlLine);

        /*   IF NewItemLedgEntry."Item Tracking" <> NewItemLedgEntry."Item Tracking"::None THEN
              ItemTrackingMgt.ExistingExpirationDate(
                NewItemLedgEntry."Item No.",
                NewItemLedgEntry."Variant Code",
                NewItemLedgEntry."Lot No.",
                NewItemLedgEntry."Serial No.",
                TRUE,
                EntriesExist); */
    end;

    local procedure UpdateOldItemLedgEntry(var OldItemLedgEntry: Record "Item Ledger Entry"; LastInvoiceDate: Date)
    begin
        OldItemLedgEntry."Completely Invoiced" := TRUE;
        OldItemLedgEntry."Last Invoice Date" := LastInvoiceDate;
        OldItemLedgEntry."Invoiced Quantity" := OldItemLedgEntry.Quantity;
        OldItemLedgEntry."Shipped Qty. Not Returned" := 0;
        OldItemLedgEntry.MODIFY;
    end;

    local procedure InsertCorrValueEntry(OldValueEntry: Record "Value Entry"; var NewValueEntry: Record "Value Entry"; ItemLedgEntry: Record "Item Ledger Entry"; DocumentLineNo: Integer; Sign: Integer; QtyToShip: Decimal; QtyToInvoice: Decimal)
    begin
        ValueEntryNo := ValueEntryNo + 1;

        NewValueEntry := OldValueEntry;
        NewValueEntry."Entry No." := ValueEntryNo;
        NewValueEntry."Item Ledger Entry No." := ItemLedgEntry."Entry No.";
        NewValueEntry."User ID" := USERID;
        NewValueEntry."Valued Quantity" := Sign * OldValueEntry."Valued Quantity";
        NewValueEntry."Document Line No." := DocumentLineNo;
        NewValueEntry."Item Ledger Entry Quantity" := QtyToShip;
        NewValueEntry."Invoiced Quantity" := QtyToInvoice;
        NewValueEntry."Expected Cost" := QtyToInvoice = 0;
        IF NOT NewValueEntry."Expected Cost" THEN BEGIN
            NewValueEntry."Cost Amount (Expected)" := -Sign * OldValueEntry."Cost Amount (Expected)";
            NewValueEntry."Cost Amount (Expected) (ACY)" := -Sign * OldValueEntry."Cost Amount (Expected) (ACY)";
            IF QtyToShip = 0 THEN BEGIN
                NewValueEntry."Cost Amount (Actual)" := Sign * OldValueEntry."Cost Amount (Expected)";
                NewValueEntry."Cost Amount (Actual) (ACY)" := Sign * OldValueEntry."Cost Amount (Expected) (ACY)";
            END ELSE BEGIN
                NewValueEntry."Cost Amount (Actual)" := -NewValueEntry."Cost Amount (Actual)";
                NewValueEntry."Cost Amount (Actual) (ACY)" := -NewValueEntry."Cost Amount (Actual) (ACY)";
            END;
            NewValueEntry."Purchase Amount (Expected)" := -Sign * OldValueEntry."Purchase Amount (Expected)";
            NewValueEntry."Sales Amount (Expected)" := -Sign * OldValueEntry."Sales Amount (Expected)";
        END ELSE BEGIN
            NewValueEntry."Cost Amount (Expected)" := -OldValueEntry."Cost Amount (Expected)";
            NewValueEntry."Cost Amount (Expected) (ACY)" := -OldValueEntry."Cost Amount (Expected) (ACY)";
            NewValueEntry."Cost Amount (Actual)" := 0;
            NewValueEntry."Cost Amount (Actual) (ACY)" := 0;
            NewValueEntry."Sales Amount (Expected)" := -OldValueEntry."Sales Amount (Expected)";
            NewValueEntry."Purchase Amount (Expected)" := -OldValueEntry."Purchase Amount (Expected)";
        END;

        NewValueEntry."Purchase Amount (Actual)" := 0;
        NewValueEntry."Sales Amount (Actual)" := 0;
        NewValueEntry."Cost Amount (Non-Invtbl.)" := Sign * OldValueEntry."Cost Amount (Non-Invtbl.)";
        NewValueEntry."Cost Amount (Non-Invtbl.)(ACY)" := Sign * OldValueEntry."Cost Amount (Non-Invtbl.)(ACY)";
        NewValueEntry."Cost Posted to G/L" := 0;
        NewValueEntry."Cost Posted to G/L (ACY)" := 0;
        NewValueEntry."Expected Cost Posted to G/L" := 0;
        NewValueEntry."Exp. Cost Posted to G/L (ACY)" := 0;

        OnBeforeInsertCorrValueEntry(NewValueEntry, OldValueEntry, ItemJnlLine);

        IF NewValueEntry.Inventoriable THEN
            PostInventoryToGL(NewValueEntry);

        NewValueEntry.INSERT;

        OnAfterInsertCorrValueEntry(NewValueEntry, ItemJnlLine);

        ItemApplnEntry.SetOutboundsNotUpdated(ItemLedgEntry);

        UpdateAdjmtProp(NewValueEntry, ItemLedgEntry."Posting Date");

        InsertItemReg(0, 0, NewValueEntry."Entry No.", 0);
        InsertPostValueEntryToGL(NewValueEntry);
    end;

    local procedure UpdateOrigAppliedFromEntry(OldItemLedgEntryNo: Integer)
    var
        ItemApplEntry: Record "Item Application Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        ItemApplEntry.CHANGECOMPANY(ChangeToCompany);
        ItemApplEntry.SETCURRENTKEY("Outbound Item Entry No.", "Item Ledger Entry No.");
        ItemApplEntry.SETRANGE("Outbound Item Entry No.", OldItemLedgEntryNo);
        ItemApplEntry.SETFILTER("Item Ledger Entry No.", '<>%1', OldItemLedgEntryNo);
        IF ItemApplEntry.FINDSET THEN
            REPEAT
                ItemLedgEntry.CHANGECOMPANY(ChangeToCompany);
                IF ItemLedgEntry.GET(ItemApplEntry."Inbound Item Entry No.") AND
                   NOT ItemLedgEntry."Applied Entry to Adjust"
                THEN BEGIN
                    ItemLedgEntry."Applied Entry to Adjust" := TRUE;
                    ItemLedgEntry.MODIFY;
                END;
            UNTIL ItemApplEntry.NEXT = 0;
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        Location.CHANGECOMPANY(ChangeToCompany);
        IF LocationCode = '' THEN
            CLEAR(Location)
        ELSE
            IF Location.Code <> LocationCode THEN
                Location.GET(LocationCode);
    end;


    procedure CheckItemTracking()
    begin
        IF SNRequired AND (ItemJnlLine."Serial No." = '') THEN
            ERROR(GetTextStringWithLineNo(SerialNoRequiredErr, ItemJnlLine."Item No.", ItemJnlLine."Line No."));
        IF LotRequired AND (ItemJnlLine."Lot No." = '') THEN
            ERROR(GetTextStringWithLineNo(LotNoRequiredErr, ItemJnlLine."Item No.", ItemJnlLine."Line No."));
        IF ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Transfer THEN BEGIN
            IF SNRequired THEN
                ItemJnlLine.TESTFIELD("New Serial No.");
            IF LotRequired THEN
                ItemJnlLine.TESTFIELD("New Lot No.");
        END;
    end;

    local procedure CheckItemTrackingInfo(var ItemJnlLine2: Record "Item Journal Line"; var TrackingSpecification: Record "Tracking Specification"; SNInfoRequired: Boolean; LotInfoRequired: Boolean)
    var
        SerialNoInfo: Record "Serial No. Information";
        LotNoInfo: Record "Lot No. Information";
    begin
        IF SNInfoRequired THEN BEGIN
            SerialNoInfo.GET(
              ItemJnlLine2."Item No.", ItemJnlLine2."Variant Code", TrackingSpecification."Serial No.");
            SerialNoInfo.TESTFIELD(Blocked, FALSE);
            IF TrackingSpecification."New Serial No." <> '' THEN BEGIN
                SerialNoInfo.GET(
                  ItemJnlLine2."Item No.", ItemJnlLine2."Variant Code", TrackingSpecification."New Serial No.");
                SerialNoInfo.TESTFIELD(Blocked, FALSE);
            END;
        END ELSE BEGIN
            IF SerialNoInfo.GET(
                 ItemJnlLine2."Item No.", ItemJnlLine2."Variant Code", TrackingSpecification."Serial No.")
            THEN
                SerialNoInfo.TESTFIELD(Blocked, FALSE);
            IF TrackingSpecification."New Serial No." <> '' THEN BEGIN
                IF SerialNoInfo.GET(
                     ItemJnlLine2."Item No.", ItemJnlLine2."Variant Code", TrackingSpecification."New Serial No.")
                THEN
                    SerialNoInfo.TESTFIELD(Blocked, FALSE);
            END;
        END;

        IF LotInfoRequired THEN BEGIN
            LotNoInfo.GET(
              ItemJnlLine2."Item No.", ItemJnlLine2."Variant Code", TrackingSpecification."Lot No.");
            LotNoInfo.TESTFIELD(Blocked, FALSE);
            IF TrackingSpecification."New Lot No." <> '' THEN BEGIN
                LotNoInfo.GET(
                  ItemJnlLine2."Item No.", ItemJnlLine2."Variant Code", TrackingSpecification."New Lot No.");
                LotNoInfo.TESTFIELD(Blocked, FALSE);
            END;
        END ELSE BEGIN
            IF LotNoInfo.GET(
                 ItemJnlLine2."Item No.", ItemJnlLine2."Variant Code", TrackingSpecification."Lot No.")
            THEN
                LotNoInfo.TESTFIELD(Blocked, FALSE);
            IF TrackingSpecification."New Lot No." <> '' THEN BEGIN
                IF LotNoInfo.GET(
                     ItemJnlLine2."Item No.", ItemJnlLine2."Variant Code", TrackingSpecification."New Lot No.")
                THEN
                    LotNoInfo.TESTFIELD(Blocked, FALSE);
            END;
        END;
    end;

    local procedure InsertTempTrkgSpecification(FreeEntryNo: Integer)
    var
        TempTrackingSpecification2: Record "Tracking Specification" temporary;
    begin
        IF NOT TempTrackingSpecification.INSERT THEN BEGIN
            TempTrackingSpecification2 := TempTrackingSpecification;
            TempTrackingSpecification.GET(TempTrackingSpecification2."Item Ledger Entry No.");
            TempTrackingSpecification.DELETE;
            TempTrackingSpecification."Entry No." := FreeEntryNo;
            TempTrackingSpecification.INSERT;
            TempTrackingSpecification := TempTrackingSpecification2;
            TempTrackingSpecification.INSERT;
        END;
    end;

    local procedure IsNotInternalWhseMovement(ItemJnlLine: Record "Item Journal Line"): Boolean
    begin
        WITH ItemJnlLine DO BEGIN
            IF ("Entry Type" = "Entry Type"::Transfer) AND
               ("Location Code" = "New Location Code") AND
               ("Dimension Set ID" = "New Dimension Set ID") AND
               ("Value Entry Type" = "Value Entry Type"::"Direct Cost") AND
               NOT Adjustment
            THEN
                EXIT(FALSE);
            EXIT(TRUE)
        END;
    end;


    procedure SetCalledFromInvtPutawayPick(NewCalledFromInvtPutawayPick: Boolean)
    begin
        CalledFromInvtPutawayPick := NewCalledFromInvtPutawayPick;
    end;


    procedure SetCalledFromAdjustment(NewCalledFromAdjustment: Boolean; NewPostToGL: Boolean)
    begin
        CalledFromAdjustment := NewCalledFromAdjustment;
        PostToGL := NewPostToGL;
    end;


    procedure NextOperationExist(ProdOrderRtngLine: Record "Prod. Order Routing Line"): Boolean
    begin
        EXIT(ProdOrderRtngLine."Next Operation No." <> '');
    end;

    local procedure UpdateAdjmtProp(ValueEntry: Record "Value Entry"; OriginalPostingDate: Date)
    begin
        ValueEntry.CHANGECOMPANY(ChangeToCompany);
        WITH ValueEntry DO
            SetAdjmtProp("Item No.", "Item Ledger Entry Type", Adjustment,
              "Order Type", "Order No.", "Order Line No.", OriginalPostingDate, "Valuation Date");
    end;

    local procedure SetAdjmtProp(ItemNo: Code[20]; ItemLedgEntryType: Option; Adjustment: Boolean; OrderType: Option; OrderNo: Code[20]; OrderLineNo: Integer; OriginalPostingDate: Date; ValuationDate: Date)
    begin
        SetItemAdjmtProp(ItemNo, ItemLedgEntryType, Adjustment, OriginalPostingDate, ValuationDate);
        SetOrderAdjmtProp(ItemLedgEntryType, OrderType, OrderNo, OrderLineNo, OriginalPostingDate, ValuationDate);
    end;

    local procedure SetItemAdjmtProp(ItemNo: Code[20]; ItemLedgEntryType: Option; Adjustment: Boolean; OriginalPostingDate: Date; ValuationDate: Date)
    var
        Item: Record Item;
        ValueEntry: Record "Value Entry";
        ModifyItem: Boolean;
    begin
        IF ItemLedgEntryType = ValueEntry."Item Ledger Entry Type"::" " THEN
            EXIT;
        IF Adjustment THEN
            IF NOT (ItemLedgEntryType IN [ValueEntry."Item Ledger Entry Type"::Output,
                                          ValueEntry."Item Ledger Entry Type"::"Assembly Output"])
            THEN
                EXIT;
        Item.CHANGECOMPANY(ChangeToCompany);
        WITH Item DO
            IF GET(ItemNo) AND ("Allow Online Adjustment" OR "Cost is Adjusted") AND (Type = Type::Inventory) THEN BEGIN
                LOCKTABLE;
                IF "Cost is Adjusted" THEN BEGIN
                    "Cost is Adjusted" := FALSE;
                    ModifyItem := TRUE;
                END;
                IF "Allow Online Adjustment" THEN BEGIN
                    IF "Costing Method" = "Costing Method"::Average THEN
                        "Allow Online Adjustment" := AllowAdjmtOnPosting(ValuationDate)
                    ELSE
                        "Allow Online Adjustment" := AllowAdjmtOnPosting(OriginalPostingDate);
                    ModifyItem := ModifyItem OR NOT "Allow Online Adjustment";
                END;
                IF ModifyItem THEN
                    MODIFY;
            END;
    end;

    local procedure SetOrderAdjmtProp(ItemLedgEntryType: Option; OrderType: Option; OrderNo: Code[20]; OrderLineNo: Integer; OriginalPostingDate: Date; ValuationDate: Date)
    var
        ValueEntry: Record "Value Entry";
        InvtAdjmtEntryOrder: Record "Inventory Adjmt. Entry (Order)";
        ProdOrderLine: Record "Prod. Order Line";
        AssemblyHeader: Record "Assembly Header";
        ModifyOrderAdjmt: Boolean;
    begin
        IF NOT (OrderType IN [ValueEntry."Order Type"::Production,
                              ValueEntry."Order Type"::Assembly])
        THEN
            EXIT;

        IF ItemLedgEntryType IN [ValueEntry."Item Ledger Entry Type"::Output,
                                 ValueEntry."Item Ledger Entry Type"::"Assembly Output"]
        THEN
            EXIT;
        InvtAdjmtEntryOrder.CHANGECOMPANY(ChangeToCompany);
        WITH InvtAdjmtEntryOrder DO
            IF GET(OrderType, OrderNo, OrderLineNo) THEN BEGIN
                IF "Allow Online Adjustment" OR "Cost is Adjusted" THEN BEGIN
                    LOCKTABLE;
                    IF "Cost is Adjusted" THEN BEGIN
                        "Cost is Adjusted" := FALSE;
                        ModifyOrderAdjmt := TRUE;
                    END;
                    IF "Allow Online Adjustment" THEN BEGIN
                        "Allow Online Adjustment" := AllowAdjmtOnPosting(OriginalPostingDate);
                        ModifyOrderAdjmt := ModifyOrderAdjmt OR NOT "Allow Online Adjustment";
                    END;
                    IF ModifyOrderAdjmt THEN
                        MODIFY;
                END;
            END ELSE
                CASE OrderType OF
                    "Order Type"::Production:
                        BEGIN
                            ProdOrderLine.GET(ProdOrderLine.Status::Released, OrderNo, OrderLineNo);
                            SetProdOrderLine(ProdOrderLine);
                            SetOrderAdjmtProp(ItemLedgEntryType, OrderType, OrderNo, OrderLineNo, OriginalPostingDate, ValuationDate);
                        END;
                    "Order Type"::Assembly:
                        BEGIN
                            IF OrderLineNo = 0 THEN BEGIN
                                AssemblyHeader.GET(AssemblyHeader."Document Type"::Order, OrderNo);
                                SetAsmOrder(AssemblyHeader);
                            END;
                            SetOrderAdjmtProp(ItemLedgEntryType, OrderType, OrderNo, 0, OriginalPostingDate, ValuationDate);
                        END;
                END;
    end;

    local procedure AllowAdjmtOnPosting(TheDate: Date): Boolean
    begin
        GetInvtSetup;
        WITH InvtSetup DO
            CASE "Automatic Cost Adjustment" OF
                "Automatic Cost Adjustment"::Never:
                    EXIT(FALSE);
                "Automatic Cost Adjustment"::Day:
                    EXIT(TheDate >= CALCDATE('<-1D>', WORKDATE));
                "Automatic Cost Adjustment"::Week:
                    EXIT(TheDate >= CALCDATE('<-1W>', WORKDATE));
                "Automatic Cost Adjustment"::Month:
                    EXIT(TheDate >= CALCDATE('<-1M>', WORKDATE));
                "Automatic Cost Adjustment"::Quarter:
                    EXIT(TheDate >= CALCDATE('<-1Q>', WORKDATE));
                "Automatic Cost Adjustment"::Year:
                    EXIT(TheDate >= CALCDATE('<-1Y>', WORKDATE));
                ELSE
                    EXIT(TRUE);
            END;
    end;

    local procedure InsertBalanceExpCostRevEntry(ValueEntry: Record "Value Entry")
    var
        ValueEntry2: Record "Value Entry";
        ValueEntry3: Record "Value Entry";
        RevExpCostToBalance: Decimal;
        RevExpCostToBalanceACY: Decimal;
    begin
        IF GlobalItemLedgEntry.Quantity - (GlobalItemLedgEntry."Invoiced Quantity" - ValueEntry."Invoiced Quantity") = 0 THEN
            EXIT;
        WITH ValueEntry2 DO BEGIN
            SETCURRENTKEY("Item Ledger Entry No.", "Entry Type");
            SETRANGE("Item Ledger Entry No.", ValueEntry."Item Ledger Entry No.");
            SETRANGE("Entry Type", "Entry Type"::Revaluation);
            SETRANGE("Applies-to Entry", 0);
            IF FINDSET THEN
                REPEAT
                    CalcRevExpCostToBalance(ValueEntry2, ValueEntry."Invoiced Quantity", RevExpCostToBalance, RevExpCostToBalanceACY);
                    IF (RevExpCostToBalance <> 0) OR (RevExpCostToBalanceACY <> 0) THEN BEGIN
                        ValueEntryNo := ValueEntryNo + 1;
                        ValueEntry3 := ValueEntry;
                        ValueEntry3."Entry No." := ValueEntryNo;
                        ValueEntry3."Item Charge No." := '';
                        ValueEntry3."Entry Type" := ValueEntry."Entry Type"::Revaluation;
                        ValueEntry3."Valuation Date" := "Valuation Date";
                        ValueEntry3.Description := '';
                        ValueEntry3."Applies-to Entry" := "Entry No.";
                        ValueEntry3."Cost Amount (Expected)" := RevExpCostToBalance;
                        ValueEntry3."Cost Amount (Expected) (ACY)" := RevExpCostToBalanceACY;
                        ValueEntry3."Valued Quantity" := "Valued Quantity";
                        ValueEntry3."Cost per Unit" := CalcCostPerUnit(RevExpCostToBalance, ValueEntry."Valued Quantity", FALSE);
                        ValueEntry3."Cost per Unit (ACY)" := CalcCostPerUnit(RevExpCostToBalanceACY, ValueEntry."Valued Quantity", TRUE);
                        ValueEntry3."Cost Posted to G/L" := 0;
                        ValueEntry3."Cost Posted to G/L (ACY)" := 0;
                        ValueEntry3."Expected Cost Posted to G/L" := 0;
                        ValueEntry3."Exp. Cost Posted to G/L (ACY)" := 0;
                        ValueEntry3."Invoiced Quantity" := 0;
                        ValueEntry3."Sales Amount (Actual)" := 0;
                        ValueEntry3."Purchase Amount (Actual)" := 0;
                        ValueEntry3."Discount Amount" := 0;
                        ValueEntry3."Cost Amount (Actual)" := 0;
                        ValueEntry3."Cost Amount (Actual) (ACY)" := 0;
                        ValueEntry3."Sales Amount (Expected)" := 0;
                        ValueEntry3."Purchase Amount (Expected)" := 0;
                        InsertValueEntry(ValueEntry3, GlobalItemLedgEntry, FALSE);
                    END;
                UNTIL NEXT = 0;
        END;
    end;

    local procedure IsBalanceExpectedCostFromRev(ItemJnlLine2: Record "Item Journal Line"): Boolean
    begin
        WITH ItemJnlLine2 DO
            EXIT((Item."Costing Method" = Item."Costing Method"::Standard) AND
              (((Quantity = 0) AND ("Invoiced Quantity" <> 0)) OR
               (Adjustment AND NOT GlobalValueEntry."Expected Cost")));
    end;

    local procedure CalcRevExpCostToBalance(ValueEntry: Record "Value Entry"; InvdQty: Decimal; var RevExpCostToBalance: Decimal; var RevExpCostToBalanceACY: Decimal)
    var
        ValueEntry2: Record "Value Entry";
        OldExpectedQty: Decimal;
    begin
        WITH ValueEntry2 DO BEGIN
            RevExpCostToBalance := -ValueEntry."Cost Amount (Expected)";
            RevExpCostToBalanceACY := -ValueEntry."Cost Amount (Expected) (ACY)";
            OldExpectedQty := GlobalItemLedgEntry.Quantity;
            SETCURRENTKEY("Item Ledger Entry No.", "Entry Type");
            SETRANGE("Item Ledger Entry No.", ValueEntry."Item Ledger Entry No.");
            IF GlobalItemLedgEntry.Quantity <> GlobalItemLedgEntry."Invoiced Quantity" THEN BEGIN
                SETRANGE("Entry Type", "Entry Type"::"Direct Cost");
                SETFILTER("Entry No.", '<%1', ValueEntry."Entry No.");
                SETRANGE("Item Charge No.", '');
                IF FINDSET THEN
                    REPEAT
                        OldExpectedQty := OldExpectedQty - "Invoiced Quantity";
                    UNTIL NEXT = 0;

                RevExpCostToBalance := ROUND(RevExpCostToBalance * InvdQty / OldExpectedQty, GLSetup."Amount Rounding Precision");
                RevExpCostToBalanceACY := ROUND(RevExpCostToBalanceACY * InvdQty / OldExpectedQty, Currency."Amount Rounding Precision");
            END ELSE BEGIN
                SETRANGE("Entry Type", "Entry Type"::Revaluation);
                SETRANGE("Applies-to Entry", ValueEntry."Entry No.");
                IF FINDSET THEN
                    REPEAT
                        RevExpCostToBalance := RevExpCostToBalance - "Cost Amount (Expected)";
                        RevExpCostToBalanceACY := RevExpCostToBalanceACY - "Cost Amount (Expected) (ACY)";
                    UNTIL NEXT = 0;
            END;
        END;
    end;

    local procedure IsInterimRevaluation(): Boolean
    begin
        WITH ItemJnlLine DO
            EXIT(("Value Entry Type" = "Value Entry Type"::Revaluation) AND (Quantity <> 0));
    end;

    local procedure InsertPostValueEntryToGL(ValueEntry: Record "Value Entry")
    var
        PostValueEntryToGL: Record "Post Value Entry to G/L";
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
    begin
        PostValueEntryToGL.CHANGECOMPANY(ChangeToCompany);
        IF IsPostToGL(ValueEntry) THEN BEGIN
            PostValueEntryToGL."Value Entry No." := ValueEntry."Entry No.";
            PostValueEntryToGL."Item No." := ValueEntry."Item No.";
            PostValueEntryToGL."Posting Date" := ValueEntry."Posting Date";
            PostValueEntryToGL.INSERT;
        END;

        // 15578   GenJnlPostPreview.SaveValueEntry(ValueEntry);
    end;

    local procedure IsPostToGL(ValueEntry: Record "Value Entry"): Boolean
    begin
        GetInvtSetup;
        WITH ValueEntry DO
            EXIT(
              Inventoriable AND NOT PostToGL AND
              (((NOT "Expected Cost") AND (("Cost Amount (Actual)" <> 0) OR ("Cost Amount (Actual) (ACY)" <> 0))) OR
               (InvtSetup."Expected Cost Posting to G/L" AND (("Cost Amount (Expected)" <> 0) OR ("Cost Amount (Expected) (ACY)" <> 0)))));
    end;

    local procedure MoveApplication(var ItemLedgEntry: Record "Item Ledger Entry"; var OldItemLedgEntry: Record "Item Ledger Entry"): Boolean
    var
        Application: Record "Item Application Entry";
        Enough: Boolean;
        FixedApplication: Boolean;
    begin
        ItemLedgEntry.CHANGECOMPANY(ChangeToCompany);
        WITH ItemLedgEntry DO BEGIN
            FixedApplication := FALSE;
            OldItemLedgEntry.TESTFIELD(Positive, TRUE);

            IF (OldItemLedgEntry."Remaining Quantity" < ABS(Quantity)) AND
               (OldItemLedgEntry."Remaining Quantity" < OldItemLedgEntry.Quantity)
            THEN BEGIN
                Enough := FALSE;
                Application.RESET;
                Application.CHANGECOMPANY(ChangeToCompany);
                Application.SETCURRENTKEY("Inbound Item Entry No.");
                Application.SETRANGE("Inbound Item Entry No.", "Applies-to Entry");
                Application.SETFILTER("Outbound Item Entry No.", '<>0');

                IF Application.FINDSET THEN BEGIN
                    REPEAT
                        IF NOT Application.Fixed THEN BEGIN
                            UnApply(Application);
                            OldItemLedgEntry.CHANGECOMPANY(ChangeToCompany);
                            OldItemLedgEntry.GET(OldItemLedgEntry."Entry No.");
                            OldItemLedgEntry.CALCFIELDS("Reserved Quantity");
                            Enough :=
                              ABS(OldItemLedgEntry."Remaining Quantity" - OldItemLedgEntry."Reserved Quantity") >=
                              ABS("Remaining Quantity");
                        END ELSE
                            FixedApplication := TRUE;
                    UNTIL (Application.NEXT = 0) OR Enough;
                END ELSE
                    EXIT(FALSE); // no applications found that could be undone
                IF NOT Enough AND FixedApplication THEN
                    ERROR(Text027);
                EXIT(Enough);
            END;
            EXIT(TRUE);
        END;
    end;

    local procedure CheckApplication(ItemLedgEntry: Record "Item Ledger Entry"; OldItemLedgEntry: Record "Item Ledger Entry")
    begin
        IF SkipApplicationCheck THEN BEGIN
            SkipApplicationCheck := FALSE;
            EXIT;
        END;

        IF ABS(OldItemLedgEntry."Remaining Quantity" - OldItemLedgEntry."Reserved Quantity") <
           ABS(ItemLedgEntry."Remaining Quantity" - ItemLedgEntry."Reserved Quantity")
        THEN
            OldItemLedgEntry.FIELDERROR("Remaining Quantity", Text004)
    end;

    local procedure CheckApplFromInProduction(var GlobalItemLedgerEntry: Record "Item Ledger Entry"; AppliesFRomEntryNo: Integer)
    var
        OldItemLedgerEntry: Record "Item Ledger Entry";
    begin
        IF AppliesFRomEntryNo = 0 THEN
            EXIT;
        GlobalItemLedgerEntry.CHANGECOMPANY(ChangeToCompany);
        WITH GlobalItemLedgerEntry DO
            IF ("Order Type" = "Order Type"::Production) AND ("Order No." <> '') THEN BEGIN
                OldItemLedgerEntry.GET(AppliesFRomEntryNo);
                IF NOT AllowProdApplication(OldItemLedgerEntry, GlobalItemLedgEntry) THEN
                    ERROR(
                      Text022,
                      OldItemLedgerEntry."Entry Type",
                      "Entry Type",
                      "Item No.",
                      "Order No.");

                IF ItemApplnEntry.CheckIsCyclicalLoop(GlobalItemLedgerEntry, OldItemLedgerEntry) THEN
                    ERROR(
                      Text022,
                      OldItemLedgerEntry."Entry Type",
                      "Entry Type",
                      "Item No.",
                      "Order No.");
            END;
    end;


    procedure RedoApplications()
    var
        TouchedItemLedgEntry: Record "Item Ledger Entry";
        DialogWindow: Dialog;
        "Count": Integer;
        t: Integer;
    begin
        TouchedItemLedgerEntries.CHANGECOMPANY(ChangeToCompany);
        TouchedItemLedgerEntries.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
        IF TouchedItemLedgerEntries.FIND('-') THEN BEGIN
            DialogWindow.OPEN(Text01 +
              '@1@@@@@@@@@@@@@@@@@@@@@@@');
            Count := TouchedItemLedgerEntries.COUNT;
            t := 0;

            REPEAT
                t := t + 1;
                DialogWindow.UPDATE(1, ROUND(t * 10000 / Count, 1));
                TouchedItemLedgEntry.GET(TouchedItemLedgerEntries."Entry No.");
                IF TouchedItemLedgEntry."Remaining Quantity" <> 0 THEN BEGIN
                    ReApply(TouchedItemLedgEntry, 0);
                    TouchedItemLedgEntry.GET(TouchedItemLedgerEntries."Entry No.");
                END;
            UNTIL TouchedItemLedgerEntries.NEXT = 0;
            IF AnyTouchedEntries THEN
                VerifyTouchedOnInventory;
            TouchedItemLedgerEntries.DELETEALL;
            DeleteTouchedEntries;
            DialogWindow.CLOSE;
        END;
    end;

    local procedure UpdateValuedByAverageCost(CostItemLedgEntryNo: Integer; ValuedByAverage: Boolean)
    var
        ValueEntry: Record "Value Entry";
    begin
        IF CostItemLedgEntryNo = 0 THEN
            EXIT;
        ValueEntry.CHANGECOMPANY(ChangeToCompany);
        ValueEntry.SETCURRENTKEY("Item Ledger Entry No.");
        ValueEntry.SETRANGE("Item Ledger Entry No.", CostItemLedgEntryNo);
        ValueEntry.SETRANGE("Valued By Average Cost", NOT ValuedByAverage);
        ValueEntry.MODIFYALL("Valued By Average Cost", ValuedByAverage);
    end;


    procedure CostAdjust()
    var
        InvtSetup: Record "Inventory Setup";
        InventoryPeriod: Record "Inventory Period";
        InvtAdjmt: Codeunit "Inventory Adjustment";
        Opendate: Date;
    begin
        InvtSetup.GET;
        InventoryPeriod.IsValidDate(Opendate);
        IF InvtSetup."Automatic Cost Adjustment" <>
           InvtSetup."Automatic Cost Adjustment"::Never
        THEN BEGIN
            IF Opendate <> 0D THEN
                Opendate := CALCDATE('<+1D>', Opendate);
            InvtAdjmt.SetProperties(TRUE, InvtSetup."Automatic Cost Posting");
            InvtAdjmt.MakeMultiLevelAdjmt;
        END;
    end;

    local procedure TouchEntry(EntryNo: Integer)
    var
        TouchedItemLedgEntry: Record "Item Ledger Entry";
    begin
        TouchedItemLedgEntry.CHANGECOMPANY(ChangeToCompany);
        TouchedItemLedgEntry.GET(EntryNo);
        TouchedItemLedgerEntries := TouchedItemLedgEntry;
        IF NOT TouchedItemLedgerEntries.INSERT THEN;
    end;

    local procedure TouchItemEntryCost(var ItemLedgerEntry: Record "Item Ledger Entry"; IsAdjustment: Boolean)
    var
        ValueEntry: Record "Value Entry";
        AvgCostAdjmtEntryPoint: Record "Avg. Cost Adjmt. Entry Point";
    begin
        ItemLedgerEntry.CHANGECOMPANY(ChangeToCompany);
        ItemLedgerEntry."Applied Entry to Adjust" := TRUE;
        WITH ItemLedgerEntry DO
            SetAdjmtProp("Item No.", "Entry Type", IsAdjustment,
              "Order Type", "Order No.", "Order Line No.",
              "Posting Date", "Posting Date");

        IF NOT IsAdjustment THEN BEGIN
            EnsureValueEntryLoaded(ValueEntry, ItemLedgerEntry);
            AvgCostAdjmtEntryPoint.UpdateValuationDate(ValueEntry);
        END;
    end;


    procedure AnyTouchedEntries(): Boolean
    begin
        EXIT(TouchedItemLedgerEntries.FIND('-'))
    end;

    local procedure GetMaxAppliedValuationdate(ItemLedgerEntry: Record "Item Ledger Entry"): Date
    var
        ToItemApplnEntry: Record "Item Application Entry";
        FromItemledgEntryNo: Integer;
        FromInbound: Boolean;
        MaxDate: Date;
        NewDate: Date;
    begin
        FromInbound := ItemLedgerEntry.Positive;
        FromItemledgEntryNo := ItemLedgerEntry."Entry No.";
        WITH ToItemApplnEntry DO BEGIN
            IF FromInbound THEN BEGIN
                SETCURRENTKEY("Inbound Item Entry No.", "Item Ledger Entry No.", "Outbound Item Entry No.");
                SETRANGE("Inbound Item Entry No.", FromItemledgEntryNo);
                SETFILTER("Outbound Item Entry No.", '<>%1', 0);
                SETFILTER(Quantity, '>%1', 0);
            END ELSE BEGIN
                SETCURRENTKEY("Outbound Item Entry No.", "Item Ledger Entry No.");
                SETRANGE("Outbound Item Entry No.", FromItemledgEntryNo);
                SETFILTER(Quantity, '<%1', 0);
            END;
            IF FINDSET THEN BEGIN
                MaxDate := 0D;
                REPEAT
                    IF FromInbound THEN
                        ItemLedgerEntry.GET("Outbound Item Entry No.")
                    ELSE
                        ItemLedgerEntry.GET("Inbound Item Entry No.");
                    NewDate := GetMaxValuationDate(ItemLedgerEntry);
                    MaxDate := Max(NewDate, MaxDate);
                UNTIL NEXT = 0
            END;
        END;
        EXIT(MaxDate);
    end;

    local procedure "Max"(Date1: Date; Date2: Date): Date
    begin
        IF Date1 > Date2 THEN
            EXIT(Date1);
        EXIT(Date2);
    end;


    procedure SetValuationDateAllValueEntrie(ItemLedgerEntryNo: Integer; ValuationDate: Date; FixedApplication: Boolean)
    var
        ValueEntry: Record "Value Entry";
    begin
        WITH ValueEntry DO BEGIN
            RESET;
            CHANGECOMPANY(ChangeToCompany);
            SETCURRENTKEY("Item Ledger Entry No.");
            SETRANGE("Item Ledger Entry No.", ItemLedgerEntryNo);
            IF FINDSET THEN
                REPEAT
                    IF ("Valuation Date" <> "Posting Date") OR
                       ("Valuation Date" < ValuationDate) OR
                       (("Valuation Date" > ValuationDate) AND FixedApplication)
                    THEN BEGIN
                        "Valuation Date" := ValuationDate;
                        MODIFY;
                    END;
                UNTIL NEXT = 0;
        END;
    end;


    procedure SetServUndoConsumption(Value: Boolean)
    begin
        IsServUndoConsumption := Value;
    end;


    procedure SetProdOrderCompModified(ProdOrderCompIsModified: Boolean)
    begin
        ProdOrderCompModified := ProdOrderCompIsModified;
    end;

    local procedure InsertCountryCode(var NewItemLedgEntry: Record "Item Ledger Entry"; ItemLedgEntry: Record "Item Ledger Entry")
    begin
        IF ItemLedgEntry."Location Code" = '' THEN
            EXIT;
        IF NewItemLedgEntry."Location Code" = '' THEN BEGIN
            Location.GET(ItemLedgEntry."Location Code");
            NewItemLedgEntry."Country/Region Code" := Location."Country/Region Code";
        END ELSE BEGIN
            Location.GET(NewItemLedgEntry."Location Code");
            IF NOT Location."Use As In-Transit" THEN BEGIN
                Location.GET(ItemLedgEntry."Location Code");
                IF NOT Location."Use As In-Transit" THEN
                    NewItemLedgEntry."Country/Region Code" := Location."Country/Region Code";
            END;
        END;
    end;

    local procedure ReservationPreventsApplication(ApplicationEntry: Integer; ItemNo: Code[20]; ReservationsEntry: Record "Item Ledger Entry")
    var
        ReservationEntries: Record "Reservation Entry";
        ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
        ReserveItemLedgEntry: Codeunit "Item Ledger Entry-Reserve";
    begin
        ReservEngineMgt.InitFilterAndSortingLookupFor(ReservationEntries, TRUE);
        ReserveItemLedgEntry.FilterReservFor(ReservationEntries, ReservationsEntry);
        IF ReservationEntries.FINDFIRST THEN;
        ERROR(
          Text029,
          ReservationsEntry.FIELDCAPTION("Applies-to Entry"),
          ApplicationEntry,
          Item.FIELDCAPTION("No."),
          ItemNo,
          ReservEngineMgt.CreateForText(ReservationEntries));
    end;

    local procedure CheckItemTrackingOfComp(TempHandlingSpecification: Record "Tracking Specification"; ItemJnlLine: Record "Item Journal Line")
    begin
        IF SNRequired THEN
            ItemJnlLine.TESTFIELD("Serial No.", TempHandlingSpecification."Serial No.");
        IF LotRequired THEN
            ItemJnlLine.TESTFIELD("Lot No.", TempHandlingSpecification."Lot No.");
    end;

    local procedure MaxConsumptionValuationDate(ProdOrderNo: Code[20]; ItemNo: Code[20]): Date
    var
        ValueEntry: Record "Value Entry";
        ValuationDate: Date;
    begin
        WITH ValueEntry DO BEGIN
            SETCURRENTKEY("Order Type", "Order No.");
            SETRANGE("Order Type", "Order Type"::Production);
            SETRANGE("Order No.", ProdOrderNo);
            SETRANGE("Item Ledger Entry Type", "Item Ledger Entry Type"::Consumption);
            SETRANGE("Item No.", ItemNo);
            IF FINDSET THEN
                REPEAT
                    IF ("Valuation Date" > ValuationDate) AND
                       ("Entry Type" <> "Entry Type"::Revaluation)
                    THEN
                        ValuationDate := "Valuation Date";
                UNTIL NEXT = 0;
            EXIT(ValuationDate);
        END;
    end;

    local procedure CorrectOutputValuationDate(ItemLedgerEntry: Record "Item Ledger Entry")
    var
        ValueEntry: Record "Value Entry";
        TempValueEntry: Record "Value Entry" temporary;
        ProductionOrder: Record "Production Order";
        ValuationDate: Date;
    begin
        IF NOT (ItemLedgerEntry."Entry Type" IN [ItemLedgerEntry."Entry Type"::Consumption, ItemLedgerEntry."Entry Type"::Output]) THEN
            EXIT;
        ProductionOrder.CHANGECOMPANY(ChangeToCompany);
        IF ProductionOrder.GET(ProductionOrder.Status::Released, ItemLedgerEntry."Order No.") THEN
            EXIT;

        IF NOT ItemUsedInConsumptionAndOutput(ItemLedgerEntry."Order No.", ItemLedgerEntry."Item No.") THEN
            EXIT;

        ValuationDate := MaxConsumptionValuationDate(ItemLedgerEntry."Order No.", ItemLedgerEntry."Item No.");
        ValueEntry.CHANGECOMPANY(ChangeToCompany);
        ValueEntry.SETCURRENTKEY("Order Type", "Order No.");
        ValueEntry.SETFILTER("Valuation Date", '<%1', ValuationDate);
        ValueEntry.SETRANGE("Order No.", ItemLedgerEntry."Order No.");
        ValueEntry.SETRANGE("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Output);
        IF ValueEntry.FINDSET THEN
            REPEAT
                TempValueEntry := ValueEntry;
                TempValueEntry.INSERT;
            UNTIL ValueEntry.NEXT = 0;

        UpdateOutputEntryAndChain(TempValueEntry, ValuationDate);
    end;

    local procedure UpdateOutputEntryAndChain(var TempValueEntry: Record "Value Entry" temporary; ValuationDate: Date)
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntryNo: Integer;
    begin
        TempValueEntry.SETCURRENTKEY("Item Ledger Entry No.", "Entry Type");
        IF TempValueEntry.FIND('-') THEN
            REPEAT
                ValueEntry.CHANGECOMPANY(ChangeToCompany);
                ValueEntry.GET(TempValueEntry."Entry No.");
                IF ValueEntry."Valuation Date" < ValuationDate THEN BEGIN
                    IF ItemLedgerEntryNo <> TempValueEntry."Item Ledger Entry No." THEN BEGIN
                        ItemLedgerEntryNo := TempValueEntry."Item Ledger Entry No.";
                        UpdateLinkedValuationDate(ValuationDate, ItemLedgerEntryNo, TRUE);
                    END;

                    ValueEntry."Valuation Date" := ValuationDate;
                    ValueEntry.MODIFY;
                    IF ValueEntry."Entry No." = DirCostValueEntry."Entry No." THEN
                        DirCostValueEntry := ValueEntry;
                END;
            UNTIL TempValueEntry.NEXT = 0;
    end;

    local procedure GetSourceNo(ItemJnlLine: Record "Item Journal Line"): Code[20]
    begin
        IF ItemJnlLine."Invoice-to Source No." <> '' THEN
            EXIT(ItemJnlLine."Invoice-to Source No.");
        EXIT(ItemJnlLine."Source No.");
    end;

    local procedure PostAssemblyResourceConsump()
    var
        CapLedgEntry: Record "Capacity Ledger Entry";
        DirCostAmt: Decimal;
        IndirCostAmt: Decimal;
    begin
        WITH ItemJnlLine DO BEGIN
            InsertCapLedgEntry(CapLedgEntry, Quantity, Quantity);
            CalcDirAndIndirCostAmts(DirCostAmt, IndirCostAmt, Quantity, "Unit Cost", "Indirect Cost %", "Overhead Rate");

            InsertCapValueEntry(CapLedgEntry, "Value Entry Type"::"Direct Cost".AsInteger(), Quantity, Quantity, DirCostAmt);
            InsertCapValueEntry(CapLedgEntry, "Value Entry Type"::"Indirect Cost".AsInteger(), Quantity, 0, IndirCostAmt);
        END;
    end;

    local procedure InsertAsmItemEntryRelation(ItemLedgerEntry: Record "Item Ledger Entry")
    begin
        Item.CHANGECOMPANY(ChangeToCompany);
        Item.GET(ItemLedgerEntry."Item No.");
        IF Item."Item Tracking Code" <> '' THEN BEGIN
            TempItemEntryRelation."Item Entry No." := ItemLedgerEntry."Entry No.";
            TempItemEntryRelation."Serial No." := ItemLedgerEntry."Serial No.";
            TempItemEntryRelation."Lot No." := ItemLedgerEntry."Lot No.";
            TempItemEntryRelation.INSERT;
        END;
    end;

    local procedure VerifyInvoicedQty(ItemLedgerEntry: Record "Item Ledger Entry")
    var
        ItemLedgEntry2: Record "Item Ledger Entry";
        ItemApplnEntry: Record "Item Application Entry";
        SalesShipmentHeader: Record "Sales Shipment Header";
        TotalInvoicedQty: Decimal;
    begin
        IF NOT (ItemLedgerEntry."Drop Shipment" AND (ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Purchase)) THEN
            EXIT;

        ItemApplnEntry.SETCURRENTKEY("Inbound Item Entry No.", "Item Ledger Entry No.", "Outbound Item Entry No.");
        ItemApplnEntry.SETRANGE("Inbound Item Entry No.", ItemLedgerEntry."Entry No.");
        ItemApplnEntry.SETFILTER("Item Ledger Entry No.", '<>%1', ItemLedgerEntry."Entry No.");
        IF ItemApplnEntry.FINDSET THEN BEGIN
            REPEAT
                ItemLedgEntry2.GET(ItemApplnEntry."Item Ledger Entry No.");
                TotalInvoicedQty += ItemLedgEntry2."Invoiced Quantity";
            UNTIL ItemApplnEntry.NEXT = 0;
            IF ItemLedgerEntry."Invoiced Quantity" > ABS(TotalInvoicedQty) THEN BEGIN
                SalesShipmentHeader.GET(ItemLedgEntry2."Document No.");
                IF ItemLedgerEntry."Item Tracking" = ItemLedgerEntry."Item Tracking"::None THEN
                    ERROR(Text032, ItemLedgerEntry."Item No.", SalesShipmentHeader."Order No.");
                ERROR(
                  Text031, ItemLedgerEntry."Item No.", ItemLedgerEntry."Lot No.", ItemLedgerEntry."Serial No.", SalesShipmentHeader."Order No.")
            END;
        END;
    end;

    local procedure TransReserveFromJobPlanningLine(FromJobContractEntryNo: Integer; ToItemJnlLine: Record "Item Journal Line")
    var
        JobPlanningLine: Record "Job Planning Line";
    begin
        JobPlanningLine.SETCURRENTKEY("Job Contract Entry No.");
        JobPlanningLine.SETRANGE("Job Contract Entry No.", FromJobContractEntryNo);
        JobPlanningLine.FINDFIRST;

        IF JobPlanningLine."Remaining Qty. (Base)" >= ToItemJnlLine."Quantity (Base)" THEN
            JobPlanningLine."Remaining Qty. (Base)" := JobPlanningLine."Remaining Qty. (Base)" - ToItemJnlLine."Quantity (Base)"
        ELSE
            JobPlanningLine."Remaining Qty. (Base)" := 0;
        JobPlanningLineReserve.TransferJobLineToItemJnlLine(JobPlanningLine, ToItemJnlLine, ToItemJnlLine."Quantity (Base)");
    end;


    /*  procedure ExciseEntriesExist("Item No.": Code[20]; Type: Option A,C): Boolean
      var
          RG23APartI: Record "13719";
          RG23CPartI: Record "13721";
      begin
          IF Type = Type::A THEN BEGIN
              RG23APartI.SETCURRENTKEY("Item No.");
              RG23APartI.SETFILTER("Item No.", "Item No.");
              EXIT(RG23APartI.FINDFIRST);
          END;
          IF Type = Type::C THEN BEGIN
              RG23CPartI.SETCURRENTKEY("FA No./ Item No.");
              RG23CPartI.SETFILTER("FA No./ Item No.", "Item No.");
              EXIT(RG23CPartI.FINDFIRST);
          END;
      end;*/ // 15578


    procedure InitRG23APartI(Transfered: Boolean; ItemLedgEntry: Record "Item Ledger Entry")
    var
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        //  RG23D: Record "16537";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        ReturnShptHeader: Record "Return Shipment Header";
        Item: Record Item;
    begin
        IF NOT Transfered THEN
            EXIT;
        WITH ItemLedgEntry DO BEGIN
            IF Item.GET("Item No.") THEN
                /* IF Item."Capital Item" THEN
                     EXIT;
             RG23D.RESET;
             RG23D.SETRANGE("Entry No.", ItemJnlLine."Applies-to Entry (RG 23 D)");
             IF RG23D.FINDFIRST THEN BEGIN
                 PurchHeader."Document Type" := RG23D."Document Type";
                 PurchHeader."No." := "Document No.";
                 PurchHeader."Buy-from Vendor No." := RG23D."Source Code";
                 PurchHeader."Pay-to Vendor No." := RG23D."Source Code";
                 PurchHeader.INSERT;
                 PurchLine."Line No." := RG23D."Line No.";
                 PurchLine."Document No." := "Document No.";
                 PurchLine."Document Type" := RG23D."Document Type";
                 PurchLine.VALIDATE("Buy-from Vendor No.", RG23D."Source Code");
                 PurchRcptHeader."Posting Date" := RG23D."Posting Date";
                 PurchRcptHeader."No." := "Document No.";
                 PurchRcptHeader."Order No." := RG23D."Order No.";
                 ReturnShptHeader."Posting Date" := RG23D."Posting Date";
                 ReturnShptHeader."No." := "Document No.";
                 ReturnShptHeader."Return Order No." := RG23D."Order No.";
             END;*/ // 15578
                PurchLine.Type := PurchLine.Type::Item;
            PurchLine.VALIDATE("No.", "Item No.");
            PurchLine."Location Code" := ItemJnlLine."New Location Code";
            PurchLine.VALIDATE(Quantity, -1 * Quantity);
        END;
        // 15578  ExciseInsertRGRegisters.InsertRG23APartIPurchase(PurchLine, PurchRcptHeader, ReturnShptHeader);
        PurchHeader.DELETE;
    end;


    /* procedure InitRG23APartII(Transfered: Boolean; ItemLedgEntry: Record 32)
     var
         PurchLine: Record 39;
      //   RG23D: Record "16537";
         PurchRcptHeader: Record 120;
         ReturnShptHeader: Record 6650;
         PurchHeader: Record 38;
         Item: Record 27;
         PurchInvLine: Record 123;
     begin
         IF NOT Transfered THEN
             EXIT;
         WITH ItemLedgEntry DO BEGIN
             IF Item.GET("Item No.") THEN
                 IF Item."Capital Item" THEN
                     EXIT;
             RG23D.RESET;
             RG23D.SETRANGE("Entry No.", ItemJnlLine."Applies-to Entry (RG 23 D)");
             IF RG23D.FINDFIRST THEN BEGIN
                 PurchHeader."Document Type" := RG23D."Document Type";
                 PurchHeader."No." := "Document No.";
                 PurchHeader."Buy-from Vendor No." := RG23D."Source Code";
                 PurchHeader."Pay-to Vendor No." := RG23D."Source Code";
                 PurchHeader.INSERT;
                 PurchLine."Document Type" := RG23D."Document Type";
                 PurchLine."Document No." := "Document No.";
                 PurchLine."Line No." := RG23D."Line No.";
                 PurchLine.VALIDATE("Buy-from Vendor No.", RG23D."Source Code");
                 PurchRcptHeader."Posting Date" := RG23D."Posting Date";
                 PurchRcptHeader."No." := "Document No.";
                 PurchRcptHeader."Order No." := RG23D."Order No.";
                 ReturnShptHeader."Posting Date" := RG23D."Posting Date";
                 ReturnShptHeader."No." := "Document No.";
                 ReturnShptHeader."Return Order No." := RG23D."Order No.";
             END;
             PurchLine.Type := PurchLine.Type::Item;
             PurchLine.VALIDATE("No.", "Item No.");
             PurchLine."Location Code" := ItemJnlLine."New Location Code";
             PurchLine.VALIDATE(Quantity, -1 * Quantity);
             PurchLine."Excise Bus. Posting Group" := RG23D."Excise Bus. Posting Group";
             PurchLine."Excise Prod. Posting Group" := RG23D."Excise Prod. Posting Group";
             PurchLine."Excise Amount" := -1 * Quantity * RG23D.Amount;
             PurchLine."BED Amount" := -1 * Quantity * RG23D."BED Amount Per Unit";
             PurchLine."AED(GSI) Amount" := -1 * Quantity * RG23D."AED(GSI) Amount Per Unit";
             PurchLine."AED(TTA) Amount" := -1 * Quantity * RG23D."AED(TTA) Amount Per Unit";
             PurchLine."SED Amount" := -1 * Quantity * RG23D."SED Amount Per Unit";
             PurchLine."SAED Amount" := -1 * Quantity * RG23D."SAED Amount Per Unit";
             PurchLine."NCCD Amount" := -1 * Quantity * RG23D."NCCD Amount Per Unit";
             PurchLine."eCess Amount" := -1 * Quantity * RG23D."eCess Amount Per Unit";
             PurchLine."SHE Cess Amount" := -1 * Quantity * RG23D."SHE Cess Amount Per Unit";
             PurchLine."SetOff Available" := RG23D."Setoff Available";
             PurchLine."ADET Amount" := -1 * Quantity * RG23D."ADET Amount Per Unit";
             PurchLine."ADE Amount" := -1 * Quantity * RG23D."ADE Amount Per Unit";
             PurchLine."ADC VAT Amount" := -1 * Quantity * RG23D."ADC VAT Amount Per Unit";
             IF PurchInvLine.GET(RG23D."Document No.", RG23D."Line No.") THEN
                 PurchLine."SetOff Available" := PurchInvLine."Set Off Available";
             PurchLine.CVD := RG23D.CVD;
         END;
         ExciseInsertRGRegisters.InsertRG23APartIIPurchase(PurchLine, PurchRcptHeader, ReturnShptHeader, FALSE);
         PurchHeader.DELETE;
     end;*/ // 15578


    /*  procedure InitRG23CPartI(Transfered: Boolean; ItemLedgEntry: Record 32)
      var
          PurchHeader: Record 38;
          PurchLine: Record 39;
          RG23D: Record "16537";
          PurchRcptHeader: Record 120;
          ReturnShptHeader: Record 6650;
          Item: Record 27;
      begin
          IF NOT Transfered THEN
              EXIT;
          WITH ItemLedgEntry DO BEGIN
              IF Item.GET("Item No.") THEN
                  IF NOT Item."Capital Item" THEN
                      EXIT;
              RG23D.RESET;
              RG23D.SETRANGE("Entry No.", ItemJnlLine."Applies-to Entry (RG 23 D)");
              IF RG23D.FINDFIRST THEN BEGIN
                  PurchHeader."Document Type" := RG23D."Document Type";
                  PurchHeader."No." := "Document No.";
                  PurchHeader."Buy-from Vendor No." := RG23D."Source Code";
                  PurchHeader."Pay-to Vendor No." := RG23D."Source Code";
                  PurchHeader.INSERT;
                  PurchLine."Line No." := RG23D."Line No.";
                  PurchLine."Document No." := "Document No.";
                  PurchLine."Document Type" := RG23D."Document Type";
                  PurchLine.VALIDATE("Buy-from Vendor No.", RG23D."Source Code");
                  PurchRcptHeader."Posting Date" := RG23D."Posting Date";
                  PurchRcptHeader."No." := "Document No.";
                  PurchRcptHeader."Order No." := RG23D."Order No.";
                  ReturnShptHeader."Posting Date" := RG23D."Posting Date";
                  ReturnShptHeader."No." := "Document No.";
                  ReturnShptHeader."Return Order No." := RG23D."Order No.";
              END;
              PurchLine.Type := PurchLine.Type::Item;
              PurchLine.VALIDATE("No.", "Item No.");
              PurchLine."Location Code" := ItemJnlLine."New Location Code";
              PurchLine.VALIDATE(Quantity, -1 * Quantity);
          END;
          ExciseInsertRGRegisters.InsertRG23CPartIPurchase(PurchLine, PurchRcptHeader, ReturnShptHeader);
          PurchHeader.DELETE;
      end;*/ // 15578


    /*  procedure InitRG23CPartII(Transfered: Boolean; ItemLedgEntry: Record 32)
      var
          PurchLine: Record 39;
          RG23D: Record "16537";
          PurchRcptHeader: Record 120;
          ReturnShptHeader: Record 6650;
          PurchHeader: Record 38;
          Item: Record 27;
          PurchInvLine: Record 123;
      begin
          IF NOT Transfered THEN
              EXIT;
          WITH ItemLedgEntry DO BEGIN
              IF Item.GET("Item No.") THEN
                  IF NOT Item."Capital Item" THEN
                      EXIT;
              RG23D.RESET;
              RG23D.SETRANGE("Entry No.", ItemJnlLine."Applies-to Entry (RG 23 D)");
              IF RG23D.FINDFIRST THEN BEGIN
                  PurchHeader."Document Type" := RG23D."Document Type";
                  PurchHeader."No." := "Document No.";
                  PurchHeader."Buy-from Vendor No." := RG23D."Source Code";
                  PurchHeader."Pay-to Vendor No." := RG23D."Source Code";
                  PurchHeader.INSERT;
                  PurchLine."Document Type" := RG23D."Document Type";
                  PurchLine."Document No." := "Document No.";
                  PurchLine."Line No." := RG23D."Line No.";
                  PurchLine.VALIDATE("Buy-from Vendor No.", RG23D."Source Code");
                  PurchRcptHeader."Posting Date" := RG23D."Posting Date";
                  PurchRcptHeader."No." := "Document No.";
                  PurchRcptHeader."Order No." := RG23D."Order No.";
                  ReturnShptHeader."Posting Date" := RG23D."Posting Date";
                  ReturnShptHeader."No." := "Document No.";
                  ReturnShptHeader."Return Order No." := RG23D."Order No.";
              END;
              PurchLine.Type := PurchLine.Type::Item;
              PurchLine.VALIDATE("No.", "Item No.");
              PurchLine."Location Code" := ItemJnlLine."New Location Code";
              PurchLine.VALIDATE(Quantity, -1 * Quantity);
              PurchLine."Excise Bus. Posting Group" := RG23D."Excise Bus. Posting Group";
              PurchLine."Excise Prod. Posting Group" := RG23D."Excise Prod. Posting Group";
              PurchLine."Excise Amount" := -1 * Quantity * RG23D.Amount;
              PurchLine."BED Amount" := -1 * Quantity * RG23D."BED Amount Per Unit";
              PurchLine."AED(GSI) Amount" := -1 * Quantity * RG23D."AED(GSI) Amount Per Unit";
              PurchLine."AED(TTA) Amount" := -1 * Quantity * RG23D."AED(TTA) Amount Per Unit";
              PurchLine."SED Amount" := -1 * Quantity * RG23D."SED Amount Per Unit";
              PurchLine."SAED Amount" := -1 * Quantity * RG23D."SAED Amount Per Unit";
              PurchLine."NCCD Amount" := -1 * Quantity * RG23D."NCCD Amount Per Unit";
              PurchLine."eCess Amount" := -1 * Quantity * RG23D."eCess Amount Per Unit";
              PurchLine."SHE Cess Amount" := -1 * Quantity * RG23D."SHE Cess Amount Per Unit";
              PurchLine."SetOff Available" := RG23D."Setoff Available";
              PurchLine."ADET Amount" := -1 * Quantity * RG23D."ADET Amount Per Unit";
              PurchLine."ADE Amount" := -1 * Quantity * RG23D."ADE Amount Per Unit";
              PurchLine."ADC VAT Amount" := -1 * Quantity * RG23D."ADC VAT Amount Per Unit";
              IF PurchInvLine.GET(RG23D."Document No.", RG23D."Line No.") THEN
                  PurchLine."SetOff Available" := PurchInvLine."Set Off Available";
              PurchLine.CVD := RG23D.CVD;
          END;
          ExciseInsertRGRegisters.InsertRG23CPartIIPurchase(PurchLine, PurchRcptHeader, ReturnShptHeader, FALSE);
          PurchHeader.DELETE;
      end;*/ // 15578


    /* procedure GetNatureOfDisposal(LineEntryType: Option Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output): Code[20]
     var
         TypeOfDisposal: Record "16565";
     begin
         TypeOfDisposal.RESET;

         CASE LineEntryType OF
             LineEntryType::Sale:
                 BEGIN
                     TypeOfDisposal.SETRANGE(Type, TypeOfDisposal.Type::Sale);
                     IF TypeOfDisposal.FINDFIRST THEN
                         EXIT(TypeOfDisposal.Code);

                     EXIT;
                 END;
         END;
     end;*/ // 15578


    /*  procedure InsertRGRegisters()
      begin
          IF NOT ItemJnlLine.Subcontracting THEN
              IF Item."Excise Accounting Type" = Item."Excise Accounting Type"::"With CENVAT" THEN BEGIN
                  IF ExciseEntriesExist(ItemJnlLine."Item No.", 0) AND (NOT Item."Capital Item") THEN
                      ExciseInsertRGRegisters.InsertRG23APartIConsumption(ItemJnlLine);
                  IF ExciseEntriesExist(ItemJnlLine."Item No.", 1) AND Item."Capital Item" THEN
                      ExciseInsertRGRegisters.InsertRG23CPartIConsumption(ItemJnlLine);
              END;
      end;*/ // 15578


    procedure UpdateDetailTaxEntry(DetailedTaxEntryNo_: Integer; MainComponentEntryNo_: Integer; DocumentNo_: Code[20]; DocumentLineNo_: Integer)
    begin
        DetailedTaxEntryNo := DetailedTaxEntryNo_;
        MainComponentEntryNo := MainComponentEntryNo_;
        DocumentNo := DocumentNo_;
        DocumentLineNo := DocumentLineNo_;
    end;


    /*  procedure UpdateSalesTaxTrackingEntry(ItemLedgerEntry: Record 32)
      var
          SalesTaxTrackingEntry: Record "16540";
          SalesTaxTrackingEntry2: Record "16540";
      begin
          WITH SalesTaxTrackingEntry DO BEGIN
              INIT;
              SalesTaxTrackingEntry2.RESET;
              IF SalesTaxTrackingEntry2.FINDLAST THEN
                  "Entry No." := SalesTaxTrackingEntry2."Entry No." + 1
              ELSE
                  "Entry No." := 1;
              "Main Component Entry No." := MainComponentEntryNo;
              "Item Ledger Entry No." := ItemLedgerEntry."Entry No.";
              Quantity := ItemLedgerEntry.Quantity;
              "Remaining Quantity" := ItemLedgerEntry.Quantity;
              INSERT;
          END;
      end;*/ // 15578


    procedure SetSubcon(SubconValueFrom: Boolean)
    begin
        SubconValue := SubconValueFrom;
    end;


    procedure SetSubconConsumptionLine(SubconConsumptionFrom: Boolean)
    begin
        CalledFromSubconConsumption := SubconConsumptionFrom;
    end;


    procedure SetExciseComp(BEDAmt2: Decimal; AEDGSIAmt2: Decimal; AEDTTAAmt2: Decimal; SEDAmt2: Decimal; SAEDAmt2: Decimal; CESSAmt2: Decimal; NCCDAmt2: Decimal)
    begin
        BEDAmt := BEDAmt2;
        AEDGSIAmt := AEDGSIAmt2;
        AEDTTAAmt := AEDTTAAmt2;
        SEDAmt := SEDAmt2;
        SAEDAmt := SAEDAmt2;
        CESSAmt := CESSAmt2;
        NCCDAmt := NCCDAmt2;
    end;


    procedure SetExciseComp2(eCessAmt2: Decimal; SHECessAmt2: Decimal; ADETAmt2: Decimal; ADEAmt2: Decimal; ADCVATAmt2: Decimal; ExciseBaseAmt2: Decimal; ExciseAmt2: Decimal)
    begin
        eCessAmt := eCessAmt2;
        SHECessAmt := SHECessAmt2;
        ADETAmt := ADETAmt2;
        ADEAmt := ADEAmt2;
        ADCVATAmt := ADCVATAmt2;
        ExciseBaseAmt := ExciseBaseAmt2;
        ExciseAmt := ExciseAmt2;
    end;

    local procedure ItemUsedInConsumptionAndOutput(ProdOrderNo: Code[20]; ItemNo: Code[20]): Boolean
    var
        ValueEntry: Record "Value Entry";
    begin
        ValueEntry.SETRANGE(ValueEntry."Order Type", ValueEntry."Order Type"::Production);
        ValueEntry.SETRANGE(ValueEntry."Order No.", ProdOrderNo);
        ValueEntry.SETRANGE(ValueEntry."Item No.", ItemNo);
        ValueEntry.SETRANGE(ValueEntry."Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Consumption);
        IF ValueEntry.ISEMPTY THEN
            EXIT(FALSE);

        ValueEntry.SETRANGE(ValueEntry."Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Output);
        EXIT(NOT ValueEntry.ISEMPTY);

    end;


    procedure SetupTempSplitItemJnlLine(ItemJnlLine2: Record "Item Journal Line"; SignFactor: Integer; var NonDistrQuantity: Decimal; var NonDistrAmount: Decimal; var NonDistrAmountACY: Decimal; var NonDistrDiscountAmount: Decimal; Invoice: Boolean; var PostItemJnlLine: Boolean)
    var
        FloatingFactor: Decimal;
    begin
        TempSplitItemJnlLine.CHANGECOMPANY(ChangeToCompany);

        TempSplitItemJnlLine."Quantity (Base)" := SignFactor * TempTrackingSpecification."Qty. to Handle (Base)";
        TempSplitItemJnlLine.Quantity := SignFactor * TempTrackingSpecification."Qty. to Handle";
        IF Invoice THEN BEGIN
            TempSplitItemJnlLine."Invoiced Quantity" := SignFactor * TempTrackingSpecification."Qty. to Invoice";
            TempSplitItemJnlLine."Invoiced Qty. (Base)" := SignFactor * TempTrackingSpecification."Qty. to Invoice (Base)";
        END;

        IF ItemJnlLine2."Output Quantity" <> 0 THEN BEGIN
            TempSplitItemJnlLine."Output Quantity (Base)" := TempSplitItemJnlLine."Quantity (Base)";
            TempSplitItemJnlLine."Output Quantity" := TempSplitItemJnlLine.Quantity;
        END;

        IF ItemJnlLine2."Phys. Inventory" THEN
            TempSplitItemJnlLine."Qty. (Phys. Inventory)" := TempSplitItemJnlLine."Qty. (Calculated)" + SignFactor * TempSplitItemJnlLine."Quantity (Base)";

        FloatingFactor := TempSplitItemJnlLine.Quantity / NonDistrQuantity;
        IF FloatingFactor < 1 THEN BEGIN
            TempSplitItemJnlLine.Amount := ROUND(NonDistrAmount * FloatingFactor, GLSetup."Amount Rounding Precision");
            TempSplitItemJnlLine."Amount (ACY)" := ROUND(NonDistrAmountACY * FloatingFactor, Currency."Amount Rounding Precision");
            TempSplitItemJnlLine."Discount Amount" := ROUND(NonDistrDiscountAmount * FloatingFactor, GLSetup."Amount Rounding Precision");
            NonDistrAmount := NonDistrAmount - TempSplitItemJnlLine.Amount;
            NonDistrAmountACY := NonDistrAmountACY - TempSplitItemJnlLine."Amount (ACY)";
            NonDistrDiscountAmount := NonDistrDiscountAmount - TempSplitItemJnlLine."Discount Amount";
            NonDistrQuantity := NonDistrQuantity - TempSplitItemJnlLine.Quantity;
            TempSplitItemJnlLine."Setup Time" := 0;
            TempSplitItemJnlLine."Run Time" := 0;
            TempSplitItemJnlLine."Stop Time" := 0;
            TempSplitItemJnlLine."Setup Time (Base)" := 0;
            TempSplitItemJnlLine."Run Time (Base)" := 0;
            TempSplitItemJnlLine."Stop Time (Base)" := 0;
            TempSplitItemJnlLine."Starting Time" := 0T;
            TempSplitItemJnlLine."Ending Time" := 0T;
            TempSplitItemJnlLine."Scrap Quantity" := 0;
            TempSplitItemJnlLine."Scrap Quantity (Base)" := 0;
            TempSplitItemJnlLine."Concurrent Capacity" := 0;
        END ELSE BEGIN
            // the last record
            TempSplitItemJnlLine.Amount := NonDistrAmount;
            TempSplitItemJnlLine."Amount (ACY)" := NonDistrAmountACY;
            TempSplitItemJnlLine."Discount Amount" := NonDistrDiscountAmount;
        END;

        IF ROUND(TempSplitItemJnlLine."Unit Amount" * TempSplitItemJnlLine.Quantity, GLSetup."Amount Rounding Precision") <> TempSplitItemJnlLine.Amount THEN
            IF (TempSplitItemJnlLine."Unit Amount" = TempSplitItemJnlLine."Unit Cost") AND (TempSplitItemJnlLine."Unit Cost" <> 0) THEN BEGIN
                TempSplitItemJnlLine."Unit Amount" := ROUND(TempSplitItemJnlLine.Amount / TempSplitItemJnlLine.Quantity, 0.00001);
                TempSplitItemJnlLine."Unit Cost" := ROUND(TempSplitItemJnlLine.Amount / TempSplitItemJnlLine.Quantity, 0.00001);
                TempSplitItemJnlLine."Unit Cost (ACY)" := ROUND(TempSplitItemJnlLine."Amount (ACY)" / TempSplitItemJnlLine.Quantity, 0.00001);
            END ELSE
                TempSplitItemJnlLine."Unit Amount" := ROUND(TempSplitItemJnlLine.Amount / TempSplitItemJnlLine.Quantity, 0.00001);

        TempSplitItemJnlLine."Serial No." := TempTrackingSpecification."Serial No.";
        TempSplitItemJnlLine."Lot No." := TempTrackingSpecification."Lot No.";
        TempSplitItemJnlLine."New Serial No." := TempTrackingSpecification."New Serial No.";
        TempSplitItemJnlLine."New Lot No." := TempTrackingSpecification."New Lot No.";
        TempSplitItemJnlLine."Item Expiration Date" := TempTrackingSpecification."Expiration Date";
        TempSplitItemJnlLine."New Item Expiration Date" := TempTrackingSpecification."New Expiration Date";

        IF NOT PostItemJnlLine THEN
            PostItemJnlLine :=
              (TempSplitItemJnlLine."Serial No." <> TempSplitItemJnlLine."New Serial No.") OR
              (TempSplitItemJnlLine."Lot No." <> TempSplitItemJnlLine."New Lot No.") OR
              (TempSplitItemJnlLine."Item Expiration Date" <> TempSplitItemJnlLine."New Item Expiration Date");

        TempSplitItemJnlLine."Warranty Date" := TempTrackingSpecification."Warranty Date";

        TempSplitItemJnlLine."Line No." := TempTrackingSpecification."Entry No.";

        IF TempTrackingSpecification.Correction OR TempSplitItemJnlLine."Drop Shipment" OR IsServUndoConsumption THEN
            TempSplitItemJnlLine."Applies-to Entry" := TempTrackingSpecification."Item Ledger Entry No."
        ELSE
            TempSplitItemJnlLine."Applies-to Entry" := TempTrackingSpecification."Appl.-to Item Entry";
        TempSplitItemJnlLine."Applies-from Entry" := TempTrackingSpecification."Appl.-from Item Entry";
        TempSplitItemJnlLine.INSERT;

    end;


    procedure CreateRealeseProdOrder(ReleaseQty: Decimal; ItemNo: Code[20]; OrgProdNo: Code[20]; Loccode: Code[20]; var VariantCode: Code[20]; PostingDate: Date; ItemJnlLine2: Record "Item Journal Line")
    var
        ProductionOrder: Record "Production Order";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MfgSetup: Record "Manufacturing Setup";
        ProductionOrderSta: Record "Production Order";
        ProdOrderStatusManagement: Codeunit "Prod. Order Status Management";
        ProdNo: Code[20];
        ChangeStatusForm: Page "Change Status on Prod. Order";
        ProdOrderComp2: Record "Prod. Order Component";
        Prodline: Record "Prod. Order Line";
        ProductionOrderNew: Record "Production Order";
        CreateProdOrderLines: Codeunit "Create Prod. Order Lines";
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        ProductionOrder2: Record "Production Order";
        Item: Record Item;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        UOMMgt: Codeunit "Unit of Measure Management";
        UomAmt: Decimal;
    begin
        MfgSetup.GET;
        MfgSetup.TESTFIELD(MfgSetup."Released Order Nos.");
        IF ProductionOrder2.GET(ProductionOrder2.Status::Released, OrgProdNo) THEN; //MSAK060515

        ProdNo := '';
        ProductionOrder.INIT;
        ProductionOrder.Status := ProductionOrder.Status::Released;
        //ProductionOrder."No." := NoSeriesMgt.GetNextNo(MfgSetup."Released Order Nos.",TODAY,TRUE);//MSAK060515
        ProductionOrder."No." := NoSeriesMgt.GetNextNo(ProductionOrder2."No. Series", TODAY, TRUE);//MSAK060515
        ProductionOrder.VALIDATE("Source Type", ProductionOrder."Source Type"::Item);
        ProductionOrder.VALIDATE(ProductionOrder."Source No.", ItemNo);
        ProductionOrder.VALIDATE(ProductionOrder."Location Code", Loccode);
        ProductionOrder."Original Prod. No" := OrgProdNo;
        ProductionOrder."Prod. Reporting No." := ProductionOrder2."Prod. Reporting No."; //MSKS
        ProductionOrder."Prod. Reporting Line No." := ProductionOrder2."Prod. Reporting Line No."; //MSKS
        ProductionOrder."Re Process Production Order" := TRUE;
        ProductionOrder.INSERT(TRUE);
        ProductionOrder.VALIDATE("Starting Time", TIME);
        ProductionOrder.VALIDATE("Starting Date", ItemJnlLine2."Posting Date");
        //IF ProductionOrder."Prod. Reporting No." <> '' THEN
        ProductionOrder.VALIDATE(Quantity, ReleaseQty);
        //  ELSE
        //ProductionOrder.VALIDATE(ConversionQty,ReleaseQty);
        ProductionOrder.VALIDATE("Shortcut Dimension 1 Code", ItemJnlLine2."Shortcut Dimension 1 Code");
        ProductionOrder.VALIDATE("Shortcut Dimension 2 Code", ItemJnlLine2."Shortcut Dimension 2 Code");
        ProdNo := ProductionOrder."No.";
        ProductionOrder."Due Date" := ItemJnlLine2."Posting Date";
        ProductionOrder.MODIFY;


        ProductionOrderNew.RESET;
        ProductionOrderNew.SETRANGE(Status, ProductionOrderNew.Status::Released);
        ProductionOrderNew.SETRANGE("No.", ProductionOrder."No.");
        IF ProductionOrderNew.FIND('-') THEN
            CreateProdOrderLines.Copy(ProductionOrderNew, 1, VariantCode, FALSE);

        /*TRI P.G 18.06.2010 -- Code Commented
        ProductionOrder.SETRANGE(Status,ProductionOrder.Status::Released);
        ProductionOrder.SETRANGE("No.",ProductionOrder."No.");
         IF ProductionOrder.FINDFIRST THEN
        //    REPORT.RUNMODAL(REPORT::"Refresh Production Order",FALSE,FALSE,ProductionOrder);//TRi karan
        TRI P.G 18.06.2010 -- Code Commented*/


        Prodline.RESET;
        Prodline.SETRANGE(Prodline.Status, Prodline.Status::Released);
        Prodline.SETRANGE("Prod. Order No.", ProductionOrder."No.");
        IF Prodline.FIND('-') THEN BEGIN
            Prodline.VALIDATE("Routing No.", ItemJnlLine2."Routing No.");
            Prodline.VALIDATE("Routing Reference No.", Prodline."Line No.");
            IF Prodline."Prod. Reporting No." <> '' THEN
                Prodline.VALIDATE("Unit of Measure Code", 'CRT')
            ELSE
                Prodline.VALIDATE("Unit of Measure Code", ItemJnlLine2."Unit of Measure Code");
            Prodline.VALIDATE("Work Shift Code", ItemJnlLine2."Work Shift Code");
            Prodline."Production Plant Code" := ItemJnlLine2."Production Plant Code";
            Prodline.MODIFY;

            ProdOrderComp2.INIT;
            ProdOrderComp2.Status := Prodline.Status;
            ProdOrderComp2."Prod. Order No." := Prodline."Prod. Order No.";
            ProdOrderComp2."Prod. Order Line No." := Prodline."Line No.";
            ProdOrderComp2."Line No." := 10000;
            ProdOrderComp2.VALIDATE("Item No.", ItemJnlLine."Item No.");
            /*
            IF ProductionOrder."Prod. Reporting No."<>'' THEN BEGIN
            Item.GET(ItemJnlLine."Item No.");
            UomAmt := UOMMgt.GetQtyPerUnitOfMeasure(Item,ItemJnlLine."Unit of Measure Code");
            ProdOrderComp2.VALIDATE("Quantity per",UomAmt);
            ProdOrderComp2."Expected Qty. (Base)":= ReleaseQty;
            ProdOrderComp2."Expected Quantity" := ReleaseQty;
            ProdOrderComp2."Qty. per Unit of Measure" :=1;
            END ELSE*/
            ProdOrderComp2.VALIDATE("Quantity per", 1);
            //ProdOrderComp2.VALIDATE(Quantity,ReleaseQty);
            ProdOrderComp2.VALIDATE("Unit of Measure Code", Prodline."Unit of Measure Code"); //MSKS
            ProdOrderComp2."Location Code" := ItemJnlLine2."Location Code";
            ProdOrderComp2."Shortcut Dimension 1 Code" := ItemJnlLine2."Shortcut Dimension 1 Code";
            ProdOrderComp2."Shortcut Dimension 2 Code" := ItemJnlLine2."Shortcut Dimension 2 Code";
            ProdOrderComp2."Original Component" := TRUE;
            ProdOrderComp2."Flushing Method" := ProdOrderComp2."Flushing Method"::Backward;
            ProdOrderComp2."Variant Code" := ItemJnlLine2."Variant Code";
            ProdOrderComp2.INSERT;


            ProdOrderRoutingLine.INIT;
            ProdOrderRoutingLine.Status := Prodline.Status;
            ProdOrderRoutingLine."Prod. Order No." := Prodline."Prod. Order No.";
            ProdOrderRoutingLine."Routing No." := ItemJnlLine2."Routing No.";
            ProdOrderRoutingLine."Routing Reference No." := Prodline."Line No.";
            ProdOrderRoutingLine."Operation No." := FORMAT(1);
            ProdOrderRoutingLine.Type := ProdOrderRoutingLine.Type::"Work Center";
            ProdOrderRoutingLine."Original Component" := TRUE;
            ProdOrderRoutingLine.INSERT;
            ProdOrderRoutingLine."Starting Date" := ItemJnlLine2."Posting Date";
            ProdOrderRoutingLine."Starting Time" := TIME;
            ProdOrderRoutingLine."Ending Date" := ItemJnlLine2."Posting Date";
            ProdOrderRoutingLine."Ending Time" := TIME;
            ProdOrderRoutingLine.VALIDATE("No.", 'AUTORPO');
            ProdOrderRoutingLine."Flushing Method" := ProdOrderRoutingLine."Flushing Method"::Backward;
            ProdOrderRoutingLine.MODIFY;
        END;

        IF MfgSetup."Create Release Prod. Order" = FALSE THEN BEGIN
            ProductionOrderSta.RESET;
            ProductionOrderSta.SETRANGE(Status, ProductionOrder.Status);
            ProductionOrderSta.SETRANGE("No.", ProductionOrder."No.");
            /* IF ProductionOrderSta.FIND('-') THEN
                 ProdOrderStatusManagement.ChangeStatusOnProdOrder(ProductionOrderSta, ProductionOrderSta.Status::Finished, TODAY, TRUE);*/ // 15578
        END;

        /*
        
        //TRI-VKG START
        ProductionOrderSta.RESET;
        ProductionOrderSta.SETRANGE(Status,ProductionOrder.Status);
        ProductionOrderSta.SETRANGE("No.",ProductionOrder."No.");
        IF ProductionOrderSta.FIND('-') THEN BEGIN
          PostReleaseProdOrder(ProductionOrderSta,VariantCode,PostingDate,ItemJnlLine2,ItemNo);
          //TRI V.D 03.07.10 START
          tgAutomaticRPO.INIT;
          tgAutomaticRPO."RPO No." := ProductionOrderSta."No.";
          tgAutomaticRPO.Status := ProductionOrderSta.Status;
          tgAutomaticRPO.INSERT;
          //TRI V.D 03.07.10 STOP
        END;
        //TRI-VKG STOP
        */

    end;


    procedure TGupdatePlantCode(RecInbound: Integer; RecOutBound: Integer; RecItemLedger: Integer; RecTransferentry: Integer)
    var
        RecItemLedgentry: Record "Item Ledger Entry";
        RecItemLedgentryInbound: Record "Item Ledger Entry";
    begin
        //TRI S.R 210310 - New Code Add Start
        IF RecItemLedgentry.GET(RecItemLedger) THEN BEGIN
            IF RecItemLedgentry."Production Plant Code" = '' THEN BEGIN
                IF RecItemLedgentryInbound.GET(RecInbound) THEN BEGIN
                    IF RecItemLedgentryInbound."Production Plant Code" <> '' THEN BEGIN
                        IF RecItemLedgentry."Production Plant Code" = '' THEN BEGIN
                            RecItemLedgentry."Production Plant Code" := RecItemLedgentryInbound."Production Plant Code";
                            RecItemLedgentry.MODIFY;
                        END;
                    END ELSE BEGIN
                        IF RecItemLedgentryInbound.GET(RecOutBound) THEN BEGIN
                            IF RecItemLedgentryInbound."Production Plant Code" <> '' THEN BEGIN
                                IF RecItemLedgentry."Production Plant Code" = '' THEN BEGIN
                                    RecItemLedgentry."Production Plant Code" := RecItemLedgentryInbound."Production Plant Code";
                                    RecItemLedgentry.MODIFY;
                                END;
                            END ELSE BEGIN
                                IF RecItemLedgentryInbound.GET(RecTransferentry) THEN BEGIN
                                    IF RecItemLedgentryInbound."Production Plant Code" <> '' THEN BEGIN
                                        IF RecItemLedgentry."Production Plant Code" = '' THEN BEGIN
                                            RecItemLedgentry."Production Plant Code" := RecItemLedgentryInbound."Production Plant Code";
                                            RecItemLedgentry.MODIFY;
                                        END;
                                    END;
                                END;
                            END;
                        END;
                    END;
                END ELSE BEGIN
                    IF RecItemLedgentryInbound.GET(RecOutBound) THEN BEGIN
                        IF RecItemLedgentryInbound."Production Plant Code" <> '' THEN BEGIN
                            IF RecItemLedgentry."Production Plant Code" = '' THEN BEGIN
                                RecItemLedgentry."Production Plant Code" := RecItemLedgentryInbound."Production Plant Code";
                                RecItemLedgentry.MODIFY;
                            END;
                        END ELSE BEGIN
                            IF RecItemLedgentryInbound.GET(RecTransferentry) THEN BEGIN
                                IF RecItemLedgentryInbound."Production Plant Code" <> '' THEN BEGIN
                                    IF RecItemLedgentry."Production Plant Code" = '' THEN BEGIN
                                        RecItemLedgentry."Production Plant Code" := RecItemLedgentryInbound."Production Plant Code";
                                        RecItemLedgentry.MODIFY;
                                    END;
                                END;
                            END;
                        END;
                    END;
                END;
            END;
        END;
        //TRI S.R 210310 - New Code Add Stop
    end;


    procedure PostReleaseProdOrder(PostProductionOrder: Record "Production Order"; var VariantCode2: Code[20]; PostingDate: Date; ItemJnlLine3: Record "Item Journal Line"; ItemNo: Code[20])
    var
        OutputJnlExplRoute: Codeunit "Output Jnl.-Expl. Route";
        vItemJnlLine2: Record "Item Journal Line";
        MftgSetup: Record "Manufacturing Setup";
        ProdOrderCom: Record "Prod. Order Component";
        ProdOrderFinish: Record "Production Order";
        ProdOrderStatusMgt: Codeunit "Prod. Order Status Management";
        ChangeStatusForm: Page "Change Status on Prod. Order";
        DimLineNo: Integer;
    begin

        //TRI-VKG ADD THIS FUNCTION FOR POSTING RELEASE PRODUCTION ORDER
        MftgSetup.GET;
        OutPutLineNo += 20000;
        vItemJnlLine2.INIT;
        vItemJnlLine2.VALIDATE("Posting Date", PostingDate);
        vItemJnlLine2.VALIDATE("Journal Template Name", 'OUTPUT');
        vItemJnlLine2.VALIDATE("Journal Batch Name", MftgSetup."Output Batch Name");
        vItemJnlLine2.VALIDATE("Line No.", OutPutLineNo);
        vItemJnlLine2.VALIDATE("Entry Type", vItemJnlLine2."Entry Type"::Output);
        vItemJnlLine2.VALIDATE("Order No.", PostProductionOrder."No.");
        vItemJnlLine2.VALIDATE("Work Shift Code", ItemJnlLine3."Work Shift Code");
        vItemJnlLine2.VALIDATE("Item No.", ItemNo);
        vItemJnlLine2.VALIDATE("Unit of Measure Code", ItemJnlLine3."Unit of Measure Code");
        vItemJnlLine2.INSERT;

        vItemJnlLine2.RESET;
        vItemJnlLine2.SETRANGE("Journal Template Name", 'OUTPUT');
        vItemJnlLine2.SETRANGE("Journal Batch Name", MftgSetup."Output Batch Name");
        vItemJnlLine2.SETRANGE("Order No.", PostProductionOrder."No.");
        vItemJnlLine2.SETRANGE("Line No.", OutPutLineNo);
        IF vItemJnlLine2.FIND('-') THEN BEGIN
            OutputJnlExplRoute.RUN(vItemJnlLine2);
            vItemJnlLine2.RESET;
            vItemJnlLine2.SETRANGE("Journal Template Name", 'OUTPUT');
            vItemJnlLine2.SETRANGE("Journal Batch Name", MftgSetup."Output Batch Name");
            IF vItemJnlLine2.FINDFIRST THEN BEGIN
                vItemJnlLine2.VALIDATE("Work Shift Code", ItemJnlLine3."Work Shift Code");
                vItemJnlLine2.RESET;
                vItemJnlLine2.SETRANGE("Journal Template Name", 'OUTPUT');
                vItemJnlLine2.SETRANGE("Journal Batch Name", MftgSetup."Output Batch Name");
                IF vItemJnlLine2.FINDSET THEN
                    REPEAT
                        vItemJnlLine2.VALIDATE("Unit of Measure Code", ItemJnlLine3."Unit of Measure Code");
                    UNTIL vItemJnlLine2.NEXT = 0;
                vItemJnlLine2.VALIDATE("Variant Code", VariantCode2);
                vItemJnlLine2.MODIFY;
            END;
        END;

        ConsLineNo += 10000;
        ProdOrderCom.RESET;
        ProdOrderCom.SETRANGE("Prod. Order No.", PostProductionOrder."No.");
        IF ProdOrderCom.FIND('-') THEN BEGIN
            vItemJnlLine2.INIT;
            vItemJnlLine2.VALIDATE("Journal Template Name", 'CONSUMP');
            vItemJnlLine2.VALIDATE("Journal Batch Name", MftgSetup."Consumption Batch Name");
            vItemJnlLine2.VALIDATE("Posting Date", PostingDate);
            vItemJnlLine2.VALIDATE("Line No.", ConsLineNo);
            vItemJnlLine2.VALIDATE("Entry Type", vItemJnlLine2."Entry Type"::Consumption);
            vItemJnlLine2.VALIDATE("Order No.", ProdOrderCom."Prod. Order No.");
            vItemJnlLine2.VALIDATE("Entry Type", vItemJnlLine2."Entry Type"::Consumption);
            vItemJnlLine2.VALIDATE("Item No.", ProdOrderCom."Item No.");
            vItemJnlLine2.VALIDATE("Unit of Measure Code", ItemJnlLine3."Unit of Measure Code");
            vItemJnlLine2.VALIDATE(Quantity, ProdOrderCom.Quantity);
            vItemJnlLine2.VALIDATE("Variant Code", ItemJnlLine3."Variant Code");
            vItemJnlLine2.VALIDATE("Work Shift Code", ItemJnlLine3."Work Shift Code");
            vItemJnlLine2.VALIDATE("Location Code", ProdOrderCom."Location Code");
            vItemJnlLine2.INSERT;
        END;
        //Finish Production Order
        //  ProdOrderStatusMgt.ChangeStatusOnProdOrder(PostProductionOrder,4,PostingDate,TRUE);
    end;

    local procedure ReservationExists(ItemJnlLine: Record "Item Journal Line"): Boolean
    var
        ReservEntry: Record "Reservation Entry";
        ProductionOrder: Record "Production Order";
    begin
        WITH ReservEntry DO BEGIN
            SETRANGE("Source ID", ItemJnlLine."Order No.");
            IF ItemJnlLine."Prod. Order Comp. Line No." <> 0 THEN
                SETRANGE("Source Ref. No.", ItemJnlLine."Prod. Order Comp. Line No.");
            SETRANGE("Source Type", DATABASE::"Prod. Order Component");
            SETRANGE("Source Subtype", ProductionOrder.Status::Released);
            SETRANGE("Source Batch Name", '');
            SETRANGE("Source Prod. Order Line", ItemJnlLine."Order Line No.");
            SETFILTER("Qty. to Handle (Base)", '<>0');
            EXIT(NOT ISEMPTY);
        END;
    end;

    local procedure VerifyTouchedOnInventory()
    var
        ItemLedgEntryApplied: Record "Item Ledger Entry";
    begin
        WITH TouchedItemLedgerEntries DO BEGIN
            FINDSET;
            REPEAT
                ItemLedgEntryApplied.GET("Entry No.");
                ItemLedgEntryApplied.VerifyOnInventory;
            UNTIL NEXT = 0;
        END;
    end;

    local procedure CheckIsCyclicalLoop(ItemLedgEntry: Record "Item Ledger Entry"; OldItemLedgEntry: Record "Item Ledger Entry"; var PrevAppliedItemLedgEntry: Record "Item Ledger Entry"; var AppliedQty: Decimal)
    var
        PrevProcessedProdOrder: Boolean;
    begin
        PrevProcessedProdOrder :=
          (ItemLedgEntry."Entry Type" = ItemLedgEntry."Entry Type"::Consumption) AND
          (OldItemLedgEntry."Entry Type" = OldItemLedgEntry."Entry Type"::Output) AND
          (ItemLedgEntry."Order Type" = ItemLedgEntry."Order Type"::Production) AND
          EntriesInTheSameOrder(OldItemLedgEntry, PrevAppliedItemLedgEntry);

        IF NOT PrevProcessedProdOrder THEN
            IF AppliedQty <> 0 THEN
                IF ItemLedgEntry.Positive THEN BEGIN
                    IF ItemApplnEntry.CheckIsCyclicalLoop(ItemLedgEntry, OldItemLedgEntry) THEN
                        AppliedQty := 0;
                END ELSE
                    IF ItemApplnEntry.CheckIsCyclicalLoop(OldItemLedgEntry, ItemLedgEntry) THEN
                        AppliedQty := 0;

        IF AppliedQty <> 0 THEN
            PrevAppliedItemLedgEntry := OldItemLedgEntry;
    end;

    local procedure EntriesInTheSameOrder(OldItemLedgEntry: Record "Item Ledger Entry"; PrevAppliedItemLedgEntry: Record "Item Ledger Entry"): Boolean
    begin
        EXIT(
          (PrevAppliedItemLedgEntry."Order Type" = PrevAppliedItemLedgEntry."Order Type"::Production) AND
          (OldItemLedgEntry."Order Type" = OldItemLedgEntry."Order Type"::Production) AND
          (OldItemLedgEntry."Order No." = PrevAppliedItemLedgEntry."Order No.") AND
          (OldItemLedgEntry."Order Line No." = PrevAppliedItemLedgEntry."Order Line No."));
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertTransferEntry(var NewItemLedgerEntry: Record "Item Ledger Entry"; var OldItemLedgerEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertValueEntry(var ValueEntry: Record "Value Entry"; var ItemJournalLine: Record "Item Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInsertValueEntry(var ValueEntry: Record "Value Entry"; var ItemJournalLine: Record "Item Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertCorrItemLedgEntry(var NewItemLedgerEntry: Record "Item Ledger Entry"; var OldItemLedgerEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInsertCorrItemLedgEntry(var NewItemLedgerEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertCorrValueEntry(var NewValueEntry: Record "Value Entry"; var OldValueEntry: Record "Value Entry"; var ItemJournalLine: Record "Item Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInsertCorrValueEntry(var NewValueEntry: Record "Value Entry"; var ItemJournalLine: Record "Item Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePostItemJnlLine(var ItemJournalLine: Record "Item Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPostItemJnlLine(var ItemJournalLine: Record "Item Journal Line")
    begin
    end;


    procedure SetSkipApplicationCheck(NewValue: Boolean)
    begin
        SkipApplicationCheck := NewValue;
    end;


    procedure LogApply(ApplyItemLedgEntry: Record "Item Ledger Entry"; AppliedItemLedgEntry: Record "Item Ledger Entry")
    var
        ItemApplnEntry: Record "Item Application Entry";
    begin
        ItemApplnEntry.CHANGECOMPANY(ChangeToCompany);
        AppliedItemLedgEntry.CHANGECOMPANY(ChangeToCompany);
        ItemApplnEntry.INIT;
        IF AppliedItemLedgEntry.Quantity > 0 THEN BEGIN
            ItemApplnEntry."Item Ledger Entry No." := ApplyItemLedgEntry."Entry No.";
            ItemApplnEntry."Inbound Item Entry No." := AppliedItemLedgEntry."Entry No.";
            ItemApplnEntry."Outbound Item Entry No." := ApplyItemLedgEntry."Entry No.";
        END ELSE BEGIN
            ItemApplnEntry."Item Ledger Entry No." := AppliedItemLedgEntry."Entry No.";
            ItemApplnEntry."Inbound Item Entry No." := ApplyItemLedgEntry."Entry No.";
            ItemApplnEntry."Outbound Item Entry No." := AppliedItemLedgEntry."Entry No.";
        END;
        AddToApplicationLog(ItemApplnEntry, TRUE);
    end;


    procedure LogUnapply(ItemApplnEntry: Record "Item Application Entry")
    begin
        AddToApplicationLog(ItemApplnEntry, FALSE);
    end;

    local procedure AddToApplicationLog(ItemApplnEntry: Record "Item Application Entry"; IsApplication: Boolean)
    begin
        TempItemApplnEntryHistory.CHANGECOMPANY(ChangeToCompany);
        ItemApplnEntry.CHANGECOMPANY(ChangeToCompany);
        WITH TempItemApplnEntryHistory DO BEGIN
            IF FINDLAST THEN;
            "Primary Entry No." += 1;

            "Item Ledger Entry No." := ItemApplnEntry."Item Ledger Entry No.";
            "Inbound Item Entry No." := ItemApplnEntry."Inbound Item Entry No.";
            "Outbound Item Entry No." := ItemApplnEntry."Outbound Item Entry No.";

            "Cost Application" := IsApplication;
            INSERT;
        END;
    end;


    procedure ClearApplicationLog()
    begin
        TempItemApplnEntryHistory.CHANGECOMPANY(ChangeToCompany);
        TempItemApplnEntryHistory.DELETEALL;
    end;


    procedure UndoApplications()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemApplnEntry: Record "Item Application Entry";
    begin
        TempItemApplnEntryHistory.CHANGECOMPANY(ChangeToCompany);
        WITH TempItemApplnEntryHistory DO BEGIN
            ASCENDING(FALSE);
            IF FINDSET THEN
                REPEAT
                    IF "Cost Application" THEN BEGIN
                        ItemApplnEntry.CHANGECOMPANY(ChangeToCompany);
                        ItemApplnEntry.SETRANGE("Inbound Item Entry No.", "Inbound Item Entry No.");
                        ItemApplnEntry.SETRANGE("Outbound Item Entry No.", "Outbound Item Entry No.");
                        ItemApplnEntry.FINDFIRST;
                        UnApply(ItemApplnEntry);
                    END ELSE BEGIN
                        ItemLedgEntry.CHANGECOMPANY(ChangeToCompany);
                        ItemLedgEntry.GET("Item Ledger Entry No.");
                        SetSkipApplicationCheck(TRUE);
                        ReApply(ItemLedgEntry, "Inbound Item Entry No.");
                    END;
                UNTIL NEXT = 0;
            ClearApplicationLog;
            ASCENDING(TRUE);
        END;
    end;


    procedure ApplicationLogIsEmpty(): Boolean
    begin
        TempItemApplnEntryHistory.CHANGECOMPANY(ChangeToCompany);
        EXIT(TempItemApplnEntryHistory.ISEMPTY);
    end;

    local procedure AppliedEntriesToReadjust(ItemLedgEntry: Record "Item Ledger Entry"): Boolean
    begin
        WITH ItemLedgEntry DO
            EXIT("Entry Type" IN ["Entry Type"::Output, "Entry Type"::"Assembly Output"]);
    end;

    local procedure GetTextStringWithLineNo(BasicTextString: Text; ItemNo: Code[20]; LineNo: Integer): Text
    begin
        IF LineNo = 0 THEN
            EXIT(STRSUBSTNO(BasicTextString, ItemNo));
        EXIT(STRSUBSTNO(BasicTextString, ItemNo) + STRSUBSTNO(LineNoTxt, LineNo));
    end;


    procedure SetCalledFromApplicationWorksheet(IsCalledFromApplicationWorksheet: Boolean)
    begin
        CalledFromApplicationWorksheet := IsCalledFromApplicationWorksheet;
    end;

    local procedure SaveTouchedEntry(ItemLedgerEntryNo: Integer; IsInbound: Boolean)
    var
        ItemApplicationEntryHistory: Record "Item Application Entry History";
        NextEntryNo: Integer;
    begin
        IF NOT CalledFromApplicationWorksheet THEN
            EXIT;

        WITH ItemApplicationEntryHistory DO BEGIN
            IF FINDLAST THEN
                NextEntryNo := "Primary Entry No." + 1
            ELSE
                NextEntryNo := 1;

            INIT;
            "Primary Entry No." := NextEntryNo;
            "Entry No." := 0;
            "Item Ledger Entry No." := ItemLedgerEntryNo;
            IF IsInbound THEN
                "Inbound Item Entry No." := ItemLedgerEntryNo
            ELSE
                "Outbound Item Entry No." := ItemLedgerEntryNo;
            "Creation Date" := CURRENTDATETIME;
            "Created By User" := USERID;
            INSERT;
        END;
    end;


    procedure RestoreTouchedEntries(var TempItem: Record Item temporary)
    var
        ItemApplicationEntryHistory: Record "Item Application Entry History";
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        WITH ItemApplicationEntryHistory DO BEGIN
            SETRANGE("Entry No.", 0);
            SETRANGE("Created By User", UPPERCASE(USERID));
            IF FINDSET THEN
                REPEAT
                    TouchEntry("Item Ledger Entry No.");

                    ItemLedgerEntry.GET("Item Ledger Entry No.");
                    TempItem."No." := ItemLedgerEntry."Item No.";
                    IF TempItem.INSERT THEN;
                UNTIL NEXT = 0;
        END;
    end;

    local procedure DeleteTouchedEntries()
    var
        ItemApplicationEntryHistory: Record "Item Application Entry History";
    begin
        IF NOT CalledFromApplicationWorksheet THEN
            EXIT;

        WITH ItemApplicationEntryHistory DO BEGIN
            SETRANGE("Entry No.", 0);
            SETRANGE("Created By User", UPPERCASE(USERID));
            DELETEALL;
        END;
    end;

    local procedure GetCombinedDimSetID(DimSetID1: Integer; DimSetID2: Integer): Integer
    var
        DimMgt: Codeunit DimensionManagement;
        DummyGlobalDimCode: array[2] of Code[20];
        DimID: array[10] of Integer;
    begin
        DimID[1] := DimSetID1;
        DimID[2] := DimSetID2;
        EXIT(DimMgt.GetCombinedDimensionSetID(DimID, DummyGlobalDimCode[1], DummyGlobalDimCode[2]));
    end;

    local procedure CalcILEExpectedAmount(var OldValueEntry: Record "Value Entry"; ItemLedgerEntryNo: Integer)
    var
        OldValueEntry2: Record "Value Entry";
    begin
        OldValueEntry.FindFirstValueEntryByItemLedgerEntryNo(ItemLedgerEntryNo);
        OldValueEntry2.COPY(OldValueEntry);
        OldValueEntry2.SETFILTER("Entry No.", '<>%1', OldValueEntry."Entry No.");
        OldValueEntry2.CALCSUMS("Cost Amount (Expected)", "Cost Amount (Expected) (ACY)");
        OldValueEntry."Cost Amount (Expected)" += OldValueEntry2."Cost Amount (Expected)";
        OldValueEntry."Cost Amount (Expected) (ACY)" += OldValueEntry2."Cost Amount (Expected) (ACY)";
    end;


    procedure SetCompany(ChnToCompany: Text)
    begin
        ChangeToCompany := ChnToCompany;
    end;


    procedure CreateItemLedgerEntries(var ItemJournalLine: Record "Item Journal Line")
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        IF ItemLedgEntryNo = 0 THEN BEGIN
            GlobalItemLedgEntry.LOCKTABLE;
            IF GlobalItemLedgEntry.FINDLAST THEN
                ItemLedgEntryNo := GlobalItemLedgEntry."Entry No.";
        END;
        InitValueEntryNo;

        WITH ItemLedgerEntry DO BEGIN
            "Entry No." := ItemLedgEntryNo + 1;
            "Item No." := ItemJnlLine."Item No.";
            "Posting Date" := ItemJnlLine."Posting Date";
            Quantity := -1 * ItemJnlLine."Quantity (Base)";
            ///"Location Code" :=
            "Document No." := ItemJournalLine."Document No.";
            "Document Line No." := ItemJnlLine."Document Line No.";
            "Document Date" := ItemJnlLine."Document Date";
            "Entry Type" := ItemJnlLine."Entry Type";
            INSERT;

        END;
    end;
}

