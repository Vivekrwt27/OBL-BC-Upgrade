
table 50062 "Vendor Requisition"
{
    Caption = 'Vendor Rep';
    DataCaptionFields = "No.", Name;
    DrillDownPageID = "Vendor Requisition List";
    LookupPageID = "Vendor Requisition List";
    Permissions = TableData "Vendor Ledger Entry" = r,
                  TableData "Approval Entry" = rim;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    PurchSetup.GET;
                    NoSeriesMgt.TestManual(PurchSetup."Vendor Nos.");
                    "No. Series" := '';
                END;
                IF "Invoice Disc. Code" = '' THEN
                    "Invoice Disc. Code" := "No.";

                //MSVrn -->>
                "Blocked Vendor" := TRUE;
                Blocked := Blocked::All;
                //--<<
                EditableAllowed;
            end;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                IF ("Search Name" = UPPERCASE(xRec.Name)) OR ("Search Name" = '') THEN
                    "Search Name" := Name;
                IF Name <> xRec.Name THEN
                    UpdateDedName;
                EditableAllowed;
            end;
        }
        field(3; "Search Name"; Code[50])
        {
            Caption = 'Search Name';

            trigger OnLookup()
            begin
                Vend."Pay-to Vendor No." := xRec."No."
            end;
        }
        field(4; "Name 2"; Text[50])
        {
            Caption = 'Name 2';

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(5; Address; Text[50])
        {
            Caption = 'Address';

            trigger OnValidate()
            begin
                "Vendor Address" := Address;//Ori Ut
                EditableAllowed;
            end;
        }
        field(6; "Address 2"; Text[50])
        {
            Caption = 'Address 2';

            trigger OnValidate()
            begin
                "Vendor Address 2" := "Address 2";//Ori Ut
                EditableAllowed;
            end;
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

            trigger OnLookup()
            begin
                "Vendor City" := City; //Ori ut
                EditableAllowed;
            end;

            trigger OnValidate()
            begin
                "Vendor City" := City; //Ori ut
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
                EditableAllowed;
            end;
        }
        field(8; Contact; Text[50])
        {
            Caption = 'Contact';

            trigger OnValidate()
            begin
                /*  //--Vrn
                "Vendor Contact":=Contact;//Ori ut
                IF RMSetup.GET THEN
                  IF RMSetup."Bus. Rel. Code for Vendors" <> '' THEN
                    IF (xRec.Contact = '') AND (xRec."Primary Contact No." = '') THEN BEGIN
                      MODIFY;
                      UpdateContFromVend.OnModify(Rec);
                      UpdateContFromVend.InsertNewContactPerson(Rec,FALSE);
                      MODIFY(TRUE);
                    END
                    */
                EditableAllowed;

            end;
        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            var
                GLSetup: Record "General Ledger Setup";
            begin
                "Vendor Phone No." := "Phone No.";//ori Ut
                GLSetup.GET;
                IF GLSetup."SMS Updatation" THEN
                    InsertSMSDetails(FIELDNO("Phone No."));
                EditableAllowed;
            end;
        }
        field(10; "Telex No."; Text[20])
        {
            Caption = 'Telex No.';

            trigger OnValidate()
            begin
                "Vendor Telex No." := "Telex No.";//Ori ut
                EditableAllowed;
            end;
        }
        field(14; "Our Account No."; Text[20])
        {
            Caption = 'Our Account No.';

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
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

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
                EditableAllowed;
            end;
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
                EditableAllowed;
            end;
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

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(22; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
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
            //16225  TableRelation = Indent;
        }
        field(29; "Purchaser Code"; Code[20])
        {
            Caption = 'Purchaser Code';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            begin
                ValidatePurchaserCode;
                EditableAllowed;
            end;
        }
        field(30; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(31; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
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
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST(Vendor),
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

            trigger OnValidate()
            begin
                IF (Blocked <> Blocked::All) AND "Privacy Blocked" THEN
                    IF GUIALLOWED THEN
                        IF CONFIRM(ConfirmBlockedPrivacyBlockedQst) THEN
                            "Privacy Blocked" := FALSE
                        ELSE
                            ERROR('')
                    ELSE
                        ERROR(CanNotChangeBlockedDueToPrivacyBlockedErr);
            end;
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
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor No." = FIELD("No."),
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
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor No." = FIELD("No."),
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
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                  "Entry Type" = FILTER('Payment Discount' .. 'Payment Discount (VAT Adjustment)'),
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
            CalcFormula = Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Initial Document Type" = CONST(Payment),
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
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Initial Document Type" = CONST(Invoice),
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
            CalcFormula = Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Initial Document Type" = CONST("Credit Memo"),
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
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Initial Document Type" = CONST("Finance Charge Memo"),
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
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST(Payment),
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
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST(Invoice),
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
            CalcFormula = Sum("Purchase Line"."Outstanding Amount" WHERE("Document Type" = CONST(Order),
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
            CalcFormula = Sum("Purchase Line"."Amt. Rcd. Not Invoiced" WHERE("Document Type" = CONST(Order),
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
                IF VATRegNoFormat.Test("VAT Registration No.", "Country/Region Code", "No.", DATABASE::Vendor) THEN
                    IF "VAT Registration No." <> xRec."VAT Registration No." THEN;
                //VATRegistrationLogMgt.LogVendor(Rec); //--Vrn
            end;
        }
        field(88; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate()
            begin
                IF xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" THEN
                    IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp, "Gen. Bus. Posting Group") THEN
                        VALIDATE("VAT Bus. Posting Group", GenBusPostingGrp."Def. VAT Bus. Posting Group");
                EditableAllowed;
            end;
        }
        field(89; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(90; GLN; Code[13])
        {
            Caption = 'GLN';
            Numeric = true;

            trigger OnValidate()
            var
                GLNCalculator: Codeunit "GLN Calculator";
            begin
                IF GLN <> '' THEN
                    GLNCalculator.AssertValidCheckDigit13(GLN);
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

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
                EditableAllowed;
            end;
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

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
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
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Initial Document Type" = CONST(Reminder),
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
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST(Reminder),
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
            TableRelation = Currency;
        }
        field(113; "Outstanding Orders (LCY)"; Decimal)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Outstanding Amount (LCY)" WHERE("Document Type" = CONST(Order),
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
            CalcFormula = Sum("Purchase Line"."Amt. Rcd. Not Invoiced (LCY)" WHERE("Document Type" = CONST(Order),
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
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                  "Entry Type" = FILTER("Payment Tolerance" | 'Payment Tolerance (VAT Adjustment)' | 'Payment Tolerance (VAT Excl.)'),
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
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount" WHERE("Initial Document Type" = CONST(Refund),
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
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Initial Document Type" = CONST(Refund),
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
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount" WHERE("Initial Document Type" = CONST(" "),
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
            CalcFormula = Sum("Purchase Line"."Outstanding Amount" WHERE("Document Type" = CONST(Invoice),
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
            CalcFormula = Sum("Purchase Line"."Outstanding Amount (LCY)" WHERE("Document Type" = CONST(Invoice),
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
            CalcFormula = Count("Purchase Header Archive" WHERE("Document Type" = CONST(Order),
                                                                 "Pay-to Vendor No." = FIELD("No.")));
            Caption = 'Pay-to No. Of Archived Doc.';
            FieldClass = FlowField;
        }
        field(131; "Buy-from No. Of Archived Doc."; Integer)
        {
            CalcFormula = Count("Purchase Header Archive" WHERE("Document Type" = CONST(Order),
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

            trigger OnValidate()
            begin
                IF "Privacy Blocked" THEN
                    Blocked := Blocked::All
                ELSE
                    Blocked := Blocked::" ";
            end;
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
                ContBusRel.SETCURRENTKEY("Link to Table", "No.");
                ContBusRel.SETRANGE("Link to Table", ContBusRel."Link to Table"::Vendor);
                ContBusRel.SETRANGE("No.", "No.");
                IF ContBusRel.FINDFIRST THEN
                    Cont.SETRANGE("Company No.", ContBusRel."Contact No.")
                ELSE
                    Cont.SETRANGE("No.", '');

                IF "Primary Contact No." <> '' THEN
                    IF Cont.GET("Primary Contact No.") THEN;
                IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
                    TempVend.COPY(Rec);
                    FIND;
                    TRANSFERFIELDS(TempVend, FALSE);
                    VALIDATE("Primary Contact No.", Cont."No.");
                END;
            end;

            trigger OnValidate()
            var
                Cont: Record Contact;
                ContBusRel: Record "Contact Business Relation";
            begin
                Contact := '';
                IF "Primary Contact No." <> '' THEN BEGIN
                    Cont.GET("Primary Contact No.");

                    ContBusRel.SETCURRENTKEY("Link to Table", "No.");
                    ContBusRel.SETRANGE("Link to Table", ContBusRel."Link to Table"::Vendor);
                    ContBusRel.SETRANGE("No.", "No.");
                    ContBusRel.FINDFIRST;

                    IF Cont."Company No." <> ContBusRel."Contact No." THEN
                        ERROR(Text004, Cont."No.", Cont.Name, "No.", Name);

                    IF Cont.Type = Cont.Type::Person THEN
                        Contact := Cont.Name
                END;
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
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));

            trigger OnValidate()
            var
                GLSetup: Record "General Ledger Setup";
                LocationRec: Record Location;
                defdim: Record "Default Dimension";
            begin
                EditableAllowed;

                //mo tri1.0 customization no. 64 start
                //To add the dimension value as default dimension
                IF LocationRec.GET("Location Code") THEN BEGIN
                    GLSetup.GET;
                    GLSetup.TESTFIELD(GLSetup."Location Dimension Code");
                    defdim.INIT;
                    defdim."Table ID" := 23;
                    defdim."No." := "No.";
                    defdim."Dimension Code" := GLSetup."Location Dimension Code";
                    IF defdim.FIND THEN BEGIN
                        defdim."Dimension Value Code" := LocationRec.Code;
                        defdim."Value Posting" := defdim."Value Posting"::" ";
                        //defdim."Table Name" := TABLENAME; code blocked for upgradation
                        defdim.MODIFY;
                    END ELSE BEGIN
                        defdim."Dimension Value Code" := LocationRec.Code;
                        defdim."Value Posting" := defdim."Value Posting"::" ";
                        // defdim."Table Name" := TABLENAME;      code blocked for upgradation
                        defdim.INSERT;
                    END;
                END;
                //mo tri1.0 customization no. 64 end
            end;
        }
        field(5790; "Lead Time Calculation"; DateFormula)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            Caption = 'Lead Time Calculation';

            trigger OnValidate()
            begin
                LeadTimeMgt.CheckLeadTimeIsNotNegative("Lead Time Calculation");
            end;
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
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Order),
                                                         "Pay-to Vendor No." = FIELD("No.")));
            Caption = 'Pay-to No. of Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7182; "Pay-to No. of Invoices"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Invoice),
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
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Order),
                                                         "Buy-from Vendor No." = FIELD("No.")));
            Caption = 'No. of Orders';
            FieldClass = FlowField;
        }
        field(7192; "No. of Invoices"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Invoice),
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
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Quote),
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
        field(13706; "T.I.N. No."; Code[11])
        {
            Caption = 'T.I.N. No.';

            trigger OnValidate()
            begin
                /*IF (STRLEN("T.I.N. No.") < 11) AND ("T.I.N. No." <> '') THEN
                  ERROR(Text16501);*/


                IF (STRLEN("T.I.N. No.") <> 11) THEN
                    ERROR(Text16502);


                IF State.GET("State Code") THEN BEGIN
                    /*16225 IF (COPYSTR(State."State Code for TIN", 1, 2) <> COPYSTR("T.I.N. No.", 1, 2)) AND ("T.I.N. No." <> '') THEN
                        ERROR('The T.I.N. no. for the state %1 should be start with %2', "State Code", COPYSTR(State."State Code for TIN", 1, 2));*/
                END;
                EditableAllowed;

            end;
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

            trigger OnValidate()
            begin
                IF (STRLEN("P.A.N. No.") <> 10) THEN
                    ERROR(Text16501);

                IF ("GST Registration No." <> '') AND ("P.A.N. No." <> COPYSTR("GST Registration No.", 3, 10)) THEN
                    ERROR(SamePANErr);
                CheckGSTRegBlankInRef;
                IF "P.A.N. No." <> xRec."P.A.N. No." THEN
                    UpdateDedPAN;
                EditableAllowed;
            end;
        }
        field(13713; "E.C.C. No."; Code[20])
        {
            Caption = 'E.C.C. No.';

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
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
                EditableAllowed;

                IF NOT ("GST Vendor Type" IN ["GST Vendor Type"::Import, "GST Vendor Type"::Unregistered]) THEN
                    TESTFIELD("GST Registration No.", '');
                IF "GST Vendor Type" = "GST Vendor Type"::Import THEN
                    ERROR(GSTVendorTypeErr, "GST Vendor Type");
            end;
        }
        field(13718; "Excise Bus. Posting Group"; Code[10])
        {
            Caption = 'Excise Bus. Posting Group';
            //16225 TableRelation = "Excise Bus. Posting Group";
        }
        field(13725; SSI; Boolean)
        {
            Caption = 'SSI';

            trigger OnValidate()
            begin
                //MoveEntries.CheckVendorEntries(Rec); //--Vrn
                IF NOT SSI THEN
                    "SSI Validity Date" := 0D;
            end;
        }
        field(13726; "SSI Validity Date"; Date)
        {
            Caption = 'SSI Validity Date';
        }
        field(13728; Structure; Code[10])
        {
            Caption = 'Structure';
            //16225  TableRelation = "Structure Header".Code;
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
            TableRelation = Location WHERE("Subcontracting Location" = CONST(true));

            trigger OnValidate()
            var
                Location: Record Location;
            begin
                IF xRec."Vendor Location" <> "Vendor Location" THEN
                    IF "Vendor Location" <> '' THEN BEGIN
                        Location.GET("Vendor Location");
                        IF Location."Subcontractor No." = '' THEN
                            Location."Subcontractor No." := "No."
                        ELSE
                            ERROR('Location is alredy being assigned');
                    END ELSE BEGIN
                        Location.GET(xRec."Vendor Location");
                        Location."Subcontractor No." := '';
                    END;
                Location.MODIFY;
                EditableAllowed;
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

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(16501; "P.A.N. Status"; Option)
        {
            Caption = 'P.A.N. Status';
            OptionCaption = ' ,PANAPPLIED,PANINVALID,PANNOTAVBL';
            OptionMembers = " ",PANAPPLIED,PANINVALID,PANNOTAVBL;

            trigger OnValidate()
            begin
                "P.A.N. No." := FORMAT("P.A.N. Status");
            end;
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

            trigger OnValidate()
            begin
                /*EditableAllowed;
                
                IF "GST Registration No." <> '' THEN BEGIN
                  TESTFIELD("State Code");
                  IF ("P.A.N. No." <> '') AND ("P.A.N. Status" = "P.A.N. Status"::" ") THEN
                    GSTRegistrationNos.CheckGSTRegistrationNo("State Code","GST Registration No.","P.A.N. No.")
                  ELSE
                    IF "GST Registration No." <> '' THEN
                      ERROR(PANErr);
                  IF "GST Vendor Type" = "GST Vendor Type"::" " THEN
                    "GST Vendor Type" := "GST Vendor Type"::Registered
                  ELSE
                    IF NOT ("GST Vendor Type" IN ["GST Vendor Type"::Registered,"GST Vendor Type"::Composite,
                                                  "GST Vendor Type"::Exempted,"GST Vendor Type"::SEZ])
                    THEN
                      "GST Vendor Type" := "GST Vendor Type"::Registered
                END ELSE
                  IF "ARN No." = '' THEN
                    "GST Vendor Type" := "GST Vendor Type"::" ";
                    */

            end;
        }
        field(16609; "GST Vendor Type"; Option)
        {
            Caption = 'GST Vendor Type';
            OptionCaption = ' ,Registered,Composite,Unregistered,Import,Exempted,SEZ';
            OptionMembers = " ",Registered,Composite,Unregistered,Import,Exempted,SEZ;

            trigger OnValidate()
            begin
                IF "GST Vendor Type" = "GST Vendor Type"::" " THEN BEGIN
                    "GST Registration No." := '';
                    EXIT;
                END;
                IF "GST Vendor Type" IN ["GST Vendor Type"::Registered, "GST Vendor Type"::Composite,
                                         "GST Vendor Type"::SEZ, "GST Vendor Type"::Exempted]
                THEN BEGIN
                    IF "GST Registration No." = '' THEN
                        IF "ARN No." = '' THEN
                            ERROR(GSTARNErr);
                END ELSE BEGIN
                    "GST Registration No." := '';
                    "ARN No." := '';
                    IF "GST Vendor Type" = "GST Vendor Type"::Import THEN
                        TESTFIELD("State Code", '')
                    ELSE
                        IF "GST Vendor Type" = "GST Vendor Type"::Unregistered THEN
                            TESTFIELD("State Code");
                    IF "GST Vendor Type" <> "GST Vendor Type"::Import THEN
                        "Associated Enterprises" := FALSE;
                END;
                IF "GST Registration No." <> '' THEN BEGIN
                    TESTFIELD("State Code");
                    IF ("P.A.N. No." <> '') AND ("P.A.N. Status" = "P.A.N. Status"::" ") THEN
                        //GSTRegistrationNos.CheckGSTRegistrationNo("State Code", "GST Registration No.", "P.A.N. No.")
                        CheckGSTRegistrationNo("State Code", "GST Registration No.", "P.A.N. No.")
                    ELSE
                        IF "GST Registration No." <> '' THEN
                            ERROR(PANErr);
                END;
            end;
        }
        field(16610; "Associated Enterprises"; Boolean)
        {
            Caption = 'Associated Enterprises';

            trigger OnValidate()
            begin
                IF "Associated Enterprises" THEN
                    TESTFIELD("GST Vendor Type", "GST Vendor Type"::Import);
            end;
        }
        field(16611; "Aggregate Turnover"; Option)
        {
            Caption = 'Aggregate Turnover';
            OptionCaption = 'More than 20 lakh,Less than 20 lakh';
            OptionMembers = "More than 20 lakh","Less than 20 lakh";

            trigger OnValidate()
            begin
                IF "GST Vendor Type" <> "GST Vendor Type"::Unregistered THEN
                    ERROR(AggTurnoverErr);
            end;
        }
        field(16612; "ARN No."; Code[15])
        {
            Caption = 'ARN No.';

            trigger OnValidate()
            begin
                IF ("ARN No." = '') AND ("GST Registration No." = '') THEN
                    IF NOT ("GST Vendor Type" IN ["GST Vendor Type"::Import, "GST Vendor Type"::Unregistered]) THEN
                        "GST Vendor Type" := "GST Vendor Type"::" ";
                IF "GST Vendor Type" IN ["GST Vendor Type"::Import, "GST Vendor Type"::Unregistered] THEN
                    TESTFIELD("ARN No.", '');
            end;
        }
        field(50003; "Vendor Classification"; Code[10])
        {
            Description = 'Customization No. 22';
            TableRelation = "Customer Type".Code WHERE(Type = FILTER(= Vendor));

            trigger OnValidate()
            begin
                //VendType is Declared as Record variable to table 50010 "Customer Type"
                //Cust 22 Start Vipul
                EditableAllowed;

                VendType.GET(VendType.Type::Vendor, "Vendor Classification");
                IF "Gen. Bus. Posting Group" = '' THEN
                    "Gen. Bus. Posting Group" := VendType."Gen. Bus. Posting Group";
                IF "Vendor Posting Group" = '' THEN
                    "Vendor Posting Group" := VendType."Vendor Posting Group";
                IF "VAT Bus. Posting Group" = '' THEN
                    "VAT Bus. Posting Group" := VendType."VAT Bus. Posting Group";
                IF "Excise Bus. Posting Group" = '' THEN
                    "Excise Bus. Posting Group" := VendType."Excise Bus. Posting Group";
                IF Structure = '' THEN
                    Structure := VendType.Structure;
                "Tax Liable" := VendType."Tax Liable";
                MODIFY

                //Cust 22 End Vipul
            end;
        }
        field(50004; "Security Amount"; Decimal)
        {
            Description = 'Customization No. 22';

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(50005; "Security Date"; Date)
        {
            Description = 'Customization No. 22';

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
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

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(50027; "Bank Account Name"; Text[50])
        {
            Description = 'Kulbhushan';

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(50028; "Bank Address"; Text[100])
        {
            Description = 'Kulbhushan';

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(50029; "Bank Address 2"; Text[50])
        {
            Description = 'Kulbhushan';

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(50030; "RTGS/NEFT Code"; Code[11])
        {
            Description = 'Kulbhushan';

            trigger OnValidate()
            begin
                EditableAllowed;

                IF (STRLEN("RTGS/NEFT Code") <> 11) THEN
                    ERROR('RTGS/NEFT Shoube be 11 Digit');

            end;
        }
        field(50031; "Vendor Address"; Text[50])
        {
            Description = 'Ori Ut';

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(50032; "Vendor Address 2"; Text[50])
        {
            Description = 'Ori Ut';

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(50033; "Vendor City"; Text[50])
        {
            Description = 'Ori Ut';

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(50034; "Vendor Contact"; Text[50])
        {
            Description = 'Ori Ut';
        }
        field(50035; "Vendor Phone No."; Text[30])
        {
            Description = 'Ori Ut';

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
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
            CalcFormula = Lookup(Vendor."No." WHERE("No." = FIELD("No.")));
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
            CalcFormula = Lookup(State.Zone WHERE(Code = FIELD("State Code")));
            Enabled = true;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(50045; Grade; Text[10])
        {

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(50046; Dsgn; Text[50])
        {

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(50047; Section; Text[50])
        {

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(50048; Region; Option)
        {
            OptionCaption = ' ,North,East,South,West';
            OptionMembers = " ",North,East,South,West;

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(50049; DOJ; Date)
        {

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(50050; "GST No."; Code[15])
        {

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(50051; "State Desc"; Text[30])
        {
            CalcFormula = Lookup(State.Description WHERE(Code = FIELD("State Code")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(50052; "Msme Code"; Code[12])
        {

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
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

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(50059; "A/C user E-mail"; Text[30])
        {

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(50060; "Financial Transaction"; Boolean)
        {

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
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

            trigger OnValidate()
            begin
                IF "Balance confirmation" THEN
                    "Balance Conf Date" := TODAY
                ELSE
                    "Balance Conf Date" := 0D;
                "Bal on Balance Conf Date" := 0;
                "Vend Ledger Balance" := 0;
            end;
        }
        field(50066; "Vend Ledger Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50067; "Bank Beneficiary Name"; Text[80])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(50068; "Beneficiary Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Saving,Current,Cash Credit';
            OptionMembers = " ",Saving,Current,"Cash Credit";

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
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

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(50075; "Vendor Class"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Domestic,Importer,Employee';
            OptionMembers = " ",Domestic,Importer,Employee;

            trigger OnValidate()
            begin
                EditableAllowed;
            end;
        }
        field(50076; "Zone Region"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'MSVrn';
            OptionCaption = ' ,East,West,South,North,Exim';
            OptionMembers = " ",East,West,South,North,Exim;
        }
        field(50077; "No. Series Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'MSVrn';
        }
        field(50080; Approved; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'MSVrn';

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                IF Approved = TRUE THEN BEGIN
                    "Blocked Vendor" := FALSE;
                    Blocked := Blocked::" ";
                    IF Vendor.GET(Rec."No. Series Code") THEN BEGIN
                        Vendor.Blocked := Vendor.Blocked::" ";
                        Vendor.MODIFY;
                    END;
                END ELSE BEGIN
                    "Blocked Vendor" := TRUE;
                    Blocked := Blocked::All;
                    IF Vendor.GET(Rec."No. Series Code") THEN BEGIN
                        Vendor.Blocked := Vendor.Blocked::All;
                        Vendor.MODIFY;
                    END;
                END;
            end;
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
        field(85001; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = 'Open,Pending for Approval,Approved';
            OptionMembers = Open,"Pending for Approval",Approved;
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
        fieldgroup(DropDown; "No.", Name, "Emp Code", "Post Code", "Phone No.", Contact, Balance)
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
        //SocialListeningSearchTopic: Record "Social Listening Search Topic"; //16225 TABLE REMMOVE BC
        CustomReportSelection: Record "Custom Report Selection";
        CompanyInformation: Record "Company Information";
        VATRegistrationLogMgt: Codeunit "VAT Registration Log Mgt.";
    begin
        //MoveEntries.MoveVendorEntries(Rec);
        EditableAllowed;

        CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Vendor);
        CommentLine.SETRANGE("No.", "No.");
        CommentLine.DELETEALL;

        VendBankAcc.SETRANGE("Vendor No.", "No.");
        VendBankAcc.DELETEALL;

        OrderAddr.SETRANGE("Vendor No.", "No.");
        OrderAddr.DELETEALL;

        ItemCrossReference.SETCURRENTKEY("Reference Type", "Reference Type No.");
        ItemCrossReference.SETRANGE("Reference Type", ItemCrossReference."Reference Type"::Vendor);
        ItemCrossReference.SETRANGE("Reference Type No.", "No.");
        ItemCrossReference.DELETEALL;

        PurchOrderLine.SETCURRENTKEY("Document Type", "Pay-to Vendor No.");
        PurchOrderLine.SETRANGE("Pay-to Vendor No.", "No.");
        IF PurchOrderLine.FINDFIRST THEN
            ERROR(
              Text000,
              TABLECAPTION, "No.",
              PurchOrderLine."Document Type");

        PurchOrderLine.SETRANGE("Pay-to Vendor No.");
        PurchOrderLine.SETRANGE("Buy-from Vendor No.", "No.");
        IF PurchOrderLine.FINDFIRST THEN
            ERROR(
              Text000,
              TABLECAPTION, "No.");

        //UpdateContFromVend.OnDelete(Rec);

        DimMgt.DeleteDefaultDim(DATABASE::Vendor, "No.");

        ServiceItem.SETRANGE("Vendor No.", "No.");
        ServiceItem.MODIFYALL("Vendor No.", '');

        ItemVendor.SETRANGE("Vendor No.", "No.");
        ItemVendor.DELETEALL(TRUE);
        //16225 Table N/F Start
        /* IF NOT SocialListeningSearchTopic.ISEMPTY THEN BEGIN
             SocialListeningSearchTopic.FindSearchTopic(SocialListeningSearchTopic."Source Type"::Vendor, "No.");
             SocialListeningSearchTopic.DELETEALL;
         END;*///16225 Table N/F End

        PurchPrice.SETCURRENTKEY("Vendor No.");
        PurchPrice.SETRANGE("Vendor No.", "No.");
        PurchPrice.DELETEALL(TRUE);

        PurchLineDiscount.SETCURRENTKEY("Vendor No.");
        PurchLineDiscount.SETRANGE("Vendor No.", "No.");
        PurchLineDiscount.DELETEALL(TRUE);

        CustomReportSelection.SETRANGE("Source Type", DATABASE::Vendor);
        CustomReportSelection.SETRANGE("Source No.", "No.");
        CustomReportSelection.DELETEALL;

        PurchPrepmtPct.SETCURRENTKEY("Vendor No.");
        PurchPrepmtPct.SETRANGE("Vendor No.", "No.");
        PurchPrepmtPct.DELETEALL(TRUE);

        //mo tri1.0 Customization no.64 start
        GLSetup.GET;
        IF DimValue.GET(GLSetup."Vendor Dimension Code", "No.") THEN BEGIN
            DimValue.DELETE;
        END;

        IF DefDim.GET(23, "No.", GLSetup."Vendor Dimension Code") THEN BEGIN
            DefDim.DELETE;
        END;
        //mo tri1.0 Customization no.64 end

        /* //MSVrn
        VATRegistrationLogMgt.DeleteVendorLog(Rec);
        CompanyInformation.CheckDeleteIntrastatContact(
          CompanyInformation."Intrastat Contact Type"::Vendor,"No.");
          */

    end;

    trigger OnInsert()
    var
        "....tri1.0": Integer;
        GLSetUp: Record "General Ledger Setup";
        DimValue: Record "Dimension Value";
        DefDim: Record "Default Dimension";
    begin
        "Creation Date" := TODAY;
        "Created By" := USERID;
        "Blocked Vendor" := TRUE;

        IF "No." = '' THEN BEGIN
            PurchSetup.GET;
            PurchSetup.TESTFIELD("Vendor Nos. 2");
            NoSeriesMgt.InitSeries(PurchSetup."Vendor Nos. 2", xRec."No. Series", 0D, "No.", "No. Series");
        END;

        //To add the generated vendor no. as dimension value.
        GLSetUp.GET;
        GLSetUp.TESTFIELD(GLSetUp."Vendor Dimension Code");
        IF NOT DimValue.GET(GLSetUp."Vendor Dimension Code", "No.") THEN BEGIN
            DimValue.INIT;
            DimValue.VALIDATE("Dimension Code", GLSetUp."Vendor Dimension Code");
            DimValue.VALIDATE(Code, "No.");
            DimValue.VALIDATE(Name, "No.");
            DimValue.INSERT;
        END;

        //To add the dimension value as default dimension
        IF NOT DefDim.GET(50062, "No.", GLSetUp."Vendor Dimension Code") THEN BEGIN
            DefDim.INIT;
            DefDim."Table ID" := 50062;
            DefDim."No." := "No.";
            DefDim."Dimension Code" := GLSetUp."Vendor Dimension Code";
            DefDim."Dimension Value Code" := DimValue.Code;
            DefDim."Value Posting" := DefDim."Value Posting"::"Same Code";
            //DefDim."Table Name" := TABLENAME;    code blocked for upgradation
            Vend."Pay-to Vendor No." := "No.";
            DefDim.INSERT;
        END;
        //mo tri1.0 Customization no.64 end


        IF "Invoice Disc. Code" = '' THEN
            "Invoice Disc. Code" := "No.";
        "Pay-to Vendor No." := "No.";

        //IF NOT InsertFromContact THEN
        //UpdateContFromVend.OnInsert(Rec);

        DimMgt.UpdateDefaultDim(
          DATABASE::Vendor, "No.",
          "Global Dimension 1 Code", "Global Dimension 2 Code");

        //-----Vrn
        "Gen. Bus. Posting Group" := 'DOMESTIC';
        "Excise Bus. Posting Group" := 'GEN';
        "Tax Liable" := TRUE;
        //--<<
    end;

    trigger OnModify()
    var
        DimValue: Record "Dimension Value";
    begin
        "Last Date Modified" := TODAY;

        /*
        IF IsContactUpdateNeeded THEN BEGIN
          MODIFY;
          UpdateContFromVend.OnModify(Rec);
          IF NOT FIND THEN BEGIN
            RESET;
            IF FIND THEN;
          END;
        END;
        */

        //mo tri1.0 customization no. 64 start
        GLSetup.GET;
        GLSetup.TESTFIELD(GLSetup."Vendor Dimension Code");
        IF DimValue.GET(GLSetup."Vendor Dimension Code", "No.") THEN BEGIN
            DimValue.VALIDATE(Name, Name);
            DimValue.MODIFY;
        END;
        //mo tri1.0 customization no. 64 end

        //"No. Series Code" := "Country/Region Code" + "Zone Region" +

    end;

    trigger OnRename()
    var
        "...tri1.0": Integer;
        GLSetup: Record "General Ledger Setup";
        DefDim: Record "Default Dimension";
        DimValue: Record "Dimension Value";
    begin
        "Last Date Modified" := TODAY;
        EditableAllowed;

        /* //--Vrn
        //mo tri1.0 Customization no.64 start
        //To add the generated customer no. as dimension value.
        GLSetup.GET;
        GLSetup.TESTFIELD(GLSetup."Vendor Dimension Code");
        IF DimValue.GET(GLSetup."Vendor Dimension Code",xRec."No.") THEN
          DimValue.DELETE;
        DimValue.INIT;
        DimValue.VALIDATE("Dimension Code",GLSetup."Vendor Dimension Code");
        DimValue.VALIDATE(Code,"No.");
        DimValue.VALIDATE(Name,"No.");
        DimValue.INSERT;
        
        //To add the dimension value as default dimension
        GLSetup.GET;
        GLSetup.TESTFIELD(GLSetup."Vendor Dimension Code");
        IF DefDim.GET(23,xRec."No.",GLSetup."Vendor Dimension Code") THEN
          DefDim.DELETE;
        DefDim.INIT;
        DefDim."Table ID" := 23;
        DefDim."No." := "No.";
        DefDim."Dimension Code" := GLSetup."Vendor Dimension Code";
        DefDim."Dimension Value Code" := DimValue.Code;
        DefDim."Value Posting" :=  DefDim."Value Posting"::" ";
        //DefDim."Table Name" := TABLENAME;   code blocked for upgradation
        DefDim.INSERT;
        //mo tri1.0 Customization no.64 end
        */

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
        ItemCrossReference: Record "Item Reference";
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
        Vend: Record "Vendor Requisition";
        GSTVendorTypeErr: Label 'State code should be empty,If GST Vendor Type %1.', Comment = '%1=GST Vendor Type';
        Vendserv: Record "SMS - Mobile No.";
        AggTurnoverErr: Label 'You can change Aggregate Turnover only for Unregistered Vendor.';
        GSTARNErr: Label 'Either GST Registration No. or ARN No. should have a value.';
        PANErr: Label 'PAN No. must be entered.';
        GSTPANErr: Label 'Please update GST Registration No. to blank in the record %1 from Order Address.', Comment = '%1 = GST Registration No.';
        SamePANErr: Label 'From postion 3 to 12 in GST Registration No. should be same as it is in PAN No. so delete and then update it.';
        NewSequenceNo: Integer;
        VendorClass: Code[1];
        ZoneRegion: Code[2];


    procedure AssistEdit(OldVend: Record "Vendor Requisition"): Boolean
    var
        Vend: Record "Vendor Requisition";
    begin
        WITH Vend DO BEGIN
            Vend := Rec;
            PurchSetup.GET;
            PurchSetup.TESTFIELD("Vendor Nos.");
            IF NoSeriesMgt.SelectSeries(PurchSetup."Vendor Nos. 2", OldVend."No. Series", "No. Series") THEN BEGIN
                PurchSetup.GET;
                PurchSetup.TESTFIELD("Vendor Nos. 2");
                NoSeriesMgt.SetSeries("No.");
                Rec := Vend;
                EXIT(TRUE);
            END;
        END;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::Vendor, "No.", FieldNumber, ShortcutDimCode);
        MODIFY;
    end;


    procedure ShowContact()
    var
        ContBusRel: Record "Contact Business Relation";
        Cont: Record Contact;
    begin
        IF "No." = '' THEN
            EXIT;

        /* //MSVrn _300622
        ContBusRel.SETCURRENTKEY("Link to Table","No.");
        ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Vendor);
        ContBusRel.SETRANGE("No.","No.");
        IF NOT ContBusRel.FINDFIRST THEN BEGIN
          IF NOT CONFIRM(Text003,FALSE,TABLECAPTION,"No.") THEN
            EXIT;
          UpdateContFromVend.InsertNewContact(Rec,FALSE);
          ContBusRel.FINDFIRST;
        END;
        COMMIT;
        
        Cont.SETCURRENTKEY("Company Name","Company No.",Type,Name);
        Cont.SETRANGE("Company No.",ContBusRel."Contact No.");
        PAGE.RUN(PAGE::"Contact List",Cont);
        */

    end;


    procedure SetInsertFromContact(FromContact: Boolean)
    begin
        InsertFromContact := FromContact;
    end;


    procedure CheckBlockedVendOnDocs(Vend2: Record Vendor; Transaction: Boolean)
    begin
        IF Vend2."Privacy Blocked" THEN
            VendPrivacyBlockedErrorMessage(Vend2, Transaction);

        IF Vend2.Blocked = Vend2.Blocked::All THEN
            VendBlockedErrorMessage(Vend2, Transaction);
    end;


    procedure CheckBlockedVendOnJnls(Vend2: Record Vendor; DocType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund; Transaction: Boolean)
    begin
        WITH Vend2 DO BEGIN
            IF "Privacy Blocked" THEN
                VendPrivacyBlockedErrorMessage(Vend2, Transaction);

            IF (Blocked = Blocked::All) OR
               (Blocked = Blocked::Payment) AND (DocType = DocType::Payment)
            THEN
                VendBlockedErrorMessage(Vend2, Transaction);
        END;
    end;


    procedure CreateAndShowNewInvoice()
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Invoice;
        PurchaseHeader.SETRANGE("Buy-from Vendor No.", "No.");
        PurchaseHeader.INSERT(TRUE);
        COMMIT;
        //16225   PAGE.RUNMODAL(PAGE::"Mini Purchase Invoice", PurchaseHeader)
    end;


    procedure CreateAndShowNewCreditMemo()
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::"Credit Memo";
        PurchaseHeader.SETRANGE("Buy-from Vendor No.", "No.");
        PurchaseHeader.INSERT(TRUE);
        COMMIT;
        //16225  PAGE.RUNMODAL(PAGE::"Mini Purchase Credit Memo", PurchaseHeader)
    end;


    procedure VendBlockedErrorMessage(Vend2: Record Vendor; Transaction: Boolean)
    var
        "Action": Text[30];
    begin
        IF Transaction THEN
            Action := Text005
        ELSE
            Action := Text006;

        IF (UPPERCASE(USERID) <> 'admin') THEN
            ERROR(Text007, Action, Vend2."No.", Vend2.Blocked);
    end;


    procedure VendPrivacyBlockedErrorMessage(Vend2: Record Vendor; Transaction: Boolean)
    var
        "Action": Text[30];
    begin
        IF Transaction THEN
            Action := Text005
        ELSE
            Action := Text006;

        ERROR(PrivacyBlockedActionErr, Action, Vend2."No.");
    end;


    procedure GetPrivacyBlockedGenericErrorText(Vend2: Record Vendor): Text[250]
    begin
        EXIT(STRSUBSTNO(PrivacyBlockedGenericTxt, Vend2."No."));
    end;

    procedure DisplayMap()
    var
        MapPoint: Record "Online Map Setup";
        MapMgt: Codeunit "Online Map Management";
    begin
        IF MapPoint.FINDFIRST THEN
            MapMgt.MakeSelection(DATABASE::Vendor, GETPOSITION)
        ELSE
            MESSAGE(Text011);
    end;


    procedure CalcOverDueBalance() OverDueBalance: Decimal
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        VendLedgEntryRemainAmtQuery: Query "Vend. Ledg. Entry Remain. Amt.";
    begin
        VendLedgEntryRemainAmtQuery.SETRANGE(Vendor_No, "No.");
        VendLedgEntryRemainAmtQuery.SETRANGE(IsOpen, TRUE);
        VendLedgEntryRemainAmtQuery.SETFILTER(Due_Date, '<%1', WORKDATE);
        VendLedgEntryRemainAmtQuery.OPEN;

        IF VendLedgEntryRemainAmtQuery.READ THEN
            OverDueBalance := -VendLedgEntryRemainAmtQuery.Sum_Remaining_Amt_LCY;
    end;

    local procedure UpdateDedName()
    var
    //  Form26Q27QEntry: Record 16505; //16225 TABLE N/F
    begin
        //16225 TABLE N/F START
        /* Form26Q27QEntry.RESET;
         Form26Q27QEntry.SETRANGE(Revised,FALSE);
         Form26Q27QEntry.SETRANGE(Filed,FALSE);
         Form26Q27QEntry.SETRANGE("Party Type",Form26Q27QEntry."Party Type"::Vendor);
         Form26Q27QEntry.SETRANGE("Party Code","No.");
         IF Form26Q27QEntry.FINDFIRST THEN
           Form26Q27QEntry.MODIFYALL("Deductee Name",Name);*/
        //16225 TABLE N/F END 
    end;

    local procedure UpdateDedPAN()
    var
    //  Form26Q27QEntry: Record 16505; //16225 TABLE N/F
    begin
        //16225 TABLE N/F START
        IF "P.A.N. Status" <> 0 THEN
            ERROR(Text16500);
        /*  Form26Q27QEntry.RESET;
          Form26Q27QEntry.SETRANGE(Revised,FALSE);
          Form26Q27QEntry.SETRANGE(Filed,FALSE);
          Form26Q27QEntry.SETRANGE("Party Type",Form26Q27QEntry."Party Type"::Vendor);
          Form26Q27QEntry.SETRANGE("Party Code","No.");
          IF Form26Q27QEntry.FINDFIRST THEN
            Form26Q27QEntry.MODIFYALL("Deductee P.A.N. No.","P.A.N. No.");*/
        //16225 TABLE N/F END
    end;


    procedure GetInvoicedPrepmtAmountLCY(): Decimal
    var
        PurchLine: Record "Purchase Line";
    begin
        PurchLine.SETCURRENTKEY("Document Type", "Pay-to Vendor No.");
        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Order);
        PurchLine.SETRANGE("Pay-to Vendor No.", "No.");
        PurchLine.CALCSUMS("Prepmt. Amount Inv. (LCY)", "Prepmt. VAT Amount Inv. (LCY)");
        EXIT(PurchLine."Prepmt. Amount Inv. (LCY)" + PurchLine."Prepmt. VAT Amount Inv. (LCY)");
    end;

    local procedure ValidatePurchaserCode()
    begin
        IF "Purchaser Code" <> '' THEN
            IF SalespersonPurchaser.GET("Purchaser Code") THEN
                IF SalespersonPurchaser.VerifySalesPersonPurchaserPrivacyBlocked(SalespersonPurchaser) THEN
                    ERROR(SalespersonPurchaser.GetPrivacyBlockedGenericText(SalespersonPurchaser, FALSE))
    end;


    procedure GetTotalAmountLCY(): Decimal
    begin
        CALCFIELDS(
          "Balance (LCY)", "Outstanding Orders (LCY)", "Amt. Rcd. Not Invoiced (LCY)", "Outstanding Invoices (LCY)");

        EXIT(
          "Balance (LCY)" + "Outstanding Orders (LCY)" +
          "Amt. Rcd. Not Invoiced (LCY)" + "Outstanding Invoices (LCY)" - GetInvoicedPrepmtAmountLCY);
    end;

    procedure "--MIPL,MSBS.Rao---"()
    begin
    end;


    procedure CreateForBell(RecVend: Record Vendor; DocumentNO: Code[20])
    var
        RecVendor: Record Vendor;
        ToCompany: Text[50];
        VendorCode: Code[20];
        Err0001: Label 'Please contact your system administrator !!!';
    begin
        WITH RecVendor DO BEGIN
            IF COMPANYNAME = 'Orient Bell Limited' THEN BEGIN
                ToCompany := 'Orient Bell Limited';
                VendorCode := RecVendor."No.";
                RecVendor.CHANGECOMPANY(ToCompany);
                IF NOT RecVendor.GET(VendorCode) THEN BEGIN
                    RecVendor.TRANSFERFIELDS(Rec);
                    RecVendor.INSERT;
                END;
                RecVend.RESET;
                RecVend.SETRANGE("No.", DocumentNO);
                IF RecVend.FINDFIRST THEN BEGIN
                    RecVend."Create for Bell" := TRUE;
                    RecVend.MODIFY;
                END;
            END ELSE
                ERROR(Err0001);
        END;
    end;


    procedure CreateForOrient(RecVend: Record Vendor; DocumentNO: Code[20])
    var
        RecVendor: Record Vendor;
        ToCompany: Text[50];
        VendorCode: Code[20];
        Err0001: Label 'Please contact your system administrator !!!';
    begin
        WITH RecVendor DO BEGIN
            IF COMPANYNAME = 'Orient Bell Limited' THEN BEGIN
                ToCompany := 'Orient Bell Limited';
                VendorCode := RecVendor."No.";
                RecVendor.CHANGECOMPANY(ToCompany);
                IF NOT RecVendor.GET(VendorCode) THEN BEGIN
                    RecVendor.TRANSFERFIELDS(Rec);
                    RecVendor.INSERT;
                END;
                RecVend.RESET;
                RecVend.SETRANGE("No.", DocumentNO);
                IF RecVend.FINDFIRST THEN BEGIN
                    RecVend."Create for Orient" := TRUE;
                    RecVend.MODIFY;
                END;
            END ELSE
                ERROR(Err0001);
        END;
    end;


    procedure CreateForAll(RecVend: Record Vendor; DocumentNO: Code[20])
    var
        RecVendor: Record Vendor;
        ToCompany: Text[50];
        RecCompany: Record Company;
        VendorCode: Code[20];
        Err0001: Label 'Please contact your system administrator !!!';
    begin
        WITH RecVendor DO BEGIN
            IF COMPANYNAME = 'Orient Bell Limited' THEN BEGIN
                IF RecCompany.FINDFIRST THEN BEGIN
                    REPEAT
                        ToCompany := RecCompany.Name;
                        VendorCode := RecVendor."No.";
                        RecVendor.CHANGECOMPANY(ToCompany);
                        IF NOT RecVendor.GET(VendorCode) THEN BEGIN
                            RecVendor.TRANSFERFIELDS(Rec);
                            RecVendor.INSERT;
                        END;
                    UNTIL RecCompany.NEXT = 0;
                END;
                RecVend.RESET;
                RecVend.SETRANGE("No.", DocumentNO);
                IF RecVend.FINDFIRST THEN BEGIN
                    RecVend."Create for Orient" := TRUE;
                    RecVend."Create for Bell" := TRUE;
                    RecVend.MODIFY;
                END;
            END ELSE
                ERROR(Err0001);
        END;
    end;

    local procedure GetVend(VendNo: Code[20])
    begin
        IF VendNo <> Vend."No." THEN
            Vend.GET(VendNo);
    end;

    procedure InsertSMSDetails(CurrentFieldNo: Integer)
    var
        RecMobileNo: Record "SMS - Mobile No.";
        SalesPerson: Record "Salesperson/Purchaser";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
    begin
        CASE CurrentFieldNo OF
            //*****************-Insert Sales Person Data-*****************

            FIELDNO("Purchaser Code"):
                BEGIN
                    IF SalespersonPurchaser.GET("Purchaser Code") THEN;
                    RecMobileNo.RESET;
                    RecMobileNo.SETRANGE("Link With", RecMobileNo."Link With"::Vendor);
                    RecMobileNo.SETRANGE("Link Code", "No.");
                    RecMobileNo.SETFILTER(Type, '%1', RecMobileNo.Type::"Sales Person");
                    RecMobileNo.SETFILTER("Mobile No.", '%1', SalespersonPurchaser."Phone No.");
                    IF RecMobileNo.FINDFIRST THEN
                        RecMobileNo.DELETEALL;

                    IF ("Purchaser Code" <> '') THEN
                        RecMobileNo.RESET;
                    RecMobileNo.SETRANGE("Link With", RecMobileNo."Link With"::Vendor);
                    RecMobileNo.SETRANGE("Link Code", "No.");
                    RecMobileNo.SETFILTER(Type, '%1', RecMobileNo.Type::"Sales Person");
                    IF NOT RecMobileNo.FINDFIRST THEN BEGIN
                        RecMobileNo.INIT;
                        RecMobileNo."Mobile No." := SalespersonPurchaser."Phone No.";
                        RecMobileNo."Link With" := RecMobileNo."Link With"::Vendor;
                        RecMobileNo."Link Code" := "No.";
                        RecMobileNo.Name := SalespersonPurchaser.Name;
                        RecMobileNo."Send Mobile Communication" := TRUE;
                        RecMobileNo.date := TODAY;
                        RecMobileNo.Type := RecMobileNo.Type::"Sales Person";
                        IF (SalespersonPurchaser."Phone No." <> '') AND (SalespersonPurchaser.Status = SalespersonPurchaser.Status::Enable) THEN
                            RecMobileNo.INSERT;
                    END;
                END;
            //*****************-Insert Customer Phone No. Data-*****************
            FIELDNO("Phone No."):
                BEGIN
                    RecMobileNo.RESET;
                    RecMobileNo.SETRANGE("Link With", RecMobileNo."Link With"::Vendor);
                    RecMobileNo.SETRANGE("Link Code", "No.");
                    RecMobileNo.SETFILTER(Type, '%1', RecMobileNo.Type::" ");
                    RecMobileNo.SETFILTER("Mobile No.", '%1', "Phone No.");
                    IF RecMobileNo.FINDFIRST THEN
                        RecMobileNo.DELETEALL;
                    IF "Phone No." <> '' THEN BEGIN
                        RecMobileNo.RESET;
                        RecMobileNo.SETRANGE("Link With", RecMobileNo."Link With"::Vendor);
                        RecMobileNo.SETRANGE("Link Code", "No.");
                        RecMobileNo.SETFILTER(Type, '%1', RecMobileNo.Type::" ");
                        IF NOT RecMobileNo.FINDFIRST THEN BEGIN
                            RecMobileNo.INIT;
                            RecMobileNo."Mobile No." := "Phone No.";
                            RecMobileNo."Link With" := RecMobileNo."Link With"::Vendor;
                            RecMobileNo."Link Code" := "No.";
                            RecMobileNo.Name := Name;
                            RecMobileNo."Send Mobile Communication" := TRUE;
                            RecMobileNo.date := TODAY;
                            RecMobileNo.Type := RecMobileNo.Type::" ";
                            RecMobileNo.INSERT;
                        END;
                    END;
                END;
        END;
    end;

    local procedure IsContactUpdateNeeded(): Boolean
    var
        VendContUpdate: Codeunit "VendCont-Update";
        UpdateNeeded: Boolean;
    begin
        UpdateNeeded :=
          (Name <> xRec.Name) OR
          ("Search Name" <> xRec."Search Name") OR
          ("Name 2" <> xRec."Name 2") OR
          (Address <> xRec.Address) OR
          ("Address 2" <> xRec."Address 2") OR
          (City <> xRec.City) OR
          ("Phone No." <> xRec."Phone No.") OR
          ("Telex No." <> xRec."Telex No.") OR
          ("Territory Code" <> xRec."Territory Code") OR
          ("Currency Code" <> xRec."Currency Code") OR
          ("Language Code" <> xRec."Language Code") OR
          ("Purchaser Code" <> xRec."Purchaser Code") OR
          ("Country/Region Code" <> xRec."Country/Region Code") OR
          ("Fax No." <> xRec."Fax No.") OR
          ("Telex Answer Back" <> xRec."Telex Answer Back") OR
          ("VAT Registration No." <> xRec."VAT Registration No.") OR
          ("Post Code" <> xRec."Post Code") OR
          (County <> xRec.County) OR
          ("E-Mail" <> xRec."E-Mail") OR
          ("Home Page" <> xRec."Home Page");

        IF NOT UpdateNeeded AND NOT ISTEMPORARY THEN
            UpdateNeeded := VendContUpdate.ContactNameIsBlank("No.");

        EXIT(UpdateNeeded);
    end;

    local procedure CheckGSTRegBlankInRef()
    var
        OrderAddress: Record "Order Address";
    begin
        OrderAddress.SETRANGE("Vendor No.", "No.");
        OrderAddress.SETFILTER("GST Registration No.", '<>%1', '');
        IF OrderAddress.FINDSET THEN
            REPEAT
                IF "P.A.N. No." <> COPYSTR(OrderAddress."GST Registration No.", 3, 10) THEN
                    ERROR(GSTPANErr, OrderAddress.Code);
            UNTIL OrderAddress.NEXT = 0;
    end;


    procedure GenerateNODNOCData(var Vendor: Record Vendor)
    var
    // NODNOCHeader: Record 13786; //16225 table N/F
    begin
        //16225 table N/F Start
        /*   IF Vendor."GST Registration No."='' THEN
             EXIT;
           NODNOCHeader.SETFILTER(Type,'%1',NODNOCHeader.Type::Vendor);
           NODNOCHeader.SETFILTER("No.",'%1',Vendor."No.");
           IF NOT NODNOCHeader.FINDFIRST THEN BEGIN
             NODNOCHeader.INIT;
             NODNOCHeader.Type := NODNOCHeader.Type::Vendor;
             NODNOCHeader."No." := Vendor."No.";
             NODNOCHeader.Name := Vendor.Name;
             NODNOCHeader."Assesse Code":= GetAssesseeCodefromGSTNo(Vendor);
             NODNOCHeader.INSERT;
           GenerateNODNOCLines(NODNOCHeader);
           END ELSE BEGIN
             NODNOCHeader.RESET;
             NODNOCHeader.SETFILTER(Type,'%1',NODNOCHeader.Type::Vendor);
             NODNOCHeader.SETFILTER("No.",'%1',Vendor."No.");
             IF NODNOCHeader.FINDFIRST THEN
              GenerateNODNOCLines(NODNOCHeader);
           END;*/
        //16225 table N/F End//
    end;

    /* local procedure GenerateNODNOCLines(NODNOCHeader: Record 13786)
     var
         NODNOCLines: Record 13785;
     begin
         NODNOCLines.SETFILTER(Type,'%1',NODNOCHeader.Type);
         NODNOCLines.SETFILTER("No.",'%1',NODNOCHeader."No.");
         NODNOCLines.SETFILTER("NOD/NOC",'%1','194Q');
         IF NODNOCLines.FINDFIRST THEN
           NODNOCLines.DELETE;

         NODNOCLines.INIT;
         NODNOCLines.Type := NODNOCHeader.Type;
         NODNOCLines."No." := NODNOCHeader."No.";
         NODNOCLines.TDS := TRUE;
         NODNOCLines.VALIDATE("NOD/NOC",'194Q');
         //NODNOCLines.Type := NODNOCHeader.Type;
         NODNOCLines.INSERT;
     end;*/

    local procedure GetAssesseeCodefromGSTNo(Vendor: Record Vendor): Code[10]
    var
        Assessee: Code[10];
    begin
        IF Vendor."GST Registration No." = '' THEN
            EXIT;
        IF STRLEN(Vendor."GST Registration No.") = 15 THEN BEGIN
            Assessee := COPYSTR(Vendor."GST Registration No.", 6, 1);
            //  MESSAGE(Assessee);
            CASE Assessee OF
                'C':
                    BEGIN
                        EXIT('COM');
                    END;
                'P':
                    BEGIN
                        EXIT('IND');
                    END;
                'H':
                    BEGIN
                        EXIT('HUF');
                    END;
                'F':
                    BEGIN
                        EXIT('FIRM');
                    END;
                'A':
                    BEGIN
                        EXIT('AOP');
                    END;
                'G':
                    BEGIN
                        EXIT('GOV');
                    END;
                'T':
                    BEGIN
                        EXIT('AOP');
                    END;

                ELSE
                    ERROR('Invalid GST No. %1', Vendor."No.");
            END;
        END;
    end;


    procedure SendForApproval(var VendorRequistion: Record "Vendor Requisition")
    var
        SalesLines: Record "Sales Line";
        RecCustomer: Record Customer;
        SmsMgt: Codeunit "SMS Sender - Due Date";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        SalespersonPurchaser1: Record "Salesperson/Purchaser";
        RequiredCreditApprovalAmt: Decimal;
        AvailableCrLimit: Decimal;
        SPApprovalLimit: Decimal;
        I: Integer;
        SPCode: Code[20];
        Customer: Record Customer;
        WorkflowUserGroupMember: Record "Workflow User Group Member";
        MailMgt: Codeunit "QD Test, PDF Creation & Email";
        VendorRep: Record "Vendor Requisition";
        Vendor: Record Vendor;
    begin
        IF Vendor.GET(VendorRequistion."No. Series Code") THEN BEGIN
            WorkflowUserGroupMember.RESET;
            WorkflowUserGroupMember.SETCURRENTKEY("Sequence No.");
            WorkflowUserGroupMember.SETFILTER("Workflow User Group Code", '%1', 'VENDEDIT');
            IF WorkflowUserGroupMember.FINDFIRST THEN BEGIN
                SPCode := WorkflowUserGroupMember."User Name";
                REPEAT
                    MakeApprovalEntry(USERID, WorkflowUserGroupMember."User Name", RequiredCreditApprovalAmt);
                    I += 1;
                UNTIL WorkflowUserGroupMember.NEXT = 0;
                CLEAR(MailMgt);
                MailMgt.CreateMailForVendorApproval1(VendorRequistion, SPCode, FALSE);
                VendorRequistion.VALIDATE(Status, VendorRequistion.Status::"Pending for Approval"); //Vrn
                VendorRequistion.MODIFY;
            END;
        END ELSE BEGIN
            WorkflowUserGroupMember.RESET;
            WorkflowUserGroupMember.SETCURRENTKEY("Sequence No.");
            WorkflowUserGroupMember.SETFILTER("Workflow User Group Code", '%1', 'VENDAPP');
            IF WorkflowUserGroupMember.FINDFIRST THEN BEGIN
                SPCode := WorkflowUserGroupMember."User Name";
                REPEAT
                    MakeApprovalEntry(USERID, WorkflowUserGroupMember."User Name", RequiredCreditApprovalAmt);
                    I += 1;
                UNTIL WorkflowUserGroupMember.NEXT = 0;
                CLEAR(MailMgt);
                MailMgt.CreateMailForVendorApproval1(VendorRequistion, SPCode, FALSE);
                VendorRequistion.VALIDATE(Status, VendorRequistion.Status::"Pending for Approval"); //Vrn
                VendorRequistion.MODIFY;
            END;
        END;
        IF Vendor.GET(VendorRequistion."No. Series Code") THEN
            Vendor.ArchiveVendor(Vendor, SPCode);
    end;

    procedure MakeApprovalEntry(SenderSPCode: Code[20]; ApprovalSPCode: Code[20]; DiscountAmt: Decimal)
    var
        ApprovalEntry: Record "Approval Entry";
        //  ApprovalSetup: Record 452;
        EntryNo: Integer;
        VendorReplica: Record "Vendor Requisition";
        LastEmailID: Text;
        UserSetup: Record "User Setup";
    begin
        WITH ApprovalEntry DO BEGIN
            ApprovalEntry.RESET;
            IF ApprovalEntry.FINDLAST THEN
                EntryNo := ApprovalEntry."Entry No.";

            SETRANGE("Table ID", 50062);
            SETRANGE("Document Type", "Document Type"::"Credit Limit");
            SETRANGE("Document No.", "No.");
            IF FINDLAST THEN BEGIN
                NewSequenceNo := "Sequence No." + 1;
                LastEmailID := EmailID;
            END ELSE
                NewSequenceNo := 1;
            "Entry No." := EntryNo + 1;
            "Table ID" := 50062;
            "Document Type" := "Document Type"::"Credit Limit";
            "Document No." := "No.";
            // "Salespers./Purch. Code" := SenderSPCode;

            "Sequence No." := NewSequenceNo;
            "Approval Code" := 'VENDAPP';
            "Sender ID" := USERID;
            "Approver ID" := ApprovalSPCode;
            Amount := DiscountAmt;
            "Amount (LCY)" := DiscountAmt;
            Status := Status::Created;
            "Currency Code" := "Currency Code";
            "Date-Time Sent for Approval" := CREATEDATETIME(TODAY, TIME);
            "Last Date-Time Modified" := CREATEDATETIME(TODAY, TIME);
            "Last Modified By ID1" := USERID;
            /// "Due Date" := CALCDATE(ApprovalSetup."Due Date Formula", TODAY);
            //ApprovalSPCode := GetNextSalesPersonIFOnLeave(ApprovalSPCode); //MSKS2007
            //ApprovalEntry."Approver Code" := ApprovalSPCode;
            ApprovalEntry."Comment Text" := '';
            //MSKS1705 Start
            IF UserSetup.GET(ApprovalSPCode) THEN
                IF UserSetup."E-Mail" <> '' THEN
                    ApprovalEntry.EmailID := UserSetup."E-Mail";
            //MSKS1705 End

            //  "Approval Type" := ApprovalTemplates."Approval Type";
            //  "Limit Type" := ApprovalTemplates."Limit Type";
            VendorReplica.RESET;
            VendorReplica.SETRANGE("No.", "No.");
            IF VendorReplica.FINDFIRST THEN
                ApprovalEntry."Record ID to Approve" := VendorReplica.RECORDID;
            IF LastEmailID <> ApprovalEntry.EmailID THEN
                INSERT(TRUE);
        END;
    end;


    procedure vendorApproval(ApprovalEntry: Record "Approval Entry")
    var
        AppApprovalEntry: Record "Approval Entry";
        VendorRequisition: Record "Vendor Requisition";
        VendorReqNo: Code[20];
        MailMgt: Codeunit "QD Test, PDF Creation & Email";
        IsFinalApproval: Boolean;
        SPCode: Code[50];
        Vendor: Record Vendor;
    begin
        IsFinalApproval := FALSE;
        VendorReqNo := ApprovalEntry."Document No.";
        VendorRequisition.RESET;
        VendorRequisition.SETRANGE("No.", VendorReqNo);
        IF VendorRequisition.FINDFIRST THEN BEGIN

            AppApprovalEntry.RESET;
            AppApprovalEntry.SETRANGE("Table ID", 50062);
            AppApprovalEntry.SETRANGE("Document No.", ApprovalEntry."Document No.");
            AppApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Created);
            IF AppApprovalEntry.FINDFIRST THEN BEGIN
                SPCode := AppApprovalEntry."Approver ID";
                VendorRequisition.VALIDATE(Status, VendorRequisition.Status::"Pending for Approval");
                // "Pending Approval UserID" := '';
                VendorRequisition."Approver ID" := AppApprovalEntry."Approver ID"; //Vrn
                VendorRequisition.MODIFY;
            END ELSE BEGIN
                IsFinalApproval := TRUE;
                //EmailTo := GetEmailID(AppApprovalEntry."Authorization 1");
                SPCode := ApprovalEntry."Sender ID";
                VendorRequisition.VALIDATE(Status, VendorRequisition.Status::Approved);
                // "Pending Approval UserID" := '';
                VendorRequisition.MODIFY;
                //Transfer Vendor
                VendorRequisition.CALCFIELDS(Picture);
                IF Vendor.GET(VendorRequisition."No. Series Code") THEN BEGIN
                    Vendor.TRANSFERFIELDS(VendorRequisition);
                    Vendor.Blocked := Vendor.Blocked::" ";
                    Vendor."No." := VendorRequisition."No. Series Code";
                    Vendor."Pay-to Vendor No." := Vendor."No.";
                    Vendor.MODIFY;
                END ELSE BEGIN
                    Vendor.INIT;
                    Vendor.TRANSFERFIELDS(VendorRequisition);
                    Vendor.Blocked := Vendor.Blocked::" ";
                    Vendor."No." := VendorRequisition."No. Series Code";
                    Vendor."Pay-to Vendor No." := Vendor."No.";
                    Vendor.INSERT;
                END;
            END;
            CLEAR(MailMgt);
            // MailMgt.CreateMailForVendorApproval1(VendorRequisition, SPCode, IsFinalApproval);
        END;
    end;


    procedure CancelApprovalEntries(var VendorRequisition: Record "Vendor Requisition")
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        VendorRequisition.TESTFIELD(Status, VendorRequisition.Status::"Pending for Approval");

        ApprovalEntry.RESET;
        ApprovalEntry.SETFILTER("Table ID", '%1', 50062);
        ApprovalEntry.SETFILTER("Document No.", '%1', VendorRequisition."No.");
        ApprovalEntry.SETFILTER(Status, '%1|%2', ApprovalEntry.Status::Created, ApprovalEntry.Status::Open);
        IF ApprovalEntry.FINDFIRST THEN BEGIN
            REPEAT
                ApprovalEntry.VALIDATE(Status, ApprovalEntry.Status::"Canceled");
                ApprovalEntry.MODIFY;
            UNTIL ApprovalEntry.NEXT = 0;
        END;
        //BudgetMaster."Rejected Date & Time" := CURRENTDATETIME();
        VendorRequisition.VALIDATE(Status, VendorRequisition.Status::Open);
        VendorRequisition.VALIDATE(Approved, FALSE);
        ///VendorRequisition."Pending Approval UserID" := '';

        VendorRequisition.MODIFY;
        CancelNotification(VendorRequisition);
    end;


    procedure CancelNotification(var VendorRequisition: Record "Vendor Requisition")
    var
        //  SMTPMailCodeunit: Codeunit 400;
        SrNo: Integer;
        RecCust: Record Customer;
        //  SMTPMailSetup: Record 409;
        CompInfo: Record "Company Information";
        Usersetup1: Record "User Setup";
        Usersetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        EmailTo: Text[150];
        EmailCC: Text[150];
        Text50002: Label 'sanuj.sharma@orientbell.com';
        Text50000: Label 'Indent Details :';
        Text50010: Label ' <br/> ';
        Text50011: Label 'Description :-  ';
        Text50012: Label 'Remarks :-  ';
        Text50013: Label 'Reason:';
        Text59999: Label '<html>';
        Text60000: Label '<Table>';
        Text60001: Label '<TR Border=4>';
        Text60002: Label '<TD  width=200 Align=Left>';
        Text60003: Label '</TD>';
        Text60004: Label '</TR>';
        Text60005: Label '</Table>';
        Text60006: Label '</html>';
        Text60007: Label '<TD  width=500 Align=Left>';
        Text60008: Label '<TD  width=100 Align=Center>';
        Text60009: Label '<TD Align=Left>';
        Text60010: Label '<TD  width=800 Align=right>';
        Text60011: Label '<BR>';
        Text60012: Label '<B>';
        Text60013: Label '</B>';
        Text60014: Label '<TD  width=850 Align=right>';
        Text60015: Label '<font size="3"> ';
        Text60016: Label '</font>';
        Text50022: Label 'Mail Sent Successfully !!!!';
        Text50023: Label 'This is to advice that the following shipment is being despatched from our factory as follows.';
        Text50024: Label '<TD  width=1000 Align=Left>';
        Text50025: Label 'This e-Mail is auto generated from Microsoft Dynamics Navison ERP.';
        Text50026: Label '<TR>';
        Text50027: Label '<table border="1" width="70%">';
        Text50028: Label '<TH>';
        Text50029: Label '</TH>';
        Text50030: Label '<td width="20%">';
        Text50031: Label '<td width="50%">';
        Text50032: Label '<FONT SIZE=6 FACE="Sans Serif">';
        Text50041: Label '<TD  width=5 Align=Center>';
        Email3: Text;
        UserSetup6: Record "User Setup";
        CommentLine: Record "Comment Line";
        I: Integer;
        Comments: Text;
        Amt: Decimal;
        EmailCC1: Text[150];
        IndentAppLink: Text[250];
        ShortLink: Text[250];
        ApprovalEntry: Record "Approval Entry";
        PurchaseLine1: Record "Purchase Line";
        TxtBoldBegin: Text;
        TxtBoldEnd: Text;
        Amt2: Decimal;
        ApproverName: Code[100];
        ApprovalEntry1: Record "Approval Entry";
        UserName: Text[100];
        UserSetup7: Record "User Setup";
        ApprovalEntry2: Record "Approval Entry";
        DRAPrice: Decimal;
        SKDPrice: Decimal;
        HSKPrice: Decimal;
        AttachmentManagment: Record "Attachment Management";
        FilePath: Text;
        FileName: Text;
        Text50090: Label '<TR  bgcolor="#80ff80">';
        Text50091: Label '<TD  width=5 Align=Center bgcolor="#80ff80"> ';
        BudgetDesc: Text;
        BudgetRemark: Text;
        ApprovalMgt: Codeunit "QD Test, PDF Creation & Email";
        BodyText: Text;
        EmailObj: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        EmailCCList: List of [Text];
        EmailAddressList: List of [Text];
        FileMgmt: Codeunit "File Management";
        EmailBccList: list of [Text];
        TempBlobCU: Codeunit "Temp Blob";
        InstreamVar: InStream;
        OutstreamVar: OutStream;

    begin
        Clear(EmailAddressList);
        Clear(EmailCCList);
        Clear(EmailBccList);

        //   SMTPMailSetup.GET;
        //   SMTPMailSetup.TESTFIELD("User ID");
        SrNo := 1;
        //   CLEAR(SMTPMailCodeunit);
        ApprovalEntry1.RESET;
        ApprovalEntry1.SETRANGE("Table ID", 50062);
        ApprovalEntry1.SETFILTER("Document No.", '%1', VendorRequisition."No.");
        ApprovalEntry1.SETFILTER(Status, '%1', ApprovalEntry1.Status::Rejected);
        IF ApprovalEntry1.FINDLAST THEN BEGIN
            IF Usersetup1.GET(ApprovalEntry1."Approver ID") THEN BEGIN
                ApproverName := Usersetup1."User Name";
                UserSetup7.GET(ApprovalEntry1."Sender ID");
                EmailTo := UserSetup7."E-Mail";
            END;
            BodyText := 'The Vendor No. ' + FORMAT(VendorRequisition."No.") + ' - ' + VendorRequisition.Name + ' has been Rejected by ' + ApproverName + ' .';
        END;
        EmailAddressList.Add('donotreply@orientbell.com');
        IF EmailTo <> '' THEN
            /* SMTPMailCodeunit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
             EmailTo, 'Vendor No. ' + VendorRequisition."No." + ' ' + ' - ' + FORMAT(VendorRequisition.Status) + ' [Rejection]', '', TRUE)*/ // 16225

            EmailMsg.Create(EmailAddressList, 'Vendor No. ' + VendorRequisition."No." + ' ' + ' - ' + FORMAT(VendorRequisition.Status) + ' [Rejection]', BodyText, true, EmailBccList, EmailCCList)

        ELSE
            /*  SMTPMailCodeunit.CreateMessage('Orient Bell Limited.', 'donotreply@orientbell.com',
              'donotreply@orientbell.com', 'Vendor No. ' + VendorRequisition."No." + ' ' + ' - ' + FORMAT(VendorRequisition.Status) + ' [Rejection]', '', TRUE);*/ // 16225
            EmailAddressList.Add('donotreply@orientbell.com');
        EmailMsg.Create(EmailAddressList, 'Vendor No. ' + VendorRequisition."No." + ' ' + ' - ' + FORMAT(VendorRequisition.Status) + ' [Rejection]', BodyText, true, EmailBccList, EmailCCList);



        EmailCCList.add('kulbhushan.sharma@orientbell.com');
        EmailCCList.add('kulwant@mindshell.info');

        BodyText := 'Dear Sir,';
        BodyText += Text50010;
        BodyText += '<br><br>';

        BodyText += BodyText;

        BodyText += Text50026 + Text50041 + FORMAT('' + Text60003);
        BodyText += Text50041 + FORMAT('') + Text60003;
        BodyText += Text50041 + FORMAT('') + Text60003;
        BodyText += Text50041 + FORMAT('') + Text60003;
        BodyText += Text50041 + FORMAT('') + Text60003;
        BodyText += Text50041 + FORMAT('') + Text60003;
        BodyText += Text50041 + FORMAT('') + Text60003;
        BodyText += Text50041 + FORMAT('') + Text60003;
        BodyText += Text50041 + FORMAT('') + Text60003;
        BodyText += Text50041 + FORMAT('') + Text60003;
        BodyText += Text60004;
        //MSKS
        BodyText += Text60004;
        BodyText += Text60005;
        BodyText += Text60006;
        BodyText += Text60011;
        //Table End
        BodyText += Comments;
        BodyText += Text60011;

        ApprovalEntry2.RESET;
        ApprovalEntry2.SETRANGE("Table ID", 50062);
        ApprovalEntry2.SETRANGE("Document No.", VendorRequisition."No.");
        ApprovalEntry2.SETRANGE(Status, ApprovalEntry1.Status::Rejected);
        ApprovalEntry2.SETFILTER("Comment Text", '<>%1', '');
        IF ApprovalEntry2.FINDFIRST THEN BEGIN
            REPEAT
                BodyText += 'Date & Time: ' + FORMAT(ApprovalEntry2."Last Date-Time Modified") +
                                              'Commented By : ' + ApprovalEntry2."Approver ID" +
                                              'Comment :' + ApprovalEntry2."Comment Text" + '<br>';
            UNTIL ApprovalEntry2.NEXT = 0;
            ;
        END;

        BodyText += 'Yours Truly, <br>';
        BodyText += 'For Orient Bell Limited  <br>';
        IF UserSetup6.GET(USERID) THEN
            BodyText += FORMAT(UserSetup6."User Name") + '<br>';

        SLEEP(100);
        EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        SLEEP(100);
        IF GUIALLOWED THEN
            MESSAGE('Mail has been sent for Vendor Cancellation!');
    end;


    procedure GetVendorNoSeries()
    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
        VendorNExtNo: Code[10];
    begin
        //V-NOSERIES
        IF "No. Series Code" = '' THEN BEGIN
            CASE "Vendor Class" OF
                "Vendor Class"::Domestic:
                    VendorClass := 'D';

                "Vendor Class"::Employee:
                    VendorClass := 'E';

                "Vendor Class"::Importer:
                    VendorClass := 'I';
            END;

            CASE "Zone Region" OF
                "Zone Region"::East:
                    ZoneRegion := '1';

                "Zone Region"::Exim:
                    ZoneRegion := '2';

                "Zone Region"::North:
                    ZoneRegion := '3';

                "Zone Region"::South:
                    ZoneRegion := '4';

                "Zone Region"::West:
                    ZoneRegion := '5';

            END;
            CLEAR(NoSeriesManagement);
            VendorNExtNo := NoSeriesManagement.GetNextNo('V-NOSERIES', TODAY, TRUE);

            IF "Zone Region" = "Zone Region"::Exim THEN
                "No. Series Code" := VendorClass + "Country/Region Code" + ZoneRegion + "State Code" + VendorNExtNo
            ELSE
                "No. Series Code" := VendorClass + "Country/Region Code" + ZoneRegion + "State Code" + VendorNExtNo;

            // ,East,West,South,North,Exim

            // ,Domestic,Importer,Employee
        END;
    end;

    local procedure EditableAllowed()
    begin
        /*IF Status <> Status::Open THEN
          ERROR('Modification not Allowed');
          */

    end;


    procedure GetUserName(): Text
    var
        UserSetup: Record "User Setup";
    begin
        IF UserSetup.GET("Approver ID") THEN
            EXIT(UserSetup."User Name");
    end;

    procedure CheckGSTRegistrationNo(StateCode: Code[10]; RegistrationNo: Code[15]; PANNo: Code[20])
    var
        State: Record State;
        Position: Integer;
        LengthErr: Label 'The Length of the GST Registration Nos. must be 15.';
        StateCodeErr: Label 'The GST Registration No. for the state %1 should start with %2.';

    begin
        IF RegistrationNo = '' THEN
            EXIT;
        IF STRLEN(RegistrationNo) <> 15 THEN
            ERROR(LengthErr);
        State.GET(StateCode);
        IF State."State Code (GST Reg. No.)" <> COPYSTR(RegistrationNo, 1, 2) THEN
            ERROR(StateCodeErr, StateCode, State."State Code (GST Reg. No.)");

        IF PANNo <> '' THEN
            IF PANNo <> COPYSTR(RegistrationNo, 3, 10) THEN
                ERROR(SamePanErr, PANNo);

        FOR Position := 3 TO 15 DO
            CASE Position OF
                3 .. 7, 12:
                    CheckIsAlphabet(RegistrationNo, Position);
                8 .. 11:
                    CheckIsNumeric(RegistrationNo, Position);
                13:
                    CheckIsAlphaNumeric(RegistrationNo, Position);
                14:
                    CheckForZValue(RegistrationNo, Position);
                15:
                    CheckIsAlphaNumeric(RegistrationNo, Position)
            END;
    end;

    local procedure CheckIsAlphabet(RegistrationNo: Code[15]; Position: Integer)
    var
        OnlyAlphabetErr: Label 'Only Alphabet is allowed in the position %1.';
    begin
        IF NOT (COPYSTR(RegistrationNo, Position, 1) IN ['A' .. 'Z']) THEN
            ERROR(OnlyAlphabetErr, Position);
    end;

    local procedure CheckIsNumeric(RegistrationNo: Code[15]; Position: Integer)
    var
        OnlyNumericErr: Label 'Only Numeric is allowed in the position %1.';
    begin
        IF NOT (COPYSTR(RegistrationNo, Position, 1) IN ['0' .. '9']) THEN
            ERROR(OnlyNumericErr, Position);
    end;

    local procedure CheckIsAlphaNumeric(RegistrationNo: Code[15]; Position: Integer)
    var
        OnlyAlphaNumericErr: Label 'Only AlphaNumeric is allowed in the position %1.';
    begin
        IF NOT ((COPYSTR(RegistrationNo, Position, 1) IN ['0' .. '9']) OR (COPYSTR(RegistrationNo, Position, 1) IN ['A' .. 'Z'])) THEN
            ERROR(OnlyAlphaNumericErr, Position);
    end;

    local procedure CheckForZValue(RegistrationNo: Code[15]; Position: Integer)
    var
        OnlyZErr: Label 'Only Z value is allowed in the position %1.';
    begin
        IF NOT (COPYSTR(RegistrationNo, Position, 1) IN ['Z']) THEN
            ERROR(OnlyZErr, Position);
    end;





    procedure ReOpen()
    begin
        TESTFIELD(Status, Status::Approved);
        VALIDATE(Status, Status::Open);
        VALIDATE(Approved, FALSE);
    end;
}

