table 50086 "Payment Terms Location Wise"
{

    fields
    {
        field(1; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(2; "State Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = State.Code;
        }
        field(3; "Payment Terms Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms".Code;
        }
    }

    keys
    {
        key(Key1; "Location Code", "State Code", "Payment Terms Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

