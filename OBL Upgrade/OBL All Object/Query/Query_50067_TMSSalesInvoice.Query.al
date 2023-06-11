query 50067 "TMS Sales Invoice"
{
    ReadState = ReadExclusive;

    elements
    {
        dataitem(Sales_Invoice_Header; 112)
        {
            DataItemTableFilter = "Posting Date" = FILTER(>= '04-01-21'),
"Location Code" = FILTER('SKD-WH-MFG|DRA-WH-MFG|HSK-WH-MFG|DRA-SAMPLE|HSK-SAMPLE|SKD-SAMPLE');
            column(Invoice_No; "No.")
            {
            }
            column(Invoice_date; "Posting Date")
            {
            }
            column(SO_no; "Order No.")
            {
            }
            column(Invoice_weight_Kg; "Gross Weight")
            {
            }
            column(E_Way_Bill_No; "E-Way Bill No.")
            {
            }
            column(Invoice_amt; Amount)
            {
            }
            column(Qty_crt; "Qty In carton")
            {
            }
            column(Qty_sqm; "Sq. Meter")
            {
            }
            dataitem(Sales_Cr_Memo_Header; 114)
            {
                DataItemLink = "No." = Sales_Invoice_Header."Reference Invoice No.";
                column(No; "No.")
                {
                }
            }
        }
    }
}

