query 50093 "No. of CP Billed"
{

    elements
    {
        dataitem(Sales_Invoice_Header; 112)
        {
            filter(PostingDateFilter; "Posting Date")
            {
            }
            filter(CustCodeFilter; "Sell-to Customer No.")
            {
            }
            filter(LocationCodeFilter; "Location Code")
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
                    Method = Sum;
                }
                column(Sum_Line_Amount; "Line Amount")
                {
                    Method = Sum;
                }
                /*column(Sum_Amount_To_Customer; "Amount To Customer")
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
                        filter(CustomerTypeFilter; "Customer Type")
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
                        column(Post_Code; "Post Code")
                        {
                        }
                        column(Salesperson_Code; "Salesperson Code")
                        {
                        }
                        column(NoOfCP)
                        {
                            Method = Count;
                        }
                    }
                }
            }
        }
    }
}

