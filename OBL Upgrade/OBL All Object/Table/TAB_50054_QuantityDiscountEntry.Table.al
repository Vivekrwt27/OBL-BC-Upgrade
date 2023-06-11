table 50054 "Quantity Discount Entry"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Document Type"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(3; "Document No."; Code[20])
        {
        }
        field(4; "Sell to Customer Code"; Code[20])
        {
            TableRelation = Customer;
        }
        field(5; "Invoice Amount"; Decimal)
        {
        }
        field(6; "Applicable Quantity"; Decimal)
        {
        }
        field(7; "Quantity Discount Accrued"; Decimal)
        {
        }
        field(8; "QD Given Amount"; Decimal)
        {
        }
        field(9; "Document Date"; Date)
        {
        }
        field(10; Period; Option)
        {
            OptionCaption = 'Monthly,Quaterly,Half Yearly,Yearly';
            OptionMembers = Monthly,Quaterly,"Half Yearly",Yearly;
        }
        field(11; "Scheme Code"; Code[20])
        {
        }
        field(12; "Total Document Quantity"; Decimal)
        {
        }
        field(13; "Accrued Entry"; Boolean)
        {
        }
        field(14; "Posting Date"; Date)
        {
        }
        field(15; "Accrued Quantity"; Decimal)
        {
        }
        field(16; "Posted Document No."; Code[20])
        {
        }
        field(17; "Slab Rate"; Decimal)
        {
        }
        field(18; Month; Integer)
        {
        }
        field(19; Year; Integer)
        {
        }
        field(20; BiPass; Boolean)
        {
        }
        field(50000; "Old QD Given Amt"; Decimal)
        {
        }
        field(50001; "Old Accrued Qty"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Sell to Customer Code", "Posting Date")
        {
        }
        key(Key3; "Sell to Customer Code", Month, Year, "Posted Document No.")
        {
        }
        key(Key4; "Sell to Customer Code", "Posting Date", "Scheme Code")
        {
            SumIndexFields = "QD Given Amount", "Accrued Quantity";
        }
        key(Key5; "Posted Document No.", "Posting Date")
        {
        }
        key(Key6; "Posted Document No.", "Sell to Customer Code")
        {
        }
    }

    fieldgroups
    {
    }
}

