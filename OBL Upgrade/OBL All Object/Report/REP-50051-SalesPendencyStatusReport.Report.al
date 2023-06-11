report 50051 "Sales Pendency Status Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\SalesPendencyStatusReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Header"; 36)
        {
            DataItemTableView = SORTING("Document Type", "No.")
             WHERE("Document Type" = CONST(Order),
             Status = FILTER(<> Released & <> Approved));
            column(ReportDate; FORMAT(TODAY, 9))
            {
            }
            column(CATEGORY1; CATEGORY[1])
            {
            }
            column(CATEGORY2; CATEGORY[2])
            {
            }
            column(CATEGORY3; CATEGORY[3])
            {
            }
            column(CATEGORY4; CATEGORY[4])
            {
            }
            column(CATEGORY5; CATEGORY[5])
            {
            }
            column(Count1; Cnt[1])
            {
            }
            column(Count2; Cnt[2])
            {
            }
            column(Count3; Cnt[3])
            {
            }
            column(Count4; Cnt[4])
            {
            }
            column(Count5; Cnt[5])
            {
            }
            column(SalesAmt1; SalesAmt[1])
            {
            }
            column(SalesAmt2; SalesAmt[2])
            {
            }
            column(SalesAmt3; SalesAmt[3])
            {
            }
            column(SalesAmt4; SalesAmt[4])
            {
            }
            column(SalesAmt5; SalesAmt[5])
            {
            }
            column(SqMtr1; SqMtr[1])
            {
            }
            column(SqMtr2; SqMtr[2])
            {
            }
            column(SqMtr3; SqMtr[3])
            {
            }
            column(SqMtr4; SqMtr[4])
            {
            }
            column(SqMtr5; SqMtr[5])
            {
            }
            column(Category; GetCategory("Sales Header"))//16767
            {
            }
            column(SalesOrderNo; "Sales Header"."No.")
            {
            }
            column(SalesORderDate; "Sales Header"."Order Date")
            {
            }
            column(CustNo; "Sales Header"."Sell-to Customer No.")
            {
            }
            column(CustName; "Sales Header"."Sell-to Customer Name")
            {
            }
            column(Location; "Sales Header"."Location Code")
            {
            }
            column(SalesAmt; SalesAmt[5] + SalesAmt[4] + SalesAmt[3] + SalesAmt[2] + SalesAmt[1])
            {
            }
            column(SqrMtr; SqMtr[5] + SqMtr[4] + SqMtr[3] + SqMtr[2] + SqMtr[1])
            {
            }//16767

            trigger OnAfterGetRecord()
            var
                I: Integer;

            begin

                // 16630    CALCFIELDS("Amount to Customer");
                CALCFIELDS("Qty in Sq. Mt.");
                IF "Sales Header"."Qty in Sq. Mt." = 0 THEN CurrReport.SKIP;
                CLEAR(Cnt);
                CLEAR(SalesAmt);
                CLEAR(SqMtr);
                FOR I := 1 TO 5 DO BEGIN
                    IF GetCategory("Sales Header") = I THEN BEGIN
                        Cnt[I] := 1;
                        SalesAmt[I] := AmttoCustomerSalesLine(salesline) / Factor;  // 16630 "Sales Header"."Amount to Customer" / Factor
                        SqMtr[I] := "Sales Header"."Qty in Sq. Mt.";
                    END;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Factor := 100000;
    end;

    var
        CATEGORY: array[5] of Text;
        Cnt: array[5] of Integer;
        SalesAmt: array[5] of Decimal;
        SqMtr: array[5] of Decimal;
        Factor: Decimal;
        salesline: Record "Sales Line";

    local procedure GetCategory(SalesHeader: Record "Sales Header"): Integer
    begin
        WITH SalesHeader DO BEGIN
            IF NOT "Credit Approved" AND "Inventory Approved" AND "Price Approved" THEN EXIT(1);
            IF NOT "Credit Approved" AND "Inventory Approved" AND NOT "Price Approved" THEN EXIT(2);
            IF "Credit Approved" AND NOT "Inventory Approved" AND NOT "Price Approved" THEN EXIT(3);
            IF NOT "Credit Approved" AND NOT "Inventory Approved" AND "Price Approved" THEN EXIT(4);
            IF NOT "Credit Approved" AND NOT "Inventory Approved" AND NOT "Price Approved" THEN EXIT(5);
        END;
    end;

    procedure AmttoCustomerSalesLine(T37: Record 37): Decimal
    var
        igst: Decimal;
        igstTotal: Decimal;
        sgst: Decimal;
        GSTper3: Decimal;
        cgst: Decimal;
        GSTper1: Decimal;
        GSTper2: Decimal;
        cgstTOTAL: Decimal;
        ReccSalesLine: Record "Sales Line";
        TotalAmt: Decimal;
        GSTSetup: Record "GST Setup";
        ComponentName: Text;
        TaxTransactionValue: Record "Tax Transaction Value";
        sgstTOTAL: Decimal;
        TDSSetup: Record "TDS Setup";
        TDSAmt: Decimal;
        T36: Record "Sales Header";
    begin
        GSTSetup.Get();
        TDSSetup.Get();
        Clear(igst);
        Clear(sgst);
        Clear(cgst);
        Clear(TotalAmt);
        Clear(TDSAmt);
        T37.Reset();
        T37.SetRange("Document No.", "Sales Header"."No.");
        if T37.FindSet() then
            repeat
                TotalAmt := T37."Line Amount";
            until t37.Next() = 0;
        if T37.Type <> T37.Type::" " then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", T37.RecordId);
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat

                    case TaxTransactionValue."Value ID" of
                        6:
                            begin
                                ComponentName := 'SGST';
                                sgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                GSTper3 := TaxTransactionValue.Percent;
                            end;
                        2:
                            begin
                                ComponentName := 'CGST';
                                cgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                GSTper2 := TaxTransactionValue.Percent;
                            end;
                        3:
                            begin
                                ComponentName := 'IGST';
                                igst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                GSTper1 := TaxTransactionValue.Percent;
                            end;
                    end;
                until TaxTransactionValue.Next() = 0;
            cgstTOTAL += cgst;
            sgstTOTAL += sgst;
            igstTotal += igst;

            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", T37.RecordId);
            TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetRange("Value ID", 7);
            //TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    TDSAmt += TaxTransactionValue.Amount;
                until TaxTransactionValue.Next() = 0;
        end;

        exit((TotalAmt + igst + sgst + cgst) - TDSAmt);
    end;

    procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal
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

