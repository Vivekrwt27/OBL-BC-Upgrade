report 50073 "Inventory Ageing Report1"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\InventoryAgeingReport1.rdl';
    Description = 'MIPL-Keshav';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("EYAIM_ERP 108DFs Report"; 50096)
        {
            DataItemTableView = SORTING(SuggestedResponse, "TaxPeriod-GSTR 3B") ORDER(Ascending) WHERE(SuggestedResponse = FILTER('*2021'), MatchReason = FILTER('SIKANDRABAD'));
            column(Month_InventoryReportAgeingData; "EYAIM_ERP 108DFs Report".SuggestedResponse)
            {
            }
            column(ItemNo_InventoryReportAgeingData; "EYAIM_ERP 108DFs Report"."TaxPeriod-GSTR 3B")
            {
            }
            column(MonthNumber_InventoryReportAgeingData; "EYAIM_ERP 108DFs Report".VendorRiskCategory)
            {
            }
            column(Plant_InventoryReportAgeingData; "EYAIM_ERP 108DFs Report".MatchReason)
            {
            }
            column(Size_InventoryReportAgeingData; "EYAIM_ERP 108DFs Report"."TaxPeriod(2A)")
            {
            }
            column(OpeningQty_InventoryReportAgeingData; "EYAIM_ERP 108DFs Report"."DocumentNumber(PR)")
            {
            }
            column(IncreaseQty_InventoryReportAgeingData; "EYAIM_ERP 108DFs Report"."TaxableValue(2A)")
            {
            }
            column(DecreaseQty_InventoryReportAgeingData; "EYAIM_ERP 108DFs Report"."CGST(PR)")
            {
            }
            column(ClosingQty_InventoryReportAgeingData; "EYAIM_ERP 108DFs Report"."GSTR3B-FilingStatus")
            {
            }
            column(SalesQtyInclReturn_InventoryReportAgeingData; "EYAIM_ERP 108DFs Report"."BillOfEntry(PR)")
            {
            }
            column(SalesReturnQty_InventoryReportAgeingData; "EYAIM_ERP 108DFs Report"."SupplyType(PR)")
            {
            }
            column(PriorMonthStockSales_InventoryReportAgeingData; "EYAIM_ERP 108DFs Report".SourceIdentifier)
            {
            }
            column(AsOnDate; FORMAT(TODAY - 1))
            {
            }
            column(decSumProd; decSumProd)
            {
            }
            column(ExpMonthlySales; ExpMonthlySales)
            {
            }
            column(ItemGrp; ItemGrp)
            {
            }

            trigger OnAfterGetRecord()
            begin
                // txtMonthGrp:=FORMAT("Inventory Report Ageing Data".Month,0,'<Month Text>');
                /*  IF "EYAIM_ERP 108DFs Report"."TaxableValue(2A)" > 0 THEN
                    decSumProd += "EYAIM_ERP 108DFs Report"."TaxableValue(2A)";

                IF DATE2DMY(TODAY, 2) = "EYAIM_ERP 108DFs Report".VendorRiskCategory THEN BEGIN
                    Days := DATE2DMY(TODAY - 1, 1);
                    ExpMonthlySales := ("EYAIM_ERP 108DFs Report"."BillOfEntry(PR)" * 30) / Days;
                END ELSE
                    ExpMonthlySales := "EYAIM_ERP 108DFs Report"."BillOfEntry(PR)";16630 */

                //Days := DATE2DMY(CALCDATE('CM',DMY2DATE(1,"Inventory Report Ageing Data"."Month Number",FORMAT(COPYSTR("Inventory Report Ageing Data".Month,4,4)))),1);

                rItem.RESET;
                IF rItem.GET("EYAIM_ERP 108DFs Report"."TaxPeriod-GSTR 3B") THEN;
                //ItemGrp := rItem."Type Group Code";
                ItemGrp := rItem."Production Group";
            end;

            trigger OnPreDataItem()
            begin
                IF (OptMonth <> OptMonth::" ") AND (OptYear <> OptYear::" ") THEN
                    "EYAIM_ERP 108DFs Report".SETFILTER("EYAIM_ERP 108DFs Report".SuggestedResponse, '%1', FORMAT(OptMonth) + '-' + FORMAT(OptYear));
                decSumProd := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Choose Month"; OptMonth)
                {
                    ApplicationArea = All;
                }
                field("Choose Year"; OptYear)
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

    var
        OptMonth: Option " ",JANUARY,FEBRUARY,MARCH,APRIL,MAY,JUNE,JULY,AUGUST,SEPTEMBER,OCTOBER,NOVEMBER,DECEMBER;
        OptYear: Option " ","2010","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020","2021","2022","2023","2024","2025","2026","2027",,"2028","2029","2030","2031",,"2032","2033","2034","2035","2036","2037","2038","2039","2040";
        txtMonthGrp: Text;
        decSumProd: Decimal;
        ExpMonthlySales: Decimal;
        Days: Integer;
        ItemGrp: Text;
        rItem: Record Item;
}

