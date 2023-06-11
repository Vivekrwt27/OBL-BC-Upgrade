tableextension 50208 tableextension50208 extends "Item Unit of Measure"
{
    fields
    {
        field(50000; "Ref Code"; Code[20])
        {
            CalcFormula = Lookup(Item."Old Code" WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(85000; "Not Required"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}

