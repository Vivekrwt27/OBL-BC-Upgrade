query 50076 "Item Detail Size IBOT"
{

    elements
    {
        dataitem(Item_Details___IBOT; 50094)
        {
            DataItemTableFilter = "Location Code" = FILTER('HSK-WH-MFG|SKD-WH-MFG|DRA-WH-MFG|DP-MORBI');
            column(Size_Code_Desc; "Size Code Desc.")
            {
            }
            column(Tableau_Product_Group; "Tableau Product Group")
            {
            }
            column(Sum_Inventory; Inventory)
            {
                Method = Sum;
            }
            column(Manufacturer_Name; "Manufacturer Name")
            {
            }
        }
    }
}

