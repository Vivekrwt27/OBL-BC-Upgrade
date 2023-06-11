report 50263 "Distribution Expansion New"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\DistributionExpansionNew.rdl';

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number);
            column(CustCnt; CustomerSalesAmount."Customer No.")
            {
            }
            column(txtMonth; txtMonth)
            {
            }
            column(intYear; intYear)
            {
            }
            column(intMonthGrp; intMonthGrp)
            {
            }
            column(txtSort; txtSort)
            {
            }
            column(intAllCustCnt; intAllCustCnt)
            {
            }
            column(txtCustCnt1; txtCustCnt[1])
            {
            }
            column(txtCustCnt2; txtCustCnt[2])
            {
            }
            column(txtCustCnt3; txtCustCnt[3])
            {
            }
            column(txtCustCnt4; txtCustCnt[4])
            {
            }
            column(txtCustCnt5; txtCustCnt[5])
            {
            }
            column(txtCustCnt6; txtCustCnt[6])
            {
            }
            column(txtCustCnt7; txtCustCnt[7])
            {
            }
            column(txtCustCnt8; txtCustCnt[8])
            {
            }
            column(txtCustCnt9; txtCustCnt[9])
            {
            }
            column(txtCustCnt10; txtCustCnt[10])
            {
            }
            column(txtCustCnt11; txtCustCnt[11])
            {
            }
            column(txtCustCnt12; txtCustCnt[12])
            {
            }

            trigger OnAfterGetRecord()
            begin

                IF intCustCnt > CustCnt THEN BEGIN
                    intAllCustCnt := 0;
                    EVALUATE(intYear, COPYSTR(CustomerSalesAmount.Period, STRLEN(CustomerSalesAmount.Period) - 3, 5));
                    EVALUATE(intMonthGrp, COPYSTR(CustomerSalesAmount.Period, 1, 2));
                    txtMonth := CustomerSalesAmount.Period;
                    intAllCustCnt := CustomerSalesAmount.COUNT;
                    CustCnt += 1;
                    CustomerSalesAmount.NEXT;
                    IF CustomerSalesAmount."Sales Amount" < 50000 THEN
                        CurrReport.SKIP;
                END ELSE
                    IF intItemCnt > ItemCnt THEN BEGIN
                        CLEAR(txtCustCnt);
                        txtMonth := ItemSalesAmount.Period;
                        EVALUATE(intYear, COPYSTR(ItemSalesAmount.Period, STRLEN(ItemSalesAmount.Period) - 3, 5));
                        EVALUATE(intMonthGrp, COPYSTR(ItemSalesAmount.Period, 1, 2));
                        IF (ItemSalesAmount."Tableau Product Group" = 'CERAMIC') AND (ItemSalesAmount."Size Code Desc." = '300X450') THEN BEGIN
                            txtCustCnt[1] := ItemSalesAmount."Customer No.";
                        END;

                        IF (ItemSalesAmount."Tableau Product Group" = 'CERAMIC') AND (ItemSalesAmount."Size Code Desc." = '300X600') THEN BEGIN
                            txtCustCnt[2] := ItemSalesAmount."Customer No.";
                        END;

                        IF (ItemSalesAmount."Tableau Product Group" = 'CERAMIC') AND (ItemSalesAmount."Size Code Desc." = '600X600') THEN BEGIN
                            txtCustCnt[3] := ItemSalesAmount."Customer No.";
                        END;

                        IF (ItemSalesAmount."Tableau Product Group" = 'DC') AND (ItemSalesAmount."Size Code Desc." = '600X600') THEN BEGIN
                            txtCustCnt[4] := ItemSalesAmount."Customer No.";
                        END;

                        IF (ItemSalesAmount."Tableau Product Group" = 'GVT') AND (ItemSalesAmount."Size Code Desc." = '600X1200') THEN BEGIN
                            txtCustCnt[5] := ItemSalesAmount."Customer No.";
                        END;

                        IF (ItemSalesAmount."Tableau Product Group" = 'GVT') AND (ItemSalesAmount."Size Code Desc." = '600X600') THEN BEGIN
                            txtCustCnt[6] := ItemSalesAmount."Customer No.";
                        END;

                        IF (ItemSalesAmount."Tableau Product Group" = 'FBVT') THEN BEGIN
                            txtCustCnt[7] := ItemSalesAmount."Customer No.";
                        END;

                        IF (ItemSalesAmount."Type Code" = 'PVT/Nano') THEN BEGIN
                            txtCustCnt[8] := ItemSalesAmount."Customer No.";
                        END;

                        IF (ItemSalesAmount.NPD = 'DUAZZLE') THEN BEGIN
                            txtCustCnt[9] := ItemSalesAmount."Customer No.";
                        END;

                        IF (ItemSalesAmount.NPD = 'RAHINO PAVERS') THEN BEGIN
                            txtCustCnt[10] := ItemSalesAmount."Customer No.";
                        END;

                        IF (ItemSalesAmount.NPD = 'TIMELESS') THEN BEGIN
                            txtCustCnt[11] := ItemSalesAmount."Customer No.";
                        END;

                        IF (ItemSalesAmount.NPD = 'VALENCICA') THEN BEGIN
                            txtCustCnt[12] := ItemSalesAmount."Customer No.";
                        END;
                        ItemCnt += 1;
                        ItemSalesAmount.NEXT;
                    END;
            end;

            trigger OnPreDataItem()
            begin
                intCustCnt := 0;
                CustomerSalesAmount.RESET;
                IF CustomerSalesAmount.FIND('-') THEN
                    intCustCnt := CustomerSalesAmount.COUNT;

                ItemSalesAmount.RESET;
                IF ItemSalesAmount.FIND('-') THEN
                    intItemCnt := ItemSalesAmount.COUNT;

                Integer.SETRANGE(Number, 1, intCustCnt + intItemCnt);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("From Date"; dtFromDate)
                {
                    ApplicationArea = All;
                }
                field("To Date"; dtToDate)
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

    trigger OnPreReport()
    begin
        //IF CustomerAmount.FINDFIRST THEN
        //  CustomerAmount.DELETEALL;

        GenerateReportData;
    end;

    var
        CustomerAmount: Record "Customer Amount";
        txtCustCnt: array[15] of Text;
        SalesJournalData: Query "Sales Journal Data";
        txtMonth: Text;
        dtFromDate: Date;
        dtToDate: Date;
        i: Integer;
        intMonthGrp: Integer;
        intYear: Integer;
        intAllCustCnt: Integer;
        rItem: Record Item;
        txtSort: Text;
        DistributionExpansion: Query "Distribution Expansion";
        ItemSalesAmount: Record "Temp Item Sales Amount" temporary;
        CustomerSalesAmount: Record "Temp Customer Sales Amount" temporary;
        intCustCnt: Integer;
        intItemCnt: Integer;
        CustCnt: Integer;
        ItemCnt: Integer;

    local procedure CalculateCustomerCount(CustomerNo: Code[20]; Slab: Integer; GrpSlab: Integer; MonthText: Text)
    begin
        CustomerAmount.RESET;
        CustomerAmount.SETFILTER("Customer No.", '%1', CustomerNo);
        CustomerAmount.SETFILTER("Amount (LCY)", '%1', Slab);
        CustomerAmount.SETFILTER("Amount 2 (LCY)", '%1', GrpSlab);
        IF NOT CustomerAmount.FINDFIRST THEN BEGIN
            CustomerAmount.INIT;
            CustomerAmount."Customer No." := CustomerNo;
            CustomerAmount."Amount (LCY)" := Slab;
            CustomerAmount."Amount 2 (LCY)" := GrpSlab;
            CustomerAmount."SP Code" := MonthText;
            CustomerAmount.INSERT;
        END;
    end;

    local procedure GenerateReportData()
    begin
        CLEAR(DistributionExpansion);
        DistributionExpansion.SETRANGE(DistributionExpansion.Posting_Date_filter, CALCDATE('-1Y', dtFromDate), CALCDATE('-1Y', dtToDate));
        DistributionExpansion.OPEN;
        WHILE DistributionExpansion.READ DO BEGIN
            ///    InsertCustomerData(DistributionExpansion.CustNo, FORMAT(DistributionExpansion.Month_Posting_Date) + '-' + FORMAT(DistributionExpansion.Year_Posting_Date), DistributionExpansion.Sum_Amount_To_Customer);
            ///    InsertItemData(DistributionExpansion.ItemNo, DistributionExpansion.CustNo, FORMAT(DistributionExpansion.Month_Posting_Date) + '-' + FORMAT(DistributionExpansion.Year_Posting_Date), DistributionExpansion.Sum_Amount_To_Customer);
        END;

        CLEAR(DistributionExpansion);
        DistributionExpansion.SETRANGE(DistributionExpansion.Posting_Date_filter, dtFromDate, dtToDate);
        DistributionExpansion.OPEN;
        WHILE DistributionExpansion.READ DO BEGIN
            ///   InsertCustomerData(DistributionExpansion.CustNo, FORMAT(DistributionExpansion.Month_Posting_Date) + '-' + FORMAT(DistributionExpansion.Year_Posting_Date), DistributionExpansion.Sum_Amount_To_Customer);
            ///    InsertItemData(DistributionExpansion.ItemNo, DistributionExpansion.CustNo, FORMAT(DistributionExpansion.Month_Posting_Date) + '-' + FORMAT(DistributionExpansion.Year_Posting_Date), DistributionExpansion.Sum_Amount_To_Customer);
        END;
    end;

    local procedure InsertCustomerData(CustNo: Code[20]; Period: Code[10]; Amt: Decimal)
    var
        rCustomer: Record Customer;
    begin
        IF STRLEN(Period) = 6 THEN
            Period := '0' + Period
        ELSE
            Period := Period;
        IF NOT CustomerSalesAmount.GET(CustNo, Period) THEN BEGIN
            CustomerSalesAmount.INIT;
            CustomerSalesAmount."Customer No." := CustNo;
            IF STRLEN(Period) = 6 THEN
                CustomerSalesAmount.Period := '0' + Period
            ELSE
                CustomerSalesAmount.Period := Period;
            CustomerSalesAmount."Sales Amount" := Amt;
            CustomerSalesAmount.INSERT;
        END ELSE BEGIN
            CustomerSalesAmount.RESET;
            IF CustomerSalesAmount.GET(CustNo, Period) THEN BEGIN
                CustomerSalesAmount."Sales Amount" += Amt;
                CustomerSalesAmount.MODIFY;
            END;
        END;
    end;

    local procedure InsertItemData(ItemNo: Code[20]; CustNo: Code[20]; Period: Code[10]; Amt: Decimal)
    var
        rItem: Record Item;
        rCustomer: Record Customer;
    begin
        IF STRLEN(Period) = 6 THEN
            Period := '0' + Period
        ELSE
            Period := Period;
        IF NOT ItemSalesAmount.GET(ItemNo, CustNo, Period) THEN BEGIN

            rItem.RESET;
            IF rItem.GET(ItemNo) THEN;
            ItemSalesAmount.INIT;
            ItemSalesAmount."Item No." := ItemNo;
            ItemSalesAmount."Tableau Product Group" := rItem."Tableau Product Group";
            ItemSalesAmount."Size Code Desc." := rItem."Size Code Desc.";
            ItemSalesAmount."Type Code" := rItem."Type Code";
            ItemSalesAmount.NPD := rItem.NPD;
            ItemSalesAmount."Customer No." := CustNo;
            IF STRLEN(Period) = 6 THEN
                ItemSalesAmount.Period := '0' + Period
            ELSE
                ItemSalesAmount.Period := Period;
            ItemSalesAmount."Sales Amount" := Amt;
            ItemSalesAmount.INSERT;
        END ELSE BEGIN
            ItemSalesAmount.RESET;
            IF ItemSalesAmount.GET(ItemNo, CustNo, Period) THEN BEGIN
                ItemSalesAmount."Sales Amount" += Amt;
                ItemSalesAmount.MODIFY;
            END;
        END;
    end;
}

