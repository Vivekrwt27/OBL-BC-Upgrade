table 50005 "Tour Line"
{
    Description = '2.9';

    fields
    {
        field(1; "Tour No."; Code[20])
        {
            TableRelation = "Tour Header"."Tour No.";
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; Details; Text[100])
        {
        }
        field(4; "From Date"; Date)
        {
        }
        field(5; "To Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Tour No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

