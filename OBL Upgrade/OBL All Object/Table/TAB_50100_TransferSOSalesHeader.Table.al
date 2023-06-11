table 50100 "Transfer SO Sales Header"
{
    Caption = 'Transfer SO Sales Header';
    DataCaptionFields = "No.", "Sell-to Customer Name";
    LookupPageID = "Sales List";
    Permissions = TableData "Approval Entry" = rimd;

    fields
    {
        field(1; Id; Integer)
        {
        }
        field(2; "Filled Date"; Date)
        {
        }
        field(3; "Filled By Emp No."; Code[10])
        {
        }
        field(4; "Filled By Emp Name"; Text[50])
        {
        }
        field(5; "Filled Location"; Code[20])
        {
        }
        field(6; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(7; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;
        }
        field(8; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(9; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            NotBlank = true;
            TableRelation = "Customer";
        }
        field(10; "Bill-to Name"; Text[50])
        {
            Caption = 'Bill-to Name';
        }
        field(11; "Bill-to Name 2"; Text[50])
        {
            Caption = 'Bill-to Name 2';
        }
        field(12; "Bill-to Address"; Text[50])
        {
            Caption = 'Bill-to Address';
        }
        field(13; "Bill-to Address 2"; Text[50])
        {
            Caption = 'Bill-to Address 2';
        }
        field(14; "Bill-to City"; Text[30])
        {
            Caption = 'Bill-to City';
            TableRelation = IF ("Bill-to Country/Region Code" = CONST()) "Post Code".City
            ELSE
            IF ("Bill-to Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Bill-to Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(15; "Bill-to Contact"; Text[50])
        {
            Caption = 'Bill-to Contact';
        }
        field(16; "Your Reference"; Text[250])
        {
            Caption = 'Your Reference';
        }
        field(17; "Ship-to Code"; Code[20])
        {
            Caption = 'Ship-to Code';
            Description = 'Change from Text';

            trigger OnValidate()
            begin
                IF ("Document Type" = "Document Type"::Order) AND
                   (xRec."Ship-to Code" <> "Ship-to Code")
                THEN BEGIN
                    SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
                    SalesLine.SETRANGE("Document No.", "No.");
                    SalesLine.SETFILTER("Purch. Order Line No.", '<>0');
                    IF NOT SalesLine.ISEMPTY THEN
                        ERROR(
                          Text006,
                          FIELDCAPTION("Ship-to Code"));
                    SalesLine.RESET;
                END;
            end;
        }
        field(18; "Ship-to Name"; Text[50])
        {
            Caption = 'Ship-to Name';
        }
        field(19; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
        }
        field(20; "Ship-to Address"; Text[50])
        {
            Caption = 'Ship-to Address';
        }
        field(21; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
        }
        field(22; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
            TableRelation = IF ("Ship-to Country/Region Code" = CONST()) "Post Code".City
            ELSE
            IF ("Ship-to Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Ship-to Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(23; "Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
        }
        field(24; "Order Date"; Date)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Order Date';
        }
        field(25; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(26; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(27; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));

            trigger OnValidate()
            var
                SH: Record "Sales Header";
            begin
            end;
        }
        field(28; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
        }
        field(29; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                ApprovalEntry: Record "Approval Entry";
                SalespersonPurchaser: Record "Salesperson/Purchaser";
                CustomerRec: Record Customer;
            begin
            end;
        }
        field(30; "Sell-to Customer Name"; Text[50])
        {
            Caption = 'Sell-to Customer Name';
        }
        field(31; "Sell-to Customer Name 2"; Text[40])
        {
            Caption = 'Sell-to Customer Name 2';
        }
        field(32; "Sell-to Address"; Text[50])
        {
            Caption = 'Sell-to Address';
        }
        field(33; "Sell-to Address 2"; Text[50])
        {
            Caption = 'Sell-to Address 2';
        }
        field(34; "Sell-to City"; Text[30])
        {
            Caption = 'Sell-to City';
            TableRelation = IF ("Sell-to Country/Region Code" = CONST()) "Post Code".City
            ELSE
            IF ("Sell-to Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Sell-to Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(35; "Sell-to Contact"; Text[50])
        {
            Caption = 'Sell-to Contact';
        }
        field(36; "Bill-to Post Code"; Code[20])
        {
            Caption = 'Bill-to Post Code';
            TableRelation = IF ("Bill-to Country/Region Code" = CONST()) "Post Code"
            ELSE
            IF ("Bill-to Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Bill-to Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(37; "Bill-to County"; Text[30])
        {
            Caption = 'Bill-to County';
        }
        field(38; "Bill-to Country/Region Code"; Code[10])
        {
            Caption = 'Bill-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(39; "Sell-to Post Code"; Code[15])
        {
            Caption = 'Sell-to Post Code';
            TableRelation = IF ("Sell-to Country/Region Code" = CONST()) "Post Code"
            ELSE
            IF ("Sell-to Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Sell-to Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(40; "Sell-to County"; Text[30])
        {
            Caption = 'Sell-to County';
        }
        field(41; "Sell-to Country/Region Code"; Code[10])
        {
            Caption = 'Sell-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(42; "Ship-to Post Code"; Code[15])
        {
            Caption = 'Ship-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(43; "Ship-to County"; Text[30])
        {
            Caption = 'Ship-to County';
        }
        field(44; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(50006; "PO No."; Code[20])
        {
            Description = 'from text';
        }
        field(50027; "Qty in Sq. Mt."; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Quantity in Sq. Mt." WHERE("Document Type" = FIELD("Document Type"),
                                                                        "Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50034; Quantity; Decimal)
        {
            CalcFormula = Sum("Sales Line".Quantity WHERE("Document Type" = FIELD("Document Type"),
                                                           "Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50040; "Payment Terms"; Text[40])
        {
            Description = 'ND Reduces length from 250 to 50 due to space problem';
        }
        field(50043; "Dealer Code"; Code[20])
        {
            Description = 'ND';

            trigger OnValidate()
            var
                Cust: Record Customer;
                SP: Record "Salesperson/Purchaser";
            begin
                IF "Dealer Code" <> '' THEN BEGIN
                    SP.GET("Dealer Code");
                    Cust.GET(SP."Customer No.");
                    "Dealer's Salesperson Code" := Cust."Salesperson Code";
                    //VALIDATE("Salesperson Code","Dealer Code"); Kulbhushan Sharma
                END;
            end;
        }
        field(50044; "Dealer's Salesperson Code"; Code[20])
        {
            Description = 'ND';
            TableRelation = "Salesperson/Purchaser".Code WHERE("Customer No." = FILTER(= ''));

            trigger OnValidate()
            begin
                VALIDATE("Salesperson Code", "Dealer's Salesperson Code");  //TRI DG 020609 Commented
            end;
        }
        field(50060; "Sales Type"; Option)
        {
            Description = 'Dilip for Tax Calculation';
            OptionCaption = ' ,Retail,Govt,Private';
            OptionMembers = " ",Retail,Govt,Private;

            trigger OnValidate()
            begin
                // TRI DP 050207 ADD START
                //UpdateSalesPerson;
                SalesLine.SETRANGE("Document Type", "Document Type");
                SalesLine.SETRANGE("Document No.", "No.");
                SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                //IF SalesLine.FIND('-') THEN
                //  ERROR('Cannot change the type when lines are already there');      //Rahul 010507
                //MESSAGE('Validate each line of Type Item with Order No.  %1',"No.");
                // TRI DP 050207 ADD END
            end;
        }
        field(50061; "Group Code"; Code[2])
        {
            Description = 'TRI N.K 20.02.08';

            trigger OnLookup()
            begin
                //TRI N.K 20.02.08 Add Start
                InventorySetup.GET;
                GroupCode.RESET;
                //GroupCodee.SETFILTER(DimensionValue."Dimension Code",InventorySetup."Size Code");
                IF PAGE.RUNMODAL(Page::"Item Group 2", GroupCode) = ACTION::LookupOK THEN
                    VALIDATE("Group Code", GroupCode."Group Code");
                //TRI N.K 20.02.08 Add Stop
            end;

            trigger OnValidate()
            begin
                //TRI LM 100308 start
                SalesLine1.RESET;
                SalesLine1.SETRANGE("Document Type", "Document Type");
                SalesLine1.SETRANGE("Document No.", "No.");
                IF SalesLine1.FIND('-') THEN
                    ERROR('You Cannot modify Group Code Because some sales line is associated with it');
                //TRI LM 100308 End
            end;
        }
        field(50070; Pay; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'Add';
            OptionCaption = 'To Pay, To Be Billed';
            OptionMembers = "To Pay"," To Be Billed";
        }
        field(50109; "ORC Terms"; Text[50])
        {
            Description = 'Ori Kulb 230113';
        }
        field(50141; Set; Boolean)
        {
        }
        field(50142; Get; Boolean)
        {
        }
        field(50144; "None"; Boolean)
        {
        }
        field(50145; "Specified Ent Team"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser" WHERE(Set = CONST(true));
        }
        field(50146; "Govt Ent Team"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser" WHERE("G E T" = CONST(true));
        }
        field(50147; "Ship to Pin Code"; Code[10])
        {
        }
        field(50148; "State Code"; Code[10])
        {
        }
        field(50149; "Placed By BH"; Boolean)
        {
        }
        field(60034; Pet; Boolean)
        {
        }
        field(60035; "Private Ent Team"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(60036; Retail; Boolean)
        {
        }
        field(60037; "Retail Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(60040; "PMT Code"; Code[15])
        {
        }
        field(60041; "Vehicle Provided"; Option)
        {
            OptionCaption = 'Company Vehicle, Party Vehicle';
            OptionMembers = "Company Vehicle"," Party Vehicle";
        }
        field(60042; "Collection Within"; Option)
        {
            OptionCaption = ' ,Within 3 Days, Within 4 to 7 Days, Within 7 to 10 Days, More Than 10 Days.';
            OptionMembers = " ","Within 3 Days"," Within 4 to 7 Days"," Within 7 to 10 Days"," More Than 10 Days.";
        }
        field(60043; "Cash Discount"; Decimal)
        {
        }
        field(60044; "Vehicle Code"; Text[150])
        {
        }
        field(60045; "Vehicle Desc"; Text[150])
        {
        }
        field(60046; "Total Net"; Decimal)
        {
        }
        field(60047; "GST Value"; Decimal)
        {
        }
        field(60048; "Total Value"; Decimal)
        {
        }
        field(60049; "Project Name"; Text[250])
        {
        }
        field(60050; Status; Integer)
        {
        }
        field(60051; "Plant Code"; Text[150])
        {
        }
        field(60060; "Sales Order Created"; Boolean)
        {
            Description = 'MSVRN 13012020';
        }
        field(60061; "Discount Percentage"; Decimal)
        {
        }
        field(80000; "Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(80001; "Line Count"; Integer)
        {
            CalcFormula = Count("Transfer SO Line" WHERE("No." = FIELD("No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Id)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(Brick; "Filled By Emp No.")//, Field79, Field60, Field84, Field61) //16225 field N/F
        {
        }
    }

    trigger OnDelete()
    var
        //  DOPaymentTransLogEntry: Record 829;
        ArchiveManagement: Codeunit ArchiveManagement;
    begin
    end;

    trigger OnInsert()
    var
        ArchiveManagement: Codeunit ArchiveManagement;
    begin
    end;

    trigger OnModify()
    begin

        //ND Tri Start Cust 38
        IF "Document Type" = "Document Type"::Quote THEN
            UserAccess := 0;
        IF "Document Type" = "Document Type"::Order THEN
            UserAccess := 1;
        IF "Document Type" = "Document Type"::Invoice THEN
            UserAccess := 2;
        IF "Document Type" = "Document Type"::"Credit Memo" THEN
            UserAccess := 3;
        IF "Document Type" = "Document Type"::"Blanket Order" THEN
            UserAccess := 4;
        IF "Document Type" = "Document Type"::"Return Order" THEN
            UserAccess := 5;
        IF ("Document Type" = "Document Type"::Order) THEN
            UserAccess := 35;
        Permissions.Type(UserAccess, xRec."Location Code");
        Permissions.Type(UserAccess, "Location Code");

        /*
        SalesLine1.RESET;
        SalesLine1.SETFILTER("Document No.","No.");
        IF SalesLine1.FIND('-') THEN REPEAT
          ItemNo := SalesLine1."No.";
        //  SalesLine1.VALIDATE(SalesLine1."No.",ItemNo);
        UNTIL SalesLine1.NEXT =0;
        */

        //ND Tri End Cust 38
        //UpdatedforApp;

    end;

    var
        Text003: Label 'You cannot rename a %1.';
        Text004: Label 'Do you want to change %1?';
        Text005: Label 'You cannot reset %1 because the document still has one or more lines.';
        Text006: Label 'You cannot change %1 because the order is associated with one or more purchase orders.';
        Text007: Label '%1 cannot be greater than %2 in the %3 table.';
        Text009: Label 'Deleting this document will cause a gap in the number series for shipments. An empty shipment %1 will be created to fill this gap in the number series.\\Do you want to continue?';
        Text012: Label 'Deleting this document will cause a gap in the number series for posted invoices. An empty posted invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?';
        Text014: Label 'Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?';
        Text015: Label 'If you change %1, the existing sales lines will be deleted and new sales lines based on the new information on the header will be created.\\Do you want to change %1?';
        Text017: Label 'You must delete the existing sales lines before you can change %1.';
        Text018: Label 'You have changed %1 on the sales header, but it has not been changed on the existing sales lines.\';
        Text019: Label 'You must update the existing sales lines manually.';
        Text020: Label 'The change may affect the exchange rate used in the price calculation of the sales lines.';
        Text021: Label 'Do you want to update the exchange rate?';
        Text022: Label 'You cannot delete this document. Your identification is set up to process from %1 %2 only.';
        Text024: Label 'You have modified the %1 field. The recalculation of VAT may cause penny differences, so you must check the amounts afterward. Do you want to update the %2 field on the lines to reflect the new value of %1?';
        Text027: Label 'Your identification is set up to process from %1 %2 only.';
        Text028: Label 'You cannot change the %1 when the %2 has been filled in.';
        Text030: Label 'Deleting this document will cause a gap in the number series for return receipts. An empty return receipt %1 will be created to fill this gap in the number series.\\Do you want to continue?';
        Text031: Label 'You have modified %1.\\';
        Text032: Label 'Do you want to update the lines?';
        Text067: Label '%1 %4 with amount of %2 has already been authorized on %3 and is not expired yet. You must void the previous authorization before you can re-authorize this %1.';
        Text068: Label 'There is nothing to void.';
        Text069: Label 'The selected operation cannot complete with the specified %1.';
        SalesSetup: Record "Sales & Receivables Setup";
        GLSetup: Record "General Ledger Setup";
        GLAcc: Record "G/L Account";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        CustLedgEntry: Record "Cust. Ledger Entry";
        Cust: Record Customer;
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        CurrExchRate: Record "Currency Exchange Rate";
        SalesCommentLine: Record "Sales Comment Line";
        ShipToAddr: Record "Ship-to Address";
        PostCode: Record "Post Code";
        BankAcc: Record "Bank Account";
        SalesShptHeader: Record "Sales Shipment Header";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        ReturnRcptHeader: Record "Return Receipt Header";
        SalesInvHeaderPrepmt: Record "Sales Invoice Header";
        SalesCrMemoHeaderPrepmt: Record "Sales Cr.Memo Header";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        GenJnILine: Record "Gen. Journal Line";
        RespCenter: Record "Responsibility Center";
        InvtSetup: Record "Inventory Setup";
        Location: Record Location;
        WhseRequest: Record "Warehouse Request";
        ShippingAgentService: Record "Shipping Agent Services";
        TempReqLine: Record "Requisition Line" temporary;
        eCommerceMerchantId: Record "E-Comm. Merchant";
        UserSetupMgt: Codeunit "User Setup Management";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";
        TransferExtendedText: Codeunit 378;
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        SalesPost: Codeunit "Sales-Post";
        CustEntrySetApplID: Codeunit "Cust. Entry-SetAppl.ID";
        DimMgt: Codeunit DimensionManagement;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WhseSourceHeader: Codeunit "Whse. Validate Source Header";
        SalesLineReserve: Codeunit "Sales Line-Reserve";
        // DOPaymentMgt: Codeunit 825; //16225 codeunit N/F
        //DOPaymentTransLogMgt: Codeunit 829; //16225 Codeunit N/F
        GSTManagement: Codeunit "GST Posting Management";//16225 16401 replace codeunit GST Posting Management
        GSTApplicationManagement: Codeunit "GST Sales Application Mgt.";//16225 16403 replace codeunit "GST Sales Application Mgt."
        CustEntryEdit: Codeunit "Cust. Entry-Edit";
        ApplyCustEntries: Page "Apply Customer Entries";
        CurrencyDate: Date;
        HideValidationDialog: Boolean;
        Confirmed: Boolean;
        Text035: Label 'You cannot Release Quote or Make Order unless you specify a customer on the quote.\\Do you want to create customer(s) now?';
        Text037: Label 'Contact %1 %2 is not related to customer %3.';
        Text038: Label 'Contact %1 %2 is related to a different company than customer %3.';
        Text039: Label 'Contact %1 %2 is not related to a customer.';
        ReservEntry: Record "Reservation Entry";
        TempReservEntry: Record "Reservation Entry" temporary;
        Text040: Label 'A won opportunity is linked to this order.\It has to be changed to status Lost before the Order can be deleted.\Do you want to change the status for this opportunity now?';
        Text044: Label 'The status of the opportunity has not been changed. The program has aborted deleting the order.';
        SkipSellToContact: Boolean;
        SkipBillToContact: Boolean;
        Text045: Label 'You can not change the %1 field because %2 %3 has %4 = %5 and the %6 has already been assigned %7 %8.';
        Text048: Label 'Sales quote %1 has already been assigned to opportunity %2. Would you like to reassign this quote?';
        Text049: Label 'The %1 field cannot be blank because this quote is linked to an opportunity.';
        InsertMode: Boolean;
        CompanyInfo: Record "Company Information";
        HideCreditCheckDialogue: Boolean;
        Text051: Label 'The sales %1 %2 already exists.';
        Text052: Label 'The sales %1 %2 has item tracking. Do you want to delete it anyway?';
        Text053: Label 'You must cancel the approval process if you wish to change the %1.';
        Text056: Label 'Deleting this document will cause a gap in the number series for prepayment invoices. An empty prepayment invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?';
        Text057: Label 'Deleting this document will cause a gap in the number series for prepayment credit memos. An empty prepayment credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?';
        Text061: Label '%1 is set up to process from %2 %3 only.';
        Text062: Label 'You cannot change %1 because the corresponding %2 %3 has been assigned to this %4.';
        Text063: Label 'Reservations exist for this order. These reservations will be canceled if a date conflict is caused by this change.\\Do you want to continue?';
        Text064: Label 'You may have changed a dimension.\\Do you want to update the lines?';
        UpdateDocumentDate: Boolean;
        Text066: Label 'You cannot change %1 to %2 because an open inventory pick on the %3.';
        Text070: Label 'You cannot change %1  to %2 because an open warehouse shipment exists for the %3.';
        BilltoCustomerNoChanged: Boolean;
        Text072: Label 'There are unpaid prepayment invoices related to the document of type %1 with the number %2.';
        DeferralLineQst: Label 'Do you want to update the deferral schedules for the lines?';
        // StrOrder: Record 13794; //16225 table N/F
        // StrOrderLine: Record 13795;//16225 table N/F
        // NODHeader: Record 13786; //16225 table N/F
        GLSetupRead: Boolean;
        Text16500: Label 'Place a check mark in Direct Debit To PLA/RG.';
        Text16501: Label 'The PLA/RG direct debit form can be accessed only when excise is liable.';
        PostedGateEntryLine: Record "Posted Gate Entry Line";
        GateEntryAttachment: Record "Gate Entry Attachment";
        GateEntryAttachment2: Record "Gate Entry Attachment";
        PostedGateEntryLineList: Page "Posted Gate Entry Line List";
        Text16502: Label 'The Service Tax Registration No. entered in Sales Line for Document Type %1 and Document No. %2 should be same for all the entries.';
        //ExciseCenvatClaim: Record 16584; //16225 table N/F
        TotalBEDAmt: Decimal;
        "TotalAED(GSI)Amt": Decimal;
        TotalSEDAmt: Decimal;
        TotalSAEDAmt: Decimal;
        TotalCESSAmt: Decimal;
        TotalNCCDAmt: Decimal;
        TotaleCessAmt: Decimal;
        TotalADETAmt: Decimal;
        TotalADEAmt: Decimal;
        "TotalAED(TTA)Amt": Decimal;
        TotalADCVATAmt: Decimal;
        TotalSHECessAmt: Decimal;
        // CenvatClaimForm: Page 13793; //16225 Table N/F
        // StateForms: Record 13767; //16225 Table N/F
        SynchronizingMsg: Label 'Synchronizing ...\ from: Sales Header with %1\ to: Assembly Header with %2.';
        //"-NAVIN-": ; //16225 Table N/F
        Text100: Label 'The LC which you have selected is Foreign type you cannot utilise for this order.';
        Text101: Label 'You cannot change Export Type because it has open orders that has not been posted yet.';
        Text103: Label 'You cannot change the structure.';
        Text104: Label 'Goods can be shipped from location %1 only against CT-2 No. %2';
        Text105: Label 'Location cannot be changed if CT-2 No. is defined';
        Text110: Label 'Sales Order cannot be deleted if Advance License is attached.';
        Text111: Label 'Status of Proforma Invoice No. %1 has been set as Expired due to modifications in the Export Order';
        //16225 "...tri1.0": ;
        Text0001: Label 'Sample Order %1 has been created for Customer %2.';
        Text0002: Label 'Status must be Open while changing the "Sell-to Post code".';
        TgText001: Label 'You are not able to mention C Form without Tax Registration No.';
        Text00002: Label 'Please enter the Posting Date first.';
        Text00003: Label 'You cannot change the structrue, because the items associated with it.';
        "..tri1.0": Integer;
        SalesHeader1: Record "Sales Header";
        SalesLine1: Record "Sales Line";
        ItemNo: Code[20];
        Permissions: Codeunit Permissions1;
        UserAccess: Integer;
        SalesLine2: Record "Sales Line";
        UserSetup1: Record "User Setup";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        GroupCode: Record "Item Group";
        InventorySetup: Record "Inventory Setup";
        "--TRI DP": Integer;
        NoSrRelation: Record "No. Series Relationship";
        NoSrRelationForm: Page "No. Series Relationships";
        NoSeries: Record "No. Series";
        PaymentTerms2: Record "Payment Terms";
        // Formcode: Record 13756;//16225 Table N/F
        UserLocation: Record "User Location";
        UserSetup: Record "User Setup";
        //TGSTrOrdDet: Record 13794;//16225 Table N/F
        SalesLineRec: Record "Sales Line";
        // StateVar: Record 13762; //16225 Table N/F
        "--SHAKTI----": Integer;
        ExcludeState: Boolean;
        ExcludeCustomer: Boolean;
        ExcludeCustomerType: Boolean;
        QDFunctions: Codeunit "Quality Discount Functions";
        RecCustGrp: Record "Customer Group";
        Customer: Record Customer;
        //Struct: Record 13792;//16225 Table N/F
        SalesLinePb: Record "Sales Line";
        RecState: Record State;
        Location1: Record Location;
        GeneralLedgerSetup: Record "General Ledger Setup";
        CDA: Boolean;
        NewSequenceNo: Integer;
        MailMgt: Codeunit "QD Test, PDF Creation & Email";
        CDMgt: Codeunit "CD Management";
        ShippingAdviceErr: Label 'This order must be a complete shipment.';
        PostedDocsToPrintCreatedMsg: Label 'One or more documents have been posted during deletion, which you can print from the related posted document.';
        InvoiceTypeErr: Label 'You can not change the Invoice Type for Shipped Document.';
        StructureChangeErr: Label 'You can not change the sturcture as Shipment has already been taken place.';
        GSTStructureErr: Label 'Structure on Header %1 and PIT Structure %2 on Line must be same.', Comment = '%1=Structure,%2=PIT Structure';
        TransactionType2: Option Purchase,Sale;
        GSTPaymentDutyErr: Label 'You can only select GST without payment of Duty in Export or Deemed Export Customer.';
        PrepaymentInvoicesNotPaidErr: Label 'You cannot post the document of type %1 with the number %2 before all related prepayment invoices are posted.', Comment = 'You cannot post the document of type Order with the number 1001 before all related prepayment invoices are posted.';
        reas: Record "Reason Code";
}

