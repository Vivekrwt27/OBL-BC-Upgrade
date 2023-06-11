pageextension 50261 pageextension50261 extends "Fixed Asset Card"
{
    layout
    {
        addafter("FA Block Code")
        {
            field("FA Posting Group"; Rec."FA Posting Group")
            {
                ApplicationArea = All;
            }
        }
    }
}

