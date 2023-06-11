table 50033 "Manufacturing Plan"
{

    fields
    {
        field(1; "Item No."; Code[20])
        {
            TableRelation = Item;
        }
        field(2; "Unit of Measure"; Code[20])
        {
            CalcFormula = Lookup(Item."Base Unit of Measure" WHERE("No." = FIELD("Item No.")));
            Enabled = true;
            FieldClass = FlowField;
        }
        field(6; "Output (Quantity)"; Decimal)
        {
        }
        field(7; "Output Date"; Date)
        {
        }
        field(8; "Item Description"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            Enabled = true;
            FieldClass = FlowField;
        }
        field(9; "Item Description2"; Text[100])
        {
            CalcFormula = Lookup(Item."Description 2" WHERE("No." = FIELD("Item No.")));
            Enabled = true;
            FieldClass = FlowField;
        }
        field(10; "Production Plant"; Code[10])
        {
            TableRelation = Location WHERE("Production Location" = CONST(true));
        }
    }

    keys
    {
        key(Key1; "Item No.", "Output Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

