table 99988 "Item IPG Mismatch"
{

    fields
    {
        field(1; "Item Code"; Code[20])
        {
        }
        field(2; "Item IPG"; Code[20])
        {
        }
        field(3; "VE IPG"; Code[20])
        {
        }
        field(4; Value; Decimal)
        {
        }
        field(5; "Posted to gl"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Item Code", "Item IPG", "VE IPG")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

