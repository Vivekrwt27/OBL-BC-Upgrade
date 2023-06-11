query 50071 "Item Stock"
{

    elements
    {
        dataitem(Location; 14)
        {
            DataItemTableFilter = "Tableau Location" = CONST(true);
            column(Location_Name; "Location Name")
            {
            }
            dataitem(Item_Ledger_Entry; 32)
            {
                DataItemLink = "Location Code" = Location.Code;
                DataItemTableFilter = "Item Category Code" = FILTER('D001|M001|H001|T001'),
"Remaining Quantity" = FILTER(<> 0);
                column(Item_No; "Item No.")
                {
                }
                column(Location_Code; "Location Code")
                {
                }
                column(Sum_Remaining_Quantity; "Remaining Quantity")
                {
                    ColumnFilter = Sum_Remaining_Quantity = FILTER(<> 0);
                    Method = Sum;
                }
                column(Posting_Date; "Posting Date")
                {
                }
                dataitem(Item; 27)
                {
                    DataItemLink = "No." = Item_Ledger_Entry."Item No.";
                    column(Item_Description; Description)
                    {
                    }
                    column(Item_Description_2; "Description 2")
                    {
                    }
                    column(Goal_Sheet_Focused_Product; "Goal Sheet Focused Product")
                    {
                    }
                    column(Item_Category_Code; "Item Category Code")
                    {
                    }
                    column(MRP; "N.R.V")
                    {
                    }
                    column(List_Price; "Sales Price")
                    {
                    }
                    column(Gross_Weight; "Gross Weight")
                    {
                    }
                    column(Prem_Sale; Liquidaton)
                    {
                    }
                    column(Size_Code_Desc; "Size Code Desc.")
                    {
                    }
                    dataitem(Product_Wise_Item_Images_IBOT; 50102)
                    {
                        DataItemLink = "Item Code" = Item."No.";
                        column(Product_Image; "Product Image")
                        {
                        }
                    }
                }
            }
        }
    }
}

