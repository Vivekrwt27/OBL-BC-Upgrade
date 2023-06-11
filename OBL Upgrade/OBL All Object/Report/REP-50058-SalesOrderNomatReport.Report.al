report 50058 "Sales Order Nomat Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\SalesOrderNomatReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order),
                                      "Location Code" = FILTER('SKD-WH-MFG|DRA-WH-MFG|HSK-WH-MFG'));
            column(ReportDate; FORMAT(TODAY, 9))
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
            column(Count6; Cnt[6])
            {
            }
            column(Count7; Cnt[7])
            {
            }
            column(Count8; Cnt[8])
            {
            }
            column(TotalCnt; Cnt[1] + Cnt[2] + Cnt[3] + Cnt[4] + Cnt[5] + Cnt[6] + Cnt[7] + Cnt[8])
            {
            }
            column(Days; Days)
            {
            }
            column(Category; GetCategory("Sales Header"))
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
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                column(ItemNo; "Sales Line"."No.")
                {
                }
                column(Description; "Sales Line".Description + ' ' + "Sales Line"."Description 2")
                {
                }
                column(MFgStg; Item."Manuf. Strategy")
                {
                }
                column(Inventory; Item.Inventory)
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
                column(CATEGORY6; CATEGORY[6])
                {
                }
                column(CATEGORY7; CATEGORY[7])
                {
                }
                column(CATEGORY8; CATEGORY[8])
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
                column(SalesAmt6; SalesAmt[6])
                {
                }
                column(SalesAmt7; SalesAmt[7])
                {
                }
                column(SalesAmt8; SalesAmt[8])
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
                column(SqMtr6; SqMtr[6])
                {
                }
                column(SqMtr7; SqMtr[7])
                {
                }
                column(SqMtr8; SqMtr[8])
                {
                }
                column(SqrMtr; SqMtr[8] + SqMtr[7] + SqMtr[6] + SqMtr[5] + SqMtr[4] + SqMtr[3] + SqMtr[2] + SqMtr[1])
                {
                }
                column(SalesAmt; SalesAmt[8] + SalesAmt[7] + SalesAmt[6] + SalesAmt[5] + SalesAmt[4] + SalesAmt[3] + SalesAmt[2] + SalesAmt[1])
                {
                }
                column(SizeRev; Item."Size Code Desc.")
                {
                }
                column(ProdQty; GetProduction("Sales Line"."No.", "Sales Line"."Location Code"))
                {
                }
                column(SalesQty; -1 * GetSales("Sales Line"."No.", "Sales Line"."Location Code"))
                {
                }
                column(WDM; Item.WDM)
                {
                }
                column(mfgplant; MfgPlant)
                {
                }

                trigger OnAfterGetRecord()
                var
                    I: Integer;
                begin
                    CLEAR(SalesAmt);
                    CLEAR(SqMtr);
                    IF "Sales Line".Type = "Sales Line".Type THEN
                        IF Item.GET("Sales Line"."No.") THEN
                            IF Item."Quality Code" <> '1' THEN CurrReport.SKIP;

                    FOR I := 1 TO 8 DO BEGIN
                        IF GetCategory("Sales Header") = I THEN BEGIN
                            Cnt[I] := 1;
                            SalesAmt[I] := "Sales Line"."Outstanding Amount" / Factor;
                            SqMtr[I] := "Sales Line"."Quantity in Sq. Mt.";
                        END ELSE BEGIN
                            SalesAmt[I] := 0;
                            SqMtr[I] := 0;
                        END;
                    END;
                    IF Item.GET("Sales Line"."No.") THEN;
                    Item.SETFILTER("Location Filter", "Sales Line"."Location Code");
                    Item.CALCFIELDS(Inventory);

                    //IF Item."Quality Code" <> '1' THEN CurrReport.SKIP;

                    IF Item."Default Prod. Plant Code" <> '' THEN
                        MfgPlant := COPYSTR(Item."Default Prod. Plant Code", 1, 3);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //CALCFIELDS("Outstanding Amount");
                CALCFIELDS("Qty in Sq. Mt.");
                IF "Sales Header"."Qty in Sq. Mt." = 0 THEN CurrReport.SKIP;
                CLEAR(Cnt);
                CLEAR(Days);
                Days := TODAY - "Sales Header"."Order Date";
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
        CATEGORY: array[8] of Text;
        Cnt: array[8] of Integer;
        SalesAmt: array[8] of Decimal;
        SqMtr: array[8] of Decimal;
        Factor: Decimal;
        Item: Record 27;
        Days: Integer;
        MfgPlant: Text;

    local procedure GetCategory(SalesHeader: Record 36): Integer
    begin
        WITH SalesHeader DO BEGIN
            IF NOT "Credit Approved" AND "Inventory Approved" AND "Price Approved" THEN EXIT(5); // Credit Not Approved 5
            IF NOT "Credit Approved" AND "Inventory Approved" AND NOT "Price Approved" THEN EXIT(6); //Credit and Discount Not Approved 6
            IF "Credit Approved" AND NOT "Inventory Approved" AND NOT "Price Approved" THEN EXIT(3); //3
            IF NOT "Credit Approved" AND NOT "Inventory Approved" AND "Price Approved" THEN EXIT(8);//No Inventory & Credit not Approved 8
            IF NOT "Credit Approved" AND NOT "Inventory Approved" AND NOT "Price Approved" THEN EXIT(2); //Open 2
            IF "Credit Approved" AND "Inventory Approved" AND "Price Approved" THEN EXIT(1); //Executable 1
            IF "Credit Approved" AND NOT "Inventory Approved" AND "Price Approved" THEN EXIT(4); // No Inventory 4
            IF "Credit Approved" AND "Inventory Approved" AND NOT "Price Approved" THEN EXIT(7); //Discount Not Approved 7
        END;
    end;

    local procedure GetProduction(ItemNo: Code[20]; LocCode: Code[10]) Qty: Decimal
    var
        ItemLedgerEntry: Record 32;
    begin
        IF LocCode = '' THEN EXIT;
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETRANGE("Item No.", ItemNo);
        ItemLedgerEntry.SETFILTER("Entry Type", '%1', ItemLedgerEntry."Entry Type"::Output);
        ItemLedgerEntry.SETFILTER("Posting Date", '%1..%2', CALCDATE('-CM', TODAY), CALCDATE('CM', TODAY));
        IF COPYSTR(LocCode, 1, 3) = 'SKD' THEN
            ItemLedgerEntry.SETFILTER("Location Code", 'SKD*');
        IF COPYSTR(LocCode, 1, 3) = 'HSK' THEN
            ItemLedgerEntry.SETFILTER("Location Code", 'HSK*');
        IF COPYSTR(LocCode, 1, 3) = 'DRA' THEN
            ItemLedgerEntry.SETFILTER("Location Code", 'DRA*');

        IF ItemLedgerEntry.FINDFIRST THEN
            REPEAT
                Qty += ItemLedgerEntry.Quantity;
            UNTIL ItemLedgerEntry.NEXT = 0;
    end;

    local procedure GetSales(ItemNo: Code[20]; LocCode: Code[10]) Qty: Decimal
    var
        ItemLedgerEntry: Record 32;
    begin
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETRANGE("Item No.", ItemNo);
        ItemLedgerEntry.SETFILTER("Entry Type", '%1', ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SETFILTER("Location Code", '%1', LocCode);
        ItemLedgerEntry.SETFILTER("Posting Date", '%1..%2', CALCDATE('-CM', TODAY), CALCDATE('CM', TODAY));
        IF ItemLedgerEntry.FINDFIRST THEN
            REPEAT
                Qty += ItemLedgerEntry.Quantity;
            UNTIL ItemLedgerEntry.NEXT = 0;
    end;
}

