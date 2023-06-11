table 90003 "temp-catg"
{

    fields
    {
        field(1; name; Text[80])
        {
        }
        field(2; no; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; no)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

