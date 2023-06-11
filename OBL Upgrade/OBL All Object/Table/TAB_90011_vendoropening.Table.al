table 90011 "vendor opening"
{

    fields
    {
        field(1; "code"; Code[20])
        {
        }
        field(2; amount; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

