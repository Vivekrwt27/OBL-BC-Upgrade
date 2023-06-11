pageextension 50273 pageextension50273 extends "Detailed Cust. Ledg. Entries"
{
    layout
    {
        addafter("Entry No.")
        {
            field("Transaction No."; Rec."Transaction No.")
            {
                ApplicationArea = All;
            }
            field("Applied Cust. Ledger Entry No."; Rec."Applied Cust. Ledger Entry No.")
            {
                ApplicationArea = All;
            }
        }
    }
}

