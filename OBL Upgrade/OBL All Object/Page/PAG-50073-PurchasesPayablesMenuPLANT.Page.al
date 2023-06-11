page 50073 "Purchases & Payables MenuPLANT"
{
    Caption = 'Purchases & Payables Menu';
    PageType = Card;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            label(Group)
            {
                CaptionClass = Text19058388;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Periodic Activities")
            {
                Caption = 'Periodic Activities';
                action("Recurring Journals")
                {
                    Caption = 'Recurring Journals';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ///  GenJnlManagement.TemplateSelection(0, TRUE);
                    end;
                }
                action("Recurring Req. &Worksheets")
                {
                    Caption = 'Recurring Req. &Worksheets';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ///   ReqJnlManagement.TemplateSelection(TRUE, 0);
                    end;
                }
                separator(Action40)
                {
                }
                group("&Delete Purchase Documents")
                {
                    Caption = '&Delete Purchase Documents';
                    action("Delete Invoiced Purch. Orders")
                    {
                        Caption = 'Delete Invoiced Purch. Orders';
                        Ellipsis = true;
                        RunObject = Report "Delete Invoiced Purch. Orders";
                        ApplicationArea = All;
                    }
                    action("Delete Invoiced &Blanket Purchase Orders")
                    {
                        Caption = 'Delete Invoiced &Blanket Purchase Orders';
                        Ellipsis = true;
                        RunObject = Report "Delete Invd Blnkt Purch Orders";
                        ApplicationArea = All;
                    }
                    action("Delete Invoiced Purchase Re&turn Orders")
                    {
                        Caption = 'Delete Invoiced Purchase Re&turn Orders';
                        Ellipsis = true;
                        RunObject = Report "Delete Invd Purch. Ret. Orders";
                        ApplicationArea = All;
                    }
                    action("Delete &Archived Purchase Quote Versions")
                    {
                        Caption = 'Delete &Archived Purchase Quote Versions';
                        Ellipsis = true;
                        // RunObject = Report "Delete Purchase Quote Versions";
                        ApplicationArea = All;
                    }
                    action("Delete Archived Purchase &Order Versions")
                    {
                        Caption = 'Delete Archived Purchase &Order Versions';
                        Ellipsis = true;
                        // RunObject = Report "Delete Purchase Quote Versions";
                        ApplicationArea = All;
                    }
                }
                separator(Action44)
                {
                }
                group("Bi&zTalk Inbound Documents")
                {
                    Caption = 'Bi&zTalk Inbound Documents';
                    action("&Pending")
                    {
                        Caption = '&Pending';
                        // RunObject = Page 9357; //16225 Page N/F
                        ApplicationArea = All;
                    }
                    action("&Accepted")
                    {
                        Caption = '&Accepted';
                        // RunObject = Page 9358;//16225 Page N/F
                        ApplicationArea = All;
                    }
                    action("&Rejected")
                    {
                        Caption = '&Rejected';
                        //  RunObject = Page 9359;//16225 Page N/F
                        ApplicationArea = All;
                    }
                }
                group("Biz&Talk Outbound Documents")
                {
                    Caption = 'Biz&Talk Outbound Documents';
                    action("&Unsent")
                    {
                        Caption = '&Unsent';
                        //  RunObject = Page 9355;//16225 Page N/F
                        ApplicationArea = All;
                    }
                    action("&Sent")
                    {
                        Caption = '&Sent';
                        //     RunObject = Page 9356; //16225 Page N/F
                        ApplicationArea = All;
                    }
                }
                group("Date &Compression")
                {
                    Caption = 'Date &Compression';
                    action("Ven&dor Ledger")
                    {
                        Caption = 'Ven&dor Ledger';
                        Ellipsis = true;
                        Image = VendorLedger;
                        RunObject = Report "Date Compress Vendor Ledger";
                        ApplicationArea = All;
                    }
                    separator(Action52)
                    {
                    }
                    action("Date &Compression Registers")
                    {
                        Caption = 'Date &Compression Registers';
                        RunObject = Page "Date Compr. Registers";
                        ApplicationArea = All;
                    }
                }
            }
            group(Setup)
            {
                Caption = 'Setup';
                action("Purchases && Payables &Setup")
                {
                    Caption = 'Purchases && Payables &Setup';
                    RunObject = Page "Purchases & Payables Setup";
                    ApplicationArea = All;
                }
                action("Vendor P&osting Groups")
                {
                    Caption = 'Vendor P&osting Groups';
                    RunObject = Page "Vendor Posting Groups";
                    ApplicationArea = All;
                }
                action("Item Charges")
                {
                    Caption = 'Item Charges';
                    RunObject = Page "Item Charges";
                    ApplicationArea = All;
                }
                separator(Action25)
                {
                }
                action("Payment Terms")
                {
                    Caption = 'Payment Terms';
                    RunObject = Page "Payment Terms";
                    ApplicationArea = All;
                }
                action("Pay&ment Methods")
                {
                    Caption = 'Pay&ment Methods';
                    RunObject = Page "Payment Methods";
                    ApplicationArea = All;
                }
                action("P&urchasers")
                {
                    Caption = 'P&urchasers';
                    RunObject = Page "Salespersons/Purchasers";
                    ApplicationArea = All;
                }
                action("Purchasing &Codes")
                {
                    Caption = 'Purchasing &Codes';
                    RunObject = Page "Purchasing Codes";
                    ApplicationArea = All;
                }
                action("S&tandard Purchase Codes")
                {
                    Caption = 'S&tandard Purchase Codes';
                    RunObject = Page "Standard Purchase Codes";
                    ApplicationArea = All;
                }
                action("S&hipment Methods")
                {
                    Caption = 'S&hipment Methods';
                    RunObject = Page "Shipment Methods";
                    ApplicationArea = All;
                }
                action("Vendor Classification")
                {
                    Caption = 'Vendor Classification';
                    RunObject = Page "Customer/Vendor Type";
                    RunPageView = SORTING(Type, Code) ORDER(Ascending) WHERE(Type = CONST(Vendor));
                    ApplicationArea = All;
                }
                separator(Action33)
                {
                }
                action("Return R&easons")
                {
                    Caption = 'Return R&easons';
                    RunObject = Page "Return Reasons";
                    ApplicationArea = All;
                }
                separator(Action30)
                {
                }
                action("Report Selections")
                {
                    Caption = 'Report Selections';
                    RunObject = Page "Report Selection - Purchase";
                    ApplicationArea = All;
                }
                action("Req. &Worksheet Templates")
                {
                    Caption = 'Req. &Worksheet Templates';
                    RunObject = Page "Req. Worksheet Templates";
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            action(Vendors)
            {
                Caption = 'Vendors';
                Enabled = VendorsEnable;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Vendor Card";
                ApplicationArea = All;
            }
            action("Purchase Journals")
            {
                Caption = 'Purchase Journals';
                Enabled = "Purchase JournalsEnable";
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ///  GenJnlManagement.TemplateSelection(2, FALSE);
                end;
            }
            action("Payment Journals")
            {
                Caption = 'Payment Journals';
                Enabled = "Payment JournalsEnable";
                Image = Journals;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ///   GenJnlManagement.TemplateSelection(4, FALSE);
                end;
            }
            action(Payments)
            {
                Caption = 'Payments';
                Enabled = PaymentsEnable;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    GenJnlTemplate.RESET;
                    GenJnlTemplate.SETRANGE(Type, 10);
                    GenJnlTemplate.FIND('-');
                    //16225 Table N/F
                    /* GenJnlHeader.FILTERGROUP := 2;
                     GenJnlHeader.SETRANGE("Journal Template Name", GenJnlTemplate.Name);
                     GenJnlTemplate.FIND('-');
                     GenJnlHeader.FILTERGROUP := 0;
                     FORM.RUN(GenJnlTemplate."Form ID", GenJnlHeader);*/
                    //16225 Table N/F end
                end;
            }
            action("Transporter Payment")
            {
                Caption = 'Transporter Payments';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Transporter Payment";
                ApplicationArea = All;
            }
            action("Requisition Worksheets")
            {
                Caption = 'Requisition Worksheets';
                Enabled = "Requisition WorksheetsEnable";
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ///    ReqJnlManagement.TemplateSelection(FALSE, 0);
                end;
            }
            action(Quotes)
            {
                Caption = 'Quotes';
                Enabled = QuotesEnable;
                Image = Quote;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38
                    LocationFilterString := '';
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    UserLocation.SETFILTER(UserLocation."View Purchase Quote", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    PurchaseHeader.SETFILTER("Location Code", LocationFilterString);
                    ///   PurchaseQuote.SETTABLEVIEW(PurchaseHeader);
                    ///   PurchaseQuote.RUN;
                    //ND Tri End Cust 38
                end;
            }
            action("Blanket Orders")
            {
                Caption = 'Blanket Orders';
                Enabled = "Blanket OrdersEnable";
                Image = BlanketOrder;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38
                    LocationFilterString := '';
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    UserLocation.SETFILTER(UserLocation."View Purchase Blanket Order", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    PurchaseHeader.SETFILTER("Location Code", LocationFilterString);
                    ///   BlanketPurchaseOrder.SETTABLEVIEW(PurchaseHeader);
                    ///   BlanketPurchaseOrder.RUN;
                    //ND Tri End Cust 38
                end;
            }
            action(Orders)
            {
                Caption = 'Orders';
                Enabled = OrdersEnable;
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
                    UserLocation.SETFILTER(UserLocation."View Purchase Order", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    PurchaseHeader.SETFILTER("Location Code", LocationFilterString);
                    ///   PurchaseOrder.SETTABLEVIEW(PurchaseHeader);
                    ///   PurchaseOrder.RUN;
                    //ND Tri End Cust 38
                end;
            }
            action(SubconOrder)
            {
                Caption = 'Subcontracting Orders';
                Enabled = SubconOrderEnable;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Subcontracting Order";
                RunPageView = SORTING(Subcontracting) ORDER(Ascending) WHERE(Subcontracting = CONST(true));
                ApplicationArea = All;
            }
            action(SubconOrders)
            {
                Caption = 'Delivery Challan';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Subcon. Delivery Challan";
                RunPageView =;
                ApplicationArea = All;
            }
            action(Invoices)
            {
                Caption = 'Invoices';
                Enabled = InvoicesEnable;
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38
                    LocationFilterString := '';
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    UserLocation.SETFILTER(UserLocation."View Purchase Invoice", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    PurchaseHeader.SETFILTER("Location Code", LocationFilterString);
                    ///    PurchaseInvoice.SETTABLEVIEW(PurchaseHeader);
                    ///    PurchaseInvoice.RUN;
                    //ND Tri End Cust 38
                end;
            }
            action("Return Orders")
            {
                Caption = 'Return Orders';
                Enabled = "Return OrdersEnable";
                Image = ReturnOrder;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38
                    LocationFilterString := '';
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    UserLocation.SETFILTER(UserLocation."View Purchase Return order", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    PurchaseHeader.SETFILTER("Location Code", LocationFilterString);
                    ///    PurchaseReturnOrder.SETTABLEVIEW(PurchaseHeader);
                    ///    PurchaseReturnOrder.RUN;
                    //ND Tri End Cust 38
                end;
            }
            action("Credit Memos")
            {
                Caption = 'Credit Memos';
                Enabled = "Credit MemosEnable";
                Image = CreditMemo;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38
                    LocationFilterString := '';
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    UserLocation.SETFILTER(UserLocation."View Purchase Credit memo", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    PurchaseHeader.SETFILTER("Location Code", LocationFilterString);
                    ///    PurchaseCreditMemo.SETTABLEVIEW(PurchaseHeader);
                    /// PurchaseCreditMemo.RUN;
                    //ND Tri End Cust 38
                end;
            }
            action("Debit Notes")
            {
                Caption = 'Debit Note';
                Enabled = "Debit NotesEnable";
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Posted ServTrans Rcpt. Subform";
                ApplicationArea = All;
            }
            action(Indent)
            {
                Caption = 'Indents';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38

                    LocationFilterString := '';
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    UserLocation.SETFILTER(UserLocation."View Indent", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    IndentHeader.SETFILTER("Location Code", LocationFilterString);

                    IF IndentHeader.FIND('-') THEN
                        REPEAT
                            CASE IndentHeader.Status OF

                                IndentHeader.Status::Open:
                                    IF IndentHeader."User ID" = UPPERCASE(USERID) THEN
                                        IndentHeader.MARK(TRUE);

                                IndentHeader.Status::Authorization1:
                                    IF IndentHeader."User ID" = UPPERCASE(USERID) THEN
                                        IndentHeader.MARK(TRUE)
                                    ELSE
                                        IF IndentHeader."Authorization 1" = UPPERCASE(USERID) THEN
                                            IndentHeader.MARK(TRUE);

                                IndentHeader.Status::Authorization2:
                                    IF IndentHeader."User ID" = UPPERCASE(USERID) THEN
                                        IndentHeader.MARK(TRUE)
                                    ELSE
                                        IF IndentHeader."Authorization 1" = UPPERCASE(USERID) THEN
                                            IndentHeader.MARK(TRUE)
                                        ELSE
                                            IF IndentHeader."Authorization 2" = UPPERCASE(USERID) THEN
                                                IndentHeader.MARK(TRUE);

                                IndentHeader.Status::Authorized:
                                    IF IndentHeader."User ID" = UPPERCASE(USERID) THEN
                                        IndentHeader.MARK(TRUE)
                                    ELSE
                                        IF IndentHeader."Authorization 1" = UPPERCASE(USERID) THEN
                                            IndentHeader.MARK(TRUE)
                                        ELSE
                                            IF IndentHeader."Authorization 2" = UPPERCASE(USERID) THEN
                                                IndentHeader.MARK(TRUE);
                            END;

                            IF IndentHeader.Status = IndentHeader.Status::Authorized THEN BEGIN
                                UserLocation.RESET;
                                UserLocation.SETFILTER(UserLocation."User ID", UPPERCASE(USERID));
                                UserLocation.SETFILTER(UserLocation."Location Code", IndentHeader."Location Code");
                                UserLocation.SETFILTER(UserLocation.Purchaser, '%1', TRUE);
                                IF UserLocation.FIND('-') THEN
                                    IndentHeader.MARK(TRUE);
                            END;

                        UNTIL IndentHeader.NEXT = 0;

                    IndentHeader.MARKEDONLY(TRUE);
                    ///    IndentHeaderForm.SETTABLEVIEW(IndentHeader);
                    ///    IndentHeaderForm.RUN;
                    //ND Tri End Cust 38
                end;
            }
            action("RFQ No.")
            {
                Caption = 'Request For Quotations';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Request for Quotations";
                ApplicationArea = All;
            }
            action(Reports)
            {
                Caption = 'Reports';
                Enabled = ReportsEnable;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                //  ReportList: Record 243; //16225 table N/F
                begin
                    /* WITH ReportList DO //16225 Table N/F
                         ShowList(FIELDNO("Purchase Plant Reports"));*/
                end;
            }
            action(Documents)
            {
                Caption = 'Documents';
                Enabled = DocumentsEnable;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                // ReportList: Record 243; //16225 Table N/F
                begin
                    /* WITH ReportList DO //16225 Table N/F
                         ShowList(FIELDNO("Purchase Documents"));*/
                end;
            }
            action("Posted Receipts")
            {
                Caption = 'Posted Receipts';
                Enabled = "Posted ReceiptsEnable";
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38
                    LocationFilterString := '';
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    UserLocation.SETFILTER(UserLocation."Create Purchase Order", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    PurchRcptHeader.SETFILTER("Location Code", LocationFilterString);
                    ///   PostedPurchaseReceipt.SETTABLEVIEW(PurchRcptHeader);
                    ///   PostedPurchaseReceipt.RUN;
                    //ND Tri End Cust 38
                end;
            }
            action("Posted Invoices")
            {
                Caption = 'Posted Invoices';
                Enabled = "Posted InvoicesEnable";
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38
                    LocationFilterString := '';
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    UserLocation.SETFILTER(UserLocation."View Purchase Invoice", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    PurchInvHeader.SETFILTER("Location Code", LocationFilterString);
                    ///   PostedPurchaseInvoice.SETTABLEVIEW(PurchInvHeader);
                    ///   PostedPurchaseInvoice.RUN;
                    //ND Tri End Cust 38
                end;
            }
            action("Posted Return Shipments")
            {
                Caption = 'Posted Return Shipments';
                Enabled = "Posted Return ShipmentsEnable";
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38
                    LocationFilterString := '';
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    UserLocation.SETFILTER(UserLocation."View Purchase Return order", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    ReturnShipmentHeader.SETFILTER("Location Code", LocationFilterString);
                    ///    PostedReturnShipment.SETTABLEVIEW(ReturnShipmentHeader);
                    ///    PostedReturnShipment.RUN;
                    //ND Tri End Cust 38
                end;
            }
            action("Posted Credit Memos")
            {
                Caption = 'Posted Credit Memos';
                Enabled = "Posted Credit MemosEnable";
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38
                    LocationFilterString := '';
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    UserLocation.SETFILTER(UserLocation."View Purchase Credit memo", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    PurchCrMemoHdr.SETFILTER("Location Code", LocationFilterString);
                    ///   PostedPurchaseCreditMemo.SETTABLEVIEW(PurchCrMemoHdr);
                    ///   PostedPurchaseCreditMemo.RUN;
                    //ND Tri End Cust 38
                end;
            }
            action("Posted Debit Notes")
            {
                Caption = 'Posted Debit Notes';
                Enabled = "Posted Debit NotesEnable";
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "GST Credit Adjustment";
                ApplicationArea = All;
            }
            action(SubDeliveryChallan)
            {
                Caption = 'Posted Delivery Challan';
                Enabled = SubDeliveryChallanEnable;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Delivery Challan";
                ApplicationArea = All;
            }
            action(PostedSubconCompReciept)
            {
                Caption = 'Posted Subcon. Comp. Reciept';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Posted Subcon Comp. Receipt";
                ApplicationArea = All;
            }
            action(SubDeliveryChallanList)
            {
                Caption = 'Sub. Delivery Challan List';
                Enabled = SubDeliveryChallanListEnable;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                // DCheader: Record "16323"; //16225 Table N/F
                begin
                    // FORM.RUN(16327, DCheader); //16225 Table N/F
                end;
            }
            action("Posted Purchase Orders")
            {
                Caption = 'Posted Purchase Orders';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38
                    LocationFilterString := '';
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    UserLocation.SETFILTER(UserLocation."View Purchase Order", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    ///   PurchaseHeaderArchive.SETFILTER("Location Code", LocationFilterString);
                    ///   PurchaseOrderArchive.SETTABLEVIEW(PurchaseHeaderArchive);
                    ///   PurchaseOrderArchive.RUN;
                    //ND Tri End Cust 38
                end;
            }
            action("Posted Purchases Order")
            {
                Caption = 'Short Closed Purchase Orders';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38
                    LocationFilterString := '';
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    UserLocation.SETFILTER(UserLocation."View Purchase Order", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    /*   PurchaseHeaderArchive.SETFILTER("Location Code", LocationFilterString);
                       PurchaseHeaderArchive.SETFILTER("New Status", '%1', PurchaseHeaderArchive."New Status"::"1");
                       PurchaseOrderArchive.SETTABLEVIEW(PurchaseHeaderArchive);
                       PurchaseOrderArchive.RUN;*////
                    //ND Tri End Cust 38
                end;
            }
            action("Posted Purchase Order")
            {
                Caption = 'Cancelled Purchase Orders';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //ND Tri Start Cust 38
                    LocationFilterString := '';
                    UserLocation.RESET;
                    UserLocation.SETFILTER(UserLocation."User ID", USERID);
                    UserLocation.SETFILTER(UserLocation."View Purchase Order", '%1', TRUE);
                    IF UserLocation.FIND('-') THEN
                        REPEAT
                            IF (STRLEN(LocationFilterString) + STRLEN(UserLocation."Location Code")) < MAXSTRLEN(LocationFilterString) THEN
                                LocationFilterString := LocationFilterString + '|' + UserLocation."Location Code";
                        UNTIL UserLocation.NEXT = 0;

                    LocationFilterString := COPYSTR(LocationFilterString, 2, 250);

                    IF LocationFilterString = '' THEN
                        ERROR('Sorry please contact your System Administrator');

                    /*  PurchaseHeaderArchive.SETFILTER("Location Code", LocationFilterString);
                      PurchaseHeaderArchive.SETFILTER("New Status", '%1', PurchaseHeaderArchive."New Status"::"2");
                      PurchaseOrderArchive.SETTABLEVIEW(PurchaseHeaderArchive);
                      PurchaseOrderArchive.RUN;*//////
                                                 //ND Tri End Cust 38
                end;
            }
            action("Closed Indents")
            {
                Caption = 'Closed Indents';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Closed Indent Header";
                ApplicationArea = All;
            }
            action("Closed Indent")
            {
                Caption = 'Deleted Indents';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Deleted Indent Header";
                ApplicationArea = All;
            }
            action(Registers)
            {
                Caption = 'Registers';
                Enabled = RegistersEnable;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "G/L Registers";
                ApplicationArea = All;
            }
            action(Navigate)
            {
                Caption = 'Navigate';
                Enabled = NavigateEnable;
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page Navigate;
                ApplicationArea = All;
            }
        }
    }

    trigger OnInit()
    begin
        SubDeliveryChallanListEnable := TRUE;
        SubDeliveryChallanEnable := TRUE;
        SubconOrderEnable := TRUE;
        "Posted Debit NotesEnable" := TRUE;
        "Debit NotesEnable" := TRUE;
        PaymentsEnable := TRUE;
        NavigateEnable := TRUE;
        RegistersEnable := TRUE;
        "Posted Credit MemosEnable" := TRUE;
        "Posted Return ShipmentsEnable" := TRUE;
        "Posted InvoicesEnable" := TRUE;
        "Posted ReceiptsEnable" := TRUE;
        DocumentsEnable := TRUE;
        ReportsEnable := TRUE;
        "Credit MemosEnable" := TRUE;
        "Return OrdersEnable" := TRUE;
        InvoicesEnable := TRUE;
        OrdersEnable := TRUE;
        "Blanket OrdersEnable" := TRUE;
        QuotesEnable := TRUE;
        "Requisition WorksheetsEnable" := TRUE;
        "Payment JournalsEnable" := TRUE;
        "Purchase JournalsEnable" := TRUE;
        VendorsEnable := TRUE;
    end;

    trigger OnOpenPage()
    var
        MainMenuPermissionMgt: Codeunit "Data Compression";
    begin
        /*  VendorsEnable :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::Vendor, FORM::"Vendor Card");
          "Purchase JournalsEnable" :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::"Gen. Journal Line", FORM::"Purchase Journal") AND
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::"Gen. Journal Template", FORM::"General Journal Templates");
          "Payment JournalsEnable" :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::"Gen. Journal Line", FORM::"Payment Journal") AND
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::"Gen. Journal Template", FORM::"General Journal Templates");
          "Requisition WorksheetsEnable" :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::"Requisition Line", FORM::"Req. Worksheet");
          QuotesEnable :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::"Purchase Header", FORM::"Purchase Quote");
          "Blanket OrdersEnable" :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::"Purchase Header", FORM::"Blanket Purchase Order");
          OrdersEnable :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::"Purchase Header", FORM::" Purchase Order");
          InvoicesEnable :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::"Purchase Header", FORM::"Purchase Invoice");
          "Return OrdersEnable" :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::"Purchase Header", FORM::"Purchase Return Order");
          "Credit MemosEnable" :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::"Purchase Header", FORM::"Purchase Credit Memo");
          ReportsEnable :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::Table243, FORM::Form282);
          DocumentsEnable :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::Table243, FORM::Form282);
          "Posted ReceiptsEnable" :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::"Purch. Rcpt. Header", FORM::"Posted Purchase Receipt");
          "Posted InvoicesEnable" :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::"Purch. Inv. Header", FORM::"Posted Purchase Invoice");
          "Posted Return ShipmentsEnable" :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::"Return Shipment Header", FORM::"Posted Return Shipment");
          "Posted Credit MemosEnable" :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::"Purch. Cr. Memo Hdr.", FORM::"Posted Purchase Credit Memos");
          RegistersEnable :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::"G/L Register", FORM::"G/L Registers");
          NavigateEnable :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::"Document Entry", FORM::Navigate);
          // NAVIN
          PaymentsEnable :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::Table16372, FORM::Form16383);
          "Debit NotesEnable" :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::"Purchase Header", FORM::Form16393);
          "Posted Debit NotesEnable" :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::"Purch. Cr. Memo Hdr.", FORM::Form16396);
          SubconOrderEnable :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::"Purch. Cr. Memo Hdr.", FORM::"Subcontracting Order");
          SubDeliveryChallanEnable :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::"Purchase Header", FORM::"Delivery Challan");
          SubDeliveryChallanListEnable :=
            MainMenuPermissionMgt.EnableMenuItem(DATABASE::"Purchase Header", FORM::"Delivery Challan List");*////


        // NAVIN
    end;

    var
        GenJnlManagement: Codeunit GenJnlManagement;
        ReqJnlManagement: Codeunit ReqJnlManagement;
        GenJnlTemplate: Record "Gen. Journal Template";
        // GenJnlHeader: Record "16372";//16225 Table N/F
        LocationFilterString: Text[250];
        UserLocation: Record "User Location";
        PurchaseHeader: Record "Purchase Header";
        IndentHeader: Record "Indent Header";
        UserSetup: Record "User Setup";
        "-----For Posted-----": Integer;
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchaseHeaderArchive: Record "Freight Master IBOT";
        ReturnShipmentHeader: Record "Return Shipment Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        [InDataSet]
        VendorsEnable: Boolean;
        [InDataSet]
        "Purchase JournalsEnable": Boolean;
        [InDataSet]
        "Payment JournalsEnable": Boolean;
        [InDataSet]
        "Requisition WorksheetsEnable": Boolean;
        [InDataSet]
        QuotesEnable: Boolean;
        [InDataSet]
        "Blanket OrdersEnable": Boolean;
        [InDataSet]
        OrdersEnable: Boolean;
        [InDataSet]
        InvoicesEnable: Boolean;
        [InDataSet]
        "Return OrdersEnable": Boolean;
        [InDataSet]
        "Credit MemosEnable": Boolean;
        [InDataSet]
        ReportsEnable: Boolean;
        [InDataSet]
        DocumentsEnable: Boolean;
        [InDataSet]
        "Posted ReceiptsEnable": Boolean;
        [InDataSet]
        "Posted InvoicesEnable": Boolean;
        [InDataSet]
        "Posted Return ShipmentsEnable": Boolean;
        [InDataSet]
        "Posted Credit MemosEnable": Boolean;
        [InDataSet]
        RegistersEnable: Boolean;
        [InDataSet]
        NavigateEnable: Boolean;
        [InDataSet]
        PaymentsEnable: Boolean;
        [InDataSet]
        "Debit NotesEnable": Boolean;
        [InDataSet]
        "Posted Debit NotesEnable": Boolean;
        [InDataSet]
        SubconOrderEnable: Boolean;
        [InDataSet]
        SubDeliveryChallanEnable: Boolean;
        [InDataSet]
        SubDeliveryChallanListEnable: Boolean;
        Text19058388: Label 'Purchases && Payables';
}

