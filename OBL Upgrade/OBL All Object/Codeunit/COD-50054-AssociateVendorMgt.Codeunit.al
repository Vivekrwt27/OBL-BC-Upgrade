codeunit 50054 "Associate Vendor Mgt"
{
    Permissions = TableData "Item Ledger Entry" = rim,
                  TableData "Value Entry" = rim;

    trigger OnRun()
    begin
        CopyAllItem;
        //PostItemJournal;
        CopyDimensions;
    end;

    var
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        InsertReservEntry: Record "Reservation Entry";
        LastEntryNo: Integer;


    procedure CopyItem(RecItem: Record Item; ToCompany: Text)
    var
        ToItemCompany: Record Item;
        FromItemUOM: Record "Item Unit of Measure";
        ToItemUOM: Record "Item Unit of Measure";
        TodefDim: Record "Default Dimension";
        FromdefDim: Record "Default Dimension";
    begin
        ToItemCompany.CHANGECOMPANY(ToCompany);
        ToItemUOM.CHANGECOMPANY(ToCompany);
        TodefDim.CHANGECOMPANY(ToCompany);
        IF NOT ToItemCompany.GET(RecItem."No.") THEN BEGIN
            ToItemCompany.TRANSFERFIELDS(RecItem);
            ToItemCompany."No." := RecItem."No.";
            //    ToItemCompany."Product Group Code" := '';
            ToItemCompany."Item Category Code" := '';
            ToItemCompany.Reserve := ToItemCompany.Reserve::Never;
            //ToItemCompany."Inventory Value Zero" := TRUE;
            ToItemCompany."Gen. Prod. Posting Group" := 'TRADING';
            ToItemCompany."Inventory Posting Group" := 'TRAD';
            ToItemCompany.INSERT;
            FromItemUOM.RESET;
            FromItemUOM.SETRANGE("Item No.", RecItem."No.");
            IF FromItemUOM.FINDFIRST THEN BEGIN
                REPEAT
                    ToItemUOM.RESET;
                    IF NOT ToItemUOM.GET(ToItemCompany."No.", FromItemUOM.Code) THEN BEGIN
                        ToItemUOM.TRANSFERFIELDS(FromItemUOM);
                        ToItemUOM."Item No." := ToItemCompany."No.";
                        ToItemUOM.INSERT;
                    END;
                UNTIL FromItemUOM.NEXT = 0;
            END;
        END;
        TodefDim.RESET;
        TodefDim.SETRANGE("Table ID", 27);
        TodefDim.SETRANGE("No.", ToItemCompany."No.");
        IF NOT TodefDim.FINDFIRST THEN BEGIN
            FromdefDim.RESET;
            FromdefDim.SETRANGE("Table ID", 27);
            FromdefDim.SETRANGE(FromdefDim."No.", RecItem."No.");
            IF FromdefDim.FINDFIRST THEN BEGIN
                REPEAT
                    TodefDim.INIT;
                    TodefDim.TRANSFERFIELDS(FromdefDim);
                    IF FromdefDim."Dimension Value Code" = RecItem."No." THEN
                        TodefDim."Dimension Value Code" := ToItemCompany."No.";
                    TodefDim."No." := ToItemCompany."No.";
                    TodefDim."Value Posting" := TodefDim."Value Posting"::" ";
                    TodefDim.INSERT;
                UNTIL FromdefDim.NEXT = 0;
            END;
        END;
    end;


    procedure CopyAllItem()
    var
        FromItem: Record Item;
    begin
        IF COMPANYNAME = 'Associate Vendors-Morbi' THEN
            EXIT;
        FromItem.RESET;
        FromItem.SETCURRENTKEY("Item Category Code");
        FromItem.SETFILTER("Item Category Code", '%1', 'T001');
        //FromItem.SETFILTER("Color Code",'%1','0001');
        IF FromItem.FINDFIRST THEN BEGIN
            REPEAT
                CopyItem(FromItem, 'Associate Vendors-Morbi');
            UNTIL FromItem.NEXT = 0;
        END;
    end;


    procedure GenerateInventoryVoucher(PurchRcptLine: Record "Purch. Rcpt. Line")
    var
        Location: Record Location;
        ToItem: Record Item;
        FromItem: Record Item;
        ToItemJournalLine: Record "Item Journal Line";
        MorbiLocation: Code[20];
        Vendor: Record Vendor;
        ItemJnlPostLineChangeCo: Codeunit "Item Jnl.-Post Line-Change Co.";
    begin
        IF PurchRcptLine.Quantity = 0 THEN
            EXIT;
        IF COMPANYNAME = 'Associate Vendors-Morbi' THEN
            EXIT;
        IF PurchRcptLine.Type <> PurchRcptLine.Type::Item THEN
            EXIT;
        IF PurchRcptLine."Item Category Code" <> 'T001' THEN
            EXIT;
        Vendor.GET(PurchRcptLine."Buy-from Vendor No.");

        Location.CHANGECOMPANY('Associate Vendors-Morbi');
        IF Location.GET(Vendor."Morbi Location Code") THEN BEGIN
            ToItem.CHANGECOMPANY('Associate Vendors-Morbi');
            IF NOT ToItem.GET(PurchRcptLine."No.") THEN BEGIN
                IF FromItem.GET(PurchRcptLine."No.") THEN
                    CopyItem(FromItem, 'Associate Vendors-Morbi');
            END;
        END;

        ToItemJournalLine.CHANGECOMPANY('Associate Vendors-Morbi');
        ToItemJournalLine.INIT;
        ToItemJournalLine."Journal Template Name" := 'ITEM';
        ToItemJournalLine."Journal Batch Name" := 'SALES';
        ToItemJournalLine."Document No." := PurchRcptLine."Document No.";
        ToItemJournalLine."Line No." := GetNextLineNo;
        ToItemJournalLine."Entry Type" := ToItemJournalLine."Entry Type"::Sale;
        ToItemJournalLine."Posting Date" := PurchRcptLine."Posting Date";
        ToItemJournalLine."Item No." := PurchRcptLine."No.";
        ToItemJournalLine.Description := PurchRcptLine.Description;
        ToItemJournalLine."Location Code" := Location.Code;
        ToItemJournalLine.Quantity := PurchRcptLine.Quantity;
        ToItemJournalLine."Gen. Prod. Posting Group" := 'TRADING';
        ToItemJournalLine."Shortcut Dimension 1 Code" := Location.Code;
        ToItemJournalLine."Quantity (Base)" := PurchRcptLine."Quantity (Base)";
        ToItemJournalLine."Unit of Measure Code" := PurchRcptLine."Unit of Measure Code";
        ToItemJournalLine."Document Date" := PurchRcptLine."Posting Date";
        ToItemJournalLine."Unit Cost" := 0;
        ToItemJournalLine."Document Line No." := PurchRcptLine."Line No.";
        ToItemJournalLine."Inter Company" := TRUE;
        IF ToItemJournalLine.Quantity <> 0 THEN
            ToItemJournalLine.INSERT;
        CLEAR(ItemJnlPostLineChangeCo);
        IF ToItemJournalLine.INSERT THEN BEGIN
            ItemJnlPostLineChangeCo.SetCompany('Associate Vendors-Morbi');
            ItemJnlPostLineChangeCo.RUN(ToItemJournalLine);
        END;
    end;


    procedure GetNextLineNo(): Integer
    var
        ItemJournalLine: Record "Item Journal Line";
    begin
        ItemJournalLine.CHANGECOMPANY('Associate Vendors-Morbi');
        ItemJournalLine.SETFILTER("Journal Template Name", 'ITEM');
        ItemJournalLine.SETFILTER("Journal Batch Name", 'SALES');
        IF ItemJournalLine.FINDLAST THEN
            EXIT(ItemJournalLine."Line No." + 10000)
        ELSE
            EXIT(10000);
    end;


    procedure PostItemJournal()
    var
        ItemJournalLine: Record "Item Journal Line";
    begin
        IF COMPANYNAME <> 'Associate Vendors-Morbi' THEN
            EXIT;
        ItemJournalLine.RESET;
        ItemJournalLine.SETFILTER("Journal Template Name", '%1', 'ITEM');
        ItemJournalLine.SETFILTER("Journal Batch Name", '%1', 'SALES');
        ItemJournalLine.SETFILTER(Quantity, '<>%1', 0);
        IF ItemJournalLine.FINDFIRST THEN
            REPEAT
                CLEAR(ItemJnlPostLine);
                IF ItemJnlPostLine.RUN(ItemJournalLine) THEN
                    ItemJournalLine.DELETE;
            UNTIL ItemJournalLine.NEXT = 0;
    end;


    procedure GenerateItemLedgerEntries(PurchRcptLine: Record "Purch. Rcpt. Line")
    var
        Location: Record Location;
        ToItem: Record Item;
        FromItem: Record Item;
        ItemLedgerEntry: Record "Item Ledger Entry";
        MorbiLocation: Code[20];
        Vendor: Record Vendor;
        ItemJnlPostLineChangeCo: Codeunit "Item Jnl.-Post Line-Change Co.";
        Item: Record Item;
    begin
        IF PurchRcptLine.Quantity = 0 THEN
            EXIT;
        IF COMPANYNAME = 'Associate Vendors-Morbi' THEN
            EXIT;
        IF PurchRcptLine.Type <> PurchRcptLine.Type::Item THEN
            EXIT;
        IF PurchRcptLine."Item Category Code" <> 'T001' THEN
            EXIT;
        Vendor.GET(PurchRcptLine."Buy-from Vendor No.");

        IF Vendor."Morbi Location Code" = '' THEN EXIT;

        Location.CHANGECOMPANY('Associate Vendors-Morbi');
        IF Location.GET(Vendor."Morbi Location Code") THEN BEGIN
            ToItem.CHANGECOMPANY('Associate Vendors-Morbi');
            IF NOT ToItem.GET(PurchRcptLine."No.") THEN BEGIN
                IF FromItem.GET(PurchRcptLine."No.") THEN
                    CopyItem(FromItem, 'Associate Vendors-Morbi');
            END;
        END;

        ItemLedgerEntry.CHANGECOMPANY('Associate Vendors-Morbi');
        ItemLedgerEntry.INIT;
        ItemLedgerEntry."Document No." := PurchRcptLine."Document No.";
        //ItemLedgerEntry."External Document No." := PurchRcptLine.Ext
        ItemLedgerEntry."Entry No." := GetLastEntryNo;
        ItemLedgerEntry."Entry Type" := ItemLedgerEntry."Entry Type"::Sale;
        ItemLedgerEntry."Posting Date" := PurchRcptLine."Posting Date";
        ItemLedgerEntry."Item No." := PurchRcptLine."No.";
        ItemLedgerEntry.Description := PurchRcptLine.Description;
        ItemLedgerEntry."Location Code" := Location.Code;
        ItemLedgerEntry.Quantity := -1 * PurchRcptLine.Quantity;
        ItemLedgerEntry."General Prod. Posting Group" := 'TRADING';
        ItemLedgerEntry.Quantity := -1 * PurchRcptLine."Quantity (Base)";
        ItemLedgerEntry."Unit of Measure Code" := PurchRcptLine."Unit of Measure Code";
        ItemLedgerEntry."Document Date" := PurchRcptLine."Posting Date";
        ItemLedgerEntry."Document Line No." := PurchRcptLine."Line No.";
        ItemLedgerEntry."Inventory Posting Group" := PurchRcptLine."Posting Group";
        ItemLedgerEntry.Correction := PurchRcptLine.Correction;
        ItemLedgerEntry."Morbi Batch No." := PurchRcptLine."Batch No."; //MSKS
        ItemLedgerEntry."Remaining Quantity" := ItemLedgerEntry.Quantity;
        ItemLedgerEntry.Open := TRUE;
        ItemLedgerEntry.Positive := (ItemLedgerEntry.Quantity > 0);
        ItemLedgerEntry."Inter Company" := TRUE;
        Item.RESET;
        IF Item.GET(ItemLedgerEntry."Item No.") THEN;
        ItemLedgerEntry."Type Code" := Item."Type Code";
        ItemLedgerEntry."Size Code" := Item."Size Code";
        ItemLedgerEntry."Plant Code" := Item."Plant Code";
        ItemLedgerEntry."Design Code" := Item."Design Code";
        ItemLedgerEntry."Packing Code" := Item."Packing Code";
        ItemLedgerEntry."Category Code" := Item."Type Catogery Code";
        ItemLedgerEntry."Color Code" := Item."Color Code";
        ItemLedgerEntry."Quality Code" := Item."Quality Code";
        ItemLedgerEntry."Group Code" := Item."Group Code";
        ItemLedgerEntry."Qty in Sq.Mt." := Item.UomToSqm(ItemLedgerEntry."Item No.", Item."Base Unit of Measure",
                                        ItemLedgerEntry.Quantity);

        ItemLedgerEntry."Qty In Carton" := Item.UomToCart(ItemLedgerEntry."Item No.", Item."Base Unit of Measure",
                                        ItemLedgerEntry.Quantity);

        ItemLedgerEntry."Qty in PCS." := Item.UomToPcs(ItemLedgerEntry."Item No.", Item."Base Unit of Measure",
                                        ItemLedgerEntry.Quantity);

        IF ItemLedgerEntry.Quantity <> 0 THEN BEGIN
            ItemLedgerEntry.INSERT;
            GenerateValueEntries(ItemLedgerEntry, PurchRcptLine);
        END;
    end;

    local procedure GetLastEntryNo(): Integer
    var
        ILE: Record "Item Ledger Entry";
    begin
        ILE.CHANGECOMPANY('Associate Vendors-Morbi');
        IF ILE.FINDLAST THEN
            EXIT(ILE."Entry No." + 1) ELSE
            EXIT(1);
    end;

    local procedure GenerateValueEntries(var ItemLedgerEntry: Record "Item Ledger Entry"; var PurchRcptLine: Record "Purch. Rcpt. Line")
    var
        ValueEntry: Record "Value Entry";
    begin
        ValueEntry.CHANGECOMPANY('Associate Vendors-Morbi');
        ValueEntry."Entry No." := GetLastValueEntryNo;
        ValueEntry."Document No." := ItemLedgerEntry."Document No.";
        ValueEntry."Document Line No." := ItemLedgerEntry."Document Line No.";
        ValueEntry."Document Date" := ItemLedgerEntry."Document Date";
        ValueEntry."Valuation Date" := ItemLedgerEntry."Posting Date";
        ValueEntry."Entry Type" := ValueEntry."Entry Type"::"Direct Cost";
        ValueEntry."Item Ledger Entry Type" := ItemLedgerEntry."Entry Type";
        ValueEntry."Posting Date" := ItemLedgerEntry."Posting Date";
        ValueEntry."Item No." := ItemLedgerEntry."Item No.";
        ValueEntry."Valued Quantity" := ItemLedgerEntry.Quantity;
        ValueEntry."Item Ledger Entry No." := ItemLedgerEntry."Entry No.";
        ValueEntry."Item Ledger Entry Quantity" := ItemLedgerEntry.Quantity;
        ValueEntry."Location Code" := ItemLedgerEntry."Location Code";
        ValueEntry."Gen. Prod. Posting Group" := ItemLedgerEntry."General Prod. Posting Group";
        ValueEntry."Gen. Bus. Posting Group" := PurchRcptLine."Gen. Bus. Posting Group";
        ValueEntry."Inventory Posting Group" := ItemLedgerEntry."Inventory Posting Group";
        ValueEntry."User ID" := USERID;
        ValueEntry."Item Base Unit of Measure" := PurchRcptLine."Unit of Measure Code";
        ValueEntry.INSERT;

    end;

    local procedure GetLastValueEntryNo(): Integer
    var
        ValueEntry: Record "Value Entry";
    begin
        ValueEntry.CHANGECOMPANY('Associate Vendors-Morbi');
        IF ValueEntry.FINDLAST THEN
            EXIT(ValueEntry."Entry No." + 1) ELSE
            EXIT(1);
    end;


    procedure CalculateInventoryBalance(ItemNo: Code[20]; LocationCode: Code[20]; BatchNo: Code[20]; AsonDate: Date; InclReserveQty: Boolean) Qty: Decimal
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ReservationEntry: Record "Reservation Entry";
    begin
        ItemLedgerEntry.CHANGECOMPANY('Associate Vendors-Morbi');
        ItemLedgerEntry.SETCURRENTKEY("Item No.", Positive, "Variant Code", Open, "Location Code", "Posting Date");
        ItemLedgerEntry.SETRANGE("Item No.", ItemNo);
        IF LocationCode <> '' THEN
            ItemLedgerEntry.SETRANGE("Location Code", LocationCode);
        IF BatchNo <> '' THEN
            ItemLedgerEntry.SETRANGE("Morbi Batch No.", BatchNo);
        ItemLedgerEntry.SETFILTER("Posting Date", '%1..%2', 0D, AsonDate);
        IF ItemLedgerEntry.FINDFIRST THEN BEGIN
            REPEAT
                Qty += ItemLedgerEntry.Quantity;
            UNTIL ItemLedgerEntry.NEXT = 0;
        END;
        IF InclReserveQty THEN BEGIN
            ReservationEntry.RESET;
            ReservationEntry.CHANGECOMPANY('Associate Vendors-Morbi');
            ReservationEntry.SETRANGE("Item No.", ItemNo);
            IF LocationCode <> '' THEN
                ReservationEntry.SETFILTER("Location Code", '%1', LocationCode);
            IF BatchNo <> '' THEN
                ReservationEntry.SETRANGE("Lot No.", BatchNo);
            IF ReservationEntry.FINDFIRST THEN
                REPEAT
                    Qty -= ReservationEntry."Quantity (Base)";
                UNTIL ReservationEntry.NEXT = 0;
        END;
        EXIT(Qty);
    end;


    procedure CopyDimensions()
    var
        FromDimension: Record Dimension;
        FromDimensionValue: Record "Dimension Value";
        ToDimension: Record Dimension;
        ToDimensionValue: Record "Dimension Value";
    begin
        IF COMPANYNAME = 'Associate Vendors-Morbi' THEN
            EXIT;
        FromDimension.RESET;
        FromDimension.CHANGECOMPANY('Orient Bell Limited');
        IF FromDimension.FINDFIRST THEN
            REPEAT
                ToDimension.CHANGECOMPANY('Associate Vendors-Morbi');
                IF NOT ToDimension.GET(FromDimension.Code) THEN BEGIN
                    ToDimension.TRANSFERFIELDS(FromDimension);
                    ToDimension.INSERT;
                END;
            UNTIL FromDimension.NEXT = 0;

        FromDimensionValue.RESET;
        FromDimensionValue.CHANGECOMPANY('Orient Bell Limited');
        IF FromDimensionValue.FINDFIRST THEN
            REPEAT
                ToDimensionValue.CHANGECOMPANY('Associate Vendors-Morbi');
                IF NOT ToDimensionValue.GET(FromDimensionValue."Dimension Code", FromDimensionValue.Code) THEN BEGIN
                    ToDimensionValue.TRANSFERFIELDS(FromDimensionValue);
                    ToDimensionValue.INSERT;
                END;
            UNTIL FromDimensionValue.NEXT = 0;
    end;


    procedure CheckInventoryBatch(ItemNo: Code[20]; LocationCode: Code[20]; BatchNo: Code[20]; AsonDate: Date) Qty: Decimal
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        ItemLedgerEntry.CHANGECOMPANY('Associate Vendors-Morbi');
        ItemLedgerEntry.SETCURRENTKEY("Item No.", Positive, "Variant Code", Open, "Location Code", "Posting Date");
        ItemLedgerEntry.SETRANGE("Item No.", ItemNo);
        ItemLedgerEntry.SETRANGE("Location Code", LocationCode);
        ItemLedgerEntry.SETRANGE("Morbi Batch No.", BatchNo);
        //ItemLedgerEntry.SETFILTER("Posting Date",'%1..%2',0D,AsonDate);
        IF NOT ItemLedgerEntry.FINDFIRST THEN BEGIN
            ERROR('Batch No. %1 not Exists for Item No. %2', BatchNo, ItemNo);
        END;
    end;


    procedure ReserveInventoryVoucher(SalesLine: Record "Sales Line")
    var
        Location: Record Location;
        ToItem: Record Item;
        FromItem: Record Item;
        ToItemJournalLine: Record "Item Journal Line";
        MorbiLocation: Code[20];
        Vendor: Record Vendor;
        ItemJnlPostLineChangeCo: Codeunit "Item Jnl.-Post Line-Change Co.";
    begin
        IF SalesLine."Location Code" <> 'DP-MORBI' THEN EXIT;
        IF SalesLine.Quantity = 0 THEN
            EXIT;
        IF COMPANYNAME = 'Associate Vendors-Morbi' THEN
            EXIT;
        IF SalesLine.Type <> SalesLine.Type::Item THEN
            EXIT;
        IF SalesLine."Item Category Code" <> 'T001' THEN
            EXIT;
        IF SalesLine."Vendor Code" = '' THEN EXIT;
        //Vendor.GET(SalesLine."Vendor Code");

        Location.CHANGECOMPANY('Associate Vendors-Morbi');
        IF Location.GET(SalesLine."Vendor Code") THEN BEGIN
            ToItem.CHANGECOMPANY('Associate Vendors-Morbi');
            IF NOT ToItem.GET(SalesLine."No.") THEN BEGIN
                IF FromItem.GET(SalesLine."No.") THEN
                    CopyItem(FromItem, 'Associate Vendors-Morbi');
            END;
        END;

        ToItemJournalLine.CHANGECOMPANY('Associate Vendors-Morbi');
        ToItemJournalLine.INIT;
        ToItemJournalLine."Journal Template Name" := 'DEFAULT';
        ToItemJournalLine."Journal Batch Name" := 'RESERVE';
        ToItemJournalLine."Document No." := SalesLine."Document No.";
        ToItemJournalLine."Line No." := ReserveGetNextLineNo;
        ToItemJournalLine."Entry Type" := ToItemJournalLine."Entry Type"::Sale;

        ToItemJournalLine."Posting Date" := TODAY;
        ToItemJournalLine."Item No." := SalesLine."No.";
        ToItemJournalLine.Description := SalesLine.Description;
        ToItemJournalLine."Description 2" := SalesLine."Description 2";
        ToItemJournalLine."Location Code" := Location.Code;
        ToItemJournalLine.Quantity := SalesLine.Quantity;
        ToItemJournalLine."Gen. Prod. Posting Group" := 'TRADING';
        ToItemJournalLine."Shortcut Dimension 1 Code" := Location.Code;
        ToItemJournalLine."Quantity (Base)" := SalesLine."Quantity (Base)";
        ToItemJournalLine."Unit of Measure Code" := SalesLine."Unit of Measure Code";
        ToItemJournalLine."Document Date" := SalesLine."Posting Date";
        ToItemJournalLine."Unit Cost" := 0;
        ToItemJournalLine."Document Line No." := SalesLine."Line No.";
        ToItemJournalLine."Inter Company" := TRUE;
        IF ToItemJournalLine.Quantity <> 0 THEN
            ToItemJournalLine.INSERT;
        //Reserve Inventory

        CreateReservEntryFor(
            DATABASE::"Item Journal Line",
            ToItemJournalLine."Entry Type".AsInteger(),
            ToItemJournalLine."Journal Template Name",
            ToItemJournalLine."Journal Batch Name",
            0,
            ToItemJournalLine."Line No.",
            ToItemJournalLine."Qty. per Unit of Measure",
            -1 * (ToItemJournalLine.Quantity),
            -1 * (ToItemJournalLine."Quantity (Base)"),
            ToItemJournalLine."Serial No.",
            ToItemJournalLine."Lot No.", ToItemJournalLine);
    end;


    procedure CreateReservEntryFor(ForType: Option; ForSubtype: Integer; ForID: Code[20]; ForBatchName: Code[10]; ForProdOrderLine: Integer; ForRefNo: Integer; ForQtyPerUOM: Decimal; Quantity: Decimal; QuantityBase: Decimal; ForSerialNo: Code[20]; ForLotNo: Code[20]; var ItemJournalLine: Record "Item Journal Line")
    var
        sign: Integer;
    begin
        InsertReservEntry.CHANGECOMPANY('Associate Vendors-Morbi');
        InsertReservEntry.INIT;
        InsertReservEntry."Entry No." := GetNextEntryNo(QuantityBase > 0);
        InsertReservEntry."Source Type" := ForType;
        InsertReservEntry."Source Subtype" := ForSubtype;
        InsertReservEntry."Item No." := ItemJournalLine."Item No.";
        InsertReservEntry."Location Code" := ItemJournalLine."Location Code";
        InsertReservEntry."Source ID" := ForID;
        InsertReservEntry."Source Batch Name" := ForBatchName;
        InsertReservEntry."Source Prod. Order Line" := ForProdOrderLine;
        InsertReservEntry."Source Ref. No." := ForRefNo;
        sign := SignFactor(InsertReservEntry);
        InsertReservEntry.Quantity := sign * Quantity;
        InsertReservEntry."Quantity (Base)" := sign * QuantityBase;
        InsertReservEntry."Qty. to Handle (Base)" := InsertReservEntry."Quantity (Base)";
        InsertReservEntry."Qty. to Invoice (Base)" := InsertReservEntry."Quantity (Base)";
        InsertReservEntry."Qty. per Unit of Measure" := ForQtyPerUOM;
        InsertReservEntry."Serial No." := ForSerialNo;
        InsertReservEntry."Lot No." := ForLotNo;

        InsertReservEntry."Item Ledger Entry No." := 0;
        InsertReservEntry."Appl.-from Item Entry" := 0;
        InsertReservEntry."Appl.-to Item Entry" := 0;
        InsertReservEntry.TESTFIELD("Qty. per Unit of Measure");
        InsertReservEntry."Reservation Status" := InsertReservEntry."Reservation Status"::Prospect;//OSKS
        IF ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Transfer THEN BEGIN
            InsertReservEntry."New Lot No." := InsertReservEntry."Lot No.";
        END;
        InsertReservEntry."Sales Order No." := ItemJournalLine."Document No.";
        InsertReservEntry."Sales Order Line No." := ItemJournalLine."Document Line No.";
        InsertReservEntry."Creation Date" := TODAY;
        InsertReservEntry."Created By" := USERID;
        InsertReservEntry.INSERT;
    end;


    procedure SignFactor(var ReservEntry: Record "Reservation Entry"): Integer
    var
        Inbound: Boolean;
    begin
        // Demand is regarded as negative, supply is regarded as positive.
        CASE ReservEntry."Source Type" OF
            DATABASE::"Sales Line":
                IF ReservEntry."Source Subtype" IN [3, 5] THEN // Credit memo, Return Order = supply
                    EXIT(1)
                ELSE
                    EXIT(-1);
            DATABASE::"Requisition Line":
                IF ReservEntry."Source Subtype" = 1 THEN
                    EXIT(-1)
                ELSE
                    EXIT(1);
            DATABASE::"Purchase Line":
                IF ReservEntry."Source Subtype" IN [3, 5] THEN // Credit memo, Return Order = demand
                    EXIT(-1)
                ELSE
                    EXIT(1);
            DATABASE::"Item Journal Line":
                IF ReservEntry."Source Subtype" IN [1, 3, 4, 5] THEN // Sale, Negative Adjmt., Transfer, Consumption
                    EXIT(-1)
                ELSE
                    EXIT(1);
            DATABASE::"Job Journal Line":
                EXIT(-1);
            DATABASE::"Item Ledger Entry":
                EXIT(1);
            DATABASE::"Prod. Order Line":
                EXIT(1);
            DATABASE::"Prod. Order Component":
                EXIT(-1);
            DATABASE::"Assembly Header":
                EXIT(1);
            DATABASE::"Assembly Line":
                EXIT(-1);
            DATABASE::"Sub Order Component List":
                EXIT(-1);
            DATABASE::"Applied Delivery Challan Entry":
                EXIT(-1);
            DATABASE::"Planning Component":
                EXIT(-1);
            DATABASE::"Transfer Line":
                IF ReservEntry."Source Subtype" = 0 THEN // Outbound
                    EXIT(-1)
                ELSE
                    EXIT(1);
            DATABASE::"Service Line":
                IF ReservEntry."Source Subtype" IN [3] THEN // Credit memo
                    EXIT(1)
                ELSE
                    EXIT(-1);
            DATABASE::"Job Planning Line":
                EXIT(-1);
        END;
    end;

    local procedure GetNextEntryNo(BlnPositive: Boolean): Integer
    var
        ReservationEntry1: Record "Reservation Entry";
    begin
        InsertReservEntry.RESET;
        InsertReservEntry.CHANGECOMPANY('Associate Vendors-Morbi');
        InsertReservEntry.SETRANGE(Positive, BlnPositive);
        IF InsertReservEntry.FINDLAST THEN
            EXIT(InsertReservEntry."Entry No." + 1)
        ELSE
            EXIT(1);
    end;


    procedure ReserveGetNextLineNo(): Integer
    var
        ItemJournalLine: Record "Item Journal Line";
    begin
        ItemJournalLine.CHANGECOMPANY('Associate Vendors-Morbi');
        ItemJournalLine.SETFILTER("Journal Template Name", 'DEFAULT');
        ItemJournalLine.SETFILTER("Journal Batch Name", 'RESERVE');
        IF ItemJournalLine.FINDLAST THEN
            EXIT(ItemJournalLine."Line No." + 10)
        ELSE
            EXIT(10);
    end;


    procedure DeleteReservation(SalesLine: Record "Sales Line")
    var
        ItemJournalLine: Record "Item Journal Line";
        ReservationEntry: Record "Reservation Entry";
    begin
        ItemJournalLine.RESET;
        ItemJournalLine.CHANGECOMPANY('Associate Vendors-Morbi');
        ItemJournalLine.SETFILTER("Journal Template Name", 'DEFAULT');
        ItemJournalLine.SETFILTER("Journal Batch Name", 'RESERVE');
        ItemJournalLine.SETFILTER("Document No.", '%1', SalesLine."Document No.");
        ItemJournalLine.SETFILTER("Document Line No.", '%1', SalesLine."Line No.");
        IF ItemJournalLine.FINDFIRST THEN
            ItemJournalLine.DELETE;

        ReservationEntry.RESET;
        ReservationEntry.CHANGECOMPANY('Associate Vendors-Morbi');
        //ReservationEntry.SETFILTER("Source ID",'DEFAULT');
        //ReservationEntry.SETFILTER("Source Batch Name",'RESERVE');
        ReservationEntry.SETFILTER("Sales Order No.", '%1', SalesLine."Document No.");
        ReservationEntry.SETFILTER("Sales Order Line No.", '%1', SalesLine."Line No.");
        IF ReservationEntry.FINDFIRST THEN
            ReservationEntry.DELETEALL;
    end;
}

