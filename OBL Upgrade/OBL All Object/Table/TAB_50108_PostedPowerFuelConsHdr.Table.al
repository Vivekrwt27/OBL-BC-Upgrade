table 50108 "Posted Power & Fuel Cons. Hdr."
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Date of Reporting"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item WHERE("Inventory Posting Group" = FILTER('POWER' | 'FUEL'));
        }
        field(16; "Item Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Consumed Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Inventory At Location"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                  "Location Code" = FIELD(Location)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; Location; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code WHERE("Prod. Units" = FIELD("Prod. Units"));
        }
        field(30; "Prod. Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Prod. End Date"; Date)
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
        field(80; "Creation Date & Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(85; "Created By"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(90; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Release';
            OptionMembers = Open,Release;
        }
        field(100; "No. Series"; Code[10])
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
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

