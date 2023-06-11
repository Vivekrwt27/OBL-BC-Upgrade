query 50066 "TMS Sales Order for Order Rele"
{

    elements
    {
        dataitem(Sales_Header; 36)
        {
            DataItemTableFilter = "Document Type" = FILTER('Order'),
"Location Code" = FILTER('SKD-WH-MFG|DRA-WH-MFG|HSK-WH-MFG|SKD-SAMPLE|SKD-STORE|DRA-STORE|HSK-STORE|DRA-SAMPLE|HSK-SAMPLE'),
"Sell-to Customer No." = FILTER(<> '');
            filter(SaleOrderFilter; "No.")
            {
            }
            column(SO_Number; "No.")
            {
            }
            column(SO_Date_n_time; "Make Order Date")
            {
            }
            column(Buyer_Name; "Bill-to Name")
            {
            }
            column(Ship_to_City; "Ship-to City")
            {
            }
            column(From_Plant_Name; "Location Code")
            {
            }
            column(Total_Load_Kg; "Gross Wt.")
            {
            }
            column(Status; Status)
            {
            }
            column(Loading_officer; "Loading Inspector")
            {
            }
            column(Transport_method; "Shipping Agent Code")
            {
            }
            column(Releasing_date; "Releasing Date")
            {
            }
            dataitem(Sales_Line; 37)
            {
                DataItemLink = "Document No." = Sales_Header."No.";
                column(Quantity_Sqmt; "Quantity (Base)")
                {
                    Method = Sum;
                }
                column(Outstanding_Quantity; "Outstanding Qty. (Base)")
                {
                    Method = Sum;
                }
                column(Shipped_Load_kg; "Shipped Gross Weight")
                {
                    Method = Sum;
                }
                column(Balance_Load_KG; "Outstanding Gross Weight")
                {
                    Method = Sum;
                }
                column(Sum_Quantity_Invoiced; "Quantity Invoiced")
                {
                    Method = Sum;
                }
                dataitem(Location; 14)
                {
                    DataItemLink = Code = Sales_Header."Location Code";
                    column(From_Plant_City; City)
                    {
                    }
                    dataitem(Customer; 18)
                    {
                        DataItemLink = "No." = Sales_Header."Sell-to Customer No.";
                        column(Sales_Officer_no; "Sales Per Mob")
                        {
                        }
                        column(Sales_officer_Name; "Salesperson Description")
                        {
                        }
                        column(Customer_Type; "Customer Type")
                        {
                        }
                        dataitem(State; 18547)
                        {
                            DataItemLink = Code = Sales_Header."GST Ship-to State Code";
                            column("Code"; "Code")
                            {
                            }
                            column(Ship_to_State; Description)
                            {
                            }
                        }
                    }
                }
            }
        }
    }
}

