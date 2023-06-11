pageextension 50382 pageextension50382 extends "Purchase Return Order List"
{
    layout
    {
        addafter("Campaign No.")
        {
            field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
            {
                ApplicationArea = All;
            }
        }
        modify("Applies-to Doc. Type")
        {
            Visible = true;
        }
    }
}

