codeunit 99999 Function// 50006
{
    /*  [EventSubscriber(ObjectType::Table, Database::"Sales Cr.Memo Line", 'OnAfterInitFromSalesLine', '', false, false)]
      local procedure OnAfterInitFromSalesLine(var SalesCrMemoLine: Record "Sales Cr.Memo Line"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesLine: Record "Sales Line");
      begin
          SalesLine.Init();
          SalesLine.TransferFields(SalesLine);
          IF (SalesLine."No." = '') AND (SalesLine.Type IN [Type::"G/L Account" .. Type::"Charge (Item)"]) THEN
              SalesCrMemoLine."Sales Type" := SalesLine."Sales Type";
      end;*/ // sales Type field N/F


    //TEAM 14763 [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInitQtyToShip', '', false, false)]//50179
    local procedure OnAfterInitQtyToShip(var SalesLine: Record "Sales Line"; CurrFieldNo: Integer);
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        IF (SalesSetup."Default Quantity to Ship" = SalesSetup."Default Quantity to Ship"::Remainder) OR
           (SalesLine."Document Type" = SalesLine."Document Type"::Invoice)
        THEN BEGIN
            //  "Qty. to Ship" := "Outstanding Quantity";
            //  "Qty. to Ship (Base)" := "Outstanding Qty. (Base)";
            //Upgrade(+)
            SalesLine."Qty. to Ship" := SalesLine."Outstanding Quantity" - SalesLine."Order Qty (CRT)";
            SalesLine."Qty. to Ship (Base)" := SalesLine."Outstanding Qty. (Base)" - SalesLine."Order Qty";
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', false, false)]// 50129 CopyFromGenJnlLine
    local procedure OnAfterCopyGLEntryFromGenJnlLine(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line");
    var
        MadeChange: Boolean;
        SlaesInv: Record "Sales Invoice Header";
        PurchInv: Record "Purch. Inv. Header";
        TSH: Record "Transfer Shipment Header";
        TRH: Record "Transfer Receipt Header";
    begin
        // 15578    GLEntry.Description := GenJournalLine.Narration;
        GLEntry."Description 2" := GenJournalLine.Description2;  //Vipul Tri1.0 -Team 7739 Upgrade 08062016
        GLEntry."Business Unit Code" := GenJournalLine."Business Unit Code";
        //
        IF GenJournalLine."Check Printed" = TRUE THEN BEGIN
            GenJournalLine."Check Printed" := FALSE;
            MadeChange := TRUE;
        END;

        IF SlaesInv.GET(GenJournalLine."Document No.") THEN
            GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", SlaesInv."Shortcut Dimension 1 Code");

        IF PurchInv.GET(GenJournalLine."Document No.") THEN
            GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", PurchInv."Shortcut Dimension 1 Code");

        IF TSH.GET(GenJournalLine."Document No.") THEN
            GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", TSH."Shortcut Dimension 1 Code");

        IF TRH.GET(GenJournalLine."Document No.") THEN
            GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", TRH."Shortcut Dimension 1 Code");

        //6700
        IF MadeChange THEN
            GenJournalLine."Check Printed" := TRUE;
        IF (GenJournalLine."Account Type" = GenJournalLine."Account Type"::"IC Partner") OR
        (GenJournalLine."Bal. Account Type" = GenJournalLine."Bal. Account Type"::"IC Partner")
     THEN
            GLEntry."Issuing Bank" := GenJournalLine."Issuing Bank";//TRI S.R 150310 - New code Add-Team 7739 Upgrade 08062016
        GLEntry."Export Reference No." := GenJournalLine."Export Reference No.";//Ori ut-Team 7739 Upgrade 08062016
    end;

    /* 
        [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', false, false)]// 50134 CopyFromGenJnlLine
        local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line");
        var
            Description: Text;
            Description2: Text;
            SalesInvHead: Record "Sales Invoice Header";
        begin
            // 15578    Description := GenJournalLine.Narration;
            Description2 := GenJournalLine.Description2; //Vipul Tri1.0 //Team 7739 Upgrade 08062016
            //Team 7739 Upgrade 08062016 Start-
            //TRI
            CustLedgerEntry."Entry No. 3.7" := GenJournalLine."Entry No. 3.7";
            CustLedgerEntry."Closed By Entry No. 3.7" := GenJournalLine."Closed By Entry No. 3.7";
            CustLedgerEntry."Closed By Amount 3.7" := GenJournalLine."Closed By Amount 3.7";
            //TRI
            //Team 7739 Upgrade 08062016 End-

            //Team 7739 Upgrade 08062016 Start-
            CustLedgerEntry."Cheque No." := GenJournalLine."Cheque No.";
            CustLedgerEntry."Cheque Date" := GenJournalLine."Cheque Date";
            //Team 7739 Upgrade 08062016 End-

            //Team 7739 Upgrade 08062016 Start-
            IF CustLedgerEntry."Dealer Code" = '' THEN BEGIN
                IF GenJournalLine."Document Type" = GenJournalLine."Document Type"::Invoice THEN
                    IF SalesInvHead.GET(CustLedgerEntry."Document No.") THEN
                        CustLedgerEntry."Dealer Code" := SalesInvHead."Dealer Code"
            END ELSE
                CustLedgerEntry."Dealer Code" := GenJournalLine."Dealer Code";
            CustLedgerEntry."Dealer's Salesperson Code" := GenJournalLine."Dealer's Salesperson Code";
            //Team 7739 Upgrade 08062016 End-
            CustLedgerEntry.Comment := GenJournalLine.Comment; //MS
        end;

        [EventSubscriber(ObjectType::Table, Database::"Bank Account Ledger Entry", 'OnAfterCopyFromGenJnlLine', '', false, false)]// 50149
        local procedure OnAfterCopyFromGenJnlLine(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; GenJournalLine: Record "Gen. Journal Line");
        begin
            //15578    BankAccountLedgerEntry.Description := GenJournalLine.Narration;
            BankAccountLedgerEntry."Description 2" := GenJournalLine.Description2;  //TRI V.D 28.06.10 ADD //Team 7739 Upgrade 08062016
            BankAccountLedgerEntry."PO No." := GenJournalLine."PO No.";
            BankAccountLedgerEntry."Issuing Bank" := GenJournalLine."Issuing Bank"; //Team 7739 Upgrade 08062016
            BankAccountLedgerEntry."Online Bank Transfer" := GenJournalLine."Online Bank Transfer";
            BankAccountLedgerEntry."Beneficiary Account No." := GenJournalLine."Beneficiary Account No.";
            BankAccountLedgerEntry."Beneficiary Account Type" := GenJournalLine."Beneficiary Account Type";
            BankAccountLedgerEntry."Beneficiary IFSC Code" := GenJournalLine."Beneficiary IFSC Code";
            BankAccountLedgerEntry."Beneficiary Name" := GenJournalLine."Beneficiary Name";
            BankAccountLedgerEntry."Payment Mode" := GenJournalLine."Payment Mode";

        end;

     */
    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeCalculatedName', '', false, false)]
    local procedure OnBeforeCalculatedName(var Contact: Record Contact; var NewName: Text[100]; var IsHandled: Boolean);
    var
        NewName250: Text[250];
        Surname: Text;
        Name: Text;
        Text029: Label 'The total length of first name, middle name and surname is %1 character(s)longer than the maximum length allowed for the Name field.';

    begin
        IF Contact."First Name" <> '' THEN
            NewName250 := Contact."First Name";
        IF Contact."Middle Name" <> '' THEN
            NewName250 := NewName250 + ' ' + Contact."Middle Name";
        IF Surname <> '' THEN
            NewName250 := NewName250 + ' ' + Surname;

        NewName250 := DELCHR(NewName250, '<', ' ');

        IF STRLEN(NewName250) > MAXSTRLEN(Name) THEN
            ERROR(Text029, STRLEN(NewName250) - MAXSTRLEN(Name));

        NewName := NewName250;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Routing Line", 'OnBeforeAdjustComponents', '', false, false)]// 50212
    local procedure OnBeforeAdjustComponents(var ProdOrderComp: Record "Prod. Order Component");
    var
        ProdOrderRouLine: Record "Prod. Order Routing Line";
        ProdOrderLine: Record "Prod. Order Line";
    begin
        ProdOrderComp.SETRANGE(ProdOrderComp.Status, ProdOrderRouLine.Status);
        ProdOrderComp.SETRANGE(ProdOrderComp."Prod. Order No.", ProdOrderRouLine."Prod. Order No.");
        ProdOrderComp.SETRANGE(ProdOrderComp."Prod. Order Line No.", ProdOrderLine."Line No.");
        IF ProdOrderComp.FIND('-') THEN
            REPEAT
                ProdOrderComp.VALIDATE(ProdOrderComp."Routing Link Code");
                ProdOrderComp.MODIFY;
            UNTIL ProdOrderComp.NEXT = 0;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purch. Rcpt. Line", 'OnAfterCopyFromPurchRcptLine', '', false, false)]// 50009
    local procedure OnAfterCopyFromPurchRcptLine(var PurchaseLine: Record "Purchase Line"; PurchRcptLine: Record "Purch. Rcpt. Line"; var TempPurchLine: Record "Purchase Line");
    var
        PurchInvHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        PurchOrderLine: Record "Purchase Line";
    begin
        IF PurchInvHeader."No." <> TempPurchLine."Document No." THEN
            PurchInvHeader.GET(TempPurchLine."Document Type", TempPurchLine."Document No.");
        PurchLine."Shortcut Dimension 1 Code" := PurchInvHeader."Shortcut Dimension 1 Code";     //TRI DG 300910 Add

        // 15578  PurchLine."Assessee Code" := PurchInvHeader."Assessee Code"; //MSKS
        //PurchLine."Source Order No." := PurchRcptLine."Order No."; //TRI S.K. //Blocked by bcz field moved to other event TEAM 14763 
        IF PurchLine."Item Category Code" = 'T001' THEN
            PurchLine."ITC Type" := PurchLine."ITC Type"::"Input Goods";
        IF PurchOrderLine."Custom Duty Amount" <> 0 THEN
            PurchLine."Custom Duty Amount" := 0;
        IF PurchOrderLine."GST Assessable Value" <> 0 THEN
            PurchLine."GST Assessable Value" := 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purch. Rcpt. Line", 'OnAfterInitFromPurchLine', '', false, false)]// 50009
    local procedure OnAfterInitFromPurchLine(PurchRcptHeader: Record "Purch. Rcpt. Header"; PurchLine: Record "Purchase Line"; var PurchRcptLine: Record "Purch. Rcpt. Line");

    begin
        PurchRcptLine."Vendor Invoice No." := PurchRcptHeader."Vendor Invoice No."; //TRI A.S 180408

    end;

    [EventSubscriber(ObjectType::Table, Database::"Production Order", 'OnBeforeGetNoSeriesCode', '', false, false)]// 50209
    local procedure OnBeforeGetNoSeriesCode(var ProductionOrder: Record "Production Order"; MfgSetup: Record "Manufacturing Setup"; var NoSeriesCode: Code[20]; var IsHandled: Boolean);
    begin
        MfgSetup.GET;
        CASE ProductionOrder.Status OF
            ProductionOrder.Status::Released:
                //TRI S.R
                IF ProductionOrder."Depot. Prod Order" THEN
                    NoSeriesCode := MfgSetup."Sampling No. Series"
                ELSE
                    NoSeriesCode := MfgSetup."Released Order Nos.";

        //EXIT(MfgSetup."Released Order Nos."); //6700
        END;

    end;

    /* [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterSetupNewLine', '', false, false)]//50258
    local procedure OnAfterSetupNewLine(var GenJournalLine: Record "Gen. Journal Line"; GenJournalTemplate: Record "Gen. Journal Template"; GenJournalBatch: Record "Gen. Journal Batch"; LastGenJournalLine: Record "Gen. Journal Line"; Balance: Decimal; BottomLine: Boolean);
    var
        Narration: Text[100];
    begin
        IF (GenJournalLine."Account Type" IN [GenJournalLine."Account Type"::Customer, GenJournalLine."Account Type"::Vendor, GenJournalLine."Account Type"::"Fixed Asset"]) AND
   (GenJournalLine."Bal. Account Type" IN ["Bal. Account Type"::Customer, "Bal. Account Type"::Vendor, GenJournalLine."Bal. Account Type"::"Fixed Asset"])
    THEN
            GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
        GenJournalLine.VALIDATE("Bal. Account No.", GenJournalBatch."Bal. Account No.");
        //upgrade(+)
        Narration := '';
        //Upgrade(-)

    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnBeforeIsAdHocDescription', '', false, false)]// 50258
    local procedure OnBeforeIsAdHocDescription(GenJournalLine: Record "Gen. Journal Line"; xGenJournalLine: Record "Gen. Journal Line"; var Result: Boolean; var IsHandled: Boolean);
    var
        Narration: TEXT[100];
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        BankAccount: Record "Bank Account";
        FixedAsset: Record "Fixed Asset";
        ICPartner: Record "IC Partner";
    begin

        CASE xGenJournalLine."Account Type" OF
            xGenJournalLine."Account Type"::"G/L Account":
                Result := GLAccount.GET(xGenJournalLine."Account No.") AND (GLAccount.Name <> Narration);   //Discription Changed to narration
            xGenJournalLine."Account Type"::Customer:
                Result := Customer.GET(xGenJournalLine."Account No.") AND (Customer.Name <> Narration);   //Discription Changed to narration
            xGenJournalLine."Account Type"::Vendor:
                Result := Vendor.GET(xGenJournalLine."Account No.") AND (Vendor.Name <> Narration);        //Discription Changed to narration
            xGenJournalLine."Account Type"::"Bank Account":
                Result := BankAccount.GET(xGenJournalLine."Account No.") AND (BankAccount.Name <> Narration);   //Discription Changed to narration
            xGenJournalLine."Account Type"::"Fixed Asset":
                Result := FixedAsset.GET(xGenJournalLine."Account No.") AND (FixedAsset.Description <> Narration);  //Discription Changed to narration
            xGenJournalLine."Account Type"::"IC Partner":
                Result := ICPartner.GET(xGenJournalLine."Account No.") AND (ICPartner.Name <> Narration); //Discription Changed to narration
        END;
        Result := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnBeforeShowDeferrals', '', false, false)]// 50258
    local procedure OnBeforeShowDeferrals(GenJournalLine: Record "Gen. Journal Line"; var ReturnValue: Boolean; var IsHandled: Boolean);
    var
        DeferralUtilities: Codeunit "Deferral Utilities";
        PostingDate: Date;
        Narration: Text[100];
        CurrencyCode: Code[10];
    begin
        ReturnValue := (
       DeferralUtilities.OpenLineScheduleEdit(
         GenJournalLine."Deferral Code", "Deferral Document Type"::"G/L".AsInteger(), GenJournalLine."Journal Template Name", GenJournalLine."Journal Batch Name", 0, '', GenJournalLine."Line No.",
         GenJournalLine.GetDeferralAmount, PostingDate, Narration, CurrencyCode));

    end;

 */
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeCustBlockedErrorMessage', '', false, false)]
    local procedure OnBeforeCustBlockedErrorMessage(Cust2: Record Customer; Transaction: Boolean; var IsHandled: Boolean);// 50131
    var
        Text006: Label 'You cannot %1 this type of document when Customer %2 is blocked with type %3';
        Action: Text[30];
    begin
        IF (UPPERCASE(USERID) <> 'FA012') AND (UPPERCASE(USERID) <> 'FA014') AND (UPPERCASE(USERID) <> 'FA007') AND (UPPERCASE(USERID) <> 'FA003') AND (UPPERCASE(USERID) <> 'ADMIN') AND (UPPERCASE(USERID) <> 'FA015') THEN   //Kulbhushan 230913
            ERROR(Text006, Action, Cust2."No.", Cust2.Blocked);
    end;


    /* [EventSubscriber(ObjectType::Table, Database::"Incoming Document", 'OnCreateGenJnlLineOnBeforeGenJnlLineInsert', '', false, false)]
    local procedure OnCreateGenJnlLineOnBeforeGenJnlLineInsert(var Sender: Record "Incoming Document"; var GenJnlLine: Record "Gen. Journal Line"; LastGenJnlLine: Record "Gen. Journal Line");
    var
        LineNo: Integer;
        JournalTemplate: code[10];
        JournalBatch: Code[10];
    begin
        GenJnlLine.SETRANGE("Incoming Document Entry No.");

        Sender."Document Type" := Sender."Document Type"::Journal;
        IF GenJnlLine.FINDLAST THEN;
        LastGenJnlLine := GenJnlLine;
        LineNo := GenJnlLine."Line No." + 10000;
        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := JournalTemplate;
        GenJnlLine."Journal Batch Name" := JournalBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine.SetUpNewLine(LastGenJnlLine, 0, TRUE);
        GenJnlLine."Incoming Document Entry No." := Sender."Entry No.";
        //15578 GenJnlLine.Narration := COPYSTR(Description, 1, MAXSTRLEN(GenJnlLine.Narration));Fiels narration N/F
        //GenJnlLine.INSERT(TRUE);
        //15578 GenJnlLine.Narration := COPYSTR(Description, 1, MAXSTRLEN(GenJnlLine.Narration));Fiels narration N/F

    end;
 */
    /* [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', false, false)]// 50141
    local procedure OnAfterCopyVendLedgerEntryFromGenJnlLine(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line");
    begin
        // 15578    VendorLedgerEntry.Description := GenJournalLine.Narration;
        VendorLedgerEntry.Description2 := GenJournalLine.Description2; //Vipul Tri1.0 //Team 7739 Upgrade 08062016
                                                                       //Team 7739 Upgrade 08062016 Start-
                                                                       //TRI
        VendorLedgerEntry."Entry No. 3.7" := GenJournalLine."Entry No. 3.7";
        VendorLedgerEntry."Closed By Entry No. 3.7" := GenJournalLine."Closed By Entry No. 3.7";
        VendorLedgerEntry."Closed By Amount 3.7" := GenJournalLine."Closed By Amount 3.7";
        //TRI
        //Team 7739 Upgrade 08062016 End-

        //Team 7739 Upgrade 08062016 Start-
        VendorLedgerEntry."Cheque No." := GenJournalLine."Cheque No.";
        VendorLedgerEntry."Cheque Date" := GenJournalLine."Cheque Date";
        //Team 7739 Upgrade 08062016 End-
        VendorLedgerEntry.Comment := GenJournalLine.Comment; //MS
    end;
 */
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeCalcBaseQty', '', false, false)]// 50186
    local procedure OnBeforeCalcBaseQty(var PurchaseLine: Record "Purchase Line"; Qty: Decimal; FromFieldName: Text; ToFieldName: Text);
    begin
        IF PurchaseLine."Prod. Order No." = '' THEN
            PurchaseLine.TESTFIELD(PurchaseLine."Qty. per Unit of Measure");
        Qty := Qty * ROUND(PurchaseLine."Qty. per Unit of Measure", 0.00001, '=');         //TRI ADD

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterUpdateLineDiscPct', '', false, false)]// 50186
    local procedure OnAfterUpdateLineDiscPct(var PurchaseLine: Record "Purchase Line");
    var
        LineDiscountPct: Decimal;
        currency: Record Currency;
        LineDiscountPctErr: Label 'The value in the Line Discount % field must be between 0 and 100.';
    begin
        IF ROUND(PurchaseLine.Quantity * PurchaseLine."Direct Unit Cost", Currency."Amount Rounding Precision") <> 0 THEN BEGIN
            IF NOT (LineDiscountPct IN [-1 .. 100]) THEN
                ERROR(LineDiscountPctErr);
            PurchaseLine."Line Discount %" := LineDiscountPct;
        END ELSE
            PurchaseLine."Line Discount %" := 0;

    end;

    //TEAM 14763 [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnUpdateAmountsOnAfterCalcLineAmount', '', false, false)]// 50179
    local procedure OnUpdateAmountsOnAfterCalcLineAmount(var Sender: Record "Sales Line"; var SalesLine: Record "Sales Line"; var LineAmount: Decimal);
    var
        Currency: Record Currency;
        BaseUOM: Record "Item Unit of Measure";
    begin
        IF SalesLine."Line Amount" <> ROUND(SalesLine.Quantity * SalesLine."Unit Price", Currency."Amount Rounding Precision")
        - (SalesLine."Line Discount Amount" + SalesLine."Quantity Discount Amount") THEN BEGIN   //Shakti ADD Quantity Discount Amount
            SalesLine."Line Amount" := ROUND(SalesLine.Quantity * SalesLine."Unit Price", Currency."Amount Rounding Precision")
               - (SalesLine."Line Discount Amount" + SalesLine."Quantity Discount Amount"); //Shakti Add Quantity Discount Amount
            SalesLine."VAT Difference" := 0;

            //Upgrade(+)
            IF SalesLine.Quantity <> 0 THEN  //ND
                IF BaseUOM.GET(SalesLine."No.", SalesLine."Unit of Measure") THEN
                    IF BaseUOM."Qty. per Unit of Measure" <> 0 THEN
                        // 15578    SalesLine."Buyer's Price" := ROUND(((SalesLine."Line Amount" + SalesLine."Excise Amount") / SalesLine.Quantity) / BaseUOM."Qty. per Unit of Measure", 0.01);
                        //IF "Buyer's Price" <> 0 THEN
                        IF SalesLine.Quantity <> 0 THEN  //ND 6700
                            IF BaseUOM.GET(SalesLine."No.", SalesLine."Unit of Measure Code") THEN
                                IF BaseUOM."Qty. per Unit of Measure" <> 0 THEN
                                    SalesLine.Validate(SalesLine."Buyer's Price /Sq.Mt", ROUND(((SalesLine."Line Amount") / SalesLine.Quantity) / BaseUOM."Qty. per Unit of Measure", 0.01));
            //Upgrade(-)
        END;


    end;

    //TEAM 14763 [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnShowItemChargeAssgntOnAfterCurrencyInitialize', '', false, false)] // 50179
    local procedure OnShowItemChargeAssgntOnAfterCurrencyInitialize(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; var Currency: Record Currency);
    var
        ItemChargeAssgntLineAmt: Decimal;
        ItemChargeAssgntSales: Record "Item Charge Assignment (Sales)";
    begin
        IF (SalesLine."Inv. Discount Amount" = 0) AND
(SalesLine."Line Discount Amount" = 0) AND
  //upgrade(+)
  (SalesLine."Quantity Discount Amount" = 0) AND  //SHAKTI
                                                  //Upgrade(-)
(NOT SalesHeader."Prices Including VAT")
THEN
            ItemChargeAssgntLineAmt := SalesLine."Line Amount"
        ELSE
            IF SalesHeader."Prices Including VAT" THEN
                ItemChargeAssgntLineAmt :=
                  ROUND((SalesLine."Line Amount" - SalesLine."Inv. Discount Amount") / (1 + SalesLine."VAT %" / 100),
                    Currency."Amount Rounding Precision")
            ELSE
                ItemChargeAssgntLineAmt := SalesLine."Line Amount" - SalesLine."Inv. Discount Amount";
        ItemChargeAssgntSales.RESET;
        ItemChargeAssgntSales.SETRANGE("Document Type", SalesLine."Document Type");
        ItemChargeAssgntSales.SETRANGE("Document No.", SalesLine."Document No.");
        ItemChargeAssgntSales.SETRANGE("Document Line No.", SalesLine."Line No.");
        ItemChargeAssgntSales.SETRANGE("Item Charge No.", SalesLine."No.");
        IF NOT ItemChargeAssgntSales.FINDLAST THEN BEGIN
            ItemChargeAssgntSales."Document Type" := SalesLine."Document Type";
            ItemChargeAssgntSales."Document No." := SalesLine."Document No.";
            ItemChargeAssgntSales."Document Line No." := SalesLine."Line No.";
            ItemChargeAssgntSales."Item Charge No." := SalesLine."No.";
            ItemChargeAssgntSales."Unit Cost" :=
              ROUND(ItemChargeAssgntLineAmt / SalesLine.Quantity,
                Currency."Unit-Amount Rounding Precision");
        END;
    end;

    //TEAM 14763 [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnUpdateLineDiscPctOnAfterCalcIsOutOfStandardDiscPctRange', '', false, false)]// 50179
    local procedure OnUpdateLineDiscPctOnAfterCalcIsOutOfStandardDiscPctRange(var SalesLine: Record "Sales Line"; var IsOutOfStandardDiscPctRange: Boolean);
    var
        Currency: Record Currency;
        LineDiscountPct: Decimal;
        LineDiscountPctErr: Label 'The value in the Line Discount % field must be between 0 and 100.';
    begin
        IF ROUND(SalesLine.Quantity * SalesLine."Unit Price", Currency."Amount Rounding Precision") <> 0 THEN BEGIN
            LineDiscountPct := ROUND(
               SalesLine."Line Discount Amount" / ROUND(SalesLine.Quantity * SalesLine."Unit Price", Currency."Amount Rounding Precision") * 100,
                0.00001);
            IF NOT (LineDiscountPct IN [-100 .. 1000]) THEN// add
                ERROR(LineDiscountPctErr);
            SalesLine."Line Discount %" := LineDiscountPct;
        END ELSE
            SalesLine."Line Discount %" := 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeZeroAmountLine', '', false, false)]// 50179
    local procedure OnBeforeZeroAmountLine(var SalesLine: Record "Sales Line"; QtyType: Option; var Result: Boolean; var IsHandled: Boolean);
    begin
        IF (SalesLine."Unit Price" = 0) THEN  //TRI DG Add
            Result := true;
    end;

    //TEAM 14763 [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterGetLineAmountToHandle', '', false, false)]// 50179
    local procedure OnAfterGetLineAmountToHandle(SalesLine: Record "Sales Line"; QtyToHandle: Decimal; var LineAmount: Decimal; var LineDiscAmount: Decimal);
    var
        Currency: Record Currency;
    begin
        IF QtyToHandle <> SalesLine.Quantity THEN
            LineDiscAmount := ROUND(SalesLine."Line Discount Amount" * QtyToHandle / SalesLine.Quantity, Currency."Amount Rounding Precision")
        ELSE
            LineDiscAmount := SalesLine."Line Discount Amount";
        LineAmount := SalesLine."Line Amount"
    end;

    //TEAM 14763 [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterCalcInvDiscToInvoice', '', false, false)]
    local procedure OnAfterCalcInvDiscToInvoice(var SalesLine: Record "Sales Line"; OldInvDiscAmtToInv: Decimal);
    var
        SalesHeader: Record "Sales Header";
        RecDiscountHeader: Record "Discount Header";
        RecSlab: Record Slabs;
        Month: Integer;
        Year: Integer;
        StartDate: Date;
        RSalesLin: Record "Sales Line";
        AccruedDisc: Decimal;
        AlreadyDisGiven: Decimal;
        DiscinCurrentDoc: Decimal;
    begin
        /*
                //Upgrade(+)

                //SHAKTI -Start
                //NEW
                IF (SalesHeader."Calculate Discount" = TRUE) OR (SalesHeader."Calculate Discount" = FALSE) THEN BEGIN
                    //"Offer Code" := QDFunctions.ReturnDiscountSchemeInclude(SalesHeader);
                    SalesLine.Validate(SalesLine."Offer Code", SalesLine.GetOfferCodeNew(SalesHeader, SalesLine));

                    RecDiscountHeader.RESET;
                    IF RecDiscountHeader.GET(SalesLine."Offer Code") THEN;
                    //VALIDATE(Slab,RecDiscountHeader."Slab Group");

                    RecSlab.RESET;
                    RecSlab.SETRANGE(RecSlab."Slab Group", RecDiscountHeader."Slab Group");
                    IF RecSlab.FINDFIRST THEN;

                    IF SalesHeader."Posting Date" <> 0D THEN BEGIN
                        Month := DATE2DMY(SalesHeader."Posting Date", 2);
                        Year := DATE2DMY(SalesHeader."Posting Date", 3);

                        StartDate := DMY2DATE(1, Month, Year);
                    END;

                    QDQuantity := 0;
                    RSalesLin.RESET;
                    IF RSalesLin."Document Type" = RSalesLin."Document Type"::Order THEN
                        RSalesLin.SETRANGE(RSalesLin."Document Type", "Document Type"::Order)
                    ELSE
                        RSalesLin.SETRANGE(RSalesLin."Document Type", RSalesLin."Document Type");

                    RSalesLin.SETRANGE(RSalesLin."Document No.", SalesLine."Document No.");
                    RSalesLin.SETRANGE(RSalesLin."Offer Code", SalesLine."Offer Code");
                    RSalesLin.SETRANGE(RSalesLin.Slab, SalesLine.Slab);
                    RSalesLin.SETRANGE(RSalesLin."Calculate Line Discount", TRUE);
                    IF RSalesLin.FIND('-') THEN BEGIN
                        REPEAT
                            IF SalesLine."Document Type" = SalesLine."Document Type"::"Credit Memo" THEN
                                QDQuantity += RSalesLin."Return Qty. to Receive"
                            ELSE
                                // QDQuantity+=RSalesLin."Qty. to Ship";
                                QDQuantity += RSalesLin."Quantity in Sq. Mt.(Ship)";
                        UNTIL RSalesLin.NEXT = 0;
                    END;
                    //Total Qty

                    AccruedDisc := QDFunctions.GetQDQuantity(SalesLine."Sell-to Customer No.", QDFunctions.GetStartDate(SalesHeader."Posting Date", RecSlab.Period),
                                QDFunctions.GetEndDate(SalesHeader."Posting Date", RecSlab.Period), salesline."Offer Code");

                    //Slab
                    DisonQty2Ship := QDFunctions.GetDiscountValue(SalesLine."Offer Code", (QDQuantity + AccruedDisc));
                    Qty2Ship := QDFunctions.GetDiscountValue(SalesLine."Offer Code", (AccruedDisc));
                    AccruedQty := (DisonQty2Ship - Qty2Ship) * AccruedDisc; //1320
                                                                            //Already Discount Given
                    AlreadyDisGiven := QDFunctions.GetAlreadyQDGiven(salesline."Sell-to Customer No.", QDFunctions.GetStartDate(SalesHeader."Posting Date"
                                      , RecSlab.Period), QDFunctions.GetEndDate(SalesHeader."Posting Date", RecSlab.Period), salesline."Offer Code");

                    //MESSAGE('AccruedDisc-%1',AccruedDisc);
                    //DiscinCurrentDoc := ((AccruedDisc+"Quantity in Sq. Mt.(Ship)") * DisonQty2Ship) - AlreadyDisGiven;
                    DiscinCurrentDoc := ((salesline."Quantity in Sq. Mt.(Ship)") * DisonQty2Ship); //7700


                    IF QDQuantity <> 0 THEN
                        AccuredDiscount := (((salesline."Quantity in Sq. Mt.(Ship)") / QDQuantity) * AccruedQty);
                    // (220 / 495) *1320
                    IF salesline."Quantity in Sq. Mt.(Ship)" <> 0 THEN BEGIN
                        SalesLine.Validate(salesline."Accrued Discount", AccuredDiscount);

                        DiscinCurrentDoc := ((((DiscinCurrentDoc * salesline."Quantity in Sq. Mt.") / salesline."Quantity in Sq. Mt.(Ship)") +
                                                 //                          AccuredDiscount));
                                                 ((AccuredDiscount * SalesLine."Quantity in Sq. Mt.") / salesline."Quantity in Sq. Mt.(Ship)")));
                        //MESSAGE('%1',AccuredDiscount);
                    END;

                    IF salesline."Return Qty. to Receive" <> 0 THEN
                        DiscinCurrentDoc := (((DiscinCurrentDoc * salesline.Quantity) / salesline."Return Qty. to Receive"));
                    IF salesline."Document Type" = salesline."Document Type"::Order THEN
                        salesline.validate(salesline."Quantity Discount Amount", DiscinCurrentDoc);
                END
                ELSE
                    salesline.Validate("Quantity Discount Amount", 0);

                IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN BEGIN
                    IF (salesline."Calculate Line Discount" = TRUE) THEN
                        salesline.Validate(salesline."Quantity Discount Amount", DiscinCurrentDoc)
                    ELSE
                        salesline.Validate(salesline."Quantity Discount Amount", 0);
                END;
                //MESSAGE('AlreadyDisGiven - %1 DiscinCurrentDoc - %2 AccuredDiscount - %3',AlreadyDisGiven,DiscinCurrentDoc,AccuredDiscount);
                //Shakti-End

                //Upgrade(-)

              */
    end;

    var
        QDQuantity: Decimal;
        QDFunctions: Codeunit "Quality Discount Functions";
        DisonQty2Ship: Decimal;
        Qty2Ship: Decimal;
        AccruedQty: Decimal;
        AccuredDiscount: Decimal;
}