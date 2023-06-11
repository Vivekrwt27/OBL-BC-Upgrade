pageextension 50466 "EXTJournal Voucher" extends "Journal Voucher"
{
    layout
    {
        movebefore(Amount; "Debit Amount", "Credit Amount")
        modify("Debit Amount")
        {
            Visible = true;
        }
        modify("Credit Amount")
        {
            Visible = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}