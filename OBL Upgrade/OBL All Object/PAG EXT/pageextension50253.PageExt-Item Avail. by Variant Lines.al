pageextension 50253 pageextension50253 extends "Item Avail. by Variant Lines"
{
    layout
    {
        addafter(ProjAvailableBalance)
        {
            field("Projected Available Balance in CRT"; ProjAvailBalanceCRT)
            {
                Caption = 'Projected Available Balance in CRT';
                ApplicationArea = All;
            }
        }
        addafter("Item.Inventory")
        {
            field("Inventory In CRT"; ItemRec."Inventory In CRT")
            {
                ApplicationArea = All;
            }
        }
    }

    var
        Item1: Record Item;

    var
        ProjAvailBalanceCRT: Decimal;
        recItem: Record Item;
        ProjAvailBalance: Decimal;
        ItemRec: Record Item;
        ProjAvailableBalance: Decimal;




    trigger OnOpenPage()
    begin
        Rec.SETFILTER("Variant Wise Inventory", '<>%1', 0);
    end;

    trigger OnAfterGetRecord()
    begin
        //TRI DG 020810 add Start
        Item1.GET(Item."No.");
        ItemRec.COPY(Item);
        ItemRec.CALCFIELDS("Inventory In CRT");
        ProjAvailBalanceCRT := Item.UomToCart(Item."No.", Item1."Base Unit of Measure", ProjAvailableBalance);
        //TRI DG 020810 add Stop
        //code copied in upgrade end(-)

    end;
}

