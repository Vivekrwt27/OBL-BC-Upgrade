table 70070 "Test GL"
{

    fields
    {
        field(1; "GL Entry"; Integer)
        {
            TableRelation = "G/L Entry";
        }
        field(2; "Gl Amount"; Decimal)
        {
        }
        field(3; "Value Amount"; Decimal)
        {
        }
        field(4; "Value Entry"; Integer)
        {
            CalcFormula = Lookup("G/L - Item Ledger Relation"."Value Entry No." WHERE("G/L Entry No." = FIELD("GL Entry")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Count of Value En"; Integer)
        {
            CalcFormula = Count("G/L - Item Ledger Relation" WHERE("Value Entry No." = FIELD("Value Entry")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "GL Entry")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

