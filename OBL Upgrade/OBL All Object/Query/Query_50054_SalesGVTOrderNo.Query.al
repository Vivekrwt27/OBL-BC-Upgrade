query 50054 "Sales GVT OrderNo."
{
    OrderBy = Ascending(OrderNo), Ascending(OrderDate);

    elements
    {
        dataitem(Sales_Invoice_Header; 112)
        {
            DataItemTableFilter = "Order No." = FILTER(<> '');
            column(OrderDate; "Order Date")
            {
                ColumnFilter = OrderDate = FILTER('04-01-19..30-04-19');
            }
            column(OrderNo; "Order No.")
            {
            }
            column(Set; BD)
            {
            }
            column(Get; GPS)
            {
            }
            column(Pet; CKA)
            {
            }
            dataitem(Sales_Invoice_Line; 113)
            {
                DataItemLink = "Document No." = Sales_Invoice_Header."No.";
                SqlJoinType = LeftOuterJoin;
                DataItemTableFilter = Type = FILTER(Item),
"Item Category Code" = FILTER('M001|D001|T001|H001'),
Quantity = FILTER(<> '0');
                filter(DocFilter; "Document No.")
                {
                }
                filter(CustFilter; "Sell-to Customer No.")
                {
                }
                filter(ItemFilter; "No.")
                {
                }
                filter(PostingDtFilter; "Posting Date")
                {
                }
                column(No; "No.")
                {
                }
                column(Amt; "Line Amount")
                {
                    Method = Sum;
                }
                column(Qty; "Quantity in Sq. Mt.")
                {
                    Method = Sum;
                }
                column(Posting_Date; "Posting Date")
                {
                }
                column(CustNo; "Sell-to Customer No.")
                {
                }
                dataitem(Item; 27)
                {
                    DataItemLink = "No." = Sales_Invoice_Line."No.";
                    DataItemTableFilter = "Tableau Product Group" = CONST('GVT');
                    filter(TableauFilter; "Tableau Product Group")
                    {
                    }
                    filter(NPDFilter; NPD)
                    {
                    }
                    column(Tableau_Product_Group; "Tableau Product Group")
                    {
                    }
                    column(ItemNo; "No.")
                    {
                    }
                    column(NPD; NPD)
                    {
                    }
                    dataitem(Customer; 18)
                    {
                        DataItemLink = "No." = Sales_Invoice_Line."Sell-to Customer No.";
                        column(PCH_Code; "PCH Code")
                        {
                        }
                        filter(PCHFilter; "PCH Code")
                        {
                        }
                        column(Tableau_Zone; "Tableau Zone")
                        {
                        }
                    }
                }
            }
        }
    }
}

