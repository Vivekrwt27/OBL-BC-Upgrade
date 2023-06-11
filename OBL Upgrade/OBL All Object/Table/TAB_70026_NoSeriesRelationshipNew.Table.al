table 70026 "No. Series Relationship New"
{
    Caption = 'No. Series Relationship';
    DrillDownPageID = "No. Series Lines";
    LookupPageID = "No. Series Lines";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                CALCFIELDS(Description);
            end;
        }
        field(2; "Series Code"; Code[10])
        {
            Caption = 'Series Code';
            NotBlank = true;
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                CALCFIELDS("Series Description");
            end;
        }
        field(3; Description; Text[50])
        {
            CalcFormula = Lookup("No. Series".Description WHERE("Code" = FIELD("Code")));
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Series Description"; Text[50])
        {
            CalcFormula = Lookup("No. Series".Description WHERE("Code" = FIELD("Series Code")));
            Caption = 'Series Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000; Location; Code[10])
        {
            TableRelation = Location.Code;
        }
    }

    keys
    {
        key(Key1; "Code", "Series Code")
        {
            Clustered = true;
        }
        key(Key2; "Series Code", "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

