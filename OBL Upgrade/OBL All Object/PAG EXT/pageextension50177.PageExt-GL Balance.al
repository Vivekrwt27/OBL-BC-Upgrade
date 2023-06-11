pageextension 50177 pageextension50177 extends "G/L Balance"
{
    layout
    {
        addfirst(Control5)
        {
            field("Date Filter"; rec."Date Filter")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
            }
        }
    }
}

