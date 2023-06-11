tableextension 50055 tableextension50055 extends "GST Posting Setup"
{
    fields
    {
        modify("State Code")
        {
            Caption = 'State Code';
        }
        /*  modify("GST Component Code")
          {
              Caption = 'GST Component Code';
          }*/ // 15578
        modify("Receivable Account")
        {
            Caption = 'Receivable Account';
        }
        modify("Payable Account")
        {
            Caption = 'Payable Account';
        }
        modify("Receivable Account (Interim)")
        {
            Caption = 'Receivable Account (Interim)';
        }
        modify("Payables Account (Interim)")
        {
            Caption = 'Payables Account (Interim)';
        }
        modify("Expense Account")
        {
            Caption = 'Expense Account';
        }
        modify("Refund Account")
        {
            Caption = 'Refund Account';
        }
        modify("Receivable Acc. Interim (Dist)")
        {
            Caption = 'Receivable Acc. Interim (Dist)';
        }
        modify("Receivable Acc. (Dist)")
        {
            Caption = 'Receivable Acc. (Dist)';
        }
    }
}

