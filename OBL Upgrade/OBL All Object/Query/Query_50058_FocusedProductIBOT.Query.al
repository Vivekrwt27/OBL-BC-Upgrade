query 50058 "Focused Product IBOT"
{

    elements
    {
        dataitem(Item; 27)
        {
            DataItemTableFilter = NPD = FILTER(<> 'XYZ Rest of SKU');
            column(Product_Code; "No.")
            {
            }
            column(FG_Item_name; "Complete Description")
            {
            }
            column(NPD; NPD)
            {
            }
            column(Size_Code_Desc; "Size Code Desc.")
            {
            }
            dataitem(Sales_Invoice_Line; 113)
            {
                DataItemLink = "No." = Item."No.";
                DataItemTableFilter = Type = FILTER(Item),
"Posting Date" = FILTER(>= '04-01-20');
                column(Posting_Date; "Posting Date")
                {
                }
                column(CP_code; "Sell-to Customer No.")
                {
                }
                column(Qty_sqmt; "Quantity (Base)")
                {
                }
                dataitem(Customer; 18)
                {
                    DataItemLink = "No." = Sales_Invoice_Line."Sell-to Customer No.";
                    column(CP_Name; Name)
                    {
                    }
                    column(Sales_Terretory; "Area Code")
                    {
                    }
                    column(Salesperson_Code; "Salesperson Code")
                    {
                    }
                    column(PCH_Code; "PCH Code")
                    {
                    }
                    column(Zonal_Manager; "Zonal Manager")
                    {
                    }
                    column(Zonal_Head; "Zonal Head")
                    {
                    }
                    dataitem(Salesperson_Purchaser; 13)
                    {
                        DataItemLink = Code = Customer."Salesperson Code";
                        column(SP_code; "Code")
                        {
                        }
                        column(Saples_person_name; Name)
                        {
                        }
                    }
                }
            }
        }
    }
}

