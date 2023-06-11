table 50071 "Location-Item Wise Reorder Lvl"
{

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            TableRelation = Location."Code" WHERE("Auto Indent Creation ID" = FILTER(<> ''));
        }
        field(10; "Item No."; Code[20])
        {
            TableRelation = Item."No." WHERE(Blocked = FILTER(false));
        }
        field(20; "Min. Qty."; Decimal)
        {
        }
        field(30; "Max. Reorder Level"; Decimal)
        {
        }
        field(1000; "Qty. on Purchase Order"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Outstanding Quantity" WHERE("No." = FIELD("Item No."),
                                                                            "Document Type" = FILTER(Order),
                                                                            "Location Code" = FIELD("Location Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(1010; "Qty. on Indent Lines"; Decimal)
        {
            CalcFormula = Sum("Indent Line".Quantity WHERE("No." = FIELD("Item No."),
                                                            "Location Code" = FIELD("Location Code"),
                                                            "Order No." = FILTER(= '')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(1020; Inventory; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                  "Location Code" = FIELD("Location Code")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Location Code", "Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

