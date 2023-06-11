query 50041 "Customer Sales Data IBOT"
{

    elements
    {
        dataitem(Customer; 18)
        {
            DataItemTableFilter = "Area Code" = FILTER(<> 'OBTB'),
"Customer Type" = FILTER('DEALER|DISTIBUTOR');
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(City; City)
            {
            }
            column(State_Desc; "State Desc.")
            {
            }
            column(Tableau_Zone; "Tableau Zone")
            {
            }
            column(Sales_terretory; "Area Code")
            {
            }
            column(Salesperson_ID; "Salesperson Code")
            {
            }
            column(Salesperson_Name; "Salesperson Description")
            {
            }
            column(PCH_Code; "PCH Code")
            {
            }
            column(Branch_Head_name; "PCH Name")
            {
            }
            column(Zonal_Manager; "Zonal Manager")
            {
            }
            column(Zonal_Head; "Zonal Head")
            {
            }
            column(Customer_Type; "Customer Type")
            {
            }
            dataitem(Sales_Invoice_Line; 113)
            {
                DataItemLink = "Sell-to Customer No." = Customer."No.";
                DataItemTableFilter = Type = FILTER(Item);
                column(Invoice_date; "Posting Date")
                {
                }
                column(Item_code; "No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Description_2; "Description 2")
                {
                }
                column(Qty_SQMT; "Quantity (Base)")
                {
                }
                /* column(Amount_To_Customer; "Amount To Customer")
                 {
                 }*/ // 16767
                column(Branch_Code; "Location Code")
                {
                }
                dataitem(Item; 27)
                {
                    DataItemLink = "No." = Sales_Invoice_Line."No.";
                    column(Item_category; "Tableau Product Group")
                    {
                    }
                    column(Type_Category_Desc; "Type Category Code Desc.")
                    {
                    }
                    column(Size_Code_Desc; "Size Code Desc.")
                    {
                    }
                    column(NPD; NPD)
                    {
                    }
                    dataitem(Location; 14)
                    {
                        DataItemLink = Code = Sales_Invoice_Line."Location Code";
                        column(Location_Name; "Location Name")
                        {
                        }
                        dataitem(zona1; 13)
                        {
                            DataItemLink = Code = Customer."Zonal Manager";
                            column(Zonal_manager_name; Name)
                            {
                            }
                            dataitem(Salesperson_Purchaser; 13)
                            {
                                DataItemLink = Code = Customer."Zonal Head";
                                column(Zonal_Head_name; Name)
                                {
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

