query 50024 "Calculate Summary Inventory"
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
            column(Quality_Code; "Quality Code")
            {
            }
            column(Manuf_Strategy; "Manuf. Strategy")
            {
            }
            column(Item_Category_Code; "Item Category Code")
            {
                ColumnFilter = Item_Category_Code = FILTER('M001 | T001 | D001 | H001 | SAMPLE');
            }
            dataitem(Item_Ledger_Entry; 32)
            {
                DataItemLink = "Item No." = Item."No.";
                column(Sum_Quantity; Quantity)
                {
                    ColumnFilter = Sum_Quantity = FILTER(<> 0);
                    Method = Sum;
                }
                column(Location_Code; "Location Code")
                {
                }
                column(Sum_Remaining_Quantity; "Remaining Quantity")
                {
                    Method = Sum;
                }
                filter(Posting_Date; "Posting Date")
                {
                }
            }
        }
    }
}

