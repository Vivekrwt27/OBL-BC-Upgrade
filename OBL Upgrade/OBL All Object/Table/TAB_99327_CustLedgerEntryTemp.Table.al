table 99327 "Cust. Ledger Entry Temp"
{
    Caption = 'Cust. Ledger Entry';
    DrillDownPageID = "Customer Ledger Entries";
    LookupPageID = "Customer Ledger Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(11; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(13; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount" WHERE("Cust. Ledger Entry No." = FIELD("Entry No."),
                                                                         "Entry Type" = FILTER("Initial Entry" | "Unrealized Loss" | "Unrealized Gain" | "Realized Loss" | "Realized Gain" | "Payment Discount" | 'Payment Discount (VAT Excl.)' | 'Payment Discount (VAT Adjustment)' | "Payment Tolerance" | "Payment Discount Tolerance" | 'Payment Tolerance (VAT Excl.)' | 'Payment Tolerance (VAT Adjustment)' | 'Payment Discount Tolerance (VAT Excl.)' | 'Payment Discount Tolerance (VAT Adjustment)'),
                                                                         "Posting Date" = FIELD("Date Filter")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Remaining Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount" WHERE("Cust. Ledger Entry No." = FIELD("Entry No."),
                                                                         "Posting Date" = FIELD("Date Filter")));
            Caption = 'Remaining Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Original Amt. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Cust. Ledger Entry No." = FIELD("Entry No."),
                                                                                 "Entry Type" = FILTER("Initial Entry"),
                                                                                 "Posting Date" = FIELD("Date Filter")));
            Caption = 'Original Amt. (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Remaining Amt. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Cust. Ledger Entry No." = FIELD("Entry No."),
                                                                                 "Posting Date" = FIELD("Date Filter")));
            Caption = 'Remaining Amt. (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Cust. Ledger Entry No." = FIELD("Entry No."),
                                                                                 "Entry Type" = FILTER("Initial Entry" | "Unrealized Loss" | "Unrealized Gain" | "Realized Loss" | "Realized Gain" | "Payment Discount" | "Payment Discount (VAT Excl.)" | "Payment Discount (VAT Adjustment)" | "Payment Tolerance" | "Payment Discount Tolerance" | "Payment Tolerance (VAT Excl.)" | "Payment Tolerance (VAT Adjustment)" | "Payment Discount Tolerance (VAT Excl.)" | "Payment Discount Tolerance (VAT Adjustment)"),
                                                                                 "Posting Date" = FIELD("Date Filter")));
            Caption = 'Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Sales (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Sales (LCY)';
        }
        field(19; "Profit (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Profit (LCY)';
        }
        field(20; "Inv. Discount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Inv. Discount (LCY)';
        }
        field(21; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;
        }
        field(22; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group";
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
        field(25; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(27; "User ID"; Code[20])
        {
            Caption = 'User ID';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
                //LoginMgt.LookupUserID("User ID"); //16225 LookupUserID N/F User Management Codeunit
            end;
        }
        field(28; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(33; "On Hold"; Code[3])
        {
            Caption = 'On Hold';
        }
        field(34; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(35; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
        }
        field(36; Open; Boolean)
        {
            Caption = 'Open';
        }
        field(37; "Due Date"; Date)
        {
            Caption = 'Due Date';

            trigger OnValidate()
            var
                ReminderEntry: Record "Reminder/Fin. Charge Entry";
                ReminderIssue: Codeunit "Reminder-Issue";
            begin
                TESTFIELD(Open, TRUE);
                IF "Due Date" <> xRec."Due Date" THEN BEGIN
                    ReminderEntry.SETCURRENTKEY("Customer Entry No.", "Type");
                    ReminderEntry.SETRANGE("Customer Entry No.", "Entry No.");
                    ReminderEntry.SETRANGE(Type, ReminderEntry.Type::Reminder);
                    ReminderEntry.SETRANGE("Reminder Level", "Last Issued Reminder Level");
                    IF ReminderEntry.FINDLAST THEN
                        ReminderIssue.ChangeDueDate(ReminderEntry, "Due Date", xRec."Due Date");
                END;
            end;
        }
        field(38; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';

            trigger OnValidate()
            begin
                TESTFIELD(Open, TRUE);
            end;
        }
        field(39; "Original Pmt. Disc. Possible"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Original Pmt. Disc. Possible';
            Editable = false;
        }
        field(40; "Pmt. Disc. Given (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Pmt. Disc. Given (LCY)';
        }
        field(43; Positive; Boolean)
        {
            Caption = 'Positive';
        }
        field(44; "Closed by Entry No."; Integer)
        {
            Caption = 'Closed by Entry No.';
            TableRelation = "Cust. Ledger Entry";
        }
        field(45; "Closed at Date"; Date)
        {
            Caption = 'Closed at Date';
        }
        field(46; "Closed by Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Closed by Amount';
        }
        field(47; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';

            trigger OnValidate()
            begin
                TESTFIELD(Open, TRUE);
            end;
        }
        field(49; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
        }
        field(50; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(51; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(52; "Bal. Account No."; Code[20])
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
        }
        field(53; "Transaction No."; Integer)
        {
            Caption = 'Transaction No.';
        }
        field(54; "Closed by Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Closed by Amount (LCY)';
        }
        field(58; "Debit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Debit Amount" WHERE("Cust. Ledger Entry No." = FIELD("Entry No."),
                                                                                 "Entry Type" = FILTER(<> "Application"),
                                                                                 "Posting Date" = FIELD("Date Filter")));
            Caption = 'Debit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Credit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Credit Amount" WHERE("Cust. Ledger Entry No." = FIELD("Entry No."),
                                                                                  "Entry Type" = FILTER(<> "Application"),
                                                                                  "Posting Date" = FIELD("Date Filter")));
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Debit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Debit Amount (LCY)" WHERE("Cust. Ledger Entry No." = FIELD("Entry No."),
                                                                                       "Entry Type" = FILTER(<> "Application"),
                                                                                       "Posting Date" = FIELD("Date Filter")));
            Caption = 'Debit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Credit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Credit Amount (LCY)" WHERE("Cust. Ledger Entry No." = FIELD("Entry No."),
                                                                                        "Entry Type" = FILTER(<> "Application"),
                                                                                        "Posting Date" = FIELD("Date Filter")));
            Caption = 'Credit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(63; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(64; "Calculate Interest"; Boolean)
        {
            Caption = 'Calculate Interest';
        }
        field(65; "Closing Interest Calculated"; Boolean)
        {
            Caption = 'Closing Interest Calculated';
        }
        field(66; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(67; "Closed by Currency Code"; Code[10])
        {
            Caption = 'Closed by Currency Code';
            TableRelation = Currency;
        }
        field(68; "Closed by Currency Amount"; Decimal)
        {
            AutoFormatExpression = "Closed by Currency Code";
            AutoFormatType = 1;
            Caption = 'Closed by Currency Amount';
        }
        field(73; "Adjusted Currency Factor"; Decimal)
        {
            Caption = 'Adjusted Currency Factor';
            DecimalPlaces = 0 : 15;
        }
        field(74; "Original Currency Factor"; Decimal)
        {
            Caption = 'Original Currency Factor';
            DecimalPlaces = 0 : 15;
        }
        field(75; "Original Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Cust. Ledger Entry No." = FIELD("Entry No."),
                                                                         "Entry Type" = FILTER("Initial Entry"),
                                                                         "Posting Date" = FIELD("Date Filter")));
            Caption = 'Original Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(76; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(77; "Remaining Pmt. Disc. Possible"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Remaining Pmt. Disc. Possible';

            trigger OnValidate()
            begin
                TESTFIELD(Open, TRUE);
                CALCFIELDS(Amount, "Original Amount");

                IF "Remaining Pmt. Disc. Possible" * Amount < 0 THEN
                    FIELDERROR("Remaining Pmt. Disc. Possible", STRSUBSTNO(Text000, FIELDCAPTION(Amount)));

                IF ABS("Remaining Pmt. Disc. Possible") > ABS("Original Amount") THEN
                    FIELDERROR("Remaining Pmt. Disc. Possible", STRSUBSTNO(Text001, FIELDCAPTION("Original Amount")));
            end;
        }
        field(78; "Pmt. Disc. Tolerance Date"; Date)
        {
            Caption = 'Pmt. Disc. Tolerance Date';

            trigger OnValidate()
            begin
                TESTFIELD(Open, TRUE);
            end;
        }
        field(79; "Max. Payment Tolerance"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Max. Payment Tolerance';

            trigger OnValidate()
            begin
                TESTFIELD(Open, TRUE);
                CALCFIELDS(Amount, "Remaining Amount");

                IF "Max. Payment Tolerance" * Amount < 0 THEN
                    FIELDERROR("Max. Payment Tolerance", STRSUBSTNO(Text000, FIELDCAPTION(Amount)));

                IF ABS("Max. Payment Tolerance") > ABS("Remaining Amount") THEN
                    FIELDERROR("Max. Payment Tolerance", STRSUBSTNO(Text001, FIELDCAPTION("Remaining Amount")));
            end;
        }
        field(80; "Last Issued Reminder Level"; Integer)
        {
            Caption = 'Last Issued Reminder Level';
        }
        field(81; "Accepted Payment Tolerance"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Accepted Payment Tolerance';
        }
        field(82; "Accepted Pmt. Disc. Tolerance"; Boolean)
        {
            Caption = 'Accepted Pmt. Disc. Tolerance';
        }
        field(83; "Pmt. Tolerance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Pmt. Tolerance (LCY)';
        }
        field(84; "Amount to Apply"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount to Apply';

            trigger OnValidate()
            begin
                TESTFIELD(Open, TRUE);
                CALCFIELDS("Remaining Amount");

                IF "Amount to Apply" * "Remaining Amount" < 0 THEN
                    FIELDERROR("Amount to Apply", STRSUBSTNO(Text000, FIELDCAPTION("Remaining Amount")));

                IF ABS("Amount to Apply") > ABS("Remaining Amount") THEN
                    FIELDERROR("Amount to Apply", STRSUBSTNO(Text001, FIELDCAPTION("Remaining Amount")));
            end;
        }
        field(85; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            TableRelation = "IC Partner";
        }
        field(86; "Applying Entry"; Boolean)
        {
            Caption = 'Applying Entry';
        }
        field(87; Reversed; Boolean)
        {
            BlankZero = true;
            Caption = 'Reversed';
        }
        field(88; "Reversed by Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Reversed by Entry No.';
            TableRelation = "Cust. Ledger Entry";
        }
        field(89; "Reversed Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Reversed Entry No.';
            TableRelation = "Cust. Ledger Entry";
        }
        field(90; Prepayment; Boolean)
        {
            Caption = 'Prepayment';
        }
        field(13702; "TDS Nature of Deduction"; Code[10])
        {
            Caption = 'TDS Nature of Deduction';
            NotBlank = true;
            //TableRelation = "TDS Nature of Deduction"; //16225 Table N/F
        }
        field(13703; "TDS Group"; Option)
        {
            Caption = 'TDS Group';
            Editable = false;
            OptionCaption = ' ,Contractor,Commission,Professional,Interest,Rent,Dividend,Interest on Securities,Lotteries,Insurance Commission,NSS,Mutual fund,Brokerage,Income from Units,Capital Assets,Horse Races,Sports Association,Payable to Non Residents,Income of Mutual Funds,Units,Foreign Currency Bonds,FII from Securities,Others';
            OptionMembers = " ",Contractor,Commission,Professional,Interest,Rent,Dividend,"Interest on Securities",Lotteries,"Insurance Commission",NSS,"Mutual fund",Brokerage,"Income from Units","Capital Assets","Horse Races","Sports Association","Payable to Non Residents","Income of Mutual Funds",Units,"Foreign Currency Bonds","FII from Securities",Others;
        }
        field(13704; "Total TDS/TCS Incl SHE CESS"; Decimal)
        {
            Caption = 'Total TDS/TCS Incl SHE CESS';
        }
        field(16500; "TCS Nature of Collection"; Code[10])
        {
            Caption = 'TCS Nature of Collection';
            TableRelation = "TCS Nature Of Collection";
        }
        field(16501; "TCS Type"; Option)
        {
            Caption = 'TCS Type';
            Editable = false;
            OptionCaption = ' ,A,B,C,D,E,F,G,H,I';
            OptionMembers = " ",A,B,C,D,E,F,G,H,I;
        }
        field(16502; "Serv. Tax on Advance Payment"; Boolean)
        {
            Caption = 'Serv. Tax on Advance Payment';
        }
        field(16503; "TDS Certificate Receivable"; Boolean)
        {
            Caption = 'TDS Certificate Receivable';

            trigger OnValidate()
            begin
                IF "TDS Certificate Receivable" = FALSE THEN
                    IF "TDS Certificate Received" = TRUE THEN
                        ERROR(Text16500);
            end;
        }
        field(16504; "Certificate Received"; Boolean)
        {
            Caption = 'Certificate Received';

            trigger OnValidate()
            begin
                IF "Certificate Received" = FALSE THEN BEGIN
                    "Certificate No." := '';
                    "TDS Certificate Rcpt Date" := 0D;
                    "TDS Certificate Amount" := 0;
                    "Financial Year" := 0;
                    "TDS Receivable Group" := "TDS Receivable Group"::" ";
                END;
            end;
        }
        field(16505; "Certificate No."; Code[20])
        {
            Caption = 'Certificate No.';
        }
        field(16506; "TDS Certificate Rcpt Date"; Date)
        {
            Caption = 'TDS Certificate Rcpt Date';
        }
        field(16507; "TDS Certificate Amount"; Decimal)
        {
            Caption = 'TDS Certificate Amount';
        }
        field(16508; "Financial Year"; Integer)
        {
            Caption = 'Financial Year';
        }
        field(16509; "TDS Receivable Group"; Option)
        {
            Caption = 'TDS Receivable Group';
            OptionCaption = ' ,Contractor,Commission,Professional,Interest,Rent,Dividend,Interest on Securities,Lotteries,Insurance Commission,NSS,Mutual fund,Brokerage,Income from Units,Capital Assets,Horse Races,Sports Association,Payable to Non Residents,Income of Mutual Funds,Units,Foreign Currency Bonds,FII from Securities,Others';
            OptionMembers = " ",Contractor,Commission,Professional,Interest,Rent,Dividend,"Interest on Securities",Lotteries,"Insurance Commission",NSS,"Mutual fund",Brokerage,"Income from Units","Capital Assets","Horse Races","Sports Association","Payable to Non Residents","Income of Mutual Funds",Units,"Foreign Currency Bonds","FII from Securities",Others;
        }
        field(16510; "TDS Certificate Received"; Boolean)
        {
            Caption = 'TDS Certificate Received';

            trigger OnValidate()
            begin
                IF "TDS Certificate Received" AND ("TDS Certificate Receivable" = FALSE) THEN
                    ERROR(Text16501);

                IF "TDS Certificate Received" = FALSE THEN BEGIN
                    "Certificate No." := '';
                    "TDS Certificate Rcpt Date" := 0D;
                    "TDS Certificate Amount" := 0;
                    "Financial Year" := 0;
                    "TDS Receivable Group" := "TDS Receivable Group"::" ";
                    "Certificate Received" := FALSE;
                END;
            end;
        }
        field(50001; Description2; Text[200])
        {
        }
        field(50002; "Cheque No."; Code[10])
        {
        }
        field(50003; "Cheque Date"; Date)
        {
        }
        field(50043; "Dealer Code"; Code[20])
        {
            Description = 'TRI';
            TableRelation = "Salesperson/Purchaser".Code WHERE("Customer No." = FILTER(<> ''));
        }
        field(50044; "Dealer's Salesperson Code"; Code[20])
        {
            Description = 'TRI';
            TableRelation = "Salesperson/Purchaser".Code WHERE("Customer No." = FILTER(= ''));
        }
        field(50045; Month; Integer)
        {
            Description = 'Tri18.1PG For Multi Balancing Option In Customer Ledger';
        }
        field(50046; Year; Integer)
        {
            Description = 'Tri18.1PG For Multi Balancing Option In Customer Ledger';
        }
        field(50047; FYEAR; Integer)
        {
            Description = 'Tri18.1PG For Multi Balancing Option In Customer Ledger';
        }
        field(50048; "Entry No. 3.7"; Integer)
        {
        }
        field(50049; "Closed By Entry No. 3.7"; Integer)
        {
        }
        field(50050; "Closed By Amount 3.7"; Decimal)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Customer No.", "Posting Date", "Currency Code")
        {
            SumIndexFields = "Sales (LCY)", "Profit (LCY)", "Inv. Discount (LCY)";
        }
        key(Key3; "Document No.")
        {
        }
        key(Key4; "External Document No.")
        {
        }
        key(Key5; "Customer No.", Open, Positive, "Due Date", "Currency Code")
        {
        }
        key(Key6; Open, "Due Date")
        {
        }
        key(Key7; "Document Type", "Customer No.", "Posting Date", "Currency Code")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
            SumIndexFields = "Sales (LCY)", "Profit (LCY)", "Inv. Discount (LCY)";
        }
        key(Key8; "Salesperson Code", "Posting Date")
        {
        }
        key(Key9; "Closed by Entry No.")
        {
        }
        key(Key10; "Transaction No.")
        {
        }
        key(Key11; "Customer No.", "Applies-to ID", Open, Positive, "Due Date")
        {
        }
        key(Key12; "Customer No.", "Posting Date")
        {
        }
        key(Key13; "Document No.", "Posting Date", "Transaction No.")
        {
        }
        key(Key14; "Customer No.", "Posting Date", "Serv. Tax on Advance Payment", Open)
        {
        }
        key(Key15; "Customer No.", "TDS Receivable Group", "TDS Certificate Receivable", "Certificate Received")
        {
        }
        key(Key16; "Customer No.", "TDS Receivable Group", "Certificate No.", "TDS Certificate Received")
        {
        }
        key(Key17; "Document No.", "Document Type", "Customer No.")
        {
        }
        key(Key18; "Closed by Entry No.", "Posting Date")
        {
        }
        key(Key19; "Dealer Code", "Dealer's Salesperson Code", "Customer No.")
        {
        }
        key(Key20; "Customer No.", Year, Month, "Posting Date")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", Description, "Customer No.", "Posting Date", "Document Type", "Document No.")
        {
        }
    }

    var
        Text000: Label 'must have the same sign as %1';
        Text001: Label 'must not be larger than %1';
        Text16500: Label 'Please uncheck TDS Certificate Received.';
        Text16501: Label 'TDS Certificate Received cannot be False unless TDS Receivable is False.';

    procedure DrillDownOnEntries(var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry.RESET;
        DtldCustLedgEntry.COPYFILTER("Customer No.", CustLedgEntry."Customer No.");
        DtldCustLedgEntry.COPYFILTER("Currency Code", CustLedgEntry."Currency Code");
        DtldCustLedgEntry.COPYFILTER("Initial Entry Global Dim. 1", CustLedgEntry."Global Dimension 1 Code");
        DtldCustLedgEntry.COPYFILTER("Initial Entry Global Dim. 2", CustLedgEntry."Global Dimension 2 Code");
        CustLedgEntry.SETCURRENTKEY("Customer No.", "Posting Date");
        CustLedgEntry.SETRANGE(Open, TRUE);
        PAGE.RUN(0, CustLedgEntry);
    end;

    procedure DrillDownOnOverdueEntries(var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry.RESET;
        DtldCustLedgEntry.COPYFILTER("Customer No.", CustLedgEntry."Customer No.");
        DtldCustLedgEntry.COPYFILTER("Currency Code", CustLedgEntry."Currency Code");
        DtldCustLedgEntry.COPYFILTER("Initial Entry Global Dim. 1", CustLedgEntry."Global Dimension 1 Code");
        DtldCustLedgEntry.COPYFILTER("Initial Entry Global Dim. 2", CustLedgEntry."Global Dimension 2 Code");
        CustLedgEntry.SETCURRENTKEY("Customer No.", "Posting Date");
        CustLedgEntry.SETFILTER("Date Filter", '..%1', WORKDATE);
        CustLedgEntry.SETFILTER("Due Date", '..%1', WORKDATE);
        CustLedgEntry.SETFILTER("Remaining Amount", '<>%1', 0);
        PAGE.RUN(0, CustLedgEntry);
    end;

    procedure GetOriginalCurrencyFactor(): Decimal
    begin
        IF "Original Currency Factor" = 0 THEN
            EXIT(1);
        EXIT("Original Currency Factor");
    end;
}

