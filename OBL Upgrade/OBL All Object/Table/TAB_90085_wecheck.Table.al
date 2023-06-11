table 90085 "we check"
{

    fields
    {
        field(1; "Tr no"; Code[20])
        {
        }
        field(2; "Item NO"; Code[20])
        {
        }
        field(3; "Line No"; Integer)
        {
        }
        field(4; Qty; Decimal)
        {
        }
        field(5; bin; Code[10])
        {
        }
        field(6; loCATION; Code[10])
        {
        }
        field(7; "APPLY TO ENTRY"; Integer)
        {
        }
        field(8; VARIANT; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Tr no", "Item NO", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

