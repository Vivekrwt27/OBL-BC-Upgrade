table 51090 "BOM Component temp"
{

    fields
    {
        field(1; "Parent Item No."; Code[20])
        {
            Caption = 'Parent Item No.';
            NotBlank = true;
            TableRelation = Item;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Item,Resource';
            OptionMembers = " ",Item,Resource;
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST(Item)) Item
            ELSE
            IF (Type = CONST(Resource)) Resource;
        }
        field(5; "Bill of Materials"; Boolean)
        {
            CalcFormula = Exist("BOM Component" WHERE(Type = CONST(Item),
                                                       "Parent Item No." = FIELD("No.")));
            Caption = 'Bill of Materials';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(7; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            IF (Type = CONST(Resource)) "Unit of Measure";
        }
        field(8; "Quantity per"; Decimal)
        {
            Caption = 'Quantity per';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(9; Position; Code[10])
        {
            Caption = 'Position';
        }
        field(10; "Position 2"; Code[10])
        {
            Caption = 'Position 2';
        }
        field(11; "Position 3"; Code[10])
        {
            Caption = 'Position 3';
        }
        field(12; "Machine No."; Code[10])
        {
            Caption = 'Machine No.';
        }
        field(13; "Production Lead Time"; Integer)
        {
            Caption = 'Production Lead Time';
        }
        field(14; "BOM Description"; Text[30])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Parent Item No.")));
            Caption = 'BOM Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("No."));
        }
        field(5900; "Installed in Line No."; Integer)
        {
            Caption = 'Installed in Line No.';
        }
        field(5901; "Installed in Item No."; Code[20])
        {
            Caption = 'Installed in Item No.';
            TableRelation = IF (Type = CONST(Item)) Item;
        }
    }

    keys
    {
        key(Key1; "Parent Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record Item;
        Res: Record Resource;
        ItemVariant: Record "Item Variant";
        BOMComp: Record "BOM Component";
        BillOfMaterials: Page "Assembly BOM";
        Text000: Label '%1 cannot be component of itself.';
}

