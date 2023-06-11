report 50075 "Purchase Saving Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\PurchaseSavingReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Location; 14)
        {
            DataItemTableView = WHERE(stores = CONST(true));
            column(PlantCode; PlantCode)
            {
            }
            dataitem("Purch. Inv. Line"; 123)
            {
                DataItemLink = "Location Code" = FIELD(Code);
                DataItemTableView = SORTING("Location Code", "Posting Group", "Posting Date")
                                    WHERE(Type = CONST(Item),
                                          Quantity = FILTER(> '0'),
                                          // 16630 "Amount To Vendor" = FILTER(> '0'),
                                          "Posting Group" = FILTER('COL-IMP|ELEC|ELEC-IMP|FUEL|GEN|GLAZE-IMP|MECH-IMP|MECH-IND|PACK|PACK-IMP|PMIM|PMIN|REF|BODY|BODY-IMP|COL|GLAZE'));
                column(Period; Period)
                {
                }
                column(LocCode; "Location Code")
                {
                }
                column(ProdGroup; "Posting Group")
                {
                }
                column(ItemNo; "No.")
                {
                }
                column(ItemDescription; RecItem.Description)
                {
                }
                column(UOM; "Purch. Inv. Line"."Unit of Measure")
                {
                }
                column(Rate; "Direct Unit Cost")
                {
                }
                column(Qty; Quantity)
                {
                }
                column(TotalAmount; GetAmttoVendorPostedLine("Document No.", "Line No.")) // 16630 "Amount To Vendor"
                {
                }
                column(QtyQ1; Qty[1])
                {
                }
                column(ValueQ1; Value[1])
                {
                }
                column(QtyQ2; Qty[2])
                {
                }
                column(ValueQ2; Value[2])
                {
                }
                column(QtyQ3; Qty[3])
                {
                }
                column(ValueQ3; Value[3])
                {
                }
                column(QtyH1; Qty[4])
                {
                }
                column(ValueH1; Value[4])
                {
                }
                column(QtyPreFY; Qty[5])
                {
                }
                column(ValuePreFY; Value[5])
                {
                }
                column(PeriodFrom1; PeriodFrom[1])
                {
                }
                column(PeriodTo1; PeriodTo[1])
                {
                }
                column(PeriodFrom2; PeriodFrom[2])
                {
                }
                column(PeriodTo2; PeriodTo[2])
                {
                }
                column(PeriodFrom3; PeriodFrom[3])
                {
                }
                column(PeriodTo3; PeriodTo[3])
                {
                }
                column(PeriodFrom4; PeriodFrom[4])
                {
                }
                column(PeriodTo4; PeriodTo[4])
                {
                }
                column(PeriodFrom5; PeriodFrom[5])
                {
                }
                column(PeriodTo5; PeriodTo[5])
                {
                }
                column(QtyyQ1; Qtyy[1])
                {
                }
                column(QtyyQ2; Qtyy[2])
                {
                }
                column(QtyyQ3; Qtyy[3])
                {
                }
                column(QtyyQ4; Qtyy[4])
                {
                }
                column(QtyyQ5; Qtyy[5])
                {
                }
                column(ValueYQ1; ValueY[1])
                {
                }
                column(ValueYQ2; ValueY[2])
                {
                }
                column(ValueYQ3; ValueY[3])
                {
                }
                column(ValueYQ4; ValueY[4])
                {
                }
                column(ValueYQ5; ValueY[5])
                {
                }
                column(ValueYQ6; ValueY[6])
                {
                }
                column(TotalValueQ1; TotalValue[1])
                {
                }
                column(TotalValueQ2; TotalValue[2])
                {
                }

                trigger OnAfterGetRecord()
                begin
                    /*    IGSTAmt := 0;
                       IGSTper := 0;
                       SGSTAmt := 0;
                       SGSTper := 0;
                       CGSTAmt := 0;
                       CGSTper := 0;
                       GSTBaseAmt := 0;
                       TotalAmount := 0;
                       "Line Amount" := 0;




                       RecDGLE.RESET();
                       RecDGLE.SETRANGE("Document No.", "Purch. Inv. Line"."No.");
                       RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                       RecDGLE.SETRANGE("GST Component Code", 'IGST');
                       IF RecDGLE.FINDFIRST THEN BEGIN
                           REPEAT
                               IGSTAmt += abs(RecDGLE."GST Amount");
                           UNTIL RecDGLE.NEXT = 0;
                       END;


                       RecDGLE.RESET();
                       RecDGLE.SETRANGE("Document No.", "Purch. Inv. Line"."No.");
                       RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                       RecDGLE.SETRANGE("GST Component Code", 'SGST');
                       IF RecDGLE.FINDFIRST THEN BEGIN
                           REPEAT
                               SGSTAmt += abs(RecDGLE."GST Amount");
                           UNTIL RecDGLE.NEXT = 0;
                       END;
                       RecDGLE.RESET();
                       RecDGLE.SETRANGE("Document No.", "Purch. Inv. Line"."No.");
                       RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                       RecDGLE.SETRANGE("GST Component Code", 'CGST');
                       IF RecDGLE.FINDFIRST THEN BEGIN
                           REPEAT
                               CGSTAmt += abs(RecDGLE."GST Amount");
                           UNTIL RecDGLE.NEXT = 0;
                       END;


                       RecDGLE.RESET();
                       RecDGLE.SETRANGE("Document No.", "Purch. Inv. Line"."No.");
                       RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                       RecDGLE.SETRANGE("GST Component Code", 'CGST');
                       IF RecDGLE.FINDFIRST THEN BEGIN
                           repeat
                               GSTBaseAmt += abs(RecDGLE."GST Base Amount");
                           until RecDGLE.next = 0;
                       END;
                       RecDGLE.RESET();
                       RecDGLE.SETRANGE("Document No.", "Purch. Inv. Line"."No.");
                       RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                       RecDGLE.SETRANGE("GST Component Code", 'IGST');
                       IF RecDGLE.FINDFIRST THEN BEGIN
                           repeat
                               GSTBaseAmt += abs(RecDGLE."GST Base Amount");
                           until RecDGLE.Next() = 0;

                       END;
                       TotalAmount += "Line Amount" + IGSTAmt + CGSTAmt + SGSTAmt;
   16630 */
                    IF "Purch. Inv. Line"."No." = '' THEN
                        CurrReport.SKIP;

                    CLEAR(Qty);
                    CLEAR(Value);
                    CLEAR(Qtyy);
                    CLEAR(ValueY);
                    CLEAR(TotalValue);

                    Period := CalculatePeriod("Purch. Inv. Line"."Posting Date");
                    Qty[Period] := "Purch. Inv. Line".Quantity;
                    Qtyy[Period] := "Purch. Inv. Line".Quantity;  //Rk
                    Value[Period] := GetAmttoVendorPostedLine("Document No.", "Line No.");
                    ValueY[Period] := GetAmttoVendorPostedLine("Document No.", "Line No.");
                    /*Value[Period] := "Purch. Inv. Line"."Amount To Vendor";
                    ValueY[Period] := "Purch. Inv. Line"."Amount To Vendor"; */ // 16630 //Rk

                    IF RecItem.GET("Purch. Inv. Line"."No.") THEN;

                    IF Period = 1 THEN
                        IF NOT TempItemAmount.GET(0, 0, "Purch. Inv. Line"."No.") THEN BEGIN
                            TempItemAmount.INIT;
                            TempItemAmount.Amount := 0;
                            TempItemAmount."Amount 2" := 0;
                            TempItemAmount."Item No." := "Purch. Inv. Line"."No.";
                            TempItemAmount.INSERT;
                        END;

                    IF Period IN [2, 3, 4, 5] THEN
                        IF NOT TempItemAmount.GET(0, 0, "Purch. Inv. Line"."No.") THEN CurrReport.SKIP;

                    //IF "Purch. Inv. Line"."Posting Group" = 'BODY' THEN//
                    TotalValue[Period] := GetAmttoVendorPostedLine("Document No.", "Line No.");
                    // 16630 TotalValue[Period] := "Purch. Inv. Line"."Amount To Vendor";
                    //
                end;

                trigger OnPreDataItem()
                begin

                    SETFILTER("Posting Date", '%1..%2|%3..%4|%5..%6|%7..%8|%9..%10', PeriodFrom[1], PeriodTo[1], PeriodFrom[2], PeriodTo[2], PeriodFrom[3], PeriodTo[3]
                                                                                    , PeriodFrom[4], PeriodTo[4], PeriodFrom[5], PeriodTo[5]);
                    //SETCURRENTKEY("No.","Posting Date");
                    "Purch. Inv. Line".SETASCENDING("Posting Date", FALSE);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                PlantCode := GetPlantCode(Location.Code);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Report Date"; ASonDate)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CalculateDates;
                    end;
                }
                field("Period From 1"; PeriodFrom[1])
                {
                    ApplicationArea = All;
                }
                field("Period To 1"; PeriodTo[1])
                {
                    ApplicationArea = All;
                }
                field("Period From 2"; PeriodFrom[2])
                {
                    ApplicationArea = All;
                }
                field("Period To 2"; PeriodTo[2])
                {
                    ApplicationArea = All;
                }
                field("Period From 3"; PeriodFrom[3])
                {
                    ApplicationArea = All;
                }
                field("Period To 3"; PeriodTo[3])
                {
                    ApplicationArea = All;
                }
                field("Period From 4"; PeriodFrom[4])
                {
                    ApplicationArea = All;
                }
                field("Period To 4"; PeriodTo[4])
                {
                    ApplicationArea = All;
                }
                field("Period From 5"; PeriodFrom[5])
                {
                    ApplicationArea = All;
                }
                field("Period To 5"; PeriodTo[5])
                {
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CalculateDates;
        MESSAGE('%1-%2-%3-%4-%5-%6', PeriodFrom[1], PeriodTo[1], PeriodFrom[2], PeriodTo[2], PeriodFrom[3], PeriodTo[3]);
        //MESSAGE('%1-%2-%3-%4-%5-%6-%7-%8-%9-%10',PeriodFrom[1],PeriodTo[1],PeriodFrom[2],PeriodTo[2],PeriodFrom[3],PeriodTo[3],PeriodFrom[4],PeriodTo[4],PeriodFrom[5],PeriodTo[5]);
    end;

    var
        ASonDate: Date;
        PeriodFrom: array[6] of Date;
        PeriodTo: array[6] of Date;
        PlantCode: Code[10];
        Period: Integer;
        RecItem: Record Item;
        Qty: array[6] of Decimal;
        Value: array[6] of Decimal;
        Avg: array[6] of Decimal;
        Qtyy: array[6] of Decimal;
        ValueY: array[6] of Decimal;
        TotalValue: array[6] of Decimal;
        TempItemAmount: Record "Item Amount" temporary;

        IGSTAmt: Decimal;
        IGSTper: Decimal;
        SGSTAmt: Decimal;
        SGSTper: Decimal;
        CGSTAmt: Decimal;
        CGSTper: Decimal;
        GSTBaseAmt: Decimal;
        TotalAmount: Decimal;
        "Line Amount": Decimal;
        RecDGLE: Record "Detailed GST Ledger Entry";

    local procedure GetPlantCode(LocationCode: Code[10]) PlantCode: Text
    var
        Location: Record Location;
    begin
        CASE LocationCode OF
            'SKD-STORE':
                EXIT('SKD');
            'HSK-STORE':
                EXIT('HSK');
            'DRA-STORE':
                EXIT('DRA');
        END;
    end;

    local procedure CalculateDates()
    begin
        IF ASonDate = 0D THEN
            ASonDate := WORKDATE;

        PeriodFrom[1] := CALCDATE('-CQ', ASonDate);
        PeriodTo[1] := CALCDATE('CQ', ASonDate);

        PeriodFrom[2] := CALCDATE('-CQ', PeriodFrom[1] - 1);
        PeriodTo[2] := CALCDATE('CQ', PeriodFrom[2]);

        PeriodFrom[3] := CALCDATE('-CQ', PeriodFrom[2] - 1);
        PeriodTo[3] := CALCDATE('CQ', PeriodFrom[3]);

        PeriodFrom[4] := CALCDATE('-CQ', PeriodFrom[3] - 1);
        PeriodTo[4] := CALCDATE('CQ', PeriodFrom[4]);

        PeriodFrom[5] := CALCDATE('-CQ', PeriodFrom[4] - 1);
        PeriodTo[5] := CALCDATE('CQ', PeriodFrom[5]);
    end;

    local procedure CalculatePeriod(DtDate: Date): Integer
    begin
        CASE DtDate OF
            PeriodFrom[1] .. PeriodTo[1]:
                EXIT(1);
            PeriodFrom[2] .. PeriodTo[2]:
                EXIT(2);
            PeriodFrom[3] .. PeriodTo[3]:
                EXIT(3);
            PeriodFrom[4] .. PeriodTo[4]:
                EXIT(4);
            PeriodFrom[5] .. PeriodTo[5]:
                EXIT(5);
        END;
    end;

    procedure GetAmttoVendorPostedLine(DocumentNo: Code[20]; DocLineNo: Integer): Decimal
    var
        PstdPurchInv: Record 123;
        PstdPurchCrMemoLine: Record 125;
        TotalAmt: Decimal;
        DetGstLedEntry: Record "Detailed GST Ledger Entry";
        IGSTAmt: Decimal;
        GSTBaseAmt: Decimal;
        SGSTAmt: Decimal;
        CGSTAmt: Decimal;
        LineAmt: Decimal;
        TaxTransactionValue: Record "Tax Transaction Value";
        TDSSetup: Record "TDS Setup";
        TDSAmt: Decimal;
    begin
        Clear(IGSTAmt);
        Clear(LineAmt);
        Clear(SGSTAmt);
        Clear(CGSTAmt);
        Clear(TDSAmt);
        TDSSetup.Get();
        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'IGST');
        IF DetGstLedEntry.FINDFIRST THEN begin
            IGSTAmt := abs(DetGstLedEntry."GST Amount");
            //GSTBaseAmt := abs(DetGstLedEntry."GST Base Amount");
        end;



        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'SGST');
        IF DetGstLedEntry.FINDFIRST THEN
            SGSTAmt := abs(DetGstLedEntry."GST Amount");

        DetGstLedEntry.RESET();
        DetGstLedEntry.SETRANGE("Document No.", DocumentNo);
        DetGstLedEntry.SetRange("Document Line No.", DocLineNo);
        DetGstLedEntry.SETRANGE("GST Component Code", 'CGST');
        IF DetGstLedEntry.FINDFIRST THEN begin
            CGSTAmt := abs(DetGstLedEntry."GST Amount");
            // GSTBaseAmt := abs(DetGstLedEntry."GST Base Amount");
        end;

        if PstdPurchCrMemoLine.Get(DocumentNo, DocLineNo) then begin
            if PstdPurchCrMemoLine.Type <> PstdPurchCrMemoLine.Type::" " then
                LineAmt := PstdPurchCrMemoLine."Line Amount";
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PstdPurchCrMemoLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetRange("Value ID", 7);
            //TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindFirst() then
                TDSAmt := TaxTransactionValue.Amount;
        end;

        if PstdPurchInv.Get(DocumentNo, DocLineNo) then begin
            if PstdPurchInv.Type <> PstdPurchInv.Type::" " then
                LineAmt := PstdPurchInv."Line Amount";
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PstdPurchInv.RecordId);
            TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetRange("Value ID", 7);
            //TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindFirst() then
                TDSAmt := TaxTransactionValue.Amount;
        end;

        Clear(TotalAmt);
        TotalAmt := (LineAmt + IGSTAmt + SGSTAmt + CGSTAmt) - TDSAmt;
        EXIT(ABS(TotalAmt));
    end;//

}

