codeunit 50108 "Extend 80"
{
    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean)
    var
        SalesLine: Record 37;
        TriCommingFromShpt: Boolean;
    begin

        SalesHeader.TestField(Status, SalesHeader.Status::Released); //TEAM 14763

        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETFILTER(Quantity, '<>0');
        if SalesLine.FindFirst() then;

        IF NOT SalesHeader.COCO THEN
            SalesLine.TESTFIELD("FA Posting Date", 0D);

        TriCommingFromShpt := FALSE;   //tri1.0 Vipul

        IF (SalesHeader."Add Insu Discount" <> 0) AND (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) THEN BEGIN  // Main1 Starts                                                                                                                                     //  Add insu discount is applicable only for Qc discunt
            IF SalesHeader."Add Insu Discount" > 0 THEN
                ERROR('Qc Discount must be negative or zero');
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean)
    var
        CDMgt: codeunit 50032;
        salesLineL: Record 37;
        SalesRecivableSetup: Record "Sales & Receivables Setup";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        Clear(SalesInvoiceHeader);
        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SetRange("No.", SalesInvHdrNo);
        if SalesInvoiceHeader.FindFirst then begin
            if SalesInvoiceHeader."Trade Discount" <> 0 then
                CDMgt.UtiliseCD(SalesInvoiceHeader, -SalesInvoiceHeader."Trade Discount", SalesInvoiceHeader."No.");
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesInvLineInsert', '', false, false)]
    local procedure OnBeforeSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; PostingSalesLine: Record "Sales Line"; SalesShipmentHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header"; var ReturnReceiptHeader: Record "Return Receipt Header")
    var
        Item: Record Item;
    begin
        IF SalesInvLine.Type = SalesInvLine.Type::Item THEN BEGIN
            Item.GET(SalesInvLine."No.");
            SalesInvLine."V. Cost" := Item."V. Cost";
            SalesInvLine."Quantity in Sq. Mt." := Item.UomToSqm(SalesInvLine."No.", SalesInvLine."Unit of Measure Code", SalesInvLine.Quantity);
            SalesInvLine."Quantity in Cartons" := Item.UomToCart(SalesInvLine."No.", SalesInvLine."Unit of Measure Code", SalesInvLine.Quantity);
            SalesInvLine."Gross Weight" := ROUND(Item."Gross Weight" * SalesLine."Qty. per Unit of Measure", 0.001, '=') * SalesLine."Qty. to Ship";
            SalesInvLine."Net Weight" := ROUND(Item."Net Weight" * SalesLine."Qty. per Unit of Measure", 0.001, '=') * SalesLine."Qty. to Ship";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterInsertInvoiceHeader', '', false, false)]
    local procedure OnAfterInsertInvoiceHeader(var SalesHeader: Record "Sales Header"; var SalesInvHeader: Record "Sales Invoice Header")
    var
        SalesSetup: Record "Sales & Receivables Setup";
        QualityDiscountFunctions: Codeunit "Quality Discount Functions";
        SalesLine, RecSalesLine : Record 37;
        PostedDocNo: Code[30];
        RecItemCharge: Record "Item Charge";
        SalesRecsetup: Record "Sales & Receivables Setup";
        RecSalaesHeader: Record "Sales Header";
    begin
        Clear(RecItemCharge);
        Clear(RecSalesLine);

        RecItemCharge.Reset;
        RecItemCharge.SetRange("No.", 'TRDDISC');
        if RecItemCharge.FindFirst then begin
            RecSalesLine.Reset;
            RecSalesLine.SetRange("Document No.", SalesHeader."No.");
            RecSalesLine.setrange("No.", RecItemCharge."GL Account");
            if RecSalesLine.FindFirst then begin
                RecSalesLine.CalcSums("Line Amount");
                SalesInvHeader."Trade Discount" := RecSalesLine."Line Amount";
            end;
        end;

        //Trade Amount
        SalesInvHeader."Trade Discount" := SalesHeader."Trade Discount";
        //Trade Amount

        //Freight
        SalesRecsetup.GET;
        if SalesRecsetup."Structure Frieght" <> '' then begin
            if SalesHeader."Structure Freight Amount" <> 0 then begin
                RecItemCharge.Reset;
                RecItemCharge.setrange("No.", SalesRecsetup."Structure Frieght");
                if RecItemCharge.FindFirst then begin
                    RecSalesLine.Reset;
                    RecSalesLine.SetRange("Document No.", SalesHeader."No.");
                    RecSalesLine.SetRange("No.", RecItemCharge."GL Account");
                    if RecSalesLine.FindFirst then begin
                        SalesInvHeader."Freight Amt" := SalesHeader."Structure Freight Amount";
                    end;
                end;
            end;
        end;
        //Freight

        Clear(RecItemCharge);
        Clear(RecSalesLine);

        if SalesRecsetup."Insurance Structure" <> '' then begin
            RecItemCharge.Reset;
            RecItemCharge.setrange("No.", SalesRecsetup."Insurance Structure");
            if RecItemCharge.FindFirst then begin
                if RecItemCharge."Insurance Percentage" <> 0 then begin
                    RecSalesLine.Reset;
                    RecSalesLine.SetRange("Document No.", SalesHeader."No.");
                    RecSalesLine.SetRange("No.", SalesRecsetup."Insurance Structure");
                    if RecSalesLine.FindSet then begin
                        RecSalesLine.CalcSums("Line Amount");
                        SalesInvHeader."Insurance Amount" := RecSalesLine."Line Amount";
                        SalesInvHeader."Insurance Amt" := RecSalesLine."Line Amount";
                    end;
                end;
            end;
        end;
        //TEAM 14763

        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETFILTER(Quantity, '<>0');
        if SalesLine.FindFirst() then;


        //SHAKTI -Start
        IF SalesSetup."QD Applicable" = TRUE THEN BEGIN
            QualityDiscountFunctions.CreateQDEntry(SalesLine."Document Type".AsInteger(),
            SalesLine."Document No.", SalesLine."Sell-to Customer No.", SalesLine."Line Amount",
            SalesLine.Quantity, SalesLine.Quantity, SalesHeader."Posting Date", SalesLine.Quantity, TRUE, SalesHeader, SalesInvHeader."No.");
        END;
        //Shakti-End

        PostedDocNo := SalesInvHeader."No.";
        IF PostedDocNo <> '' THEN
            MESSAGE('The Invoice No. %1 has been posted', PostedDocNo);
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterCheckSalesDoc', '', false, false)]
    local procedure OnAfterCheckSalesDoc(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; WhseShip: Boolean; WhseReceive: Boolean)
    var
        RecInvInsDisc: Record 50058;
        TotRemAmt: Decimal;
        TotQcAmt: Decimal;
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesSetup: Record "Sales & Receivables Setup";
        SalesLine1: Record 37;
        CustomerLedgerEntry1: Record 21;
        SalesInvoiceHeader1: Record 112;
        PromptPmt: Record 50025;
    begin
        RecInvInsDisc.RESET;
        RecInvInsDisc.SETCURRENTKEY(CustId, cAmount, cDate);
        RecInvInsDisc.SETRANGE(RecInvInsDisc.cFlag, '%1', 'SAVED');
        RecInvInsDisc.SETRANGE(RecInvInsDisc.CustId, SalesHeader."Sell-to Customer No.");
        RecInvInsDisc.SETRANGE(RecInvInsDisc.AmountToGive, TRUE);
        IF NOT RecInvInsDisc.FIND('-') THEN
            TotRemAmt := 0
        ELSE BEGIN
            RecInvInsDisc.FINDFIRST;
            REPEAT
                TotRemAmt += RecInvInsDisc."Remaining Amount";
            UNTIL RecInvInsDisc.NEXT = 0;
            IF TotRemAmt + 10 < TotQcAmt THEN
                ERROR('Qc Amount %1 is greater than the Remaining Amount %2', TotQcAmt, TotRemAmt);
        END;

        // Main 1 ends
        //sash


        //Pr Tri1.0 Customization No. 5.3.6 Start
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) THEN BEGIN
            // SalesHeader.Deleted := TRUE;
            //SalesHeader.MODIFY;
            // IF NOT SalesHeader.COCO THEN //TSPL LM
            //   ArchiveManagement.StoreSalesDocument(SalesHeader, FALSE);
        END;
        //Pr Tri1.0 Customization No. 5.3.6 End
        SalesHeader."Promised Delivery Date" := 0D; //MSKS0509

        //ND Tri1.0 Cust 22 Start
        SalesSetup.GET;
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" THEN BEGIN
            SalesLine1.RESET;
            SalesLine1.SETFILTER(SalesLine1."Document Type", '%1', SalesLine1."Document Type"::"Credit Memo");
            SalesLine1.SETFILTER(SalesLine1."Document No.", SalesHeader."No.");
            SalesLine1.SETFILTER(SalesLine1.Type, '%1', SalesLine1.Type::"G/L Account");
            SalesLine1.SETFILTER(SalesLine1."No.", SalesSetup."Prompt Pmt. Account No.");
            IF SalesLine1.FIND('-') THEN BEGIN
                CustomerLedgerEntry1.RESET;
                CustomerLedgerEntry1.SETFILTER(CustomerLedgerEntry1."Applies-to ID", SalesLine1."Document No.");
                IF CustomerLedgerEntry1.FIND('-') THEN BEGIN
                    REPEAT
                        IF PromptPmt.GET(CustomerLedgerEntry1."Document No.") THEN BEGIN
                            IF SalesInvoiceHeader1.GET(PromptPmt."Invoice No.") THEN
                                IF SalesInvoiceHeader1."Prompt Pmt. Discount" <> 0 THEN BEGIN
                                    ERROR('Prompt Payment Discount for %1 has already been posted.', SalesHeader."Sell-to Customer Name");
                                END ELSE BEGIN
                                    SalesInvoiceHeader1."Prompt Pmt. Discount" := PromptPmt."Discount Amount";
                                    // SalesInvoiceHeader1.MODIFY;
                                    PromptPmt."Credit Memo No." := SalesHeader."No.";
                                    PromptPmt.MODIFY;
                                END;
                        END;
                    UNTIL CustomerLedgerEntry1.NEXT = 0;
                END ELSE BEGIN
                    ERROR('Someone else has generated another Prompt Payment Credit Memo for %1 after you.', SalesHeader."Sell-to Customer Name");
                END;
            END;
        END;
        //ND Tri1.0 Cust 22 Start
    END;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesShptLineInsert', '', false, false)]
    local procedure OnBeforeSalesShptLineInsert(var SalesShptLine: Record "Sales Shipment Line"; SalesShptHeader: Record "Sales Shipment Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; PostedWhseShipmentLine: Record "Posted Whse. Shipment Line"; SalesHeader: Record "Sales Header"; WhseShip: Boolean; WhseReceive: Boolean; ItemLedgShptEntryNo: Integer; xSalesLine: record "Sales Line"; var TempSalesLineGlobal: record "Sales Line" temporary; var IsHandled: Boolean)
    var
        Item: Record 27;
    begin
        //TRI VS 230410 Add Start
        IF Item.GET(TempSalesLineGlobal."No.") THEN BEGIN
            IF (Item."Item Category Code" = 'M001') OR (Item."Item Category Code" = 'T001') THEN BEGIN
                IF NOT (TempSalesLineGlobal."Unit of Measure Code" IN ['CRT', 'PCS.']) THEN
                    ERROR('UOM should be CRT or PCS. Please Select CRT or PCS');
            END;
        END;
        //TRI VS 230410 Add Stop
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesInvLineInsert', '', false, false)]
    local procedure OnAfterSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; ItemLedgShptEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean; CommitIsSuppressed: Boolean; var SalesHeader: Record "Sales Header"; var TempItemChargeAssgntSales: Record "Item Charge Assignment (Sales)" temporary; var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; PreviewMode: Boolean)
    var
        Item: Record 27;
        Month: Integer;
    begin
        //MSAK.BEGIN 080515
        SalesInvLine."Discount Amt 1" := SalesLine."Quantity in Sq. Mt.(Ship)" * SalesLine.D1;
        SalesInvLine."Discount Amt 2" := SalesLine."Quantity in Sq. Mt.(Ship)" * SalesLine.D2;
        SalesInvLine."Discount Amt 3" := SalesLine."Quantity in Sq. Mt.(Ship)" * SalesLine.D3;
        SalesInvLine."Discount Amt 4" := SalesLine."Quantity in Sq. Mt.(Ship)" * SalesLine.D4;
        SalesInvLine."Discount Amt 6" := SalesLine."Quantity in Sq. Mt.(Ship)" * SalesLine.D6;
        // SalesInvLine."Discount Amt 7" := SalesLine."Quantity in Sq. Mt.(Ship)"*SalesLine.D7;

        SalesInvLine.D7 := 0;
        SalesInvLine."Discount Amt 7" := 0;
        SalesInvLine."System Discount Amount" := SalesLine."Quantity in Sq. Mt.(Ship)" * SalesLine.S1;
        SalesInvLine."Sales Type" := SalesLine."Sales Type";

        //SalesInvLine."Inv. Discount Amount" := (SalesInvLine."Trade Discount Amount" + SalesInvLine."Structure Discount Amount") * SalesInvLine.Quantity;

        //MSAK.END 080515
        //Rahul Start 050406
        /*
        Code has been moved from Event OnAfterSalesInvLineInsert to Event OnBeforeSalesInvLineInsert
        IF SalesInvLine.Type = SalesInvLine.Type::Item THEN BEGIN
            Item.GET(SalesInvLine."No.");
            SalesInvLine."V. Cost" := Item."V. Cost";
            SalesInvLine."Quantity in Sq. Mt." := Item.UomToSqm(SalesInvLine."No.", SalesInvLine."Unit of Measure Code", SalesInvLine.Quantity);
            SalesInvLine."Quantity in Cartons" := Item.UomToCart(SalesInvLine."No.", SalesInvLine."Unit of Measure Code", SalesInvLine.Quantity);
            SalesInvLine."Gross Weight" := ROUND(Item."Gross Weight" * SalesLine."Qty. per Unit of Measure", 0.001, '=') * SalesLine."Qty. to Ship";
            SalesInvLine."Net Weight" := ROUND(Item."Net Weight" * SalesLine."Qty. per Unit of Measure", 0.001, '=') * SalesLine."Qty. to Ship";
        end;
        Code has been moved from Event OnAfterSalesInvLineInsert to Event OnBeforeSalesInvLineInsert
        */

        //Msdr.begin


        Month := DATE2DMY(SalesInvLine."Posting Date", 2);
        CASE Month OF
            1:
                SalesInvLine.Month := SalesInvLine.Month::Jan;
            2:
                SalesInvLine.Month := SalesInvLine.Month::Feb;
            3:
                SalesInvLine.Month := SalesInvLine.Month::Mar;
            4:
                SalesInvLine.Month := SalesInvLine.Month::April;
            5:
                SalesInvLine.Month := SalesInvLine.Month::May;
            6:
                SalesInvLine.Month := SalesInvLine.Month::Jun;
            7:
                SalesInvLine.Month := SalesInvLine.Month::July;
            8:
                SalesInvLine.Month := SalesInvLine.Month::Aug;
            9:
                SalesInvLine.Month := SalesInvLine.Month::Sep;
            10:
                SalesInvLine.Month := SalesInvLine.Month::Oct;
            11:
                SalesInvLine.Month := SalesInvLine.Month::Nov;
            12:
                SalesInvLine.Month := SalesInvLine.Month::Dec;
        END;
        //msdr.end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnRunOnBeforePostICGenJnl', '', false, false)]
    local procedure OnRunOnBeforePostICGenJnl(var SalesHeader: Record "Sales Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header");
    var
        CDMgt: codeunit 50032;
        salesLineL: Record 37;
        SalesRecivableSetup: Record "Sales & Receivables Setup";
    begin
        // SalesInvoiceHeader.CALCFIELDS(SalesInvoiceHeader."CD Availed from Utilisation");

        /*
        salesLineL.reset;
        salesLineL.setrange("Document Type", SalesHeader."Document Type");
        salesLineL.setrange("Document No.", SalesHeader."No.");
        salesLineL.setrange(Type, salesLineL.Type::"Charge (Item)");
        salesLineL.setrange("No.", 'TRDDISC');
        IF salesLineL.FindFirst() then begin
            CDMgt.UtiliseCD(SalesInvoiceHeader, -salesLineL."Line Amount", SalesInvoiceHeader."No.");
        end;
        */
    end;


    [EventSubscriber(ObjectType::Table, 37, 'OnValidateQuantityOnAfterCalcBaseQty', '', false, false)]
    local procedure OnValidateQuantityOnAfterCalcBaseQty(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line")
    var
        BaseUOM: Record "Item Unit of Measure";
    begin
        if SalesLine.Type = SalesLine.Type::Item then
            IF SalesLine.Quantity <> 0 THEN  //ND
                IF BaseUOM.GET(SalesLine."No.", SalesLine."Unit of Measure") THEN
                    IF BaseUOM."Qty. per Unit of Measure" <> 0 THEN
                        SalesLine."Buyer's Price" := ROUND(((SalesLine."Line Amount") / SalesLine.Quantity) / BaseUOM."Qty. per Unit of Measure", 0.01);

        if SalesLine.Type = SalesLine.Type::Item then
            IF SalesLine.Quantity <> 0 THEN  //ND 6700
                IF BaseUOM.GET(SalesLine."No.", SalesLine."Unit of Measure Code") THEN
                    IF BaseUOM."Qty. per Unit of Measure" <> 0 THEN
                        SalesLine.VALIDATE("Buyer's Price /Sq.Mt", ROUND(((SalesLine."Line Amount") / SalesLine.Quantity) / BaseUOM."Qty. per Unit of Measure", 0.01));

        if SalesLine.Type = SalesLine.Type::Item then
            if (SalesLine.Quantity <> 0) then
                SalesLine."Buyer's Price" := SalesLine."Line Amount" / SalesLine.Quantity;

        if SalesLine.Type = SalesLine.Type::Item then
            if SalesLine.Quantity = 0 then begin
                SalesLine."Buyer's Price" := 0;
                SalesLine."Buyer's Price /Sq.Mt" := 0;
            end;
        //IF Quantity <> 0 THEN                                     //ND
        //    "Buyer's Price" := ("Line Amount" + "Excise Amount") / Quantity;
    end;

    //TEAM 14763
    [EventSubscriber(ObjectType::Table, 37, 'OnAfterUpdateAmountsDone', '', false, false)]
    local procedure OnAfterUpdateAmountsDone(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    var
        BaseUOM: Record "Item Unit of Measure";
    begin
        //Upgrade(+)
        IF SalesLine.Quantity <> 0 THEN  //ND
            IF BaseUOM.GET(SalesLine."No.", SalesLine."Unit of Measure") THEN
                IF BaseUOM."Qty. per Unit of Measure" <> 0 THEN
                    SalesLine."Buyer's Price" := ROUND(((SalesLine."Line Amount") / SalesLine.Quantity) / BaseUOM."Qty. per Unit of Measure", 0.01);
        //IF "Buyer's Price" <> 0 THEN

        IF SalesLine.Quantity <> 0 THEN  //ND 6700
            IF BaseUOM.GET(SalesLine."No.", SalesLine."Unit of Measure Code") THEN
                IF BaseUOM."Qty. per Unit of Measure" <> 0 THEN
                    SalesLine.VALIDATE("Buyer's Price /Sq.Mt", ROUND(((SalesLine."Line Amount") / SalesLine.Quantity) / BaseUOM."Qty. per Unit of Measure", 0.01));

        if SalesLine.Type = SalesLine.Type::Item then
            if (SalesLine.Quantity <> 0) then
                SalesLine."Buyer's Price" := SalesLine."Line Amount" / SalesLine.Quantity;

        if SalesLine.Type = SalesLine.Type::Item then
            if SalesLine.Quantity = 0 then begin
                SalesLine."Buyer's Price" := 0;
                SalesLine."Buyer's Price /Sq.Mt" := 0;
            end;
        //Upgrade(-)
    end;
    //TEAM 14763


    /* [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostCustomerEntry', '', false, false)]
    local procedure OnAfterPostCustomerEntry(var GenJnlLine: Record "Gen. Journal Line"; var SalesHeader: Record "Sales Header"; var TotalSalesLine: Record "Sales Line"; var TotalSalesLineLCY: Record "Sales Line"; CommitIsSuppressed: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line");
    var
        CDMgt: codeunit 50032;


    begin
        SalesInvHeader.CALCFIELDS(SalesInvHeader."CD Availed from Utilisation");
        CDMgt.UtiliseCD(SalesInvHeader, SalesInvHeader."CD Availed from Utilisation", SalesInvHeader."No.");

    end;
 
    /* 
        [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeInsertICGenJnlLine', '', false, false)]
        local procedure OnBeforeInsertICGenJnlLine(var ICGenJournalLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean)
        var
            CreateSO: Codeunit 50050;
        begin
            ICGenJournalLine.Narration := SalesHeader."Posting Description";

            ICGenJournalLine."Dealer Code" := SalesHeader."Dealer Code"; //6700
            ICGenJournalLine.Set := SalesHeader.BD; //6700
            ICGenJournalLine."Get." := SalesHeader.GPS; //6700
            ICGenJournalLine.Pet := SalesHeader.CKA; //6700
            CLEAR(CreateSO);
            CreateSO.InsertTMSData(SalesHeader."No."); //MSKS
       end;
     */
    /*   //// need to remove after update
      [EventSubscriber(ObjectType::Table, 36, 'OnBeforeConfirmUpdateAllLineDim', '', false, false)]
      local procedure OnBeforeConfirmUpdateAllLineDim(var SalesHeader: Record "Sales Header"; var xSalesHeader: Record "Sales Header"; NewParentDimSetID: Integer; OldParentDimSetID: Integer; var Confirmed: Boolean; var IsHandled: Boolean)
      begin
          IsHandled := true;
      end;
      //// need to remove after update
   */

}