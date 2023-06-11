query 50086 "Sales Invoice Quantity"
{

    elements
    {
        dataitem(Sales_Invoice_Header; 112)
        {
            filter(PostingDateFilter; "Posting Date")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            dataitem(Sales_Invoice_Line; 113)
            {
                DataItemLink = "Document No." = Sales_Invoice_Header."No.";
                DataItemTableFilter = "Item Category Code" = FILTER('M001|T001|H001|D001');
                filter(ItemNoFilter; "No.")
                {
                }
                column(No; "No.")
                {
                }
                column(Sum_Quantity; Quantity)
                {
                    Method = Sum;
                }
                column(Sum_Quantity_Base; "Quantity (Base)")
                {
                    Method = Sum;
                }
                column(Sum_Quantity_in_Sq_Mt; "Quantity in Sq. Mt.")
                {
                    Method = Sum;
                }
            }
        }
    }
}

