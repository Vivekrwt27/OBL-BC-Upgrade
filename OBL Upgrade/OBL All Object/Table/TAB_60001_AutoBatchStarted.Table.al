table 60001 "Auto Batch Started"
{

    fields
    {
        field(1; "Report ID"; Integer)
        {
        }
        field(2; "Start Time"; Time)
        {
        }
        field(3; "End Time"; Time)
        {
        }
        field(4; BatchStarted; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Report ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

