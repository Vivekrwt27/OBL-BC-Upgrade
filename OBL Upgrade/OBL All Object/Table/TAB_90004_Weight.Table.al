table 90004 Weight
{

    fields
    {
        field(1; size; Code[10])
        {
        }
        field(2; Packing; Code[10])
        {
        }
        field(3; "Net Weight"; Decimal)
        {
        }
        field(4; "Gross Weight"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; size, Packing)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

