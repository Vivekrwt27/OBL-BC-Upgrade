query 50028 "Sales Data -MGT"
{

    elements
    {
        dataitem(Matrix_Master; 50003)
        {
            filter(AreaFilter; "Type 1")
            {
            }
            column("Area"; "Type 1")
            {
            }
            column(Description_2; "Description 2")
            {
            }
            dataitem(Customer; 18)
            {
                DataItemLink = "Area Code" = Matrix_Master."Type 1";
                filter(CustomerTypeFilter; "Customer Type")
                {
                }
                column(No; "No.")
                {
                }
                column(Name; Name)
                {
                }
                column(Area_Code; "Area Code")
                {
                }
                filter(PCHFilter; "PCH Code")
                {
                }
                filter(SPFilter; "Salesperson Code")
                {
                }
                dataitem(Sales_Invoice_Line; 113)
                {
                    DataItemLink = "Sell-to Customer No." = Customer."No.";
                    DataItemTableFilter = Type = FILTER(Item),
Quantity = FILTER(<> 0),
"Item Category Code" = FILTER('M001|T001|D001|H001');
                    filter(PostDateFilter; "Posting Date")
                    {
                    }
                    column(Posting_Date; "Posting Date")
                    {
                    }
                    column(Item_Category_Code; "Item Category Code")
                    {
                    }
                    filter(LocationFilter; "Location Code")
                    {
                    }
                    column(Sum_Quantity_Base; "Quantity (Base)")
                    {
                        ColumnFilter = Sum_Quantity_Base = FILTER(<> 0);
                        Method = Sum;
                    }
                    column(Sum_Line_Amount; "Line Amount")
                    {
                        Method = Sum;
                    }
                    dataitem(HVP_Discontinued_Items; 50080)
                    {
                        DataItemLink = "Item No." = Sales_Invoice_Line."No.";
                        DataItemTableFilter = Type = FILTER(HVP),
"Starting Date" = FILTER(>= '04-01-18');
                        filter(HVPFilter; "HVP/Discontinued")
                        {
                        }
                        column(HVP_Discontinued; "HVP/Discontinued")
                        {
                        }
                    }
                }
            }
        }
    }
}

