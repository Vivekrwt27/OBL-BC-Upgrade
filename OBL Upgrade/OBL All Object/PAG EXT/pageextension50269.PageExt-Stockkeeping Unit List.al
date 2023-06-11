pageextension 50269 pageextension50269 extends "Stockkeeping Unit List"
{
    layout
    {
        addafter("Assembly Policy")
        {
            field("Unit Cost"; Rec."Unit Cost")
            {
                ApplicationArea = All;
            }
            field("Components at Location"; Rec."Components at Location")
            {
                ApplicationArea = All;
            }
            field("Routing No."; rec."Routing No.")
            {
                ApplicationArea = All;
            }
            field("Default Production SKU"; Rec."Default Production SKU")
            {
                ApplicationArea = All;
            }
            field("Transfer-from Code"; Rec."Transfer-from Code")
            {
                ApplicationArea = All;
            }
        }
    }
}

