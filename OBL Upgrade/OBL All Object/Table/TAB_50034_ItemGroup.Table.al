table 50034 "Item Group"
{
    DrillDownPageID = "Item Group 2";
    LookupPageID = "Item Group 2";

    fields
    {
        field(1; "Group Code"; Code[10])
        {
            NotBlank = true;
        }
        field(2; Name; Text[30])
        {
        }
        field(3; Description; Text[100])
        {
        }
        field(4; Description2; Text[100])
        {
        }
        field(5; COCO; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Group Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

