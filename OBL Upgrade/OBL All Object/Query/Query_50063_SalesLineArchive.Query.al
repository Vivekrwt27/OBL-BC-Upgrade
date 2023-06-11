query 50063 "Sales Line Archive"
{

    elements
    {
        dataitem(Sales_Header_Archive; 5107)
        {
            DataItemTableFilter = "Document Type" = FILTER('Order');
            filter(Date_filter; "Date Archived")
            {
            }
            column(Date_Archived; "Date Archived")
            {
            }
            column(State; State)
            {
            }
            column(Customer_Type; "Customer Type")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(Sell_to_City; "Sell-to City")
            {
            }
            column(Archived_By; "Archived By")
            {
            }
            column(Reason_Code; "Reason Code")
            {
            }
            column(Order_Booked_Date; "Order Booked Date")
            {
            }
            column(Despatch_Remarks; "Despatch Remarks")
            {
            }
            dataitem(Sales_Line_Archive; 5108)
            {
                DataItemLink = "Document No." = Sales_Header_Archive."No.";
                DataItemTableFilter = /* "Outstanding Qty.(Base)" = FILTER(<> '0'),16767 */
"Item Category Code" = FILTER(<> 'SAMPLE');
                column(Document_Type; "Document Type")
                {
                }
                column(Status; Status)
                {
                }
                column(Cust_Type; "Cust Type")
                {
                }
                column(Sell_to_Customer_No; "Sell-to Customer No.")
                {
                }
                column(Release_Date; "Release Date")
                {
                }
                column(Release_Time; "Release Time")
                {
                }
                column(Arch_Date; "Arch Date")
                {
                }
                column(Arch_Time; "Arch Time")
                {
                }
                column(Document_No; "Document No.")
                {
                }
                column(Line_No; "Line No.")
                {
                }
                column(Type; Type)
                {
                }
                column(No; "No.")
                {
                }
                column(Location_Code; "Location Code")
                {
                }
                column(Price_Group_Code; "Price Group Code")
                {
                }
                column(Posting_Group; "Posting Group")
                {
                }
                column(Description; Description)
                {
                }
                column(Description_2; "Description 2")
                {
                }
                column(Qty_per_Unit_of_Measure; "Qty. per Unit of Measure")
                {
                }
                column(Unit_of_Measure; "Unit of Measure")
                {
                }
                column(Quantity_in_Cartons; "Quantity in Cartons")
                {
                }
                column(Quantity_Base; "Quantity (Base)")
                {
                }
                column(Quantity_Shipped; "Quantity Shipped")
                {
                }
                column(Qty_Shipped_Base; "Qty. Shipped (Base)")
                {
                }
                column(Quantity_Invoiced; "Quantity Invoiced")
                {
                }
                column(Qty_Invoiced_Base; "Qty. Invoiced (Base)")
                {
                }
                column(Outstanding_Quantity; "Outstanding Quantity")
                {
                }
                column(Outstanding_Qty_Base; "Outstanding Qty. (Base)")
                {
                }
                column(Line_Amount; "Line Amount")
                {
                }
                /*column(Amount_To_Customer; "Amount To Customer")
                {
                }*/
                column(Outstanding_Amount; "Outstanding Amount")
                {
                }
                column(Gen_Prod_Posting_Group; "Gen. Prod. Posting Group")
                {
                }
                column(MRP_Price; "MRP Price")
                {
                }
                column(Buyer_s_Price; "Buyer's Price")
                {
                }
                column(Item_Category_Code; "Item Category Code")
                {
                }
                column(Completely_Shipped; "Completely Shipped")
                {
                }
                column(Shipping_Agent_Code; "Shipping Agent Code")
                {
                }
                /* column(Source_Document_Type; "Source Document Type")
                 {
                 }*/ //16767
                column(Type_Code; "Type Code")
                {
                }
                column(Plant_Code; "Plant Code")
                {
                }
                column(Size_Code; "Size Code")
                {
                }
                column(Quality_Code; "Quality Code")
                {
                }
                column(Gross_Weight; "Gross Weight")
                {
                }
                column(Net_Weight; "Net Weight")
                {
                }
            }
        }
    }
}

