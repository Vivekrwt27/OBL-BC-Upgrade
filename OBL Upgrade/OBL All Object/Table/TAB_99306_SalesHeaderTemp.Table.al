table 99306 "Sales Header Temp"
{
    Caption = 'Sales Header';
    DataCaptionFields = "No.", "Sell-to Customer Name";
    LookupPageID = "Sales List";

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;

            trigger OnValidate()
            var
                // "...tri1.0": ; //16225
                TEXT0001: Label 'Do you want to create the Sales Order for the samples for Customer %1.';
            begin
            end;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(4; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            Editable = false;
            TableRelation = Customer;

            trigger OnValidate()
            var
                ContBusRel: Record "Contact Business Relation";
                Cont: Record Contact;
            begin
            end;
        }
        field(5; "Bill-to Name"; Text[30])
        {
            Caption = 'Bill-to Name';
            Editable = false;
        }
        field(6; "Bill-to Name 2"; Text[30])
        {
            Caption = 'Bill-to Name 2';
            Editable = false;
        }
        field(7; "Bill-to Address"; Text[30])
        {
            Caption = 'Bill-to Address';
            Editable = false;
        }
        field(8; "Bill-to Address 2"; Text[30])
        {
            Caption = 'Bill-to Address 2';
            Editable = false;
        }
        field(9; "Bill-to City"; Text[30])
        {
            Caption = 'Bill-to City';
            Editable = false;
        }
        field(10; "Bill-to Contact"; Text[30])
        {
            Caption = 'Bill-to Contact';
            Editable = false;
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
        field(21; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
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
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(31; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            Editable = false;
            TableRelation = "Customer Posting Group";
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
        field(34; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
        field(35; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';

            trigger OnValidate()
            var
                SalesLine: Record "Sales Line";
                Currency: Record Currency;
                RecalculatePrice: Boolean;
            begin
            end;
        }
        field(37; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';
            TableRelation = "Cust. Invoice Disc.".Code WHERE(Code = FIELD("Invoice Disc. Code"));
        }
        field(40; "Customer Disc. Group"; Code[10])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
        }
        field(41; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(43; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                SalespersonPurchaser: Record "Salesperson/Purchaser";
                CustomerRec: Record Customer;
            begin
            end;
        }
        field(45; "Order Class"; Code[10])
        {
            Caption = 'Order Class';
        }
        field(46; Comment; Boolean)
        {
            CalcFormula = Exist("Sales Comment Line" WHERE("Document Type" = FIELD("Document Type"),
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
        field(57; Ship; Boolean)
        {
            Caption = 'Ship';
            Editable = false;
        }
        field(58; Invoice; Boolean)
        {
            Caption = 'Invoice';
        }
        field(60; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line".Amount WHERE("Document Type" = FIELD("Document Type"),
                                                         "Document No." = FIELD("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Amount Including VAT" WHERE("Document Type" = FIELD("Document Type"),
                                                                         "Document No." = FIELD("No.")));
            Caption = 'Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Shipping No."; Code[20])
        {
            Caption = 'Shipping No.';
        }
        field(63; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
        }
        field(64; "Last Shipping No."; Code[20])
        {
            Caption = 'Last Shipping No.';
            Editable = false;
            TableRelation = "Sales Shipment Header";
        }
        field(65; "Last Posting No."; Code[20])
        {
            Caption = 'Last Posting No.';
            Editable = false;
            TableRelation = "Sales Invoice Header";
        }
        field(70; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
        }
        field(71; "Combine Shipments"; Boolean)
        {
            Caption = 'Combine Shipments';
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
        field(75; "EU 3-Party Trade"; Boolean)
        {
            Caption = 'EU 3-Party Trade';
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
        field(79; "Sell-to Customer Name"; Text[30])
        {
            Caption = 'Sell-to Customer Name';
            Editable = false;
        }
        field(80; "Sell-to Customer Name 2"; Text[30])
        {
            Caption = 'Sell-to Customer Name 2';
            Editable = false;
        }
        field(81; "Sell-to Address"; Text[30])
        {
            Caption = 'Sell-to Address';
            Editable = false;
        }
        field(82; "Sell-to Address 2"; Text[30])
        {
            Caption = 'Sell-to Address 2';
            Editable = false;
        }
        field(83; "Sell-to City"; Text[30])
        {
            Caption = 'Sell-to City';
            Editable = false;
        }
        field(84; "Sell-to Contact"; Text[30])
        {
            Caption = 'Sell-to Contact';
            Editable = false;
        }
        field(85; "Bill-to Post Code"; Code[20])
        {
            Caption = 'Bill-to Post Code';
            Editable = false;
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(86; "Bill-to County"; Text[30])
        {
            Caption = 'Bill-to County';
            Editable = false;
        }
        field(87; "Bill-to Country Code"; Code[10])
        {
            Caption = 'Bill-to Country Code';
            Editable = false;
        }
        field(88; "Sell-to Post Code"; Code[20])
        {
            Caption = 'Sell-to Post Code';
            Editable = false;
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(89; "Sell-to County"; Text[30])
        {
            Caption = 'Sell-to County';
        }
        field(90; "Sell-to Country Code"; Code[10])
        {
            Caption = 'Sell-to Country Code';
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
        field(97; "Exit Point"; Code[10])
        {
            Caption = 'Exit Point';
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
        field(100; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
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
        field(105; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        field(106; "Package Tracking No."; Text[30])
        {
            Caption = 'Package Tracking No.';
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
        field(109; "Shipping No. Series"; Code[10])
        {
            Caption = 'Shipping No. Series';
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
        field(117; Reserve; Option)
        {
            Caption = 'Reserve';
            OptionCaption = 'Never,Optional,Always';
            OptionMembers = Never,Optional,Always;
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
            Editable = false;
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
            CalcFormula = Max("Sales Header Archive"."Version No." WHERE("Document Type" = FIELD("Document Type"),
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
        field(5051; "Sell-to Customer Template Code"; Code[10])
        {
            Caption = 'Sell-to Customer Template Code';
            TableRelation = "Customer Template";

            trigger OnValidate()
            var
                SellToCustTemplate: Record "Customer Template";
            begin
            end;
        }
        field(5052; "Sell-to Contact No."; Code[20])
        {
            Caption = 'Sell-to Contact No.';
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
        field(5053; "Bill-to Contact No."; Code[20])
        {
            Caption = 'Bill-to Contact No.';
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
        field(5054; "Bill-to Customer Template Code"; Code[10])
        {
            Caption = 'Bill-to Customer Template Code';
            TableRelation = "Customer Template";

            trigger OnValidate()
            var
                BillToCustTemplate: Record "Customer Template";
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
        field(5752; "Completely Shipped"; Boolean)
        {
            CalcFormula = Min("Sales Line"."Completely Shipped" WHERE("Document Type" = FIELD("Document Type"),
                                                                       "Document No." = FIELD("No."),
                                                                       "Type" = FILTER(<> ' '),
                                                                       "Location Code" = FIELD("Location Filter")));
            Caption = 'Completely Shipped';
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
        field(5790; "Requested Delivery Date"; Date)
        {
            Caption = 'Requested Delivery Date';
        }
        field(5791; "Promised Delivery Date"; Date)
        {
            Caption = 'Promised Delivery Date';
        }
        field(5792; "Shipping Time"; DateFormula)
        {
            Caption = 'Shipping Time';
        }
        field(5793; "Outbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Outbound Whse. Handling Time';
        }
        field(5794; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
        }
        field(5795; "Late Order Shipping"; Boolean)
        {
            CalcFormula = Exist("Sales Line" WHERE("Document Type" = FIELD("Document Type"),
                                                    "Sell-to Customer No." = FIELD("Sell-to Customer No."),
                                                    "Document No." = FIELD("No."),
                                                    "Shipment Date" = FIELD("Date Filter")));
            Caption = 'Late Order Shipping';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5796; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(5800; Receive; Boolean)
        {
            Caption = 'Receive';
        }
        field(5801; "Return Receipt No."; Code[20])
        {
            Caption = 'Return Receipt No.';
        }
        field(5802; "Return Receipt No. Series"; Code[10])
        {
            Caption = 'Return Receipt No. Series';
            TableRelation = "No. Series";
        }
        field(5803; "Last Return Receipt No."; Code[20])
        {
            Caption = 'Last Return Receipt No.';
            Editable = false;
            TableRelation = "Return Receipt Header";
        }
        field(5900; "Service Mgt. Document"; Boolean)
        {
            Caption = 'Service Mgt. Document';
        }
        field(6201; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(6202; "CP Status"; Option)
        {
            Caption = 'CP Status';
            Editable = false;
            OptionCaption = ' ,Requested by Customer,Accepted by Customer,Rejected';
            OptionMembers = " ","Requested by Customer","Accepted by Customer",Rejected;
        }
        field(6203; "Auto Created"; Boolean)
        {
            Caption = 'Auto Created';
            Editable = false;
        }
        field(6210; "Login ID"; Code[30])
        {
            Caption = 'Login ID';
            Editable = false;
            TableRelation = "Return Receipt Header";
        }
        field(6211; "Web Site Code"; Code[20])
        {
            Caption = 'Web Site Code';
            TableRelation = "Return Receipt Header";
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
        }
        field(13701; "TDS Assessee Code"; Code[10])
        {
            TableRelation = "Return Receipt Header";
        }
        field(13706; "Excise Bus. Posting Group"; Code[10])
        {
            // TableRelation = "Excise Bus. Posting Group"; //16225 Table N/F
        }
        field(13707; "Excise Registration No."; Text[20])
        {
        }
        field(13731; "Amount Including Tax"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
        }
        field(13732; "Tax Registration No."; Text[20])
        {
        }
        field(13733; "Tax Country Code"; Code[10])
        {
        }
        field(13736; "Bill to Customer State"; Code[10])
        {
            TableRelation = State;
        }
        field(13737; "Form Code"; Code[10])
        {
            //16225 TABLE N/F "State Forms"
            /* TableRelation = "State Forms"."Form Code" WHERE(State = FIELD(State),
                                                              "Transit Document" = CONST(false));*/
        }
        field(13738; "Form No."; Code[10])
        {
        }
        field(13740; "Export Document"; Boolean)
        {
            Editable = false;
        }
        field(13742; "Export Type"; Option)
        {
            OptionMembers = Normal,Deemed;

            trigger OnValidate()
            var
                PurchHeader: Record "Purchase Header";
            begin
            end;
        }
        field(13743; Port; Code[10])
        {
        }
        field(13744; "Incentive Type"; Option)
        {
            OptionCaption = ' ,Adv. License';
            OptionMembers = " ","Adv. License";

            trigger OnValidate()
            var
                EPCGLicText: Label 'advance License cannot be used if The Export Order is applied for EPCG';
            begin
            end;
        }
        field(13745; EPCG; Boolean)
        {

            trigger OnValidate()
            var
                AdvLicText: Label 'EPCG Cannot be used if The Export Order is applied for Advance License';
            begin
            end;
        }
        field(13746; "Incentive No."; Code[20])
        {
        }
        field(13747; "EPCG No."; Code[20])
        {
        }
        field(13750; "Export Obligation Date"; Date)
        {
            Editable = false;
        }
        field(13751; "Transit Document"; Boolean)
        {
        }
        field(13752; State; Code[10])
        {
            TableRelation = State;

            trigger OnValidate()
            var
                "...tri1.0": Integer;
                StateVar: Record State;
            begin
            end;
        }
        field(13753; "LC No."; Code[20])
        {
            //16225 TABLE N/F LC Detail
            /* TableRelation = "LC Detail"."No." WHERE("Transaction Type" = CONST(Sale),
                                                    "Issued To/Received From" = FIELD("Bill-to Customer No."),
                                                    "Closed" = CONST(false),
                                                    "Released" = CONST(true));*/
        }
        field(13790; Structure; Code[10])
        {
            // TableRelation = "Structure Header"; //16225 Table N/F

            trigger OnValidate()
            var
                // StrDetails: Record "13793";//16225 Table N/F
                //  StrOrderDetails: Record "13794";//16225 Table N/F
                // StrOrderLines: Record "13795";//16225 Table N/F
                SaleLines: Record "Sales Line";
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
            Editable = false;
        }
        field(16351; "UT1 Serial No."; Code[20])
        {
            Editable = true;
        }
        field(16352; "ARE-1 No."; Code[20])
        {
            Editable = true;
        }
        field(16353; "CT-2 No."; Code[20])
        {
            Editable = true;
        }
        field(16354; "AR-3A No."; Code[20])
        {
            Editable = true;
        }
        field(16355; "ARE Posting"; Boolean)
        {
        }
        field(16361; New; Boolean)
        {
        }
        field(16370; "Pre-Carriage"; Option)
        {
            OptionCaption = 'By Sea,By Air,By Rail';
            OptionMembers = "By Sea","By Air","By Rail";
        }
        field(16371; Carriage; Option)
        {
            OptionCaption = 'By Sea,By Air,By Rail';
            OptionMembers = "By Sea","By Air","By Rail";
        }
        field(16372; "Port of Discharge"; Code[10])
        {
        }
        field(16373; "Final Destination"; Code[20])
        {
            TableRelation = "Post Code".City;
        }
        field(16374; "Country of Origin of Goods"; Code[10])
        {
        }
        field(16375; "Country of Final Destination"; Code[10])
        {
        }
        field(16376; "Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(16377; "Customer Bank Account"; Code[10])
        {
            TableRelation = "Customer Bank Account".Code WHERE("Customer No." = FIELD("Sell-to Customer No."));
        }
        field(16378; "Packing List No."; Code[20])
        {
        }
        field(16379; "Bill-To Bank Account"; Code[10])
        {
            TableRelation = "Customer Bank Account".Code WHERE("Customer No." = FIELD("Bill-to Customer No."));
        }
        field(16380; "Export Shipment Method"; Option)
        {
            OptionCaption = 'FOB,CIF,C&F';
            OptionMembers = FOB,CIF,"C&F";
        }
        field(16381; "Export Shipment Type"; Option)
        {
            OptionCaption = 'FOB,CIF,C&F';
            OptionMembers = FOB,CIF,"C&F";
        }
        field(16382; "Vessel/Flight No."; Code[20])
        {
        }
        field(16410; "Free Supply"; Boolean)
        {
            Caption = 'Free Supply';
        }
        field(50000; Deleted; Boolean)
        {
            Description = 'Used for Tracking of ArchieveManagement For Deleted Sales Order';
        }
        field(50001; "New Status"; Option)
        {
            OptionCaption = ',Short Close,Cancel,Close';
            OptionMembers = ,"Short Close",Cancel,Close;
        }
        field(50002; "Locked Order"; Boolean)
        {
            Description = 'Customization No. 5.3';
        }
        field(50003; "Customer Type"; Code[10])
        {
            Description = 'Cust 22';
            TableRelation = "Customer Type".Code WHERE(Type = FILTER(= Customer));
        }
        field(50004; "Security Amount"; Decimal)
        {
            Description = 'Customization No. 22';
        }
        field(50005; "Security Date"; Date)
        {
            Description = 'Customization No. 22';
        }
        field(50006; "Clubbed With SO"; Code[20])
        {
            Description = 'Customization No. 5.3.3';
        }
        field(50012; "Transporter's Name"; Code[20])
        {
            Description = 'Customization No. 25';
            TableRelation = Vendor WHERE(Transporter1 = FILTER(true));

            trigger OnValidate()
            var
                vendor: Record Vendor;
            begin
            end;
        }
        field(50013; "GR No."; Code[20])
        {
            Description = 'Customization No. 25';
        }
        field(50014; "Truck No."; Code[20])
        {
            Description = 'Customization No. 25';
        }
        field(50015; "Shipping Bill No."; Code[10])
        {
            Description = 'Customization No. 33';
        }
        field(50016; "HS Code"; Code[10])
        {
            Description = 'Customization No. 33';
        }
        field(50017; "Loading Inspector"; Text[30])
        {
            Description = 'Customization No. 25';
        }
        field(50018; "GR Date"; Date)
        {
            Description = 'Customization No. 25';
        }
        field(50019; "Packing Credit Value"; Decimal)
        {
        }
        field(50020; "Insurance Amount"; Decimal)
        {
            Description = 'Report 107';
        }
        field(50021; "Foreign Commission Agent"; Code[20])
        {
            Description = 'Report 83 EXIM';
            TableRelation = Customer;
        }
        field(50022; "Indian Commission Agent"; Code[20])
        {
            Description = 'Report 83 EXIM';
            TableRelation = Customer;
        }
        field(50023; "Entry No."; Integer)
        {
            Description = 'Report 18 Letter';
        }
        field(50024; "Entry Date"; Date)
        {
            Description = 'Report 18 Letter';
        }
        field(50025; "Main Location"; Code[10])
        {
        }
        field(50026; "Shipment Status"; Text[50])
        {
            Description = 'Report 102 EXIM';
        }
        field(50027; "Qty in Sq. Mt."; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Quantity in Sq. Mt." WHERE("Document Type" = FIELD("Document Type"),
                                                                        "Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50028; "Net Wt."; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Net Weight" WHERE("Document Type" = FIELD("Document Type"),
                                                               "Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50029; "Gross Wt."; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Gross Weight" WHERE("Document Type" = FIELD("Document Type"),
                                                                 "Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50030; "State Desc."; Text[50])
        {
        }
        field(50031; "Salesperson Description"; Text[50])
        {
            Editable = false;
        }
        field(50033; "Transporter Name"; Text[30])
        {
            Editable = false;
        }
        field(50034; Quantity; Decimal)
        {
            CalcFormula = Sum("Sales Line".Quantity WHERE("Document Type" = FIELD("Document Type"),
                                                           "Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50035; "Qty. To Ship"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Qty. to Ship" WHERE("Document Type" = FIELD("Document Type"),
                                                                 "Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50037; "FOB Value"; Decimal)
        {
            Description = 'ND';
        }
        field(50038; "Ocean Freight"; Decimal)
        {
            Description = 'ND';
        }
        field(50039; "No. of Containers"; Integer)
        {
            Description = 'ND';
        }
        field(50040; "Payment Terms"; Text[250])
        {
            Description = 'ND';
        }
        field(50041; "LC Number"; Code[100])
        {
            Description = 'ND';
        }
        field(50042; "Currency Code 1"; Code[50])
        {
            Description = 'ND';
            TableRelation = Currency;
        }
        field(50043; "Dealer Code"; Code[20])
        {
            Description = 'ND';
            TableRelation = "Salesperson/Purchaser".Code WHERE("Customer No." = FILTER(<> ''));

            trigger OnValidate()
            var
                Cust: Record Customer;
                SP: Record "Salesperson/Purchaser";
            begin
            end;
        }
        field(50044; "Dealer's Salesperson Code"; Code[20])
        {
            Description = 'ND';
            TableRelation = "Salesperson/Purchaser".Code WHERE("Customer No." = FILTER(= ''));
        }
        field(50045; "Quote No."; Code[20])
        {
        }
        field(50046; "Quote Date"; Date)
        {
        }
        field(50047; "Releasing Date"; Date)
        {
            Editable = false;
        }
        field(50048; "Releasing Time"; Time)
        {
            Editable = false;
        }
        field(50049; "SB No."; Code[10])
        {
        }
        field(50050; "SB Date"; Date)
        {
        }
        field(50051; ICD; Text[10])
        {
        }
        field(50052; "Export To"; Text[15])
        {
        }
        field(50053; "OTS No."; Code[15])
        {
        }
        field(50054; "Container No."; Code[15])
        {
        }
        field(50055; "Abatement Required"; Boolean)
        {
            Description = 'rakesh for sales tax calculation';
        }
        field(50060; "Sales Type"; Option)
        {
            Description = 'Dilip for Tax Calculation';
            OptionMembers = " Project","Project Sale",Dealer;
        }
        field(50061; "Group Code"; Code[2])
        {
            Description = 'TRI N.K 20.02.08';
        }
        field(50062; "Group Code Check"; Boolean)
        {
        }
        field(50070; Pay; Option)
        {
            Description = 'TRIRJ ORIENT6.0 01-11-08';
            OptionMembers = "To Pay","To Be Billed";
        }
        field(50072; "Sales Order No."; Code[10])
        {
            Description = 'TRI DP 140309';
        }
        field(50073; "Archive Version"; Integer)
        {
            CalcFormula = Count("Sales Header Archive" WHERE("Document Type" = FIELD("Document Type"),
                                                              "No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50074; "Blanket Order No."; Code[20])
        {
            Editable = false;
        }
        field(50075; "Date of Release"; Date)
        {
            Editable = false;
        }
        field(50076; "Time of Release"; Time)
        {
            Editable = false;
        }
        field(50077; "Releaser ID"; Code[10])
        {
            Editable = false;
        }
        field(50078; "Opener ID"; Code[10])
        {
            Editable = false;
        }
        field(50079; "Date of Reopen"; Date)
        {
            Editable = false;
        }
        field(50080; "Time of Reopen"; Time)
        {
            Editable = false;
        }
        field(50081; "Sales Order No"; Code[20])
        {
            Description = 'TRI DP';
        }
        field(50082; "Discount Charges %"; Decimal)
        {
        }
        field(50083; "Canceller ID"; Code[10])
        {
        }
        field(50084; "Cancellation Time"; Time)
        {
        }
        field(50085; "Amount to customer"; Decimal)
        {
            //16225 Sales Line"."Amount To Customer FIELD N/F
            /*  CalcFormula = Sum("Sales Line"."Amount To Customer" WHERE("Document Type" = FIELD("Document Type"),
                                                                         "Document No." = FIELD("No.")));*/
            FieldClass = FlowField;
        }
        field(50086; "Blanket Order No. Series"; Code[10])
        {
            Description = 'TRI P.G 22.06.2009';
        }
        field(99008500; "Date Received"; Date)
        {
            Caption = 'Date Received';
        }
        field(99008501; "Time Received"; Time)
        {
            Caption = 'Time Received';
        }
        field(99008502; "BizTalk Request for Sales Qte."; Boolean)
        {
            Caption = 'BizTalk Request for Sales Qte.';
        }
        field(99008503; "BizTalk Sales Order"; Boolean)
        {
            Caption = 'BizTalk Sales Order';
        }
        field(99008509; "Date Sent"; Date)
        {
            Caption = 'Date Sent';
        }
        field(99008510; "Time Sent"; Time)
        {
            Caption = 'Time Sent';
        }
        field(99008513; "BizTalk Sales Quote"; Boolean)
        {
            Caption = 'BizTalk Sales Quote';
        }
        field(99008514; "BizTalk Sales Order Cnfmn."; Boolean)
        {
            Caption = 'BizTalk Sales Order Cnfmn.';
        }
        field(99008518; "Customer Quote No."; Code[20])
        {
            Caption = 'Customer Quote No.';
        }
        field(99008519; "Customer Order No."; Code[20])
        {
            Caption = 'Customer Order No.';
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
        key(Key2; "Document Type", "Sell-to Customer No.", "No.")
        {
        }
        key(Key3; "Document Type", "Combine Shipments", "Bill-to Customer No.", "Currency Code")
        {
        }
        key(Key4; "Document Type", "Service Mgt. Document")
        {
        }
        key(Key5; "Sell-to Customer No.", "External Document No.")
        {
        }
        key(Key6; "Document Type", "Sell-to Contact No.")
        {
        }
        key(Key7; "Bill-to Contact No.")
        {
        }
        key(Key8; "Salesperson Code", State)
        {
        }
        key(Key9; "LC No.")
        {
        }
        key(Key10; State, "Sell-to City", "Customer Price Group", "Sell-to Customer No.")
        {
        }
        key(Key11; State)
        {
        }
        key(Key12; State, "Sell-to Customer No.")
        {
        }
    }

    fieldgroups
    {
    }
}

