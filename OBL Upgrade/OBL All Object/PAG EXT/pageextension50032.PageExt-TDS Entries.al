pageextension 50032 pageextension50032 extends "TDS Entries"
{
    layout
    {
        addafter("Document No.")
        {
            field(Reversed; rec.Reversed)
            {
                ApplicationArea = All;
            }
            field("Party Account No."; rec."Party Account No.")
            {
                ApplicationArea = All;
            }

        }
        addafter("Invoice Amount")
        {
            field("Location Code"; rec."Location Code")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
}

