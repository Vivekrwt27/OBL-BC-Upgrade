pageextension 50163 pageextension50163 extends "Bank Acc. Reconciliation Lines"
{

    //Unsupported feature: Property Modification (DelayedInsert) on ""Bank Acc. Reconciliation Lines"(Page 380)".

    layout
    {
        moveafter(Control1; "Document No.", Description, "Statement Amount", Difference, "Applied Amount", Type, "Applied Entries")
        modify("Value Date")
        {
            ApplicationArea = All;
            Visible = true;
        }
        addfirst(Control1)
        {
            field("Bank Account No."; rec."Bank Account No.")
            {
                ApplicationArea = All;
            }
            field("Statement No."; rec."Statement No.")
            {
                ApplicationArea = All;
            }
            field("Statement Line No."; rec."Statement Line No.")
            {
                ApplicationArea = All;
            }

        }
        addafter("Transaction Date")
        {
            field("Ready for Application"; rec."Ready for Application")
            {
                ApplicationArea = All;
            }
            field("Cheque No."; rec."Check No.")
            {
                Caption = 'Cheque No.';
                ApplicationArea = All;
            }
        }
        addafter("Additional Transaction Info")
        {
            field(Name; rec.Name)
            {
                ApplicationArea = All;
            }
            field(Select; rec.Select)
            {
                ApplicationArea = All;
            }
            field("Issuing Bank"; rec."Issuing Bank")
            {
                ApplicationArea = All;
            }
        }
    }
}

