table 50056 "IC In Line"
{

    fields
    {
        field(10; "Document Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Inter Company';
            OptionMembers = "Inter Company";
        }
        field(20; "Document No."; Code[20])
        {
            Editable = false;
        }
        field(30; "Line No."; Integer)
        {
            Editable = false;
        }
        field(40; "Item No."; Code[20])
        {
            TableRelation = Item;
            ValidateTableRelation = false;
        }
        field(50; Description; Text[50])
        {
            Editable = false;
        }
        field(51; "Description 2"; Text[50])
        {
            Editable = false;
        }
        field(60; Quantity; Decimal)
        {
            Editable = false;
        }
        field(70; "From Company"; Text[30])
        {
            Editable = false;
        }
        field(80; "To Company"; Text[30])
        {
            Editable = false;
            TableRelation = Company;
        }
        field(90; "From Location"; Code[10])
        {
            Editable = false;
        }
        field(100; "To Location"; Code[10])
        {
            Editable = false;
        }
        field(110; "Posting Date"; Date)
        {
            Editable = false;
        }
        field(120; "Shortcut Dimesion 1 Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(130; "Shortcut Dimesion 2 Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(140; "Transfer Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Transfer In, Transfer Out';
            OptionMembers = "Transfer In"," Transfer Out";
        }
        field(150; UOM; Code[10])
        {
            Editable = false;
            TableRelation = "Item Unit of Measure"."Item No." WHERE("Item No." = FIELD("Item No."));
        }
        field(160; "DT UOM"; Code[10])
        {
            Editable = false;
        }
        field(170; "Variant Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(50001; "IC Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'IC Gen. Bus. Posting Group';
            Description = 'MSBS.Rao';
            Editable = false;
            TableRelation = "Gen. Business Posting Group";
        }
        field(50002; "From Item No."; Code[20])
        {
            Editable = false;
            TableRelation = Item."No." WHERE("Item Category Code" = FIELD("Item Category Code"));
            ValidateTableRelation = false;
        }
        field(50003; "Item Category Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Item Category";
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "To Location", "Posting Date", "Document No.", "Item No.")
        {
        }
    }

    fieldgroups
    {
    }
}

