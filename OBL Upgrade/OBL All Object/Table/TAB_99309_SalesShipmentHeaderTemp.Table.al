table 99309 "Sales Shipment Header Temp"
{
    Caption = 'Sales Shipment Header';
    DataCaptionFields = "No.", "Sell-to Customer Name";
    LookupPageID = "Posted Sales Shipment";

    fields
    {
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            NotBlank = true;
            TableRelation = Customer;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(4; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            NotBlank = true;
            TableRelation = Customer;
        }
        field(5; "Bill-to Name"; Text[30])
        {
            Caption = 'Bill-to Name';
        }
        field(6; "Bill-to Name 2"; Text[30])
        {
            Caption = 'Bill-to Name 2';
        }
        field(7; "Bill-to Address"; Text[30])
        {
            Caption = 'Bill-to Address';
        }
        field(8; "Bill-to Address 2"; Text[30])
        {
            Caption = 'Bill-to Address 2';
        }
        field(9; "Bill-to City"; Text[30])
        {
            Caption = 'Bill-to City';
        }
        field(10; "Bill-to Contact"; Text[30])
        {
            Caption = 'Bill-to Contact';
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
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
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
            Editable = false;
            TableRelation = Currency;
        }
        field(33; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
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
        }
        field(37; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';
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
        }
        field(44; "Order No."; Code[20])
        {
            Caption = 'Order No.';
        }
        field(46; Comment; Boolean)
        {
            CalcFormula = Exist("Sales Comment Line" WHERE("Document Type" = CONST("Shipment"),
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
        field(70; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
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
        }
        field(80; "Sell-to Customer Name 2"; Text[30])
        {
            Caption = 'Sell-to Customer Name 2';
        }
        field(81; "Sell-to Address"; Text[30])
        {
            Caption = 'Sell-to Address';
        }
        field(82; "Sell-to Address 2"; Text[30])
        {
            Caption = 'Sell-to Address 2';
        }
        field(83; "Sell-to City"; Text[30])
        {
            Caption = 'Sell-to City';
        }
        field(84; "Sell-to Contact"; Text[30])
        {
            Caption = 'Sell-to Contact';
        }
        field(85; "Bill-to Post Code"; Code[20])
        {
            Caption = 'Bill-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(86; "Bill-to County"; Text[30])
        {
            Caption = 'Bill-to County';
        }
        field(87; "Bill-to Country Code"; Code[10])
        {
            Caption = 'Bill-to Country Code';
        }
        field(88; "Sell-to Post Code"; Code[20])
        {
            Caption = 'Sell-to Post Code';
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
        field(109; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(110; "Order No. Series"; Code[10])
        {
            Caption = 'Order No. Series';
            TableRelation = "No. Series";
        }
        field(112; "User ID"; Code[20])
        {
            Caption = 'User ID';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
            end;
        }
        field(113; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
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
        field(119; "VAT Base Discount %"; Decimal)
        {
            Caption = 'VAT Base Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(5050; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            TableRelation = Campaign;
        }
        field(5052; "Sell-to Contact No."; Code[20])
        {
            Caption = 'Sell-to Contact No.';
            TableRelation = Contact;
        }
        field(5053; "Bill-to Contact No."; Code[20])
        {
            Caption = 'Bill-to Contact No.';
            TableRelation = Contact;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
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
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
        }
        field(13703; "Ship-to Courier Zone"; Code[2])
        {
        }
        field(13706; "Excise Bus. Posting Group"; Code[10])
        {
        }
        field(13707; "Excise Registration No."; Text[20])
        {
        }
        field(13732; "TAX Registration No."; Text[20])
        {
        }
        field(13733; "TAX Country Code"; Code[10])
        {
        }
        field(13737; "Form Code"; Code[10])
        {
            //TableRelation = "Form Codes";// 16225 TABLE N/F
        }
        field(13738; "Form No."; Code[10])
        {
            // TableRelation = "Tax Forms Details"; //16225 TABLE N/F
        }
        field(13740; "Export Document"; Boolean)
        {
            Description = 'EXIM';
        }
        field(13742; "Export Type"; Option)
        {
            OptionMembers = Normal,Deemed;
        }
        field(13743; Port; Code[10])
        {
        }
        field(13744; "Incentive Type"; Option)
        {
            OptionCaption = ' ,Adv. License';
            OptionMembers = " ","Adv. License";
        }
        field(13745; EPCG; Boolean)
        {
        }
        field(13746; "Incentive No."; Code[20])
        {
        }
        field(13747; "EPCG No."; Code[20])
        {
        }
        field(13748; "Duty Draw Back"; Boolean)
        {
        }
        field(13749; DEPB; Boolean)
        {
        }
        field(13751; DFRC; Boolean)
        {
        }
        field(13752; State; Code[10])
        {
            TableRelation = State;
        }
        field(13753; "LC No."; Code[20])
        {
            /*TableRelation = "LC Detail"."No." WHERE ("Transaction Type"=CONST("Sale"),
                                                   "Issued To/Received From"=FIELD("Bill-to Customer No."),
                                                   "Closed"=CONST(No),
                                                   Released=CONST(Yes));*/ //16225 Table N/F
        }
        field(13790; Structure; Code[10])
        {
            /*  TableRelation = "Structure Header";

              trigger OnValidate()
              var
                  StrDetails: Record 13793;
                  StrOrderDetails: Record 13794;
                  StrOrderLines: Record 13795;
                  SaleLines: Record 37;
              begin
              end;*/ //16225 Table N/F
        }
        field(16350; "VAT Business Posting Group"; Code[10])
        {
            Editable = false;
        }
        field(16370; "Pre-Carriage"; Option)
        {
            Description = 'EXIM';
            OptionCaption = 'By Sea,By Air,By Rail';
            OptionMembers = "By Sea","By Air","By Rail";
        }
        field(16371; Carriage; Option)
        {
            Description = 'EXIM';
            OptionCaption = 'By Sea,By Air,By Rail';
            OptionMembers = "By Sea","By Air","By Rail";
        }
        field(16372; "Port of Discharge"; Code[10])
        {
            Description = 'EXIM';
        }
        field(16373; "Final Destination"; Code[20])
        {
            Description = 'EXIM';
            TableRelation = "Post Code".City;
        }
        field(16374; "Country of Origin of Goods"; Code[10])
        {
            Description = 'EXIM';
        }
        field(16375; "Country of Final Destination"; Code[10])
        {
            Description = 'EXIM';
        }
        field(16376; "Bank Account"; Code[20])
        {
            Description = 'EXIM';
            TableRelation = "Bank Account"."No.";
        }
        field(16377; "Customer Bank Account"; Code[10])
        {
            Description = 'EXIM';
            TableRelation = "Customer Bank Account".Code WHERE("Customer No." = FIELD("Sell-to Customer No."));
        }
        field(16378; "Packing List No."; Code[20])
        {
            Description = 'EXIM';
        }
        field(16379; "Bill-To Bank Account"; Code[10])
        {
            Description = 'EXIM';
            TableRelation = "Customer Bank Account".Code WHERE("Customer No." = FIELD("Bill-to Customer No."));
        }
        field(16382; "Vessel/Flight No."; Code[20])
        {
            Description = 'EXIM';
        }
        field(16383; "Bill of Lading Date"; Date)
        {
            Description = 'EXIM';
        }
        field(16384; "Bill of Lading No"; Code[20])
        {
            Description = 'EXIM';
        }
        field(16385; "Container No"; Text[50])
        {
            Description = 'EXIM';
        }
        field(16386; "Place of Issue of B/L"; Code[20])
        {
            Description = 'EXIM';
        }
        field(16387; "Container No 2"; Text[50])
        {
        }
        field(16388; "Container No 3"; Text[50])
        {
        }
        field(16389; "Freight and Charges"; Text[50])
        {
        }
        field(16390; "Miscellaneous Charges1"; Text[50])
        {
        }
        field(16391; "Miscellaneous Charges2"; Text[50])
        {
        }
        field(16392; "Miscellaneous Charges3"; Text[50])
        {
        }
        field(16393; "Miscellaneous Charges4"; Text[50])
        {
        }
        field(16394; "Miscellaneous Charges5"; Text[50])
        {
        }
        field(16395; "Miscellaneous Charges6"; Text[50])
        {
        }
        field(16410; "Free Supply"; Boolean)
        {
            Caption = 'Free Supply';
        }
        field(50003; "Customer Type"; Code[10])
        {
            Description = 'Customization No. 22';
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
        field(50010; Remarks; Text[100])
        {
            Description = 'Customization No. 28';
        }
        field(50012; "Transporter's Name"; Code[20])
        {
            Description = 'Customization No. 25';
            TableRelation = Vendor WHERE(Transporter1 = FILTER(true));
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
        field(50030; "State Desc."; Text[50])
        {
        }
        field(50031; "Salesperson Description"; Text[50])
        {
        }
        field(50033; "Transporter Name"; Text[30])
        {
            Editable = false;
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
        field(50040; "Payment Terms"; Text[220])
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
        }
        field(50044; "Dealer's Salesperson Code"; Code[20])
        {
            Description = 'ND';
        }
        field(50045; "Quote No."; Code[20])
        {
        }
        field(50046; "Quote Date"; Date)
        {
        }
        field(50047; "Releasing Date"; Date)
        {
        }
        field(50048; "Releasing Time"; Time)
        {
        }
        field(50049; "SB No."; Code[15])
        {
        }
        field(50050; "SB Date"; Date)
        {
        }
        field(50051; ICD; Text[15])
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
        field(50060; "Sales Type"; Option)
        {
            Description = 'Dilip for Tax Calculation';
            Editable = false;
            OptionMembers = " ","Project Sale","Normal Sale";
        }
        field(50061; "Group Code"; Code[2])
        {
        }
        field(50071; Pay; Option)
        {
            Description = 'TRIRJ ORIENT6.0 01-11-08';
            Editable = false;
            OptionMembers = "To Pay","To Be Billed";
        }
        field(50090; Posted; Boolean)
        {
        }
        field(50091; SkipRec; Boolean)
        {
        }
        field(99008509; "Date Sent"; Date)
        {
            Caption = 'Date Sent';
        }
        field(99008510; "Time Sent"; Time)
        {
            Caption = 'Time Sent';
        }
        field(99008515; "BizTalk Shipment Notification"; Boolean)
        {
            Caption = 'BizTalk Shipment Notification';
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
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Order No.")
        {
        }
        key(Key3; "Bill-to Customer No.")
        {
        }
        key(Key4; "Sell-to Customer No.", "External Document No.")
        {
        }
        key(Key5; "Sell-to Customer No.", "No.")
        {
        }
        key(Key6; "Salesperson Code", State)
        {
        }
    }

    fieldgroups
    {
    }
}

