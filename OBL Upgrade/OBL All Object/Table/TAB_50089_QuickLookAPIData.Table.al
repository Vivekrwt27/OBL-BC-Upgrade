table 50089 "QuickLook API Data"
{

    fields
    {
        field(10; "Month Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Customer No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Item No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "DV Count"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "DS Count"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Salesperson Code"; Code[11])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "PCH Code"; Code[11])
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Zonal Manager"; Code[11])
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Zohal Head"; Code[11])
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Salesperson Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(56; "PCH Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(57; Zonal_Head; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(58; Zonal_Manager; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Customer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "City Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(61; "State Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(62; OBTB; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Month Date", "Customer No.", "Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

