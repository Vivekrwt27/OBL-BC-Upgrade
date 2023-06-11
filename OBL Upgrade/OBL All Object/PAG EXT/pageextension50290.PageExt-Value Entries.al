pageextension 50290 pageextension50290 extends "Value Entries"
{

    layout
    {
        addafter("Capacity Ledger Entry No.")
        {
            field("Inventory Posting Group"; Rec."Inventory Posting Group")
            {
                ApplicationArea = All;
            }
        }
        addafter("Job Ledger Entry No.")
        {
            field("Purchase Amount (Actual)"; Rec."Purchase Amount (Actual)")
            {
                ApplicationArea = All;
            }
            field("Item Base Unit of Measure"; Rec."Item Base Unit of Measure")
            {
                ApplicationArea = All;
            }
        }
    }
}

