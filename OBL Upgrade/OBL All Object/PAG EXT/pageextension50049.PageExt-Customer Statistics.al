pageextension 50049 pageextension50049 extends "Customer Statistics"
{
    layout
    {
        addafter(GetInvoicedPrepmtAmountLCY)
        {
            field("Balance Due"; rec."Balance Due")
            {
                ApplicationArea = All;
            }
        }
    }
}

