codeunit 50109 "Extend90"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchRcptHeaderInsert', '', false, false)]
    local procedure OnBeforePurchRcptHeaderInsert(var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; WhseReceive: Boolean; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; WhseShip: Boolean);
    begin
        PurchRcptHeader."User ID" := USERID;
        PurchRcptHeader."Actual MRN Date" := TODAY;
        PurchRcptHeader."Vendor Invoice No." := PurchaseHeader."Vendor Invoice No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeReturnShptHeaderInsert', '', false, false)]
    local procedure OnBeforeReturnShptHeaderInsert(var ReturnShptHeader: Record "Return Shipment Header"; var PurchHeader: Record "Purchase Header"; CommitIsSupressed: Boolean; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; WhseReceive: Boolean; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; WhseShip: Boolean);
    begin
        ReturnShptHeader."Vendor Invoice No." := PurchHeader."Vendor Invoice No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchCrMemoHeaderInsert', '', false, false)]
    local procedure OnBeforePurchCrMemoHeaderInsert(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchHeader: Record "Purchase Header"; CommitIsSupressed: Boolean);
    begin
        PurchCrMemoHdr."Vendor Invoice No." := PurchHeader."Vendor Invoice No."; //MSKS090216
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnRunOnAfterPostInvoice', '', false, false)]
    local procedure OnRunOnAfterPostInvoice(var PurchaseHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var ReturnShipmentHeader: Record "Return Shipment Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PreviewMode: Boolean; var Window: Dialog; SrcCode: Code[10]; GenJnlLineDocType: Enum "Gen. Journal Document Type"; GenJnlLineDocNo: Code[20]; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line");
    var
        AssociateVendorMgt: Codeunit 50054;
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        PurchRcptLine.Reset();
        PurchRcptLine.SetRange("Document No.", PurchRcptHeader."No.");
        if PurchRcptLine.FindFirst() then
            AssociateVendorMgt.GenerateItemLedgerEntries(PurchRcptLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure OnBeforePostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; CommitIsSupressed: Boolean; var HideProgressWindow: Boolean; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line")
    var
        C: Codeunit 90;
    begin
        IF ((PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Return Order") OR (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo")) AND (PurchaseHeader.Trading)
        THEN
            PurchaseHeader.TESTFIELD("Applies-to Doc. No.");
        PurchaseHeader.TESTFIELD("Document Type");
        PurchaseHeader.TESTFIELD("Buy-from Vendor No.");
        PurchaseHeader.TESTFIELD("Pay-to Vendor No.");
        PurchaseHeader.TESTFIELD("Posting Date");
        PurchaseHeader.TESTFIELD("Document Date");
        //Upgrade
        //Upgrade(+)
        //TRI DG 010510 Add start
        IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice THEN BEGIN
            PurchaseHeader.TESTFIELD("Vendor Invoice No.");
            PurchaseHeader.TESTFIELD("Vendor Invoice Date");
        END;


        PurchaseHeader.TESTFIELD("Location Code");
        PurchaseHeader.TESTFIELD("Shortcut Dimension 1 Code");


    end;


    [EventSubscriber(ObjectType::Codeunit, 90, 'OnInsertReceiptLineOnAfterInitPurchRcptLine', '', false, false)]
    local procedure OnInsertReceiptLineOnAfterInitPurchRcptLine(var PurchRcptLine: Record "Purch. Rcpt. Line"; PurchLine: Record "Purchase Line"; ItemLedgShptEntryNo: Integer; xPurchLine: Record "Purchase Line"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var CostBaseAmount: Decimal; PostedWhseRcptHeader: Record "Posted Whse. Receipt Header"; WhseRcptHeader: Record "Warehouse Receipt Header"; var WhseRcptLine: Record "Warehouse Receipt Line")
    var
        PurchHeader: Record 38;

    begin

        PurchHeader.Reset();
        PurchHeader.SetRange("No.", PurchLine."Document No.");
        if PurchHeader.FindFirst() then;

        CheckReturnOrdertoCreate(PurchHeader, PurchLine, PurchRcptLine, PurchRcptHeader);// Return Order closed Kulbhushan

        //    Error('Not Done 1');

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchaseDoc', '', false, false)]
    local procedure OnAfterPostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20]; CommitIsSupressed: Boolean);
    var
        PurchHeaderL: Record "Purchase Header";
        ReturnOrderNoL: Code[20];
    begin
        /*  PurchHeaderL.get(PurchaseHeader."Document Type", PurchaseHeader."No.");
         If PurchHeaderL."Return Order No" <> '' then begin
         */
        SingleInstanceG.GetPurchaseCredit(ReturnOrderNoL);
        SingleInstanceG.SetPurchaseCredit('');
        if ReturnOrderNoL <> '' then
            PostReturnOrder(PurchaseHeader, ReturnOrderNoL);
    end;//15578

    procedure CheckReturnOrdertoCreate(PurchHdr: Record 38; RecPurchLine1: Record 39; PurchRcptLine: record 121; var PurchRcptHeaderP: Record "Purch. Rcpt. Header")
    var
        RecPurchLine: Record 39;
        ReturnApplytoEntry: Integer;
    begin
        ReturnApplytoEntry := PurchRcptLine."Item Rcpt. Entry No.";

        //Team 7739 Upgrade 310516 Start--
        RecPurchLine.RESET;
        RecPurchLine.SETRANGE("Document Type", PurchHdr."Document Type"::Order);
        RecPurchLine.SETRANGE("Document No.", PurchHdr."No.");
        RecPurchLine.SETFILTER("Qty. to Receive (Base)", '>%1', 0);
        RecPurchLine.SETFILTER("Diff Qty.", '>%1', 0);
        IF RecPurchLine.FINDFIRST THEN BEGIN
            //MESSAGE('%1  %2',RecPurchLine1."Diff Qty."*RecPurchLine1."Unit Cost");
            CreateReturnOrder(PurchHdr, RecPurchLine1, ReturnApplytoEntry, PurchRcptHeaderP);
        END;
        //Team 7739 Upgrade 310516 End--
    end;

    procedure CreateReturnOrder(RecPurchHeader: Record 38; RecPurchLine: Record 39; ApplytoEntry: Integer; var PurchRcptHeaderP: Record "Purch. Rcpt. Header")
    var
        PURCHHEADERR: Record 38;
        PLINE: Record 39;
        PURCHLINETAB: Record 39;
        PurchPaySetup: Record 312;
        LineNo: Integer;
        ReturnHeaderCreated: Boolean;
        ReturnHeader: Record 38;

    begin
        //Team 7739 Upgrade 310516 Start--
        IF RecPurchHeader."Return Order No" = '' THEN BEGIN
            PurchPaySetup.GET;
            CLEAR(PURCHHEADERR);
            PURCHHEADERR.INIT;
            PURCHHEADERR.TRANSFERFIELDS(RecPurchHeader);
            PURCHHEADERR."Document Type" := PURCHHEADERR."Document Type"::"Return Order";
            PURCHHEADERR."No." := '';

            PURCHHEADERR."Auto Create Return Order" := TRUE;
            PURCHHEADERR."Pmt. Discount Date" := 0D;
            PURCHHEADERR.Status := PURCHHEADERR.Status::Open;
            PURCHHEADERR."Return Ref. Order No." := RecPurchHeader."No.";
            PURCHHEADERR."GST Reason Type" := PURCHHEADERR."GST Reason Type"::"Deficiency in Service";
            PURCHHEADERR."Reference Invoice No." := RecPurchHeader."No.";
            // PURCHHEADERR."Return Order No" := PURCHHEADERR."No.";
            PURCHHEADERR.INSERT(TRUE);
            PURCHHEADERR."Location Code" := RecPurchHeader."Location Code";
            RecPurchHeader."Return Order No" := PURCHHEADERR."No.";

            SingleInstanceG.SetPurchaseCredit(RecPurchHeader."Return Order No");
            RecPurchHeader.Modify(true);

            //CopyFromPurchDocDimToHeader(PURCHHEADERR,RecPurchHeader); Code commented due to dimension changes in the current version //Team 7739 Upgrade 310516
            //CopyFromPurchStrToHeader(ToPurchHeader,FromPurchHeader);
            ReturnHeaderCreated := TRUE;
            IF ReturnHeaderCreated THEN
                ReturnHeader.COPY(PURCHHEADERR);

            PLINE.RESET;
            PLINE.SETRANGE("Document Type", PLINE."Document Type"::Order);
            PLINE.SETRANGE("Document No.", RecPurchHeader."No.");
            IF PLINE.FIND('-') THEN BEGIN
                REPEAT
                    IF (PLINE."Diff Qty." > 0) AND (PLINE."Qty. to Receive" <> 0) THEN BEGIN
                        LineNo += 10000;
                        PURCHLINETAB.INIT;
                        PURCHLINETAB.TRANSFERFIELDS(PLINE);
                        PURCHLINETAB."Return Qty. Shipped Not Invd." := 0;
                        PURCHLINETAB."Document Type" := PURCHLINETAB."Document Type"::"Return Order";
                        PURCHLINETAB."Document No." := ReturnHeader."No.";
                        PURCHLINETAB."Line No." := PLINE."Line No.";
                        PURCHLINETAB."Line Amount" := PLINE."Diff Qty." * PLINE."Unit Cost";//6700
                        PURCHLINETAB.VALIDATE(Quantity, PLINE."Diff Qty.");
                        //PURCHLINETAB."TDS Nature of Deduction" := '';
                        PURCHLINETAB."Prepmt. Amt. Inv." := 0;
                        PURCHLINETAB."Prepayment Amount" := 0;
                        PURCHLINETAB."Prepmt. VAT Base Amt." := 0;
                        PURCHLINETAB."Prepmt Amt to Deduct" := 0;
                        PURCHLINETAB."Prepmt Amt Deducted" := 0;
                        PURCHLINETAB."Prepmt. Amount Inv. Incl. VAT" := 0;
                        PURCHLINETAB."Prepayment VAT Difference" := 0;
                        PURCHLINETAB."Prepmt VAT Diff. to Deduct" := 0;
                        PURCHLINETAB."Prepmt VAT Diff. Deducted" := 0;
                        PURCHLINETAB."Quantity Received" := 0;
                        PURCHLINETAB."Qty. Received (Base)" := 0;
                        PURCHLINETAB."Return Qty. Shipped" := 0;
                        PURCHLINETAB."Return Qty. Shipped (Base)" := 0;
                        PURCHLINETAB."Quantity Invoiced" := 0;
                        PURCHLINETAB."Qty. Invoiced (Base)" := 0;
                        PURCHLINETAB."Reserved Quantity" := 0;
                        PURCHLINETAB."Reserved Qty. (Base)" := 0;
                        PURCHLINETAB."Qty. Rcd. Not Invoiced" := 0;
                        PURCHLINETAB."Qty. Rcd. Not Invoiced (Base)" := 0;
                        PURCHLINETAB."Return Qty. Shipped Not Invd." := 0;
                        PURCHLINETAB."Ret. Qty. Shpd Not Invd.(Base)" := 0;
                        PURCHLINETAB."Qty. to Receive" := 0;
                        PURCHLINETAB."Qty. to Receive (Base)" := 0;
                        PURCHLINETAB."Return Qty. to Ship" := 0;
                        PURCHLINETAB."Return Qty. to Ship (Base)" := 0;
                        PURCHLINETAB."Qty. to Invoice" := 0;
                        PURCHLINETAB."Qty. to Invoice (Base)" := 0;
                        PURCHLINETAB."Amt. Rcd. Not Invoiced" := 0;
                        PURCHLINETAB."Amt. Rcd. Not Invoiced (LCY)" := 0;
                        PURCHLINETAB."Return Shpd. Not Invd." := 0;
                        PURCHLINETAB."Return Shpd. Not Invd. (LCY)" := 0;

                        PURCHLINETAB.InitOutstanding;

                        PURCHLINETAB.INSERT(TRUE);
                        PURCHLINETAB.VALIDATE("Qty. to Receive", 0);
                        PURCHLINETAB.VALIDATE("Return Qty. to Ship", PLINE."Diff Qty.");
                        PURCHLINETAB.VALIDATE("Qty. to Invoice", 0);
                        PURCHLINETAB.VALIDATE("Appl.-to Item Entry", ApplytoEntry);

                        //CopyFromPurchDocDimToLine(PURCHLINETAB,RecPurchLine); Code commented due to dimension changes in the current version //Team 7739 Upgrade 310516
                        // PURCHLINETAB.CalculateStructures(PURCHHEADERR);
                        //PURCHLINETAB.AdjustStructureAmounts(PURCHHEADERR);
                        //PURCHLINETAB.UpdatePurchLines(PURCHHEADERR);
                        PURCHLINETAB.MODIFY;
                        //ReturnApplytoEntry := 0;

                        ReverseIndentLines(PURCHLINETAB); //MSKS Indent
                    END;
                UNTIL PLINE.NEXT = 0;
            end;
        END;
        //PURCHHEADERR.VALIDATE(Structure);
        //PURCHHEADERR.Status:=PURCHHEADERR.Status::Released;
        //PURCHHEADERR.MODIFY;
        //PostReturnOrder(PURCHHEADERR);
        //Team 7739 Upgrade 310516 End--

    end;


    local procedure ReverseIndentLines(PurchLine: Record 39)
    var
        OrgIndentLine: Record 50017;
        IndentLine: Record 50017;
        IndentLineNo: Integer;
    begin
        IF (PurchLine."Indent No." = '') AND (PurchLine."Rejected Quantity" = 0) THEN
            EXIT;

        OrgIndentLine.RESET;
        OrgIndentLine.SETRANGE("Document No.", PurchLine."Indent No.");
        IF OrgIndentLine.FINDLAST THEN
            IndentLineNo := OrgIndentLine."Line No." + 1000;

        OrgIndentLine.RESET;
        OrgIndentLine.SETRANGE("Document No.", PurchLine."Indent No.");
        OrgIndentLine.SETFILTER("Line No.", '%1', PurchLine."Indent Line No.");
        IF OrgIndentLine.FINDFIRST THEN BEGIN
            IndentLine.INIT;
            IndentLine.TRANSFERFIELDS(OrgIndentLine);
            IndentLine."Line No." := IndentLineNo;
            IndentLine.Quantity := PurchLine.Quantity;
            IndentLine."Received Qty" := 0;
            IndentLine."Actual PO Qty" := 0;
            IndentLine."Order No." := '';
            IndentLine."Order Line No." := 0;
            IndentLine.Status := IndentLine.Status::Authorized;
            IndentLine.INSERT;
        END;
    end;

    procedure PostReturnOrder(RecPurchHeaderP: Record 38; purcRecpCode: Code[20])
    var
        CdPurchPost: Codeunit 91;
        PPR: Record 120;
        RecPurchHeader: Record "Purchase Header";
        PurchRecp: Record "Purch. Rcpt. Header";
    begin
        // PurchRecp.get(purcRecpCode);
        ////if PurchRecp."Return Order No" <> '' then begin
        //Team 7739 Upgrade 310516 Start-
        RecPurchHeader.get(RecPurchHeaderP."Document Type"::"Return Order", purcRecpCode);
        RecPurchHeader.Status := RecPurchHeader.Status::Released;
        IF PPR.GET(RecPurchHeader."Receiving No.") THEN
            RecPurchHeader."Vendor Shipment No." := PPR."Vendor Shipment No.";
        RecPurchHeader."Posting Description" := 'Shortage ' + RecPurchHeader."Posting Description";
        RecPurchHeader.MODIFY;

        CLEAR(CdPurchPost);
        CdPurchPost.RUN(RecPurchHeader); //Commented due to GST as discussed with Mr. Sandeep Jhanwar & Sharma
        RecPurchHeader."Auto Create Return Order" := FALSE;
        RecPurchHeader.MODIFY;
        //Team 7739 Upgrade 310516 End-

    end;

    /* [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterPostPurchLines', '', false, false)]
    local procedure OnAfterPostPurchLines(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShipmentHeader: Record "Return Shipment Header"; WhseShip: Boolean; WhseReceive: Boolean; var PurchLinesProcessed: Boolean; CommitIsSuppressed: Boolean; EverythingInvoiced: Boolean; var TempInvoicePostBuffer: Record "Invoice Post. Buffer" temporary; var TempPurchLineGlobal: Record "Purchase Line" temporary)
    var
        RecpurHeader: Record 38;
    begin
        RecpurHeader.Reset;
        RecpurHeader.SetRange("No.", PurchHeader."Return Order No");
        RecpurHeader.setrange("Document Type", RecpurHeader."Document Type"::"Return Order");
        if RecpurHeader.FindFirst then
            PostReturnOrder(RecpurHeader);

    end;
 */
    [EventSubscriber(ObjectType::Codeunit, 18435, 'OnBeforeCheckRefInvNoPurchaseHeader', '', false, false)]
    local procedure OnBeforeCheckRefInvNoPurchaseHeader(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        ReturnPurchaseLine: Record 39;
    begin
        ReturnPurchaseLine.Reset;
        ReturnPurchaseLine.setrange("Document No.", PurchaseHeader."No.");
        ReturnPurchaseLine.setfilter("Return Qty. to Ship", '>%1', 0);
        if ReturnPurchaseLine.FindFirst then
            IsHandled := true;
    end;

    var
        SingleInstanceG: Codeunit "Single Instance";
}