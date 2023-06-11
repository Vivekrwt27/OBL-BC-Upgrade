table 50041 "Reminder Details"
{

    fields
    {
        field(5; "Customer No."; Code[20])
        {
        }
        field(10; "Date of Reminder"; Date)
        {
        }
        field(15; "Customer Entry No."; Integer)
        {
        }
        field(20; "No. of Reminders"; Integer)
        {
        }
        field(25; "Original Reminder Date"; Date)
        {
        }
        field(50; "Date of Issue"; Date)
        {
        }
        field(55; "Mail Sent"; Boolean)
        {
        }
        field(60; "PDF Generated"; Boolean)
        {
        }
        field(900; "Date of Invoice"; Date)
        {
        }
        field(905; "Document No."; Code[20])
        {
        }
        field(910; "Due date"; Date)
        {
        }
        field(915; Amount; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Customer No.", "Date of Reminder")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

