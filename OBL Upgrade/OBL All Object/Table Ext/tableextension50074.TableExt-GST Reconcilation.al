tableextension 50074 tableextension50074 extends "GST Reconcilation"
{
    fields
    {
        modify(Month)
        {
            Caption = 'Month';
        }
        modify(Year)
        {
            Caption = 'Year';
        }
        modify("Document No")
        {
            Caption = 'Document No';
        }
        modify("Posting Date")
        {
            Caption = 'Posting Date';
        }
    }
}

