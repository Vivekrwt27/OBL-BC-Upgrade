pageextension 50332 pageextension50332 extends "Posted Return Shipment Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
        }
    }
}

