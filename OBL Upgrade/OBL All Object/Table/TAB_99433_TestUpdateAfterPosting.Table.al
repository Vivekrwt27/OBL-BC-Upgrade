table 99433 "Test Update After Posting"
{

    fields
    {
        field(1; Type; Option)
        {
            OptionCaption = ' ,Vendor,Customer';
            OptionMembers = " ",Vendor,Customer;
        }
        field(2; "Entry No."; Integer)
        {
        }
        field(3; "Closed By Entry No."; Integer)
        {
        }
        field(4; "Entry Type"; Option)
        {
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(5; "Closed By Amount"; Decimal)
        {
        }
        field(6; Description; Text[200])
        {
        }
        field(7; "Document No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; Type, "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

