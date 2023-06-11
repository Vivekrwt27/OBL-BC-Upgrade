table 90095 "LOcation COntra"
{

    fields
    {
        field(1; location; Code[10])
        {
        }
        field(2; "code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; location)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

