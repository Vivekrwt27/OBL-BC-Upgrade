page 50100 "Import Order"
{
    Caption = 'Purchase Order';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order),
                            Subcontracting = FILTER(false));

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

                    trigger OnValidate()
                    begin
                        BuyfromVendorNoOnAfterValidate;
                    end;
                }
                field("Buy-from Contact No."; Rec."Buy-from Contact No.")
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
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ApplicationArea = All;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ApplicationArea = All;
                }
                /*    field(Structure; Structure)
                    {
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
                field("Security Date"; Rec."Security Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Locked Order"; Rec."Locked Order")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Delivary Date"; Rec."Delivary Date")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    Caption = 'Truck No.';
                    ApplicationArea = All;
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("GE No."; Rec."GE No.")
                {
                    ApplicationArea = All;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ApplicationArea = All;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PurchaserCodeOnAfterValidate;
                    end;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("RFQ No."; Rec."RFQ No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quotation No."; Rec."Quotation No.")
                {
                    Caption = 'Quote No.';
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Capital PO"; Rec."Capital PO")
                {
                    ApplicationArea = All;
                }
            }
            part(PurchLines; "Import Order Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            group(VendInfoPanel)
            {
                Caption = 'Vendor Information';
                label(Control41)
                {
                    CaptionClass = Text19023272;
                    ApplicationArea = All;
                }
                //16630  field(Control228; STRSUBSTNO('(%1)', PurchInfoPaneMgmt.CalcNoOfOrderAddr(Rec."Buy-from Vendor No.")))
                field(Control228; STRSUBSTNO('(%1)', (Rec."Buy-from Vendor No.")))
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                //16630 field(Control225; STRSUBSTNO('(%1)', PurchInfoPaneMgmt.CalcNoOfContacts(Rec)))
                field(Control225; STRSUBSTNO('(%1)', (Rec)))
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                label(Control)
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
                    ApplicationArea = All;
                }
                /*    field("C Form"; "C Form")//16630 table field N/f
                    {
                        Visible = true;
                    }
                    field("Form Code"; "Form Code")
                    {
                    }
                    field("Form No."; "Form No.")
                    {
                    }*/
                field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Form 31 Amount"; Rec."Form 31 Amount")
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
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("On Hold"; Rec."On Hold")
                {
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
                    ApplicationArea = All;
                }
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    ApplicationArea = All;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code/City';
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                //16630 field N/F 
                /*    field("Vendor Shipment Date"; "Vendor Shipment Date")
                    {
                    }*/
                field("Transporter's Code"; Rec."Transporter's Code")
                {
                    ApplicationArea = All;
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ApplicationArea = All;
                }
                field("Delivery Period"; Rec."Delivery Period")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ApplicationArea = All;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                }
                field("Receiving No. Series"; Rec."Receiving No. Series")
                {
                    ApplicationArea = All;
                }
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
                field(Area1; Rec.Area)
                {
                    ApplicationArea = All;
                }
            }
            group("E-Commerce")
            {
                Caption = 'E-Commerce';
            }
            group(Prepayment)
            {
                Caption = 'Prepayment';
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Prepayment37OnAfterValidate;
                    end;
                }
                field("Compress Prepayment"; Rec."Compress Prepayment")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Payment Terms Code"; Rec."Prepmt. Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Due Date"; Rec."Prepayment Due Date")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Payment Discount %"; Rec."Prepmt. Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Pmt. Discount Date"; Rec."Prepmt. Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
                {
                    ApplicationArea = All;
                }
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
                /*    field("Consignment Note No."; "Consignment Note No.")
                    {
                    }
                    field("Declaration Form (GTA)"; "Declaration Form (GTA)")
                    {
                    }
                    field("Input Service Distribution"; "Input Service Distribution")
                    {
                    }
                    field("Transit Document"; "Transit Document")
                    {
                    }*/
                field(Trading; Rec.Trading)
                {
                    ApplicationArea = All;
                }
                //16630 field N/F Start
                /*   field("LC No."; "LC No.")
                   {
                   }
                   field("Service Tax Rounding Precision"; "Service Tax Rounding Precision")
                   {
                   }
                   field("Service Tax Rounding Type"; "Service Tax Rounding Type")
                   {
                   }*///16630 field N/F End
                group("Manufacturer Detail")
                {
                    Caption = 'Manufacturer Detail';
                    //16630 field N/F Start
                    /*    field("Manufacturer E.C.C. No."; "Manufacturer E.C.C. No.")
                        {
                        }
                        field("Manufacturer Name"; "Manufacturer Name")
                        {
                        }
                        field("Manufacturer Address"; "Manufacturer Address")
                        {
                        }*///16630 field N/F End
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
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
                        PurchSetup.GET;
                        IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                            rec.CalcInvDiscForHeader;
                            COMMIT;
                        END;
                        //16630 field N/F
                        /*  IF Rec.Structure <> '' THEN BEGIN
                              PurchLine.CalculateStructures(Rec);
                              PurchLine.AdjustStructureAmounts(Rec);
                              PurchLine.UpdatePurchLines(Rec);
                              PurchLine.CalculateTDS(Rec);
                          END ELSE BEGIN
                              PurchLine.CalculateTDS(Rec);
                          END;*/

                        COMMIT;
                        PAGE.RUNMODAL(PAGE::"Purchase Order Statistics", Rec);
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
                                  "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Receipts)
                {
                    Caption = 'Receipts';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ApplicationArea = All;
                }
                action(Invoices)
                {
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ApplicationArea = All;
                }
                action("Prepa&yment Invoices")
                {
                    Caption = 'Prepa&yment Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    ApplicationArea = All;
                }
                action("Prepayment Credi&t Memos")
                {
                    Caption = 'Prepayment Credi&t Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
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
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        // ApprovalEntries.Setfilters(DATABASE::"Purchase Header", Rec."Document Type", rec."No.");
                        //ApprovalEntries.RUN;
                    end;
                }
                separator(Control1)
                {
                }
                action("Whse. Receipt Lines")
                {
                    Caption = 'Whse. Receipt Lines';
                    RunObject = Page "Whse. Receipt Lines";
                    RunPageLink = "Source Type" = CONST(39),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    ApplicationArea = All;
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Purchase Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                    ApplicationArea = All;
                }
                separator(Control11)
                {
                }
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    action("Get&Sales Order")
                    {
                        Caption = 'Get &Sales Order';
                        RunObject = Codeunit "Purch.-Get Drop Shpt.";
                        ApplicationArea = All;
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    action("Get &Sales Order")
                    {
                        Caption = 'Get &Sales Order';
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            DistIntegration: Codeunit "Dist. Integration";
                            PurchHeader: Record "Purchase Header";
                        begin
                            PurchHeader.COPY(Rec);
                            DistIntegration.GetSpecialOrders(PurchHeader);
                            Rec := PurchHeader;
                        end;
                    }
                }
                separator(Cntrol)
                {
                }
                action("St&ructure")
                {
                    ApplicationArea = All;
                    /*  Caption = 'St&ructure';
                      RunObject = Page 16305;
                      RunPageLink = Type = CONST(Purchase),
                                    "Document Type" = FIELD("Document Type"),
                                    "Document No." = FIELD("No.");*/
                }
                action("Transit Documents")
                {
                    ApplicationArea = All;
                    //16630 Page N/F
                    /*   Caption = 'Transit Documents';
                       RunObject = Page 13705;
                       RunPageLink = Type = CONST(Purchase),
                                     "PO / SO No." = FIELD("No."),
                                     "Vendor / Customer Ref." = FIELD("Buy-from Vendor No."),
                                     State = FIELD(State);*/
                }
                action("Deferment Schedule")
                {
                    ApplicationArea = All;
                    //16630 Page N/F
                    /*    Caption = 'Deferment Schedule';
                        RunObject = Page 16558;
                        RunPageLink = "Document No." = FIELD("No.");*/
                }
                action("Attached Gate Entry")
                {
                    Caption = 'Attached Gate Entry';
                    RunObject = Page "Gate Entry Attachment List";
                    RunPageLink = "Source No." = FIELD("No."),
                                  "Source Type" = CONST("Purchase Order"),
                                  "Entry Type" = CONST(Inward);
                    ApplicationArea = All;
                }
                action("Detailed &Tax")
                {
                    ApplicationArea = All;
                    //16630 Page N/F
                    /*   Caption = 'Detailed &Tax';
                       RunObject = Page 16341;
                       RunPageLink = "Document Type" = FIELD("Document Type"),
                                     "Document No." = FIELD("No."),
                                     "Transaction Type" = CONST(Purchase);*/
                }
                action("&Get Indent Headers")
                {
                    Caption = '&Get Indent Headers';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CompletlyOrdered;

                        PurchaseLine2.RESET;
                        PurchaseLine2.SETFILTER(PurchaseLine2."Document Type", '%1', PurchaseLine2."Document Type"::Order);
                        PurchaseLine2.SETFILTER(PurchaseLine2."Document No.", rec."No.");
                        IF PurchaseLine2.FIND('+') THEN
                            LineNo1 := PurchaseLine2."Line No.";

                        IndentHeader.RESET;
                        IndentHeader.SETFILTER(Deleted, '%1', FALSE);
                        IndentHeader.SETFILTER(Status, '%1', IndentLine.Status::Authorized);
                        IndentHeader.SETFILTER(IndentHeader."Completely Ordered", '%1', FALSE);
                        IF PAGE.RUNMODAL(Page::"Indent Header List", IndentHeader) = ACTION::LookupOK THEN BEGIN
                            IndentHeader.SETFILTER(IndentHeader.Selection, '%1', TRUE);
                            IF IndentHeader.FIND('-') THEN
                                REPEAT
                                    IndentHeader.Selection := FALSE;
                                    IndentHeader.MODIFY;
                                    IndentLine.RESET;
                                    IndentLine.SETFILTER(IndentLine."Document No.", IndentHeader."No.");
                                    IndentLine.SETFILTER(IndentLine.Deleted, '%1', FALSE);
                                    IndentLine.SETFILTER(IndentLine.Status, '%1', IndentLine.Status::Authorized);
                                    IndentLine.SETFILTER(IndentLine."Order No.", '%1', '');
                                    IndentLine.SETFILTER("No.", '<>%1', '');
                                    IF IndentLine.FIND('-') THEN
                                        REPEAT
                                            LineNo1 := LineNo1 + 10000;

                                            IF IndentLine.Type = IndentLine.Type::Item THEN BEGIN
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Document Type", PurchaseLine2."Document Type"::Order);
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Document No.", rec."No.");
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Line No.", LineNo1);
                                                PurchaseLine2.VALIDATE(PurchaseLine2.Type, PurchaseLine2.Type::Item);
                                                PurchaseLine2.VALIDATE(PurchaseLine2."No.", IndentLine."No.");
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Unit of Measure", IndentLine."Unit of Measurement");
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Item Category Code", IndentLine."Item Category Code");
                                                PurchaseLine2.VALIDATE(PurchaseLine2.Quantity, IndentLine.Quantity);
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Direct Unit Cost", IndentLine.Rate);
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Indent No.", IndentLine."Document No.");
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Indent Line No.", IndentLine."Line No.");
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Indent Date", IndentLine.Date);
                                                IF CONFIRM('Do you want to use Indent Location?', TRUE) THEN
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."Location Code", IndentLine."Location Code");
                                                PurchaseLine2.INSERT(TRUE);
                                            END ELSE
                                                IF IndentLine.Type = IndentLine.Type::"Non Stock Item" THEN BEGIN
                                                    IndentLine.TESTFIELD(IndentLine."G/L Account");
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."Document Type", PurchaseLine2."Document Type"::Order);
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."Document No.", rec."No.");
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."Line No.", LineNo1);
                                                    PurchaseLine2.VALIDATE(PurchaseLine2.Type, PurchaseLine2.Type::"G/L Account");
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."Indent Date", IndentLine.Date);
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."No.", IndentLine."G/L Account");
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."Unit of Measure", IndentLine."Unit of Measurement");
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."Item Category Code", IndentLine."Item Category Code");
                                                    PurchaseLine2.VALIDATE(PurchaseLine2.Quantity, IndentLine.Quantity);
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."Direct Unit Cost", IndentLine.Rate);
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."Indent No.", IndentLine."Document No.");
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."Indent Line No.", IndentLine."Line No.");
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."Indent Date", IndentLine.Date);
                                                    IF CONFIRM('Do you want to use Indent Location?', TRUE) THEN
                                                        PurchaseLine2.VALIDATE(PurchaseLine2."Location Code", IndentLine."Location Code");
                                                    PurchaseLine2.INSERT(TRUE);
                                                END;

                                            /*
                                              PurchaseLine2.RESET;
                                              PurchaseLine2.VALIDATE(PurchaseLine2."Document Type",PurchaseLine2."Document Type"::Order);
                                              PurchaseLine2.VALIDATE(PurchaseLine2."Document No.","No.");
                                              IF IndentLine.Type = IndentLine.Type::Item THEN
                                                PurchaseLine2.VALIDATE(PurchaseLine2.Type,PurchaseLine2.Type::Item);
                                              IF IndentLine.Type = IndentLine.Type::"Non Stock Item" THEN
                                                PurchaseLine2.VALIDATE(PurchaseLine2.Type,PurchaseLine2.Type::"Non Stock Item");
                                              IF CONFIRM('Do you want to use Indent Location.',TRUE) THEN
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Location Code",IndentLine."Location Code");
                                              PurchaseLine2.VALIDATE(PurchaseLine2."No.",IndentLine."No.");
                                              PurchaseLine2.VALIDATE(PurchaseLine2."Unit of Measure",IndentLine."Unit of Measurement");
                                              PurchaseLine2.VALIDATE(PurchaseLine2."Item Category Code",IndentLine."Item Category Code");
                                              PurchaseLine2.VALIDATE(PurchaseLine2.Quantity,IndentLine.Quantity);
                                              PurchaseLine2.VALIDATE(PurchaseLine2."Direct Unit Cost",IndentLine.Rate);
                                              PurchaseLine2.VALIDATE(PurchaseLine2."Indent No.",IndentLine."Document No.");
                                              PurchaseLine2.VALIDATE(PurchaseLine2."Indent Line No.",IndentLine."Line No.");
                                              PurchaseLine2.VALIDATE(PurchaseLine2."Line No.",LineNo1);
                                              PurchaseLine2.INSERT(TRUE);
                                            */

                                            IndentLine."Order No." := PurchaseLine2."Document No.";
                                            IndentLine."Order Line No." := PurchaseLine2."Line No.";
                                            IndentLine."Order Date" := rec."Posting Date";
                                            //  IndentLine.VALIDATE(IndentLine.Status,IndentLine.Status::Closed);
                                            IndentLine.MODIFY;

                                        UNTIL IndentLine.NEXT = 0;
                                    //  IndentHeader.VALIDATE(IndentHeader.Status,IndentHeader1.Status::Closed);
                                    IndentHeader.MODIFY;

                                UNTIL IndentHeader.NEXT = 0;
                        END;

                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                separator(Control12)
                {
                }
                action("&Get Indent Lines")
                {
                    Caption = '&Get Indent Lines';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Item: Record Item;
                    begin
                        PurchaseLine2.RESET;
                        PurchaseLine2.SETFILTER(PurchaseLine2."Document Type", '%1', PurchaseLine2."Document Type"::Order);
                        PurchaseLine2.SETFILTER(PurchaseLine2."Document No.", Rec."No.");
                        IF PurchaseLine2.FIND('+') THEN
                            LineNo1 := PurchaseLine2."Line No.";

                        IndentLine.RESET;
                        IndentLine.SETFILTER(IndentLine.Deleted, '%1', FALSE);
                        IndentLine.SETFILTER(IndentLine.Status, '%1', IndentLine.Status::Authorized);
                        IndentLine.SETFILTER(IndentLine."Order No.", '%1', '');
                        IndentLine.SETCURRENTKEY(IndentLine.Date); //TRI SC
                        IndentLine.SETFILTER("No.", '<>%1', '');
                        //IF NOT IndentLine.FIND('-') THEN
                        //  ERROR('There are no pending Indents');
                        IF PAGE.RUNMODAL(Page::"Indent Lines List", IndentLine) = ACTION::LookupOK THEN BEGIN
                            IndentLineList.GETRECORD(IndentLine);
                            IndentLine.SETFILTER(IndentLine.Selection, '%1', TRUE);
                            IF IndentLine.FIND('-') THEN
                                REPEAT
                                    IndentLine.Selection := FALSE;
                                    IndentLine.MODIFY;
                                    LineNo1 := LineNo1 + 10000;
                                    IF IndentLine.Type = IndentLine.Type::Item THEN BEGIN
                                        PurchaseLine2.VALIDATE(PurchaseLine2."Document Type", PurchaseLine2."Document Type"::Order);
                                        PurchaseLine2.VALIDATE(PurchaseLine2."Document No.", Rec."No.");
                                        PurchaseLine2.VALIDATE(PurchaseLine2."Line No.", LineNo1);
                                        PurchaseLine2.VALIDATE(PurchaseLine2.Type, PurchaseLine2.Type::Item);
                                        PurchaseLine2.VALIDATE(PurchaseLine2."No.", IndentLine."No.");
                                        PurchaseLine2.VALIDATE(PurchaseLine2."Unit of Measure", IndentLine."Unit of Measurement");
                                        PurchaseLine2.VALIDATE(PurchaseLine2."Item Category Code", IndentLine."Item Category Code");
                                        PurchaseLine2.VALIDATE(PurchaseLine2.Quantity, IndentLine.Quantity);
                                        PurchaseLine2.VALIDATE(PurchaseLine2."Direct Unit Cost", IndentLine.Rate);
                                        //16630    PurchaseLine2.VALIDATE(PurchaseLine2."Excise Bus. Posting Group", "Excise Bus. Posting Group");
                                        IF PurchaseLine2.Type = PurchaseLine2.Type::Item THEN
                                            IF Item.GET(PurchaseLine2."No.") THEN
                                                //16630 PurchaseLine2.VALIDATE(PurchaseLine2."Excise Prod. Posting Group", Item."Excise Prod. Posting Group");

                                                PurchaseLine2.VALIDATE(PurchaseLine2."Indent No.", IndentLine."Document No.");
                                        PurchaseLine2.VALIDATE(PurchaseLine2."Indent Line No.", IndentLine."Line No.");
                                        PurchaseLine2.VALIDATE(PurchaseLine2."Indent Date", IndentLine.Date);
                                        IF CONFIRM('Do you want to use Indent Location?', TRUE) THEN
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Location Code", IndentLine."Location Code");
                                        PurchaseLine2.INSERT(TRUE);
                                    END ELSE
                                        IF IndentLine.Type = IndentLine.Type::"Non Stock Item" THEN BEGIN
                                            IndentLine.TESTFIELD(IndentLine."G/L Account");
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Document Type", PurchaseLine2."Document Type"::Order);
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Document No.", Rec."No.");
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Line No.", LineNo1);
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Indent Date", IndentLine.Date);
                                            PurchaseLine2.VALIDATE(PurchaseLine2.Type, PurchaseLine2.Type::"G/L Account");
                                            PurchaseLine2.VALIDATE(PurchaseLine2."No.", IndentLine."G/L Account");
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Unit of Measure", IndentLine."Unit of Measurement");
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Item Category Code", IndentLine."Item Category Code");
                                            PurchaseLine2.VALIDATE(PurchaseLine2.Quantity, IndentLine.Quantity);
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Direct Unit Cost", IndentLine.Rate);
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Indent No.", IndentLine."Document No.");
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Indent Line No.", IndentLine."Line No.");
                                            IF IndentLine."Planning Date" <> 0D THEN
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Planned Receipt Date", IndentLine."Planning Date");
                                            PurchaseLine2.VALIDATE(PurchaseLine2."Indent Date", IndentLine.Date);
                                            //PurchaseLine2.VALIDATE(PurchaseLine2."Planned Receipt Date",IndentLine."Starting Date");
                                            IF CONFIRM('Do you want to use Indent Location?', TRUE) THEN
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Location Code", IndentLine."Location Code");
                                            PurchaseLine2.INSERT(TRUE);
                                        END;

                                    IndentLine."Order No." := PurchaseLine2."Document No.";
                                    IndentLine."Order Line No." := PurchaseLine2."Line No.";
                                    IndentLine.VALIDATE(IndentLine.Status, IndentLine.Status::Closed);
                                    IndentLine."Order Date" := rec."Posting Date";
                                    IndentLine.MODIFY;

                                UNTIL IndentLine.NEXT = 0;

                        END;
                    end;
                }
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
                separator(Control2)
                {
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
                separator(Control21)
                {
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
                action("Archi&ve Document")
                {
                    Caption = 'Archi&ve Document';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(FALSE);
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
                separator(Control3)
                {
                }
                action("Create &Whse. Receipt")
                {
                    Caption = 'Create &Whse. Receipt';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                    begin
                        GetSourceDocInbound.CreateFromPurchOrder(Rec);

                        IF NOT Rec.FIND('=><') THEN
                            Rec.INIT;
                    end;
                }
                action("Create Inventor&y Put-away / Pick")
                {
                    Caption = 'Create Inventor&y Put-away / Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.CreateInvtPutAwayPick;

                        IF NOT Rec.FIND('=><') THEN
                            Rec.INIT;
                    end;
                }
                action("Get Gate Entry Lines")
                {
                    Caption = 'Get Gate Entry Lines';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //16630  GetGateEntryLines;
                    end;
                }
                separator(Control31)
                {
                }
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //16630  IF ApprovalMgt.SendPurchaseApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //16630  IF ApprovalMgt.CancelPurchaseApprovalRequest(Rec, TRUE, TRUE) THEN;
                    end;
                }
                separator(Control32)
                {
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
                        "...tri1.0": Integer;
                        PurchLine1: Record "Purchase Line";
                    begin
                        IF UserSetup.GET(USERID) THEN BEGIN
                            IF UserSetup."Allow PO Release" = FALSE THEN
                                ERROR('%1 has no permission to Release the Purchase Order', UserSetup."User ID");
                        END;

                        //mo tri1.0 Customization no.44 start
                        Rec.TESTFIELD("Buy-from Post Code");
                        PurchLine1.RESET;
                        PurchLine1.SETRANGE("Document Type", Rec."Document Type");
                        PurchLine1.SETRANGE("Document No.", Rec."No.");
                        PurchLine1.SETFILTER(Type, '>0');
                        PurchLine1.SETFILTER(Quantity, '<>0');
                        IF PurchLine1.FIND('-') THEN
                            REPEAT
                                PurchLine1.VALIDATE("Qty. to Receive", 0);
                                PurchLine1.VALIDATE("Qty. to Invoice", 0);
                                PurchLine1.MODIFY;
                            UNTIL PurchLine1.NEXT = 0;
                        //mo tri1.0 Customization no.44 end
                        //Trident-Rakesh-Start 260906
                        IF Rec."Document Type" = rec."Document Type"::Order THEN BEGIN    //TRI A.S 04.08.09 Code Added
                            Rec."Locked Order" := TRUE;
                            Rec.MODIFY;
                            COMMIT;
                            //Trident-Rakesh-End 260906
                        END;
                        //ReleasePurchaseDocument.RUN(Rec);
                        ReleasePurchDoc.PerformManualRelease(Rec);
                        //mo tri1.0 Customization no. start
                        PurchLine1.RESET;
                        PurchLine1.SETRANGE("Document Type", rec."Document Type");
                        PurchLine1.SETRANGE("Document No.", rec."No.");
                        PurchLine1.SETFILTER(Type, '>0');
                        PurchLine1.SETFILTER(Quantity, '<>0');
                        PurchLine1.SETFILTER("Direct Unit Cost", '%1', 0);
                        IF PurchLine1.FIND('-') THEN
                            ERROR('Unit Cost of the Item %1 must not be zero while Release', PurchLine1."No.");
                        //mo tri1.0 Customization no. end
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
                        rec.TESTFIELD("Locked Order", FALSE);
                        IF UserSetup.GET(USERID) THEN BEGIN
                            IF UserSetup."Allow PO Reopen" = FALSE THEN
                                ERROR('%1 has no permission to Reopen the Purchase Order', UserSetup."User ID");
                        END;

                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                separator(Control33)
                {
                }
                action("&Send BizTalk Purchase Order")
                {
                    Caption = '&Send BizTalk Purchase Order';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                        ApprovalMgt: Codeunit "Export F/O Consolidation";
                    begin
                        //IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                        //BizTalkManagement.SendPurchaseOrder(Rec);
                        //code unit not available in 2013r2
                    end;
                }
                action("Send IC Purchase Order")
                {
                    Caption = 'Send IC Purchase Order';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                        SalesHeader: Record "Sales Header";
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //16630  IF ApprovalMgt.PrePostApprovalCheck(SalesHeader, Rec) THEN
                        IF ApprovalMgt.PrePostApprovalCheckPurch(Rec) THEN
                            ICInOutboxMgt.SendPurchDoc(Rec, FALSE);
                    end;
                }
                separator(Control22)
                {
                }
                action("Calc&ulate Structure Values")
                {
                    Caption = 'Calc&ulate Structure Values';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //16630 Funcation N/F Start
                        /*  PurchLine.CalculateStructures(Rec);
                          PurchLine.AdjustStructureAmounts(Rec);
                          PurchLine.UpdatePurchLines(Rec);*/
                        //16630 Funcation N/F End
                    end;
                }
                action("Calculate TDS")
                {
                    Caption = 'Calculate TDS';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //16630   PurchLine.CalculateTDS(Rec);
                    end;
                }
                action(ShortClose)
                {
                    Caption = 'ShortClose';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ShortClose.Cancel(Rec, 1);
                    end;
                }
                action(Cancel)
                {
                    Caption = 'Cancel';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ShortClose.Cancel(Rec, 2);
                    end;
                }
                action("Lock/Unlock")
                {
                    Caption = 'Lock/Unlock';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //TRI DG Add start
                        LockPurchDoc.PurchLockUnlock(Rec);
                        //TRI DG Add stop
                    end;
                }
                action(UpdateQuantity)
                {
                    Caption = 'UpdateQuantity';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        recPurchaseLine: Record "Purchase Line";
                    begin
                        recPurchaseLine.RESET;
                        recPurchaseLine.SETRANGE("Document Type", rec."Document Type");
                        recPurchaseLine.SETRANGE("Document No.", rec."No.");
                        IF recPurchaseLine.FINDFIRST THEN BEGIN
                            REPEAT
                                //    recPurchaseLine.VALIDATE(Quantity);
                                recPurchaseLine.VALIDATE("Challan Quantity", recPurchaseLine.Quantity);
                                recPurchaseLine.VALIDATE("Actual Quantity", recPurchaseLine.Quantity);
                                recPurchaseLine.MODIFY;
                            UNTIL recPurchaseLine.NEXT = 0;
                        END;
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
                    Ellipsis = true;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        PurchLine1: Record "Purchase Line";
                        PurchLine2: Record "Purchase Line";
                    begin
                        //Vipul Tri1.0 Start
                        //TESTFIELD("Vendor Shipment No.");
                        //TESTFIELD("Vendor Invoice No.");
                        //Vipul Tri1.0 End

                        // NAVIN
                        //16630 field N/F Start
                        /*  IF Structure <> '' THEN BEGIN
                              PurchLine.CalculateStructures(Rec);
                              PurchLine.AdjustStructureAmounts(Rec);
                              PurchLine.UpdatePurchLines(Rec);
                              COMMIT;
                          END;*///16630 field N/F End

                        //CODEUNIT.RUN(91,Rec);
                        // NAVIN
                        /* IF ApprovalMgt.PrePostApprovalCheck(SalesHeader, Rec) THEN BEGIN
                             IF ApprovalMgt.TestPurchasePrepayment(Rec) THEN
                                 ERROR(STRSUBSTNO(Text001, "Document Type", "No."))
                             ELSE BEGIN
                                 IF ApprovalMgt.TestPurchasePayment(Rec) THEN BEGIN
                                     IF NOT CONFIRM(STRSUBSTNO(Text002, "Document Type", "No."), TRUE) THEN
                                         EXIT
                                     ELSE
                                         CODEUNIT.RUN(CODEUNIT::"Purch.-Post (Yes/No)", Rec);
                                 END ELSE
                                     CODEUNIT.RUN(CODEUNIT::"Purch.-Post (Yes/No)", Rec);
                             END;
                         END;*/

                        //mo tri1.0 Customization no.44 start
                        PurchLine1.RESET;
                        PurchLine1.SETRANGE("Document Type", rec."Document Type");
                        PurchLine1.SETRANGE("Document No.", rec."No.");
                        PurchLine1.SETFILTER(Type, '>0');
                        PurchLine1.SETFILTER(Quantity, '<>0');
                        IF PurchLine1.FIND('-') THEN
                            REPEAT
                                IF PurchLine1.Quantity > PurchLine1."Qty. to Receive" THEN BEGIN
                                    PurchLine1.VALIDATE("Qty. to Receive", 0);
                                    PurchLine1.VALIDATE("Qty. to Invoice", 0);
                                    //mo tri1.0 Customization no.10
                                    PurchLine1."Challan Quantity" := 0;
                                    PurchLine1."Actual Quantity" := 0;
                                    PurchLine1."Accepted Quantity" := 0;
                                    PurchLine1."Shortage Quantity" := 0;
                                    PurchLine1."Rejected Quantity" := 0;
                                    PurchLine1.MODIFY;
                                END;
                            UNTIL PurchLine1.NEXT = 0;
                        //mo tri1.0 Customization no.44 end
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Ellipsis = true;
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
                        PurchLine1: Record "Purchase Line";
                    begin
                        //Vipul Tri1.0 Start
                        //TESTFIELD("Vendor Shipment No.");
                        //TESTFIELD("Vendor Invoice No.");
                        //Vipul Tri1.0 End
                        // NAVIN
                        //16630 Field N/F Start
                        /*  IF Structure <> '' THEN BEGIN
                              PurchLine.CalculateStructures(Rec);
                              PurchLine.AdjustStructureAmounts(Rec);
                              PurchLine.UpdatePurchLines(Rec);
                              COMMIT;
                          END;*///16630 Field N/F End

                        //CODEUNIT.RUN(92,Rec);
                        // NAVIN
                        /*  IF ApprovalMgt.PrePostApprovalCheck(SalesHeader, Rec) THEN BEGIN
                              IF ApprovalMgt.TestPurchasePrepayment(Rec) THEN
                                  ERROR(STRSUBSTNO(Text001, "Document Type", "No."))
                              ELSE BEGIN
                                  IF ApprovalMgt.TestPurchasePayment(Rec) THEN BEGIN
                                      IF NOT CONFIRM(STRSUBSTNO(Text002, "Document Type", "No."), TRUE) THEN
                                          EXIT
                                      ELSE
                                          CODEUNIT.RUN(CODEUNIT::"Purch.-Post + Print", Rec);
                                  END ELSE
                                      CODEUNIT.RUN(CODEUNIT::"Purch.-Post + Print", Rec);
                              END;
                          END;*/

                        //mo tri1.0 Customization no.44 start
                        PurchLine1.RESET;
                        PurchLine1.SETRANGE("Document Type", rec."Document Type");
                        PurchLine1.SETRANGE("Document No.", rec."No.");
                        PurchLine1.SETFILTER(Type, '>0');
                        PurchLine1.SETFILTER(Quantity, '<>0');
                        IF PurchLine1.FIND('-') THEN
                            REPEAT
                                IF PurchLine1.Quantity > PurchLine1."Qty. to Receive" THEN BEGIN
                                    PurchLine1.VALIDATE("Qty. to Receive", 0);
                                    PurchLine1.VALIDATE("Qty. to Invoice", 0);
                                    //Customization no.10
                                    PurchLine1."Challan Quantity" := 0;
                                    PurchLine1."Actual Quantity" := 0;
                                    PurchLine1."Accepted Quantity" := 0;
                                    PurchLine1."Shortage Quantity" := 0;
                                    PurchLine1."Rejected Quantity" := 0;
                                    PurchLine1.MODIFY;
                                END;
                            UNTIL PurchLine1.NEXT = 0;
                        //mo tri1.0 Customization no.44 end
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
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Print Deferment Schedule")
                {
                    Caption = 'Print Deferment Schedule';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //16630 Table N/F start
                        /*  DefermentBuffer.RESET;
                          DefermentBuffer.SETRANGE("Document No.", "No.");
                          REPORT.RUNMODAL(16543, TRUE, TRUE, DefermentBuffer);*///16630 Table N/F End
                    end;
                }
                separator(Control4)
                {
                }
                group("Prepa&yment")
                {
                    Caption = 'Prepa&yment';
                    action("Prepayment Test &Report")
                    {
                        Caption = 'Prepayment Test &Report';
                        Ellipsis = true;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            ReportPrint.PrintPurchHeaderPrepmt(Rec);
                        end;
                    }
                    action("Post Prepayment &Invoice")
                    {
                        Caption = 'Post Prepayment &Invoice';
                        Ellipsis = true;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            SalesHeader: Record "Sales Header";
                            ApprovalMgt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            /* IF ApprovalMgt.PrePostApprovalCheck(SalesHeader, Rec) THEN
                                 PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, FALSE);*/
                        end;
                    }
                    action("Post and Print Prepmt. Invoic&e")
                    {
                        Caption = 'Post and Print Prepmt. Invoic&e';
                        Ellipsis = true;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            SalesHeader: Record "Sales Header";
                            ApprovalMgt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            /*IF ApprovalMgt.PrePostApprovalCheck(SalesHeader, Rec) THEN
                                PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, TRUE);*/
                        end;
                    }
                    action("Post Prepayment &Credit Memo")
                    {
                        Caption = 'Post Prepayment &Credit Memo';
                        Ellipsis = true;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            SalesHeader: Record "Sales Header";
                            ApprovalMgt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            /*IF ApprovalMgt.PrePostApprovalCheck(SalesHeader, Rec) THEN
                                PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec, FALSE);*/
                        end;
                    }
                    action("Post and Print Prepmt. Cr. Mem&o")
                    {
                        Caption = 'Post and Print Prepmt. Cr. Mem&o';
                        Ellipsis = true;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            SalesHeader: Record "Sales Header";
                            ApprovalMgt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            /* IF ApprovalMgt.PrePostApprovalCheck(SalesHeader, Rec) THEN
                                 PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec, TRUE);*/
                        end;
                    }
                }
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    DocPrint.PrintPurchHeader(Rec);
                end;
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
                    //not avialable
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
                    //not avialable
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
                    //16630   PurchInfoPaneMgmt.LookupContacts(Rec);
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
                    //16630  PurchInfoPaneMgmt.LookupOrderAddr(Rec);
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(rec.ConfirmDeletion);
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
        rec."Responsibility Center" := UserMgt.GetPurchasesFilter();
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
            rec.FILTERGROUP(2);
            rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            rec.FILTERGROUP(0);
        END;
        //TRI SC
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
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit ArchiveManagement;
        Text001: Label 'There are non posted Prepayment Amounts on %1 %2.';
        Text002: Label 'There are unpaid Prepayment Invoices related to %1 %2. Do you wish to continue?';
        PurchInfoPaneMgmt: Codeunit 7181;
        PurchLine: Record "Purchase Line";
        //16630   DefermentBuffer: Record 16532;
        //  "...tri1.0": ;
        Text0001: Label 'Challan Quantity must be filled in.';
        Text0002: Label 'Actual Quantity must be filled in.';
        Text0003: Label 'Accepted Quantity must be filled in.';
        Text0004: Label 'Rejection Reason Code must be entered.';
        Text0005: Label 'Shortage Reason Code must be entered.';
        Text0006: Label 'Status must be Released while posting.';
        Text0007: Label 'Status must be Open while changing the "Buy-from Post code".';
        Text000: Label 'Do you want to convert the Order to an Import order?';
        WFAmount: Decimal;
        WFPurchLine: Record "Purchase Line";
        LineNo: Integer;
        IsValid: Boolean;
        ReleasePurchaseDocument: Codeunit "Release Purchase Document";
        ShortClose: Codeunit ShortClose;
        UserSetup: Record "User Setup";
        IndentLine: Record "Indent Line";
        PurchaseLine2: Record "Purchase Line";
        GetFilters: Code[80];
        LineNo1: Integer;
        IndentHeader: Record "Indent Header";
        IndentLine1: Record "Indent Line";
        IndentHeader1: Record "Indent Header";
        IndentLine2: Record "Indent Line";
        IndentHeader2: Record "Indent Header";
        LockPurchDoc: Codeunit "Lock Sales Document";
        UserLocation: Record "User Location";
        LocationFilterString: Text[250];
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
        IndentLineList: Page "Indent Line List";

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure UpdateInfoPanel()
    var
        DifferBuyFromPayTo: Boolean;
    begin
        DifferBuyFromPayTo := rec."Buy-from Vendor No." <> rec."Pay-to Vendor No.";
        PurchHistoryBtnVisible := DifferBuyFromPayTo;
        PayToCommentPictVisible := DifferBuyFromPayTo;
        PayToCommentBtnVisible := DifferBuyFromPayTo;
        //16630 PurchHistoryBtn1Visible := PurchInfoPaneMgmt.DocExist(Rec, "Buy-from Vendor No.");
        IF DifferBuyFromPayTo THEN;
        //16630 PurchHistoryBtnVisible := PurchInfoPaneMgmt.DocExist(Rec, "Pay-to Vendor No.")
    end;

    procedure "---NAVIN---"()
    begin
    end;

    procedure "---Tri1.0---"()
    begin
    end;

    procedure SendOrderNo() OrderNo: Code[20]
    begin
        OrderNo := rec."No.";
    end;

    procedure CompletlyOrdered()
    var
        IndentLine2: Record "Indent Line";
        IndentHeader2: Record "Indent Header";
    begin
        IndentHeader2.RESET;
        IndentHeader2.SETFILTER(Deleted, '%1', FALSE);
        IndentHeader2.SETFILTER(IndentHeader2."Completely Ordered", '%1', FALSE);
        IF IndentHeader2.FIND('-') THEN
            REPEAT
                IndentLine2.RESET;
                IndentLine2.SETFILTER(IndentLine2."Document No.", IndentHeader2."No.");
                IndentLine2.SETFILTER(IndentLine2.Deleted, '%1', FALSE);
                IndentLine2.SETFILTER(IndentLine2."Order No.", '%1', '');
                IF NOT IndentLine2.FIND('-') THEN BEGIN
                    IndentHeader2."Completely Ordered" := TRUE;
                    IndentHeader2.MODIFY;
                END;
                COMMIT;
            UNTIL IndentHeader2.NEXT = 0;
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
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

    local procedure Prepayment37OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;
}

