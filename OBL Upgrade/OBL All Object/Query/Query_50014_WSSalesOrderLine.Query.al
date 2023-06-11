query 50014 "WS Sales Order Line"
{

    elements
    {
        dataitem(Sales_Line; 37)
        {
            DataItemTableFilter = "Document Type" = CONST(Order);
            column(Document_No; "Document No.")
            {
            }
            column(Line_No; "Line No.")
            {
            }
            column(Sell_to_Customer_No; "Sell-to Customer No.")
            {
            }
            column(No; "No.")
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(Unit_Price; "Unit Price")
            {
            }
            column(Line_Amount; "Line Amount")
            {
            }
            column(Line_Discount_Amount; "Line Discount Amount")
            {
            }
            /* column(Amount_To_Customer; "Amount To Customer")
             {
             }*/ // 16767
            dataitem(Item; 27)
            {
                DataItemLink = "No." = Sales_Line."No.";
                column(Size_Code_Desc; "Size Code Desc.")
                {
                }
                column(Design_Code_Desc; "Design Code Desc.")
                {
                }
                column(Quality_Code_Desc; "Quality Code Desc.")
                {
                }
                column(Color_Code_Desc; "Color Code Desc.")
                {
                }
            }
        }
    }
}

