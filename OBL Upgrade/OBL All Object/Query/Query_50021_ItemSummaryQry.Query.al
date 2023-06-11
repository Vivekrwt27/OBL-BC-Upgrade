query 50021 "Item Summary Qry"
{

    elements
    {
        dataitem(item; 27)
        {
            DataItemTableFilter = "Size Code" = FILTER(<> ''),
"Color Code" = FILTER(<> '');
            column(Size_Code; "Size Code")
            {
            }
            column(Color_Code; "Color Code")
            {
            }
            dataitem(Item_Ledger_Entry; 32)
            {
                DataItemLink = "Item No." = Item."No.";
                SqlJoinType = InnerJoin;
                DataItemTableFilter = "Entry Type" = FILTER(Output);
                column(Item_No; "Item No.")
                {
                }
                column(Posting_Date; "Posting Date")
                {
                }
                column(Location_Code; "Location Code")
                {
                }
                column(Sum_Quantity; Quantity)
                {
                    Method = Sum;
                }
            }
        }
    }
}

