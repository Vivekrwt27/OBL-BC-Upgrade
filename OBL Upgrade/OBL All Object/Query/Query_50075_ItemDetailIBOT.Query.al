query 50075 "Item Detail IBOT"
{

    elements
    {
        dataitem(Item_Details___IBOT; 50094)
        {
            DataItemTableFilter = "Location Code" = FILTER('HSK-WH-MFG|SKD-WH-MFG|DRA-WH-MFG|DP-MORBI');
            column(Item_code; "Item No.")
            {
            }
            column(Size_Code_Desc; "Size Code Desc.")
            {
            }
            column(Design_Code_Desc; "Design Code Desc.")
            {
            }
            column(Item_Name; Description)
            {
            }
            column(Inventory_In_SQMT; "Inventory In Hand")
            {
            }
            column(Sales_price; "Last Sales Price")
            {
            }
            column(Discount; Discount)
            {
            }
            column(Wight_Per_carton; "Weight Per Carton")
            {
            }
            column(Coverage_Area; Conversion)
            {
            }
            column(Manufacturing_plant; "Manufacturer Name")
            {
            }
            column(NPD; NPD)
            {
            }
            column(Product_Group; "Tableau Product Group")
            {
            }
            column(Quality_Code; "Quality Code")
            {
            }
            column(Gross_Weight_SQMT; "Gross Weight")
            {
            }
            column(Liquidaton; Liquidaton)
            {
            }
            /*dataitem(Product_Wise_Item_Images_IBOT; 50102)
            {
                DataItemLink = "Item Code" = Item_Details_IBOT."Item No.";
                column(Product_Image; "Product Image")
                {
                }
                column(Product_Information; "Product Information")
                {
                }
                dataitem(Location; 14)
                {
                    DataItemLink = Code = Item_Details_IBOT."Location Code";
                    DataItemTableFilter = "Tableau Location" = FILTER(true);
                    column(Despatch_Name; "Location Name")
                    {
                    }
                    dataitem(Item; 27)
                    {
                        DataItemLink = "No." = Item_Details_IBOT."Item No.";
                        column(Full_name; "Complete Description")
                        {
                        }
                    }
                }
            }*/
        }
    }
}

