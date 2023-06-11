pageextension 50381 pageextension50381 extends "Purchase Credit Memos"
{
    layout
    {
        addafter("Purchaser Code")
        {
            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = All;
            }
        }
    }
}

