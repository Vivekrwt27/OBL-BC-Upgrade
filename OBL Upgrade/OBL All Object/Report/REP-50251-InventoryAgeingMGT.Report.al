report 50251 "Inventory Ageing -MGT"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\InventoryAgeingMGT.rdl';

    dataset
    {
        dataitem(Location; Location)
        {
            DataItemTableView = WHERE("Tableau Location" = CONST(true));
            column(Month; Month)
            {
            }
            column(Year; Year)
            {
            }
            column(ASOnDate; ASOnDate)
            {
            }
            column(Location; Location.Code)
            {
            }
            column(BlnDetailed; BlnDetailed)
            {
            }
            column(SaleQty; SalesQty)
            {
            }
            column(SaleValue; SalesValue)
            {
            }
            column(MonthlyAvgSale; MonthlyAvgSale)
            {
            }
            column(DailyAvgSale; DailyAvgSale)
            {
            }
            column(CurrMonthSalesValue; CurrMonthSalesValue)
            {
            }
            column(CurrMonthSalesQty; CurrMonthSalesQty)
            {
            }
            column(ASP; ASP)
            {
            }
            column(Aread_sqft; Area)
            {
            }
            dataitem(Integer; Integer)
            {
                column(ItemNo; InventoryAgeingMGT.No)
                {
                }
                column(ItemDesc; InventoryAgeingMGT.Description)
                {
                }
                column(ItemCatCode; InventoryAgeingMGT.Item_Category_Code)
                {
                }
                column(PostDate; InventoryAgeingMGT.Posting_Date)
                {
                }
                column(Qty1; Qty[1])
                {
                }
                column(Qty2; Qty[2])
                {
                }
                column(Qty3; Qty[3])
                {
                }
                column(Qty4; Qty[4])
                {
                }
                column(TotQty; Qty[1] + Qty[2] + Qty[3] + Qty[4])
                {
                }
                column(Tableau_product; InventoryAgeingMGT.Tableau_Product_Group)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF NOT InventoryAgeingMGT.READ THEN
                        CurrReport.BREAK;
                    /*
                    IF InventoryAgeingMGT.No <> ItemCode THEN BEGIN
                    SalesQty := 0;
                    SalesValue := 0;
                    CLEAR(SalesJournalData);
                    SalesJournalData.SETRANGE(SalesJournalData.LocationCode,Location.Code);
                    SalesJournalData.SETRANGE(SalesJournalData.PostingDate,YearStartDDate,YearEndDate);
                    SalesJournalData.OPEN;
                    WHILE SalesJournalData.READ DO BEGIN
                      SalesQty += SalesJournalData.Quantity_Base;
                      SalesValue += SalesJournalData.LineAmount;
                    END;
                    END;
                    */
                    CLEAR(Qty);
                    CASE ASOnDate - InventoryAgeingMGT.Posting_Date OF
                        0 .. 90:
                            Qty[1] := InventoryAgeingMGT.Sum_Remaining_Quantity;
                        91 .. 180:
                            Qty[2] := InventoryAgeingMGT.Sum_Remaining_Quantity;
                        181 .. 300:
                            Qty[3] := InventoryAgeingMGT.Sum_Remaining_Quantity;
                        301 .. 999999:
                            Qty[4] := InventoryAgeingMGT.Sum_Remaining_Quantity;

                    END;

                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(InventoryAgeingMGT);
                InventoryAgeingMGT.SETRANGE(InventoryAgeingMGT.Location_Code, Location.Code);
                InventoryAgeingMGT.OPEN;
                SalesQty := 0;
                SalesValue := 0;
                ASP := 0;
                DailyAvgSale := 0;
                CurrMonthSalesValue := 0;
                CurrMonthSalesQty := 0;

                CLEAR(SalesJournalData);
                SalesJournalData.SETRANGE(SalesJournalData.LocationCode, Location.Code);
                SalesJournalData.SETRANGE(SalesJournalData.PostingDate, YearStartDDate, YearEndDate);
                SalesJournalData.OPEN;
                WHILE SalesJournalData.READ DO BEGIN
                    SalesQty += SalesJournalData.Quantity_Base;
                    SalesValue += SalesJournalData.LineAmount;
                    IF SalesJournalData.PostingDate >= CALCDATE('-CM', ASOnDate) THEN BEGIN
                        CurrMonthSalesValue += SalesJournalData.LineAmount;
                        CurrMonthSalesQty += SalesJournalData.Quantity_Base;
                    END;
                END;

                IF SalesQty <> 0 THEN
                    ASP := SalesValue / SalesQty;

                MonthlyAvgSale := (SalesQty / Mnth) * 30;
                DailyAvgSale := MonthlyAvgSale / 30;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(Detailed; BlnDetailed)
                    {
                        ApplicationArea = All;
                    }
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
        ASOnDate := TODAY - 1;
        day := DATE2DMY(ASOnDate, 2);
        Year := DATE2DMY(ASOnDate, 3);
        CASE day OF
            1:
                Month := 'JAN';
            2:
                Month := 'FEB';
            3:
                Month := 'MARCH';
            4:
                Month := 'APR';
            5:
                Month := 'MAY';
            6:
                Month := 'JUNE';
            7:
                Month := 'JULY';
            8:
                Month := 'AUG';
            9:
                Month := 'SEPT';
            10:
                Month := 'OCT';
            11:
                Month := 'NOV';
            12:
                Month := 'DEC';
        END;
        ////ASOnDate := 310119D;
        IF DATE2DMY(ASOnDate, 2) IN [1, 2, 3] THEN BEGIN
            YearStartDDate := DMY2DATE(1, 4, DATE2DMY(ASOnDate, 3) - 1);
            YearEndDate := DMY2DATE(31, 3, DATE2DMY(ASOnDate, 3));
            //  StartYearPart := DATE2DMY(ASonDate,3)-1;
            //  ENDYearPart := DATE2DMY(ASonDate,3);
        END ELSE BEGIN
            YearStartDDate := DMY2DATE(1, 4, DATE2DMY(ASOnDate, 3));
            YearEndDate := DMY2DATE(31, 3, DATE2DMY(ASOnDate, 3) + 1);
            //  StartYearPart := DATE2DMY(ASonDate,3);
            //  ENDYearPart := DATE2DMY(ASonDate,3)+1;
        END;
        //Mnth := ROUND((ASOnDate-YearStartDDate)/32,1.0,'>');
        Mnth := ROUND((ASOnDate - YearStartDDate), 1.0, '>');
        //MESSAGE('%1',Mnth);
        //MESSAGE('%1..%2', YearStartDDate, YearEndDate);
    end;

    var
        ASOnDate: Date;
        YearStartDDate: Date;
        YearEndDate: Date;
        InventoryAgeingMGT: Query "Inventory Ageing MGT";
        Qty: array[4] of Decimal;
        BlnDetailed: Boolean;
        MonthlyAvgSale: Decimal;
        ASP: Decimal;
        SalesJournalData: Query "Sales Journal Data";
        SalesQty: Decimal;
        SalesValue: Decimal;
        Days: Integer;
        Mnth: Decimal;
        ItemCode: Code[20];
        DailyAvgSale: Decimal;
        day: Integer;
        Year: Integer;
        Month: Text[20];
        CurrMonthSalesValue: Decimal;
        CurrMonthSalesQty: Decimal;

    local procedure GetSalesValue(AreaCode: Code[10]; Sdate: Date; Edate: Date; var SalesQty: Decimal; var SalesValue: Decimal; HVP: Boolean)
    var
        SalesDataMGT: Query "Sales Data -MGT";
    begin
        CLEAR(SalesDataMGT);
        IF AreaCode <> '' THEN
            IF AreaCode <> 'CKA' THEN BEGIN
                SalesDataMGT.SETFILTER(CustomerTypeFilter, '<>%1&<>%2&<>%3', 'MISC.', 'CKA', 'DIRECTPROJ');
                SalesDataMGT.SETFILTER(SalesDataMGT.AreaFilter, AreaCode);
            END ELSE BEGIN
                SalesDataMGT.SETFILTER(CustomerTypeFilter, '%1|%2|%3', 'MISC.', 'CKA', 'DIRECTPROJ');
            END;
        SalesDataMGT.SETRANGE(PostDateFilter, Sdate, Edate);
        IF HVP THEN
            SalesDataMGT.SETRANGE(SalesDataMGT.HVPFilter, TRUE);
        SalesDataMGT.OPEN;
        WHILE SalesDataMGT.READ DO BEGIN
            SalesValue += SalesDataMGT.Sum_Line_Amount;
            SalesQty += SalesDataMGT.Sum_Quantity_Base;
        END;
    end;

    procedure SetValues(BlnLocalDetail: Boolean)
    begin
        BlnDetailed := BlnLocalDetail;
    end;
}

