table 99989 "Item Revaluation"
{

    fields
    {
        field(1; "Item COde"; Code[20])
        {
        }
        field(2; "Unit of measure"; Code[10])
        {
        }
        field(3; Date; Date)
        {
        }
        field(4; LOcation; Code[10])
        {
        }
        field(5; Quantity; Decimal)
        {
        }
        field(6; "Old Rate"; Decimal)
        {
        }
        field(7; "New Rate"; Decimal)
        {
        }
        field(8; Done; Boolean)
        {
        }
        field(9; "count"; Integer)
        {
            CalcFormula = Count("Item Revaluation");
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Item COde", "Unit of measure", Date, LOcation, Quantity)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

