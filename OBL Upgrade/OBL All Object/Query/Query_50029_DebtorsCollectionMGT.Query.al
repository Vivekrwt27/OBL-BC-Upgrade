query 50029 "Debtors Collection MGT"
{
    OrderBy = Ascending(Tableau_Zone), Ascending(Area_Code);

    elements
    {
        dataitem(Customer; 18)
        {
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
                DataItemTableFilter = "Entry Skipped" = FILTER(false);
                filter(PostDateFilter; "Posting Date")
                {
                }
                filter(DueDateFilter; "Due Date")
                {
                }
                filter(Document_Type; "Document Type")
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

