table 99987 "Value Entry mismatch"
{
    Caption = 'Value Entry';
    DrillDownPageID = "Value Entries";
    LookupPageID = "Value Entries";

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
        field(4; "Item Ledger Entry Type"; Option)
        {
            Caption = 'Item Ledger Entry Type';
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ";
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
        field(7; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(8; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(9; "Inventory Posting Group"; Code[10])
        {
            Caption = 'Inventory Posting Group';
            TableRelation = "Inventory Posting Group";
        }
        field(10; "Source Posting Group"; Code[10])
        {
            Caption = 'Source Posting Group';
            TableRelation = IF ("Source Type" = CONST(Customer)) "Customer Posting Group"
            ELSE
            IF ("Source Type" = CONST(Vendor)) "Vendor Posting Group"
            ELSE
            IF ("Source Type" = CONST(Item)) "Inventory Posting Group";
        }
        field(11; "Item Ledger Entry No."; Integer)
        {
            Caption = 'Item Ledger Entry No.';
            TableRelation = "Item Ledger Entry";
        }
        field(12; "Valued Quantity"; Decimal)
        {
            Caption = 'Valued Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(14; "Invoiced Quantity"; Decimal)
        {
            Caption = 'Invoiced Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(15; "Cost per Unit"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Cost per Unit';
        }
        field(17; "Sales Amount (Actual)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Sales Amount (Actual)';
        }
        field(22; "Salespers./Purch. Code"; Code[10])
        {
            Caption = 'Salespers./Purch. Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(23; "Discount Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Discount Amount';
        }
        field(24; "User ID"; Code[20])
        {
            Caption = 'User ID';
            //TableRelation = 2000000002; //16225 TABLE N/F
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
                //  LoginMgt.LookupUserID("User ID"); //16225 CODEUNIT LookupUserID FUNCATION N/F
            end;
        }
        field(25; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(28; "Applies-to Entry"; Integer)
        {
            Caption = 'Applies-to Entry';
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
        field(41; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = ' ,Customer,Vendor,Item';
            OptionMembers = " ",Customer,Vendor,Item;
        }
        field(43; "Cost Amount (Actual)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Actual)';
        }
        field(45; "Cost Posted to G/L"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Posted to G/L';
        }
        field(46; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(47; "Drop Shipment"; Boolean)
        {
            Caption = 'Drop Shipment';
        }
        field(48; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            //This property is currently not supported
            //TestTableRelation = false;
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
        field(60; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(61; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(68; "Cost Amount (Actual) (ACY)"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Cost Amount (Actual) (ACY)';
        }
        field(70; "Cost Posted to G/L (ACY)"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Cost Posted to G/L (ACY)';
        }
        field(72; "Cost per Unit (ACY)"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 2;
            Caption = 'Cost per Unit (ACY)';
        }
        field(98; "Expected Cost"; Boolean)
        {
            Caption = 'Expected Cost';
        }
        field(99; "Item Charge No."; Code[20])
        {
            Caption = 'Item Charge No.';
            TableRelation = "Item Charge";
        }
        field(100; "Valued By Average Cost"; Boolean)
        {
            Caption = 'Valued By Average Cost';
        }
        field(102; "Partial Revaluation"; Boolean)
        {
            Caption = 'Partial Revaluation';
        }
        field(103; Inventoriable; Boolean)
        {
            Caption = 'Inventoriable';
        }
        field(104; "Valuation Date"; Date)
        {
            Caption = 'Valuation Date';
        }
        field(105; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            Editable = false;
            OptionCaption = 'Direct Cost,Revaluation,Rounding,Indirect Cost,Variance';
            OptionMembers = "Direct Cost",Revaluation,Rounding,"Indirect Cost",Variance;
        }
        field(106; "Variance Type"; Option)
        {
            Caption = 'Variance Type';
            Editable = false;
            OptionCaption = ' ,Purchase,Material,Capacity,Capacity Overhead,Manufacturing Overhead,Subcontracted';
            OptionMembers = " ",Purchase,Material,Capacity,"Capacity Overhead","Manufacturing Overhead",Subcontracted;
        }
        field(107; "G/L Entry No. (Account)"; Integer)
        {
            BlankZero = true;
            Caption = 'G/L Entry No. (Account)';
            TableRelation = "G/L Entry";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(108; "G/L Entry No. (Bal. Account)"; Integer)
        {
            BlankZero = true;
            Caption = 'G/L Entry No. (Bal. Account)';
            TableRelation = "G/L Entry";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(148; "Purchase Amount (Actual)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Purchase Amount (Actual)';
        }
        field(149; "Purchase Amount (Expected)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Purchase Amount (Expected)';
        }
        field(150; "Sales Amount (Expected)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Sales Amount (Expected)';
        }
        field(151; "Cost Amount (Expected)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Expected)';
        }
        field(152; "Cost Amount (Non-Invtbl.)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Non-Invtbl.)';
        }
        field(156; "Cost Amount (Expected) (ACY)"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Cost Amount (Expected) (ACY)';
        }
        field(157; "Cost Amount (Non-Invtbl.)(ACY)"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Cost Amount (Non-Invtbl.)(ACY)';
        }
        field(5401; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(5818; Adjustment; Boolean)
        {
            Caption = 'Adjustment';
            Editable = false;
        }
        field(5831; "Capacity Ledger Entry No."; Integer)
        {
            Caption = 'Capacity Ledger Entry No.';
            TableRelation = "Notification - User Mapping";
        }
        field(5832; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Work Center,Machine Center, ';
            OptionMembers = "Work Center","Machine Center"," ";
        }
        field(5834; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST("Machine Center")) "Machine Center"
            ELSE
            IF (Type = CONST("Work Center")) "Work Center";
        }
        field(5881; "Prod. Order Line No."; Integer)
        {
            Caption = 'Prod. Order Line No.';
        }
        field(6602; "Return Reason Code"; Code[10])
        {
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";
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
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Item Ledger Entry No.", "Expected Cost", "Document No.", "Partial Revaluation", "Entry Type", "Variance Type", Adjustment)
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Invoiced Quantity", "Sales Amount (Expected)", "Sales Amount (Actual)", "Cost Amount (Expected)", "Cost Amount (Actual)", "Cost Amount (Non-Invtbl.)", "Cost Amount (Expected) (ACY)", "Cost Amount (Actual) (ACY)", "Cost Amount (Non-Invtbl.)(ACY)", "Purchase Amount (Actual)", "Purchase Amount (Expected)";
        }
        key(Key3; "Item No.", "Item Ledger Entry Type", "Entry Type", "Item Charge No.", "Location Code", "Variant Code", "Expected Cost", "Posting Date")
        {
            SumIndexFields = "Invoiced Quantity", "Sales Amount (Expected)", "Sales Amount (Actual)", "Cost Amount (Expected)", "Cost Amount (Actual)", "Cost Amount (Non-Invtbl.)", "Cost Amount (Expected) (ACY)", "Cost Amount (Actual) (ACY)", "Cost Amount (Non-Invtbl.)(ACY)", "Purchase Amount (Actual)", "Purchase Amount (Expected)";
        }
        key(Key4; "Document No.", "Posting Date")
        {
        }
        key(Key5; "Item No.", "Expected Cost", "Valuation Date", "Location Code", "Variant Code")
        {
            SumIndexFields = "Invoiced Quantity", "Sales Amount (Expected)", "Sales Amount (Actual)", "Cost Amount (Expected)", "Cost Amount (Actual)", "Cost Amount (Non-Invtbl.)", "Cost Amount (Expected) (ACY)", "Cost Amount (Actual) (ACY)", "Cost Amount (Non-Invtbl.)(ACY)", "Purchase Amount (Actual)", "Purchase Amount (Expected)";
        }
        key(Key6; "Item No.", "Valued By Average Cost", Adjustment, "Valuation Date")
        {
        }
        key(Key7; "Source Type", "Source No.", "Item Ledger Entry Type", "Item No.", "Posting Date")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Discount Amount", "Cost Amount (Non-Invtbl.)";
        }
        key(Key8; "Item Charge No.", "Inventory Posting Group", "Item No.")
        {
        }
        key(Key9; "Capacity Ledger Entry No.", "Entry Type")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Cost Amount (Actual)", "Cost Amount (Actual) (ACY)";
        }
        key(Key10; "Prod. Order No.")
        {
        }
        key(Key11; "Item Ledger Entry No.", "Expected Cost", "Valuation Date")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Cost Amount (Expected)", "Cost Amount (Expected) (ACY)";
        }
        key(Key12; "Item Ledger Entry Type", "Location Code", "Prod. Order No.", "Prod. Order Line No.", "Source Type", "Source No.")
        {
            SumIndexFields = "Cost Amount (Actual)", "Cost Amount (Actual) (ACY)";
        }
        key(Key13; "Inventory Posting Group", "Item Ledger Entry Type", "Posting Date", "Item No.")
        {
            SumIndexFields = "Cost Amount (Actual)";
        }
        key(Key14; "Item No.", "Inventory Posting Group", "Posting Date")
        {
            SumIndexFields = "Cost Amount (Actual)";
        }
    }

    fieldgroups
    {
    }

    var
        GLSetup: Record "General Ledger Setup";
        DimMgt: Codeunit DimensionManagement;
        GLSetupRead: Boolean;

    procedure GetCurrencyCode(): Code[10]
    begin
        IF NOT GLSetupRead THEN BEGIN
            GLSetup.GET;
            GLSetupRead := TRUE;
        END;
        EXIT(GLSetup."Additional Reporting Currency");
    end;
}

