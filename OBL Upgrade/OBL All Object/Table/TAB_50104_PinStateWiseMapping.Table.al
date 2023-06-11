table 50104 "Pin State Wise Mapping"
{

    fields
    {
        field(1; "Pin No."; Code[6])
        {
        }
        field(2; "State Code"; Code[10])
        {
            TableRelation = State;

            trigger OnValidate()
            begin
                IF RecStat.GET("State Code") THEN
                    "State Name" := RecStat.Description;
            end;
        }
        field(3; "State Name"; Text[30])
        {
            Editable = false;
        }
        field(4; "Sales Terretory"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Matrix Master"."Type 1";
        }
        field(5; "Post Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                PostCode.RESET;
                PostCode.SETRANGE(Code, "Post Code");
                IF PostCode.FINDFIRST THEN BEGIN
                    "City Name" := PostCode.City;
                    Zone := PostCode.Zone;
                END;
            end;
        }
        field(6; "City Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; Zone; Text[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Pin No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        IF PostCode.GET("Post Code") THEN
            "City Name" := PostCode.City;
    end;

    var
        RecStat: Record State;
        PostCode: Record "Post Code";
}

