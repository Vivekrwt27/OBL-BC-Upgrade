table 65000 "Temp Customer Sales Amount"
{

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Period; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Sales Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Customer No.", Period)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

