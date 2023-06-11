table 88001 Temp
{

    fields
    {
        field(1; "Item Code"; Code[20])
        {
        }
        field(2; "Group Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Item Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

