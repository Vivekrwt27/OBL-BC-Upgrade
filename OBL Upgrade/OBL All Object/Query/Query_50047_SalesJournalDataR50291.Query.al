query 50047 "Sales Journal Data_R50291"
{
    OrderBy = Ascending(LocationCode), Ascending(PostingDate);

    elements
    {
        dataitem(Sales_Invoice_Header; 112)
        {
            filter(PostingDateFilter; "Posting Date")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(Sell_to_City; "Sell-to City")
            {
            }
            column(Salesperson_Code; "Salesperson Code")
            {
            }
            column(Sell_to_Customer_No; "Sell-to Customer No.")
            {
            }
            dataitem(Sales_Invoice_Line; 113)
            {
                DataItemLink = "Document No." = Sales_Invoice_Header."No.";
                DataItemTableFilter = Type = FILTER(Item),
Quantity = FILTER(<> 0),
"Item Category Code" = FILTER('M001|T001|D001|H001');
                column(Quantity; Quantity)
                {
                }
                column(Quantity_Base; "Quantity (Base)")
                {
                }
                column(LineAmount; "Line Amount")
                {
                }
                column(line_discount; "Line Discount Amount")
                {
                }
                column(System_Discount_Amount; "System Discount Amount")
                {
                }
                /* column(Amount_To_Customer; "Amount To Customer")
                 {
                 }*/ // 16767
                dataitem(Item; 27)
                {
                    DataItemLink = "No." = Sales_Invoice_Line."No.";
                    column(SizeCodeDesc; "Size Code Desc.")
                    {
                    }
                    column(TypeCatCodeDesc; "Item Category Code")
                    {
                    }
                    column(TabProdGrp; "Tableau Product Group")
                    {
                    }
                    column(Size_Code; "Size Code")
                    {
                    }
                }
            }
        }
    }
}

