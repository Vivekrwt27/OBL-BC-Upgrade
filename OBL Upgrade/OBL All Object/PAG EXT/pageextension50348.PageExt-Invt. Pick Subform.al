pageextension 50348 pageextension50348 extends "Invt. Pick Subform"
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

