table 99316 "Purchase Line Archive Temp"
{
    Caption = 'Purchase Line Archive';

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            TableRelation = Vendor;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Purchase Header Archive"."No." WHERE("Document Type" = FIELD("Document Type"),
                                                                 "Version No." = FIELD("Version No."));
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
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE
            IF (Type = CONST("Item")) Item
            ELSE
            IF (Type = CONST(3)) Resource
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
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group"
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
        field(16; "Outstanding Quantity"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(17; "Qty. to Invoice"; Decimal)
        {
            Caption = 'Qty. to Invoice';
            DecimalPlaces = 0 : 5;
        }
        field(18; "Qty. to Receive"; Decimal)
        {
            Caption = 'Qty. to Receive';
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
        }
        field(26; "Quantity Disc. %"; Decimal)
        {
            Caption = 'Quantity Disc. %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
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
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';
        }
        field(29; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(30; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
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
        field(57; "Outstanding Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Outstanding Amount';
        }
        field(58; "Qty. Rcd. Not Invoiced"; Decimal)
        {
            Caption = 'Qty. Rcd. Not Invoiced';
            DecimalPlaces = 0 : 5;
        }
        field(59; "Amt. Rcd. Not Invoiced"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amt. Rcd. Not Invoiced';
        }
        field(60; "Quantity Received"; Decimal)
        {
            Caption = 'Quantity Received';
            DecimalPlaces = 0 : 5;
        }
        field(61; "Quantity Invoiced"; Decimal)
        {
            Caption = 'Quantity Invoiced';
            DecimalPlaces = 0 : 5;
        }
        field(63; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
        }
        field(64; "Receipt Line No."; Integer)
        {
            Caption = 'Receipt Line No.';
        }
        field(67; "Profit %"; Decimal)
        {
            Caption = 'Profit %';
            DecimalPlaces = 0 : 5;
        }
        field(68; "Pay-to Vendor No."; Code[20])
        {
            Caption = 'Pay-to Vendor No.';
            TableRelation = Vendor;
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Discount Amount';
        }
        field(70; "Vendor Item No."; Text[20])
        {
            Caption = 'Vendor Item No.';
        }
        field(71; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            TableRelation = IF ("Drop Shipment" = CONST(true)) "Sales Header"."No." WHERE("Document Type" = CONST("Order"));
        }
        field(72; "Sales Order Line No."; Integer)
        {
            Caption = 'Sales Order Line No.';
            TableRelation = IF ("Drop Shipment" = CONST(true)) "Sales Line"."Line No." WHERE("Document Type" = CONST(Order),
                                                                                         "Document No." = FIELD("Sales Order No."));
        }
        field(73; "Drop Shipment"; Boolean)
        {
            Caption = 'Drop Shipment';
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
            Editable = false;
            TableRelation = "Purchase Line Archive"."Line No." WHERE("Document Type" = FIELD("Document Type"),
                                                                      "Document No." = FIELD("Document No."),
                                                                      "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"),
                                                                      "Version No." = FIELD("Version No."));
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
        field(91; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(92; "Outstanding Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Outstanding Amount (LCY)';
        }
        field(93; "Amt. Rcd. Not Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amt. Rcd. Not Invoiced (LCY)';
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
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
        }
        field(100; "Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Cost';
        }
        field(101; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
        }
        field(103; "Line Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Amount';
        }
        field(104; "VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Difference';
        }
        field(105; "Inv. Disc. Amount to Invoice"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Disc. Amount to Invoice';
        }
        field(106; "VAT Identifier"; Code[10])
        {
            Caption = 'VAT Identifier';
        }
        field(5047; "Version No."; Integer)
        {
            Caption = 'Version No.';
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
        }
        field(5401; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            TableRelation = "Production Order"."No." WHERE(Status = FILTER(Released | Finished));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("No."));
        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"));
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            InitValue = 1;
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
        field(5416; "Outstanding Qty. (Base)"; Decimal)
        {
            Caption = 'Outstanding Qty. (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5417; "Qty. to Invoice (Base)"; Decimal)
        {
            Caption = 'Qty. to Invoice (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5418; "Qty. to Receive (Base)"; Decimal)
        {
            Caption = 'Qty. to Receive (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5458; "Qty. Rcd. Not Invoiced (Base)"; Decimal)
        {
            Caption = 'Qty. Rcd. Not Invoiced (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5460; "Qty. Received (Base)"; Decimal)
        {
            Caption = 'Qty. Received (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5461; "Qty. Invoiced (Base)"; Decimal)
        {
            Caption = 'Qty. Invoiced (Base)';
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
            TableRelation = "Item Category";
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
        field(5713; "Special Order"; Boolean)
        {
            Caption = 'Special Order';
        }
        field(5714; "Special Order Sales No."; Code[20])
        {
            Caption = 'Special Order Sales No.';
            TableRelation = IF ("Special Order" = CONST(true)) "Sales Header"."No." WHERE("Document Type" = CONST(Order));
        }
        field(5715; "Special Order Sales Line No."; Integer)
        {
            Caption = 'Special Order Sales Line No.';
            TableRelation = IF ("Special Order" = CONST(true)) "Sales Line"."Line No." WHERE("Document Type" = CONST(Order),
                                                                                         "Document No." = FIELD("Special Order Sales No."));
        }
        field(5752; "Completely Received"; Boolean)
        {
            Caption = 'Completely Received';
        }
        field(5790; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';
        }
        field(5791; "Promised Receipt Date"; Date)
        {
            Caption = 'Promised Receipt Date';
        }
        field(5792; "Lead Time Calculation"; DateFormula)
        {
            Caption = 'Lead Time Calculation';
        }
        field(5793; "Inbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Inbound Whse. Handling Time';
        }
        field(5794; "Planned Receipt Date"; Date)
        {
            Caption = 'Planned Receipt Date';
        }
        field(5795; "Order Date"; Date)
        {
            Caption = 'Order Date';
        }
        field(5800; "Allow Item Charge Assignment"; Boolean)
        {
            Caption = 'Allow Item Charge Assignment';
            InitValue = true;
        }
        field(5803; "Return Qty. to Ship"; Decimal)
        {
            Caption = 'Return Qty. to Ship';
            DecimalPlaces = 0 : 5;
        }
        field(5804; "Return Qty. to Ship (Base)"; Decimal)
        {
            Caption = 'Return Qty. to Ship (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5805; "Return Qty. Shipped Not Invd."; Decimal)
        {
            Caption = 'Return Qty. Shipped Not Invd.';
            DecimalPlaces = 0 : 5;
        }
        field(5806; "Ret. Qty. Shpd Not Invd.(Base)"; Decimal)
        {
            Caption = 'Ret. Qty. Shpd Not Invd.(Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5807; "Return Shpd. Not Invd."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Return Shpd. Not Invd.';
        }
        field(5808; "Return Shpd. Not Invd. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Return Shpd. Not Invd. (LCY)';
        }
        field(5809; "Return Qty. Shipped"; Decimal)
        {
            Caption = 'Return Qty. Shipped';
            DecimalPlaces = 0 : 5;
        }
        field(5810; "Return Qty. Shipped (Base)"; Decimal)
        {
            Caption = 'Return Qty. Shipped (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(6600; "Return Shipment No."; Code[20])
        {
            Caption = 'Return Shipment No.';
        }
        field(6601; "Return Shipment Line No."; Integer)
        {
            Caption = 'Return Shipment Line No.';
            Editable = false;
        }
        field(6608; "Return Reason Code"; Code[10])
        {
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";
        }
        field(13701; "Tax %"; Decimal)
        {
            Editable = false;
            MinValue = 0;
        }
        field(13702; "Amount Including Tax"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13703; "Form Code"; Code[10])
        {

            trigger OnLookup()
            var
                StateForm: Record State;
            begin
            end;
        }
        field(13704; "Form No."; Code[10])
        {
            //16225 "Tax Forms Details" Table N/F
            /* TableRelation = "Tax Forms Details"."Form No." WHERE("Form Code" = FIELD("Form Code"),
                                                                   Issued = CONST(false),
                                                                   "State" = FIELD("State"));*/
        }
        field(13705; State; Code[10])
        {
            TableRelation = State;
        }
        field(13711; "Tax Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13713; "Excise Bus. Posting Group"; Code[10])
        {
            Editable = false;
            // TableRelation = "Excise Bus. Posting Group"; //16225 Table N/F
        }
        field(13714; "Excise Prod. Posting Group"; Code[10])
        {
            Editable = false;
            // TableRelation = "Excise Prod. Posting Group"; //16225 Table N/F
        }
        field(13715; "Excise %"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
        }
        field(13716; "Excise Calculation Type"; Option)
        {
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %","Amount/Unit","% of Accessable Value","Excise %+Amount/Unit";
        }
        field(13717; "Amount Including Excise"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
        }
        field(13718; "Excise Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
        }
        field(13719; "Excise Base Quantity"; Decimal)
        {
            Description = 'Excise Base UOM Quantity';
        }
        field(13722; "Tax Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
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
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
        }
        field(13731; "Work Tax %"; Decimal)
        {
            Editable = false;
        }
        field(13732; "Work Tax Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13733; "TDS Category"; Option)
        {
            OptionCaption = ' ,A,C,S';
            OptionMembers = " ",A,C,S;
        }
        field(13734; "Surcharge %"; Decimal)
        {
            Editable = false;
        }
        field(13735; "Surcharge Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13736; "Concessional code"; Code[10])
        {
            Editable = false;
            TableRelation = "Concessional Code";
        }
        field(13738; "Excise Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13740; "TDS Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13741; "TDS Nature of Deduction"; Code[10])
        {
            //  TableRelation = "TDS Nature of Deduction"; //16225 Table N/F
        }
        field(13742; "TDS Assessee Code"; Code[10])
        {
            Editable = false;
            // TableRelation = "TDS Nature of Deduction"; //16225 Table N/F
        }
        field(13743; "TDS %"; Decimal)
        {
            Editable = false;
        }
        field(13744; "TDS Amount Including Surcharge"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13745; "TDS Account"; Code[20])
        {
            Editable = false;
        }
        field(13746; "Bal. TDS Including eCESS"; Decimal)
        {
            Caption = 'Bal. TDS Including eCESS';
            Editable = false;
        }
        field(13750; "Capital Item"; Boolean)
        {
            Editable = false;
        }
        field(13751; "AED(GSI) Calculation Type"; Option)
        {
            OptionCaption = 'Percentage,Amount';
            OptionMembers = Percentage,Amount;
        }
        field(13752; "AED(GSI) % / Amount"; Decimal)
        {
        }
        field(13753; "SED Calculation Type"; Option)
        {
            OptionCaption = 'Percentage,Amount';
            OptionMembers = Percentage,Amount;
        }
        field(13754; "SED % / Amount"; Decimal)
        {
        }
        field(13757; "BED Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13758; "AED(GSI) Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13759; "SED Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13761; "SAED Calculation Type"; Option)
        {
            OptionCaption = 'Percentage,Amount';
            OptionMembers = Percentage,Amount;
        }
        field(13762; "SAED % / Amount"; Decimal)
        {
        }
        field(13763; "CESS Calculation Type"; Option)
        {
            OptionCaption = 'Percentage,Amount';
            OptionMembers = Percentage,Amount;
        }
        field(13764; "CESS % / Amount"; Decimal)
        {
        }
        field(13765; "NCCD Calculation Type"; Option)
        {
            OptionCaption = 'Percentage,Amount';
            OptionMembers = Percentage,Amount;
        }
        field(13766; "NCCD % / Amount"; Decimal)
        {
        }
        field(13767; "eCess Calculation Type"; Option)
        {
            OptionCaption = 'Percentage,Amount';
            OptionMembers = Percentage,Amount;
        }
        field(13768; "eCess % / Amount"; Decimal)
        {
        }
        field(13769; "SAED Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13770; "CESS Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13771; "NCCD Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13772; "eCess Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13773; "% of Assessable Value"; Decimal)
        {
        }
        field(13774; "% of Excise Applicable"; Decimal)
        {
            InitValue = 100;
        }
        field(13775; "Amount Added to Excise Base"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13776; "Amount Added to Tax Base"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13777; "Amount Added to Inventory"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13786; "Item Type"; Option)
        {
            OptionCaption = ' ,Capital Goods,Spares';
            OptionMembers = " ","Capital Goods",Spares;
        }
        field(13787; "Duty Group"; Code[10])
        {
            //  TableRelation = "TDS Nature of Deduction"; //16225 Table N/F
        }
        field(13788; "Total Duty Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13789; "Quantity Can Import"; Decimal)
        {
            Editable = false;
        }
        field(13790; "Import Quantity Value"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13791; "Allocated Incentive Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
        }
        field(13792; "Extra Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13793; "Amount Including Duties"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
        }
        field(13796; "FI Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
        }
        field(13797; "Inv. Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13798; "Inv. Amount (LCY)"; Decimal)
        {
            Editable = false;
        }
        field(16321; "Excise Credit Reversal"; Boolean)
        {
        }
        field(16340; "Amount To Vendor"; Decimal)
        {
        }
        field(16341; "Balance Work Tax Amount"; Decimal)
        {
            Editable = false;
        }
        field(16342; "Charges To Vendor"; Decimal)
        {
            Editable = false;
        }
        field(16343; "TDS Base Amount"; Decimal)
        {
            Editable = false;
        }
        field(16350; "VAT Business Posting Group"; Code[10])
        {
            Editable = false;
            // TableRelation = "TDS Nature of Deduction".Code; //16225 Table N/F
        }
        field(16351; "VAT Product Posting Group"; Code[10])
        {
            Editable = false;
            //  TableRelation = "TDS Nature of Deduction".Code; //16225 Table N/F
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
        field(16359; "Balance Surcharge Amount"; Decimal)
        {
            Editable = false;
        }
        field(16362; "Surcharge Base Amount"; Decimal)
        {
            Editable = false;
        }
        field(16363; "TDS Group"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Contractor,Commission,Professional,Interest,Rent,Others,Dividend';
            OptionMembers = " ",Contractor,Commission,Professional,Interest,Rent,Others,Dividend;
        }
        field(16364; "Work Tax Nature Of Deduction"; Code[10])
        {
            //   TableRelation = "TDS Nature of Deduction"; //16225 Table N/F
        }
        field(16365; "Work Tax Group"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Contractor,Commission,Professional,Interest,Rent,Others';
            OptionMembers = " ",Contractor,Commission,Professional,Interest,Rent,Others;
        }
        field(16366; "Temp TDS Base"; Decimal)
        {
        }
        field(16367; "SetOff Available"; Boolean)
        {
        }
        field(16370; Subcontracting; Boolean)
        {
        }
        field(16371; SubConSend; Boolean)
        {
        }
        field(16372; "Delivery Challan Posted"; Integer)
        {
            CalcFormula = Count("Delivery Challan Header" WHERE("Sub. order No." = FIELD("Document No."),
                                                                 "Sub. Order Line No." = FIELD("Line No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(16373; "Qty. to Reject (Rework)"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(16374; "Qty. Rejected (Rework)"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(16375; SendForRework; Boolean)
        {
        }
        field(16376; "Qty. to Reject (C.E.)"; Decimal)
        {
            Description = 'Company Expence';
        }
        field(16377; "Qty. to Reject (V.E.)"; Decimal)
        {
        }
        field(16378; "Qty. Rejected (C.E.)"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(16379; "Qty. Rejected (V.E.)"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(16380; "Deliver Comp. For"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(16381; "Posting Date"; Date)
        {
        }
        field(16382; Status; Option)
        {
            OptionCaption = 'Open,Closed';
            OptionMembers = Open,Closed;

            trigger OnValidate()
            var
                SubOrderCompListVend: Record "Sub Order Comp. List Vend";
                ProdOrder: Record "Production Order";
                SubOrderCompList: Record "Sub Order Component List";
            begin
            end;
        }
        field(16383; "Vendor Shipment No."; Code[20])
        {
        }
        field(16384; "Released Production Order"; Code[10])
        {
            TableRelation = "Production Order"."No." WHERE("Status" = CONST(Finished),
                                                          "No." = FIELD("Prod. Order No."));
        }
        field(16385; SubConReceive; Boolean)
        {
        }
        field(16386; "Component Item No."; Code[20])
        {
        }
        field(16387; "Max Incentive Value"; Decimal)
        {
            Description = 'EXIM';
        }
        field(16388; "Incentive UOM"; Code[20])
        {
            Description = 'EXIM';
            TableRelation = "Unit of Measure";
        }
        field(16389; "Total Weight"; Decimal)
        {
            Description = 'EXIM';
        }
        field(16390; SIONType; Option)
        {
            Description = 'EXIM';
            OptionCaption = 'Value,% of FOB,Net + %';
            OptionMembers = Value,"% of FOB","Net + %";
        }
        field(16391; "Service Tax Group"; Code[20])
        {
            Caption = 'Service Tax Group';
            // TableRelation = "Service Tax Groups".Code; //16225 Table N/F

            trigger OnValidate()
            var
                CompanyInfo: Record "Company Information";
            begin
            end;
        }
        field(16392; "Service Tax %"; Decimal)
        {
            Caption = 'Service Tax %';
        }
        field(16393; "Service Tax Base"; Decimal)
        {
            Caption = 'Service Tax Base';
        }
        field(16394; "Service Tax Amount"; Decimal)
        {
            Caption = 'Service Tax Amount';
        }
        field(16395; "Service Tax Registration No."; Code[20])
        {
            Caption = 'Service Tax Registration No.';
            //TableRelation = "Service Tax Registration Nos.".Code; //16225 Table N/F
        }
        field(16396; "Service Tax Abetment"; Decimal)
        {
            Caption = 'Service Tax Abetment';
        }
        field(16397; "eCESS %"; Decimal)
        {
            Editable = false;
        }
        field(16398; "eCESS on TDS Amount"; Decimal)
        {
            Editable = false;
        }
        field(16399; "Total TDS Including eCESS"; Decimal)
        {
            Editable = false;
        }
        field(16400; "Per Contract"; Boolean)
        {
        }
        field(16405; "Service Tax eCess %"; Decimal)
        {
            Caption = 'Service Tax eCess %';
        }
        field(16406; "Service Tax eCess Amount"; Decimal)
        {
            Caption = 'Service Tax eCess Amount';
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
            AutoFormatExpression = "Currency Code";
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
            AutoFormatExpression = "Currency Code";
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
            AutoFormatExpression = "Currency Code";
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
        field(50010; "Indent No."; Code[20])
        {
            Description = 'Customization No. 1 ND';
        }
        field(50011; "Indent Line No."; Integer)
        {
            Description = 'Customization No. 1 ND';
        }
        field(50012; Make; Text[30])
        {
        }
        field(50013; "Indent Date"; Date)
        {
            Description = 'Report 84 EXIM ravi';
        }
        field(50014; "Main Location"; Code[10])
        {
        }
        field(50015; "Starting Date"; Date)
        {

            trigger OnValidate()
            begin
                //Vipul Tri1.0
                IF ("Ending Date" <> 0D) AND ("Starting Date" > "Ending Date") THEN
                    ERROR('Starting Date can not be greater then Ending Date');
            end;
        }
        field(50016; "Ending Date"; Date)
        {

            trigger OnValidate()
            begin
                //Vipul Tri1.0
                IF ("Starting Date" <> 0D) AND ("Starting Date" > "Ending Date") THEN
                    ERROR('Starting Date can not be greater then Ending Date');
            end;
        }
        field(50019; "Excise Amount Per Unit"; Decimal)
        {
            Description = 'ND';
        }
        field(50020; "Posting Date 1"; Date)
        {
            Editable = true;
        }
        field(99000750; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
            TableRelation = "Routing Header";
        }
        field(99000751; "Operation No."; Code[10])
        {
            Caption = 'Operation No.';
            TableRelation = "Prod. Order Routing Line"."Operation No." WHERE("Status" = CONST(Released),
                                                                              "Prod. Order No." = FIELD("Prod. Order No."),
                                                                              "Routing No." = FIELD("Routing No."));
        }
        field(99000752; "Work Center No."; Code[20])
        {
            Caption = 'Work Center No.';
            TableRelation = "Work Center";
        }
        field(99000753; Finished; Boolean)
        {
            Caption = 'Finished';
        }
        field(99000754; "Prod. Order Line No."; Integer)
        {
            Caption = 'Prod. Order Line No.';
            TableRelation = "Prod. Order Line"."Line No." WHERE(Status = FILTER(Released ..),
                                                                 "Prod. Order No." = FIELD("Prod. Order No."));
        }
        field(99000755; "Overhead Rate"; Decimal)
        {
            Caption = 'Overhead Rate';
            DecimalPlaces = 0 : 5;
        }
        field(99000756; "MPS Order"; Boolean)
        {
            Caption = 'MPS Order';
        }
        field(99000757; "Planning Flexibility"; Option)
        {
            Caption = 'Planning Flexibility';
            OptionCaption = 'Unlimited,None';
            OptionMembers = Unlimited,"None";
        }
        field(99000758; "Safety Lead Time"; DateFormula)
        {
            Caption = 'Safety Lead Time';
        }
        field(99000759; "Routing Reference No."; Integer)
        {
            Caption = 'Routing Reference No.';
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Doc. No. Occurrence", "Version No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = Amount, "Amount Including VAT";
        }
    }

    fieldgroups
    {
    }
}

