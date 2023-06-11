pageextension 50294 pageextension50294 extends "Purch. Receipt Lines"
{

    layout
    {
        addafter("Unit of Measure Code")
        {
            field("Item Category Code"; Rec."Item Category Code")
            {
                ApplicationArea = All;
            }
            field("VAT %"; Rec."VAT %")
            {
                ApplicationArea = All;
            }
            field("Challan Quantity"; Rec."Challan Quantity")
            {
                ApplicationArea = All;
            }
            field("Actual Quantity"; Rec."Actual Quantity")
            {
                ApplicationArea = All;
            }
            field("Accepted Qunatity"; Rec."Accepted Qunatity")
            {
                ApplicationArea = All;
            }
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
            }
        }
    }
}

