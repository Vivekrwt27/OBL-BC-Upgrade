tableextension 50277 tableextension50277 extends "Production BOM Line"
{
    fields
    {
        field(50002; "Description 2"; Text[30])
        {
        }
        field(50004; "Scrap Item"; Boolean)
        {
            Description = 'TRI V.D 21.06.2010 New Field Added';

            trigger OnValidate()
            begin
                //TRI V.D 21.06.2010 START
                IF NOT "Scrap Item" THEN
                    TESTFIELD("Scrap Qty Per Square Meter", 0);
                //TRI V.D 21.06.2010 STOP
            end;
        }
        field(50006; "Scrap Qty Per Square Meter"; Decimal)
        {
            Description = 'TRI V.D 21.06.2010 New Field Added';

            trigger OnValidate()
            begin
                //TRI V.D 21.06.2010 START
                TESTFIELD("Scrap Item", TRUE);
                IF "Scrap Qty Per Square Meter" <> 0 THEN BEGIN
                    tgProdBOMLine.RESET;
                    tgProdBOMLine.SETRANGE(tgProdBOMLine."Production BOM No.", "Production BOM No.");
                    tgProdBOMLine.SETRANGE(tgProdBOMLine."Version Code", "Version Code");
                    tgProdBOMLine.SETRANGE(tgProdBOMLine."No.", "No.");
                    tgProdBOMLine.SETRANGE(tgProdBOMLine."Scrap Item", TRUE);
                    IF tgProdBOMLine.FINDSET THEN
                        IF tgProdBOMLine.COUNT > 1 THEN
                            ERROR(tgText002, "No.", "Production BOM No.");
                END;
                //TRI V.D 21.06.2010 STOP
            end;
        }
        field(50007; "Production BOM Desc"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Production BOM No.")));
            Description = 'ori ut';
            FieldClass = FlowField;
        }
        field(50008; "Production BOM Desc2"; Text[100])
        {
            CalcFormula = Lookup(Item."Description 2" WHERE("No." = FIELD("Production BOM No.")));
            Description = 'ori ut';
            FieldClass = FlowField;
        }
        field(50009; "Ref code"; Code[20])
        {
            //15578 CalcFormula = Lookup (Item."Old Code" WHERE ("No."=FIELD("No.")));
            // FieldClass = FlowField;
        }
        field(50010; BomNo; Code[20])
        {
            CalcFormula = Lookup(Item."Production BOM No." WHERE("No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(85000; "Not Required"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        tgProdBOMLine: Record "Production BOM Line";
        tgText002: Label 'Item No. %1 cannot be a scrap Item twice in a same Prod. BOM No. %2.';
}

