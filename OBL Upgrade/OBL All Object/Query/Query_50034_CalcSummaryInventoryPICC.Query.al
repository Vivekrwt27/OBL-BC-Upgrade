query 50034 "Calc. Summary Inventory PICC"
{

    elements
    {
        dataitem(Item; 27)
        {
            column(No; "No.")
            {
            }
            filter(Inventory_Posting_Group; "Inventory Posting Group")
            {
            }
            dataitem(Item_Ledger_Entry; 32)
            {
                DataItemLink = "Item No." = Item."No.";
                column(Item_Category_Code; "Item Category Code")
                {
                }
                column(Sum_Quantity; Quantity)
                {
                    ColumnFilter = Sum_Quantity = FILTER(<> 0);
                    Method = Sum;
                }
                column(Location_Code; "Location Code")
                {
                }
                filter(Posting_Date; "Posting Date")
                {
                }
            }
        }
    }
}

