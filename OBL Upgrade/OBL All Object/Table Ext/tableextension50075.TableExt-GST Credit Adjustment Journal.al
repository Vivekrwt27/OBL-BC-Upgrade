tableextension 50075 tableextension50075 extends "GST Credit Adjustment Journal"
{
    fields
    {
        modify("Vendor No.")
        {
            Caption = 'Vendor No.';
        }
        modify("Posting Date")
        {
            Caption = 'Posting Date';
        }
        modify("Document Type")
        {
            Caption = 'Document Type';
            OptionCaption = 'Invoice,Credit Memo';
        }
        modify("Document No.")
        {
            Caption = 'Document No.';
        }
        modify("Location State Code")
        {
            Caption = 'Location State Code';
        }
    }
}

