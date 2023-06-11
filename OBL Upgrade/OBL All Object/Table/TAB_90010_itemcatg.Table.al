table 90010 "item catg"
{

    fields
    {
        field(1; "item no"; Code[20])
        {
        }
        field(2; "code"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "item no")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

