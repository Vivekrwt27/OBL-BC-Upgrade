table 50116 "GSTN Log Entry"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Vendor,Customer';
            OptionMembers = " ",Vendor,Customer;
        }
        field(15; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "GSTN No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(40; Date; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Checked By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60; Status; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

