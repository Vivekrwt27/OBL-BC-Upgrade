query 50055 SumForGstBaseAmt
{

    elements
    {
        dataitem(Detailed_GST_Ledger_Entry; 18001)
        {
            DataItemTableFilter = "GST Component Code" = FILTER('CGST|IGST');
            filter(Posting_Date; "Posting Date")
            {
            }
            filter(Entry_Type; "Entry Type")
            {
                ColumnFilter = Entry_Type = FILTER(Application);
            }
            filter(Transaction_Type; "Transaction Type")
            {
                ColumnFilter = Transaction_Type = FILTER(Sales);
            }
            /*filter(Original_Doc_No; "Original Doc. No.")
            {
            }*/ //16767
            filter(Document_Type; "Document Type")
            {
                ColumnFilter = Document_Type = FILTER(Payment | Invoice);
            }
            column(Document_No; "Document No.")
            {
            }
            column(Sum_GST_Base_Amount; "GST Base Amount")
            {
                Method = Sum;
            }
            column(Sum_GST; "GST %")
            {
                Method = Sum;
            }
            column(GST_Component_Code; "GST Component Code")
            {
            }
        }
    }
}

