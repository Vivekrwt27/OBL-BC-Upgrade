tableextension 50272 tableextension50272 extends "Item Vendor"
{
    fields
    {
        field(50000; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            Description = 'report 50008';
            TableRelation = "Item Category";
        }
        field(50001; "Product Group Code"; Code[10])
        {
            Description = 'Tri PG 29112006';
            TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(50002; "Last MRN Date"; Date)
        {
            Description = 'Tri PG 29112006';
        }
        field(50003; "Last Purchase Price"; Decimal)
        {
            Description = 'Tri PG 29112006';
        }
        field(50004; "Last MRN No."; Code[20])
        {
            Description = 'Tri PG 29112006';
        }
    }
    keys
    {
        /* key(Key4; "Item Category Code", "Vendor No.")
         {
         }*///15578
    }

    procedure GetItemCategory()
    begin
        IF "Item No." <> '' THEN BEGIN
            Item.GET("Item No.");
            "Item Category Code" := Item."Item Category Code";
        END;
    end;

    var
        LicensePermission: Record "License Permission";
        Item: Record Item;
}

