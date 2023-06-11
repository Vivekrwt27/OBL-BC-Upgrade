query 50072 "Sales order data archive"
{

    elements
    {
        dataitem(Sales_Header_Archive; 5107)
        {
            DataItemTableFilter = "Order Date" = FILTER(>= '01-01-20'),
"Location Code" = FILTER('SKD-WH-MFG|DRA-WH-MFG|HSK-WH-MFG|DP-MORBI'),
"Sell-to Customer No." = FILTER(<> ''),
"Document Type" = FILTER(Order);
            column(so_no; "No.")
            {
            }
            column(Order_Date; "Order Date")
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(Executive_no; "Transfer No.")
            {
            }
            column(Salesperson_Code; "Salesperson Code")
            {
            }
            column(Salesperson_Description; "Salesperson Description")
            {
            }
            column(Amount; Amount)
            {
            }
            column(Order_Change_Remarks; "Order Change Remarks")
            {
            }
            dataitem(Customer; 18)
            {
                DataItemLink = "No." = Sales_Header_Archive."Sell-to Customer No.";
                column(Sales_Terretory; "Area Code")
                {
                }
            }
        }
    }
}

