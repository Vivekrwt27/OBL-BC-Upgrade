codeunit 60000 "GST Calculated Posted"
{
    trigger OnRun()
    begin

    end;

    var
    procedure PostedDocumentGSTCalculated(Rec: Record "Sales Invoice Header"; Var AmounttoCustomer: Decimal)
    var
        IGSTAmt: Decimal;
        SGSTAmt: Decimal;
        CGSTAmt: Decimal;
        LineAmount: Decimal;
        RecDGLE: Record "Detailed GST Ledger Entry";
        SalesInvLine: Record "Sales Invoice Line";
    begin
        AmounttoCustomer := 0;
        IGSTAmt := 0;
        SGSTAmt := 0;
        CGSTAmt := 0;
        LineAmount := 0;

        SalesInvLine.Reset();
        SalesInvLine.SetRange("Document No.", Rec."No.");
        SalesInvLine.SetRange(Type, SalesInvLine.Type::Item); //TEAM 14763 03-06-23
        if SalesInvLine.FindSet() then
            repeat
                LineAmount += SalesInvLine."Line Amount";
            until SalesInvLine.Next() = 0;

        RecDGLE.RESET();
        RecDGLE.SETRANGE("Document No.", Rec."No.");
        RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
        RecDGLE.SETRANGE("GST Component Code", 'IGST');
        IF RecDGLE.FINDFIRST THEN BEGIN
            REPEAT
                IGSTAmt += abs(RecDGLE."GST Amount");
            UNTIL RecDGLE.NEXT = 0;
        END;
        RecDGLE.RESET();
        RecDGLE.SETRANGE("Document No.", Rec."No.");
        RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
        RecDGLE.SETRANGE("GST Component Code", 'SGST');
        IF RecDGLE.FINDFIRST THEN BEGIN
            REPEAT
                SGSTAmt += abs(RecDGLE."GST Amount");
            UNTIL RecDGLE.NEXT = 0;
        END;
        RecDGLE.RESET();
        RecDGLE.SETRANGE("Document No.", Rec."No.");
        RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
        RecDGLE.SETRANGE("GST Component Code", 'CGST');
        IF RecDGLE.FINDFIRST THEN BEGIN
            REPEAT
                CGSTAmt += abs(RecDGLE."GST Amount");
            UNTIL RecDGLE.NEXT = 0;
        END;

        //Blocked by TEAM 14763 03-06-23 AmounttoCustomer := LineAmount + IGSTAmt + CGSTAmt + SGSTAmt;
        AmounttoCustomer := LineAmount;

    end;


    procedure GSTCalculatedPre(Rec: Record "Sales Header"; var AmounttoCustomer: Decimal)
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
        RecSalesLine: Record "Sales Line";
        ComponentName: Code[20];
        TotalAmt: Decimal;
    begin
        Clear(AmounttoCustomer);
        Clear(sgst);
        Clear(igst);
        Clear(cgst);
        Clear(TotalAmt);
        RecSalesLine.Reset();
        RecSalesLine.SetRange("Document Type", Rec."Document Type");
        RecSalesLine.SetRange("Document No.", Rec."No.");
        if RecSalesLine.FindSet() then
            repeat
                TotalAmt += RecSalesLine."Line Amount";
                GSTSetup.Get();
                if GSTSetup."GST Tax Type" = GSTLbl then
                    if RecSalesLine."GST Jurisdiction Type" = RecSalesLine."GST Jurisdiction Type"::Interstate then
                        ComponentName := IGSTLbl
                    else
                        ComponentName := CGSTLbl
                else
                    if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                        ComponentName := CESSLbl;

                if RecSalesLine.Type <> RecSalesLine.Type::" " then begin
                    TaxTransactionValue.Reset();
                    TaxTransactionValue.SetRange("Tax Record ID", RecSalesLine.RecordId);
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
            until RecSalesLine.Next() = 0;
        AmounttoCustomer := TotalAmt + igst + cgst + sgst;
        //15578 text
    end;

    local procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal// 15578 text
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

