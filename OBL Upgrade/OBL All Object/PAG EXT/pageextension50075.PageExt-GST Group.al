pageextension 50075 pageextension50075 extends "GST Group"
{
    layout
    {
        addafter("Reverse Charge")
        {
            field(Blocked; rec.Blocked)
            {
                ApplicationArea = All;
            }
        }
    }
}

