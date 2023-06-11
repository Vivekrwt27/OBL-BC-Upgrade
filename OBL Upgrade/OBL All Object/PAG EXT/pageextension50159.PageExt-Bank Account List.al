pageextension 50159 pageextension50159 extends "Bank Account List"
{
    layout
    {
        addafter("SWIFT Code")
        {
            field("GST Registration No."; rec."GST Registration No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Search Name")
        {
            field("Balance (LCY)"; rec."Balance (LCY)")
            {
                ApplicationArea = All;
            }
            field("Balance at Date"; rec."Balance at Date")
            {
                ApplicationArea = All;
            }
            field(Balance; rec.Balance)
            {
                ApplicationArea = All;
            }
        }
    }
}

