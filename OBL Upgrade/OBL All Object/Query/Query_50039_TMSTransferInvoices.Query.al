query 50039 "TMS Transfer Invoices"
{
    ReadState = ReadExclusive;

    elements
    {
        dataitem(Transfer_Shipment_Header; 5744)
        {
            DataItemTableFilter = "Posting Date" = FILTER(>= '06-01-20');
            column(No; "No.")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Transfer_Order_No; "Transfer Order No.")
            {
            }
            column(Gross_Weight; "Gross Weight")
            {
            }
            column(E_Way_Bill_No; "E-Way Bill No.")
            {
            }
            column(Amount; Amount)
            {
            }
            dataitem(Transfer_Shipment_Line; 5745)
            {
                DataItemLink = "Document No." = Transfer_Shipment_Header."No.";
                column(Qty_In_SQMT; "Quantity (Base)")
                {
                    Method = Sum;
                }
                column(Sum_Quantity; Quantity)
                {
                    Method = Sum;
                }
            }
        }
    }
}

