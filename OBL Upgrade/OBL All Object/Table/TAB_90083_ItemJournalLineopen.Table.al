table 90083 "Item Journal Line open"
{
    Caption = 'Item Journal Line';
    DrillDownPageID = "Item Journal Lines";
    LookupPageID = "Item Journal Lines";

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Item Journal Template";
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
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate()
            var
                CheckDateConflict: Codeunit "Reservation-Check Date Confl.";
            begin
            end;
        }
        field(5; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output;
        }
        field(6; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            Editable = false;
            TableRelation = IF ("Source Type" = CONST("Customer")) "Customer"
            ELSE
            IF ("Source Type" = CONST("Vendor")) "Vendor"
            ELSE
            IF ("Source Type" = CONST("Item")) "Item";
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(8; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(9; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(10; "Inventory Posting Group"; Code[10])
        {
            Caption = 'Inventory Posting Group';
            Editable = false;
            TableRelation = "Inventory Posting Group";
        }
        field(11; "Source Posting Group"; Code[10])
        {
            Caption = 'Source Posting Group';
            Editable = false;
            TableRelation = IF ("Source Type" = CONST("Customer")) "Customer Posting Group"
            ELSE
            IF ("Source Type" = CONST("Vendor")) "Vendor Posting Group"
            ELSE
            IF ("Source Type" = CONST("Item")) "Inventory Posting Group";
        }
        field(13; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(15; "Invoiced Quantity"; Decimal)
        {
            Caption = 'Invoiced Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(16; "Unit Amount"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Amount';
        }
        field(17; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost';
        }
        field(18; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(22; "Discount Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Discount Amount';
            Editable = false;
        }
        field(23; "Salespers./Purch. Code"; Code[10])
        {
            Caption = 'Salespers./Purch. Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(26; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            Editable = false;
            TableRelation = "Source Code";
        }
        field(29; "Applies-to Entry"; Integer)
        {
            Caption = 'Applies-to Entry';

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
            begin
            end;
        }
        field(32; "Item Shpt. Entry No."; Integer)
        {
            Caption = 'Item Shpt. Entry No.';
            Editable = false;
        }
        field(34; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(35; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(37; "Indirect Cost %"; Decimal)
        {
            Caption = 'Indirect Cost %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(39; "Source Type"; Option)
        {
            Caption = 'Source Type';
            Editable = false;
            OptionCaption = ' ,Customer,Vendor,Item';
            OptionMembers = " ",Customer,Vendor,Item;
        }
        field(41; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(42; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(43; "Recurring Method"; Option)
        {
            BlankZero = true;
            Caption = 'Recurring Method';
            OptionCaption = ',Fixed,Variable';
            OptionMembers = ,"Fixed",Variable;
        }
        field(44; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(45; "Recurring Frequency"; DateFormula)
        {
            Caption = 'Recurring Frequency';
        }
        field(46; "Drop Shipment"; Boolean)
        {
            Caption = 'Drop Shipment';
            Editable = false;
        }
        field(47; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(48; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(49; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
        }
        field(50; "New Location Code"; Code[10])
        {
            Caption = 'New Location Code';
            TableRelation = Location;
        }
        field(51; "New Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1,' + Text007;
            Caption = 'New Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(52; "New Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2,' + Text007;
            Caption = 'New Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(53; "Qty. (Calculated)"; Decimal)
        {
            Caption = 'Qty. (Calculated)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(54; "Qty. (Phys. Inventory)"; Decimal)
        {
            Caption = 'Qty. (Phys. Inventory)';
            DecimalPlaces = 0 : 5;
        }
        field(55; "Last Item Ledger Entry No."; Integer)
        {
            Caption = 'Last Item Ledger Entry No.';
            Editable = false;
            TableRelation = "Item Ledger Entry";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(56; "Phys. Inventory"; Boolean)
        {
            Caption = 'Phys. Inventory';
            Editable = false;
        }
        field(57; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(58; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
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
        field(62; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(63; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(64; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(65; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
        }
        field(68; "Reserved Quantity"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry".Quantity WHERE("Reservation Status" = CONST(Reservation),
                                                                  "Source Type" = CONST(83),
                                                                  "Source Subtype" = FIELD("Entry Type"),
                                                                  "Source ID" = FIELD("Journal Template Name"),
                                                                  "Source Batch Name" = FIELD("Journal Batch Name"),
                                                                  "Source Prod. Order Line" = CONST(0),
                                                                  "Source Ref. No." = FIELD("Line No.")));
            Caption = 'Reserved Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(72; "Unit Cost (ACY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Unit Cost (ACY)';
            Editable = false;
        }
        field(73; "Source Currency Code"; Code[10])
        {
            Caption = 'Source Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(5401; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            TableRelation = "Production Order"."No." WHERE(Status = CONST(Released));
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = IF ("Entry Type" = FILTER('Purchase' | 'Positive Adjmt.' | 'Output'),
                                Quantity = FILTER(>= 0)) Bin.Code WHERE("Location Code" = FIELD("Location Code"),
                                                                      "Item Filter" = FIELD("Item No."),
                                                                      "Variant Filter" = FIELD("Variant Code"))
            ELSE
            IF ("Entry Type" = FILTER('Purchase' | 'Positive Adjmt.' | 'Output'),
                                                                               Quantity = FILTER(< 0)) "Bin Content"."Bin Code" WHERE("Location Code" = FIELD("Location Code"),
                                                                                                                                    "Item No." = FIELD("Item No."),
                                                                                                                                    "Variant Code" = FIELD("Variant Code"))
            ELSE
            IF ("Entry Type" = FILTER('Sale' | 'Negative Adjmt.' | 'Transfer' | 'Consumption'),
                                                                                                                                             Quantity = FILTER(>= 0)) "Bin Content"."Bin Code" WHERE("Location Code" = FIELD("Location Code"),
                                                                                                                                                                                                   "Item No." = FIELD("Item No."),
                                                                                                                                                                                                   "Variant Code" = FIELD("Variant Code"))
            ELSE
            IF ("Entry Type" = FILTER('Sale' | 'Negative Adjmt.' | 'Transfer' | 'Consumption'),
                                                                                                                                                                                                            Quantity = FILTER(< 0)) Bin.Code WHERE("Location Code" = FIELD("Location Code"),
                                                                                                                                                                                                                                                 "Item Filter" = FIELD("Item No."),
                                                                                                                                                                                                                                                 "Variant Filter" = FIELD("Variant Code"));
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(5406; "New Bin Code"; Code[20])
        {
            Caption = 'New Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("New Location Code"),
                                            "Item Filter" = FIELD("Item No."),
                                            "Variant Filter" = FIELD("Variant Code"));
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(5408; "Derived from Blanket Order"; Boolean)
        {
            Caption = 'Derived from Blanket Order';
            Editable = false;
        }
        field(5413; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5415; "Invoiced Qty. (Base)"; Decimal)
        {
            Caption = 'Invoiced Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5468; "Reserved Qty. (Base)"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Reservation Status" = CONST(Reservation),
                                                                           "Source Type" = CONST(83),
                                                                           "Source Subtype" = FIELD("Entry Type"),
                                                                           "Source ID" = FIELD("Journal Template Name"),
                                                                           "Source Batch Name" = FIELD("Journal Batch Name"),
                                                                           "Source Prod. Order Line" = CONST(0),
                                                                           "Source Ref. No." = FIELD("Line No.")));
            Caption = 'Reserved Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5700; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';
        }
        field(5701; "Originally Ordered No."; Code[20])
        {
            Caption = 'Originally Ordered No.';
            TableRelation = Item;
        }
        field(5702; "Originally Ordered Var. Code"; Code[10])
        {
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
        field(5740; "Transfer Order No."; Code[20])
        {
            Caption = 'Transfer Order No.';
            Editable = false;
        }
        field(5791; "Planned Delivery Date"; Date)
        {
            Caption = 'Planned Delivery Date';
        }
        field(5793; "Order Date"; Date)
        {
            Caption = 'Order Date';
        }
        field(5800; "Value Entry Type"; Option)
        {
            Caption = 'Value Entry Type';
            OptionCaption = 'Direct Cost,Revaluation,Rounding,Indirect Cost,Variance';
            OptionMembers = "Direct Cost",Revaluation,Rounding,"Indirect Cost",Variance;
        }
        field(5801; "Item Charge No."; Code[20])
        {
            Caption = 'Item Charge No.';
            TableRelation = "Item Charge";
        }
        field(5802; "Inventory Value (Calculated)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Inventory Value (Calculated)';
            Editable = false;
        }
        field(5803; "Inventory Value (Revalued)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Inventory Value (Revalued)';
            MinValue = 0;

            trigger OnValidate()
            var
                NewUnitCost: Decimal;
            begin
            end;
        }
        field(5804; "Variance Type"; Option)
        {
            Caption = 'Variance Type';
            OptionCaption = ' ,Purchase,Material,Capacity,Capacity Overhead,Manufacturing Overhead';
            OptionMembers = " ",Purchase,Material,Capacity,"Capacity Overhead","Manufacturing Overhead";
        }
        field(5805; "Inventory Value Per"; Option)
        {
            Caption = 'Inventory Value Per';
            Editable = false;
            OptionCaption = ' ,Item,Location,Variant,Location and Variant';
            OptionMembers = " ",Item,Location,Variant,"Location and Variant";
        }
        field(5806; "Partial Revaluation"; Boolean)
        {
            Caption = 'Partial Revaluation';
            Editable = false;
        }
        field(5807; "Applies-from Entry"; Integer)
        {
            Caption = 'Applies-from Entry';
            MinValue = 0;

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
            begin
            end;
        }
        field(5808; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
        }
        field(5809; "Unit Cost (Calculated)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (Calculated)';
            Editable = false;
        }
        field(5810; "Unit Cost (Revalued)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (Revalued)';
            MinValue = 0;
        }
        field(5811; "Applied Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Applied Amount';
            Editable = false;
        }
        field(5812; "Update Standard Cost"; Boolean)
        {
            Caption = 'Update Standard Cost';
        }
        field(5813; "Amount (ACY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (ACY)';
        }
        field(5817; Correction; Boolean)
        {
            Caption = 'Correction';
        }
        field(5818; Adjustment; Boolean)
        {
            Caption = 'Adjustment';
        }
        field(5819; "Applies-to Value Entry"; Integer)
        {
            Caption = 'Applies-to Value Entry';
        }
        field(5830; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Work Center,Machine Center, ';
            OptionMembers = "Work Center","Machine Center"," ";
        }
        field(5831; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST("Machine Center")) "Machine Center"
            ELSE
            IF (Type = CONST("Work Center")) "Work Center";
        }
        field(5838; "Operation No."; Code[10])
        {
            Caption = 'Operation No.';
            TableRelation = "Prod. Order Routing Line"."Operation No." WHERE(Status = CONST(Released),
                                                                              "Prod. Order No." = FIELD("Prod. Order No."),
                                                                              "Routing No." = FIELD("Routing No."),
                                                                              "Routing Reference No." = FIELD("Routing Reference No."),
                                                                              "Routing Status" = FILTER(< Finished));
        }
        field(5839; "Work Center No."; Code[20])
        {
            Caption = 'Work Center No.';
            Editable = false;
            TableRelation = "Work Center";
        }
        field(5841; "Setup Time"; Decimal)
        {
            Caption = 'Setup Time';
            DecimalPlaces = 0 : 5;
        }
        field(5842; "Run Time"; Decimal)
        {
            Caption = 'Run Time';
            DecimalPlaces = 0 : 5;
        }
        field(5843; "Stop Time"; Decimal)
        {
            Caption = 'Stop Time';
            DecimalPlaces = 0 : 5;
        }
        field(5846; "Output Quantity"; Decimal)
        {
            Caption = 'Output Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(5847; "Scrap Quantity"; Decimal)
        {
            Caption = 'Scrap Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(5849; "Concurrent Capacity"; Decimal)
        {
            Caption = 'Concurrent Capacity';
            DecimalPlaces = 0 : 5;
        }
        field(5851; "Setup Time (Base)"; Decimal)
        {
            Caption = 'Setup Time (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5852; "Run Time (Base)"; Decimal)
        {
            Caption = 'Run Time (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5853; "Stop Time (Base)"; Decimal)
        {
            Caption = 'Stop Time (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5856; "Output Quantity (Base)"; Decimal)
        {
            Caption = 'Output Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5857; "Scrap Quantity (Base)"; Decimal)
        {
            Caption = 'Scrap Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5858; "Cap. Unit of Measure Code"; Code[10])
        {
            Caption = 'Cap. Unit of Measure Code';
            TableRelation = "Capacity Unit of Measure";

            trigger OnValidate()
            var
                DirectUnitCost: Decimal;
            begin
            end;
        }
        field(5859; "Qty. per Cap. Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Cap. Unit of Measure';
            DecimalPlaces = 0 : 5;
        }
        field(5873; "Starting Time"; Time)
        {
            Caption = 'Starting Time';
        }
        field(5874; "Ending Time"; Time)
        {
            Caption = 'Ending Time';
        }
        field(5880; "Prod. Order Line No."; Integer)
        {
            Caption = 'Prod. Order Line No.';
            TableRelation = "Prod. Order Line"."Line No." WHERE(Status = CONST(Released),
                                                                 "Prod. Order No." = FIELD("Prod. Order No."));
        }
        field(5882; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
            Editable = false;
            TableRelation = "Routing Header";
        }
        field(5883; "Routing Reference No."; Integer)
        {
            Caption = 'Routing Reference No.';
        }
        field(5884; "Prod. Order Comp. Line No."; Integer)
        {
            Caption = 'Prod. Order Comp. Line No.';
            TableRelation = "Prod. Order Component"."Line No." WHERE(Status = CONST(Released),
                                                                      "Prod. Order No." = FIELD("Prod. Order No."),
                                                                      "Prod. Order Line No." = FIELD("Prod. Order Line No."));
        }
        field(5885; Finished; Boolean)
        {
            Caption = 'Finished';
        }
        field(5887; "Unit Cost Calculation"; Option)
        {
            Caption = 'Unit Cost Calculation';
            OptionCaption = 'Time,Units';
            OptionMembers = Time,Units;
        }
        field(5888; Subcontracting; Boolean)
        {
            Caption = 'Subcontracting';
        }
        field(5895; "Stop Code"; Code[10])
        {
            Caption = 'Stop Code';
            TableRelation = Stop;
        }
        field(5896; "Scrap Code"; Code[10])
        {
            Caption = 'Scrap Code';
            TableRelation = Scrap;
        }
        field(5898; "Work Center Group Code"; Code[10])
        {
            Caption = 'Work Center Group Code';
            Editable = false;
            TableRelation = "Work Center Group";
        }
        field(5899; "Work Shift Code"; Code[10])
        {
            Caption = 'Work Shift Code';
            TableRelation = "Work Shift";
        }
        field(5900; "Service Order No."; Code[20])
        {
            Caption = 'Service Order No.';
            Editable = false;
        }
        field(6500; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';
            Editable = false;
        }
        field(6501; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            Editable = false;
        }
        field(6502; "Warranty Date"; Date)
        {
            Caption = 'Warranty Date';
            Editable = false;
        }
        field(6503; "New Serial No."; Code[20])
        {
            Caption = 'New Serial No.';
            Editable = false;
        }
        field(6504; "New Lot No."; Code[20])
        {
            Caption = 'New Lot No.';
            Editable = false;
        }
        field(6600; "Return Reason Code"; Code[10])
        {
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";
        }
        field(7380; "Phys Invt Counting Period Code"; Code[10])
        {
            Caption = 'Phys Invt Counting Period Code';
            Editable = false;
            TableRelation = "Phys. Invt. Counting Period";
        }
        field(7381; "Phys Invt Counting Period Type"; Option)
        {
            Caption = 'Phys Invt Counting Period Type';
            Editable = false;
            OptionCaption = ' ,Item,SKU';
            OptionMembers = " ",Item,SKU;
        }
        field(13700; "Export Document"; Boolean)
        {
        }
        field(13701; "Import Document"; Boolean)
        {
        }
        field(13702; "Excise %"; Decimal)
        {
        }
        field(13703; "Excise Amount"; Decimal)
        {
        }
        field(13710; "Reverse Excise"; Boolean)
        {
        }
        field(13711; "RG23PartI Entry No."; Integer)
        {
        }
        field(13712; "RG23PartII Entry No."; Integer)
        {
        }
        field(13713; Return; Boolean)
        {
        }
        field(13715; "RG Correction Type"; Option)
        {
            OptionMembers = Purchase,Sale;
        }
        field(13716; "RG Line No."; Integer)
        {
        }
        field(13717; "Excise Record"; Option)
        {
            OptionCaption = ',RG23A,RG23C';
            OptionMembers = ,RG23A,RG23C;
        }
        field(99000755; "Overhead Rate"; Decimal)
        {
            Caption = 'Overhead Rate';
            DecimalPlaces = 0 : 5;
        }
        field(99000756; "Single-Level Material Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Single-Level Material Cost';
        }
        field(99000757; "Single-Level Capacity Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Single-Level Capacity Cost';
        }
        field(99000758; "Single-Level Subcontrd. Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Single-Level Subcontrd. Cost';
        }
        field(99000759; "Single-Level Cap. Ovhd Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Single-Level Cap. Ovhd Cost';
        }
        field(99000760; "Single-Level Mfg. Ovhd Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Single-Level Mfg. Ovhd Cost';
        }
        field(99000761; "Rolled-up Material Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Rolled-up Material Cost';
        }
        field(99000762; "Rolled-up Capacity Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Rolled-up Capacity Cost';
        }
        field(99000763; "Rolled-up Subcontracted Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Rolled-up Subcontracted Cost';
        }
        field(99000764; "Rolled-up Mfg. Ovhd Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Rolled-up Mfg. Ovhd Cost';
        }
        field(99000765; "Rolled-up Cap. Overhead Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Rolled-up Cap. Overhead Cost';
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
            MaintainSIFTIndex = false;
        }
        key(Key2; "Entry Type", "Item No.", "Variant Code", "Location Code", "Bin Code", "Posting Date")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Quantity (Base)";
        }
        key(Key3; "Entry Type", "Item No.", "Variant Code", "New Location Code", "New Bin Code", "Posting Date")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Quantity (Base)";
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label 'Prices including VAT cannot be calculated when %1 is %2.';
        Text001: Label '%1 must be reduced.';
        Text002: Label 'You cannot change %1 when %2 is %3.';
        Text003: Label 'You cannot change %3 when %2 is %1.';
        Text005: Label 'Change %1 from %2 to %3?';
        Text006: Label 'You must not enter %1 in a revaluation sum line.';
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlLine: Record "Item Journal Line";
        Item: Record Item;
        ItemVariant: Record "Item Variant";
        GLSetup: Record "General Ledger Setup";
        SKU: Record "Stockkeeping Unit";
        MfgSetup: Record "Manufacturing Setup";
        ProdOrder: Record "Production Order";
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderComp: Record "Prod. Order Component";
        ProdOrderRtngLine: Record "Prod. Order Routing Line";
        WorkCenter: Record "Work Center";
        MachineCenter: Record "Machine Center";
        Location: Record Location;
        Bin: Record Bin;
        Reservation: Page Reservation;
        ItemAvailByDate: Page "Item Availability by Periods";
        ItemAvailByVar: Page "Item Availability by Variant";
        ItemAvailByLoc: Page "Item Availability by Location";
        ItemCheckAvail: Codeunit "Item-Check Avail.";
        ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UOMMgt: Codeunit "Unit of Measure Management";
        DimMgt: Codeunit DimensionManagement;
        UserMgt: Codeunit "User Setup Management";
        CalendarMgt: Codeunit "Shop Calendar Management";
        CostCalcMgt: Codeunit "Cost Calculation Management";
        PurchPriceCalcMgt: Codeunit 7010;
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        WMSManagement: Codeunit "WMS Management";
        PositiveSourceLine: Boolean;
        PhysInvtEntered: Boolean;
        GLSetupRead: Boolean;
        MfgSetupRead: Boolean;
        UnitCost: Decimal;
        Text007: Label 'New ';
        Text010: Label 'You cannot revalue outputs manually.';
        Text011: Label 'The unit cost cannot be changed to %1. Do you want to change it to %2 instead?';
        Text012: Label 'The update has been interrupted to respect the warning.';
        Text029: Label 'must be positive';
        Text030: Label 'must be negative';
        ItemJnlTemplate1: Record "Item Journal Template";
        UserAccess: Integer;
        UserLocation: Record "User Location";
        Permissions: Codeunit Permissions1;
        GeneralLedgerSetup: Record "General Ledger Setup";
        Location1: Record Location;

    procedure EmptyLine(): Boolean
    begin
    end;

    procedure IsValueEntryForDeletedItem(): Boolean
    begin
    end;

    local procedure CalcBaseQty(Qty: Decimal): Decimal
    begin
    end;

    local procedure CalcBaseTime(Qty: Decimal): Decimal
    begin
    end;

    procedure UpdateAmount()
    begin
    end;

    local procedure SelectItemEntry(CurrentFieldNo: Integer)
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemJnlLine2: Record "Item Journal Line";
    begin
    end;

    local procedure CheckItemAvailable(CalledByFieldNo: Integer)
    begin
    end;

    local procedure GetItem()
    begin
    end;

    procedure SetUpNewLine(LastItemJnlLine: Record "Item Journal Line")
    begin
    end;

    procedure GetUnitAmount(CalledByFieldNo: Integer)
    begin
    end;

    procedure ShowReservation()
    begin
    end;

    procedure Signed(Value: Decimal): Decimal
    begin
    end;

    procedure IsInbound(): Boolean
    begin
    end;

    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
    end;

    procedure BlockDynamicTracking(SetBlock: Boolean)
    begin
    end;

    procedure OpenItemTrackingLines(IsReclass: Boolean)
    begin
    end;


    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20])
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
    end;

    procedure CreateProdDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20])
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
    end;


    procedure GetDim()
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

    procedure ValidateNewShortcutDimCode(FieldNumber: Integer; var NewShortcutDimCode: Code[20])
    begin
    end;

    procedure LookupNewShortcutDimCode(FieldNumber: Integer; var NewShortcutDimCode: Code[20])
    begin
    end;

    procedure ShowNewShortcutDimCode(var NewShortcutDimCode: array[8] of Code[20])
    begin
    end;

    local procedure InitRevalJnlLine(ItemLedgEntry2: Record "Item Ledger Entry")
    var
        ValueEntry: Record "Value Entry";
    begin
    end;

    local procedure ReadGLSetup()
    begin
    end;

    local procedure GetSKU(): Boolean
    begin
    end;

    local procedure RetrieveCosts()
    begin
    end;

    local procedure CalcUnitCost(ItemLedgEntryNo: Integer): Decimal
    var
        ValueEntry: Record "Value Entry";
    begin
    end;

    local procedure ClearSingleAndRolledUpCosts()
    begin
    end;

    procedure GetMfgSetup()
    begin
    end;

    local procedure GetProdOrderRtngLine()
    begin
    end;


    procedure SetFilterProdOrderLine()
    begin
    end;

    procedure SetFilterProdOrderComp()
    begin
    end;

    procedure OnlyStopTime(): Boolean
    begin
    end;

    procedure OutputValuePosting(): Boolean
    begin
    end;

    procedure TimeIsEmpty(): Boolean
    begin
    end;

    procedure RowID1(): Text[250]
    var
        ItemTrackingMgt: Codeunit "Item Tracking Management";
    begin
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
    end;

    local procedure GetBin(LocationCode: Code[10]; BinCode: Code[20])
    begin
    end;

    procedure ItemPosting(): Boolean
    var
        ProdOrderRtngLine: Record "Prod. Order Routing Line";
    begin
    end;
}

