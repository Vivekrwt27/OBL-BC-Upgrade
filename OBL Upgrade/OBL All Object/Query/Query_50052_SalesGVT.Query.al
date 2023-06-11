query 50052 "Sales GVT"
{
    OrderBy = Ascending(Posting_Date), Ascending(No);

    elements
    {
        dataitem(Sales_Invoice_Line; 113)
        {
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
            filter(OrderNoFilter; "Order No.")
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
            dataitem(Item; 27)
            {
                DataItemLink = "No." = Sales_Invoice_Line."No.";
                DataItemTableFilter = "Tableau Product Group" = FILTER('GVT');
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

