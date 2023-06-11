table 50059 "Auto Mail Detailed"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Editable = true;
        }
        field(2; "PDF Created"; Boolean)
        {
            Editable = false;
        }
        field(3; "PDF Mailed"; Boolean)
        {
            Editable = true;
        }
        field(4; "Sales Invoice No."; Code[20])
        {
            Editable = true;
        }
        field(5; "DateTime PDF Creation"; DateTime)
        {
            Editable = false;
        }
        field(6; "DateTime Mail Sent"; DateTime)
        {
            Editable = false;
        }
        field(7; "Customer Email Id"; Text[100])
        {
        }
        field(8; CustName; Text[50])
        {
        }
        field(9; SalesPersonEmail; Text[60])
        {
        }
        field(10; PCHemail; Text[60])
        {
        }
    }

    keys
    {
        key(Key1; "Document No.")
        {
            Clustered = true;
        }
        key(Key2; "DateTime PDF Creation")
        {
        }
    }

    fieldgroups
    {
    }
}

