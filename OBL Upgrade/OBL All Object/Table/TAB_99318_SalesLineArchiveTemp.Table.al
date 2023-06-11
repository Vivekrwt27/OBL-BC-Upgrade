table 99318 "Sales Line Archive Temp"
{
    Caption = 'Sales Line Archive';

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Sales Header Archive"."No." WHERE("Document Type" = FIELD("Document Type"),
                                                              "Version No." = FIELD("Version No."));
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
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE
            IF (Type = CONST("Item")) Item
            ELSE
            IF (Type = CONST(Resource)) Resource
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
        field(9; "Quantity Disc. Code"; Code[20])
        {
            Caption = 'Quantity Disc. Code';
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
        field(18; "Qty. to Ship"; Decimal)
        {
            Caption = 'Qty. to Ship';
            DecimalPlaces = 0 : 5;
        }
        field(22; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
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
            //AutoFormatExpression = "Currency Code";//16225 
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';
        }
        field(29; Amount; Decimal)
        {
            // AutoFormatExpression = "Currency Code";//16225
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(30; "Amount Including VAT"; Decimal)
        {
            //AutoFormatExpression = "Currency Code";//16225
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
        field(42; "Price Group Code"; Code[10])
        {
            Caption = 'Price Group Code';
            TableRelation = "Customer Price Group";
        }
        field(43; "Allow Quantity Disc."; Boolean)
        {
            Caption = 'Allow Quantity Disc.';
            InitValue = true;
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
        field(55; "Cust./Item Disc. %"; Decimal)
        {
            Caption = 'Cust./Item Disc. %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(57; "Outstanding Amount"; Decimal)
        {
            // AutoFormatExpression = "Currency Code";//16225
            AutoFormatType = 1;
            Caption = 'Outstanding Amount';
            Editable = false;
        }
        field(58; "Qty. Shipped Not Invoiced"; Decimal)
        {
            Caption = 'Qty. Shipped Not Invoiced';
            DecimalPlaces = 0 : 5;
        }
        field(59; "Shipped Not Invoiced"; Decimal)
        {
            // AutoFormatExpression = "Currency Code";//16225
            AutoFormatType = 1;
            Caption = 'Shipped Not Invoiced';
        }
        field(60; "Quantity Shipped"; Decimal)
        {
            Caption = 'Quantity Shipped';
            DecimalPlaces = 0 : 5;
        }
        field(61; "Quantity Invoiced"; Decimal)
        {
            Caption = 'Quantity Invoiced';
            DecimalPlaces = 0 : 5;
        }
        field(63; "Shipment No."; Code[20])
        {
            Caption = 'Shipment No.';
        }
        field(64; "Shipment Line No."; Integer)
        {
            Caption = 'Shipment Line No.';
        }
        field(67; "Profit %"; Decimal)
        {
            Caption = 'Profit %';
            DecimalPlaces = 0 : 5;
        }
        field(68; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
            // AutoFormatExpression = "Currency Code";//16225
            AutoFormatType = 1;
            Caption = 'Inv. Discount Amount';
        }
        field(71; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            TableRelation = IF ("Drop Shipment" = CONST(TRUE)) "Purchase Header"."No." WHERE("Document Type" = CONST(Order));
        }
        field(72; "Purch. Order Line No."; Integer)
        {
            Caption = 'Purch. Order Line No.';
            TableRelation = IF ("Drop Shipment" = CONST(TRUE)) "Purchase Line"."Line No." WHERE("Document Type" = CONST(Order),
                                                                                            "Document No." = FIELD("Purchase Order No."));
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
            TableRelation = "Sales Line Archive"."Line No." WHERE("Document Type" = FIELD("Document Type"),
                                                                   "Document No." = FIELD("Document No."),
                                                                   "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"),
                                                                   "Version No." = FIELD("Version No."));
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
        field(93; "Shipped Not Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Shipped Not Invoiced (LCY)';
        }
        field(96; Reserve; Option)
        {
            Caption = 'Reserve';
            OptionCaption = 'Never,Optional,Always';
            OptionMembers = Never,Optional,Always;
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
        field(5405; Planned; Boolean)
        {
            Caption = 'Planned';
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
        field(5418; "Qty. to Ship (Base)"; Decimal)
        {
            Caption = 'Qty. to Ship (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5458; "Qty. Shipped Not Invd. (Base)"; Decimal)
        {
            Caption = 'Qty. Shipped Not Invd. (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5460; "Qty. Shipped (Base)"; Decimal)
        {
            Caption = 'Qty. Shipped (Base)';
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
        field(5701; "Out-of-Stock Substitution"; Boolean)
        {
            Caption = 'Out-of-Stock Substitution';
        }
        field(5702; "Substitution Available"; Boolean)
        {
            CalcFormula = Exist("Item Substitution" WHERE("Type" = CONST("Item"),
                                                           "No." = FIELD("No."),
                                                           "Substitute Type" = CONST(Item)));
            Caption = 'Substitution Available';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5703; "Originally Ordered No."; Code[20])
        {
            Caption = 'Originally Ordered No.';
            TableRelation = IF (Type = CONST(Item)) Item;
        }
        field(5704; "Originally Ordered Var. Code"; Code[10])
        {
            Caption = 'Originally Ordered Var. Code';
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("Originally Ordered No."));
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
        field(5714; "Special Order Purchase No."; Code[20])
        {
            Caption = 'Special Order Purchase No.';
            TableRelation = IF ("Special Order" = CONST(true)) "Purchase Header"."No." WHERE("Document Type" = CONST("Order"));
        }
        field(5715; "Special Order Purch. Line No."; Integer)
        {
            Caption = 'Special Order Purch. Line No.';
            TableRelation = IF ("Special Order" = CONST(true)) "Purchase Line"."Line No." WHERE("Document Type" = CONST("Order"),
                                                                                            "Document No." = FIELD("Special Order Purchase No."));
        }
        field(5752; "Completely Shipped"; Boolean)
        {
            Caption = 'Completely Shipped';
        }
        field(5790; "Requested Delivery Date"; Date)
        {
            Caption = 'Requested Delivery Date';
        }
        field(5791; "Promised Delivery Date"; Date)
        {
            Caption = 'Promised Delivery Date';
        }
        field(5792; "Shipping Time"; DateFormula)
        {
            Caption = 'Shipping Time';
        }
        field(5793; "Outbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Outbound Whse. Handling Time';
        }
        field(5794; "Planned Delivery Date"; Date)
        {
            Caption = 'Planned Delivery Date';
        }
        field(5795; "Planned Shipment Date"; Date)
        {
            Caption = 'Planned Shipment Date';
        }
        field(5796; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        field(5797; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
        }
        field(5800; "Allow Item Charge Assignment"; Boolean)
        {
            Caption = 'Allow Item Charge Assignment';
            InitValue = true;
        }
        field(5803; "Return Qty. to Receive"; Decimal)
        {
            Caption = 'Return Qty. to Receive';
            DecimalPlaces = 0 : 5;
        }
        field(5804; "Return Qty. to Receive (Base)"; Decimal)
        {
            Caption = 'Return Qty. to Receive (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5805; "Return Qty. Rcd. Not Invd."; Decimal)
        {
            Caption = 'Return Qty. Rcd. Not Invd.';
            DecimalPlaces = 0 : 5;
        }
        field(5806; "Ret. Qty. Rcd. Not Invd.(Base)"; Decimal)
        {
            Caption = 'Ret. Qty. Rcd. Not Invd.(Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5807; "Return Amt. Rcd. Not Invd."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Return Amt. Rcd. Not Invd.';
        }
        field(5808; "Ret. Amt. Rcd. Not Invd. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Ret. Amt. Rcd. Not Invd. (LCY)';
        }
        field(5809; "Return Qty. Received"; Decimal)
        {
            Caption = 'Return Qty. Received';
            DecimalPlaces = 0 : 5;
        }
        field(5810; "Return Qty. Received (Base)"; Decimal)
        {
            Caption = 'Return Qty. Received (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5811; "Appl.-from Item Entry"; Integer)
        {
            Caption = 'Appl.-from Item Entry';
            MinValue = 0;
        }
        field(5900; "Service Contract No."; Code[20])
        {
            Caption = 'Service Contract No.';
            TableRelation = "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract),
                                                                            "Customer No." = FIELD("Sell-to Customer No."),
                                                                            "Bill-to Customer No." = FIELD("Bill-to Customer No."));
        }
        field(5901; "Service Order No."; Code[20])
        {
            Caption = 'Service Order No.';
        }
        field(5902; "Service Item No."; Code[20])
        {
            Caption = 'Service Item No.';
            TableRelation = "Service Item"."No." WHERE("Customer No." = FIELD("Sell-to Customer No."));
        }
        field(5903; "Appl.-to Service Entry"; Integer)
        {
            Caption = 'Appl.-to Service Entry';
        }
        field(5904; "Service Item Line No."; Integer)
        {
            Caption = 'Service Item Line No.';
        }
        field(5907; "Serv. Price Adjmt. Gr. Code"; Code[10])
        {
            Caption = 'Serv. Price Adjmt. Gr. Code';
            TableRelation = "Service Price Adjustment Group";
        }
        field(5909; "BOM Item No."; Code[20])
        {
            Caption = 'BOM Item No.';
            TableRelation = Item;
        }
        field(6600; "Return Receipt No."; Code[20])
        {
            Caption = 'Return Receipt No.';
        }
        field(6601; "Return Receipt Line No."; Integer)
        {
            Caption = 'Return Receipt Line No.';
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
            DecimalPlaces = 0 : 4;
            Editable = false;
        }
        field(13702; "Excise Bus. Posting Group"; Code[10])
        {
            // TableRelation = "Excise Bus. Posting Group";//16225 Table N/F
        }
        field(13703; "Excise Prod. Posting Group"; Code[10])
        {
            // TableRelation = "Excise Prod. Posting Group";//16225 Table N/F
        }
        field(13704; "India Tax 2"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13705; "India Tax 3"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13706; "India Tax 4"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13707; "India Tax 1"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13708; "Excise Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13709; "Excise %"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13710; "Excise Calculation Type"; Option)
        {
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %","Amount/Unit","% of Accessable Value","Excise %+Amount/Unit";
        }
        field(13711; "Amount Including Excise"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
        }
        field(13712; "Excise Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
        }
        field(13715; "Excise Accounting Type"; Option)
        {
            OptionCaption = 'With CENVAT,Without CENVAT';
            OptionMembers = "With CENVAT","Without CENVAT";
        }
        field(13719; "Excise Base Quantity"; Decimal)
        {
            Description = 'Excise Base UOM Quantity';
        }
        field(13721; "Tax %"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(13722; "Amount Including Tax"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13724; "Amount Added to Excise Base"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
        }
        field(13725; "Amount Added to Tax Base"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
        }
        field(13727; "Tax Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13730; "Work Tax Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
        }
        field(13731; "Work Tax %"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
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
            //  TableRelation = "Concessional Codes";//16225 Table N/F
        }
        field(13741; "TDS Nature of Deduction"; Code[10])
        {
            // TableRelation = "TDS Nature of Deduction";
        }
        field(13742; "TDS Assessee Code"; Code[10])
        {
            Editable = false;
            // TableRelation = "TDS Nature of Deduction";
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
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13749; "Claim Deferred Excise"; Boolean)
        {
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
        field(13755; "BED Amount"; Decimal)
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
            Editable = false;
            OptionCaption = 'Percentage,Amount';
            OptionMembers = Percentage,Amount;
        }
        field(13762; "SAED % / Amount"; Decimal)
        {
            Editable = false;
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
        field(13773; "% of Accessable Value"; Decimal)
        {
        }
        field(13792; "% of Excise Applicable"; Decimal)
        {
            InitValue = 100;
        }
        field(13796; "Form Code"; Code[10])
        {

            trigger OnLookup()
            var
                StateForm: Record State;
            begin
            end;
        }
        field(13797; "Form No."; Code[10])
        {
        }
        field(13798; State; Code[10])
        {
            TableRelation = State;
        }
        field(13799; "TDS Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(16340; "Amount To Customer"; Decimal)
        {
            Editable = false;
        }
        field(16341; "Balance Work Tax Amount"; Decimal)
        {
            Editable = false;
        }
        field(16342; "Charges To Customer"; Decimal)
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
        field(16356; "Reverse VAT"; Boolean)
        {
        }
        field(16359; "Declared Goods"; Boolean)
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
            // TableRelation = "TDS Nature of Deduction";//16225 Table N/F
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
        field(16370; "Incentive Type"; Option)
        {
            OptionCaption = ' ,DFRC,DEPB,Duty Drawback';
            OptionMembers = " ",DFRC,DEPB,"Duty Drawback";

            trigger OnValidate()
            var
                ErrorText: Label 'Incentive type should be Blank if Export order is applied for Advance License or EPCG';
                ErrorText1: Label 'Incentive type cannot be changed if items have been shipped.';
                // SIONHeader: Record "13733"; //16225 Table N/F
                ErrorText2: Label 'Incentive type can only be select for items.';
                ErrorText3: Label '%1 should be defined as a SION Item in the SION Header.';
            begin
            end;
        }
        field(16371; "Package No."; Text[10])
        {
        }
        field(16372; "Pallet No."; Text[10])
        {
        }
        field(16374; "Claim DDB"; Boolean)
        {
        }
        field(16376; SelectItem; Boolean)
        {
        }
        field(16377; "Service Tax Group"; Code[20])
        {
            Caption = 'Service Tax Group';
            //TableRelation = "Service Tax Groups".Code; //16225 Table N/F

            trigger OnValidate()
            var
                CompanyInfo: Record "Company Information";
            begin
            end;
        }
        field(16378; "Service Tax %"; Decimal)
        {
            Caption = 'Service Tax %';
        }
        field(16379; "Service Tax Base"; Decimal)
        {
            Caption = 'Service Tax Base';
        }
        field(16380; "Service Tax Amount"; Decimal)
        {
            Caption = 'Service Tax Amount';
        }
        field(16381; "Service Tax Registration No."; Code[20])
        {
            Caption = 'Service Tax Registration No.';
            //TableRelation = "Service Tax Registration Nos.".Code; //16225 Table N/F
        }
        field(16382; "Service Tax Abetment"; Decimal)
        {
            Caption = 'Service Tax Abetment';
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
        field(16386; "Per Contract"; Boolean)
        {
        }
        field(16390; "Service Tax eCess %"; Decimal)
        {
            Caption = 'Service Tax eCess %';
        }
        field(16391; "Service Tax eCess Amount"; Decimal)
        {
            Caption = 'Service Tax eCess Amount';
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
        field(16456; "Free Supply"; Boolean)
        {
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
        field(50002; "Quantity in Cartons"; Decimal)
        {
        }
        field(50003; "Type Code"; Code[2])
        {
        }
        field(50004; "Plant Code"; Code[1])
        {
        }
        field(50005; "Size Code"; Code[3])
        {
        }
        field(50006; "Posting Date"; Date)
        {
            Description = 'report  S15';
        }
        field(50007; Schemes; Code[20])
        {
            Description = 'Customization No. 47';
        }
        field(50008; "Color Code"; Code[4])
        {
            Description = 'report s-20';
        }
        field(50009; "Design Code"; Code[4])
        {
        }
        field(50010; "Packing Code"; Code[2])
        {
        }
        field(50011; "Quality Code"; Code[1])
        {
        }
        field(50012; "Salesperson Code"; Code[10])
        {
            Description = 'Report n-4';
        }
        field(50013; "Quantity in Sq. Mt."; Decimal)
        {
            Editable = false;
        }
        field(50014; "Main Location"; Code[10])
        {
        }
        field(50015; "Buyer's Price"; Decimal)
        {
            Editable = false;
        }
        field(50016; "Discount Per Unit"; Decimal)
        {
        }
        field(50018; "Related Location code"; Code[20])
        {
        }
        field(50019; "Unit Price (FCY)"; Decimal)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50020; "Amount (FCY)"; Decimal)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50021; "Carton No. From"; Integer)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50022; "Carton No. To"; Integer)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50023; "Pallet No. From"; Integer)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50024; "Pallet No. To"; Integer)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50025; "Total Pallets"; Integer)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50026; "Total Cartons"; Integer)
        {
            Description = 'ND';
            Editable = false;
        }
        field(50028; "Group Code"; Code[2])
        {
            Editable = false;
        }
        field(50029; "Item Type"; Code[2])
        {
            Description = 'tri LM 100308';
        }
        field(50030; "Type Catogery Code"; Code[2])
        {
            Description = 'Tri NM 160308';
        }
        field(50031; "Order Qty"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" WHERE("Document Type" = FILTER("Order"),
                                                                            "Blanket Order No." = FIELD("Document No."),
                                                                            "Blanket Order Line No." = FIELD("Line No.")));
            Description = 'TRI DP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50032; "Remaining Inventory"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Location Code" = FIELD("Location Code"),
                                                                  "Variant Code" = FIELD("Variant Code")));
            Description = 'TRI DP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50033; "Total Reserved Quantity"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Location Code" = FIELD("Location Code"),
                                                                  "Source Type" = FILTER(32),
                                                                  "Variant Code" = FIELD("Variant Code")));
            Description = 'TRI DP';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50034; "Quantity in Sq. Mt.(Ship)"; Decimal)
        {
            Editable = false;
        }
        field(50035; "Quantity in Cartons(Ship)"; Decimal)
        {
            Editable = false;
        }
        field(50036; "Quantity in Hand"; Decimal)
        {
            Editable = false;
        }
        field(50038; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(50039; "Gross Weight (Ship)"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50040; "Net Weight (Ship)"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Doc. No. Occurrence", "Version No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = Amount, "Amount Including VAT", "Outstanding Amount", "Shipped Not Invoiced", "Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)";
        }
        key(Key2; State, "Size Code")
        {
        }
        key(Key3; "Design Code", "Color Code", "Quality Code", "Size Code", "Packing Code")
        {
        }
        key(Key4; "Design Code", "Color Code", "Quality Code", "Size Code", "Packing Code", "Sell-to Customer No.")
        {
        }
        key(Key5; "Plant Code")
        {
        }
        key(Key6; "Sell-to Customer No.", "Document No.")
        {
        }
    }

    fieldgroups
    {
    }
}

