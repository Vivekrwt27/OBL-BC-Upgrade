table 70014 "No. Series New"
{
    Caption = 'No. Series';
    DataCaptionFields = "Code", Description;
    DrillDownPageID = "No. Series";
    LookupPageID = "No. Series";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Default Nos."; Boolean)
        {
            Caption = 'Default Nos.';
        }
        field(4; "Manual Nos."; Boolean)
        {
            Caption = 'Manual Nos.';
        }
        field(5; "Date Order"; Boolean)
        {
            Caption = 'Date Order';
        }
        field(50000; Location; Code[10])
        {
            TableRelation = Location.Code;
        }
        field(50001; "Sales Order No. Series"; Code[10])
        {
            Description = 'TRI DP 140309';
            TableRelation = "No. Series";
        }
        field(50002; "Posted Invoice No. Series"; Code[10])
        {
            Description = 'TRI DG';
            TableRelation = "No. Series";
        }
        field(50003; Structure; Code[10])
        {
            Description = 'TRI P.G 22.06.2009';
            //TableRelation = "Structure Header"; 16225 TABLE N/F
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        NoSeriesLine.SETRANGE("Series Code", Code);
        NoSeriesLine.DELETEALL;

        NoSeriesRelationship.SETRANGE(Code, Code);
        NoSeriesRelationship.DELETEALL;
        NoSeriesRelationship.SETRANGE(Code);

        NoSeriesRelationship.SETRANGE("Series Code", Code);
        NoSeriesRelationship.DELETEALL;
        NoSeriesRelationship.SETRANGE("Series Code");
    end;

    var
        NoSeriesLine: Record "No. Series Line";
        NoSeriesRelationship: Record "No. Series Relationship";
}

