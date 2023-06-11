pageextension 50235 pageextension50235 extends "Purchase Lines"
{
    layout
    {
        addafter("Document Type")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
        }
        addafter(Type)
        {
            field("Item Category Code"; Rec."Item Category Code")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = All;
            }
            field("Outstanding Qty. (Base)"; Rec."Outstanding Qty. (Base)")
            {
                ApplicationArea = All;
            }
        }

    }
}

