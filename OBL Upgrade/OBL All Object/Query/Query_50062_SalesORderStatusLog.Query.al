query 50062 "Sales ORder Status Log"
{

    elements
    {
        dataitem(QueryElement1000000000; 50060)
        {
            DataItemTableFilter = Manual = CONST(false);
            filter(OrderDateTimeFilter; "Order Date & Time")
            {
            }
            column(Sales_Order_No; "Sales Order No.")
            {
            }
            column(Min_Entry_No; "Entry No.")
            {
                Method = Min;
            }
        }
    }
}

