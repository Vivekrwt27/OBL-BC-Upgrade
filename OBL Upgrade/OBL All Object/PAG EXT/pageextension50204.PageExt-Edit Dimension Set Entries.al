pageextension 50204 pageextension50204 extends "Edit Dimension Set Entries"
{
    layout
    {
        addafter("Dimension Name")
        {
            field("Dimension Set ID"; Rec."Dimension Set ID")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Dimension Value ID"; Rec."Dimension Value ID")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
}

