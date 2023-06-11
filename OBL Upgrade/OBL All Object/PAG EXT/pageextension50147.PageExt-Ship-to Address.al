pageextension 50147 pageextension50147 extends "Ship-to Address"
{
    layout
    {
        addafter(Consignee)
        {
            field("Tax Liable"; rec."Tax Liable")
            {
                ApplicationArea = All;
            }
            field("Tax Area Code"; rec."Tax Area Code")
            {
                ApplicationArea = All;
            }
        }
    }
}

