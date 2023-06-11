query 50027 "Sales Invoiced Details"
{

    elements
    {
        dataitem(Sales_Invoice_Header; 112)
        {
            filter(OrderDateFilter; "Order Date")
            {
            }
            filter(ReleasingDateFilter; "Releasing Date")
            {
            }
            filter(PostingDateFilter; "Posting Date")
            {
            }
            column(Sell_to_Customer_No; "Sell-to Customer No.")
            {
            }
            column(Order_Date; "Order Date")
            {
            }
            column(Releasing_Date; "Releasing Date")
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(OrderProcessingDate; "Payment Date 3")
            {
            }
            column(Make_Order_Date; "Make Order Date")
            {
            }
            dataitem(Customer; 18)
            {
                DataItemLink = "No." = Sales_Invoice_Header."Sell-to Customer No.";
                column(Name; Name)
                {
                }
                column(Area_Code; "Area Code")
                {
                }
                column(Tableau_Zone; "Tableau Zone")
                {
                }
                column(PCH_Code; "PCH Code")
                {
                }
                column(Salesperson_Code; "Salesperson Code")
                {
                }
                filter(Customer_Type; "Customer Type")
                {
                    ColumnFilter = Customer_Type = FILTER('CKA | DIRECTPROJ');
                }
                dataitem(Sales_Invoice_Line; 113)
                {
                    DataItemLink = "Document No." = Sales_Invoice_Header."No.";
                    DataItemTableFilter = Type = CONST(Item),
Quantity = FILTER(<> 0);
                    column(Sum_Quantity; Quantity)
                    {
                        Method = Sum;
                    }
                    column(Sum_Quantity_Base; "Quantity (Base)")
                    {
                        Method = Sum;
                    }
                    /*column(Sum_Tax_Base_Amount; "Tax Base Amount")
                    {
                        Method = Sum;
                    }*/ //16767
                    filter(Item_Category_Code; "Item Category Code")
                    {
                    }
                    dataitem(Item; 27)
                    {
                        DataItemLink = "No." = Sales_Invoice_Line."No.";
                        filter(TabProdGrpFilter; "Tableau Product Group")
                        {
                        }
                        column(Tableau_Product_Group; "Tableau Product Group")
                        {
                        }
                    }
                }
            }
        }
    }
}

