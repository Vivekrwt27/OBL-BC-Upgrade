pageextension 50178 pageextension50178 extends "G/L Account Balance"
{
    layout
    {
        addfirst(content)
        {
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

