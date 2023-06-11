query 50080 "Transporter History IBOT"
{

    elements
    {
        dataitem(Sales_Invoice_Header; 112)
        {
            DataItemTableFilter = "Posting Date" = FILTER(> '04-01-20'),
"Location Code" = FILTER('HSK-WH-MFG|SKD-WH-MFG|DRA-WH-MFG|DP-MORBI'),
"Transporter Name" = FILTER(<> '');
            column(Sell_to_Customer_No; "Sell-to Customer No.")
            {
            }
            column(CP_Name; "Sell-to Customer Name")
            {
            }
            column(Sell_to_Address; "Sell-to Address")
            {
            }
            column(Sell_to_Address_2; "Sell-to Address 2")
            {
            }
            column(Sell_to_City; "Sell-to City")
            {
            }
            column(State_name; "State name")
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(No; "No.")
            {
            }
            column(Transporter_Name; "Transporter Name")
            {
            }
            column(Ship_to_City; "Ship-to City")
            {
            }
            dataitem(Sales_Invoice_Line; 113)
            {
                DataItemLink = "Document No." = Sales_Invoice_Header."No.";
                DataItemTableFilter = Type = FILTER(Item);
                column(Qty_Sqmt; "Quantity (Base)")
                {
                    Method = Sum;
                }
                column(Qty_crt; "Quantity in Cartons")
                {
                    Method = Sum;
                }
                column(Sum_Gross_Weight; "Gross Weight")
                {
                    Method = Sum;
                }
                dataitem(Shipping_Agent; 291)
                {
                    DataItemLink = Code = Sales_Invoice_Header."Shipping Agent Code";
                    DataItemTableFilter = "Block for IBOT" = FILTER('No');
                    column(Vehicle_Capacity; Tonnage)
                    {
                    }
                    dataitem(Location; 14)
                    {
                        DataItemLink = Code = Sales_Invoice_Header."Location Code";
                        column(Despatch_Location; "Location Name")
                        {
                        }
                    }
                }
            }
        }
    }
}

