tableextension 50250 tableextension50250 extends "Purchase Price"
{
    fields
    {
        field(50000; "Order Date"; Date)
        {
        }
        field(50001; "Order No."; Code[20])
        {
        }
        field(50002; Quantity; Decimal)
        {
        }
        field(50003; "Excise %"; Decimal)
        {
        }
        field(50004; PaymentTerms; Code[20])
        {
            TableRelation = "Payment Terms".Code;
        }
        field(50005; "VAT %"; Decimal)
        {
        }
        field(50006; "Sales Tax %"; Decimal)
        {
        }
        field(50007; "Charges %"; Decimal)
        {
        }
        field(50008; "Other Taxes %"; Decimal)
        {
        }
    }

    var
        Item: Record Item;
        Text001: Label '%1 already exists.';
}

