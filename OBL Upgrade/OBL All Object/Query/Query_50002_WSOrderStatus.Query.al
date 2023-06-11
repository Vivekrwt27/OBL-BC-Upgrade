query 50002 "WS Order Status"
{

    elements
    {
        dataitem(Sales_Header; 36)
        {
            DataItemTableFilter = "Document Type" = CONST(Order);
            column(Sell_to_Customer_No; "Sell-to Customer No.")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(Order_Date; "Order Date")
            {
            }
            column(No; "No.")
            {
            }
            column(Status; Status)
            {
            }
            column(Salesperson_Code; "Salesperson Code")
            {
            }
            column(Qty_in_Sq_Mt; "Qty in Sq. Mt.")
            {
            }
            /* column(Amount_to_Customer; "Amount to Customer")
             {
             }*/ // 16767
            column(Approval_Pending_At; "Approval Pending At")
            {
            }
        }
    }
}

