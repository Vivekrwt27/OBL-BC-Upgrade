table 50001 "Branch Wise focused Prod IBOT"
{

    fields
    {
        field(1; "Sales Territory"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Matrix Master"."Type 1";
        }
        field(2; NPD; Text[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Sales Territory", NPD)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

