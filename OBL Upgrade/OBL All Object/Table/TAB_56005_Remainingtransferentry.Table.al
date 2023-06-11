table 56005 "Remaining transfer entry"
{

    fields
    {
        field(1; ID; Integer)
        {
        }
        field(2; "Posting Date"; Date)
        {
        }
        field(3; "Transfer Order"; Code[20])
        {
        }
        field(4; "Doc No."; Code[20])
        {
        }
        field(5; "Account No."; Code[10])
        {
        }
        field(6; "Debit Amount"; Decimal)
        {
        }
        field(7; "Credit Amount"; Decimal)
        {
        }
        field(8; "Account Desc."; Text[30])
        {
            CalcFormula = Lookup("G/L Account".Name WHERE("No." = FIELD("Account No.")));
            FieldClass = FlowField;
        }
        field(9; Year; Integer)
        {
        }
        field(10; Month; Integer)
        {
        }
        field(11; Type; Code[1])
        {
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
        key(Key2; Year, Month, "Posting Date", "Transfer Order", "Account No.")
        {
            SumIndexFields = "Debit Amount", "Credit Amount";
        }
        key(Key3; "Transfer Order")
        {
        }
        key(Key4; Year, Month, "Posting Date", "Account No.")
        {
            SumIndexFields = "Debit Amount", "Credit Amount";
        }
        key(Key5; Year, Month, "Account No.")
        {
            SumIndexFields = "Debit Amount", "Credit Amount";
        }
    }

    fieldgroups
    {
    }
}

