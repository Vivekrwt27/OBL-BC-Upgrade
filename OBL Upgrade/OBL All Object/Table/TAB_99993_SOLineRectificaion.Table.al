table 99993 "SO Line Rectificaion"
{

    fields
    {
        field(1; "Order No"; Code[20])
        {
        }
        field(2; "Bin NO"; Code[20])
        {
        }
        field(3; "Item No"; Code[20])
        {
        }
        field(4; Variant; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Order No", "Bin NO")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

