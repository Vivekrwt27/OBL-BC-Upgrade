query 50078 "Item Detail Item Name IBOT"
{

    elements
    {
        dataitem(Item_Details___IBOT; 50094)
        {
            DataItemTableFilter = "Location Code" = FILTER('HSK-WH-MFG|SKD-WH-MFG|DRA-WH-MFG|DP-MORBI');
            column(Item_No; "Item No.")
            {
            }
            column(Item_name; Description)
            {
            }
            column(NPD; NPD)
            {
            }
            column(Tableau_Product_Group; "Tableau Product Group")
            {
            }
            column(Sum_Inventory; Inventory)
            {
                Method = Sum;
            }
        }
    }
}

