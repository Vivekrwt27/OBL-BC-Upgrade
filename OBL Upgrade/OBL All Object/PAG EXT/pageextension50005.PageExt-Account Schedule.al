pageextension 50005 pageextension50005 extends "Account Schedule"
{
    layout
    {
        addafter("New Page")
        {
            field("Inventory Entry As On Date"; rec."Inventory Entry As On Date")
            {
                ApplicationArea = All;
            }
            field("Inventory Posting Group Filter"; rec."Inventory Posting Group Filter")
            {
                ApplicationArea = All;
            }
        }
    }
}

