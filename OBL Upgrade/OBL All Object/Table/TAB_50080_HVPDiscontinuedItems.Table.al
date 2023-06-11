table 50080 "HVP/Discontinued Items"
{

    fields
    {
        field(1; Type; Option)
        {
            OptionCaption = ' ,HVP,Discontinued';
            OptionMembers = " ",HVP,Discontinued;
        }
        field(5; "Item No."; Code[20])
        {
            TableRelation = Item;
        }
        field(10; "Starting Date"; Date)
        {
        }
        field(30; "HVP/Discontinued"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; Type, "Item No.", "Starting Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

