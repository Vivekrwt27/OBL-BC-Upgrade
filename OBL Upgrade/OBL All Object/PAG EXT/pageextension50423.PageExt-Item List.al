pageextension 50423 pageextension50423 extends "Item List"
{
    layout
    {
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
            field("Manuf. Strategy"; Rec."Manuf. Strategy")
            {
                ApplicationArea = all;
            }
            field("Complete Description"; Rec."Complete Description")
            {
                ApplicationArea = all;
            }
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = all;
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = all;
            }
            field(NPD; Rec.NPD)
            {
                ApplicationArea = all;
            }
            field("Type Code"; Rec."Type Code")
            {
                ApplicationArea = all;
            }
            field("Type Catogery Code"; Rec."Type Catogery Code")
            {
                ApplicationArea = all;
            }
            field("Size Code"; Rec."Size Code")
            {
                ApplicationArea = all;
            }
            field("Design Code"; Rec."Design Code")
            {
                ApplicationArea = all;
            }
            field("Color Code"; Rec."Color Code")
            {
                ApplicationArea = all;
            }
            field("Packing Code"; Rec."Packing Code")
            {
                ApplicationArea = all;
            }
            field("Quality Code"; Rec."Quality Code")
            {
                ApplicationArea = all;
            }
            field("Plant Code"; Rec."Plant Code")
            {
                ApplicationArea = all;
            }
            field("Tableau Product Group"; Rec."Tableau Product Group")
            {
                ApplicationArea = all;
            }

        }
        moveafter("Type Code"; "Item Category Code")
        addafter("No.")
        {
            field("Created Date"; Rec."Created Date")
            {
                ApplicationArea = all;
            }
        }

        addafter("Default Deferral Template Code")
        {
            field("Maximum Inventory"; Rec."Maximum Inventory")
            {
                ApplicationArea = All;
            }
            field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
            {
                ApplicationArea = All;
            }
            field("Date Filter"; Rec."Date Filter")
            {
                ApplicationArea = All;
            }

            field("Reserved Qty. on Inventory"; Rec."Reserved Qty. on Inventory")
            {
                ApplicationArea = All;
            }
            field(Inventory; Rec.Inventory)
            {
                ApplicationArea = All;
            }
            field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
            {
                ApplicationArea = All;
            }
            field("<Net Weight/SQ.MT>"; Rec."Net Weight")
            {
                Caption = '<Net Weight/SQ.MT>';
                ApplicationArea = All;
            }
            field("Location Filter"; Rec."Location Filter")
            {
                ApplicationArea = All;
            }
            field("Net Change"; Rec."Net Change")
            {
                ApplicationArea = All;
            }
            field("GST Group Code"; Rec."GST Group Code")
            {
                ApplicationArea = All;
            }
            field("HSN/SAC Code"; Rec."HSN/SAC Code")
            {
                ApplicationArea = All;
            }
            field("ProductionQty."; Rec."ProductionQty.")
            {
                ApplicationArea = all;
            }
            field("Layer Per Pallate"; Rec."Layer Per Pallate")
            {
                ApplicationArea = all;
            }
            field("Box Per Layer"; Rec."Box Per Layer")
            {
                ApplicationArea = all;
            }

        }
        moveafter("HSN/SAC Code"; "Unit Price", "Unit Cost")
    }

    var
        ItemCostMgt: Codeunit ItemCostManagement;
        AverageCostLCY: Decimal;
        AverageCostACY: Decimal;
        AverageCostLCY1: Decimal;
        AverageCostACY1: Decimal;
        LocFilter: Code[10];
        [InDataSet]
        "Cost is AdjustedEditable": Boolean;
        AdminVisi: Boolean;

    trigger OnOpenPage()
    begin
        CurrPage.LOOKUPMODE := TRUE;
        //if xRec.Blocked = True then;
        //  IF UPPERCASE(USERID) = 'ADMIN' THEN
        Rec.SETRANGE(Blocked, FALSE);
        Rec.SETRANGE(Blocked2, FALSE);

    end;

    procedure "--MSBS.Rao261114--"()
    begin
    end;

    procedure SetLocationFilter(LocCode: Code[10])
    begin
        LocFilter := LocCode;
    end;
}

