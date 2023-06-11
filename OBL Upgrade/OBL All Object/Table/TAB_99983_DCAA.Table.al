table 99983 DCAA
{

    fields
    {
        field(1; "item No"; Code[20])
        {
        }
        field(2; Amount; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "item No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

