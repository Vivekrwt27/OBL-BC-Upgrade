table 50002 "Freight Master IBOT"
{

    fields
    {
        field(1; "Despatch Location"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "State Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; City; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "9 MT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "18 MT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "25 MT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "30 MT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "35 - 40  MT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "24 MT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "3 -5 MT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "6 MT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Despatch Location", "State Name", City)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

