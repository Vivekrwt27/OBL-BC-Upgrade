tableextension 50232 tableextension50232 extends "G/L - Item Ledger Relation"
{
    fields
    {
        field(50000; "Gl Amt"; Decimal)
        {
            CalcFormula = Sum("G/L Entry".Amount WHERE("Entry No." = FIELD("G/L Entry No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Val Amt"; Decimal)
        {
            CalcFormula = Sum("Value Entry"."Cost Amount (Actual)" WHERE("Entry No." = FIELD("Value Entry No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Gl Account"; Code[20])
        {
            CalcFormula = Lookup("G/L Entry"."G/L Account No." WHERE("Entry No." = FIELD("G/L Entry No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Posting Date"; Date)
        {
            CalcFormula = Lookup("G/L Entry"."Posting Date" WHERE("Entry No." = FIELD("G/L Entry No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }
}

