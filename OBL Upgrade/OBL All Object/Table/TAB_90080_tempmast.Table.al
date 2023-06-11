table 90080 "temp mast"
{

    fields
    {
        field(1; "code"; Code[10])
        {
        }
        field(2; Desc; Text[30])
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

