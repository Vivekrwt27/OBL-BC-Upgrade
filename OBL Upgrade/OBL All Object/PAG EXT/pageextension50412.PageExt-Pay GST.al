pageextension 50412 pageextension50412 extends "Pay GST"
{
    layout
    {

        addafter("Payment Amount")
        {
            field("Surplus Credit"; Rec."Surplus Credit")
            {
                ApplicationArea = All;
            }
            field("Surplus Cr. Utilized"; Rec."Surplus Cr. Utilized")
            {
                ApplicationArea = All;
            }
            field("Carry Forward"; Rec."Carry Forward")
            {
                ApplicationArea = All;
            }
        }
    }
}

