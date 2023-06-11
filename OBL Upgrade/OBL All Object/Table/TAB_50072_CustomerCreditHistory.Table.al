table 50072 "Customer Credit History"
{

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            TableRelation = Customer;
        }
        field(10; "Starting date"; Date)
        {
        }
        field(100; "Credit Limit (LCY)"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Customer No.", "Starting date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

