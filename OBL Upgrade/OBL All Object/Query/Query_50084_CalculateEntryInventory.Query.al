query 50084 "Calculate Entry Inventory"
{

    elements
    {
        dataitem(Item; 27)
        {
            DataItemTableFilter = "Item Category Code" = FILTER('M001|D001|H001'),
Blocked = FILTER(false),
"Quality Code" = FILTER(1),
"Manuf. Strategy" = FILTER('Make-to-Stock|MTO');
            column(No; "No.")
            {
            }
            column(Size_Code; "Size Code")
            {
            }
            column(Size_Code_Desc; "Size Code Desc.")
            {
            }
            filter(Inventory_Posting_Group; "Inventory Posting Group")
            {
            }
            column(Item_Category_Code; "Item Category Code")
            {
            }
            dataitem(Item_Ledger_Entry; 32)
            {
                DataItemLink = "Item No." = Item."No.";
                column(Entry_Type; "Entry Type")
                {
                }
                column(Sum_Quantity; Quantity)
                {
                    Method = Sum;
                }
                column(Mfg_Batch_No; "Mfg. Batch No.")
                {
                }
                filter(Location_Code; "Location Code")
                {
                }
                filter(Posting_Date; "Posting Date")
                {
                }
            }
        }
    }
}

