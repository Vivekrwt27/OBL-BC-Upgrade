codeunit 50111 "BasecodeunitExt"
{
    //TEAM 14763 02-06-23

    [EventSubscriber(ObjectType::Report, 1496, 'OnBeforeInsertBankAccReconLine', '', false, false)]
    local procedure OnBeforeInsertBankAccReconLine(var BankAccReconLine: Record "Bank Acc. Reconciliation Line"; var BankAccLedgEntry: Record "Bank Account Ledger Entry")
    var
        RecCustomer: Record Customer;
        RecVendor: Record Vendor;
        RecGLAccount: Record "G/L Account";
        RecCheckLedgerEntry: Record "Check Ledger Entry";
    begin
        RecCheckLedgerEntry.Reset;
        RecCheckLedgerEntry.SetRange("Document No.", BankAccLedgEntry."Document No.");
        if RecCheckLedgerEntry.FindFirst then
            BankAccReconLine."Check No." := RecCheckLedgerEntry."Check No."
        else
            BankAccReconLine."Check No." := BankAccLedgEntry."Cheque No.";
        if BankAccLedgEntry."Bal. Account Type" = BankAccLedgEntry."Bal. Account Type"::Customer then begin
            RecCustomer.GET(BankAccLedgEntry."Bal. Account No.");
            BankAccReconLine.Name := RecCustomer.Name;
        end else
            if BankAccLedgEntry."Bal. Account Type" = BankAccLedgEntry."Bal. Account Type"::Vendor then begin
                RecVendor.GET(BankAccLedgEntry."Bal. Account No.");
                BankAccReconLine.Name := RecVendor.Name;
            end else
                if BankAccLedgEntry."Bal. Account Type" = BankAccLedgEntry."Bal. Account Type"::"G/L Account" then begin
                    RecGLAccount.GET(BankAccLedgEntry."Bal. Account No.");
                    BankAccReconLine.Name := RecGLAccount.Name;
                end;
    end;

    [EventSubscriber(ObjectType::Table, 121, 'OnBeforeInsertInvLineFromRcptLine', '', false, false)]
    local procedure OnBeforeInsertInvLineFromRcptLine(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchLine: Record "Purchase Line"; PurchOrderLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
        PurchOrderLine."Source Order No." := PurchRcptLine."Order No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, 6620, 'OnAfterCopySalesHeaderDone', '', false, false)]
    local procedure OnAfterCopySalesHeaderDone(var ToSalesHeader: Record "Sales Header"; OldSalesHeader: Record "Sales Header"; FromSalesHeader: Record "Sales Header"; FromSalesShipmentHeader: Record "Sales Shipment Header"; FromSalesInvoiceHeader: Record "Sales Invoice Header"; FromReturnReceiptHeader: Record "Return Receipt Header"; FromSalesCrMemoHeader: Record "Sales Cr.Memo Header"; FromSalesHeaderArchive: Record "Sales Header Archive"; FromDocType: Enum "Sales Document Type From")
    begin
        ToSalesHeader."Trade Discount" := FromSalesInvoiceHeader."Trade Discount";
        ToSalesHeader."Structure Freight Amount" := FromSalesInvoiceHeader."Freight Amt";
        ToSalesHeader."Insurance Amount" := FromSalesInvoiceHeader."Insurance Amount";
        ToSalesHeader."Discount Amount" := FromSalesInvoiceHeader."Discount Amount";
        ToSalesHeader."Discount Charges %" := FromSalesInvoiceHeader."Discount Charges %";
        ToSalesHeader."Invoice Discount Amount" := FromSalesInvoiceHeader."Invoice Discount Amount";
    end;

    [EventSubscriber(ObjectType::Codeunit, 6620, 'OnCopySalesLineOnAfterTransferFieldsToSalesLine', '', false, false)]
    local procedure OnCopySalesLineOnAfterTransferFieldsToSalesLine(var ToSalesLine: Record "Sales Line"; FromSalesLine: Record "Sales Line")
    begin
        ToSalesLine."GST Group Code" := FromSalesLine."GST Group Code";
        ToSalesLine."HSN/SAC Code" := FromSalesLine."HSN/SAC Code";
        ToSalesLine.VALIDATE("Inv. Discount Amount", FromSalesLine."Inv. Discount Amount");
        ToSalesLine."Amount Inc CD" := FromSalesLine."Amount Inc CD";
        ToSalesLine."Gen. Prod. Posting Group" := FromSalesLine."Gen. Prod. Posting Group";
    end;

    [EventSubscriber(ObjectType::Codeunit, 6620, 'OnCopySalesDocLineOnBeforeCheckLocationOnWMS', '', false, false)]
    local procedure OnCopySalesDocLineOnBeforeCheckLocationOnWMS(var ToSalesHeader: Record "Sales Header"; var ToSalesLine: Record "Sales Line"; var FromSalesLine: Record "Sales Line"; var IsHandled: Boolean; IncludeHeader: Boolean; RecalculateLines: Boolean)
    begin
        ToSalesLine."GST Group Code" := FromSalesLine."GST Group Code";
        ToSalesLine."HSN/SAC Code" := FromSalesLine."HSN/SAC Code";
        ToSalesLine.VALIDATE("Inv. Discount Amount", FromSalesLine."Inv. Discount Amount");
        ToSalesLine."Amount Inc CD" := FromSalesLine."Amount Inc CD";
        ToSalesLine."Gen. Prod. Posting Group" := FromSalesLine."Gen. Prod. Posting Group";
    end;

    [EventSubscriber(ObjectType::Codeunit, 18435, 'OnBeforeCheckRefInvoiceNoSalesHeader', '', false, false)]
    local procedure OnBeforeCheckRefInvoiceNoSalesHeader(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;
    //TEAM 14763 02-06-23


    [EventSubscriber(ObjectType::Codeunit, 99000773, 'OnCalculateComponentsOnBeforeUpdateRoutingLinkCode', '', false, false)]
    local procedure OnCalculateComponentsOnBeforeUpdateRoutingLinkCode(var ProdOrderComp: Record "Prod. Order Component"; ProdOrderLine: Record "Prod. Order Line"; var IsHandled: Boolean)
    begin
        ProdOrderComp."Prod. Reporting No." := ProdOrderLine."Prod. Reporting No."; //MSKS
        ProdOrderComp."Prod. Reporting Line No." := ProdOrderLine."Prod. Reporting Line No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, 99000787, 'OnAfterProdOrderLineInsert', '', false, false)]
    local procedure OnAfterProdOrderLineInsert(var ProdOrder: Record "Production Order"; var ProdOrderLine: Record "Prod. Order Line"; var NextProdOrderLineNo: Integer)
    begin
        ProdOrderLine."Prod. Reporting No." := ProdOrder."Prod. Reporting No.";//MSKS
        ProdOrderLine."Prod. Reporting Line No." := ProdOrder."Prod. Reporting Line No."; //MSKS
    end;
    /* 
        [EventSubscriber(ObjectType::Codeunit, 5632, 'OnBeforePostFixedAssetFromGenJnlLine', '', false, false)]
        local procedure OnBeforePostFixedAssetFromGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; var FALedgerEntry: Record "FA Ledger Entry"; FAAmount: Decimal; VATAmount: Decimal)
        begin
            //FALedgerEntry."Tax Amount" := GenJournalLine."Tax Amount"; // Tri1.0 Vipul //TCPL::shiv
            FALedgerEntry."Charges Amount" := GenJournalLine."Charges Amount"; // Tri1.0 Vipul


        end;
     
    [EventSubscriber(ObjectType::Codeunit, 5647, 'OnAfterCopyFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyFromGenJnlLine(var MaintenanceLedgerEntry: Record "Maintenance Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        MaintenanceLedgerEntry.Description := GenJournalLine.Narration;

    end;
    */

    /* [EventSubscriber(ObjectType::Codeunit, 393, 'OnAfterInitGenJnlLine', '', false, false)]
    local procedure OnAfterInitGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; ReminderHeader: Record "Reminder Header"; var SrcCode: Code[10])
    begin
        GenJournalLine.Narration := ReminderHeader."Posting Description";
    end;
 */
    /*[EventSubscriber(ObjectType::Codeunit, 407, 'OnBeforeGenJnlLineInsert', '', false, false)]

     local procedure OnBeforeGenJnlLineInsert(var NewGenJnlLine: Record "Gen. Journal Line"; GenJnlLine2: Record "Gen. Journal Line"; PrevGenJnlLine2: Record "Gen. Journal Line")
    var

        TempCurrTotalBuffer: Record "Currency Total Buffer" temporary;
        Text002: Label 'Rounding correction for %1';
    begin
        TempCurrTotalBuffer.SetFilter("Currency Code", '<>%1', '');
        TempCurrTotalBuffer.SetRange("Total Amount", 0);

        if TempCurrTotalBuffer.Find('-') then;

        // NewGenJnlLine.Narration := STRSUBSTNO(Text002, TempCurrTotalBuffer."Currency Code");
    end;
 */
    /* [EventSubscriber(ObjectType::Codeunit, 1004, 'OnAfterFromGenJnlLineToJnlLine', '', false, false)]
    local procedure OnAfterFromGenJnlLineToJnlLine(var JobJnlLine: Record "Job Journal Line"; GenJnlLine: Record "Gen. Journal Line")
    var

    begin
        JobJnlLine.Description := GenJnlLine.Narration;
    end;
 */
    /* [EventSubscriber(ObjectType::Codeunit, 1224, 'OnBeforeGenJnlLineInsertFromIncomingDocument', '', false, false)]
    local procedure OnBeforeGenJnlLineInsertFromIncomingDocument(var GenJournalLine: Record "Gen. Journal Line"; IncomingDocument: Record "Incoming Document")

    begin
        GenJournalLine.VALIDATE(Narration, IncomingDocument."Vendor Name");
    end;
 */
    [EventSubscriber(ObjectType::Codeunit, 84, 'OnBeforeRun', '', false, false)]
    local procedure OnBeforeRun(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        //TCPL-7632-260516
        //TRI S.R 030110 - New code Add Start
        SalesHeader.TESTFIELD("Sales Order No.");
        SalesHeader.TESTFIELD("Location Code");
        SalesHeader.TESTFIELD("Payment Terms Code");
        //SalesHeader.TESTFIELD(Structure);
        SalesHeader.TESTFIELD("Order Date");
        SalesHeader.TESTFIELD("Document Date");
        SalesHeader.TESTFIELD("Promised Delivery Date");
        SalesHeader.TESTFIELD("Salesperson Code");
        //TRI S.R 030110 - New code Add Stop
    end;

    [EventSubscriber(ObjectType::Codeunit, 60, 'OnAfterValidateSalesLine2Quantity', '', false, false)]
    local procedure OnAfterValidateSalesLine2Quantity(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; CustInvoiceDisc: Record "Cust. Invoice Disc.")
    begin
        //mo tri1.0 start      //TCPL::shiv
        SalesLine.SetRec(CustInvoiceDisc);
        //mo tri1.0 end           //tcpl::shiv
    end;

    [EventSubscriber(ObjectType::Codeunit, 92, 'OnBeforeRunPurchPost', '', false, false)]
    local procedure OnBeforeRunPurchPost(var PurchHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
        if PurchHeader.Receive then begin
            PurchHeader.TESTFIELD("Vendor Shipment No.");
            // PurchHeader.TESTFIELD("Vendor Shipment Date");
            PurchHeader.TESTFIELD("GE No.");
        end;
        if PurchHeader.Invoice then begin
            PurchHeader.TESTFIELD("Vendor Invoice No.");
            PurchHeader.TESTFIELD("Vendor Invoice Date");
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 5641, 'OnAfterOnRun', '', false, false)]
    local procedure OnAfterOnRun(var FAReclassJournalLine: Record "FA Reclass. Journal Line")
    begin
        // NAVIN  //TCPL::Shiv
        DeferredClaimCheck(FAReclassJournalLine);
        // NAVIN
    end;

    procedure DeferredClaimCheck(var FAReclassJnlLine: Record 5624)
    var
        FALedger: Record 5601;
        Chk1: Boolean;
        Chk2: Boolean;
        D: Codeunit 5407;
    begin
        FALedger.RESET;
        FALedger.SETCURRENTKEY("FA No.", "FA Posting Type");
        FALedger.SETRANGE("FA No.", FAReclassJnlLine."FA No.");
        FALedger.SETFILTER("FA Posting Type", '<>%1', FALedger."FA Posting Type"::"Acquisition Cost");
        IF FALedger.FIND('-') THEN
            Chk1 := FALSE
        ELSE
            Chk1 := TRUE;

        FALedger.RESET;
        FALedger.SETCURRENTKEY("FA No.", "Reclassification Entry");
        FALedger.SETRANGE("FA No.", FAReclassJnlLine."FA No.");
        FALedger.SETRANGE("Reclassification Entry", TRUE);
        IF FALedger.FIND('-') THEN
            Chk2 := FALSE
        ELSE
            Chk2 := TRUE;

        IF ((FAReclassJnlLine."Reclassify Acq. Cost %" = 100) AND Chk1 AND Chk2) THEN
            FAReclassJnlLine."Claim Deferred" := TRUE
        ELSE
            FAReclassJnlLine."Claim Deferred" := FALSE;
        FAReclassJnlLine.MODIFY;
    end;
    /* 
        [EventSubscriber(ObjectType::Codeunit, 5601, 'OnGetBalAccAfterSaveGenJnlLineFields', '', false, false)]
        local procedure OnGetBalAccAfterSaveGenJnlLineFields(var ToGenJnlLine: Record "Gen. Journal Line"; FromGenJnlLine: Record "Gen. Journal Line"; var SkipInsert: Boolean)
        var
            Description2: Text[200];

        begin
            Description2 := FromGenJnlLine.Narration;
            ToGenJnlLine.Narration := Description2;

        end;
     */
    [EventSubscriber(ObjectType::Codeunit, 5708, 'OnBeforeReleaseTransferDoc', '', false, false)]
    local procedure OnBeforeReleaseTransferDoc(var TransferHeader: Record "Transfer Header")
    var
        EndUserItemExist: Boolean;
        TranLine2: Record "Transfer Line";
    begin
        //TCPL::shiv
        //IF "Transfer-from Code" = 'SKD-STORE' THEN BEGIN
        EndUserItemExist := FALSE;
        TranLine2.SETRANGE("Document No.", TransferHeader."No.");
        IF TranLine2.FIND('-') THEN BEGIN
            EndUserItemExist := TranLine2."End Use Item";
            REPEAT
                IF TranLine2."End Use Item" <> EndUserItemExist THEN
                    ERROR('Please Check all Item Should be End user Item');
            UNTIL TranLine2.NEXT = 0;
        END;
        //END;                                     //TCPL::shiv
    end;

    [EventSubscriber(ObjectType::Codeunit, 5600, 'OnBeforeInsertFA', '', false, false)]
    local procedure OnBeforeInsertFA(var FALedgerEntry: Record "FA Ledger Entry")
    begin

        // Tri1.0 Start Vipul     //TCPL::shiv   :code added in upgrade
        IF ((FALedgerEntry.Amount > 0) AND (FALedgerEntry."Document Type" = FALedgerEntry."Document Type"::Invoice)) THEN BEGIN
            FALedgerEntry.Amount := FALedgerEntry.Amount + FALedgerEntry."Tax Amount" + FALedgerEntry."Charges Amount";
            FALedgerEntry."Debit Amount" := FALedgerEntry.Amount;
            FALedgerEntry."Amount (LCY)" :=
              ROUND(FALedgerEntry.Amount * GetExchangeRate(FALedgerEntry."FA Exchange Rate"));
        END;

        IF ((FALedgerEntry.Amount < 0) AND (FALedgerEntry."Document Type" = FALedgerEntry."Document Type"::"Credit Memo")) THEN BEGIN
            FALedgerEntry.Amount := FALedgerEntry.Amount + FALedgerEntry."Tax Amount" + FALedgerEntry."Charges Amount";
            FALedgerEntry."Credit Amount" := -FALedgerEntry.Amount;
            FALedgerEntry."Amount (LCY)" :=
              ROUND(FALedgerEntry.Amount * GetExchangeRate(FALedgerEntry."FA Exchange Rate"));
        END;
        // Tri1.0 End Vipul         //TCPL::Shiv  :code added in upgrade

    end;

    local procedure GetExchangeRate(ExchangeRate: Decimal): Decimal
    begin
        if ExchangeRate <= 0 then
            exit(1);
        exit(ExchangeRate / 100);
    end;

    /*  [EventSubscriber(ObjectType::Codeunit, 227, 'OnAfterPostApplyVendLedgEntry', '', false, false)]
     local procedure OnAfterPostApplyVendLedgEntry(GenJournalLine: Record "Gen. Journal Line"; VendorLedgerEntry: Record "Vendor Ledger Entry"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")

     begin
         GenJournalLine.Narration := VendorLedgerEntry.Description;

     end;
  */
    /*   [EventSubscriber(ObjectType::Codeunit, 226, 'OnAfterPostApplyCustLedgEntry', '', false, false)]
      local procedure OnAfterPostApplyCustLedgEntry(GenJournalLine: Record "Gen. Journal Line"; CustLedgerEntry: Record "Cust. Ledger Entry"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
      begin
          GenJournalLine.Narration := CustLedgerEntry.Description;
      end;
   */
    [EventSubscriber(ObjectType::Codeunit, 353, 'OnBeforeShowItemAvailVariant', '', false, false)]
    local procedure OnBeforeShowItemAvailVariant(var Item: Record Item; FieldCaption: Text[80]; OldVariant: Code[20]; var NewVariant: Code[20]; var Result: Boolean; var IsHandled: Boolean)
    begin
        Item.CALCFIELDS("Inventory In CRT");
        Item.SETFILTER("Inventory In CRT", '<>%1', 0);

    end;

    /* [EventSubscriber(ObjectType::Codeunit, 370, 'OnBeforeInitPost', '', false, false)]
    local procedure OnBeforeInitPost(var BankAccReconciliation: Record "Bank Acc. Reconciliation")
    var
        BankAccRecLine: Record 274;
    begin
        //mo Tri1.0 Start
        BankAccRecLine.RESET;
        BankAccRecLine.SETRANGE("Bank Account No.", BankAccReconciliation."Bank Account No.");
        BankAccRecLine.SETRANGE("Statement No.", BankAccReconciliation."Statement No.");
        IF BankAccRecLine.FIND('-') THEN
            REPEAT
                BankAccRecLine.TESTFIELD(BankAccRecLine."Value Date");
            UNTIL BankAccRecLine.NEXT = 0; */ //15578 )01032023 Not Use value date Field In BC
                                              //mo Tri1.0 End

    /*
    BankAccReconLine2.RESET;
            BankAccReconLine2.SETRANGE("Bank Account No.", "Bank Account No.");
            BankAccReconLine2.SETRANGE("Statement No.", "Statement No.");
            BankAccReconLine2.CALCSUMS("Statement Amount", Difference);
            Window.CLOSE;
    */



    // end;

    /* [EventSubscriber(ObjectType::Codeunit, 370, 'OnPostPaymentApplicationsOnAfterInitGenJnlLine', '', false, false)]
    local procedure OnPostPaymentApplicationsOnAfterInitGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line")
    begin

        GenJournalLine.Narration := BankAccReconciliationLine.GetDescription;
    end;
 */
    /* [EventSubscriber(ObjectType::Codeunit, 13, 'OnAfterMakeRecurringTexts', '', false, false)]
    local procedure OnAfterMakeRecurringTexts(var GenJournalLine: Record "Gen. Journal Line"; var AccountingPeriod: Record "Accounting Period"; var Day: Integer; var Week: Integer; var Month: Integer; var MonthText: Text[30])
    begin
        GenJournalLine.Narration := DELCHR(
                                       PADSTR(
                                      STRSUBSTNO(GenJournalLine.Narration, Day, Week, Month, MonthText, AccountingPeriod.Name),
                                    MAXSTRLEN(GenJournalLine.Narration)))
    end;

 */
    /*     [EventSubscriber(ObjectType::Codeunit, 13, 'OnPostAllocationsOnBeforeCopyFromGenJnlAlloc', '', false, false)]
        local procedure OnPostAllocationsOnBeforeCopyFromGenJnlAlloc(var GenJournalLine: Record "Gen. Journal Line"; var AllocateGenJournalLine: Record "Gen. Journal Line"; var Reversing: Boolean)
        begin

            GenJournalLine.Narration := AllocateGenJournalLine.narration;
            GenJournalLine.Description2 := AllocateGenJournalLine.Description2;    //Vipul Tri1.0


        end;
     */
    [EventSubscriber(ObjectType::Codeunit, 5805, 'OnSuggestAssgntOnBeforeAssignItemCharges', '', false, false)]
    local procedure OnSuggestAssgntOnBeforeAssignItemCharges(var PurchaseLine: Record "Purchase Line"; ItemChargeAssignmentPurch: Record "Item Charge Assignment (Purch)")
    begin
        //MSKs2707          //TCPL:shiv
        UpdateDim(ItemChargeAssignmentPurch."Document No.", ItemChargeAssignmentPurch."Document Line No.",
        ItemChargeAssignmentPurch."Applies-to Doc. No.", ItemChargeAssignmentPurch."Applies-to Doc. Line No.");
        //MSKs2707          //TCPL::shiv
    end;

    procedure UpdateDim(DocumentNo: Code[20]; DocLineNo: Integer; FromDocNo: Code[20]; FromDocLineNo: Integer)
    var
        RecPurchLine: Record 39;
    begin
        /*RecPostedDocDim.RESET;
        RecPostedDocDim.SETRANGE("Table ID",121);
        RecPostedDocDim.SETRANGE(RecPostedDocDim."Document No.",FromDocNo);
        RecPostedDocDim.SETRANGE(RecPostedDocDim."Line No.",FromDocLineNo);
        IF RecPostedDocDim.FINDFIRST THEN BEGIN
          RecDocDim.RESET;
          RecDocDim.SETRANGE(RecDocDim."Table ID",39);
          RecDocDim.SETRANGE("Document Type",RecDocDim."Document Type"::Invoice);
          RecDocDim.SETRANGE("Document No.",DocumentNo);
          RecDocDim.SETRANGE("Line No.",DocLineNo);
          IF RecDocDim.FINDFIRST THEN
            RecDocDim.DELETEALL;
        REPEAT
        //  RecDocDim.TRANSFERFIELDS(RecPostedDocDim);
          RecDocDim."Document Type":=RecDocDim."Document Type"::Invoice;
          RecDocDim."Document No." :=DocumentNo;
          RecDocDim."Line No." :=DocLineNo;
          RecDocDim."Dimension Code" :=RecPostedDocDim."Dimension Code";
          RecDocDim."Dimension Value Code":=RecPostedDocDim."Dimension Value Code";
          RecDocDim."Table ID" := 39;
          RecDocDim.INSERT;
        MESSAGE('%1-%2-%3-%4',DocumentNo,DocLineNo,FromDocNo,FromDocLineNo);
        UNTIL RecPostedDocDim.NEXT=0;
        END;
         */
    end;

    /*   [EventSubscriber(ObjectType::Codeunit, 5640, 'OnAfterMakeGenJnlLine', '', false, false)]

      local procedure OnAfterMakeGenJnlLine(var GenJnlLine: Record "Gen. Journal Line"; var FAJnlLine: Record "FA Journal Line")
      begin

          GenJnlLine.Narration := FAJnlLine.Description;
      end;

      [EventSubscriber(ObjectType::Codeunit, 5640, 'OnAfterMakeFAJnlLine', '', false, false)]
      local procedure OnAfterMakeFAJnlLine(var FAJnlLine: Record "FA Journal Line"; var GenJnlLine: Record "Gen. Journal Line")
      begin

          FAJnlLine.Description := GenJnlLine.Narration;

      end;

      [EventSubscriber(ObjectType::Codeunit, 5640, 'OnAfterAdjustGenJnlLine', '', false, false)]
      local procedure OnAfterAdjustGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; var GenJournalLine2: Record "Gen. Journal Line")
      begin
          GenJournalLine.Narration := GenJournalLine2.Narration;
      end;
   */
    [EventSubscriber(ObjectType::Codeunit, 312, 'OnBeforeSalesHeaderCheck', '', false, false)]
    local procedure OnBeforeSalesHeaderCheck(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; var CreditLimitExceeded: Boolean);
    var
        cust: Record Customer;
        CustCheckCreditLimit: Page 343;
    begin
        //TCPL::shiv start
        IF CustCheckCreditLimit.SalesHeaderShowWarning(SalesHeader) THEN BEGIN
            IF Cust.GET(SalesHeader."Sell-to Customer No.") THEN BEGIN
                Cust."Sales Header No." := SalesHeader."No.";
                Cust."Sales Header Type" := SalesHeader."Document Type".AsInteger();
                Cust.MODIFY;
            END;
            COMMIT;

        end;
        //TCPL::Shiv end

        IF not CustCheckCreditLimit.SalesHeaderShowWarning(SalesHeader) THEN BEGIN
            //TCPL::Shiv start
            IF Cust.GET(SalesHeader."Sell-to Customer No.") THEN BEGIN
                Cust."Sales Header No." := '';
                Cust."Sales Header Type" := 0;
                Cust.MODIFY;
            END;
            COMMIT;
            //TCPL::Shiv end
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 312, 'OnBeforeSalesLineCheck', '', false, false)]
    local procedure OnBeforeSalesLineCheck(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        cust: Record Customer;
        CustCheckCreditLimit: Page 343;
        SalesHeader: Record 36;
        OK: Boolean;

    begin

        IF CustCheckCreditLimit.SalesLineShowWarning(SalesLine) THEN BEGIN
            //TCPL::Shiv start

            IF Cust.GET(SalesLine."Sell-to Customer No.") THEN BEGIN
                Cust."Sales Header No." := SalesLine."No.";
                Cust."Sales Header Type" := SalesLine."Document Type".AsInteger();
                Cust.MODIFY;
            END;
            COMMIT;
            //TCPL::shiv end
            SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.");
        END;
        IF NOT CustCheckCreditLimit.SalesLineShowWarning(SalesLine) THEN
            SalesHeader.OnCustomerCreditLimitNotExceeded
        ELSE BEGIN
            OK := CustCheckCreditLimit.RUNMODAL = ACTION::Yes;
            CLEAR(CustCheckCreditLimit);
            //TCPL::Shiv start
            IF Cust.GET(SalesLine."Sell-to Customer No.") THEN BEGIN
                Cust."Sales Header No." := '';
                Cust."Sales Header Type" := 0;
                Cust.MODIFY;
            END;
            //            COMMIT;

            //TCPL::shiv end


        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnFindOpenApprovalEntryForCurrUserOnAfterApprovalEntrySetFilters', '', false, false)]
    local procedure OnFindOpenApprovalEntryForCurrUserOnAfterApprovalEntrySetFilters(var ApprovalEntry: Record "Approval Entry")

    begin
        ApprovalEntry.SETFILTER(Status, '%1|%2', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnCancelApprovalRequestsForRecordOnAfterSetApprovalEntryFilters', '', false, false)]
    local procedure OnCancelApprovalRequestsForRecordOnAfterSetApprovalEntryFilters(var ApprovalEntry: Record "Approval Entry"; RecRef: RecordRef)
    begin
        ApprovalEntry.SETFILTER(Status, '<>%1&<>%2', ApprovalEntry.Status::Rejected, ApprovalEntry.Status::Canceled);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnRejectApprovalRequestsForRecordOnAfterSetApprovalEntryFilters', '', false, false)]

    local procedure OnRejectApprovalRequestsForRecordOnAfterSetApprovalEntryFilters(var ApprovalEntry: Record "Approval Entry"; RecRef: RecordRef)
    begin

        ApprovalEntry.SETFILTER(Status, '<>%1&<>%2', ApprovalEntry.Status::Rejected, ApprovalEntry.Status::Canceled);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnHasOpenApprovalEntriesOnAfterApprovalEntrySetFilters', '', false, false)]
    local procedure OnHasOpenApprovalEntriesOnAfterApprovalEntrySetFilters(var ApprovalEntry: Record "Approval Entry")
    begin

        ApprovalEntry.SETFILTER(Status, '%1|%2', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created);
    end;

    [EventSubscriber(ObjectType::Codeunit, 40, 'OnAfterLogInStart', '', false, false)]
    local procedure OnAfterLogInStart()
    var
        RecSMSSetup: Record 50035;
        CdSMSDue: Codeunit "SMS Sender - Due Date";

    begin

        IF (UPPERCASE(USERID) = UPPERCASE('ADMIN')) AND (COMPANYNAME = 'Orient Bell Limited') THEN BEGIN
            RecSMSSetup.GET;
            IF RecSMSSetup."Message Queue Created Date" <> TODAY THEN
                CdSMSDue.RUN;
        END;
        IF (COMPANYNAME = 'Associate Vendors-Morbi') THEN
            ReapplyEntries; //MSKS


    end;


    procedure ReapplyEntries()
    var
        TempItemLedgEntry: Record 32;
        AppliedItemLedgEntry: Record 32;
        Apply: Codeunit "Item Jnl.-Post Line";
    begin
        TempItemLedgEntry.SETFILTER("Remaining Quantity", '<%1', 0);
        TempItemLedgEntry.SETFILTER(Open, '%1', TRUE);
        IF TempItemLedgEntry.FINDSET THEN
            REPEAT
                Apply.ReApply(TempItemLedgEntry, 0);
            //Apply.LogApply(TempItemLedgEntry,AppliedItemLedgEntry);
            UNTIL TempItemLedgEntry.NEXT = 0;

        Apply.RedoApplications;
        Apply.CostAdjust;
        Apply.ClearApplicationLog;
    end;

    [EventSubscriber(ObjectType::Codeunit, 241, 'OnBeforeCode', '', false, false)]
    local procedure OnBeforeCode(var ItemJournalLine: Record "Item Journal Line"; var HideDialog: Boolean; var SuppressCommit: Boolean; var IsHandled: Boolean)
    var
        ItemMas: Record 27;
        ManSetup: Record "Manufacturing Setup";
        ItemUnitofMeasure: Record 5404;
        Text009: Label 'Unit of Measure code %1 not define for the item no. %2';
        Text008: Label 'Gen. Bus. Posting Group must be %1.';
        DateLength: DateFormula;
        OutputPostDate: Date;
        Text50001: Label 'Output cannot be Posted as Allowed Posting Date is from %1';
    begin
        //TCPL-7632-260516
        //TRI S.R 18.02.10 - New code Add Start
        IF ItemJournalLine."Commercial Quantity" <> 0 THEN BEGIN
            ItemMas.GET(ItemJournalLine."Item No.");
            ItemMas.TESTFIELD(Premium, TRUE);
            ItemMas.TESTFIELD(Commercial);
            //TRI-VKG ADD START THIS FOR CHECK UNIT OF MEASURE CODE
            ItemUnitofMeasure.SETRANGE("Item No.", ItemMas.Commercial);
            ItemUnitofMeasure.SETRANGE(Code, ItemJournalLine."Unit of Measure Code");
            IF NOT ItemUnitofMeasure.FINDFIRST THEN
                ERROR(Text009, ItemJournalLine."Unit of Measure Code", ItemMas.Commercial);
            //TRI-VKG ADD END
        END;
        IF ItemJournalLine."Economic Quantity" <> 0 THEN BEGIN
            ItemMas.GET(ItemJournalLine."Item No.");
            ItemMas.TESTFIELD(Premium, TRUE);
            ItemMas.TESTFIELD(Economic);
            //TRI-VKG ADD START THIS FOR CHECK UNIT OF MEASURE CODE
            ItemUnitofMeasure.SETRANGE("Item No.", ItemMas.Economic);
            ItemUnitofMeasure.SETRANGE(Code, ItemJournalLine."Unit of Measure Code");
            IF NOT ItemUnitofMeasure.FINDFIRST THEN
                ERROR(Text009, ItemJournalLine."Unit of Measure Code", ItemMas.Economic);
            //TRI-VKG ADD END
        END;
        IF ItemJournalLine."Broken Tiles Quantity" <> 0 THEN BEGIN
            ItemMas.GET(ItemJournalLine."Item No.");
            ItemMas.TESTFIELD(Premium, TRUE);
            ItemMas.TESTFIELD("Broken Tiles");
            //TRI-VKG ADD START THIS FOR CHECK UNIT OF MEASURE CODE
            ItemUnitofMeasure.SETRANGE("Item No.", ItemMas."Broken Tiles");
            ItemUnitofMeasure.SETRANGE(Code, ItemJournalLine."Unit of Measure Code");
            IF NOT ItemUnitofMeasure.FINDFIRST THEN
                ERROR(Text009, ItemJournalLine."Unit of Measure Code", ItemMas."Broken Tiles");
            //TRI-VKG ADD END
        END;
        ManSetup.GET;
        IF ItemJournalLine."Journal Template Name" = 'ISSUE' THEN
            ItemJournalLine.TESTFIELD("Direct Consumption Entries");
        IF ItemJournalLine."Direct Consumption Entries" THEN
            IF ItemJournalLine."Gen. Bus. Posting Group" <> ManSetup."Con. Bus. Posting Group" THEN
                ERROR(Text008, ManSetup."Con. Bus. Posting Group");

        //TRI S.R 18.02.10 - New code Add Stop

        //TSPL SA START
        IF ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Output THEN BEGIN
            EVALUATE(DateLength, '-' + FORMAT(ManSetup."Post Output (Days)"));
            OutputPostDate := CALCDATE(DateLength, TODAY);
            IF ItemJournalLine."Posting Date" < OutputPostDate THEN
                ERROR(Text50001, OutputPostDate);
        END;
        //TSPL SA END
        //TCPL-7632-260516
        /*
                IF ItemJournalLine."Line No." = 0 THEN BEGIN
                    //TCPL-7632-260516
                    // MESSAGE(Text002)
                    ItemJournalLine.RESET;
                    ItemJournalLine.FILTERGROUP(2);
                    ItemJournalLine.SETRANGE("Journal Template Name", ItemJournalLine."Journal Template Name");
                    ItemJournalLine.SETRANGE("Journal Batch Name", ItemJournalLine."Journal Batch Name");
                    ItemJournalLine.FILTERGROUP(0);
                    ItemJournalLine."Line No." := 1;
                    ItemJournalLine.DELETEALL;
                    */
    end;

    [EventSubscriber(ObjectType::Codeunit, 427, 'OnCreatePurchDocumentOnBeforePurchHeaderModify', '', false, false)]
    local procedure OnCreatePurchDocumentOnBeforePurchHeaderModify(var PurchHeader: Record "Purchase Header"; ICInboxPurchHeader: Record "IC Inbox Purchase Header")
    var
        ICPartner: Record "IC Partner";
        SalesInvHeader: Record 112;
    begin
        if PurchHeader."Document Type" = PurchHeader."Document Type"::Invoice then


     //MSKS          //TCPL::Shiv   :code added inupgrde
     BEGIN
            PurchHeader."Vendor Invoice No." := ICInboxPurchHeader."No.";
            PurchHeader."Vendor Invoice Date" := ICInboxPurchHeader."Document Date";
        END;
        //MSKS     //TCPL::shiv       :code added inupgrde

        //MS-PB BEGIN                          //TCPL::shiv
        ICPartner.RESET;
        ICPartner.SETRANGE("Inbox Type", ICPartner."Inbox Type"::Database);
        ICPartner.SETRANGE(Code, PurchHeader."Buy-from IC Partner Code");
        IF ICPartner.FINDFIRST THEN BEGIN
            SalesInvHeader.CHANGECOMPANY(ICPartner."Inbox Details");
            IF SalesInvHeader.GET(ICInboxPurchHeader."No.") THEN BEGIN
                PurchHeader.VALIDATE("Location Code", SalesInvHeader."Other Comp. Location");
                PurchHeader.VALIDATE("Other Comp. Location", SalesInvHeader."Location Code");
            END;
        END;
        PurchHeader.VALIDATE("Inter Company", TRUE);
        //MS-PB END;               //TCPL::shiv


    end;

    [EventSubscriber(ObjectType::Codeunit, 427, 'OnAfterICInboxTransInsert', '', false, false)]
    local procedure OnAfterICInboxTransInsert(var ICInboxTransaction: Record "IC Inbox Transaction"; ICOutboxTransaction: Record "IC Outbox Transaction")
    begin
        ICInboxTransaction."Line Action" := ICInboxTransaction."Line Action"::Accept;

    end;

    [EventSubscriber(ObjectType::Codeunit, 333, 'OnAfterInsertPurchOrderLine', '', false, false)]
    local procedure OnAfterInsertPurchOrderLine(var PurchOrderLine: Record "Purchase Line"; var NextLineNo: Integer; var RequisitionLine: Record "Requisition Line"; var PurchOrderHeader: Record "Purchase Header")
    var
        IndentHeader: Record 50016;
    begin

        TgInsertIndentLine(RequisitionLine, IndentHeader);//TRI S.R 04.03.10 - New code Added// TCPL:Shiv
    end;

    procedure TGInsertIndentHeader(ReqLine: Record 246; var IndentHeader: Record 50016)
    var
        PurchasePay: Record 312;
        NoSeriesMgt: Codeunit 396;
        c: Codeunit 11;
    begin
        //TRI S.R 04.03.10
        PurchasePay.GET;
        PurchasePay.TESTFIELD(PurchasePay."Indent Nos.");
        WITH ReqLine DO BEGIN
            IndentHeader.INIT;
            IndentHeader."No." := '';
            IndentHeader."Indent Date" := WORKDATE;
            IndentHeader."User ID" := USERID;
            IndentHeader.Status := IndentHeader.Status::Authorization1;
            IndentHeader.INSERT(TRUE);
            IndentHeader.Description := ReqLine.Description;
            IndentHeader."Location Code" := ReqLine."Location Code";
            IndentHeader."Department Code" := "Shortcut Dimension 1 Code";
            IndentHeader."Plant Code" := "Shortcut Dimension 2 Code";
            IndentHeader."Group Code" := "Group Code";
            IndentHeader.MODIFY;
        END;
    end;


    procedure TgInsertIndentLine(ReqLine: Record 246; var IndentHeader: Record 50016)
    var
        IndentLine: Record 50017;
        NextLineNo: Integer;
        LocCode: Code[20];
        GroupCode: Code[2];
    begin
        //TRI S.R 04.03.10
        ReqLine.SETCURRENTKEY("Location Code", "Group Code");
        GroupCode := '#@';
        LocCode := '#@#';
        WITH ReqLine DO BEGIN
            REPEAT
                IF ("No." = '') OR (Quantity = 0) OR
                   ("Replenishment System" <> "Replenishment System"::Purchase) THEN
                    EXIT;

                IF (LocCode <> ReqLine."Location Code") OR (GroupCode <> ReqLine."Group Code") THEN BEGIN
                    TGInsertIndentHeader(ReqLine, IndentHeader);
                    IndentLine.RESET;
                    IndentLine.SETRANGE("Document No.", IndentHeader."No.");
                    IF IndentLine.FIND('+') THEN
                        NextLineNo := IndentLine."Line No." + 10000
                    ELSE
                        NextLineNo := 10000;

                    IF (GroupCode <> ReqLine."Group Code") THEN
                        GroupCode := ReqLine."Group Code";

                    IF (LocCode <> ReqLine."Location Code") THEN
                        LocCode := ReqLine."Location Code"

                END;

                IF ReqLine."Accept Action Message" THEN BEGIN
                    IndentLine.INIT;
                    IndentLine."Document No." := IndentHeader."No.";
                    IndentLine."Line No." := NextLineNo;
                    IndentLine.Type := IndentLine.Type::Item;
                    IndentLine.VALIDATE("No.", ReqLine."No.");
                    IndentLine.Description := ReqLine.Description;
                    IndentLine.VALIDATE(Quantity, ReqLine.Quantity);
                    IndentLine.VALIDATE("Unit of Measurement", ReqLine."Unit of Measure Code");
                    IndentLine."Due Date" := ReqLine."Order Date";
                    IndentLine."Order No." := ReqLine."Ref. Order No.";
                    IndentLine."Order Line No." := ReqLine."Ref. Line No.";
                    IndentLine.Date := ReqLine."Order Date";
                    IndentLine."Vendor No." := ReqLine."Vendor No.";
                    IndentLine.Status := IndentHeader.Status;
                    IndentLine."Group Code" := ReqLine."Group Code";
                    IndentLine."Order Date" := ReqLine."Order Date";
                    IndentLine."Description 2" := ReqLine."Description 2";
                    IndentLine."Planning Date" := ReqLine."Starting Date";
                    IndentLine.INSERT;
                    //CarryOut.TGCarryOutToReqWksh(ReqLine,'1','1',IndentLine."Document No.",IndentLine."Line No.");
                    ReqLine.DELETE(TRUE);
                    NextLineNo += 10000;
                END;
            UNTIL ReqLine.NEXT = 0;
        END;
    end;

    /* [EventSubscriber(ObjectType::Codeunit, 11, 'OnBeforeRunCheck', '', false, false)]
    local procedure OnBeforeRunCheck(var GenJournalLine: Record "Gen. Journal Line")
    begin

        IF GenJournalLine."Online Bank Transfer" THEN BEGIN
            GenJournalLine.TESTFIELD("Beneficiary Account No.");
            GenJournalLine.TESTFIELD("Beneficiary Account Type");
            GenJournalLine.TESTFIELD("Beneficiary IFSC Code");
            GenJournalLine.TESTFIELD("Beneficiary Name");
            GenJournalLine.TESTFIELD("Payment Mode");
        END;
        IF NOT (GenJournalLine."Source Code" = 'PURCHAPPL') OR (GenJournalLine."Source Code" = 'UNAPPPURCH')
                  OR (GenJournalLine."Source Code" = 'INVTPCOST') OR (GenJournalLine."Source Code" = 'INVTADJMT') THEN //TRI-VKG ADD 220910
            CheckDates(GenJournalLine);


    end;
 */
    local procedure CheckDates(GenJnlLine: Record 81)
    var
        AccountingPeriod: Record 50;
        DateNotAllowed: Boolean;
        Text000: Label 'can only be a closing date for G/L entries';
        Text001: Label 'is not within your range of allowed posting dates';

    begin
        WITH GenJnlLine DO BEGIN
            TESTFIELD("Posting Date");
            IF "Posting Date" <> NORMALDATE("Posting Date") THEN BEGIN
                IF ("Account Type" <> "Account Type"::"G/L Account") OR
                   ("Bal. Account Type" <> "Bal. Account Type"::"G/L Account")
                THEN
                    FIELDERROR("Posting Date", Text000);
                AccountingPeriod.GET(NORMALDATE("Posting Date") + 1);
                AccountingPeriod.TESTFIELD("New Fiscal Year", TRUE);
                AccountingPeriod.TESTFIELD("Date Locked", TRUE);
            END;

            IF DateNotAllowed("Posting Date") THEN
                FIELDERROR("Posting Date", Text001);

            IF "Document Date" <> 0D THEN
                IF ("Document Date" <> NORMALDATE("Document Date")) AND
                   (("Account Type" <> "Account Type"::"G/L Account") OR
                    ("Bal. Account Type" <> "Bal. Account Type"::"G/L Account"))
                THEN
                    FIELDERROR("Document Date", Text000);
        END;
    end;

    procedure DateNotAllowed(PostingDate: Date): Boolean
    var
        AllowPostingFrom: date;
        AllowPostingTo: Date;
        UserSetup: Record 91;
        GLSetup: Record 98;
        c: Codeunit "Approvals Mgmt.";

    begin
        IF (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) THEN BEGIN
            IF USERID <> '' THEN
                IF UserSetup.GET(USERID) THEN BEGIN
                    AllowPostingFrom := UserSetup."Allow Posting From";
                    AllowPostingTo := UserSetup."Allow Posting To";
                END;
            IF (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) THEN BEGIN
                GLSetup.GET;
                AllowPostingFrom := GLSetup."Allow Posting From";
                AllowPostingTo := GLSetup."Allow Posting To";
            END;
            IF AllowPostingTo = 0D THEN
                AllowPostingTo := 99991231D;
        END;
        EXIT((PostingDate < AllowPostingFrom) OR (PostingDate > AllowPostingTo));
    end;

    [EventSubscriber(ObjectType::Codeunit, 5704, 'OnBeforeTransferOrderPostShipment', '', false, false)]
    local procedure OnBeforeTransferOrderPostShipment(var TransferHeader: Record "Transfer Header"; var CommitIsSuppressed: Boolean)
    var
        InvtSetup: Record "Inventory Setup";
        recNoSerRelation: Record "No. Series Relationship";
        TranLine5: Record "Transfer Line";

    begin
        //Team 7739 Upgrade 010616 Start-
        //-- 1. Tri34.2PG 18112006 PG -- Start
        IF TransferHeader."External Transfer" THEN BEGIN
            InvtSetup.GET;
            recNoSerRelation.RESET;
            //    recNoSerRelation.SETFILTER(Code,InvtSetup."Posted Transfer Shpt. Nos.");
            recNoSerRelation.SETFILTER("Series Code", TransferHeader."Shipment No. Series");
            recNoSerRelation.SETFILTER(Location, TransferHeader."Transfer-from Code");
            IF NOT recNoSerRelation.FIND('-') THEN ERROR('CURRENT POSTING NO. SERIES USED IS NOT LINKED WITH POSTING LOCATION');
        END;
        //-- 1. Tri34.2PG 18112006 PG -- Stop
        //Team 7739 Upgrade 010616 End-

        TranLine5.SETRANGE("Document No.", TransferHeader."No.");
        IF TranLine5.FIND('-') THEN BEGIN
            REPEAT
                TranLine5.CheckMfgBatchNo(TranLine5);
            UNTIL TranLine5.NEXT = 0;
        END;

        CheckItemInInventory(TranLine5);

    end;

    local procedure CheckItemInInventory(TransLine: Record 5741)
    var
        Item: Record 27;
        Text009: Label 'Item %1 is not in inventory.';

    begin
        WITH Item DO BEGIN
            GET(TransLine."Item No.");
            SETFILTER("Variant Filter", TransLine."Variant Code");
            SETFILTER("Location Filter", TransLine."Transfer-from Code");
            CALCFIELDS(Inventory);
            IF Inventory <= 0 THEN
                ERROR(Text009, TransLine."Item No.");
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, 5704, 'OnAfterInsertTransShptHeader', '', false, false)]
    local procedure OnAfterInsertTransShptHeader(var TransferHeader: Record "Transfer Header"; var TransferShipmentHeader: Record "Transfer Shipment Header")
    begin

        //Team 7739 Upgrade 010616 Start-
        //MS-AN 08/01/13 - BEGIN
        TransferShipmentHeader.Purpose := TransferHeader.Purpose;
        //MS-AN 08/01/13 - END

        //ND Tri1.0 Start
        TransferShipmentHeader."Insurance Amount" := TransferHeader."Insurance Amount";
        TransferShipmentHeader."Transfer-from State" := TransferHeader."Transfer-from State";
        TransferShipmentHeader."Transfer-to State" := TransferHeader."Transfer-to State";
        TransferShipmentHeader."External Transfer" := TransferHeader."External Transfer";
        TransferShipmentHeader.ReProcess := TransferHeader.ReProcess; //TRI  SC
                                                                      //ND Tri1.0 End
        TransferShipmentHeader.Pay := TransferHeader.Pay;//TRI A.S 07.11.08
        TransferShipmentHeader."Location Comment" := TransferHeader."Location Comment"; //TRI A.S 31.12.08
                                                                                        //TRI N.K. 22.02.08 START
        TransferShipmentHeader."Group Code" := TransferHeader."Group Code";
        //TRI N.K. 22.02.08 STOP
        //Vipul Start
        TransferShipmentHeader."Releasing Date" := TransferHeader."Releasing Date";
        TransferShipmentHeader."Releasing Time" := TransferHeader."Releasing Time";
        //Vipul End
        //report 54 - S2 Start ravi
        TransferShipmentHeader."Transporter's Name" := TransferHeader."Transporter's Name";
        TransferShipmentHeader."GR No." := TransferHeader."GR No.";
        TransferShipmentHeader."GR Date" := TransferHeader."GR Date";
        TransferShipmentHeader."Truck No." := TransferHeader."Truck No.";
        //report 54 - S2 Start ravi
        //mo tri1.0 start
        TransferShipmentHeader."SalesPerson Code" := TransferHeader."SalesPerson Code";
        //mo tri1.0 end
        //Vipul Tri1.0 satrt Report 113 N-10A
        TransferShipmentHeader."Loading Inspector" := TransferHeader."Loading Inspector";
        //Vipul Tri1.0 End Report 113 N-10A
        //Team 7739 Upgrade End-
        TransferShipmentHeader."Created ID" := TransferHeader."Created ID"; //Team 7739 Upgrade 010616
        TransferShipmentHeader."Shortage TO" := TransferHeader."Shortage TO"; //TRI-VKG ADD 23.09.10 //Team 7739 Upgrade 010616
    end;

    [EventSubscriber(ObjectType::Codeunit, 5704, 'OnAfterInsertTransShptLine', '', false, false)]
    local procedure OnAfterInsertTransShptLine(var TransShptLine: Record "Transfer Shipment Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; TransShptHeader: Record "Transfer Shipment Header")
    var
        Item: Record 27;
    begin

        TransShptLine."Gross Weight" := (TransLine."Gross Weight" * TransLine."Qty. to Ship") / TransLine.Quantity;  //MS - 160318

        //Team 7739 Upgrade 010616 Start-
        TransShptLine."Short Quantity" := TransLine."Short Quantity";
        TransShptLine."Reason Code" := TransLine."Reason Code";
        //Team 7739 Upgrade 010616 End-
        TransShptLine."Unit Price" := TransLine."Transfer Price";
        //Team 7739 Upgrade 010616 Start-
        TransShptLine."Size Code" := TransLine."Size Code";  //vipul Tri1.0
        TransShptLine."Plant Code" := TransLine."Plant Code"; //mo tri1.0
        TransShptLine."Type Code" := TransLine."Type Code"; //mo tri1.0
        TransShptLine."Color Code" := TransLine."Color Code"; //ND tri1.0
        TransShptLine."Quality Code" := TransLine."Quality Code"; //ND tri1.0
        TransShptLine."Packing Code" := TransLine."Packing Code"; //ND tri1.0
        TransShptLine."Design Code" := TransLine."Design Code"; //ND tri1.0
        TransLine.CALCFIELDS(TransLine."Transfer-to State"); //mo tri1.0
        TransShptLine."Transfer-to State" := TransLine."Transfer-to State"; //mo tri1.0
                                                                            //        TransShptLine."Assessable Value" := TransLine."Assessable Value"; //ND Tri1.0
        TransShptLine."External Transfer" := TransLine."External Transfer";   //TRI DG 010510
        TransShptLine.ReProcess := TransLine.ReProcess;   //TRI SC
                                                          // NAVIN
        TransShptLine."Unit Price" := TransLine."Unit Price";
        //Team 7739 Upgrade 010616 End-
        TransShptLine.Amount := TransLine.Amount;
        //Team 7739 Upgrade 010616 Start-
        //TRI N.K. 22.02.08 START
        TransShptLine."Group Code" := TransLine."Group Code";
        //TRI N.K. 22.02.08 STOP
        //Team 7739 Upgrade 010616 End-
        //Team 7739 Upgrade 010616 Start-
        TransShptLine."Customer Price Group" := TransLine."Customer Price Group";//TRI-VKG ADD23.09.10
        TransShptLine."Shoratge Transfer Rcpt No." := TransLine."Shoratge Transfer Rcpt No.";//TRI-VKG ADD23.09.10
        TransShptLine."Qty in Sq. Mt." := TransLine."Qty in Sq. Mt.";
        TransShptLine."Qty in Carton." := TransLine."Qty in Carton.";
        //TRI VS 230410 Add Start
        IF TransShptHeader."External Transfer" THEN BEGIN
            IF Item.GET(TransLine."Item No.") THEN BEGIN
                IF (Item."Item Category Code" = 'M001') OR (Item."Item Category Code" = 'T001') THEN BEGIN
                    IF NOT (TransLine."Unit of Measure Code" IN ['CRT', 'PCS.']) THEN
                        ERROR('UOM should be CRT or PCS. Please Select CRT or PCS');
                END;
            END;
        END;
        //TRI VS 230410 Add Stop
        //Team 7739 Upgrade 010616 End-
    end;

    [EventSubscriber(ObjectType::Codeunit, 5704, 'OnAfterCopyTransLine', '', false, false)]
    local procedure OnAfterCopyTransLine(var NewTransferLine: Record "Transfer Line"; TransferLine: Record "Transfer Line")
    var
        ReserveTransLine: Codeunit 99000836;
        TrackingSpecification: Record 336;
    begin

        TrackingSpecification.RESET;
        TrackingSpecification.SETRANGE("Source Prod. Order Line", TransferLine."Derived From Line No.");
        IF TrackingSpecification.FIND('-') THEN;

        //Team 7739 Upgrade 010616 Start-
        NewTransferLine."External Transfer" := TransferLine."External Transfer"; //ND
        NewTransferLine.ReProcess := TransferLine.ReProcess;      //TRI S.C
                                                                  //Team 7739 Upgrade 010616 End-


        //Team 7739 Upgrade 010616 Start-
        ReserveTransLine.TransferTransferToTransfer(TransferLine,
         NewTransferLine, TransferLine."Qty. to Ship (Base)", 1, TrackingSpecification);
        //Team 7739 Upgrade 010616 End-

    end;

    [EventSubscriber(ObjectType::Codeunit, 5704, 'OnAfterCreateItemJnlLine', '', false, false)]
    local procedure OnAfterCreateItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferShipmentHeader: Record "Transfer Shipment Header"; TransferShipmentLine: Record "Transfer Shipment Line")
    var
        c: Codeunit 87;
    begin
        ItemJournalLine."Capex No." := TransferShipmentLine."Capex No."; //MSKS
        ItemJournalLine."Mfg. Batch No." := TransferLine."Mfg. Batch No.";//MSKS
    end;

    [EventSubscriber(ObjectType::Codeunit, 87, 'OnBeforeInsertSalesOrderHeader', '', false, false)]
    local procedure OnBeforeInsertSalesOrderHeader(var SalesOrderHeader: Record "Sales Header"; var BlanketOrderSalesHeader: Record "Sales Header")
    var
        SalesOrdNo: Code[20];
        NoSeriesMgt: Codeunit 396;
    begin


        SalesOrdNo := NoSeriesMgt.GetNextNo(BlanketOrderSalesHeader."Sales Order No.", TODAY, TRUE);

        //Team 7739 Upgrade End--


        //SalesOrderHeader."No." := '';

        SalesOrderHeader."No." := SalesOrdNo;//TRI S.R 030110 - New code Added
        IF SalesOrderHeader."Sales Order No." = 'SOHOTRD' THEN
            SalesOrderHeader."Posting No. Series" := 'SIPLT';
        SalesOrderHeader."Releasing Date" := 0D;//MSAK
        SalesOrderHeader."Releasing Time" := 0T;//MSAK
        SalesOrderHeader."Date of Reopen" := 0D; //MSAK
        SalesOrderHeader."Time of Reopen" := 0T; //MSAK
        SalesOrderHeader."Sell-to Customer No." := BlanketOrderSalesHeader."Sell-to Customer No."; //MSKS0307
        SalesOrderHeader."Bill-to Customer No." := BlanketOrderSalesHeader."Bill-to Customer No."; //MSKS0307
        SalesOrderHeader."Payment Terms Code" := BlanketOrderSalesHeader."Payment Terms Code";
        SalesOrderHeader.Commitment := BlanketOrderSalesHeader.Commitment;
        SalesOrderHeader."Ship to Pin" := BlanketOrderSalesHeader."Ship to Pin";
        SalesOrderHeader."Order Booked Date" := BlanketOrderSalesHeader."Order Booked Date";
        SalesOrderHeader."PMT Code" := BlanketOrderSalesHeader."PMT Code";
        SalesOrderHeader.Commitment := BlanketOrderSalesHeader.Commitment;
        SalesOrderHeader."Ship to Pin" := BlanketOrderSalesHeader."Ship to Pin";
        SalesOrderHeader."Sales Type" := BlanketOrderSalesHeader."Sales Type";
        SalesOrderHeader."Shipping Agent Code" := BlanketOrderSalesHeader."Shipping Agent Code";
        SalesOrderHeader."Location State Code" := BlanketOrderSalesHeader."Location State Code";
        SalesOrderHeader.Pay := BlanketOrderSalesHeader.Pay;
        SalesOrderHeader."ORC Terms" := BlanketOrderSalesHeader."ORC Terms";
        SalesOrderHeader."Dealer Code" := BlanketOrderSalesHeader."Dealer Code";
        SalesOrderHeader.Remarks := BlanketOrderSalesHeader.Remarks;
        SalesOrderHeader.GPS := BlanketOrderSalesHeader.GPS;
        SalesOrderHeader."Govt. Project Sales" := BlanketOrderSalesHeader."Govt. Project Sales";
        SalesOrderHeader.BD := BlanketOrderSalesHeader.BD;
        SalesOrderHeader."Business Development" := BlanketOrderSalesHeader."Business Development";
        SalesOrderHeader.CKA := BlanketOrderSalesHeader.CKA;
        SalesOrderHeader."CKA Code" := BlanketOrderSalesHeader."CKA Code";
        SalesOrderHeader.None := BlanketOrderSalesHeader.None;
        SalesOrderHeader."GST Ship-to State Code" := BlanketOrderSalesHeader."GST Ship-to State Code";
        SalesOrderHeader."Bypass Auto Order Process" := TRUE;


        SalesOrderHeader.CheckQDApplicableforCustomer; //MSKS0307



        //TRI P.G 07.08.2009 -- New Code Add Start
        SalesOrderHeader.VALIDATE("Sell-to Customer No."); //MSKS0307
        SalesOrderHeader.VALIDATE("Payment Terms Code", BlanketOrderSalesHeader."Payment Terms Code");
        SalesOrderHeader.VALIDATE("PMT Code", BlanketOrderSalesHeader."PMT Code");
        SalesOrderHeader.Commitment := BlanketOrderSalesHeader.Commitment;
        SalesOrderHeader."Ship to Pin" := BlanketOrderSalesHeader."Ship to Pin";
        SalesOrderHeader."Sales Type" := BlanketOrderSalesHeader."Sales Type";
        SalesOrderHeader."TPT Method" := BlanketOrderSalesHeader."TPT Method";
        SalesOrderHeader."Shipping Agent Code" := BlanketOrderSalesHeader."Shipping Agent Code";
        SalesOrderHeader.Pay := BlanketOrderSalesHeader.Pay;
        SalesOrderHeader."ORC Terms" := BlanketOrderSalesHeader."ORC Terms";
        SalesOrderHeader."Dealer Code" := BlanketOrderSalesHeader."Dealer Code";
        SalesOrderHeader.Remarks := BlanketOrderSalesHeader.Remarks;
        SalesOrderHeader.GPS := BlanketOrderSalesHeader.GPS;
        SalesOrderHeader."Govt. Project Sales" := BlanketOrderSalesHeader."Govt. Project Sales";
        SalesOrderHeader.BD := BlanketOrderSalesHeader.BD;
        SalesOrderHeader."Business Development" := BlanketOrderSalesHeader."Business Development";
        SalesOrderHeader.CKA := BlanketOrderSalesHeader.CKA;
        SalesOrderHeader."CKA Code" := BlanketOrderSalesHeader."CKA Code";
        SalesOrderHeader.None := BlanketOrderSalesHeader.None;
        SalesOrderHeader."GST Ship-to State Code" := BlanketOrderSalesHeader."GST Ship-to State Code";
        SalesOrderHeader."Location State Code" := BlanketOrderSalesHeader."Location State Code";
        SalesOrderHeader."Bypass Auto Order Process" := TRUE;

        //TRI P.G 07.08.2009 -- New Code Add Start Stop
        //Team 7739 Upgrade End--

        IF BlanketOrderSalesHeader."Order Date" = 0D THEN
            SalesOrderHeader."Order Date" := WORKDATE
        ELSE
            SalesOrderHeader."Order Date" := WORKDATE;//TRI Team 7739 Upgrade
                                                      // SalesOrderHeader."Order Date" := "Order Date"; //Team 7739 Upgrade Code Comment

        IF BlanketOrderSalesHeader."Posting Date" <> 0D THEN
            SalesOrderHeader."Posting Date" := BlanketOrderSalesHeader."Posting Date";

        SalesOrderHeader."Posting Date" := WORKDATE;//TRI Team 7739 Upgrade
                                                    //SalesOrderHeader."Document Date" := "Document Date"; //TRI Team 7739 Upgrade
                                                    //SalesOrderHeader."Shipment Date" := "Shipment Date"; //TRI Team 7739 Upgrade
        SalesOrderHeader."Document Date" := WORKDATE;//TRI Team 7739 Upgrade
        SalesOrderHeader."Shipment Date" := WORKDATE;//TRI Team 7739 Upgrade
        SalesOrderHeader."Make Order Date" := CURRENTDATETIME;//Ori Uttar  Team 7739 Upgrade
        SalesOrderHeader."Order Created ID" := USERID;//ORi Uttar21-07-10  Team 7739 Upgrade

        SalesOrderHeader."Shortcut Dimension 1 Code" := BlanketOrderSalesHeader."Shortcut Dimension 1 Code";
        SalesOrderHeader."Shortcut Dimension 2 Code" := BlanketOrderSalesHeader."Shortcut Dimension 2 Code";
        SalesOrderHeader."Dimension Set ID" := BlanketOrderSalesHeader."Dimension Set ID";
        SalesOrderHeader."Outbound Whse. Handling Time" := BlanketOrderSalesHeader."Outbound Whse. Handling Time";
        SalesOrderHeader."Location Code" := BlanketOrderSalesHeader."Location Code";
        SalesOrderHeader."Posting No. Series" := BlanketOrderSalesHeader."Posting No. Series";
        SalesOrderHeader."Shipping No. Series" := BlanketOrderSalesHeader."Shipping No. Series";
        SalesOrderHeader."Ship-to Name" := BlanketOrderSalesHeader."Ship-to Name";
        SalesOrderHeader."Ship-to Name 2" := BlanketOrderSalesHeader."Ship-to Name 2";
        SalesOrderHeader."Ship-to Address" := BlanketOrderSalesHeader."Ship-to Address";
        SalesOrderHeader."Ship-to Address 2" := BlanketOrderSalesHeader."Ship-to Address 2";
        SalesOrderHeader."Ship-to City" := BlanketOrderSalesHeader."Ship-to City";
        SalesOrderHeader."Ship-to Post Code" := BlanketOrderSalesHeader."Ship-to Post Code";
        SalesOrderHeader."Ship-to County" := BlanketOrderSalesHeader."Ship-to County";
        SalesOrderHeader."Ship-to Country/Region Code" := BlanketOrderSalesHeader."Ship-to Country/Region Code";
        SalesOrderHeader."Ship-to Contact" := BlanketOrderSalesHeader."Ship-to Contact";
        SalesOrderHeader."Customer Price Group" := BlanketOrderSalesHeader."Customer Price Group";//Team 7739 Upgrade
        SalesOrderHeader.Reserve := BlanketOrderSalesHeader.Reserve;

        //Team 7739 Upgrade Start--
        SalesOrderHeader."Group Code" := BlanketOrderSalesHeader."Group Code";
        SalesOrderHeader."Tax Area Code" := BlanketOrderSalesHeader."Tax Area Code";
        SalesOrderHeader.Commitment := BlanketOrderSalesHeader.Commitment;
        SalesOrderHeader."PO No." := BlanketOrderSalesHeader."PO No.";//Ori Ut
        IF SalesOrderHeader."Sales Order No." = 'SOHOTRD' THEN
            SalesOrderHeader."Posting No. Series" := 'SIPLT';
        //Team 7739 Upgrade End--
        IF SalesOrderHeader."Posting Date" = 0D THEN
            SalesOrderHeader."Bypass Auto Order Process" := TRUE;
        SalesOrderHeader."Posting Date" := WORKDATE;
        SalesOrderHeader."Posting Date" := WORKDATE;//TRI Team 7739 Upgrade
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", 'OnBeforeFlushProdOrder', '', false, false)]
    local procedure OnBeforeFlushProdOrder(var ProductionOrder: Record "Production Order"; NewStatus: Enum "Production Order Status"; PostingDate: Date; var IsHandled: Boolean);
    begin
        IF ProductionOrder."Original Prod. No" <> '' THEN
            PostingDate := ProductionOrder."Due Date";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", 'OnInitItemJnlLineFromProdOrderLineOnAfterInit', '', false, false)]
    local procedure OnInitItemJnlLineFromProdOrderLineOnAfterInit(var ItemJournalLine: Record "Item Journal Line");
    var
        ProdOrderLine: Record 5406;
    begin
        /*     ProdOrderLine.RESET;
           ProdOrderLine.SETRANGE(Status, ProdOrder.Status);
           ProdOrderLine.SETRANGE("Prod. Order No.", ProdOrder."No.");
           IF ProdOrderLine.FINDSET THEN
               ItemJournalLine."Work Shift Code" := ProdOrderLine."Work Shift Code";//TRI S.R
           ItemJournalLine."Production Plant Code" := ProdOrderLine."Production Plant Code";//TRI S.R
           ItemJournalLine.VALIDATE(ItemJournalLine."Shortcut Dimension 1 Code", ProdOrderLine."Shortcut Dimension 1 Code");  //TRI DG 030910
     */
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeTestStatusOpen', '', false, false)]
    local procedure OnBeforeTestStatusOpen(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; xSalesLine: Record "Sales Line"; CallingFieldNo: Integer; var StatusCheckSuspended: Boolean);
    begin
        if (SalesHeader.Status = SalesHeader.Status::Approved) or (SalesLine."Charge Item") then
            IsHandled := true;

        SalesLine."Charge Item" := false;
        SalesLine."Location Code" := SalesHeader."Location Code"; //TEAM 14763
    end;


    //TEAM 14763 process to ignore error for negative line discount %
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnUpdateLineDiscPctOnAfterCalcIsOutOfStandardDiscPctRange', '', false, false)]
    local procedure OnUpdateLineDiscPctOnAfterCalcIsOutOfStandardDiscPctRange(var SalesLine: Record "Sales Line"; var IsOutOfStandardDiscPctRange: Boolean)
    begin
        IsOutOfStandardDiscPctRange := false;
    end;
    //TEAM 14763 process to ignore error for negative line discount %
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reference Invoice No. Mgt.", 'OnBeforeCheckRefInvNoPurchHeader', '', false, false)]
    local procedure OnBeforeCheckRefInvNoPurchHeader(var PurchaseHeader: Record "Purchase Header"; IsHandled: Boolean);
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reference Invoice No. Mgt.", 'OnBeforeCheckRefInvNoPurchaseHeader', '', false, false)]
    local procedure OnBeforeCheckRefInvNoPurchaseHeader(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean);
    begin
        IsHandled := true;
    end;



}