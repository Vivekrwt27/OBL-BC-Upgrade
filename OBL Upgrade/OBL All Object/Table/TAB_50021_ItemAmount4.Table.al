table 50021 "Item Amount 4"
{

    fields
    {
        field(10; "Item No."; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(20; Date; Date)
        {
        }
        field(30; Quantity; Decimal)
        {
        }
        field(40; "MFG Code"; Code[10])
        {
        }
        field(50; "Location Code"; Code[10])
        {
            TableRelation = Location.Code;
        }
    }

    keys
    {
        key(Key1; "Item No.", Date, "MFG Code", "Location Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

