table 90084 "Locan Bin Mismatch"
{

    fields
    {
        field(1; "Item No"; Code[20])
        {
        }
        field(2; Location; Code[10])
        {
        }
        field(3; "LOcation Qty"; Decimal)
        {
        }
        field(4; "Bin Qty"; Decimal)
        {
        }
        field(5; "count"; Integer)
        {
            CalcFormula = Count("Locan Bin Mismatch" WHERE("POsitive" = CONST(false)));
            FieldClass = FlowField;
        }
        field(6; POsitive; Boolean)
        {
        }
        field(7; Difference; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Item No", Location)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

