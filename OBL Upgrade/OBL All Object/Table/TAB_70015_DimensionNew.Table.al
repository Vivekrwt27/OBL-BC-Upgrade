table 70015 "Dimension New"
{
    Caption = 'Dimension';
    DataCaptionFields = "Code", Name;
    DrillDownPageID = "Dimension List";
    LookupPageID = "Dimension List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;

            trigger OnValidate()
            var
                GLAcc: Record "G/L Account";
                BusUnit: Record "Business Unit";
            begin
            end;
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(3; "Code Caption"; Text[30])
        {
            Caption = 'Code Caption';
        }
        field(4; "Filter Caption"; Text[30])
        {
            Caption = 'Filter Caption';
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(6; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(7; "Consolidation Code"; Code[20])
        {
            Caption = 'Consolidation Code';
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
    var
        GLSetup: Record "General Ledger Setup";
    begin
    end;
}

