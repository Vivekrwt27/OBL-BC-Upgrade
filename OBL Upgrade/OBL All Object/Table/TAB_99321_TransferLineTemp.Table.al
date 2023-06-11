table 99321 "Transfer Line Temp"
{
    Caption = 'Transfer Line';
    DrillDownPageID = "Transfer Lines";
    LookupPageID = "Transfer Lines";
    PasteIsValid = false;

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

            trigger OnValidate()
            var
                TempTransferLine: Record "Transfer Line" temporary;
            begin
            end;
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(5; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
        }
        field(6; "Qty. to Ship"; Decimal)
        {
            Caption = 'Qty. to Ship';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(7; "Qty. to Receive"; Decimal)
        {
            Caption = 'Qty. to Receive';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(8; "Quantity Shipped"; Decimal)
        {
            Caption = 'Quantity Shipped';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(9; "Quantity Received"; Decimal)
        {
            Caption = 'Quantity Received';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(10; Status; Option)
        {
            Caption = 'Status';
            Editable = true;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(11; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(12; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(13; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(14; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(15; "Inventory Posting Group"; Code[10])
        {
            Caption = 'Inventory Posting Group';
            TableRelation = "Inventory Posting Group";
        }
        field(16; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(17; "Outstanding Qty. (Base)"; Decimal)
        {
            Caption = 'Outstanding Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(18; "Qty. to Ship (Base)"; Decimal)
        {
            Caption = 'Qty. to Ship (Base)';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(19; "Qty. Shipped (Base)"; Decimal)
        {
            Caption = 'Qty. Shipped (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(20; "Qty. to Receive (Base)"; Decimal)
        {
            Caption = 'Qty. to Receive (Base)';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(21; "Qty. Received (Base)"; Decimal)
        {
            Caption = 'Qty. Received (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(22; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(23; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));

            trigger OnValidate()
            var
                UnitOfMeasure: Record "Unit of Measure";
                UOMMgt: Codeunit "Unit of Measure Management";
            begin
            end;
        }
        field(24; "Outstanding Quantity"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(25; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
        }
        field(26; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
        }
        field(27; "Unit Volume"; Decimal)
        {
            Caption = 'Unit Volume';
            DecimalPlaces = 0 : 5;
        }
        field(30; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));

            trigger OnValidate()
            var
                ItemVariant: Record "Item Variant";
                item: Record Item;
            begin
            end;
        }
        field(31; "Units per Parcel"; Decimal)
        {
            Caption = 'Units per Parcel';
            DecimalPlaces = 0 : 5;
        }
        field(32; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(33; "In-Transit Code"; Code[10])
        {
            Caption = 'In-Transit Code';
            Editable = false;
            TableRelation = Location WHERE("Use As In-Transit" = CONST(true));
        }
        field(34; "Qty. in Transit"; Decimal)
        {
            Caption = 'Qty. in Transit';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(35; "Qty. in Transit (Base)"; Decimal)
        {
            Caption = 'Qty. in Transit (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(36; "Transfer-from Code"; Code[10])
        {
            Caption = 'Transfer-from Code';
            TableRelation = Location;
        }
        field(37; "Transfer-to Code"; Code[10])
        {
            Caption = 'Transfer-to Code';
            TableRelation = Location;
        }
        field(38; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
        }
        field(39; "Receipt Date"; Date)
        {
            Caption = 'Receipt Date';
        }
        field(40; "Derived From Line No."; Integer)
        {
            Caption = 'Derived From Line No.';
            TableRelation = "Transfer Line"."Line No." WHERE("Document No." = FIELD("Document No."));
        }
        field(41; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        field(42; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
        }
        field(50; "Reserved Quantity Inbnd."; Decimal)
        {
            CalcFormula = Sum("Reservation Entry".Quantity WHERE("Reservation Status" = CONST(Reservation),
                                                                  "Source Type" = CONST(5741),
                                                                  "Source Subtype" = CONST(1),
                                                                  "Source ID" = FIELD("Document No."),
                                                                  "Source Prod. Order Line" = FIELD("Derived From Line No."),
                                                                  "Source Ref. No." = FIELD("Line No.")));
            Caption = 'Reserved Quantity Inbnd.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(51; "Reserved Quantity Outbnd."; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry".Quantity WHERE("Reservation Status" = CONST(Reservation),
                                                                   "Source Type" = CONST(5741),
                                                                   "Source Subtype" = CONST(0),
                                                                   "Source ID" = FIELD("Document No."),
                                                                   "Source Prod. Order Line" = FIELD("Derived From Line No."),
                                                                   "Source Ref. No." = FIELD("Line No.")));
            Caption = 'Reserved Quantity Outbnd.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(52; "Reserved Qty. Inbnd. (Base)"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Reservation Status" = CONST(Reservation),
                                                                           "Source Type" = CONST(5741),
                                                                           "Source Subtype" = CONST(1),
                                                                           "Source ID" = FIELD("Document No."),
                                                                           "Source Prod. Order Line" = FIELD("Derived From Line No."),
                                                                           "Source Ref. No." = FIELD("Line No.")));
            Caption = 'Reserved Qty. Inbnd. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(53; "Reserved Qty. Outbnd. (Base)"; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry"."Quantity (Base)" WHERE("Reservation Status" = CONST(Reservation),
                                                                            "Source Type" = CONST(5741),
                                                                            "Source Subtype" = CONST(0),
                                                                            "Source ID" = FIELD("Document No."),
                                                                            "Source Prod. Order Line" = FIELD("Derived From Line No."),
                                                                            "Source Ref. No." = FIELD("Line No.")));
            Caption = 'Reserved Qty. Outbnd. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(54; "Shipping Time"; DateFormula)
        {
            Caption = 'Shipping Time';
        }
        field(5750; "Whse. Outstanding Qty. (Inbnd)"; Decimal)
        {
            CalcFormula = Sum("Warehouse Receipt Line"."Qty. Outstanding (Base)" WHERE("Source Type" = CONST(5741),
                                                                                        "Source Subtype" = CONST(1),
                                                                                        "Source No." = FIELD("Document No."),
                                                                                        "Source Line No." = FIELD("Line No.")));
            Caption = 'Whse. Outstanding Qty. (Inbnd)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5751; "Whse. Outstanding Qty (Outbnd)"; Decimal)
        {
            CalcFormula = Sum("Warehouse Shipment Line"."Qty. Outstanding (Base)" WHERE("Source Type" = CONST(5741),
                                                                                         "Source Subtype" = CONST(0),
                                                                                         "Source No." = FIELD("Document No."),
                                                                                         "Source Line No." = FIELD("Line No.")));
            Caption = 'Whse. Outstanding Qty (Outbnd)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5752; "Completely Shipped"; Boolean)
        {
            Caption = 'Completely Shipped';
            Editable = false;
        }
        field(5753; "Completely Received"; Boolean)
        {
            Caption = 'Completely Received';
            Editable = false;
        }
        field(5793; "Outbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Outbound Whse. Handling Time';
        }
        field(5794; "Inbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Inbound Whse. Handling Time';
        }
        field(7300; "Transfer-from Bin Code"; Code[20])
        {
            Caption = 'Transfer-from Bin Code';
            TableRelation = "Bin Content"."Bin Code" WHERE("Location Code" = FIELD("Transfer-from Code"),
                                                            "Item No." = FIELD("Item No."),
                                                            "Variant Code" = FIELD("Variant Code"));
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
            AutoFormatType = 2;
            Caption = 'Unit Price';
            DecimalPlaces = 0 : 2;
        }
        field(13702; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
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
            Editable = false;
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
            Editable = false;
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
            //  TableRelation = "Excise Prod. Posting Group"; //16225 TABLE N/F
        }
        field(13728; "Excise Bus. Posting Group"; Code[10])
        {
            Caption = 'Excise Bus. Posting Group';
            //  TableRelation = "Excise Bus. Posting Group";
        }
        field(13730; "Capital Item"; Boolean)
        {
            Caption = 'Capital Item';
        }
        field(13731; "Excise Base Quantity"; Decimal)
        {
            Description = 'Excise UOM Quantity';
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
        field(13781; "Price Type"; Option)
        {
            Caption = 'Price Type';
            Editable = false;
            OptionCaption = 'At Cost,At Price';
            OptionMembers = "At Cost","At Price";
        }
        field(13782; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
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
        field(50000; MRP; Decimal)
        {
            Editable = false;
        }
        field(50001; "Assessable Value"; Decimal)
        {
        }
        field(50002; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(50003; "From Main Location"; Code[10])
        {
        }
        field(50004; "To Main Location"; Code[10])
        {
        }
        field(50005; "Plant Code"; Code[1])
        {
            Editable = false;
        }
        field(50006; "Type Code"; Code[2])
        {
            Editable = false;
        }
        field(50007; "Size Code"; Code[3])
        {
            Editable = false;
        }
        field(50008; "Color Code"; Code[4])
        {
            Editable = false;
        }
        field(50009; "Design Code"; Code[4])
        {
            Editable = false;
        }
        field(50010; "Packing Code"; Code[2])
        {
            Editable = false;
        }
        field(50011; "Quality Code"; Code[1])
        {
            Editable = false;
        }
        field(50012; "Qty in Sq. Mt."; Decimal)
        {
            Editable = false;
        }
        field(50013; "Qty in Carton."; Decimal)
        {
            Editable = false;
        }
        field(50014; "External Transfer"; Boolean)
        {
        }
        field(50016; "Transfer-to State"; Code[20])
        {
            CalcFormula = Lookup("Transfer Header"."Transfer-to State" WHERE("No." = FIELD("Document No.")));
            Description = '';
            FieldClass = FlowField;
            TableRelation = State.Code;
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
            SumIndexFields = "Qty in Sq. Mt.", "Qty in Carton.", Quantity, "Gross Weight", "Qty. to Ship", "Amount Including Excise";
        }
        key(Key2; "Transfer-to Code", Status, "Derived From Line No.", "Item No.", "Variant Code", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Receipt Date", "In-Transit Code")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Qty. in Transit (Base)", "Outstanding Qty. (Base)";
        }
        key(Key3; "Transfer-from Code", Status, "Derived From Line No.", "Item No.", "Variant Code", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Shipment Date", "In-Transit Code")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Outstanding Qty. (Base)";
        }
        key(Key4; "Item No.")
        {
        }
        key(Key5; "Plant Code")
        {
        }
        key(Key6; "Transfer-to Code", "Document No.")
        {
        }
        key(Key7; "Document No.", "Derived From Line No.")
        {
            SumIndexFields = "Qty in Sq. Mt.", "Qty in Carton.", Quantity, "Gross Weight", "Qty. to Ship";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
    begin
    end;

    trigger OnInsert()
    var
        TransLine2: Record "Transfer Line";
    begin
    end;
}

