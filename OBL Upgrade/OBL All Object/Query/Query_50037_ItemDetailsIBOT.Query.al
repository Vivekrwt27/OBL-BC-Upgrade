query 50037 "Item Details - IBOT"
{

    elements
    {
        dataitem(Location; 14)
        {
            DataItemTableFilter = Blocked = CONST(false),
Code = FILTER('HSK-WH-MFG|SKD-WH-MFG|DRA-WH-MFG|DP-MORBI');
            filter(LocationFilter; "Code")
            {
            }
            column("Code"; "Code")
            {
            }
            dataitem(Item; 27)
            {
                SqlJoinType = CrossJoin;
                DataItemTableFilter = "Item Category Code" = FILTER('D001 | H001 | M001 | T001'),
"Plant Code" = FILTER(<> 'T'),
Blocked = FILTER(false),
Blocked2 = FILTER(false);
                column(No; "No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Complete_Description; "Complete Description")
                {
                }
                column(Inventory_Posting_Group; "Inventory Posting Group")
                {
                }
                column(Type_Code; "Type Code")
                {
                }
                column(Type_Catogery_Code; "Type Catogery Code")
                {
                }
                column(Gross_Weight; "Gross Weight")
                {
                }
                column(Net_Weight; "Net Weight")
                {
                }
                column(Size_Code; "Size Code")
                {
                }
                column(Design_Code; "Design Code")
                {
                }
                column(Color_Code; "Color Code")
                {
                }
                column(Packing_Code; "Packing Code")
                {
                }
                column(Quality_Code; "Quality Code")
                {
                }
                column(Plant_Code; "Plant Code")
                {
                }
                column(Item_Classification; "Item Classification")
                {
                }
                column(Type_Code_Desc; "Type Code Desc.")
                {
                }
                column(Type_Category_Code_Desc; "Type Category Code Desc.")
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
                column(Plant_Code_Desc; "Plant Code Desc.")
                {
                }
                column(Manufacturer_Name; "Manufacturer Name")
                {
                }
                column(Group_Code; "Group Code")
                {
                }
                column(Group_code_Desc; "Group code Desc")
                {
                }
                column(Tableau_Product_Group; "Tableau Product Group")
                {
                }
                column(Manuf_Strategy; "Manuf. Strategy")
                {
                }
                column(Default_Prod_Plant_Code; "Default Prod. Plant Code")
                {
                }
                column(NPD; NPD)
                {
                }
                column(ITC; "Item Category Code")
                {
                }
                column(Liquidaton; Liquidaton)
                {
                }
                dataitem(Item_Ledger_Entry; 32)
                {
                    DataItemLink = "Item No." = Item."No.",
"Location Code" = Location.Code;
                    column(Sum_Quantity; Quantity)
                    {
                        Method = Sum;
                    }
                    column(Sum_Qty_In_Carton; "Qty In Carton")
                    {
                        Method = Sum;
                    }
                    column(Sum_Reserved_Quantity; "Reserved Quantity")
                    {
                        Method = Sum;
                    }
                }
            }
        }
    }
}

