page 50106 "Transfer Order Shortage"
{
    // 1. TRI A.S 07.11.08 - Code Added for Quantity not to be zero.
    // MSKS.0001 :
    //     Kulwant Singh 27-07-2010 Reserve Qty made Mandatory

    Caption = 'Transfer Order Shortage';
    PageType = Card;
    SourceTable = "Transfer Header";
    SourceTableView = WHERE("Shortage TO" = FILTER(true));
    UsageCategory = Lists;
    ApplicationArea = ALL;


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
                field(Pay; Rec.Pay)
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Caption = 'Posting / Receiving Date';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PostingDateOnAfterValidate;
                    end;
                }
                field("Transfer order Status"; Rec."Transfer order Status")
                {
                    Caption = 'Status';
                    ApplicationArea = All;
                }

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
                field("Transfer-from State"; Rec."Transfer-from State")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Contact"; Rec."Transfer-from Contact")
                {
                    ApplicationArea = All;
                }
                field(Problem; Rec.Problem)
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
                field("Shipment No. Series"; Rec."Shipment No. Series")
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
                field("Location Comment"; Rec."Location Comment")
                {
                    Editable = false;
                    ApplicationArea = All;
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
                /*  action(Structure)
                  {
                      Caption = 'Structure';
                      RunObject = Page 16305;
                      RunPageLink = Type = FILTER(Transfer),
                                    "Document No." = FIELD("No."),
                                    "Structure Code" = FIELD(Structure);
                      ApplicationArea = All;
                  }
                  action("Transit Documents")
                  {
                      Caption = 'Transit Documents';
                      RunObject = Page 13705;
                      RunPageLink = Type = CONST(3),
                                    "PO / SO No." = FIELD("No.");
                      ApplicationArea = All;
                  }*/
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
                    Visible = false;
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
                    Visible = false;
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
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.CreateInvtPutAwayPick;
                    end;
                }
                action("Get Bin Content")
                {
                    Caption = 'Get Bin Content';
                    Ellipsis = true;
                    Image = GetBinContent;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        BinContent: Record "Bin Content";
                        GetBinContent: Report "Whse. Get Bin Content";
                    begin
                        BinContent.SETRANGE("Location Code", rec."Transfer-from Code");
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
                action("Reo&pen1")
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
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin




                        //TRI
                        Rec.TESTFIELD("Transfer order Status", Rec."Transfer order Status"::Open);
                        DateFilter := '..' + FORMAT(Rec."Posting Date");
                        TransLine1.RESET;
                        TransLine1.SETRANGE("Document No.", Rec."No.");
                        TransLine1.SETFILTER(Quantity, '<>0');
                        IF TransLine1.FIND('-') THEN
                            REPEAT
                                TransLine1.CALCFIELDS("Reserved Qty. Outbnd. (Base)");

                                // IF (TransLine1."Quantity (Base)" > TransLine1."Reserved Qty. Outbnd. (Base)") THEN
                                //  ERROR(Text50001,TransLine1."Line No.");

                                Item.RESET;
                                Item.SETFILTER("No.", TransLine1."Item No.");
                                Item.SETFILTER("Date Filter", DateFilter);
                                Item.SETFILTER("Location Filter", TransLine1."Transfer-from Code");
                                Item.SETFILTER("Variant Filter", '%1', TransLine1."Variant Code");
                                IF Item.FIND('-') THEN BEGIN
                                    Item.CALCFIELDS("Net Change", "Reserved Qty. on Inventory");
                                    AvailableQuantity := Item."Net Change" - (Item."Reserved Qty. on Inventory" - TransLine1."Reserved Qty. Outbnd. (Base)");
                                END;

                                IF (TransLine1."Quantity (Base)" > AvailableQuantity) THEN
                                    ERROR(Text0001, TransLine1."Line No.");

                                IF TransLine1."Transfer-from Bin Code" <> '' THEN BEGIN
                                    BinContent.GET(TransLine1."Transfer-from Code", TransLine1."Transfer-from Bin Code", TransLine1."Item No.",
                                    TransLine1."Variant Code", TransLine1."Unit of Measure Code");
                                    BinContent.CALCFIELDS(BinContent.Quantity);
                                    IF BinContent.Quantity < TransLine1.Quantity THEN
                                        ERROR('Insufficient Bin Quantity for line no %1', TransLine1."Line No.");
                                END;
                            UNTIL TransLine1.NEXT = 0;


                        IF Rec."Customer Price Group" <> '' THEN BEGIN
                            TransLine1.RESET;
                            TransLine1.SETRANGE("Document No.", Rec."No.");
                            IF TransLine1.FIND('-') THEN
                                REPEAT
                                //   TransLine1.TESTFIELD(MRP);
                                UNTIL TransLine1.NEXT = 0;
                        END;

                        Rec."Releasing Date" := WORKDATE;
                        Rec."Releasing Time" := TIME;

                        Rec."Posting Date" := 0D;
                        Rec."Transfer order Status" := Rec."Transfer order Status"::Released;
                        Rec."Locked Order" := TRUE;
                        Rec."External Transfer" := TRUE;
                        Rec.MODIFY;
                        //TRI
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
                        Rec.TESTFIELD("Locked Order", FALSE);
                        Rec.TESTFIELD("Transfer order Status", Rec."Transfer order Status"::Released);
                        Rec."Transfer order Status" := Rec."Transfer order Status"::Open;
                        Rec.MODIFY;
                        ReleaseTransferDoc.Reopen(Rec);
                    end;
                }
                action("Calculate Structure Values")
                {
                    Caption = 'Calculate Structure Values';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        TransferLine: Record "Transfer Line";
                    begin
                        // NAVIN
                        /*  TransferLine.CalculateStructures(Rec);
                          TransferLine.AdjustStructureAmounts(Rec);
                          TransferLine.UpdateTransLines(Rec);*/
                        // NAVIN
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
                action("Delete Transfer Order")
                {
                    Caption = 'Delete Transfer Order';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        TransferLine: Record "Transfer Line";
                    begin
                        Rec.Status := Rec.Status::Open;
                        IF CONFIRM('Do you want to delete Transfer Order %1', TRUE, Rec."No.") THEN BEGIN
                            TransferOrderNo := Rec."No.";
                            TransferLine.SETRANGE(TransferLine."Document No.", Rec."No.");
                            IF TransferLine.FIND('-') THEN
                                REPEAT

                                    TransferLine.InitQtyToShip;
                                    TransferLine.InitQtyToReceive;
                                    IF TransferLine."Quantity Shipped" <> TransferLine."Quantity Received" THEN
                                        ERROR('cannot delete')
                                    ELSE
                                        TransferLine.DELETE();
                                UNTIL TransferLine.NEXT = 0;
                            Rec.DELETE;
                            MESSAGE('Transfer Order %1 has been deleted.', TransferOrderNo);
                        END;
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
                        Rec.TESTFIELD("Transfer order Status", Rec."Transfer order Status"::Released); //ND
                        TransLine.SETRANGE("Document No.", Rec."No.");
                        TransLine.SETRANGE("Derived From Line No.", 0);
                        IF TransLine.FIND('-') THEN
                            REPEAT
                                IF (TransLine."Quantity Shipped" = 0) THEN BEGIN
                                    Item.GET(TransLine."Item No.");
                                    ItemCostMgt.CalculateAverageCost(Item, AverageCostLCY, AverageCostACY);
                                    //TransLine.VALIDATE("Unit Cost",ROUND(AverageCostLCY));
                                    /*IF (TransLine."Price Type" = 0) THEN
                                      TransLine.VALIDATE("Transfer Price",ROUND(AverageCostLCY));*///TRIRJ-MC BSAE FIELD"Price type" NOT AVAILABLE IN NAV 2009
                                    TransLine.MODIFY;
                                END;
                            UNTIL TransLine.NEXT = 0;
                        //COMMIT;

                        /*  IF Rec."Transit Document" THEN BEGIN
                              TransDocDetails.SETRANGE(Type, TransDocDetails.Type::"3");
                              TransDocDetails.SETRANGE("PO / SO No.", Rec."No.");
                              IF NOT TransDocDetails.FIND('-') THEN
                                  ERROR(Text000);
                          END ELSE BEGIN
                              TransDocDetails.SETRANGE(Type, TransDocDetails.Type::"3");
                              TransDocDetails.SETRANGE("PO / SO No.", Rec."No.");
                              IF TransDocDetails.FIND('-') THEN
                                  ERROR(Text001);
                          END;*/

                        //Vipul Tri1.0 StartLine1.RESET;
                        TransLine1.RESET;
                        TransLine1.SETRANGE("Document No.", Rec."No.");
                        TransLine1.SETFILTER(TransLine1."Qty. to Ship", '<>%1', 0);
                        IF TransLine1.FIND('-') THEN
                            REPEAT
                            /*   StrOrdLineDetail.RESET;
                               StrOrdLineDetail.SETFILTER(StrOrdLineDetail.Type, '%1', StrOrdLineDetail.Type::Transfer);
                               StrOrdLineDetail.SETFILTER(StrOrdLineDetail."Document No.", '%1', TransLine1."Document No.");
                               StrOrdLineDetail.SETFILTER(StrOrdLineDetail."Item No.", '%1', TransLine1."Item No.");
                               StrOrdLineDetail.SETFILTER(StrOrdLineDetail."Line No.", '%1', TransLine1."Line No.");
                               IF StrOrdLineDetail.FIND('-') THEN
                                   REPEAT
                                       IF StrOrdLineDetail."Tax/Charge Type" = StrOrdLineDetail."Tax/Charge Type"::Excise THEN
                                           IF TransLine1."Excise Amount" = 0 THEN
                                               TransLine1.TESTFIELD(TransLine1."Excise Amount");
                                   UNTIL StrOrdLineDetail.NEXT = 0;*/
                            UNTIL TransLine1.NEXT = 0;
                        //Vipul Tri1.0 end

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
                        Rec.TESTFIELD("Transfer order Status", Rec."Transfer order Status"::Released); //ND
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

                        /* IF Rec."Transit Document" THEN BEGIN
                             TransDocDetails.SETRANGE(Type, TransDocDetails.Type::"3");
                             TransDocDetails.SETRANGE("PO / SO No.", Rec."No.");
                             IF NOT TransDocDetails.FIND('-') THEN
                                 ERROR(Text000);
                         END ELSE BEGIN
                             TransDocDetails.SETRANGE(Type, TransDocDetails.Type::"3");
                             TransDocDetails.SETRANGE("PO / SO No.", Rec."No.");
                             IF TransDocDetails.FIND('-') THEN
                                 ERROR(Text001);
                         END;*/

                        //Vipul Tri1.0 StartLine1.RESET;
                        TransLine1.RESET;
                        TransLine1.SETRANGE("Document No.", Rec."No.");
                        IF TransLine1.FIND('-') THEN
                            REPEAT
                            /*   StrOrdLineDetail.RESET;
                               StrOrdLineDetail.SETFILTER(StrOrdLineDetail.Type, '%1', StrOrdLineDetail.Type::Transfer);
                               StrOrdLineDetail.SETFILTER(StrOrdLineDetail."Document No.", '%1', TransLine1."Document No.");
                               StrOrdLineDetail.SETFILTER(StrOrdLineDetail."Item No.", '%1', TransLine1."Item No.");
                               StrOrdLineDetail.SETFILTER(StrOrdLineDetail."Line No.", '%1', TransLine1."Line No.");
                               IF StrOrdLineDetail.FIND('-') THEN
                                   REPEAT
                                       IF StrOrdLineDetail."Tax/Charge Type" = StrOrdLineDetail."Tax/Charge Type"::Excise THEN
                                           IF TransLine1."Excise Amount" = 0 THEN
                                               TransLine1.TESTFIELD(TransLine1."Excise Amount");
                                   UNTIL StrOrdLineDetail.NEXT = 0;*/
                            UNTIL TransLine1.NEXT = 0;
                        //Vipul Tri1.0 end

                        CODEUNIT.RUN(CODEUNIT::"TransferOrder-Post + Print", Rec);

                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                action("&Print1")
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
        Rec."Shortage TO" := TRUE;
    end;

    var
        TransLine: Record "Transfer Line";
        Item: Record Item;
        ItemCostMgt: Codeunit ItemCostManagement;
        AverageCostLCY: Decimal;
        AverageCostACY: Decimal;
        // TransDocDetails: Record 13768;
        Text000: Label 'You have to attach transit document for this invoice.';
        Text001: Label 'Transit document(s) are not required  for this invoice.';
        LockSalDoc: Codeunit "Lock Sales Document";
        TransLine1: Record "Transfer Line";
        DateFilter: Text[500];
        AvailableQuantity: Decimal;
        Text0001: Label 'Sufficient Inventory Not Available in line no. %1';
        BinContent: Record "Bin Content";
        bin: Record Bin;
        // StrOrdLineDetail: Record 13795;
        TransferOrderNo: Code[20];
        TransferLine: Record "Transfer Line";
        tgTransferHeader: Record "Transfer Header";
        tgUserLocation: Record "User Location";
        Text50001: Label 'Reserve Quantity Should be Equal to Quantity for Line No. %1';
        // StrDetails: Record 13793;
        RecNoSeries: Record "No. Series";

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

    local procedure InboundWhseHandlingTimeOnAfter()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;
}

