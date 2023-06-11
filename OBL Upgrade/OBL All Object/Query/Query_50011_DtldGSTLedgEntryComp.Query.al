query 50011 "Dtld. GST Ledg. Entry Comp"
{

    elements
    {
        dataitem(Detailed_GST_Ledger_Entry; 18001)
        {
            DataItemTableFilter = "Entry Type" = CONST("Initial Entry");
            filter(Document_No; "Document No.")
            {
            }
            filter(Source_Type; "Source Type")
            {
            }
            filter(Document_Type; "Document Type")
            {
            }
            filter(Transaction_Type; "Transaction Type")
            {
            }
            filter(Document_Line_No; "Document Line No.")
            {
            }
            column(GST_Component_Code; "GST Component Code")
            {
            }
            column(Sum_GST_Amount; "GST Amount")
            {
                Method = Sum;
            }
            column(Sum_GST_Base_Amount; "GST Base Amount")
            {
                Method = Sum;
            }
            /*  column(Sum_Amount_to_Customer_Vendor; "Amount to Customer/Vendor")
              {
                  Method = Sum;
              }*/ // 16767
        }
    }
}

