query 50077 "Item Detail Location IBOT"
{

    elements
    {
        dataitem(Item_Details___IBOT; 50094)
        {
            DataItemTableFilter = "Location Code" = FILTER('HSK-WH-MFG|SKD-WH-MFG|DP-MORBI|DRA-WH-MFG'),
NPD = FILTER(<> 'XYZ Rest of SKU');
            column(Manufacturing_Location; "Manufacturer Name")
            {
            }
            column(Sum_Inventory; Inventory)
            {
                Method = Sum;
            }
        }
    }
}

