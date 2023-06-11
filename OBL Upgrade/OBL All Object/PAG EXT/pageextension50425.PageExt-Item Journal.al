pageextension 50425 pageextension50425 extends "Item Journal"
{

    layout
    {

        modify("Entry Type")
        {
            trigger OnAfterValidate()
            begin
                //TRI S.R
                IF (Rec."Entry Type" = Rec."Entry Type"::Sale) OR (Rec."Entry Type" = Rec."Entry Type"::"Negative Adjmt.") THEN
                    Rec."Production Plant Code" := ''
                ELSE BEGIN
                    IF COPYSTR(Rec."Item No.", 19, 1) = 'M' THEN BEGIN
                        IF RecItem.GET(Rec."Item No.") THEN BEGIN
                            Rec."Production Plant Code" := RecItem."Default Prod. Plant Code";
                        END;
                    END;
                END;
                //TRI S.R


            end;
        }

        modify("Item No.")
        {
            trigger OnAfterValidate()
            begin
                //Upgrade(+)
                //TRI S.R
                IF (Rec."Entry Type" = Rec."Entry Type"::Purchase) OR (Rec."Entry Type" = Rec."Entry Type"::"Positive Adjmt.") THEN BEGIN
                    IF COPYSTR(Rec."Item No.", 19, 1) = 'M' THEN BEGIN
                        IF RecItem.GET(Rec."Item No.") THEN BEGIN
                            Rec."Production Plant Code" := RecItem."Default Prod. Plant Code";
                        END;
                    END;
                END;
                //TRI S.R

                //Upgrade(-)

            end;
        }
        modify("Variant Code")
        {
            trigger OnAfterAfterLookup(Selected: RecordRef)
            begin
                ERROR('Please user "Mfg. Batch No." Instead of "Variant Code"');
            end;

            trigger OnAfterValidate()
            begin
                ERROR('Please user "Mfg. Batch No." Instead of "Variant Code"');
            end;
        }


        addafter("Applies-to Entry")
        {
            field("Qty. (Phys. Inventory)"; Rec."Qty. (Phys. Inventory)")
            {
                ApplicationArea = All;
            }

            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
            field("Source No."; Rec."Source No.")
            {
                ApplicationArea = All;
            }

            field("Source Type"; Rec."Source Type")
            {
                ApplicationArea = All;
            }

            field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
            {
                ApplicationArea = All;
            }
            field(AvlInventatPostingdatePlant; AvlInventatPostingdatePlant)
            {
                Caption = 'Inventory till Date at Plant ';
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    //TRI V.D 03.07.10 START
                    tgILE.RESET;
                    tgILE.SETCURRENTKEY(tgILE."Item No.", tgILE."Posting Date");
                    tgILE.SETRANGE(tgILE."Item No.", Rec."Item No.");
                    tgILE.SETRANGE(tgILE."Posting Date", 0D, TODAY);
                    IF Rec."Variant Code" <> '' THEN
                        tgILE.SETRANGE(tgILE."Variant Code", Rec."Variant Code");
                    IF Rec."Location Code" <> '' THEN
                        tgILE.SETFILTER(tgILE."Location Code", '%1|%2', 'PLANT', 'WAREHOUSE');
                    PAGE.RUN(0, tgILE);
                    //TRI V.D 03.07.10 STOP
                end;
            }
            field(Adjustment; Rec.Adjustment)
            {
                ApplicationArea = All;
            }
            field("Applies-to Value Entry"; Rec."Applies-to Value Entry")
            {
                ApplicationArea = All;
            }
            field(tgInventatPostingdate; tgInventatPostingdate)
            {
                Caption = 'Inventory at Posting Date';
                Editable = false;
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    //TRI V.D 03.07.10 START
                    tgILE.RESET;
                    tgILE.SETCURRENTKEY(tgILE."Item No.", tgILE."Posting Date");
                    tgILE.SETRANGE(tgILE."Item No.", Rec."Item No.");
                    tgILE.SETRANGE(tgILE."Posting Date", 0D, Rec."Posting Date");
                    IF Rec."Variant Code" <> '' THEN
                        tgILE.SETRANGE(tgILE."Variant Code", Rec."Variant Code");
                    IF Rec."Location Code" <> '' THEN
                        tgILE.SETRANGE(tgILE."Location Code", Rec."Location Code");
                    PAGE.RUN(0, tgILE);
                    //TRI V.D 03.07.10 STOP
                end;
            }
            field(tgAvlInventatPostingdate; tgAvlInventatPostingdate)
            {
                Caption = 'Inventory Till Date';
                Editable = false;
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    //TRI V.D 03.07.10 START
                    tgILE.RESET;
                    tgILE.SETCURRENTKEY(tgILE."Item No.", tgILE."Posting Date");
                    tgILE.SETRANGE(tgILE."Item No.", Rec."Item No.");
                    tgILE.SETRANGE(tgILE."Posting Date", 0D, TODAY);
                    IF Rec."Variant Code" <> '' THEN
                        tgILE.SETRANGE(tgILE."Variant Code", Rec."Variant Code");
                    IF Rec."Location Code" <> '' THEN
                        tgILE.SETRANGE(tgILE."Location Code", Rec."Location Code");
                    PAGE.RUN(0, tgILE);
                    //TRI V.D 03.07.10 STOP
                end;
            }
            field("Inventory Posting Group"; Rec."Inventory Posting Group")
            {
                ApplicationArea = All;
            }

            field("Item Category Code"; Rec."Item Category Code")
            {
                ApplicationArea = All;
            }

        }
        moveafter("Location Code"; "Shortcut Dimension 1 Code")


    }
    actions
    {

        modify(Post)
        {
            trigger OnAfterAction()
            begin
                CheckBatchInventory;
                //TRI S.R
                Rec.TESTFIELD("Shortcut Dimension 1 Code");
                RecItemJournal.RESET;
                RecItemJournal.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                RecItemJournal.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                IF RecItemJournal.FIND('-') THEN
                    REPEAT
                        IF (Rec."Entry Type" = Rec."Entry Type"::Purchase) OR (Rec."Entry Type" = Rec."Entry Type"::"Positive Adjmt.") THEN BEGIN
                            IF COPYSTR(Rec."Item No.", 19, 1) = 'M' THEN BEGIN
                                IF Rec."Production Plant Code" = '' THEN
                                    ERROR(Text003, RecItemJournal."Item No.", RecItemJournal."Line No.");
                            END;
                        END;
                    UNTIL RecItemJournal.NEXT = 0;
                //TRI S.R

            end;
        }
        modify("Post and &Print")
        {
            trigger OnAfterAction()
            begin
                CheckBatchInventory;
            end;
        }

        addafter("&Get Standard Journals")
        {
            action("Update Zero Inventory")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    InventorytoDelete: Query "Inventory to Delete";
                    Item: Record Item;
                    QtytoDelete: Decimal;
                begin
                    CLEAR(InventorytoDelete);
                    //InventorytoDelete.SETFILTER(InventorytoDelete.Item_No,'%1','010104505610231101M');

                    InventorytoDelete.OPEN;
                    WHILE InventorytoDelete.READ DO BEGIN

                        QtytoDelete := 0;
                        IF Item.GET(InventorytoDelete.Item_No) THEN
                            IF Item."Item Category Code" IN ['M001', 'D001', 'T001', 'H001'] THEN
                                QtytoDelete := 0.72
                            ELSE
                                QtytoDelete := 0.99;
                        IF (InventorytoDelete.Remaining_Quantity <= QtytoDelete) AND (InventorytoDelete.Remaining_Quantity <> 0) THEN BEGIN
                            i += 1;
                            RecItemJournal.INIT;
                            IF InventorytoDelete.Remaining_Quantity > 0 THEN
                                RecItemJournal."Entry Type" := RecItemJournal."Entry Type"::"Negative Adjmt." ELSE
                                RecItemJournal."Entry Type" := RecItemJournal."Entry Type"::"Positive Adjmt.";
                            RecItemJournal."Posting Date" := TODAY;
                            RecItemJournal."Document No." := 'PICC-1918-00001';
                            RecItemJournal."Journal Template Name" := 'ITEM';
                            RecItemJournal."Journal Batch Name" := Rec."Journal Batch Name";
                            RecItemJournal."Line No." := i * 1000;
                            RecItemJournal.VALIDATE("Item No.", InventorytoDelete.Item_No);
                            RecItemJournal.VALIDATE("Location Code", InventorytoDelete.Location_Code);

                            RecItemJournal.VALIDATE(Quantity, InventorytoDelete.Remaining_Quantity);
                            RecItemJournal.VALIDATE("Applies-to Entry", InventorytoDelete.Entry_No);
                            IF RecItemJournal.Quantity <> 0 THEN BEGIN
                                RecItemJournal.INSERT;
                                RecItemJournal."Dimension Set ID" := InventorytoDelete.Dimension_Set_ID;
                                RecItemJournal."Shortcut Dimension 1 Code" := InventorytoDelete.Global_Dimension_1_Code;
                                RecItemJournal.MODIFY;
                            END;
                        END;
                    END;
                end;
            }
        }
    }

    var
        RecItem: Record Item;
        RecItemJournal: Record "Item Journal Line";
        tgInventatPostingdate: Decimal;
        tgILE: Record "Item Ledger Entry";
        tgAvlInventatPostingdate: Decimal;
        tgItem: Record Item;
        AvlInventatPostingdatePlant: Decimal;
        Text003: Label 'Please define Production Plant code in Item No. %1 Line No. %2.';
        i: Integer;

    trigger OnAfterGetRecord()
    begin
        //Upgrade(+)
        AvlInventatPostingdatePlant := 0;
        //TRI V.D 03.07.10 START
        tgInventatPostingdate := 0;
        tgAvlInventatPostingdate := 0;  //TRI DG
        tgILE.RESET;
        tgILE.SETCURRENTKEY(tgILE."Item No.", tgILE."Posting Date");
        tgILE.SETRANGE(tgILE."Item No.", Rec."Item No.");
        tgILE.SETRANGE(tgILE."Posting Date", 0D, Rec."Posting Date");
        IF Rec."Variant Code" <> '' THEN
            tgILE.SETRANGE(tgILE."Variant Code", Rec."Variant Code");
        IF Rec."Location Code" <> '' THEN
            tgILE.SETRANGE(tgILE."Location Code", Rec."Location Code");
        IF tgILE.FIND('-') THEN
            REPEAT
                tgILE.CALCFIELDS(tgILE."Item Base Unit of Measure");
                tgInventatPostingdate += tgILE."Remaining Quantity";
                tgAvlInventatPostingdate += tgItem.UomToCart(tgILE."Item No.", tgILE."Item Base Unit of Measure",
                tgILE."Remaining Quantity"); //TRI DG
            UNTIL tgILE.NEXT = 0;

        //TRI V.D 03.07.10 STOP
        IF USERID <> 'admin' THEN;



    end;

    local procedure CheckBatchInventory()
    var
        AssociateVendorMgt: Codeunit "Associate Vendor Mgt";
        ItemJournalLine: Record "Item Journal Line";
        QtyToPost: Decimal;
    begin
        IF COMPANYNAME = 'Orient Bell Limited' THEN
            EXIT;
        ItemJournalLine.RESET;
        ItemJournalLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
        ItemJournalLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        ItemJournalLine.SETRANGE("Entry Type", ItemJournalLine."Entry Type"::"Negative Adjmt.");
        IF ItemJournalLine.FINDFIRST THEN
            REPEAT
                CLEAR(AssociateVendorMgt);
                ItemJournalLine.TESTFIELD("Morbi Batch No.");
                QtyToPost := AssociateVendorMgt.CalculateInventoryBalance(ItemJournalLine."Item No.", ItemJournalLine."Location Code", '', ItemJournalLine."Posting Date", TRUE);
                IF QtyToPost <= ItemJournalLine.Quantity THEN
                    ERROR('Not in Inventory %1 At %2 Btch %3', ItemJournalLine."Item No.", ItemJournalLine."Location Code", '');

            UNTIL ItemJournalLine.NEXT = 0;

    end;
}

