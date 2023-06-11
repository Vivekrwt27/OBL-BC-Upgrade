pageextension 50041 pageextension50041 extends "Posted Sales Shipments"
{
    layout
    {
        addafter("Shipment Date")
        {
            field("Order No."; rec."Order No.")
            {
                ApplicationArea = All;
            }
            field("GR No."; rec."GR No.")
            {
                ApplicationArea = All;
            }
        }
    }
}

