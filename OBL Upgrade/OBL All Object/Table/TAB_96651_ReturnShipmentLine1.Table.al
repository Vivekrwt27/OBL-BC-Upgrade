table 96651 "Return Shipment Line1"
{
    Caption = 'Return Shipment Line';
    LookupPageID = "Posted Return Shipment Lines";
    Permissions = TableData "Item Ledger Entry" = r,
                  TableData "Value Entry" = r;

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
            TableRelation = "Return Shipment Header";
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
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group"
            ELSE
            IF (Type = CONST("Fixed Asset")) "FA Posting Group";
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
            AutoFormatExpression = GetCurrencyCode;
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
        field(39; "Item Shpt. Entry No."; Integer)
        {
            Caption = 'Item Shpt. Entry No.';
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
        field(54; "Indirect Cost %"; Decimal)
        {
            Caption = 'Indirect Cost %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(61; "Quantity Invoiced"; Decimal)
        {
            Caption = 'Quantity Invoiced';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(68; "Pay-to Vendor No."; Code[20])
        {
            Caption = 'Pay-to Vendor No.';
            Editable = false;
            TableRelation = Vendor;
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
            TableRelation = "Return Shipment Line"."Line No." WHERE("Document No." = FIELD("Document No."));
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
            CalcFormula = Lookup("Return Shipment Header"."Currency Code" WHERE("No." = FIELD("Document No.")));
            Caption = 'Currency Code';
            Editable = false;
            FieldClass = FlowField;
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
        field(131; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
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
        field(5461; "Qty. Invoiced (Base)"; Decimal)
        {
            Caption = 'Qty. Invoiced (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
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
            ValidateTableRelation = true;
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
        field(5805; "Return Qty. Shipped Not Invd."; Decimal)
        {
            Caption = 'Return Qty. Shipped Not Invd.';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5811; "Item Charge Base Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Item Charge Base Amount';
        }
        field(5817; Correction; Boolean)
        {
            Caption = 'Correction';
            Editable = false;
        }
        field(6602; "Return Order No."; Code[20])
        {
            Caption = 'Return Order No.';
            Editable = false;
        }
        field(6603; "Return Order Line No."; Integer)
        {
            Caption = 'Return Order Line No.';
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
        field(13703; "Form Code"; Code[10])
        {
            Caption = 'Form Code';

            trigger OnLookup()
            var
            //StateForm: Record "13767"; //16225 TABLE N/F
            //StateForms: Page "13702";  //16225 TABLE N/F
            begin
            end;
        }
        field(13704; "Form No."; Code[10])
        {
            Caption = 'Form No.';
            //16225 TABLE N/F "Tax Forms Details"
            /*TableRelation = "Tax Forms Details"."Form No." WHERE (Form Code=FIELD(Form Code),
                                                                  Issued=CONST(No),
                                                                  State=FIELD(State));*/
        }
        field(13705; State; Code[10])
        {
            Caption = 'State';
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
            Editable = false;
            // TableRelation = "Excise Bus. Posting Group"; //16225 TABLE N/F
        }
        field(13714; "Excise Prod. Posting Group"; Code[10])
        {
            Caption = 'Excise Prod. Posting Group';
            Editable = false;
            // TableRelation = "Excise Prod. Posting Group";//16225 TABLE N/F
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
            AutoFormatType = 1;
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
        field(13738; "Excise Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Excise Base Amount';
            Editable = false;
        }
        field(13750; "Capital Item"; Boolean)
        {
            Caption = 'Capital Item';
            Editable = false;
        }
        field(13757; "BED Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'BED Amount';
            Editable = false;
        }
        field(13758; "AED(GSI) Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'AED(GSI) Amount';
            Editable = false;
        }
        field(13759; "SED Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'SED Amount';
            Editable = false;
        }
        field(13769; "SAED Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'SAED Amount';
            Editable = false;
        }
        field(13770; "CESS Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'CESS Amount';
            Editable = false;
        }
        field(13771; "NCCD Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'NCCD Amount';
            Editable = false;
        }
        field(13772; "eCess Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'eCess Amount';
            Editable = false;
        }
        field(16355; "Claim VAT"; Boolean)
        {
            Caption = 'Claim VAT';
            InitValue = true;
        }
        field(16356; "Refund VAT"; Boolean)
        {
            Caption = 'Refund VAT';
        }
        field(16357; "Consume VAT"; Boolean)
        {
            Caption = 'Consume VAT';
        }
        field(16358; "Reverse VAT"; Boolean)
        {
            Caption = 'Reverse VAT';
        }
        field(16367; "SetOff Available"; Boolean)
        {
            Caption = 'SetOff Available';
        }
        field(16383; "Vendor Shipment No."; Code[20])
        {
            Caption = 'Vendor Shipment No.';
        }
        field(16391; "Service Tax Group"; Code[20])
        {
            Caption = 'Service Tax Group';
            // TableRelation = "Service Tax Groups".Code;

            trigger OnValidate()
            var
                CompanyInfo: Record "Company Information";
            begin
            end;
        }
        field(16393; "Service Tax Base"; Decimal)
        {
            Caption = 'Service Tax Base';
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
        field(16452; "ADET Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'ADET Amount';
            Editable = false;
        }
        field(16455; "AED(TTA) Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'AED(TTA) Amount';
            Editable = false;
        }
        field(16459; "ADE Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'ADE Amount';
            Editable = false;
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
            AutoFormatType = 1;
            Caption = 'ADC VAT Amount';
        }
        field(16510; "CIF Amount"; Decimal)
        {
            Caption = 'CIF Amount';
        }
        field(16511; "BCD Amount"; Decimal)
        {
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
        field(16522; "Excise Loading on Inventory"; Boolean)
        {
            Caption = 'Excise Loading on Inventory';
        }
        field(16523; "Custom eCess Amount"; Decimal)
        {
            Caption = 'Custom eCess Amount';
            MinValue = 0;
        }
        field(16524; "Custom SHECess Amount"; Decimal)
        {
            Caption = 'Custom SHECess Amount';
            MinValue = 0;
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
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Return Order No.", "Return Order Line No.")
        {
        }
        key(Key3; "Blanket Order No.", "Blanket Order Line No.")
        {
        }
        key(Key4; "Pay-to Vendor No.")
        {
        }
        key(Key5; "Buy-from Vendor No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        PurchDocLineComments: Record "Purch. Comment Line";
    begin
        //DimMgt.DeletePostedDocDim(DATABASE::"Return Shipment Line","No.","Line No.");    Code blocked for upgrade //Dimensions
        PurchDocLineComments.SETRANGE("Document Type", PurchDocLineComments."Document Type"::"Posted Return Shipment");
        PurchDocLineComments.SETRANGE("No.", "Document No.");
        PurchDocLineComments.SETRANGE("Document Line No.", "Line No.");
        IF NOT PurchDocLineComments.ISEMPTY THEN
            PurchDocLineComments.DELETEALL;
    end;

    var
        Currency: Record Currency;
        ReturnShptHeader: Record "Return Shipment Header";
        DimMgt: Codeunit DimensionManagement;
        Text000: Label 'Return Shipment No. %1:';
        Text001: Label 'The program cannot find this purchase line.';
        CurrencyRead: Boolean;

    procedure GetCurrencyCode(): Code[10]
    begin
        IF "Document No." = ReturnShptHeader."No." THEN
            EXIT(ReturnShptHeader."Currency Code");
        IF ReturnShptHeader.GET("Document No.") THEN
            EXIT(ReturnShptHeader."Currency Code");
        EXIT('');
    end;

    procedure ShowDimensions()
    begin
        TESTFIELD("No.");
        TESTFIELD("Line No.");
        /*PostedDocDim.SETRANGE("Table ID",DATABASE::"Return Shipment Line");
        PostedDocDim.SETRANGE("Document No.","Document No.");
        PostedDocDim.SETRANGE("Line No.","Line No.");
        PostedDocDimensions.SETTABLEVIEW(PostedDocDim);
        PostedDocDimensions.RUNMODAL;
        Code blocked for upgradation*/

    end;

    procedure ShowItemTrackingLines()
    var
        ItemTrackingMgt: Codeunit "Item Tracking Management";
    begin
        //ItemTrackingMgt.CallPostedItemTrackingForm(DATABASE::"Return Shipment Line",0,"Document No.",'',0,"Line No.");
    end;

    procedure InsertInvLineFromRetShptLine(var PurchLine: Record "Purchase Line")
    var
        PurchOrderLine: Record "Purchase Line";
        TempPurchLine: Record "Purchase Line";
        TransferOldExtLines: Codeunit "Transfer Old Ext. Text Lines";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        NextLineNo: Integer;
        ExtTextLine: Boolean;
    begin
        SETRANGE("Document No.", "Document No.");

        TempPurchLine := PurchLine;
        IF PurchLine.FIND('+') THEN
            NextLineNo := PurchLine."Line No." + 10000
        ELSE
            NextLineNo := 10000;

        IF PurchLine."Return Shipment No." <> "Document No." THEN BEGIN
            PurchLine.INIT;
            PurchLine."Line No." := NextLineNo;
            PurchLine."Document Type" := TempPurchLine."Document Type";
            PurchLine."Document No." := TempPurchLine."Document No.";
            PurchLine.Description := STRSUBSTNO(Text000, "Document No.");
            PurchLine.INSERT;
            NextLineNo := NextLineNo + 10000;
        END;

        TransferOldExtLines.ClearLineNumbers;

        REPEAT
            ExtTextLine := (TransferOldExtLines.GetNewLineNumber("Attached to Line No.") <> 0);

            IF NOT PurchOrderLine.GET(
                PurchOrderLine."Document Type"::"Return Order", "Return Order No.", "Return Order Line No.")
            THEN BEGIN
                IF ExtTextLine THEN BEGIN
                    PurchOrderLine.INIT;
                    PurchOrderLine."Line No." := "Return Order Line No.";
                    PurchOrderLine.Description := Description;
                    PurchOrderLine."Description 2" := "Description 2";
                END ELSE
                    ERROR(Text001);
            END;
            PurchLine := PurchOrderLine;
            PurchLine."Line No." := NextLineNo;
            PurchLine."Document Type" := TempPurchLine."Document Type";
            PurchLine."Document No." := TempPurchLine."Document No.";
            PurchLine."Variant Code" := "Variant Code";
            PurchLine."Location Code" := "Location Code";
            PurchLine."Return Reason Code" := "Return Reason Code";
            PurchLine."Quantity (Base)" := 0;
            PurchLine.Quantity := 0;
            PurchLine."Outstanding Qty. (Base)" := 0;
            PurchLine."Outstanding Quantity" := 0;
            PurchLine."Return Qty. Shipped" := 0;
            PurchLine."Return Qty. Shipped (Base)" := 0;
            PurchLine."Quantity Invoiced" := 0;
            PurchLine."Qty. Invoiced (Base)" := 0;
            PurchLine."Sales Order No." := '';
            PurchLine."Sales Order Line No." := 0;
            PurchLine."Drop Shipment" := FALSE;
            PurchLine."Return Shipment No." := "Document No.";
            PurchLine."Return Shipment Line No." := "Line No.";
            IF NOT ExtTextLine THEN BEGIN
                PurchLine.VALIDATE(Quantity, Quantity - "Quantity Invoiced");
                PurchLine.VALIDATE("Direct Unit Cost", PurchOrderLine."Direct Unit Cost");
                PurchLine.VALIDATE("Line Discount %", PurchOrderLine."Line Discount %");
            END;
            PurchLine."Attached to Line No." :=
              TransferOldExtLines.TransferExtendedText(
                "Line No.",
                NextLineNo,
                "Attached to Line No.");
            PurchLine."Shortcut Dimension 1 Code" := PurchOrderLine."Shortcut Dimension 1 Code";
            PurchLine."Shortcut Dimension 2 Code" := PurchOrderLine."Shortcut Dimension 2 Code";
            PurchLine.INSERT;

            // ItemTrackingMgt.CopyHandledItemTrkgToInvLine2(PurchOrderLine, PurchLine);

            /*FromDocDim.SETRANGE("Table ID",DATABASE::"Purchase Line");
            FromDocDim.SETRANGE("Document Type",PurchOrderLine."Document Type");
            FromDocDim.SETRANGE("Document No.",PurchOrderLine."Document No.");
            FromDocDim.SETRANGE("Line No.",PurchOrderLine."Line No.");

            ToDocDim.SETRANGE("Table ID",DATABASE::"Purchase Line");
            ToDocDim.SETRANGE("Document Type",PurchLine."Document Type");
            ToDocDim.SETRANGE("Document No.",PurchLine."Document No.");
            ToDocDim.SETRANGE("Line No.", PurchLine."Line No.");
            ToDocDim.DELETEALL;

            IF FromDocDim.FIND('-') THEN
              REPEAT
                TempFromDocDim.INIT;
                TempFromDocDim := FromDocDim;
                TempFromDocDim."Table ID" := DATABASE::"Purchase Line";
                TempFromDocDim."Document Type" := PurchLine."Document Type";
                TempFromDocDim."Document No." := PurchLine."Document No.";
                TempFromDocDim."Line No." := PurchLine."Line No.";
                TempFromDocDim.INSERT;
              UNTIL FromDocDim.NEXT = 0;
               //code blocked for upgrade //Dimensions
               */
            NextLineNo := NextLineNo + 10000;
            IF "Attached to Line No." = 0 THEN
                SETRANGE("Attached to Line No.", "Line No.");
        UNTIL (NEXT = 0) OR ("Attached to Line No." = 0);

    end;

    procedure GetPurchCrMemoLines(var TempPurchCrMemoLine: Record "Purch. Cr. Memo Line" temporary)
    var
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        ItemLedgEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
    begin
        TempPurchCrMemoLine.RESET;
        TempPurchCrMemoLine.DELETEALL;

        IF Type <> Type::Item THEN
            EXIT;

        FilterPstdDocLnItemLedgEntries(ItemLedgEntry);
        ItemLedgEntry.SETFILTER("Invoiced Quantity", '<>0');
        IF ItemLedgEntry.FINDSET THEN BEGIN
            ValueEntry.SETCURRENTKEY("Item Ledger Entry No.", "Entry Type");
            ValueEntry.SETRANGE("Entry Type", ValueEntry."Entry Type"::"Direct Cost");
            ValueEntry.SETFILTER("Invoiced Quantity", '<>0');
            REPEAT
                ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
                IF ValueEntry.FINDSET THEN
                    REPEAT
                        IF ValueEntry."Document Type" = ValueEntry."Document Type"::"Purchase Credit Memo" THEN
                            IF PurchCrMemoLine.GET(ValueEntry."Document No.", ValueEntry."Document Line No.") THEN BEGIN
                                TempPurchCrMemoLine.INIT;
                                TempPurchCrMemoLine := PurchCrMemoLine;
                                IF TempPurchCrMemoLine.INSERT THEN;
                            END;
                    UNTIL ValueEntry.NEXT = 0;
            UNTIL ItemLedgEntry.NEXT = 0;
        END;
    end;

    procedure FilterPstdDocLnItemLedgEntries(var ItemLedgEntry: Record "Item Ledger Entry")
    begin
        ItemLedgEntry.RESET;
        ItemLedgEntry.SETCURRENTKEY("Document No.");
        ItemLedgEntry.SETRANGE("Document No.", "Document No.");
        ItemLedgEntry.SETRANGE("Document Type", ItemLedgEntry."Document Type"::"Purchase Return Shipment");
        ItemLedgEntry.SETRANGE("Document Line No.", "Line No.");
    end;

    procedure ShowItemLedgEntries()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        IF Type = Type::Item THEN BEGIN
            FilterPstdDocLnItemLedgEntries(ItemLedgEntry);
            PAGE.RUNMODAL(0, ItemLedgEntry);
        END;
    end;

    procedure ShowItemPurchCrMemoLines()
    var
        TempPurchCrMemoLine: Record "Purch. Cr. Memo Line" temporary;
    begin
        IF Type = Type::Item THEN BEGIN
            GetPurchCrMemoLines(TempPurchCrMemoLine);
            PAGE.RUNMODAL(0, TempPurchCrMemoLine);
        END;
    end;

    local procedure InitCurrency(CurrencyCode: Code[10])
    begin
        IF (Currency.Code = CurrencyCode) AND CurrencyRead THEN
            EXIT;

        IF CurrencyCode <> '' THEN
            Currency.GET(CurrencyCode)
        ELSE
            Currency.InitRoundingPrecision;
        CurrencyRead := TRUE;
    end;

    procedure ShowLineComments()
    var
        PurchDocLineComments: Record "Purch. Comment Line";
        PurchDocCommentSheet: Page "Purch. Comment Sheet";
    begin
        PurchDocLineComments.SETRANGE("Document Type", PurchDocLineComments."Document Type"::"Posted Return Shipment");
        PurchDocLineComments.SETRANGE("No.", "Document No.");
        PurchDocLineComments.SETRANGE("Document Line No.", "Line No.");
        PurchDocCommentSheet.SETTABLEVIEW(PurchDocLineComments);
        PurchDocCommentSheet.RUNMODAL;
    end;
}

