table 50028 "Sales Person Leave Details"
{

    fields
    {
        field(1; "Sales Person Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(10; Date; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Sales Person Code", Date)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

