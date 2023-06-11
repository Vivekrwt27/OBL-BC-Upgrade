codeunit 50046 "Prod. Reporting Mgt."
{

    trigger OnRun()
    begin
    end;

    var
        MfgSetup: Record "Manufacturing Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ProdReportingLine: Record "Prod. Reporting Line";
        ProductionOrder: Record "Production Order";
        ProdOrderLine: Record "Prod. Order Line";
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        ProdReportHeader: Record "Prod. Reporting Header";
        PartiallyConsumed: Boolean;


    procedure PostProdOrder(var ProdReportingHeader: Record "Prod. Reporting Header")
    var
        ProdOrderLine: Record "Prod. Order Line";
        RecProductionOrder: Record "Production Order";
        NotProdOrderLine: Record "Prod. Order Line";
    begin
        IF NOT CONFIRM('Do you want to Create the Release Prod. Order', FALSE, TRUE) THEN
            EXIT;
        WITH ProdReportingHeader DO BEGIN
            IF Posted THEN
                EXIT;
            CheckValidations(ProdReportingHeader);
            CheckAllowedPostingDate("Posting Date");
            ProdReportingLine.RESET;
            ProdReportingLine.SETRANGE("Document No.", "No.");
            IF ProdReportingLine.FINDFIRST THEN
                REPEAT
                    ProductionOrder.RESET;
                    ProductionOrder.SETRANGE(Status, ProductionOrder.Status::Released);
                    ProductionOrder.SETRANGE("Prod. Reporting No.", "No.");
                    ProductionOrder.SETRANGE("Prod. Reporting Line No.", ProdReportingLine."Line No.");
                    IF NOT ProductionOrder.FINDFIRST THEN BEGIN
                        ProductionOrder.INIT;
                        ProductionOrder."No." := GetNextNoSeries(GetProdNoSeries("Prod. Units"), "Posting Date");
                        ProductionOrder.Status := ProductionOrder.Status::Released;
                        ProductionOrder.VALIDATE("Source Type", ProductionOrder."Source Type"::Item);
                        ProductionOrder.VALIDATE("Source No.", ProdReportingLine."FG No.");
                        ProductionOrder.VALIDATE(Description, ProdReportingLine.Description);

                        ProductionOrder.VALIDATE(Quantity, ProdReportingLine."Quantity Produced");
                        ProductionOrder.VALIDATE(ConversionQty, ProdReportingLine."Qty. in CRT.");
                        ProductionOrder.VALIDATE(Status, ProductionOrder.Status::Released);
                        ProductionOrder.VALIDATE("Location Code", ProdReportingLine.Location);
                        ProductionOrder."No. Series" := GetProdNoSeries("Prod. Units");
                        ProductionOrder."Prod. Reporting No." := "No.";
                        ProductionOrder."Prod. Reporting Line No." := ProdReportingLine."Line No.";
                        ProductionOrder."Shortcut Dimension 1 Code" := ProdReportingLine."Shortcut Dimension 1 Code";
                        ProductionOrder."Shortcut Dimension 2 Code" := ProdReportingLine."Shortcut Dimension 2 Code";
                        ProductionOrder."Dimension Set ID" := ProdReportingLine."Dimension Set ID";
                        ProductionOrder.INSERT(TRUE);
                        ProdReportingLine."Prod. Order No." := ProductionOrder."No.";
                        // ProdReportingLine."Prod. Order Line No." := ProdOrderLine."Line No.";
                        ProdReportingLine.MODIFY;
                        //        MESSAGE('Header Posted');
                        ProductionOrder.SETRANGE(Status, ProductionOrder.Status::Released);
                        ProductionOrder.SETRANGE("No.", ProductionOrder."No.");
                        REPORT.RUNMODAL(REPORT::"Refresh Prod. Reporting Order", FALSE, FALSE, ProductionOrder);
                        COMMIT;
                    END;
                UNTIL ProdReportingLine.NEXT = 0;

            ProdReportingLine.RESET;
            ProdReportingLine.SETRANGE("Document No.", "No.");
            IF ProdReportingLine.FINDFIRST THEN
                REPEAT
                    ProdOrderLine.RESET;
                    ProdOrderLine.SETRANGE("Prod. Order No.", ProdReportingLine."Prod. Order No.");
                    IF ProdOrderLine.FINDFIRST THEN
                        REPEAT
                            ProdReportingLine."Prod. Order No." := ProdOrderLine."Prod. Order No.";
                            ProdReportingLine."Prod. Order Line No." := ProdOrderLine."Line No.";
                            ProdReportingLine."Quantity Produced" := ProdOrderLine.Quantity;
                            ProdReportingLine.MODIFY;
                            ProdOrderLine."Work Shift Code" := ProdReportingLine.Shift;
                            ProdOrderLine."Variant Code" := ProdReportingLine."Variant Code";
                            ProdOrderLine."Mfg. Batch No." := ProdReportingLine."Mfg. Batch No."; //MSKS
                            ProdOrderLine.MODIFY;
                        UNTIL ProdOrderLine.NEXT = 0;

                UNTIL ProdReportingLine.NEXT = 0;

            ProdReportingHeader.Status := ProdReportingHeader.Status::Released;
            ProdReportingHeader.Modify();

            MESSAGE('Release Prod. Order Created Successfully!!!!');
        END;
    end;


    procedure CallOutput(var ProdReportingHeader: Record "Prod. Reporting Header"; TemplateName: Code[20]; BatchNAme: Code[20]; ProdOrderLine: Record "Prod. Order Line"; ProdReportingLine: Record "Prod. Reporting Line")
    var
        ItemJournalLine: Record "Item Journal Line";
        LineNo: Integer;
        OutputJnlExplRoute: Codeunit "Output Jnl.-Expl. Route";
        ItemJournalLine2: Record "Item Journal Line";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        ConvFactor: Decimal;
        Item: Record Item;
    begin
        ItemJournalLine.RESET;
        ItemJournalLine.SETRANGE("Journal Template Name", TemplateName);
        ItemJournalLine.SETRANGE("Journal Batch Name", BatchNAme);
        IF ItemJournalLine.FINDFIRST THEN
            ItemJournalLine.DELETEALL;

        ItemJournalLine.RESET;
        ItemJournalLine.SETFILTER("Journal Template Name", TemplateName);
        ItemJournalLine.SETFILTER("Journal Batch Name", BatchNAme);
        IF ItemJournalLine.FINDLAST THEN
            LineNo := ItemJournalLine."Line No." + 10000
        ELSE
            LineNo := 10000;


        ProductionOrder.GET(ProdOrderLine.Status, ProdOrderLine."Prod. Order No.");
        //IF ProdOrderLine.FINDFIRST THEN BEGIN
        //REPEAT
        ItemJournalLine.INIT;
        ItemJournalLine."Journal Template Name" := TemplateName;
        ItemJournalLine."Journal Batch Name" := BatchNAme;
        ItemJournalLine.VALIDATE("Entry Type", ItemJournalLine."Entry Type"::Output);
        ItemJournalLine.VALIDATE("Order No.", ProductionOrder."No.");//1603
        ItemJournalLine.VALIDATE("Posting Date", ProdReportingHeader."Posting Date");

        ItemJournalLine.VALIDATE("Document No.", ProductionOrder."No.");
        ItemJournalLine.VALIDATE("Line No.", LineNo);

        ItemJournalLine.VALIDATE("Item No.", ProductionOrder."Source No.");
        ItemJournalLine.VALIDATE("Variant Code", ProdReportingLine."Variant Code");
        ItemJournalLine.VALIDATE("Location Code", ProductionOrder."Location Code");

        ItemJournalLine.VALIDATE(Quantity, ProdReportingLine."Qty. in CRT.");
        ItemJournalLine.VALIDATE("Output Quantity", ProdReportingLine."Qty. in CRT.");
        Item.GET(ProductionOrder."Source No.");
        IF Item."Base Unit of Measure" = 'SQ.MT' THEN
            ItemJournalLine.VALIDATE("Unit of Measure Code", 'CRT') ELSE
            ItemJournalLine.VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
        ConvFactor := 1;
        ConvFactor := ROUND(ProductionOrder."Qty .Base", 0.01, '=');
        ItemJournalLine.VALIDATE("Economic Quantity", ProdReportingLine."Economic Quantity");
        ItemJournalLine.VALIDATE("Commercial Quantity", ProdReportingLine."Commercial Quantity");
        ItemJournalLine.VALIDATE("Broken Tiles Quantity", ProdReportingLine."Broken Tiles");
        ItemJournalLine.VALIDATE("Work Shift Code", ProdReportingHeader.Shift);
        ItemJournalLine.Finished := TRUE;
        //ItemJournalLine.VALIDATE("Shortcut Dimension 1 Code" , ProductionOrder."Shortcut Dimension 1 Code");
        //ItemJournalLine.VALIDATE("Shortcut Dimension 2 Code" , ProductionOrder."Shortcut Dimension 2 Code");
        IF ItemJournalLine."Gen. Prod. Posting Group" = '' THEN
            ItemJournalLine."Gen. Prod. Posting Group" := 'MANUF';
        ItemJournalLine."Work Shift Code" := ProdReportingHeader.Shift;
        ItemJournalLine."Morbi Batch No." := ProdReportingLine."Morbi Batch No."; //MSKS
        ItemJournalLine."Prod. Reporting No." := ProdReportingHeader."No.";
        ItemJournalLine."Mfg. Batch No." := ProdReportingLine."Mfg. Batch No."; //MSKS
        ItemJournalLine.INSERT;
        LineNo += 10000;
        CheckAllowedPostingDate(ProdReportingHeader."Posting Date");
        OutputJnlExplRoute.RUN(ItemJournalLine);

        ItemJournalLine.RESET;
        ItemJournalLine.SETRANGE("Journal Template Name", TemplateName);
        ItemJournalLine.SETRANGE("Journal Batch Name", BatchNAme);
        IF ItemJournalLine.FINDFIRST THEN
            REPEAT
                IF ItemJournalLine."Gen. Prod. Posting Group" = '' THEN
                    ItemJournalLine."Gen. Prod. Posting Group" := 'MANUF';
                ItemJournalLine.VALIDATE("Economic Quantity", ProdReportingLine."Economic Quantity");
                ItemJournalLine.VALIDATE("Commercial Quantity", ProdReportingLine."Commercial Quantity");
                ItemJournalLine.VALIDATE("Broken Tiles Quantity", ProdReportingLine."Broken Tiles");
                ItemJournalLine.VALIDATE("Work Shift Code", ProdReportingHeader.Shift);
                ItemJournalLine."Prod. Reporting No." := ProdReportingHeader."No.";
                ItemJournalLine.MODIFY;
            UNTIL ItemJournalLine.NEXT = 0;

        CLEAR(ItemJnlPostLine);
        ItemJournalLine.RESET;
        ItemJournalLine.SETRANGE("Journal Template Name", TemplateName);
        ItemJournalLine.SETRANGE("Journal Batch Name", BatchNAme);
        IF ItemJournalLine.FINDFIRST THEN
            REPEAT
                ItemJnlPostLine.RunWithCheck(ItemJournalLine);
            UNTIL ItemJournalLine.NEXT = 0;
    end;


    procedure CallConsumption(var ProdReportingHeader: Record "Prod. Reporting Header"; TemplateName: Code[20]; BatchNAme: Code[20]; ProdOrderLine: Record "Prod. Order Line") Partially: Boolean
    var
        ItemJournalLine: Record "Item Journal Line";
        LineNo: Integer;
        OutputJnlExplRoute: Codeunit "Output Jnl.-Expl. Route";
        ItemJournalLine2: Record "Item Journal Line";
        CalcConsumption: Report "Calc. Consumption";
        ProdOrderComponent: Record "Prod. Order Component";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
    begin
        ItemJournalLine.RESET;
        ItemJournalLine.SETRANGE("Journal Template Name", TemplateName);
        ItemJournalLine.SETRANGE("Journal Batch Name", BatchNAme);
        IF ItemJournalLine.FINDFIRST THEN
            ItemJournalLine.DELETEALL;

        ItemJournalLine.RESET;
        ItemJournalLine.SETFILTER("Journal Template Name", '%1', TemplateName);
        ItemJournalLine.SETFILTER("Journal Batch Name", '%1', BatchNAme);
        IF ItemJournalLine.FINDLAST THEN
            LineNo := ItemJournalLine."Line No." + 10000
        ELSE
            LineNo := 10000;

        ProductionOrder.GET(ProdOrderLine.Status, ProdOrderLine."Prod. Order No.");
        ProdOrderComponent.RESET;
        ProdOrderComponent.SETRANGE(Status, ProdOrderLine.Status);
        ProdOrderComponent.SETRANGE("Prod. Order No.", ProdOrderLine."Prod. Order No.");
        ProdOrderComponent.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
        ProdOrderComponent.SETFILTER("Remaining Qty. (Base)", '<>%1', 0);
        IF ProdOrderComponent.FINDFIRST THEN BEGIN
            REPEAT
                ItemJournalLine.INIT;
                ItemJournalLine."Journal Template Name" := TemplateName;
                ItemJournalLine."Journal Batch Name" := BatchNAme;
                ItemJournalLine.VALIDATE("Entry Type", ItemJournalLine."Entry Type"::Consumption);
                ItemJournalLine.VALIDATE("Document No.", ProductionOrder."No.");
                ItemJournalLine.VALIDATE("Order No.", ProductionOrder."No.");//1603
                ItemJournalLine.VALIDATE("Line No.", LineNo);
                ItemJournalLine.VALIDATE("Item No.", ProdOrderComponent."Item No.");
                ItemJournalLine.VALIDATE("Posting Date", ProdReportingHeader."Posting Date");
                ItemJournalLine.VALIDATE("Location Code", ProductionOrder."Location Code");
                ItemJournalLine.VALIDATE("Order Type", ItemJournalLine."Order Type"::Production);
                ItemJournalLine.VALIDATE(Quantity, ProdOrderComponent."Remaining Qty. (Base)");
                ItemJournalLine."Morbi Batch No." := ProdOrderComponent."Morbi Batch No."; //MSKS
                ItemJournalLine."Work Shift Code" := ProdReportingHeader.Shift;
                //ItemJournalLine.VALIDATE("Item No." , ProductionOrder."Source No.");
                //ItemJournalLine.VALIDATE("Source No.", ProductionOrder."Source No.");
                /*
                ItemJournalLine.VALIDATE(Quantity , ProductionOrder.Quantity);
                ItemJournalLine.VALIDATE("Shortcut Dimension 1 Code" , ProductionOrder."Shortcut Dimension 1 Code");
                ItemJournalLine.VALIDATE("Shortcut Dimension 2 Code" , ProductionOrder."Shortcut Dimension 2 Code");
                */
                //MESSAGE('%2-%1',CheckItemAvailability(ItemJournalLine,FALSE),ItemJournalLine."Item No.");
                //IF NOT CheckItemAvailability(ItemJournalLine,FALSE) THEN

                ProdOrderComponent.CALCFIELDS(Inventory, "Reserve Qty");
                IF ((ProdOrderComponent.Inventory + ProdOrderComponent."Reserve Qty") >= ProdOrderComponent."Remaining Quantity") AND (ProdOrderComponent."Remaining Quantity" <> 0) THEN begin
                    ItemJournalLine.INSERT
                end ELSE
                    IF (ProdOrderComponent."Remaining Quantity" <> 0) THEN
                        Partially := TRUE;
                LineNo += 10000;
                CheckAllowedPostingDate(ProdReportingHeader."Posting Date");


            UNTIL ProdOrderComponent.NEXT = 0;


        END;
        CLEAR(ItemJnlPostLine);
        ItemJournalLine.RESET;
        ItemJournalLine.SETRANGE("Journal Template Name", TemplateName);
        ItemJournalLine.SETRANGE("Journal Batch Name", BatchNAme);
        IF ItemJournalLine.FINDFIRST THEN BEGIN
            //  CheckItemAvailability(ItemJournalLine,TRUE);
            REPEAT
                // IF NOT CheckItemAvailability(ItemJournalLine,TRUE) THEN
                ItemJnlPostLine.RunWithCheck(ItemJournalLine);
            UNTIL ItemJournalLine.NEXT = 0;
        END;

    end;

    local procedure CheckItemAvailability(var ItemJnlLine: Record "Item Journal Line"; ShowError: Boolean) QtyNOTAvailable: Boolean
    var
        Item: Record Item;
        TempSKU: Record "Stockkeeping Unit" temporary;
        ItemJnlLine2: Record "Item Journal Line";
        QtyinItemJnlLine: Decimal;
        AvailableQty: Decimal;
    begin
        CLEAR(ItemJnlLine2);
        ItemJnlLine2.COPYFILTERS(ItemJnlLine);
        IF ItemJnlLine2.FINDSET THEN
            REPEAT
                IF NOT TempSKU.GET(ItemJnlLine2."Location Code", ItemJnlLine2."Item No.", ItemJnlLine2."Variant Code") THEN
                    InsertTempSKU(TempSKU, ItemJnlLine2);
            UNTIL ItemJnlLine2.NEXT = 0;

        IF TempSKU.FINDSET THEN
            REPEAT
                QtyinItemJnlLine := CalcRequiredQty(TempSKU, ItemJnlLine2);
                IF QtyinItemJnlLine < 0 THEN BEGIN
                    Item.GET(TempSKU."Item No.");
                    Item.SETFILTER("Location Filter", TempSKU."Location Code");
                    Item.SETFILTER("Variant Filter", TempSKU."Variant Code");
                    Item.CALCFIELDS("Reserved Qty. on Inventory", "Net Change");
                    AvailableQty := Item."Net Change" - Item."Reserved Qty. on Inventory" + SelfReservedQty(TempSKU, ItemJnlLine2);

                    QtyNOTAvailable := (AvailableQty < ABS(QtyinItemJnlLine));
                    IF ShowError THEN
                        IF (AvailableQty < ABS(QtyinItemJnlLine)) THEN BEGIN
                            ERROR('Item %1 is not in Inventory[%2]  ag. [%3]', Item."No.", AvailableQty, ABS(QtyinItemJnlLine));
                        END;
                END;
            UNTIL TempSKU.NEXT = 0;
        EXIT(QtyNOTAvailable);
    end;

    local procedure InsertTempSKU(var TempSKU: Record "Stockkeeping Unit" temporary; ItemJnlLine: Record "Item Journal Line")
    begin
        WITH TempSKU DO BEGIN
            INIT;
            "Location Code" := ItemJnlLine."Location Code";
            "Item No." := ItemJnlLine."Item No.";
            "Variant Code" := ItemJnlLine."Variant Code";
            INSERT;
        END;
    end;

    local procedure CalcRequiredQty(TempSKU: Record "Stockkeeping Unit" temporary; var ItemJnlLine: Record "Item Journal Line"): Decimal
    var
        SignFactor: Integer;
        QtyinItemJnlLine: Decimal;
    begin
        QtyinItemJnlLine := 0;
        ItemJnlLine.SETRANGE("Item No.", TempSKU."Item No.");
        ItemJnlLine.SETRANGE("Location Code", TempSKU."Location Code");
        ItemJnlLine.SETRANGE("Variant Code", TempSKU."Variant Code");
        ItemJnlLine.FINDSET;
        REPEAT
            IF (ItemJnlLine."Entry Type" IN
                [ItemJnlLine."Entry Type"::Sale,
                 ItemJnlLine."Entry Type"::"Negative Adjmt.",
                 ItemJnlLine."Entry Type"::Consumption]) OR
               (ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Transfer)
            THEN
                SignFactor := -1
            ELSE
                SignFactor := 1;
            QtyinItemJnlLine += ItemJnlLine."Quantity (Base)" * SignFactor;
        UNTIL ItemJnlLine.NEXT = 0;
        EXIT(QtyinItemJnlLine);
    end;

    local procedure SelfReservedQty(SKU: Record "Stockkeeping Unit"; ItemJnlLine: Record "Item Journal Line"): Decimal
    var
        ReservationEntry: Record "Reservation Entry";
    begin
        IF ItemJnlLine."Order Type" <> ItemJnlLine."Order Type"::Production THEN
            EXIT;

        WITH ReservationEntry DO BEGIN
            SETRANGE("Item No.", SKU."Item No.");
            SETRANGE("Location Code", SKU."Location Code");
            SETRANGE("Variant Code", SKU."Variant Code");
            SETRANGE("Source Type", DATABASE::"Prod. Order Component");
            SETRANGE("Source ID", ItemJnlLine."Order No.");
            IF ISEMPTY THEN
                EXIT;
            CALCSUMS("Quantity (Base)");
            EXIT(-"Quantity (Base)");
        END;
    end;


    procedure CheckAllowedPostingDate(PostDate: Date)
    var
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        InvSetup: Record "Inventory Setup";
        Text001: Label 'is not within your range of allowed posting dates';
    begin
        IF (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) THEN BEGIN
            MfgSetup.GET;
            GLSetup.GET;
            IF USERID <> '' THEN
                IF UserSetup.GET(USERID) THEN BEGIN
                    AllowPostingFrom := UserSetup."Allow Posting From";
                    AllowPostingTo := UserSetup."Allow Posting To";
                END;
            IF (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) THEN BEGIN
                AllowPostingFrom := GLSetup."Allow Posting From";
                AllowPostingTo := GLSetup."Allow Posting To";
            END;
            IF AllowPostingTo = 0D THEN
                AllowPostingTo := 99991231D;
        END;
        IF (PostDate < AllowPostingFrom) OR (PostDate > AllowPostingTo) THEN
            //FIELDERROR(PostDate,Text001)
            ERROR('%1 is not within your range of allowed posting dates', PostDate);
    end;

    local procedure CheckValidations(ProductionHeader: Record "Prod. Reporting Header")
    var
        ItemJournalLine: Record "Item Journal Line";
        ProdReportingLine: Record "Prod. Reporting Line";
    begin
        ProdReportingLine.RESET;
        ProdReportingLine.SETFILTER("Document No.", ProductionHeader."No.");
        ProdReportingLine.SETFILTER("Qty. in CRT.", '<>%1', 0);
        IF ProdReportingLine.FINDFIRST THEN
            REPEAT
                IF COMPANYNAME = 'Associate Vendors-Morbi' THEN
                    ProdReportingLine.TESTFIELD("Morbi Batch No.");
                ProdReportingLine.TESTFIELD(Shift);
                ProdReportingLine.TESTFIELD(Location);
            UNTIL ProdReportingLine.NEXT = 0;
    end;

    local procedure ItemLedgerEntriesExists(ProdOrderNo: Code[20]): Boolean
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        ItemLedgEntry.SETCURRENTKEY("Order Type", "Order No.", "Order Line No.");
        ItemLedgEntry.SETRANGE("Order Type", ItemLedgEntry."Order Type"::Production);
        ItemLedgEntry.SETRANGE("Order No.", ProdOrderNo);
        IF ItemLedgEntry.FINDFIRST THEN
            EXIT(TRUE);
    end;

    local procedure GetProdNoSeries(OptPlant: Option " ",SKD,DRA,HSK): Code[10]
    begin
        CASE OptPlant OF
            OptPlant::SKD:
                EXIT('RPOSKD');
            OptPlant::DRA:
                EXIT('RPODRA');
            OptPlant::HSK:
                EXIT('RPOHSK');
        END;
    end;

    local procedure GetNextNoSeries(NOSeriesCode: Code[20]; DtDate: Date): Code[20]
    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        EXIT(NoSeriesManagement.GetNextNo(NOSeriesCode, DtDate, TRUE));
    end;


    procedure ReportOutput(var ProdReportingHeader: Record "Prod. Reporting Header")
    begin
        ProdReportingLine.RESET;
        ProdReportingLine.SETRANGE("Document No.", ProdReportingHeader."No.");
        IF ProdReportingLine.FINDFIRST THEN
            REPEAT
                ProdOrderLine.RESET;
                ProdOrderLine.SETFILTER(Status, '%1', ProdOrderLine.Status::Released);
                ProdOrderLine.SETRANGE("Prod. Order No.", ProdReportingLine."Prod. Order No.");
                ProdOrderLine.SETFILTER("Finished Quantity", '%1', 0);
                IF ProdOrderLine.FINDFIRST THEN
                    REPEAT
                        CallOutput(ProdReportingHeader, 'OUTPUT', 'DEFAULT', ProdOrderLine, ProdReportingLine);
                        ProdReportingLine."Prod. Order No." := ProdOrderLine."Prod. Order No.";
                        ProdReportingLine."Prod. Order Line No." := ProdOrderLine."Line No.";
                        ProdReportingLine."Quantity Produced" := ProdOrderLine.Quantity;
                        ProdReportingLine.MODIFY;
                        IF ProdReportingLine."Commercial Quantity" <> 0 THEN
                            AutoCloseRPO(ProdOrderLine."Prod. Order No.");
                        IF ProdReportingLine."Economic Quantity" <> 0 THEN
                            AutoCloseRPO(ProdOrderLine."Prod. Order No.");
                        IF ProdReportingLine."Broken Tiles" <> 0 THEN
                            AutoCloseRPO(ProdOrderLine."Prod. Order No.");
                    UNTIL ProdOrderLine.NEXT = 0;
            UNTIL ProdReportingLine.NEXT = 0;
        ProdReportingHeader.Posted := TRUE;
        ProdReportingHeader.Status := ProdReportingHeader.Status::"Output Reported";
    end;


    procedure AutoCloseRPO(ProdOrdNo: Code[20])
    var
        ProductionOrderSta: Record "Production Order";
        ProdOrderStatusManagement: Codeunit "Prod. Order Status Management";
    begin
        ProductionOrderSta.RESET;
        ProductionOrderSta.SETRANGE(Status, ProductionOrderSta.Status::Released);
        ProductionOrderSta.SETRANGE("Original Prod. No", ProdOrdNo);
        IF ProductionOrderSta.FIND('-') THEN
            ProdOrderStatusManagement.ChangeProdOrderStatus(ProductionOrderSta, ProductionOrderSta.Status::Finished, TODAY, TRUE); // 15578
    end;


    procedure ReportConsumption(var ProdReportingHeader: Record "Prod. Reporting Header")
    var
        PartiallyCons: Boolean;
    begin
        ProdReportingLine.RESET;
        ProdReportingLine.SETRANGE("Document No.", ProdReportingHeader."No.");
        IF ProdReportingLine.FINDFIRST THEN
            REPEAT
                ProdOrderLine.RESET;
                ProdOrderLine.SETFILTER(Status, '%1', ProdOrderLine.Status::Released);
                ProdOrderLine.SETRANGE("Prod. Order No.", ProdReportingLine."Prod. Order No.");
                IF ProdOrderLine.FINDFIRST THEN
                    REPEAT
                        PartiallyCons := CallConsumption(ProdReportingHeader, 'CONSUMP', 'DEFAULT', ProdOrderLine);
                        IF PartiallyCons THEN
                            PartiallyConsumed := TRUE;
                    UNTIL ProdOrderLine.NEXT = 0;
            UNTIL ProdReportingLine.NEXT = 0;

        IF PartiallyConsumed THEN
            ProdReportingHeader.Status := ProdReportingHeader.Status::"Partially Consumed"
        ELSE
            ProdReportingHeader.Status := ProdReportingHeader.Status::"Consumption Done";
    end;


    procedure CloseDocument(var ProdReportingHeader: Record "Prod. Reporting Header")
    var
        ProdReportingLine: Record "Prod. Reporting Line";
        ProductionOrder: Record "Production Order";
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        IF CONFIRM('Once Finished cannot be reopened, Are you sure to Finish the Prod. Order', FALSE) THEN BEGIN
            ProdReportingLine.RESET;
            ProdReportingLine.SETRANGE("Document No.", ProdReportingHeader."No.");
            IF ProdReportingLine.FINDFIRST THEN
                REPEAT
                    ProductionOrder.GET(ProductionOrder.Status::Released, ProdReportingLine."Prod. Order No.");
                    ItemLedgerEntry.RESET;
                    ItemLedgerEntry.SETCURRENTKEY("Order Type", "Order No.", "Order Line No.", "Prod. Order Comp. Line No.", "Entry Type", "Location Code");
                    ItemLedgerEntry.SETFILTER("Order Type", '%1', ItemLedgerEntry."Order Type"::Production);
                    ItemLedgerEntry.SETRANGE("Order No.", ProductionOrder."No.");
                    ItemLedgerEntry.SETFILTER("Entry Type", '%1', ItemLedgerEntry."Entry Type"::Output);
                    IF ItemLedgerEntry.ISEMPTY THEN
                        ERROR('No Output Entries has been posted cannot be finished.');

                    if CompanyName <> 'Associate Vendors-Morbi' then begin
                        ItemLedgerEntry.RESET;
                        ItemLedgerEntry.SETCURRENTKEY("Order Type", "Order No.", "Order Line No.", "Prod. Order Comp. Line No.", "Entry Type", "Location Code");
                        ItemLedgerEntry.SETFILTER("Order Type", '%1', ItemLedgerEntry."Order Type"::Production);
                        ItemLedgerEntry.SETRANGE("Order No.", ProductionOrder."No.");
                        ItemLedgerEntry.SETFILTER("Entry Type", '%1', ItemLedgerEntry."Entry Type"::Consumption);
                        IF ItemLedgerEntry.ISEMPTY THEN
                            ERROR('No Consumption Entries has been posted cannot be finished.');
                    end;

                    if CompanyName <> 'Associate Vendors-Morbi' then
                        ProductionOrder.TESTFIELD(Finished, FALSE);
                    ProductionOrder.Finished := TRUE;
                    ProductionOrder."Finished By" := USERID;
                    ProductionOrder."Finished Date" := TODAY;
                    ProductionOrder.MODIFY;

                UNTIL ProdReportingLine.NEXT = 0;
            ProdReportingHeader.Status := ProdReportingHeader.Status::Closed;
        END;
    end;
}

