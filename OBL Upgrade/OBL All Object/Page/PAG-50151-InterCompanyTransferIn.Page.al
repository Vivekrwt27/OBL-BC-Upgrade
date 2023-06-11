page 50151 "Inter Company Transfer - In"
{
    Caption = 'Inter Company Transfer - In';
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Invoice),
                            "Inter Company" = FILTER(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //MS-PB To Filter IC Vendor BEGIN
                        Vendor.FINDFIRST;
                        Vendor.SETFILTER("IC Partner Code", '<>%1', '');
                        IF PAGE.RUNMODAL(Page::"Vendor List", Vendor) = ACTION::LookupOK THEN BEGIN
                            Rec.VALIDATE("Buy-from Vendor No.", Vendor."No.");
                        END;

                        //END;
                    end;

                    trigger OnValidate()
                    begin
                        BuyfromVendorNoOnAfterValidate;
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Buy-from Address"; Rec."Buy-from Address")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Buy-from Address 2"; Rec."Buy-from Address 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    Caption = 'Buy-from Post Code/City';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Buy-from City"; Rec."Buy-from City")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    ApplicationArea = All;
                }
                /* field(Structure; Structure)//16225 Field N/f
                 {
                     ApplicationArea = All;
                 }*/
                field("Vendor Classification"; Rec."Vendor Classification")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Security Amount"; Rec."Security Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    Caption = 'Narration';
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
                {
                    ApplicationArea = All;
                }
                field("Other Comp. Location"; Rec."Other Comp. Location")
                {
                    Caption = 'Rcpt. From to other Com. Loc.';
                    Editable = false;
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(PurchLines; "Purch. Invoice Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            group(CustInfoPanel)
            {
                Caption = 'Vendor Information';
                label(Control155)
                {
                    CaptionClass = Text19023272;
                    ApplicationArea = All;
                }
                //16225  field(Control150; STRSUBSTNO('(%1)', PurchInfoPaneMgmt.CalcNoOfOrderAddr(Rec."Buy-from Vendor No.")))
                field(Control150; STRSUBSTNO('(%1)', (Rec."Buy-from Vendor No.")))
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                //16225field(Control147; STRSUBSTNO('(%1)', PurchInfoPaneMgmt.CalcNoOfContacts(Rec)))
                field(Control147; STRSUBSTNO('(%1)', (Rec)))
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                label(Control156)
                {
                    CaptionClass = Text19005663;
                    ApplicationArea = All;
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PaytoVendorNoOnAfterValidate;
                    end;
                }
                field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay-to Address"; Rec."Pay-to Address")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    Caption = 'Pay-to Post Code/City';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay-to City"; Rec."Pay-to City")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                /* field("Form No.";"Form No.")//16225 Table field N/f
                 {
                 }*/
                field("Your Reference"; Rec."Your Reference")
                {
                    Caption = 'Export Reference No.';
                    ApplicationArea = All;
                }
                field("Inter Company"; Rec."Inter Company")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //ShortcutDimension1CodeOnAfterValidate;
                        ShortcutDimension1CodeOnAfterV
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //ShortcutDimension2CodeOnAfterValidate;
                        ShortcutDimension2CodeOnAfterV
                    end;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("On Hold"; Rec."On Hold")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //PricesIncludingVATOnAfterValidate;
                        PricesIncludingVATOnAfterValid
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code/City';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                /*field("Transit Document";"Transit Document")//16225
                {
                }*/
                field("Transporter's Code"; Rec."Transporter's Code")
                {
                    ApplicationArea = All;
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                /*   field("Vendor Shipment Date";"Vendor Shipment Date")//16225
                   {
                       Editable = false;
                   }*/
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date");
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrencyCodeOnAfterValidate;
                    end;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ApplicationArea = All;
                }
                field(Area1; Rec."Area")
                {
                    ApplicationArea = All;
                }
            }
            group("E-Commerce")
            {
                Caption = 'E-Commerce';
            }
            group(Application)
            {
                Caption = 'Application';
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = All;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = All;
                }
            }
            group("Tax Information")
            {
                Caption = 'Tax Information';
                //16225 table field N/F
                /* field("Consignment Note No.";"Consignment Note No.")
                 {
                 }
                 field("Declaration Form (GTA)";"Declaration Form (GTA)")
                 {
                 }
                 field("Input Service Distribution";"Input Service Distribution")
                 {
                 }*/
                field(Trading; Rec.Trading)
                {
                    ApplicationArea = All;
                }
                //16225 Table Field N/F
                /*field("C Form";"C Form")
                {
                }
                field("Form Code";"Form Code")
                {
                }
                field("LC No.";"LC No.")
                {
                }
                field("Service Tax Rounding Precision";"Service Tax Rounding Precision")
                {
                }
                field("Service Tax Rounding Type";"Service Tax Rounding Type")
                {
                }
                group("Manufacturer Detail")
                {
                    Caption = 'Manufacturer Detail';
                    field("Manufacturer E.C.C. No.";"Manufacturer E.C.C. No.")
                    {
                    }
                    field("Manufacturer Name";"Manufacturer Name")
                    {
                    }
                    field("Manufacturer Address";"Manufacturer Address")
                    {
                    }
                }*/
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Invoice")
            {
                Caption = '&Invoice';
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.CalcInvDiscForHeader;
                        COMMIT;
                        //16225 Structure Fielld N/F
                        /* IF Rec.Structure <> '' THEN BEGIN
                           PurchLine.CalculateStructures(Rec);
                           PurchLine.AdjustStructureAmounts(Rec);
                           PurchLine.UpdatePurchLines(Rec);
                           PurchLine.CalculateTDS(Rec);
                           COMMIT;
                         END ELSE BEGIN
                           PurchLine.CalculateTDS(Rec);
                           COMMIT;
                         END;*/
                        PAGE.RUNMODAL(PAGE::"Purchase Statistics", Rec);
                    end;
                }
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                    "No." = FIELD("No."),
                    "Document Line No." = CONST(0);
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                /*  action(Approvals)
                 {
                     Caption = 'Approvals';
                     Image = Approvals;
                     ApplicationArea = All;

                     trigger OnAction()
                     var
                         ApprovalEntries: Page "Approval Entries";
                     begin
                         ApprovalEntries.Setfilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");
                         ApprovalEntries.RUN;
                     end;
                 }
                 */ //16225 Page N/F Start
                    /* action("St&ructure")
                     {
                         Caption = 'St&ructure';
                         RunObject = Page 16305;
                                         RunPageLink = Type=CONST(Purchase),
                                       Document Type=FIELD(Document Type),
                                       Document No.=FIELD(No.),
                                       Structure Code=FIELD(Structure);
                     }
                     action("Transit Documents")
                     {
                         Caption = 'Transit Documents';
                         RunObject = Page 13705;
                                         RunPageLink = Type=CONST(Purchase),
                                       PO / SO No.=FIELD(No.),
                                       Vendor / Customer Ref.=FIELD(Buy-from Vendor No.);
                     }
                     action("Attached Gate Entry")
                     {
                         Caption = 'Attached Gate Entry';
                         RunObject = Page 16481;
                                         RunPageLink = Entry Type=CONST(Inward),
                                       Purchase Invoice No.=FIELD(No.);
                     }
                     action("Detailed Tax")
                     {
                         Caption = 'Detailed Tax';
                         RunObject = Page 16341;
                                         RunPageLink = Document Type=FIELD(Document Type),
                                       Document No.=FIELD(No.),
                                       Transaction Type=CONST(Purchase);
                     }*///16225 Page N/F End
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Calculate &Invoice Discount")
                {
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                    end;
                }
                action("Get St&d. Vend. Purchase Codes")
                {
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                action("&Get Receipt Lines")
                {
                    Caption = '&Get Receipt Lines';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PurchaseLines: Record "Purchase Line";
                    begin
                        CurrPage.PurchLines.PAGE.GetReceipt;
                        //ND Start
                        PurchaseLines.RESET;
                        PurchaseLines.SETFILTER(PurchaseLines."Document Type", '%1', Rec."Document Type");
                        PurchaseLines.SETFILTER(PurchaseLines."Document No.", '%1', Rec."No.");
                        PurchaseLines.SETFILTER(PurchaseLines."Location Code", '<>%1', '');
                        IF PurchaseLines.FIND('-') THEN
                            REPEAT
                                PurchaseLines.VALIDATE(PurchaseLines."Location Code", PurchaseLines."Location Code");
                            UNTIL PurchaseLines.NEXT = 0;
                        //ND End;
                    end;
                }
                action("Get Gate Entry Lines")
                {
                    Caption = 'Get Gate Entry Lines';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //16225 Funcation N/F  GetGateEntryLines;
                    end;
                }
                action("Copy Document")
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL;
                        CLEAR(CopyPurchDoc);
                    end;
                }
                action("Move Negative Lines")
                {
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegPurchLines);
                        MoveNegPurchLines.SetPurchHeader(Rec);
                        MoveNegPurchLines.RUNMODAL;
                        MoveNegPurchLines.ShowDocument;
                    end;
                }
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";//16225//439 Replace "Approvals Mgmt."
                    begin
                        //16225 IF ApprovalMgt.SendPurchaseApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";//16225//439 Replace "Approvals Mgmt."
                    begin
                        //16225  IF ApprovalMgt.CancelPurchaseApprovalRequest(Rec, TRUE, TRUE) THEN;
                    end;
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        Rec.TESTFIELD("Buy-from Post Code");
                        Rec.TESTFIELD("Vendor Invoice No.");
                        Rec.TESTFIELD("Vendor Invoice Date");
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                action("Calc&ulate Structure Values")
                {
                    Caption = 'Calc&ulate Structure Values';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //16225 Funcation n/F start
                        /* PurchLine.CalculateStructures(Rec);
                         PurchLine.AdjustStructureAmounts(Rec);
                         PurchLine.UpdatePurchLines(Rec);*///16225 Funcation N/F End
                    end;
                }
                action("Calculate TDS")
                {
                    Caption = 'Calculate TDS';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //16225 PurchLine.CalculateTDS(Rec);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                        ApprovalMgt: Codeunit "Approvals Mgmt.";//16225 439 replace "Approvals Mgmt."
                    begin
                        // NAVIN
                        //16225 Funcation N/f Start
                        /*IF Structure <> '' THEN BEGIN
                        PurchLine.CalculateStructures(Rec);
                        PurchLine.AdjustStructureAmounts(Rec);
                        PurchLine.UpdatePurchLines(Rec);
                        COMMIT;
                         END;*///16225 Funcation N/f End
                               // NAVIN

                        //16225 IF ApprovalMgt.PrePostApprovalCheck(SalesHeader, Rec) THEN
                        IF ApprovalMgt.PrePostApprovalCheckSales(SalesHeader) THEN
                            CODEUNIT.RUN(CODEUNIT::"Purch.-Post (Yes/No)", Rec);
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        // NAVIN
                        //16225 Funcation  N/F Start
                        /* IF Structure <> '' THEN BEGIN
                         PurchLine.CalculateStructures(Rec);
                         PurchLine.AdjustStructureAmounts(Rec);
                         PurchLine.UpdatePurchLines(Rec);
                         COMMIT;
                         END;*///16225 Funcation  N/F End
                               // NAVIN
                               //16225 IF ApprovalMgt.PrePostApprovalCheck(SalesHeader, Rec) THEN
                        IF ApprovalMgt.PrePostApprovalCheckSales(SalesHeader) THEN
                            CODEUNIT.RUN(CODEUNIT::"Purch.-Post + Print", Rec);
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Invoices", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("&Freight Voucher")
                {
                    Caption = '&Freight Voucher';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        PILine.RESET;
                        PILine.SETFILTER(PILine."Document No.", Rec."No.");
                        IF PILine.FIND('-') THEN BEGIN
                            FreightVoucher.SETTABLEVIEW(PILine);
                            FreightVoucher.RUN;
                        END;
                    end;
                }
            }
            action(PurchHistoryBtn)
            {
                Caption = 'Purchase H&istory';
                Promoted = true;
                PromotedCategory = Process;
                Visible = PurchHistoryBtnVisible;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //PurchInfoPaneMgmt.LookupVendPurchaseHistory(Rec,"Pay-to Vendor No.",TRUE);
                    //code blocked for upgrade
                end;
            }
            action(PurchHistoryBtn1)
            {
                Caption = 'Purchase Histor&y';
                Promoted = true;
                PromotedCategory = Process;
                Visible = PurchHistoryBtn1Visible;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //PurchInfoPaneMgmt.LookupVendPurchaseHistory(Rec,"Buy-from Vendor No.",FALSE);
                    //code blocked for upgrade
                end;
            }
            action("&Contacts")
            {
                Caption = '&Contacts';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //16225   PurchInfoPaneMgmt.LookupContacts(Rec);
                end;
            }
            action("Order &Addresses")
            {
                Caption = 'Order &Addresses';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //16225   PurchInfoPaneMgmt.LookupOrderAddr(Rec);
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(Rec.ConfirmDeletion);
    end;

    trigger OnInit()
    begin
        PurchHistoryBtn1Visible := TRUE;
        PayToCommentBtnVisible := TRUE;
        PayToCommentPictVisible := TRUE;
        PurchHistoryBtnVisible := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
        Rec."Inter Company" := TRUE;
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter);
            Rec.FILTERGROUP(0);
        END;
        //TRI SC
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

        rec.FILTERGROUP(2);
        rec.SETFILTER("Location Code", LocationFilterString);
        rec.FILTERGROUP(0);
        //ND Tri End Cust 38
        //TRI SC
    end;

    var
        ChangeExchangeRate: Page "Change Exchange Rate";
        PurchSetup: Record "Purchases & Payables Setup";
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        PurchInfoPaneMgmt: Codeunit 7181;
        // DefermentBuffer: Record 16532;//16225 Table N/F
        PurchLine: Record "Purchase Line";
        "-- NAVIN --": Integer;
        WFAmount: Decimal;
        WFPurchLine: Record "Purchase Line";
        LineNo: Integer;
        IsValid: Boolean;
        ReleasePurchaseDocument: Codeunit "Release Purchase Document";
        UserSetup: Record "User Setup";
        //"--NAVIN--": ;
        Text13000: Label 'No Setup exists for this Amount.';
        Text13001: Label 'Do you want to send the Invoice for Authorization?';
        Text13002: Label 'The Invoice Is Authorized, You Cannot Resend For Authorization';
        Text13003: Label 'You Cannot Resend For Authorization';
        Text13004: Label 'This Invoice Has been Rejected. Please Create A New Invoice.';
        UserLocation: Record "User Location";
        LocationFilterString: Text[250];
        PILine: Record "Purchase Line";
        FreightVoucher: Report "Production Planning Report";
        Vendor: Record Vendor;
        [InDataSet]

        PurchHistoryBtnVisible: Boolean;
        [InDataSet]
        PayToCommentPictVisible: Boolean;
        [InDataSet]
        PayToCommentBtnVisible: Boolean;
        [InDataSet]
        PurchHistoryBtn1Visible: Boolean;
        Text19023272: Label 'Buy-from Vendor';
        Text19005663: Label 'Pay-to Vendor';

    local procedure ApproveCalcInvDisc()
    var
        PILine: Record "Purchase Line";
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure UpdateInfoPanel()
    var
        DifferBuyFromPayTo: Boolean;
    begin
        DifferBuyFromPayTo := Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
        PurchHistoryBtnVisible := DifferBuyFromPayTo;
        PayToCommentPictVisible := DifferBuyFromPayTo;
        PayToCommentBtnVisible := DifferBuyFromPayTo;
        //16225  PurchHistoryBtn1Visible := PurchInfoPaneMgmt.DocExist(Rec, "Buy-from Vendor No.");
        IF DifferBuyFromPayTo THEN;
        //16225PurchHistoryBtnVisible := PurchInfoPaneMgmt.DocExist(Rec, "Pay-to Vendor No.")
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;

    local procedure CurrencyCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;
}

