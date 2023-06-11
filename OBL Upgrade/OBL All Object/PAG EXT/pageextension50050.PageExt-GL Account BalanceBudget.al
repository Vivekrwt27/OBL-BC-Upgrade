pageextension 50050 pageextension50050 extends "G/L Account Balance/Budget"
{
    layout
    {
        addfirst(Options)
        {
            field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
            }
            field("Budget Filter"; rec."Budget Filter")
            {
                ApplicationArea = All;
            }
        }
    }
}

