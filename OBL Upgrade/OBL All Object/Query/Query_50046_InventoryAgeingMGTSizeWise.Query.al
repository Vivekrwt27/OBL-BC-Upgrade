query 50046 "Inventory Ageing MGT Size Wise"
{
    OrderBy = Ascending(Location_Code), Ascending(Tableau_Product_Group), Ascending(Size_Code), Ascending(No);

    elements
    {
        dataitem(Item; 27)
        {
            DataItemTableFilter = "Item Category Code" = FILTER('M001|D001|T001|H001');
            column(No; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Item_Category_Code; "Item Category Code")
            {
            }
            column(Tableau_Product_Group; "Tableau Product Group")
            {
            }
            column(Size_Code; "Size Code")
            {
            }
            column(Size_Code_Desc; "Size Code Desc.")
            {
            }
            dataitem(Item_Ledger_Entry; 32)
            {
                DataItemLink = "Item No." = Item."No.";
                column(Location_Code; "Location Code")
                {
                }
                filter(Posting_Date; "Posting Date")
                {
                }
                column(Sum_Quantity; Quantity)
                {
                    Method = Sum;
                }
                column(Sum_Remaining_Quantity; "Remaining Quantity")
                {
                    Method = Sum;
                }
            }
        }
    }
}

