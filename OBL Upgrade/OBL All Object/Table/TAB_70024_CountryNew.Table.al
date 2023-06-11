table 70024 "Country New"
{
    Caption = 'Country';
    LookupPageID = "Countries/Regions";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(6; "EU Country Code"; Code[10])
        {
            Caption = 'EU Country Code';
        }
        field(7; "Intrastat Code"; Code[10])
        {
            Caption = 'Intrastat Code';
        }
        field(8; "Address Format"; Option)
        {
            Caption = 'Address Format';
            InitValue = "City+Post Code";
            OptionCaption = 'Post Code+City,City+Post Code,City+County+Post Code,Blank Line+Post Code+City';
            OptionMembers = "Post Code+City","City+Post Code","City+County+Post Code","Blank Line+Post Code+City";
        }
        field(9; "Contact Address Format"; Option)
        {
            Caption = 'Contact Address Format';
            InitValue = "After Company Name";
            OptionCaption = 'First,After Company Name,Last';
            OptionMembers = First,"After Company Name",Last;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "EU Country Code")
        {
        }
        key(Key3; "Intrastat Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        VATRegNoFormat: Record "VAT Registration No. Format";
    begin
    end;
}

