pageextension 50164 pageextension50164 extends "Apply Check Ledger Entries"
{
    layout
    {
        moveafter(LineApplied; "Posting Date", "Document Type", "Document No.", Amount, "Check Date", "Check No.", "Check Type", Open, "Statement Status", "Statement No.", "Statement Line No.")
        addafter(LineApplied)
        {
            field("Entry No."; rec."Entry No.")
            {
                ApplicationArea = All;
            }
            field("Bank Account No."; rec."Bank Account No.")
            {
                ApplicationArea = All;
            }
            field("Bank Account Ledger Entry No."; rec."Bank Account Ledger Entry No.")
            {
                ApplicationArea = All;
            }
            field(Description; rec.Description)
            {
                ApplicationArea = All;
            }
            field("Bank Payment Type"; rec."Bank Payment Type")
            {
                ApplicationArea = All;
            }
            field("Entry Status"; rec."Entry Status")
            {
                ApplicationArea = All;
            }
            field("Original Entry Status"; rec."Original Entry Status")
            {
                ApplicationArea = All;
            }
            field("Bal. Account Type"; rec."Bal. Account Type")
            {
                ApplicationArea = All;
            }
            field("Bal. Account No."; rec."Bal. Account No.")
            {
                ApplicationArea = All;
            }
            field("User ID"; rec."User ID")
            {
                ApplicationArea = All;
            }
            field("External Document No."; rec."External Document No.")
            {
                ApplicationArea = All;
            }
            field("Stale Cheque"; rec."Stale Cheque")
            {
                ApplicationArea = All;
            }
            field("Stale Cheque Expiry Date"; rec."Stale Cheque Expiry Date")
            {
                ApplicationArea = All;
            }
            field("Cheque Stale Date"; rec."Cheque Stale Date")
            {
                ApplicationArea = All;
            }
        }
    }
}

