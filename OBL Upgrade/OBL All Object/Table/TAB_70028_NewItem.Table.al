table 70028 NewItem
{

    fields
    {
        field(1; NewString; Code[20])
        {
        }
        field(2; Description; Text[250])
        {
        }
        field(3; PREM; Decimal)
        {
        }
        field(4; COM; Decimal)
        {
        }
        field(5; ECO; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; NewString)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

