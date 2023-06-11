query 50073 "Sales order data1"
{

    elements
    {
        dataitem(Sales_Header; 36)
        {
            DataItemTableFilter = "Order Date" = FILTER(>= '01-01-20'),
"Location Code" = FILTER('SKD-WH-MFG|DRA-WH-MFG|HSK-WH-MFG|DP-MORBI'),
"Sell-to Customer No." = FILTER(<> '');
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
            dataitem(Customer; 18)
            {
                DataItemLink = "No." = Sales_Header."Sell-to Customer No.";
                column(Sales_Terretory; "Area Code")
                {
                }
            }
        }
    }
}

