table 50198 "security - cust"
{

    fields
    {
        field(1; customer; Code[20])
        {
        }
        field(2; Amount; Decimal)
        {
        }
        field(3; Date; Date)
        {
        }
    }

    keys
    {
        key(Key1; customer)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

