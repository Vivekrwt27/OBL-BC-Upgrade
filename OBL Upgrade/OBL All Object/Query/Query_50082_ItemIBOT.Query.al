query 50082 "Item IBOT"
{

    elements
    {
        dataitem(Item; 27)
        {
            DataItemTableFilter = Blocked = FILTER('No'),
"Item Category Code" = FILTER('H001|D001|T001|M001');
            column(Product_code; "No.")
            {
            }
            column(Complete_Description; "Complete Description")
            {
            }
            column(Size_Code_Desc; "Size Code Desc.")
            {
            }
            column(Hide_Items; "Hide Items")
            {
            }
            column(NPD; NPD)
            {
            }
            column(Product_Group; "Tableau Product Group")
            {
            }
            column(Item_Category_Code; "Item Category Code")
            {
            }
        }
    }
}

