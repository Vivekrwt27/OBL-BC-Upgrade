table 70006 "User New"
{
    Caption = 'User';
    DataCaptionFields = "User ID", Name;
    DataPerCompany = false;

    fields
    {
        field(1; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(2; Password; Text[30])
        {
            Caption = 'Password';
        }
        field(3; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(4; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

