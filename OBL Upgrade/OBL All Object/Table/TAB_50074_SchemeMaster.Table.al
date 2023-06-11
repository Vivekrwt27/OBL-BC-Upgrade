table 50074 "Scheme Master"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(10; Description; Text[50])
        {
        }
        field(30; "Scheme Start Date"; Date)
        {
        }
        field(50; "Scheme End Date"; Date)
        {
        }
        field(60; "Incentive Calculation Basis"; Option)
        {
            OptionCaption = ' ,Slab-Basis,Non-Slab Basis';
            OptionMembers = " ","Slab-Basis","Non-Slab Basis";
        }
        field(65; "Incentive %age"; Decimal)
        {

            trigger OnValidate()
            begin
                TESTFIELD("Incentive Calculation Basis", "Incentive Calculation Basis"::"Non-Slab Basis");
            end;
        }
        field(70; "Incentive Calculation ON"; Option)
        {
            OptionCaption = ' ,Turnover,Eligible Sales';
            OptionMembers = " ",Turnover,"Eligible Sales";
        }
        field(75; "Pending Invoice Dates"; Date)
        {
        }
        field(1000; "SMS Template"; Text[250])
        {
        }
        field(1001; "Print HVP Value"; Boolean)
        {
        }
        field(1002; Status; Option)
        {
            OptionCaption = 'Active,Closed';
            OptionMembers = Active,Closed;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

