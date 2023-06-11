table 99982 "Transfer Amount"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Account No."; Code[20])
        {
        }
        field(3; Description; Text[250])
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; Date; Date)
        {
        }
        field(6; "Document No."; Code[20])
        {
        }
        field(7; Location; Code[20])
        {
        }
        field(8; "count"; Integer)
        {
            CalcFormula = Count("Transfer Amount");
            FieldClass = FlowField;
        }
        field(9; "Account Head"; Text[30])
        {
            CalcFormula = Lookup("G/L Account".Name WHERE("No." = FIELD("Account No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Document No.")
        {
        }
    }

    fieldgroups
    {
    }
}

