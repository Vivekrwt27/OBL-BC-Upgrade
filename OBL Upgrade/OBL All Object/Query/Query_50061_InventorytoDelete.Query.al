query 50061 "Inventory to Delete"
{

    elements
    {
        dataitem(Item_Ledger_Entry; 32)
        {
            DataItemTableFilter = "Remaining Quantity" = FILTER(-0.99 .. 0.99),
Open = FILTER('Yes');
            column(Item_No; "Item No.")
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(Remaining_Quantity; "Remaining Quantity")
            {
            }
            column(Entry_No; "Entry No.")
            {
            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
            }
            column(Dimension_Set_ID; "Dimension Set ID")
            {
            }
        }
    }
}

