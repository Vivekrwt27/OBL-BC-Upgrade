table 90103 "Weighted Avg.Save"
{

    fields
    {
        field(1; "Item No."; Code[20])
        {
        }
        field(5; "Location Code"; Code[20])
        {
        }
        field(10; "Variant Code"; Code[20])
        {
        }
        field(15; "Posting Date"; Date)
        {
        }
        field(20; "Document No."; Code[20])
        {
        }
        field(25; Quantity; Decimal)
        {
            DecimalPlaces = 5 : 5;
        }
        field(30; "Remaining Quantity"; Decimal)
        {
            DecimalPlaces = 5 : 5;
        }
        field(35; "Cost Amount Actual"; Decimal)
        {
            DecimalPlaces = 5 : 5;
        }
        field(40; "Cost Amount Expected"; Decimal)
        {
            DecimalPlaces = 5 : 5;
        }
        field(45; "Entry No."; Integer)
        {
        }
        field(50; Posted; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Location Code", "Item No.", "Variant Code")
        {
        }
    }

    fieldgroups
    {
    }
}

