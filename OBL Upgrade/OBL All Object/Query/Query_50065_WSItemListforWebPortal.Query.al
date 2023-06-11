query 50065 "WS Item List for Web Portal"
{

    elements
    {
        dataitem(Item; 27)
        {
            DataItemTableFilter = "Item Category Code" = FILTER('T001|D001|M001|H001'),
"Quality Code" = FILTER('1');
            column(No; "No.")
            {
            }
            column(Size_Code_Desc; "Size Code Desc.")
            {
            }
            column(Design_Code_Desc; "Design Code Desc.")
            {
            }
            column(Color_Code_Desc; "Color Code Desc.")
            {
            }
            column(Packing_Code_Desc; "Packing Code Desc.")
            {
            }
            column(Quality_Code_Desc; "Quality Code Desc.")
            {
            }
            column(Gross_Weight; "Gross Weight")
            {
            }
            column(Net_Weight; "Net Weight")
            {
            }
            column(Blocked; Blocked)
            {
            }
            column(Item_Creation_Date; "Created Date")
            {
            }
            column(MRP; "N.R.V")
            {
            }
            column(List_Price; "Sales Price")
            {
            }
            column(Retained; Retained)
            {
            }
        }
    }
}

