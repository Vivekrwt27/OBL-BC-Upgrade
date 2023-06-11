pageextension 50243 pageextension50243 extends "Posted Purchase Invoice Lines"
{
    layout
    {
        addafter("Line Discount %")
        {
            field("Nature of Expense"; Rec.NOE)
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
}

