page 50175 "Issue Slip"
{
    // MIJS, MBA- Infosoft, Jalaj,
    //   : Provide the error if Qty not validate Reserved Qty Outbond.

    Caption = 'Issue Slip';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Transfer Header";
    SourceTableView = WHERE("External Transfer" = FILTER(false));

    //Captive Consumption=FILTER(No),

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
                    TableRelation = "User Location"."Location Code" WHERE("Location Code" = FILTER('MP 1'));
                    ApplicationArea = All;
                }
                field("In-Transit Code"; Rec."In-Transit Code")
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
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                }
                field("Created ID"; Rec."Created ID")
                {
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
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
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Locked Order"; Rec."Locked Order")
                {
                    Editable = false;
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
                field("Shipment No. Series"; Rec."Shipment No. Series")
                {
                    ApplicationArea = All;
                }
                /*  label()
                  {
                  }*/

            }
            part(TransferLines; "Issue Slip Subform")
            {
                SubPageLink = "Document No." = FIELD("No."),
                              "Derived From Line No." = CONST(0);
                ApplicationArea = All;

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
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
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
                    RunPageLink = "Source Document" = FILTER("Inbound Transfer" | "Outbound Transfer"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                    ApplicationArea = All;
                }
                action("St&ructure")
                {
                    ApplicationArea = All;
                    //16225 Page N/F
                    /*   Caption = 'St&ructure';
                       RunObject = Page 16305;
                                       RunPageLink = Type=FILTER(Transfer),
                                     Document No.=FIELD(No.),
                                     Structure Code=FIELD(Structure);*///16225 Page N/F end
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
                action("Get Gate Entry Lines")
                {
                    Caption = 'Get Gate Entry Lines';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //16225 funcation N/F   GetGateEntryLines;
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
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        MSerr0001: Label 'Please Select Department Code First !!!';
                    begin
                        //MSSS- Begin

                        IF Rec."Transfer-to Code" IN ['WH-HOSKOTE', 'WH-DORA'] THEN BEGIN //MSKS1611
                            TransferLine.RESET;
                            TransferLine.SETRANGE(TransferLine."Document No.", Rec."No.");
                            TransferLine.SETFILTER(TransferLine.Quantity, '<>%1', 0);
                            IF TransferLine.FINDFIRST THEN BEGIN
                                REPEAT
                                    TransferLine.CALCFIELDS(TransferLine."Reserved Quantity Outbnd.");
                                    MESSAGE(Text50002, TransferLine.Quantity, ABS(TransferLine."Reserved Quantity Outbnd."));
                                    IF TransferLine.Quantity > ROUND(TransferLine."Reserved Quantity Outbnd.") THEN
                                        ERROR(Text50001, TransferLine."Line No.");
                                UNTIL TransferLine.NEXT = 0;
                            END;
                        END; //MSKS1611
                             //MSSS- End

                        /*
                       //Commneted by Deepak for correction
                       {
                       //TESTFIELD(Status,Status::Released);
                       //mo tri1.0 Customization no.45 start
                       DateFilter := '..' + FORMAT("Posting Date");
                       TransLine1.RESET;
                       TransLine1.SETRANGE("Document No.","No.");
                       TransLine1.SETFILTER(Quantity,'<>0');
                       IF TransLine1.FIND('-') THEN
                         REPEAT
                           TransLine1.CALCFIELDS(TransLine1."Reserved Quantity Outbnd.");
                           // MIJS.begin
                           MESSAGE('%1,%2',TransLine1."Reserved Quantity Outbnd.",TransLine1.Quantity);
                           IF TransLine1."Reserved Quantity Outbnd." <> TransLine1.Quantity THEN
                             ERROR(Text50000);      //TRI DG Stop
                           // MIJS.end
                           IF (TransLine1."Reserved Quantity Outbnd." < TransLine1.Quantity) THEN
                             BEGIN
                               ERROR(Text0001,TransLine1."Line No.");
                               {

                       //     IF TransLine1."End Use Item" = kULBHUSHAN

                               Item.RESET;
                               Item.SETFILTER("No.",TransLine1."Item No.");
                            //   Item.SETFILTER("Date Filter",DateFilter);
                               Item.SETFILTER("Location Filter",TransLine1."Transfer-from Code");
                               IF Item.FIND('-') THEN BEGIN
                                 Item.CALCFIELDS("Net Change","Reserved Qty. on Inventory");
                                 AvailableQuantity := Item."Net Change"  - Item."Reserved Qty. on Inventory";
                               END;
                               IF (TransLine1.Quantity > AvailableQuantity) THEN
                                 ERROR(Text0001,TransLine1."Line No.");
                                  }
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

                       "Releasing Date" := WORKDATE;  //ravi
                       "Releasing Time" := TIME;   //ravi

                       if "External Transfer" then
                       IF "Customer Price Group" <> '' THEN BEGIN
                         TransLine1.RESET;
                         TransLine1.SETRANGE("Document No.","No.");
                         IF TransLine1.FIND('-') THEN
                         REPEAT
                           TransLine1.TESTFIELD(MRP);
                         UNTIL TransLine1.NEXT = 0;
                       END;

                       "Posting Date" := 0D;
                       //rahul  "Shipment Date" := 0D;
                       "Transfer order Status" := "Transfer order Status" :: Released;
                       MODIFY;
                       ReleaseTrasfer.RUN(Rec);
                       }
                       TESTFIELD(Status,Status::Open);
                       //TESTFIELD("Transfer order Status","Transfer order Status"::Open);
                       //TRI A.S 07.11.08 Code Start
                       TransLine1.RESET;
                       TransLine1.SETRANGE("Document No.","No.");
                       IF TransLine1.FIND('-') THEN
                         REPEAT
                           TransLine1.TESTFIELD(TransLine1.Quantity);
                           //MSKS.0001 Start
                           TransLine1.CALCFIELDS("Reserved Qty. Outbnd. (Base)");
                           IF TransLine1."Reserved Qty. Outbnd. (Base)" <> TransLine1."Quantity (Base)" THEN;
                           //MSKS.0001 End
                         UNTIL TransLine1.NEXT = 0;
                       //TRI A.S 07.11.08 Code End

                       if "Transfer-from Code" <> "Production Plant Code" Then
                          ERROR('Please select the Transfer and Production Plant Code Same!!');

                       //mo tri1.0 Customization no.45 start
                       DateFilter := '..' + FORMAT("Posting Date");
                       TransLine1.RESET;
                       TransLine1.SETRANGE("Document No.","No.");
                       TransLine1.SETFILTER(Quantity,'<>0');
                       IF TransLine1.FIND('-') THEN
                         REPEAT
                           TransLine1.CALCFIELDS(TransLine1."Reserved Quantity Outbnd.",TransLine1."Reserved Qty. Outbnd. (Base)");
                           // MIJS.begin
                           IF TransLine1."Reserved Qty. Outbnd. (Base)" <> TransLine1."Quantity (Base)" THEN;
                           // MIJS.end
                           IF (TransLine1."Reserved Qty. Outbnd. (Base)" < TransLine1."Quantity (Base)") THEN
                             BEGIN
                               Item.RESET;
                               Item.SETFILTER("No.",TransLine1."Item No.");
                            //   Item.SETFILTER("Date Filter",DateFilter);
                               Item.SETFILTER("Location Filter",TransLine1."Transfer-from Code");
                               IF Item.FIND('-') THEN BEGIN
                                 Item.CALCFIELDS("Net Change","Reserved Qty. on Inventory");
                                 AvailableQuantity := Item."Net Change"  - Item."Reserved Qty. on Inventory";
                               END;
                               IF (TransLine1.Quantity > AvailableQuantity) THEN;
                                // ERROR(Text0001,TransLine1."Line No.");
                             END;
                       //    bin.SETRANGE(bin."Location Code",TransLine1."Transfer-from Code");
                        //   IF bin.FIND('-') THEN BEGIN    //TRI DG stop
                           IF TransLine1."Transfer-from Bin Code" <> '' THEN BEGIN
                           BinContent.GET(TransLine1."Transfer-from Code",TransLine1."Transfer-from Bin Code",TransLine1."Item No.",
                           TransLine1."Variant Code",TransLine1."Unit of Measure Code");
                           BinContent.CALCFIELDS(BinContent.Quantity);
                           IF BinContent.Quantity < TransLine1.Quantity THEN
                             ERROR('Insufficient Bin Quantity for line no %1',TransLine1."Line No.");
                          END;
                         UNTIL TransLine1.NEXT = 0;
                       //mo tri1.0 Customization no.45 end;

                       "Releasing Date" := WORKDATE;  //ravi
                       "Releasing Time" := TIME;   //ravi

                       if "External Transfer" then
                       IF "Customer Price Group" <> '' THEN BEGIN
                         TransLine1.RESET;
                         TransLine1.SETRANGE("Document No.","No.");
                         IF TransLine1.FIND('-') THEN
                         REPEAT
                           TransLine1.TESTFIELD(MRP);
                         UNTIL TransLine1.NEXT = 0;
                       END;

                       "Posting Date" := 0D;
                       //rahul  "Shipment Date" := 0D;
                       "Transfer order Status" := "Transfer order Status" :: Released;
                       MODIFY;
                       ReleaseTrasfer.RUN(Rec);
                       */


                        //TRI
                        //TESTFIELD("Transfer order Status","Transfer order Status"::Open);
                        DateFilter := '..' + FORMAT(Rec."Posting Date");
                        TransLine1.RESET;
                        TransLine1.SETRANGE(TransLine1."Document No.", Rec."No.");
                        TransLine1.SETFILTER(TransLine1.Quantity, '<>0');
                        IF TransLine1.FIND('-') THEN
                            REPEAT
                                //MSBS.Rao Start 290914
                                TransLine1.TESTFIELD("Qty. to Ship");
                                IF TransLine1."Shortcut Dimension 2 Code" = '' THEN
                                    ERROR(MSerr0001);
                                //MSBS.Rao Stop 290914
                                TransLine1.CALCFIELDS(TransLine1."Reserved Qty. Outbnd. (Base)");
                                Item.RESET;
                                Item.SETFILTER("No.", TransLine1."Item No.");
                                Item.SETFILTER("Date Filter", DateFilter);
                                Item.SETFILTER("Location Filter", TransLine1."Transfer-from Code");
                                Item.SETFILTER(Item."Variant Filter", '%1', TransLine1."Variant Code");
                                IF Item.FIND('-') THEN BEGIN
                                    Item.CALCFIELDS(Item."Net Change", Item."Reserved Qty. on Inventory");
                                    AvailableQuantity := (Item."Net Change") - (Item."Reserved Qty. on Inventory" - TransLine1."Reserved Qty. Outbnd. (Base)");
                                END;

                                //IF (TransLine1."Quantity (Base)" > AvailableQuantity) THEN
                                // ERROR(Text50001,TransLine1."Line No.");

                                IF TransLine1."Transfer-from Bin Code" <> '' THEN BEGIN
                                    BinContent.GET(TransLine1."Transfer-from Code", TransLine1."Transfer-from Bin Code", TransLine1."Item No.",
                                    TransLine1."Variant Code", TransLine1."Unit of Measure Code");
                                    BinContent.CALCFIELDS(BinContent.Quantity);
                                    IF BinContent.Quantity < TransLine1.Quantity THEN
                                        ERROR('Insufficient Bin Quantity for line no %1', TransLine1."Line No.");
                                END;
                            UNTIL TransLine1.NEXT = 0;

                        Rec."Releasing Date" := WORKDATE;
                        Rec."Releasing Time" := TIME;

                        IF Rec."External Transfer" THEN
                            IF Rec."Customer Price Group" <> '' THEN BEGIN
                                TransLine1.RESET;
                                TransLine1.SETRANGE(TransLine1."Document No.", Rec."No.");
                                IF TransLine1.FIND('-') THEN
                                    REPEAT
                                    //16225 TransLine1.TESTFIELD(TransLine1.MRP);
                                    UNTIL TransLine1.NEXT = 0;
                            END;


                        //SHAKTI

                        /*TransLine1.RESET;
                        TransLine1.SETRANGE("Document No.","No.");
                        IF TransLine1.FIND('-') THEN BEGIN
                        REPEAT
                        IF TransLine1."Qty. to Ship" >0 THEN
                        TransLine1.TESTFIELD(TransLine1."Reserved Quantity Outbnd.");
                        TransLine1.CALCFIELDS(TransLine1."Reserved Quantity Outbnd.");
                        IF TransLine1.Quantity <= TransLine1."Reserved Quantity Outbnd." THEN
                        "Posting Date" := 0D;
                        "Transfer order Status" := "Transfer order Status" :: Released;
                        MODIFY;
                        ReleaseTrasfer.RUN(Rec);
                        
                          UNTIL TransLine1.NEXT = 0;
                        END
                        ELSE
                        ERROR(Text50002,TransLine1.Quantity,TransLine1."Reserved Quantity Outbnd.");   */

                        //SHAKTI


                        Rec."Posting Date" := 0D;
                        Rec."Transfer order Status" := Rec."Transfer order Status"::Released;
                        Rec.MODIFY;
                        ReleaseTrasfer.RUN(Rec);
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
                        //TRI START
                        Rec."Transfer order Status" := Rec."Transfer order Status"::Open;
                        Rec.MODIFY;
                        //TRI STOP
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
                        //16225 Funcation N/F Start
                        /* TransferLine.CalculateStructures(Rec);
                         TransferLine.AdjustStructureAmounts(Rec);
                         TransferLine.UpdateTransLines(Rec);*///16225 Funcation N/F End
                    end;
                }
                action("Delete Transfer Order")
                {
                    Caption = 'Delete Transfer Order';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::Open;
                        IF CONFIRM('Do you want to delete Transfer Order %1', TRUE, Rec."No.") THEN BEGIN
                            Transferorderno := Rec."No.";
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
                            MESSAGE('Transfer Order %1 has been deleted.', Transferorderno);
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
                        Rec.TESTFIELD(Rec."Transfer order Status", Rec."Transfer order Status"::Released); //ND
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
                    Visible = false;
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
                    Visible = false;
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
                    Visible = false;
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
                action("Issue Slip")
                {
                    Caption = 'Issue Slip';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        TransferHeader: Record "Transfer Header";
                    begin
                        TransferHeader.RESET;
                        TransferHeader.SETFILTER("No.", '%1', Rec."No.");
                        IF TransferHeader.FINDFIRST THEN
                            //IssueSlip.SETTABLEVIEW(Rec);
                            REPORT.RUN(Report::"Issue Slip", TRUE, TRUE, TransferHeader);
                    end;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        Rec.TESTFIELD(Status, Status::Open);
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
        //16225  "--MIJS---": ;
        Text50000: Label 'Quantity is not equal to Reserved Quantity Outbond\\You can not release the document.';
        ReleaseTrasfer: Codeunit "Release Transfer Document";
        Text50001: Label 'Reserve Quantity Should be Equal to Quantity for Line No. %1';
        Text50002: Label 'Transfer Order Quantity %1 &  Reserve Quantity %2.';
        TransferLine: Record "Transfer Line";
        Transferorderno: Code[20];
        IssueSlip: Report "Issue Slip";
        RecTL: Record "Transfer Line";

    local procedure PostingDateOnAfterValidate()
    begin
        CurrPage.TransferLines.PAGE.Update(TRUE);
    end;

    local procedure InTransitCodeOnActivate()
    begin
        Rec."In-Transit Code" := 'INTRAN';
    end;
}

