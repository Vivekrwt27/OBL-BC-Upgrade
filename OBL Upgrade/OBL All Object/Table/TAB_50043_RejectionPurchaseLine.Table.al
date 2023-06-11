table 50043 "Rejection Purchase Line"
{
    // DrillDownPageID = 50112;
    // LookupPageID = 50112;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            Editable = false;
            NotBlank = true;
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            Editable = true;
            TableRelation = Vendor;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
            NotBlank = true;
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = FIELD("Document Type"));
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            Editable = false;
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

            trigger OnValidate()
            var
                ICPartner: Record "IC Partner";
                // ItemCrossReference: Record "Item Cross Reference";
                PrepmtMgt: Codeunit "Prepayment Mgt.";
            begin
            end;
        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                            "Subcontracting Location" = CONST(false));
        }
        field(8; "Posting Group"; Code[10])
        {
            Caption = 'Posting Group';
            Editable = false;
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group"
            ELSE
            IF (Type = CONST("Fixed Asset")) "FA Posting Group";
        }
        field(10; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
        }
        field(11; Description; Text[190])
        {
            Caption = 'Description';
        }
        field(12; "Description 2"; Text[150])
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
            Editable = false;
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
            Editable = false;

            trigger OnValidate()
            var
                SubOrderCompListVend: Record "Sub Order Comp. List Vend";
            begin
            end;
        }
        field(22; "Direct Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            CaptionClass = GetCaptionClass(FIELDNO("Direct Unit Cost"));
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
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';
        }
        field(29; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;
        }
        field(30; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
            Editable = false;
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

            trigger OnValidate()
            var
                Job: Record Job;
            begin
            end;
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
            Editable = false;

            trigger OnValidate()
            var
                Currency2: Record Currency;
            begin
            end;
        }
        field(58; "Qty. Rcd. Not Invoiced"; Decimal)
        {
            Caption = 'Qty. Rcd. Not Invoiced';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(59; "Amt. Rcd. Not Invoiced"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amt. Rcd. Not Invoiced';
            Editable = false;

            trigger OnValidate()
            var
                Currency2: Record Currency;
            begin
            end;
        }
        field(60; "Quantity Received"; Decimal)
        {
            Caption = 'Quantity Received';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(61; "Quantity Invoiced"; Decimal)
        {
            Caption = 'Quantity Invoiced';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(63; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
            Editable = false;
        }
        field(64; "Receipt Line No."; Integer)
        {
            Caption = 'Receipt Line No.';
            Editable = false;
        }
        field(67; "Profit %"; Decimal)
        {
            Caption = 'Profit %';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(68; "Pay-to Vendor No."; Code[20])
        {
            Caption = 'Pay-to Vendor No.';
            Editable = false;
            TableRelation = Vendor;
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Discount Amount';
            Editable = false;
        }
        field(70; "Vendor Item No."; Text[20])
        {
            Caption = 'Vendor Item No.';
        }
        field(71; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            Editable = false;
            TableRelation = IF ("Drop Shipment" = CONST(true)) "Sales Header"."No." WHERE("Document Type" = CONST(Order));
        }
        field(72; "Sales Order Line No."; Integer)
        {
            Caption = 'Sales Order Line No.';
            Editable = false;
            TableRelation = IF ("Drop Shipment" = CONST(true)) "Sales Line"."Line No." WHERE("Document Type" = CONST(Order),
                                                                                         "Document No." = FIELD("Sales Order No."));
        }
        field(73; "Drop Shipment"; Boolean)
        {
            Caption = 'Drop Shipment';
            Editable = false;
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
            Editable = false;
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
            TableRelation = "Purchase Line"."Line No." WHERE("Document Type" = FIELD("Document Type"),
                                                              "Document No." = FIELD("Document No."));
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
            Editable = false;
            TableRelation = Currency;
        }
        field(92; "Outstanding Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Outstanding Amount (LCY)';
            Editable = false;
        }
        field(93; "Amt. Rcd. Not Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amt. Rcd. Not Invoiced (LCY)';
            Editable = false;
        }
        field(95; "Reserved Quantity"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry".Quantity WHERE("Source ID" = FIELD("Document No."),
                                                                  "Source Ref. No." = FIELD("Line No."),
                                                                  "Source Type" = CONST(39),
                                                                  "Source Subtype" = FIELD("Document Type"),
                                                                  "Reservation Status" = CONST("Reservation")));
            Caption = 'Reserved Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
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
            Editable = false;
        }
        field(100; "Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            Editable = false;
        }
        field(101; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            Editable = false;
        }
        field(103; "Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionClass = GetCaptionClass(FIELDNO("Line Amount"));
            Caption = 'Line Amount';
        }
        field(104; "VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Difference';
            Editable = false;
        }
        field(105; "Inv. Disc. Amount to Invoice"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Disc. Amount to Invoice';
            Editable = false;
        }
        field(106; "VAT Identifier"; Code[10])
        {
            Caption = 'VAT Identifier';
            Editable = false;
        }
        field(107; "IC Partner Ref. Type"; Option)
        {
            Caption = 'IC Partner Ref. Type';
            OptionCaption = ' ,G/L Account,Item,,,Charge (Item),Cross Reference,Common Item No.,Vendor Item No.';
            OptionMembers = " ","G/L Account",Item,,,"Charge (Item)","Cross Reference","Common Item No.","Vendor Item No.";
        }
        field(108; "IC Partner Reference"; Code[20])
        {
            Caption = 'IC Partner Reference';

            trigger OnLookup()
            var
                ICGLAccount: Record "IC G/L Account";
                // ItemCrossReference: Record "Item Cross Reference";
                ItemVendorCatalog: Record "Item Vendor";
            begin
            end;
        }
        field(109; "Prepayment %"; Decimal)
        {
            Caption = 'Prepayment %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            var
                GenPostingSetup: Record "General Posting Setup";
                GLAcc: Record "G/L Account";
            begin
            end;
        }
        field(110; "Prepmt. Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionClass = GetCaptionClass(FIELDNO("Prepmt. Line Amount"));
            Caption = 'Prepmt. Line Amount';
            MinValue = 0;
        }
        field(111; "Prepmt. Amt. Inv."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionClass = GetCaptionClass(FIELDNO("Prepmt. Amt. Inv."));
            Caption = 'Prepmt. Amt. Inv.';
            Editable = false;
        }
        field(112; "Prepmt. Amt. Incl. VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. Amt. Incl. VAT';
            Editable = false;
        }
        field(113; "Prepayment Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepayment Amount';
            Editable = false;
        }
        field(114; "Prepmt. VAT Base Amt."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. VAT Base Amt.';
            Editable = false;
        }
        field(115; "Prepayment VAT %"; Decimal)
        {
            Caption = 'Prepayment VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
        }
        field(116; "Prepmt. VAT Calc. Type"; Option)
        {
            Caption = 'Prepmt. VAT Calc. Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(117; "Prepayment VAT Identifier"; Code[10])
        {
            Caption = 'Prepayment VAT Identifier';
            Editable = false;
        }
        field(118; "Prepayment Tax Area Code"; Code[20])
        {
            Caption = 'Prepayment Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(119; "Prepayment Tax Liable"; Boolean)
        {
            Caption = 'Prepayment Tax Liable';
        }
        field(120; "Prepayment Tax Group Code"; Code[10])
        {
            Caption = 'Prepayment Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(121; "Prepmt Amt to Deduct"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionClass = GetCaptionClass(FIELDNO("Prepmt Amt to Deduct"));
            Caption = 'Prepmt Amt to Deduct';
            MinValue = 0;
        }
        field(122; "Prepmt Amt Deducted"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionClass = GetCaptionClass(FIELDNO("Prepmt Amt Deducted"));
            Caption = 'Prepmt Amt Deducted';
            Editable = false;
        }
        field(123; "Prepayment Line"; Boolean)
        {
            Caption = 'Prepayment Line';
            Editable = false;
        }
        field(124; "Prepmt. Amount Inv. Incl. VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. Amount Inv. Incl. VAT';
            Editable = false;
        }
        field(129; "Prepmt. Amount Inv. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Prepmt. Amount Inv. (LCY)';
            Editable = false;
        }
        field(130; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            TableRelation = "IC Partner";
        }
        field(135; "Prepayment VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepayment VAT Difference';
            Editable = false;
        }
        field(136; "Prepmt VAT Diff. to Deduct"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt VAT Diff. to Deduct';
            Editable = false;
        }
        field(137; "Prepmt VAT Diff. Deducted"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt VAT Diff. Deducted';
            Editable = false;
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));
        }
        field(1002; "Job Line Type"; Option)
        {
            Caption = 'Job Line Type';
            OptionCaption = ' ,Schedule,Contract,Both Schedule and Contract';
            OptionMembers = " ",Schedule,Contract,"Both Schedule and Contract";
        }
        field(1003; "Job Unit Price"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Unit Price';
        }
        field(1004; "Job Total Price"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Total Price';
            Editable = false;
        }
        field(1005; "Job Line Amount"; Decimal)
        {
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Job Line Amount';
        }
        field(1006; "Job Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Job Line Discount Amount';
        }
        field(1007; "Job Line Discount %"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(1008; "Job Unit Price (LCY)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Unit Price (LCY)';
            Editable = false;
        }
        field(1009; "Job Total Price (LCY)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Total Price (LCY)';
            Editable = false;
        }
        field(1010; "Job Line Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Job Line Amount (LCY)';
            Editable = false;
        }
        field(1011; "Job Line Disc. Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Job Line Disc. Amount (LCY)';
            Editable = false;
        }
        field(1012; "Job Currency Factor"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Currency Factor';
        }
        field(1013; "Job Currency Code"; Code[20])
        {
            Caption = 'Job Currency Code';
        }
        field(5401; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            TableRelation = "Production Order"."No." WHERE(Status = CONST(Released));
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

            trigger OnLookup()
            var
                WMSManagement: Codeunit "WMS Management";
                BinCode: Code[20];
            begin
            end;

            trigger OnValidate()
            var
                WMSManagement: Codeunit "WMS Management";
            begin
            end;
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = true;
            InitValue = 1;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";

            trigger OnValidate()
            var
                UnitOfMeasureTranslation: Record "Unit of Measure Translation";
            begin
            end;
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
            Editable = false;
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
            Editable = false;
        }
        field(5460; "Qty. Received (Base)"; Decimal)
        {
            Caption = 'Qty. Received (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5461; "Qty. Invoiced (Base)"; Decimal)
        {
            Caption = 'Qty. Invoiced (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5495; "Reserved Qty. (Base)"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Source Type" = CONST(39),
                                                                           "Source Subtype" = FIELD("Document Type"),
                                                                           "Source ID" = FIELD("Document No."),
                                                                           "Source Ref. No." = FIELD("Line No."),
                                                                           "Reservation Status" = CONST(Reservation)));
            Caption = 'Reserved Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
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
            Editable = false;
            TableRelation = "Responsibility Center";
        }
        field(5705; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';

            trigger OnValidate()
            var
            //  ReturnedCrossRef: Record "Item Cross Reference";
            begin
            end;
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
        field(5750; "Whse. Outstanding Qty. (Base)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Warehouse Receipt Line"."Qty. Outstanding (Base)" WHERE("Source Type" = CONST(39),
                                                                                        "Source Subtype" = FIELD("Document Type"),
                                                                                        "Source No." = FIELD("Document No."),
                                                                                        "Source Line No." = FIELD("Line No.")));
            Caption = 'Whse. Outstanding Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5752; "Completely Received"; Boolean)
        {
            Caption = 'Completely Received';
            Editable = false;
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
        field(5801; "Qty. to Assign"; Decimal)
        {
            CalcFormula = Sum("Item Charge Assignment (Purch)"."Qty. to Assign" WHERE("Document Type" = FIELD("Document Type"),
                                                                                       "Document No." = FIELD("Document No."),
                                                                                       "Document Line No." = FIELD("Line No.")));
            Caption = 'Qty. to Assign';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5802; "Qty. Assigned"; Decimal)
        {
            CalcFormula = Sum("Item Charge Assignment (Purch)"."Qty. Assigned" WHERE("Document Type" = FIELD("Document Type"),
                                                                                      "Document No." = FIELD("Document No."),
                                                                                      "Document Line No." = FIELD("Line No.")));
            Caption = 'Qty. Assigned';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
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
            Editable = false;
        }
        field(5806; "Ret. Qty. Shpd Not Invd.(Base)"; Decimal)
        {
            Caption = 'Ret. Qty. Shpd Not Invd.(Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5807; "Return Shpd. Not Invd."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Return Shpd. Not Invd.';
            Editable = false;

            trigger OnValidate()
            var
                Currency2: Record Currency;
            begin
            end;
        }
        field(5808; "Return Shpd. Not Invd. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Return Shpd. Not Invd. (LCY)';
            Editable = false;
        }
        field(5809; "Return Qty. Shipped"; Decimal)
        {
            Caption = 'Return Qty. Shipped';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5810; "Return Qty. Shipped (Base)"; Decimal)
        {
            Caption = 'Return Qty. Shipped (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(6600; "Return Shipment No."; Code[20])
        {
            Caption = 'Return Shipment No.';
            Editable = false;
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
            Caption = 'Tax %';
            Editable = false;
            MinValue = 0;
        }
        field(13702; "Amount Including Tax"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including Tax';
            Editable = false;
        }
        field(13703; "Form Code"; Code[10])
        {
            Caption = 'Form Code';

            trigger OnLookup()
            var
            //16225 StateForm: Record "13767";
            //16225  StateForms: Page "13702";
            begin
            end;
        }
        field(13704; "Form No."; Code[10])
        {
            Caption = 'Form No.';
            //16225 table "Tax Forms Details" N/F
            /*TableRelation = "Tax Forms Details"."Form No." WHERE (Form Code=FIELD(Form Code),
                                                                  Issued=CONST(No),
                                                                  State=FIELD(State Code));*/
        }
        field(13705; "State Code"; Code[10])
        {
            Caption = 'State Code';
            TableRelation = State;
        }
        field(13711; "Tax Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Tax Base Amount';
            Editable = false;
        }
        field(13713; "Excise Bus. Posting Group"; Code[10])
        {
            Caption = 'Excise Bus. Posting Group';
            Editable = true;
            //16225 TableRelation = "Excise Bus. Posting Group";
        }
        field(13714; "Excise Prod. Posting Group"; Code[10])
        {
            Caption = 'Excise Prod. Posting Group';
            Editable = true;
            //16225  TableRelation = "Excise Prod. Posting Group";
        }
        field(13717; "Amount Including Excise"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including Excise';
        }
        field(13718; "Excise Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 3;
            Caption = 'Excise Amount';
        }
        field(13719; "Excise Base Quantity"; Decimal)
        {
            Caption = 'Excise Base Quantity';
        }
        field(13722; "Tax Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Tax Amount';
            Editable = false;
        }
        field(13724; "Excise Accounting Type"; Option)
        {
            Caption = 'Excise Accounting Type';
            OptionCaption = 'With CENVAT,Without CENVAT';
            OptionMembers = "With CENVAT","Without CENVAT";
        }
        field(13730; "Work Tax Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Work Tax Base Amount';
        }
        field(13731; "Work Tax %"; Decimal)
        {
            Caption = 'Work Tax %';
            Editable = false;
        }
        field(13732; "Work Tax Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Work Tax Amount';
            Editable = false;
        }
        field(13733; "TDS Category"; Option)
        {
            Caption = 'TDS Category';
            OptionCaption = ' ,A,C,S';
            OptionMembers = " ",A,C,S;
        }
        field(13734; "Surcharge %"; Decimal)
        {
            Caption = 'Surcharge %';
            Editable = false;
        }
        field(13735; "Surcharge Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Surcharge Amount';
            Editable = false;
        }
        field(13736; "Concessional Code"; Code[10])
        {
            Caption = 'Concessional Code';
            Editable = false;
            TableRelation = "Concessional Code";
        }
        field(13738; "Excise Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Excise Base Amount';
            Editable = false;
        }
        field(13740; "TDS Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'TDS Amount';
            Editable = false;
        }
        field(13741; "TDS Nature of Deduction"; Code[10])
        {
            Caption = 'TDS Nature of Deduction';
            //16225 TableRelation = "TDS Nature of Deduction";
        }
        field(13742; "Assessee Code"; Code[10])
        {
            Caption = 'Assessee Code';
            Editable = false;
            TableRelation = "Assessee Code";
        }
        field(13743; "TDS %"; Decimal)
        {
            Caption = 'TDS %';
            Editable = false;
        }
        field(13744; "TDS Amount Including Surcharge"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'TDS Amount Including Surcharge';
            Editable = false;
        }
        field(13746; "Bal. TDS Including SHE CESS"; Decimal)
        {
            Caption = 'Bal. TDS Including SHE CESS';
            Editable = false;
        }
        field(13750; "Capital Item"; Boolean)
        {
            Caption = 'Capital Item';
            Editable = true;
        }
        field(13757; "BED Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'BED Amount';
            Editable = true;
        }
        field(13758; "AED(GSI) Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'AED(GSI) Amount';
            Editable = true;
        }
        field(13759; "SED Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'SED Amount';
            Editable = true;
        }
        field(13769; "SAED Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'SAED Amount';
            Editable = true;
        }
        field(13770; "CESS Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'CESS Amount';
            Editable = true;
        }
        field(13771; "NCCD Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'NCCD Amount';
            Editable = true;
        }
        field(13772; "eCess Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'eCess Amount';
            Editable = true;
        }
        field(13775; "Amount Added to Excise Base"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Added to Excise Base';
            Editable = false;
        }
        field(13776; "Amount Added to Tax Base"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Added to Tax Base';
            Editable = false;
        }
        field(13777; "Amount Added to Inventory"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Added to Inventory';
            Editable = false;
        }
        field(16321; "Excise Credit Reversal"; Boolean)
        {
            Caption = 'Excise Credit Reversal';
        }
        field(16340; "Amount To Vendor"; Decimal)
        {
            Caption = 'Amount To Vendor';
        }
        field(16342; "Charges To Vendor"; Decimal)
        {
            Caption = 'Charges To Vendor';
            Editable = false;
        }
        field(16343; "TDS Base Amount"; Decimal)
        {
            Caption = 'TDS Base Amount';
            Editable = false;
        }
        field(16362; "Surcharge Base Amount"; Decimal)
        {
            Caption = 'Surcharge Base Amount';
            Editable = false;
        }
        field(16363; "TDS Group"; Option)
        {
            Caption = 'TDS Group';
            Editable = false;
            OptionCaption = ' ,Contractor,Commission,Professional,Interest,Rent,Dividend,Interest on Securities,Lotteries,Insurance Commission,NSS,Mutual fund,Brokerage,Income from Units,Capital Assets,Horse Races,Sports Association,Payable to Non Residents,Income of Mutual Funds,Units,Foreign Currency Bonds,FII from Securities,Others';
            OptionMembers = " ",Contractor,Commission,Professional,Interest,Rent,Dividend,"Interest on Securities",Lotteries,"Insurance Commission",NSS,"Mutual fund",Brokerage,"Income from Units","Capital Assets","Horse Races","Sports Association","Payable to Non Residents","Income of Mutual Funds",Units,"Foreign Currency Bonds","FII from Securities",Others;
        }
        field(16364; "Work Tax Nature Of Deduction"; Code[10])
        {
            Caption = 'Work Tax Nature Of Deduction';
            //16225  TableRelation = "TDS Nature of Deduction";
        }
        field(16365; "Work Tax Group"; Option)
        {
            Caption = 'Work Tax Group';
            Editable = false;
            OptionCaption = ' ,Contractor,Commission,Professional,Interest,Rent,Dividend,Interest on Securities,Lotteries,Insurance Commission,NSS,Mutual fund,Brokerage,Income from Units,Capital Assets,Horse Races,Sports Association,Payable to Non Residents,Income of Mutual Funds,Units,Foreign Currency Bonds,FII from Securities,Others';
            OptionMembers = " ",Contractor,Commission,Professional,Interest,Rent,Dividend,"Interest on Securities",Lotteries,"Insurance Commission",NSS,"Mutual fund",Brokerage,"Income from Units","Capital Assets","Horse Races","Sports Association","Payable to Non Residents","Income of Mutual Funds",Units,"Foreign Currency Bonds","FII from Securities",Others;
        }
        field(16366; "Temp TDS Base"; Decimal)
        {
            Caption = 'Temp TDS Base';
        }
        field(16367; "SetOff Available"; Boolean)
        {
            Caption = 'SetOff Available';
        }
        field(16370; Subcontracting; Boolean)
        {
            Caption = 'Subcontracting';
        }
        field(16371; SubConSend; Boolean)
        {
            Caption = 'SubConSend';
        }
        field(16372; "Delivery Challan Posted"; Integer)
        {
            CalcFormula = Count("Delivery Challan Header" WHERE("Sub. order No." = FIELD("Document No."),
                                                                 "Sub. Order Line No." = FIELD("Line No.")));
            Caption = 'Delivery Challan Posted';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16373; "Qty. to Reject (Rework)"; Decimal)
        {
            Caption = 'Qty. to Reject (Rework)';
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            var
                SubOrderComponents: Record "Sub Order Component List";
            begin
            end;
        }
        field(16374; "Qty. Rejected (Rework)"; Decimal)
        {
            Caption = 'Qty. Rejected (Rework)';
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(16375; SendForRework; Boolean)
        {
            Caption = 'SendForRework';
        }
        field(16376; "Qty. to Reject (C.E.)"; Decimal)
        {
            Caption = 'Qty. to Reject (C.E.)';
        }
        field(16377; "Qty. to Reject (V.E.)"; Decimal)
        {
            Caption = 'Qty. to Reject (V.E.)';
        }
        field(16378; "Qty. Rejected (C.E.)"; Decimal)
        {
            Caption = 'Qty. Rejected (C.E.)';
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(16379; "Qty. Rejected (V.E.)"; Decimal)
        {
            Caption = 'Qty. Rejected (V.E.)';
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(16380; "Deliver Comp. For"; Decimal)
        {
            Caption = 'Deliver Comp. For';
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            var
                ProdBOMLine: Record "Production BOM Line";
                QtySentToVendor: Decimal;
                SubOrderCompList: Record "Sub Order Component List";
                SubOrderComponents: Record "Sub Order Component List";
            begin
            end;
        }
        field(16381; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(16382; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Open,Closed';
            OptionMembers = Open,Closed;

            trigger OnValidate()
            var
                SubOrderCompListVend: Record "Sub Order Comp. List Vend";
                ProdOrder: Record "Production Order";
                SubOrderCompList: Record "Sub Order Component List";
                Text16360: Label 'There is still components pending at vendor location.';
                Text16361: Label 'Reopening is not allowed Production Order %1 has already been reported as Finished.';
            begin
            end;
        }
        field(16383; "Vendor Shipment No."; Code[20])
        {
            Caption = 'Vendor Shipment No.';
        }
        field(16384; "Released Production Order"; Code[10])
        {
            Caption = 'Released Production Order';
            TableRelation = "Production Order"."No." WHERE(Status = CONST(Finished),
                                                          "No." = FIELD("Prod. Order No."));
        }
        field(16385; SubConReceive; Boolean)
        {
            Caption = 'SubConReceive';
        }
        field(16386; "Component Item No."; Code[20])
        {
            Caption = 'Component Item No.';
        }
        field(16391; "Service Tax Group"; Code[20])
        {
            Caption = 'Service Tax Group';
            //16225 TableRelation = "Service Tax Groups".Code;
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
            //16225  TableRelation = "Service Tax Registration Nos.".Code;
        }
        field(16397; "eCESS % on TDS"; Decimal)
        {
            Caption = 'eCESS % on TDS';
            Editable = false;
        }
        field(16398; "eCESS on TDS Amount"; Decimal)
        {
            Caption = 'eCESS on TDS Amount';
            Editable = false;
        }
        field(16399; "Total TDS Including SHE CESS"; Decimal)
        {
            Caption = 'Total TDS Including SHE CESS';
            Editable = false;
        }
        field(16400; "Per Contract"; Boolean)
        {
            Caption = 'Per Contract';
        }
        field(16406; "Service Tax eCess Amount"; Decimal)
        {
            Caption = 'Service Tax eCess Amount';
        }
        field(16452; "ADET Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'ADET Amount';
            Editable = true;
        }
        field(16455; "AED(TTA) Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'AED(TTA) Amount';
            Editable = true;
        }
        field(16459; "ADE Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'ADE Amount';
            Editable = true;
        }
        field(16490; "Assessable Value"; Decimal)
        {
            Caption = 'Assessable Value';
        }
        field(16491; "VAT Type"; Option)
        {
            Caption = 'VAT Type';
            OptionCaption = ' ,Item,Capital Goods';
            OptionMembers = " ",Item,"Capital Goods";
        }
        field(16494; "SHE Cess Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'SHE Cess Amount';
            Editable = true;
        }
        field(16496; "Service Tax SHE Cess Amount"; Decimal)
        {
            Caption = 'Service Tax SHE Cess Amount';
        }
        field(16500; "Non ITC Claimable Usage %"; Decimal)
        {
            Caption = 'Non ITC Claimable Usage %';
            MaxValue = 100;
            MinValue = 0;
        }
        field(16501; "Amount Loaded on Inventory"; Decimal)
        {
            Caption = 'Amount Loaded on Inventory';
            Editable = false;
        }
        field(16502; "Input Tax Credit Amount"; Decimal)
        {
            Caption = 'Input Tax Credit Amount';
            Editable = false;
        }
        field(16503; "VAT able Purchase Tax Amount"; Decimal)
        {
            Caption = 'VAT able Purchase Tax Amount';
            Editable = false;
        }
        field(16504; Supplementary; Boolean)
        {
            Caption = 'Supplementary';
        }
        field(16505; "Source Document Type"; Option)
        {
            Caption = 'Source Document Type';
            OptionCaption = 'Posted Invoice,Posted Credit Memo';
            OptionMembers = "Posted Invoice","Posted Credit Memo";
        }
        field(16506; "Source Document No."; Code[20])
        {
            Caption = 'Source Document No.';
            TableRelation = IF ("Source Document Type" = FILTER("Posted Invoice")) "Purch. Inv. Header"."No."
            ELSE
            IF ("Source Document Type" = FILTER("Posted Credit Memo")) "Purch. Cr. Memo Hdr."."No.";
        }
        field(16509; "ADC VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'ADC VAT Amount';
            Editable = true;
        }
        field(16510; "CIF Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'CIF Amount';
        }
        field(16511; "BCD Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'BCD Amount';
        }
        field(16512; CVD; Boolean)
        {
            Caption = 'CVD';
        }
        field(16513; "Notification Sl. No."; Code[20])
        {
            Caption = 'Notification Sl. No.';
        }
        field(16514; "Notification No."; Code[20])
        {
            Caption = 'Notification No.';
        }
        field(16515; "CTSH No."; Code[10])
        {
            Caption = 'CTSH No.';
        }
        field(16518; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(16519; "SHE Cess % On TDS"; Decimal)
        {
            Caption = 'SHE Cess % On TDS';
            Editable = false;
        }
        field(16520; "SHE Cess on TDS Amount"; Decimal)
        {
            Caption = 'SHE Cess on TDS Amount';
            Editable = false;
        }
        field(16522; "Excise Loading on Inventory"; Boolean)
        {
            Caption = 'Excise Loading on Inventory';
        }
        field(16523; "Custom eCess Amount"; Decimal)
        {
            Caption = 'Custom eCess Amount';
        }
        field(16524; "Custom SHECess Amount"; Decimal)
        {
            Caption = 'Custom SHECess Amount';
        }
        field(16527; "Excise Refund"; Boolean)
        {
            Caption = 'Excise Refund';
        }
        field(16528; "CWIP G/L Type"; Option)
        {
            Caption = 'CWIP G/L Type';
            OptionCaption = ' ,Labor,Material,Overheads';
            OptionMembers = " ",Labor,Material,Overheads;

            trigger OnValidate()
            var
                Job: Record Job;
            begin
            end;
        }
        field(16529; "Applies-to ID (Delivery)"; Code[20])
        {
            Caption = 'Applies-to ID (Delivery)';
        }
        field(16530; "Applies-to ID (Receipt)"; Code[20])
        {
            Caption = 'Applies-to ID (Receipt)';
        }
        field(16531; "Delivery Challan Date"; Date)
        {
            Caption = 'Delivery Challan Date';
        }
        field(16532; "Item Charge Entry"; Boolean)
        {
            Caption = 'Item Charge Entry';
        }
        field(50000; "Rejection Reason Code"; Code[10])
        {
            Description = 'Customization No. 10';
            TableRelation = "Reason Code";
        }
        field(50001; "Shortage Reason Code"; Code[10])
        {
            Description = 'Customization No. 10';
            TableRelation = "Reason Code";
        }
        field(50002; "Challan Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Customization No. 10';
        }
        field(50003; "Actual Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Customization No. 10';
        }
        field(50004; "Accepted Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Customization No. 10';
        }
        field(50005; "Shortage Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'Customization No. 10';
        }
        field(50006; "Rejected Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
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
        field(50013; "Indent Date"; Date)
        {
            Description = 'Report 84 EXIM ravi';
        }
        field(50014; "Main Location"; Code[10])
        {
        }
        field(50015; "Starting Date"; Date)
        {
        }
        field(50016; "Ending Date"; Date)
        {
        }
        field(50019; "Excise Amount Per Unit"; Decimal)
        {
            DecimalPlaces = 2 : 4;
            Description = 'ND';
        }
        field(50020; "Posting Date 1"; Date)
        {
            Editable = true;
        }
        field(50021; "Unit Price (FCY)"; Decimal)
        {
            Caption = 'Unit Price (FCY) Per Sq.Mt.';
            Description = 'ND';
        }
        field(50022; "Amount (FCY)"; Decimal)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50023; Currency1; Code[10])
        {
            TableRelation = Currency;
        }
        field(50024; "Receipt Date"; Date)
        {
            CalcFormula = Lookup("Purch. Rcpt. Header"."Posting Date" WHERE("No." = FIELD("Receipt No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50025; "Source Order No."; Code[20])
        {
            Description = 'TRI S.K 030610';
        }
        field(50026; Selection; Boolean)
        {
            Description = 'Ori Ut270710';
        }
        field(50031; "Shortage CRN"; Boolean)
        {
            Description = 'TRI VKG 23.09.10';
        }
        field(50038; "Orient MRP"; Decimal)
        {
            Description = 'TRI V.D New Field Added';
        }
        field(60010; "Rejection No."; Code[20])
        {
            Editable = false;
            NotBlank = true;
        }
        field(60011; "Store Rejection No."; Code[20])
        {
        }
        field(60012; "Rejection Date"; Date)
        {
            CalcFormula = Lookup("Rejection Purchase Header"."Posting Date" WHERE("Rejection No." = FIELD("Rejection No.")));
            FieldClass = FlowField;
        }
        field(60013; "MRN No."; Code[20])
        {
        }
        field(60014; "MRN Date"; Date)
        {
        }
        field(99000750; "Routing No."; Code[10])
        {
            Caption = 'Routing No.';
            TableRelation = "Routing Header";
        }
        field(99000751; "Operation No."; Code[10])
        {
            Caption = 'Operation No.';
            TableRelation = "Prod. Order Routing Line"."Operation No." WHERE(Status = CONST(Released),
                                                                              "Prod. Order No." = FIELD("Prod. Order No."),
                                                                              "Routing No." = FIELD("Routing No."));

            trigger OnValidate()
            var
                ProdOrderRtngLine: Record "Prod. Order Routing Line";
            begin
            end;
        }
        field(99000752; "Work Center No."; Code[10])
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
        key(Key1; "Rejection No.", "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PurchHeader: Record "Purchase Header";
        PurchLine2: Record "Purchase Line";
        TempPurchLine: Record "Purchase Line";
        GLAcc: Record "G/L Account";
        Item: Record Item;
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        ItemTranslation: Record "Item Translation";
        SalesOrderLine: Record "Sales Line";
        VATPostingSetup: Record "VAT Posting Setup";
        StdTxt: Record "Standard Text";
        FA: Record "Fixed Asset";
        FADeprBook: Record "FA Depreciation Book";
        FASetup: Record "FA Setup";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        GenProdPostingGrp: Record "Gen. Product Posting Group";
        ReservEntry: Record "Reservation Entry";
        UnitOfMeasure: Record "Unit of Measure";
        ItemCharge: Record "Item Charge";
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
        SKU: Record "Stockkeeping Unit";
        WorkCenter: Record "Work Center";
        PurchasingCode: Record Purchasing;
        InvtSetup: Record "Inventory Setup";
        Location: Record Location;
        GLSetup: Record "General Ledger Setup";
        ReturnReason: Record "Return Reason";
        ItemVend: Record "Item Vendor";
        CalChange: Record "Customized Calendar Change";
        JobJnlLine: Record "Job Journal Line" temporary;
        Reservation: Page Reservation;
        ItemAvailByDate: Page "Item Availability by Periods";
        ItemAvailByVar: Page "Item Availability by Variant";
        ItemAvailByLoc: Page "Item Availability by Location";
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
        //  ReservePurchLine: Codeunit "Purch. Line-Reserve";
        UOMMgt: Codeunit "Unit of Measure Management";
        AddOnIntegrMgt: Codeunit AddOnIntegrManagement;
        DimMgt: Codeunit DimensionManagement;
        DistIntegration: Codeunit "Dist. Integration";
        NonstockItemMgt: Codeunit "Catalog Item Management";
        WhseValidateSourceLine: Codeunit "Whse. Validate Source Line";
        LeadTimeMgt: Codeunit "Lead-Time Management";
        PurchPriceCalcMgt: Codeunit 7010;
        CalendarMgmt: Codeunit "Calendar Management";
        CheckDateConflict: Codeunit "Reservation-Check Date Confl.";
        TrackingBlocked: Boolean;
        StatusCheckSuspended: Boolean;
        GLSetupRead: Boolean;
        UnitCostCurrency: Decimal;
        UpdateFromVAT: Boolean;
        //  TDSNOD: Record 13726; //16225 Table N/F
        // NODLines: Record 13785;//16225 Table N/F
        //16225 TDSBuf: array[2] of Record 13714 temporary;
        // TDSSetup: Record 13728; //16225 table N/F
        TDSBaseLCY: Decimal;
        TDSPercentage: Decimal;
        SurchargePercentage: Decimal;
        TempTDSBase: Decimal;
        CFactor: Decimal;
        CompanyInfo: Record "Company Information";
        CompanyInfoRead: Boolean;
        // ExcisePostingSetup: Record "13711";
        PurchHeader2: Record "Purchase Header";
        SurchargeBaseLCY: Decimal;
        TaxAmount: Decimal;
        AssessableValueCalc: Boolean;
        "...tri1.0": Integer;
        PurchasePayablesSetup: Record "Purchases & Payables Setup";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Location1: Record Location;
        UserAccess: Integer;
        Permissions: Codeunit Permissions1;
        UserLocation: Record "User Location";
        IndentLine: Record "Indent Line";
        TaxGroup: Record "Tax Group";
        PurchHeader11: Record "Purchase Header";
        tgSalesPrice: Record "Sales Price";
        tgPurchHdr: Record "Purchase Header";
        tgPurchRctHeader: Record "Purch. Rcpt. Header";
        Text000: Label 'You cannot rename a %1.';
        Text001: Label 'You cannot change %1 because the order line is associated with sales order %2.';
        Text002: Label 'Prices including VAT cannot be calculated when %1 is %2.';
        Text003: Label 'You cannot purchase resources.';
        Text004: Label 'must not be less than %1';
        Text006: Label 'You cannot invoice more than %1 units.';
        Text007: Label 'You cannot invoice more than %1 base units.';
        Text008: Label 'You cannot receive more than %1 units.';
        Text009: Label 'You cannot receive more than %1 base units.';
        Text010: Label 'You cannot change %1 when %2 is %3.';
        Text011: Label ' must be 0 when %1 is %2';
        Text012: Label 'must not be specified when %1 = %2';
        Text014: Label 'Change %1 from %2 to %3?';
        Text016: Label '%1 is required for %2 = %3.';
        Text017: Label '\The entered information will be disregarded by warehouse operations.';
        Text018: Label '%1 %2 is earlier than the work date %3.';
        Text020: Label 'You cannot return more than %1 units.';
        Text021: Label 'You cannot return more than %1 base units.';
        Text022: Label 'You cannot change %1, if item charge is already posted.';
        Text023: Label 'You cannot change the %1 when the %2 has been filled in.';
        Text029: Label 'must be positive.';
        Text030: Label 'must be negative.';
        Text031: Label 'You cannot define item tracking on this line because it is linked to production order %1.';
        Text032: Label '%1 must not be greater than %2.';
        Text033: Label 'Warehouse ';
        Text034: Label 'Inventory ';
        Text035: Label '%1 units for %2 %3 have already been returned or transferred. Therefore, only %4 units can be returned.';
        Text036: Label 'You must cancel the existing approval for this document to be able to change the %1 field.';
        Text037: Label 'cannot be %1.';
        Text038: Label 'cannot be less than %1.';
        Text039: Label 'cannot be more than %1.';
        Text99000000: Label 'You cannot change %1 when the purchase order is associated to a production order.';
        Text042: Label 'You cannot return more than the %1 units that you have received for %2 %3.';
        Text043: Label 'must be positive when %1 is not 0.';
        Text044: Label 'You cannot change %1 because this purchase order is associated with %2 %3.';
        Text13700: Label 'You are not allowed to select this Nature of deduction.';
        Text13701: Label 'BED AMOUNT';
        Text13702: Label 'AED AMOUNT';
        Text13703: Label 'SED AMOUNT';
        Text13704: Label 'SAED AMOUNT';
        Text13705: Label 'CESS AMOUNT';
        Text13706: Label 'NCCD AMOUNT';
        Text13707: Label 'ECESS AMOUNT';
        Text13708: Label 'ADET AMOUNT';
        Text13709: Label 'LINE AMOUNT';
        Text13710: Label 'ADE AMOUNT';
        Text13711: Label 'Type must be Item or Fixed Asset.';
        Text13712: Label 'Type must be G/L Account or Charge (Item).';
        Text16350: Label 'cannot be changed if it has already been invoiced.';
        Text16351: Label 'The Document must be a Return Order.';
        Text16362: Label 'No Transaction allowed; Status is Closed.';
        Text16363: Label 'Invalid Quantity.';
        Text16500: Label 'Applied Invoice No %1 in the Return Order is closed or missing from RG23 D.';
        Text16501: Label 'The maximum available quantity for item %1 in RG 23 D register is %2. Please reduce the %3.';
        Text13713: Label 'SHE CESS AMOUNT';
        Text16502: Label 'ADC VAT AMOUNT';
        Text16503: Label 'BCD AMOUNT';
        Text16504: Label 'CIF AMOUNT';
        Text16505: Label 'CUST. ECESS AMOUNT';
        Text16506: Label 'CUST. SHECESS AMOUNT';
        Text16507: Label 'Type must be G/L Account or Item in Purchase Line Document Type=%1'',Document No.=%2,Line No.=%3.';
        Text16508: Label 'To view Excise Detail the Structure should include Excise. ';
        Text16509: Label 'TDS cannot be deducted for negative Line Amounts \ Document Type=%1'',Document No.=%2,Line No.=%3.';
        //16225 "--NAVIN--": ;
        Text100: Label 'Quantity Per Should be greater than Zero in Excise Posting Setup.';
        Text101: Label 'You are not allowed to select this Nature of deduction.';
        Text103: Label 'Tax area is not defined for Vendor Location %1 to Receiving Location %2.';
        Txt001: Label 'You can not have %1 Defined in structure for Import Document';
        Text16360: Label 'There is still Components pending at vendor location';
        Text16361: Label 'Reopening is not allowed Production Order %1 has already been reported as Finished';
        text16321: Label 'You can not delete the purchase line as one or more ledger entries exists.';
        Text16322: Label 'You are not allowed to make this change in a Subcontracting Order';
        Text16323: Label 'The selected structure will load the sales tax component on inventory value. Do you want to proceed ?';
        Text16324: Label 'The selected structure will not load the sales tax component on inventory value. Do you want to proceed ?';
        //16225  "....tri1.0": ;
        Text0001: Label 'You can''t enter more than %1 units.';
        Text0002: Label 'Acutal Quantity must be filled in.';
        Text0003: Label 'Item is Blocked for Purchase insertion.';

    procedure InitOutstanding()
    begin
    end;

    procedure InitOutstandingAmount()
    var
        AmountInclVAT: Decimal;
    begin
    end;

    procedure InitQtyToReceive()
    begin
    end;

    procedure InitQtyToShip()
    begin
    end;

    procedure InitQtyToInvoice()
    begin
    end;

    local procedure InitItemAppl()
    begin
    end;

    procedure MaxQtyToInvoice(): Decimal
    begin
    end;

    procedure MaxQtyToInvoiceBase(): Decimal
    begin
    end;

    procedure CalcInvDiscToInvoice()
    var
        OldInvDiscAmtToInv: Decimal;
    begin
    end;

    local procedure CalcBaseQty(Qty: Decimal): Decimal
    begin
    end;

    local procedure SelectItemEntry()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
    end;

    procedure SetPurchHeader(NewPurchHeader: Record "Purchase Header")
    begin
    end;

    local procedure GetPurchHeader()
    begin
    end;

    local procedure GetItem()
    begin
    end;

    local procedure UpdateDirectUnitCost(CalledByFieldNo: Integer)
    begin
    end;

    procedure UpdateUnitCost()
    var
        DiscountAmountPerQty: Decimal;
    begin
    end;

    procedure UpdateAmounts()
    begin
    end;

    local procedure UpdateVATAmounts()
    var
        PurchLine2: Record "Purchase Line";
        TotalLineAmount: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalQuantityBase: Decimal;
    begin
    end;

    local procedure UpdateSalesCost()
    begin
    end;

    local procedure GetFAPostingGroup()
    var
        LocalGLAcc: Record "G/L Account";
        FAPostingGr: Record "FA Posting Group";
    begin
    end;

    procedure UpdateUOMQtyPerStockQty()
    begin
    end;

    procedure ShowReservation()
    begin
    end;

    procedure ShowReservationEntries(Modal: Boolean)
    begin
    end;

    procedure GetDate(): Date
    begin
    end;

    procedure Signed(Value: Decimal): Decimal
    begin
    end;

    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
    end;

    procedure BlanketOrderLookup()
    begin
    end;

    procedure BlockDynamicTracking(SetBlock: Boolean)
    begin
    end;

    procedure ShowDimensions()
    begin
    end;

    procedure OpenItemTrackingLines()
    begin
    end;

    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20]; Type4: Integer; No4: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
    end;

    local procedure GetSKU(): Boolean
    begin
    end;

    procedure ShowItemChargeAssgnt()
    var
        ItemChargeAssgnts: Page "Item Charge Assignment (Purch)";
        AssignItemChargePurch: Codeunit "Item Charge Assgnt. (Purch.)";
    begin
    end;

    procedure UpdateItemChargeAssgnt()
    var
        ShareOfVAT: Decimal;
    begin
    end;

    local procedure DeleteItemChargeAssgnt(DocType: Option; DocNo: Code[20]; DocLineNo: Integer)
    begin
    end;

    local procedure DeleteChargeChargeAssgnt(DocType: Option; DocNo: Code[20]; DocLineNo: Integer)
    begin
    end;


    procedure CheckItemChargeAssgnt()
    var
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
    begin
    end;

    local procedure GetFieldCaption(FieldNumber: Integer): Text[100]
    var
        "Field": Record Field;
    begin
    end;

    local procedure GetCaptionClass(FieldNumber: Integer): Text[80]
    begin
    end;

    local procedure TestStatusOpen()
    begin
    end;

    procedure SuspendStatusCheck(Suspend: Boolean)
    begin
    end;

    procedure UpdateLeadTimeFields()
    var
        StartingDate: Date;
    begin
    end;

    procedure GetUpdateBasicDates()
    begin
    end;

    procedure UpdateDates()
    begin
    end;

    procedure InternalLeadTimeDays(PurchDate: Date): Text[30]
    var
        SafetyLeadTime: DateFormula;
        TotalDays: DateFormula;
    begin
    end;

    procedure UpdateVATOnLines(QtyType: Option General,Invoicing,Shipping; var PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var VATAmountLine: Record "VAT Amount Line")
    var
        TempVATAmountLineRemainder: Record "VAT Amount Line" temporary;
        Currency: Record Currency;
        ChangeLogMgt: Codeunit "Change Log Management";
        RecRef: RecordRef;
        xRecRef: RecordRef;
        NewAmount: Decimal;
        NewAmountIncludingVAT: Decimal;
        NewVATBaseAmount: Decimal;
        VATAmount: Decimal;
        VATDifference: Decimal;
        InvDiscAmount: Decimal;
        LineAmountToInvoice: Decimal;
    begin
    end;

    procedure CalcVATAmountLines(QtyType: Option General,Invoicing,Shipping; var PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var VATAmountLine: Record "VAT Amount Line")
    var
        PrevVatAmountLine: Record "VAT Amount Line";
        Currency: Record Currency;
        Vendor: Record Vendor;
        VendorPostingGroup: Record "Vendor Posting Group";
        PurchSetup: Record "Purchases & Payables Setup";
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        QtyToHandle: Decimal;
        RoundingLineInserted: Boolean;
        TotalVATAmount: Decimal;
    begin
    end;

    procedure UpdateWithWarehouseReceive()
    begin
    end;

    local procedure CheckWarehouse()
    var
        Location2: Record Location;
        WhseSetup: Record "Warehouse Setup";
        ShowDialog: Option " ",Message,Error;
        DialogText: Text[50];
    begin
    end;

    local procedure GetOverheadRateFCY(): Decimal
    var
        QtyPerUOM: Decimal;
    begin
    end;

    procedure GetItemTranslation()
    begin
    end;

    local procedure GetGLSetup()
    begin
    end;

    procedure AdjustDateFormula(DateFormulatoAdjust: DateFormula): Text[30]
    begin
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
    end;

    procedure RowID1(): Text[250]
    var
        ItemTrackingMgt: Codeunit "Item Tracing Mgt.";
    begin
    end;

    local procedure GetDefaultBin()
    var
        WMSManagement: Codeunit "WMS Management";
    begin
    end;

    procedure CrossReferenceNoLookUp()
    var
    //  ItemCrossReference: Record "Item Cross Reference";
    begin
    end;

    procedure ItemExists(ItemNo: Code[20]): Boolean
    var
        Item2: Record Item;
    begin
    end;

    local procedure GetAbsMin(QtyToHandle: Decimal; QtyHandled: Decimal): Decimal
    begin
    end;

    local procedure CheckApplToItemLedgEntry(): Code[10]
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ApplyRec: Record "Item Application Entry";
        QtyBase: Decimal;
        RemainingQty: Decimal;
        ReturnedQty: Decimal;
        RemainingtobeReturnedQty: Decimal;
    begin
    end;

    procedure CalcPrepaymentToDeduct()
    begin
    end;

    procedure JobTaskIsSet(): Boolean
    begin
    end;

    procedure CreateTempJobJnlLine(GetPrices: Boolean)
    begin
    end;

    procedure UpdatePricesFromJobJnlLine()
    begin
    end;

    procedure JobSetCurrencyFactor()
    begin
    end;

    procedure SetUpdateFromVAT(UpdateFromVAT2: Boolean)
    begin
    end;

    procedure InitQtyToReceive2()
    begin
    end;

    procedure ShowLineComments()
    var
        PurchCommentLine: Record "Purch. Comment Line";
        PurchCommentSheet: Page "Purch. Comment Sheet";
    begin
    end;

    procedure SetDefaultQuantity()
    var
        PurchSetup: Record "Purchases & Payables Setup";
    begin
    end;

    local procedure UpdatePrePaymentAmounts()
    var
        ReceiptLine: Record "Purch. Rcpt. Line";
        PurchOrderLine: Record "Purchase Line";
    begin
    end;

    procedure SetVendorItemNo()
    begin
    end;

    procedure ZeroAmountLine(QtyType: Option General,Invoicing,Shipping): Boolean
    begin
    end;

    procedure UpdateTaxAmounts()
    var
        // ServiceTaxSetup: Record 16472; //16225 table N/F
        Vendor: Record Vendor;
        //IndianSalesTaxCalculate: Codeunit 13704; //16225 Table N/F
        LineTaxAmount: Decimal;
        VatCalculatedAmounts: Text[100];
        ServiceTaxAbatement: Integer;
        ItemChargeAssgntPurch2: Record "Item Charge Assignment (Purch)";
        // DetailedTaxEntryBuffer: Record 16480; //16225 Table N/F
        // DefermentBuffer: Record "16532"; //16225 Table N/F
        TotalTaxAmount: Decimal;
        AmountonInventory: Decimal;
        InputTaxCreditAmount: Decimal;
        VATablePurchTaxAmount: Decimal;
        TotalAmountonInventory: Decimal;
        TotalInputTaxCreditAmount: Decimal;
        TotalVATablePurchTaxAmount: Decimal;
    begin
    end;

    procedure UpdateExciseAmount()
    var
        //   ExciseProdPostingGrp: Record 13710; //16225 Table N/F
        //   ExcisePostingSetup: Record 13711; //16225 Table N/F
        ItemUOM: Record "Item Unit of Measure";
        Vendor: Record Vendor;
        SSI: Boolean;
    begin
    end;

    local procedure InitExciseAmount()
    var
    //  StrOrderLineDet: Record 13795; //16225 Table N/F
    begin
    end;

    local procedure EvaluateExpression(IsTestExpression: Boolean; Expression: Code[250]; PurchLine: Record "Purchase Line"): Decimal
    var
        Result: Decimal;
        Calllevel: Integer;
        Parantheses: Integer;
        IsExpression: Boolean;
        Operators: Text[8];
        OperatorNo: Integer;
        IsFilter: Boolean;
        i: Integer;
        RightResult: Decimal;
        LeftResult: Decimal;
        RightOperand: Text[250];
        LeftOperand: Text[250];
        Operator: Char;
        PurchLine1: Record "Purchase Line";
        DivisionError: Boolean;
    begin
    end;

    local procedure TaxAreaUpdate()
    var
        // TaxLocation: Record 13761; //16225 table N/F
        TaxGroup: Record "Tax Group";
    begin
    end;

    procedure CalculateStructures(var PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        //StrOrderDetails: Record "13794";//16225 Table N/F
        // StrOrderLineDetails: Record "13795";//16225 Table N/F
        // StrOrderLines: Record "13795";//16225 Table N/F
        Currency: Record Currency;
        TotalAmount: Decimal;
        BaseAmount: Decimal;
        CFactor: Decimal;
        AmountToVendor: Decimal;
        PurchTotalLine: Decimal;
    begin
    end;
    //16225 EvaluateExpressioninStructures Funcation N/F
    /* local procedure EvaluateExpressioninStructures(IsTestExpression: Boolean;Expression: Code[250];PurchLine: Record "Purchase Line";var StructureOrderDetails: Record 13794): Decimal
     var
         StrOrderLineDetails2: Record "13795";
         TD: Record "13795";
         StructureOrderDetails1: Record "13794";
         PurchaseLine: Record "39";
         Result: Decimal;
         Calllevel: Integer;
         Parantheses: Integer;
         IsExpression: Boolean;
         Operators: Text[8];
         OperatorNo: Integer;
         IsFilter: Boolean;
         i: Integer;
         RightResult: Decimal;
         LeftResult: Decimal;
         RightOperand: Text[250];
         LeftOperand: Text[250];
         Operator: Char;
         DivisionError: Boolean;
         Exp: Integer;
     begin
     end;*/

    procedure AdjustStructureAmounts(var PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        // StrOrderDetails: Record "13794"; //16225 Table N/F
        // StrOrderLineDetails: Record "13795"; //16225 Table N/F
        //  StrOrderLines: Record "13795"; //16225 Table N/F
        GLAcc: Record "G/L Account";
        TotalAmount: Decimal;
        TotalLines: Decimal;
        BaseAmount: Decimal;
        CFactor: Decimal;
        StructureAmount: Decimal;
        DiffAmount: Decimal;
        Adjusted: Boolean;
    begin
    end;

    procedure UpdatePurchLines(var PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        //StrOrderDetails: Record 13794; //16225 Table N/F
        //StrOrderLineDetails: Record "13795"; //16225 Table N/F
        // StrOrderLines: Record "13795"; //16225 Table N/F
        Currency: Record Currency;
        TotalAmount: Decimal;
        TotalLines: Decimal;
        BaseAmount: Decimal;
        CFactor: Decimal;
        ChargesToVendor: Decimal;
    begin
    end;

    procedure CalculateTDS(var PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        TDSEntry: Record "TDS Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        // TDSGroup: Record 13731; //16225 Table N/F
        CurrPurchLine: Record "Purchase Line";
        Vendor: Record Vendor;
        DateFilterCalc: Codeunit "DateFilter-Calc";
        AccountingPeriodFilter: Text[30];
        FiscalYear: Boolean;
        PreviousTDSAmt: Decimal;
        PreviousSurchargeAmt: Decimal;
        PreviousAmount: Decimal;
        AppliedAmount: Decimal;
        CurrentPOTDSAmt: Decimal;
        CurrentPOAmount: Decimal;
        CurrentPOContractAmt: Decimal;
        CurrentPOContractTDSAmt: Decimal;
        CurrentJnlSurChargeamt: Decimal;
        CalculatedTDSAmt: Decimal;
        CalculatedSurchargeAmt: Decimal;
        CalculateSurcharge: Boolean;
        SurchargeBase: Decimal;
        PreviousContractAmount: Decimal;
        InvoiceAmount: Decimal;
        PaymentAmount: Decimal;
        CurrentAmount: Decimal;
        AppliedAmountDoc: Decimal;
        // ServiceTaxEntry: Record "16473"; //16225 table N/F
        ServiceTaxAmt: Decimal;
        ServiceTaxECessAmt: Decimal;
        ServiceTaxSHECessAmt: Decimal;
    // StrOrdLineDet: Record "13795"; //16225 Table N/F
    begin
    end;

    local procedure CheckNonResidentGroup(PurchLine: Record "Purchase Line"; PostingDate: Date)
    var
    //  TDSGroup: Record 13731; //16225 Table N/F
    begin
    end;

    local procedure RoundTDSAmount(TDSAmount: Decimal): Decimal
    var
        TDSRoundingDirection: Text[1];
        TDSRoundingPrecision: Decimal;
    begin
    end;

    local procedure InsertTDSBuf(TDSEntry: Record "TDS Entry"; PostingDate: Date; CalculateSurcharge: Boolean; CalculateTDS: Boolean)
    begin
    end;

    local procedure UpdTDSBuffer()
    begin
    end;

    local procedure InsertGenTDSBuf(Applied: Boolean)
    begin
    end;

    procedure ValidateQuantity()
    begin
    end;

    procedure UpdateSubConOrderLines()
    var
        SubOrderComponents: Record "Sub Order Component List";
        SubOrderCompListVend: Record "Sub Order Comp. List Vend";
    begin
    end;


    procedure TestSubcontractingEntries()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        Text16321: Label 'You can not delete the purchase line as one or more ledger entries exists.';
    begin
    end;

    procedure DeleteSubconDetails()
    var
        SubOrderComponents: Record "Sub Order Component List";
        SubOrderCompListVend: Record "Sub Order Comp. List Vend";
    begin
    end;

    procedure UpdateProdOrder()
    var
        ProdOrderLine: Record "Prod. Order Line";
    begin
    end;

    procedure PurchaseTotalLines(PurchLine: Record "Purchase Line"): Integer
    begin
    end;

    local procedure InitTDSAmounts(var PurchaseLine: Record "Purchase Line")
    begin
    end;


    procedure GetBaseAmt(var Amt: Decimal; DocNo: Code[20]; Item: Code[20]; PurchLine: Record "Purchase Line"): Decimal
    var
        //16225 RG23D: Record "16537";
        PurchHeader: Record "Purchase Header";
        Qty: Decimal;
        CurrencyFactor: Decimal;
    begin
    end;


    procedure InitDetailRG23D(Qty: Decimal; EntryNo: Integer)
    var
    //16225  DetailRG23D: Record "16533";
    begin
    end;


    procedure GetEntryNo(): Integer
    var
    //16225    DetailRG23D: Record "16533";
    begin
    end;


    procedure CheckAvailableQty(DocNo: Code[20])
    var
        PurchLine: Record "Purchase Line";
        //16225  Rg23D: Record "16537";
        //16225  DetailRG23D: Record "16533";
        QtyAllocated: Decimal;
    begin
    end;


    procedure UpdateStruOrdLineDetails()
    var
    //16225 StructureDetail: Record "13793";
    //16225 StrOrderLineDetails: Record "13795";
    begin
    end;

    local procedure GetCompanyInfo()
    begin
    end;

    procedure GetCVDPayableToThirdParty(PurchLine: Record "Purchase Line"): Boolean
    var
        CVDPayableToThirdParty: Boolean;
    //16225  StrOrderDetails: Record "13794";
    begin
    end;

    procedure GetExcisePostingSetup()
    var
        PurchaseHeader2: Record "Purchase Header";
    //16225  ExcisePostingSetup2: Record "13711";
    //16225  ExcisePostingSetupForm: Page "13710";
    //16225  StructureDetails: Record "13793";
    begin
    end;


    procedure UpdateIssueDetails()
    var
        PurchLine: Record "Purchase Line";
        SubOrderComponents: Record "Sub Order Component List";
    begin
    end;


    procedure SetSubconAppliestoID(ID: Code[20]; var PurchLine: Record "Purchase Line"; Delivery: Boolean)
    begin
    end;

    procedure MultipleDeliveryChallanList()
    var
        DeliveryChallanHeader: Record "Delivery Challan Header";
        DeliveryChallanLine: Record "Delivery Challan Line";
        DelivChallanListMult: Page "Delivery Challan List";
    begin
    end;


    procedure ShowSubOrderDetailsForm()
    var
        PurchaseLine: Record "Purchase Line";
    begin
    end;


    procedure CheckAssessableValue(PurchHeader: Record "Purchase Header"): Boolean
    var
        //16225   ExciseProdPostingGrp: Record "13710";
        //16225  ExcisePostingSetup: Record "13711";
        Vendor: Record Vendor;
        SSI: Boolean;
        AssessableValue: Boolean;
    begin
    end;

    procedure ShowSubOrderRcptForm()
    var
        PurchaseLine: Record "Purchase Line";
    begin
    end;
}

