pageextension 50500 Pageext50500 extends "Payment Journal"
{
    layout
    {
        addafter(Description)
        {
            field(Description2; Rec.Description2)
            {
                ApplicationArea = All;
            }
        }
        addafter("TDS Section Code")
        {
            field("Manual TDS"; Rec."Manual TDS")
            {
                ApplicationArea = all;
                Editable = true;
            }
            field("Manual TDS Base Amount"; Rec."Manual TDS Base Amount")
            {
                ApplicationArea = all;
                Editable = true;
            }
        }
        addafter("Posting Date")
        {
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = all;
            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
            }

        }
        addafter("Manual TDS Base Amount")
        {
            field("Payment Mode"; Rec."Payment Mode")
            {
                ApplicationArea = all;
            }
            field("Beneficiary Name"; Rec."Beneficiary Name")
            {
                ApplicationArea = all;
            }
            field("Beneficiary Account No."; Rec."Beneficiary Account No.")
            {
                ApplicationArea = all;
            }
            field("Beneficiary IFSC Code"; Rec."Beneficiary IFSC Code")
            {
                ApplicationArea = all;
            }
            field("Beneficiary Account Type"; Rec."Beneficiary Account Type")
            {
                ApplicationArea = all;
            }
            field("PO No."; Rec."PO No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Bank Payment Type")
        {
            field("Online Bank Transfer"; Rec."Online Bank Transfer")
            {
                ApplicationArea = all;
            }
        }

        moveafter(Description2; "Debit Amount", "Credit Amount")
        modify("Debit Amount")
        {
            Visible = true;
        }
        modify("Credit Amount")
        {
            Visible = true;
        }

    }

    actions
    {
        addafter(PrintCheck)
        {
            action("Check Print Report")
            {
                Caption = 'Check Print Report';
                ApplicationArea = All;
                Promoted = true;
                RunObject = report 50087;
            }
        }
    }

    var
        myInt: Integer;
}