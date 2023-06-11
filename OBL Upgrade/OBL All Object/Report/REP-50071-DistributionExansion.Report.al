report 50071 "Distribution Exansion"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\DistributionExansion.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Matrix Master"; 50003)
        {
            DataItemTableView = SORTING(ZH, "Sorting Order", PCH)
                                WHERE(Description = FILTER(<> ''));
            column(QuantitativeReport; QuantitativeReport)
            {
            }
            column(ASonDate; FORMAT(AsonDate))
            {
            }
            column(ASonDate1; AsonDate - 3)
            {
            }
            column(ASonDate2; AsonDate - 2)
            {
            }
            column(ASonDate3; AsonDate - 1)
            {
            }
            column(ASonDate4; FORMAT(AsonDate - 1))
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
            column(TempAreaCode; tempMatrixMaster."Type 1")
            {
            }
            column(TempZone; tempMatrixMaster.Description)
            {
            }
            column(TempAreaDes; tempMatrixMaster."Description 2")
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

            trigger OnAfterGetRecord()
            var
                OrderReleaseDate: Date;
                InvReleaseDate: Date;
                Customer: Record Customer;
            begin
                //Keshav23092020>>
                CLEAR(custNo);
                CLEAR(intMTDCustCnt);
                IF (QuantitativeReport) THEN BEGIN
                    CLEAR(SalesJournalData);
                    SalesJournalData.SETFILTER(SalesJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                    //  SalesJournalData.SETFILTER(SalesJournalData.AmountToCustomer, '>%1', 50000);
                    IF (dtFrom <> 0D) AND (dtTo <> 0D) THEN
                        SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', dtFrom, dtTo)
                    ELSE
                        SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', CALCDATE('-CM', AsonDate - 1), AsonDate - 1);
                    SalesJournalData.SETFILTER(SalesJournalData.CustomerType, '<>%1', 'CKA');
                    SalesJournalData.OPEN;
                    WHILE SalesJournalData.READ DO BEGIN
                        recSalInvHdr[13].RESET;
                        recSalInvHdr[13].SETRANGE("No.", SalesJournalData.InvoiceNo);
                        IF recSalInvHdr[13].FIND('-') THEN
                            IF (STRPOS(custNo[13], recSalInvHdr[13]."Sell-to Customer No.") = 0) THEN
                                IF custNo[13] = '' THEN
                                    custNo[13] := recSalInvHdr[13]."Sell-to Customer No."
                                ELSE
                                    custNo[13] := custNo[13] + '|' + recSalInvHdr[13]."Sell-to Customer No.";

                        CustRec.RESET();
                        CustRec.SETFILTER("No.", custNo[13]);
                        IF CustRec.FINDFIRST THEN
                            intMTDCustCnt[13] := CustRec.COUNT;
                    END;
                    CLEAR(SalesJournalData);
                    SalesJournalData.SETFILTER(SalesJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                    SalesJournalData.SETFILTER(SalesJournalData.Quantity_in_Sq_Mt, '>%1', 20);
                    IF (dtFrom <> 0D) AND (dtTo <> 0D) THEN
                        SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', dtFrom, dtTo)
                    ELSE
                        SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', CALCDATE('-CM', AsonDate - 1), AsonDate - 1);
                    SalesJournalData.SETFILTER(SalesJournalData.CustomerType, '<>%1', 'CKA');
                    SalesJournalData.OPEN;
                    WHILE SalesJournalData.READ DO BEGIN
                        IF (SalesJournalData.Size_Code_Desc_Filter = '300X450') AND (SalesJournalData.TabProdGrp = 'Ceramic') THEN BEGIN
                            recSalInvHdr[1].RESET;
                            recSalInvHdr[1].SETRANGE("No.", SalesJournalData.InvoiceNo);
                            IF recSalInvHdr[1].FIND('-') THEN
                                IF (STRPOS(custNo[1], recSalInvHdr[1]."Sell-to Customer No.") = 0) THEN
                                    IF custNo[1] = '' THEN
                                        custNo[1] := recSalInvHdr[1]."Sell-to Customer No."
                                    ELSE
                                        custNo[1] := custNo[1] + '|' + recSalInvHdr[1]."Sell-to Customer No.";

                            CustRec.RESET();
                            CustRec.SETFILTER("No.", custNo[1]);
                            IF CustRec.FINDFIRST THEN
                                intMTDCustCnt[1] := CustRec.COUNT;

                        END ELSE
                            IF (SalesJournalData.Size_Code_Desc_Filter = '300X600') AND (SalesJournalData.TabProdGrp = 'Ceramic') THEN BEGIN
                                recSalInvHdr[2].RESET;
                                recSalInvHdr[2].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                IF recSalInvHdr[2].FIND('-') THEN
                                    IF (STRPOS(custNo[2], recSalInvHdr[2]."Sell-to Customer No.") = 0) THEN
                                        IF custNo[2] = '' THEN
                                            custNo[2] := recSalInvHdr[2]."Sell-to Customer No."
                                        ELSE
                                            custNo[2] := custNo[2] + '|' + recSalInvHdr[2]."Sell-to Customer No.";
                                CustRec.RESET();
                                CustRec.SETFILTER("No.", custNo[2]);
                                IF CustRec.FINDFIRST THEN
                                    intMTDCustCnt[2] := CustRec.COUNT;
                            END ELSE
                                IF (SalesJournalData.Size_Code_Desc_Filter = '600X600') AND (SalesJournalData.TabProdGrp = 'Ceramic') THEN BEGIN
                                    recSalInvHdr[3].RESET;
                                    recSalInvHdr[3].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                    IF recSalInvHdr[3].FIND('-') THEN
                                        IF (STRPOS(custNo[3], recSalInvHdr[3]."Sell-to Customer No.") = 0) THEN
                                            IF custNo[3] = '' THEN
                                                custNo[3] := recSalInvHdr[3]."Sell-to Customer No."
                                            ELSE
                                                custNo[3] := custNo[3] + '|' + recSalInvHdr[3]."Sell-to Customer No.";
                                    CustRec.RESET();
                                    CustRec.SETFILTER("No.", custNo[3]);
                                    IF CustRec.FINDFIRST THEN
                                        intMTDCustCnt[3] := CustRec.COUNT;
                                END ELSE
                                    IF (SalesJournalData.Size_Code_Desc_Filter = '600X600') AND (SalesJournalData.TabProdGrp = 'DC') THEN BEGIN
                                        recSalInvHdr[4].RESET;
                                        recSalInvHdr[4].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                        IF recSalInvHdr[4].FIND('-') THEN
                                            IF (STRPOS(custNo[4], recSalInvHdr[4]."Sell-to Customer No.") = 0) THEN
                                                IF custNo[4] = '' THEN
                                                    custNo[4] := recSalInvHdr[4]."Sell-to Customer No."
                                                ELSE
                                                    custNo[4] := custNo[4] + '|' + recSalInvHdr[4]."Sell-to Customer No.";
                                        CustRec.RESET();
                                        CustRec.SETFILTER("No.", custNo[4]);
                                        IF CustRec.FINDFIRST THEN
                                            intMTDCustCnt[4] := CustRec.COUNT;
                                    END ELSE
                                        IF (SalesJournalData.Size_Code_Desc_Filter = '600X1200') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                            recSalInvHdr[5].RESET;
                                            recSalInvHdr[5].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                            IF recSalInvHdr[5].FIND('-') THEN
                                                IF (STRPOS(custNo[5], recSalInvHdr[5]."Sell-to Customer No.") = 0) THEN
                                                    IF custNo[5] = '' THEN
                                                        custNo[5] := recSalInvHdr[5]."Sell-to Customer No."
                                                    ELSE
                                                        custNo[5] := custNo[5] + '|' + recSalInvHdr[5]."Sell-to Customer No.";
                                            CustRec.RESET();
                                            CustRec.SETFILTER("No.", custNo[5]);
                                            IF CustRec.FINDFIRST THEN
                                                intMTDCustCnt[5] := CustRec.COUNT;
                                        END ELSE
                                            IF (SalesJournalData.Size_Code_Desc_Filter = '600X600') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                                recSalInvHdr[6].RESET;
                                                recSalInvHdr[6].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                                IF recSalInvHdr[6].FIND('-') THEN
                                                    IF (STRPOS(custNo[6], recSalInvHdr[6]."Sell-to Customer No.") = 0) THEN
                                                        IF custNo[6] = '' THEN
                                                            custNo[6] := recSalInvHdr[6]."Sell-to Customer No."
                                                        ELSE
                                                            custNo[6] := custNo[6] + '|' + recSalInvHdr[6]."Sell-to Customer No.";
                                                CustRec.RESET();
                                                CustRec.SETFILTER("No.", custNo[6]);
                                                IF CustRec.FINDFIRST THEN
                                                    intMTDCustCnt[6] := CustRec.COUNT;
                                            END ELSE
                                                IF (SalesJournalData.Item_npd = 'Valencica') THEN BEGIN
                                                    recSalInvHdr[7].RESET;
                                                    recSalInvHdr[7].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                                    IF recSalInvHdr[7].FIND('-') THEN
                                                        IF (STRPOS(custNo[7], recSalInvHdr[7]."Sell-to Customer No.") = 0) THEN
                                                            IF custNo[7] = '' THEN
                                                                custNo[7] := recSalInvHdr[7]."Sell-to Customer No."
                                                            ELSE
                                                                custNo[7] := custNo[7] + '|' + recSalInvHdr[7]."Sell-to Customer No.";
                                                    CustRec.RESET();
                                                    CustRec.SETFILTER("No.", custNo[7]);
                                                    IF CustRec.FINDFIRST THEN
                                                        intMTDCustCnt[7] := CustRec.COUNT;
                                                END ELSE
                                                    IF (SalesJournalData.Item_npd = 'Duazzle') THEN BEGIN
                                                        recSalInvHdr[8].RESET;
                                                        recSalInvHdr[8].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                                        IF recSalInvHdr[8].FIND('-') THEN
                                                            IF (STRPOS(custNo[8], recSalInvHdr[8]."Sell-to Customer No.") = 0) THEN
                                                                IF custNo[8] = '' THEN
                                                                    custNo[8] := recSalInvHdr[8]."Sell-to Customer No."
                                                                ELSE
                                                                    custNo[8] := custNo[8] + '|' + recSalInvHdr[8]."Sell-to Customer No.";
                                                        CustRec.RESET();
                                                        CustRec.SETFILTER("No.", custNo[8]);
                                                        IF CustRec.FINDFIRST THEN
                                                            intMTDCustCnt[8] := CustRec.COUNT;
                                                    END ELSE
                                                        IF (SalesJournalData.Item_npd = 'Hsk Rhino Paver') THEN BEGIN
                                                            recSalInvHdr[9].RESET;
                                                            recSalInvHdr[9].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                                            IF recSalInvHdr[9].FIND('-') THEN
                                                                IF (STRPOS(custNo[9], recSalInvHdr[9]."Sell-to Customer No.") = 0) THEN
                                                                    IF custNo[9] = '' THEN
                                                                        custNo[9] := recSalInvHdr[9]."Sell-to Customer No."
                                                                    ELSE
                                                                        custNo[9] := custNo[9] + '|' + recSalInvHdr[9]."Sell-to Customer No.";
                                                            CustRec.RESET();
                                                            CustRec.SETFILTER("No.", custNo[9]);
                                                            IF CustRec.FINDFIRST THEN
                                                                intMTDCustCnt[9] := CustRec.COUNT;
                                                        END ELSE
                                                            IF (SalesJournalData.Item_npd = 'Timeless') THEN BEGIN
                                                                recSalInvHdr[10].RESET;
                                                                recSalInvHdr[10].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                                                IF recSalInvHdr[10].FIND('-') THEN
                                                                    IF (STRPOS(custNo[10], recSalInvHdr[10]."Sell-to Customer No.") = 0) THEN
                                                                        IF custNo[10] = '' THEN
                                                                            custNo[10] := recSalInvHdr[10]."Sell-to Customer No."
                                                                        ELSE
                                                                            custNo[10] := custNo[10] + '|' + recSalInvHdr[10]."Sell-to Customer No.";
                                                                CustRec.RESET();
                                                                CustRec.SETFILTER("No.", custNo[10]);
                                                                IF CustRec.FINDFIRST THEN
                                                                    intMTDCustCnt[10] := CustRec.COUNT;
                                                            END ELSE
                                                                IF (SalesJournalData.TabProdGrp = 'FBVT') THEN BEGIN
                                                                    recSalInvHdr[11].RESET;
                                                                    recSalInvHdr[11].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                                                    IF recSalInvHdr[11].FIND('-') THEN
                                                                        IF (STRPOS(custNo[11], recSalInvHdr[11]."Sell-to Customer No.") = 0) THEN
                                                                            IF custNo[11] = '' THEN
                                                                                custNo[11] := recSalInvHdr[11]."Sell-to Customer No."
                                                                            ELSE
                                                                                custNo[11] := custNo[11] + '|' + recSalInvHdr[11]."Sell-to Customer No.";
                                                                    CustRec.RESET();
                                                                    CustRec.SETFILTER("No.", custNo[11]);
                                                                    IF CustRec.FINDFIRST THEN
                                                                        intMTDCustCnt[11] := CustRec.COUNT;
                                                                END ELSE
                                                                    IF (SalesJournalData.TabProdGrp = 'PVT') THEN BEGIN
                                                                        recSalInvHdr[12].RESET;
                                                                        recSalInvHdr[12].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                                                        IF recSalInvHdr[12].FIND('-') THEN
                                                                            IF (STRPOS(custNo[12], recSalInvHdr[12]."Sell-to Customer No.") = 0) THEN
                                                                                IF custNo[12] = '' THEN
                                                                                    custNo[12] := recSalInvHdr[12]."Sell-to Customer No."
                                                                                ELSE
                                                                                    custNo[12] := custNo[12] + '|' + recSalInvHdr[12]."Sell-to Customer No.";
                                                                        CustRec.RESET();
                                                                        CustRec.SETFILTER("No.", custNo[12]);
                                                                        IF CustRec.FINDFIRST THEN
                                                                            intMTDCustCnt[12] := CustRec.COUNT;
                                                                    END ELSE BEGIN
                                                                        recSalInvHdr[14].RESET;
                                                                        recSalInvHdr[14].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                                                        IF recSalInvHdr[14].FIND('-') THEN
                                                                            IF (STRPOS(custNo[14], recSalInvHdr[14]."Sell-to Customer No.") = 0) THEN
                                                                                IF custNo[14] = '' THEN
                                                                                    custNo[14] := recSalInvHdr[14]."Sell-to Customer No."
                                                                                ELSE
                                                                                    custNo[14] := custNo[14] + '|' + recSalInvHdr[14]."Sell-to Customer No.";
                                                                        CustRec.RESET();
                                                                        CustRec.SETFILTER("No.", custNo[14]);
                                                                        IF CustRec.FINDFIRST THEN
                                                                            intMTDCustCnt[14] := CustRec.COUNT;
                                                                    END;
                    END;
                END;
                //Keshav23092020<<
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Quantitative; QuantitativeReport)
                {
                    ApplicationArea = All;
                }
                field("From Date"; dtFrom)
                {
                    ApplicationArea = All;
                }
                field("To Date"; dtTo)
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
        // AsonDate := TODAY;
        AsonDate := 20200822D;
        QuantitativeReport := TRUE;
    end;

    trigger OnPreReport()
    begin
        CLEAR(decOpnOrderOtstnd);
        CLEAR(decMTDDesp);
        CLEAR(decFTDDesp);

        CLEAR(intLMTDCustCnt);
        CLEAR(intMTDCustCnt);
        CLEAR(intYTDCustCnt);
        CLEAR(tempSalesInvHdr);

        CLEAR(decLMTDDesp);
    end;

    var
        SalesOrdersDetails: Query "Sales Orders Details";
        SalesInvoicedDetails: Query "Sales Invoiced Details";
        SalesReturnJournalData: Query "Sales Return Journal Data";
        PCHCode: Code[20];
        OpenOrdersQty: Decimal;
        ReleaseOrdersQty: Decimal;
        OpenOrdersAmt: Decimal;
        ReleaseOrdersAmt: Decimal;
        OrderBookedAmt: array[4] of Decimal;
        OrderBookedQty: array[4] of Decimal;
        AsonDate: Date;
        OrderReleasedAmt: array[4] of Decimal;
        OrderReleasedQty: array[4] of Decimal;
        Target: Decimal;
        MTD: Decimal;
        InvBookedQty: array[4] of Decimal;
        InvBookedAmt: array[4] of Decimal;
        InvOrderQty: array[4] of Decimal;
        InvOrderAmt: array[4] of Decimal;
        MTDQty: Decimal;
        QuantitativeReport: Boolean;
        FTDQty: Decimal;
        FTD: Decimal;
        NintyDaySales: Decimal;
        OutStandingAmt: Decimal;
        Sales: Decimal;
        DSO: Decimal;
        recItem: Record Item;
        decOpnOrderOtstnd: array[8] of Decimal;
        decMTDDesp: array[8] of Decimal;
        decFTDDesp: array[8] of Decimal;
        SalesJournalData: Query "Sales Journal Data";
        tempMatrixMaster: Record "Matrix Master" temporary;
        decMTDRet: array[8] of Decimal;
        decFTDRet: array[8] of Decimal;
        intMTDCustCnt: array[15] of Integer;
        intYTDCustCnt: array[8] of Integer;
        intLMTDCustCnt: array[8] of Integer;
        tempSalesInvHdr: array[8] of Record "Sales Invoice Header" temporary;
        recSalInvHdr: array[15] of Record "Sales Invoice Header";
        intMinus: Integer;
        intTest: Integer;
        tmSalInv: Record "Sales Invoice Header";
        recSalCrMemoHdr: array[8] of Record "Sales Cr.Memo Header";
        tempSalesCrMemoHdr: array[8] of Record "Sales Cr.Memo Header" temporary;
        custNo: array[15] of Text;
        CustRec: Record Customer;
        CustNoYTD: array[8] of Text;
        CustNoLMTD: array[8] of Text;
        decLMTDDesp: array[8] of Decimal;
        blnMTD: Boolean;
        dtFrom: Date;
        dtTo: Date;
}

