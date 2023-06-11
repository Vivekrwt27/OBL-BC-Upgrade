table 50090 "E-Way Request ID"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Document No."; Code[20])
        {
        }
        field(3; "Request Id"; Text[250])
        {
        }
        field(4; "Request Date"; Date)
        {
        }
        field(5; "Request Time"; Time)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

