page 50084 "Tour Menu"
{
    Caption = 'General Ledger Menu';
    PageType = Card;
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            label(Control)
            {
                CaptionClass = Text19021117;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Vendors)
            {
                Caption = 'Vendors';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Vendor Card";
                ApplicationArea = All;
            }
            action(Customers)
            {
                Caption = 'Customers';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Customer Card";
                ApplicationArea = All;
            }
            action("Tour Master")
            {
                Caption = 'Tour Master';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Tour Master";
                ApplicationArea = All;
            }
            action(Reports)
            {
                Caption = 'Reports';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                //     ReportList: Record 243;
                begin
                    /*  WITH ReportList DO
                          ShowList(FIELDNO("Sales HO Reports"));*/
                end;
            }
            action("Posted Invoices")
            {
                Caption = 'Posted Invoices';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38
                    LocationFilterString := '';
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    UserLocation.SETFILTER(UserLocation."View Sales Invoice", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    SalesInvoiceHeader.SETFILTER("Location Code", LocationFilterString);
                    //    PSalesInvoice.SETTABLEVIEW(SalesInvoiceHeader);
                    //   PSalesInvoice.RUN;
                    //ND Tri End Cust 38
                end;
            }
        }
    }

    var
        GenJnlManagement: Codeunit GenJnlManagement;
        IntraJnlManagement: Codeunit IntraJnlManagement;
        VATStmtManagement: Codeunit VATStmtManagement;
        // GenJnlHeader: Record 16372;
        GenJnlTemplate: Record "Gen. Journal Template";
        LocationFilterString: Text[250];
        UserLocation: Record "User Location";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        ReturnShipmentHeader: Record "Return Shipment Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchaseHeaderArchive: Record "Freight Master IBOT";
        //SalesHeaderArchive: Record "Item Amount3";
        SalesShipHeader: Record "Sales Shipment Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        ReturnReceiptHeader: Record "Return Receipt Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesHeader: Record "Sales Header";
        PurchaseHeader: Record "Purchase Header";
        TransferHeader: Record "Transfer Header";
        UserLocation1: Record "User Location";
        Text19021117: Label 'Tour';
}

