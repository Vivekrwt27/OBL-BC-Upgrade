tableextension 50207 tableextension50207 extends "Item Variant"
{
    // 
    // 1.TRI S.R 230310 - New field Added
    fields
    {
        field(50000; "Batch Code"; Code[4])
        {
            Description = 'TRI S.R 230310 - New field Add';
        }
        field(50001; Blocked; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Enabled = true;
        }
        field(50002; "Varient Codes"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code" WHERE("Varient Codes" = FILTER(true),
                                                 Blocked = FILTER(false));
        }
        field(50003; "Variant Wise Inventory"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                  "Variant Code" = FIELD(Code),
                                                                  "Location Code" = FIELD(FILTER("Location Filter"))));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Location Filter"; Code[10])
        {
            FieldClass = FlowFilter;
        }
    }
}

