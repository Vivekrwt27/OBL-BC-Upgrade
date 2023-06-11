page 50099 "Transfer Order External"
{
    // 1. TRI A.S 07.11.08 - Code Added for Quantity not to be zero.
    // MSKS.0001 :
    //     Kulwant Singh 27-07-2010 Reserve Qty made Mandatory

    Caption = 'Transfer Order-External';
    PageType = Card;
    Permissions = TableData "Purch. Rcpt. Line" = rimd;
    SourceTable = "Transfer Header";
    /* SourceTableView = WHERE("Captive Consumption" = FILTER(false),
                            "External Transfer" = FILTER(true)); */
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = "No.Editable";
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    Editable = "Transfer-from CodeEditable";
                    ApplicationArea = All;
                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    Editable = "Transfer-to CodeEditable";
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("In-Transit Code"; Rec."In-Transit Code")
                {
                    Editable = "In-Transit CodeEditable";
                    ApplicationArea = All;
                }
                field("Bill from Pin Code"; Rec."Bill from Pin Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill To  Pin Code"; Rec."Bill To  Pin Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }

                field(Purpose; Rec.Purpose)
                {
                    Editable = PurposeEditable;
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
                field("Loading Inspector"; Rec."Loading Inspector")
                {
                    Editable = "Loading InspectorEditable";
                    ApplicationArea = All;
                }
                field("Truck No."; Rec."Truck No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF (Rec."Qty. To Ship" <> 0) AND (Rec."External Transfer") THEN
                            ERROR('Truck No. Cannot Changed When (Qty to Ship) is Greater Then ZERO');
                    end;
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    Editable = "Customer Price GroupEditable";
                    ApplicationArea = All;
                }
                field("Total Qty"; Rec."Total Qty")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Group Code"; Rec."Group Code")
                {
                    Editable = "Group CodeEditable";
                    ApplicationArea = All;
                }
                field(Pay; Rec.Pay)
                {
                    Editable = PayEditable;
                    ApplicationArea = All;
                }
                field("Locked Order"; Rec."Locked Order")
                {
                    Editable = "Locked OrderEditable";
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Caption = 'Posting / Receiving Date';
                    Editable = "Posting DateEditable";
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PostingDateOnAfterValidate;
                        Rec."Shipment Date" := Rec."Posting Date";
                        Rec."GR Date" := Rec."Posting Date";
                    end;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShipmentDateOnAfterValidate;
                    end;
                }
                field("Transfer order Status"; Rec."Transfer order Status")
                {
                    Caption = 'Status';
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("E-way Bill No."; Rec."E-way Bill No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF (STRLEN(Rec."E-way Bill No.") <> 12) THEN
                            ERROR(Text50032);

                        IF CONFIRM('E-Way Bill No. You have Entered' + '-' + Rec."E-way Bill No.", TRUE) THEN
                            "E-Way Bill No.editable" := FALSE
                        ELSE
                            "E-Way Bill No.editable" := TRUE
                    end;
                }
                field("GR No."; Rec."GR No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF (Rec."Qty. To Ship" <> 0) AND (Rec."External Transfer") THEN
                            ERROR('Gr.No. Cannot Changed When (Qty to Ship) is Greater Then ZERO');
                    end;
                }
                field("GR Date"; Rec."GR Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF (Rec."Qty. To Ship" <> 0) AND (Rec."External Transfer") THEN
                            ERROR('Gr.Date Cannot Changed When (Qty to Ship) is Greater Then ZERO');
                    end;
                }
                field("Insurance Amount"; Rec."Insurance Amount")
                {
                    Editable = "Insurance AmountEditable";
                    ApplicationArea = All;
                }
                field("Transit Document"; Rec."Transit Document")
                {
                    Editable = "Transit DocumentEditable";
                    ApplicationArea = All;
                }
                field("SalesPerson Code"; Rec."SalesPerson Code")
                {
                    Editable = "SalesPerson CodeEditable";
                    ApplicationArea = All;
                }
                field("Qty in Sq Mtr"; Rec."Qty in Sq Mtr")
                {
                    ApplicationArea = All;
                }
                field("Total Weight"; Rec."Total Weight")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Qty. To Ship"; Rec."Qty. To Ship")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Editable = "External Document No.Editable";
                    ApplicationArea = All;
                }
                field("Shipment No. Series"; Rec."Shipment No. Series")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(TransferLines; "Transfer Order Subform")
            {
                SubPageLink = "Document No." = FIELD("No."),
                              "Derived From Line No." = CONST(0);
                ApplicationArea = All;
            }
            group("Transfer-From or Transfer-To")
            {
                Caption = 'Transfer-From or Transfer-To';
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
                field("OutPut Date"; Rec."OutPut Date")
                {
                    ApplicationArea = All;
                }
                field("Production Plant Code"; Rec."Production Plant Code")
                {
                    ApplicationArea = All;
                }
                field("Releasing Date"; Rec."Releasing Date")
                {
                    ApplicationArea = All;
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //OutboundWhseHandlingTimeOnAfter;
                        OutboundWhseHandlingTimeOnAfte
                    end;
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
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ApplicationArea = All;
                }
                field("Shipping No."; Rec."Shipping No.")
                {
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Receiving No."; Rec."Receiving No.")
                {
                    ApplicationArea = All;
                }
                field("Releasing Time"; Rec."Releasing Time")
                {
                    ApplicationArea = All;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShippingTimeOnAfterValidate;
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
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
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
                /* action(Structure)
                 {
                     Caption = 'Structure';
                     RunObject = Page 16305;
                     RunPageLink = Type = FILTER(Transfer),
                                   "Document No." = FIELD("No."),
                                   "Structure Code" = FIELD(Structure);
                     ApplicationArea = All;
                 }*/
                action("Transit Documents")
                {
                    Caption = 'Transit Documents';
                    /*  RunObject = Page "Transit Document Order Details";
                      RunPageLink = Type = CONST(3),
                                    "PO / SO No." = FIELD("No.");*/
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
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
                        //VALIDATE("Transfer-from Code");
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

                        /*  IF "Transit Document" THEN BEGIN
                              TransDocDetails.SETRANGE(Type, TransDocDetails.Type::"3");
                              TransDocDetails.SETRANGE("PO / SO No.", Rec."No.");
                              IF NOT TransDocDetails.FIND('-') THEN
                                  ERROR(Text000);
                          END ELSE BEGIN
                              TransDocDetails.SETRANGE(Type, TransDocDetails.Type::"3");
                              TransDocDetails.SETRANGE("PO / SO No.", Rec."No.");
                              IF TransDocDetails.FIND('-') THEN
                                  ERROR(Text001);
                          END;*/ // 15578

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
                action(Reserve)
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        CurrPage.TransferLines.PAGE.ShowReservation;
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


                        IF Rec."Transfer-to Code" IN ['SKD-SAMPLE', 'HSK-SAMPLE', 'DRA-SAMPLE'] THEN
                            EXIT
                        ELSE
                            IF Rec."Transfer-from Code" IN ['SKD-WH-MFG', 'HSK-WH-MFG', 'DRA-WH-MFG'] THEN BEGIN
                                IF UserSetup.GET(USERID) THEN BEGIN
                                    IF UserSetup."Allow TO Release" = FALSE THEN
                                        ERROR('%1 has no permission to Release the Transfer Order, Please Cal On 8373914482', UserSetup."User ID");
                                END;
                            END;


                        //   Rec.TESTFIELD(Structure); //MSKS2509
                        TransferLine.RESET;
                        //TransferLine.SETRANGE("Document Type","Document Type");
                        TransferLine.SETRANGE("Document No.", Rec."No.");
                        TransferLine.SETRANGE("Structure Calculated", FALSE);
                        IF TransferLine.FINDFIRST THEN
                            ERROR('Please Press F10 Before Releasing');

                        Rec.TESTFIELD("Customer Price Group");


                        Rec.CheckExciseStructure;//MSBS.Rao 0713
                        Rec.VALIDATE("Transfer-from Code");
                        IF RecLocation.GET(Rec."Transfer-from Code") THEN
                            /*   IF StructureHeader.GET(Structure) THEN BEGIN
                                   ExciseStr := StructureHeader.Excise;
                               END;*/

                        IF (ExciseStr = TRUE) AND (RecLocation."Excisable Location" = FALSE) THEN
                                ERROR('%1', Text50000);
                        TransferLine.RESET;
                        TransferLine.SETRANGE("Document No.", Rec."No.");
                        TransferLine.SETRANGE("Transfer-from Code", '');
                        IF TransferLine.FINDFIRST THEN
                            ERROR('You can not release with a blank line');


                        /*
                        //Commented By deepak
                        {
                        TESTFIELD("Transfer order Status","Transfer order Status"::Open);
                        //TRI DG 020810 Add Start
                        IF RecNoSeries.GET("No. Series") THEN BEGIN
                          IF RecNoSeries.Trading THEN BEGIN
                            StrDetails.RESET;
                            StrDetails.SETRANGE(Code,Structure);
                            StrDetails.SETRANGE(StrDetails.Type,StrDetails.Type::Excise);
                            IF StrDetails.FINDFIRST THEN
                              ERROR('This is a trading Order and you cannot choose excise');
                          END;
                        END;
                        //TRI DG 020810 Add Stop
                        
                        //TRI A.S 07.11.08 Code Start
                        TransLine1.RESET;
                        TransLine1.SETRANGE("Document No.","No.");
                        IF TransLine1.FIND('-') THEN
                          REPEAT
                            TransLine1.TESTFIELD(TransLine1.Quantity);
                            //MSKS.0001 Start
                            TransLine1.CALCFIELDS("Reserved Qty. Outbnd. (Base)");
                            IF TransLine1."Reserved Qty. Outbnd. (Base)" <> TransLine1."Quantity (Base)" THEN BEGIN
                              ERROR(Text50001,TransLine1."Line No.");
                            END;
                            //MSKS.0001 End
                        
                          UNTIL TransLine1.NEXT = 0;
                        //TRI A.S 07.11.08 Code End
                        
                        //mo tri1.0 Customization no.45 start
                        DateFilter := '..' + FORMAT("Posting Date");
                        TransLine1.RESET;
                        TransLine1.SETRANGE("Document No.","No.");
                        TransLine1.SETFILTER(Quantity,'<>0');
                        IF TransLine1.FIND('-') THEN
                          REPEAT
                            TransLine1.CALCFIELDS(TransLine1."Reserved Quantity Outbnd.");
                            IF (TransLine1."Reserved Quantity Outbnd." < TransLine1."Quantity (Base)") THEN
                              BEGIN
                                //ERROR(Text0001,TransLine1."Line No.");
                                Item.RESET;
                                Item.SETFILTER("No.",TransLine1."Item No.");
                             //   Item.SETFILTER("Date Filter",DateFilter);
                                Item.SETFILTER("Location Filter",TransLine1."Transfer-from Code");
                                Item.SETFILTER("Variant Filter",'%1',TransLine1."Variant Code");
                                IF Item.FIND('-') THEN BEGIN
                                  Item.CALCFIELDS("Net Change","Reserved Qty. on Inventory");
                                  AvailableQuantity := Item."Net Change"  - Item."Reserved Qty. on Inventory";
                                END;
                                IF (ROUND(TransLine1."Quantity (Base)",0.01,'=') > ROUND(AvailableQuantity,0.01,'=')) THEN ;
                                  //ERROR(Text0001,TransLine1."Line No.");
                              END;
                        //    bin.SETRANGE(bin."Location Code",TransLine1."Transfer-from Code");
                         //   IF bin.FIND('-') THEN BEGIN
                            IF TransLine1."Transfer-from Bin Code" <> '' THEN BEGIN
                            BinContent.GET(TransLine1."Transfer-from Code",TransLine1."Transfer-from Bin Code",TransLine1."Item No.",
                            TransLine1."Variant Code",TransLine1."Unit of Measure Code");
                            BinContent.CALCFIELDS(BinContent.Quantity);
                            IF BinContent.Quantity < TransLine1.Quantity THEN
                              ERROR('Insufficient Bin Quantity for line no %1',TransLine1."Line No.");
                           END;
                          UNTIL TransLine1.NEXT = 0;
                        //mo tri1.0 Customization no.45 end;
                        
                        IF "Customer Price Group" <> '' THEN BEGIN
                          TransLine1.RESET;
                          TransLine1.SETRANGE("Document No.","No.");
                          IF TransLine1.FIND('-') THEN
                          REPEAT
                            TransLine1.TESTFIELD(MRP);
                          UNTIL TransLine1.NEXT = 0;
                        END;
                        
                        "Releasing Date" := WORKDATE;  //ravi
                        "Releasing Time" := TIME;   //ravi
                        
                        "Posting Date" := 0D;
                        //rahul  "Shipment Date" := 0D;
                        "Transfer order Status" := "Transfer order Status" :: Released;
                        "Locked Order" := TRUE; //trident rakesh 260906
                        MODIFY;
                        }
                        //Commeented by Deepak Stop
                        
                        TESTFIELD("Transfer order Status","Transfer order Status"::Open);
                        //TRI A.S 07.11.08 Code Start
                        TransLine1.RESET;
                        TransLine1.SETRANGE("Document No.","No.");
                        IF TransLine1.FIND('-') THEN
                          REPEAT
                            TransLine1.TESTFIELD(TransLine1.Quantity);
                            //MSKS.0001 Start
                            TransLine1.CALCFIELDS("Reserved Qty. Outbnd. (Base)");
                            IF TransLine1."Reserved Qty. Outbnd. (Base)" <> TransLine1."Quantity (Base)" THEN BEGIN
                              ERROR(Text50001,TransLine1."Line No.");
                            END;
                        
                            //MSKS.0001 End
                          UNTIL TransLine1.NEXT = 0;
                        //TRI A.S 07.11.08 Code End
                        
                        //mo tri1.0 Customization no.45 start
                        DateFilter := '..' + FORMAT("Posting Date");
                        TransLine1.RESET;
                        TransLine1.SETRANGE("Document No.","No.");
                        TransLine1.SETFILTER(Quantity,'<>0');
                        IF TransLine1.FIND('-') THEN
                          REPEAT
                            TransLine1.CALCFIELDS(TransLine1."Reserved Quantity Outbnd.","Reserved Qty. Outbnd. (Base)");
                            IF (TransLine1."Reserved Qty. Outbnd. (Base)" < TransLine1."Quantity (Base)") THEN
                              BEGIN
                                //ERROR(Text0001,TransLine1."Line No.");
                                Item.RESET;
                                Item.SETFILTER("No.",TransLine1."Item No.");
                                //Item.SETFILTER("Date Filter",DateFilter);
                                Item.SETFILTER("Location Filter",TransLine1."Transfer-from Code");
                                Item.SETFILTER("Variant Filter",'%1',TransLine1."Variant Code");
                                IF Item.FIND('-') THEN BEGIN
                                  Item.CALCFIELDS("Net Change","Reserved Qty. on Inventory");
                                  AvailableQuantity := Item."Net Change"  - Item."Reserved Qty. on Inventory";
                                END;
                                IF TransLine1."Quantity (Base)" > AvailableQuantity THEN
                                  ERROR(Text0001,TransLine1."Line No.");
                              END;
                            IF TransLine1."Transfer-from Bin Code" <> '' THEN BEGIN
                              BinContent.GET(TransLine1."Transfer-from Code",TransLine1."Transfer-from Bin Code",TransLine1."Item No.",
                              TransLine1."Variant Code",TransLine1."Unit of Measure Code");
                              BinContent.CALCFIELDS(BinContent.Quantity);
                              IF BinContent.Quantity < TransLine1.Quantity THEN
                                ERROR('Insufficient Bin Quantity for line no %1',TransLine1."Line No.");
                           END;
                          UNTIL TransLine1.NEXT = 0;
                        //mo tri1.0 Customization no.45 end;
                        
                        IF "Customer Price Group" <> '' THEN BEGIN
                          TransLine1.RESET;
                          TransLine1.SETRANGE("Document No.","No.");
                          IF TransLine1.FIND('-') THEN
                          REPEAT
                            TransLine1.TESTFIELD(MRP);
                          UNTIL TransLine1.NEXT = 0;
                        END;
                        
                        "Releasing Date" := WORKDATE;  //ravi
                        "Releasing Time" := TIME;   //ravi
                        
                        "Posting Date" := 0D;
                        //rahul  "Shipment Date" := 0D;
                        "Transfer order Status" := "Transfer order Status" :: Released;
                        "Locked Order" := TRUE; //trident rakesh 260906
                        "External Transfer" := TRUE;
                        MODIFY;
                        */




                        //TRI
                        Rec.TESTFIELD("Transfer order Status", Rec."Transfer order Status"::Open);
                        DateFilter := '..' + FORMAT(Rec."Posting Date");
                        TransLine1.RESET;
                        TransLine1.SETRANGE("Document No.", Rec."No.");
                        TransLine1.SETFILTER(Quantity, '<>0');
                        IF TransLine1.FIND('-') THEN
                            REPEAT
                                TransLine1.CALCFIELDS("Reserved Qty. Outbnd. (Base)");

                                IF (TransLine1."Quantity (Base)" > TransLine1."Reserved Qty. Outbnd. (Base)") THEN
                                    ERROR(Text50001, TransLine1."Line No.");

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
                        Rec.Status := Rec.Status::Released;
                        Rec."Locked Order" := TRUE;
                        Rec."External Transfer" := TRUE;
                        Rec.MODIFY;
                        //TRI

                    end;
                }
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
            }
            group(Others)
            {
                Caption = 'Others';
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
                    ShortCutKey = 'Shift+F6';
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
                        Rec.CreateInvtPutAwayPick;
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
                action("Re&lease1")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    RunObject = Codeunit "Release Transfer Document";
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        IF Rec."Transfer-to Code" IN ['SKD-SAMPLE', 'HSK-SAMPLE', 'DRA-SAMPLE'] THEN
                            EXIT
                        ELSE
                            IF Rec."Transfer-from Code" IN ['SKD-WH-MFG', 'HSK-WH-MFG', 'DRA-WH-MFG'] THEN BEGIN
                                IF UserSetup.GET(USERID) THEN BEGIN
                                    IF UserSetup."Allow TO Release" = FALSE THEN
                                        ERROR('%1 has no permission to Release the Transfer Order, Please Cal On 8373914482', UserSetup."User ID");
                                END;
                            END;


                        Rec.VALIDATE("Transfer-from Code");
                        Rec.CheckStructureCalculated(Rec); //MSKS2309
                        TransferLine.RESET;
                        TransferLine.SETRANGE("Document No.", Rec."No.");
                        TransferLine.SETRANGE("Transfer-from Code", '');
                        IF TransferLine.FINDFIRST THEN
                            ERROR('You can not release with a blank line');


                        Rec.UpdateStructureCalculated1(Rec, TRUE)
                    end;
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
                        TransferLine.RESET;
                        TransferLine.SETRANGE("Document No.", Rec."No.");
                        TransferLine.CALCSUMS("Quantity Shipped");
                        IF TransferLine."Quantity Shipped" > 0 THEN
                            ERROR('Qty has already shipped');

                        ReleaseTransferDoc.Reopen(Rec);
                    end;
                }
                action("Reo&pen")
                {
                    Caption = 'Reo&pen';
                    Image = ReOpen;
                    ShortCutKey = 'Ctrl+O';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleaseTransferDoc: Codeunit "Release Transfer Document";
                    begin
                        TransLine.SETRANGE("Document No.", Rec."No.");
                        TransLine.SETFILTER(TransLine."Quantity Shipped", '<>0');
                        IF TransLine.FIND('-') THEN
                            ERROR('Qty Already Shipped for Trasnfer Order No. %1', rec."No.");


                        Rec.TESTFIELD("Locked Order", FALSE);
                        Rec.TESTFIELD("Transfer order Status", Rec."Transfer order Status"::Released);
                        Rec."Transfer order Status" := Rec."Transfer order Status"::Open;

                        Rec.MODIFY;
                        ReleaseTransferDoc.Reopen(Rec);
                        Rec.UpdateStructureCalculated1(Rec, FALSE);
                    end;
                }
                action("Calculate Structure Values")
                {
                    Caption = 'Calculate Structure Values';
                    ShortCutKey = 'F10';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        TransferLine: Record "Transfer Line";
                    begin
                        // NAVIN
                        //CheckStructureCalculated(Rec); //MSKS2309
                        /* TransferLine.CalculateStructures(Rec);
                         TransferLine.AdjustStructureAmounts(Rec);
                         TransferLine.UpdateTransLines(Rec);*/
                        tgTransferHeader.UpdateStructureCalculated1(Rec, TRUE); //MSKS2309
                        // NAVIN
                    end;
                }
                action("Lock/Unlock")
                {
                    Caption = 'Lock/Unlock';
                    ShortCutKey = 'Ctrl+U';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        LockSalDoc.CheckLock(Rec);
                    end;
                }
                action("Delete Transfer Order")
                {
                    Caption = 'Delete Transfer Order';
                    ShortCutKey = 'Ctrl+F7';
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
                action("Update Dimension")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        TransShipHead: Record "Transfer Shipment Header";
                        TransShipLine: Record "Transfer Shipment Line";
                    begin
                        TransferLine.RESET;
                        TransferLine.SETRANGE("Document No.", Rec."No.");
                        TransferLine.SETFILTER("Quantity Shipped", '<>%1', 0);
                        TransferLine.SETRANGE("Dimension Set ID", 0);
                        IF TransferLine.FINDFIRST THEN
                            REPEAT
                                TransShipHead.RESET;
                                TransShipHead.SETRANGE("Transfer Order No.", TransferLine."Document No.");
                                IF TransShipHead.FINDFIRST THEN
                                    REPEAT
                                        TransShipLine.RESET;
                                        TransShipLine.SETRANGE("Document No.", TransShipHead."No.");
                                        TransShipLine.SETRANGE("Item No.", TransferLine."Item No.");
                                        IF TransShipLine.FINDFIRST THEN BEGIN
                                            TransferLine."Dimension Set ID" := TransShipLine."Dimension Set ID";
                                            TransferLine.MODIFY;
                                        END;
                                    UNTIL
                                    TransShipHead.NEXT = 0;
                            UNTIL
                            TransferLine.NEXT = 0;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EnabledFalse2;

        IF RecLocation.GET(Rec."Transfer-from Code") THEN
            Rec."Bill from Pin Code" := RecLocation."Pin Code";

        IF RecLocation.GET(Rec."Transfer-from Code") THEN
            Rec."Shortcut Dimension 1 Code" := Rec."Transfer-to Code";
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Rec.TESTFIELD(Status, Rec.Status::Open);
    end;

    trigger OnInit()
    begin
        "External Document No.Editable" := TRUE;
        "Posting DateEditable" := TRUE;
        "SalesPerson CodeEditable" := TRUE;
        "Transit DocumentEditable" := TRUE;
        "Insurance AmountEditable" := TRUE;
        "GR DateEditable" := TRUE;
        "GR No.Editable" := TRUE;
        "Form No.Editable" := TRUE;
        "Form CodeEditable" := TRUE;
        "Group CodeEditable" := TRUE;
        "Loading InspectorEditable" := TRUE;
        PurposeEditable := TRUE;
        StructureEditable := TRUE;
        "In-Transit CodeEditable" := TRUE;
        "Transfer-to CodeEditable" := TRUE;
        "Transfer-from CodeEditable" := TRUE;
        "No.Editable" := TRUE;
        PayEditable := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        UserSet: Record "User Setup";
    begin
        Rec."External Transfer" := TRUE;
        UserSet.GET(USERID);
        Rec."Transfer-from Code" := UserSet.Location;
    end;

    trigger OnOpenPage()
    begin
        EnabledFalse2;
        CLEAR(Rec);

        IF Rec."E-way Bill No." <> '' THEN
            "E-Way Bill No.editable" := FALSE
        ELSE
            "E-Way Bill No.editable" := TRUE

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
        //StrDetails: Record 13793;
        RecNoSeries: Record "No. Series";
        ExciseStr: Boolean;
        RecLocation: Record Location;
        //   StructureHeader: Record 13792;
        Text50000: Label 'Sorry!!!!!! You can''t select the Excisable Structure. Please Contact System administrator.';
        [InDataSet]
        PayEditable: Boolean;
        [InDataSet]
        "No.Editable": Boolean;
        [InDataSet]
        "Transfer-from CodeEditable": Boolean;
        [InDataSet]
        "Transfer-to CodeEditable": Boolean;
        [InDataSet]
        "In-Transit CodeEditable": Boolean;
        [InDataSet]
        StructureEditable: Boolean;
        [InDataSet]
        PurposeEditable: Boolean;
        [InDataSet]
        "Loading InspectorEditable": Boolean;
        [InDataSet]
        "Customer Price GroupEditable": Boolean;
        [InDataSet]
        "Locked OrderEditable": Boolean;
        [InDataSet]
        "Group CodeEditable": Boolean;
        [InDataSet]
        "Form CodeEditable": Boolean;
        [InDataSet]
        "Form No.Editable": Boolean;
        [InDataSet]
        "GR No.Editable": Boolean;
        [InDataSet]
        "GR DateEditable": Boolean;
        [InDataSet]
        "Insurance AmountEditable": Boolean;
        [InDataSet]
        "Transit DocumentEditable": Boolean;
        [InDataSet]
        "SalesPerson CodeEditable": Boolean;
        [InDataSet]
        "Posting DateEditable": Boolean;
        [InDataSet]
        "External Document No.Editable": Boolean;
        "E-Way Bill No.editable": Boolean;
        Text50032: Label 'E-Way Bill No. Should be in Tweleve Charector';
        UserSetup: Record "User Setup";


    procedure EnabledFalse2()
    begin
        IF Rec.Status = Rec.Status::Released THEN BEGIN
            "No.Editable" := FALSE;
            "Transfer-from CodeEditable" := FALSE;
            "Transfer-to CodeEditable" := FALSE;
            "In-Transit CodeEditable" := FALSE;
            StructureEditable := FALSE;
            PurposeEditable := FALSE;
            // CurrForm."Transporter's Name".EDITABLE(FALSE);
            //CurrForm."Transporter Name".EDITABLE(FALSE);
            "Loading InspectorEditable" := FALSE;
            //CurrForm."Truck No.".EDITABLE(FALSE);
            PayEditable := FALSE;
            "Customer Price GroupEditable" := FALSE;
            "Locked OrderEditable" := FALSE;
            //CurrForm."Total Qty".EDITABLE(FALSE);
            "Group CodeEditable" := FALSE;
            //CurrForm."Posting Date".EDITABLE(FALSE);
            "Form CodeEditable" := FALSE;
            "Form CodeEditable" := FALSE;
            "Form No.Editable" := FALSE;
            "GR No.Editable" := FALSE;
            "GR DateEditable" := FALSE;
            "Insurance AmountEditable" := FALSE;
            "Transit DocumentEditable" := FALSE;
            "SalesPerson CodeEditable" := FALSE;
            //CurrForm."Qty in Sq Mtr".EDITABLE(FALSE);
            //CurrForm."Total Weight".EDITABLE(FALSE);
            //CurrForm."Qty. To Ship".EDITABLE(FALSE);
            //CurrForm."External Document No.".EDITABLE(FALSE);
        END ELSE BEGIN
            "No.Editable" := TRUE;
            "Transfer-from CodeEditable" := TRUE;
            "Transfer-to CodeEditable" := TRUE;
            "In-Transit CodeEditable" := TRUE;
            StructureEditable := TRUE;
            PurposeEditable := TRUE;
            //CurrForm."Transporter's Name".EDITABLE(TRUE);
            // CurrForm."Transporter Name".EDITABLE(TRUE);
            "Loading InspectorEditable" := TRUE;
            // CurrForm."Truck No.".EDITABLE(TRUE);
            PayEditable := TRUE;
            "Customer Price GroupEditable" := TRUE;
            "Locked OrderEditable" := TRUE;
            //CurrForm."Total Qty".EDITABLE(TRUE);
            "Group CodeEditable" := TRUE;
            "Posting DateEditable" := TRUE;
            "Form CodeEditable" := TRUE;
            "Form CodeEditable" := TRUE;
            "Form No.Editable" := TRUE;
            "GR No.Editable" := TRUE;
            "GR DateEditable" := TRUE;
            "Insurance AmountEditable" := TRUE;
            "Transit DocumentEditable" := TRUE;
            "SalesPerson CodeEditable" := TRUE;
            // CurrForm."Qty in Sq Mtr".EDITABLE(TRUE);
            //CurrForm."Total Weight".EDITABLE(TRUE);
            //CurrForm."Qty. To Ship".EDITABLE(TRUE);
            "External Document No.Editable" := TRUE;
        END;

        IF (USERID = 'MA028') AND (USERID = 'FA028') THEN
            PayEditable := TRUE;
    end;

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

    local procedure PayOnBeforeInput()
    begin
        IF (USERID = 'MA028') AND (USERID = 'FA028') THEN
            PayEditable := TRUE;
    end;
}

