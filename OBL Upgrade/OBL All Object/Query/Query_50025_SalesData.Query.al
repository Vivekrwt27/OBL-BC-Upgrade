query 50025 "Sales Data"
{

    elements
    {
        dataitem(Matrix_Master; 50003)
        {
            column(Type_1; "Type 1")
            {
            }
            column(Description_2; "Description 2")
            {
            }
            dataitem(Customer; 18)
            {
                DataItemLink = "Area Code" = Matrix_Master."Type 1";
                column(No; "No.")
                {
                }
                column(Name; Name)
                {
                }
                column(Area_Code; "Area Code")
                {
                }
                filter(PCH_Code; "PCH Code")
                {
                }
                filter(Zonal_Head; "Zonal Head")
                {
                }
                filter(Salesperson_Code; "Salesperson Code")
                {
                }
                dataitem(Sales_Invoice_Line; 113)
                {
                    DataItemLink = "Sell-to Customer No." = Customer."No.";
                    DataItemTableFilter = Type = FILTER(Item),
Quantity = FILTER(<> '0'),
"Item Category Code" = FILTER('M001|T001|D001|H001');
                    filter(Posting_Date; "Posting Date")
                    {
                    }
                    column(Sum_Quantity_Base; "Quantity (Base)")
                    {
                        ColumnFilter = Sum_Quantity_Base = FILTER(<> 0);
                        Method = Sum;
                    }
                    /* column(Sum_Tax_Base_Amount; "Tax Base Amount")
                     {
                         Method = Sum;
                     }*/ // 16767
                }
            }
        }
    }
}

