table 70001 "Customer New"
{
    Caption = 'Customer';
    DataCaptionFields = "No.", Name;
    DrillDownPageID = "Customer List";
    LookupPageID = "Customer List";
    Permissions = TableData "Cust. Ledger Entry" = r;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(3; "Search Name"; Code[30])
        {
            Caption = 'Search Name';
        }
        field(4; "Name 2"; Text[30])
        {
            Caption = 'Name 2';
        }
        field(5; Address; Text[30])
        {
            Caption = 'Address';
        }
        field(6; "Address 2"; Text[30])
        {
            Caption = 'Address 2';
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
        }
        field(8; Contact; Text[30])
        {
            Caption = 'Contact';
        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(10; "Telex No."; Text[20])
        {
            Caption = 'Telex No.';
        }
        field(14; "Our Account No."; Text[20])
        {
            Caption = 'Our Account No.';
        }
        field(15; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code';
            TableRelation = Territory;
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(18; "Chain Name"; Code[10])
        {
            Caption = 'Chain Name';
        }
        field(19; "Budgeted Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Budgeted Amount';
        }
        field(20; "Credit Limit (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Credit Limit (LCY)';
        }
        field(21; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group";
        }
        field(22; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(23; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
        field(24; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(26; "Statistics Group"; Integer)
        {
            Caption = 'Statistics Group';
        }
        field(27; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(28; "Fin. Charge Terms Code"; Code[10])
        {
            Caption = 'Fin. Charge Terms Code';
            //TableRelation = "Indent";//16225 TABLE N/F
        }
        field(29; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(30; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(31; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        field(32; "Place of Export"; Code[20])
        {
            Caption = 'Place of Export';
        }
        field(33; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';
            TableRelation = "Cust. Invoice Disc." WHERE(Code = FIELD("Invoice Disc. Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(34; "Customer Disc. Group"; Code[10])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
        }
        field(35; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
        }
        field(36; "Collection Method"; Code[20])
        {
            Caption = 'Collection Method';
        }
        field(37; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(38; Comment; Boolean)
        {
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST(Customer),
                                                     "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; Blocked; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Ship,Invoice,All';
            OptionMembers = " ",Ship,Invoice,All;
        }
        field(40; "Invoice Copies"; Integer)
        {
            Caption = 'Invoice Copies';
        }
        field(41; "Last Statement No."; Integer)
        {
            Caption = 'Last Statement No.';
        }
        field(42; "Print Statements"; Boolean)
        {
            Caption = 'Print Statements';
        }
        field(45; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;
        }
        field(46; Priority; Integer)
        {
            Caption = 'Priority';
        }
        field(47; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(54; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(55; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(56; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(57; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(58; Balance; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("No."),
                                                                         "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                         "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Net Change"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("No."),
                                                                         "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Net Change';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Net Change (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Net Change (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Sales (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Cust. Ledger Entry"."Sales (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                        "Posting Date" = FIELD("Date Filter"),
                                                                        "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Sales (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(63; "Profit (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Cust. Ledger Entry"."Profit (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                        "Posting Date" = FIELD("Date Filter"),
                                                                        "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Profit (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64; "Inv. Discounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Cust. Ledger Entry"."Inv. Discount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                        "Posting Date" = FIELD("Date Filter"),
                                                                        "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Inv. Discounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(65; "Pmt. Discounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Entry Type" = FILTER("Payment Discount" .. 'Payment Discount (VAT Adjustment)'),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Pmt. Discounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(66; "Balance Due"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("No."),
                                                                                 "Entry Type" = FILTER("Payment Discount" .. 'Payment Discount (VAT Adjustment)'),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Balance Due';
            Editable = false;
            FieldClass = FlowField;
        }
        field(67; "Balance Due (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Due Date" = FIELD("Date Filter"),
                                                                                 "Posting Date" = FIELD(UPPERLIMIT("Date Filter")),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Balance Due (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(69; Payments; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Initial Document Type" = CONST(Payment),
                                                                          "Entry Type" = CONST("Initial Entry"),
                                                                          "Customer No." = FIELD("No."),
                                                                          "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                          "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                          "Posting Date" = FIELD("Date Filter"),
                                                                          "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Payments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70; "Invoice Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount" WHERE("Initial Document Type" = CONST(Invoice),
                                                                          "Entry Type" = CONST("Initial Entry"),
                                                                          "Customer No." = FIELD("No."),
                                                                          "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                          "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                          "Posting Date" = FIELD("Date Filter"),
                                                                          "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Invoice Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(71; "Cr. Memo Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Initial Document Type" = CONST("Credit Memo"),
                                                                          "Entry Type" = CONST("Initial Entry"),
                                                                          "Customer No." = FIELD("No."),
                                                                          "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                          "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                          "Posting Date" = FIELD("Date Filter"),
                                                                          "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Cr. Memo Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(72; "Finance Charge Memo Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Initial Document Type" = CONST("Finance Charge Memo"),
                                                                          "Entry Type" = CONST("Initial Entry"),
                                                                          "Customer No." = FIELD("No."),
                                                                          "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                          "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                          "Posting Date" = FIELD("Date Filter"),
                                                                          "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Finance Charge Memo Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(74; "Payments (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST("Payment"),
                                                                                 "Entry Type" = CONST("Initial Entry"),
                                                                                 "Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Payments (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(75; "Inv. Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST(Invoice),
                                                                                 "Entry Type" = CONST("Initial Entry"),
                                                                                 "Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Inv. Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(76; "Cr. Memo Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST("Credit Memo"),
                                                                                 "Entry Type" = CONST("Initial Entry"),
                                                                                 "Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Cr. Memo Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(77; "Fin. Charge Memo Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST("Finance Charge Memo"),
                                                                                 "Entry Type" = CONST("Initial Entry"),
                                                                                 "Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Fin. Charge Memo Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(78; "Outstanding Orders"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Outstanding Amount" WHERE("Document Type" = CONST(Order),
                                                                       "Bill-to Customer No." = FIELD("No."),
                                                                       "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                       "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                       "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Outstanding Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(79; "Shipped Not Invoiced"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Shipped Not Invoiced" WHERE("Document Type" = CONST(Order),
                                                                       "Bill-to Customer No." = FIELD("No."),
                                                                       "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                       "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                       "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Shipped Not Invoiced';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80; "Application Method"; Option)
        {
            Caption = 'Application Method';
            OptionCaption = 'Manual,Apply to Oldest';
            OptionMembers = Manual,"Apply to Oldest";
        }
        field(82; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';
        }
        field(83; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));

            trigger OnValidate()
            var
                "...tri1.0": Integer;
                LocationRec: Record Location;
                GLSetUp: Record "General Ledger Setup";
                DefDim: Record "Default Dimension";
            begin
            end;
        }
        field(84; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(85; "Telex Answer Back"; Text[20])
        {
            Caption = 'Telex Answer Back';
        }
        field(86; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';

            trigger OnValidate()
            var
                VATRegNoFormat: Record "VAT Registration No. Format";
            begin
            end;
        }
        field(87; "Combine Shipments"; Boolean)
        {
            Caption = 'Combine Shipments';
        }
        field(88; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(89; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(91; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(92; County; Text[30])
        {
            Caption = 'County';
        }
        field(97; "Debit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Debit Amount" WHERE("Customer No." = FIELD("No."),
                                                                                 "Entry Type" = FILTER(<> "Application"),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Debit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(98; "Credit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Credit Amount" WHERE("Customer No." = FIELD("No."),
                                                                                 "Entry Type" = FILTER(<> "Application"),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(99; "Debit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Debit Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                      "Entry Type" = FILTER(<> "Application"),
                                                                                      "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                      "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                      "Posting Date" = FIELD("Date Filter"),
                                                                                      "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Debit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(100; "Credit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Credit Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Entry Type" = FILTER(<> "Application"),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Credit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(102; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
        }
        field(103; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
        }
        field(104; "Reminder Terms Code"; Code[10])
        {
            Caption = 'Reminder Terms Code';
            TableRelation = "Reminder Terms";
        }
        field(105; "Reminder Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Initial Document Type" = CONST("Reminder"),
                                                                         "Entry Type" = CONST("Initial Entry"),
                                                                         "Customer No." = FIELD("No."),
                                                                         "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Reminder Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(106; "Reminder Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST("Reminder"),
                                                                                "Entry Type" = CONST("Initial Entry"),
                                                                                "Customer No." = FIELD("No."),
                                                                                "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                "Posting Date" = FIELD("Date Filter"),
                                                                                "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Reminder Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(107; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(108; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(109; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(110; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(111; "Currency Filter"; Code[10])
        {
            Caption = 'Currency Filter';
            FieldClass = FlowFilter;
            TableRelation = Currency;
        }
        field(113; "Outstanding Orders (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Outstanding Amount (LCY)" WHERE("Document Type" = CONST("Order"),
                                                                             "Bill-to Customer No." = FIELD("No."),
                                                                             "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                             "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                             "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Outstanding Orders (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(114; "Shipped Not Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Shipped Not Invoiced (LCY)" WHERE("Document Type" = CONST("Order"),
                                                                             "Bill-to Customer No." = FIELD("No."),
                                                                             "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                             "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                             "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Shipped Not Invoiced (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(115; Reserve; Option)
        {
            Caption = 'Reserve';
            InitValue = Optional;
            OptionCaption = 'Never,Optional,Always';
            OptionMembers = Never,Optional,Always;
        }
        field(116; "Block Payment Tolerance"; Boolean)
        {
            Caption = 'Block Payment Tolerance';
        }
        field(117; "Pmt. Disc. Tolerance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Entry Type" = FILTER('Payment Discount Tolerance' | 'Payment Discount Tolerance (VAT Adjustment)' | 'Payment Discount Tolerance (VAT Excl.)'),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Pmt. Disc. Tolerance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(118; "Pmt. Tolerance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Entry Type" = FILTER('Payment Discount Tolerance' | 'Payment Discount Tolerance (VAT Adjustment)' | 'Payment Discount Tolerance (VAT Excl.)'),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Pmt. Tolerance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5049; "Primary Contact No."; Code[20])
        {
            Caption = 'Primary Contact No.';
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusRel: Record "Contact Business Relation";
            begin
            end;

            trigger OnValidate()
            var
                Cont: Record Contact;
                ContBusRel: Record "Contact Business Relation";
            begin
            end;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(5750; "Shipping Advice"; Option)
        {
            Caption = 'Shipping Advice';
            OptionCaption = 'Partial,Complete';
            OptionMembers = Partial,Complete;
        }
        field(5790; "Shipping Time"; DateFormula)
        {
            Caption = 'Shipping Time';
        }
        field(5792; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
        }
        field(5900; "Service Zone Code"; Code[10])
        {
            Caption = 'Service Zone Code';
            TableRelation = "Service Zone";
        }
        field(5902; "Contract Gain/Loss Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Contract Gain/Loss Entry".Amount WHERE("Customer No." = FIELD("No."),
                                                                       "Ship-to Code" = FIELD("Ship-to Filter"),
                                                                       "Change Date" = FIELD("Date Filter")));
            Caption = 'Contract Gain/Loss Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5903; "Ship-to Filter"; Code[10])
        {
            Caption = 'Ship-to Filter';
            FieldClass = FlowFilter;
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("No."));
        }
        field(6207; "Notification Process Code"; Code[10])
        {
            Caption = 'Notification Process Code';
            //TableRelation = 6221; //16225 table n/f
        }
        field(6209; "Queue Priority"; Option)
        {
            Caption = 'Queue Priority';
            InitValue = Medium;
            OptionCaption = 'Very Low,,Low,Medium,High,,,Very High';
            OptionMembers = "Very Low",,Low,Medium,High,,,"Very High";
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
            InitValue = true;
        }
        field(7600; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            TableRelation = "Base Calendar";
        }
        field(13707; "Tax Registration No."; Text[20])
        {
        }
        field(13709; "Courier Zone"; Code[2])
        {
        }
        field(13710; "Tax Exemption No."; Text[30])
        {
        }
        field(13711; "Party's L.S.T No."; Code[40])
        {
        }
        field(13712; "Party's C.S.T No."; Code[40])
        {
        }
        field(13713; "P.A.N No."; Code[20])
        {
        }
        field(13714; "E.C.C No."; Code[20])
        {
        }
        field(13715; Range; Code[20])
        {
        }
        field(13716; Collectorate; Code[20])
        {
        }
        field(13717; "Excise Bus. Posting Group"; Code[10])
        {
            // TableRelation = "Excise Bus. Posting Group"; //16225 table n/f
        }
        field(13719; "Excise Registration No."; Text[20])
        {
        }
        field(13720; "Banker Name & Address"; Code[70])
        {
        }
        field(13721; "SSI No."; Code[20])
        {
        }
        field(13722; State; Code[10])
        {
            TableRelation = State;

            trigger OnValidate()
            var
                "...tri1.0": Integer;
                GLSetUp: Record "General Ledger Setup";
                DimValue: Record "Dimension Value";
                DefDim: Record "Default Dimension";
                staterec: Record State;
            begin
            end;
        }
        field(13725; SSI; Boolean)
        {
        }
        field(13726; "SSI Validity Date"; Date)
        {
        }
        field(13728; Structure; Code[10])
        {
            // TableRelation = "Structure Header".Code; ///16225 table n/f
        }
        field(16350; "VAT Business Posting Group"; Code[10])
        {
            // TableRelation = Table16350.Field1; //16225 Table N/F
        }
        field(16352; "Free Trade Zone"; Boolean)
        {
        }
        field(50001; "Purchase Order Pending"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER("Order" | "Invoice"),
                                                      "Bill-to Customer No." = FIELD("No.")));
            Description = 'TRI DP';
            FieldClass = FlowField;
        }
        field(50003; "Customer Type"; Code[10])
        {
            Description = 'Cust 22';
            TableRelation = "Customer Type".Code WHERE(Type = FILTER(= Customer));
        }
        field(50004; "Security Amount"; Decimal)
        {
            Description = 'Cust 22';
        }
        field(50005; "Security Date"; Date)
        {
            Description = 'Cust 22';
        }
        field(50006; "Prompt Pmt. Details"; Boolean)
        {
        }
        field(50007; "State Desc."; Text[50])
        {
        }
        field(50008; "Salesperson Description"; Text[50])
        {
        }
        field(50009; "T.I.N. No."; Code[11])
        {
            Description = 'HF13';
            // TableRelation = "T.I.N. Nos."; //16225 Table N/F
        }
        field(50010; "Form Code"; Code[10])
        {
            // TableRelation = "Form Codes"; //16225 Table N/F
        }
        field(50011; "PPD No. of Days"; Integer)
        {
        }
        field(50012; "PPD %"; Decimal)
        {
        }
        field(50013; "Payment Terms Days"; Integer)
        {
        }
        field(50014; "PAN Ref. No."; Code[10])
        {
            Description = 'RM added for eTDS';
        }
        field(50015; "PAN Status"; Option)
        {
            Description = 'RM added for eTDS';
            OptionCaption = ',PANAPPLIED,PANINVALID,PANNOTAVBL';
            OptionMembers = ,PANAPPLIED,PANINVALID,PANNOTAVBL;
        }
        field(50016; "Quantity in Carton"; Decimal)
        {
            CalcFormula = Sum("Sales Invoice Line"."Quantity in Cartons" WHERE("Sell-to Customer No." = FIELD("No."),
                                                                                "Posting Date1" = FIELD("Date Filter"),
                                                                                "Location Code" = FIELD("Location filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50017; "Quantity in Sq. Meters"; Decimal)
        {
            CalcFormula = Sum("Sales Invoice Line"."Quantity in Sq. Mt." WHERE("Sell-to Customer No." = FIELD("No."),
                                                                                "Posting Date1" = FIELD("Date Filter"),
                                                                                "Location Code" = FIELD("Location filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50018; "Ex-Factory Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Invoice Line".Amount WHERE("Sell-to Customer No." = FIELD("No."),
                                                                "Posting Date1" = FIELD("Date Filter"),
                                                                "Location Code" = FIELD("Location filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50019; "Excise Amount"; Decimal)
        {
            //16225 Sale Invoice Line."Excise Amount" Field N/F
            /*CalcFormula = Sum("Sales Invoice Line"."Excise Amount" WHERE ("Sell-to Customer No."=FIELD("No."),
                                                                         "Posting Date1"=FIELD("Date Filter"),
                                                                         "Location Code"=FIELD("Location filter")));*/
            Editable = false;
            FieldClass = FlowField;
        }
        field(50020; "Sales Amount"; Decimal)
        {
            //16225 Sale Invoice Line."Amount Including Excise" Field N/F
            /* CalcFormula = Sum("Sales Invoice Line"."Amount Including Excise" WHERE ("Sell-to Customer No."=FIELD("No."),
                                                                                    "Posting Date1"=FIELD("Date Filter"),
                                                                                    "Location Code"=FIELD("Location filter")));*/
            Editable = false;
            FieldClass = FlowField;
        }
        field(50021; "Location filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(50022; Pay; Option)
        {
            Description = 'TRIRJ ORIENT6.0 01-11-08';
            OptionMembers = "To Pay"," To Be Billed";
        }
        field(50023; "Pin Code"; Code[10])
        {
            Description = 'TRI';
        }
        field(50024; "Cust. Company Type"; Option)
        {
            Description = 'TRI A.S 21.01.09';
            OptionCaption = ' ,Proprietorship,Partnership,Pvt. Ltd,Public Ltd';
            OptionMembers = " ",Proprietorship,Partnership,"Pvt. Ltd","Public Ltd";
        }
        field(50025; "Security Chq Availability"; Boolean)
        {
            Description = 'TRI A.S 21.01.09';
        }
        field(50026; "Bank Account No."; Code[15])
        {
            Description = 'TRI A.S 21.01.09';
        }
        field(50027; "Bank Other Details"; Text[50])
        {
            Description = 'TRI A.S 21.01.09';
        }
        field(50028; "Cust Landline No."; Text[40])
        {
            Description = 'TRI A.S 21.01.09';
        }
        field(50076; "Sales Header No."; Code[20])
        {
        }
        field(50077; "Sales Header Type"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(50078; "Outstanding Amount"; Decimal)
        {
            //16225 "Sales Line"."Amount To Customer" filed N/F
            /*
            CalcFormula = Sum("Sales Line"."Amount To Customer" WHERE ("Document Type"=FILTER("Order"|"Invoice"),
                                                                       "Bill-to Customer No."=FIELD("No.")));*/
            Editable = false;
            FieldClass = FlowField;
        }
        field(50079; "Outstanding Blanket order"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER("Blanket Order"),
                                                      "Bill-to Customer No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50080; "Blanket Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Line".Amount WHERE("Document Type" = FILTER("Blanket Order"),
                                                         "Bill-to Customer No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Name")
        {
        }
        key(Key3; "Customer Posting Group")
        {
        }
        key(Key4; "Currency Code")
        {
        }
        key(Key5; "Country Code")
        {
        }
        key(Key6; "Gen. Bus. Posting Group")
        {
        }
        key(Key7; Name, Address, City)
        {
        }
        key(Key8; "VAT Registration No.")
        {
        }
        key(Key9; Name)
        {
        }
        key(Key10; State, "Customer Type")
        {
        }
        key(Key11; State, City, "Customer Price Group", "No.")
        {
        }
        key(Key12; "Salesperson Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        CampaignTargetGr: Record "Campaign Target Group";
        ContactBusRel: Record "Contact Business Relation";
        CampaignTargetGrMgmt: Codeunit "Campaign Target Group Mgt";
        "...tri1.0": Integer;
        DefDim: Record "Default Dimension";
        DimValue: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
    begin
    end;

    trigger OnInsert()
    var
        ".........tri1.0": Integer;
        DimValue: Record "Dimension Value";
        DefDim: Record "Default Dimension";
        GLSetUp: Record "General Ledger Setup";
    begin
    end;

    trigger OnModify()
    var
        GLSetup: Record "General Ledger Setup";
        DimValue: Record "Dimension Value";
    begin
    end;

    trigger OnRename()
    var
        "...tri1.0": Integer;
        DimValue: Record "Dimension Value";
        DefDim: Record "Default Dimension";
        GLSetup: Record "General Ledger Setup";
    begin
    end;
}

