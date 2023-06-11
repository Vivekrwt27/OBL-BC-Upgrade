table 50032 "Physical Journal Output Entrie"
{
    DrillDownPageID = "Phy. Journal Output Entries";
    LookupPageID = "Phy. Journal Output Entries";

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(5; "Document Line No."; Integer)
        {
        }
        field(10; "Line No."; Integer)
        {
        }
        field(20; "RM Code"; Code[20])
        {
            TableRelation = Item;
        }
        field(25; Description; Text[50])
        {
        }
        field(30; "Source No."; Code[20])
        {
            TableRelation = Item;
        }
        field(35; "BOM Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(50; "Allocate Quantity"; Decimal)
        {
            DecimalPlaces = 2 : 5;

            trigger OnValidate()
            begin
                //"Manually Changed" := TRUE;
                //ReAllocateQty("Allocate Quantity");
                "Manually Changed" := TRUE;
            end;
        }
        field(55; "Transfer Allocated Qty."; Decimal)
        {
            DecimalPlaces = 2 : 5;
        }
        field(80; "Total Prod. Quantity"; Decimal)
        {
        }
        field(90; "Location Code"; Code[20])
        {
        }
        field(100; "Manually Changed"; Boolean)
        {
        }
        field(120; "Inventory At Location"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("RM Code"),
                                                                  "Location Code" = FIELD("Location Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(130; "Reservation Qty."; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Document No.", "Document Line No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = "BOM Quantity", "Total Prod. Quantity";
        }
        key(Key2; "Document No.", "Document Line No.", "Location Code")
        {
            SumIndexFields = "Allocate Quantity";
        }
    }

    fieldgroups
    {
    }

    procedure ReAllocateQty(var PhysicalJournalLine: Record "Physical Journal Line"; CalledFromBaseLine: Boolean)
    var
        PhysicalJournalOutputEntrie: Record "Physical Journal Output Entrie";
        totalRemainprod: Decimal;
        ManuallyAllocated: Decimal;
        ManuallyTransferAllocated: Decimal;
        TotalRemainingTransfer: Decimal;
        PhysicalJournalOutputEntrie1: Record "Physical Journal Output Entrie";
        PhysicalJournalOutputEntrie2: Record "Physical Journal Output Entrie";
        PhyInvToAllocate: Decimal;
        FirstEntry: Boolean;
        LocationWiseInventory: Record "Location Wise Inventory";
        InventoryToAllocate: Decimal;
    begin
        //PhysicalJournalLine.CALCFIELDS("Manually Allocated Qty.");
        IF CalledFromBaseLine THEN BEGIN
            PhysicalJournalOutputEntrie1.RESET;
            PhysicalJournalOutputEntrie1.SETRANGE("Document No.", PhysicalJournalLine."Document No.");
            PhysicalJournalOutputEntrie1.SETRANGE("Document Line No.", PhysicalJournalLine."Line No.");
            IF PhysicalJournalOutputEntrie1.FINDFIRST THEN
                PhysicalJournalOutputEntrie1.MODIFYALL("Manually Changed", FALSE);
        END;

        PhysicalJournalOutputEntrie1.RESET;
        PhysicalJournalOutputEntrie1.SETRANGE("Document No.", PhysicalJournalLine."Document No.");
        PhysicalJournalOutputEntrie1.SETRANGE("Document Line No.", PhysicalJournalLine."Line No.");
        PhysicalJournalOutputEntrie1.SETFILTER("Transfer Allocated Qty.", '<>%1', 0);
        IF PhysicalJournalOutputEntrie1.FINDFIRST THEN BEGIN
            PhysicalJournalOutputEntrie.MODIFYALL("Transfer Allocated Qty.", 0);
        END;

        LocationWiseInventory.RESET;
        LocationWiseInventory.SETRANGE("Physical Journal Filter", PhysicalJournalLine."Document No.");
        LocationWiseInventory.SETRANGE("No.", PhysicalJournalLine."Item No.");
        LocationWiseInventory.SETRANGE(Location, PhysicalJournalLine."Location Code");
        IF LocationWiseInventory.FINDFIRST THEN BEGIN
            REPEAT
                totalRemainprod := 0;
                ManuallyAllocated := 0;
                FirstEntry := TRUE;
                PhysicalJournalOutputEntrie.RESET;
                PhysicalJournalOutputEntrie.SETCURRENTKEY("Document No.", "Document Line No.", "Location Code");
                PhysicalJournalOutputEntrie.SETRANGE("Document No.", PhysicalJournalLine."Document No.");
                PhysicalJournalOutputEntrie.SETRANGE("Document Line No.", PhysicalJournalLine."Line No.");
                //PhysicalJournalOutputEntrie.SETRANGE("Manually Changed",FALSE);
                PhysicalJournalOutputEntrie.SETRANGE("Location Code", LocationWiseInventory.Location);
                IF PhysicalJournalOutputEntrie.FINDFIRST THEN BEGIN
                    REPEAT
                        IF NOT PhysicalJournalOutputEntrie."Manually Changed" THEN BEGIN
                            totalRemainprod += PhysicalJournalOutputEntrie."Total Prod. Quantity";
                        END;
                        IF PhysicalJournalOutputEntrie."Manually Changed" THEN BEGIN
                            ManuallyAllocated += PhysicalJournalOutputEntrie."Allocate Quantity";
                            ManuallyTransferAllocated += PhysicalJournalOutputEntrie."Transfer Allocated Qty.";
                        END;
                    UNTIL PhysicalJournalOutputEntrie.NEXT = 0;
                END;
                IF FirstEntry THEN BEGIN
                    InventoryToAllocate := LocationWiseInventory."Inventory at Location" - (ManuallyAllocated + PhysicalJournalLine."Physical Inventory");
                    PhysicalJournalLine."Physical Inventory" := 0;
                END;

                //IF InventoryToAllocate<>0 THEN BEGIN
                PhysicalJournalOutputEntrie.RESET;
                PhysicalJournalOutputEntrie.SETCURRENTKEY("Document No.", "Document Line No.", "Location Code");
                PhysicalJournalOutputEntrie.SETRANGE("Document No.", PhysicalJournalLine."Document No.");
                PhysicalJournalOutputEntrie.SETRANGE("Document Line No.", PhysicalJournalLine."Line No.");
                PhysicalJournalOutputEntrie.SETRANGE("Location Code", LocationWiseInventory.Location);
                //PhysicalJournalOutputEntrie.SETRANGE("Manually Changed",FALSE);
                IF PhysicalJournalOutputEntrie.FINDFIRST THEN BEGIN
                    PhyInvToAllocate := PhysicalJournalLine."Physical Inventory";
                    REPEAT
                        //IF PhysicalJournalOutputEntrie."RM Code" = 'RD101008741' THEN
                        // MESSAGE('%1-%2-%3',LocationWiseInventory."Inventory at Location",InventoryToAllocate,PhysicalJournalLine."Physical Inventory");
                        IF (PhysicalJournalLine."Short/Excess" <> 0) AND (NOT PhysicalJournalOutputEntrie."Manually Changed") THEN BEGIN
                            PhysicalJournalOutputEntrie."Allocate Quantity" := ROUND(InventoryToAllocate
                                          * (PhysicalJournalOutputEntrie."Total Prod. Quantity" / (totalRemainprod)), 0.01, '<');
                            PhysicalJournalOutputEntrie.MODIFY();
                        END;

                        IF (PhysicalJournalLine."Transfer Inventory" <> 0) THEN BEGIN

                            PhysicalJournalOutputEntrie1.RESET;
                            PhysicalJournalOutputEntrie1.SETCURRENTKEY("Document No.", "Document Line No.", "Location Code");
                            PhysicalJournalOutputEntrie1.SETRANGE("Document No.", PhysicalJournalOutputEntrie."Document No.");
                            PhysicalJournalOutputEntrie1.SETRANGE("Document Line No.", PhysicalJournalOutputEntrie."Document Line No.");
                            PhysicalJournalOutputEntrie1.SETRANGE("Location Code", PhysicalJournalOutputEntrie."Location Code");
                            PhysicalJournalOutputEntrie1.SETFILTER("Transfer Allocated Qty.", '<>%1', 0);
                            IF NOT PhysicalJournalOutputEntrie1.FINDFIRST THEN BEGIN
                                PhysicalJournalOutputEntrie2.RESET;
                                PhysicalJournalOutputEntrie2.SETCURRENTKEY("Document No.", "Document Line No.", "Location Code");
                                PhysicalJournalOutputEntrie2.SETRANGE("Document No.", PhysicalJournalOutputEntrie."Document No.");
                                PhysicalJournalOutputEntrie2.SETRANGE("Document Line No.", PhysicalJournalOutputEntrie."Document Line No.");
                                PhysicalJournalOutputEntrie2.SETRANGE("Location Code", PhysicalJournalOutputEntrie."Location Code");
                                IF PhysicalJournalOutputEntrie2.FINDFIRST THEN
                                    PhysicalJournalOutputEntrie2.CALCSUMS("Allocate Quantity");
                                PhysicalJournalOutputEntrie.CALCFIELDS("Inventory At Location");

                                IF FirstEntry THEN
                                    PhysicalJournalOutputEntrie."Transfer Allocated Qty." := (PhysicalJournalOutputEntrie2."Allocate Quantity" - PhysicalJournalOutputEntrie."Inventory At Location" + PhysicalJournalLine."Physical Inventory")
                                ELSE
                                    PhysicalJournalOutputEntrie."Transfer Allocated Qty." := (PhysicalJournalOutputEntrie2."Allocate Quantity" - PhysicalJournalOutputEntrie."Inventory At Location");
                                FirstEntry := FALSE;
                                IF PhysicalJournalOutputEntrie."Transfer Allocated Qty." < 0 THEN
                                    PhysicalJournalOutputEntrie."Transfer Allocated Qty." := 0;
                                PhysicalJournalOutputEntrie.MODIFY();
                            END ELSE BEGIN
                                PhysicalJournalOutputEntrie."Transfer Allocated Qty." := 0;
                                PhysicalJournalOutputEntrie.MODIFY;
                            END;
                        END;
                    UNTIL PhysicalJournalOutputEntrie.NEXT = 0;
                    //  END;
                END;// MSKS
            UNTIL LocationWiseInventory.NEXT = 0;
        END;
    end;

    procedure CheckShortExcess(DocNo: Code[20]; LineNo: Integer)
    var
        PhysicalJournalLine: Record "Physical Journal Line";
        PhysicalJournalOutputEntrie: Record "Physical Journal Output Entrie";
        ShortExcess: Decimal;
    begin
        PhysicalJournalLine.RESET;
        PhysicalJournalLine.SETRANGE("Document No.", "Document No.");
        PhysicalJournalLine.SETRANGE("Line No.", "Document Line No.");
        IF PhysicalJournalLine.FINDSET THEN BEGIN
            PhysicalJournalOutputEntrie.RESET;
            PhysicalJournalOutputEntrie.SETRANGE("Document No.", PhysicalJournalLine."Document No.");
            PhysicalJournalOutputEntrie.SETRANGE("Document Line No.", PhysicalJournalLine."Line No.");
            IF PhysicalJournalOutputEntrie.FINDSET THEN
                REPEAT
                    ShortExcess += PhysicalJournalOutputEntrie."Allocate Quantity";
                UNTIL PhysicalJournalOutputEntrie.NEXT = 0;
        END;
        IF ShortExcess <> 0 THEN
            PhysicalJournalLine.TESTFIELD("Short/Excess", ShortExcess);
    end;
}

