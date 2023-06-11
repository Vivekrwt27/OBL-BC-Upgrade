table 50015 "Vendor Master Archive"
{
    Caption = 'Vendor';
    DataCaptionFields = "No.", Name;
    DrillDownPageID = "Vendor List";
    LookupPageID = "Vendor List";
    Permissions = TableData "Vendor Ledger Entry" = r;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
        }
        field(4; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(5; Address; Text[70])
        {
            Caption = 'Address';
        }
        field(6; "Address 2"; Text[70])
        {
            Caption = 'Address 2';
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code".City
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(8; Contact; Text[50])
        {
            Caption = 'Contact';
        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            var
                GLSetup: Record "General Ledger Setup";
            begin
            end;
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
        field(19; "Budgeted Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Budgeted Amount';
        }
        field(21; "Vendor Posting Group"; Code[10])
        {
            Caption = 'Vendor Posting Group';
            TableRelation = "Vendor Posting Group";
        }
        field(22; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
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
            //  TableRelation = "Indent"; //16225 TABLE N/F
        }
        field(29; "Purchaser Code"; Code[20])
        {
            Caption = 'Purchaser Code';
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
        field(33; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';
            TableRelation = Vendor;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(35; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(38; Comment; Boolean)
        {
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST("Vendor"),
                                                      "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; Blocked; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Payment,All';
            OptionMembers = " ",Payment,All;
        }
        field(45; "Pay-to Vendor No."; Code[20])
        {
            Caption = 'Pay-to Vendor No.';
            TableRelation = Vendor;
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
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount" WHERE("Vendor No." = FIELD("No."),
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
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
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
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount" WHERE("Vendor No." = FIELD("No."),
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
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                   "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                   "Posting Date" = FIELD("Date Filter"),
                                                                                   "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Net Change (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Purchases (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Vendor Ledger Entry"."Purchase (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                             "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                             "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                             "Posting Date" = FIELD("Date Filter"),
                                                                             "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Purchases (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64; "Inv. Discounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Vendor Ledger Entry"."Inv. Discount (LCY)" WHERE("Vendor No." = FIELD("No."),
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
            FieldClass = FlowField;
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                  "Entry Type" = FILTER('Payment Discount' .. 'Payment Discount (VAT Adjustment)'),
                                                                                  "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                                  "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Pmt. Discounts (LCY)';
            Editable = false;

        }
        field(66; "Balance Due"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor No." = FIELD("No."),
                                                                           "Posting Date" = FIELD(UPPERLIMIT("Date Filter")),
                                                                           "Initial Entry Due Date" = FIELD("Date Filter"),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Balance Due';
            Editable = false;
            FieldClass = FlowField;
        }
        field(67; "Balance Due (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                   "Posting Date" = FIELD(UPPERLIMIT("Date Filter")),
                                                                                   "Initial Entry Due Date" = FIELD("Date Filter"),
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
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount" WHERE("Initial Document Type" = CONST("Payment"),
                                                                          "Entry Type" = CONST("Initial Entry"),
                                                                          "Vendor No." = FIELD("No."),
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
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount" WHERE("Initial Document Type" = CONST("Invoice"),
                                                                           "Entry Type" = CONST("Initial Entry"),
                                                                           "Vendor No." = FIELD("No."),
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
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount" WHERE("Initial Document Type" = CONST("Credit Memo"),
                                                                          "Entry Type" = CONST("Initial Entry"),
                                                                          "Vendor No." = FIELD("No."),
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
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount" WHERE("Initial Document Type" = CONST("Finance Charge Memo"),
                                                                           "Entry Type" = CONST("Initial Entry"),
                                                                           "Vendor No." = FIELD("No."),
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
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST("Payment"),
                                                                                  "Entry Type" = CONST("Initial Entry"),
                                                                                  "Vendor No." = FIELD("No."),
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
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST("Invoice"),
                                                                                   "Entry Type" = CONST("Initial Entry"),
                                                                                   "Vendor No." = FIELD("No."),
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
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST("Credit Memo"),
                                                                                  "Entry Type" = CONST("Initial Entry"),
                                                                                  "Vendor No." = FIELD("No."),
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
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST("Finance Charge Memo"),
                                                                                   "Entry Type" = CONST("Initial Entry"),
                                                                                   "Vendor No." = FIELD("No."),
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
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Outstanding Amount" WHERE("Document Type" = CONST("Order"),
                                                                          "Pay-to Vendor No." = FIELD("No."),
                                                                          "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                          "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                          "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Outstanding Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(79; "Amt. Rcd. Not Invoiced"; Decimal)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Amt. Rcd. Not Invoiced" WHERE("Document Type" = CONST("Order"),
                                                                              "Pay-to Vendor No." = FIELD("No."),
                                                                              "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                              "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                              "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Amt. Rcd. Not Invoiced';
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

            trigger OnValidate()
            var
                PurchPrice: Record "Purchase Price";
                Item: Record Item;
                VATPostingSetup: Record "VAT Posting Setup";
                Currency: Record Currency;
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
                VATRegistrationLogMgt: Codeunit "VAT Registration Log Mgt.";
            begin
            end;
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
        field(90; GLN; Code[13])
        {
            Caption = 'GLN';
            Numeric = true;

            trigger OnValidate()
            var
                GLNCalculator: Codeunit "GLN Calculator";
            begin
            end;
        }
        field(91; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code"
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;
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
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Debit Amount" WHERE("Vendor No." = FIELD("No."),
                                                                                  "Entry Type" = FILTER(<> Application),
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
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Credit Amount" WHERE("Vendor No." = FIELD("No."),
                                                                                   "Entry Type" = FILTER(<> Application),
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
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Debit Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                        "Entry Type" = FILTER(<> Application),
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
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Credit Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                         "Entry Type" = FILTER(<> Application),
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
            ExtendedDatatype = EMail;
        }
        field(103; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
            ExtendedDatatype = URL;
        }
        field(104; "Reminder Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount" WHERE("Initial Document Type" = CONST("Reminder"),
                                                                           "Entry Type" = CONST("Initial Entry"),
                                                                           "Vendor No." = FIELD("No."),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Posting Date" = FIELD("Date Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Reminder Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(105; "Reminder Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST("Reminder"),
                                                                                   "Entry Type" = CONST("Initial Entry"),
                                                                                   "Vendor No." = FIELD("No."),
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
            TableRelation = "Currency";
        }
        field(113; "Outstanding Orders (LCY)"; Decimal)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Outstanding Amount (LCY)" WHERE("Document Type" = CONST("Order"),
                                                                                "Pay-to Vendor No." = FIELD("No."),
                                                                                "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Outstanding Orders (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(114; "Amt. Rcd. Not Invoiced (LCY)"; Decimal)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Amt. Rcd. Not Invoiced (LCY)" WHERE("Document Type" = CONST("Order"),
                                                                                    "Pay-to Vendor No." = FIELD("No."),
                                                                                    "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                    "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                    "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Amt. Rcd. Not Invoiced (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(116; "Block Payment Tolerance"; Boolean)
        {
            Caption = 'Block Payment Tolerance';
        }
        field(117; "Pmt. Disc. Tolerance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                  "Entry Type" = FILTER('Payment Discount Tolerance|Payment Discount Tolerance (VAT Adjustment)|Payment Discount Tolerance (VAT Excl.)'),
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
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                  "Entry Type" = FILTER('Payment Tolerance|Payment Tolerance (VAT Adjustment)|Payment Tolerance (VAT Excl.)'),
                                                                                  "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                                  "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Pmt. Tolerance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(119; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            TableRelation = "IC Partner";

            trigger OnValidate()
            var
                VendLedgEntry: Record "Vendor Ledger Entry";
                AccountingPeriod: Record "Accounting Period";
                ICPartner: Record "IC Partner";
            begin
            end;
        }
        field(120; Refunds; Decimal)
        {
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount" WHERE("Initial Document Type" = CONST("Refund"),
                                                                           "Entry Type" = CONST("Initial Entry"),
                                                                           "Vendor No." = FIELD("No."),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Posting Date" = FIELD("Date Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Refunds';
            FieldClass = FlowField;
        }
        field(121; "Refunds (LCY)"; Decimal)
        {
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST("Refund"),
                                                                                   "Entry Type" = CONST("Initial Entry"),
                                                                                   "Vendor No." = FIELD("No."),
                                                                                   "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                   "Posting Date" = FIELD("Date Filter"),
                                                                                   "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Refunds (LCY)';
            FieldClass = FlowField;
        }
        field(122; "Other Amounts"; Decimal)
        {
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Initial Document Type" = CONST(" "),
                                                                           "Entry Type" = CONST("Initial Entry"),
                                                                           "Vendor No." = FIELD("No."),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Posting Date" = FIELD("Date Filter"),
                                                                           "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Other Amounts';
            FieldClass = FlowField;
        }
        field(123; "Other Amounts (LCY)"; Decimal)
        {
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST(" "),
                                                                                   "Entry Type" = CONST("Initial Entry"),
                                                                                   "Vendor No." = FIELD("No."),
                                                                                   "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                   "Posting Date" = FIELD("Date Filter"),
                                                                                   "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Other Amounts (LCY)';
            FieldClass = FlowField;
        }
        field(124; "Prepayment %"; Decimal)
        {
            Caption = 'Prepayment %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(125; "Outstanding Invoices"; Decimal)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Outstanding Amount" WHERE("Document Type" = CONST("Invoice"),
                                                                          "Pay-to Vendor No." = FIELD("No."),
                                                                          "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                          "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                          "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Outstanding Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(126; "Outstanding Invoices (LCY)"; Decimal)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Outstanding Amount (LCY)" WHERE("Document Type" = CONST("Invoice"),
                                                                                "Pay-to Vendor No." = FIELD("No."),
                                                                                "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Outstanding Invoices (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(130; "Pay-to No. Of Archived Doc."; Integer)
        {
            CalcFormula = Count("Purchase Header Archive" WHERE("Document Type" = CONST("Order"),
                                                                 "Pay-to Vendor No." = FIELD("No.")));
            Caption = 'Pay-to No. Of Archived Doc.';
            FieldClass = FlowField;
        }
        field(131; "Buy-from No. Of Archived Doc."; Integer)
        {
            CalcFormula = Count("Purchase Header Archive" WHERE("Document Type" = CONST("Order"),
                                                                 "Buy-from Vendor No." = FIELD("No.")));
            Caption = 'Buy-from No. Of Archived Doc.';
            FieldClass = FlowField;
        }
        field(132; "Partner Type"; Option)
        {
            Caption = 'Partner Type';
            OptionCaption = ' ,Company,Person';
            OptionMembers = " ",Company,Person;
        }
        field(150; "Privacy Blocked"; Boolean)
        {
            Caption = 'Privacy Blocked';
        }
        field(170; "Creditor No."; Code[20])
        {
            Caption = 'Creditor No.';
        }
        field(288; "Preferred Bank Account"; Code[10])
        {
            Caption = 'Preferred Bank Account';
            TableRelation = "Vendor Bank Account".Code WHERE("Vendor No." = FIELD("No."));
        }
        field(840; "Cash Flow Payment Terms Code"; Code[10])
        {
            Caption = 'Cash Flow Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(5049; "Primary Contact No."; Code[20])
        {
            Caption = 'Primary Contact No.';
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusRel: Record "Contact Business Relation";
                TempVend: Record Vendor temporary;
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
        field(5701; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = "Location" WHERE("Use As In-Transit" = CONST(false));

            trigger OnValidate()
            var
                GLSetup: Record "General Ledger Setup";
                LocationRec: Record Location;
                defdim: Record "Default Dimension";
            begin
            end;
        }
        field(5790; "Lead Time Calculation"; DateFormula)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            Caption = 'Lead Time Calculation';
        }
        field(7177; "No. of Pstd. Receipts"; Integer)
        {
            CalcFormula = Count("Purch. Rcpt. Header" WHERE("Buy-from Vendor No." = FIELD("No.")));
            Caption = 'No. of Pstd. Receipts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7178; "No. of Pstd. Invoices"; Integer)
        {
            CalcFormula = Count("Purch. Inv. Header" WHERE("Buy-from Vendor No." = FIELD("No.")));
            Caption = 'No. of Pstd. Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7179; "No. of Pstd. Return Shipments"; Integer)
        {
            CalcFormula = Count("Return Shipment Header" WHERE("Buy-from Vendor No." = FIELD("No.")));
            Caption = 'No. of Pstd. Return Shipments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7180; "No. of Pstd. Credit Memos"; Integer)
        {
            CalcFormula = Count("Purch. Cr. Memo Hdr." WHERE("Buy-from Vendor No." = FIELD("No.")));
            Caption = 'No. of Pstd. Credit Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7181; "Pay-to No. of Orders"; Integer)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST("Order"),
                                                         "Pay-to Vendor No." = FIELD("No.")));
            Caption = 'Pay-to No. of Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7182; "Pay-to No. of Invoices"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST("Invoice"),
                                                         "Pay-to Vendor No." = FIELD("No.")));
            Caption = 'Pay-to No. of Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7183; "Pay-to No. of Return Orders"; Integer)
        {
            AccessByPermission = TableData "Return Shipment Header" = R;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST("Return Order"),
                                                         "Pay-to Vendor No." = FIELD("No.")));
            Caption = 'Pay-to No. of Return Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7184; "Pay-to No. of Credit Memos"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST("Credit Memo"),
                                                         "Pay-to Vendor No." = FIELD("No.")));
            Caption = 'Pay-to No. of Credit Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7185; "Pay-to No. of Pstd. Receipts"; Integer)
        {
            CalcFormula = Count("Purch. Rcpt. Header" WHERE("Pay-to Vendor No." = FIELD("No.")));
            Caption = 'Pay-to No. of Pstd. Receipts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7186; "Pay-to No. of Pstd. Invoices"; Integer)
        {
            CalcFormula = Count("Purch. Inv. Header" WHERE("Pay-to Vendor No." = FIELD("No.")));
            Caption = 'Pay-to No. of Pstd. Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7187; "Pay-to No. of Pstd. Return S."; Integer)
        {
            CalcFormula = Count("Return Shipment Header" WHERE("Pay-to Vendor No." = FIELD("No.")));
            Caption = 'Pay-to No. of Pstd. Return S.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7188; "Pay-to No. of Pstd. Cr. Memos"; Integer)
        {
            CalcFormula = Count("Purch. Cr. Memo Hdr." WHERE("Pay-to Vendor No." = FIELD("No.")));
            Caption = 'Pay-to No. of Pstd. Cr. Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7189; "No. of Quotes"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST("Quote"),
                                                         "Buy-from Vendor No." = FIELD("No.")));
            Caption = 'No. of Quotes';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7190; "No. of Blanket Orders"; Integer)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST("Blanket Order"),
                                                         "Buy-from Vendor No." = FIELD("No.")));
            Caption = 'No. of Blanket Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7191; "No. of Orders"; Integer)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST("Order"),
                                                         "Buy-from Vendor No." = FIELD("No.")));
            Caption = 'No. of Orders';
            FieldClass = FlowField;
        }
        field(7192; "No. of Invoices"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST("Invoice"),
                                                         "Buy-from Vendor No." = FIELD("No.")));
            Caption = 'No. of Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7193; "No. of Return Orders"; Integer)
        {
            AccessByPermission = TableData "Return Shipment Header" = R;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST("Return Order"),
                                                         "Buy-from Vendor No." = FIELD("No.")));
            Caption = 'No. of Return Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7194; "No. of Credit Memos"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST("Credit Memo"),
                                                         "Buy-from Vendor No." = FIELD("No.")));
            Caption = 'No. of Credit Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7195; "No. of Order Addresses"; Integer)
        {
            CalcFormula = Count("Order Address" WHERE("Vendor No." = FIELD("No.")));
            Caption = 'No. of Order Addresses';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7196; "Pay-to No. of Quotes"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST("Quote"),
                                                         "Pay-to Vendor No." = FIELD("No.")));
            Caption = 'Pay-to No. of Quotes';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7197; "Pay-to No. of Blanket Orders"; Integer)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST("Blanket Order"),
                                                         "Pay-to Vendor No." = FIELD("No.")));
            Caption = 'Pay-to No. of Blanket Orders';
            FieldClass = FlowField;
        }
        field(7600; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            TableRelation = "Base Calendar";
        }
        field(9000; "Version No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9010; "Archive Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(9020; "Archive By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13706; "T.I.N. No."; Code[11])
        {
            Caption = 'T.I.N. No.';
        }
        field(13710; "L.S.T. No."; Code[20])
        {
            Caption = 'L.S.T. No.';
        }
        field(13711; "C.S.T. No."; Code[20])
        {
            Caption = 'C.S.T. No.';
        }
        field(13712; "P.A.N. No."; Code[20])
        {
            Caption = 'P.A.N. No.';
        }
        field(13713; "E.C.C. No."; Code[20])
        {
            Caption = 'E.C.C. No.';
        }
        field(13714; Range; Code[40])
        {
            Caption = 'Range';
        }
        field(13715; Collectorate; Code[20])
        {
            Caption = 'Collectorate';
        }
        field(13717; "State Code"; Code[10])
        {
            Caption = 'State Code';
            TableRelation = State;

            trigger OnValidate()
            var
                StateRec: Record State;
                DefDim: Record "Default Dimension";
            begin
            end;
        }
        field(13718; "Excise Bus. Posting Group"; Code[10])
        {
            Caption = 'Excise Bus. Posting Group';
            //TableRelation = "Excise Bus. Posting Group"; //16225 TABLE N/F
        }
        field(13725; SSI; Boolean)
        {
            Caption = 'SSI';
        }
        field(13726; "SSI Validity Date"; Date)
        {
            Caption = 'SSI Validity Date';
        }
        field(13728; Structure; Code[10])
        {
            Caption = 'Structure';
            // TableRelation = "Structure Header".Code; //16225 TABLE N/F
        }
        field(13730; "Vendor Type"; Option)
        {
            Caption = 'Vendor Type';
            OptionCaption = ' ,Manufacturer,First Stage Dealer,Second Stage Dealer,Importer';
            OptionMembers = " ",Manufacturer,"First Stage Dealer","Second Stage Dealer",Importer;
        }
        field(16360; Subcontractor; Boolean)
        {
            Caption = 'Subcontractor';
        }
        field(16361; "Vendor Location"; Code[10])
        {
            Caption = 'Vendor Location';
            Editable = true;
            TableRelation = "Location" WHERE("Subcontracting Location" = CONST(true));

            trigger OnValidate()
            var
                Location: Record Location;
            begin
            end;
        }
        field(16362; "Commissioner's Permission No."; Text[50])
        {
            Caption = 'Commissioner''s Permission No.';
        }
        field(16471; "Service Tax Registration No."; Code[20])
        {
            Caption = 'Service Tax Registration No.';
        }
        field(16473; "Service Entity Type"; Code[20])
        {
            Caption = 'Service Entity Type';
            TableRelation = "Service Entity Type";
        }
        field(16500; "P.A.N. Reference No."; Code[20])
        {
            Caption = 'P.A.N. Reference No.';
        }
        field(16501; "P.A.N. Status"; Option)
        {
            Caption = 'P.A.N. Status';
            OptionCaption = ' ,PANAPPLIED,PANINVALID,PANNOTAVBL';
            OptionMembers = " ",PANAPPLIED,PANINVALID,PANNOTAVBL;
        }
        field(16502; Composition; Boolean)
        {
            Caption = 'Composition';
        }
        field(16503; Transporter; Boolean)
        {
            Caption = 'Transporter';
        }
        field(16600; "GST Registration No."; Code[15])
        {
            Caption = 'GST Registration No.';
        }
        field(16609; "GST Vendor Type"; Option)
        {
            Caption = 'GST Vendor Type';
            OptionCaption = ' ,Registered,Composite,Unregistered,Import,Exempted,SEZ';
            OptionMembers = " ",Registered,Composite,Unregistered,Import,Exempted,SEZ;
        }
        field(16610; "Associated Enterprises"; Boolean)
        {
            Caption = 'Associated Enterprises';
        }
        field(16611; "Aggregate Turnover"; Option)
        {
            Caption = 'Aggregate Turnover';
            OptionCaption = 'More than 20 lakh,Less than 20 lakh';
            OptionMembers = "More than 20 lakh","Less than 20 lakh";
        }
        field(16612; "ARN No."; Code[15])
        {
            Caption = 'ARN No.';
        }
        field(50003; "Vendor Classification"; Code[10])
        {
            Description = 'Customization No. 22';
            TableRelation = "Customer Type".Code WHERE(Type = FILTER(= Vendor));
        }
        field(50004; "Security Amount"; Decimal)
        {
            Description = 'Customization No. 22';
        }
        field(50005; "Security Date"; Date)
        {
            Description = 'Customization No. 22';
        }
        field(50006; Transporter1; Boolean)
        {
            Description = 'Customization No. 9';
        }
        field(50008; "PAN Ref. No."; Code[10])
        {
            Description = 'RM Added for eTDS';
        }
        field(50009; "PAN Status"; Option)
        {
            Description = 'RM Added for eTDS';
            OptionCaption = ',PANAPPLIED,PANINVALID,PANNOTAVBL';
            OptionMembers = ,PANAPPLIED,PANINVALID,PANNOTAVBL;
        }
        field(50023; "Pin Code"; Code[10])
        {
            Description = 'TRI';
        }
        field(50024; "Blocked Old"; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Payment,All';
            OptionMembers = " ",Payment,All;
        }
        field(50025; "Tax Registration No."; Code[20])
        {
            Description = 'TRI Karan';
        }
        field(50026; "Bank A/c"; Code[30])
        {
            Description = 'Kulbhushan';
        }
        field(50027; "Bank Account Name"; Text[50])
        {
            Description = 'Kulbhushan';
        }
        field(50028; "Bank Address"; Text[100])
        {
            Description = 'Kulbhushan';
        }
        field(50029; "Bank Address 2"; Text[50])
        {
            Description = 'Kulbhushan';
        }
        field(50030; "RTGS/NEFT Code"; Code[11])
        {
            Description = 'Kulbhushan';
        }
        field(50031; "Vendor Address"; Text[70])
        {
            Description = 'Ori Ut';
        }
        field(50032; "Vendor Address 2"; Text[70])
        {
            Description = 'Ori Ut';
        }
        field(50033; "Vendor City"; Text[50])
        {
            Description = 'Ori Ut';
        }
        field(50034; "Vendor Contact"; Text[50])
        {
            Description = 'Ori Ut';
        }
        field(50035; "Vendor Phone No."; Text[30])
        {
            Description = 'Ori Ut';
        }
        field(50036; "Vendor Telex No."; Text[30])
        {
            Description = 'Ori Ut';
        }
        field(50037; "Create for Orient"; Boolean)
        {
            Description = 'MIPL,MSBS.Rao Dt. 03-10-11';
            Editable = false;
        }
        field(50038; "Create for Bell"; Boolean)
        {
            Description = 'MIPL,MSBS.Rao Dt. 03-10-11';
            Editable = false;
        }
        field(50039; "Emp Code"; Code[10])
        {
        }
        field(50040; "CST Tin"; Code[11])
        {
        }
        field(50041; PAYVEND; Code[20])
        {
            CalcFormula = Lookup("Vendor"."No." WHERE("No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50042; "Vend. Company Type"; Option)
        {
            Description = 'Kulbhushan A.S 21.01.09';
            OptionCaption = ' ,Proprietorship,Partnership,Pvt. Ltd,Public Ltd';
            OptionMembers = " ",Proprietorship,Partnership,"Pvt. Ltd","Public Ltd";
        }
        field(50043; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPT'));
        }
        field(50044; Zone; Text[7])
        {
            CalcFormula = Lookup("State"."Zone" WHERE(Code = FIELD("State Code")));
            Enabled = true;
            FieldClass = FlowField;
        }
        field(50045; Grade; Text[10])
        {
        }
        field(50046; Dsgn; Text[50])
        {
        }
        field(50047; Section; Text[50])
        {
        }
        field(50048; Region; Option)
        {
            OptionCaption = ' ,North,East,South,West';
            OptionMembers = " ",North,East,South,West;
        }
        field(50049; DOJ; Date)
        {
        }
        field(50050; "GST No."; Code[15])
        {
        }
        field(50051; "State Desc"; Text[30])
        {
            CalcFormula = Lookup("State"."Description" WHERE(Code = FIELD("State Code")));
            FieldClass = FlowField;
        }
        field(50052; "Msme Code"; Code[12])
        {
        }
        field(50053; "Requested By"; Text[30])
        {
        }
        field(50054; "Micro Enterprises"; Boolean)
        {
        }
        field(50055; "Small Enterprises"; Boolean)
        {
        }
        field(50056; "Medium Enterprises"; Boolean)
        {
        }
        field(50057; "Creation Date"; Date)
        {
        }
        field(50058; "Landline No."; Text[10])
        {
        }
        field(50059; "A/C user E-mail"; Text[30])
        {
        }
        field(50060; "Financial Transaction"; Boolean)
        {
        }
        field(50061; "Morbi Location Code"; Code[10])
        {
        }
        field(50062; "Created By"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50063; "Bal on Balance Conf Date"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Balance';
            Editable = false;
            FieldClass = Normal;
        }
        field(50064; "Balance Conf Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50065; "Balance confirmation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50066; "Vend Ledger Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50067; "Bank Beneficiary Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50068; "Beneficiary Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Saving,Current,Cash Credit';
            OptionMembers = " ",Saving,Current,"Cash Credit";
        }
        field(50070; "Morbi Inventory"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Temp Calcualtion';
        }
        field(50071; "194Q"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50072; "194Q Recived Data"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50073; "Contact Mail ID"; Text[50])
        {
            Caption = 'E-Mail';
            DataClassification = ToBeClassified;
            Description = 'Contact Mail ID for Material Despatchedc.';
            ExtendedDatatype = EMail;
        }
        field(50080; Approved; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'MSVrn';
        }
        field(50081; "Approver ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'MSVrn';
            TableRelation = "User Setup"."User ID";
        }
        field(50082; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'MSVrn';
            OptionCaption = ' ,Sent for Approval,Approved,Rejected';
            OptionMembers = " ","Sent for Approval",Approved,Rejected;
        }
        field(50083; "Blocked Vendor"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'MSVrn';
        }
        field(85000; "Not Required"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.", "Version No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Name")
        {
        }
        key(Key3; "Vendor Posting Group")
        {
        }
        key(Key4; "Currency Code")
        {
        }
        key(Key5; Priority)
        {
        }
        key(Key6; "Country/Region Code")
        {
        }
        key(Key7; "Gen. Bus. Posting Group")
        {
        }
        key(Key8; "VAT Registration No.")
        {
        }
        key(Key9; Name)
        {
        }
        key(Key10; City)
        {
        }
        key(Key11; "Post Code")
        {
        }
        key(Key12; "Phone No.")
        {
        }
        key(Key13; Contact)
        {
        }
        key(Key14; "Vendor Classification", "No.")
        {
        }
        key(Key15; "Purchaser Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name, "Emp Code", "Post Code", City, "Phone No.", Contact, Balance)
        {
        }
        fieldgroup(Brick; "No.", Name, "Balance (LCY)", Contact, "Balance Due (LCY)")
        {
        }
    }

    trigger OnDelete()
    var
        ItemVendor: Record "Item Vendor";
        PurchPrice: Record "Purchase Price";
        PurchLineDiscount: Record "Purchase Line Discount";
        PurchPrepmtPct: Record "Purchase Prepayment %";
        "...tri1.0": Integer;
        GLSetup: Record "General Ledger Setup";
        DefDim: Record "Default Dimension";
        DimValue: Record "Dimension Value";
        // SocialListeningSearchTopic: Record "Social Listening Search Topic"; //16225 TABLE REMOVED BC
        CustomReportSelection: Record "Custom Report Selection";
        CompanyInformation: Record "Company Information";
        VATRegistrationLogMgt: Codeunit "VAT Registration Log Mgt.";
    begin
    end;

    trigger OnInsert()
    var
        "....tri1.0": Integer;
        GLSetUp: Record "General Ledger Setup";
        DimValue: Record "Dimension Value";
        DefDim: Record "Default Dimension";
    begin
    end;

    trigger OnModify()
    var
        DimValue: Record "Dimension Value";
    begin
    end;

    trigger OnRename()
    var
        "...tri1.0": Integer;
        GLSetup: Record "General Ledger Setup";
        DefDim: Record "Default Dimension";
        DimValue: Record "Dimension Value";
    begin
    end;

    var
        Text000: Label 'You cannot delete %1 %2 because there is at least one outstanding Purchase %3 for this vendor.';
        Text002: Label 'You have set %1 to %2. Do you want to update the %3 price list accordingly?';
        Text003: Label 'Do you wish to create a contact for %1 %2?';
        PurchSetup: Record "Purchases & Payables Setup";
        CommentLine: Record "Comment Line";
        PurchOrderLine: Record "Purchase Line";
        PostCode: Record "Post Code";
        VendBankAcc: Record "Vendor Bank Account";
        OrderAddr: Record "Order Address";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
       // ItemCrossReference: Record "Item Cross Reference";
        RMSetup: Record "Marketing Setup";
        ServiceItem: Record "Service Item";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        GSTRegistrationNos: Record "GST Registration Nos.";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MoveEntries: Codeunit MoveEntries;
        UpdateContFromVend: Codeunit "VendCont-Update";
        DimMgt: Codeunit DimensionManagement;
        LeadTimeMgt: Codeunit "Lead-Time Management";
        InsertFromContact: Boolean;
        Text004: Label 'Contact %1 %2 is not related to vendor %3 %4.';
        Text005: Label 'post';
        Text006: Label 'create';
        Text007: Label 'You cannot %1 this type of document when Vendor %2 is blocked with type %3';
        Text008: Label 'The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3.';
        Text009: Label 'Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?';
        Text010: Label 'You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.';
        Text011: Label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        PrivacyBlockedActionErr: Label 'You cannot %1 this type of document when Vendor %2 is blocked for privacy.', Comment = '%1 = action (create or post), %2 = vendor code.';
        PrivacyBlockedGenericTxt: Label 'Privacy Blocked must not be true for vendor %1.', Comment = '%1 = vendor code';
        ConfirmBlockedPrivacyBlockedQst: Label 'If you change the Blocked field, the Privacy Blocked field is changed to No. Do you want to continue?';
        CanNotChangeBlockedDueToPrivacyBlockedErr: Label 'The Blocked field cannot be changed because the user is blocked for privacy reasons.';
        Text16500: Label 'P.A.N. cannot be updated unless the P.A.N. status is blank.';
        State: Record State;
        Text16501: Label 'PAN No. Should be Ten Digit.';
        Text16502: Label 'TIN No. Should be Eleven Digit.';
        VendType: Record "Customer Type";
        GLSetup: Record "General Ledger Setup";
        Vend: Record Vendor;
        GSTVendorTypeErr: Label 'State code should be empty,If GST Vendor Type %1.', Comment = '%1=GST Vendor Type';
        Vendserv: Record "SMS - Mobile No.";
        AggTurnoverErr: Label 'You can change Aggregate Turnover only for Unregistered Vendor.';
        GSTARNErr: Label 'Either GST Registration No. or ARN No. should have a value.';
        PANErr: Label 'PAN No. must be entered.';
        GSTPANErr: Label 'Please update GST Registration No. to blank in the record %1 from Order Address.', Comment = '%1 = GST Registration No.';
        SamePANErr: Label 'From postion 3 to 12 in GST Registration No. should be same as it is in PAN No. so delete and then update it.';
}

