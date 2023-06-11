page 50076 "Transfer Order Plant"
{
    Caption = 'Transfer Order';
    PageType = Card;
    SourceTable = "Transfer Header";
    


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; REC."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF REC.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Transfer-from Code"; REC."Transfer-from Code")
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
                field("Locked Order"; Rec."Locked Order")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PostingDateOnAfterValidate;
                    end;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer order Status"; Rec."Transfer order Status")
                {
                    Caption = 'Status';
                    ApplicationArea = All;
                }
                /* field("Form Code"; "Form Code")
                 {
                     ApplicationArea = All;
                 }
                 field("Form No."; "Form No.")
                 {
                     ApplicationArea = All;
                 }*/
                field("GR No."; Rec."GR No.")
                {
                    ApplicationArea = All;
                }
                field("GR Date"; Rec."GR Date")
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
                field("Transfer-from State"; Rec."Transfer-from State")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Contact"; Rec."Transfer-from Contact")
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
                        ShippingAgentCodeOnAfterValida
                    end;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShippingTimeOnAfterValidate;
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
                field("Transfer-to Post Code"; Rec."Transfer-to Post Code")
                {
                    Caption = 'Transfer-to Post Code/City';
                    ApplicationArea = All;
                }
                field("Transfer-to City"; Rec."Transfer-to City")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to State"; Rec."Transfer-to State")
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
                action(Structure)
                {
                    Caption = 'Structure';
                    /*    RunObject = Page 16305;
                        RunPageLink = Type = FILTER(Transfer),
                                      "Document No." = FIELD("No."),
                                      "Structure Code" = FIELD(Structure);*/
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Transit Documents")
                {
                    Caption = 'Transit Documents';
                    /*  RunObject = Page 13705;
                      RunPageLink = Type = CONST(3),
                                    "PO / SO No." = FIELD("No.");*/
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
                        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
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
                        REC.CreateInvtPutAwayPick;
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
                        BinContent.SETRANGE("Location Code", REC."Transfer-from Code");
                        GetBinContent.SETTABLEVIEW(BinContent);
                        GetBinContent.InitializeTransferHeader(Rec);
                        GetBinContent.RUNMODAL;
                    end;
                }
                action("Re&lease1")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    RunObject = Codeunit "Release Transfer Document";
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Reo&pen")
                {
                    Caption = 'Reo&pen';
                    Image = ReOpen;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleaseTransferDoc: Codeunit "Release Transfer Document";
                    begin
                        ReleaseTransferDoc.Reopen(Rec);
                    end;
                }
                action("Re&lease2")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        REC.TESTFIELD(Status, REC.Status::Open);
                        REC."Transfer order Status" := REC."Transfer order Status"::Released;
                        Rec.MODIFY;
                    end;
                }
                action("Reo &pen")
                {
                    Caption = 'Reo&pen';
                    Image = ReOpen;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        REC.TESTFIELD(Status, REC.Status::Open);
                        REC."Transfer order Status" := REC."Transfer order Status"::Open;
                        REC.MODIFY;
                    end;
                }
                action("Lock/Unlock")
                {
                    Caption = 'Lock/Unlock';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        LockSalDoc.CheckLock(Rec);
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
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        REC.TESTFIELD("Transfer order Status", REC."Transfer order Status"::Released); //ND
                                                                                                       /*TransLine.SETRANGE("Document No.","No.");
                                                                                                       TransLine.SETRANGE("Derived From Line No.",0);
                                                                                                       IF TransLine.FIND('-') THEN
                                                                                                       REPEAT
                                                                                                         IF (TransLine."Quantity Shipped" = 0) THEN BEGIN
                                                                                                           Item.GET(TransLine."Item No.");
                                                                                                           ItemCostMgt.CalculateAverageCost(Item,AverageCostLCY,AverageCostACY);
                                                                                                           TransLine.VALIDATE("Unit Cost",ROUND(AverageCostLCY));
                                                                                                           IF (TransLine."Price Type" = 0) THEN
                                                                                                             TransLine.VALIDATE("Unit Price",ROUND(AverageCostLCY));
                                                                                                           TransLine.MODIFY;
                                                                                                         END;
                                                                                                       UNTIL TransLine.NEXT = 0;*///ND
                                                                                                                                  //COMMIT;

                        /*   IF "Transit Document" THEN BEGIN
                               TransDocDetails.SETRANGE(Type, TransDocDetails.Type::"3");
                               TransDocDetails.SETRANGE("PO / SO No.", REC."No.");
                               IF NOT TransDocDetails.FIND('-') THEN
                                   ERROR(Text000);
                           END ELSE BEGIN
                               TransDocDetails.SETRANGE(Type, TransDocDetails.Type::"3");
                               TransDocDetails.SETRANGE("PO / SO No.", REC."No.");
                               IF TransDocDetails.FIND('-') THEN
                                   ERROR(Text001);
                           END;*/

                        CODEUNIT.RUN(CODEUNIT::"TransferOrder-Post (Yes/No)", Rec);

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
                    begin
                        REC.TESTFIELD("Transfer order Status", REC."Transfer order Status"::Released); //ND
                                                                                                       /*TransLine.SETRANGE("Document No.","No.");
                                                                                                       TransLine.SETRANGE("Derived From Line No.",0);
                                                                                                       IF TransLine.FIND('-') THEN
                                                                                                       REPEAT
                                                                                                         IF (TransLine."Quantity Shipped" = 0) THEN BEGIN
                                                                                                           Item.GET(TransLine."Item No.");
                                                                                                           ItemCostMgt.CalculateAverageCost(Item,AverageCostLCY,AverageCostACY);
                                                                                                           TransLine.VALIDATE("Unit Cost",ROUND(AverageCostLCY));
                                                                                                           IF (TransLine."Price Type" = 0) THEN
                                                                                                             TransLine.VALIDATE("Unit Price",ROUND(AverageCostLCY));
                                                                                                           TransLine.MODIFY;
                                                                                                         END;
                                                                                                       UNTIL TransLine.NEXT = 0;*///ND
                                                                                                                                  //COMMIT;

                        /*  IF REC."Transit Document" THEN BEGIN
                              TransDocDetails.SETRANGE(Type, TransDocDetails.Type::"3");
                              TransDocDetails.SETRANGE("PO / SO No.", REC."No.");
                              IF NOT TransDocDetails.FIND('-') THEN
                                  ERROR(Text000);
                          END ELSE BEGIN
                              TransDocDetails.SETRANGE(Type, TransDocDetails.Type::"3");
                              TransDocDetails.SETRANGE("PO / SO No.", REC."No.");
                              IF TransDocDetails.FIND('-') THEN
                                  ERROR(Text001);
                          END;*/

                        CODEUNIT.RUN(CODEUNIT::"TransferOrder-Post + Print", Rec);

                    end;
                }
            }
            group("&Print ")
            {
                Caption = '&Print';
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
                        LoadingSlipT: Report "Date Wise Invoice Wise Sales";
                    begin
                        TransferHeader.RESET;
                        TransferHeader.SETFILTER("No.", REC."No.");
                        LoadingSlipT.SETTABLEVIEW(TransferHeader);
                        LoadingSlipT.RUN;
                    end;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        REC.TESTFIELD(Status, REC.Status::Open);
    end;

    var
        TransLine: Record "Transfer Line";
        Item: Record Item;
        ItemCostMgt: Codeunit ItemCostManagement;
        AverageCostLCY: Decimal;
        AverageCostACY: Decimal;
        //  TransDocDetails: Record 13768;
        Text000: Label 'You have to attach transit document for this invoice.';
        Text001: Label 'Transit document(s) are not required  for this invoice.';
        LockSalDoc: Codeunit "Lock Sales Document";

    local procedure PostingDateOnAfterValidate()
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

