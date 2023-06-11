query 50050 "Debtors Collection MGT 1"
{
    OrderBy = Ascending(Tableau_Zone), Ascending(Area_Code);

    elements
    {
        dataitem(Customer; 18)
        {
            filter(AreaFilter; "Area Code")
            {
            }
            filter(CustFilter; "No.")
            {
            }
            column(Area_Code; "Area Code")
            {
            }
            column(Customer_Type; "Customer Type")
            {
            }
            column(Tableau_Zone; "Tableau Zone")
            {
            }
            column(No; "No.")
            {
            }
            dataitem(Cust__Ledger_Entry; 21)
            {
                DataItemLink = "Customer No." = Customer."No.";
                filter(PostDateFilter; "Posting Date")
                {
                }
                filter(Document_Type; "Document Type")
                {
                }
                filter(OpenFilter; Open)
                {
                }
                filter(DueDate; "Due Date")
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
                column(Due_Date; "Due Date")
                {
                }
            }
        }
    }
}

