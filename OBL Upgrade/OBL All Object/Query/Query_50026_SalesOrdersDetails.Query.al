query 50026 "Sales Orders Details"
{

    elements
    {
        dataitem(Sales_Header; 36)
        {
            DataItemTableFilter = "Document Type" = FILTER(Order);
            filter(OrderDateFilter; "Order Date")
            {
            }
            filter(StatusFilter; Status)
            {
            }
            filter(ReleasingDateFilter; "Releasing Date")
            {
            }
            filter(Document_Type; "Document Type")
            {
            }
            column(OrderNo; "No.")
            {
            }
            column(Sell_to_Customer_No; "Sell-to Customer No.")
            {
            }
            column(Make_Order_Date; "Make Order Date")
            {
            }
            column(OrderProcessDate; "Payment Date 3")
            {
            }
            column(Releasing_Date; "Releasing Date")
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(Status; Status)
            {
            }
            dataitem(Customer; 18)
            {
                DataItemLink = "No." = Sales_Header."Sell-to Customer No.";
                column(Name; Name)
                {
                }
                filter(AreaFilter; "Area Code")
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
                }
                dataitem(Sales_Line; 37)
                {
                    DataItemLink = "Document Type" = Sales_Header."Document Type",
"Document No." = Sales_Header."No.";
                    column(Sum_Quantity; Quantity)
                    {
                        Method = Sum;
                    }
                    column(Sum_Outstanding_Qty_Base; "Outstanding Qty. (Base)")
                    {
                        Method = Sum;
                    }
                    column(Sum_Quantity_Base; "Quantity (Base)")
                    {
                        Method = Sum;
                    }
                    column(Sum_Quantity_Invoiced; "Quantity Invoiced")
                    {
                        Method = Sum;
                    }
                    column(Sum_Amount; Amount)
                    {
                        Method = Sum;
                    }
                    column(Sum_Outstanding_Amount; "Outstanding Amount")
                    {
                        Method = Sum;
                    }
                    filter(Item_Category_Code; "Item Category Code")
                    {
                    }
                    dataitem(Item; 27)
                    {
                        DataItemLink = "No." = Sales_Line."No.";
                        filter(TabProdGrpFilter; "Tableau Product Group")
                        {
                        }
                        column(Tableau_Product_Group; "Tableau Product Group")
                        {
                        }
                        column(Size_Code_Desc; "Size Code Desc.")
                        {
                        }
                        column(NPD; NPD)
                        {
                        }
                        column(Type_Catogery_Code; "Type Catogery Code")
                        {
                        }
                        column(Type_Code; "Type Code")
                        {
                        }
                        column(Design_Code; "Design Code")
                        {
                        }
                    }
                }
            }
        }
    }
}

