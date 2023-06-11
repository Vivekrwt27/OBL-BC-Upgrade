table 50078 "Customer Scheme Details"
{

    fields
    {
        field(10; "Customer No."; Code[20])
        {
            TableRelation = Customer;
        }
        field(20; "Scheme Code"; Code[20])
        {
            TableRelation = "Scheme Master";
        }
        field(30; "Total Target"; Decimal)
        {
        }
        field(60; "With HVP Target"; Decimal)
        {
        }
        field(70; "Without HVP Target"; Decimal)
        {
        }
        field(80; "Target Achieved - HVP"; Decimal)
        {
            CalcFormula = Sum("Scheme Entries"."Target Sales" WHERE("Customer No." = FIELD("Customer No."),
                                                                     "Scheme" = FIELD("Scheme Code"),
                                                                     "HVP" = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85; "Target Achieved - Non-HVP"; Decimal)
        {
            CalcFormula = Sum("Scheme Entries"."Eligible Sales" WHERE("Customer No." = FIELD("Customer No."),
                                                                       "Scheme" = FIELD("Scheme Code"),
                                                                       "HVP" = CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(90; "Total Target Achieved"; Decimal)
        {
            CalcFormula = Sum("Scheme Entries"."Eligible Sales" WHERE("Customer No." = FIELD("Customer No."),
                                                                       Scheme = FIELD("Scheme Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(95; "Total Turnover"; Decimal)
        {
            CalcFormula = Sum("Scheme Entries"."Target Sales" WHERE("Customer No." = FIELD("Customer No."),
                                                                     Scheme = FIELD("Scheme Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(100; "Incentive %age HVP"; Decimal)
        {
        }
        field(110; "Incentive %age Non-HVP"; Decimal)
        {
        }
        field(120; Status; Option)
        {
            OptionCaption = ' ,Signed,Not-Signed,Not Interested';
            OptionMembers = " ",Signed,"Not-Signed","Not Interested";
        }
        field(130; PCH; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(140; "Sales Person Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(145; ZM; Code[10])
        {
        }
        field(150; "Zonal Heads"; Code[10])
        {
        }
        field(160; "Area"; Code[10])
        {
        }
        field(50000; "Customer Name"; Text[250])
        {
            CalcFormula = Lookup("Customer"."Name" WHERE("No." = FIELD("Customer No.")));
            FieldClass = FlowField;
        }
        field(50001; Outstanding; Decimal)
        {
        }
        field(50002; "Over Due"; Decimal)
        {
        }
        field(50003; "Pending Invoice"; Decimal)
        {
        }
        field(80000; "Tableau Target Achieved - HVP"; Decimal)
        {
            Editable = false;
        }
        field(80010; "Tableau Target Achieved-NonHVP"; Decimal)
        {
            Editable = false;
        }
        field(80020; "Tableau Total Target Achieved"; Decimal)
        {
            Editable = false;
        }
        field(80030; "Tableau Total Turnover"; Decimal)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Customer No.", "Scheme Code")
        {
            Clustered = true;
        }
        key(Key2; "Scheme Code", "Total Target")
        {
        }
    }

    fieldgroups
    {
    }
}

