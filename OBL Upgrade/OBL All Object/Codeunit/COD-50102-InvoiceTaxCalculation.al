codeunit 50102 "Sales Before Post Tax Calculat"
{
    var
        cgstTOTAL, sgstTOTAL, igstTotal, TotalAmt, GSTper1, GSTper2, GSTper3 : Decimal;

    procedure CalculateTax(var SalesHeader: Record "Sales Header")
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        ReccSalesLine: Record "Sales Line";
        cgst, sgst, igst : Decimal;
        GSTSetup: Record "GST Setup";
        GSTLbl: Label 'GST';
        IGSTLbl: Label 'IGST';
        CGSTLbl: Label 'CGST';
        GSTCESSLbl: Label 'GST CESS';
        CESSLbl: Label 'CESS';
        ComponentName: Code[30];
    begin
        Clear(TotalAmt);
        Clear(igst);
        Clear(sgst);
        Clear(cgst);
        Clear(GSTper1);
        Clear(GSTper2);
        Clear(GSTper3);

        ReccSalesLine.Reset();
        ReccSalesLine.SetRange("Document No.", SalesHeader."No.");
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
    end;

    local procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal
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

    procedure GetGSTBaseAmount(): Decimal
    begin
        exit(TotalAmt);
    end;

    procedure GetSGSTAmount(): Decimal
    begin
        exit(sgstTOTAL);
    end;

    procedure GetIGSTAmount(): Decimal
    begin
        exit(igstTotal);
    end;

    procedure GetCGSTAmount(): Decimal
    begin
        exit(cgstTOTAL);
    end;

    procedure CGSTPer(): Decimal
    begin
        exit(GSTper2)
    end;

    procedure IGSTPer(): Decimal
    begin
        exit(GSTper1)
    end;
}