table 50042 "Rejection Purchase Header"
{
    DataCaptionFields = "Rejection No.", "No.", "Buy-from Vendor Name";
    LookupPageID = "Rejection List";

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            Editable = false;
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            Editable = false;
            TableRelation = Vendor;

            trigger OnValidate()
            var
                //NODHeader: Record 13786; //16225 TABLE N/F
                Location1: Record Location;
            begin
            end;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(4; "Pay-to Vendor No."; Code[20])
        {
            Caption = 'Pay-to Vendor No.';
            NotBlank = true;
            TableRelation = Vendor;
        }
        field(5; "Pay-to Name"; Text[100])
        {
            Caption = 'Pay-to Name';
        }
        field(6; "Pay-to Name 2"; Text[50])
        {
            Caption = 'Pay-to Name 2';
        }
        field(7; "Pay-to Address"; Text[50])
        {
            Caption = 'Pay-to Address';
        }
        field(8; "Pay-to Address 2"; Text[50])
        {
            Caption = 'Pay-to Address 2';
        }
        field(9; "Pay-to City"; Text[30])
        {
            Caption = 'Pay-to City';
        }
        field(10; "Pay-to Contact"; Text[50])
        {
            Caption = 'Pay-to Contact';
        }
        field(11; "Your Reference"; Text[30])
        {
            Caption = 'Your Reference';
        }
        field(12; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Sell-to Customer No."));
        }
        field(13; "Ship-to Name"; Text[100])
        {
            Caption = 'Ship-to Name';
        }
        field(14; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
        }
        field(15; "Ship-to Address"; Text[50])
        {
            Caption = 'Ship-to Address';
        }
        field(16; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
        }
        field(17; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
        }
        field(18; "Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
        }
        field(19; "Order Date"; Date)
        {
            Caption = 'Order Date';
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(21; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
        }
        field(22; "Posting Description"; Text[250])
        {
            Caption = 'Posting Description';
            Description = '50>>250,TRI DG';
        }
        field(23; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(24; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(25; "Payment Discount %"; Decimal)
        {
            Caption = 'Payment Discount %';
            DecimalPlaces = 0 : 5;
        }
        field(26; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';
        }
        field(27; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(28; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(31; "Vendor Posting Group"; Code[10])
        {
            Caption = 'Vendor Posting Group';
            Editable = false;
            TableRelation = "Vendor Posting Group";
        }
        field(32; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(33; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(35; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';

            trigger OnValidate()
            var
                PurchLine: Record "Purchase Line";
                Currency: Record Currency;
                RecalculatePrice: Boolean;
            begin
            end;
        }
        field(37; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';
        }
        field(41; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(43; "Purchaser Code"; Code[10])
        {
            Caption = 'Purchaser Code';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                ApprovalEntry: Record "Approval Entry";
            begin
            end;
        }
        field(45; "Order Class"; Code[10])
        {
            Caption = 'Order Class';
        }
        field(46; Comment; Boolean)
        {
            CalcFormula = Exist("Purch. Comment Line" WHERE("Document Type" = FIELD("Document Type"),
                                                             "No." = FIELD("No."),
                                                             "Document Line No." = CONST(0)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(47; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            Editable = false;
        }
        field(51; "On Hold"; Code[3])
        {
            Caption = 'On Hold';
        }
        field(52; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(53; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnValidate()
            var
                VendLedgEntry: Record "Vendor Ledger Entry";
            begin
            end;
        }
        field(55; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account";
        }
        field(57; Receive; Boolean)
        {
            Caption = 'Receive';
        }
        field(58; Invoice; Boolean)
        {
            Caption = 'Invoice';
        }
        field(60; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line".Amount WHERE("Document Type" = FIELD("Document Type"),
                                                            "Document No." = FIELD("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Amount Including VAT" WHERE("Document Type" = FIELD("Document Type"),
                                                                            "Document No." = FIELD("No.")));
            Caption = 'Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Receiving No."; Code[20])
        {
            Caption = 'Receiving No.';
        }
        field(63; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
        }
        field(64; "Last Receiving No."; Code[20])
        {
            Caption = 'Last Receiving No.';
            Editable = false;
            TableRelation = "Purch. Rcpt. Header";
        }
        field(65; "Last Posting No."; Code[20])
        {
            Caption = 'Last Posting No.';
            Editable = false;
            TableRelation = "Purch. Inv. Header";
        }
        field(66; "Vendor Order No."; Code[20])
        {
            Caption = 'Vendor Order No.';
        }
        field(67; "Vendor Shipment No."; Code[20])
        {
            Caption = 'Vendor Shipment No.';
        }
        field(68; "Vendor Invoice No."; Code[20])
        {
            Caption = 'Vendor Invoice No.';
        }
        field(69; "Vendor Cr. Memo No."; Code[20])
        {
            Caption = 'Vendor Cr. Memo No.';
        }
        field(70; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
        }
        field(72; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;
        }
        field(73; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(76; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(77; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(78; "VAT Country/Region Code"; Code[10])
        {
            Caption = 'VAT Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(79; "Buy-from Vendor Name"; Text[100])
        {
            Caption = 'Buy-from Vendor Name';
        }
        field(80; "Buy-from Vendor Name 2"; Text[50])
        {
            Caption = 'Buy-from Vendor Name 2';
        }
        field(81; "Buy-from Address"; Text[50])
        {
            Caption = 'Buy-from Address';
        }
        field(82; "Buy-from Address 2"; Text[50])
        {
            Caption = 'Buy-from Address 2';
        }
        field(83; "Buy-from City"; Text[30])
        {
            Caption = 'Buy-from City';
        }
        field(84; "Buy-from Contact"; Text[50])
        {
            Caption = 'Buy-from Contact';
        }
        field(85; "Pay-to Post Code"; Code[20])
        {
            Caption = 'Pay-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(86; "Pay-to County"; Text[30])
        {
            Caption = 'Pay-to County';
        }
        field(87; "Pay-to Country/Region Code"; Code[10])
        {
            Caption = 'Pay-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(88; "Buy-from Post Code"; Code[20])
        {
            Caption = 'Buy-from Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(89; "Buy-from County"; Text[30])
        {
            Caption = 'Buy-from County';
        }
        field(90; "Buy-from Country/Region Code"; Code[10])
        {
            Caption = 'Buy-from Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(91; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(92; "Ship-to County"; Text[30])
        {
            Caption = 'Ship-to County';
        }
        field(93; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(94; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(95; "Order Address Code"; Code[10])
        {
            Caption = 'Order Address Code';
            TableRelation = "Order Address".Code WHERE("Vendor No." = FIELD("Buy-from Vendor No."));

            trigger OnValidate()
            var
                PayToVend: Record Vendor;
            begin
            end;
        }
        field(97; "Entry Point"; Code[10])
        {
            Caption = 'Entry Point';
            TableRelation = "Entry/Exit Point";
        }
        field(98; Correction; Boolean)
        {
            Caption = 'Correction';
        }
        field(99; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(101; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(102; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(104; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(107; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(108; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
        }
        field(109; "Receiving No. Series"; Code[10])
        {
            Caption = 'Receiving No. Series';
            TableRelation = "No. Series";
        }
        field(114; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(115; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(116; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(118; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';

            trigger OnValidate()
            var
                TempVendLedgEntry: Record "Vendor Ledger Entry";
            begin
            end;
        }
        field(119; "VAT Base Discount %"; Decimal)
        {
            Caption = 'VAT Base Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            var
                ChangeLogMgt: Codeunit "Change Log Management";
                RecRef: RecordRef;
                xRecRef: RecordRef;
            begin
            end;
        }
        field(120; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(121; "Invoice Discount Calculation"; Option)
        {
            Caption = 'Invoice Discount Calculation';
            Editable = false;
            OptionCaption = 'None,%,Amount';
            OptionMembers = "None","%",Amount;
        }
        field(122; "Invoice Discount Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Invoice Discount Value';
            Editable = false;
        }
        field(123; "Send IC Document"; Boolean)
        {
            Caption = 'Send IC Document';
        }
        field(124; "IC Status"; Option)
        {
            Caption = 'IC Status';
            OptionCaption = 'New,Pending,Sent';
            OptionMembers = New,Pending,Sent;
        }
        field(125; "Buy-from IC Partner Code"; Code[20])
        {
            Caption = 'Buy-from IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(126; "Pay-to IC Partner Code"; Code[20])
        {
            Caption = 'Pay-to IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(129; "IC Direction"; Option)
        {
            Caption = 'IC Direction';
            OptionCaption = 'Outgoing,Incoming';
            OptionMembers = Outgoing,Incoming;
        }
        field(130; "Prepayment No."; Code[20])
        {
            Caption = 'Prepayment No.';
        }
        field(131; "Last Prepayment No."; Code[20])
        {
            Caption = 'Last Prepayment No.';
            TableRelation = "Purch. Inv. Header";
        }
        field(132; "Prepmt. Cr. Memo No."; Code[20])
        {
            Caption = 'Prepmt. Cr. Memo No.';
        }
        field(133; "Last Prepmt. Cr. Memo No."; Code[20])
        {
            Caption = 'Last Prepmt. Cr. Memo No.';
            TableRelation = "Purch. Cr. Memo Hdr.";
        }
        field(134; "Prepayment %"; Decimal)
        {
            Caption = 'Prepayment %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(135; "Prepayment No. Series"; Code[10])
        {
            Caption = 'Prepayment No. Series';
            TableRelation = "No. Series";
        }
        field(136; "Compress Prepayment"; Boolean)
        {
            Caption = 'Compress Prepayment';
            InitValue = true;
        }
        field(137; "Prepayment Due Date"; Date)
        {
            Caption = 'Prepayment Due Date';
        }
        field(138; "Prepmt. Cr. Memo No. Series"; Code[10])
        {
            Caption = 'Prepmt. Cr. Memo No. Series';
            TableRelation = "No. Series";
        }
        field(139; "Prepmt. Posting Description"; Text[50])
        {
            Caption = 'Prepmt. Posting Description';
        }
        field(142; "Prepmt. Pmt. Discount Date"; Date)
        {
            Caption = 'Prepmt. Pmt. Discount Date';
        }
        field(143; "Prepmt. Payment Terms Code"; Code[10])
        {
            Caption = 'Prepmt. Payment Terms Code';
            TableRelation = "Payment Terms";

            trigger OnValidate()
            var
                PaymentTerms: Record "Payment Terms";
            begin
            end;
        }
        field(144; "Prepmt. Payment Discount %"; Decimal)
        {
            Caption = 'Prepmt. Payment Discount %';
            DecimalPlaces = 0 : 5;
        }
        field(151; "Quote No."; Code[20])
        {
            Caption = 'Quote No.';
            Editable = false;
        }
        field(5043; "No. of Archived Versions"; Integer)
        {
            CalcFormula = Max("Purchase Header Archive"."Version No." WHERE("Document Type" = FIELD("Document Type"),
                                                                             "No." = FIELD("No."),
                                                                             "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence")));
            Caption = 'No. of Archived Versions';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
        }
        field(5050; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            TableRelation = Campaign;
        }
        field(5052; "Buy-from Contact No."; Code[20])
        {
            Caption = 'Buy-from Contact No.';
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            begin
            end;

            trigger OnValidate()
            var
                ContBusinessRelation: Record "Contact Business Relation";
                Cont: Record Contact;
            begin
            end;
        }
        field(5053; "Pay-to Contact No."; Code[20])
        {
            Caption = 'Pay-to Contact No.';
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            begin
            end;

            trigger OnValidate()
            var
                ContBusinessRelation: Record "Contact Business Relation";
                Cont: Record Contact;
            begin
            end;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(5752; "Completely Received"; Boolean)
        {
            CalcFormula = Min("Purchase Line"."Completely Received" WHERE("Document Type" = FIELD("Document Type"),
                                                                           "Document No." = FIELD("No."),
                                                                           "Type" = FILTER(<> ' '),
                                                                           "Location Code" = FIELD("Location Filter")));
            Caption = 'Completely Received';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5753; "Posting from Whse. Ref."; Integer)
        {
            Caption = 'Posting from Whse. Ref.';
        }
        field(5754; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(5790; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';
        }
        field(5791; "Promised Receipt Date"; Date)
        {
            Caption = 'Promised Receipt Date';
        }
        field(5792; "Lead Time Calculation"; DateFormula)
        {
            Caption = 'Lead Time Calculation';
        }
        field(5793; "Inbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Inbound Whse. Handling Time';
        }
        field(5796; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(5800; "Vendor Authorization No."; Code[20])
        {
            Caption = 'Vendor Authorization No.';
        }
        field(5801; "Return Shipment No."; Code[20])
        {
            Caption = 'Return Shipment No.';
        }
        field(5802; "Return Shipment No. Series"; Code[10])
        {
            Caption = 'Return Shipment No. Series';
            TableRelation = "No. Series";
        }
        field(5803; Ship; Boolean)
        {
            Caption = 'Ship';
        }
        field(5804; "Last Return Shipment No."; Code[20])
        {
            Caption = 'Last Return Shipment No.';
            Editable = false;
            TableRelation = "Return Shipment Header";
        }
        field(9000; "Assigned User ID"; Code[20])
        {
            Caption = 'Assigned User ID';
            TableRelation = "User Setup";
        }
        field(13701; "Assessee Code"; Code[10])
        {
            Caption = 'Assessee Code';
            TableRelation = "Assessee Code";
        }
        field(13712; "Excise Bus. Posting Group"; Code[10])
        {
            Caption = 'Excise Bus. Posting Group';
            //TableRelation = "Excise Bus. Posting Group"; //16225 Table N/F
        }
        field(13716; "Amount to Vendor"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            //16225 Table Field N/F
            /* CalcFormula = Sum("Purchase Line"."Amount To Vendor" WHERE ("Document Type"=FIELD("Document Type"),
                                                                         "Document No."=FIELD("No.")));*/
            Caption = 'Amount to Vendor';
            Editable = false;
            //FieldClass = FlowField;
        }
        field(13723; "Form Code"; Code[10])
        {
            Caption = 'Form Code';
            //16225 Table State Forms" N/F
            /*TableRelation = IF (C Form=CONST(No)) "State Forms"."Form Code" WHERE (State=FIELD(State),
                                                                                   Transit Document=CONST(No))
                                                                                   ELSE IF (C Form=CONST(Yes)) "Form Codes".Code WHERE (C Form=CONST(Yes));*/
        }
        field(13724; "Form No."; Code[10])
        {
            Caption = 'Form No.';
            //16225 Table "Tax Forms Details" N/F
            /* TableRelation = IF (C Form=CONST(No)) "Tax Forms Details"."Form No." WHERE (Form Code=FIELD(Form Code),
                                                                                         Issued=CONST(No),
                                                                                         State=FIELD(State))
                                                                                         ELSE IF (C Form=CONST(Yes)) "Tax Forms Details"."Form No." WHERE (Form Code=FIELD(Form Code),
                                                                                                                                                           Issued=CONST(No));*/

            trigger OnValidate()
            var
            // SalesFormsDetails: Record "13757"; //16225 Table N/F
            begin
            end;
        }
        field(13759; "Transit Document"; Boolean)
        {
            Caption = 'Transit Document';
        }
        field(13760; "LC No."; Code[20])
        {
            Caption = 'LC No.';
            //16225 Table "LC Detail" N/F
            /* TableRelation = "LC Detail".No. WHERE (Transaction Type=CONST(Purchase),
                                                    Issued To/Received From=FIELD(Pay-to Vendor No.),
                                                    Closed=CONST(No),
                                                    Released=CONST(Yes));*/

            trigger OnValidate()
            var
                //LCDetail: Record 16300; //16225 Table N/F
                Text13700: Label 'The LC which you have selected is Foreign type you cannot utilise for this order.';
            begin
            end;
        }
        field(13761; State; Code[20])
        {
            Caption = 'State';
            TableRelation = State;
        }
        field(13790; Structure; Code[10])
        {
            Caption = 'Structure';
            //16225 table N/F "Structure Header"
            // TableRelation = "Structure Header" WHERE ("Structure Type"=FILTER('Purchase'|'Others'));

            trigger OnValidate()
            var
                //StrDetails: Record 13793; //16225 Table N/F
                //StrOrderDetails: Record 13794;//16225 Table N/F
                //StrOrderLines: Record 13795;//16225 Table N/F
                PurchaseLines: Record "Purchase Line";
            begin
            end;
        }
        field(16360; Subcontracting; Boolean)
        {
            Caption = 'Subcontracting';
        }
        field(16371; "Subcon. Order No."; Code[10])
        {
            Caption = 'Subcon. Order No.';
        }
        field(16372; "Subcon. Order Line No."; Integer)
        {
            Caption = 'Subcon. Order Line No.';
        }
        field(16373; SubConPostLine; Integer)
        {
            Caption = 'SubConPostLine';
        }
        field(16375; "Vendor Shipment Date"; Date)
        {
            Caption = 'Vendor Shipment Date';
        }
        field(16376; "C Form"; Boolean)
        {
            Caption = 'C Form';
        }
        field(16377; "Consignment Note No."; Code[20])
        {
            Caption = 'Consignment Note No.';
        }
        field(16378; "Declaration Form (GTA)"; Boolean)
        {
            Caption = 'Declaration Form (GTA)';
        }
        field(16379; "GTA Service Type"; Option)
        {
            Caption = 'GTA Service Type';
            OptionCaption = ' ,Inward GTA,Outward GTA Stock Transfer,Outward GTA Input Service,Outward GTA';
            OptionMembers = " ","Inward GTA","Outward GTA Stock Transfer","Outward GTA Input Service","Outward GTA";
        }
        field(16500; "Manufacturer E.C.C. No."; Code[20])
        {
            Caption = 'Manufacturer E.C.C. No.';
        }
        field(16501; "Manufacturer Name"; Text[30])
        {
            Caption = 'Manufacturer Name';
        }
        field(16502; "Manufacturer Address"; Text[30])
        {
            Caption = 'Manufacturer Address';
        }
        field(16503; Trading; Boolean)
        {
            Caption = 'Trading';
        }
        field(16504; "Transaction No. Serv. Tax"; Integer)
        {
            Caption = 'Transaction No. Serv. Tax';
        }
        field(16505; CVD; Boolean)
        {
            Caption = 'CVD';
        }
        field(16506; "Input Service Distribution"; Boolean)
        {
            Caption = 'Input Service Distribution';
        }
        field(16522; "Service Tax Rounding Precision"; Decimal)
        {
            Caption = 'Service Tax Rounding Precision';
        }
        field(16523; "Service Tax Rounding Type"; Option)
        {
            Caption = 'Service Tax Rounding Type';
            OptionCaption = 'Nearest,Up,Down';
            OptionMembers = Nearest,Up,Down;
        }
        field(50000; Deleted; Boolean)
        {
        }
        field(50001; "New Status"; Option)
        {
            OptionMembers = " ","Short Close",Cancel;
        }
        field(50002; "RFQ No."; Code[20])
        {
            Description = 'customization 3';
            NotBlank = true;
        }
        field(50003; "Vendor Classification"; Code[10])
        {
            Description = 'customization 22';
            TableRelation = "Customer Type".Code WHERE(Type = FILTER(= Vendor));
        }
        field(50004; "Security Amount"; Decimal)
        {
            Description = 'customization 22';
        }
        field(50005; "Security Date"; Date)
        {
            Description = 'customization 22';
        }
        field(50006; "Value of Order"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Line Amount" WHERE("Document Type" = FIELD("Document Type"),
                                                                   "Document No." = FIELD("No.")));
            Description = 'Report 49';
            FieldClass = FlowField;
        }
        field(50009; "Vendor Invoice Date"; Date)
        {
        }
        field(50012; "Document Received from Bank"; Boolean)
        {
            Description = 'Report 84 EXIM';
        }
        field(50013; "Document Receiving Date"; Date)
        {
            Description = 'Report 84 EXIM';
        }
        field(50014; "Main Location"; Code[10])
        {
        }
        field(50015; "GE No."; Code[20])
        {
        }
        field(50016; "Transporter's Code"; Code[20])
        {
            TableRelation = Vendor WHERE(Transporter1 = FILTER(true));

            trigger OnValidate()
            var
                vendor: Record Vendor;
            begin
            end;
        }
        field(50017; "Quotation No."; Code[20])
        {
        }
        field(50018; "State Desc."; Text[50])
        {
            Editable = false;
        }
        field(50019; "Transporter Name"; Text[50])
        {
            Editable = false;
        }
        field(50020; "Delivery Period"; Text[30])
        {
        }
        field(50021; "Form 31 Amount"; Decimal)
        {
        }
        field(50022; "Currency Code 1"; Code[50])
        {
            Description = 'ND';
            TableRelation = Currency;
        }
        field(50023; "Terms of Delivery"; Option)
        {
            OptionCaption = ' ,FOB,EXW,C&W,CIF';
            OptionMembers = " ",FOB,EXW,"C&W",CIF;
        }
        field(50024; "Capital PO"; Boolean)
        {
            Description = 'TRI VS';
        }
        field(50025; "Ordered Qty"; Decimal)
        {
            CalcFormula = Sum("Purchase Line".Quantity WHERE("Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50026; "Total Recd. Quantity"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Quantity Received" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(60002; "Locked Order"; Boolean)
        {
        }
        field(60003; "Delivary Date"; Date)
        {
        }
        field(60004; "Shortage CRN"; Boolean)
        {
        }
        field(60006; "PUrchase Type"; Option)
        {
            OptionMembers = "Purchase Order No.","Work Order No.........";
        }
        field(60007; "Quotation Date"; Date)
        {
        }
        field(60008; Rejected; Boolean)
        {
            Editable = false;
        }
        field(60010; "Rejection No."; Code[20])
        {
            Editable = false;
            NotBlank = true;
        }
        field(60012; "Rejection created by"; Code[20])
        {
            Editable = false;
        }
        field(60013; "Store Rejection No"; Code[20])
        {
        }
        field(60014; "MRN No."; Code[20])
        {
            CalcFormula = Lookup("Purch. Rcpt. Header"."No." WHERE("Order No." = FIELD("No."),
                                                                  "Vendor Invoice No." = FIELD("Vendor Invoice No.")));
            Description = 'TRI V.D 08.11.10 - New Field Added.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60015; "Amendment No."; Code[10])
        {
        }
        field(60016; "Amendment Date"; Date)
        {
        }
        field(99008500; "Date Received"; Date)
        {
            Caption = 'Date Received';
        }
        field(99008501; "Time Received"; Time)
        {
            Caption = 'Time Received';
        }
        field(99008504; "BizTalk Purchase Quote"; Boolean)
        {
            Caption = 'BizTalk Purchase Quote';
        }
        field(99008505; "BizTalk Purch. Order Cnfmn."; Boolean)
        {
            Caption = 'BizTalk Purch. Order Cnfmn.';
        }
        field(99008506; "BizTalk Purchase Invoice"; Boolean)
        {
            Caption = 'BizTalk Purchase Invoice';
        }
        field(99008507; "BizTalk Purchase Receipt"; Boolean)
        {
            Caption = 'BizTalk Purchase Receipt';
        }
        field(99008508; "BizTalk Purchase Credit Memo"; Boolean)
        {
            Caption = 'BizTalk Purchase Credit Memo';
        }
        field(99008509; "Date Sent"; Date)
        {
            Caption = 'Date Sent';
        }
        field(99008510; "Time Sent"; Time)
        {
            Caption = 'Time Sent';
        }
        field(99008511; "BizTalk Request for Purch. Qte"; Boolean)
        {
            Caption = 'BizTalk Request for Purch. Qte';
        }
        field(99008512; "BizTalk Purchase Order"; Boolean)
        {
            Caption = 'BizTalk Purchase Order';
        }
        field(99008520; "Vendor Quote No."; Code[20])
        {
            Caption = 'Vendor Quote No.';
        }
        field(99008521; "BizTalk Document Sent"; Boolean)
        {
            Caption = 'BizTalk Document Sent';
        }
    }

    keys
    {
        key(Key1; "Rejection No.")
        {
            Clustered = true;
        }
        key(Key2; "Vendor Invoice No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text000: Label 'Do you want to print receipt %1?';
        Text001: Label 'Do you want to print invoice %1?';
        Text002: Label 'Do you want to print credit memo %1?';
        Text003: Label 'You cannot rename a %1.';
        Text004: Label 'Do you want to change %1?';
        Text005: Label 'You cannot reset %1 because the document still has one or more lines.';
        Text006: Label 'You cannot change %1 because the order is associated with one or more sales orders.';
        Text007: Label '%1 is greater than %2 in the %3 table.\';
        Text008: Label 'Confirm change?';
        Text009: Label 'Deleting this document will cause a gap in the number series for receipts. ';
        Text010: Label 'An empty receipt %1 will be created to fill this gap in the number series.\\';
        Text011: Label 'Do you want to continue?';
        Text012: Label 'Deleting this document will cause a gap in the number series for posted invoices. ';
        Text013: Label 'An empty posted invoice %1 will be created to fill this gap in the number series.\\';
        Text014: Label 'Deleting this document will cause a gap in the number series for posted credit memos. ';
        Text015: Label 'An empty posted credit memo %1 will be created to fill this gap in the number series.\\';
        Text016: Label 'If you change %1, the existing purchase lines will be deleted and new purchase lines based on the new information in the header will be created.\\';
        Text018: Label 'You must delete the existing purchase lines before you can change %1.';
        Text019: Label 'You have changed %1 on the purchase header, but it has not been changed on the existing purchase lines.\';
        Text020: Label 'You must update the existing purchase lines manually.';
        Text021: Label 'The change may affect the exchange rate used on the price calculation of the purchase lines.';
        Text022: Label 'Do you want to update the exchange rate?';
        Text023: Label 'You cannot delete this document. Your identification is set up to process from %1 %2 only.';
        Text024: Label 'Do you want to print return shipment %1?';
        Text025: Label 'You have modified the %1 field. Note that the recalculation of VAT may cause penny differences, so you must check the amounts afterwards. ';
        Text027: Label 'Do you want to update the %2 field on the lines to reflect the new value of %1?';
        Text028: Label 'Your identification is set up to process from %1 %2 only.';
        Text029: Label 'Deleting this document will cause a gap in the number series for return shipments. ';
        Text030: Label 'An empty return shipment %1 will be created to fill this gap in the number series.\\';
        Text032: Label 'You have modified %1.\\';
        Text033: Label 'Do you want to update the lines?';
        Text034: Label 'You cannot change the %1 when the %2 has been filled in.';
        Text037: Label 'Contact %1 %2 is not related to vendor %3.';
        Text038: Label 'Contact %1 %2 is related to a different company than vendor %3.';
        Text039: Label 'Contact %1 %2 is not related to a vendor.';
        Text040: Label 'You can not change the %1 field because %2 %3 has %4 = %5 and the %6 has already been assigned %7 %8.';
        Text041: Label 'The purchase %1 %2 has item tracking. Do you want to delete it anyway?';
        Text042: Label 'You must cancel the approval process if you wish to change the %1.';
        Text043: Label 'Do you want to print prepayment invoice %1?';
        Text044: Label 'Do you want to print prepayment credit memo %1?';
        Text045: Label 'Deleting this document will cause a gap in the number series for prepayment invoices. ';
        Text046: Label 'An empty prepayment invoice %1 will be created to fill this gap in the number series.\\';
        Text047: Label 'Deleting this document will cause a gap in the number series for prepayment credit memos. ';
        Text049: Label '%1 is set up to process from %2 %3 only.';
        Text050: Label 'Reservations exist for this order. These reservations will be cancelled if a date conflict is caused by this change.\\';
        Text16500: Label 'Trading can''t be true when Excise Loading On Inventory on lines has been checked.';
        //"...tri1.0": ; //16225
        Text0001: Label 'Status must be Open while changing  the "Buy- from Post code" ';
        Text0002: Label 'Vendor Inv. Date must be later then Posting Date';

    procedure AssistEdit(OldRejectionNote: Record "Rejection Purchase Header"): Boolean
    begin
        PurchSetup.GET;

        TestNoSeries;
        IF NoSeriesMgt.SelectSeries(GetNoSeriesCode, OldRejectionNote."No. Series", "No. Series") THEN BEGIN
            PurchSetup.GET;
            TestNoSeries;
            NoSeriesMgt.SetSeries("Rejection No.");
            EXIT(TRUE);
        END;
    end;

    local procedure TestNoSeries(): Boolean
    begin
        CASE "Document Type" OF
            "Document Type"::Quote:
                PurchSetup.TESTFIELD("Quote Nos.");
            "Document Type"::Order:
                BEGIN
                    IF NOT Subcontracting THEN
                        PurchSetup.TESTFIELD(PurchSetup."Reject No.")
                    ELSE
                        PurchSetup.TESTFIELD("Subcontracting Order Nos.");
                END;
            "Document Type"::Invoice:
                BEGIN
                    PurchSetup.TESTFIELD("Invoice Nos.");
                    PurchSetup.TESTFIELD("Posted Invoice Nos.");
                END;
            "Document Type"::"Return Order":
                PurchSetup.TESTFIELD("Return Order Nos.");
            "Document Type"::"Credit Memo":
                BEGIN
                    PurchSetup.TESTFIELD("Credit Memo Nos.");
                    PurchSetup.TESTFIELD("Posted Credit Memo Nos.");
                END;
            "Document Type"::"Blanket Order":
                PurchSetup.TESTFIELD("Blanket Order Nos.");
        END;
    end;

    local procedure GetNoSeriesCode(): Code[10]
    begin
        CASE "Document Type" OF
            "Document Type"::Quote:
                EXIT(PurchSetup."Quote Nos.");
            "Document Type"::Order:
                BEGIN
                    IF NOT Subcontracting THEN
                        EXIT(PurchSetup."Reject No.")
                    ELSE
                        EXIT(PurchSetup."Subcontracting Order Nos.");
                END;
            "Document Type"::Invoice:
                EXIT(PurchSetup."Invoice Nos.");
            "Document Type"::"Return Order":
                EXIT(PurchSetup."Return Order Nos.");
            "Document Type"::"Credit Memo":
                EXIT(PurchSetup."Credit Memo Nos.");
            "Document Type"::"Blanket Order":
                EXIT(PurchSetup."Blanket Order Nos.");
        END;
    end;
}

