table 99330 "Gen. Journal Line - Temp"
{
    Caption = 'Gen. Journal Line - Temp';

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(4; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset";

            trigger OnValidate()
            var
                CompanyInfo: Record "Company Information";
            begin
            end;
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            ClosingDates = true;
        }
        field(6; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(8; Description; Text[200])
        {
            Caption = 'Description';
            Description = 'Tri PG 29.11.2006 Field Length Change From 200 -> 50';
        }
        field(10; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(11; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Customer")) Customer
            ELSE
            IF ("Bal. Account Type" = CONST("Vendor")) Vendor
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset";

            trigger OnValidate()
            var
                CompanyInfo: Record "Company Information";
            begin
            end;
        }
        field(12; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(13; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(14; "Debit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Debit Amount';
        }
        field(15; "Credit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Credit Amount';
        }
        field(16; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';
        }
        field(17; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Balance (LCY)';
            Editable = false;
        }
        field(18; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(19; "Sales/Purch. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Sales/Purch. (LCY)';
        }
        field(20; "Profit (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Profit (LCY)';
        }
        field(21; "Inv. Discount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Inv. Discount (LCY)';
        }
        field(22; "Bill-to/Pay-to No."; Code[20])
        {
            Caption = 'Bill-to/Pay-to No.';
            TableRelation = IF ("Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Bal. Account Type" = CONST("Customer")) Customer
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Bal. Account Type" = CONST(Vendor)) Vendor;
        }
        field(23; "Posting Group"; Code[10])
        {
            Caption = 'Posting Group';
            Editable = false;
            TableRelation = IF ("Account Type" = CONST(Customer)) "Customer Posting Group"
            ELSE
            IF ("Account Type" = CONST(Vendor)) "Vendor Posting Group"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "FA Posting Group";
        }
        field(24; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(25; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(26; "Salespers./Purch. Code"; Code[10])
        {
            Caption = 'Salespers./Purch. Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(29; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            Editable = false;
            TableRelation = "Source Code";
        }
        field(30; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            Editable = false;
        }
        field(34; "On Hold"; Code[3])
        {
            Caption = 'On Hold';
        }
        field(35; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(36; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnLookup()
            var
                GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
                PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
            begin
            end;
        }
        field(38; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(39; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';
        }
        field(40; "Payment Discount %"; Decimal)
        {
            Caption = 'Payment Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(42; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            Editable = false;
            TableRelation = Job;
        }
        field(43; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(44; "VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Amount';
        }
        field(45; "VAT Posting"; Option)
        {
            Caption = 'VAT Posting';
            Editable = false;
            OptionCaption = 'Automatic VAT Entry,Manual VAT Entry';
            OptionMembers = "Automatic VAT Entry","Manual VAT Entry";
        }
        field(47; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(48; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';
        }
        field(50; "Business Unit Code"; Code[10])
        {
            Caption = 'Business Unit Code';
            TableRelation = "Business Unit";
        }
        field(51; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(52; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(53; "Recurring Method"; Option)
        {
            BlankZero = true;
            Caption = 'Recurring Method';
            OptionCaption = ' ,F  Fixed,V  Variable,B  Balance,RF Reversing Fixed,RV Reversing Variable,RB Reversing Balance';
            OptionMembers = " ","F  Fixed","V  Variable","B  Balance","RF Reversing Fixed","RV Reversing Variable","RB Reversing Balance";
        }
        field(54; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(55; "Recurring Frequency"; DateFormula)
        {
            Caption = 'Recurring Frequency';
        }
        field(56; "Allocated Amt. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Gen. Jnl. Allocation".Amount WHERE("Journal Template Name" = FIELD("Journal Template Name"),
                                                                   "Journal Batch Name" = FIELD("Journal Batch Name"),
                                                                   "Journal Line No." = FIELD("Line No.")));
            Caption = 'Allocated Amt. (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; "Gen. Posting Type"; Option)
        {
            Caption = 'Gen. Posting Type';
            OptionCaption = ' ,Purchase,Sale,Settlement';
            OptionMembers = " ",Purchase,Sale,Settlement;
        }
        field(58; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(59; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(60; "VAT Calculation Type"; Option)
        {
            Caption = 'VAT Calculation Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(61; "EU 3-Party Trade"; Boolean)
        {
            Caption = 'EU 3-Party Trade';
            Editable = false;
        }
        field(62; "Allow Application"; Boolean)
        {
            Caption = 'Allow Application';
            InitValue = true;
        }
        field(63; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(64; "Bal. Gen. Posting Type"; Option)
        {
            Caption = 'Bal. Gen. Posting Type';
            OptionCaption = ' ,Purchase,Sale,Settlement';
            OptionMembers = " ",Purchase,Sale,Settlement;
        }
        field(65; "Bal. Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Bal. Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(66; "Bal. Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Bal. Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(67; "Bal. VAT Calculation Type"; Option)
        {
            Caption = 'Bal. VAT Calculation Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(68; "Bal. VAT %"; Decimal)
        {
            Caption = 'Bal. VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(69; "Bal. VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Bal. VAT Amount';
        }
        field(70; "Bank Payment Type"; Option)
        {
            Caption = 'Bank Payment Type';
            OptionCaption = ' ,Computer Check,Manual Check';
            OptionMembers = " ","Computer Check","Manual Check";
        }
        field(71; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
        }
        field(72; "Bal. VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Bal. VAT Base Amount';
        }
        field(73; Correction; Boolean)
        {
            Caption = 'Correction';
        }
        field(75; "Check Printed"; Boolean)
        {
            Caption = 'Check Printed';
        }
        field(76; "Document Date"; Date)
        {
            Caption = 'Document Date';
            ClosingDates = true;
        }
        field(77; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(78; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = ' ,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = " ",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(79; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = IF ("Source Type" = CONST("Customer")) Customer
            ELSE
            IF ("Source Type" = CONST("Vendor")) Vendor
            ELSE
            IF ("Source Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Source Type" = CONST("Fixed Asset")) "Fixed Asset";
        }
        field(80; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
        }
        field(82; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(83; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(84; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(85; "Use Tax"; Boolean)
        {
            Caption = 'Use Tax';
        }
        field(86; "Bal. Tax Area Code"; Code[20])
        {
            Caption = 'Bal. Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(87; "Bal. Tax Liable"; Boolean)
        {
            Caption = 'Bal. Tax Liable';
        }
        field(88; "Bal. Tax Group Code"; Code[10])
        {
            Caption = 'Bal. Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(89; "Bal. Use Tax"; Boolean)
        {
            Caption = 'Bal. Use Tax';
        }
        field(90; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(91; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(92; "Bal. VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'Bal. VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(93; "Bal. VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'Bal. VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(95; "Additional-Currency Posting"; Option)
        {
            Caption = 'Additional-Currency Posting';
            Editable = false;
            OptionCaption = 'None,Amount Only,Additional-Currency Amount Only';
            OptionMembers = "None","Amount Only","Additional-Currency Amount Only";
        }
        field(98; "FA Add.-Currency Factor"; Decimal)
        {
            Caption = 'FA Add.-Currency Factor';
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }
        field(99; "Source Currency Code"; Code[10])
        {
            Caption = 'Source Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(100; "Source Currency Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Source Currency Amount';
            Editable = false;
        }
        field(101; "Source Curr. VAT Base Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Source Curr. VAT Base Amount';
            Editable = false;
        }
        field(102; "Source Curr. VAT Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Source Curr. VAT Amount';
            Editable = false;
        }
        field(103; "VAT Base Discount %"; Decimal)
        {
            Caption = 'VAT Base Discount %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(104; "VAT Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'VAT Amount (LCY)';
            Editable = false;
        }
        field(105; "VAT Base Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'VAT Base Amount (LCY)';
            Editable = false;
        }
        field(106; "Bal. VAT Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Bal. VAT Amount (LCY)';
            Editable = false;
        }
        field(107; "Bal. VAT Base Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Bal. VAT Base Amount (LCY)';
            Editable = false;
        }
        field(108; "Reversing Entry"; Boolean)
        {
            Caption = 'Reversing Entry';
            Editable = false;
        }
        field(109; "Allow Zero-Amount Posting"; Boolean)
        {
            Caption = 'Allow Zero-Amount Posting';
            Editable = false;
        }
        field(110; "Ship-to/Order Address Code"; Code[10])
        {
            Caption = 'Ship-to/Order Address Code';
            TableRelation = IF ("Account Type" = CONST("Customer")) "Ship-to Address"."Code" WHERE("Customer No." = FIELD("Bill-to/Pay-to No."))
            ELSE
            IF ("Account Type" = CONST("Vendor")) "Order Address"."Code" WHERE("Vendor No." = FIELD("Bill-to/Pay-to No."))
            ELSE
            IF ("Bal. Account Type" = CONST("Customer")) "Ship-to Address"."Code" WHERE("Customer No." = FIELD("Bill-to/Pay-to No."))
            ELSE
            IF ("Bal. Account Type" = CONST("Vendor")) "Order Address"."Code" WHERE("Vendor No." = FIELD("Bill-to/Pay-to No."));
        }
        field(111; "VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Difference';
            Editable = false;
        }
        field(112; "Bal. VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Bal. VAT Difference';
            Editable = false;
        }
        field(5050; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            TableRelation = Campaign;
        }
        field(5400; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            Editable = false;
        }
        field(5600; "FA Posting Date"; Date)
        {
            Caption = 'FA Posting Date';
        }
        field(5601; "FA Posting Type"; Option)
        {
            Caption = 'FA Posting Type';
            OptionCaption = ' ,Acquisition Cost,Depreciation,Write-Down,Appreciation,Custom 1,Custom 2,Disposal,Maintenance';
            OptionMembers = " ","Acquisition Cost",Depreciation,"Write-Down",Appreciation,"Custom 1","Custom 2",Disposal,Maintenance;
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
        field(5604; "No. of Depreciation Days"; Integer)
        {
            BlankZero = true;
            Caption = 'No. of Depreciation Days';
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
        field(5614; "FA Reclassification Entry"; Boolean)
        {
            Caption = 'FA Reclassification Entry';
        }
        field(5615; "FA Error Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'FA Error Entry No.';
            TableRelation = "FA Ledger Entry";
        }
        field(5616; "Index Entry"; Boolean)
        {
            Caption = 'Index Entry';
        }
        field(5802; "Value Entry No."; Integer)
        {
            Caption = 'Value Entry No.';
            Editable = false;
            TableRelation = "Value Entry";
        }
        field(13701; "Source Curr. Excise Amount"; Decimal)
        {
            Editable = false;
        }
        field(13702; "Source Curr. Tax Amount"; Decimal)
        {
            Editable = false;
        }
        field(13703; "State Code"; Code[10])
        {
        }
        field(13704; "Tax Exemption No."; Text[30])
        {
        }
        field(13706; "Excise Bus. Posting Group"; Code[10])
        {
        }
        field(13707; "Excise Prod. Posting Group"; Code[10])
        {
        }
        field(13708; "Excise Amount"; Decimal)
        {
            Editable = false;
        }
        field(13709; "Excise %"; Decimal)
        {
            Editable = false;
        }
        field(13710; "Excise Calculation Type"; Option)
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
        field(13715; "PLA Type"; Option)
        {
            OptionCaption = ' ,BED Amount,AED Amount,SED Amount,SAED Amount,CESS Amount,NCCD Amount,Duty4 Amount';
            OptionMembers = " ","BED Amount","AED Amount","SED Amount","SAED Amount","CESS Amount","NCCD Amount","Duty4 Amount";
        }
        field(13716; "TDS Amount"; Decimal)
        {
            Editable = false;
        }
        field(13717; "Service Tax"; Decimal)
        {
        }
        field(13718; "Tax Amount"; Decimal)
        {
            DecimalPlaces = 0 : 4;
        }
        field(13719; "Excise Accounting Type"; Option)
        {
            OptionCaption = 'With CENVAT,Without CENVAT';
            OptionMembers = "With CENVAT","Without CENVAT";
        }
        field(13720; "Indirect Costs Amount"; Decimal)
        {
            Editable = false;
        }
        field(13721; "PLA eCess Amount"; Decimal)
        {
            Caption = 'PLA eCess Amount';
        }
        field(13722; "RG 23 A PART II eCess Amount"; Decimal)
        {
            Caption = 'RG 23 A PART II eCess Amount';
        }
        field(13723; "RG 23 C PART II eCess Amount"; Decimal)
        {
            Caption = 'RG 23 C PART II eCess Amount';
        }
        field(13726; "PLA SAED Amount"; Decimal)
        {
            Caption = 'PLA SAED Amount';
        }
        field(13727; "RG 23 A PART II SAED Amount"; Decimal)
        {
            Caption = 'RG 23 A PART II SAED Amount';
        }
        field(13728; "RG 23 C PART II SAED Amount"; Decimal)
        {
            Caption = 'RG 23 C PART II SAED Amount';
        }
        field(13729; "PLA CESS Amount"; Decimal)
        {
            Caption = 'PLA CESS Amount';
        }
        field(13730; "RG 23 A PART II CESS Amount"; Decimal)
        {
            Caption = 'RG 23 A PART II CESS Amount';
        }
        field(13731; "RG 23 C PART II CESS Amount"; Decimal)
        {
            Caption = 'RG 23 C PART II CESS Amount';
        }
        field(13732; "PLA NCCD Amount"; Decimal)
        {
            Caption = 'PLA NCCD Amount';
        }
        field(13733; "RG 23 A PART II NCCD Amount"; Decimal)
        {
            Caption = 'RG 23 A PART II NCCD Amount';
        }
        field(13734; "RG 23 C PART II NCCD Amount"; Decimal)
        {
            Caption = 'RG 23 C PART II NCCD Amount';
        }
        field(13736; PLA; Boolean)
        {
        }
        field(13737; "Tax %"; Decimal)
        {
        }
        field(13740; "Export Document"; Boolean)
        {
        }
        field(13741; "Import Document"; Boolean)
        {
        }
        field(13744; "Tax Base Amount"; Decimal)
        {
        }
        field(13746; Cenvat; Boolean)
        {
        }
        field(13747; "Location Code"; Code[20])
        {
        }
        field(13750; "Source Curr. TAX Base Amount"; Decimal)
        {
            Editable = false;
        }
        field(13753; "Tax Amount (LCY)"; Decimal)
        {
        }
        field(13754; "Tax Base Amount (LCY)"; Decimal)
        {
        }
        field(13758; "TDS Nature of Deduction"; Code[10])
        {
            // TableRelation = "TDS Nature of Deduction"; //16225 Table N/F
        }
        field(13759; "TDS Assessee Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Assessee Code";
        }
        field(13760; "TDS %"; Decimal)
        {
            Editable = false;
        }
        field(13761; "TDS Amount Including Surcharge"; Decimal)
        {
            Editable = false;
        }
        field(13763; "Bal. TDS Including eCESS"; Decimal)
        {
            Caption = 'Bal. TDS Including eCESS';
            Editable = false;
        }
        field(13764; "TDS Party Type"; Option)
        {
            BlankNumbers = DontBlank;
            InitValue = " ";
            OptionCaption = ' ,Party,Customer,Vendor';
            OptionMembers = " ",Party,Customer,Vendor;
        }
        field(13765; "TDS Party"; Code[20])
        {
            TableRelation = IF ("TDS Party Type" = CONST("Party")) Party
            ELSE
            IF ("TDS Party Type" = CONST(Customer)) Customer
            ELSE
            IF ("TDS Party Type" = CONST(Vendor)) Vendor;
        }
        field(13766; "BED Amount"; Decimal)
        {
            Caption = 'BED Amount';
        }
        field(13767; "AED(GSI) Amount"; Decimal)
        {
            Caption = 'AED(GSI) Amount';
        }
        field(13768; "SED Amount"; Decimal)
        {
            Caption = 'SED Amount';
        }
        field(13769; "SAED Amount"; Decimal)
        {
            Caption = 'SAED Amount';
        }
        field(13770; "CESS Amount"; Decimal)
        {
            Caption = 'CESS Amount';
        }
        field(13771; "NCCD Amount"; Decimal)
        {
            Caption = 'NCCD Amount';
        }
        field(13772; "eCess Amount"; Decimal)
        {
            Caption = 'eCess Amount';
        }
        field(13773; "Form Code"; Code[10])
        {
            // TableRelation = "Form Codes"; //16225 table N/F
        }
        field(13774; "Form No."; Code[10])
        {
            //  TableRelation = "Tax Forms Details"; //16225 Table N/F
        }
        field(13775; "India Tax 1"; Decimal)
        {
        }
        field(13776; "India Tax 2"; Decimal)
        {
        }
        field(13777; "India Tax 3"; Decimal)
        {
        }
        field(13778; "India Tax 4"; Decimal)
        {
        }
        field(13779; "LC No."; Code[20])
        {
            //16225 Tabble N/F LC Detail"
            /*TableRelation = "LC Detail"."No." WHERE (Closed=CONST(false),
                                                   Released=CONST(true));*/
        }
        field(13780; "Work Tax Base Amount"; Decimal)
        {
            Editable = true;
        }
        field(13781; "Work Tax %"; Decimal)
        {
            Editable = false;
        }
        field(13782; "Work Tax Amount"; Decimal)
        {
            Editable = false;
        }
        field(13786; "TDS Category"; Option)
        {
            OptionCaption = ' ,A,C,S';
            OptionMembers = " ",A,C,S;
        }
        field(13787; "Surcharge %"; Decimal)
        {
            Editable = false;
        }
        field(13788; "Surcharge Amount"; Decimal)
        {
            Editable = false;
        }
        field(13789; "Concessional Rate"; Code[10])
        {
            Editable = false;
            //TableRelation = "Concessional Codes";
        }
        field(13790; "Work Tax Paid"; Boolean)
        {
            Editable = false;
        }
        field(13791; "PLA AED(GSI) Amount"; Decimal)
        {
            Caption = 'PLA AED(GSI) Amount';
        }
        field(13792; "RG 23A PART II AED(GSI) Amount"; Decimal)
        {
            Caption = 'RG 23 A PART II AED Amount';
        }
        field(13793; "RG 23C PART II AED(GSI) Amount"; Decimal)
        {
            Caption = 'RG 23 C PART II AED Amount';
        }
        field(13794; "PLA BED Amount"; Decimal)
        {
            Caption = 'PLA BED Amount';
        }
        field(13795; "RG 23 A PART II BED Amount"; Decimal)
        {
            Caption = 'RG 23 A PART II BED Amount';
        }
        field(13796; "RG 23 C PART II BED Amount"; Decimal)
        {
            Caption = 'RG 23 C PART II BED Amount';
        }
        field(13797; "PLA SED Amount"; Decimal)
        {
            Caption = 'PLA SED Amount';
        }
        field(13798; "RG 23 A PART II SED Amount"; Decimal)
        {
            Caption = 'RG 23 A PART II SED Amount';
        }
        field(13799; "RG 23 C PART II SED Amount"; Decimal)
        {
            Caption = 'RG 23 C PART II SED Amount';
        }
        field(16301; "Pay TDS"; Boolean)
        {
            Editable = false;
        }
        field(16302; "Pay Work Tax"; Boolean)
        {
            Editable = false;
        }
        field(16303; "TDS Entry"; Boolean)
        {
        }
        field(16304; "Pay Excise"; Boolean)
        {
        }
        field(16305; "TDS % Applied"; Decimal)
        {
        }
        field(16306; "TDS Invoice No."; Code[20])
        {
            Editable = false;
        }
        field(16307; "TDS Base Amount"; Decimal)
        {
            Editable = false;
        }
        field(16308; "Challan No."; Code[20])
        {
        }
        field(16309; "Challan Date"; Date)
        {
        }
        field(16310; Adjustment; Boolean)
        {
            Editable = false;
        }
        field(16311; "TDS Transaction No."; Integer)
        {
            Editable = false;
        }
        field(16312; "Pay Sales Tax"; Boolean)
        {
            Editable = false;
        }
        field(16313; "E.C.C. No."; Code[20])
        {
            // TableRelation = "E.C.C. Nos."; //16225 Table N/F
        }
        field(16340; "Balance Work Tax Amount"; Decimal)
        {
            Editable = false;
        }
        field(16350; "Pay VAT"; Boolean)
        {
        }
        field(16351; "VAT Claim Amount"; Decimal)
        {

            trigger OnValidate()
            var
            //  VATValidation: Codeunit 16350; //16225 codeunit N/F
            begin
            end;
        }
        field(16352; "Refund VAT"; Boolean)
        {
        }
        field(16353; "Balance Surcharge Amount"; Decimal)
        {
            Editable = false;
        }
        field(16354; "Cheque Date"; Date)
        {
        }
        field(16355; "Issuing Bank"; Text[30])
        {
        }
        field(16357; "Surcharge % Applied"; Decimal)
        {

            trigger OnValidate()
            var
                BalanceTDS: Decimal;
                BalanceTDSInclSurcharge: Decimal;
            begin
            end;
        }
        field(16358; "Surcharge Base Amount"; Decimal)
        {
            Editable = false;
        }
        field(16359; "TDS Group"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Contractor,Commission,Professional,Interest,Rent,Dividend,Interest on Securities,Lotteries,Insurance Commission,NSS,Mutual fund,Brokerage,Income from Units,Capital Assets,Horse Races,Sports Association,Payable to Non Residents,Income of Mutual Funds,Units,Foreign Currency Bonds,FII from Securities,Others';
            OptionMembers = " ",Contractor,Commission,Professional,Interest,Rent,Dividend,"Interest on Securities",Lotteries,"Insurance Commission",NSS,"Mutual fund",Brokerage,"Income from Units","Capital Assets","Horse Races","Sports Association","Payable to Non Residents","Income of Mutual Funds",Units,"Foreign Currency Bonds","FII from Securities",Others;
        }
        field(16360; "Work Tax Nature Of Deduction"; Code[10])
        {
            //  TableRelation = "TDS Nature of Deduction"; //16225 table N/F
        }
        field(16361; "Work Tax Group"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Contractor,Commission,Professional,Interest,Rent,Dividend,Interest on Securities,Lotteries,Insurance Commission,NSS,Mutual fund,Brokerage,Income from Units,Capital Assets,Horse Races,Sports Association,Payable to Non Residents,Income of Mutual Funds,Units,Foreign Currency Bonds,FII from Securities,Others';
            OptionMembers = " ",Contractor,Commission,Professional,Interest,Rent,Dividend,"Interest on Securities",Lotteries,"Insurance Commission",NSS,"Mutual fund",Brokerage,"Income from Units","Capital Assets","Horse Races","Sports Association","Payable to Non Residents","Income of Mutual Funds",Units,"Foreign Currency Bonds","FII from Securities",Others;
        }
        field(16362; "Balance TDS Amount"; Decimal)
        {
            Editable = false;
        }
        field(16363; "Temp TDS Base"; Decimal)
        {
        }
        field(16364; "Excise Posting"; Boolean)
        {
        }
        field(16365; "Product Type"; Option)
        {
            OptionCaption = ',Item,FA';
            OptionMembers = ,Item,FA;
        }
        field(16366; "Excise Charge"; Boolean)
        {
            Caption = 'Excise Charge';
        }
        field(16367; "Excise Charge Amount"; Decimal)
        {
            Caption = 'Excise Charge Amount';
        }
        field(16368; "PLA Excise Charge Amount"; Decimal)
        {
            Caption = 'PLA Excise Charge Amount';
        }
        field(16369; "Excise Record"; Option)
        {
            BlankZero = true;
            Caption = 'Excise Record';
            OptionCaption = ' ,RG23A,RG23C';
            OptionMembers = " ",RG23A,RG23C;
        }
        field(16370; "Deferred Claim FA Excise"; Boolean)
        {
            Editable = false;
        }
        field(16371; JV; Boolean)
        {
        }
        field(16372; "Cheque No."; Code[10])
        {
        }
        field(16373; "DDB No."; Code[20])
        {
        }
        field(16374; Deferred; Boolean)
        {
        }
        field(16375; "Service Tax Type"; Option)
        {
            Caption = 'Service Tax Type';
            OptionCaption = 'Sale,Purchase,Charge';
            OptionMembers = Sale,Purchase,Charge;
        }
        field(16376; "Service Tax Group Code"; Code[20])
        {
            Caption = 'Service Tax Group Code';
            // TableRelation = "Service Tax Groups".Code;
        }
        field(16377; "STN No."; Code[20])
        {
            Caption = 'Service Tax Reg. No.';
            //  TableRelation = "Service Tax Registration Nos.".Code;
        }
        field(16378; "Service Tax Base Amount"; Decimal)
        {
            Caption = 'Service Tax Base Amount';
            Editable = false;
        }
        field(16379; "Service Tax Amount"; Decimal)
        {
            Caption = 'Service Tax Amount';
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(16380; "Service Tax %"; Decimal)
        {
            Caption = 'Service Tax %';
            Editable = false;
        }
        field(16381; "Service Tax Abetment"; Decimal)
        {
            Caption = 'Service Tax Abetment';
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(16382; "Service Tax Entry"; Boolean)
        {
            Caption = 'Service Tax Entry';
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
        field(16386; "eCESS Base Amount"; Decimal)
        {
        }
        field(16387; "eCESS % Applied"; Decimal)
        {

            trigger OnValidate()
            var
                BalanceTDS: Decimal;
                BalanceSurcharge: Decimal;
            begin
            end;
        }
        field(16388; "Balance eCESS on TDS Amount"; Decimal)
        {
        }
        field(16389; "Per Contract"; Boolean)
        {
        }
        field(16390; "Capital Item"; Boolean)
        {
            Caption = 'Capital Item';
        }
        field(16391; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(16405; "Service Tax eCess %"; Decimal)
        {
            Caption = 'Service Tax eCess %';
            DecimalPlaces = 0 : 2;
        }
        field(16406; "Service Tax eCess Amount"; Decimal)
        {
            Caption = 'Service Tax eCess Amount';
            DecimalPlaces = 0 : 2;
        }
        field(16452; "ADET Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'ADET Amount';
        }
        field(16453; "PLA ADET Amount"; Decimal)
        {
            Caption = 'PLA ADET Amount';
        }
        field(16454; "RG 23 A Part II ADET Amount"; Decimal)
        {
            Caption = 'RG 23 A Part II ADET Amount';
        }
        field(16455; "RG 23 C Part II ADET Amount"; Decimal)
        {
            Caption = 'RG 23 C Part II ADET Amount';
        }
        field(16456; "AED(TTA) Amount"; Decimal)
        {
            Caption = 'AED(TTA) Amount';
        }
        field(16457; "PLA AED(TTA) Amount"; Decimal)
        {
            Caption = 'PLA AED(TTA) Amount';
        }
        field(16458; "RG 23A PART II AED(TTA) Amount"; Decimal)
        {
            Caption = 'RG 23A PART II AED(TTA) Amount';
        }
        field(16459; "RG 23C PART II AED(TTA) Amount"; Decimal)
        {
            Caption = 'RG 23C PART II AED(TTA) Amount';
        }
        field(16460; "Goes to Excise Entry"; Boolean)
        {

            trigger OnValidate()
            var
                ErrText: Label 'The General Journal Line must have Service Tax Component';
                CompanyInfo: Record "Company Information";
            begin
            end;
        }
        field(16461; "From Excise"; Boolean)
        {
            Caption = 'From Excise';
        }
        field(16462; "RG 23 A ST BED Amount"; Decimal)
        {
            Description = 'Service Tax as Excise Credit - for Pay Excise';
        }
        field(16463; "RG 23 A ST AED(GSI) Amount"; Decimal)
        {
        }
        field(16464; "RG 23 A ST AED(TTA) Amount"; Decimal)
        {
        }
        field(16465; "RG 23 A ST SED Amount"; Decimal)
        {
        }
        field(16466; "RG 23 A ST SAED Amount"; Decimal)
        {
        }
        field(16467; "RG 23 A ST NCCD Amount"; Decimal)
        {
        }
        field(16468; "RG 23 A ST eCESS Amount"; Decimal)
        {
        }
        field(16469; "RG 23 C ST BED Amount"; Decimal)
        {
        }
        field(16470; "RG 23 C ST AED(GSI) Amount"; Decimal)
        {
        }
        field(16471; "RG 23 C ST AED(TTA) Amount"; Decimal)
        {
        }
        field(16472; "RG 23 C ST SED Amount"; Decimal)
        {
        }
        field(16473; "RG 23 C ST SAED Amount"; Decimal)
        {
        }
        field(16474; "RG 23 C ST NCCD Amount"; Decimal)
        {
        }
        field(16475; "RG 23 C ST eCESS Amount"; Decimal)
        {
        }
        field(16476; "RG 23 A ST ADET Amount"; Decimal)
        {
        }
        field(16477; "RG 23 C ST ADET Amount"; Decimal)
        {
        }
        field(16478; "T.A.N. No."; Code[10])
        {
            //TableRelation = "T.A.N. Nos."; //16225 table N/F
        }
        field(16479; "ADE Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'ADE Amount';
        }
        field(16480; "PLA ADE Amount"; Decimal)
        {
            Caption = 'PLA ADE Amount';
        }
        field(16481; "RG 23 A Part II ADE Amount"; Decimal)
        {
            Caption = 'RG 23 A Part II ADE Amount';
        }
        field(16482; "RG 23 C Part II ADE Amount"; Decimal)
        {
            Caption = 'RG 23 C Part II ADE Amount';
        }
        field(16483; "RG 23 A ST ADE Amount"; Decimal)
        {
        }
        field(16484; "RG 23 C ST ADE Amount"; Decimal)
        {
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
        field(50000; Description2; Text[200])
        {
            Description = 'Tri PG 29.11.2006 Field Length Change From 200 -> 50';
        }
        field(50001; "VAT Type"; Option)
        {
            OptionCaption = ' ,Item,Capital Goods';
            OptionMembers = " ",Item,"Capital Goods";
        }
        field(50002; "Charges Amount"; Decimal)
        {
        }
        field(50003; abedment; Boolean)
        {
        }
        field(50004; MRP; Decimal)
        {
        }
        field(50043; "Dealer Code"; Code[20])
        {
            Description = 'ND';
            TableRelation = "Salesperson/Purchaser".Code WHERE("Customer No." = FILTER(<> ''));
        }
        field(50044; "Dealer's Salesperson Code"; Code[20])
        {
            Description = 'ND';
            TableRelation = "Salesperson/Purchaser".Code WHERE("Customer No." = FILTER(= ''));
        }
        field(50045; "BSR Code"; Code[7])
        {
            Description = 'Rakesh-to post in TDS entry table';
        }
        field(50046; "Balance OK"; Boolean)
        {
            Description = 'TriPG 10112006 -- For Batch -- Test Gen. Line Balance';
        }
        field(50047; Reversal; Boolean)
        {
            Description = 'TRI VS';
        }
        field(50048; "Entry No. 3.7"; Integer)
        {
        }
        field(50049; "Closed By Entry No. 3.7"; Integer)
        {
        }
        field(50050; "Closed By Amount 3.7"; Decimal)
        {
        }
        field(50051; "G/L Account Name"; Text[30])
        {
            CalcFormula = Lookup("G/L Account"."Name" WHERE("No." = FIELD("Account No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50052; "G/L Bal. Account Name"; Text[30])
        {
            CalcFormula = Lookup("G/L Account"."Name" WHERE("No." = FIELD("Bal. Account No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60000; "Update Posting Status"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
            SumIndexFields = "Balance (LCY)";
        }
        key(Key2; "Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.")
        {
        }
        key(Key3; "Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.")
        {
        }
        key(Key4; "Journal Template Name", "Journal Batch Name", "Posting Date", "Cheque No.")
        {
        }
        key(Key5; "Document No.")
        {
        }
    }

    fieldgroups
    {
    }
}

