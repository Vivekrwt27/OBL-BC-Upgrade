tableextension 50212 tableextension50212 extends "Prod. Order Routing Line"
{
    // 
    // 1.TRI S.R 04.02.10 - New field Added for Manufacturing
    // 2.TRI S.R 190310 - New field Add
    // 3.TRI S.R 190310 - New Code Add
    fields
    {
        field(50000; "Posted Quantity"; Decimal)
        {
            CalcFormula = Sum("Capacity Ledger Entry"."Output Quantity" WHERE("Prod. Order No." = FIELD("Prod. Order No."),
                                                                               "Operation No." = FIELD("Operation No.")));
            Description = 'TRI S.R 04.02.10 - New field Added for Manufacturing';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Original Component"; Boolean)
        {
            Description = 'TRI S.R 190310 - New field Add';
            Editable = false;
        }
    }




    //Unsupported feature: Code Modification on "AdjustComponents(PROCEDURE 14)".

    //procedure AdjustComponents();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ProdOrderComp.SETRANGE(Status,Status);
    ProdOrderComp.SETRANGE("Prod. Order No.","Prod. Order No.");
    ProdOrderComp.SETRANGE("Prod. Order Line No.",ProdOrderLine."Line No.");

    IF ProdOrderComp.FIND('-') THEN
      REPEAT
        ProdOrderComp.VALIDATE("Routing Link Code");
        ProdOrderComp.MODIFY;
      UNTIL ProdOrderComp.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    {ProdOrderComp.SETRANGE(Status,Status);
    ProdOrderComp.SETRANGE("Prod. Order No.","Prod. Order No.");
    ProdOrderComp.SETRANGE("Prod. Order Line No.",ProdOrderLine."Line No.");
    }


    ProdOrderComp.SETRANGE(ProdOrderComp.Status,Status);
    ProdOrderComp.SETRANGE(ProdOrderComp."Prod. Order No.","Prod. Order No.");
    ProdOrderComp.SETRANGE(ProdOrderComp."Prod. Order Line No.",ProdOrderLine."Line No.");
    IF ProdOrderComp.FIND('-') THEN
      REPEAT
        ProdOrderComp.VALIDATE(ProdOrderComp."Routing Link Code");
        ProdOrderComp.MODIFY;
      UNTIL ProdOrderComp.NEXT = 0;
    */
    //end;
}

