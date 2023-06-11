table 90005 Sqm
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

