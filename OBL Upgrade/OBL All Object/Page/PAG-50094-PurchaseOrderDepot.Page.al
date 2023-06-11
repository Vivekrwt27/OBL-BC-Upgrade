page 50094 "Purchase Order Depot"
{
    Caption = 'Purchase Order';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                }
                field("Buy-from Address 2"; Rec."Buy-from Address 2")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    Caption = 'Buy-from Post Code/City';
                    ApplicationArea = All;
                }
                field("Buy-from City"; Rec."Buy-from City")
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field("State Desc."; Rec."State Desc.")
                {
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
                /* field(Structure; Structure)//16225 Field N/F
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
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    Caption = 'Truck No.';
                    ApplicationArea = All;
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
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
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
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
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Capital PO"; Rec."Capital PO")
                {
                    ApplicationArea = All;
                }
            }
            part(PurchLines; "Purchase Order Subform depot")
            {
                SubPageLink = "Document No." = FIELD("No.");

                ApplicationArea = All;
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    Editable = false;
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
                    ApplicationArea = All;
                }
                field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    Caption = 'Pay-to Post Code/City';
                    ApplicationArea = All;
                }
                field("Pay-to City"; Rec."Pay-to City")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ApplicationArea = All;
                }
                //16225 Field N/F
                /*field("C Form"; "C Form")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Form Code"; "Form Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Form No."; "Form No.")
                {
                    ApplicationArea = All;
                }*/
                field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
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
                /*field("LC No."; "LC No.")//16225 field N/F
                {
                    ApplicationArea = All;
                }*/
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
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = All;
                }
                //16225 field N/F
                /*field("Transit Document"; "Transit Document")
                {
                    ApplicationArea = All;
                }
                field("Vendor Shipment Date"; "Vendor Shipment Date")
                {
                    ApplicationArea = All;
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
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date");
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
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
                field("Area"; Rec."Area")

                {
                    ApplicationArea = All;
                }
            }
            group("E - Commerce")
            {
                Caption = 'E - Commerce';
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
                            CurrPage.PurchLines.PAGE.CalcInvDisc;
                            COMMIT;
                        END;
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
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Dim. Allowed Values per Acc.";
                    ApplicationArea = All;
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
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    action("Get &Sales Order")
                    {
                        Caption = 'Get &Sales Order';
                        RunObject = Codeunit "Purch.-Get Drop Shpt.";
                        ApplicationArea = All;
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    action("Get &Sales Orders")
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
                action("Transit Documents")
                {
                    Caption = 'Transit Documents';
                    ApplicationArea = All;
                    //16225  RunObject = Page 13705;
                }
                action(Structure)
                {
                    ApplicationArea = All;
                    /*  Caption = 'Structure'; //16225 Page N/F
                      RunObject = Page 16305;
                                      RunPageLink = "Type"=CONST(Purchase),
                                    "Document Type"=FIELD("Document Type"),
                                    "Document No."=FIELD("No.");*/
                }
                action("Authorization Information")
                {
                    Caption = 'Authorization Information';
                    ApplicationArea = All;
                    // RunObject = Page 16344; //16225 Page N/F
                }
                separator("----------------")
                {
                    Caption = '----------------';
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
            group("&Line")
            {
                Caption = '&Line';
                separator(Action192)
                {
                }
                action("&Get Indent Lines")
                {
                    Caption = '&Get Indent Lines';
                    ApplicationArea = All;

                    trigger OnAction()
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
            group("F&unctions")
            {
                Caption = 'F&unctions';
                separator(Action191)
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
                separator(Action190)
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
                separator(Action189)
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
                    end;
                }
                separator(Action74)
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
                        PurchLine1.SETRANGE("Document Type", rec."Document Type");
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

                        ReleasePurchaseDocument.Run(Rec);

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
                        rec.TESTFIELD("Locked Order", FALSE);
                        IF UserSetup.GET(USERID) THEN BEGIN
                            IF UserSetup."Allow PO Reopen" = FALSE THEN
                                ERROR('%1 has no permission to Reopen the Purchase Order', UserSetup."User ID");
                        END;

                        ReleasePurchDoc.Reopen(Rec);
                    end;
                }
                separator(Action73)
                {
                }
                action("&Send BizTalk Purchase Order")
                {
                    Caption = '&Send BizTalk Purchase Order';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //BizTalkManagement.SendPurchaseOrder(Rec);
                    end;
                }
                separator(Action1280031)
                {
                }
                action("Make Import Order")
                {
                    Caption = 'Make Import Order';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ConvertOrdertoImportOrder(Rec); // NAVIN
                    end;
                }
                action("Calculate Structure Values")
                {
                    Caption = 'Calculate Structure Values';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // NAVIN
                        //16225 N/F Funaction
                        /* PurchLine.CalculateStructures(Rec);
                         PurchLine.AdjustStructureAmounts(Rec);
                         PurchLine.UpdatePurchLines(Rec);*///16225 N/F Funaction
                                                           // NAVIN
                    end;
                }
                action("Calculate TDS")
                {
                    Caption = 'Calculate TDS';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //16225  PurchLine.CalculateTDS(Rec); // GS
                    end;
                }
                separator(Action1280032)
                {
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
                        Txt13000: Label 'Structures not calculated. Do you want to calculate structure Values?';
                        PurchLine1: Record "Purchase Line";
                        PurchLine2: Record "Purchase Line";
                    begin
                        //Vipul Tri1.0 Start
                        //TESTFIELD("Vendor Shipment No.");
                        //TESTFIELD("Vendor Invoice No.");
                        //Vipul Tri1.0 End

                        // NAVIN
                        //16225 N/F Start
                        /*  IF Structure <> '' THEN BEGIN
                              PurchLine.CalculateStructures(Rec);
                              PurchLine.AdjustStructureAmounts(Rec);
                              PurchLine.UpdatePurchLines(Rec);
                              COMMIT;
                          END;*///16225 N/F End

                        CODEUNIT.RUN(Codeunit::"Purch.-Post (Yes/No)", Rec);
                        // NAVIN

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
                        PurchLine1: Record "Purchase Line";
                    begin
                        //Vipul Tri1.0 Start
                        //TESTFIELD("Vendor Shipment No.");
                        //TESTFIELD("Vendor Invoice No.");
                        //Vipul Tri1.0 End
                        // NAVIN
                        //16225 N/F Start
                        /*IF Structure <> '' THEN BEGIN
                            PurchLine.CalculateStructures(Rec);
                            PurchLine.AdjustStructureAmounts(Rec);
                            PurchLine.UpdatePurchLines(Rec);
                            COMMIT;
                        END;*///16225 N/F End

                        CODEUNIT.RUN(Codeunit::"Purch.-Post + Print", Rec);
                        // NAVIN

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
                        //Vipul Tri1.0 Start
                        //  TESTFIELD("Vendor Shipment No.");
                        //  TESTFIELD("Vendor Invoice No.");
                        //Vipul Tri1.0 End

                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
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
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(Rec.ConfirmDeletion);
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
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit ArchiveManagement;
        "-NAVIN-": Integer;
        PurchLine: Record "Purchase Line";
        OK: Boolean;
        //"--NAVIN--": ;
        Text000: Label 'Do you want to convert the Order to an Import order?';
        Text001: Label 'Order number %1 has been converted to Import order number %2.';
        "-- NAVIN": Integer;
        WFAmount: Decimal;
        WFPurchLine: Record "Purchase Line";
        LineNo: Integer;
        IsValid: Boolean;
        Text13000: Label 'No Setup exists for this Amount.';
        Text13001: Label 'Do you want to send the order for Authorization?';
        Text13002: Label 'The Order Is Authorized, You Cannot Resend For Authorization';
        Text13003: Label 'You Cannot Resend For Authorization';
        Text13004: Label 'This Order Has been Rejected. Please Create A New Order.';
        ReleasePurchaseDocument: Codeunit "Release Purchase Document";
        ShortClose: Codeunit ShortClose;
        UserSetup: Record "User Setup";
        // "...tri1.0": ;
        Text0001: Label 'Challan Quantity must be filled in.';
        Text0002: Label 'Actual Quantity must be filled in.';
        Text0003: Label 'Accepted Quantity must be filled in.';
        Text0004: Label 'Rejection Reason Code must be entered.';
        Text0005: Label 'Shortage Reason Code must be entered.';
        IndentLine: Record "Indent Line";
        PurchaseLine2: Record "Purchase Line";
        GetFilters: Code[80];
        LineNo1: Integer;
        IndentHeader: Record "Indent Header";
        IndentLine1: Record "Indent Line";
        IndentHeader1: Record "Indent Header";
        IndentLine2: Record "Indent Line";
        IndentHeader2: Record "Indent Header";
        Text0006: Label 'Status must be Released while posting.';
        Text0007: Label 'Status must be Open while changing the "Buy-from Post code".';
        LockPurchDoc: Codeunit "Lock Sales Document";
        IndentLineList: Page "Indent Lines List";
        ChangeExchangeRate: Page "Change Exchange Rate";

    procedure "---NAVIN---"()
    begin
    end;

    procedure ConvertOrdertoImportOrder(var Rec: Record "Purchase Header")
    var
        OldPurchCommentLine: Record "Purch. Comment Line";
        PurchImportOrderHeader: Record "Purchase Header";
        PurchImportOrderLine: Record "Purchase Line";
        PurchCommentLine: Record "Purch. Comment Line";
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
        // ReservePurchLine: Codeunit "Purch. Line-Reserve";
        PurchOrderLine: Record "Purchase Line";
    begin
        IF NOT CONFIRM(Text000, FALSE) THEN
            EXIT;

        PurchImportOrderHeader := Rec;
        PurchImportOrderHeader."Document Type" := PurchImportOrderHeader."Document Type"::Order;
        PurchImportOrderHeader."No. Printed" := 0;
        PurchImportOrderHeader.Status := PurchImportOrderHeader.Status::Open;
        PurchImportOrderHeader."No." := '';

        PurchImportOrderLine.LOCKTABLE;
        PurchImportOrderHeader.INSERT(TRUE);

        /*FromDocDim.SETRANGE("Table ID",DATABASE::"Purchase Header");
        FromDocDim.SETRANGE("Document Type","Document Type");
        FromDocDim.SETRANGE("Document No.","No.");
        
        ToDocDim.SETRANGE("Table ID",DATABASE::"Purchase Header");
        ToDocDim.SETRANGE("Document Type",PurchImportOrderHeader."Document Type");
        ToDocDim.SETRANGE("Document No.",PurchImportOrderHeader."No.");
        ToDocDim.DELETEALL;  */

        /*IF FromDocDim.FIND('-') THEN BEGIN
          REPEAT
            ToDocDim.INIT;
            ToDocDim."Table ID" := DATABASE::"Purchase Header";
            ToDocDim."Document Type" := PurchImportOrderHeader."Document Type";
            ToDocDim."Document No." := PurchImportOrderHeader."No.";
            ToDocDim."Line No." := 0;
            ToDocDim."Dimension Code" := FromDocDim."Dimension Code";
            ToDocDim."Dimension Value Code" := FromDocDim."Dimension Value Code";
            ToDocDim.INSERT;
          UNTIL FromDocDim.NEXT = 0;
        END; */

        PurchImportOrderHeader."Order Date" := Rec."Order Date";
        PurchImportOrderHeader."Posting Date" := Rec."Posting Date";
        PurchImportOrderHeader."Document Date" := Rec."Document Date";
        PurchImportOrderHeader."Expected Receipt Date" := Rec."Expected Receipt Date";
        PurchImportOrderHeader."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
        PurchImportOrderHeader."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
        /*PurchImportOrderHeader."Date Received" := 0D;
        PurchImportOrderHeader."Time Received" := 0T;
        PurchImportOrderHeader."Date Sent" := 0D;
        PurchImportOrderHeader."Time Sent" := 0T;
        */
        //fields not in 2013r2
        PurchImportOrderHeader.MODIFY;

        PurchOrderLine.SETRANGE("Document Type", Rec."Document Type");
        PurchOrderLine.SETRANGE("Document No.", Rec."No.");
        /*
        FromDocDim.SETRANGE("Table ID",DATABASE::"Purchase Line");
        ToDocDim.SETRANGE("Table ID",DATABASE::"Purchase Line");
         */
        //code blocked for upgrade
        //dimensions
        IF PurchOrderLine.FIND('-') THEN
            REPEAT
                PurchImportOrderLine := PurchOrderLine;
                PurchImportOrderLine."Document Type" := PurchImportOrderHeader."Document Type";
                PurchImportOrderLine."Document No." := PurchImportOrderHeader."No.";
                PurchImportOrderLine."Expected Receipt Date" := PurchImportOrderHeader."Expected Receipt Date";
                PurchOrderLine.CALCFIELDS("Reserved Qty. (Base)");  // SK
                                                                    /* ReservePurchLine.TransferPurchLineToPurchLine(
                                                                       PurchOrderLine, PurchImportOrderLine, PurchOrderLine."Reserved Qty. (Base)");
                                                                     PurchImportOrderLine."Shortcut Dimension 1 Code" := PurchOrderLine."Shortcut Dimension 1 Code";
                                                                     PurchImportOrderLine."Shortcut Dimension 2 Code" := PurchOrderLine."Shortcut Dimension 2 Code";
                                                                     PurchImportOrderLine.INSERT;*/ // 15578

            /*FromDocDim.SETRANGE("Line No.",PurchOrderLine."Line No.");

            ToDocDim.SETRANGE("Line No.",PurchImportOrderLine."Line No.");
            ToDocDim.DELETEALL;

            IF FromDocDim.FIND('-') THEN BEGIN
              REPEAT
                ToDocDim.INIT;
                ToDocDim."Table ID" := DATABASE::"Purchase Line";
                ToDocDim."Document Type" := PurchImportOrderHeader."Document Type";
                ToDocDim."Document No." := PurchImportOrderHeader."No.";
                ToDocDim."Line No." := PurchImportOrderLine."Line No.";
                ToDocDim."Dimension Code" := FromDocDim."Dimension Code";
                ToDocDim."Dimension Value Code" := FromDocDim."Dimension Value Code";
                ToDocDim.INSERT;
              UNTIL FromDocDim.NEXT = 0;
            END;
            */
            //Code blocked for upgrade
            //dimensions
            UNTIL PurchOrderLine.NEXT = 0;

        PurchCommentLine.SETRANGE("Document Type", Rec."Document Type");
        PurchCommentLine.SETRANGE("No.", Rec."No.");
        IF NOT PurchCommentLine.ISEMPTY THEN BEGIN
            PurchCommentLine.LOCKTABLE;
            IF PurchCommentLine.FIND('-') THEN
                REPEAT
                    OldPurchCommentLine := PurchCommentLine;
                    PurchCommentLine.DELETE;
                    PurchCommentLine."Document Type" := PurchImportOrderHeader."Document Type";
                    PurchCommentLine."No." := PurchImportOrderHeader."No.";
                    PurchCommentLine.INSERT;
                    PurchCommentLine := OldPurchCommentLine;
                UNTIL PurchCommentLine.NEXT = 0;
        END;

        ItemChargeAssgntPurch.RESET;
        ItemChargeAssgntPurch.SETRANGE("Document Type", Rec."Document Type");
        ItemChargeAssgntPurch.SETRANGE("Document No.", Rec."No.");

        WHILE ItemChargeAssgntPurch.FIND('-') DO BEGIN
            ItemChargeAssgntPurch.DELETE;
            ItemChargeAssgntPurch."Document Type" := PurchImportOrderHeader."Document Type";
            ItemChargeAssgntPurch."Document No." := PurchImportOrderHeader."No.";
            IF NOT (ItemChargeAssgntPurch."Applies-to Doc. Type" IN
              [ItemChargeAssgntPurch."Applies-to Doc. Type"::Receipt,
               ItemChargeAssgntPurch."Applies-to Doc. Type"::"Return Shipment"])
            THEN BEGIN
                ItemChargeAssgntPurch."Applies-to Doc. Type" := PurchImportOrderHeader."Document Type";
                ItemChargeAssgntPurch."Applies-to Doc. No." := PurchImportOrderHeader."No.";
            END;
            ItemChargeAssgntPurch.INSERT;
        END;

        Rec.DELETE;
        PurchOrderLine.DELETEALL;
        /*
        FromDocDim.SETRANGE("Line No.");
        FromDocDim.DELETEALL;
        */
        //code blocked for upgrade
        //dimensions
        COMMIT;
        MESSAGE(
          Text001,
          Rec."No.", PurchImportOrderHeader."No.");

    end;

    procedure "---Tri1.0---"()
    begin
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
}

