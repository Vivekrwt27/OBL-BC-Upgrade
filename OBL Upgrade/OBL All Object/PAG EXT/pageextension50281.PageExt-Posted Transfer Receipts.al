pageextension 50281 pageextension50281 extends "Posted Transfer Receipts"
{

    layout
    {
        addafter("Transfer-to Code")
        {
            field("Releasing Date"; Rec."Releasing Date")
            {
                ApplicationArea = All;
            }
            field("Releasing Time"; Rec."Releasing Time")
            {
                ApplicationArea = All;
            }
            field("Transfer Order No."; Rec."Transfer Order No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipping Agent Code")
        {
            field("Total Receipt Qty"; Rec."Total Receipt Qty")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
}

