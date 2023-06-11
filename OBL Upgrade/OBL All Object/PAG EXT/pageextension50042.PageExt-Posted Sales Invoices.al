pageextension 50042 pageextension50042 extends "Posted Sales Invoices"
{
    layout
    {
        moveafter(Amount; "Posting Date")
        modify("Posting Date")
        {
            ApplicationArea = all;
        }
        addfirst(Control1)
        {
            field("Acknowledgement No."; rec."Acknowledgement No.")
            {
                ApplicationArea = All;
            }

            field("IRN Hash"; rec."IRN Hash")
            {
                ApplicationArea = All;
            }
            field("QR Code"; rec."QR Code")
            {
                ApplicationArea = All;
            }
            field("Acknowledgement Date"; rec."Acknowledgement Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Sell-to Customer Name")
        {
            field("User ID"; rec."User ID")
            {
                ApplicationArea = All;
            }
        }
        addafter("Ship-to Code")
        {
            field("Group Code"; rec."Group Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Ship-to Name")
        {
            field("Ship-to Address"; rec."Ship-to Address")
            {
                ApplicationArea = All;
            }
            field("Ship-to Address 2"; rec."Ship-to Address 2")
            {
                ApplicationArea = All;
            }
        }
        addafter("Ship-to Country/Region Code")
        {
            field("Reference Invoice No."; rec."Reference Invoice No.")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Shipment Date"; "External Document No.")
        addafter("Shipment Date")
        {
            field("Dealer Code"; rec."Dealer Code")
            {
                ApplicationArea = All;
            }

            field("ORC Terms"; rec."ORC Terms")
            {
                ApplicationArea = All;
            }
            field("PO No."; rec."PO No.")
            {
                ApplicationArea = All;
            }
            field("Email ID"; rec."Email ID")
            {
                ApplicationArea = All;
            }
            field("CR Approved By"; rec."CR Approved By")
            {
                ApplicationArea = All;
            }
            field("CR Exception Type"; rec."CR Exception Type")
            {
                ApplicationArea = All;
            }
            field("Loading Inspector"; rec."Loading Inspector")
            {
                ApplicationArea = All;
            }
            field("Freight / MT"; rec."GR Value")
            {
                ApplicationArea = All;
            }
            field(State; rec.State)
            {
                ApplicationArea = All;
            }
            field("State name"; rec."State name")
            {
                ApplicationArea = All;
            }
            field("Order Created ID"; rec."Order Created ID")
            {
                ApplicationArea = All;
            }
            field("Make Order Date"; rec."Make Order Date")
            {
                ApplicationArea = All;
            }
            field("Releasing Date"; rec."Releasing Date")
            {
                ApplicationArea = All;
            }
            field("Releasing Time"; rec."Releasing Time")
            {
                ApplicationArea = All;
            }
            field("Bill-to City"; rec."Bill-to City")
            {
                ApplicationArea = All;
            }
            field("Discount Charges %"; rec."Discount Charges %")
            {
                ApplicationArea = All;
            }
            field(Pay; rec.Pay)
            {
                ApplicationArea = All;
            }
            field("Transporter's Name"; rec."Transporter's Name")
            {
                ApplicationArea = All;
            }
            field("Transporter Name"; rec."Transporter Name")
            {
                ApplicationArea = All;
            }
            field("GR No."; rec."GR No.")
            {
                ApplicationArea = All;
            }
            field("Truck No."; rec."Truck No.")
            {
                ApplicationArea = All;
            }
            field("Gross Weight"; rec."Gross Weight")
            {
                ApplicationArea = All;
            }
            field("Net Weight"; rec."Net Weight")
            {
                ApplicationArea = All;
            }
            field("Blanket Order No."; rec."Blanket Order No.")
            {
                ApplicationArea = All;
            }
            field("Sq. Meter"; rec."Sq. Meter")
            {
                ApplicationArea = All;
            }
            field("Qty In carton"; rec."Qty In carton")
            {
                ApplicationArea = All;
            }
            field("Customer Type"; rec."Customer Type")
            {
                ApplicationArea = All;
            }
            field("Order Date"; rec."Order Date")
            {
                ApplicationArea = All;
            }
            field("Payment Amount"; rec."Payment Amount")
            {
                ApplicationArea = All;
            }
            field("Payment Date"; rec."Payment Date")
            {
                ApplicationArea = All;
            }
            field("E-Way No."; rec."E-Way No.")
            {
                Editable = false;
                Importance = Promoted;
                Style = StrongAccent;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("Confirmed Desc"; rec."Confirmed Desc")
            {
                ApplicationArea = All;
            }
            field("Despatch Remarks"; rec."Despatch Remarks")
            {
                ApplicationArea = All;
            }
            field(Commitment; rec.Commitment)
            {
                ApplicationArea = All;
            }
            field("Payment Amount 2"; rec."Payment Amount 2")
            {
                ApplicationArea = All;
            }
            field("E-Way Bill No.1"; Rec."E-Way Bill No.1")
            {
                ApplicationArea = all;
            }
            field("E-Way Bill Date"; Rec."E-Way Bill Date")
            {
                ApplicationArea = all;
            }
            field("E-Way Bill Validity"; Rec."E-Way Bill Validity")
            {
                ApplicationArea = all;
            }
            field("E-Way Generated"; Rec."E-Way Generated")
            {
                ApplicationArea = all;
            }
            field("E-Way-to generate"; Rec."E-Way-to generate")
            {
                ApplicationArea = all;
            }

            field("Payment Date 2"; rec."Payment Date 2")
            {
                ApplicationArea = All;
            }
            field("Payment Amount 3"; rec."Payment Amount 3")
            {
                ApplicationArea = All;
            }
            field("Order Processing Date"; rec."Payment Date 3")
            {
                ApplicationArea = All;
            }
            field("Last Payment Receipt Date"; rec."Last Payment Receipt Date")
            {
                ApplicationArea = All;
            }
            field("CD Applicable"; rec."CD Applicable")
            {
                ApplicationArea = All;
            }
            field("GR Date"; rec."GR Date")
            {
                ApplicationArea = All;
            }
            field("Sent Time Approval"; SentTime)
            {
                ApplicationArea = All;
            }
            field("PCH Approval Time"; PCHTime)
            {
                ApplicationArea = All;
            }
            field("ZM Approval Time"; ZMTime)
            {
                ApplicationArea = All;
            }
            field("PSM Approval Time"; PSMTime)
            {
                ApplicationArea = All;
            }
            field(Set; rec.BD)
            {
                ApplicationArea = All;
            }
            field("BD Code"; rec."Business Development")
            {
                ApplicationArea = All;
            }
            field(Get; rec.GPS)
            {
                ApplicationArea = All;
            }
            field("GPS Code"; rec."Govt. Project Sales")
            {
                ApplicationArea = All;
            }
            field(Pet; rec.CKA)
            {
                ApplicationArea = All;
            }
            field("CKA Code"; rec."CKA Code")
            {
                ApplicationArea = All;
            }
            field("PAC Approval Time"; PACTime)
            {
                ApplicationArea = All;
            }
            field("PMT Code"; rec."PMT Code")
            {
                ApplicationArea = All;
            }
            field("Ship to Pin"; rec."Ship to Pin")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("GST Ship-to State Code"; rec."GST Ship-to State Code")
            {
                ApplicationArea = All;
            }
            field("Sales Territory"; salterr)
            {
                Caption = 'Sales Territory';
                ApplicationArea = All;
            }
            field("Reason To Hold"; rec.Commitment)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Morbi Team"; rec."Entry Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Customer GST Reg. No."; rec."Customer GST Reg. No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("GST Customer Type"; rec."GST Customer Type")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Ship-to City"; rec."Ship-to City")
            {
                ApplicationArea = All;
            }
            field("Sell-to Customer Name 2"; rec."Sell-to Customer Name 2")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Sell-to Address"; rec."Sell-to Address")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Sell-to Address 2"; rec."Sell-to Address 2")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Sell-to City"; rec."Sell-to City")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Order Booking Date"; rec."Order Booked Date")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Order Processing Date"; "Order No.")
    }
    actions
    {
        addafter("&Invoice")
        {
            action(GenerateIRN)
            {
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    APIManagementEY: Codeunit "API Management -EY 2.6";
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    IF rec."Posting Date" <= 20200930D THEN
                        ERROR('You cannot create IRN Before than 1st Oct 2020');

                    Rec.TESTFIELD("Acknowledgement No.", '');
                    Rec.TESTFIELD("Acknowledgement Date", 0DT);
                    CLEAR(APIManagementEY);
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETFILTER("No.", '%1', Rec."No.");
                    IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                        APIManagementEY.SetSalesInvHeader(SalesInvoiceHeader);
                        APIManagementEY.GenerateSalesInvJSONSchema(SalesInvoiceHeader);
                    END;
                end;
            }
            action("Cancel IRN")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    APIManagementEY: Codeunit "API Management -EY 2.6";
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    IF Rec."Posting Date" <= 20200930D THEN
                        ERROR('You cannot create IRN Before than 1st Oct 2020');
                    Rec.TESTFIELD("Acknowledgement No.");
                    Rec.TESTFIELD("Acknowledgement Date");
                    Rec.TESTFIELD("IRN Hash");
                    IF CONFIRM('Do you want to cancel the generated IRN?', FALSE) THEN BEGIN
                        CLEAR(APIManagementEY);
                        SalesInvoiceHeader.RESET;
                        SalesInvoiceHeader.SETFILTER("No.", '%1', Rec."No.");
                        IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                            APIManagementEY.SetSalesInvHeader(SalesInvoiceHeader);
                            APIManagementEY.CancelSalesIRNNo(SalesInvoiceHeader);
                        END;
                    END;
                end;
            }
            action("GST Sales Invoice")
            {
                Caption = 'GST Sales Invoice';
                /*  Enabled = true;
                 Image = PrintVoucher;
                 Promoted = true;
                 PromotedCategory = Category4;
                 Visible = true;
  */
                ApplicationArea = all;

                trigger OnAction()
                var
                    // TradingInvoiceReport: Report "Sales Invoice";
                    BoolStart: Boolean;
                    SalesCrMemoHeader: Record "Sales Cr.Memo Header";
                    Customer: Record Customer;
                begin

                    IF (rec."Posting Date" >= 20200111D) AND ("GST Customer Type"::Registered = rec."GST Customer Type") AND (rec."IRN Hash" = '') THEN
                        ERROR('You cannot print the invoice without IRN ');
                    if Customer.get(Rec."Bill-to Customer No.") then;

                    IF (rec."Posting Date" >= 20200111D) AND (Customer."State Code" = 'WB') AND (rec."IRN Hash" = '') THEN
                        ERROR('You cannot print the invoice without IRN ');


                    CLEAR(BoolStart);
                    SalesCrMemoHeader.RESET;
                    SalesCrMemoHeader.SETRANGE("Applies-to Doc. No.", rec."No.");
                    IF SalesCrMemoHeader.FINDFIRST THEN
                        BoolStart := TRUE
                    ELSE
                        PrintReport;
                    IF (BoolStart) THEN
                        IF USERID IN ['FA017'] THEN
                            PrintReport
                        ELSE
                            ERROR('You Cannot Print the Invoice Due to This Invoice is Already Cancelled.');
                end;
            }

            action("Check IRN")
            {
                Image = Check;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    APIManagementEY: Codeunit "API Management -EY 2.6";
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    CLEAR(APIManagementEY);
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETFILTER("No.", '%1', Rec."No.");
                    IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                        APIManagementEY.SetSalesInvHeader(SalesInvoiceHeader);
                        APIManagementEY.GenerateSalesInvJSONSchemaforChecking(SalesInvoiceHeader);
                    END;
                end;
            }
        }
    }
    local procedure PrintReport()
    begin
        /*SalesInvHeader.RESET;
        SalesInvHeader.SETRANGE("No.","No.");
        SalesInvHeader.FINDFIRST;
        REPORT.RUN(50393,TRUE,FALSE,SalesInvHeader);
         */
        //MSVRN 091117 >>
        SalesInvHeader.RESET;
        SalesInvHeader.SETRANGE("No.", rec."No.");
        SalesInvHeader.FINDFIRST;
        //REPORT.RUN(50393,TRUE,FALSE,SalesInvHeader) //MSVRN 091117 /original blocked
        IF recCust.GET(Rec."Sell-to Customer No.") THEN;
        IF recCust."State Code" <> '19' THEN BEGIN
            recCustType.RESET;
            recCustType.SETRANGE(Code, recCust."Customer Type");
            IF recCustType.FINDFIRST THEN BEGIN
                IF recCustType."Hide Discount" = TRUE THEN
                    REPORT.RUN(50393, TRUE, FALSE, SalesInvHeader)
                ELSE
                    REPORT.RUN(50393, TRUE, FALSE, SalesInvHeader);
            END;
        END;

        IF (recCust."State Code" = '19') AND (SalesInvHeader."LC Number" = '') THEN
            //REPORT.RUN(50344,TRUE,FALSE,SalesInvHeader) for Nepal without discount.
            REPORT.RUN(50319, TRUE, FALSE, SalesInvHeader)
        ELSE
            ;
        IF (recCust."State Code" = '19') AND (SalesInvHeader."LC Number" <> '') THEN
            //REPORT.RUN(50344,TRUE,FALSE,SalesInvHeader) for Nepal without discount.
            //rEPORT.RUN(50198,TRUE,FALSE,SalesInvHeader);
            REPORT.RUN(50319, TRUE, FALSE, SalesInvHeader);



        //MSVRN 091117 <<

    end;


    var
        SalesInvHeader: Record 112;
        recCust: Record Customer;
        recCustType: Record "Customer Type";
        LocationFilterString: Text[1000];
        UserLocation: Record "User Location";
        SentTime: DateTime;
        PACTime: DateTime;
        Count1: Integer;
        PCHTime: DateTime;
        ZMTime: DateTime;
        PSMTime: DateTime;
        ArchiveApprovalEntryREC: Record "Archive Approval Entry";
        CUSTOMER: Record Customer;
        salterr: Code[15];
        orderchangeremarks: Code[10];
        archivesalesheader: Record "Sales Header Archive";
        APIManagementEY26: Codeunit "API Management -EY 2.6";

    trigger OnAfterGetRecord()
    begin
        //  DocExchStatusStyle := rec.GetDocExchStatusStyle;
        //Upgrade
        //
        CLEAR(SentTime);
        CLEAR(PACTime);
        ArchiveApprovalEntryREC.RESET;
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC.Status, ArchiveApprovalEntryREC.Status::Approved);
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC."Document No.", rec."Order No.");
        IF ArchiveApprovalEntryREC.FINDFIRST THEN
            SentTime := ArchiveApprovalEntryREC."Date-Time Sent for Approval";

        ArchiveApprovalEntryREC.RESET;
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC.Status, ArchiveApprovalEntryREC.Status::Approved);
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC."Document No.", rec."Order No.");
        IF ArchiveApprovalEntryREC.FINDFIRST THEN
            REPEAT
                IF (ArchiveApprovalEntryREC."Approver Code" = '1110088') OR (ArchiveApprovalEntryREC."Approver Code" = '1111058') THEN
                    PACTime := ArchiveApprovalEntryREC."Approval Date & Time";
            UNTIL ArchiveApprovalEntryREC.NEXT = 0;

        CLEAR(Count1);
        CLEAR(PCHTime);
        CLEAR(ZMTime);
        CLEAR(PSMTime);
        ArchiveApprovalEntryREC.RESET;
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC.Status, ArchiveApprovalEntryREC.Status::Approved);
        ArchiveApprovalEntryREC.SETRANGE(ArchiveApprovalEntryREC."Document No.", rec."Order No.");
        IF ArchiveApprovalEntryREC.FINDFIRST THEN
            REPEAT
                Count1 += 1;
                IF (Count1 = 1) AND (ArchiveApprovalEntryREC."Approver Code" <> '1110088') AND (ArchiveApprovalEntryREC."Approver Code" <> '1111058') THEN
                    PCHTime := ArchiveApprovalEntryREC."Approval Date & Time";
                IF (Count1 = 2) AND (ArchiveApprovalEntryREC."Approver Code" <> '1110088') AND (ArchiveApprovalEntryREC."Approver Code" <> '1111058') THEN
                    ZMTime := ArchiveApprovalEntryREC."Approval Date & Time";
                IF (Count1 = 3) AND (ArchiveApprovalEntryREC."Approver Code" <> '1110088') AND (ArchiveApprovalEntryREC."Approver Code" <> '1111058') THEN
                    PSMTime := ArchiveApprovalEntryREC."Approval Date & Time";
            UNTIL ArchiveApprovalEntryREC.NEXT = 0;
        //MSAK
        //Upgrade

        IF CUSTOMER.GET(Rec."Sell-to Customer No.") THEN
            salterr := CUSTOMER."Area Code";

    end;

    trigger OnOpenPage()
    var

    begin
        LocationFilterString := '';
        UserLocation.RESET;
        UserLocation.SETFILTER(UserLocation."User ID", USERID);
        UserLocation.SETFILTER(UserLocation."View Sales Invoice", '%1', TRUE);
        IF UserLocation.FIND('-') THEN
            REPEAT
                //IF (STRLEN(LocationFilterString)+STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                LocationFilterString += UserLocation."Location Code" + '|';
            UNTIL UserLocation.NEXT = 0;


        LocationFilterString := COPYSTR(LocationFilterString, 1, STRLEN(LocationFilterString) - 1);

        // IF LocationFilterString = '' THEN
        //   ERROR('Sorry please contact your System Administrator');

        //MESSAGE(LocationFilterString);

        rec.FILTERGROUP(2);
        rec.SETFILTER("Location Code", LocationFilterString);
        rec.FILTERGROUP(0);

    end;
}

