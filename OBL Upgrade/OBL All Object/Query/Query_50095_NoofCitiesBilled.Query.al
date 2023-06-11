query 50095 "No. of Cities Billed"
{
    OrderBy = Ascending(Post_Code);

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
Quantity = FILTER(<> false),
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
                        filter(Zonal_Manager; "Zonal Manager")
                        {
                        }
                        filter(Zonal_Head; "Zonal Head")
                        {
                        }
                        filter(Salesperson_Code; "Salesperson Code")
                        {
                        }
                        column(Post_Code; "Post Code")
                        {
                        }
                        column(NoofCities)
                        {
                            Method = Count;
                        }
                    }
                }
            }
        }
    }
}

