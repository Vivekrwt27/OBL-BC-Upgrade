pageextension 50436 pageextension50436 extends "Item Avail. by Location Lines"
{
    layout
    {
        addafter("Item.""Net Change""")
        {
            field(ProjAvailBalanceCRT; ProjAvailBalanceCRT)
            {
                Caption = 'Projected Available Balance in CRT';
                ApplicationArea = All;
            }
            /* field("ItemRec.""Inventory In CRT"""; Rec. "ItemRec.""Inventory In CRT""")
             {
                 Caption = 'Inventory In CRT';
                 Editable = false;

                 trigger OnDrillDown()
                 begin
                     //ShowItemLedgerEntries(FALSE); code blocked for upgrade
                 end;
             }*/
        }
    }

    var
        Item1: Record Item;

    var
        ProjAvailBalanceCRT: Decimal;
        ItemRec: Record Item;


    //Unsupported feature: Code Insertion (VariableCollection) on "OnAfterGetRecord".

    //trigger (Variable: Item1)()
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CalcAvailQuantities(
      GrossRequirement,PlannedOrderRcpt,ScheduledRcpt,
      PlannedOrderReleases,ProjAvailableBalance,ExpectedInventory,QtyAvailable);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    Item1.GET(Item."No.");
    ItemRec.COPY(Item);
    ItemRec.CALCFIELDS("Inventory In CRT");
    ProjAvailBalanceCRT := Item.UomToCart(Item."No.",Item1."Base Unit of Measure",ProjAvailableBalance);

    //Upgrade(+)
      //TRI DG 020810 add Start
    // ProjAvailBalanceCRT := Item.UomToCart(Item."No.",Item."Base Unit of Measure",ProjAvailBalance);   code blocked for upgrade
    //TRI DG 020810 add Stop
    //upgrade(-)
    */
    //end;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PeriodStart := 0D;
    PeriodEnd := 311299D;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    PeriodStart := 0D;
    PeriodEnd := 123199D;
    */
    //end;
}

