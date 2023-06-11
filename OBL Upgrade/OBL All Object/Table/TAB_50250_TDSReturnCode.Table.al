table 50250 "TDS Return Code"
{

    fields
    {
        field(1; "TDS Section"; Code[10])
        {
        }
        field(2; "TDS Return Section"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "TDS Section")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

