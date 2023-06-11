pageextension 50181 pageextension50181 extends "Shipping Agents"
{
    layout
    {
        addafter("Account No.")
        {
            field("Insurance Applicable"; rec."Insurance Applicable")
            {
                ApplicationArea = All;
            }
            field("Transporter GST No."; rec."Transporter GST No.")
            {
                ApplicationArea = All;
            }
        }
    }
}

