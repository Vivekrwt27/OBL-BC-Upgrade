table 50067 "State Wise CD Slabs"
{

    fields
    {
        field(1; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,State,Customer';
            OptionMembers = " ",State,Customer;
        }
        field(3; "State/Customer Code"; Code[20])
        {
            TableRelation = IF (Type = FILTER(State)) State
            ELSE
            IF (Type = FILTER(Customer)) "Customer"."No." WHERE(Blocked = FILTER(' '));
        }
        field(5; "Effective Date"; Date)
        {
        }
        field(10; "Slab 1"; Decimal)
        {
        }
        field(15; "Slab 2"; Decimal)
        {
        }
        field(20; "Slab 3"; Decimal)
        {
        }
        field(30; "Slab 4"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Slab 5"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Slab 6"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Type, "State/Customer Code", "Effective Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

