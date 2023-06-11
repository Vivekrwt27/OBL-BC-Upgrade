pageextension 50007 pageextension50007 extends "Inventory Posting Groups"
{
    layout
    {
        addafter(Description)
        {
            field("Item Code Service App"; rec."Item Code Service App")
            {
                ApplicationArea = All;
            }
        }
    }
}

