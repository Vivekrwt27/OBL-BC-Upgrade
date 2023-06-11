pageextension 50161 pageextension50161 extends "Bank Account Balance Lines"
{
    layout
    {
        addfirst(Control1)
        {
            field("Period Type"; rec."Period Type")
            {
                ApplicationArea = All;
            }
            field("Period End"; rec."Period End")
            {
                ApplicationArea = All;
            }
        }
        moveafter(Control1; "Period Start", "Period Name")
    }
}

