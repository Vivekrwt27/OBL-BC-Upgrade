table 50037 "SMS - Mobile No."
{
    // DrillDownPageID = 50011;//16225 PAGE N/F
    // LookupPageID = 50011; //16225 PAGE N/F

    fields
    {
        field(1; "Mobile No."; Code[30])
        {
        }
        field(2; "Link With"; Option)
        {
            OptionCaption = ' ,Customer,Vendor,Bank,Contact,SalesPerson';
            OptionMembers = " ",Customer,Vendor,Bank,Contact,SalesPerson;
        }
        field(3; "Link Code"; Code[20])
        {
            TableRelation = IF ("Link With" = CONST("Customer")) "Customer"."No."
            ELSE
            IF ("Link With" = CONST("Vendor")) "Vendor"."No."
            ELSE
            IF ("Link With" = CONST("Bank")) "Bank Account"."No."
            ELSE
            IF ("Link With" = CONST("Contact")) "Contact"."No."
            ELSE
            IF ("Link With" = CONST("SalesPerson")) "Salesperson/Purchaser"."Code";
        }
        field(20; Name; Text[100])
        {
        }
        field(30; Description; Text[100])
        {
        }
        field(40; "Send Mobile Communication"; Boolean)
        {
        }
        field(500; "Send Generic Message"; Boolean)
        {
        }
        field(2000; Selected; Boolean)
        {
        }
        field(2001; date; Date)
        {
        }
        field(2002; Type; Option)
        {
            OptionCaption = ' ,PCH,Sales Person,Govt.SP,Private SP';
            OptionMembers = " ",PCH,"Sales Person","Govt.SP","Private SP";
        }
    }

    keys
    {
        key(Key1; "Mobile No.", "Link With", "Link Code", Type)
        {
            Clustered = true;
        }
        key(Key2; "Mobile No.", "Send Generic Message")
        {
        }
    }

    fieldgroups
    {
    }
}

