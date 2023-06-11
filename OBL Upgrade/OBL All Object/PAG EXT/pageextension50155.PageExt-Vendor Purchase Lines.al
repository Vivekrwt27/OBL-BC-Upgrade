pageextension 50155 pageextension50155 extends "Vendor Purchase Lines"
{
    layout
    {
        addfirst(Control1)
        {
            field("Period Type"; rec."Period Type")
            {
                ApplicationArea = All;
            }
        }
        addafter("Period Start")
        {
            field("Period End"; rec."Period End")
            {
                ApplicationArea = All;
            }

        }
    }
}

