table 99998 "Item not found Adjustment"
{

    fields
    {
        field(1; "Posting Date"; Date)
        {
        }
        field(2; "Item No."; Code[20])
        {
        }
        field(3; "Negative Adj."; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Posting Date", "Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

