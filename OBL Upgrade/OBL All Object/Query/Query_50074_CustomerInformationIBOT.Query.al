query 50074 "Customer Information IBOT"
{

    elements
    {
        dataitem(Customer; 18)
        {
            DataItemTableFilter = "Customer Type" = FILTER('<>COCO&<>MISC.&<>MGMT&<>LEGAL');
            column(Cust_code; "No.")
            {
            }
            column(Cust_name; Name)
            {
            }
            column(DSO; "DSO IBOT")
            {
            }
            column(Over_due; "OverDue Amt IBOT")
            {
            }
            column(Outstanding; "Outstanding IBOT")
            {
            }
            column(MTD_Collection; "MTD Collection IBOT")
            {
            }
            column(PYTD_Sales; "PYTD Sale IBOT")
            {
            }
            column(YTD_Sales; "YTD Sale IBOT")
            {
            }
            column(Available_Credit_Limited; "Available Credit Limit IBOT")
            {
            }
            column(Customer_Target; "Minmum Amt pur value")
            {
            }
            column(MTD_Sales; "MTD Sales IBOT")
            {
            }
            column(Balance_Confirmation_Date; "Balance Conf Recd Date")
            {
            }
            column(QTD_Sales; "QTD Sales IBOT")
            {
            }
            column(Last_Billing_Date; "Last Billing Date")
            {
            }
            column(SP_ID; "Salesperson Code")
            {
            }
            column(Sales_territory; "Area Code")
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
            dataitem(C_form; 50061)
            {
                DataItemLink = "Customer No." = Customer."No.";
                column(C_Form_Pending_Amt; "C-Form Pending Amt")
                {
                    Method = Sum;
                }
            }
        }
    }
}

