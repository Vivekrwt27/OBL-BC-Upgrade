tableextension 50061 tableextension50061 extends "GST Ledger Entry"
{
    fields
    {
        modify("Entry No.")
        {
            Caption = 'Entry No.';
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        modify("Posting Date")
        {
            Caption = 'Posting Date';
        }
        modify("Document No.")
        {
            Caption = 'Document No.';
        }
        modify("Document Type")
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Transfer,,,Refund';
        }
        modify("Transaction Type")
        {
            Caption = 'Transaction Type';
            OptionCaption = 'Purchase,Sales';
        }
        modify("GST Base Amount")
        {
            Caption = 'GST Base Amount';
        }
        modify("Source Type")
        {
            Caption = 'Source Type';
        }
        modify("Source No.")
        {
            Caption = 'Source No.';
        }
        modify("User ID")
        {
            Caption = 'User ID';
        }
        modify("Source Code")
        {
            Caption = 'Source Code';
        }
        modify("Reason Code")
        {
            Caption = 'Reason Code';
        }
        modify("Purchase Group Type")
        {
            Caption = 'Purchase Group Type';
            OptionCaption = ' ,Goods,Service';
        }
        modify("Transaction No.")
        {
            Caption = 'Transaction No.';
        }
        modify("External Document No.")
        {
            Caption = 'External Document No.';
        }
        modify("GST Component Code")
        {
            Caption = 'GST Component Code';
        }
        modify("GST on Advance Payment")
        {
            Caption = 'GST on Advance Payment';
        }
        modify("Reverse Charge")
        {
            Caption = 'Reverse Charge';
        }
        modify("GST Amount")
        {
            Caption = 'GST Amount';
        }
        modify("Currency Code")
        {
            Caption = 'Currency Code';
        }
        modify("Currency Factor")
        {
            Caption = 'Currency Factor';
        }
        modify(Reversed)
        {
            Caption = 'Reversed';
        }
        modify("Reversed Entry No.")
        {
            Caption = 'Reversed Entry No.';
        }
        modify("Reversed by Entry No.")
        {
            Caption = 'Reversed by Entry No.';
        }
        modify(UnApplied)
        {
            Caption = 'UnApplied';
        }
        modify("Entry Type")
        {
            Caption = 'Entry Type';
            OptionCaption = 'Initial Entry,Application';
        }
        modify("Payment Type")
        {
            Caption = 'Payment Type';
        }
        modify("Input Service Distribution")
        {
            Caption = 'Input Service Distribution';
        }
    }
    keys
    {
        key(Key4; "Document No.", "Posting Date")
        {
        }
    }

}

