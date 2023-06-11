table 50225 "Production Forcast Entry"
{

    fields
    {
        field(1; "FG Item Code"; Code[20])
        {
            TableRelation = Item;
        }
        field(2; "Production Forcast Qty"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "FG Item Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

