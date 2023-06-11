pageextension 50016 pageextension50016 extends "Comment List"
{
    Editable = true;
    layout
    {
        addafter(Code)
        {
            field("Line No."; rec."Line No.")
            {
                ApplicationArea = All;
            }
            field("Reply/Comment"; rec."Reply/Comment")
            {
                ApplicationArea = All;
            }
            field("To User"; rec."To User")
            {
                ApplicationArea = All;
            }
        }
    }
}

