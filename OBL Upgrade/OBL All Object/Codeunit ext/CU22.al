codeunit 50107 "Codeunit 50107-Extend"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterPostOutput', '', false, false)]
    local procedure OnAfterPostOutput(var ItemLedgerEntry: Record "Item Ledger Entry"; var ProdOrderLine: Record "Prod. Order Line"; var ItemJournalLine: Record "Item Journal Line");
    var
        Item: Record 27;
        MftgSetup: Record "Manufacturing Setup";
        ItemMas: Record 27;
        c: Codeunit 22;
    begin
        if Item.Get(ItemJournalLine."Item No.") then begin
            IF (Item."Quality Code" = '1') AND (Item."Item Category Code" IN ['D001', 'H001']) THEN
                ItemJournalLine.TESTFIELD("Mfg. Batch No."); //MSKS

            //TRI-VKG ADD START
            MftgSetup.GET;
            MftgSetup.TESTFIELD(MftgSetup."Output Batch Name");
            MftgSetup.TESTFIELD(MftgSetup."Consumption Batch Name");
            //TRI-VKG ADD END

            IF ItemJournalLine."Commercial Quantity" <> 0 THEN BEGIN
                ItemMas.GET(ItemJournalLine."Item No.");
                ItemMas.TESTFIELD(Premium, TRUE);
                ItemMas.TESTFIELD(Commercial);
                CreateRealeseProdOrder(ItemJournalLine."Commercial Quantity", ItemMas.Commercial, ItemJournalLine."Order No.", ItemJournalLine."Location Code"
                                     , ItemJournalLine."Commercial Varient", ItemJournalLine."Posting Date", ItemJournalLine);
            END;
            IF ItemJournalLine."Economic Quantity" <> 0 THEN BEGIN
                ItemMas.GET(ItemJournalLine."Item No.");
                ItemMas.TESTFIELD(Premium, TRUE);
                ItemMas.TESTFIELD(Economic);
                MESSAGE('%1', ItemMas.Economic);
                CreateRealeseProdOrder(ItemJournalLine."Economic Quantity", ItemMas.Economic, ItemJournalLine."Order No.", ItemJournalLine."Location Code"
                                     , ItemJournalLine."Economic Varient", ItemJournalLine."Posting Date", ItemJournalLine);
            END;
            IF ItemJournalLine."Broken Tiles Quantity" <> 0 THEN BEGIN
                ItemMas.GET(ItemJournalLine."Item No.");
                ItemMas.TESTFIELD(Premium, TRUE);
                ItemMas.TESTFIELD("Broken Tiles");
                CreateRealeseProdOrder(ItemJournalLine."Broken Tiles Quantity", ItemMas."Broken Tiles", ItemJournalLine."Order No.", ItemJournalLine."Location Code"
                                   , ItemJournalLine."Broken Tiles Varient", ItemJournalLine."Posting Date", ItemJournalLine);

            END;
            //TRI S.R 18.02.10 - New Code Add Stop

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 5407, 'OnBeforeFlushProdOrder', '', false, false)]
    local procedure OnBeforeFlushProdOrder(var ProductionOrder: Record "Production Order"; NewStatus: Enum "Production Order Status"; PostingDate: Date; var IsHandled: Boolean)
    begin
        if ProductionOrder."Original Prod. No" <> '' then
            PostingDate := ProductionOrder."Due Date";
    end;



    /*  [EventSubscriber(ObjectType::Codeunit, 22, 'OnBeforePostOutput', '', false, false)]
     local procedure OnBeforePostOutput(var ItemJnlLine: Record "Item Journal Line")
     var
         Item: Record 27;
         MftgSetup: Record "Manufacturing Setup";
         ItemMas: Record 27;
         c: Codeunit 22;
     begin
         if Item.Get(ItemJnlLine."Item No.") then begin
             IF (Item."Quality Code" = '1') AND (Item."Item Category Code" IN ['D001', 'H001']) THEN
                 ItemJnlLine.TESTFIELD("Mfg. Batch No."); //MSKS

             //TRI-VKG ADD START
             MftgSetup.GET;
             MftgSetup.TESTFIELD(MftgSetup."Output Batch Name");
             MftgSetup.TESTFIELD(MftgSetup."Consumption Batch Name");
             //TRI-VKG ADD END

             IF ItemJnlLine."Commercial Quantity" <> 0 THEN BEGIN
                 ItemMas.GET(ItemJnlLine."Item No.");
                 ItemMas.TESTFIELD(Premium, TRUE);
                 ItemMas.TESTFIELD(Commercial);
                 //  CreateRealeseProdOrder(ItemJnlLine."Commercial Quantity", ItemMas.Commercial, ItemJnlLine."Order No.", ItemJnlLine."Location Code"
                 //                       , ItemJnlLine."Commercial Varient", ItemJnlLine."Posting Date", ItemJnlLine);
             END;
             IF ItemJnlLine."Economic Quantity" <> 0 THEN BEGIN
                 ItemMas.GET(ItemJnlLine."Item No.");
                 ItemMas.TESTFIELD(Premium, TRUE);
                 ItemMas.TESTFIELD(Economic);
                 MESSAGE('%1', ItemMas.Economic);
                 // CreateRealeseProdOrder(ItemJnlLine."Economic Quantity", ItemMas.Economic, ItemJnlLine."Order No.", ItemJnlLine."Location Code"
                 //                      , ItemJnlLine."Economic Varient", ItemJnlLine."Posting Date", ItemJnlLine);
             END;
             IF ItemJnlLine."Broken Tiles Quantity" <> 0 THEN BEGIN
                 ItemMas.GET(ItemJnlLine."Item No.");
                 ItemMas.TESTFIELD(Premium, TRUE);
                 ItemMas.TESTFIELD("Broken Tiles");
                 // CreateRealeseProdOrder(ItemJnlLine."Broken Tiles Quantity", ItemMas."Broken Tiles", ItemJnlLine."Order No.", ItemJnlLine."Location Code"
                 //                      , ItemJnlLine."Broken Tiles Varient", ItemJnlLine."Posting Date", ItemJnlLine);

             END;
             //TRI S.R 18.02.10 - New Code Add Stop

         end;



     end;
  */
    [EventSubscriber(ObjectType::Codeunit, 22, 'OnBeforePostItem', '', false, false)]
    local procedure OnBeforePostItem(var ItemJournalLine: Record "Item Journal Line"; var IsHandled: Boolean; CalledFromAdjustment: Boolean)
    var
        Item: Record 27;
        MfgSetup: Record "Manufacturing Setup";
        MSErr0001: Label 'Item No %1 , Line No %2 discoutinued , Please contact to Costing Department.';
    begin


        IF Item.GET(ItemJournalLine."Item No.") THEN BEGIN
            IF NOT CalledFromAdjustment THEN
                IF (UPPERCASE(USERID) <> 'IT005') AND (UPPERCASE(USERID) <> 'ADMIN') AND (UPPERCASE(USERID) <> 'SUMIT') THEN
                    Item.TESTFIELD(Blocked, FALSE);

            //MSBS.Rao Begin Dt. 11-04-13
            MfgSetup.GET;
            IF MfgSetup."Allow Discoutinued" THEN BEGIN
                IF ItemJournalLine."Document Type" <> ItemJournalLine."Document Type"::"Purchase Invoice" THEN
                    IF ItemJournalLine."Entry Type" IN [ItemJournalLine."Entry Type"::Purchase, ItemJournalLine."Entry Type"::Output] THEN
                        IF Item."Inventory Posting Group" IN ['MANUF', 'TRAD'] THEN
                            IF (USERID <> 'ADMIN') THEN
                                IF NOT Item.Retained THEN
                                    ERROR(MSErr0001, Item."No.", ItemJournalLine."Document Line No.");
            END;
            //MSBS.Rao End Dt. 11-04-13

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnBeforeInsertConsumpEntry', '', false, false)]
    local procedure OnBeforeInsertConsumpEntry(var ProdOrderComponent: Record "Prod. Order Component"; QtyBase: Decimal; var ModifyProdOrderComp: Boolean; var ItemJnlLine: Record "Item Journal Line"; var TempSplitItemJnlLine: Record "Item Journal Line" temporary)
    var
        CheckCount: Boolean;
        RecProductionOrder: Record "Production Order";
    begin
        //TRI
        IF CheckCount = TRUE THEN
            EXIT;
        //TRI

        //TRI
        IF RecProductionOrder.GET(RecProductionOrder.Status::Released, ItemJnlLine."Order No.") THEN
            IF RecProductionOrder."Original Prod. No" <> '' THEN
                CheckCount := TRUE;
        //TRI


    end;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterInsertCapLedgEntry', '', false, false)]
    local procedure OnAfterInsertCapLedgEntry(var CapLedgEntry: Record "Capacity Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    var
        RecItem: Record 27;
    begin

        //TRI S.R 04.03.10 - New code Add Start
        IF RecItem.GET(ItemJournalLine."Item No.") THEN BEGIN
            CapLedgEntry.Commercial := RecItem.Commercial;
            CapLedgEntry.Economic := RecItem.Economic;
            CapLedgEntry."Broken Tiles" := RecItem."Broken Tiles";
        END;
        CapLedgEntry."Commercial Quantity" := ItemJournalLine."Commercial Quantity";
        CapLedgEntry."Economic Quantity" := ItemJournalLine."Economic Quantity";
        CapLedgEntry."Broken Tiles Quantity" := ItemJournalLine."Broken Tiles Quantity";
        CapLedgEntry."Gross Weight" := ItemJournalLine."Gross Weight";
        CapLedgEntry."Net Weight" := ItemJournalLine."Net Weight";
        //TRI S.R 04.03.10 - New code Add Stop

        CapLedgEntry."Production Order Comp Line No." := ItemJournalLine."Prod. Order Comp. Line No.";   //TRI DG 040910

    end;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterInsertCapValueEntry', '', false, false)]
    local procedure OnAfterInsertCapValueEntry(var ValueEntry: Record "Value Entry"; ItemJnlLine: Record "Item Journal Line")
    begin
        ValueEntry."Machine Code" := ItemJnlLine."Machine Code";//SHAKTI

    end;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterApplyItemLedgEntrySetFilters', '', false, false)]
    local procedure OnAfterApplyItemLedgEntrySetFilters(var ItemLedgerEntry2: Record "Item Ledger Entry"; ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    var
        CompanyInformation: Record 79;


    begin
        //MSKS
        /*
        CompanyInformation.GET;
        IF CompanyInformation."Block ILE Functionality" THEN
            ItemLedgerEntry2.SETRANGE("Laboratory Test", FALSE);
            */
        //MSKS

    end;


    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    var
        ProductionOrderL: Record 5405;
    begin

        NewItemLedgEntry."Production Plant Code" := ItemJournalLine."Production Plant Code";//TRI S.R 210310 - New Code Add
        NewItemLedgEntry."Gross Weight" := ItemJournalLine."Gross Weight";//TRI S.R 210310 - New Code Add
        NewItemLedgEntry."Net Weight" := ItemJournalLine."Net Weight";//TRI S.R 210310 - New Code Add
        NewItemLedgEntry."Direct Consumption Entries" := ItemJournalLine."Direct Consumption Entries";//TRI S.R 210310 - New Code Add
        NewItemLedgEntry.ReProcess := ItemJournalLine.ReProcess;//TRI S.C
        NewItemLedgEntry."Output Date" := ItemJournalLine."OutPut Date";  //TRI S.K  21.06.10
        NewItemLedgEntry."Depot. Prod Order" := ItemJournalLine."Depot. Prod Order";//TRI S.R 210310 - New Code Add
        NewItemLedgEntry."Mfg. Batch No." := ItemJournalLine."Mfg. Batch No."; //MSKS
        NewItemLedgEntry."External Transfer" := ItemJournalLine."External Transfer"; //ND
                                                                                     //TRI
        NewItemLedgEntry."ILE Entry No. 3.7" := ItemJournalLine."ILE Entry No. 3.7";
        //TRI
        NewItemLedgEntry."Capex No." := ItemJournalLine."Capex No.";//MSBS.Rao 081114
        NewItemLedgEntry."Mfg. Batch No." := ItemJournalLine."Mfg. Batch No."; //MSKS
        NewItemLedgEntry."Routing Link Code" := ItemJournalLine."Routing Link Code"; //TRI-VKG ADD

        if (NewItemLedgEntry."Entry Type" = NewItemLedgEntry."Entry Type"::Consumption) or (NewItemLedgEntry."Entry Type" = NewItemLedgEntry."Entry Type"::Output) then begin
            ProductionOrderL.Reset();
            ProductionOrderL.SetRange("No.", NewItemLedgEntry."Order No.");
            if ProductionOrderL.FindFirst() then begin
                IF ProductionOrderL."Original Prod. No" <> '' then
                    NewItemLedgEntry."Posting Date" := ProductionOrderL."Due Date";
            end;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntry', '', false, false)]// TEAM 15578
    local procedure OnBeforeInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; TransferItem: Boolean; OldItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLineOrigin: Record "Item Journal Line");
    var

        Item: Record 27;
        Text012: Label 'Item %1 must be reserved on Line No.%2';
        tgText001: Label 'Quanity in Cartoon %1 should not be in fraction.';

        ItemNo1: Code[20];
        TypeCode: Code[2];
        SizeCode: Code[3];
        PlantCode: Code[1];
        PackingCode: Code[2];
        DesignCode: Code[4];
        ColorCode: Code[4];
        QualityCode: Code[1];
        LocationRec: Record Location;
    begin


        IF ItemJournalLine."Inter Company" = TRUE THEN BEGIN
            Item.Reserve := Item.Reserve::Never
        END ELSE BEGIN
            IF (ItemJournalLine."Document Type" <> ItemJournalLine."Document Type"::"Purchase Return Shipment") AND (ItemJournalLine."Job No." = '') THEN BEGIN
                IF (Item.Reserve = Item.Reserve::Always) AND
                   (ItemLedgerEntry.Quantity < 0)
                THEN
                    ERROR(Text012, ItemLedgerEntry."Item No.", ItemJournalLine."Line No.");
            END;
        END;

        //MS-PB END
        ItemLedgerEntry."Machine Code" := ItemJournalLine."Machine Code";    //MSSS
        IF ItemLedgerEntry."Remaining Quantity" < 0 THEN BEGIN
            MESSAGE('%1', ItemLedgerEntry."Entry No.");
            // ERROR(Text0001,"Line No.");
        END
        ELSE BEGIN
            //mo tri1.0 Customization no.40 end

            //mo tri1.0 Customization no.s-16 start
            ItemNo1 := ItemLedgerEntry."Item No.";
            Item.RESET;
            Item.SETRANGE(Item."No.", ItemLedgerEntry."Item No.");
            if Item.FindFirst() then begin
                TypeCode := Item."Type Code";
                SizeCode := Item."Size Code";
                PlantCode := Item."Plant Code";
                DesignCode := Item."Design Code";
                QualityCode := Item."Quality Code";
                ColorCode := Item."Color Code";
                PackingCode := Item."Packing Code";
                ItemLedgerEntry."Type Code" := TypeCode;
                ItemLedgerEntry."Size Code" := SizeCode;
                ItemLedgerEntry."Plant Code" := PlantCode;
                ItemLedgerEntry."Design Code" := DesignCode;
                ItemLedgerEntry."Packing Code" := PackingCode;
                ItemLedgerEntry."Category Code" := Item."Type Catogery Code"; //ND
                ItemLedgerEntry."Color Code" := ColorCode;//rahul 160805
                ItemLedgerEntry."Quality Code" := QualityCode;//rahul 160805
                                                              //TRI LM 100308 start
                ItemLedgerEntry."Group Code" := ItemJournalLine."Group Code";
            end;
            //TRI LM 100308 End
        END;

        //ND tri1.0 Start
        IF LocationRec.GET(ItemLedgerEntry."Location Code") THEN BEGIN
            ItemLedgerEntry."Main Location" := LocationRec."Main Location";
            ItemLedgerEntry.InTransit := LocationRec."Use As In-Transit";
        END;

        ItemLedgerEntry."Qty in Sq.Mt." := Item.UomToSqm(ItemLedgerEntry."Item No.", Item."Base Unit of Measure",
                                         ItemLedgerEntry.Quantity);

        ItemLedgerEntry."Qty In Carton" := Item.UomToCart(ItemLedgerEntry."Item No.", Item."Base Unit of Measure",
                                         ItemLedgerEntry.Quantity);

        ItemLedgerEntry."Qty in PCS." := Item.UomToPcs(ItemLedgerEntry."Item No.", Item."Base Unit of Measure",
                                         ItemLedgerEntry.Quantity);
        //ND tri1.0 End

        //mo tri1.0 Start
        IF LocationRec.GET(ItemLedgerEntry."Location Code") THEN BEGIN
            IF LocationRec."Main Location" <> '' THEN
                ItemLedgerEntry."Relational Location Code" := LocationRec."Main Location"
            ELSE
                ItemLedgerEntry."Relational Location Code" := LocationRec.Code;
        END;
        //mo tri1.0 End

        //TRI V.D 23.08.10 START
        IF ItemLedgerEntry."Entry Type" <> ItemLedgerEntry."Entry Type"::Transfer THEN BEGIN
            IF ItemLedgerEntry."Unit of Measure Code" = 'CRT' THEN BEGIN
                IF STRPOS(FORMAT(ItemLedgerEntry."Qty In Carton"), '.') <> 0 THEN
                    ERROR(tgText001, ItemLedgerEntry."Qty In Carton");
            END;
        END;
        ItemLedgerEntry."Capex No." := ItemJournalLine."Capex No.";//Ori Ut
                                                                   //MSKS0308 Start
        IF ItemJournalLine."Production Plant Code" <> '' THEN
            ItemLedgerEntry."Production Plant Code" := ItemJournalLine."Production Plant Code";
        ItemLedgerEntry."Morbi Batch No." := ItemJournalLine."Morbi Batch No.";
        //MSKS0308 End
        //TRI V.D 23.08.10 STOP
        //MS-PB BEGIN
        ItemLedgerEntry."Inter Company" := ItemJournalLine."Inter Company";
        ItemLedgerEntry."IC Line No." := ItemJournalLine."IC Line No.";

        //MS-PB END
        ItemLedgerEntry."Physical Journal Entry" := ItemJournalLine."Physical Journal Entry";
        ItemLedgerEntry."Physical Journal Key" := ItemJournalLine."Physical Journal Key";
        ItemLedgerEntry."Posting Datetime" := CURRENTDATETIME;

        //END;

        //TRI S.R
        /*
        IF ItemJournalLine."Entry Type" <> ItemJournalLine."Entry Type"::Transfer THEN
            TGupdatePlantCode(RecInbound, RecOutBound, RecItemLedger, RecTransferentry)
        ELSE BEGIN
            TGupdatePlantCode(RecInbound, RecOutBound, RecItemLedger, RecTransferentry);
            IF CheckiTemLed.GET(RecItemLedger) THEN BEGIN
                IF AfterCheckItemLed.GET(RecItemLedger - 1) THEN BEGIN
                    AfterCheckItemLed."Production Plant Code" := CheckiTemLed."Production Plant Code";
                    AfterCheckItemLed.MODIFY;
                END;
            END;
        END;
        //TRI S.R
        */

    end;



    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterInitCorrItemLedgEntry', '', false, false)]
    local procedure OnAfterInitCorrItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; EntriesExist: Boolean)
    var
        item: Record 27;
    begin
        //TRI DG 110810 Add Start
        Item.GET(NewItemLedgEntry."Item No.");
        NewItemLedgEntry."Qty in Sq.Mt." := Item.UomToSqm(NewItemLedgEntry."Item No.", Item."Base Unit of Measure",
                                                  NewItemLedgEntry.Quantity);

        NewItemLedgEntry."Qty In Carton" := Item.UomToCart(NewItemLedgEntry."Item No.", Item."Base Unit of Measure",
                                                  NewItemLedgEntry.Quantity);

        NewItemLedgEntry."Qty in PCS." := Item.UomToPcs(NewItemLedgEntry."Item No.", Item."Base Unit of Measure",
                                                  NewItemLedgEntry.Quantity);
        //TRI DG 110810 Add Stop
    end;

    procedure CreateRealeseProdOrder(ReleaseQty: Decimal; ItemNo: Code[20]; OrgProdNo: Code[20]; Loccode: Code[20]; VAR VariantCode: Code[20]; PostingDate: Date; ItemJnlLine2: Record "Item Journal Line")

    VAR
        ProductionOrder: Record 5405;
        NoSeriesMgt: Codeunit 396;
        MfgSetup: Record 99000765;
        ProductionOrderSta: Record 5405;
        ProdOrderStatusManagement: Codeunit 5407;
        ProdNo: Code[20];
        ChangeStatusForm: Page 99000882;
        ProdOrderComp2: Record 5407;
        Prodline: Record 5406;
        ProductionOrderNew: Record 5405;
        CreateProdOrderLines: Codeunit 99000787;
        ProdOrderRoutingLine: Record 5409;
        ProductionOrder2: Record 5405;
        Item: Record 27;
        ItemUnitofMeasure: Record 5404;
        UOMMgt: Codeunit 5402;
        UomAmt: Decimal;
    BEGIN
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
            IF (ProductionOrder."Re Process Production Order") AND (COMPANYNAME = 'Associate Vendors-Morbi') THEN
                Prodline."Morbi Batch No." := 'STD'
            ELSE
                Prodline."Morbi Batch No." := ItemJnlLine2."Morbi Batch No.";
            Prodline.MODIFY;

            ProdOrderComp2.INIT;
            ProdOrderComp2.Status := Prodline.Status;
            ProdOrderComp2."Prod. Order No." := Prodline."Prod. Order No.";
            ProdOrderComp2."Prod. Order Line No." := Prodline."Line No.";
            ProdOrderComp2."Line No." := 10000;
            ProdOrderComp2.VALIDATE("Item No.", ItemJnlLine2."Item No.");

            /*                   IF ProductionOrder."Prod. Reporting No." <> '' THEN BEGIN
             Item.GET(ItemJnlLine."Item No.");
             UomAmt := UOMMgt.GetQtyPerUnitOfMeasure(Item, ItemJnlLine."Unit of Measure Code");
             ProdOrderComp2.VALIDATE("Quantity per", UomAmt);
             ProdOrderComp2."Expected Qty. (Base)" := ReleaseQty;
             ProdOrderComp2."Expected Quantity" := ReleaseQty;
             ProdOrderComp2."Qty. per Unit of Measure" := 1;
         END ELSE
*/
            ProdOrderComp2.VALIDATE("Quantity per", 1);
            //ProdOrderComp2.VALIDATE(Quantity,ReleaseQty);
            ProdOrderComp2.VALIDATE("Unit of Measure Code", Prodline."Unit of Measure Code"); //MSKS
            ProdOrderComp2."Location Code" := ItemJnlLine2."Location Code";
            ProdOrderComp2."Shortcut Dimension 1 Code" := ItemJnlLine2."Shortcut Dimension 1 Code";
            ProdOrderComp2."Shortcut Dimension 2 Code" := ItemJnlLine2."Shortcut Dimension 2 Code";
            ProdOrderComp2."Original Component" := TRUE;
            ProdOrderComp2."Flushing Method" := ProdOrderComp2."Flushing Method"::Backward;
            ProdOrderComp2."Variant Code" := ItemJnlLine2."Variant Code";
            IF (ProductionOrder."Re Process Production Order") AND (COMPANYNAME = 'Associate Vendors-Morbi') THEN
                ProdOrderComp2."Morbi Batch No." := 'STD'
            ELSE
                ProdOrderComp2."Morbi Batch No." := ItemJnlLine2."Morbi Batch No.";
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
            IF ProductionOrderSta.FIND('-') THEN
                ProdOrderStatusManagement.ChangeProdOrderStatus(ProductionOrderSta, ProductionOrderSta.Status::Finished, PostingDate, TRUE);
        END;
    END;




}
