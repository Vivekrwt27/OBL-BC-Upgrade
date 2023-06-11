table 99314 "Sales Cr.Memo Line Temp"
{
    Caption = 'Sales Cr.Memo Line';
    DrillDownPageID = "Posted Sales Cr. Memo Subform";

    fields
    {
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Sales Cr.Memo Header";
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(6; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE
            IF (Type = CONST("Item")) Item
            ELSE
            IF (Type = CONST("Resource")) Resource
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
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group"
            ELSE
            IF (Type = CONST("Fixed Asset")) "FA Posting Group";
        }
        field(10; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
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
        field(22; "Unit Price"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 2;
            CaptionClass = GetCaptionClass(FIELDNO("Unit Price"));
            Caption = 'Unit Price';
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
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';
        }
        field(29; Amount; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(30; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
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
        field(42; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
        field(45; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(46; "Appl.-to Job Entry"; Integer)
        {
            Caption = 'Appl.-to Job Entry';
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
        field(50; "Job Applies-to ID"; Code[20])
        {
            Caption = 'Job Applies-to ID';
        }
        field(51; "Apply and Close (Job)"; Boolean)
        {
            Caption = 'Apply and Close (Job)';
        }
        field(52; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
        }
        field(68; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Inv. Discount Amount';
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
            TableRelation = "Sales Cr.Memo Line"."Line No." WHERE("Document No." = FIELD("Document No."));
        }
        field(81; "Exit Point"; Code[10])
        {
            Caption = 'Exit Point';
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
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST("Blanket Order"));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(98; "Blanket Order Line No."; Integer)
        {
            Caption = 'Blanket Order Line No.';
            TableRelation = "Sales Line"."Line No." WHERE("Document Type" = CONST("Blanket Order"),
                                                           "Document No." = FIELD("Blanket Order No."));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(99; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
            Editable = false;
        }
        field(100; "Unit Cost"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            Editable = false;
        }
        field(103; "Line Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CaptionClass = GetCaptionClass(FIELDNO("Line Amount"));
            Caption = 'Line Amount';
        }
        field(104; "VAT Difference"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'VAT Difference';
        }
        field(106; "VAT Identifier"; Code[10])
        {
            Caption = 'VAT Identifier';
            Editable = false;
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
        field(5602; "Depreciation Book Code"; Code[10])
        {
            Caption = 'Depreciation Book Code';
            TableRelation = "Depreciation Book";
        }
        field(5605; "Depr. until FA Posting Date"; Boolean)
        {
            Caption = 'Depr. until FA Posting Date';
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
        field(5811; "Appl.-from Item Entry"; Integer)
        {
            Caption = 'Appl.-from Item Entry';
        }
        field(5900; "Service Contract No."; Code[20])
        {
            Caption = 'Service Contract No.';
            TableRelation = "Service Contract Header"."Contract No.";
        }
        field(5901; "Service Order No."; Code[20])
        {
            Caption = 'Service Order No.';
            TableRelation = "Service Contract Header";
        }
        field(5902; "Service Item No."; Code[20])
        {
            Caption = 'Service Item No.';
            TableRelation = "Service Item";
        }
        field(5903; "Appl.-to Service Entry"; Integer)
        {
            Caption = 'Appl.-to Service Entry';
        }
        field(6608; "Return Reason Code"; Code[10])
        {
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
            InitValue = true;
        }
        field(7002; "Customer Disc. Group"; Code[10])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
        }
        field(13701; "Tax Amount"; Decimal)
        {
        }
        field(13702; "Excise Bus. Posting Group"; Code[10])
        {
            //TableRelation = "Excise Bus. Posting Group"; //16225 Table N/F
        }
        field(13703; "Excise Prod. Posting Group"; Code[10])
        {
            // TableRelation = "Excise Prod. Posting Group"; //16225 Table N/F
        }
        field(13704; "India Tax 2"; Decimal)
        {
            Editable = false;
        }
        field(13705; "India Tax 3"; Decimal)
        {
            Editable = false;
        }
        field(13706; "India Tax 4"; Decimal)
        {
            Editable = false;
        }
        field(13707; "India Tax 1"; Decimal)
        {
            Editable = false;
        }
        field(13708; "Excise Amount"; Decimal)
        {
            Editable = false;
        }
        field(13709; "BED %"; Decimal)
        {
            Editable = false;
        }
        field(13710; "BED Calculation Type"; Option)
        {
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %","Amount/Unit","% of Accessable Value","Excise %+Amount/Unit";
        }
        field(13711; "Amount Including Excise"; Decimal)
        {
            Editable = false;
        }
        field(13712; "Excise Base Amount"; Decimal)
        {
            Editable = false;
        }
        field(13721; "Tax %"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(13722; "Amount Including Tax"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
        }
        field(13727; "Tax Base Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Editable = false;
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
        field(13736; "Concessional Code"; Code[10])
        {
            TableRelation = "Concessional Code";
        }
        field(13741; "TDS Nature of Deduction"; Code[10])
        {
            // TableRelation = "TDS Nature of Deduction"; //16225 Table N/F
        }
        field(13742; "TDS Assessee Code"; Code[10])
        {
            // TableRelation = "TDS Nature of Deduction"; //16225 Table N/F
        }
        field(13743; "TDS %"; Decimal)
        {
        }
        field(13744; "TDS Amount Including Surchage"; Decimal)
        {
        }
        field(13745; "TDS Account"; Code[20])
        {
        }
        field(13746; "Bal. TDS Including eCESS"; Decimal)
        {
        }
        field(13750; "Capital Item"; Boolean)
        {
            Description = 'If Capital Item then Excise to go to RG23C instead of RG23A';
            Editable = false;
        }
        field(13751; "AED(GSI) Calculation Type"; Option)
        {
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %","Amount/Unit","% of Accessable Value","Excise %+Amount/Unit";
        }
        field(13752; "AED(GSI) % / Amount"; Decimal)
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
        field(13755; "BED Amount"; Decimal)
        {
        }
        field(13758; "AED(GSI) Amount"; Decimal)
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
        field(13796; "Form Code"; Code[10])
        {
            //16225 TABLE N/F "State Forms"
            /* TableRelation = "State Forms"."Form Code" WHERE(State = FIELD(State),
                                                              "Transit Document" = CONST(false));*/
        }
        field(13797; "Form No."; Code[10])
        {
        }
        field(13798; State; Code[10])
        {
            TableRelation = State;
        }
        field(16340; "Amount To Customer"; Decimal)
        {
        }
        field(16341; "Balance Work Tax Amount"; Decimal)
        {
            Editable = false;
        }
        field(16342; "Charges To Customer"; Decimal)
        {
        }
        field(16343; "TDS Base Amount"; Decimal)
        {
            Description = 'Hotfix4';
        }
        field(16350; "VAT Business Posting Group"; Code[10])
        {
            Editable = false;
            TableRelation = State.Code;
        }
        field(16351; "VAT Product Posting Group"; Code[10])
        {
            Editable = false;
            TableRelation = State.Code;
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
        field(16355; "Zero Duty Good"; Boolean)
        {
        }
        field(16358; "Reverse VAT"; Boolean)
        {
        }
        field(16360; "Balance Surcharge Amount"; Decimal)
        {
            Editable = false;
        }
        field(16363; "Surcharge Base Amount"; Decimal)
        {
            Editable = false;
        }
        field(16364; "TDS Group"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Contractor,Commission,Professional,Interest,Rent,Dividend,Interest on Securities,Lotteries,Insurance Commission,NSS,Mutual fund,Brokerage,Income from Units,Capital Assets,Horse Races,Sports Association,Payable to Non Residents,Income of Mutual Funds,Units,Foreign Currency Bonds,FII from Securities,Others';
            OptionMembers = " ",Contractor,Commission,Professional,Interest,Rent,Dividend,"Interest on Securities",Lotteries,"Insurance Commission",NSS,"Mutual fund",Brokerage,"Income from Units","Capital Assets","Horse Races","Sports Association","Payable to Non Residents","Income of Mutual Funds",Units,"Foreign Currency Bonds","FII from Securities",Others;
        }
        field(16365; "Work Tax Nature Of Deduction"; Code[10])
        {
            //TableRelation = "TDS Nature of Deduction"; //16225 Table N/F
        }
        field(16366; "Work Tax Group"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Contractor,Commission,Professional,Interest,Rent,Dividend,Interest on Securities,Lotteries,Insurance Commission,NSS,Mutual fund,Brokerage,Income from Units,Capital Assets,Horse Races,Sports Association,Payable to Non Residents,Income of Mutual Funds,Units,Foreign Currency Bonds,FII from Securities,Others';
            OptionMembers = " ",Contractor,Commission,Professional,Interest,Rent,Dividend,"Interest on Securities",Lotteries,"Insurance Commission",NSS,"Mutual fund",Brokerage,"Income from Units","Capital Assets","Horse Races","Sports Association","Payable to Non Residents","Income of Mutual Funds",Units,"Foreign Currency Bonds","FII from Securities",Others;
        }
        field(16367; "Temp TDS Base"; Decimal)
        {
        }
        field(16383; "eCESS %"; Decimal)
        {
            Editable = false;
        }
        field(16384; "eCESS on TDS Amount"; Decimal)
        {
            Editable = false;
        }
        field(16385; "Total TDS Including eCESS"; Decimal)
        {
            Editable = false;
        }
        field(16450; "ADET Calculation Type"; Option)
        {
            Caption = 'ADET Calculation Type';
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %","Amount/Unit","% of Accessable Value","Excise %+Amount/Unit";
        }
        field(16451; "ADET % / Amount"; Decimal)
        {
            Caption = 'ADET % / Amount';
        }
        field(16452; "ADET Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'ADET Amount';
            Editable = false;
        }
        field(16453; "AED(TTA) Calculation Type"; Option)
        {
            Caption = 'AED(TTA) Calculation Type';
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %","Amount/Unit","% of Accessable Value","Excise %+Amount/Unit";
        }
        field(16454; "AED(TTA) % / Amount"; Decimal)
        {
            Caption = 'AED(TTA) % / Amount';
        }
        field(16455; "AED(TTA) Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'AED(TTA) Amount';
            Editable = false;
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
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'ADE Amount';
            Editable = false;
        }
        field(16485; "Total TDS Incl. eCESS (LCY)"; Decimal)
        {
        }
        field(16486; "TDS Amount (LCY)"; Decimal)
        {
        }
        field(16487; "Surcharge Amount (LCY)"; Decimal)
        {
        }
        field(16488; "TDS Including Surcharge (LCY)"; Decimal)
        {
        }
        field(16489; "eCESS on TDS Amount (LCY)"; Decimal)
        {
        }
        field(16490; "Assessable Value 1"; Decimal)
        {
        }
        field(16491; "VAT Type"; Option)
        {
            OptionCaption = ' ,Item,Capital Goods';
            OptionMembers = " ",Item,"Capital Goods";
        }
        field(50001; "Assessable Value"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
            MaintainSIFTIndex = false;
            SumIndexFields = Amount, "Amount Including VAT";
        }
        key(Key2; "Blanket Order No.", "Blanket Order Line No.")
        {
        }
        key(Key3; "Sell-to Customer No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DimMgt: Codeunit DimensionManagement;


    procedure GetCurrencyCode(): Code[10]
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
    end;

    procedure ShowDimensions()
    begin
    end;

    procedure ShowItemTrackingLines()
    var
        ItemTrackingMgt: Codeunit "Item Tracking Management";
    begin
    end;

    procedure CalcVATAmountLines(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var VATAmountLine: Record "VAT Amount Line")
    begin
    end;

    local procedure GetFieldCaption(FieldNumber: Integer): Text[100]
    var
        "Field": Record Field;
    begin
    end;

    local procedure GetCaptionClass(FieldNumber: Integer): Text[80]
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
    end;

    procedure RowID1(): Text[250]
    var
        ItemTrackingMgt: Codeunit "Item Tracking Management";
    begin
    end;
}

