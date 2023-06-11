table 99018 "Purch Credit memo diff"
{

    fields
    {
        field(1; "DOcument No."; Code[20])
        {
        }
        field(2; Amount; Decimal)
        {
        }
        field(3; Difference; Decimal)
        {
        }
        field(4; "Item No."; Code[20])
        {
            TableRelation = Item;
        }
        field(5; "ile no."; Integer)
        {
        }
        field(6; Total; Decimal)
        {
            CalcFormula = Sum("Purch Credit memo diff".Difference);
            FieldClass = FlowField;
        }
        field(7; "G/L No"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "DOcument No.", "Item No.", "ile no.", "G/L No")
        {
            Clustered = true;
            SumIndexFields = Difference;
        }
    }

    fieldgroups
    {
    }
}

