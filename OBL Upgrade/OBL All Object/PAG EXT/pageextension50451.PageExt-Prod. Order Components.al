pageextension 50451 pageextension50451 extends "Prod. Order Components"
{
    layout
    {
        addafter(Description)
        {
            field("Item Description 2"; Rec."Item Description 2")
            {
                ApplicationArea = All;
            }
        }
        addafter("Cost Amount")
        {
            field(Inventory; Rec.Inventory)
            {
                ApplicationArea = All;
            }
        }
    }
}

