query 50087 "Sales Line OutstandingQty"
{

    elements
    {
        dataitem(Sales_Header; 36)
        {
            DataItemTableFilter = "Document Type" = CONST(Order);
            filter(OrderDateFilter; "Order Date")
            {
            }
            column(Order_Date; "Order Date")
            {
            }
            column(Status; Status)
            {
            }
            dataitem(Sales_Line; 37)
            {
                DataItemLink = "Document Type" = Sales_Header."Document Type",
                "Document No." = Sales_Header."No.";
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
                column(Sum_Outstanding_Quantity; "Outstanding Quantity")
                {
                    Method = Sum;
                }
                column(Sum_Outstanding_Qty_Base; "Outstanding Qty. (Base)")
                {
                    Method = Sum;
                }
            }
        }
    }
}

