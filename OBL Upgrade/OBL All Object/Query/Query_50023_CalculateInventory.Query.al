query 50023 "Calculate Inventory"
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
            filter(Item_Category_Code; "Item Category Code")
            {
            }
            dataitem(Item_Ledger_Entry; 32)
            {
                DataItemLink = "Item No." = Item."No.";
                column(Sum_Quantity; Quantity)
                {
                    Method = Sum;
                }
                column(Location_Code; "Location Code")
                {
                }
                filter(Posting_Date; "Posting Date")
                {
                }
                filter(LocationFilter; "Location Code")
                {
                }
            }
        }
    }
}

