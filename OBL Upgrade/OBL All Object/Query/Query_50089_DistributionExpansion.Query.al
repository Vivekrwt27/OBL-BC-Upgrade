query 50089 "Distribution Expansion"
{

    elements
    {
        dataitem(Customer; 18)
        {
            DataItemTableFilter = "Customer Type" = FILTER('DEALER|DISTIBUTOR');
            column(CustNo; "No.")
            {
            }
            dataitem(Sales_Invoice_Line; 113)
            {
                DataItemLink = "Sell-to Customer No." = Customer."No.";
                filter(Posting_Date_filter; "Posting Date")
                {
                }
                filter(ItemNoFilter; "No.")
                {
                }
                filter(Document_No_Filter; "Document No.")
                {
                }
                filter(Sell_to_Customer_No_Filter; "Sell-to Customer No.")
                {
                }
                column(Month_Posting_Date; "Posting Date")
                {
                    Method = Month;
                }
                column(Year_Posting_Date; "Posting Date")
                {
                    Method = Year;
                }
                column(Sell_to_Customer_No; "Sell-to Customer No.")
                {
                }
                column(ItemNo; "No.")
                {
                }
                /*column(Sum_Amount_To_Customer; "Amount To Customer")
                {
                    ColumnFilter = Sum_Amount_To_Customer = FILTER(<> 0);
                    Method = Sum;
                }*/ //16767
                dataitem(Item; 27)
                {
                    DataItemLink = "No." = Sales_Invoice_Line."No.";
                    DataItemTableFilter = "Item Category Code" = FILTER('M001|D001|T001|H001');
                    column(Tableau_Product_Group; "Tableau Product Group")
                    {
                    }
                    column(Type_Code; "Type Code")
                    {
                    }
                    column(Size_Code_Desc; "Size Code Desc.")
                    {
                    }
                    column(Item_NPD; NPD)
                    {
                    }
                }
            }
        }
    }
}

