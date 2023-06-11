query 50068 "TMS Sales_order"
{

    elements
    {
        dataitem(TMS_Data; 50111)
        {
            column(SO_Number; "Sales Order No.")
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
            column(From_Plant_Name; "From Plant Name")
            {
            }
            column(Total_Load_Kg; "Total Load(KG)")
            {
            }
            column(Status; Status)
            {
            }
            column(Loading_officer; "Loading Officer")
            {
            }
            column(Transport_Method; "Transport Method")
            {
            }
            column(Releasing_Date; "Releasing Date")
            {
            }
            column(Quantity_in_SqMt; "Quantity in SqMt.")
            {
            }
            column(Outstanding_Quantity; "Outstanding Qty.")
            {
            }
            column(Shipped_Load_kg; "Gross Wt. Shipped")
            {
            }
            column(Balance_Load_KG; "Gross Wt. Outstanding")
            {
            }
            column(Sum_Quantity_Invoiced; "Quantity Invoiced")
            {
            }
            column(Sales_Officer_no; "Sales Person MobileNo.")
            {
            }
            column(Sales_officer_Name; "Sales Person Name")
            {
            }
            column(Customer_Type; "Customer Type")
            {
            }
            column("Code"; "State Code")
            {
            }
            column(Ship_to_State; "Ship to State Description")
            {
            }
            column(Closed; Closed)
            {
            }
            dataitem(Location; 14)
            {
                DataItemLink = Code = TMS_Data."From Plant Name";
                column(From_Plant_City; City)
                {
                }
            }
        }
    }
}

