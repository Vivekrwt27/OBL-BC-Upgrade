table 99777 "Item Classification Rect."
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; c1; Code[10])
        {
        }
        field(3; c2; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

