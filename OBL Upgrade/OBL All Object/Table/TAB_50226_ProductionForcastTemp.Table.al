table 50226 "Production Forcast Temp"
{

    fields
    {
        field(1; "Sales Order No."; Code[20])
        {
        }
        field(2; "Line No"; Integer)
        {
        }
        field(3; "FG Item"; Code[20])
        {
            TableRelation = Item;
        }
        field(4; "RM Item Code"; Code[20])
        {
            TableRelation = Item;
        }
        field(5; "FG Qty"; Decimal)
        {
        }
        field(6; "RM Qty"; Decimal)
        {
            DecimalPlaces = 5 : 5;
        }
        field(7; "Prod. Bom No."; Code[20])
        {
        }
        field(8; "Required Qty"; Decimal)
        {
            DecimalPlaces = 5 : 5;
        }
        field(9; "Item Inventory"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("RM Item Code")));
            FieldClass = FlowField;
        }
        field(10; Level; Integer)
        {
        }
        field(11; "Net Requirement"; Decimal)
        {
        }
        field(12; "FG Inventory"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("FG Item")));
            FieldClass = FlowField;
        }
        field(13; "Stock Qty"; Decimal)
        {
        }
        field(14; Flag; Boolean)
        {

            trigger OnValidate()
            begin
                /*RecItem.RESET;
                IF RecItem.GET("RM Item Code") THEN
                RecItem.CALCFIELDS(Inventory);
                "Net Requirement"  :="Required Qty" -RecItem.Inventory;
                MODIFY;
                */

            end;
        }
        field(15; "Level One Minus Qty"; Decimal)
        {
            DecimalPlaces = 2 : 7;
        }
        field(16; "BOM Requirement Qty"; Decimal)
        {
            DecimalPlaces = 2 : 7;
        }
        field(17; "Conversion Factor"; Decimal)
        {
            DecimalPlaces = 2 : 7;

            trigger OnValidate()
            begin
                IF Level = 1 THEN
                    "Conversion Factor" := 1;

                Const := 1;
                FOR i := 1 TO 15 DO BEGIN
                    RecMRP.RESET;
                    RecMRP.SETFILTER("Line No", '<=%1', "Line No");
                    RecMRP.SETFILTER(Level, '%1', Level - i);
                    IF RecMRP.FINDLAST THEN BEGIN
                        Const := Const * (RecMRP."Conversion Factor" * RecMRP."BOM Requirement Qty");
                        //    MESSAGE('%1-%2-%3-%4',i,RecMRP."Conversion Factor" ,RecMRP."BOM Requirement Qty",Const);
                    END;
                END;
                "Actual Conversion" := ("Conversion Factor" * "BOM Requirement Qty" * Const);
                "XYZ Calculated" := "Actual Conversion" * "FG Qty";
            end;
        }
        field(18; "Actual Conversion"; Decimal)
        {
            DecimalPlaces = 2 : 7;
        }
        field(19; "Production BOM Code"; Code[20])
        {
        }
        field(20; "XYZ Calculated"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
            Clustered = true;
        }
        key(Key2; "FG Item", "RM Item Code")
        {
        }
        key(Key3; "FG Item", "Sales Order No.")
        {
        }
        key(Key4; "RM Item Code")
        {
        }
        key(Key5; "FG Item", Level, "RM Item Code")
        {
        }
        key(Key6; "FG Item", "Line No", "RM Item Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        RecItem: Record Item;
        "Const": Decimal;
        RecMRP: Record "Production Forcast Temp";
        i: Integer;
}

