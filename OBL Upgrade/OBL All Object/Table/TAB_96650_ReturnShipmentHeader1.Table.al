table 96650 "Return Shipment Header1"
{
    Caption = 'Return Shipment Header';
    DataCaptionFields = "No.", "Buy-from Vendor Name";
    LookupPageID = "Posted Return Shipments";

    fields
    {
        field(2; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            NotBlank = true;
            TableRelation = Vendor;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(4; "Pay-to Vendor No."; Code[20])
        {
            Caption = 'Pay-to Vendor No.';
            NotBlank = true;
            TableRelation = Vendor;
        }
        field(5; "Pay-to Name"; Text[50])
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

            trigger OnLookup()
            begin
                //PostCode.LookUpCity("Pay-to City","Pay-to Post Code",FALSE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidateCity("Pay-to City","Pay-to Post Code");
            end;
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
        field(13; "Ship-to Name"; Text[50])
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

            trigger OnLookup()
            begin
                //PostCode.LookUpCity("Ship-to City","Ship-to Post Code",FALSE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidateCity("Ship-to City","Ship-to Post Code");
            end;
        }
        field(18; "Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
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
            Editable = false;
            TableRelation = Currency;
        }
        field(33; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            MinValue = 0;
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
        field(46; Comment; Boolean)
        {
            CalcFormula = Exist("Purch. Comment Line" WHERE("Document Type" = CONST("Posted Return Shipment"),
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

            trigger OnLookup()
            begin
                VendLedgEntry.SETCURRENTKEY("Document No.");
                VendLedgEntry.SETRANGE("Document Type", "Applies-to Doc. Type");
                VendLedgEntry.SETRANGE("Document No.", "Applies-to Doc. No.");
                PAGE.RUN(0, VendLedgEntry);
            end;
        }
        field(55; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account";
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
        field(79; "Buy-from Vendor Name"; Text[50])
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

            trigger OnLookup()
            begin
                //PostCode.LookUpCity("Buy-from City","Buy-from Post Code",FALSE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidateCity("Buy-from City","Buy-from Post Code");
            end;
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

            trigger OnLookup()
            begin
                //PostCode.LookUpPostCode("Pay-to City","Pay-to Post Code",FALSE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidatePostCode("Pay-to City","Pay-to Post Code");
            end;
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

            trigger OnLookup()
            begin
                //PostCode.LookUpPostCode("Buy-from City","Buy-from Post Code",FALSE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidatePostCode("Buy-from City","Buy-from Post Code");
            end;
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

            trigger OnLookup()
            begin
                //PostCode.LookUpPostCode("Ship-to City","Ship-to Post Code",FALSE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidatePostCode("Ship-to City","Ship-to Post Code");
            end;
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
        field(108; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
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
                //16225  LoginMgt.LookupUserID("User ID");
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
        field(5052; "Buy-from Contact No."; Code[20])
        {
            Caption = 'Buy-from Contact No.';
            TableRelation = Contact;
        }
        field(5053; "Pay-to Contact No."; Code[20])
        {
            Caption = 'Pay-to Contact No.';
            TableRelation = Contact;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(5800; "Vendor Authorization No."; Code[20])
        {
            Caption = 'Vendor Authorization No.';
        }
        field(6601; "Return Order No."; Code[20])
        {
            Caption = 'Return Order No.';
        }
        field(6602; "Return Order No. Series"; Code[10])
        {
            Caption = 'Return Order No. Series';
            TableRelation = "No. Series";
        }
        field(13701; "Assessee Code"; Code[20])
        {
            Caption = 'Assessee Code';
            TableRelation = "Assessee Code";
        }
        field(13712; "Excise Bus. Posting Group"; Code[10])
        {
            Caption = 'Excise Bus. Posting Group';
            // TableRelation = "Excise Bus. Posting Group"; //16225 table N/F
        }
        field(13723; "Form Code"; Code[10])
        {
            Caption = 'Form Code';
            //16225 Table "State Forms" N/F
            /* TableRelation = IF (C Form=CONST(No)) "State Forms"."Form Code" WHERE (State=FIELD(State),
                                                                                    Transit Document=CONST(No))
                                                                                    ELSE IF (C Form=CONST(Yes)) "Form Codes".Code WHERE (C Form=CONST(Yes));*/
        }
        field(13724; "Form No."; Code[10])
        {
            Caption = 'Form No.';
            //16225 table "Tax Forms Details" N/F
            /*TableRelation = IF (C Form=CONST(No)) "Tax Forms Details"."Form No." WHERE (Form Code=FIELD(Form Code),
                                                                                        Issued=CONST(No),
                                                                                        State=FIELD(State))
                                                                                        ELSE IF (C Form=CONST(Yes)) "Tax Forms Details"."Form No." WHERE (Form Code=FIELD(Form Code),
                                                                                                                                                          Issued=CONST(No));*/

            trigger OnValidate()
            var
            // SalesFormsDetails: Record "13757"; //16225 table N/F
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
            //16225 Table N/F
            /*TableRelation = "LC Detail".No. WHERE (Transaction Type=CONST(Purchase),
                                                   Issued To/Received From=FIELD(Pay-to Vendor No.),
                                                   Closed=CONST(No),
                                                   Released=CONST(Yes));*/

            trigger OnValidate()
            var
                //LCDetail: Record "16300"; //16225 Table N/F
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
            // TableRelation = "Structure Header"; //16225 table N/f

            trigger OnValidate()
            var
                // StrDetails: Record "13793"; //16225 table N/F
                // StrOrderDetails: Record "13794"; //16225 table N/F
                // StrOrderLines: Record "13795"; //16225 table N/F
                PurchaseLines: Record "Purchase Line";
            begin
            end;
        }
        field(16341; Authorized; Boolean)
        {
            Caption = 'Authorized';
        }
        field(16343; "Authorized User ID"; Code[20])
        {
            Caption = 'Authorized User ID';
            TableRelation = User;
        }
        field(16375; "Vendor Shipment Date"; Date)
        {
            Caption = 'Vendor Shipment Date';
        }
        field(16376; "C Form"; Boolean)
        {
            Caption = 'C Form';
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
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Return Order No.")
        {
        }
        key(Key3; "Buy-from Vendor No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        LOCKTABLE;
        //PostPurchLinesDelete.DeletePurchShptLines(Rec);

        PurchCommentLine.SETRANGE("Document Type", PurchCommentLine."Document Type"::"Posted Return Shipment");
        PurchCommentLine.SETRANGE("No.", "No.");
        PurchCommentLine.DELETEALL;

        //DimMgt.DeletePostedDocDim(DATABASE::"Return Shipment Header","No.",0);

        //16225 Funcation N/F   ApprovalsMgt.DeletePostedApprovalEntry(DATABASE::"Return Shipment Header", "No.");
    end;

    var
        ReturnShptHeader: Record "Return Shipment Header";
        PurchCommentLine: Record "Purch. Comment Line";
        VendLedgEntry: Record "Vendor Ledger Entry";
        PostCode: Record "Post Code";
        PostPurchLinesDelete: Codeunit "PostPurch-Delete";
        DimMgt: Codeunit DimensionManagement;
        ApprovalsMgt: Codeunit "Approvals Mgmt.";

    procedure PrintRecords(ShowRequestForm: Boolean)
    var
        ReportSelection: Record "Report Selections";
    begin
        WITH ReturnShptHeader DO BEGIN
            COPY(Rec);
            ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"P.Ret.Shpt.");
            ReportSelection.SETFILTER("Report ID", '<>0');
            ReportSelection.FIND('-');
            REPEAT
                REPORT.RUNMODAL(ReportSelection."Report ID", ShowRequestForm, FALSE, ReturnShptHeader);
            UNTIL ReportSelection.NEXT = 0;
        END;
    end;

    procedure Navigate()
    var
        NavigateForm: Page Navigate;
    begin
        NavigateForm.SetDoc("Posting Date", "No.");
        NavigateForm.RUN;
    end;
}

