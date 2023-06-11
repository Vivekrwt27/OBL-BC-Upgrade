table 50081 "PMT Goal Sheet Data"
{

    fields
    {
        field(1; "PMT ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Lead ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Status; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Tiling Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Last Modify"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(175; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(180; "PMT Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(181; Inactive; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(182; Hot; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(183; BH; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(184; ZM; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(185; ZH; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "PMT ID")
        {
            Clustered = true;
        }
        key(Key2; "Created By", BH, ZM, ZH)
        {
        }
    }

    fieldgroups
    {
    }
}

