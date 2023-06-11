codeunit 51000 BaseCodeunit
{
    var
        PostCons: Boolean;
        RecTransferLine: Record "Transfer Line";
        TransferRecptNo: Code[20];

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Get Receipt", 'OnAfterPurchRcptLineSetFilters', '', false, false)]
    local procedure OnAfterPurchRcptLineSetFilters(var PurchRcptLine: Record "Purch. Rcpt. Line"; PurchaseHeader: Record "Purchase Header");
    var
        MainLoc: Text[1024];
        Location1: Record Location;
        c: Codeunit 87;
    begin
        //UPDATE - TCPL - 7632
        //TRI S.K Add Start 030610
        MainLoc := '';
        Location1.RESET;
        Location1.SETRANGE(Location1."Main Location", PurchaseHeader."Location Code");
        IF Location1.FINDFIRST THEN BEGIN
            REPEAT
                MainLoc := MainLoc + '|' + Location1.Code;
            UNTIL Location1.NEXT = 0;
            MainLoc := COPYSTR(MainLoc, 2, STRLEN(MainLoc)) + '|' + PurchaseHeader."Location Code";
        END
        ELSE BEGIN
            MainLoc := PurchaseHeader."Location Code";
        END;
        //TRI S.K Add END 030610
        //UPDATE - TCPL - 7632
        PurchRcptLine.SETCURRENTKEY("Pay-to Vendor No.", "Posting Date");
        PurchRcptLine.SETRANGE("Pay-to Vendor No.", PurchaseHeader."Pay-to Vendor No.");
        PurchRcptLine.SETFILTER("Posting Date", '>%1', 20220131D);
        PurchRcptLine.SETRANGE("Buy-from Vendor No.", PurchaseHeader."Buy-from Vendor No.");
        PurchRcptLine.SETFILTER("Location Code", MainLoc);
    END;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Get Receipt", 'OnBeforeInsertLines', '', false, false)]
    local procedure OnBeforeInsertLines(var PurchaseHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line");
    var
        PurchsRecptNos: Integer;
        PurchRcptLine2: Record "Purch. Rcpt. Line";
        RecPurchRecptHeader: Record "Purch. Rcpt. Header";
    begin
        //UPDATE - TCPL - 7632
        //PurchLine."Document No." := PurchHeader."No.";
        PurchLine.VALIDATE(PurchLine."Document No.", PurchaseHeader."No.");//rahul 130307
                                                                           //UPDATE - TCPL - 7632
                                                                           //UPDATE - TCPL - 7632
                                                                           //msks start
        IF PurchsRecptNos = 1 THEN BEGIN
            IF PurchaseHeader.GET(PurchRcptLine2."Document No.") THEN
                IF PurchaseHeader.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") THEN BEGIN
                    //MESSAGE('%1--%2',RecPurchRecptHeader."Posting Date",PurchRcptLine2."Document No.");
                    PurchaseHeader.VALIDATE("GRN Date", RecPurchRecptHeader."Posting Date");
                    PurchaseHeader."Due Date Calc. On" := RecPurchRecptHeader."Due Date Calc. On";
                    PurchaseHeader.VALIDATE("Payment Terms Code", RecPurchRecptHeader."Payment Terms Code");
                    PurchaseHeader.NOE := RecPurchRecptHeader.NOE;

                    PurchaseHeader.MODIFY;
                    PurchsRecptNos += 1;
                END;
        END;
        //MSKS END
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Get Receipt", 'OnAfterInsertInvoiceLineFromReceiptLine', '', false, false)]
    local procedure OnAfterInsertInvoiceLineFromReceiptLine(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchLine: Record "Purchase Line"; PurchRcptLine2: Record "Purch. Rcpt. Line"; TransferLine: Boolean);
    begin
        IF TransferLine THEN BEGIN
            //UPDATE - TCPL - 7632
            //MSKS
            IF PurchRcptLine2."Item Rcpt. Entry No." <> 0 THEN
                CheckReturnOrderPosted(PurchRcptLine2."Item Rcpt. Entry No.");
            //MSKS
            //UPDATE - TCPL - 7632

        end;
    end;

    procedure CheckReturnOrderPosted(ApplyToEntry: Integer)
    var
        RecIle: Record "Item Ledger Entry";
    begin
        RecIle.RESET;
        RecIle.SETCURRENTKEY("Applies-to Entry");
        RecIle.SETRANGE("Applies-to Entry", ApplyToEntry);
        IF RecIle.FINDFIRST THEN BEGIN
            IF (UPPERCASE(USERID) <> 'FA019') AND (UPPERCASE(USERID) <> 'BDRACC003') AND (UPPERCASE(USERID) <> 'BHKACC005') AND (UPPERCASE(USERID) <> 'PLANTACC5') THEN
                IF RecIle."Invoiced Quantity" <> RecIle.Quantity THEN
                    ERROR('Return Document No. - %1 Pending For Invoice ', RecIle."Document No.");
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::CheckManagement, 'OnInsertCheckOnAfterCheckLedgEntryInsert', '', false, false)]//Codeunit 367
    local procedure OnInsertCheckOnAfterCheckLedgEntryInsert(var CheckLedgEntry: Record "Check Ledger Entry");
    var
        Text012: Label 'Check %1 already exists.';
    begin
        //TRI S.R code Add Start  //TCPL::shiv
        CheckLedgEntry.SETRANGE("Check No.", CheckLedgEntry."Document No.");
        IF CheckLedgEntry.FIND('-') THEN
            ERROR(Text012, CheckLedgEntry."Document No.");
        //TRI S.R code Add Stop     //TCPL::shiv
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnReopenOnBeforeSalesHeaderModify', '', false, false)]// COD414
    local procedure OnReopenOnBeforeSalesHeaderModify(var SalesHeader: Record "Sales Header");
    var
        Text0001: Label 'Sales Order %1  has already been locked &  cannot be reopened. ';
    begin
        //TCPL-7632-260516
        //mo tri1.0 Customization no. 14 start
        IF ((SalesHeader."Document Type" = SalesHeader."Document Type"::Order) AND (SalesHeader."Locked Order" = TRUE)) THEN
            ERROR(Text0001, SalesHeader."No.");
        //mo tri1.0 Customization no. 14 end
        SalesHeader."Opener ID" := USERID;
        SalesHeader."Date of Reopen" := TODAY;
        SalesHeader."Time of Reopen" := TIME;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterReopenSalesDoc', '', false, false)]//COD 414
    local procedure OnAfterReopenSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean);
    var
        TGSalesLine: Record "Sales Line";
    begin
        //TCPL-7632-260516
        SalesHeader.Status := Status::Open;

        IF SalesHeader."Document Type" <> SalesHeader."Document Type"::Order THEN
            ReopenATOs(SalesHeader);
        //TCPL-7632-260516
        //TRI
        //TCPL-7632-260516
        //TRI

        TGSalesLine.RESET;
        TGSalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        TGSalesLine.SETRANGE("Document No.", SalesHeader."No.");
        IF TGSalesLine.FIND('-') THEN
            REPEAT
                TGSalesLine.Status := TGSalesLine.Status::Open;
                TGSalesLine.MODIFY;
            UNTIL TGSalesLine.NEXT = 0;
        //TRI
        //TCPL-7632-260516

    end;

    procedure ReopenATOs(SalesHeader: Record "Sales Header")// COD 414
    var
        SalesLine: Record "Sales Line";
        AsmHeader: Record "Assembly Header";
        ReleaseAssemblyDocument: Codeunit "Release Assembly Document";
    begin
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        IF SalesLine.FINDSET THEN
            REPEAT
                IF SalesLine.AsmToOrderExists(AsmHeader) THEN
                    ReleaseAssemblyDocument.Reopen(AsmHeader);
            UNTIL SalesLine.NEXT = 0;

    end;

    /*  [EventSubscriber(ObjectType::Codeunit, Codeunit::"Inventory Posting To G/L", 'OnAfterRun', '', false, false)]// COD 5802
      local procedure OnAfterRun(var ValueEntry: Record "Value Entry");
      var
          GlobalPostPerPostGroup: Boolean;
          GenJnlLine: Record "Gen. Journal Line";
      begin
          IF GlobalPostPerPostGroup THEN
              PostInvtPostBuf(Rec, "Document No.", '', '', TRUE)
          ELSE
              PostInvtPostBuf(
                Rec,
                "Document No.",
                "External Document No.",
                COPYSTR(
                  STRSUBSTNO(Text000, "Entry Type", "Source No.", "Posting Date"),
                  1, MAXSTRLEN(GenJnlLine.Narration)),
                FALSE);
      end;*/

    /* [EventSubscriber(ObjectType::Codeunit, Codeunit::"Inventory Posting To G/L", 'OnPostInvtPostBufOnAfterInitGenJnlLine', '', false, false)]// COD 5802
    local procedure OnPostInvtPostBufOnAfterInitGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; var ValueEntry: Record "Value Entry");
    var
        Desc: Text[50];
        InvtPostingBuffer: Record "Invt. Posting Buffer";
        DimMgt: Codeunit DimensionManagement;
    begin
        GenJournalLine.INIT;
        GenJournalLine.Narration := Desc;
        GenJournalLine."Location Code" := InvtPostingBuffer."Location Code"; //TSPL SA TO FLOW LOCATION IN G/L ENTRY.  //TCPL::Shiv
        DimMgt.UpdateGlobalDimFromDimSetID(InvtPostingBuffer."Dimension Set ID", GenJournalLine."Shortcut Dimension 1 Code", GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", ValueEntry."Global Dimension 1 Code");   //TRI DG 030910 //TCPL::shiv


    end;
 */
    /*     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Inventory Posting To G/L", 'OnAfterSetDesc', '', false, false)]// COD 5802
        local procedure OnAfterSetDesc(var GenJnlLine: Record "Gen. Journal Line"; var InvtPostBuf: Record "Invt. Posting Buffer");
        var
            Text001: Label '%1 - %2, %3,%4,%5,%6';
        begin
            WITH InvtPostBuf DO
                GenJnlLine.Narration :=
                  COPYSTR(
                    STRSUBSTNO(
                      Text001,
                      "Account Type", "Bal. Account Type",
                      "Location Code", "Inventory Posting Group",
                      "Gen. Bus. Posting Group", "Gen. Prod. Posting Group"),
                    1, MAXSTRLEN(GenJnlLine.Narration));
        end;

        [EventSubscriber(ObjectType::Codeunit, Codeunit::"Inventory Posting To G/L", 'OnInsertTempInvtPostToGLTestBufOnBeforeInsert', '', false, false)]//COD 5802
        local procedure OnInsertTempInvtPostToGLTestBufOnBeforeInsert(var TempInvtPostToGLTestBuf: Record "Invt. Post to G/L Test Buffer"; ValueEntry: Record "Value Entry");
        var
            GenJnlLine: Record "Gen. Journal Line";
        begin
            TempInvtPostToGLTestBuf.Description := GenJnlLine.Narration;
        end;
    */
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnBeforeShowPurchDoc', '', false, false)]//COD 6620
    local procedure OnBeforeShowPurchDoc(var ToPurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean);
    begin
        CASE ToPurchaseHeader."Document Type" OF
            ToPurchaseHeader."Document Type"::Order:
                PAGE.RUN(PAGE::"Purchase Order Subform", ToPurchaseHeader);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterUpdateSalesLine', '', false, false)]//6620
    local procedure OnAfterUpdateSalesLine(var ToSalesHeader: Record "Sales Header"; var ToSalesLine: Record "Sales Line"; var FromSalesHeader: Record "Sales Header"; var FromSalesLine: Record "Sales Line"; var CopyThisLine: Boolean; RecalculateAmount: Boolean; FromSalesDocType: Option; var CopyPostedDeferral: Boolean; ExactCostRevMandatory: Boolean; MoveNegLines: Boolean);
    begin
        IF ToSalesLine.Quantity <> 0 THEN
            ToSalesLine.VALIDATE("Line Discount Amount", FromSalesLine."Line Discount Amount");
        ToSalesLine.VALIDATE("Quantity Discount %", FromSalesLine."Quantity Discount %");//SHAKTI   //TCPL-7632-25052016
        ToSalesLine.VALIDATE("Quantity Discount Amount", FromSalesLine."Quantity Discount Amount"); //SHAKTI      //TCPL-
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterSetDefaultValuesToSalesLine', '', false, false)]
    local procedure OnAfterSetDefaultValuesToSalesLine(var ToSalesLine: Record "Sales Line"; ToSalesHeader: Record "Sales Header"; CreateToHeader: Boolean; RecalculateLines: Boolean);
    begin
        IF ToSalesLine."Document Type" <> ToSalesLine."Document Type"::Order THEN BEGIN
            ToSalesLine."Quantity Discount %" := 0; //SHAKTI  //TCPL-7632-25052016
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnAfterFindSalesLineItemPrice', '', false, false)]// 7000
    local procedure OnAfterFindSalesLineItemPrice(var SalesLine: Record "Sales Line"; var TempSalesPrice: Record "Sales Price"; var FoundSalesPrice: Boolean; CalledByFieldNo: Integer);
    begin
        /* IF TempSalesPrice.MRP THEN BEGIN
             "MRP Price" := ROUND(TempSalesPrice."MRP Price", 1); //TCPL-7632-250516*/
        SalesLine."Unit Price Incl. of Tax" := TempSalesPrice."Unit Price";             //TCPL-7632-250516
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnBeforeCalcBestUnitPrice', '', false, false)]
    local procedure OnBeforeCalcBestUnitPrice(var SalesPrice: Record "Sales Price"; var IsHandled: Boolean);
    var
        CustomerIsThere: Boolean;
        sales: Boolean;
        SalesH: Record "Sales Header";
    begin
        WITH SalesPrice DO BEGIN
            //ND Tri1.0 START
            CustomerIsThere := FALSE;
            IF FIND('-') THEN
                REPEAT
                    IF "Sales Type" = "Sales Type"::Customer THEN
                        IF "Sales Code" <> '' THEN
                            CustomerIsThere := TRUE;
                UNTIL NEXT = 0;

            IF CustomerIsThere THEN BEGIN
                SETRANGE("Sales Type", SalesPrice."Sales Type"::Customer);
                SETFILTER("Sales Code", '<>%1', '');
            END;
            IF sales THEN BEGIN//rahul
                SalesPrice := SalesPrice;
                IF FIND('-') THEN BEGIN
                    SalesPrice.SETFILTER(SalesPrice."Sales Type", '%1', "Sales Type");
                    SalesPrice.SETFILTER(SalesPrice."Sales Code", '%1', "Sales Code");
                    SalesPrice.SETFILTER(SalesPrice."Item No.", '%1', "Item No.");
                    //    SalesPrice.SETFILTER(SalesPrice."Unit of Measure Code",'%1',"Unit of Measure Code"); //MSKS1201
                    SalesPrice.SETRANGE(SalesPrice."Starting Date", 0D, WORKDATE); //-- 1. Tri PG 13112006
                END;
                SalesPrice.FIND('+');
                IF SalesH."Order Date" >= WORKDATE THEN BEGIN
                    SETRANGE("Starting Date", SalesPrice."Starting Date", SalesH."Order Date"); //rahul
                END ELSE
                    SETRANGE("Starting Date", 0D, SalesPrice."Starting Date"); //rahul
            END;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnAfterFindSalesPrice', '', false, false)]//COD 7000
    local procedure OnAfterFindSalesPrice(var ToSalesPrice: Record "Sales Price"; var FromSalesPrice: Record "Sales Price"; QtyPerUOM: Decimal; Qty: Decimal; CustNo: Code[20]; ContNo: Code[20]; CustPriceGrCode: Code[10]; CampaignNo: Code[20]; ItemNo: Code[20]; VariantCode: Code[10]; UOM: Code[10]; CurrencyCode: Code[10]; StartingDate: Date; ShowAll: Boolean);
    begin
        WITH FromSalesPrice DO BEGIN
            SETRANGE("Item No.", ItemNo);
            //  SETFILTER("Variant Code",'%1|%2',VariantCode,'');     //TRI DG Comment  //TCPL-7632-250516
            SETFILTER("Ending Date", '%1|>=%2', 0D, StartingDate);
            IF UOM <> '' THEN
                SETFILTER("Unit of Measure Code", '%1', UOM); //MSKS1201 Duplicate
        end;
    end;

    /* [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnBeforeCopySalesPriceToSalesPrice', '', false, false)]//COD 7000
    local procedure OnBeforeCopySalesPriceToSalesPrice(var FromSalesPrice: Record "Sales Price"; var ToSalesPrice: Record "Sales Price"; var IsHandled: Boolean);
    begin
        WITH ToSalesPrice DO BEGIN
            IF FromSalesPrice.FINDLAST THEN
                //   REPEAT           //TRI SR 220410 Del
                IF FromSalesPrice."Unit Price" <> 0 THEN BEGIN
                    ToSalesPrice := FromSalesPrice;
                    INSERT;
                END;
            //    UNTIL FromSalesPrice.NEXT = 0;   //TRI SR 220410 Del
        END;
    end; */

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnAfterGetSalesLinePrice', '', false, false)]// COD 7000
    local procedure OnAfterGetSalesLinePrice(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var TempSalesPrice: Record "Sales Price");
    var
        MS00001: Label 'The Customer Price Group Must Be Blank. ';
    begin
        //MSBS.Rao Begin Dt. 16-04-13
        IF SalesLine."Customer Price Group" <> '' THEN
            IF TempSalesPrice."Sales Type" = TempSalesPrice."Sales Type"::Customer THEN
                ERROR(MS00001);
        //MSBS.Rao End Dt. 16-04-13
        // VALIDATE("Unit Price",TempSalesPrice."Unit Price"); //code unblocked as in previous version

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", 'OnBeforeFlushProdOrder', '', false, false)]//COD 5407
    local procedure OnBeforeFlushProdOrder(var ProductionOrder: Record "Production Order"; NewStatus: Enum "Production Order Status"; PostingDate: Date; var IsHandled: Boolean);
    var
        ItemJnlLine: Record "Item Journal Line";
    begin
        IF ProductionOrder."Original Prod. No" <> '' THEN
            PostingDate := ProductionOrder."Due Date";
        ItemJnlLine.VALIDATE(ItemJnlLine."Shortcut Dimension 1 Code", ProductionOrder."Shortcut Dimension 1 Code");  //TRI DG 030910

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", 'OnFlushProdOrderProcessProdOrderRtngLineOnAfterCalcOutputQty', '', false, false)]
    local procedure OnFlushProdOrderProcessProdOrderRtngLineOnAfterCalcOutputQty(ProdOrderLine: Record "Prod. Order Line"; ProdOrderRoutingLine: Record "Prod. Order Routing Line"; var OutputQty: Decimal; var OutputQtyBase: Decimal);
    var
        ItemJnlLine: Record "Item Journal Line";
    begin
        ItemJnlLine."Work Shift Code" := ProdOrderLine."Work Shift Code";//TRI S.R
        ItemJnlLine."Production Plant Code" := ProdOrderLine."Production Plant Code";//TRI S.R
        ItemJnlLine.VALIDATE(ItemJnlLine."Shortcut Dimension 1 Code", ProdOrderLine."Shortcut Dimension 1 Code");  //TRI DG 030910
                                                                                                                   // ItemJnlLine.VALIDATE(ItemJnlLine."Shortcut Dimension 1 Code", ProductionOrder."Shortcut Dimension 1 Code");  //TRI DG 030910
        ItemJnlLine.VALIDATE(ItemJnlLine."Shortcut Dimension 1 Code", ProdOrderLine."Shortcut Dimension 1 Code");  //TRI DG 030910
        ItemJnlLine."Work Shift Code" := ProdOrderLine."Work Shift Code";//TRI S.R
        ItemJnlLine."Production Plant Code" := ProdOrderLine."Production Plant Code";//TRI S.R
        ItemJnlLine.VALIDATE(ItemJnlLine."Shortcut Dimension 1 Code", ProdOrderLine."Shortcut Dimension 1 Code");  //TRI DG 030910

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", 'OnAfterCalculateQtyToPost', '', false, false)]//COD 5407
    local procedure OnAfterCalculateQtyToPost(ProdOrderComponent: Record "Prod. Order Component"; var QtyToPost: Decimal; ProdOrder: Record "Production Order"; NewStatus: Enum "Production Order Status");
    var
        Window: Dialog;
        LineCount: Integer;
        NoOfRecords: Integer;
    begin
        IF ProdOrder."Original Prod. No" = '' THEN//TRI S.R
                                                 BEGIN //TRI S.R

            Window.UPDATE(1, LineCount);
            Window.UPDATE(2, ROUND(LineCount / NoOfRecords * 10000, 1));
        END;//TRI S.R
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", 'OnFlushProdOrderOnBeforeCopyItemTracking', '', false, false)]// COD 5407
    local procedure OnFlushProdOrderOnBeforeCopyItemTracking(var ItemJournalLine: Record "Item Journal Line"; ProdOrderComponent: Record "Prod. Order Component"; Item: Record Item);
    var
        ProdOrderLine: Record "Prod. Order Line";
        Window: Dialog;
        ProdOrder: Record "Production Order";
    begin

        ItemJournalLine.VALIDATE(ItemJournalLine."Shortcut Dimension 1 Code", ProdOrderLine."Shortcut Dimension 1 Code");  //TRI DG 030910
        ItemJournalLine."Work Shift Code" := ProdOrderLine."Work Shift Code";//TRI S.R
        ItemJournalLine."Production Plant Code" := ProdOrderLine."Production Plant Code";//TRI S.R
        ItemJournalLine.VALIDATE(ItemJournalLine."Shortcut Dimension 1 Code", ProdOrderLine."Shortcut Dimension 1 Code");  //TRI DG 030910
                                                                                                                           //IF ProdOrder."Original Prod. No" = '' THEN//TRI S.R
                                                                                                                           //Window.CLOSE;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", 'OnFlushProdOrderOnAfterPostFlushItemJnlLine', '', false, false)]// COD 5407
    local procedure OnFlushProdOrderOnAfterPostFlushItemJnlLine(var ItemJnlLine: Record "Item Journal Line");
    var
        ProdOrderLine: Record "Prod. Order Line";
        Window: Dialog;
        ProdOrder: Record "Production Order";
    begin
        ItemJnlLine.VALIDATE(ItemJnlLine."Shortcut Dimension 1 Code", ProdOrderLine."Shortcut Dimension 1 Code");  //TRI DG 030910
        ItemJnlLine."Work Shift Code" := ProdOrderLine."Work Shift Code";//TRI S.R
        ItemJnlLine."Production Plant Code" := ProdOrderLine."Production Plant Code";//TRI S.R
        ItemJnlLine.VALIDATE(ItemJnlLine."Shortcut Dimension 1 Code", ProdOrderLine."Shortcut Dimension 1 Code");  //TRI DG 030910
                                                                                                                   // IF ProdOrder."Original Prod. No" = '' THEN//TRI S.R
                                                                                                                   //   Window.CLOSE;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeTransferOrderPostReceipt', '', false, false)]
    local procedure OnBeforeTransferOrderPostReceipt(var Sender: Codeunit "TransferOrder-Post Receipt"; var TransferHeader: Record "Transfer Header"; var CommitIsSuppressed: Boolean; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line");
    var
        UserSetupManagement: Codeunit "User Setup Management";
        Text000: Label 'Transfer order %2 cannot be posted because %3 and %4 are the same.';
    begin
        CheckUserPostingRights(31, TransferHeader."Transfer-to Code"); //MSKS// 5740
        IF not (UPPERCASE(USERID) IN ['ADMIN', 'OBLTILES\C', 'OBLTILES\D', 'OBLTILES\E', 'OBLTILES\F', 'OBLTILES\G', 'OBLTILES\N']) THEN
            ERROR(Text000, TransferHeader."No.", TransferHeader.FIELDCAPTION("Transfer-from Code"), TransferHeader.FIELDCAPTION("Transfer-to Code"));
    end;

    procedure CheckUserPostingRights(TransactionType: Integer; LocationCode: Code[20])
    var
        RecUserLocations: Record "User Location";
    begin
        CASE TransactionType OF
            30: //Transfer Shipment
                BEGIN
                    RecUserLocations.RESET;
                    RecUserLocations.SETRANGE("User ID", UPPERCASE(USERID));
                    RecUserLocations.SETFILTER("Transfer Shipment", '%1', TRUE);
                    RecUserLocations.SETFILTER("Location Code", '%1', LocationCode);
                    IF NOT RecUserLocations.FINDFIRST THEN BEGIN
                        ERROR('You do not have Permission to Ship The Material for Location %1', LocationCode);
                    END;
                END;
            31: //Transfer Reciept
                BEGIN
                    RecUserLocations.RESET;
                    RecUserLocations.SETRANGE("User ID", UPPERCASE(USERID));
                    RecUserLocations.SETFILTER(RecUserLocations."Transfer Reciept", '%1', TRUE);
                    RecUserLocations.SETFILTER(RecUserLocations."Location Code", '%1', LocationCode);
                    IF NOT RecUserLocations.FINDFIRST THEN BEGIN
                        ERROR('You do not have Permission to Receive The Material for Location %1', LocationCode);
                    END;
                END;
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post (Yes/No)", 'OnBeforePost', '', false, false)]// 5706
    local procedure OnBeforePost(var TransHeader: Record "Transfer Header"; var IsHandled: Boolean);
    var
        EndUserItemExist: Boolean;
        TranLine2: Record "Transfer Line";
        PostDate: Date;
        TransLine: Record "Transfer Line";
        TranLine: Record "Transfer Line";
    begin
        WITH TransHeader DO BEGIN
            TESTFIELD(Status, Status::Released);
            EndUserItemExist := FALSE;
            TranLine2.SETRANGE("Document No.", "No.");
            IF TranLine2.FIND('-') THEN BEGIN
                EndUserItemExist := TranLine2."End Use Item";
                REPEAT
                    TranLine2.CheckMfgBatchNo(TranLine2); //MSKS
                    IF TranLine2."End Use Item" <> EndUserItemExist THEN
                        ERROR('Please Check all Item Should be End user Item');
                UNTIL TranLine2.NEXT = 0;
            END;
            PostDate := TransHeader."Posting Date";
            TransLine.SETRANGE("Document No.", "No.");
            IF TransLine.FIND('-') THEN
                TranLine := TransLine;
        end;
    end;




    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeTransRcptHeaderInsert', '', false, false)]// 5706
    local procedure OnBeforeTransRcptHeaderInsert(var TransferReceiptHeader: Record "Transfer Receipt Header"; TransferHeader: Record "Transfer Header")
    begin
        TransferReceiptHeader."Vendor No." := TransferHeader."Vendor No.";
        TransferReceiptHeader.Pay := TransferHeader.Pay; //TRI A.S 07.11.08 Code Added
        TransferReceiptHeader."Location Comment" := TransferHeader."Location Comment"; //TRI A.S 31.12.08
                                                                                       //Team 7739 Upgrade 010616 Start-
                                                                                       //MS-AN 08/01/13 - BEGIN
        TransferReceiptHeader.Purpose := TransferHeader.Purpose;
        //MS-AN 08/01/13 - END
        //ND Tri1.0 Start
        TransferReceiptHeader."Insurance Amount" := TransferHeader."Insurance Amount";
        TransferReceiptHeader."Transfer-from State" := TransferHeader."Transfer-from State";
        TransferReceiptHeader."Transfer-to State" := TransferHeader."Transfer-to State";
        TransferReceiptHeader."External Transfer" := TransferHeader."External Transfer"; //ND
        TransferReceiptHeader.ReProcess := TransferHeader.ReProcess; //TRI S.C
        TransferReceiptHeader."OutPut Date" := TransferHeader."OutPut Date";   //TRI S.K 21.06.10
                                                                               //ND Tri1.0 End
                                                                               //report 54 - S2 start ravi

        //TEAM 14763 TransferReceiptHeader."Form Code" := TransferHeader."Form Code"; Field has been removed
        //TEAM 14763 TransferReceiptHeader."Form No." := TransferHeader."Form No."; Field has been removed

        TransferReceiptHeader."Transporter's Name" := TransferHeader."Transporter's Name";
        TransferReceiptHeader."GR No." := TransferHeader."GR No.";
        TransferReceiptHeader."GR Date" := TransferHeader."GR Date";
        TransferReceiptHeader."Truck No." := TransferHeader."Truck No.";
        //report 54 - S2 end ravi
        //mo tri1.0 start
        TransferReceiptHeader."SalesPerson Code" := TransferHeader."SalesPerson Code";
        //mo tri1.0 end
        //TRI N.K. 22.02.08 START
        TransferReceiptHeader."Group Code" := TransferHeader."Group Code";
        //TRI N.K. 22.02.08 STOP
        //Vipul Tri1.0 satrt
        TransferReceiptHeader."Releasing Date" := TransferHeader."Releasing Date";
        TransferReceiptHeader."Releasing Time" := TransferHeader."Releasing Time";
        //Vipul Tri1.0 end
        //Vipul Tri1.0 satrt Report 113 N-10A
        TransferReceiptHeader."Loading Inspector" := TransferHeader."Loading Inspector";
        //Vipul Tri1.0 End Report 113 N-10A
        //Team 7739 Upgrade 010616 END-

        //Team 7739 Upgrade 010616 Start-
        IF TransferHeader."Receiving No." <> '' THEN
            TransferReceiptHeader."No." := TransferHeader."Receiving No.";
        //Team 7739 Upgrade 010616 End-
        TransferReceiptHeader."Shortage TO" := TransferHeader."Shortage TO"; //TRI-VKG ADD 23.09.10  //Team 7739 Upgrade 010616
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeInsertTransRcptLine', '', false, false)]// 5706
    local procedure OnBeforeInsertTransRcptLine(var TransRcptLine: Record "Transfer Receipt Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; TransferReceiptHeader: Record "Transfer Receipt Header")
    var
        TransferShipHeader: Record "Transfer Shipment Header";
        ShortHeader: Record "Transfer Header";
        ShortReceiptLine: Record "Transfer Receipt Line";
    begin
        TransRcptLine."Short Quantity" := TransLine."Short Quantity";   //Team 7739 Upgrade 010616
        TransRcptLine."Reason Code" := TransLine."Reason Code";         //Team 7739 Upgrade 010616


        //Team 7739 Upgrade 010616 Start-
        TransRcptLine."Plant Code" := TransLine."Plant Code";//mo Tri1.0
        //TransRcptLine."Assessable Value" := TransLine."Assessable Value"; //ND Tri1.0
        TransRcptLine."Size Code" := TransLine."Size Code";  //ND Tri1.0
        TransRcptLine."Posting Date" := TransLine."Posting Date";  //ND Tri1.0
        TransRcptLine."Plant Code" := TransLine."Plant Code"; //ND tri1.0
        TransRcptLine."Type Code" := TransLine."Type Code"; //ND tri1.0
        TransRcptLine."Color Code" := TransLine."Color Code"; //ND tri1.0
        TransRcptLine."Quality Code" := TransLine."Quality Code"; //ND tri1.0
        TransRcptLine."Packing Code" := TransLine."Packing Code"; //ND tri1.0
        TransRcptLine."Design Code" := TransLine."Design Code"; //ND tri1.0
        TransRcptLine."External Transfer" := TransLine."External Transfer";   //TRI DG 010510
        TransRcptLine.ReProcess := TransLine.ReProcess;  //TRI SC
        TransRcptLine."Issue to Machine" := TransLine."Issue to Machine";
        TransRcptLine."Shelf No." := TransLine."Shelf No.";
        TransRcptLine."Capex No." := TransLine."Capex No.";
        TransRcptLine."Mfg. Batch No." := TransLine."Mfg. Batch No."; //MSKS
                                                                      // NAVIN
                                                                      //TRI-VKG START 23.09.10
        TransRcptLine."Customer Price Group" := TransLine."Customer Price Group";
        TransRcptLine."Shoratge Transfer Rcpt No." := TransLine."Shoratge Transfer Rcpt No.";
        TransferShipHeader.RESET;
        TransferShipHeader.SETRANGE("Transfer Order No.", TransLine."Document No.");
        IF TransferShipHeader.FINDLAST THEN BEGIN
            TransRcptLine."Transfer Shipment No." := TransferShipHeader."No.";
            TransRcptLine."Transfer Shipment Date" := TransferShipHeader."Posting Date";
        END;
        //TRI-VKG END 23.09.10
        //TRI N.K. 22.02.08 START
        TransRcptLine."Group Code" := TransLine."Group Code";
        //TRI N.K. 22.02.08 STOP
        //TRI-VKG START 23.09.10
        ShortHeader.GET(TransLine."Document No.");
        IF ShortHeader."Shortage TO" THEN BEGIN
            ShortReceiptLine.RESET;
            ShortReceiptLine.SETRANGE("Document No.", TransLine."Shoratge Transfer Rcpt No.");
            ShortReceiptLine.SETRANGE("Item No.", TransLine."Item No.");
            IF ShortReceiptLine.FINDFIRST THEN BEGIN
                ShortReceiptLine."Shoratge Quantity Shipped" := TRUE;
                ShortReceiptLine.MODIFY;
            END;
        END;
        //TRI-VKG END 23.09.10
        //Team 7739 Upgrade 010616 End-
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnCheckTransLine', '', false, false)]// 5706
    local procedure OnCheckTransLine(TransferLine: Record "Transfer Line"; TransferHeader: Record "Transfer Header"; Location: Record Location; WhseReceive: Boolean)
    var
        TransferOrderPostYesNo: Codeunit TransferOrderPostYesNo;
        RecLocation: Record Location;
        ItemJnlLine: Record "Item Journal Line";
    begin
        /*
        IF TransferLine."End Use Item" THEN BEGIN
            //CLEAR(TransferOrderPostYesNo);
            //TransferOrderPostYesNo.PostConsumption(TransferLine);
            //PostCons := TRUE;

            //IF PostCons THEN
            IF RecLocation.GET(TransferLine."Transfer-to Code") THEN BEGIN
                //ItemJnlLine.RESET;
                ItemJnlLine.SETRANGE("Journal Template Name", RecLocation."End Use Item Issue Template");
                ItemJnlLine.SETRANGE("Journal Batch Name", RecLocation."End Use Item Issue Batch");
                IF ItemJnlLine.FINDFIRST THEN
                    CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Batch", ItemJnlLine);//MSAK020315
                                                                                //UNTIL ItemJnlLine.NEXT =0;
            END;
        end;
        */
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnRunOnBeforeUpdateWithWarehouseShipReceive', '', false, false)]// 5706
    local procedure OnRunOnBeforeUpdateWithWarehouseShipReceive(var TransferLine: Record "Transfer Line")
    var
        TransferOrderPostYesNo: Codeunit TransferOrderPostYesNo;
    begin
        IF TransferLine."End Use Item" THEN BEGIN
            CLEAR(TransferOrderPostYesNo);
            TransferOrderPostYesNo.PostConsumption(TransferLine);
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnRunOnAfterInsertTransRcptLines', '', false, false)]
    local procedure OnRunOnAfterInsertTransRcptLines(TransRcptHeader: Record "Transfer Receipt Header"; TransferLine: Record "Transfer Line"; TransferHeader: Record "Transfer Header"; Location: Record Location; WhseReceive: Boolean)
    var
        TrcptLine: Record "Transfer Receipt Line";
    begin
        Clear(TrcptLine);
        TrcptLine.RESET;
        TrcptLine.SetRange("Document No.", TransRcptHeader."No.");
        IF TrcptLine.FindSet THEN BEGIN
            REPEAT
                CreateAssemblyOrderandPost(TrcptLine);
                CreateSampleAssemblyOrderandPost(TrcptLine);
            UNTIL TrcptLine.NEXT = 0;
        END;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforePostItemJournalLine', '', false, false)]// 5706
    local procedure OnBeforePostItemJournalLine(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferReceiptHeader: Record "Transfer Receipt Header"; TransferReceiptLine: Record "Transfer Receipt Line"; CommitIsSuppressed: Boolean; TransLine: Record "Transfer Line"; PostedWhseRcptHeader: Record "Posted Whse. Receipt Header")
    var
        RecLoc: Record Location;
        TransHeader: Record "Transfer Header";
    begin
        ItemJournalLine."End Use Item" := TransferLine."End Use Item"; //Team 7739 Upgrade 010616
                                                                       //Team 7739 Upgrade 010616 Start-
                                                                       //ItemJnlLine."New Location Code" := TransRcptHeader2."Transfer-to Code"; //MSKS2807
        ItemJournalLine."New Location Code" := TransferReceiptLine."Transfer-to Code";
        //Team 7739 Upgrade 010616 End-

        //Team 7739 Upgrade 010616 Start-
        TransHeader.Reset;
        TransHeader.SetRange("No.", TransferLine."Document No.");
        if TransHeader.FindFirst then begin
            IF RecLoc.GET(TransHeader."In-Transit Code") THEN BEGIN
                //MSKS2006
                RecLoc.TESTFIELD("Gen. Bus. Posting Group");
                ItemJournalLine."Gen. Bus. Posting Group" := RecLoc."Gen. Bus. Posting Group";
            END;
        end;
        //Team 7739 Upgrade 010616 Start-
        ItemJournalLine.ReProcess := TransferReceiptLine.ReProcess;//TRI S.C
        ItemJournalLine."OutPut Date" := TransferReceiptHeader."OutPut Date";  //TRI S.K 21.06.10
                                                                               //Team 7739 Upgrade 010616 End-
                                                                               //Team 7739 Upgrade 010616 End-
    end;

    local procedure CreateSampleAssemblyOrderandPost(VAR TrfRecptLine: Record "Transfer Receipt Line")
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        Item: Record Item;
        AssemblySetup: Record "Assembly Setup";
        AssemblyPost: Codeunit "Assembly-Post";
        Location: Record Location;
        SampleItem: Code[20];
        RecTransferRecptHeader: Record "Transfer Receipt Header";
    begin
        Clear(RecTransferRecptHeader);
        RecTransferRecptHeader.Reset;
        RecTransferRecptHeader.Get(TrfRecptLine."Document No.");

        IF Item.GET(TrfRecptLine."Item No.") THEN
            IF Item."Sample Code" = '' THEN
                EXIT;
        SampleItem := Item."Sample Code";
        //MESSAGE(SampleItem);
        IF TrfRecptLine.Quantity = 0 THEN
            EXIT;
        Location.GET(TrfRecptLine."Transfer-to Code");
        IF NOT (Location.Code IN ['DRA-SAMPLE', 'SKD-SAMPLE', 'HSK-SAMPLE', 'MOR-SAMPLE']) THEN
            EXIT;
        AssemblySetup.GET;
        AssemblySetup.TESTFIELD("Assembly Order Nos.");

        AssemblyHeader.RESET;
        AssemblyHeader.INIT;
        AssemblyHeader."Document Type" := AssemblyHeader."Document Type"::Order;
        AssemblyHeader."No." := '';
        AssemblyHeader.VALIDATE("Posting Date", TrfRecptLine."Posting Date");
        AssemblyHeader."Due Date" := TrfRecptLine."Posting Date";
        AssemblyHeader.VALIDATE("Item No.", SampleItem);
        AssemblyHeader.VALIDATE(Quantity, TrfRecptLine.Quantity * GetPackingSize(Item."Packing Code"));
        AssemblyHeader.VALIDATE("Location Code", TrfRecptLine."Transfer-to Code");

        //AssemblyHeader.Validate("Shortcut Dimension 1 Code", RecTransferRecptHeader."Transfer-from Code"); //TEAM 14763

        AssemblyHeader."Transfer Order No." := TrfRecptLine."Transfer Order No.";
        AssemblyHeader."Transfer Shipment No." := TrfRecptLine."Document No.";
        AssemblyHeader."Transfer Shipment Line No." := TrfRecptLine."Line No.";
        AssemblyHeader."Posting No." := AssemblyHeader."No.";
        AssemblyHeader.INSERT(TRUE);
        AssemblyHeader."Posting No." := AssemblyHeader."No.";
        AssemblyHeader.MODIFY;

        AssemblyLine.INIT;
        AssemblyLine.Type := AssemblyLine.Type::Item;
        AssemblyLine."Document Type" := AssemblyHeader."Document Type"::Order;
        AssemblyLine."Document No." := AssemblyHeader."No.";
        AssemblyLine."Line No." := TrfRecptLine."Line No.";

        AssemblyLine.VALIDATE("No.", TrfRecptLine."Item No.");
        AssemblyLine.VALIDATE("Unit of Measure Code", TrfRecptLine."Unit of Measure Code");
        AssemblyLine.VALIDATE(Quantity, TrfRecptLine.Quantity);

        AssemblyLine.VALIDATE("Qty. per Unit of Measure", TrfRecptLine."Qty. per Unit of Measure");
        AssemblyLine.VALIDATE("Location Code", TrfRecptLine."Transfer-to Code");
        AssemblyLine.VALIDATE("Quantity to Consume", TrfRecptLine.Quantity);
        AssemblyLine."Transfer Order No." := TrfRecptLine."Transfer Order No.";
        AssemblyLine."Transfer Shipment No." := TrfRecptLine."Document No.";
        AssemblyLine."Transfer Shipment Line No." := TrfRecptLine."Line No.";
        AssemblyLine.INSERT(TRUE);

        AssemblyPost.RUN(AssemblyHeader);
    end;

    local procedure GetPackingSize(PackCode: Code[10]): Decimal
    var
        DimensionValue: Record "Dimension Value";
    begin
        DimensionValue.RESET;
        DimensionValue.SETFILTER("Dimension Code", '%1', 'PACKING');
        DimensionValue.SETFILTER(Code, '%1', PackCode);
        IF DimensionValue.FINDFIRST THEN
            EXIT(DimensionValue.Value) ELSE
            EXIT(1);
    end;

    local procedure CreateAssemblyOrderandPost(VAR TrfRecptLine: Record "Transfer Receipt Line")
    var
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        Item: Record Item;
        AssemblySetup: Record "Assembly Setup";
        AssemblyPost: Codeunit "Assembly-Post";
        Location: Record Location;
        RecTransferReceiptHeader: Record "Transfer Receipt Header";
    begin
        Clear(RecTransferReceiptHeader);
        RecTransferReceiptHeader.Reset;
        RecTransferReceiptHeader.Get(TrfRecptLine."Document No.");

        Item.GET(TrfRecptLine."Item No.");
        IF Item."Prod. Consumption Item" = '' THEN
            EXIT;
        IF TrfRecptLine.Quantity = 0 THEN
            EXIT;
        Location.GET(TrfRecptLine."Transfer-to Code");
        IF Location."Prod. Units" = Location."Prod. Units"::" " THEN
            EXIT;
        AssemblySetup.GET;
        AssemblySetup.TESTFIELD("Assembly Order Nos.");

        AssemblyHeader.RESET;
        AssemblyHeader.INIT;
        AssemblyHeader."Document Type" := AssemblyHeader."Document Type"::Order;
        AssemblyHeader."No." := '';
        AssemblyHeader.VALIDATE("Posting Date", RecTransferReceiptHeader."Posting Date");
        AssemblyHeader."Due Date" := RecTransferReceiptHeader."Posting Date";

        //TEAM 14763 AssemblyHeader.VALIDATE("Posting Date", TrfRecptLine."Posting Date");
        //TEAM 14763 AssemblyHeader."Due Date" := TrfRecptLine."Posting Date";

        AssemblyHeader.VALIDATE("Item No.", Item."Prod. Consumption Item");
        AssemblyHeader.VALIDATE(Quantity, TrfRecptLine.Quantity);
        AssemblyHeader.VALIDATE("Location Code", TrfRecptLine."Transfer-to Code");

        //AssemblyHeader.Validate("Shortcut Dimension 1 Code", RecTransferReceiptHeader."Transfer-from Code"); //TEAM 14763

        AssemblyHeader."Transfer Order No." := TrfRecptLine."Transfer Order No.";
        AssemblyHeader."Transfer Shipment No." := TrfRecptLine."Document No.";
        AssemblyHeader."Transfer Shipment Line No." := TrfRecptLine."Line No.";
        AssemblyHeader."Posting No." := AssemblyHeader."No.";
        AssemblyHeader.INSERT(TRUE);
        AssemblyHeader."Posting No." := AssemblyHeader."No.";
        AssemblyHeader.MODIFY;

        AssemblyLine.INIT;
        AssemblyLine.Type := AssemblyLine.Type::Item;
        AssemblyLine."Document Type" := AssemblyHeader."Document Type"::Order;
        AssemblyLine."Document No." := AssemblyHeader."No.";
        AssemblyLine."Line No." := TrfRecptLine."Line No.";
        AssemblyLine.VALIDATE("Qty. per Unit of Measure", 1);
        AssemblyLine.VALIDATE("No.", TrfRecptLine."Item No.");
        AssemblyLine.VALIDATE(Quantity, TrfRecptLine.Quantity);
        AssemblyLine.VALIDATE("Location Code", TrfRecptLine."Transfer-to Code");
        AssemblyLine.VALIDATE("Quantity to Consume", TrfRecptLine.Quantity);
        AssemblyLine."Transfer Order No." := TrfRecptLine."Transfer Order No.";
        AssemblyLine."Transfer Shipment No." := TrfRecptLine."Document No.";
        AssemblyLine."Transfer Shipment Line No." := TrfRecptLine."Line No.";
        AssemblyLine.INSERT(TRUE);

        AssemblyPost.RUN(AssemblyHeader);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post (Yes/No)", 'OnCodeOnBeforePostTransferOrder', '', false, false)]// 5706
    local procedure OnCodeOnBeforePostTransferOrder(var TransHeader: Record "Transfer Header"; var DefaultNumber: Integer; var Selection: Option; var IsHandled: Boolean);
    var
        EndUserItemExist: Boolean;
        Text000: Label '&Ship,&Receive';
        Text001: Label '&Ship,&Receive,Ship &and Receive';
        TranLine2: Record "Transfer Line";
        TransferPostShipment: Codeunit "TransferOrder-Post Shipment";
        TransferPostReceipt: Codeunit "TransferOrder-Post Receipt";
        TransferOrder: Codeunit TransferOrderPostYesNo;
        TransferLine: Record "Transfer Line";
    begin
        EndUserItemExist := FALSE;

        TranLine2.SETRANGE("Document No.", TransHeader."No.");
        IF TranLine2.FIND('-') THEN BEGIN
            EndUserItemExist := TranLine2."End Use Item";
            REPEAT
                TranLine2.CheckMfgBatchNo(TranLine2); //MSKS
                IF TranLine2."End Use Item" <> EndUserItemExist THEN
                    ERROR('Please Check all Item Should be End user Item');
            UNTIL TranLine2.NEXT = 0;
        END;

        IF TransHeader."Transfer-to Code" = 'WAREHOUSE' THEN //TRI S.K. 22.06.2010
            TransHeader.TESTFIELD(TransHeader."OutPut Date");
        /*
                IF (NOT EndUserItemExist) THEN
                    Selection := STRMENU(Text000, DefaultNumber)
                ELSE
                    Selection := STRMENU(Text001, DefaultNumber);

                CASE Selection OF
                    0:
                        EXIT;
                    1:
                        begin
                      //      TransferPostShipment.RUN(TransHeader);
                        end;
                    2:
                        begin
                            //IF TransHeader."No. Series" = 'ISSUESLIP' THEN
                            //    TransHeader.TESTFIELD("Posting Date", TODAY); //MSAK020315 Kulbhushan
                        //    TransferPostReceipt.RUN(TransHeader);
                        end;
                    3:
                        BEGIN
                          //  TransferPostShipment.RUN(TransHeader);
                          //  TransferPostReceipt.RUN(TransHeader);
                        END;
                END;

                IsHandled := true;
            */
    end;
    /* 
        [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterTransferOrderPostShipment', '', false, false)]// 5706
        local procedure OnAfterTransferOrderPostShipment(var TransferHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean; var TransferShipmentHeader: Record "Transfer Shipment Header"; InvtPickPutaway: Boolean)
        var
            tgText001: Label 'Transfer Order No. %1 successfully posted.';
        begin
            MESSAGE(tgText001, TransferHeader."No.");
        end; */


    /*    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnCheckAvailabilityOnBeforeSalesLineInitOutstanding', '', false, false)]
       local procedure OnCheckAvailabilityOnBeforeSalesLineInitOutstanding(var SalesLine: Record "Sales Line"; BlanketOrderSalesLine: Record "Sales Line");
       var
           IsValid: Boolean;
       begin
           IF SalesLine."Qty. to Ship" > 0 THEN BEGIN
               IsValid := TRUE;  //Team 7739 Upgrade
               SalesLine.Quantity := SalesLine."Qty. to Ship";
               SalesLine."Quantity (Base)" := SalesLine."Qty. to Ship (Base)";  //Team 7739 Upgrade
                                                                                //Team 7739 Upgrade Start-
               IF NOT IsValid THEN
                   EXIT;
               //Team 7739 Upgrade End-

           end;
       end;
    */



}