table 99980 "GIT positive"
{

    fields
    {
        field(1; "Item Code"; Code[20])
        {
        }
        field(2; "To No"; Code[40])
        {
        }
        field(3; "TS No"; Code[20])
        {
        }
        field(4; Quantity; Decimal)
        {
        }
        field(5; "ILE no"; Integer)
        {
        }
        field(6; "count"; Integer)
        {
            CalcFormula = Count("GIT positive");
            FieldClass = FlowField;
        }
        field(7; "sum"; Decimal)
        {
            CalcFormula = Sum("GIT positive".Quantity);
            FieldClass = FlowField;
        }
        field(8; Variant; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "ILE no")
        {
            Clustered = true;
            SumIndexFields = Quantity;
        }
    }

    fieldgroups
    {
    }
}

