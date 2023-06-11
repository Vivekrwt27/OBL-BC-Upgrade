table 50109 "Posted Power & Fuel Cons.Lines"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Consumed Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "FG Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "FG Item Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Total Sq. Meter Produced"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Prod. Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Prod. Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(45; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50; "Prod. Units"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,SKD,DRA,HSK';
            OptionMembers = " ",SKD,DRA,HSK;
        }
        field(60; Location; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(80; "Consumption Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

