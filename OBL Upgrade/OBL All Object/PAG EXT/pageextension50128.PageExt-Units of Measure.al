pageextension 50128 pageextension50128 extends "Units of Measure"
{
    layout
    {
        addafter(Description)
        {
            field("E-Way Code"; rec."E-Way Code")
            {
                ApplicationArea = All;
            }
        }
    }
}