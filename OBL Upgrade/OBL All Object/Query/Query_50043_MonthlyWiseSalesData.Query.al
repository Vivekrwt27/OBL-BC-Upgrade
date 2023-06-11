query 50043 "MonthlyWise  Sales Data"
{

    elements
    {
        dataitem(Sales_Invoice_Header; 112)
        {
            filter(PostingDateFilter; "Posting Date")
            {
            }
            column(CustomerType; "Customer Type")
            {
            }
            dataitem(Sales_Invoice_Line; 113)
            {
                DataItemLink = "Document No." = Sales_Invoice_Header."No.";
                DataItemTableFilter = Type = FILTER(Item),
Quantity = FILTER(<> 0),
"Item Category Code" = FILTER('M001|T001|D001|H001');
                column(Sum_Quantity_Base; "Quantity (Base)")
                {
                    Method = Sum;
                }
                column(LineAmount; "Line Amount")
                {
                    Method = Sum;
                }
                /* column(AmountToCustomer; "Amount To Customer")
                 {
                     Method = Sum;
                 }*/ // 16767
                column(line_discount; "Line Discount Amount")
                {
                    Method = Sum;
                }
                column(Sum_Quantity_in_Sq_Mt; "Quantity in Sq. Mt.")
                {
                    Method = Sum;
                }
                dataitem(Item; 27)
                {
                    DataItemLink = "No." = Sales_Invoice_Line."No.";
                    column(SizeCodeDesc; "Size Code Desc.")
                    {
                    }
                    column(TypeCodeDesc; "Type Code Desc.")
                    {
                    }
                    column(TypeCatCodeDesc; "Item Category Code")
                    {
                        ColumnFilter = TypeCatCodeDesc = FILTER('M001|T001|D001|H001');
                    }
                    column(TabProdGrp; "Tableau Product Group")
                    {
                    }
                    column(TypeCatCode; "Type Catogery Code")
                    {
                    }
                    column(QualityCode; "Quality Code")
                    {
                    }
                    dataitem(Customer; 18)
                    {
                        DataItemLink = "No." = Sales_Invoice_Header."Sell-to Customer No.";
                        filter(AreaFilter; "Area Code")
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

