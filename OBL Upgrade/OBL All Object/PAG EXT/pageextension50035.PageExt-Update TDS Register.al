pageextension 50035 pageextension50035 extends "Update TDS Register"
{
    layout
    {
        addafter("TDS Base Amount")
        {

            field("Assessee Code"; rec."Assessee Code")
            {
                ApplicationArea = All;
            }
            field("Account No."; rec."Account No.")
            {
                ApplicationArea = All;
            }
        }
    }
}

