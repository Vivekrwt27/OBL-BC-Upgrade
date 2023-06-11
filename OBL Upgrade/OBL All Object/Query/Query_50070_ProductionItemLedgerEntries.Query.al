query 50070 "Production Item Ledger Entries"
{

    elements
    {
        dataitem(Location; 14)
        {
            column("Code"; "Code")
            {
            }
            column(Prod_Units; "Prod. Units")
            {
            }
            dataitem(Item_Ledger_Entry; 32)
            {
                DataItemLink = "Location Code" = Location.Code;
                DataItemTableFilter = "Entry Type" = FILTER(Output);
                column(Order_Type; "Order Type")
                {
                }
                column(Order_No; "Order No.")
                {
                }
                column(Order_Line_No; "Order Line No.")
                {
                }
                column(Global_Dimension_1_Code; "Global Dimension 1 Code")
                {
                }
                column(Global_Dimension_2_Code; "Global Dimension 2 Code")
                {
                }
                column(Dimension_Set_ID; "Dimension Set ID")
                {
                }
                column(Location_Code; "Location Code")
                {
                }
                column(Item_No; "Item No.")
                {
                }
                filter(Posting_Date; "Posting Date")
                {
                }
                column(Sum_Qty_in_Sq_Mt; "Qty in Sq.Mt.")
                {
                    Method = Sum;
                }
                column(Sum_Quantity; Quantity)
                {
                    Method = Sum;
                }
                dataitem(Production_Order; 5405)
                {
                    DataItemLink = "No." = Item_Ledger_Entry."Order No.";
                    DataItemTableFilter = Status = CONST(Released);
                    column(No; "No.")
                    {
                    }
                    dataitem(Item; 27)
                    {
                        DataItemLink = "No." = Item_Ledger_Entry."Item No.";
                        column(Size_Code; "Size Code")
                        {
                        }
                        column(Production_Group; "Production Group")
                        {
                        }
                    }
                }
            }
        }
    }
}

