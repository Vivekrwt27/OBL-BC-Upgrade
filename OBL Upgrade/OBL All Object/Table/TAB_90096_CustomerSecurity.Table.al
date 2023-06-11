table 90096 "Customer Security"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; "Document No."; Code[20])
        {
        }
        field(4; "Customer No."; Code[20])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; Location; Code[10])
        {
        }
        field(7; Description; Text[200])
        {
        }
        field(8; "Bal Ac"; Code[20])
        {
        }
        field(9; "External Doc."; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

