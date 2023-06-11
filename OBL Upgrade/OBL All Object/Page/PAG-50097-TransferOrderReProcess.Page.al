page 50097 "Transfer Order Re-Process"
{
    Caption = 'Transfer Order';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Transfer Header";
    /* SourceTableView = WHERE("Captive Consumption" = FILTER(false),
                             "External Transfer" = FILTER(false),
                             ReProcess = FILTER(true));*/
    


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    ApplicationArea = All;
                }
                field("In-Transit Code"; Rec."In-Transit Code")
                {
                    ApplicationArea = All;
                }

                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                }
                field("Transporter's Name"; Rec."Transporter's Name")
                {
                    Caption = 'Transporter Code';
                    ApplicationArea = All;
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ApplicationArea = All;
                }
                field("Truck No."; Rec."Truck No.")
                {
                    ApplicationArea = All;
                }
                field("Loading Inspector"; Rec."Loading Inspector")
                {
                    ApplicationArea = All;
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ApplicationArea = All;
                }
                field("Total Qty"; Rec."Total Qty")
                {
                    ApplicationArea = All;
                }
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PostingDateC4OnAfterValidate;
                    end;
                }
                field("OutPut Date"; Rec."OutPut Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }

                field("Insurance Amount"; Rec."Insurance Amount")
                {
                    ApplicationArea = All;
                }
                field("Transit Document"; Rec."Transit Document")
                {
                    ApplicationArea = All;
                }
                field("Locked Order"; Rec."Locked Order")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("SalesPerson Code"; Rec."SalesPerson Code")
                {
                    ApplicationArea = All;
                }
                field("Qty in Sq Mtr"; Rec."Qty in Sq Mtr")
                {
                    ApplicationArea = All;
                }
                field("Total Weight"; Rec."Total Weight")
                {
                    ApplicationArea = All;
                }
                field("Qty. To Ship"; Rec."Qty. To Ship")
                {
                    ApplicationArea = All;
                }
            }
            part(TransferLines; "Transfer Order Subform")
            {
                SubPageLink = "Document No." = FIELD("No."),
                              "Derived From Line No." = CONST(0);
                ApplicationArea = All;
            }
            group("Transfer-from")
            {
                Caption = 'Transfer-from';
                field("Transfer-from Name"; Rec."Transfer-from Name")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Name 2"; Rec."Transfer-from Name 2")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Address"; Rec."Transfer-from Address")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Address 2"; Rec."Transfer-from Address 2")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Post Code"; Rec."Transfer-from Post Code")
                {
                    Caption = 'Transfer-from Post Code/City';
                    ApplicationArea = All;
                }
                field("Transfer-from City"; Rec."Transfer-from City")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to State"; Rec."Transfer-to State")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Contact"; Rec."Transfer-from Contact")
                {
                    ApplicationArea = All;
                }
                field("Shipment No. Series"; Rec."Shipment No. Series")
                {
                    ApplicationArea = All;
                }
                field(Problem; Rec.Problem)
                {
                    ApplicationArea = All;
                }
                field("Shipping No."; Rec."Shipping No.")
                {
                    ApplicationArea = All;
                }
                field("Receiving No."; Rec."Receiving No.")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShipmentDateOnAfterValidate;
                    end;
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //OutboundWhseHandlingTimeOnAfterValidate;
                        OutboundWhseHandlingTimeOnAfte
                    end;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //ShippingAgentCodeOnAfterValidate;
                        ShippingAgentCodeOnAfterValida
                    end;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //ShippingAgentServiceCodeOnAfterValidate;
                        ShippingAgentServiceCodeOnAfte
                    end;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //ShippingTimeOnAfterValidate;
                        ShippingTimeOnAfterValidate
                    end;
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ApplicationArea = All;
                }
            }
            group("Transfer-to")
            {
                Caption = 'Transfer-to';
                field("Transfer-to Name"; Rec."Transfer-to Name")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Name 2"; Rec."Transfer-to Name 2")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Address"; Rec."Transfer-to Address")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Address 2"; Rec."Transfer-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Address 3"; Rec."Transfer-to Address 3")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Post Code"; Rec."Transfer-to Post Code")
                {
                    Caption = 'Transfer-to Post Code/City';
                    ApplicationArea = All;
                }
                field("Transfer-to City"; Rec."Transfer-to City")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Contact"; Rec."Transfer-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ReceiptDateOnAfterValidate;
                    end;
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //InboundWhseHandlingTimeOnAfterValidate;
                        InboundWhseHandlingTimeOnAfter
                    end;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
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
                field(Area1; Rec.Area)
                {
                    ApplicationArea = All;
                }
                field("Entry/Exit Point"; Rec."Entry/Exit Point")
                {
                    ApplicationArea = All;
                }
                field("Time of Removal"; Rec."Time of Removal")
                {
                    Caption = 'Time of Removal';
                    ApplicationArea = All;
                }
                field("Mode of Transport"; Rec."Mode of Transport")
                {
                    Caption = 'Mode of Transport';
                    ApplicationArea = All;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    Caption = 'Vehicle No.';
                    ApplicationArea = All;
                }
                field("LR/RR No."; Rec."LR/RR No.")
                {
                    Caption = 'LR/RR No.';
                    ApplicationArea = All;
                }
                field("LR/RR Date"; Rec."LR/RR Date")
                {
                    Caption = 'LR/RR Date';
                    ApplicationArea = All;
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
                    RunObject = Page "Transfer Statistics";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Inventory Comment Sheet";
                    RunPageLink = "Document Type" = CONST("Transfer Order"),
                                  "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("S&hipments")
                {
                    Caption = 'S&hipments';
                    RunObject = Page "Posted Transfer Shipments";
                    RunPageLink = "Transfer Order No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Re&ceipts")
                {
                    Caption = 'Re&ceipts';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Transfer Receipts";
                    RunPageLink = "Transfer Order No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Dim. Allowed Values per Acc.";
                    ApplicationArea = All;
                }
                action("Whse. Shi&pments")
                {
                    Caption = 'Whse. Shi&pments';
                    RunObject = Page "Whse. Shipment Lines";
                    RunPageLink = "Source Type" = CONST(5741),
                                  "Source Subtype" = CONST(0),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    ApplicationArea = All;
                }
                action("&Whse. Receipts")
                {
                    Caption = '&Whse. Receipts';
                    RunObject = Page "Whse. Receipt Lines";
                    RunPageLink = "Source Type" = CONST(5741),
                                  "Source Subtype" = CONST(1),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    ApplicationArea = All;
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = FILTER('Inbound Transfer|Outbound Transfer'),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                    ApplicationArea = All;
                }
                action("St&ructure")
                {
                    Caption = 'St&ructure';
                    /*    RunObject = Page 16305;
                        RunPageLink = Type = FILTER(Transfer),
                                      "Document No." = FIELD("No."),
                                      "Structure Code" = FIELD(Structure);*/
                    ApplicationArea = All;
                }
                action("Attached Gate Entry")
                {
                    Caption = 'Attached Gate Entry';
                    RunObject = Page "Gate Entry Attachment List";
                    RunPageLink = "Source Type" = CONST("Transfer Receipt"),
                                  "Entry Type" = CONST(Inward),
                                  "Source No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Create &Whse. Receipt")
                {
                    Caption = 'Create &Whse. Receipt';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        GetSourceDocInbound: Codeunit 5751;
                    begin
                        GetSourceDocInbound.CreateFromInbndTransferOrder(Rec);
                    end;
                }
                action("Create Whse. S&hipment")
                {
                    Caption = 'Create Whse. S&hipment';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    begin
                        GetSourceDocOutbound.CreateFromOutbndTransferOrder(Rec);
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
                action("Get Gate Entry Lines")
                {
                    Caption = 'Get Gate Entry Lines';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //  GetGateEntryLines;
                    end;
                }
                action("Get Bin Content")
                {
                    Caption = 'Get Bin Content';
                    Ellipsis = true;
                    Image = GetBinContent;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        BinContent: Record "Bin Content";
                        GetBinContent: Report "Whse. Get Bin Content";
                    begin
                        BinContent.SETRANGE("Location Code", Rec."Transfer-from Code");
                        GetBinContent.SETTABLEVIEW(BinContent);
                        GetBinContent.InitializeTransferHeader(Rec);
                        GetBinContent.RUNMODAL;
                    end;
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    RunObject = Codeunit "Release Transfer Document";
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD(Status, Rec.Status::Released);
                        //mo tri1.0 Customization no.45 start
                        DateFilter := '..' + FORMAT(Rec."Posting Date");
                        TransLine1.RESET;
                        TransLine1.SETRANGE("Document No.", Rec."No.");
                        TransLine1.SETFILTER(Quantity, '<>0');
                        IF TransLine1.FIND('-') THEN
                            REPEAT
                                TransLine1.CALCFIELDS(TransLine1."Reserved Quantity Outbnd.");
                                IF (TransLine1."Reserved Quantity Outbnd." < TransLine1.Quantity) THEN BEGIN
                                    Item.RESET;
                                    Item.SETFILTER("No.", TransLine1."Item No.");
                                    //   Item.SETFILTER("Date Filter",DateFilter);
                                    Item.SETFILTER("Location Filter", TransLine1."Transfer-from Code");
                                    IF Item.FIND('-') THEN BEGIN
                                        Item.CALCFIELDS("Net Change", "Reserved Qty. on Inventory");
                                        AvailableQuantity := Item."Net Change" - Item."Reserved Qty. on Inventory";
                                    END;
                                    IF (TransLine1.Quantity > AvailableQuantity) THEN
                                        ERROR(Text0001, TransLine1."Line No.");
                                END;
                                //    bin.SETRANGE(bin."Location Code",TransLine1."Transfer-from Code");
                                //   IF bin.FIND('-') THEN BEGIN
                                IF TransLine1."Transfer-from Bin Code" <> '' THEN BEGIN
                                    BinContent.GET(TransLine1."Transfer-from Code", TransLine1."Transfer-from Bin Code", TransLine1."Item No.",
                                    TransLine1."Variant Code", TransLine1."Unit of Measure Code");
                                    BinContent.CALCFIELDS(BinContent.Quantity);
                                    IF BinContent.Quantity < TransLine1.Quantity THEN
                                        ERROR('Insufficient Bin Quantity for line no %1', TransLine1."Line No.");
                                END;
                            UNTIL TransLine1.NEXT = 0;
                        //mo tri1.0 Customization no.45 end;

                        Rec."Releasing Date" := WORKDATE;  //ravi
                        Rec."Releasing Time" := TIME;   //ravi

                        IF Rec."Customer Price Group" <> '' THEN BEGIN
                            TransLine1.RESET;
                            TransLine1.SETRANGE("Document No.", Rec."No.");
                            IF TransLine1.FIND('-') THEN
                                REPEAT
                                // TransLine1.TESTFIELD(MRP);
                                UNTIL TransLine1.NEXT = 0;
                        END;

                        Rec."Posting Date" := 0D;
                        //rahul  "Shipment Date" := 0D;
                        Rec."Transfer order Status" := Rec."Transfer order Status"::Released;
                        Rec.MODIFY;
                    end;
                }
                action("Reo&pen")
                {
                    Caption = 'Reo&pen';
                    Image = ReOpen;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleaseTransferDoc: Codeunit "Release Transfer Document";
                    begin
                        ReleaseTransferDoc.Reopen(Rec);
                    end;
                }
                action("Calc&ulate Structure Values")
                {
                    Caption = 'Calc&ulate Structure Values';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        TransferLine: Record "Transfer Line";
                    begin
                        /*  TransferLine.CalculateStructures(Rec);
                          TransferLine.AdjustStructureAmounts(Rec);
                          TransferLine.UpdateTransLines(Rec);*/
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "TransferOrder-Post (Yes/No)";
                    ShortCutKey = 'F9';
                    ApplicationArea = All;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "TransferOrder-Post + Print";
                    ShortCutKey = 'Shift+F9';
                    ApplicationArea = All;
                }
            }
            group(Print)
            {
                Caption = 'Print';
                action("&Print")
                {
                    Caption = '&Print';
                    Image = Print;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        DocPrint: Codeunit "Document-Print";
                    begin
                        DocPrint.PrintTransferHeader(Rec);
                    end;
                }
                action("&Loading Slip")
                {
                    Caption = '&Loading Slip';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        TransferHeader: Record "Transfer Header";
                        LoadingSlipT: Report "Loading Slip Transfer";
                    begin
                        TransferHeader.RESET;
                        TransferHeader.SETFILTER("No.", Rec."No.");
                        LoadingSlipT.SETTABLEVIEW(TransferHeader);
                        LoadingSlipT.RUN;
                    end;
                }
                action("Order Confirmatiom")
                {
                    Caption = 'Order Confirmatiom';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        TransferHeader: Record "Transfer Header";
                        OrderConfirmation: Report "Transfer Order confirmation";
                    begin
                        TransferHeader.RESET;
                        TransferHeader.SETFILTER("No.", Rec."No.");
                        OrderConfirmation.SETTABLEVIEW(TransferHeader);
                        OrderConfirmation.RUN;
                    end;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        Rec.TESTFIELD(Status, Rec.Status::Open);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.ReProcess := TRUE;
    end;

    var
        DateFilter: Text[500];
        Text000: Label 'You have to attach transit document for this invoice.';
        Text001: Label 'Transit document(s) are not required  for this invoice.';
        Text0001: Label 'Sufficient Inventory Not Available in line no. %1';
        TransLine1: Record "Transfer Line";
        Item: Record Item;
        AvailableQuantity: Decimal;
        BinContent: Record "Bin Content";
        LoadingSlipT: Report "Transfer Order confirmation";

    local procedure PostingDateC4OnAfterValidate()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShipmentDateOnAfterValidate()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShippingAgentServiceCodeOnAfte()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShippingAgentCodeOnAfterValida()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShippingTimeOnAfterValidate()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure OutboundWhseHandlingTimeOnAfte()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ReceiptDateOnAfterValidate()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure InboundWhseHandlingTimeOnAfter()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;
}

