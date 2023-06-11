pageextension 50234 pageextension50234 extends "Purchase Order Archive Subform"
{
    layout
    {

        addafter("No.")
        {
            field("Version No."; Rec."Version No.")
            {
                ApplicationArea = All;
            }
            field("Document No."; Rec."Document No.")
            {
                ApplicationArea = All;
            }
        }
        moveafter(Description; "Description 2")

    }
}

