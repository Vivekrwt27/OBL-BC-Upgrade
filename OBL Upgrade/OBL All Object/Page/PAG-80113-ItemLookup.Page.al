pageextension 80113 "EXTItem Lookup" extends "Item Lookup"
{
    layout
    {
        moveafter("Created From Nonstock Item"; "Unit Cost", "Assembly Policy", "Default Deferral Template Code", Blocked, "Flushing Method", "Gen. Prod. Posting Group", "Inventory Posting Group", "Item Category Code", "Last Date Modified", "Last Direct Cost", "Sales Unit of Measure")
        addafter("Base Unit of Measure")
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = all;
            }
            field("Complete Description"; Rec."Complete Description")
            {
                ApplicationArea = all;
            }
            field("Manuf. Strategy"; Rec."Manuf. Strategy")
            {
                ApplicationArea = all;
            }
            field("Substitutes Exist"; Rec."Substitutes Exist")
            {
                ApplicationArea = all;
            }
            field("Assembly BOM"; Rec."Assembly BOM")
            {
                ApplicationArea = all;
            }
            field("Production BOM No."; Rec."Production BOM No.")
            {
                ApplicationArea = all;
            }
            field("Hide Items"; Rec."Hide Items")
            {
                ApplicationArea = all;
            }

            field(COGS; Rec.COGS)
            {
                ApplicationArea = all;
            }

            field("End Use Item"; Rec."End Use Item")
            {
                ApplicationArea = all;
            }
            field("Shelf Location HSK"; Rec."Shelf Location HSK")
            {
                ApplicationArea = all;
            }
            field("Shelf Location Dra"; Rec."Shelf Location Dra")
            {
                ApplicationArea = all;
            }
            field("Maximum Inventory"; Rec."Maximum Inventory")
            {
                ApplicationArea = all;
            }
            field("Last Modified ID"; Rec."Last Modified ID")
            {
                ApplicationArea = all;
            }
            field("Minimum Inventory"; Rec."Minimum Inventory")
            {
                ApplicationArea = all;
            }
            field("Transfer Order Blocked"; Rec."Transfer Order Blocked")
            {
                ApplicationArea = all;
            }
            field("Created ID"; Rec."Created ID")
            {
                ApplicationArea = all;
            }

            field("Indent Blocked"; Rec."Indent Blocked")
            {
                ApplicationArea = all;
            }
            field("Purchase Blocked"; Rec."Purchase Blocked")
            {
                ApplicationArea = all;
            }
            field("Created Date"; Rec."Created Date")
            {
                ApplicationArea = all;
            }
            field(Premium; Rec.Premium)
            {
                ApplicationArea = all;
            }
            field("Type Code"; Rec."Type Code")
            {
                ApplicationArea = all;
            }
            field("Size Code"; Rec."Size Code")
            {
                ApplicationArea = all;
            }
            field("Group Code"; Rec."Group Code")
            {
                ApplicationArea = all;
            }
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = all;
            }
            field(Retained; Rec.Retained)
            {
                ApplicationArea = all;
            }
            field("Default Prod. Plant Code"; Rec."Default Prod. Plant Code")
            {
                ApplicationArea = all;
            }
            field("Reserved Qty. on Inventory"; Rec."Reserved Qty. on Inventory")
            {
                ApplicationArea = all;
            }
            field(Inventory; Rec.Inventory)
            {
                ApplicationArea = all;
            }
            field("Inventory At Plant location"; Rec."Inventory At Plant location")
            {
                ApplicationArea = all;
            }
            field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
            {
                ApplicationArea = all;
            }
            field("ABC Analysis"; Rec."ABC Analysis")
            {
                ApplicationArea = all;
            }
            field("Type Category Code Desc."; Rec."Type Category Code Desc.")
            {
                ApplicationArea = all;
            }
            field("Item Classification"; Rec."Item Classification")
            {
                ApplicationArea = all;
            }
            field("Product Group Desc."; Rec."Product Group Desc.")
            {
                ApplicationArea = all;
            }
            field("Type Code Desc."; Rec."Type Code Desc.")
            {
                ApplicationArea = all;
            }
            field("Item Category Desc."; Rec."Item Category Desc.")
            {
                ApplicationArea = all;
            }
            field("Size Code Desc."; Rec."Size Code Desc.")
            {
                ApplicationArea = all;
            }
            field("Plant Code Desc."; Rec."Plant Code Desc.")
            {
                ApplicationArea = all;
            }
            field("Location Filter"; Rec."Location Filter")
            {
                ApplicationArea = all;
            }
            field("Packing Code"; Rec."Packing Code")
            {
                ApplicationArea = all;
            }

            field("Plant Code"; Rec."Plant Code")
            {
                ApplicationArea = all;
            }
            field("Quality Code"; Rec."Quality Code")
            {
                ApplicationArea = all;
            }
            field("Color Code"; Rec."Color Code")
            {
                ApplicationArea = all;
            }
            field("Design Code"; Rec."Design Code")
            {
                ApplicationArea = all;
            }
            field("Design Code Desc."; Rec."Design Code Desc.")
            {
                ApplicationArea = all;
            }
            field("Color Code Desc."; Rec."Color Code Desc.")
            {
                ApplicationArea = all;
            }
            field("Packing Code Desc."; Rec."Packing Code Desc.")
            {
                ApplicationArea = all;
            }
            field("Quality Code Desc."; Rec."Quality Code Desc.")
            {
                ApplicationArea = all;
            }
            field(NPD; Rec.NPD)
            {
                ApplicationArea = all;
            }
            field("NPD Sub"; Rec."NPD Sub")
            {
                ApplicationArea = all;
            }
            field("GST Group Code"; Rec."GST Group Code")
            {
                ApplicationArea = all;
            }
            field("HSN/SAC Code"; Rec."HSN/SAC Code")
            {
                ApplicationArea = all;
            }
            field("Scheme Group"; Rec."Scheme Group")
            {
                ApplicationArea = all;
            }
            field(Liquidaton; Rec.Liquidaton)
            {
                ApplicationArea = all;
            }
            field("Box Per Layer"; Rec."Box Per Layer")
            {
                ApplicationArea = all;
            }

            field("Sales Price"; Rec."Sales Price")
            {
                ApplicationArea = all;
            }
            field("Tableau Product Group"; Rec."Tableau Product Group")
            {
                ApplicationArea = all;
            }
            field("Prod. Consumption Item"; Rec."Prod. Consumption Item")
            {
                ApplicationArea = all;
            }

            field(Blocked2; Rec.Blocked2)
            {
                ApplicationArea = all;
            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}