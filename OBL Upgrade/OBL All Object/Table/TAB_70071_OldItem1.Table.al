table 70071 "Old Item1"
{

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Description 2"; Text[30])
        {
        }
        field(4; "Base Unit of Measure"; Code[10])
        {
        }
        field(5; "Inventory Posting Group"; Code[10])
        {
        }
        field(6; "New Item Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

