table 50068 "CD Applicable"
{

    fields
    {
        field(1; "State Code"; Code[10])
        {
        }
        field(5; Type; Option)
        {
            OptionCaption = ' ,Customer Type,Customer';
            OptionMembers = " ","Customer Type",Customer;
        }
        field(10; "Code"; Code[20])
        {
            TableRelation = IF (Type = FILTER("Customer Type")) "Customer Type".Code
            ELSE
            IF (Type = FILTER(Customer)) "Customer"."No." WHERE(Blocked = CONST(" "));

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                IF Type = Type::Customer THEN BEGIN
                    Customer.GET(Code);
                    "State Code" := Customer."State Code";
                END;
            end;
        }
        field(25; Include; Boolean)
        {
        }
        field(40; "Days Slab 0"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Days Slab 1"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Days Slab 2"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Days Slab 3"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Days Slab 4"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Days Slab 5"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(75; "Days Slab 6"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "State Code", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        Customer: Record Customer;
    begin
        IF Type = Type::Customer THEN BEGIN
            Customer.GET(Code);
            "State Code" := Customer."State Code";
        END;
    end;
}

