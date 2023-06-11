table 50031 conversion
{

    fields
    {
        field(1; Size; Code[10])
        {
        }
        field(2; Packing; Code[10])
        {
        }
        field(3; CRT; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(4; Pcs; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(5; SQfeet; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(6; "nt wt"; Decimal)
        {
            DecimalPlaces = 0 : 3;
        }
        field(7; "g wt"; Decimal)
        {
            DecimalPlaces = 0 : 3;
        }
        field(8; "Size Description"; Text[100])
        {
            CalcFormula = Lookup("Dimension Value"."Name" WHERE("Dimension Code" = FILTER('SIZE'),
                                                               Code = FIELD("Size")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Packing Description"; Text[100])
        {
            CalcFormula = Lookup("Dimension Value"."Name" WHERE("Dimension Code" = FILTER('PACKING'),
                                                               Code = FIELD("Packing")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "SQ.MT"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; Size, Packing)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

