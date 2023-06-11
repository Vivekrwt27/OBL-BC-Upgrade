table 99325 "Transfer Receipt Line Temp"
{
    Caption = 'Transfer Receipt Line';
    LookupPageID = "Posted Transfer Receipt Lines";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(5; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(8; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(9; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(10; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(11; "Inventory Posting Group"; Code[10])
        {
            Caption = 'Inventory Posting Group';
            TableRelation = "Inventory Posting Group";
        }
        field(12; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(14; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            InitValue = 1;
        }
        field(15; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(16; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
        }
        field(17; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
        }
        field(18; "Unit Volume"; Decimal)
        {
            Caption = 'Unit Volume';
            DecimalPlaces = 0 : 5;
        }
        field(21; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(22; "Units per Parcel"; Decimal)
        {
            Caption = 'Units per Parcel';
            DecimalPlaces = 0 : 5;
        }
        field(23; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(24; "Transfer Order No."; Code[20])
        {
            Caption = 'Transfer Order No.';
            TableRelation = "Transfer Header";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(25; "Receipt Date"; Date)
        {
            Caption = 'Receipt Date';
        }
        field(26; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        field(27; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
        }
        field(28; "In-Transit Code"; Code[10])
        {
            Caption = 'In-Transit Code';
            Editable = false;
            TableRelation = Location WHERE("Use As In-Transit" = CONST(true));
        }
        field(29; "Transfer-from Code"; Code[10])
        {
            Caption = 'Transfer-from Code';
            Editable = false;
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(30; "Transfer-to Code"; Code[10])
        {
            Caption = 'Transfer-to Code';
            Editable = false;
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(31; "Item Rcpt. Entry No."; Integer)
        {
            Caption = 'Item Rcpt. Entry No.';
        }
        field(32; "Shipping Time"; DateFormula)
        {
            Caption = 'Shipping Time';
        }
        field(7301; "Transfer-To Bin Code"; Code[20])
        {
            Caption = 'Transfer-To Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Transfer-to Code"),
                                            "Item Filter" = FIELD("Item No."),
                                            "Variant Filter" = FIELD("Variant Code"));
        }
        field(13701; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
        }
        field(13702; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(13703; "Excise Calculation Type"; Option)
        {
            Caption = 'Excise Calculation Type';
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %","Amount/Unit","% of Accessable Value","Excise %+Amount/Unit";
        }
        field(13704; "Excise %"; Decimal)
        {
            Caption = 'Excise %';
        }
        field(13705; "AED(GSI) Calculation Type"; Option)
        {
            Caption = 'AED(GSI) Calculation Type';
            OptionCaption = 'Percentage,Amount';
            OptionMembers = Percentage,Amount;
        }
        field(13706; "AED(GSI) % / Amount"; Decimal)
        {
            Caption = 'AED(GSI) % / Amount';
        }
        field(13707; "SED Calculation Type"; Option)
        {
            Caption = 'SED Calculation Type';
            OptionCaption = 'Percentage,Amount';
            OptionMembers = Percentage,Amount;
        }
        field(13708; "SED % / Amount"; Decimal)
        {
            Caption = 'SED % / Amount';
        }
        field(13709; "BED Amount"; Decimal)
        {
            Caption = 'BED Amount';
        }
        field(13710; "AED(GSI) Amount"; Decimal)
        {
            Caption = 'AED(GSI) Amount';
        }
        field(13711; "SED Amount"; Decimal)
        {
            Caption = 'SED Amount';
        }
        field(13712; "SAED Calculation Type"; Option)
        {
            Caption = 'SAED Calculation Type';
            OptionCaption = 'Percentage,Amount';
            OptionMembers = Percentage,Amount;
        }
        field(13713; "SAED % / Amount"; Decimal)
        {
            Caption = 'SAED % / Amount';
        }
        field(13714; "CESS Calculation Type"; Option)
        {
            Caption = 'CESS Calculation Type';
            OptionCaption = 'Percentage,Amount';
            OptionMembers = Percentage,Amount;
        }
        field(13715; "CESS % / Amount"; Decimal)
        {
            Caption = 'CESS % / Amount';
        }
        field(13716; "NCCD Calculation Type"; Option)
        {
            Caption = 'NCCD Calculation Type';
            OptionCaption = 'Percentage,Amount';
            OptionMembers = Percentage,Amount;
        }
        field(13717; "NCCD % / Amount"; Decimal)
        {
            Caption = 'NCCD % / Amount';
        }
        field(13718; "eCess Calculation Type"; Option)
        {
            Caption = 'eCess Calculation Type';
            OptionCaption = 'Percentage,Amount';
            OptionMembers = Percentage,Amount;
        }
        field(13719; "eCess % / Amount"; Decimal)
        {
            Caption = 'eCess % / Amount';
        }
        field(13720; "SAED Amount"; Decimal)
        {
            Caption = 'SAED Amount';
        }
        field(13721; "CESS Amount"; Decimal)
        {
            Caption = 'CESS Amount';
        }
        field(13722; "NCCD Amount"; Decimal)
        {
            Caption = 'NCCD Amount';
        }
        field(13723; "eCess Amount"; Decimal)
        {
            Caption = 'eCess Amount';
        }
        field(13724; "Excise Amount"; Decimal)
        {
            Caption = 'Excise Amount';
        }
        field(13725; "Amount Including Excise"; Decimal)
        {
            Caption = 'Amount Including Excise';
        }
        field(13726; "Excise Accounting Type"; Option)
        {
            Caption = 'Excise Accounting Type';
            OptionCaption = 'With CENVAT,Without CENVAT';
            OptionMembers = "With CENVAT","Without CENVAT";
        }
        field(13727; "Excise Prod. Posting Group"; Code[10])
        {
            Caption = 'Excise Prod. Posting Group';
            // TableRelation = "Excise Prod. Posting Group"; //16225 TABLE N/F
        }
        field(13728; "Excise Bus. Posting Group"; Code[10])
        {
            Caption = 'Excise Bus. Posting Group';
            //  TableRelation = "Excise Bus. Posting Group"; //16225 TABLE N/F
        }
        field(13730; "Capital Item"; Boolean)
        {
            Caption = 'Capital Item';
        }
        field(13738; "Excise Base Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Excise Base Amount';
            Editable = false;
        }
        field(13775; "Amount Added to Excise Base"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount Added to Excise Base';
            Editable = false;
        }
        field(13777; "Amount Added to Inventory"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount Added to Inventory';
            Editable = false;
        }
        field(13778; "Charges to Transfer"; Decimal)
        {
            Caption = 'Charges to Transfer';
            Editable = false;
        }
        field(13779; "Total Amount to Transfer"; Decimal)
        {
            Caption = 'Total Amount to Transfer';
            Editable = false;
        }
        field(13780; "Claim Deferred Excise"; Boolean)
        {
            Caption = 'Claim Deferred Excise';
        }
        field(16450; "ADET Calculation Type"; Option)
        {
            Caption = 'ADET Calculation Type';
            OptionCaption = 'Percentage,Amount';
            OptionMembers = Percentage,Amount;
        }
        field(16451; "ADET % / Amount"; Decimal)
        {
            Caption = 'ADET % / Amount';
        }
        field(16452; "ADET Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'ADET Amount';
            Editable = false;
        }
        field(16453; "AED(TTA) Calculation Type"; Option)
        {
            Caption = 'AED(TTA) Calculation Type';
            OptionCaption = 'Percentage,Amount';
            OptionMembers = Percentage,Amount;
        }
        field(16454; "AED(TTA) % / Amount"; Decimal)
        {
            Caption = 'AED(TTA) % / Amount';
        }
        field(16455; "AED(TTA) Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'AED(TTA) Amount';
            Editable = false;
        }
        field(16457; "ADE Calculation Type"; Option)
        {
            Caption = 'ADE Calculation Type';
            OptionCaption = 'Percentage,Amount';
            OptionMembers = Percentage,Amount;
        }
        field(16458; "ADE % / Amount"; Decimal)
        {
            Caption = 'ADE % / Amount';
        }
        field(16459; "ADE Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'ADE Amount';
            Editable = false;
        }
        field(50000; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(50001; "Size Code"; Code[3])
        {

            trigger OnLookup()
            var
                InventorySetup: Record "Inventory Setup";
                DimensionValue: Record "Dimension Value";
            begin
            end;
        }
        field(50002; MRP; Decimal)
        {
            Editable = false;
        }
        field(50003; "Assessable Value"; Decimal)
        {
        }
        field(50004; "From Main Location"; Code[10])
        {
        }
        field(50005; "To Main Location"; Code[10])
        {
        }
        field(50006; "External Transfer"; Boolean)
        {
        }
        field(50008; "Plant Code"; Code[1])
        {
        }
        field(50017; "Quality Code"; Code[10])
        {
        }
        field(50018; "Packing Code"; Code[10])
        {
        }
        field(50019; "Color Code"; Code[10])
        {
        }
        field(50020; "Design Code"; Code[10])
        {
        }
        field(50021; "Type Code"; Code[10])
        {
        }
        field(50022; "Group Code"; Code[2])
        {
        }
        field(50023; "Type Catogery Code"; Code[2])
        {
            Description = 'TRI NM 160308';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Transfer Order No.", "Item No.", "Receipt Date")
        {
        }
        key(Key3; "Document No.", "Transfer-to Code")
        {
        }
        key(Key4; "Transfer-to Code", "Size Code", "Unit of Measure")
        {
        }
        key(Key5; "Document No.", "Item No.")
        {
        }
    }

    fieldgroups
    {
    }
}

