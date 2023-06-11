query 50004 "WS Sales Data"
{

    elements
    {
        dataitem(Sales_Invoice_Header; 112)
        {
            column(Sell_to_Customer_No; "Sell-to Customer No.")
            {
            }
            column(No; "No.")
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(State; State)
            {
            }
            /*  column(Amount_to_Customer; "Amount to Customer")
              {
              }*/ // 16767
            column(Salesperson_Code; "Salesperson Code")
            {
            }
            column(Sq_Meter; "Sq. Meter")
            {
            }
            column(Sell_to_City; "Sell-to City")
            {
            }
            column(Sales_Territory; "Sales Territory")
            {
            }
            column(Customer_Type; "Customer Type")
            {
            }
            dataitem(Sales_Invoice_Line; 113)
            {
                DataItemLink = "Document No." = Sales_Invoice_Header."No.";
                DataItemTableFilter = Type = FILTER(Item);
                column(Item_no; "No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Description_2; "Description 2")
                {
                }
                column(Qty_Crt; Quantity)
                {
                }
                column(Unit_of_Measure; "Unit of Measure")
                {
                }
                column(Qty_sqmt; "Quantity (Base)")
                {
                }
                dataitem(Customer; 18)
                {
                    DataItemLink = "No." = Sales_Invoice_Header."Sell-to Customer No.";
                    column(Tableau_Zone; "Tableau Zone")
                    {
                    }
                    column(State_Desc; "State Desc.")
                    {
                    }
                    column(Phone_No; "Phone No.")
                    {
                    }
                    column(E_Mail; "E-Mail")
                    {
                    }
                    column(Contact_Name; Contact)
                    {
                    }
                    dataitem(Item; 27)
                    {
                        DataItemLink = "No." = Sales_Invoice_Line."No.";
                        column(Tableau_Product_Group; "Tableau Product Group")
                        {
                        }
                    }
                }
            }
        }
    }
}

