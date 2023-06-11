table 99300 "Purchase Header Temp"
{
    Caption = 'Purchase Header';
    DataCaptionFields = "No.", "Buy-from Vendor Name";
    LookupPageID = "Purchase List";

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            TableRelation = Vendor;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(4; "Pay-to Vendor No."; Code[20])
        {
            Caption = 'Pay-to Vendor No.';
            TableRelation = Vendor;
        }
        field(5; "Pay-to Name"; Text[30])
        {
            Caption = 'Pay-to Name';
        }
        field(6; "Pay-to Name 2"; Text[30])
        {
            Caption = 'Pay-to Name 2';
        }
        field(7; "Pay-to Address"; Text[30])
        {
            Caption = 'Pay-to Address';
        }
        field(8; "Pay-to Address 2"; Text[30])
        {
            Caption = 'Pay-to Address 2';
        }
        field(9; "Pay-to City"; Text[30])
        {
            Caption = 'Pay-to City';
        }
        field(10; "Pay-to Contact"; Text[30])
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
            TableRelation = "Ship-to Address"."Code" WHERE("Customer No." = FIELD("Sell-to Customer No."));
        }
        field(13; "Ship-to Name"; Text[30])
        {
            Caption = 'Ship-to Name';
        }
        field(14; "Ship-to Name 2"; Text[30])
        {
            Caption = 'Ship-to Name 2';
        }
        field(15; "Ship-to Address"; Text[30])
        {
            Caption = 'Ship-to Address';
        }
        field(16; "Ship-to Address 2"; Text[30])
        {
            Caption = 'Ship-to Address 2';
        }
        field(17; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
        }
        field(18; "Ship-to Contact"; Text[30])
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

            trigger OnValidate()
            var
                NoSeries: Record "No. Series";
            begin
            end;
        }
        field(21; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
        }
        field(22; "Posting Description"; Text[50])
        {
            Caption = 'Posting Description';
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
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(1));
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(2));
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
        }
        field(45; "Order Class"; Code[10])
        {
            Caption = 'Order Class';
        }
        field(46; Comment; Boolean)
        {
            CalcFormula = Exist("Purch. Comment Line" WHERE("Document Type" = FIELD("Document Type"),
                                                             "No." = FIELD("No.")));
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
        }
        field(55; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account";
        }
        field(56; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
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
            Caption = 'Amount';
            Editable = false;
        }
        field(61; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
            Editable = false;
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
        field(78; "VAT Country Code"; Code[10])
        {
            Caption = 'VAT Country Code';
        }
        field(79; "Buy-from Vendor Name"; Text[30])
        {
            Caption = 'Buy-from Vendor Name';
        }
        field(80; "Buy-from Vendor Name 2"; Text[30])
        {
            Caption = 'Buy-from Vendor Name 2';
        }
        field(81; "Buy-from Address"; Text[30])
        {
            Caption = 'Buy-from Address';
        }
        field(82; "Buy-from Address 2"; Text[30])
        {
            Caption = 'Buy-from Address 2';
        }
        field(83; "Buy-from City"; Text[30])
        {
            Caption = 'Buy-from City';
        }
        field(84; "Buy-from Contact"; Text[30])
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
        field(87; "Pay-to Country Code"; Code[10])
        {
            Caption = 'Pay-to Country Code';
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
        field(90; "Buy-from Country Code"; Code[10])
        {
            Caption = 'Buy-from Country Code';
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
        field(93; "Ship-to Country Code"; Code[10])
        {
            Caption = 'Ship-to Country Code';
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
        }
        field(119; "VAT Base Discount %"; Decimal)
        {
            Caption = 'VAT Base Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(120; Status; Option)
        {
            Caption = 'Status';
            Editable = true;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
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
        field(5043; "No. of Archived Versions"; Integer)
        {
            Caption = 'No. of Archived Versions';
            Editable = false;
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
        field(13701; "TDS Assessee Code"; Code[20])
        {
            TableRelation = "Return Shipment Header";
        }
        field(13705; "Tax Registration No."; Text[20])
        {
        }
        field(13706; "Tax Country Code"; Code[10])
        {
        }
        field(13712; "Excise Bus. Posting Group"; Code[10])
        {
            // TableRelation = "Excise Bus. Posting Group";
        }
        field(13713; "Excise Registration No."; Text[20])
        {
        }
        field(13716; "Amount Including Tax"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13723; "Form Code"; Code[10])
        {
            //16225 "State Forms" Table N/F
            /*TableRelation = IF ("C Form"=CONST(false)) "State Forms"."Form Code" WHERE (State=FIELD(State),
                                                                                   "Transit Document"=CONST(false))
                                                                                   ELSE IF ("C Form"=CONST(true)) "Form Codes".Code WHERE ("C Form"=CONST(true));*/
        }
        field(13724; "Form No."; Code[10])
        {
            //16225 "Tax Forms Details" Table N/F
            /* TableRelation = IF ("C Form"=CONST(fales)) "Tax Forms Details"."Form No." WHERE ("Form Code"=FIELD("Form Code"),
                                                                                         Issued=CONST(false),
                                                                                         State=FIELD(State))
                                                                                         ELSE IF ("C Form"=CONST(true)) "Tax Forms Details"."Form No." WHERE ("Form Code"=FIELD("Form Code"),
                                                                                                                                                           Issued=CONST(false));*/
        }
        field(13740; "Import Document"; Boolean)
        {
            Editable = false;
        }
        field(13742; "Incentive Type"; Option)
        {
            OptionMembers = " ","Adv. License",DFRC;
        }
        field(13743; EPCG; Boolean)
        {
        }
        field(13744; "Incentive No."; Code[20])
        {
        }
        field(13745; "EPCG No."; Code[20])
        {
        }
        field(13746; "Export Order No."; Code[20])
        {
            Editable = false;
        }
        field(13747; "Duty Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13748; "Cap Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13749; "Spares Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13750; "Import Quantity Value"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13751; "Allocated Incentive Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13752; "Amount Including Duties"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13755; DEPB; Boolean)
        {
        }
        field(13756; "Allocated Incentive Amount-CP"; Decimal)
        {
            Editable = false;
        }
        field(13757; "Allocated Incentive Amount-SP"; Decimal)
        {
            Editable = false;
        }
        field(13758; "Customs Currency Factor"; Decimal)
        {
            DecimalPlaces = 0 : 15;
        }
        field(13759; "Transit Document"; Boolean)
        {
        }
        field(13760; "LC No."; Code[20])
        {
            /* TableRelation = "LC Detail"."No." WHERE("Transaction Type" = CONST(Purchase),
                                                    "Issued To/Received From" = FIELD("Pay-to Vendor No."),
                                                    Closed = CONST(false),
                                                    Released = CONST(true));*/
        }
        field(13761; State; Code[20])
        {
            Editable = true;
            TableRelation = State;
        }
        field(13790; Structure; Code[10])
        {
            // TableRelation = "Structure Header"; //16225 table n/f

            trigger OnValidate()
            var
                //StrDetails: Record 13793;
                //StrOrderDetails: Record 13794;
                //StrOrderLines: Record 13795;
                PurchaseLines: Record "Purchase Line";
            begin
            end;
        }
        field(16340; "Sent for Authorization"; Boolean)
        {
        }
        field(16341; Authorized; Boolean)
        {
        }
        field(16342; Declined; Boolean)
        {
        }
        field(16343; "User ID"; Code[20])
        {
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(16350; "VAT Business Posting Group"; Code[10])
        {
        }
        field(16360; Subcontracting; Boolean)
        {
        }
        field(16361; New; Boolean)
        {
        }
        field(16371; "Subcon. Order No."; Code[10])
        {
            Description = 'For Debit Note';
        }
        field(16372; "Subcon. Order Line No."; Integer)
        {
            Description = 'For Debit Note';
        }
        field(16373; SubConPostLine; Integer)
        {
        }
        field(16375; "Vendor Shipment Date"; Date)
        {
        }
        field(16376; "C Form"; Boolean)
        {
            Caption = 'C Form';
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
            TableRelation = "RFQ No.";
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
            Description = 'Report 49';
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
        field(50019; "Transporter Name"; Text[30])
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
        field(60002; "Locked Order"; Boolean)
        {
            Description = 'TRI DG';
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
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Buy-from Vendor No.", "No.")
        {
        }
        key(Key3; "Buy-from Vendor No.", "Vendor Authorization No.")
        {
        }
        key(Key4; Subcontracting)
        {
        }
        key(Key5; "Vendor Classification", "No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
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
        //"--NAVIN--": ;
        Text041: Label 'The LC which you have selected is Foreign type you cannot utilise for this order.';
        Text042: Label 'You cannot change the structure.';
        //"...tri1.0": ;
        Text0001: Label 'Status must be Open while changing  the "Buy- from Post code" ';
}

