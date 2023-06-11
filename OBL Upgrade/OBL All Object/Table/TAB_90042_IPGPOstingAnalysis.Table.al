table 90042 "IPG POsting Analysis"
{

    fields
    {
        field(1; "GL Account"; Code[20])
        {
            Editable = false;
        }
        field(2; "Inventory Posting Group"; Code[10])
        {
            Editable = false;
        }
        field(3; "G/L Account Name"; Text[30])
        {
            CalcFormula = Lookup("G/L Account".Name WHERE("No." = FIELD("GL Account")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "IPG Name"; Text[30])
        {
            CalcFormula = Lookup("Inventory Posting Group".Description WHERE("Code" = FIELD("Inventory Posting Group")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Debit Amount"; Decimal)
        {
            CalcFormula = Sum("G/L Entry"."Debit Amount" WHERE("G/L Account No." = FIELD("GL Account"),
                                                                "Inventory Posting Group" = FIELD("Inventory Posting Group"),
                                                                "Posting Date" = FIELD("Date Filter"),
                                                                "Source Code" = FIELD("Source Code Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Credit Amount"; Decimal)
        {
            CalcFormula = Sum("G/L Entry"."Credit Amount" WHERE("G/L Account No." = FIELD("GL Account"),
                                                                 "Inventory Posting Group" = FIELD("Inventory Posting Group"),
                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                 "Source Code" = FIELD("Source Code Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Net Change"; Decimal)
        {
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("GL Account"),
                                                        "Inventory Posting Group" = FIELD("Inventory Posting Group"),
                                                        "Posting Date" = FIELD("Date Filter"),
                                                        "Source Code" = FIELD("Source Code Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(9; "Source Code Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Source Code";
        }
    }

    keys
    {
        key(Key1; "GL Account", "Inventory Posting Group")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

