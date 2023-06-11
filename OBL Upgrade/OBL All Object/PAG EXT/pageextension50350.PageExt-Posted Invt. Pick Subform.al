pageextension 50350 pageextension50350 extends "Posted Invt. Pick Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
        }
    }
}

