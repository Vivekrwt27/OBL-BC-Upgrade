pageextension 50419 pageextension50419 extends "Customer Ledger Entries"
{
    layout
    {
        modify("Credit Amount")
        {
            Visible = true;
        }
        modify("Debit Amount")
        {
            Visible = true;
        }
        moveafter("Posting Date"; "Sales (LCY)", "Debit Amount", "Credit Amount")

        addafter("Document No.")
        {
            field("Inv. Discount (LCY)"; Rec."Inv. Discount (LCY)")
            {
                ApplicationArea = All;
            }
            field("Sales Territory"; Rec."Sales Territory")
            {
                ApplicationArea = all;
            }
            field("Cheque Date"; Rec."Cheque Date")
            {
                ApplicationArea = all;
            }
            field("Cheque No."; Rec."Cheque No.")
            {
                ApplicationArea = all;
            }

            field("Pmt. Disc. Given (LCY)"; Rec."Pmt. Disc. Given (LCY)")
            {
                ApplicationArea = All;
            }
            /*   field("Document Date"; Rec."Document Date")
              {
                  ApplicationArea = All;
              } */

        }
        moveafter("Document No."; "External Document No.")
        moveafter(Description; "Remaining Amt. (LCY)", "Due Date", "Original Amt. (LCY)", "Credit Amount", "Debit Amount", "Original Amount", "Reversed by Entry No.")
    }
    actions
    {


    }
}

