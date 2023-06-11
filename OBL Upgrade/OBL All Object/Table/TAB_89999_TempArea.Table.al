table 89999 "Temp Area"
{

    fields
    {
        field(1; "Item No."; Code[20])
        {
        }
        field(2; "Area"; Decimal)
        {
        }
        field(3; "Entry No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Item No.", "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

