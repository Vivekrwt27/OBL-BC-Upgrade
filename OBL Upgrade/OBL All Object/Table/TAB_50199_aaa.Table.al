table 50199 aaa
{

    fields
    {
        field(4; "Item No"; Code[20])
        {
        }
        field(5; Quantity; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Item No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

