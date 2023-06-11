tableextension 50013 tableextension50013 extends "Purch. Cr. Memo Line"
{
    fields
    {


        field(50000; "Rejection Reason Code"; Code[20])
        {
            Description = 'Customization No. 10';
            TableRelation = "Return Reason";
        }
        field(50001; "Shortage Reason Code"; Code[20])
        {
            Description = 'Customization No. 10';
            TableRelation = "Return Reason";
        }
        field(50002; "Challan Quantity"; Decimal)
        {
            Description = 'Customization No. 10';
        }
        field(50003; "Actual Quantity"; Decimal)
        {
            Description = 'Customization No. 10';
        }
        field(50004; "Accepted Quantity"; Decimal)
        {
            Description = 'Customization No. 10';
        }
        field(50005; "Shortage Quantity"; Decimal)
        {
            Description = 'Customization No. 10';
        }
        field(50006; "Rejected Quantity"; Decimal)
        {
            Description = 'Customization No. 10';
        }
        field(50012; Make; Text[30])
        {
        }
        field(50020; "Posting Date 1"; Date)
        {
            Editable = true;
        }
        field(50021; "Posting Date Header"; Date)
        {
            CalcFormula = Lookup("Purch. Cr. Memo Hdr."."Posting Date" WHERE("No." = FIELD("Document No.")));
            Description = 'Tri1.3 PG 10112006 -- Excise Batch';
            FieldClass = FlowField;
        }
        field(50031; "Shortage CRN"; Boolean)
        {
            Description = 'TRI VKG 23.09.10';
        }
    }
    keys
    {
        key(Key6; "No.", "Buy-from Vendor No.", "Posting Date")
        {
        }
    }

    //Unsupported feature: Property Deletion (CaptionML).

}

