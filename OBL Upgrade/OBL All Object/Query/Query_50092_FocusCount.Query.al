query 50092 "Focus Count"
{

    elements
    {
        dataitem(Sales_Invoice_Header; 112)
        {
            filter(PostingDateFilter; "Posting Date")
            {
                ColumnFilter = PostingDateFilter = FILTER('01-04-21..30-04-21');
            }
            filter(CustCodeFilter; "Sell-to Customer No.")
            {
            }
            dataitem(Sales_Invoice_Line; 113)
            {
                DataItemLink = "Document No." = Sales_Invoice_Header."No.";
                DataItemTableFilter = Type = FILTER(Item),
Quantity = FILTER(<> 0),
"Item Category Code" = FILTER('M001|T001|D001|H001');
                column(Sum_Quantity; Quantity)
                {
                    Method = Sum;
                }
                column(Sum_Quantity_Base; "Quantity (Base)")
                {
                    ColumnFilter = Sum_Quantity_Base = FILTER(> 50);
                    Method = Sum;
                }
                column(Sum_Line_Amount; "Line Amount")
                {
                    Method = Sum;
                }
                /* column(Sum_Amount_To_Customer; "Amount To Customer")
                 {
                     Method = Sum;
                 }*/ //16767
                dataitem(Item; 27)
                {
                    DataItemLink = "No." = Sales_Invoice_Line."No.";
                    filter(TypeCatCodeDesc; "Item Category Code")
                    {
                    }
                    dataitem(Customer; 18)
                    {
                        DataItemLink = "No." = Sales_Invoice_Header."Sell-to Customer No.";
                        DataItemTableFilter = "Customer Type" = FILTER('DEALER|DISTIBUTER');
                        filter(CXOTieUp; "CXO Tie Up")
                        {
                        }
                        filter(AreaFilter; "Area Code")
                        {
                        }
                        filter(PCHFilter; "PCH Code")
                        {
                        }
                        filter(SalesPersonFilter; "Salesperson Code")
                        {
                        }
                        filter(TableauZoneFilter; "Tableau Zone")
                        {
                        }
                        column(Zonal_Manager; "Zonal Manager")
                        {
                        }
                        column(Zonal_Head; "Zonal Head")
                        {
                        }
                        column(No; "No.")
                        {
                        }
                        column(Salesperson_Code; "Salesperson Code")
                        {
                        }
                        dataitem(Item_Wise_Focused_Prod_; 50088)
                        {
                            DataItemLink = "Goal Sheet Focused Product" = Item."Goal Sheet Focused Product",
"Tableau Zone" = Customer."Tableau Zone";
                            column(Goal_Sheet_Focused_Product; "Goal Sheet Focused Product")
                            {
                                ColumnFilter = Goal_Sheet_Focused_Product = FILTER(<> '');
                            }
                        }
                    }
                }
            }
        }
    }
}

