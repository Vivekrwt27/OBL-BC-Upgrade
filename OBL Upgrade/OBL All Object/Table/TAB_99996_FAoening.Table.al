table 99996 "FA oening"
{

    fields
    {
        field(1; facode; Code[10])
        {
        }
        field(2; amount; Decimal)
        {
        }
        field(3; "A/D"; Option)
        {
            OptionMembers = A,d;
        }
    }

    keys
    {
        key(Key1; facode, "A/D")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

