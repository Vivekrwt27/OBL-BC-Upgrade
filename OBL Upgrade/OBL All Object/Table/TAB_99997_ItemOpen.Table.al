table 99997 "Item Open"
{

    fields
    {
        field(1; "Item Code"; Code[20])
        {
        }
        field(2; Quantity; Decimal)
        {
        }
        field(3; Line; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Item Code", Line)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

