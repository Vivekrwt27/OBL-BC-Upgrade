pageextension 50437 pageextension50437 extends "Application Worksheet"
{
    layout
    {
        addafter("Document Line No.")
        {
            field("Cost Amount (Expected)"; Rec."Cost Amount (Expected)")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {


    }
}

