query 50040 "Cust. Ledger"
{

    elements
    {
        dataitem(Cust__Ledger_Entry; 21)
        {
            filter(Customer_No_filter; "Customer No.")
            {
            }
            filter(Posting_Date; "Posting Date")
            {
            }
            filter(Document_Type; "Document Type")
            {
            }
            column(Entry_No; "Entry No.")
            {
            }
            column(Customer_No; "Customer No.")
            {
            }
            column(Amount; Amount)
            {
            }
            column(Remaining_Amount; "Remaining Amount")
            {
            }
            column(Amount_LCY; "Amount (LCY)")
            {
            }
            column(Remaining_Amt_LCY; "Remaining Amt. (LCY)")
            {
            }
            column(Original_Amt_LCY; "Original Amt. (LCY)")
            {
            }
            column(Open_CLE; Open)
            {
            }
            column(Entry_Skipped; "Entry Skipped")
            {
            }
            /*  dataitem(Detailed_Cust__Ledg__Entry; 379)
              {
                  DataItemLink = "Cust Ledger Entry No." = Cust_Ledger_Entry."Entry No.";
                  column(Det_Entry_Type; "Entry Type")
                  {
                  }
                  column(Det_Document_Type; "Document Type")
                  {
                  }
                  column(Det_Posting_Date; "Posting Date")
                  {
                  }
                  column(Sum_Amount_Det; Amount)
                  {
                  }
              }*/
        }
    }
}

