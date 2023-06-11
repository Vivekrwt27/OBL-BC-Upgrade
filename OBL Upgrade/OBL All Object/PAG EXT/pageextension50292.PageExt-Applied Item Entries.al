pageextension 50292 pageextension50292 extends "Applied Item Entries"
{
    layout
    {
        addafter(Description)
        {
            field("Unit of Measure Code"; Rec."Unit of Measure Code")
            {
                ApplicationArea = All;
            }
            field("Cost Amount (Expected)"; Rec."Cost Amount (Expected)")
            {
                ApplicationArea = All;
            }
            field("Cost Amount (Actual)"; Rec."Cost Amount (Actual)")
            {
                ApplicationArea = All;
            }
        }
        addafter("Global Dimension 1 Code")
        {
            field("Output Date"; Rec."Output Date")
            {
                ApplicationArea = All;
            }
            field("Qty In Carton"; Rec."Qty In Carton")
            {
                ApplicationArea = All;
            }
        }
    }
}

