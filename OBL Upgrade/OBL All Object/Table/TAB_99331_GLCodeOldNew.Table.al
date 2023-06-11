table 99331 "G/L Code Old/New"
{

    fields
    {
        field(1; "Old G/L Code"; Code[20])
        {
        }
        field(2; "New G/L Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Old G/L Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

