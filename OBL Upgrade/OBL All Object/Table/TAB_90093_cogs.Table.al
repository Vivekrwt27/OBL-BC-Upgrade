table 90093 cogs
{

    fields
    {
        field(1; "Item code"; Code[20])
        {
        }
        field(2; "Rate SQM"; Decimal)
        {
        }
        field(3; "Rate Carton"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Item code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

