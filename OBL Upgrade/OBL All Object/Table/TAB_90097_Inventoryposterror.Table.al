table 90097 "Inventory post error"
{

    fields
    {
        field(1; "Item No"; Code[20])
        {
        }
        field(2; "Inventory POstig Group"; Code[20])
        {
            CalcFormula = Lookup(Item."Inventory Posting Group" WHERE("No." = FIELD("Item No")));
            FieldClass = FlowField;
        }
        field(3; "Product Posting Group"; Code[20])
        {
            CalcFormula = Lookup(Item."Gen. Prod. Posting Group" WHERE("No." = FIELD("Item No")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Item No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

