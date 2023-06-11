pageextension 50168 pageextension50168 extends "Phys. Inventory Journal"
{
    layout
    {
        addafter("Reason Code")
        {
            field("Line No."; rec."Line No.")
            {
                ApplicationArea = All;
            }
            field("Inventory Posting Group"; rec."Inventory Posting Group")
            {
                ApplicationArea = All;
            }
            field("Qty. In Pieces"; rec."Qty. In Pieces")
            {
                ApplicationArea = All;
            }
            field("Item Category Code"; rec."Item Category Code")
            {
                ApplicationArea = All;
            }
            field("Qty. In Carton"; rec."Qty. In Carton")
            {
                ApplicationArea = All;
            }
        }
    }
}

