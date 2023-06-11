table 50053 Slabs
{
    //LookupPageID = 50118;//16225 PAGE N/F

    fields
    {
        field(1; "Slab Group"; Code[20])
        {
        }
        field(2; "Qty (Sq Mt.)"; Decimal)
        {
        }
        field(3; "Discount Amount"; Decimal)
        {
        }
        field(4; Period; Option)
        {
            OptionMembers = Monthly,Quaterly,"Half Yearly",Yearly;
        }
        field(5; Description; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Slab Group", "Qty (Sq Mt.)")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

