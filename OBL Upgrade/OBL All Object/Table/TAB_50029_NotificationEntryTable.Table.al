table 50029 "Notification Entry Table"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Record ID"; RecordID)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Notification Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('NOTIFY'));
        }
        field(20; "Notification Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Notify User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Email ID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Creation Date & Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50; Notify; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Notify On" := CURRENTDATETIME;
            end;
        }
        field(60; "Notify On"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Table ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Doc Type"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Document Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(100; "Notify Message"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(120; "Available Inventory"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Notify Due Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
            Description = 'Keshav';
        }
        field(50002; "Notify Time Range"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'Keshav';
        }
        field(50003; "Notify Message1"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'Keshav';
        }
        field(50004; "Notify Message2"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'Keshav';
        }
        field(50005; "Location Code"; Code[20])
        {
            Description = 'keshav';
            TableRelation = Location;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Notify User", "Notification Code", Notify)
        {
        }
        key(Key3; "Notification Code", "Record ID")
        {
        }
        key(Key4; "Notification Code", "Document No.", "Document Line No.", Notify)
        {
        }
    }

    fieldgroups
    {
    }
}

