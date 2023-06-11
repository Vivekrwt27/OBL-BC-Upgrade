pageextension 50289 pageextension50289 extends "Item Charges"
{
    layout
    {
        addafter(Description)
        {
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Calculation Type"; Rec."Calculation Type")
            {
                ApplicationArea = all;
            }
            field("Insurance Percentage"; Rec."Insurance Percentage")
            {
                ApplicationArea = all;
            }
            field("GL Account"; Rec."GL Account")
            {
                ApplicationArea = all;
            }
            field("Structure Type "; Rec."Structure Type ")
            {
                ApplicationArea = all;
            }
        }
    }
}

