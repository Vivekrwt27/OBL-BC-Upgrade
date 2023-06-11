pageextension 50160 pageextension50160 extends "Bank Account Ledger Entries"
{
    Editable = true;
    layout
    {
        moveafter("Entry No."; "Debit Amount", "Credit Amount", "Cheque Date", "Cheque No.", "Bal. Account Type", "Bal. Account No.")
        modify("Bal. Account Type")
        {
            Visible = true;
        }
        modify("Bal. Account No.")
        {
            Visible = true;
        }

        addafter("Entry No.")
        {
            field("Statement No."; rec."Statement No.")
            {
                ApplicationArea = All;
            }

            field("Online Bank Transfer"; Rec."Online Bank Transfer")
            {
                ApplicationArea = All;
                Editable = true;
                AccessByPermission = tabledata "Bank Account Ledger Entry" = rm;
            }
            field("External Document No."; rec."External Document No.")
            {
                ApplicationArea = All;
            }
            field("Value Date"; rec."Value Date")
            {
                ApplicationArea = All;
            }
            field("Issuing Bank"; rec."Issuing Bank")
            {
                ApplicationArea = All;
            }
            field("File Name"; rec."File Name")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Bank RF Status"; rec."Bank RF Status")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Bank UTR/Ref. No."; rec."Bank UTR/Ref. No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("File Create By User ID"; rec."File Create By User ID")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Description 2"; rec."Description 2")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(Stale_Check)
        {
            action("Ledger E&ntries")
            {
                Caption = 'Ledger E&ntries';
                RunObject = Page "Check Ledger Entries";
                ShortCutKey = 'Ctrl+F7';
                ApplicationArea = All;
            }
        }
    }
}

