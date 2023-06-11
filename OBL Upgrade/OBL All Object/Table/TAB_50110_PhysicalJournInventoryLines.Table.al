table 50110 "Physical Journ Inventory Lines"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(10; "Document Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(20; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "System Inventory"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Physical Inventory"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Document Line No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

