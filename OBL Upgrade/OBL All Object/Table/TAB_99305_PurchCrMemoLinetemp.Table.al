table 99305 "Purch. Cr. Memo Line temp"
{
    Caption = 'Purch. Cr. Memo Line';
    DrillDownPageID = "Posted Purchase Cr. Memo Lines";
    LookupPageID = "Posted Purchase Cr. Memo Lines";

    fields
    {
        field(2; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            Editable = false;
            TableRelation = Vendor;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Purch. Cr. Memo Hdr.";
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";
        }
        field(6; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE
            IF (Type = CONST("Item")) Item
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST("Charge (Item)")) "Item Charge";
        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(8; "Posting Group"; Code[10])
        {
            Caption = 'Posting Group';
            Editable = false;
            TableRelation = IF (Type = CONST("Item")) "Inventory Posting Group"
            ELSE
            IF (Type = CONST("Fixed Asset")) "FA Posting Group";
        }
        field(10; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
        }
        field(11; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(12; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(13; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(22; "Direct Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Direct Unit Cost';
        }
        field(23; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';
        }
        field(25; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(27; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(28; "Line Discount Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';
        }
        field(29; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(30; "Amount Including VAT"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
        }
        field(31; "Unit Price (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price (LCY)';
        }
        field(32; "Allow Invoice Disc."; Boolean)
        {
            Caption = 'Allow Invoice Disc.';
            InitValue = true;
        }
        field(34; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
        }
        field(35; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
        }
        field(36; "Units per Parcel"; Decimal)
        {
            Caption = 'Units per Parcel';
            DecimalPlaces = 0 : 5;
        }
        field(37; "Unit Volume"; Decimal)
        {
            Caption = 'Unit Volume';
            DecimalPlaces = 0 : 5;
        }
        field(38; "Appl.-to Item Entry"; Integer)
        {
            Caption = 'Appl.-to Item Entry';
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(45; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(47; "Phase Code"; Code[10])
        {
            Caption = 'Phase Code';
        }
        field(48; "Task Code"; Code[10])
        {
            Caption = 'Task Code';
        }
        field(49; "Step Code"; Code[10])
        {
            Caption = 'Step Code';
        }
        field(54; "Indirect Cost %"; Decimal)
        {
            Caption = 'Indirect Cost %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Inv. Discount Amount';
        }
        field(70; "Vendor Item No."; Text[20])
        {
            Caption = 'Vendor Item No.';
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(75; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(77; "VAT Calculation Type"; Option)
        {
            Caption = 'VAT Calculation Type';
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(78; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(79; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(80; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
            TableRelation = "Purch. Cr. Memo Line"."Line No." WHERE("Document No." = FIELD("Document No."));
        }
        field(81; "Entry Point"; Code[10])
        {
            Caption = 'Entry Point';
            TableRelation = "Entry/Exit Point";
        }
        field(82; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(83; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(85; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(86; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(87; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(88; "Use Tax"; Boolean)
        {
            Caption = 'Use Tax';
        }
        field(89; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(90; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(97; "Blanket Order No."; Code[20])
        {
            Caption = 'Blanket Order No.';
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = CONST("Blanket Order"));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(98; "Blanket Order Line No."; Integer)
        {
            Caption = 'Blanket Order Line No.';
            TableRelation = "Purchase Line"."Line No." WHERE("Document Type" = CONST("Blanket Order"),
                                                              "Document No." = FIELD("Blanket Order No."));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(99; "VAT Base Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
            Editable = false;
        }
        field(100; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            Editable = false;
        }
        field(103; "Line Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Amount';
        }
        field(104; "VAT Difference"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'VAT Difference';
        }
        field(106; "VAT Identifier"; Code[10])
        {
            Caption = 'VAT Identifier';
            Editable = false;
        }
        field(5401; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("No."));
        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"),
                                            "Item Filter" = FIELD("No."),
                                            "Variant Filter" = FIELD("Variant Code"));
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";
        }
        field(5415; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5600; "FA Posting Date"; Date)
        {
            Caption = 'FA Posting Date';
        }
        field(5601; "FA Posting Type"; Option)
        {
            Caption = 'FA Posting Type';
            OptionCaption = ' ,Acquisition Cost,Maintenance';
            OptionMembers = " ","Acquisition Cost",Maintenance;
        }
        field(5602; "Depreciation Book Code"; Code[10])
        {
            Caption = 'Depreciation Book Code';
            TableRelation = "Depreciation Book";
        }
        field(5603; "Salvage Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Salvage Value';
        }
        field(5605; "Depr. until FA Posting Date"; Boolean)
        {
            Caption = 'Depr. until FA Posting Date';
        }
        field(5606; "Depr. Acquisition Cost"; Boolean)
        {
            Caption = 'Depr. Acquisition Cost';
        }
        field(5609; "Maintenance Code"; Code[10])
        {
            Caption = 'Maintenance Code';
            TableRelation = Maintenance;
        }
        field(5610; "Insurance No."; Code[20])
        {
            Caption = 'Insurance No.';
            TableRelation = Insurance;
        }
        field(5611; "Budgeted FA No."; Code[20])
        {
            Caption = 'Budgeted FA No.';
            TableRelation = "Fixed Asset";
        }
        field(5612; "Duplicate in Depreciation Book"; Code[10])
        {
            Caption = 'Duplicate in Depreciation Book';
            TableRelation = "Depreciation Book";
        }
        field(5613; "Use Duplication List"; Boolean)
        {
            Caption = 'Use Duplication List';
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(5705; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';
        }
        field(5706; "Unit of Measure (Cross Ref.)"; Code[10])
        {
            Caption = 'Unit of Measure (Cross Ref.)';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
        }
        field(5707; "Cross-Reference Type"; Option)
        {
            Caption = 'Cross-Reference Type';
            OptionCaption = ' ,Customer,Vendor,Bar Code';
            OptionMembers = " ",Customer,Vendor,"Bar Code";
        }
        field(5708; "Cross-Reference Type No."; Code[30])
        {
            Caption = 'Cross-Reference Type No.';
        }
        field(5709; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = IF (Type = CONST(Item)) "Item Category";
        }
        field(5710; Nonstock; Boolean)
        {
            Caption = 'Nonstock';
        }
        field(5711; "Purchasing Code"; Code[10])
        {
            Caption = 'Purchasing Code';
            TableRelation = Purchasing;
        }
        field(5712; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(6608; "Return Reason Code"; Code[10])
        {
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";
        }
        field(13701; "Tax %"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(13702; "Amount Including Tax"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(13703; "Form Code"; Code[10])
        {
            /* TableRelation = "State Forms"."Form Code" WHERE (State=FIELD(State),
                                                              "Transit Document"=CONST(false));*/
        }
        field(13704; "Form No."; Code[10])
        {
        }
        field(13705; State; Code[10])
        {
            TableRelation = State;
        }
        field(13711; "Tax Base Amount"; Decimal)
        {
            AutoFormatType = 1;
            Editable = false;
        }
        field(13713; "Excise Bus. Posting Group"; Code[10])
        {
            Editable = false;
            //TableRelation = "Excise Bus. Posting Group"; /16225 table N/F
        }
        field(13714; "Excise Prod. Posting Group"; Code[10])
        {
            Editable = false;
            //TableRelation = "Excise Prod. Posting Group"; //16225 Table N/F
        }
        field(13715; "BED %"; Decimal)
        {
        }
        field(13716; "BED Calculation Type"; Option)
        {
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %","Amount/Unit","% of Accessable Value","Excise %+Amount/Unit";
        }
        field(13717; "Amount Including Excise"; Decimal)
        {
        }
        field(13718; "Excise Amount"; Decimal)
        {
        }
        field(13722; "Tax Amount"; Decimal)
        {
        }
        field(13723; "Amount Per Unit Of Measure"; Decimal)
        {
        }
        field(13724; "Excise Accounting Type"; Option)
        {
            OptionCaption = 'With CENVAT,Without CENVAT';
            OptionMembers = "With CENVAT","Without CENVAT";
        }
        field(13730; "Work Tax Base Amount"; Decimal)
        {
        }
        field(13731; "Work Tax %"; Decimal)
        {
        }
        field(13732; "Work Tax Amount"; Decimal)
        {
        }
        field(13733; "TDS Category"; Option)
        {
            OptionCaption = ' ,A,C,S';
            OptionMembers = " ",A,C,S;
        }
        field(13734; "Surcharge %"; Decimal)
        {
        }
        field(13735; "Surcharge Amount"; Decimal)
        {
        }
        field(13736; "Concessional Rate"; Code[10])
        {
        }
        field(13738; "Excise Base Amount"; Decimal)
        {
            Editable = false;
        }
        field(13739; "Excise Record"; Option)
        {
            OptionCaption = 'RG 23 A,RG 23 C';
            OptionMembers = "RG 23 A","RG 23 C";
        }
        field(13741; "TDS Nature of Deduction"; Code[10])
        {
            // TableRelation = "TDS Nature of Deduction"; //16225 Table N/f
        }
        field(13742; "TDS Assessee Code"; Code[10])
        {
            //TableRelation = "TDS Nature of Deduction"; //16225 Table N/f
        }
        field(13743; "TDS %"; Decimal)
        {
        }
        field(13744; "TDS Amount"; Decimal)
        {
        }
        field(13745; "TDS Account"; Code[20])
        {
        }
        field(13746; "Balance TDS"; Decimal)
        {
        }
        field(13747; "Exchange Rate"; Decimal)
        {
        }
        field(13750; "Capital Item"; Boolean)
        {
            Description = 'If Capital Item then Excise to go to RG23C instead of RG23A';
            Editable = false;
        }
        field(13751; "AED Calculation Type"; Option)
        {
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %","Amount/Unit","% of Accessable Value","Excise %+Amount/Unit";
        }
        field(13752; "AED % / Amount"; Decimal)
        {
        }
        field(13753; "SED Calculation Type"; Option)
        {
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %","Amount/Unit","% of Accessable Value","Excise %+Amount/Unit";
        }
        field(13754; "SED % / Amount"; Decimal)
        {
        }
        field(13757; BED; Decimal)
        {
        }
        field(13758; "AED Amount"; Decimal)
        {
        }
        field(13759; "SED Amount"; Decimal)
        {
        }
        field(13761; "SAED Calculation Type"; Option)
        {
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %","Amount/Unit","% of Accessable Value","Excise %+Amount/Unit";
        }
        field(13762; "SAED % / Amount"; Decimal)
        {
        }
        field(13763; "CESS Calculation Type"; Option)
        {
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %","Amount/Unit","% of Accessable Value","Excise %+Amount/Unit";
        }
        field(13764; "CESS % / Amount"; Decimal)
        {
        }
        field(13765; "NCCD Calculation Type"; Option)
        {
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %","Amount/Unit","% of Accessable Value","Excise %+Amount/Unit";
        }
        field(13766; "NCCD % / Amount"; Decimal)
        {
        }
        field(13767; "eCess Calculation Type"; Option)
        {
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %","Amount/Unit","% of Accessable Value","Excise %+Amount/Unit";
        }
        field(13768; "eCess % / Amount"; Decimal)
        {
        }
        field(13769; "SAED Amount"; Decimal)
        {
        }
        field(13770; "CESS Amount"; Decimal)
        {
        }
        field(13771; "NCCD Amount"; Decimal)
        {
        }
        field(13772; "eCess Amount"; Decimal)
        {
        }
        field(13775; "Amount Added to Excise Base"; Decimal)
        {
            Description = 'For Structures';
        }
        field(13776; "Amount Added to Tax Base"; Decimal)
        {
            Description = 'For Structures';
        }
        field(13777; "Amount Added to Inventory"; Decimal)
        {
            Description = 'For Structures';
        }
        field(16340; "Amount To Vendor"; Decimal)
        {
        }
        field(16341; "Balance Work Tax Amount"; Decimal)
        {
        }
        field(16342; "Charges To Vendor"; Decimal)
        {
        }
        field(16343; "TDS Base Amount"; Decimal)
        {
            Description = 'Hotfix4';
        }
        field(16350; "VAT Business Posting Group"; Code[10])
        {
            Editable = false;
            // TableRelation = "TDS Nature of Deduction".Code; //16225 table N/F
        }
        field(16351; "VAT Product Posting Group"; Code[10])
        {
            Editable = false;
            // TableRelation = "TDS Nature of Deduction".Code; //16225 table N/F
        }
        field(16352; "VAT %age"; Decimal)
        {
            Editable = false;
        }
        field(16353; "VAT Base"; Decimal)
        {
            Editable = false;
        }
        field(16354; "VAT Amount"; Decimal)
        {
            Editable = false;
        }
        field(16355; "Claim VAT"; Boolean)
        {
            InitValue = true;
        }
        field(16356; "Refund VAT"; Boolean)
        {
        }
        field(16357; "Consume VAT"; Boolean)
        {
        }
        field(16358; "Reverse VAT"; Boolean)
        {
        }
        field(16409; "RG Record Type"; Option)
        {
            Caption = 'RG Record Type';
            OptionCaption = ' ,RG23A,RG23C';
            OptionMembers = " ",RG23A,RG23C;
        }
        field(16410; "Excise as Service Tax Credit"; Boolean)
        {
            Caption = 'Excise as Service Tax Credit';
        }
        field(16411; "Service Tax as Excise Credit"; Boolean)
        {
            Caption = 'Service Tax as Excise Credit';
        }
        field(16457; "ADE Calculation Type"; Option)
        {
            Caption = 'ADE Calculation Type';
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %","Amount/Unit","% of Accessable Value","Excise %+Amount/Unit";
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
        field(16490; "Assessable Value"; Decimal)
        {
        }
        field(16491; "VAT Type"; Option)
        {
            OptionCaption = ' ,Item,Capital Goods';
            OptionMembers = " ",Item,"Capital Goods";
        }
        field(50000; "Rejection Reason Code"; Code[20])
        {
            Description = 'Customization No. 10';
            TableRelation = "Return Reason";
        }
        field(50001; "Shortage Reason Code"; Code[20])
        {
            Description = 'Customization No. 10';
            TableRelation = "Return Reason";
        }
        field(50002; "Challan Quantity"; Decimal)
        {
            Description = 'Customization No. 10';
        }
        field(50003; "Actual Quantity"; Decimal)
        {
            Description = 'Customization No. 10';
        }
        field(50004; "Accepted Quantity"; Decimal)
        {
            Description = 'Customization No. 10';
        }
        field(50005; "Shortage Quantity"; Decimal)
        {
            Description = 'Customization No. 10';
        }
        field(50006; "Rejected Quantity"; Decimal)
        {
            Description = 'Customization No. 10';
        }
        field(50012; Make; Text[30])
        {
        }
        field(50020; "Posting Date 1"; Date)
        {
            Editable = true;
        }
        field(50021; "Posting Date Header"; Date)
        {
            CalcFormula = Lookup("Purch. Cr. Memo Hdr."."Posting Date" WHERE("No." = FIELD("Document No.")));
            Description = 'Tri1.3 PG 10112006 -- Excise Batch';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
            MaintainSIFTIndex = false;
            SumIndexFields = Amount, "Amount Including VAT", "Amount Including Tax";
        }
        key(Key2; "Blanket Order No.", "Blanket Order Line No.")
        {
        }
        key(Key3; "Buy-from Vendor No.", "No.", "Posting Date 1")
        {
        }
        key(Key4; "No.", "Excise Amount", "Posting Date 1")
        {
        }
    }

    fieldgroups
    {
    }
}

