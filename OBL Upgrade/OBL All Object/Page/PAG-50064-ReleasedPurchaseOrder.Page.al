page 50064 "Released Purchase Order"
{
    // 1. TRI V.D 08.11.10 - New Menu Items added on "Functions" Menu Button for reject functionality.

    Caption = 'Purchase Order';
    Editable = true;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order),
                            Subcontracting = FILTER(false),
                            Status = FILTER('Released|Short Close'));



    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = true;
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
                    Editable = false;
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
                /* field(Structure; Structure)
                 {
                     ApplicationArea = All;
                 }*/
                field("Bill of Entry No."; Rec."Bill of Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Bill of Entry Value"; Rec."Bill of Entry Value")
                {
                    ApplicationArea = All;
                }
                field("Bill of Entry Date"; Rec."Bill of Entry Date")
                {
                    ApplicationArea = All;
                }
                field("Capex No."; Rec."Capex No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Capital PO"; Rec."Capital PO")
                {
                    ApplicationArea = All;
                }
                field("Delivary Date"; Rec."Delivary Date")
                {
                    ApplicationArea = All;
                }
                field("Ordered Qty"; Rec."Ordered Qty")
                {
                    Editable = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Total Recd. Quantity"; Rec."Total Recd. Quantity")
                {
                    Editable = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = All;
                }
                field("Return Order Pend. For Posting"; Rec."Return Order Pend. For Posting")
                {
                    ApplicationArea = All;
                }
                /*  field("C Form"; "C Form")
                  {
                      Visible = true;
                      ApplicationArea = All;
                  }*/ // 15578
                field("Road Permit"; Rec."Form 38 No.")
                {
                    Caption = 'Road Permit';
                    Editable = false;
                    Image = "None";
                    Importance = Standard;
                    ApplicationArea = All;
                }
                /* field("Form No."; "Form No.")
                 {
                     ApplicationArea = All;
                 }*/ //15578
                field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Delivery Period"; Rec."Delivery Period")
                {
                    ApplicationArea = All;
                }
                field(Residue; Rec.Residue)
                {
                    ApplicationArea = All;
                }
                field(Moisture; Rec.Moisture)
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
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
                    Caption = 'Gate Entry No.';
                    ApplicationArea = All;
                }
                field("GE Date"; Rec."GE Date")
                {
                    ApplicationArea = All;
                }
                field("E-Way Bill No."; rec."E-Way Bill No.")
                {
                    Image = Star;
                    Style = Attention;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF (STRLEN(Rec."E-Way Bill No.") <> 12) THEN
                            ERROR('E-Way Should BEGIN 12 Cherector')
                    end;
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
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quotation No."; Rec."Quotation No.")
                {
                    Caption = 'Quotation No.';
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Quotation Date"; Rec."Quotation Date")
                {
                    ApplicationArea = All;
                }
                field("PUrchase Type"; Rec."PUrchase Type")
                {
                    Caption = 'Purchase Type';
                    ApplicationArea = All;
                }
                field("Amendment No."; Rec."Amendment No.")
                {
                    ApplicationArea = All;
                }
                field("Amendment Date"; Rec."Amendment Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    ApplicationArea = All;
                }
                field("Receiving No. Series"; Rec."Receiving No. Series")
                {
                    ApplicationArea = All;
                }
                /*   field("Vendor Shipment Date"; "Vendor Shipment Date")
                   {
                       ApplicationArea = All;
                   }*/
                field("Releasing Date"; Rec."Releasing Date")
                {
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Releasing Time"; Rec."Releasing Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("User Id"; Rec."User Id")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(PurchLines; "Purchase Order Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                Visible = false;
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
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    Importance = Additional;
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
                    Importance = Promoted;
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
                field("Transporter's Code"; Rec."Transporter's Code")
                {
                    ApplicationArea = All;
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                    Importance = Promoted;
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
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    Editable = false;
                    Enabled = true;
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PaytoVendorNoOnAfterValidate;
                    end;
                }
                field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                {
                    Editable = false;
                    Importance = Additional;
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
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                    Editable = false;
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    Editable = false;
                    Importance = Additional;
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
                    Importance = Additional;
                    ApplicationArea = All;
                }
                field("Form 31 Amount"; Rec."Form 31 Amount")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Due Date"; Rec."Due Date")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    Importance = Additional;
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
                        //PricesIncludingVATOnAfterVALIDATE;
                        PricesIncludingVATOnAfterValid
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Receiving No."; Rec."Receiving No.")
                {
                    Editable = true;
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
                /*  field(PoT; PoT)
                  {
                      ApplicationArea = All;
                  }*/
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Order")
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
                            Rec.CalcInvDiscForHeader;
                            COMMIT;
                        END;
                        /*   IF Rec.Structure <> '' THEN BEGIN
                               PurchLine.CalculateStructures(Rec);
                               PurchLine.AdjustStructureAmounts(Rec);
                               PurchLine.UpdatePurchLines(Rec);
                               PurchLine.CalculateTDS(Rec);
                           END ELSE BEGIN
                               PurchLine.CalculateTDS(Rec);
                           END;*/ // 15578

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
                        // ApprovalEntries.Setfilters(DATABASE::"Purchase Header", rec."Document Type", rec."No.");
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
                separator(Control2)
                {
                }
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    action("Get &Sales Order1")
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
                separator(Control3)
                {
                }
                action("St&ructure")
                {
                    Caption = 'St&ructure';
                    /*   RunObject = Page 16305;
                       RunPageLink = Type = CONST(Purchase),
                                     "Document Type" = FIELD("Document Type"),
                                     "Document No." = FIELD("No.");*/ // 15578
                    ApplicationArea = All;
                }
                action("Transit Documents")
                {
                    Caption = 'Transit Documents';
                    /*   RunObject = Page "Transit Document Order Details";
                       RunPageLink = Type = CONST(Purchase),
                                     "PO / SO No." = FIELD("No."),
                                     "Vendor / Customer Ref." = FIELD("Buy-from Vendor No."),
                                     State = FIELD(State);*/ // 15578
                    ApplicationArea = All;
                }
                action("Deferment Schedule")
                {
                    Caption = 'Deferment Schedule';
                    /*  RunObject = Page "Deferment Schedule";
                      RunPageLink = "Document No." = FIELD("No.");*/ // 15578
                    ApplicationArea = All;
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
                    Caption = 'Detailed &Tax';
                    /*   RunObject = Page "Purch. Detailed Tax";
                       RunPageLink = "Document Type" = FIELD("Document Type"),
                                     "Document No." = FIELD("No."),
                                     "Transaction Type" = CONST(Purchase);*/ // 15578
                    ApplicationArea = All;
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
                        PurchaseLine2.SETFILTER(PurchaseLine2."Document No.", Rec."No.");
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
                                                PurchaseLine2.VALIDATE(PurchaseLine2."Document No.", Rec."No.");
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
                                                    PurchaseLine2.VALIDATE(PurchaseLine2."Document No.", Rec."No.");
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
                                            IndentLine."Order Date" := Rec."Posting Date";
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
            group(Line)
            {
                Caption = '&Line';
                separator(control4)
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
                        //TRI SC 27.05.10
                        //IndentLine.SETCURRENTKEY(IndentLine.Date);
                        IndentLine.SETCURRENTKEY(IndentLine."Document No.", "Line No.");
                        //TRI SC
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
                                        //  PurchaseLine2.VALIDATE(PurchaseLine2."Excise Bus. Posting Group", "Excise Bus. Posting Group");
                                        IF PurchaseLine2.Type = PurchaseLine2.Type::Item THEN
                                            IF Item.GET(PurchaseLine2."No.") THEN
                                                //    PurchaseLine2.VALIDATE(PurchaseLine2."Excise Prod. Posting Group", Item."Excise Prod. Posting Group");

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
                                    IndentLine."Order Date" := Rec."Posting Date";
                                    IndentLine.MODIFY;

                                UNTIL IndentLine.NEXT = 0;

                        END;
                    end;
                }
            }
        }
        area(processing)
        {
            group("Function")
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
                separator(Conrrol)
                {
                }
                action("Get St&d. Vend. Purchase Codes")
                {
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record 175;
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                separator(control)
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
                    Visible = false;
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
                separator(control5)
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
                        // 15578   GetGateEntryLines;
                    end;
                }
                separator(control6)
                {
                }
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Export F/O Consolidation";
                    begin
                        // 15578  IF ApprovalMgt.SendPurchaseApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Export F/O Consolidation";
                    begin
                        // 15578   IF ApprovalMgt.CancelPurchaseApprovalRequest(Rec, TRUE, TRUE) THEN;
                    end;
                }
                separator(control7)
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
                        PurchLine1.SETRANGE("Document No.", rec."No.");
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
                        IF Rec."Document Type" = Rec."Document Type"::Order THEN BEGIN    //TRI A.S 04.08.09 Code Added
                            Rec."Locked Order" := TRUE;
                            Rec.MODIFY;
                            COMMIT;
                            //Trident-Rakesh-End 260906
                        END;
                        //ReleasePurchaseDocument.RUN(Rec);

                        IF Rec.Status = Rec.Status::Open THEN
                            ArchiveManagement.ArchivePurchDocument(Rec);


                        ReleasePurchDoc.PerformManualRelease(Rec);
                        //mo tri1.0 Customization no. start
                        PurchLine1.RESET;
                        PurchLine1.SETRANGE("Document Type", Rec."Document Type");
                        PurchLine1.SETRANGE("Document No.", Rec."No.");
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
                        Rec.TESTFIELD("Locked Order", FALSE);
                        IF UserSetup.GET(USERID) THEN BEGIN
                            IF UserSetup."Allow PO Reopen" = FALSE THEN
                                ERROR('%1 has no permission to Reopen the Purchase Order', UserSetup."User ID");
                        END;

                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                separator(control8)
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
                        ApprovalMgt: Codeunit "Export F/O Consolidation";
                    begin
                        /*   IF ApprovalMgt.PrePostApprovalCheck(SalesHeader, Rec) THEN
                               ICInOutboxMgt.SendPurchDoc(Rec, FALSE);*/ // 15578
                    end;
                }
                separator(control9)
                {
                }
                action("Calc&ulate Structure Values")
                {
                    Caption = 'Calc&ulate Structure Values';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /* PurchLine.CalculateStructures(Rec);
                         PurchLine.AdjustStructureAmounts(Rec);
                         PurchLine.UpdatePurchLines(Rec);*/
                    end;
                }
                action("Calculate TDS")
                {
                    Caption = 'Calculate TDS';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // 15578   PurchLine.CalculateTDS(Rec);
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
                        recPurchaseLine.SETRANGE("Document Type", Rec."Document Type");
                        recPurchaseLine.SETRANGE("Document No.", Rec."No.");
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
                group("&Reject")
                {
                    Caption = '&Reject';
                    action("&Post Rejection Note")
                    {
                        Caption = '&Post Rejection Note';
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            tgPurchHdr: Record "Purchase Header";
                            tgPurchLine: Record "Purchase Line";
                            tgRejectNo: Code[20];
                            tgNoSeriesMgt: Codeunit NoSeriesManagement;
                            tgPurchSetup: Record "Purchases & Payables Setup";
                            tgRejectHdr: Record "Rejection Purchase Header";
                            tgRejectLine: Record "Rejection Purchase Line";
                            tgRecRejectHdr: Record "Rejection Purchase Header";
                            tgVendor: Record Vendor;
                            Text001: Label 'No reject quantity found in Purchase order No. %1';
                            Text002: Label 'Do you want to post reject note?';
                            Text004: Label 'Cancelled by %1.';
                            Text008: Label 'Rejection successfully posted by %1.';
                            tgText002: Label 'Rejection Note No. %1 for Vendor Invoice No. %2 already exists.';
                            tgRejectNo2: Code[20];
                        begin
                            //TRI V.D 30.10.10 START
                            IF NOT CONFIRM(Text002, FALSE) THEN
                                ERROR(Text004, UPPERCASE(USERID));

                            Rec.TESTFIELD(Status, Rec.Status::Released);
                            Rec.TESTFIELD("Vendor Invoice No.");
                            Rec.TESTFIELD("Vendor Invoice Date");
                            Rec.TESTFIELD("Vendor Shipment No.");
                            // Rec.TESTFIELD("Vendor Shipment Date");
                            //TESTFIELD("Transporter's Code");
                            Rec.TESTFIELD("GE No.");
                            Rec.TESTFIELD("Buy-from Vendor No.");

                            tgVendor.GET(Rec."Buy-from Vendor No.");
                            tgVendor.TESTFIELD(tgVendor.Blocked, tgVendor.Blocked::" ");

                            tgRecRejectHdr.RESET;
                            tgRecRejectHdr.SETCURRENTKEY("Vendor Invoice No.");
                            tgRecRejectHdr.SETRANGE(tgRecRejectHdr."Vendor Invoice No.", Rec."Vendor Invoice No.");
                            IF tgRecRejectHdr.FIND('-') THEN
                                ERROR(tgText002, tgRecRejectHdr."Rejection No.", Rec."Vendor Invoice No.");

                            tgPurchSetup.GET;
                            tgPurchSetup.TESTFIELD(tgPurchSetup."Reject No.");

                            tgRejectNo := '';
                            NoSeriesRelationship.RESET;
                            NoSeriesRelationship.SETRANGE(Code, tgPurchSetup."Reject No.");
                            NoSeriesRelationship.SETRANGE(Location, Rec."Location Code");
                            IF NoSeriesRelationship.FINDFIRST THEN
                                tgRejectNo := tgNoSeriesMgt.GetNextNo(NoSeriesRelationship."Series Code", Rec."Rejection Date", TRUE);

                            tgPurchSetup.GET;
                            tgPurchSetup.TESTFIELD(tgPurchSetup."Store Reject No");
                            tgRejectNo2 := '';
                            NoSeriesRelationship.RESET;
                            NoSeriesRelationship.SETRANGE(Code, tgPurchSetup."Store Reject No");
                            NoSeriesRelationship.SETRANGE(Location, Rec."Location Code");
                            IF NoSeriesRelationship.FINDFIRST THEN
                                tgRejectNo2 := tgNoSeriesMgt.GetNextNo(NoSeriesRelationship."Series Code", Rec."Rejection Date", TRUE);


                            tgRejectHdr.INIT;
                            tgRejectHdr.TRANSFERFIELDS(Rec);
                            tgRejectHdr."Rejection No." := tgRejectNo;
                            tgRejectHdr."Store Rejection No" := tgRejectNo2;
                            tgRejectHdr."Rejection created by" := USERID;
                            tgRejectHdr."Posting Date" := Rec."Rejection Date";
                            tgRejectHdr.INSERT;

                            tgPurchLine.RESET;
                            tgPurchLine.SETRANGE(tgPurchLine."Document Type", tgPurchLine."Document Type"::Order);
                            tgPurchLine.SETRANGE(tgPurchLine."Document No.", Rec."No.");
                            //tgPurchLine.SETFILTER(tgPurchLine."Rejected Quantity",'<>%1',0);
                            //tgPurchLine.SETFILTER(tgPurchLine."Shortage Quantity",'<>%1',0);

                            IF tgPurchLine.FIND('-') THEN
                                REPEAT
                                    tgRejectLine.INIT;
                                    tgRejectLine.TRANSFERFIELDS(tgPurchLine);
                                    tgRejectLine."Rejection No." := tgRejectNo;
                                    tgRejectLine."Store Rejection No." := tgRejectNo2;
                                    tgRejectLine.INSERT;
                                UNTIL tgPurchLine.NEXT = 0
                            ELSE
                                ERROR(Text001);
                            MESSAGE(Text008, UPPERCASE(USERID));
                            //TRI V.D 30.10.10 STOP
                        end;
                    }
                    action("Sho&w Rejection Note")
                    {
                        Caption = 'Sho&w Rejection Note';
                        RunObject = Page "Rejection List";
                        RunPageLink = "No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                }
                action("Approve Excise")
                {
                    Caption = 'Approve Excise';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        UsrSetup.GET(USERID);
                        IF UsrSetup."Verify Excise on PO" THEN BEGIN
                            Rec."Excise Approved (Accounts)" := TRUE;
                            Rec.MODIFY;
                        END ELSE
                            ERROR('You are not Authorized to Approve Excise');
                    end;
                }
            }
            group(Posting)
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
                        ApprovalMgt: Codeunit "Export F/O Consolidation";
                        PurchLine1: Record "Purchase Line";
                        PurchLine2: Record "Purchase Line";
                    begin
                        //Vipul Tri1.0 Start
                        //TESTFIELD("Vendor Shipment No.");
                        //TESTFIELD("Vendor Invoice No.");
                        //Vipul Tri1.0 End

                        // NAVIN
                        /*    IF Structure <> '' THEN BEGIN
                                PurchLine.CalculateStructures(Rec);
                                PurchLine.AdjustStructureAmounts(Rec);
                                PurchLine.UpdatePurchLines(Rec);
                                COMMIT;
                            END;*/

                        //CODEUNIT.RUN(91,Rec);
                        // NAVIN
                        /*  IF ApprovalMgt.PrePostApprovalCheck(SalesHeader, Rec) THEN BEGIN
                              IF ApprovalMgt.TestPurchasePrepayment(Rec) THEN
                                  ERROR(STRSUBSTNO(Text001, Rec."Document Type", Rec."No."))
                              ELSE BEGIN
                                  IF ApprovalMgt.TestPurchasePayment(Rec) THEN BEGIN
                                      IF NOT CONFIRM(STRSUBSTNO(Text002, Rec."Document Type", Rec."No."), TRUE) THEN
                                          EXIT
                                      ELSE
                                          CODEUNIT.RUN(CODEUNIT::"Purch.-Post (Yes/No)", Rec);
                                  END ELSE
                                      CODEUNIT.RUN(CODEUNIT::"Purch.-Post (Yes/No)", Rec);
                              END;
                          END;*/ // 15578

                        //mo tri1.0 Customization no.44 start
                        PurchLine1.RESET;
                        PurchLine1.SETRANGE("Document Type", Rec."Document Type");
                        PurchLine1.SETRANGE("Document No.", Rec."No.");
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
                        //   ApprovalMgt: Codeunit "Export F/O Consolidation";
                        PurchLine1: Record "Purchase Line";
                    begin
                        //Vipul Tri1.0 Start
                        //TESTFIELD("Vendor Shipment No.");
                        //TESTFIELD("Vendor Invoice No.");
                        //Vipul Tri1.0 End
                        // NAVIN
                        /*  IF Structure <> '' THEN BEGIN
                              PurchLine.CalculateStructures(Rec);
                              PurchLine.AdjustStructureAmounts(Rec);
                              PurchLine.UpdatePurchLines(Rec);
                              COMMIT;
                          END;*/

                        //CODEUNIT.RUN(92,Rec);
                        // NAVIN
                        /*   IF ApprovalMgt.PrePostApprovalCheck(SalesHeader, Rec) THEN BEGIN
                               IF ApprovalMgt.TestPurchasePrepayment(Rec) THEN
                                   ERROR(STRSUBSTNO(Text001, Rec."Document Type", Rec."No."))
                               ELSE BEGIN
                                   IF ApprovalMgt.TestPurchasePayment(Rec) THEN BEGIN
                                       IF NOT CONFIRM(STRSUBSTNO(Text002, Rec."Document Type", Rec."No."), TRUE) THEN
                                           EXIT
                                       ELSE
                                           CODEUNIT.RUN(CODEUNIT::"Purch.-Post + Print", Rec);
                                   END ELSE
                                       CODEUNIT.RUN(CODEUNIT::"Purch.-Post + Print", Rec);
                               END;
                           END;*/// 15578

                        //mo tri1.0 Customization no.44 start
                        PurchLine1.RESET;
                        PurchLine1.SETRANGE("Document Type", Rec."Document Type");
                        PurchLine1.SETRANGE("Document No.", Rec."No.");
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
                        /* DefermentBuffer.RESET;
                            DefermentBuffer.SETRANGE("Document No.", rec."No.");
                         REPORT.RUNMODAL(16543, TRUE, TRUE, DefermentBuffer);*/
                    end;
                }
                separator(contro20)
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
                            ApprovalMgt: Codeunit "Export F/O Consolidation";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            /*    IF ApprovalMgt.PrePostApprovalCheck(SalesHeader, Rec) THEN
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
                            ApprovalMgt: Codeunit "Export F/O Consolidation";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            /*  IF ApprovalMgt.PrePostApprovalCheck(SalesHeader, Rec) THEN
                                  PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, TRUE);*/ // 15578
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
                            ApprovalMgt: Codeunit "Export F/O Consolidation";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            /*    IF ApprovalMgt.PrePostApprovalCheck(SalesHeader, Rec) THEN
                                    PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec, FALSE);*/ // 15578
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
                            ApprovalMgt: Codeunit "Export F/O Consolidation";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            /* IF ApprovalMgt.PrePostApprovalCheck(SalesHeader, Rec) THEN
                                 PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec, TRUE);*/ // 15578
                        end;
                    }
                }
            }
            action(Print)
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
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(Rec.ConfirmDeletion);
    end;

    trigger OnInit()
    begin
        //ERROR('Not Allowed');
        PurchHistoryBtn1Visible := TRUE;
        PayToCommentBtnVisible := TRUE;
        PayToCommentPictVisible := TRUE;
        PurchHistoryBtnVisible := TRUE;
        LineEnable := TRUE;
        PostingEnable := TRUE;
        FunctionEnable := TRUE;
        OrderEnable := TRUE;
        "Buy-from Vendor No.Enable" := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FILTERGROUP(0);
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

        LocationFilterString := COPYSTR(LocationFilterString, 2, 1024);

        IF LocationFilterString = '' THEN
            ERROR('Sorry please contact your System Administrator');

        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Location Code", LocationFilterString);
        Rec.FILTERGROUP(0);
        //ND Tri End Cust 38
        //TRI SC
        OnActivateForm;
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
        //   DefermentBuffer: Record "Deferment Buffer";

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
        LocationFilterString: Text[1024];
        UsrSetup: Record "User Setup";
        NoSeriesRelationship: Record "No. Series Relationship";
        [InDataSet]
        "Buy-from Vendor No.Enable": Boolean;
        [InDataSet]
        OrderEnable: Boolean;
        [InDataSet]
        FunctionEnable: Boolean;
        [InDataSet]
        PostingEnable: Boolean;
        [InDataSet]
        LineEnable: Boolean;
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
        IndentLineList: Page "Indent Lines List";
        Text50041: Text;

    local procedure ApproveCalcInvDisc()
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
        // PurchHistoryBtn1Visible := PurchInfoPaneMgmt.DocExist(Rec, Rec."Buy-from Vendor No.");
        /* IF DifferBuyFromPayTo THEN
             PurchHistoryBtnVisible := PurchInfoPaneMgmt.DocExist(Rec, Rec."Pay-to Vendor No.")*/
    end;



    procedure SendOrderNo() OrderNo: Code[20]
    begin
        OrderNo := Rec."No.";
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

    local procedure BuyfromVendorNoOnActivate()
    begin
        Rec.CALCFIELDS("No. of Archived Versions");
        IF Rec."No. of Archived Versions" <> 0 THEN
            "Buy-from Vendor No.Enable" := FALSE;
    end;

    local procedure OnActivateForm()
    begin
        IF Rec.Status = Rec.Status::"Short Close" THEN BEGIN
            CurrPage.EDITABLE := FALSE;
            OrderEnable := FALSE;
            FunctionEnable := FALSE;
            PostingEnable := FALSE;
            //CurrForm.btPrint.ENABLED := FALSE;
            LineEnable := FALSE;
            //  CurrForm.Release.ENABLED :=FALSE;
        END ELSE BEGIN
            CurrPage.EDITABLE := TRUE;
            OrderEnable := TRUE;
            FunctionEnable := TRUE;
            PostingEnable := TRUE;
            //CurrForm.btPrint.ENABLED := TRUE;
            LineEnable := TRUE;
            //CurrForm.Release.ENABLED := TRUE;
        END;
    end;
}

