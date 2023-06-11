query 50096 "Sales Order Archive"
{
    OrderBy = Ascending(Location_Code), Ascending(Sell_to_Customer_No), Ascending(ItemNo);

    elements
    {
        dataitem(Sales_Header_Archive; 5107)
        {
            SqlJoinType = LeftOuterJoin;
            filter(OrderDateFilter; "Order Date")
            {
            }
            filter(LocationFilter; "Location Code")
            {
            }
            filter(CustomerFilter; "Sell-to Customer No.")
            {
            }
            column(Sell_to_Customer_No; "Sell-to Customer No.")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(No; "No.")
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(Order_Date; "Order Date")
            {
            }
            column(Salesperson_Code; "Salesperson Code")
            {
            }
            column(Doc_No_Occurrence; "Doc. No. Occurrence")
            {
            }
            column(Max_Version_No; "Version No.")
            {
                Method = Max;
            }
            column(Despatch_Remarks; "Despatch Remarks")
            {
                ColumnFilter = Despatch_Remarks = FILTER('No Material|Material Not Traceable');
            }
            dataitem(Sales_Line_Archive; 5108)
            {
                DataItemLink = "Document Type" = Sales_Header_Archive."Document Type",
"Document No." = Sales_Header_Archive."No.",
"Version No." = Sales_Header_Archive."Version No.";
                column(Line_No; "Line No.")
                {
                }
                column(Type; Type)
                {
                }
                column(ItemNo; "No.")
                {
                }
                column(Outstanding_Quantity; "Outstanding Quantity")
                {
                }
                column(Outstanding_Qty_Base; "Outstanding Qty. (Base)")
                {
                    ColumnFilter = Outstanding_Qty_Base = FILTER(> 0);
                }
                dataitem(Item_Ledger_Entry; 32)
                {
                    DataItemLink = "Item No." = Sales_Line_Archive."No.",
"Location Code" = Sales_Line_Archive."Location Code";
                    SqlJoinType = FullOuterJoin;
                    column(Sum_Quantity; Quantity)
                    {
                        ColumnFilter = Sum_Quantity = FILTER(> 50);
                        Method = Sum;
                    }
                    column(Count_)
                    {
                        Method = Count;
                    }
                }
            }
        }
    }
}

