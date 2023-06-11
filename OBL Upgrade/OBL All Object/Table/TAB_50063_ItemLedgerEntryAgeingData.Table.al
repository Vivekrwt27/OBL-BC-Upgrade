table 50063 "Item Ledger Entry Ageing Data"
{
    Caption = 'Item Ledger Entry';
    DrillDownPageID = 38;
    LookupPageID = 38;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(4; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        }
        field(5; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = IF ("Source Type" = CONST(Customer)) Customer
            ELSE
            IF ("Source Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Source Type" = CONST(Item)) Item;
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(8; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(12; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(13; "Remaining Quantity"; Decimal)
        {
            Caption = 'Remaining Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(14; "Invoiced Quantity"; Decimal)
        {
            Caption = 'Invoiced Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(28; "Applies-to Entry"; Integer)
        {
            Caption = 'Applies-to Entry';
        }
        field(29; Open; Boolean)
        {
            Caption = 'Open';
        }
        field(33; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(34; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(36; Positive; Boolean)
        {
            Caption = 'Positive';
        }
        field(41; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = ' ,Customer,Vendor,Item';
            OptionMembers = " ",Customer,Vendor,Item;
        }
        field(47; "Drop Shipment"; Boolean)
        {
            AccessByPermission = TableData 223 = R;
            Caption = 'Drop Shipment';
        }
        field(50; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(51; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(52; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(59; "Entry/Exit Point"; Code[10])
        {
            Caption = 'Entry/Exit Point';
            TableRelation = "Entry/Exit Point";
        }
        field(60; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(61; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }
        field(62; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(63; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(64; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(70; "Reserved Quantity"; Decimal)
        {
            AccessByPermission = TableData 120 = R;
            Caption = 'Reserved Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(79; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Sales Shipment,Sales Invoice,Sales Return Receipt,Sales Credit Memo,Purchase Receipt,Purchase Invoice,Purchase Return Shipment,Purchase Credit Memo,Transfer Shipment,Transfer Receipt,Service Shipment,Service Invoice,Service Credit Memo,Posted Assembly';
            OptionMembers = " ","Sales Shipment","Sales Invoice","Sales Return Receipt","Sales Credit Memo","Purchase Receipt","Purchase Invoice","Purchase Return Shipment","Purchase Credit Memo","Transfer Shipment","Transfer Receipt","Service Shipment","Service Invoice","Service Credit Memo","Posted Assembly";
        }
        field(80; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
        }
        field(90; "Order Type"; Option)
        {
            Caption = 'Order Type';
            Editable = false;
            OptionCaption = ' ,Production,Transfer,Service,Assembly';
            OptionMembers = " ",Production,Transfer,Service,Assembly;
        }
        field(91; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            Editable = false;
        }
        field(92; "Order Line No."; Integer)
        {
            Caption = 'Order Line No.';
            Editable = false;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(904; "Assemble to Order"; Boolean)
        {
            AccessByPermission = TableData 90 = R;
            Caption = 'Assemble to Order';
        }
        field(1000; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job."No.";
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));
        }
        field(1002; "Job Purchase"; Boolean)
        {
            Caption = 'Job Purchase';
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(5408; "Derived from Blanket Order"; Boolean)
        {
            Caption = 'Derived from Blanket Order';
        }
        field(5700; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';
        }
        field(5701; "Originally Ordered No."; Code[20])
        {
            AccessByPermission = TableData 5715 = R;
            Caption = 'Originally Ordered No.';
            TableRelation = Item;
        }
        field(5702; "Originally Ordered Var. Code"; Code[10])
        {
            AccessByPermission = TableData 5715 = R;
            Caption = 'Originally Ordered Var. Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Originally Ordered No."));
        }
        field(5703; "Out-of-Stock Substitution"; Boolean)
        {
            Caption = 'Out-of-Stock Substitution';
        }
        field(5704; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(5705; Nonstock; Boolean)
        {
            Caption = 'Nonstock';
        }
        field(5706; "Purchasing Code"; Code[10])
        {
            Caption = 'Purchasing Code';
            TableRelation = Purchasing;
        }
        field(5707; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(5800; "Completely Invoiced"; Boolean)
        {
            Caption = 'Completely Invoiced';
        }
        field(5801; "Last Invoice Date"; Date)
        {
            Caption = 'Last Invoice Date';
        }
        field(5802; "Applied Entry to Adjust"; Boolean)
        {
            Caption = 'Applied Entry to Adjust';
        }
        field(5803; "Cost Amount (Expected)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Expected)';
            Editable = false;
        }
        field(5804; "Cost Amount (Actual)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Actual)';
            Editable = false;
        }
        field(5805; "Cost Amount (Non-Invtbl.)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Non-Invtbl.)';
            Editable = false;
        }
        field(5806; "Cost Amount (Expected) (ACY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Expected) (ACY)';
            Editable = false;
        }
        field(5817; Correction; Boolean)
        {
            Caption = 'Correction';
        }
        field(5818; "Shipped Qty. Not Returned"; Decimal)
        {
            AccessByPermission = TableData 36 = R;
            Caption = 'Shipped Qty. Not Returned';
            DecimalPlaces = 0 : 5;
        }
        field(5833; "Prod. Order Comp. Line No."; Integer)
        {
            AccessByPermission = TableData 5405 = R;
            Caption = 'Prod. Order Comp. Line No.';
        }
        field(6500; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';
        }
        field(6501; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
        }
        field(6502; "Warranty Date"; Date)
        {
            Caption = 'Warranty Date';
        }
        field(6503; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(6510; "Item Tracking"; Option)
        {
            Caption = 'Item Tracking';
            Editable = false;
            OptionCaption = 'None,Lot No.,Lot and Serial No.,Serial No.';
            OptionMembers = "None","Lot No.","Lot and Serial No.","Serial No.";
        }
        field(6602; "Return Reason Code"; Code[10])
        {
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";
        }
        field(13000; "DSA Entry No."; Integer)
        {
            Caption = 'DSA Entry No.';
        }
        field(13702; "BED %"; Decimal)
        {
            Caption = 'BED %';
        }
        field(13703; "BED Amount"; Decimal)
        {
            Caption = 'BED Amount';
        }
        field(13704; "Other Duties %"; Decimal)
        {
            Caption = 'Other Duties %';
        }
        field(13705; "Other Duties Amount"; Decimal)
        {
            Caption = 'Other Duties Amount';
        }
        field(16500; "Laboratory Test"; Boolean)
        {
            Caption = 'Laboratory Test';
        }
        field(16501; "Other Usage"; Option)
        {
            Caption = 'Other Usage';
            OptionCaption = ' ,Disposal,Wasted/Destroyed';
            OptionMembers = " ",Disposal,"Wasted/Destroyed";
        }
        field(16502; "Nature of Disposal"; Code[10])
        {
            Caption = 'Nature of Disposal';
        }
        field(16503; "Type of Disposal"; Option)
        {
            Caption = 'Type of Disposal';
            OptionCaption = ' ,Purchase return,Transfer Shipment,Sale,Negative Adjustment';
            OptionMembers = " ","Purchase return","Transfer Shipment",Sale,"Negative Adjustment";
        }
        field(16504; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(16505; "Captive Consumption"; Boolean)
        {
            Caption = 'Captive Consumption';
        }
        field(16506; "Re-Dispatch"; Boolean)
        {
            Caption = 'Re-Dispatch';
            Editable = false;
        }
        field(16510; "Assessable Value"; Decimal)
        {
            Caption = 'Assessable Value';
        }
        field(16515; "Subcon Order No."; Code[20])
        {
            Caption = 'Subcon Order No.';
        }
        field(50000; "Type Code"; Code[2])
        {
            Description = 'report s-16(68)';
        }
        field(50002; "Size Code"; Code[3])
        {
            Description = 'report s-16(68)';
        }
        field(50003; "Design Code"; Code[4])
        {
            Description = 'report closing stock valuation';
        }
        field(50004; "Color Code"; Code[4])
        {
            Description = 'report closing stock valuation';
        }
        field(50005; "Packing Code"; Code[2])
        {
        }
        field(50006; "Quality Code"; Code[1])
        {
            Description = 'report closing stock valuation';
        }
        field(50007; "Plant Code"; Code[10])
        {
            Description = 'report s-16(68)';
        }
        field(50008; "Main Location"; Code[20])
        {
            TableRelation = Location;
        }
        field(50009; InTransit; Boolean)
        {
        }
        field(50010; "Relational Location Code"; Code[20])
        {
            TableRelation = Location.Code WHERE("Main Location" = FILTER(''));
        }
        field(50011; "External Transfer"; Boolean)
        {
        }
        field(50012; "Qty in Sq.Mt."; Decimal)
        {
        }
        field(50013; "Qty In Carton"; Decimal)
        {
        }
        field(50014; "Category Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('CATG'));
        }
        field(50015; OK; Boolean)
        {
        }
        field(50016; "Production Plant Code"; Code[20])
        {
            TableRelation = Location.Code WHERE("Use As In-Transit" = FILTER(false));
        }
        field(50060; "Output Date"; Date)
        {
            Description = 'TRI S.K. 21.06.10';
            Editable = true;
        }
        field(50061; "Group Code"; Code[2])
        {
            Description = 'TRI N.K 20.02.08';
            TableRelation = "Item Group";
        }
        field(50062; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
            Editable = true;
            MinValue = 0;
        }
        field(50063; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
            Editable = true;
            MinValue = 0;
        }
        field(50064; "ILE Entry No. 3.7"; Integer)
        {
            Editable = false;
        }
        field(50065; "Old Variant Code"; Code[10])
        {
            Editable = false;
        }
        field(50067; "Capex No."; Code[20])
        {
            TableRelation = "Budget Master"."No.";
        }
        field(50068; "Inter Company"; Boolean)
        {
            Description = 'MS-PB';
        }
        field(50069; "IC Line No."; Integer)
        {
        }
        field(50070; "Prod. BOM No."; Code[20])
        {
        }
        field(60002; "Qty in PCS."; Decimal)
        {
            Description = 'TRI DG 010510';
            Editable = false;
        }
        field(60010; "Direct Consumption Entries"; Boolean)
        {
            Description = 'TRI P.G 03.06.2010';
        }
        field(60011; "Depot. Prod Order"; Boolean)
        {
            Description = 'TRI S.R';
            Editable = false;
        }
        field(60012; ReProcess; Boolean)
        {
            Description = 'TRI S.C. 09.06.10';
        }
        field(60013; "Re Process Production Order"; Boolean)
        {
            Description = 'TRI S.K 21.06.10 Add New Field';
        }
        field(60014; "Work Shift Code"; Code[20])
        {
            Description = 'TRI S.K 21.06.10 Add New Field';
        }
        field(60015; "Original Prod. No"; Code[20])
        {
            Description = 'TRI S.K 21.06.10 Add New Field';
        }
        field(60020; "Import Document"; Boolean)
        {
            Description = 'TRI DG 010710';
        }
        field(60022; "Routing Link Code"; Code[10])
        {
            Description = 'TRI VKG 27.09.10';
            TableRelation = "Routing Link";
        }
        field(60023; "Machine Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('MACHINE'));
        }
        field(60040; "End Use Item"; Boolean)
        {
        }
        field(60042; "Temp Entry to Adjust"; Boolean)
        {
        }
        field(70000; "Mfg. Batch No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(80000; "Ageing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(80010; "Created By"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(80015; "Creation date time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(80016; "Indent No."; Code[20])
        {
            CalcFormula = Lookup("Purch. Rcpt. Line"."Indent No." WHERE("Document No." = FIELD("External Document No.")));
            FieldClass = FlowField;
        }
        field(90021; "Physical Journal Entry"; Boolean)
        {
        }
        field(90022; "Physical Journal Key"; Code[10])
        {
        }
        field(90023; "Morbi Batch No."; Code[10])
        {
        }
        field(90024; "Posting Datetime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(90025; "Cost Amount- Prop."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(90026; "Cost Amount Expected-Prop."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(90027; "Cost Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(90028; "Cost Amount Expected"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Ageing Date", "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Item No.")
        {
            SumIndexFields = "Invoiced Quantity";
        }
        key(Key3; "Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date")
        {
            SumIndexFields = Quantity, "Invoiced Quantity", "Qty in Sq.Mt.", "Qty In Carton";
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", Description, "Item No.", "Posting Date", "Entry Type", "Document No.")
        {
        }
    }

    trigger OnInsert()
    var
        GenJnlPostPreview: Codeunit 19;
    begin
    end;

    var
        GLSetup: Record 98;
        ReservEntry: Record 337;
        ReservEngineMgt: Codeunit 99000831;
        ReserveItemLedgEntry: Codeunit 99000841;
        ItemTrackingMgt: Codeunit 6500;
        GLSetupRead: Boolean;
        IsNotOnInventoryErr: Label 'You have insufficient quantity of Item %1 on inventory.';
        Loc: Record 14;


    procedure CalculateRemQuantity(ItemLedgEntryNo: Integer; PostingDate: Date): Decimal
    var
        ItemApplnEntry: Record 339;
        RemQty: Decimal;
    begin
        ItemApplnEntry.SETCURRENTKEY("Inbound Item Entry No.");
        ItemApplnEntry.SETRANGE("Inbound Item Entry No.", ItemLedgEntryNo);
        RemQty := 0;
        IF ItemApplnEntry.FINDSET THEN
            REPEAT
                IF ItemApplnEntry."Posting Date" <= PostingDate THEN
                    RemQty += ItemApplnEntry.Quantity;
            UNTIL ItemApplnEntry.NEXT = 0;
        EXIT(RemQty);
    end;


    procedure CalculateRemInventoryValue(ItemLedgEntryNo: Integer; ItemLedgEntryQty: Decimal; RemQty: Decimal; IncludeExpectedCost: Boolean; PostingDate: Date): Decimal
    var
        ValueEntry: Record 5802;
        AdjustedCost: Decimal;
        TotalQty: Decimal;
    begin
        ValueEntry.SETCURRENTKEY("Item Ledger Entry No.");
        ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgEntryNo);
        ValueEntry.SETFILTER("Valuation Date", '<=%1', PostingDate);
        IF NOT IncludeExpectedCost THEN
            ValueEntry.SETRANGE("Expected Cost", FALSE);
        IF ValueEntry.FINDSET THEN
            REPEAT
                IF ValueEntry."Entry Type" = ValueEntry."Entry Type"::Revaluation THEN
                    TotalQty := ValueEntry."Valued Quantity"
                ELSE
                    TotalQty := ItemLedgEntryQty;
                IF ValueEntry."Entry Type" <> ValueEntry."Entry Type"::Rounding THEN
                    IF IncludeExpectedCost THEN
                        AdjustedCost += RemQty / TotalQty * (ValueEntry."Cost Amount (Actual)" + ValueEntry."Cost Amount (Expected)")
                    ELSE
                        AdjustedCost += RemQty / TotalQty * ValueEntry."Cost Amount (Actual)";
            UNTIL ValueEntry.NEXT = 0;
        EXIT(AdjustedCost);
    end;
}

