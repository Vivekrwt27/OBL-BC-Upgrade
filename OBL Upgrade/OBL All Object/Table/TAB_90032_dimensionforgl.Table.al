table 90032 "dimension for gl"
{

    fields
    {
        field(1; "sl no"; Code[10])
        {
        }
        field(2; dimension; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "sl no")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

