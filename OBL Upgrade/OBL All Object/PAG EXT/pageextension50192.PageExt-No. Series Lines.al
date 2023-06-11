pageextension 50192 pageextension50192 extends "No. Series Lines"
{
    layout
    {
        addafter(Open)
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
    }
}

