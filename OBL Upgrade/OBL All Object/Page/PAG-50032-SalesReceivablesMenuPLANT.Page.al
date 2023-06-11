page 50032 "Sales & Receivables Menu PLANT"
{
    Caption = 'Sales & Receivables Menu';
    PageType = Card;
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            label(Control)
            {
                CaptionClass = Text19008473;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Orders)
            {
                Caption = 'Orders';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38
                    LocationFilterString := '';
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    UserLocation.SETFILTER(UserLocation."View Sales Order", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    SalesHeader.SETFILTER(SalesHeader."Location Code", LocationFilterString);
                    SalesHeader.SETRANGE(SalesHeader.Status, SalesHeader.Status::Released);
                    SalesOrder.SETTABLEVIEW(SalesHeader);
                    SalesOrder.RUN;
                    //ND Tri End Cust 38
                end;
            }
            action("Blanket Orders")
            {
                Caption = 'Blanket Order';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38
                    LocationFilterString := '';
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    UserLocation.SETFILTER(UserLocation."View Sales Order", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    SalesHeader.SETFILTER(SalesHeader."Location Code", LocationFilterString);
                    BO.SETTABLEVIEW(SalesHeader);
                    BO.RUN;
                    //ND Tri End Cust 38
                end;
            }
            action("Transfer Orders")
            {
                Caption = 'Transfer Orders External';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38

                    TransferHeader.RESET;
                    IF TransferHeader.FIND('-') THEN
                        REPEAT
                            UserLocation.RESET;
                            UserLocation.SETFILTER("User ID", UPPERCASE(USERID));
                            UserLocation.SETFILTER("Location Code", TransferHeader."Transfer-from Code");
                            UserLocation.SETFILTER("Transfer From", '%1', TRUE);
                            UserLocation1.RESET;
                            UserLocation1.SETFILTER("User ID", UPPERCASE(USERID));
                            UserLocation1.SETFILTER("Location Code", TransferHeader."Transfer-to Code");
                            UserLocation1.SETFILTER("Transfer To", '%1', TRUE);
                            IF (UserLocation1.FIND('-')) OR (UserLocation.FIND('-')) THEN
                                TransferHeader.MARK(TRUE);
                        UNTIL TransferHeader.NEXT = 0;

                    TransferHeader.MARKEDONLY(TRUE);
                    TransferHeader.SETRANGE(TransferHeader."Transfer order Status", TransferHeader."Transfer order Status"::Released);
                    TransferOrder1.SETTABLEVIEW(TransferHeader);
                    TransferOrder1.RUN;

                    //ND Tri End Cust 38
                end;
            }
            action("Transfer Orders int")
            {
                Caption = 'Transfer Orders Internal';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38

                    TransferHeader.RESET;
                    IF TransferHeader.FIND('-') THEN
                        REPEAT
                            UserLocation.RESET;
                            UserLocation.SETFILTER("User ID", UPPERCASE(USERID));
                            UserLocation.SETFILTER("Location Code", TransferHeader."Transfer-from Code");
                            UserLocation.SETFILTER("Transfer From", '%1', TRUE);
                            UserLocation1.RESET;
                            UserLocation1.SETFILTER("User ID", UPPERCASE(USERID));
                            UserLocation1.SETFILTER("Location Code", TransferHeader."Transfer-to Code");
                            UserLocation1.SETFILTER("Transfer To", '%1', TRUE);
                            IF (UserLocation1.FIND('-')) OR (UserLocation.FIND('-')) THEN
                                TransferHeader.MARK(TRUE);
                        UNTIL TransferHeader.NEXT = 0;

                    TransferHeader.MARKEDONLY(TRUE);
                    TransferHeader.SETRANGE(TransferHeader."Transfer order Status", TransferHeader."Transfer order Status"::Released);
                    TransferOrder.SETTABLEVIEW(TransferHeader);
                    TransferOrder.RUN;

                    //ND Tri End Cust 38
                end;
            }
            action("Export Orders")
            {
                Caption = 'Export Orders';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38
                    LocationFilterString := '';
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    UserLocation.SETFILTER(UserLocation."View Export Order", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    SalesHeader.SETFILTER(SalesHeader."Location Code", LocationFilterString);
                    //ExportOrder.SETTABLEVIEW(SalesHeader);
                    //ExportOrder.RUN;
                    //ND Tri End Cust 38
                end;
            }
            action("Posted Sales Order")
            {
                Caption = 'Posted Sales Orders';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38
                    LocationFilterString := '';
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    UserLocation.SETFILTER(UserLocation."View Sales Order", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    //SalesHeaderArchive.SETFILTER(SalesHeaderArchive."Export Document",'%1',FALSE);         //ravi
                    SalesHeaderArchive.SETFILTER(SalesHeaderArchive."Location Code", LocationFilterString);
                    SalesHeaderArchive.SETFILTER(Deleted, '%1', TRUE);
                    PSalesOrder.SETTABLEVIEW(SalesHeaderArchive);
                    PSalesOrder.RUN;
                    //ND Tri End Cust 38
                end;
            }
            action("Short Closed  Sales Orders")
            {
                Caption = 'Short Closed  Sales Orders';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38
                    LocationFilterString := '';
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    UserLocation.SETFILTER(UserLocation."View Sales Order", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    //SalesHeaderArchive.SETFILTER(SalesHeaderArchive."Export Document",'%1',FALSE);         //ravi
                    SalesHeaderArchive.SETFILTER(SalesHeaderArchive."Location Code", LocationFilterString);
                    SalesHeaderArchive.SETFILTER("New Status", '%1', SalesHeaderArchive."New Status"::"Short Close");
                    PSalesOrder.SETTABLEVIEW(SalesHeaderArchive);
                    PSalesOrder.RUN;
                    //ND Tri End Cust 38
                end;
            }
            action("Cancelled Sales Orders")
            {
                Caption = 'Cancelled Sales Orders';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38
                    LocationFilterString := '';
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    UserLocation.SETFILTER(UserLocation."View Sales Order", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    //SalesHeaderArchive.SETFILTER(SalesHeaderArchive."Export Document",'%1',FALSE);         //ravi
                    SalesHeaderArchive.SETFILTER(SalesHeaderArchive."Location Code", LocationFilterString);
                    SalesHeaderArchive.SETFILTER("New Status", '%1', SalesHeaderArchive."New Status"::Cancel);
                    PSalesOrder.SETTABLEVIEW(SalesHeaderArchive);
                    PSalesOrder.RUN;
                    //ND Tri End Cust 38
                end;
            }
            action("Posted Shipments")
            {
                Caption = 'Posted Shipments';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38
                    LocationFilterString := '';
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    UserLocation.SETFILTER(UserLocation."Create Sales Order", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    SalesShipHeader.SETFILTER("Location Code", LocationFilterString);
                    PSalesShipment.SETTABLEVIEW(SalesShipHeader);
                    PSalesShipment.RUN;
                    //ND Tri End Cust 38
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
                    PSalesInvoice.SETTABLEVIEW(SalesInvoiceHeader);
                    PSalesInvoice.RUN;
                    //ND Tri End Cust 38
                end;
            }
            action("Posted Credit Memos")
            {
                Caption = 'Posted Credit Memos';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38
                    LocationFilterString := '';
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    UserLocation.SETFILTER(UserLocation."View Sales Credit memo", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    SalesCrMemoHeader.SETFILTER("Location Code", LocationFilterString);
                    PSalesCreditMemo.SETTABLEVIEW(SalesCrMemoHeader);
                    PSalesCreditMemo.RUN;
                    //ND Tri End Cust 38
                end;
            }
            action("Posted Transfer Shipments")
            {
                Caption = 'Posted Transfer Shipments';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Posted Transfer Shipment";
                ApplicationArea = All;
            }
            action("Posted Export Shipments")
            {
                Caption = 'Posted Export Shipments';
                Promoted = true;
                PromotedCategory = Process;
                //  RunObject = Page 13746;
                ApplicationArea = All;
            }
            action("Posted Export Invoices")
            {
                Caption = 'Posted Export Invoices';
                Promoted = true;
                PromotedCategory = Process;
                //   RunObject = Page 13744;
                ApplicationArea = All;
            }
            action(Registers)
            {
                Caption = 'Registers';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "G/L Registers";
                ApplicationArea = All;
            }
            action(Navigate)
            {
                Caption = 'Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page Navigate;
                ApplicationArea = All;
            }
        }
    }

    var
        GenJnlManagement: Codeunit GenJnlManagement;
        UserLocation: Record "User Location";
        LocationFilterString: Text[250];
        SalesOrder: Page tms_so_data;
        SalesHeader: Record "Sales Header";
        SalesQuote: Page "Sales Quote";
        BlanketSalesOrder: Page "Blanket Sales Order";
        SalesInvoice: Page "Sales Invoice";
        SalesReturnOrder: Page "Sales Return Order";
        SalesCreditMemo: Page "Sales Credit Memo";
        CustType: Record "Customer Type";
        "----Posted-----": Integer;
        PSalesOrder: Page "RGP In List";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        PSalesInvoice: Page "Posted Sales Invoice";
        PSalesShipment: Page "Posted Sales Shipment";
        PSalesCreditMemo: Page "Posted Sales Credit Memo";
        SalesShipHeader: Record "Sales Shipment Header";
        SalesHeaderArchive: Record "Sales Header Archive";
        PostedReturnReceipt: Page "Posted Return Receipt";
        ReturnReceiptHeader: Record "Return Receipt Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        TransferHeader: Record "Transfer Header";
        UserLocation1: Record "User Location";
        TransferOrder: Page "Transfer Order";
        TransferOrder1: Page "Transfer Order External";
        BO: Page "Blanket Sales Order";
        Text19008473: Label 'Sales && Receivables';
}

