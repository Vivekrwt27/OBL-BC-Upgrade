pageextension 50464 "Page ExSales Order Statistics" extends "Sales Order Statistics"
{
    layout
    {
        modify(InvDiscountAmount_General)
        {
            Editable = false;
        }
        modify("TotalAmount1[1]")
        {
            Editable = false;
        }
        modify(VATAmount)
        {
            Editable = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}