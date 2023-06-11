pageextension 50008 pageextension50008 extends "Item Vendor Catalog"
{
    layout
    {
        addafter("Lead Time Calculation")
        {
            field("Item Category Code"; rec."Item Category Code")
            {
                ApplicationArea = All;
            }
        }
    }
}

