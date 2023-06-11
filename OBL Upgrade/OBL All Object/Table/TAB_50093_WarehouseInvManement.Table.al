table 50093 "Warehouse Inv Manement"
{
    Caption = 'Warehouse Inv Manement';



    fields
    {
        field(1; "item Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";

            trigger OnValidate()
            begin
                IF Item.GET("item Code") THEN
                    "Complete Desc" := Item."Complete Description"
            end;
        }
        field(2; "Complete Desc"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Location; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code WHERE("Warehouse Location" = CONST(true));
        }
        field(6; "Batch No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Inv_Location; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Qty; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Remaining := Qty
            end;
        }
        field(9; Utilize; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Remaining := Qty - Utilize;
            end;
        }
        field(10; Remaining; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "MFG Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Loading Qty"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Remaining < "Loading Qty" THEN
                    ERROR('There is No Remaining Qty');

                IF "Loading Qty" <> 0 THEN
                    Utilize := Utilize + "Loading Qty";

                Remaining := Qty - Utilize;
            end;
        }
        field(13; Size; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "item Code", Location, "Batch No.", Inv_Location, Qty, Utilize)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record 27;
}

