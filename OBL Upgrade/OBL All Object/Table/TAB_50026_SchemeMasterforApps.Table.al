table 50026 "Scheme Master for Apps"
{

    fields
    {
        field(1; "Scheme Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Date & Time of Update"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Customer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;

            trigger OnValidate()
            begin
                IF Customer.GET("Customer Code") THEN
                    "Customer Name" := Customer.Name;
                City := Customer.City;

            end;
        }
        field(4; "Customer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; City; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Unit of Target"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Number of Slabs"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Slab 1 Target"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Slab 2 Target"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Slab 3 Target"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Slab 4 Target"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Slab 5 Target"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Slab 6 Target"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Slab 7 Target"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Current Achievement"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Slab 1 Reward"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Slab 2 Reward"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Slab 3 Reward"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Slab 4 Reward"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Slab 5 Reward"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Slab 6 Reward"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Slab 7 Reward"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "% Achievement on Slab 1"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Scheme Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Customer: Record 18;
}

