pageextension 50462 "Reason Codes" extends "Reason Codes"
{
    layout
    {
        addafter(Description)
        {
            field("Item Change Remarks"; Rec."Item Change Remarks")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}