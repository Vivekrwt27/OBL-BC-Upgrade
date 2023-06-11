pageextension 50450 pageextension50450 extends "Released Production Orders"
{
    layout
    {
        addafter("Source No.")
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
        }
    }


}

