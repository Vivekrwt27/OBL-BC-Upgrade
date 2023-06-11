codeunit 50036 "Issued Credit Mgt"
{

    trigger OnRun()
    begin
    end;

    var
        IssuedCreditDetails: Record "Issued Credit Details";


    procedure UtiliseCredit(SalesInvHeader: Record "Sales Invoice Header"; UtilisedAmt: Decimal)
    var
        IGSTAmt: Decimal;
        IGSTper: Decimal;
        SGSTAmt: Decimal;
        SGSTper: Decimal;
        CGSTAmt: Decimal;
        CGSTper: Decimal;
        GSTBaseAmt: Decimal;
        TotalAmount: Decimal;
        RecDGLE: Record "Detailed GST Ledger Entry";
        LineAmount: Decimal;
        SalesInvLine: Record "Sales Invoice Line";
    begin
        IGSTAmt := 0;
        SGSTAmt := 0;
        CGSTAmt := 0;
        LineAmount := 0;

        SalesInvLine.Reset();
        SalesInvLine.SetRange("Document No.", SalesInvHeader."No.");
        if SalesInvLine.FindSet() then
            repeat
                LineAmount += SalesInvLine."Line Amount";
            until SalesInvLine.Next() = 0;

        RecDGLE.RESET();
        RecDGLE.SETRANGE("Document No.", SalesInvHeader."No.");
        RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
        RecDGLE.SETRANGE("GST Component Code", 'IGST');
        IF RecDGLE.FINDFIRST THEN BEGIN
            REPEAT
                IGSTAmt += abs(RecDGLE."GST Amount");
            UNTIL RecDGLE.NEXT = 0;
        END;
        RecDGLE.RESET();
        RecDGLE.SETRANGE("Document No.", SalesInvHeader."No.");
        RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
        RecDGLE.SETRANGE("GST Component Code", 'SGST');
        IF RecDGLE.FINDFIRST THEN BEGIN
            REPEAT
                SGSTAmt += abs(RecDGLE."GST Amount");
            UNTIL RecDGLE.NEXT = 0;
        END;
        RecDGLE.RESET();
        RecDGLE.SETRANGE("Document No.", SalesInvHeader."No.");
        RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
        RecDGLE.SETRANGE("GST Component Code", 'CGST');
        IF RecDGLE.FINDFIRST THEN BEGIN
            REPEAT
                CGSTAmt += abs(RecDGLE."GST Amount");
            UNTIL RecDGLE.NEXT = 0;
        END;
        IssuedCreditDetails.INIT;
        IssuedCreditDetails."Document Type" := 1;
        IssuedCreditDetails."Entry No." := GetNexTPaymentEntryNo;
        IssuedCreditDetails."Cust. No." := SalesInvHeader."Sell-to Customer No.";
        IF UtilisedAmt > 0 THEN
            UtilisedAmt := -1 * UtilisedAmt;
        IssuedCreditDetails."Invoice Amount" := LineAmount + IGSTAmt + CGSTAmt + SGSTAmt;
        IssuedCreditDetails."Payment Amount" := UtilisedAmt;
        IssuedCreditDetails."State Code" := SalesInvHeader.State;
        IssuedCreditDetails."Invoice No." := SalesInvHeader."No.";
        IssuedCreditDetails."Sales Order No." := SalesInvHeader."No.";
        IssuedCreditDetails."Posting Date" := SalesInvHeader."Posting Date";
        IssuedCreditDetails.Amount := UtilisedAmt;
        IssuedCreditDetails.Posted := TRUE;
        IF IssuedCreditDetails.Amount <> 0 THEN
            IssuedCreditDetails.INSERT;
    end;


    procedure GetNexTPaymentEntryNo(): Integer
    var
        LocalIssuedCreditDetails: Record "Issued Credit Details";
    begin
        IF LocalIssuedCreditDetails.FINDLAST THEN
            EXIT(LocalIssuedCreditDetails."Entry No." + 1)
        ELSE
            EXIT(1);
    end;


    procedure PostEntries(ICD: Record "Issued Credit Details")
    begin
        ICD.TESTFIELD("Item Charge No.");
        ICD.TESTFIELD("Cust. No.");
        ICD.TESTFIELD("Posting Date");
        ICD.TESTFIELD(Amount);
        IssuedCreditDetails.INIT;
        IssuedCreditDetails."Document Type" := 0;
        IssuedCreditDetails."Entry No." := GetNexTPaymentEntryNo;
        IssuedCreditDetails."Cust. No." := ICD."Cust. No.";
        IssuedCreditDetails."Item Charge No." := ICD."Item Charge No.";
        IssuedCreditDetails."Posting Date" := ICD."Posting Date";
        IssuedCreditDetails.Amount := ICD.Amount;
        IssuedCreditDetails."Posting Date & Time" := CURRENTDATETIME;
        IssuedCreditDetails."External Doc. No." := ICD."External Doc. No.";
        IssuedCreditDetails.Narration := ICD.Narration;
        IssuedCreditDetails.Posted := TRUE;
        IF IssuedCreditDetails.Amount <> 0 THEN
            IssuedCreditDetails.INSERT(TRUE);
    end;


    procedure UtiliseCreditOnSalesOrder(SalesInvHeader: Record "Sales Header"; ItemCharge: Code[20]; UtilisedAmt: Decimal)
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
        sgstTOTAL: Decimal;
        GSTLbl: Label 'GST';
        IGSTLbl: Label 'IGST';
        CGSTLbl: Label 'CGST';
        GSTCESSLbl: Label 'GST CESS';
        CESSLbl: Label 'CESS';
        igst: Decimal;
        igstTotal: Decimal;
        sgst: Decimal;
        GSTper3: Decimal;
        cgst: Decimal;
        GSTper1: Decimal;
        GSTper2: Decimal;
        cgstTOTAL: Decimal;
        ReccSalesLine: Record "Sales Line";
        ComponentName: Code[20];
        TotalAmt: Decimal;
    begin
        Clear(sgst);
        Clear(igst);
        Clear(cgst);
        Clear(TotalAmt);
        ReccSalesLine.Reset();
        ReccSalesLine.SetRange("Document Type", SalesInvHeader."Document Type");
        ReccSalesLine.SetRange("Document No.", SalesInvHeader."No.");
        if ReccSalesLine.FindSet() then
            repeat
                TotalAmt += ReccSalesLine."Line Amount";
                GSTSetup.Get();
                if GSTSetup."GST Tax Type" = GSTLbl then
                    if ReccSalesLine."GST Jurisdiction Type" = ReccSalesLine."GST Jurisdiction Type"::Interstate then
                        ComponentName := IGSTLbl
                    else
                        ComponentName := CGSTLbl
                else
                    if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                        ComponentName := CESSLbl;

                if ReccSalesLine.Type <> ReccSalesLine.Type::" " then begin
                    TaxTransactionValue.Reset();
                    TaxTransactionValue.SetRange("Tax Record ID", ReccSalesLine.RecordId);
                    TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
                    TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                    TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
                    if TaxTransactionValue.FindSet() then
                        repeat
                            case TaxTransactionValue."Value ID" of
                                6:
                                    begin
                                        sgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                        GSTper3 := TaxTransactionValue.Percent;
                                    end;
                                2:
                                    begin
                                        cgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                        GSTper2 := TaxTransactionValue.Percent;
                                    end;
                                3:
                                    begin
                                        igst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                        GSTper1 := TaxTransactionValue.Percent;
                                    end;
                            end;
                        until TaxTransactionValue.Next() = 0;
                    cgstTOTAL += cgst;
                    sgstTOTAL += sgst;
                    igstTotal += igst;
                end;
            until ReccSalesLine.Next() = 0;
        //15578 text


        IssuedCreditDetails.INIT;
        IssuedCreditDetails."Document Type" := 1;
        IssuedCreditDetails."Entry No." := GetNexTPaymentEntryNo;
        IssuedCreditDetails."Cust. No." := SalesInvHeader."Sell-to Customer No.";
        IF UtilisedAmt > 0 THEN
            UtilisedAmt := -1 * UtilisedAmt;
        IssuedCreditDetails."Invoice Amount" := TotalAmt + sgst + igst + cgst;
        IssuedCreditDetails."Payment Amount" := UtilisedAmt;
        IssuedCreditDetails."State Code" := SalesInvHeader.State;
        IssuedCreditDetails."Item Charge No." := ItemCharge;
        IssuedCreditDetails."Sales Order No." := SalesInvHeader."No.";
        IssuedCreditDetails."Posting Date" := SalesInvHeader."Posting Date";
        IssuedCreditDetails.Amount := UtilisedAmt;
        IssuedCreditDetails.Posted := TRUE;
        IF IssuedCreditDetails.Amount <> 0 THEN
            IssuedCreditDetails.INSERT;
    end;


    procedure ShortCloseandReleaseCredit(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        IssuedCreditDetails: Record "Issued Credit Details";
        SalesInvHeader: Record "Sales Invoice Header";
        //    PostStrOrdDetailLine: Record 13798;
        ChargeAmt: Decimal;
        IssuedCreditDetails1: Record "Issued Credit Details";
    begin
        IssuedCreditDetails.RESET;
        IssuedCreditDetails.SETRANGE(IssuedCreditDetails."Sales Order No.", SalesHeader."No.");
        IssuedCreditDetails.SETFILTER(Amount, '<%1', 0);
        IssuedCreditDetails.SETFILTER(Reversed, '%1', FALSE);
        IF IssuedCreditDetails.FINDFIRST THEN BEGIN
            REPEAT
                SalesInvHeader.SETFILTER("Order No.", SalesHeader."No.");
                /*    IF SalesInvHeader.FINDFIRST THEN BEGIN
                        REPEAT
                            PostStrOrdDetailLine.RESET;
                            PostStrOrdDetailLine.SETFILTER(Type, '%1', PostStrOrdDetailLine.Type::Sale);
                            PostStrOrdDetailLine.SETFILTER(PostStrOrdDetailLine."Invoice No.", SalesInvHeader."No.");
                            PostStrOrdDetailLine.SETFILTER("Tax/Charge Group", IssuedCreditDetails."Item Charge No.");
                            IF PostStrOrdDetailLine.FINDFIRST THEN BEGIN
                                REPEAT
                                    ChargeAmt += PostStrOrdDetailLine."Amount (LCY)";
                                UNTIL PostStrOrdDetailLine.NEXT = 0;
                            END;
                        UNTIL SalesInvHeader.NEXT = 0;
                    END;*/ // 15578

                IF ABS(IssuedCreditDetails.Amount) <> ABS(ChargeAmt) THEN BEGIN
                    IssuedCreditDetails1.INIT;
                    IssuedCreditDetails1."Document Type" := 0;
                    IssuedCreditDetails1."Entry No." := GetNexTPaymentEntryNo;
                    IssuedCreditDetails1."Cust. No." := SalesInvHeader."Sell-to Customer No.";
                    IssuedCreditDetails1."Item Charge No." := IssuedCreditDetails."Item Charge No.";
                    IssuedCreditDetails1."Posting Date" := TODAY;
                    IssuedCreditDetails1.Amount := -1 * (IssuedCreditDetails.Amount - ChargeAmt);
                    IssuedCreditDetails1."Posting Date & Time" := CURRENTDATETIME;
                    IssuedCreditDetails1."Sales Order No." := SalesInvHeader."Order No.";
                    IssuedCreditDetails1."External Doc. No." := SalesInvHeader."Order No.";
                    IssuedCreditDetails1.Reversed := TRUE;
                    IssuedCreditDetails1.Narration := 'Being Amount Released due to ShortClose/Cancel of Order';
                    IssuedCreditDetails1.Posted := TRUE;
                    IF IssuedCreditDetails1.Amount <> 0 THEN
                        IssuedCreditDetails1.INSERT;
                END;
                ChargeAmt := 0;
            UNTIL IssuedCreditDetails.NEXT = 0;
        END;
    end;

    procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal// 15578 text
    var
        TaxComponent: Record "Tax Component";
        GSTSetup1: Record "GST Setup";
        GSTRoundingPrecision: Decimal;
    begin
        if not GSTSetup1.Get() then
            exit;
        GSTSetup1.TestField("GST Tax Type");

        TaxComponent.SetRange("Tax Type", GSTSetup1."GST Tax Type");
        TaxComponent.SetRange(Name, ComponentName);
        TaxComponent.FindFirst();
        if TaxComponent."Rounding Precision" <> 0 then
            GSTRoundingPrecision := TaxComponent."Rounding Precision"
        else
            GSTRoundingPrecision := 1;
        exit(GSTRoundingPrecision);
    end;
}

