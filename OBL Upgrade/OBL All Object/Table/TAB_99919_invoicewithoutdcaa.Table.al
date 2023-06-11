table 99919 "invoice without dcaa"
{

    fields
    {
        field(1; "invoice no"; Code[20])
        {
            TableRelation = "Purch. Inv. Header";
        }
        field(2; Date; Date)
        {
        }
        field(3; Amount; Decimal)
        {
            CalcFormula = Sum("Purch. Inv. Line".Amount WHERE("Document No." = FIELD("invoice no")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "invoice no")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

