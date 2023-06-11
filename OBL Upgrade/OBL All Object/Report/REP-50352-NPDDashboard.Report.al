report 50352 "NPD Dashboard"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\NPDDashboard.rdl';

    dataset
    {
        dataitem(Customer_Loop; Customer)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE("Area Code" = FILTER(<> ''));
            column(ASonDate4; FORMAT(AsonDate))
            {
            }
            column(Zone; "Matrix Master".Description)
            {
            }
            column(AreaCode; "Matrix Master"."Type 1")
            {
            }
            column(AreaDescription; "Matrix Master"."Description 2")
            {
            }
            column(CustNo; Customer_Loop."No.")
            {
            }
            column(CustName; Customer_Loop.Name)
            {
            }
            column(CustCity; Customer_Loop.City)
            {
            }
            column(decYTDDesp1; decYTDDesp[1])
            {
            }
            column(decYTDDesp2; decYTDDesp[2])
            {
            }
            column(decYTDDesp3; decYTDDesp[3])
            {
            }
            column(decYTDDesp4; decYTDDesp[4])
            {
            }
            column(decYTDDesp5; decYTDDesp[5])
            {
            }
            column(decYTDDesp6; decYTDDesp[6])
            {
            }
            column(decYTDDesp7; decYTDDesp[7])
            {
            }
            column(decYTDDesp8; decYTDDesp[8])
            {
            }
            column(decYTDDesp9; decYTDDesp[9])
            {
            }
            column(decYTDDesp10; decYTDDesp[10])
            {
            }
            column(decYTDDesp11; decYTDDesp[11])
            {
            }
            column(decYTDDesp12; decYTDDesp[12])
            {
            }
            column(decYTDDesp13; decYTDDesp[13])
            {
            }
            column(decYTDDesp14; decYTDDesp[14])
            {
            }
            column(decYTDDesp15; decYTDDesp[15])
            {
            }
            column(decYTDDesp16; decYTDDesp[16])
            {
            }
            column(decYTDDesp17; decYTDDesp[17])
            {
            }
            column(decYTDDesp18; decYTDDesp[18])
            {
            }
            column(decYTDDesp19; decYTDDesp[19])
            {
            }
            column(decMTDDesp1; decMTDDesp[1])
            {
            }
            column(decMTDDesp2; decMTDDesp[2])
            {
            }
            column(decMTDDesp3; decMTDDesp[3])
            {
            }
            column(decMTDDesp4; decMTDDesp[4])
            {
            }
            column(decMTDDesp5; decMTDDesp[5])
            {
            }
            column(decMTDDesp6; decMTDDesp[6])
            {
            }
            column(decMTDDesp7; decMTDDesp[7])
            {
            }
            column(decMTDDesp8; decMTDDesp[8])
            {
            }
            column(decMTDDesp9; decMTDDesp[9])
            {
            }
            column(decMTDDesp10; decMTDDesp[10])
            {
            }
            column(decMTDDesp11; decMTDDesp[11])
            {
            }
            column(decMTDDesp12; decMTDDesp[12])
            {
            }
            column(decMTDDesp13; decMTDDesp[13])
            {
            }
            column(decMTDDesp14; decMTDDesp[14])
            {
            }
            column(decMTDDesp15; decMTDDesp[15])
            {
            }
            column(decMTDDesp16; decMTDDesp[16])
            {
            }
            column(decMTDDesp17; decMTDDesp[17])
            {
            }
            column(decMTDDesp18; decMTDDesp[18])
            {
            }
            column(decMTDDesp19; decMTDDesp[19])
            {
            }
            column(intMTDCustCnt1; intMTDCustCnt[1])
            {
            }
            column(intMTDCustCnt2; intMTDCustCnt[2])
            {
            }
            column(intMTDCustCnt3; intMTDCustCnt[3])
            {
            }
            column(intMTDCustCnt4; intMTDCustCnt[4])
            {
            }
            column(intMTDCustCnt5; intMTDCustCnt[5])
            {
            }
            column(intMTDCustCnt6; intMTDCustCnt[6])
            {
            }
            column(intMTDCustCnt7; intMTDCustCnt[7])
            {
            }
            column(intMTDCustCnt8; intMTDCustCnt[8])
            {
            }
            column(intMTDCustCnt9; intMTDCustCnt[9])
            {
            }
            column(intMTDCustCnt10; intMTDCustCnt[10])
            {
            }
            column(intMTDCustCnt11; intMTDCustCnt[11])
            {
            }
            column(intMTDCustCnt12; intMTDCustCnt[12])
            {
            }
            column(intMTDCustCnt13; intMTDCustCnt[13])
            {
            }
            column(intMTDCustCnt14; intMTDCustCnt[14])
            {
            }
            column(intMTDCustCnt15; intMTDCustCnt[15])
            {
            }
            column(intMTDCustCnt16; intMTDCustCnt[16])
            {
            }
            column(intMTDCustCnt17; intMTDCustCnt[17])
            {
            }
            column(intMTDCustCnt18; intMTDCustCnt[18])
            {
            }
            column(intMTDCustCnt19; intMTDCustCnt[19])
            {
            }
            column(intYTDCustCnt1; intYTDCustCnt[1])
            {
            }
            column(intYTDCustCnt2; intYTDCustCnt[2])
            {
            }
            column(intYTDCustCnt3; intYTDCustCnt[3])
            {
            }
            column(intYTDCustCnt4; intYTDCustCnt[4])
            {
            }
            column(intYTDCustCnt5; intYTDCustCnt[5])
            {
            }
            column(intYTDCustCnt6; intYTDCustCnt[6])
            {
            }
            column(intYTDCustCnt7; intYTDCustCnt[7])
            {
            }
            column(intYTDCustCnt8; intYTDCustCnt[8])
            {
            }
            column(intYTDCustCnt9; intYTDCustCnt[9])
            {
            }
            column(intYTDCustCnt10; intYTDCustCnt[10])
            {
            }
            column(intYTDCustCnt11; intYTDCustCnt[11])
            {
            }
            column(intYTDCustCnt12; intYTDCustCnt[12])
            {
            }
            column(intYTDCustCnt13; intYTDCustCnt[13])
            {
            }
            column(intYTDCustCnt14; intYTDCustCnt[14])
            {
            }
            column(intYTDCustCnt15; intYTDCustCnt[15])
            {
            }
            column(intYTDCustCnt16; intYTDCustCnt[16])
            {
            }
            column(intYTDCustCnt17; intYTDCustCnt[17])
            {
            }
            column(intYTDCustCnt18; intYTDCustCnt[18])
            {
            }
            column(intYTDCustCnt19; intYTDCustCnt[19])
            {
            }
            column(intAllCustCnt; intAllCustCnt)
            {
            }
            column(decAllCustDesp; decAllCustDesp)
            {
            }

            trigger OnAfterGetRecord()
            var
                OrderReleaseDate: Date;
                InvReleaseDate: Date;
                Customer: Record Customer;
            begin
                "Matrix Master".RESET;
                "Matrix Master".SETRANGE("Matrix Master"."Type 1", Customer_Loop."Area Code");
                IF NOT "Matrix Master".FINDFIRST THEN
                    CurrReport.SKIP;

                //Keshav09112020
                CLEAR(decMTDDesp);
                CLEAR(decYTDDesp);
                CLEAR(intAllCustCnt);
                CLEAR(decAllCustDesp);
                CLEAR(intMTDCustCnt);
                CLEAR(intYTDCustCnt);

                //YTD CustCount>>
                CLEAR(SalesJournalData);
                // SalesJournalData.SETFILTER(SalesJournalData.AreaFilter,'%1',"Matrix Master"."Type 1");
                SalesJournalData.SETFILTER(SalesJournalData.CustCodeFilter, '%1', Customer_Loop."No.");
                // SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter,'%1..%2',DMY2DATE(1,4,DATE2DMY(AsonDate,3)),AsonDate);
                SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', DMY2DATE(1, 4, intYear), AsonDate);
                SalesJournalData.OPEN;
                WHILE SalesJournalData.READ DO BEGIN
                    decAllCustDesp += SalesJournalData.Quantity_in_Sq_Mt;
                    CalculateCustomerCount(SalesJournalData.CustomerNo, 0, 0, Customer_Loop."Area Code");
                    IF (SalesJournalData.TabProdGrp = 'DC') AND (SalesJournalData.Item_npd = 'Zenith 600X600') THEN BEGIN
                        decYTDDesp[1] += SalesJournalData.Quantity_in_Sq_Mt;
                        CalculateCustomerCount(SalesJournalData.CustomerNo, 1, 1, Customer_Loop."Area Code");
                    END;
                    IF (SalesJournalData.TabProdGrp = 'FBVT') AND (SalesJournalData.Item_npd = 'Sahara') THEN BEGIN
                        decYTDDesp[2] += SalesJournalData.Quantity_in_Sq_Mt;
                        CalculateCustomerCount(SalesJournalData.CustomerNo, 2, 1, Customer_Loop."Area Code");
                    END;
                    IF (SalesJournalData.TabProdGrp = 'Ceramic') THEN BEGIN
                        IF (SalesJournalData.Item_npd = 'Estilo 12X18') THEN BEGIN
                            decYTDDesp[3] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 3, 1, Customer_Loop."Area Code");
                        END;
                        IF (SalesJournalData.Item_npd = 'Estilo 12X24') THEN BEGIN
                            decYTDDesp[4] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 4, 1, Customer_Loop."Area Code");
                        END;
                        IF (SalesJournalData.Item_npd = 'Sparkle') THEN BEGIN
                            decYTDDesp[5] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 5, 1, Customer_Loop."Area Code");
                        END;
                        IF (SalesJournalData.Item_npd = 'Estilo 12X18') OR (SalesJournalData.Item_npd = 'Sparkle') THEN BEGIN
                            decYTDDesp[6] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 6, 1, Customer_Loop."Area Code");
                        END;
                        IF (SalesJournalData.Item_npd = 'Dora 2X2 Jul') THEN BEGIN
                            decYTDDesp[7] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 7, 1, Customer_Loop."Area Code");
                        END;
                        IF (SalesJournalData.Item_npd = 'Hdp Elev') THEN BEGIN
                            decYTDDesp[8] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 8, 1, Customer_Loop."Area Code");
                        END;
                        IF (SalesJournalData.Item_npd = 'Rhino') THEN BEGIN
                            decYTDDesp[9] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 9, 1, Customer_Loop."Area Code");
                        END;
                        IF (SalesJournalData.Item_npd = 'Duazzle') THEN BEGIN
                            decYTDDesp[10] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 10, 1, Customer_Loop."Area Code");
                        END;
                        IF (SalesJournalData.Item_npd = 'Ascend Step') THEN BEGIN
                            decYTDDesp[11] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 11, 1, Customer_Loop."Area Code");
                        END;
                    END;
                    IF SalesJournalData.TabProdGrp = 'GVT' THEN BEGIN
                        IF SalesJournalData.Item_npd = 'Aug Inspire_600X600' THEN BEGIN
                            decYTDDesp[12] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 12, 1, Customer_Loop."Area Code");
                        END;
                        IF SalesJournalData.Item_npd = 'Inspire Gvt' THEN BEGIN
                            decYTDDesp[13] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 13, 1, Customer_Loop."Area Code");
                        END;
                        IF SalesJournalData.Item_npd = 'Aug Npd 20 195X1200' THEN BEGIN
                            decYTDDesp[14] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 14, 1, Customer_Loop."Area Code");
                        END;
                        IF SalesJournalData.Item_npd = 'Timeless' THEN BEGIN
                            decYTDDesp[15] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 15, 1, Customer_Loop."Area Code");
                        END;
                        IF SalesJournalData.Item_npd = 'Eleg 12x18' THEN BEGIN
                            decYTDDesp[16] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 16, 1, Customer_Loop."Area Code");
                        END;
                        IF SalesJournalData.Item_npd = 'Eleg 12x24' THEN BEGIN
                            decYTDDesp[17] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 17, 1, Customer_Loop."Area Code");
                        END;
                        IF SalesJournalData.Item_npd = 'RIVER' THEN BEGIN
                            decYTDDesp[18] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 18, 1, Customer_Loop."Area Code");
                        END;
                        IF SalesJournalData.Item_npd = 'SKD 1x1 Pavers' THEN BEGIN
                            decYTDDesp[19] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 19, 1, Customer_Loop."Area Code");
                        END;
                    END;
                END;
                //YTD CustCount<<

                //MTD CustCount and Dispatch Calculation>>
                CLEAR(SalesJournalData);
                // SalesJournalData.SETFILTER(SalesJournalData.AreaFilter,'%1',"Matrix Master"."Type 1");
                SalesJournalData.SETFILTER(SalesJournalData.CustCodeFilter, '%1', Customer_Loop."No.");
                SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', CALCDATE('-CM', AsonDate - 1), AsonDate - 1);
                SalesJournalData.OPEN;
                WHILE SalesJournalData.READ DO BEGIN
                    IF (SalesJournalData.TabProdGrp = 'DC') AND (SalesJournalData.Item_npd = 'Zenith 600X600') THEN BEGIN
                        decMTDDesp[1] += SalesJournalData.Quantity_in_Sq_Mt;
                        CalculateCustomerCount(SalesJournalData.CustomerNo, 1, 2, Customer_Loop."Area Code");
                    END;
                    IF (SalesJournalData.TabProdGrp = 'FBVT') AND (SalesJournalData.Item_npd = 'Sahara') THEN BEGIN
                        decMTDDesp[2] += SalesJournalData.Quantity_in_Sq_Mt;
                        CalculateCustomerCount(SalesJournalData.CustomerNo, 2, 2, Customer_Loop."Area Code");
                    END;
                    IF (SalesJournalData.TabProdGrp = 'Ceramic') THEN BEGIN
                        IF (SalesJournalData.Item_npd = 'Estilo 12x18') THEN BEGIN
                            decMTDDesp[3] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 3, 2, Customer_Loop."Area Code");
                        END;
                        IF (SalesJournalData.Item_npd = 'Estilo 12x24') THEN BEGIN
                            decMTDDesp[4] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 4, 2, Customer_Loop."Area Code");
                        END;
                        IF (SalesJournalData.Item_npd = 'Sparkle') THEN BEGIN
                            decMTDDesp[5] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 5, 2, Customer_Loop."Area Code");
                        END;
                        IF (SalesJournalData.Item_npd = 'Estilo 12x18') OR (SalesJournalData.Item_npd = 'Sparkle') THEN BEGIN
                            decMTDDesp[6] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 6, 2, Customer_Loop."Area Code");
                        END;
                        IF (SalesJournalData.Item_npd = 'Dora 2X2 Jul') THEN BEGIN
                            decMTDDesp[7] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 7, 2, Customer_Loop."Area Code");
                        END;
                        IF (SalesJournalData.Item_npd = 'Hdp Elev') THEN BEGIN
                            decMTDDesp[8] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 8, 2, Customer_Loop."Area Code");
                        END;
                        IF (SalesJournalData.Item_npd = 'Rhino') THEN BEGIN
                            decMTDDesp[9] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 9, 2, Customer_Loop."Area Code");
                        END;
                        IF (SalesJournalData.Item_npd = 'Duazzle') THEN BEGIN
                            decMTDDesp[10] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 10, 2, Customer_Loop."Area Code");
                        END;
                        IF (SalesJournalData.Item_npd = 'Ascend Step') THEN BEGIN
                            decMTDDesp[11] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 11, 2, Customer_Loop."Area Code");
                        END;
                    END;
                    IF SalesJournalData.TabProdGrp = 'GVT' THEN BEGIN
                        IF SalesJournalData.Item_npd = 'Aug Inspire_600X600' THEN BEGIN
                            decMTDDesp[12] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 12, 2, Customer_Loop."Area Code");
                        END;
                        IF SalesJournalData.Item_npd = 'Inspire Gvt' THEN BEGIN
                            decMTDDesp[13] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 13, 2, Customer_Loop."Area Code");
                        END;
                        IF SalesJournalData.Item_npd = 'Aug Npd 20 195X1200' THEN BEGIN
                            decMTDDesp[14] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 14, 2, Customer_Loop."Area Code");
                        END;
                        IF SalesJournalData.Item_npd = 'Timeless' THEN BEGIN
                            decMTDDesp[15] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 15, 2, Customer_Loop."Area Code");
                        END;
                        IF SalesJournalData.Item_npd = 'Eleg 12x18' THEN BEGIN
                            decMTDDesp[16] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 16, 1, Customer_Loop."Area Code");
                        END;
                        IF SalesJournalData.Item_npd = 'Eleg 12x24' THEN BEGIN
                            decMTDDesp[17] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 17, 1, Customer_Loop."Area Code");
                        END;
                        IF SalesJournalData.Item_npd = 'RIVER' THEN BEGIN
                            decMTDDesp[18] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 18, 1, Customer_Loop."Area Code");
                        END;
                        IF SalesJournalData.Item_npd = 'SKD 1x1 Pavers' THEN BEGIN
                            decMTDDesp[19] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 19, 1, Customer_Loop."Area Code");
                        END;
                    END;
                END;
                //MTD CustCount and Dispatch Calculation>>

                CustomerAmount.RESET;
                CustomerAmount.SETRANGE("Amount (LCY)", 0);
                CustomerAmount.SETRANGE("Amount 2 (LCY)", 0);
                CustomerAmount.SETRANGE("SP Code", Customer_Loop."Area Code");
                IF CustomerAmount.FINDFIRST THEN BEGIN
                    intAllCustCnt := CustomerAmount.COUNT;
                END;

                FOR i := 1 TO 19 DO BEGIN
                    CustomerAmount.RESET;
                    CustomerAmount.SETFILTER("Amount (LCY)", '%1', i);
                    CustomerAmount.SETFILTER("Amount 2 (LCY)", '%1', 1);
                    CustomerAmount.SETRANGE("SP Code", Customer_Loop."Area Code");
                    IF CustomerAmount.FINDFIRST THEN BEGIN
                        intYTDCustCnt[i] := CustomerAmount.COUNT;
                    END;
                END;
                FOR i := 1 TO 19 DO BEGIN
                    CustomerAmount.RESET;
                    CustomerAmount.SETFILTER("Amount (LCY)", '%1', i);
                    CustomerAmount.SETFILTER("Amount 2 (LCY)", '%1', 2);
                    CustomerAmount.SETRANGE("SP Code", Customer_Loop."Area Code");
                    IF CustomerAmount.FINDFIRST THEN BEGIN
                        intMTDCustCnt[i] := CustomerAmount.COUNT;
                    END;
                END;
                IF decAllCustDesp = 0 THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                IF CustomerAmount.FINDFIRST THEN
                    CustomerAmount.DELETEALL;
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

    trigger OnInitReport()
    begin
        AsonDate := TODAY;
        IF DATE2DMY(AsonDate, 3) > 3 THEN
            intYear := DATE2DMY(AsonDate, 3) - 1
        ELSE
            intYear := DATE2DMY(AsonDate, 3);
    end;

    var
        AsonDate: Date;
        recItem: Record Item;
        decOpnOrderOtstnd: array[25] of Decimal;
        decMTDDesp: array[25] of Decimal;
        decYTDDesp: array[25] of Decimal;
        SalesJournalData: Query "Sales Journal Data";
        tempMatrixMaster: Record "Matrix Master" temporary;
        decMTDRet: array[25] of Decimal;
        intMTDCustCnt: array[25] of Integer;
        intYTDCustCnt: array[25] of Integer;
        tempSalesInvHdr: array[25] of Record "Sales Invoice Header" temporary;
        recSalInvHdr: array[25] of Record "Sales Invoice Header";
        intMinus: Integer;
        tempSalesInvHdrYTD: array[25] of Record "Sales Invoice Header" temporary;
        intTest: Integer;
        CustomerAmount: Record "Customer Amount";
        i: Integer;
        intAllCustCnt: Integer;
        decAllCustDesp: Decimal;
        "Matrix Master": Record "Matrix Master";
        intYear: Integer;

    local procedure CalculateCustomerCount(CustomerNo: Code[20]; Slab: Integer; GrpSlab: Integer; AreaCode: Text)
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
            CustomerAmount."SP Code" := AreaCode;
            CustomerAmount.INSERT;
        END;
    end;
}

