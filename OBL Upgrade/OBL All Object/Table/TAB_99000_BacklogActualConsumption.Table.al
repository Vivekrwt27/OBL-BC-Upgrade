table 99000 "Backlog Actual Consumption"
{

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Item Journal Template";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(4; "Consumption Date"; Date)
        {
        }
        field(5; "Item No."; Code[20])
        {
        }
        field(6; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(7; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(8; "Consumption Qty."; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Line No.", "Consumption Date", "Item No.", "Location Code", "Variant Code")
        {
            Clustered = true;
        }
        key(Key2; "Consumption Date", "Item No.", "Location Code", "Variant Code")
        {
            SumIndexFields = "Consumption Qty.";
        }
    }

    fieldgroups
    {
    }
}

