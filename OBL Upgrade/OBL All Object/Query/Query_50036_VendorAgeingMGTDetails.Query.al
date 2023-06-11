query 50036 "Vendor Ageing MGT Details"
{

    elements
    {
        dataitem(Vendor; 23)
        {
            SqlJoinType = FullOuterJoin;
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            filter(Purchaser_Code; "Purchaser Code")
            {
            }
            column(Balance; Balance)
            {
            }
            dataitem(Vendor_Ledger_Entry; 25)
            {
                DataItemLink = "Vendor No." = Vendor."No.";
                filter(PostDateFilter; "Posting Date")
                {
                }
                column(Document_No; "Document No.")
                {
                }
                column(Due_Date; "Due Date")
                {
                }
                filter(Document_Type; "Document Type")
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

