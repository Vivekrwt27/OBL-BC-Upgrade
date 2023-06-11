table 99995 "DEP PERCENTAGE"
{

    fields
    {
        field(1; FACODE; Code[10])
        {
        }
        field(2; "DEP PERC"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; FACODE)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

