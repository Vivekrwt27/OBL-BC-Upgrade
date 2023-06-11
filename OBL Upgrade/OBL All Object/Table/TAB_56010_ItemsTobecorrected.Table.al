table 56010 "Items To be corrected"
{

    fields
    {
        field(1; "Item No."; Code[20])
        {
        }
        field(2; UOM; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

