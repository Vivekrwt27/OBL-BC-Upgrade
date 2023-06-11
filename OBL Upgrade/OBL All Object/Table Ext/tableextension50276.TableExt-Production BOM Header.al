tableextension 50276 tableextension50276 extends "Production BOM Header"
{
    fields
    {
        field(50000; VersionCode; Code[20])
        {
            CalcFormula = Lookup("Production BOM Version"."Version Code" WHERE("Production BOM No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(85000; "Not Required"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(85001; "Last Mod Ver Date"; Date)
        {
            CalcFormula = Max("Production BOM Version"."Last Date Modified" WHERE("Production BOM No." = FIELD("No.")));
            FieldClass = FlowField;
        }
    }
}

