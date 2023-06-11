pageextension 50439 pageextension50439 extends "Prod. Order Comp. Line List"
{
    Editable = true;
    layout
    {
        addafter("Remaining Quantity")
        {
            field(Inventory; Rec.Inventory)
            {
                ApplicationArea = All;
            }
        }
        addafter("Position 2")
        {
            field("Reserve Qty"; Rec."Reserve Qty")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Item &Tracking Lines")
        {
            action(Reserve)
            {
                Caption = '&Reserve';
                Ellipsis = true;
                Image = Reserve;
                ShortCutKey = 'Ctrl+R';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.FIND;
                    Rec.ShowReservation;
                end;
            }
        }
    }
}

