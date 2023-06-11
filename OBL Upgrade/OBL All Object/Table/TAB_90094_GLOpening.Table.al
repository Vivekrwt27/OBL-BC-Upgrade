table 90094 "GL Opening"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; "Document No"; Code[20])
        {
        }
        field(4; "Code"; Code[20])
        {
        }
        field(5; Reference; Code[20])
        {
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; Location; Code[10])
        {
        }
        field(8; Type; Option)
        {
            OptionMembers = Invoice,Payment,"Credit Memo";
        }
        field(9; "count"; Integer)
        {
            CalcFormula = Count("GL Opening");
            FieldClass = FlowField;
        }
        field(10; Bal; Code[20])
        {
        }
        field(11; "Account Type"; Option)
        {
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(12; "Customer Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

