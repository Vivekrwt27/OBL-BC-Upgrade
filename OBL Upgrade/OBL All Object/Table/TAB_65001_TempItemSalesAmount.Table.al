table 65001 "Temp Item Sales Amount"
{

    fields
    {
        field(1; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Customer No."; Code[20])
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
        field(100; "Tableau Product Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(101; "Size Code Desc."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(102; "Type Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(103; NPD; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Item No.", "Customer No.", Period)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

