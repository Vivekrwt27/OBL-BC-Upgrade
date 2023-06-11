table 70003 "Item New"
{
    DataCaptionFields = "No.", Description;
    DrillDownPageID = "Item List";
    LookupPageID = "Item List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "No. 2"; Code[20])
        {
            Caption = 'No. 2';
        }
        field(3; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(4; "Search Description"; Code[30])
        {
            Caption = 'Search Description';
        }
        field(5; "Description 2"; Text[30])
        {
            Caption = 'Description 2';
        }
        field(6; "Bill of Materials"; Boolean)
        {
            CalcFormula = Exist("BOM Component" WHERE("Parent Item No." = FIELD("No.")));
            Caption = 'Bill of Materials';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; Class; Code[10])
        {
            Caption = 'Class';
            //TableRelation = 6222;//16225 table N/F
        }
        field(8; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
        }
        field(9; "Price Unit Conversion"; Integer)
        {
            Caption = 'Price Unit Conversion';
        }
        field(11; "Inventory Posting Group"; Code[10])
        {
            Caption = 'Inventory Posting Group';
            TableRelation = "Inventory Posting Group";
        }
        field(12; "Shelf No."; Code[10])
        {
            Caption = 'Shelf No.';
        }
        field(14; "Item Disc. Group"; Code[10])
        {
            Caption = 'Item Disc. Group';
            TableRelation = "Item Discount Group";
        }
        field(15; "Allow Invoice Disc."; Boolean)
        {
            Caption = 'Allow Invoice Disc.';
            InitValue = true;
        }
        field(16; "Statistics Group"; Integer)
        {
            Caption = 'Statistics Group';
        }
        field(17; "Commission Group"; Integer)
        {
            Caption = 'Commission Group';
        }
        field(18; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';
            MinValue = 0;
        }
        field(19; "Price/Profit Calculation"; Option)
        {
            Caption = 'Price/Profit Calculation';
            OptionCaption = 'Profit=Price-Cost,Price=Cost+Profit,No Relationship';
            OptionMembers = "Profit=Price-Cost","Price=Cost+Profit","No Relationship";
        }
        field(20; "Profit %"; Decimal)
        {
            Caption = 'Profit %';
            DecimalPlaces = 0 : 5;
            MaxValue = 99.99999;
        }
        field(21; "Costing Method"; Option)
        {
            Caption = 'Costing Method';
            OptionCaption = 'FIFO,LIFO,Specific,Average,Standard';
            OptionMembers = FIFO,LIFO,Specific,"Average",Standard;
        }
        field(22; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            MinValue = 0;
        }
        field(24; "Standard Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Standard Cost';
            MinValue = 0;
        }
        field(25; "Last Direct Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Last Direct Cost';
            MinValue = 0;
        }
        field(28; "Indirect Cost %"; Decimal)
        {
            Caption = 'Indirect Cost %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(31; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;
        }
        field(32; "Vendor Item No."; Text[20])
        {
            Caption = 'Vendor Item No.';
        }
        field(33; "Lead Time Calculation"; DateFormula)
        {
            Caption = 'Lead Time Calculation';
        }
        field(34; "Reorder Point"; Decimal)
        {
            Caption = 'Reorder Point';
            DecimalPlaces = 0 : 5;
        }
        field(35; "Maximum Inventory"; Decimal)
        {
            Caption = 'Maximum Inventory';
            DecimalPlaces = 0 : 5;
        }
        field(36; "Reorder Quantity"; Decimal)
        {
            Caption = 'Reorder Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(37; "Alternative Item No."; Code[20])
        {
            Caption = 'Alternative Item No.';
            TableRelation = Item;
        }
        field(38; "Unit List Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit List Price';
            MinValue = 0;
        }
        field(39; "Duty Due %"; Decimal)
        {
            Caption = 'Duty Due %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(40; "Duty Code"; Code[10])
        {
            Caption = 'Duty Code';
        }
        field(41; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(42; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(43; "Units per Parcel"; Decimal)
        {
            Caption = 'Units per Parcel';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(44; "Unit Volume"; Decimal)
        {
            Caption = 'Unit Volume';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(45; Durability; Code[10])
        {
            Caption = 'Durability';
        }
        field(46; "Freight Type"; Code[10])
        {
            Caption = 'Freight Type';
        }
        field(47; "Tariff No."; Code[10])
        {
            Caption = 'Tariff No.';
            TableRelation = "Tariff Number";
        }
        field(48; "Duty Unit Conversion"; Decimal)
        {
            Caption = 'Duty Unit Conversion';
            DecimalPlaces = 0 : 5;
        }
        field(49; "Country Purchased Code"; Code[10])
        {
            Caption = 'Country Purchased Code';
            TableRelation = "Country/Region";
        }
        field(50; "Budget Quantity"; Decimal)
        {
            Caption = 'Budget Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(51; "Budgeted Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Budgeted Amount';
        }
        field(52; "Budget Profit"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Budget Profit';
        }
        field(53; Comment; Boolean)
        {
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST("Item"),
                                                      "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(54; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(62; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(64; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(65; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(66; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(67; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(68; Inventory; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Quantity" WHERE("Item No." = FIELD("No."),
                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                  "Location Code" = FIELD("Location Filter"),
                                                                  "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                  "Variant Code" = FIELD("Variant Filter"),
                                                                  "Lot No." = FIELD("Lot No. Filter"),
                                                                  "Serial No." = FIELD("Serial No. Filter")));
            Caption = 'Inventory';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(69; "Net Invoiced Qty."; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Invoiced Quantity" WHERE("Item No." = FIELD("No."),
                                                                            "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                            "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                            "Location Code" = FIELD("Location Filter"),
                                                                            "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                            "Variant Code" = FIELD("Variant Filter"),
                                                                            "Lot No." = FIELD("Lot No. Filter"),
                                                                            "Serial No." = FIELD("Serial No. Filter")));
            Caption = 'Net Invoiced Qty.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(70; "Net Change"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                "Location Code" = FIELD("Location Filter"),
                                                                "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                "Variant Code" = FIELD("Variant Filter"),
                                                                "Lot No." = FIELD("Lot No. Filter"),
                                                                "Serial No." = FIELD("Serial No. Filter"),
                                                                 "Entry Type" = FIELD("Entry Type")));
            Caption = 'Net Change';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(71; "Purchases (Qty.)"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Invoiced Quantity" WHERE("Entry Type" = CONST("Purchase"),
                                                                             "Item No." = FIELD("No."),
                                                                             "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                             "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                             "Location Code" = FIELD("Location Filter"),
                                                                             "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                             "Variant Code" = FIELD("Variant Filter"),
                                                                             "Posting Date" = FIELD("Date Filter"),
                                                                             "Lot No." = FIELD("Lot No. Filter"),
                                                                             "Serial No." = FIELD("Serial No. Filter")));
            Caption = 'Purchases (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(72; "Sales (Qty.)"; Decimal)
        {
            CalcFormula = - Sum("Item Ledger Entry"."Invoiced Quantity" WHERE("Entry Type" = CONST("Sale"),
                                                                              "Item No." = FIELD("No."),
                                                                              "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                              "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                              "Location Code" = FIELD("Location Filter"),
                                                                              "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                              "Variant Code" = FIELD("Variant Filter"),
                                                                              "Posting Date" = FIELD("Date Filter"),
                                                                              "Lot No." = FIELD("Lot No. Filter"),
                                                                              "Serial No." = FIELD("Serial No. Filter")));
            Caption = 'Sales (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(73; "Positive Adjmt. (Qty.)"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Invoiced Quantity" WHERE("Entry Type" = CONST("Positive Adjmt."),
                                                                              "Item No." = FIELD("No."),
                                                                              "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                              "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                              "Location Code" = FIELD("Location Filter"),
                                                                              "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                              "Variant Code" = FIELD("Variant Filter"),
                                                                              "Posting Date" = FIELD("Date Filter"),
                                                                              "Lot No." = FIELD("Lot No. Filter"),
                                                                              "Serial No." = FIELD("Serial No. Filter")));
            Caption = 'Positive Adjmt. (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(74; "Negative Adjmt. (Qty.)"; Decimal)
        {
            CalcFormula = - Sum("Item Ledger Entry"."Invoiced Quantity" WHERE("Entry Type" = CONST("Negative Adjmt."),
                                                                              "Item No." = FIELD("No."),
                                                                              "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                              "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                              "Location Code" = FIELD("Location Filter"),
                                                                              "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                              "Variant Code" = FIELD("Variant Filter"),
                                                                              "Posting Date" = FIELD("Date Filter"),
                                                                              "Lot No." = FIELD("Lot No. Filter"),
                                                                              "Serial No." = FIELD("Serial No. Filter")));
            Caption = 'Negative Adjmt. (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(77; "Purchases (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Purchase Amount (Actual)" WHERE("Item Ledger Entry Type" = CONST("Purchase"),
                                                                              "Item No." = FIELD("No."),
                                                                              "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                              "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                              "Location Code" = FIELD("Location Filter"),
                                                                              "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                              "Variant Code" = FIELD("Variant Filter"),
                                                                              "Posting Date" = FIELD("Date Filter")));
            Caption = 'Purchases (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(78; "Sales (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Sales Amount (Actual)" WHERE("Item Ledger Entry Type" = CONST(Sale),
                                                                          "Item No." = FIELD("No."),
                                                                          "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                          "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                          "Location Code" = FIELD("Location Filter"),
                                                                          "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                          "Variant Code" = FIELD("Variant Filter"),
                                                                          "Posting Date" = FIELD("Date Filter")));
            Caption = 'Sales (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(79; "Positive Adjmt. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Cost Amount (Actual)" WHERE("Item Ledger Entry Type" = CONST("Positive Adjmt."),
                                                                          "Item No." = FIELD("No."),
                                                                          "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                          "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                          "Location Code" = FIELD("Location Filter"),
                                                                          "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                          "Variant Code" = FIELD("Variant Filter"),
                                                                          "Posting Date" = FIELD("Date Filter")));
            Caption = 'Positive Adjmt. (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80; "Negative Adjmt. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Cost Amount (Actual)" WHERE("Item Ledger Entry Type" = CONST("Negative Adjmt."),
                                                                          "Item No." = FIELD("No."),
                                                                          "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                          "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                          "Location Code" = FIELD("Location Filter"),
                                                                          "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                          "Variant Code" = FIELD("Variant Filter"),
                                                                          "Posting Date" = FIELD("Date Filter")));
            Caption = 'Negative Adjmt. (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(83; "COGS (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Value Entry"."Cost Amount (Actual)" WHERE("Item Ledger Entry Type" = CONST("Sale"),
                                                                         "Item No." = FIELD("No."),
                                                                          "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                          "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                          "Location Code" = FIELD("Location Filter"),
                                                                          "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                          "Variant Code" = FIELD("Variant Filter"),
                                                                          "Posting Date" = FIELD("Date Filter")));
            Caption = 'COGS (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(84; "Qty. on Purch. Order"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Outstanding Qty. (Base)" WHERE("Document Type" = CONST("Order"),
                                                                               "Type" = CONST("Item"),
                                                                               "No." = FIELD("No."),
                                                                               "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                               "Location Code" = FIELD("Location Filter"),
                                                                               "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                               "Variant Code" = FIELD("Variant Filter"),
                                                                               "Expected Receipt Date" = FIELD("Date Filter")));
            Caption = 'Qty. on Purch. Order';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(85; "Qty. on Sales Order"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" WHERE("Document Type" = CONST("Order"),
                                                                               "Type" = CONST("Item"),
                                                                               "No." = FIELD("No."),
                                                                               "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                               "Location Code" = FIELD("Location Filter"),
                                                                               "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                               "Variant Code" = FIELD("Variant Filter"),
                                                                               "Shipment Date" = FIELD("Date Filter")));
            Caption = 'Qty. on Sales Order';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(87; "Price Includes VAT"; Boolean)
        {
            Caption = 'Price Includes VAT';

            trigger OnValidate()
            var
                VATPostingSetup: Record "VAT Posting Setup";
            begin
            end;
        }
        field(89; "Drop Shipment Filter"; Boolean)
        {
            Caption = 'Drop Shipment Filter';
            FieldClass = FlowFilter;
        }
        field(90; "VAT Bus. Posting Gr. (Price)"; Code[10])
        {
            Caption = 'VAT Bus. Posting Gr. (Price)';
            TableRelation = "VAT Business Posting Group";
        }
        field(91; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(92; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(93; "Transferred (Qty.)"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Invoiced Quantity" WHERE("Entry Type" = CONST("Transfer"),
                                                                             "Item No." = FIELD("No."),
                                                                             "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                             "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                             "Location Code" = FIELD("Location Filter"),
                                                                             "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                             "Variant Code" = FIELD("Variant Filter"),
                                                                             "Posting Date" = FIELD("Date Filter"),
                                                                             "Lot No." = FIELD("Lot No. Filter"),
                                                                             "Serial No." = FIELD("Serial No. Filter")));
            Caption = 'Transferred (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(94; "Transferred (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Sales Amount (Actual)" WHERE("Item Ledger Entry Type" = CONST("Transfer"),
                                                                           "Item No." = FIELD("No."),
                                                                           "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                           "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                           "Location Code" = FIELD("Location Filter"),
                                                                           "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                           "Variant Code" = FIELD("Variant Filter"),
                                                                           "Posting Date" = FIELD("Date Filter")));
            Caption = 'Transferred (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(95; "Country of Origin Code"; Code[10])
        {
            Caption = 'Country of Origin Code';
            TableRelation = "Country/Region";
        }
        field(96; "Automatic Ext. Texts"; Boolean)
        {
            Caption = 'Automatic Ext. Texts';
        }
        field(97; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(98; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(99; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(100; Reserve; Option)
        {
            Caption = 'Reserve';
            InitValue = Optional;
            OptionCaption = 'Never,Optional,Always';
            OptionMembers = Never,Optional,Always;
        }
        field(101; "Reserved Qty. on Inventory"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Reservation Status" = CONST("Reservation"),
                                                                           "Item No." = FIELD("No."),
                                                                           "Location Code" = FIELD("Location Filter"),
                                                                           "Variant Code" = FIELD("Variant Filter"),
                                                                           "Lot No." = FIELD("Lot No. Filter"),
                                                                           "Serial No." = FIELD("Serial No. Filter"),
                                                                           "Source Type" = CONST(32),
                                                                           "Source Subtype" = CONST(0)));
            Caption = 'Reserved Qty. on Inventory';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(102; "Reserved Qty. on Purch. Orders"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Reservation Status" = CONST("Reservation"),
                                                                           "Item No." = FIELD("No."),
                                                                           "Location Code" = FIELD("Location Filter"),
                                                                           "Variant Code" = FIELD("Variant Filter"),
                                                                           "Source Type" = CONST(39),
                                                                           "Source Subtype" = CONST(1),
                                                                           "Expected Receipt Date" = FIELD("Date Filter")));
            Caption = 'Reserved Qty. on Purch. Orders';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(103; "Reserved Qty. on Sales Orders"; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry"."Quantity (Base)" WHERE("Reservation Status" = CONST("Reservation"),
                                                                            "Item No." = FIELD("No."),
                                                                            "Location Code" = FIELD("Location Filter"),
                                                                            "Variant Code" = FIELD("Variant Filter"),
                                                                            "Source Type" = CONST(37),
                                                                            "Source Subtype" = CONST(1),
                                                                            "Shipment Date" = FIELD("Date Filter")));
            Caption = 'Reserved Qty. on Sales Orders';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(105; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(106; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(107; "Res. Qty. on Outbound Transfer"; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry"."Quantity (Base)" WHERE("Reservation Status" = CONST("Reservation"),
                                                                            "Item No." = FIELD("No."),
                                                                            "Location Code" = FIELD("Location Filter"),
                                                                            "Variant Code" = FIELD("Variant Filter"),
                                                                            "Source Type" = CONST(5741),
                                                                            "Source Subtype" = CONST(0),
                                                                            "Shipment Date" = FIELD("Date Filter")));
            Caption = 'Res. Qty. on Outbound Transfer';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(108; "Res. Qty. on Inbound Transfer"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Reservation Status" = CONST("Reservation"),
                                                                           "Item No." = FIELD("No."),
                                                                           "Location Code" = FIELD("Location Filter"),
                                                                           "Variant Code" = FIELD("Variant Filter"),
                                                                           "Source Type" = CONST(5741),
                                                                           "Source Subtype" = CONST(1),
                                                                           "Expected Receipt Date" = FIELD("Date Filter")));
            Caption = 'Res. Qty. on Inbound Transfer';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5400; "Low-Level Code"; Integer)
        {
            Caption = 'Low-Level Code';
            Editable = false;
        }
        field(5401; "Lot Size"; Decimal)
        {
            Caption = 'Lot Size';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(5402; "Serial Nos."; Code[10])
        {
            Caption = 'Serial Nos.';
            TableRelation = "No. Series";
        }
        field(5403; "Last Unit Cost Calc. Date"; Date)
        {
            Caption = 'Last Unit Cost Calc. Date';
            Editable = false;
        }
        field(5404; "Rolled-up Material Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Rolled-up Material Cost';
            DecimalPlaces = 2 : 5;
            Editable = false;
        }
        field(5405; "Rolled-up Capacity Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Rolled-up Capacity Cost';
            DecimalPlaces = 2 : 5;
            Editable = false;
        }
        field(5406; "Indirect Cost per Unit"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Indirect Cost per Unit';
            DecimalPlaces = 2 : 5;
        }
        field(5407; "Scrap %"; Decimal)
        {
            Caption = 'Scrap %';
            DecimalPlaces = 0 : 2;
            MaxValue = 100;
            MinValue = 0;
        }
        field(5409; "Inventory Value Zero"; Boolean)
        {
            Caption = 'Inventory Value Zero';
        }
        field(5410; "Discrete Order Quantity"; Integer)
        {
            Caption = 'Discrete Order Quantity';
            MinValue = 0;
        }
        field(5411; "Minimum Order Quantity"; Decimal)
        {
            Caption = 'Minimum Order Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(5412; "Maximum Order Quantity"; Decimal)
        {
            Caption = 'Maximum Order Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(5413; "Safety Stock Quantity"; Decimal)
        {
            Caption = 'Safety Stock Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(5414; "Order Multiple"; Decimal)
        {
            Caption = 'Order Multiple';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(5415; "Safety Lead Time"; DateFormula)
        {
            Caption = 'Safety Lead Time';
        }
        field(5417; "Flushing Method"; Option)
        {
            Caption = 'Flushing Method';
            OptionCaption = 'Manual,Forward,Backward,Pick + Forward,Pick + Backward';
            OptionMembers = Manual,Forward,Backward,"Pick + Forward","Pick + Backward";
        }
        field(5419; "Replenishment System"; Option)
        {
            Caption = 'Replenishment System';
            OptionCaption = 'Purchase,Prod. Order, ';
            OptionMembers = Purchase,"Prod. Order"," ";
        }
        field(5420; "Scheduled Receipt (Qty.)"; Decimal)
        {
            CalcFormula = Sum("Prod. Order Line"."Remaining Qty. (Base)" WHERE("Status" = FILTER(Planned .. Released),
                                                                                "Item No." = FIELD("No."),
                                                                                "Variant Code" = FIELD("Variant Filter"),
                                                                                "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                "Location Code" = FIELD("Location Filter"),
                                                                                "Due Date" = FIELD("Date Filter")));
            Caption = 'Scheduled Receipt (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5421; "Scheduled Need (Qty.)"; Decimal)
        {
            CalcFormula = Sum("Prod. Order Component"."Remaining Qty. (Base)" WHERE("Status" = FILTER(Planned .. Released),
                                                                                     "Item No." = FIELD("No."),
                                                                                     "Variant Code" = FIELD("Variant Filter"),
                                                                                     "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                     "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                     "Location Code" = FIELD("Location Filter"),
                                                                                     "Due Date" = FIELD("Date Filter")));
            Caption = 'Scheduled Need (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5422; "Rounding Precision"; Decimal)
        {
            Caption = 'Rounding Precision';
            DecimalPlaces = 0 : 5;
            InitValue = 1;
        }
        field(5423; "Bin Filter"; Code[20])
        {
            Caption = 'Bin Filter';
            FieldClass = FlowFilter;
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Filter"));
        }
        field(5424; "Variant Filter"; Code[10])
        {
            Caption = 'Variant Filter';
            FieldClass = FlowFilter;
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("No."));
        }
        field(5425; "Sales Unit of Measure"; Code[10])
        {
            Caption = 'Sales Unit of Measure';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
        }
        field(5426; "Purch. Unit of Measure"; Code[10])
        {
            Caption = 'Purch. Unit of Measure';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
        }
        field(5428; "Reorder Cycle"; DateFormula)
        {
            Caption = 'Reorder Cycle';
        }
        field(5429; "Reserved Qty. on Prod. Order"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Reservation Status" = CONST("Reservation"),
                                                                           "Item No." = FIELD("No."),
                                                                           "Location Code" = FIELD("Location Filter"),
                                                                           "Variant Code" = FIELD("Variant Filter"),
                                                                           "Source Type" = CONST(5406),
                                                                           "Source Subtype" = FILTER(1 .. 3),
                                                                           "Expected Receipt Date" = FIELD("Date Filter")));
            Caption = 'Reserved Qty. on Prod. Order';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5430; "Res. Qty. on Prod. Order Comp."; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry"."Quantity (Base)" WHERE("Reservation Status" = CONST("Reservation"),
                                                                            "Item No." = FIELD("No."),
                                                                            "Location Code" = FIELD("Location Filter"),
                                                                            "Variant Code" = FIELD("Variant Filter"),
                                                                            "Source Type" = CONST(5407),
                                                                            "Source Subtype" = FILTER(1 .. 3),
                                                                            "Shipment Date" = FIELD("Date Filter")));
            Caption = 'Res. Qty. on Prod. Order Comp.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5431; "Res. Qty. on Req. Line"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Reservation Status" = CONST("Reservation"),
                                                                           "Item No." = FIELD("No."),
                                                                           "Location Code" = FIELD("Location Filter"),
                                                                           "Variant Code" = FIELD("Variant Filter"),
                                                                           "Source Type" = CONST(246),
                                                                           "Source Subtype" = FILTER(0),
                                                                           "Expected Receipt Date" = FIELD("Date Filter")));
            Caption = 'Res. Qty. on Req. Line';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5440; "Reordering Policy"; Option)
        {
            Caption = 'Reordering Policy';
            OptionCaption = ' ,Fixed Reorder Qty.,Maximum Qty.,Order,Lot-for-Lot';
            OptionMembers = " ","Fixed Reorder Qty.","Maximum Qty.","Order","Lot-for-Lot";
        }
        field(5441; "Include Inventory"; Boolean)
        {
            Caption = 'Include Inventory';
        }
        field(5442; "Manufacturing Policy"; Option)
        {
            Caption = 'Manufacturing Policy';
            OptionCaption = 'Make-to-Stock,Make-to-Order';
            OptionMembers = "Make-to-Stock","Make-to-Order";
        }
        field(5700; "Stockkeeping Unit Exists"; Boolean)
        {
            CalcFormula = Exist("Stockkeeping Unit" WHERE("Item No." = FIELD("No.")));
            Caption = 'Stockkeeping Unit Exists';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5701; "Manufacturer Code"; Code[10])
        {
            Caption = 'Manufacturer Code';
            TableRelation = Manufacturer;

            trigger OnValidate()
            var
                Manufacturer: Record Manufacturer;
            begin
            end;
        }
        field(5702; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(5703; "Created From Nonstock Item"; Boolean)
        {
            Caption = 'Created From Nonstock Item';
            Editable = false;
        }
        field(5704; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Product Group"."Code" WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(5706; "Substitutes Exist"; Boolean)
        {
            CalcFormula = Exist("Item Substitution" WHERE("Type" = CONST("Item"),
                                                           "No." = FIELD("No.")));
            Caption = 'Substitutes Exist';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5707; "Qty. in Transit"; Decimal)
        {
            CalcFormula = Sum("Transfer Line"."Qty. in Transit (Base)" WHERE("Derived From Line No." = CONST(0),
                                                                              "Item No." = FIELD("No."),
                                                                              "Transfer-to Code" = FIELD("Location Filter"),
                                                                              "Variant Code" = FIELD("Variant Filter"),
                                                                              "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                              "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                              "Receipt Date" = FIELD("Date Filter")));
            Caption = 'Qty. in Transit';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5708; "Trans. Ord. Receipt (Qty.)"; Decimal)
        {
            CalcFormula = Sum("Transfer Line"."Outstanding Qty. (Base)" WHERE("Derived From Line No." = CONST(0),
                                                                               "Item No." = FIELD("No."),
                                                                               "Transfer-to Code" = FIELD("Location Filter"),
                                                                               "Variant Code" = FIELD("Variant Filter"),
                                                                               "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                               "Receipt Date" = FIELD("Date Filter")));
            Caption = 'Trans. Ord. Receipt (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5709; "Trans. Ord. Shipment (Qty.)"; Decimal)
        {
            CalcFormula = Sum("Transfer Line"."Outstanding Qty. (Base)" WHERE("Derived From Line No." = CONST(0),
                                                                               "Item No." = FIELD("No."),
                                                                               "Transfer-to Code" = FIELD("Location Filter"),
                                                                               "Variant Code" = FIELD("Variant Filter"),
                                                                               "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                               "Receipt Date" = FIELD("Date Filter")));
            Caption = 'Trans. Ord. Shipment (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5776; "Qty. Assigned to ship"; Decimal)
        {
            CalcFormula = Sum("Warehouse Shipment Line"."Qty. Outstanding (Base)" WHERE("Item No." = FIELD("No."),
                                                                                         "Location Code" = FIELD("Location Filter"),
                                                                                         "Variant Code" = FIELD("Variant Filter"),
                                                                                         "Due Date" = FIELD("Date Filter")));
            Caption = 'Qty. Assigned to ship';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5777; "Qty. Picked"; Decimal)
        {
            CalcFormula = Sum("Warehouse Shipment Line"."Qty. Picked (Base)" WHERE("Item No." = FIELD("No."),
                                                                                    "Location Code" = FIELD("Location Filter"),
                                                                                    "Variant Code" = FIELD("Variant Filter"),
                                                                                    "Due Date" = FIELD("Date Filter")));
            Caption = 'Qty. Picked';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5900; "Service Item Group"; Code[10])
        {
            Caption = 'Service Item Group';
            TableRelation = "Service Item Group".Code;
        }
        field(5901; "Qty. on Service Order"; Decimal)
        {
            Caption = 'Qty. on Service Order';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5902; "Res. Qty. on Service Orders"; Decimal)
        {
            Caption = 'Res. Qty. on Service Orders';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(6202; "Picture No."; Code[20])
        {
            Caption = 'Picture No.';
            //TableRelation = 6215;//16225 TABLE N/F
        }
        field(6500; "Item Tracking Code"; Code[10])
        {
            Caption = 'Item Tracking Code';
            TableRelation = "Item Tracking Code";
        }
        field(6501; "Lot Nos."; Code[10])
        {
            Caption = 'Lot Nos.';
            TableRelation = "No. Series";
        }
        field(6502; "Expiration Calculation"; DateFormula)
        {
            Caption = 'Expiration Calculation';
        }
        field(6503; "Lot No. Filter"; Code[10])
        {
            Caption = 'Lot No. Filter';
            FieldClass = FlowFilter;
            TableRelation = "Lot No. Information"."Lot No." WHERE("Item No." = FIELD("No."));
        }
        field(6504; "Serial No. Filter"; Code[20])
        {
            Caption = 'Serial No. Filter';
            FieldClass = FlowFilter;
            TableRelation = "Serial No. Information"."Serial No." WHERE("Item No." = FIELD("No."));
        }
        field(7301; "Special Equipment Code"; Code[10])
        {
            Caption = 'Special Equipment Code';
            TableRelation = "Special Equipment";
        }
        field(7302; "Put-away Template Code"; Code[10])
        {
            Caption = 'Put-away Template Code';
            TableRelation = "Put-away Template Header";
        }
        field(7307; "Put-away Unit of Measure Code"; Code[10])
        {
            Caption = 'Put-away Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
        }
        field(7380; "Phys Invt Counting Period Code"; Code[10])
        {
            Caption = 'Phys Invt Counting Period Code';
            TableRelation = "Phys. Invt. Counting Period";

            trigger OnValidate()
            var
                PhysInvtCountPeriod: Record "Phys. Invt. Counting Period";
                PhysInvtCountPeriodMgt: Codeunit "Phys. Invt. Count.-Management";
            begin
            end;
        }
        field(7381; "Last Counting Period Update"; Date)
        {
            Caption = 'Last Counting Period Update';
            Editable = false;
        }
        field(7382; "Next Counting Period"; Text[250])
        {
            Caption = 'Next Counting Period';
            Editable = false;
        }
        field(7383; "Last Phys. Invt. Date"; Date)
        {
            CalcFormula = Max("Phys. Inventory Ledger Entry"."Posting Date" WHERE("Item No." = FIELD("No."),
                                                                                   "Phys Invt Counting Period Type" = FILTER(' ' | "Item")));
            Caption = 'Last Phys. Invt. Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7384; "Use Cross-Docking"; Boolean)
        {
            Caption = 'Use Cross-Docking';
            InitValue = true;
        }
        field(7700; "Identifier Code"; Code[20])
        {
            CalcFormula = Lookup("Item Identifier"."Code" WHERE("Item No." = FIELD("No.")));
            Caption = 'Identifier Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13712; "Excise Prod. Posting Group"; Code[10])
        {
            // TableRelation = "Excise Prod. Posting Group"; //16225 TABLE N/F

            trigger OnValidate()
            var
                ItemUOM: Record "Item Unit of Measure";
                //ExciseProdPostingGrp: Record 13710; //16225 TABLE N/F
                ErrText01: Label 'Item Unit of Measure must be defined for %1 before Excise Product Posting Group %2 can be assigned';
            begin
            end;
        }
        field(13714; "Excise Accounting Type"; Option)
        {
            OptionCaption = 'With CENVAT,Without CENVAT';
            OptionMembers = "With CENVAT","Without CENVAT";
        }
        field(13727; "Assessable Value"; Decimal)
        {
        }
        field(13740; "Import Duty Group"; Code[10])
        {
            // TableRelation = 13752;//16225 TABLE N/F
        }
        field(13745; "Declared Goods"; Boolean)
        {
        }
        field(13750; "Capital Item"; Boolean)
        {
        }
        field(16351; "VAT Product Posting Group"; Code[10])
        {
            //TableRelation = 16351.Field1; //16225 TABLE N/F
        }
        field(16360; Subcontracting; Boolean)
        {
            Description = 'Identifying Item as a Subcontracted Item';

            trigger OnValidate()
            var
                InventorySetup: Record "Inventory Setup";
            begin
            end;
        }
        field(16361; "Sub. Comp. Location"; Code[20])
        {
            Description = 'Company location used to send components to the Vendor';
            TableRelation = Location WHERE("Subcontracting Location" = CONST(false));
        }
        field(50000; "Type Code"; Code[2])
        {
        }
        field(50001; "Type Catogery Code"; Code[2])
        {
        }
        field(50002; "Size Code"; Code[3])
        {
        }
        field(50003; "Design Code"; Code[4])
        {
        }
        field(50004; "Color Code"; Code[4])
        {
        }
        field(50005; "Packing Code"; Code[2])
        {
        }
        field(50006; "Quality Code"; Code[1])
        {
        }
        field(50007; "Plant Code"; Code[1])
        {
        }
        field(50008; "Item Classification"; Code[10])
        {
            TableRelation = "Item Classification";
        }
        field(50009; "Type Code Desc."; Text[50])
        {
            Editable = false;
        }
        field(50010; "Type Category Code Desc."; Text[50])
        {
            Editable = false;
        }
        field(50011; "Size Code Desc."; Text[50])
        {
            Editable = false;
        }
        field(50012; "Design Code Desc."; Text[50])
        {
            Editable = false;
        }
        field(50013; "Color Code Desc."; Text[50])
        {
            Editable = false;
        }
        field(50014; "Packing Code Desc."; Text[50])
        {
            Editable = false;
        }
        field(50015; "Quality Code Desc."; Text[50])
        {
            Editable = false;
        }
        field(50016; "Plant Code Desc."; Text[50])
        {
            Editable = false;
        }
        field(50017; "Manufacturer Name"; Text[100])
        {
            Editable = false;
        }
        field(50018; "Warehouse Entry"; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                "Location Code" = FIELD("Location Filter")));
            FieldClass = FlowField;
        }
        field(50019; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            FieldClass = FlowFilter;
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output;
        }
        field(50021; "SalesQty."; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Entry Type" = CONST(Sale),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Size Code" = FIELD("Size Code"),
                                                                         "Plant Code" = FILTER(<> ''),
                                                                         "Size Code" = FILTER(<> ''),
                                                                         "Item No." = FIELD("No."),
                                                                         "Location Code" = FIELD("Location Filter")));
            FieldClass = FlowField;
        }
        field(50022; "ProductionQty."; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Entry Type" = CONST(Output),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Location Code" = FIELD("Location Filter"),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Size Code" = FIELD("Size Code"),
                                                                         "Plant Code" = FILTER(<> ''),
                                                                         "Size Code" = FILTER(<> ''),
                                                                         "Item No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50023; "TransferQty."; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Entry Type" = CONST("Transfer"),
                                                                         "Location Code" = FIELD("Location Filter"),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "InTransit" = CONST(false),
                                                                         "Qty in Sq.Mt." = FILTER(< 0),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Size Code" = FIELD("Size Code"),
                                                                         "External Transfer" = CONST(true),
                                                                         "Plant Code" = FILTER(<> ''),
                                                                         "Size Code" = FILTER(<> ''),
                                                                         "Item No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50024; BalaceQty; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Qty in Sq.Mt." WHERE("Item No." = FIELD("No."),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Entry Type" = FIELD("Entry Type"),
                                                                         "Location Code" = FIELD("Location Filter"),
                                                                         "Plant Code" = FIELD("Plant Code"),
                                                                         "Plant Code" = FILTER(<> ''),
                                                                         "Size Code" = FIELD("Size Code"),
                                                                         "Size Code" = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(50025; "Inventory Change"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                  "Location Code" = FIELD("Location Filter"),
                                                                  "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                  "Variant Code" = FIELD("Variant Filter"),
                                                                  "Lot No." = FIELD("Lot No. Filter"),
                                                                  "Serial No." = FIELD("Serial No. Filter"),
                                                                  "Entry Type" = FIELD("Entry Type"),
                                                                  "InTransit" = CONST(false),
                                                                  "Quantity" = FIELD("ILE Quantity")));
            Caption = 'Inventory Change';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50026; "ILE Quantity"; Decimal)
        {
            FieldClass = FlowFilter;
        }
        field(50027; "balance at date"; Decimal)
        {
            FieldClass = FlowField;

            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                  "Location Code" = FIELD("Location Filter"),
                                                                  "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                  "Posting Date" = FIELD(UPPERLIMIT("Date Filter")),
                                                                  "Variant Code" = FIELD("Variant Filter"),
                                                                  "Lot No." = FIELD("Lot No. Filter"),
                                                                  "Serial No." = FIELD("Serial No. Filter"),
                                                                  "Entry Type" = FIELD("Entry Type")));

        }
        field(50028; EntryTypeOT; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                  "Location Code" = FIELD("Location Filter"),
                                                                  "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                  "Variant Code" = FIELD("Variant Filter"),
                                                                  "Lot No." = FIELD("Lot No. Filter"),
                                                                  "Serial No." = FIELD("Serial No. Filter"),
                                                                  "Entry Type" = FILTER(Output | Transfer),
                                                                  "Quantity" = FILTER(> 0)));
            Caption = 'EntryTypeOT';
            DecimalPlaces = 0 : 5;
            Description = 'TRI H.B 12.04.06 - Flow Filter For Entry Type Equal to Output or Transfer, rest of all same as Net Change';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50029; EntryTypeST; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Quantity" WHERE("Item No." = FIELD("No."),
                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                  "Location Code" = FIELD("Location Filter"),
                                                                  "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                  "Variant Code" = FIELD("Variant Filter"),
                                                                  "Lot No." = FIELD("Lot No. Filter"),
                                                                  "Serial No." = FIELD("Serial No. Filter"),
                                                                  "Entry Type" = FILTER(Sale | Transfer),
                                                                  "Quantity" = FILTER(< 0)));
            Caption = 'EntryTypeST';
            DecimalPlaces = 0 : 5;
            Description = 'TRI H.B 12.04.06 - Flow Filter For Entry Type Equal to Sale or transfer, rest of all same as Net Change';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50030; "Item Category Desc."; Text[60])
        {
            CalcFormula = Lookup("Item Category"."Description" WHERE(Code = FIELD("Item Category Code")));
            Description = 'Tri56.1 PG 15112006 -- Desc. Req. In Item List';
            FieldClass = FlowField;
        }
        field(50031; "Product Group Desc."; Text[30])
        {
            CalcFormula = Lookup("Product Group"."Description" WHERE(Code = FIELD("Product Group Code")));
            Description = 'Tri56.1 PG 15112006 -- Desc. Req. In Item List';
            FieldClass = FlowField;
        }
        field(50032; "Ex-Factory Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Invoice Line"."Amount" WHERE(Type = CONST("Item"),
                                                                 "No." = FIELD("No."),
                                                                 "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                 "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                 "Location Code" = FIELD("Location Filter"),
                                                                 "Posting Date1" = FIELD("Date Filter")));
            Description = 'Tri PG 03042007';
            FieldClass = FlowField;
        }
        field(50033; "Excise Amount"; Decimal)
        {
            //16225 Excise Amount field Not Found Sale invoice Line Table
            /* CalcFormula = Sum("Sales Invoice Line"."Excise Amount" WHERE (Type=CONST("Item"),
                                                                           "No."=FIELD("No."),
                                                                           "Shortcut Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                                                                           "Shortcut Dimension 2 Code"=FIELD("Global Dimension 2 Filter"),
                                                                           "Location Code"=FIELD("Location Filter"),
                                                                           "Posting Date1"=FIELD("Date Filter")));*/
            //16225 End
            Description = 'Tri PG 03042007';
            FieldClass = FlowField;
        }
        field(50034; "Group Code"; Code[2])
        {
            TableRelation = "Item Group";
        }
        field(50035; "Group code Desc"; Text[50])
        {
            Description = 'tri LM 100308';
            Editable = false;
        }
        field(50036; COGS; Decimal)
        {
            Description = 'S.B. for Inserting value of Good sold manually 200508';
        }
        field(50037; "COGS Effective Date"; Date)
        {
            Description = 'S.B. for inserting effective date of COGS manually 200508';
        }
        field(50038; "Indent Blocked"; Boolean)
        {
            Description = 'TRI A.S 28.05.08';
        }
        field(50039; "Purchase Blocked"; Boolean)
        {
            Description = 'TRI A.S 28.05.08';
        }
        field(99000750; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
            TableRelation = "Routing Header";
        }
        field(99000751; "Production BOM No."; Code[20])
        {
            Caption = 'Production BOM No.';
            TableRelation = "Production BOM Header";

            trigger OnValidate()
            var
                MfgSetup: Record "Manufacturing Setup";
                ProdBOMHeader: Record "Production BOM Header";
                CalcLowLevel: Codeunit "Calculate Low-Level Code";
            begin
            end;
        }
        field(99000752; "Single-Level Material Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Single-Level Material Cost';
            Editable = false;
        }
        field(99000753; "Single-Level Capacity Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Single-Level Capacity Cost';
            Editable = false;
        }
        field(99000754; "Single-Level Subcontrd. Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Single-Level Subcontrd. Cost';
            Editable = false;
        }
        field(99000755; "Single-Level Cap. Ovhd Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Single-Level Cap. Ovhd Cost';
            Editable = false;
        }
        field(99000756; "Single-Level Mfg. Ovhd Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Single-Level Mfg. Ovhd Cost';
            Editable = false;
        }
        field(99000757; "Overhead Rate"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Overhead Rate';
        }
        field(99000758; "Rolled-up Subcontracted Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Rolled-up Subcontracted Cost';
            Editable = false;
        }
        field(99000759; "Rolled-up Mfg. Ovhd Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Rolled-up Mfg. Ovhd Cost';
            Editable = false;
        }
        field(99000760; "Rolled-up Cap. Overhead Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Rolled-up Cap. Overhead Cost';
            Editable = false;
        }
        field(99000761; "Planning Issues (Qty.)"; Decimal)
        {
            CalcFormula = Sum("Planning Component"."Expected Quantity (Base)" WHERE("Item No." = FIELD("No."),
                                                                                     "Due Date" = FIELD("Date Filter"),
                                                                                     "Location Code" = FIELD("Location Filter"),
                                                                                     "Variant Code" = FIELD("Variant Filter"),
                                                                                     "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                     "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                     "Planning Line Origin" = CONST(" ")));
            Caption = 'Planning Issues (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(99000762; "Planning Receipt (Qty.)"; Decimal)
        {
            CalcFormula = Sum("Requisition Line"."Quantity (Base)" WHERE(Type = CONST("Item"),
                                                                          "No." = FIELD("No."),
                                                                          "Due Date" = FIELD("Date Filter"),
                                                                          "Location Code" = FIELD("Location Filter"),
                                                                          "Variant Code" = FIELD("Variant Filter"),
                                                                          "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                          "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter")));
            Caption = 'Planning Receipt (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(99000765; "Planned Order Receipt (Qty.)"; Decimal)
        {
            CalcFormula = Sum("Prod. Order Line"."Remaining Qty. (Base)" WHERE("Status" = CONST("Planned"),
                                                                                "Item No." = FIELD("No."),
                                                                                "Variant Code" = FIELD("Variant Filter"),
                                                                                "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                "Location Code" = FIELD("Location Filter"),
                                                                                "Due Date" = FIELD("Date Filter")));
            Caption = 'Planned Order Receipt (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(99000766; "FP Order Receipt (Qty.)"; Decimal)
        {
            CalcFormula = Sum("Prod. Order Line"."Remaining Qty. (Base)" WHERE("Status" = CONST("Firm Planned"),
                                                                                "Item No." = FIELD("No."),
                                                                                "Variant Code" = FIELD("Variant Filter"),
                                                                                "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                "Location Code" = FIELD("Location Filter"),
                                                                                "Due Date" = FIELD("Date Filter")));
            Caption = 'FP Order Receipt (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(99000767; "Rel. Order Receipt (Qty.)"; Decimal)
        {
            CalcFormula = Sum("Prod. Order Line"."Remaining Qty. (Base)" WHERE("Status" = CONST("Released"),
                                                                                "Item No." = FIELD("No."),
                                                                                "Variant Code" = FIELD("Variant Filter"),
                                                                                "Shortcut Dimension 1 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                "Location Code" = FIELD("Location Filter"),
                                                                                "Due Date" = FIELD("Date Filter")));
            Caption = 'Rel. Order Receipt (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(99000768; "Planning Release (Qty.)"; Decimal)
        {
            CalcFormula = Sum("Requisition Line"."Quantity (Base)" WHERE(Type = CONST("Item"),
                                                                          "No." = FIELD("No."),
                                                                          "Starting Date" = FIELD("Date Filter"),
                                                                          "Location Code" = FIELD("Location Filter"),
                                                                          "Variant Code" = FIELD("Variant Filter"),
                                                                          "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                          "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter")));
            Caption = 'Planning Release (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(99000769; "Planned Order Release (Qty.)"; Decimal)
        {
            CalcFormula = Sum("Prod. Order Line"."Remaining Qty. (Base)" WHERE("Status" = CONST("Planned"),
                                                                                "Item No." = FIELD("No."),
                                                                                "Variant Code" = FIELD("Variant Filter"),
                                                                                "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                "Shortcut Dimension 2 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                "Location Code" = FIELD("Location Filter"),
                                                                                "Starting Date" = FIELD("Date Filter")));
            Caption = 'Planned Order Release (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(99000770; "Purch. Req. Receipt (Qty.)"; Decimal)
        {
            CalcFormula = Sum("Requisition Line"."Quantity (Base)" WHERE("Type" = CONST("Item"),
                                                                          "No." = FIELD("No."),
                                                                          "Variant Code" = FIELD("Variant Filter"),
                                                                          "Location Code" = FIELD("Location Filter"),
                                                                          "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                          "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                          "Due Date" = FIELD("Date Filter"),
                                                                          "Planning Line Origin" = CONST(" ")));
            Caption = 'Purch. Req. Receipt (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(99000771; "Purch. Req. Release (Qty.)"; Decimal)
        {
            CalcFormula = Sum("Requisition Line"."Quantity (Base)" WHERE("Type" = CONST(Item),
                                                                          "No." = FIELD("No."),
                                                                          "Location Code" = FIELD("Location Filter"),
                                                                          "Variant Code" = FIELD("Variant Filter"),
                                                                          "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                          "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                          "Order Date" = FIELD("Date Filter")));
            Caption = 'Purch. Req. Release (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(99000773; "Order Tracking Policy"; Option)
        {
            Caption = 'Order Tracking Policy';
            OptionCaption = 'None,Tracking Only,Tracking & Action Msg.';
            OptionMembers = "None","Tracking Only","Tracking & Action Msg.";

            trigger OnValidate()
            var
                ReservEntry: Record "Reservation Entry";
                ActionMessageEntry: Record "Action Message Entry";
            begin
            end;
        }
        field(99000774; "Prod. Forecast Quantity (Base)"; Decimal)
        {
            CalcFormula = Sum("Production Forecast Entry"."Forecast Quantity (Base)" WHERE("Item No." = FIELD("No."),
                                                                                            "Production Forecast Name" = FIELD("Production Forecast Name"),
                                                                                            "Forecast Date" = FIELD("Date Filter"),
                                                                                            "Location Code" = FIELD("Location Filter"),
                                                                                            "Component Forecast" = FIELD("Component Forecast")));
            Caption = 'Prod. Forecast Quantity (Base)';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }
        field(99000775; "Production Forecast Name"; Code[10])
        {
            Caption = 'Production Forecast Name';
            FieldClass = FlowFilter;
            TableRelation = "Production Forecast Name";
        }
        field(99000776; "Component Forecast"; Boolean)
        {
            Caption = 'Component Forecast';
            FieldClass = FlowFilter;
        }
        field(99000777; "Qty. on Prod. Order"; Decimal)
        {
            CalcFormula = Sum("Prod. Order Line"."Remaining Qty. (Base)" WHERE("Status" = FILTER(Planned .. Released),
                                                                                "Item No." = FIELD("No."),
                                                                                "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                "Location Code" = FIELD("Location Filter"),
                                                                                "Variant Code" = FIELD("Variant Filter"),
                                                                                "Due Date" = FIELD("Date Filter")));
            Caption = 'Qty. on Prod. Order';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(99000778; "Qty. on Component Lines"; Decimal)
        {
            CalcFormula = Sum("Prod. Order Component"."Remaining Qty. (Base)" WHERE("Status" = FILTER(Planned .. Released),
                                                                                     "Item No." = FIELD("No."),
                                                                                     "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                     "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                     "Location Code" = FIELD("Location Filter"),
                                                                                     "Variant Code" = FIELD("Variant Filter"),
                                                                                     "Due Date" = FIELD("Date Filter")));
            Caption = 'Qty. on Component Lines';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(99000875; Critical; Boolean)
        {
            Caption = 'Critical';
        }
        field(99008500; "Common Item No."; Code[20])
        {
            Caption = 'Common Item No.';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

