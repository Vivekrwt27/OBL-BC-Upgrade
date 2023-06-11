table 50114 "Indent Status History"
{

    fields
    {
        field(1; "Reporting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Indent Status"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = 'Open,Authorization1,Authorization2,Authorized,Closed,Authorization3';
            OptionMembers = Open,Authorization1,Authorization2,Authorized,Closed,Authorization3;
        }
        field(10; "Indent No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Indent Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(30; Status; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Item Category Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(60; Plant; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(70; Department; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Reporting Date", "Indent No.", "Indent Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

