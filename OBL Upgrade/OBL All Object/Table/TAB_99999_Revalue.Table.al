table 99999 Revalue
{

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Editable = false;
            NotBlank = true;
        }
        field(2; Cost; Decimal)
        {
            Editable = false;
        }
        field(4; Continue; Boolean)
        {
            Editable = false;

            trigger OnValidate()
            begin
                TESTFIELD(Cost, 0)
            end;
        }
    }

    keys
    {
        key(Key1; "Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

