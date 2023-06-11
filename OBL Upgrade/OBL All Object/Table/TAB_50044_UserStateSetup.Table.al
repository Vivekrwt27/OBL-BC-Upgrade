table 50044 "User State Setup"
{

    fields
    {
        field(1; "User ID"; Code[20])
        {
            Editable = true;
            TableRelation = "User Setup"."User ID";
        }
        field(2; State; Code[10])
        {
            TableRelation = State;

            trigger OnValidate()
            begin
                IF RecState.GET(State) THEN
                    "State Name" := RecState.Description
                ELSE
                    "State Name" := '';
            end;
        }
        field(3; "State Name"; Text[30])
        {
            Editable = false;
        }
        field(4; "PCH Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser" WHERE(Status = FILTER(< Disabled));
        }
    }

    keys
    {
        key(Key1; "User ID", State)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        RecState: Record State;
}

