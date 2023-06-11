table 50120 "Sales Person Hararkey"
{

    fields
    {
        field(1; "Sales Person Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Sales Person Name"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "BH Code"; Code[10])
        {
            //  CalcFormula = Lookup ("Customer"."PCH Code" WHERE ("Salesperson Code"=FIELD("Sales Person Code")));
            //16225 CUSTOMER TABLE FIELD N/F
            FieldClass = FlowField;
        }
        field(4; "BH Name"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "ZM Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "ZM Name"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "ZH Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "ZH Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Enable,Disabled';
            OptionMembers = Enable,Disabled;
        }
    }

    keys
    {
        key(Key1; "Sales Person Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

