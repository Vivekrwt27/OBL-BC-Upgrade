report 50171 "Sales Order Status Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\SalesOrderStatusReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("Sales Header"; 36)
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order),
                                      Status = FILTER(<> Released),
                                      "Location Code" = FILTER('HSK-WH-MFG|DRA-WH-MFG|SKD-WH-MFG'),
                                      "Customer Type" = FILTER('<>GET&<>PET&<>SET&<>MISC.'));
            column(Report1; 'Report1')
            {
            }
            column(SalesOrderNo; "Sales Header"."No.")
            {
            }
            column(CustName; Customer.Name)
            {
            }
            column("Area"; Customer."Area Code")
            {
            }
            column(TabZone; Customer."Tableau Zone")
            {
            }
            column(OrderDateTime; "Sales Header"."Order Date Time")
            {
            }
            column(AgeingTime; AgeTime)
            {
            }
            column(Location_Code; "Sales Header"."Location Code")
            {
            }
            column(TotSKU; TotSKU)
            {
            }
            column(GTotalSKU; GTotalSKU)
            {
            }
            column(TotShortLineQty; TotShortLineQty)
            {
            }
            column(MTSCount; MTSCount)
            {
            }
            column(TotOutSqMtr; TotSqMtr)
            {
            }
            column(OutStandAmt; OutStandAmt)
            {
            }
            column(Credit_Clear; FORMAT("Sales Header"."Credit Approved"))
            {
            }
            column(TotalShortLineQty; TotalShortLineQty)
            {
            }
            column(TotalMTSCount; TotalMTSCount)
            {
            }
            dataitem("Sales Line"; 37)
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    WHERE("Outstanding Qty. (Base)" = FILTER(<> 0));
                column(ItemNo; "Sales Line"."No.")
                {
                }
                column(ItemDesc; Item.Description)
                {
                }
                column(QtySqMt; "Sales Line"."Quantity in Sq. Mt.")
                {
                }
                column(SizeCodeDesc; Item."Size Code Desc.")
                {
                }
                column(OutStandingQty; SizeWiseOutQty)
                {
                }
                column(ReserveQty; "Sales Line"."Reserved Qty. (Base)")
                {
                }
                column(SizeCnt; SizeCnt)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF "Sales Line"."Outstanding Qty. (Base)" = "Sales Line"."Reserved Qty. (Base)" THEN
                        CurrReport.SKIP;
                    SizeCnt := 0;
                    "Sales Line".CALCFIELDS("Sales Line"."Reserved Qty. (Base)");
                    IF Item.GET("Sales Line"."No.") THEN;
                    IF ("Sales Line"."Outstanding Qty. (Base)" <> "Sales Line"."Reserved Qty. (Base)") AND ("Sales Line"."Outstanding Qty. (Base)" <> 0) THEN BEGIN
                        SizeWiseOutQty := "Sales Line"."Outstanding Qty. (Base)";
                        SizeCnt := 1;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            var
                SalesLine: Record 37;
            begin
                "Sales Header".CALCFIELDS("Outstanding Qty");
                "Sales Header".CALCFIELDS("Sales Header"."Reserved Qty");
                TotSKU := 0;
                GrandTotSKU := 0;
                AgeTime := 0;
                TotSqMtr := 0;
                MTSCount := 0;
                OutStandAmt := 0;
                TotShortLineQty := 0;
                IF "Sales Header"."Order Date" <> 0D THEN
                    AgeTime := TODAY - "Sales Header"."Order Date";

                //ERROR('%1',AgeTime);
                IF ("Sales Header"."Outstanding Qty" = 0) THEN//OR ("Sales Header"."Outstanding Qty"="Sales Header"."Reserved Qty") THEN
                    CurrReport.SKIP;

                IF Customer.GET("Sales Header"."Sell-to Customer No.") THEN;

                IF (Customer."Tableau Zone" = 'Enterprise') AND (Customer."Tableau Zone" = 'Misc') THEN
                    CurrReport.SKIP;

                SalesLine.RESET;
                SalesLine.SETRANGE("Document Type", "Document Type");
                SalesLine.SETRANGE("Document No.", "Sales Header"."No.");
                IF SalesLine.FINDFIRST THEN BEGIN
                    TotSKU := SalesLine.COUNT;
                    GrandTotSKU += TotSKU;
                    REPEAT
                        SalesLine.CALCFIELDS("Reserved Qty. (Base)");
                        IF (SalesLine."Outstanding Qty. (Base)" <> SalesLine."Reserved Qty. (Base)") THEN BEGIN
                            TotShortLineQty += 1;

                            // IF SalesLine."Outstanding Qty. (Base)"<>0 THEN BEGIN
                            IF Item.GET(SalesLine."No.") THEN
                                IF Item."Manuf. Strategy" = Item."Manuf. Strategy"::"Make-to-Stock" THEN BEGIN
                                    MTSCount += 1;
                                    CalculateSummary(SalesLine."No.", SalesLine."Location Code", 1);
                                END ELSE BEGIN
                                    CalculateSummary(SalesLine."No.", SalesLine."Location Code", 0);
                                END;
                        END;
                        IF SalesLine."Outstanding Qty. (Base)" <> 0 THEN BEGIN
                            OutStandAmt += SalesLine."Outstanding Amount (LCY)"; //* SalesLine."Line Amount" / SalesLine."Quantity (Base)";
                            TotSqMtr += SalesLine."Outstanding Qty. (Base)";
                        END;

                    UNTIL SalesLine.NEXT = 0;
                END;

                TotalMTSCount += MTSCount;
                TotalShortLineQty += TotShortLineQty;
                GTotalSKU += GrandTotSKU;
                //MESSAGE('%1=%2',TotalMTSCount,TotalShortLineQty);
            end;
        }
        dataitem(Location; 14)
        {
            column(Report2; 'Report2')
            {
            }
            column("Code"; Location.Code)
            {
            }
            column(TotalItemsCountNotINInv; TotalItemsCountNotINInv)
            {
            }
            column(TotMTSItemsCountNotINInv; TotMTSItemsCountNotINInv)
            {
            }
            column(TotMTOItemsCountNotINInv; TotMTOItemsCountNotINInv)
            {
            }

            trigger OnAfterGetRecord()
            begin
                TotMTSItemsCountNotINInv := 0;
                TotalItemsCountNotINInv := 0;
                TotMTOItemsCountNotINInv := 0;

                TempItemAmount.RESET;
                TempItemAmount.SETFILTER("Location Code", '%1', Location.Code);
                IF TempItemAmount.FINDFIRST THEN
                    REPEAT
                        IF TempItemAmount."Minimum Order Quantity" < TempItemAmount."Maximum Order Quantity" THEN BEGIN
                            TotalItemsCountNotINInv += 1;
                            IF TempItemAmount."Dampener Quantity" > 0 THEN
                                TotMTSItemsCountNotINInv += 1
                            ELSE
                                TotMTOItemsCountNotINInv += 1;

                        END;
                    UNTIL TempItemAmount.NEXT = 0;

                IF TotalItemsCountNotINInv = 0 THEN
                    CurrReport.SKIP;
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

    var
        Customer: Record 18;
        Item: Record 27;
        AgeTime: Integer;
        TotSKU: Integer;
        TotShortLineQty: Decimal;
        TotSqMtr: Decimal;
        OutStandAmt: Decimal;
        MTSCount: Integer;
        SizeWiseOutQty: Decimal;
        SizeCnt: Integer;
        TotalMTSCount: Integer;
        TotalShortLineQty: Decimal;
        GrandTotSKU: Integer;
        GTotalSKU: Integer;
        ItemNo: Code[20];
        TotalItemsCountNotINInv: Integer;
        TotMTSItemsCountNotINInv: Integer;
        TotMTOItemsCountNotINInv: Integer;
        TempItemAmount: Record 5700 temporary;

    local procedure CalcTotInventory(LocCode: Code[20]; ItemNo: Code[20]) Qty: Decimal
    var
        ItemLedgerEntry: Record 32;
    begin
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
        ItemLedgerEntry.SETFILTER("Item No.", '%1', ItemNo);
        ItemLedgerEntry.SETFILTER("Location Code", '%1', LocCode);
        ItemLedgerEntry.SETFILTER("Remaining Quantity", '<>%1', 0);
        IF ItemLedgerEntry.FINDFIRST THEN
            REPEAT
                Qty += ItemLedgerEntry.Quantity;
            UNTIL ItemLedgerEntry.NEXT = 0;
    end;

    local procedure CalcTotSalesOrder(LocCode: Code[20]; ItemNo: Code[20]) Qty: Decimal
    var
        SalesLine: Record 37;
    begin
        SalesLine.RESET;
        SalesLine.SETFILTER("No.", '%1', ItemNo);
        SalesLine.SETFILTER("Location Code", '%1', LocCode);
        SalesLine.SETFILTER("Outstanding Quantity", '<>%1', 0);
        IF SalesLine.FINDFIRST THEN
            REPEAT
                Qty += SalesLine."Outstanding Qty. (Base)";
            UNTIL SalesLine.NEXT = 0;
    end;

    local procedure CalculateSummary(ITemNo: Code[20]; LocationCode: Code[10]; MfgItem: Integer)
    var
        Item: Record 27;
    begin
        IF NOT TempItemAmount.GET(LocationCode, ITemNo, '') THEN BEGIN
            TempItemAmount.INIT;
            TempItemAmount."Item No." := ITemNo;
            TempItemAmount."Location Code" := LocationCode;
            TempItemAmount."Dampener Quantity" := MfgItem;
            TempItemAmount."Minimum Order Quantity" := CalcTotInventory(LocationCode, ITemNo);
            TempItemAmount."Maximum Order Quantity" := CalcTotSalesOrder(LocationCode, ITemNo);
            TempItemAmount.INSERT;
        END;
    end;
}

