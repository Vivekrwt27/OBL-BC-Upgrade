table 50049 "IC Out Line"
{

    fields
    {
        field(10; "Document Type"; Option)
        {
            OptionCaption = 'Inter Company';
            OptionMembers = "Inter Company";
        }
        field(20; "Document No."; Code[20])
        {
        }
        field(30; "Line No."; Integer)
        {
        }
        field(40; "Item No."; Code[20])
        {
            TableRelation = Item;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50; Description; Text[50])
        {
        }
        field(51; "Description 2"; Text[50])
        {
        }
        field(60; Quantity; Decimal)
        {
        }
        field(70; "From Company"; Text[30])
        {
        }
        field(80; "To Company"; Text[30])
        {
            TableRelation = Company;
        }
        field(90; "From Location"; Code[10])
        {
        }
        field(100; "To Location"; Code[10])
        {
        }
        field(110; "Posting Date"; Date)
        {
        }
        field(120; "Shortcut Dimension 1 Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(130; "Shortcut Dimension 2 Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(140; "Transfer Type"; Option)
        {
            OptionCaption = 'Transfer In, Transfer Out';
            OptionMembers = "Transfer In"," Transfer Out";
        }
        field(150; UOM; Code[10])
        {
            TableRelation = "Item Unit of Measure"."Item No." WHERE("Item No." = FIELD("Item No."));
        }
        field(160; "DT UOM"; Code[10])
        {
        }
        field(170; "Variant Code"; Code[10])
        {
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(50001; "IC Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'IC Gen. Bus. Posting Group';
            Description = 'MSBS.Rao';
            TableRelation = "Gen. Business Posting Group";
        }
        field(50002; "From Item No."; Code[20])
        {
            TableRelation = Item."No." WHERE("Item Category Code" = FIELD("Item Category Code"));
            ValidateTableRelation = false;
        }
        field(50003; "Item Category Code"; Code[20])
        {
            TableRelation = "Item Category";
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "From Location", "Posting Date", "Document No.", "Item No.")
        {
        }
    }

    fieldgroups
    {
    }
}

