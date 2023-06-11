table 50027 "Notification - User Mapping"
{

    fields
    {
        field(10; "Notification Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('NOTIFY'));
        }
        field(20; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
            begin
                UserSetup.GET("User ID");
                "E-Mail ID" := UserSetup."E-Mail";
            end;
        }
        field(40; "E-Mail ID"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Notification Code", "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

