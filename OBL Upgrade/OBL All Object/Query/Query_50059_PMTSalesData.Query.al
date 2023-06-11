query 50059 "PMT Sales Data"
{

    elements
    {
        dataitem(Sales_Invoice_Header; 112)
        {
            DataItemTableFilter = "PMT Code" = FILTER(<> '');
            column(PMT_No; "PMT Code")
            {
            }
            column(Sale_amount; Amount)
            {
                Method = Sum;
            }
            column(No; "No.")
            {
            }
            column(Sum_Qty_In_carton; "Qty In carton")
            {
                Method = Sum;
            }
        }
    }
}

