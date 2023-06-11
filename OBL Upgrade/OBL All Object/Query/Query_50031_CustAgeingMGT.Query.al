query 50031 "Cust. Ageing MGT"
{

    elements
    {
        dataitem(Customer; 18)
        {
            SqlJoinType = FullOuterJoin;
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Area_Code; "Area Code")
            {
            }
            column(Customer_Type; "Customer Type")
            {
            }
            filter(Zonal_Head; "Zonal Head")
            {
            }
            filter(Zonal_Manager; "Zonal Manager")
            {
            }
            filter(PCH_Code; "PCH Code")
            {
            }
            filter(Salesperson_Code; "Salesperson Code")
            {
            }
            column(Balance; Balance)
            {
            }
            dataitem(Cust__Ledger_Entry; 21)
            {
                DataItemLink = "Customer No." = Customer."No.";
                filter(PostDateFilter; "Posting Date")
                {
                }
                column(Due_Date; "Due Date")
                {
                }
                filter(Document_Type; "Document Type")
                {
                }
                column(Not_Enclude_CFORM; "Not Enclude CFORM")
                {
                }
                column(Posting_Date; "Posting Date")
                {
                }
                column(Sum_Amount; Amount)
                {
                    Method = Sum;
                }
                column(Sum_Amount_LCY; "Amount (LCY)")
                {
                    Method = Sum;
                }
                column(Sum_Remaining_Amt_LCY; "Remaining Amt. (LCY)")
                {
                    Method = Sum;
                }
            }
        }
    }
}

