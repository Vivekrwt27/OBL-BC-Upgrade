table 50010 "Customer Type"
{
    Caption = 'Type';
    // LookupPageID = 50013;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Description = 'Cust 22';
        }
        field(2; Description; Text[50])
        {
            Description = 'Cust 22';
        }
        field(3; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            Description = 'Cust 22';
            TableRelation = "Gen. Business Posting Group";
        }
        field(4; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            Description = 'Cust 22';
            TableRelation = "Customer Posting Group";
        }
        field(5; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            Description = 'Cust 22';
            TableRelation = "VAT Business Posting Group";
        }
        field(6; "Excise Bus. Posting Group"; Code[10])
        {
            Description = 'Cust 22';
            //TableRelation = "Excise Bus. Posting Group";//16225 TABLE N/F
        }
        field(7; Structure; Code[10])
        {
            Description = 'Cust 22';
            // TableRelation = "Structure Header".Code;//16225 TABLE N/F
        }
        field(8; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
            Description = 'Cust 22';
        }
        field(9; Type; Option)
        {
            Description = 'Customer,Vendor';
            OptionCaption = 'Customer,Vendor';
            OptionMembers = Customer,Vendor;
        }
        field(22; "Vendor Posting Group"; Code[10])
        {
            Caption = 'Vendor Posting Group';
            Description = 'Cust 22';
            TableRelation = "Vendor Posting Group";
        }
        field(201; "Post Customer Invoice"; Boolean)
        {
        }
        field(202; "Post Customer Cr. Note"; Boolean)
        {
        }
        field(203; "Post Customer Payment"; Boolean)
        {
        }
        field(204; "Post Customer Refund"; Boolean)
        {
        }
        field(205; "Post Customer Due Date"; Boolean)
        {
        }
        field(206; "Post Customer +5 Due Date"; Boolean)
        {
        }
        field(207; "Post Customer -5 Due Date"; Boolean)
        {
        }
        field(209; "Send Msg. on DA Release"; Boolean)
        {
        }
        field(5000; "Send PCH SMS"; Boolean)
        {
        }
        field(5001; "Send Retail SMS"; Boolean)
        {
        }
        field(5002; "Send Govt. SMS"; Boolean)
        {
        }
        field(5003; "Send Private SMS"; Boolean)
        {
        }
        field(9000; "Send DA SP SMS"; Boolean)
        {
        }
        field(9010; "Send DA PCH SMS"; Boolean)
        {
        }
        field(9020; "Send DA Customer SMS"; Boolean)
        {
        }
        field(10001; "Hide Discount"; Boolean)
        {
            Description = 'MSVRN 091117';
        }
    }

    keys
    {
        key(Key1; Type, "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

