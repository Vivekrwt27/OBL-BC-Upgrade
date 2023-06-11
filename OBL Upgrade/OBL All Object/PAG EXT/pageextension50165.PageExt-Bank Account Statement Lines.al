pageextension 50165 pageextension50165 extends "Bank Account Statement Lines"
{
    layout
    {
        moveafter(Control1; "Document No.")
        addfirst(Control1)
        {
            field("Bank Account No."; rec."Bank Account No.")
            {
                ApplicationArea = All;
            }
            field("Statement No."; rec."Statement No.")
            {
                ApplicationArea = All;
            }
            field("Statement Line No."; rec."Statement Line No.")
            {
                ApplicationArea = All;
            }

        }
        moveafter("Statement Amount"; Difference)
        moveafter("Applied Amount"; "Applied Entries", "Value Date", "Check No.")
        addafter("Applied Amount")
        {
            field(Name; rec.Name)
            {
                ApplicationArea = All;
            }
            field("Cheque Date"; rec."Cheque Date")
            {
                ApplicationArea = All;
            }
            field("Issuing Bank"; rec."Issuing Bank")
            {
                ApplicationArea = All;
            }
            field("Cheque No."; rec."Cheque No.")
            {
                ApplicationArea = All;
            }
        }
    }
}

