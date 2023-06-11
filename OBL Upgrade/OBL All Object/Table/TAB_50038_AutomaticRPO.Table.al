table 50038 "Automatic RPO"
{

    fields
    {
        field(1; "SI No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
            NotBlank = true;
        }
        field(2; "RPO No."; Code[20])
        {
            Editable = false;
            NotBlank = true;
        }
        field(4; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Simulated,Planned,Firm Planned,Released,Finished';
            OptionMembers = Simulated,Planned,"Firm Planned",Released,Finished;
        }
    }

    keys
    {
        key(Key1; "SI No.", "RPO No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

