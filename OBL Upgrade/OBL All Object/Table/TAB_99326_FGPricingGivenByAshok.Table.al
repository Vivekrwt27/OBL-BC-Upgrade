table 99326 "FG Pricing Given By Ashok"
{

    fields
    {
        field(1; "Item No."; Code[20])
        {
        }
        field(2; "Location Code"; Code[20])
        {
        }
        field(3; "Rate/Sqm"; Decimal)
        {
        }
        field(4; UOM; Code[10])
        {

            trigger OnValidate()
            begin
                IF RecItem.GET("Item No.") THEN BEGIN
                    IF RecItem."Base Unit of Measure" = 'SQ.MT' THEN BEGIN
                        IF RecItemUOM.GET("Item No.", UOM) THEN BEGIN
                            "Rate/UOM" := "Rate/Sqm" * RecItemUOM."Qty. per Unit of Measure";
                        END;
                    END;
                END;
            end;
        }
        field(5; "Qty. in UOM"; Decimal)
        {
        }
        field(6; "Qty. In Sqm"; Decimal)
        {
        }
        field(7; "Rate/UOM"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Item No.", "Location Code")
        {
            Clustered = true;
        }
        key(Key2; UOM)
        {
            SumIndexFields = "Qty. in UOM";
        }
    }

    fieldgroups
    {
    }

    var
        RecItem: Record Item;
        RecItemUOM: Record "Item Unit of Measure";
}

