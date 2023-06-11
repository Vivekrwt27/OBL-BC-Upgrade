query 50033 "Item Group Master"
{

    elements
    {
        dataitem(Item; 27)
        {
            DataItemTableFilter = "Item Category Code" = FILTER('M001|T001|H001|D001'),
"Tableau Product Group" = FILTER(<> '');
            column(Tableau_Product_Group; "Tableau Product Group")
            {
            }
            column(Size_Code; "Size Code")
            {
            }
            column(Item_Category_Code; "Item Category Code")
            {
            }
            dataitem(Dimension_Value; 349)
            {
                DataItemLink = Code = Item."Size Code";
                DataItemTableFilter = "Dimension Code" = CONST('SIZE');
                column(Name; Name)
                {
                }
                column(Count_)
                {
                    Method = Count;
                }
            }
        }
    }
}

