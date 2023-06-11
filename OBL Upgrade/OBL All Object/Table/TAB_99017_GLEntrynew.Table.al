table 99017 "G/L Entry new"
{
    Caption = 'G/L Entry';
    DrillDownPageID = "General Ledger Entries";
    LookupPageID = "General Ledger Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            TableRelation = "G/L Account";
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            ClosingDates = true;
        }
        field(5; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,Posting,FullFinal,Reimbursement';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,Posting,FullFinal,Reimbursement;
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(7; Description; Text[200])
        {
            Caption = 'Description';
            Description = '';
        }
        field(10; "Bal. Account No."; Code[20])
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
            IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Bal. Account Type" = CONST("Employee")) Employee;
        }
        field(17; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(27; "User ID"; Code[20])
        {
            Caption = 'User ID';
            //TableRelation = 2000000002; //16225 TABLE N/F
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
                //LoginMgt.LookupUserID("User ID"); //16225 LookupUserID CODEUNIT N/F
            end;
        }
        field(28; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(29; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
        }
        field(30; "Prior-Year Entry"; Boolean)
        {
            Caption = 'Prior-Year Entry';
        }
        field(41; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(42; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(43; "VAT Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'VAT Amount';
        }
        field(45; "Business Unit Code"; Code[10])
        {
            Caption = 'Business Unit Code';
            TableRelation = "Business Unit";
        }
        field(46; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
        }
        field(47; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(48; "Gen. Posting Type"; Option)
        {
            Caption = 'Gen. Posting Type';
            OptionCaption = ' ,Purchase,Sale,Settlement,Payroll';
            OptionMembers = " ",Purchase,Sale,Settlement,Payroll;
        }
        field(49; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            //16225 TABLE N/F 33000072
            /*TableRelation = IF ("Gen. Posting Type"=FILTER(<>Payroll)) "Gen. Business Posting Group"
                            ELSE IF ("Gen. Posting Type"=FILTER(Payroll)) Table33000072;*/
        }
        field(50; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            //16225 TABLE N/F 33000073
            /*TableRelation = IF ("Gen. Posting Type"=FILTER(<>Payroll)) "Gen. Product Posting Group"
                            ELSE IF ("Gen. Posting Type"=FILTER(Payroll)) Table33000073*/
            ;
        }
        field(51; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset",Employee;
        }
        field(52; "Transaction No."; Integer)
        {
            Caption = 'Transaction No.';
        }
        field(53; "Debit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Debit Amount';
        }
        field(54; "Credit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Credit Amount';
        }
        field(55; "Document Date"; Date)
        {
            Caption = 'Document Date';
            ClosingDates = true;
        }
        field(56; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(57; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = ' ,Customer,Vendor,Bank Account,Fixed Asset,Employee';
            OptionMembers = " ",Customer,Vendor,"Bank Account","Fixed Asset",Employee;
        }
        field(58; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = IF ("Source Type" = CONST("Customer")) Customer
            ELSE
            IF ("Source Type" = CONST("Vendor")) Vendor
            ELSE
            IF ("Source Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Source Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Source Type" = CONST("Employee")) Employee;
        }
        field(59; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(60; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(61; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(62; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(63; "Use Tax"; Boolean)
        {
            Caption = 'Use Tax';
        }
        field(64; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(65; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(68; "Additional-Currency Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Additional-Currency Amount';
        }
        field(69; "Add.-Currency Debit Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Add.-Currency Debit Amount';
        }
        field(70; "Add.-Currency Credit Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Add.-Currency Credit Amount';
        }
        field(71; "Close Income Statement Dim. ID"; Integer)
        {
            Caption = 'Close Income Statement Dim. ID';
        }
        field(5400; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
        }
        field(5600; "FA Entry Type"; Option)
        {
            Caption = 'FA Entry Type';
            OptionCaption = ' ,Fixed Asset,Maintenance';
            OptionMembers = " ","Fixed Asset",Maintenance;
        }
        field(5601; "FA Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'FA Entry No.';
            TableRelation = IF ("FA Entry Type" = CONST("Fixed Asset")) "FA Ledger Entry"
            ELSE
            IF ("FA Entry Type" = CONST(Maintenance)) "Maintenance Ledger Entry";
        }
        field(5802; "Value Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Value Entry No.';
            TableRelation = "Value Entry";
        }
        field(13702; "Tax Amount"; Decimal)
        {
        }
        field(13707; "Amount Including Excise"; Decimal)
        {
        }
        field(13708; "TDS Nature of Deduction"; Code[10])
        {
            // TableRelation = "TDS Nature of Deduction".Code;//16225 TABLE N/F
        }
        field(13709; "TDS Assessee Code"; Code[10])
        {
            TableRelation = "Assessee Code";
        }
        field(13710; "Party Type"; Option)
        {
            OptionCaption = ' ,Party,Customer,Vendor';
            OptionMembers = " ",Party,Customer,Vendor;
        }
        field(13711; Party; Code[20])
        {
        }
        field(16354; "Cheque Date"; Date)
        {
        }
        field(16355; "Issuing Bank"; Text[30])
        {
        }
        field(16356; Month; Integer)
        {
        }
        field(16357; Year; Integer)
        {
        }
        field(16372; "Cheque No."; Code[10])
        {
        }
        field(16373; "DDB No."; Code[20])
        {
            Description = 'EXIM';
        }
        field(50001; Description2; Text[200])
        {
        }
        field(50002; FYear; Integer)
        {
        }
        field(50003; total; Decimal)
        {
            CalcFormula = Sum("G/L Entry new".Amount);
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "G/L Account No.", "Posting Date")
        {
            SumIndexFields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";
        }
        key(Key3; "G/L Account No.", "Business Unit Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Close Income Statement Dim. ID", "Posting Date")
        {
            SumIndexFields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";
        }
        key(Key4; "Document No.", "Posting Date")
        {
        }
        key(Key5; "Transaction No.")
        {
        }
        key(Key6; "Close Income Statement Dim. ID")
        {
        }
        key(Key7; "Posting Date", "Source Type", "Source No.", "TDS Nature of Deduction", "TDS Assessee Code", "System-Created Entry")
        {
            SumIndexFields = Amount;
        }
        key(Key8; "Posting Date", "Party Type", Party, "TDS Nature of Deduction", "TDS Assessee Code")
        {
            SumIndexFields = Amount;
        }
        key(Key9; Year, Month, "Posting Date", "Bal. Account No.")
        {
        }
        key(Key10; "G/L Account No.", Year, Month, "Posting Date", "Transaction No.")
        {
        }
        key(Key11; "Global Dimension 1 Code")
        {
        }
        key(Key12; "G/L Account No.", "Source Code")
        {
            SumIndexFields = Amount;
        }
        key(Key13; "Document No.", "Source Code")
        {
        }
        key(Key14; "System-Created Entry", "G/L Account No.", "Document No.", "Posting Date")
        {
            SumIndexFields = Amount;
        }
        key(Key15; "Document No.", "G/L Account No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        GLSetup: Record "General Ledger Setup";
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

