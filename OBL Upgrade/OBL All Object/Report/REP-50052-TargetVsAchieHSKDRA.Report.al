report 50052 "Target Vs Achie HSK DRA"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\TargetVsAchieHSKDRA.rdl';
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
            column(Target; Target)
            {
            }
            column(MTD; MTD / 100000)
            {
            }
            column(MTDQty; MTDQty)
            {
            }
            column(OpenOrdersQty; OpenOrdersQty)
            {
            }
            column(ReleaseOrdersQty; ReleaseOrdersQty)
            {
            }
            column(OpenOrdersAmt; OpenOrdersAmt / 100000)
            {
            }
            column(ReleaseOrdersAmty; ReleaseOrdersAmt / 100000)
            {
            }
            column(OrderBookedAmt1; (OrderBookedAmt[1] + InvBookedAmt[1]) / 100000)
            {
            }
            column(OrderBookedAmt2; (OrderBookedAmt[2] + InvBookedAmt[2]) / 100000)
            {
            }
            column(OrderBookedAmt3; (OrderBookedAmt[3] + InvBookedAmt[3]) / 100000)
            {
            }
            column(OrderReleasedAmt1; (OrderReleasedAmt[1] + InvOrderAmt[1]) / 100000)
            {
            }
            column(OrderReleasedAmt2; (OrderReleasedAmt[2] + InvOrderAmt[2]) / 100000)
            {
            }
            column(OrderReleasedAmt3; (OrderReleasedAmt[3] + InvOrderAmt[3]) / 100000)
            {
            }
            column(InvBookedAmt1; InvBookedAmt[1])
            {
            }
            column(InvBookedAmt2; InvBookedAmt[2])
            {
            }
            column(InvBookedAmt3; InvBookedAmt[3])
            {
            }
            column(OrderBookedQty1; OrderBookedQty[1] + InvBookedQty[1])
            {
            }
            column(OrderBookedQty2; OrderBookedQty[2] + InvBookedQty[2])
            {
            }
            column(OrderBookedQty3; OrderBookedQty[3] + InvBookedQty[3])
            {
            }
            column(OrderReleasedQty1; OrderReleasedQty[1] + InvOrderQty[1])
            {
            }
            column(OrderReleasedQty2; OrderBookedQty[2] + InvOrderQty[2])
            {
            }
            column(OrderReleasedQty3; OrderBookedQty[3] + InvOrderQty[3])
            {
            }
            column(Outstanding; "Matrix Master"."Outstanding Amount" / 100000)
            {
            }
            column(OverDue; "Matrix Master"."OverDue Amount" / 100000)
            {
            }
            column(Collection; ABS("Matrix Master"."Collection Amount" / 100000))
            {
            }
            column(FTD; FTD / 100000)
            {
            }
            column(FTDQty; FTDQty)
            {
            }
            column(DSO; DSO)
            {
            }
            column(Sales; Sales)
            {
            }
            column(OutStandingAmt; OutStandingAmt)
            {
            }
            column(decOpnOrderOtstnd1; decOpnOrderOtstnd[1])
            {
            }
            column(decOpnOrderOtstnd2; decOpnOrderOtstnd[2])
            {
            }
            column(decOpnOrderOtstnd3; decOpnOrderOtstnd[3])
            {
            }
            column(decOpnOrderOtstnd4; decOpnOrderOtstnd[4])
            {
            }
            column(decOpnOrderOtstnd5; decOpnOrderOtstnd[5])
            {
            }
            column(decOpnOrderOtstnd6; decOpnOrderOtstnd[6])
            {
            }
            column(decOpnOrderOtstnd7; decOpnOrderOtstnd[7])
            {
            }
            column(decOpnOrderOtstnd8; decOpnOrderOtstnd[8])
            {
            }
            column(decOpnOrderOtstnd9; decOpnOrderOtstnd[9])
            {
            }
            column(decOpnOrderOtstnd10; decOpnOrderOtstnd[10])
            {
            }
            column(decOpnOrderOtstnd11; decOpnOrderOtstnd[11])
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
            column(decFTDDesp1; decFTDDesp[1])
            {
            }
            column(decFTDDesp2; decFTDDesp[2])
            {
            }
            column(decFTDDesp3; decFTDDesp[3])
            {
            }
            column(decFTDDesp4; decFTDDesp[4])
            {
            }
            column(decFTDDesp5; decFTDDesp[5])
            {
            }
            column(decFTDDesp6; decFTDDesp[6])
            {
            }
            column(decFTDDesp7; decFTDDesp[7])
            {
            }
            column(decFTDDesp8; decFTDDesp[8])
            {
            }
            column(decFTDDesp9; decFTDDesp[9])
            {
            }
            column(decFTDDesp10; decFTDDesp[10])
            {
            }
            column(decFTDDesp11; decFTDDesp[11])
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
            column(decMTDret1; decMTDRet[1])
            {
            }
            column(decMTDret2; decMTDRet[2])
            {
            }
            column(decMTDret3; decMTDRet[3])
            {
            }
            column(decMTDret4; decMTDRet[4])
            {
            }
            column(decMTDret5; decMTDRet[5])
            {
            }
            column(decMTDret6; decMTDRet[6])
            {
            }
            column(decMTDret7; decMTDRet[7])
            {
            }
            column(decMTDret8; decMTDRet[8])
            {
            }
            column(decMTDret9; decMTDRet[9])
            {
            }
            column(decMTDret10; decMTDRet[10])
            {
            }
            column(decMTDret11; decMTDRet[11])
            {

            }
            column(decFTDret1; decFTDRet[1])
            {
            }
            column(decFTDret2; decFTDRet[2])
            {
            }
            column(decFTDret3; decFTDRet[3])
            {
            }
            column(decFTDret4; decFTDRet[4])
            {
            }
            column(decFTDret5; decFTDRet[5])
            {
            }
            column(decFTDret6; decFTDRet[6])
            {
            }
            column(decFTDret7; decFTDRet[7])
            {
            }
            column(decFTDret8; decFTDRet[8])
            {
            }
            column(decFTDret9; decFTDRet[9])
            {
            }
            column(decFTDret10; decFTDRet[10])
            {
            }
            column(decFTDret11; decFTDRet[11])
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
            column(intLMTDCustCnt1; intLMTDCustCnt[1])
            {
            }
            column(intLMTDCustCnt2; intLMTDCustCnt[2])
            {
            }
            column(intLMTDCustCnt3; intLMTDCustCnt[3])
            {
            }
            column(intLMTDCustCnt4; intLMTDCustCnt[4])
            {
            }
            column(intLMTDCustCnt5; intLMTDCustCnt[5])
            {
            }
            column(intLMTDCustCnt6; intLMTDCustCnt[6])
            {
            }
            column(intLMTDCustCnt7; intLMTDCustCnt[7])
            {
            }
            column(intLMTDCustCnt8; intLMTDCustCnt[8])
            {
            }
            column(intLMTDCustCnt9; intLMTDCustCnt[9])
            {
            }
            column(intLMTDCustCnt10; intLMTDCustCnt[10])
            {
            }
            column(intLMTDCustCnt11; intLMTDCustCnt[11])
            {

            }
            column(decLMTDDesp1; decLMTDDesp[1])
            {
            }
            column(decLMTDret1; decLMTDRet[1])
            {
            }
            column(decLMTDDesp2; decLMTDDesp[2])
            {
            }
            column(decLMTDret2; decLMTDRet[2])
            {
            }
            column(decLMTDDesp3; decLMTDDesp[3])
            {
            }
            column(decLMTDret3; decLMTDRet[3])
            {
            }
            column(decLMTDDesp4; decLMTDDesp[4])
            {
            }
            column(decLMTDret4; decLMTDRet[4])
            {
            }
            column(decLMTDret5; decLMTDRet[5])
            {
            }
            column(decLMTDDesp5; decLMTDDesp[5])
            {
            }
            column(decLMTDDesp6; decLMTDDesp[6])
            {
            }
            column(decLMTDDesp7; decLMTDDesp[7])
            {
            }
            column(decLMTDDesp8; decLMTDDesp[8])
            {
            }
            column(decLMTDDesp9; decLMTDDesp[9])
            {
            }
            column(decLMTDret9; decLMTDRet[9])
            {
            }
            column(decLMTDDesp10; decLMTDDesp[10])
            {
            }
            column(decLMTDDesp11; decLMTDDesp[11])
            {

            }
            column(decLMTDret10; decLMTDRet[10])
            {
            }
            column(decLMTDret11; decLMTDRet[11])
            {

            }
            column(intMTDItemCnt1; intMTDItemCnt[1])
            {
            }
            column(intMTDItemCnt2; intMTDItemCnt[2])
            {
            }
            column(intMTDItemCnt3; intMTDItemCnt[3])
            {
            }
            column(intMTDItemCnt4; intMTDItemCnt[4])
            {
            }
            column(intMTDItemCnt5; intMTDItemCnt[5])
            {
            }
            column(intMTDItemCnt9; intMTDItemCnt[9])
            {
            }
            column(intMTDItemCnt10; intMTDItemCnt[10])
            {
            }
            column(intMTDItemCnt11; intMTDItemCnt[11])
            {

            }
            column(intLMTDItemCnt1; intLMTDItemCnt[1])
            {
            }
            column(intLMTDItemCnt2; intLMTDItemCnt[2])
            {
            }
            column(intLMTDItemCnt3; intLMTDItemCnt[3])
            {
            }
            column(intLMTDItemCnt4; intLMTDItemCnt[4])
            {
            }
            column(intLMTDItemCnt5; intLMTDItemCnt[5])
            {
            }
            column(intLMTDItemCnt9; intLMTDItemCnt[9])
            {
            }
            column(intLMTDItemCnt10; intLMTDItemCnt[10])
            {
            }
            column(intLMTDItemCnt11; intLMTDItemCnt[11])
            {

            }
            column(intYTDItemCnt1; intYTDItemCnt[1])
            {
            }
            column(intYTDItemCnt2; intYTDItemCnt[2])
            {
            }
            column(intYTDItemCnt3; intYTDItemCnt[3])
            {
            }
            column(intYTDItemCnt4; intYTDItemCnt[4])
            {
            }
            column(intYTDItemCnt5; intYTDItemCnt[5])
            {
            }
            column(intYTDItemCnt9; intYTDItemCnt[9])
            {
            }
            column(intYTDItemCnt10; intYTDItemCnt[10])
            {
            }
            column(intYTDItemCnt11; intYTDItemCnt[11])
            {

            }

            trigger OnAfterGetRecord()
            var
                OrderReleaseDate: Date;
                InvReleaseDate: Date;
                Customer: Record Customer;
            begin
                intCnt := 1;
                // InitialisedVariables;
                //Keshav22072020
                CLEAR(decOpnOrderOtstnd);
                CLEAR(decMTDDesp);
                CLEAR(decMTDRet);
                CLEAR(decFTDRet);
                CLEAR(decFTDDesp);


                //Hoskote Report
                IF (QuantitativeReport) THEN BEGIN
                    IF ("Matrix Master"."Type 1" <> 'CKA') THEN BEGIN

                        CLEAR(SalesOrdersDetails);
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.AreaFilter, '%1', "Matrix Master"."Type 1");
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Document_Type, '%1', DocTypeEnum::Order);
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.StatusFilter, '%1', StatusEnum::Released);
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Item_Category_Code, '%1', 'H001');
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Customer_Type, '<>%1&<>%2&<>%3', 'GET', 'PET', 'SET');
                        // SalesOrdersDetails.SETRANGE(salesordersdetails.Tableau_Product_Group,'GVT');
                        SalesOrdersDetails.OPEN;
                        WHILE SalesOrdersDetails.READ DO BEGIN
                            IF (SalesOrdersDetails.Size_Code_Desc = '250X375') THEN BEGIN
                                decOpnOrderOtstnd[1] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END;
                            IF SalesOrdersDetails.NPD = 'Rhino Paver' THEN BEGIN
                                decOpnOrderOtstnd[2] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END;
                            IF SalesOrdersDetails.NPD = 'Ascend Step Paver' THEN BEGIN
                                decOpnOrderOtstnd[9] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END;
                            IF (SalesOrdersDetails.Size_Code_Desc = '600X600') THEN BEGIN
                                decOpnOrderOtstnd[10] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END;
                            IF (SalesOrdersDetails.Size_Code_Desc = '600X1200') THEN BEGIN
                                decOpnOrderOtstnd[11] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END;//16767
                        END;

                        CLEAR(SalesJournalData);
                        SalesJournalData.SETFILTER(SalesJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                        SalesJournalData.SETFILTER(SalesJournalData.Item_Category_Code_Filter, '%1', 'H001');
                        SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', CALCDATE('-CM', AsonDate - 1), AsonDate - 1);
                        SalesJournalData.SETFILTER(SalesJournalData.CustomerType, '<>%1&<>%2&<>%3', 'GET', 'PET', 'SET');
                        SalesJournalData.OPEN;
                        WHILE SalesJournalData.READ DO BEGIN
                            IF (SalesJournalData.Size_Code_Desc_Filter = '250X375') THEN BEGIN
                                decMTDDesp[1] += SalesJournalData.Quantity_in_Sq_Mt;

                                //Keshav01092020
                                recSalInvHdr[1].RESET;
                                recSalInvHdr[1].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                IF recSalInvHdr[1].FIND('-') THEN
                                    IF (STRPOS(custNo[1], recSalInvHdr[1]."Sell-to Customer No.") = 0) THEN
                                        IF custNo[1] = '' THEN
                                            custNo[1] := recSalInvHdr[1]."Sell-to Customer No."
                                        ELSE
                                            custNo[1] := custNo[1] + '|' + recSalInvHdr[1]."Sell-to Customer No.";

                                // custNo:=DELCHR(custNo,'>','|');
                                CustRec.RESET();
                                CustRec.SETFILTER("No.", custNo[1]);
                                IF CustRec.FINDFIRST THEN
                                    intMTDCustCnt[1] := CustRec.COUNT;

                                //Item Count>>
                                recSalesInvLn[1].RESET;
                                recSalesInvLn[1].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                                recSalesInvLn[1].SetFilter(Quantity, '<>%1', 0); //16767
                                recSalesInvLn[1].SETRANGE(Type, recSalesInvLn[1].Type::Item);
                                IF recSalesInvLn[1].FIND('-') THEN
                                    REPEAT
                                        IF (STRPOS(itemno[1], recSalesInvLn[1]."No.") = 0) THEN BEGIN
                                            IF itemno[1] = '' THEN
                                                itemno[1] := recSalesInvLn[1]."No."
                                            ELSE
                                                itemno[1] := itemno[1] + '|' + recSalesInvLn[1]."No.";
                                        END;
                                    UNTIL recSalesInvLn[1].NEXT = 0;
                                ritem.RESET();
                                ritem.SETFILTER("No.", itemno[1]);
                                ritem.SETRANGE("Size Code Desc.", '250X375');
                                ritem.SETRANGE("Item Category Code", 'H001');
                                ritem.SETRANGE("Quality Code", '1');
                                intMTDItemCnt[1] := ritem.COUNT;

                            END;
                            IF SalesJournalData.Item_npd = 'Rhino Paver' THEN BEGIN
                                decMTDDesp[2] += SalesJournalData.Quantity_in_Sq_Mt;

                                //Keshav01092020
                                recSalInvHdr[2].RESET;
                                recSalInvHdr[2].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                IF recSalInvHdr[2].FIND('-') THEN
                                    IF (STRPOS(custNo[2], recSalInvHdr[2]."Sell-to Customer No.") = 0) THEN
                                        IF custNo[2] = '' THEN
                                            custNo[2] := recSalInvHdr[2]."Sell-to Customer No."
                                        ELSE
                                            custNo[2] := custNo[2] + '|' + recSalInvHdr[2]."Sell-to Customer No.";

                                // custNo:=DELCHR(custNo,'>','|');
                                CustRec.RESET();
                                CustRec.SETFILTER("No.", custNo[2]);
                                IF CustRec.FINDFIRST THEN
                                    intMTDCustCnt[2] := CustRec.COUNT;
                                //Keshav01092020

                                //Item Count>>
                                recSalesInvLn[2].RESET;
                                recSalesInvLn[2].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                                recSalesInvLn[2].SetFilter(Quantity, '<>%1', 0);
                                IF recSalesInvLn[2].FIND('-') THEN
                                    REPEAT
                                        IF (STRPOS(itemno[2], recSalesInvLn[2]."No.") = 0) THEN
                                            IF itemno[2] = '' THEN
                                                itemno[2] := recSalesInvLn[2]."No."
                                            ELSE
                                                itemno[2] := itemno[2] + '|' + recSalesInvLn[2]."No.";
                                    UNTIL recSalesInvLn[2].NEXT = 0;

                                ritem.RESET();
                                ritem.SETFILTER("No.", itemno[2]);
                                ritem.SETRANGE(NPD, 'Rhino Paver');
                                ritem.SETRANGE("Item Category Code", 'H001');
                                ritem.SETRANGE("Quality Code", '1');
                                intMTDItemCnt[2] := ritem.COUNT;
                                //Item Count<<
                            END;
                            IF SalesJournalData.Item_npd = 'Ascend Step Paver' THEN BEGIN
                                decMTDDesp[9] += SalesJournalData.Quantity_in_Sq_Mt;

                                //Keshav01092020
                                recSalInvHdr[9].RESET;
                                recSalInvHdr[9].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                IF recSalInvHdr[9].FIND('-') THEN
                                    IF (STRPOS(custNo[9], recSalInvHdr[9]."Sell-to Customer No.") = 0) THEN
                                        IF custNo[9] = '' THEN
                                            custNo[9] := recSalInvHdr[9]."Sell-to Customer No."
                                        ELSE
                                            custNo[9] := custNo[9] + '|' + recSalInvHdr[9]."Sell-to Customer No.";

                                // custNo:=DELCHR(custNo,'>','|');
                                CustRec.RESET();
                                CustRec.SETFILTER("No.", custNo[9]);
                                IF CustRec.FINDFIRST THEN
                                    intMTDCustCnt[9] := CustRec.COUNT;
                                //Keshav01092020

                                //Item Count>>
                                recSalesInvLn[9].RESET;
                                recSalesInvLn[9].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                                recSalesInvLn[9].SetFilter(Quantity, '<>%1', 0);
                                IF recSalesInvLn[9].FIND('-') THEN
                                    REPEAT
                                        IF (STRPOS(itemno[9], recSalesInvLn[9]."No.") = 0) THEN
                                            IF itemno[9] = '' THEN
                                                itemno[9] := recSalesInvLn[9]."No."
                                            ELSE
                                                itemno[9] := itemno[9] + '|' + recSalesInvLn[9]."No.";
                                    UNTIL recSalesInvLn[9].NEXT = 0;

                                ritem.RESET();
                                ritem.SETFILTER("No.", itemno[9]);
                                ritem.SETRANGE(NPD, 'Ascend Step Paver');
                                ritem.SETRANGE("Item Category Code", 'H001');
                                ritem.SETRANGE("Quality Code", '1');
                                intMTDItemCnt[9] := ritem.COUNT;
                                //Item Count<<
                            END;
                            IF (SalesJournalData.Size_Code_Desc_Filter = '600X600') THEN BEGIN
                                decMTDDesp[10] += SalesJournalData.Quantity_in_Sq_Mt;

                                //Keshav01092020
                                recSalInvHdr[10].RESET;
                                recSalInvHdr[10].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                IF recSalInvHdr[10].FIND('-') THEN
                                    IF (STRPOS(custNo[10], recSalInvHdr[10]."Sell-to Customer No.") = 0) THEN
                                        IF custNo[10] = '' THEN
                                            custNo[10] := recSalInvHdr[10]."Sell-to Customer No."
                                        ELSE
                                            custNo[10] := custNo[10] + '|' + recSalInvHdr[10]."Sell-to Customer No.";

                                // custNo:=DELCHR(custNo,'>','|');
                                CustRec.RESET();
                                CustRec.SETFILTER("No.", custNo[10]);
                                IF CustRec.FINDFIRST THEN
                                    intMTDCustCnt[10] := CustRec.COUNT;

                                //Item Count>>
                                recSalesInvLn[10].RESET;
                                recSalesInvLn[10].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                                recSalesInvLn[10].SETFILTER(Quantity, '<>%1', 0);
                                recSalesInvLn[10].SETRANGE(Type, recSalesInvLn[10].Type::Item);
                                IF recSalesInvLn[10].FIND('-') THEN
                                    REPEAT
                                        IF (STRPOS(itemno[10], recSalesInvLn[10]."No.") = 0) THEN BEGIN
                                            IF itemno[10] = '' THEN
                                                itemno[10] := recSalesInvLn[10]."No."
                                            ELSE
                                                itemno[10] := itemno[10] + '|' + recSalesInvLn[10]."No.";
                                        END;
                                    UNTIL recSalesInvLn[10].NEXT = 0;
                                ritem.RESET();
                                ritem.SETFILTER("No.", itemno[10]);
                                ritem.SETRANGE("Size Code Desc.", '600X600');
                                ritem.SETRANGE("Item Category Code", 'H001');
                                ritem.SETRANGE("Quality Code", '1');
                                intMTDItemCnt[10] := ritem.COUNT;
                            END;
                            IF (SalesJournalData.Size_Code_Desc_Filter = '600X1200') THEN BEGIN
                                decMTDDesp[11] += SalesJournalData.Quantity_in_Sq_Mt;

                                //Keshav01092020
                                recSalInvHdr[11].RESET;
                                recSalInvHdr[11].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                IF recSalInvHdr[11].FIND('-') THEN
                                    IF (STRPOS(custNo[11], recSalInvHdr[11]."Sell-to Customer No.") = 0) THEN
                                        IF custNo[11] = '' THEN
                                            custNo[11] := recSalInvHdr[11]."Sell-to Customer No."
                                        ELSE
                                            custNo[11] := custNo[11] + '|' + recSalInvHdr[11]."Sell-to Customer No.";

                                // custNo:=DELCHR(custNo,'>','|');
                                CustRec.RESET();
                                CustRec.SETFILTER("No.", custNo[11]);
                                IF CustRec.FINDFIRST THEN
                                    intMTDCustCnt[11] := CustRec.COUNT;

                                //Item Count>>
                                recSalesInvLn[11].RESET;
                                recSalesInvLn[11].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                                recSalesInvLn[11].SETFILTER(Quantity, '<>%1', 0);
                                recSalesInvLn[11].SETRANGE(Type, recSalesInvLn[11].Type::Item);
                                IF recSalesInvLn[11].FIND('-') THEN
                                    REPEAT
                                        IF (STRPOS(itemno[11], recSalesInvLn[11]."No.") = 0) THEN BEGIN
                                            IF itemno[11] = '' THEN
                                                itemno[11] := recSalesInvLn[11]."No."
                                            ELSE
                                                itemno[11] := itemno[11] + '|' + recSalesInvLn[11]."No.";
                                        END;
                                    UNTIL recSalesInvLn[11].NEXT = 0;
                                ritem.RESET();
                                ritem.SETFILTER("No.", itemno[11]);
                                ritem.SETRANGE("Size Code Desc.", '600X1200');
                                ritem.SETRANGE("Item Category Code", 'H001');
                                ritem.SETRANGE("Quality Code", '1');
                                intMTDItemCnt[11] := ritem.COUNT;
                            END;

                        END;

                        CLEAR(SalesJournalData);
                        SalesJournalData.SETFILTER(SalesJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                        SalesJournalData.SETFILTER(SalesJournalData.Item_Category_Code_Filter, '%1', 'H001');
                        SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', AsonDate - 1, AsonDate - 1);
                        SalesJournalData.SETFILTER(SalesJournalData.CustomerType, '<>%1&<>%2&<>%3', 'GET', 'PET', 'SET');
                        SalesJournalData.OPEN;
                        WHILE SalesJournalData.READ DO BEGIN
                            IF (SalesJournalData.Size_Code_Desc_Filter = '250X375') THEN BEGIN
                                decFTDDesp[1] += SalesJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF SalesJournalData.Item_npd = 'Rhino Paver' THEN BEGIN
                                decFTDDesp[2] += SalesJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF SalesJournalData.Item_npd = 'Ascend Step Paver' THEN BEGIN
                                decFTDDesp[9] += SalesJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF (SalesJournalData.Size_Code_Desc_Filter = '600X600') THEN BEGIN
                                decFTDDesp[10] += SalesJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF (SalesJournalData.Size_Code_Desc_Filter = '600X1200') THEN BEGIN
                                decFTDDesp[11] += SalesJournalData.Quantity_in_Sq_Mt;
                            END;
                        END;

                        CLEAR(SalesReturnJournalData);
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code_Filter, '%1', 'H001');
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.PostingDateFilter, '%1..%2', CALCDATE('-CM', AsonDate - 1), AsonDate - 1);
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.CustomerType, '<>%1&<>%2&<>%3', 'GET', 'PET', 'SET');
                        SalesReturnJournalData.OPEN;
                        WHILE SalesReturnJournalData.READ DO BEGIN
                            IF (SalesReturnJournalData.Size_Code_Desc = '250X375') THEN BEGIN
                                decMTDRet[1] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF SalesReturnJournalData.NPD = 'Rhino Paver' THEN BEGIN
                                decMTDRet[2] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF SalesReturnJournalData.NPD = 'Ascend Step Paver' THEN BEGIN
                                decMTDRet[9] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF (SalesReturnJournalData.Size_Code_Desc = '600X600') THEN BEGIN
                                decMTDRet[10] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF (SalesReturnJournalData.Size_Code_Desc = '600X1200') THEN BEGIN
                                decMTDRet[11] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                        END;

                        CLEAR(SalesReturnJournalData);
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code_Filter, '%1', 'H001');
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.PostingDateFilter, '%1..%2', AsonDate - 1, AsonDate - 1);
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.CustomerType, '<>%1&<>%2&<>%3', 'GET', 'PET', 'SET');
                        SalesReturnJournalData.OPEN;
                        WHILE SalesReturnJournalData.READ DO BEGIN
                            //16767 IF (SalesReturnJournalData.Size_Code_Desc = '250X350') THEN BEGIN
                            IF (SalesReturnJournalData.Size_Code_Desc = '250X375') THEN BEGIN
                                decFTDRet[1] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF SalesReturnJournalData.NPD = 'Rhino Paver' THEN BEGIN
                                decFTDRet[2] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF SalesReturnJournalData.NPD = 'Ascend Step Paver' THEN BEGIN
                                decFTDRet[9] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF (SalesReturnJournalData.Size_Code_Desc = '600X600') THEN BEGIN
                                decFTDRet[10] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF (SalesReturnJournalData.Size_Code_Desc = '600X1200') THEN BEGIN
                                decFTDRet[11] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                        END;
                    END ELSE BEGIN
                        CLEAR(SalesOrdersDetails);
                        //SalesOrdersDetails.SETFILTER(SalesOrdersDetails.AreaFilter,'%1',"Matrix Master"."Type 1");
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Document_Type, '%1', DocTypeEnum::Order);
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Customer_Type, '%1|%2|%3', 'GET', 'SET', 'PET');
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.StatusFilter, '%1', StatusEnum::Released);
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Item_Category_Code, '%1', 'H001');
                        // SalesOrdersDetails.SETRANGE(salesordersdetails.Tableau_Product_Group,'GVT');
                        SalesOrdersDetails.OPEN;
                        WHILE SalesOrdersDetails.READ DO BEGIN
                            IF (SalesOrdersDetails.Size_Code_Desc = '250X375') THEN BEGIN
                                decOpnOrderOtstnd[1] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END;
                            IF SalesOrdersDetails.NPD = 'Rhino Paver' THEN BEGIN
                                decOpnOrderOtstnd[2] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END;
                            IF SalesOrdersDetails.NPD = 'Ascend Step Paver' THEN BEGIN
                                decOpnOrderOtstnd[9] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END;
                            IF (SalesOrdersDetails.Size_Code_Desc = '600X600') THEN BEGIN
                                decOpnOrderOtstnd[10] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END;
                            IF (SalesOrdersDetails.Size_Code_Desc = '600X1200') THEN BEGIN
                                decOpnOrderOtstnd[11] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END;
                        END;

                        CLEAR(SalesJournalData);
                        SalesJournalData.SETFILTER(SalesJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                        SalesJournalData.SETFILTER(SalesJournalData.Item_Category_Code_Filter, '%1', 'H001');
                        SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', CALCDATE('-CM', AsonDate - 1), AsonDate - 1);
                        SalesJournalData.SETFILTER(SalesJournalData.CustomerType, '%1|%2|%3', 'GET', 'SET', 'PET');
                        SalesJournalData.OPEN;
                        WHILE SalesJournalData.READ DO BEGIN
                            IF (SalesJournalData.Size_Code_Desc_Filter = '250X375') THEN BEGIN
                                decMTDDesp[1] += SalesJournalData.Quantity_in_Sq_Mt;

                                //Keshav01092020
                                recSalInvHdr[1].RESET;
                                recSalInvHdr[1].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                IF recSalInvHdr[1].FIND('-') THEN
                                    IF (STRPOS(custNo[1], recSalInvHdr[1]."Sell-to Customer No.") = 0) THEN
                                        IF custNo[1] = '' THEN
                                            custNo[1] := recSalInvHdr[1]."Sell-to Customer No."
                                        ELSE
                                            custNo[1] := custNo[1] + '|' + recSalInvHdr[1]."Sell-to Customer No.";

                                // custNo:=DELCHR(custNo,'>','|');
                                CustRec.RESET();
                                CustRec.SETFILTER("No.", custNo[1]);
                                IF CustRec.FINDFIRST THEN
                                    intMTDCustCnt[1] := CustRec.COUNT;
                                //Keshav01092020

                                //Item Count>>
                                recSalesInvLn[1].RESET;
                                recSalesInvLn[1].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                                recSalesInvLn[1].SETFILTER(Quantity, '<>%1', 0);
                                recSalesInvLn[1].SETFILTER(recSalesInvLn[1].Type, '%1', recSalesInvLn[1].Type::Item);
                                IF recSalesInvLn[1].FIND('-') THEN
                                    REPEAT
                                        IF (STRPOS(itemno[1], recSalesInvLn[1]."No.") = 0) THEN
                                            IF itemno[1] = '' THEN
                                                itemno[1] := recSalesInvLn[1]."No."
                                            ELSE
                                                itemno[1] := itemno[1] + '|' + recSalesInvLn[1]."No.";
                                    UNTIL recSalesInvLn[1].NEXT = 0;

                                ritem.RESET();
                                ritem.SETFILTER("No.", itemno[1]);
                                ritem.SETRANGE("Item Category Code", 'H001');
                                ritem.SETRANGE("Size Code Desc.", '250X375');
                                ritem.SETRANGE("Quality Code", '1');
                                IF ritem.FINDFIRST THEN
                                    intMTDItemCnt[1] := ritem.COUNT;
                                //Item Count<<

                            END;
                            IF SalesJournalData.Item_npd = 'Rhino Paver' THEN BEGIN
                                decMTDDesp[2] += SalesJournalData.Quantity_in_Sq_Mt;
                                //Keshav01092020
                                recSalInvHdr[2].RESET;
                                recSalInvHdr[2].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                IF recSalInvHdr[2].FIND('-') THEN
                                    IF (STRPOS(custNo[2], recSalInvHdr[2]."Sell-to Customer No.") = 0) THEN
                                        IF custNo[2] = '' THEN
                                            custNo[2] := recSalInvHdr[2]."Sell-to Customer No."
                                        ELSE
                                            custNo[2] := custNo[2] + '|' + recSalInvHdr[2]."Sell-to Customer No.";

                                // custNo:=DELCHR(custNo,'>','|');
                                CustRec.RESET();
                                CustRec.SETFILTER("No.", custNo[2]);
                                IF CustRec.FINDFIRST THEN
                                    intMTDCustCnt[2] := CustRec.COUNT;
                                //Keshav01092020

                                //Item Count>>
                                recSalesInvLn[2].RESET;
                                recSalesInvLn[2].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                                recSalesInvLn[2].SETFILTER(Quantity, '<>%1', 0);
                                IF recSalesInvLn[2].FIND('-') THEN
                                    REPEAT
                                        IF (STRPOS(itemno[2], recSalesInvLn[2]."No.") = 0) THEN
                                            IF itemno[2] = '' THEN
                                                itemno[2] := recSalesInvLn[2]."No."
                                            ELSE
                                                itemno[2] := itemno[2] + '|' + recSalesInvLn[2]."No.";
                                    UNTIL recSalesInvLn[2].NEXT = 0;

                                ritem.RESET();
                                ritem.SETFILTER("No.", itemno[2]);
                                ritem.SETRANGE("Item Category Code", 'H001');
                                ritem.SETRANGE(NPD, 'Rhino Paver');
                                ritem.SETRANGE("Quality Code", '1');
                                IF ritem.FINDFIRST THEN
                                    intMTDItemCnt[2] := ritem.COUNT;
                                //Item Count<<
                            END;
                            IF SalesJournalData.Item_npd = 'Ascend Step Paver' THEN BEGIN
                                decMTDDesp[9] += SalesJournalData.Quantity_in_Sq_Mt;
                                //Keshav01092020
                                recSalInvHdr[9].RESET;
                                recSalInvHdr[9].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                IF recSalInvHdr[9].FIND('-') THEN
                                    IF (STRPOS(custNo[9], recSalInvHdr[9]."Sell-to Customer No.") = 0) THEN
                                        IF custNo[9] = '' THEN
                                            custNo[9] := recSalInvHdr[9]."Sell-to Customer No."
                                        ELSE
                                            custNo[9] := custNo[9] + '|' + recSalInvHdr[9]."Sell-to Customer No.";

                                // custNo:=DELCHR(custNo,'>','|');
                                CustRec.RESET();
                                CustRec.SETFILTER("No.", custNo[9]);
                                IF CustRec.FINDFIRST THEN
                                    intMTDCustCnt[9] := CustRec.COUNT;
                                //Keshav01092020

                                //Item Count>>
                                recSalesInvLn[9].RESET;
                                recSalesInvLn[9].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                                recSalesInvLn[9].SETFILTER(Quantity, '<>%1', 0);
                                IF recSalesInvLn[9].FIND('-') THEN
                                    REPEAT
                                        IF (STRPOS(itemno[9], recSalesInvLn[9]."No.") = 0) THEN
                                            IF itemno[9] = '' THEN
                                                itemno[9] := recSalesInvLn[9]."No."
                                            ELSE
                                                itemno[9] := itemno[9] + '|' + recSalesInvLn[9]."No.";
                                    UNTIL recSalesInvLn[9].NEXT = 0;

                                ritem.RESET();
                                ritem.SETFILTER("No.", itemno[9]);
                                ritem.SETRANGE("Item Category Code", 'H001');
                                ritem.SETRANGE(NPD, 'Ascend Step Paver');
                                ritem.SETRANGE("Quality Code", '1');
                                IF ritem.FINDFIRST THEN
                                    intMTDItemCnt[9] := ritem.COUNT;
                                //Item Count<<
                            END;
                            IF (SalesJournalData.Size_Code_Desc_Filter = '600X600') THEN BEGIN
                                decMTDDesp[10] += SalesJournalData.Quantity_in_Sq_Mt;

                                //Keshav01092020
                                recSalInvHdr[10].RESET;
                                recSalInvHdr[10].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                IF recSalInvHdr[10].FIND('-') THEN
                                    IF (STRPOS(custNo[10], recSalInvHdr[10]."Sell-to Customer No.") = 0) THEN
                                        IF custNo[10] = '' THEN
                                            custNo[10] := recSalInvHdr[10]."Sell-to Customer No."
                                        ELSE
                                            custNo[10] := custNo[10] + '|' + recSalInvHdr[10]."Sell-to Customer No.";

                                // custNo:=DELCHR(custNo,'>','|');
                                CustRec.RESET();
                                CustRec.SETFILTER("No.", custNo[10]);
                                IF CustRec.FINDFIRST THEN
                                    intMTDCustCnt[10] := CustRec.COUNT;
                                //Keshav01092020

                                //Item Count>>
                                recSalesInvLn[10].RESET;
                                recSalesInvLn[10].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                                recSalesInvLn[10].SETFILTER(Quantity, '<>%1', 0);
                                recSalesInvLn[10].SETFILTER(recSalesInvLn[10].Type, '%1', recSalesInvLn[10].Type::Item);
                                IF recSalesInvLn[10].FIND('-') THEN
                                    REPEAT
                                        IF (STRPOS(itemno[10], recSalesInvLn[10]."No.") = 0) THEN
                                            IF itemno[10] = '' THEN
                                                itemno[10] := recSalesInvLn[10]."No."
                                            ELSE
                                                itemno[10] := itemno[10] + '|' + recSalesInvLn[10]."No.";
                                    UNTIL recSalesInvLn[10].NEXT = 0;

                                ritem.RESET();
                                ritem.SETFILTER("No.", itemno[10]);
                                ritem.SETRANGE("Item Category Code", 'H001');
                                ritem.SETRANGE("Size Code Desc.", '600X600');
                                ritem.SETRANGE("Quality Code", '1');
                                IF ritem.FINDFIRST THEN
                                    intMTDItemCnt[10] := ritem.COUNT;
                            END;
                            IF (SalesJournalData.Size_Code_Desc_Filter = '600X1200') THEN BEGIN
                                decMTDDesp[11] += SalesJournalData.Quantity_in_Sq_Mt;

                                //Keshav01092020
                                recSalInvHdr[11].RESET;
                                recSalInvHdr[11].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                IF recSalInvHdr[11].FIND('-') THEN
                                    IF (STRPOS(custNo[11], recSalInvHdr[11]."Sell-to Customer No.") = 0) THEN
                                        IF custNo[11] = '' THEN
                                            custNo[11] := recSalInvHdr[11]."Sell-to Customer No."
                                        ELSE
                                            custNo[11] := custNo[11] + '|' + recSalInvHdr[11]."Sell-to Customer No.";

                                // custNo:=DELCHR(custNo,'>','|');
                                CustRec.RESET();
                                CustRec.SETFILTER("No.", custNo[11]);
                                IF CustRec.FINDFIRST THEN
                                    intMTDCustCnt[11] := CustRec.COUNT;
                                //Keshav01092020

                                //Item Count>>
                                recSalesInvLn[11].RESET;
                                recSalesInvLn[11].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                                recSalesInvLn[11].SETFILTER(Quantity, '<>%1', 0);
                                recSalesInvLn[11].SETFILTER(recSalesInvLn[11].Type, '%1', recSalesInvLn[11].Type::Item);
                                IF recSalesInvLn[11].FIND('-') THEN
                                    REPEAT
                                        IF (STRPOS(itemno[11], recSalesInvLn[11]."No.") = 0) THEN
                                            IF itemno[11] = '' THEN
                                                itemno[11] := recSalesInvLn[11]."No."
                                            ELSE
                                                itemno[11] := itemno[11] + '|' + recSalesInvLn[11]."No.";
                                    UNTIL recSalesInvLn[11].NEXT = 0;

                                ritem.RESET();
                                ritem.SETFILTER("No.", itemno[11]);
                                ritem.SETRANGE("Item Category Code", 'H001');
                                ritem.SETRANGE("Size Code Desc.", '600X1200');
                                ritem.SETRANGE("Quality Code", '1');
                                IF ritem.FINDFIRST THEN
                                    intMTDItemCnt[11] := ritem.COUNT;
                            END;
                        END;

                        CLEAR(SalesJournalData);
                        //SalesJournalData.SETFILTER(SalesJournalData.AreaFilter,'%1',"Matrix Master"."Type 1");
                        SalesJournalData.SETFILTER(SalesJournalData.Item_Category_Code_Filter, '%1', 'H001');
                        SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', AsonDate - 1, AsonDate - 1);
                        SalesJournalData.SETFILTER(SalesJournalData.CustomerType, '%1|%2|%3', 'GET', 'SET', 'PET');
                        SalesJournalData.OPEN;
                        WHILE SalesJournalData.READ DO BEGIN
                            IF (SalesJournalData.Size_Code_Desc_Filter = '250X375') THEN BEGIN
                                decFTDDesp[1] += SalesJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF SalesJournalData.Item_npd = 'Rhino Paver' THEN BEGIN
                                decFTDDesp[2] += SalesJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF SalesJournalData.Item_npd = 'Ascend Step Paver' THEN BEGIN
                                decFTDDesp[9] += SalesJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF (SalesJournalData.Size_Code_Desc_Filter = '600X600') THEN BEGIN
                                decFTDDesp[10] += SalesJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF (SalesJournalData.Size_Code_Desc_Filter = '600X1200') THEN BEGIN
                                decFTDDesp[11] += SalesJournalData.Quantity_in_Sq_Mt;
                            END;
                        END;

                        CLEAR(SalesReturnJournalData);
                        //SalesReturnJournalData.SETFILTER(SalesReturnJournalData.AreaFilter,'%1',"Matrix Master"."Type 1");
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code_Filter, '%1', 'H001');
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.PostingDateFilter, '%1..%2', CALCDATE('-CM', AsonDate - 1), AsonDate - 1);
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.CustomerType, '%1|%2|%3', 'GET', 'SET', 'PET');
                        SalesReturnJournalData.OPEN;
                        WHILE SalesReturnJournalData.READ DO BEGIN
                            IF (SalesReturnJournalData.Size_Code_Desc = '250X375') THEN BEGIN
                                decMTDRet[1] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF SalesReturnJournalData.NPD = 'Rhino Paver' THEN BEGIN
                                decMTDRet[2] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF SalesReturnJournalData.NPD = 'Ascend Step Paver' THEN BEGIN
                                decMTDRet[9] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF (SalesReturnJournalData.Size_Code_Desc = '600X600') THEN BEGIN
                                decMTDRet[10] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF (SalesReturnJournalData.Size_Code_Desc = '600X1200') THEN BEGIN
                                decMTDRet[11] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                        END;

                        CLEAR(SalesReturnJournalData);
                        //SalesReturnJournalData.SETFILTER(SalesReturnJournalData.AreaFilter,'%1',"Matrix Master"."Type 1");
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code_Filter, '%1', 'H001');
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.PostingDateFilter, '%1..%2', AsonDate - 1, AsonDate - 1);
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.CustomerType, '%1|%2|%3', 'GET', 'SET', 'PET');
                        SalesReturnJournalData.OPEN;
                        WHILE SalesReturnJournalData.READ DO BEGIN
                            IF (SalesReturnJournalData.Size_Code_Desc = '250X375') THEN BEGIN
                                decFTDRet[1] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF SalesReturnJournalData.NPD = 'Rhino Paver' THEN BEGIN
                                decFTDRet[2] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF SalesReturnJournalData.NPD = 'Ascend Step Paver' THEN BEGIN
                                decFTDRet[9] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF (SalesReturnJournalData.Size_Code_Desc = '600X600') THEN BEGIN
                                decFTDRet[10] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF (SalesReturnJournalData.Size_Code_Desc = '600X1200') THEN BEGIN
                                decFTDRet[11] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                        END;
                    END;
                    IF DATE2DMY(AsonDate, 2) < 4 THEN
                        intMinus := 1
                    ELSE
                        intMinus := 0;

                    CLEAR(SalesJournalData);
                    SalesJournalData.SETFILTER(SalesJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                    SalesJournalData.SETFILTER(SalesJournalData.Item_Category_Code_Filter, '%1', 'H001');
                    //SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter,'%1..%2',DMY2DATE(DATE2DMY(AsonDate-1,1),4,DATE2DMY(AsonDate-1,3)-intMinus),AsonDate-1);
                    SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', DMY2DATE(1, 4, DATE2DMY(AsonDate - 1, 3) - intMinus), AsonDate - 1);
                    //  SalesJournalData.SETFILTER(SalesJournalData.CustomerType,'<>%1','CKA');
                    SalesJournalData.OPEN;
                    WHILE SalesJournalData.READ DO BEGIN
                        IF (SalesJournalData.Size_Code_Desc_Filter = '250X375') THEN BEGIN
                            recSalInvHdr[1].RESET;
                            recSalInvHdr[1].SETRANGE("No.", SalesJournalData.InvoiceNo);
                            IF recSalInvHdr[1].FIND('-') THEN
                                IF (STRPOS(CustNoYTD[1], recSalInvHdr[1]."Sell-to Customer No.") = 0) THEN
                                    IF CustNoYTD[1] = '' THEN
                                        CustNoYTD[1] := recSalInvHdr[1]."Sell-to Customer No."
                                    ELSE
                                        CustNoYTD[1] := CustNoYTD[1] + '|' + recSalInvHdr[1]."Sell-to Customer No.";

                            // custNo:=DELCHR(custNo,'>','|');
                            CustRec.RESET();
                            CustRec.SETFILTER("No.", CustNoYTD[1]);
                            IF CustRec.FINDFIRST THEN
                                intYTDCustCnt[1] := CustRec.COUNT;

                            //Item Count>>
                            recSalesInvLn[1].RESET;
                            recSalesInvLn[1].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                            recSalesInvLn[1].SETFILTER(Quantity, '<>%1', 0);
                            IF recSalesInvLn[1].FIND('-') THEN
                                REPEAT
                                    IF (STRPOS(itemNoYTD[1], recSalesInvLn[1]."No.") = 0) THEN
                                        IF itemNoYTD[1] = '' THEN
                                            itemNoYTD[1] := recSalesInvLn[1]."No."
                                        ELSE
                                            itemNoYTD[1] := itemNoYTD[1] + '|' + recSalesInvLn[1]."No.";
                                UNTIL recSalesInvLn[1].NEXT = 0;

                            ritem.RESET();
                            ritem.SETFILTER("No.", itemNoYTD[1]);
                            ritem.SETRANGE("Item Category Code", 'H001');
                            ritem.SETRANGE("Size Code Desc.", '250X375');
                            ritem.SETRANGE("Quality Code", '1');
                            IF ritem.FINDFIRST THEN
                                intYTDItemCnt[1] := ritem.COUNT;
                            //Item Count<<

                        END;
                        IF SalesJournalData.Item_npd = 'Rhino Paver' THEN BEGIN
                            recSalInvHdr[2].RESET;
                            recSalInvHdr[2].SETRANGE("No.", SalesJournalData.InvoiceNo);
                            IF recSalInvHdr[2].FIND('-') THEN
                                IF (STRPOS(CustNoYTD[2], recSalInvHdr[2]."Sell-to Customer No.") = 0) THEN
                                    IF CustNoYTD[2] = '' THEN
                                        CustNoYTD[2] := recSalInvHdr[2]."Sell-to Customer No."
                                    ELSE
                                        CustNoYTD[2] := CustNoYTD[2] + '|' + recSalInvHdr[2]."Sell-to Customer No.";

                            // custNo:=DELCHR(custNo,'>','|');
                            CustRec.RESET();
                            CustRec.SETFILTER("No.", CustNoYTD[2]);
                            IF CustRec.FINDFIRST THEN
                                intYTDCustCnt[2] := CustRec.COUNT;

                            //Item Count>>
                            recSalesInvLn[2].RESET;
                            recSalesInvLn[2].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                            recSalesInvLn[2].SETFILTER(Quantity, '<>%1', 0);
                            IF recSalesInvLn[2].FIND('-') THEN
                                REPEAT
                                    IF (STRPOS(itemNoYTD[2], recSalesInvLn[2]."No.") = 0) THEN
                                        IF itemNoYTD[2] = '' THEN
                                            itemNoYTD[2] := recSalesInvLn[2]."No."
                                        ELSE
                                            itemNoYTD[2] := itemNoYTD[2] + '|' + recSalesInvLn[2]."No.";
                                UNTIL recSalesInvLn[2].NEXT = 0;

                            ritem.RESET();
                            ritem.SETFILTER("No.", itemNoYTD[2]);
                            ritem.SETRANGE("Item Category Code", 'H001');
                            ritem.SETRANGE(NPD, 'Rhino Paver');
                            ritem.SETRANGE("Quality Code", '1');
                            IF ritem.FINDFIRST THEN
                                intYTDItemCnt[2] := ritem.COUNT;
                            //Item Count<<
                        END;
                        IF SalesJournalData.Item_npd = 'Ascend Step Paver' THEN BEGIN
                            recSalInvHdr[9].RESET;
                            recSalInvHdr[9].SETRANGE("No.", SalesJournalData.InvoiceNo);
                            IF recSalInvHdr[9].FIND('-') THEN
                                IF (STRPOS(CustNoYTD[9], recSalInvHdr[9]."Sell-to Customer No.") = 0) THEN
                                    IF CustNoYTD[9] = '' THEN
                                        CustNoYTD[9] := recSalInvHdr[9]."Sell-to Customer No."
                                    ELSE
                                        CustNoYTD[9] := CustNoYTD[9] + '|' + recSalInvHdr[9]."Sell-to Customer No.";

                            // custNo:=DELCHR(custNo,'>','|');
                            CustRec.RESET();
                            CustRec.SETFILTER("No.", CustNoYTD[9]);
                            IF CustRec.FINDFIRST THEN
                                intYTDCustCnt[9] := CustRec.COUNT;

                            //Item Count>>
                            recSalesInvLn[9].RESET;
                            recSalesInvLn[9].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                            recSalesInvLn[9].SETFILTER(Quantity, '<>%1', 0);
                            IF recSalesInvLn[9].FIND('-') THEN
                                REPEAT
                                    IF (STRPOS(itemNoYTD[9], recSalesInvLn[9]."No.") = 0) THEN
                                        IF itemNoYTD[9] = '' THEN
                                            itemNoYTD[9] := recSalesInvLn[9]."No."
                                        ELSE
                                            itemNoYTD[9] := itemNoYTD[9] + '|' + recSalesInvLn[9]."No.";
                                UNTIL recSalesInvLn[9].NEXT = 0;

                            ritem.RESET();
                            ritem.SETFILTER("No.", itemNoYTD[9]);
                            ritem.SETRANGE("Item Category Code", 'H001');
                            ritem.SETRANGE(NPD, 'Ascend Step Paver');
                            ritem.SETRANGE("Quality Code", '1');
                            IF ritem.FINDFIRST THEN
                                intYTDItemCnt[9] := ritem.COUNT;
                            //Item Count<<
                        END;
                        IF (SalesJournalData.Size_Code_Desc_Filter = '600X600') THEN BEGIN
                            recSalInvHdr[10].RESET;
                            recSalInvHdr[10].SETRANGE("No.", SalesJournalData.InvoiceNo);
                            IF recSalInvHdr[10].FIND('-') THEN
                                IF (STRPOS(CustNoYTD[10], recSalInvHdr[10]."Sell-to Customer No.") = 0) THEN
                                    IF CustNoYTD[10] = '' THEN
                                        CustNoYTD[10] := recSalInvHdr[10]."Sell-to Customer No."
                                    ELSE
                                        CustNoYTD[10] := CustNoYTD[10] + '|' + recSalInvHdr[10]."Sell-to Customer No.";

                            // custNo:=DELCHR(custNo,'>','|');
                            CustRec.RESET();
                            CustRec.SETFILTER("No.", CustNoYTD[10]);
                            IF CustRec.FINDFIRST THEN
                                intYTDCustCnt[10] := CustRec.COUNT;

                            //Item Count>>
                            recSalesInvLn[10].RESET;
                            recSalesInvLn[10].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                            recSalesInvLn[10].SETFILTER(Quantity, '<>%1', 0);
                            IF recSalesInvLn[10].FIND('-') THEN
                                REPEAT
                                    IF (STRPOS(itemNoYTD[10], recSalesInvLn[10]."No.") = 0) THEN
                                        IF itemNoYTD[10] = '' THEN
                                            itemNoYTD[10] := recSalesInvLn[10]."No."
                                        ELSE
                                            itemNoYTD[10] := itemNoYTD[10] + '|' + recSalesInvLn[10]."No.";
                                UNTIL recSalesInvLn[10].NEXT = 0;

                            ritem.RESET();
                            ritem.SETFILTER("No.", itemNoYTD[10]);
                            ritem.SETRANGE("Item Category Code", 'H001');
                            ritem.SETRANGE("Size Code Desc.", '600X600');
                            ritem.SETRANGE("Quality Code", '1');
                            IF ritem.FINDFIRST THEN
                                intYTDItemCnt[10] := ritem.COUNT;
                            //Item Count<<

                        END;
                        IF (SalesJournalData.Size_Code_Desc_Filter = '600X1200') THEN BEGIN
                            recSalInvHdr[11].RESET;
                            recSalInvHdr[11].SETRANGE("No.", SalesJournalData.InvoiceNo);
                            IF recSalInvHdr[11].FIND('-') THEN
                                IF (STRPOS(CustNoYTD[11], recSalInvHdr[11]."Sell-to Customer No.") = 0) THEN
                                    IF CustNoYTD[11] = '' THEN
                                        CustNoYTD[11] := recSalInvHdr[11]."Sell-to Customer No."
                                    ELSE
                                        CustNoYTD[11] := CustNoYTD[11] + '|' + recSalInvHdr[11]."Sell-to Customer No.";

                            // custNo:=DELCHR(custNo,'>','|');
                            CustRec.RESET();
                            CustRec.SETFILTER("No.", CustNoYTD[11]);
                            IF CustRec.FINDFIRST THEN
                                intYTDCustCnt[11] := CustRec.COUNT;

                            //Item Count>>
                            recSalesInvLn[11].RESET;
                            recSalesInvLn[11].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                            recSalesInvLn[11].SETFILTER(Quantity, '<>%1', 0);
                            IF recSalesInvLn[11].FIND('-') THEN
                                REPEAT
                                    IF (STRPOS(itemNoYTD[11], recSalesInvLn[11]."No.") = 0) THEN
                                        IF itemNoYTD[11] = '' THEN
                                            itemNoYTD[11] := recSalesInvLn[11]."No."
                                        ELSE
                                            itemNoYTD[11] := itemNoYTD[11] + '|' + recSalesInvLn[11]."No.";
                                UNTIL recSalesInvLn[11].NEXT = 0;

                            ritem.RESET();
                            ritem.SETFILTER("No.", itemNoYTD[11]);
                            ritem.SETRANGE("Item Category Code", 'H001');
                            ritem.SETRANGE("Size Code Desc.", '600X1200');
                            ritem.SETRANGE("Quality Code", '1');
                            IF ritem.FINDFIRST THEN
                                intYTDItemCnt[11] := ritem.COUNT;
                            //Item Count<<
                        END;
                    END;

                    CLEAR(SalesJournalData);
                    SalesJournalData.SETFILTER(SalesJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                    SalesJournalData.SETFILTER(SalesJournalData.Item_Category_Code_Filter, '%1', 'H001');
                    //SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter,'%1..%2',CALCDATE('-CM',DMY2DATE(DATE2DMY(TODAY-1,1),DATE2DMY(TODAY-1,2)-1,DATE2DMY(TODAY-1,3))),DMY2DATE(DATE2DMY(AsonDate-1,1),DATE2DMY(AsonDate-1,2)-1,DATE2DMY(AsonDate-1,3)));
                    //  SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter,'%1..%2',CALCDATE('-CM-1M',TODAY-1),CALCDATE('CM-1M',TODAY-1));
                    //SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter,'%1..%2',CALCDATE('-CM-1M',TODAY-1),DMY2DATE(DATE2DMY(AsonDate-1,1),DATE2DMY(AsonDate-1,2)-1,DATE2DMY(AsonDate-1,3)));
                    SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', LastMnthStDate, LastMnthEndDate);
                    //  SalesJournalData.SETFILTER(SalesJournalData.CustomerType,'<>%1','CKA');
                    SalesJournalData.OPEN;
                    WHILE SalesJournalData.READ DO BEGIN
                        IF (SalesJournalData.Size_Code_Desc_Filter = '250X375') THEN BEGIN
                            decLMTDDesp[1] += SalesJournalData.Quantity_in_Sq_Mt;
                            recSalInvHdr[1].RESET;
                            recSalInvHdr[1].SETRANGE("No.", SalesJournalData.InvoiceNo);
                            IF recSalInvHdr[1].FIND('-') THEN
                                IF (STRPOS(CustNoLMTD[1], recSalInvHdr[1]."Sell-to Customer No.") = 0) THEN
                                    IF CustNoLMTD[1] = '' THEN
                                        CustNoLMTD[1] := recSalInvHdr[1]."Sell-to Customer No."
                                    ELSE
                                        CustNoLMTD[1] := CustNoLMTD[1] + '|' + recSalInvHdr[1]."Sell-to Customer No.";

                            // custNo:=DELCHR(custNo,'>','|');
                            CustRec.RESET();
                            CustRec.SETFILTER("No.", CustNoLMTD[1]);
                            IF CustRec.FINDFIRST THEN
                                intLMTDCustCnt[1] := CustRec.COUNT;

                            //Item Count>>
                            recSalesInvLn[1].RESET;
                            recSalesInvLn[1].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                            recSalesInvLn[1].SETFILTER(Quantity, '<>%1', 0);
                            IF recSalesInvLn[1].FIND('-') THEN
                                REPEAT
                                    IF (STRPOS(itemNoLMTD[1], recSalesInvLn[1]."No.") = 0) THEN
                                        IF itemNoLMTD[1] = '' THEN
                                            itemNoLMTD[1] := recSalesInvLn[1]."No."
                                        ELSE
                                            itemNoLMTD[1] := itemNoLMTD[1] + '|' + recSalesInvLn[1]."No.";
                                UNTIL recSalesInvLn[1].NEXT = 0;

                            ritem.RESET();
                            ritem.SETFILTER("No.", itemNoLMTD[1]);
                            ritem.SETRANGE("Item Category Code", 'H001');
                            ritem.SETRANGE("Size Code Desc.", '250X375');
                            ritem.SETRANGE("Quality Code", '1');
                            IF ritem.FINDFIRST THEN
                                intLMTDItemCnt[1] := ritem.COUNT;
                            //Item Count<<
                            //ERROR('%1',itemNoLMTD[1]);

                        END;
                        IF SalesJournalData.Item_npd = 'Rhino Paver' THEN BEGIN
                            decLMTDDesp[2] += SalesJournalData.Quantity_in_Sq_Mt;
                            recSalInvHdr[2].RESET;
                            recSalInvHdr[2].SETRANGE("No.", SalesJournalData.InvoiceNo);
                            IF recSalInvHdr[2].FIND('-') THEN
                                IF (STRPOS(CustNoLMTD[2], recSalInvHdr[2]."Sell-to Customer No.") = 0) THEN
                                    IF CustNoLMTD[2] = '' THEN
                                        CustNoLMTD[2] := recSalInvHdr[2]."Sell-to Customer No."
                                    ELSE
                                        CustNoLMTD[2] := CustNoLMTD[2] + '|' + recSalInvHdr[2]."Sell-to Customer No.";

                            CustRec.RESET();
                            CustRec.SETFILTER("No.", CustNoLMTD[2]);
                            IF CustRec.FINDFIRST THEN
                                intLMTDCustCnt[2] := CustRec.COUNT;

                            //Item Count>>
                            recSalesInvLn[2].RESET;
                            recSalesInvLn[2].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                            recSalesInvLn[1].SETFILTER(Quantity, '<>%1', 0);
                            IF recSalesInvLn[2].FIND('-') THEN
                                REPEAT
                                    IF (STRPOS(itemNoLMTD[2], recSalesInvLn[2]."No.") = 0) THEN
                                        IF itemNoLMTD[2] = '' THEN
                                            itemNoLMTD[2] := recSalesInvLn[2]."No."
                                        ELSE
                                            itemNoLMTD[2] := itemNoLMTD[2] + '|' + recSalesInvLn[2]."No.";
                                UNTIL recSalesInvLn[2].NEXT = 0;

                            ritem.RESET();
                            ritem.SETFILTER("No.", itemNoLMTD[2]);
                            ritem.SETRANGE("Item Category Code", 'H001');
                            ritem.SETRANGE(NPD, 'Rhino Paver');
                            ritem.SETRANGE("Quality Code", '1');
                            IF ritem.FINDFIRST THEN
                                intLMTDItemCnt[2] := ritem.COUNT;
                            //Item Count<<

                        END;
                        IF SalesJournalData.Item_npd = 'Ascend Step Paver' THEN BEGIN
                            decLMTDDesp[9] += SalesJournalData.Quantity_in_Sq_Mt;
                            recSalInvHdr[9].RESET;
                            recSalInvHdr[9].SETRANGE("No.", SalesJournalData.InvoiceNo);
                            IF recSalInvHdr[9].FIND('-') THEN
                                IF (STRPOS(CustNoLMTD[9], recSalInvHdr[9]."Sell-to Customer No.") = 0) THEN
                                    IF CustNoLMTD[9] = '' THEN
                                        CustNoLMTD[9] := recSalInvHdr[9]."Sell-to Customer No."
                                    ELSE
                                        CustNoLMTD[9] := CustNoLMTD[9] + '|' + recSalInvHdr[9]."Sell-to Customer No.";

                            CustRec.RESET();
                            CustRec.SETFILTER("No.", CustNoLMTD[9]);
                            IF CustRec.FINDFIRST THEN
                                intLMTDCustCnt[9] := CustRec.COUNT;

                            //Item Count>>
                            recSalesInvLn[9].RESET;
                            recSalesInvLn[9].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                            recSalesInvLn[9].SETFILTER(Quantity, '<>%1', 0);
                            IF recSalesInvLn[9].FIND('-') THEN
                                REPEAT
                                    IF (STRPOS(itemNoLMTD[9], recSalesInvLn[9]."No.") = 0) THEN
                                        IF itemNoLMTD[9] = '' THEN
                                            itemNoLMTD[9] := recSalesInvLn[9]."No."
                                        ELSE
                                            itemNoLMTD[9] := itemNoLMTD[9] + '|' + recSalesInvLn[9]."No.";
                                UNTIL recSalesInvLn[9].NEXT = 0;

                            ritem.RESET();
                            ritem.SETFILTER("No.", itemNoLMTD[9]);
                            ritem.SETRANGE("Item Category Code", 'H001');
                            ritem.SETRANGE(NPD, 'Ascend Step Paver');
                            ritem.SETRANGE("Quality Code", '1');
                            IF ritem.FINDFIRST THEN
                                intLMTDItemCnt[9] := ritem.COUNT;
                            //Item Count<<
                        END;
                        IF (SalesJournalData.Size_Code_Desc_Filter = '600X600') THEN BEGIN
                            decLMTDDesp[10] += SalesJournalData.Quantity_in_Sq_Mt;
                            recSalInvHdr[10].RESET;
                            recSalInvHdr[10].SETRANGE("No.", SalesJournalData.InvoiceNo);
                            IF recSalInvHdr[10].FIND('-') THEN
                                IF (STRPOS(CustNoLMTD[10], recSalInvHdr[10]."Sell-to Customer No.") = 0) THEN
                                    IF CustNoLMTD[10] = '' THEN
                                        CustNoLMTD[10] := recSalInvHdr[10]."Sell-to Customer No."
                                    ELSE
                                        CustNoLMTD[10] := CustNoLMTD[10] + '|' + recSalInvHdr[10]."Sell-to Customer No.";

                            // custNo:=DELCHR(custNo,'>','|');
                            CustRec.RESET();
                            CustRec.SETFILTER("No.", CustNoLMTD[10]);
                            IF CustRec.FINDFIRST THEN
                                intLMTDCustCnt[10] := CustRec.COUNT;

                            //Item Count>>
                            recSalesInvLn[10].RESET;
                            recSalesInvLn[10].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                            recSalesInvLn[10].SETFILTER(Quantity, '<>%1', 0);
                            IF recSalesInvLn[10].FIND('-') THEN
                                REPEAT
                                    IF (STRPOS(itemNoLMTD[10], recSalesInvLn[10]."No.") = 0) THEN
                                        IF itemNoLMTD[10] = '' THEN
                                            itemNoLMTD[10] := recSalesInvLn[10]."No."
                                        ELSE
                                            itemNoLMTD[10] := itemNoLMTD[10] + '|' + recSalesInvLn[10]."No.";
                                UNTIL recSalesInvLn[10].NEXT = 0;

                            ritem.RESET();
                            ritem.SETFILTER("No.", itemNoLMTD[10]);
                            ritem.SETRANGE("Item Category Code", 'H001');
                            ritem.SETRANGE("Size Code Desc.", '600X600');
                            ritem.SETRANGE("Quality Code", '1');
                            IF ritem.FINDFIRST THEN
                                intLMTDItemCnt[10] := ritem.COUNT;
                            //Item Count<<

                        END;
                        IF (SalesJournalData.Size_Code_Desc_Filter = '600X1200') THEN BEGIN
                            decLMTDDesp[11] += SalesJournalData.Quantity_in_Sq_Mt;
                            recSalInvHdr[11].RESET;
                            recSalInvHdr[11].SETRANGE("No.", SalesJournalData.InvoiceNo);
                            IF recSalInvHdr[11].FIND('-') THEN
                                IF (STRPOS(CustNoLMTD[11], recSalInvHdr[11]."Sell-to Customer No.") = 0) THEN
                                    IF CustNoLMTD[11] = '' THEN
                                        CustNoLMTD[11] := recSalInvHdr[11]."Sell-to Customer No."
                                    ELSE
                                        CustNoLMTD[11] := CustNoLMTD[11] + '|' + recSalInvHdr[11]."Sell-to Customer No.";

                            // custNo:=DELCHR(custNo,'>','|');
                            CustRec.RESET();
                            CustRec.SETFILTER("No.", CustNoLMTD[11]);
                            IF CustRec.FINDFIRST THEN
                                intLMTDCustCnt[11] := CustRec.COUNT;

                            //Item Count>>
                            recSalesInvLn[11].RESET;
                            recSalesInvLn[11].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                            recSalesInvLn[11].SETFILTER(Quantity, '<>%1', 0);

                            IF recSalesInvLn[11].FIND('-') THEN
                                REPEAT
                                    IF (STRPOS(itemNoLMTD[11], recSalesInvLn[11]."No.") = 0) THEN
                                        IF itemNoLMTD[11] = '' THEN
                                            itemNoLMTD[11] := recSalesInvLn[11]."No."
                                        ELSE
                                            itemNoLMTD[11] := itemNoLMTD[11] + '|' + recSalesInvLn[11]."No.";
                                UNTIL recSalesInvLn[11].NEXT = 0;

                            ritem.RESET();
                            ritem.SETFILTER("No.", itemNoLMTD[11]);
                            ritem.SETRANGE("Item Category Code", 'H001');
                            ritem.SETRANGE("Size Code Desc.", '600X1200');
                            ritem.SETRANGE("Quality Code", '1');
                            IF ritem.FINDFIRST THEN
                                intLMTDItemCnt[11] := ritem.COUNT;
                            //Item Count<<
                        END;
                    END;
                    CLEAR(SalesReturnJournalData);
                    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code_Filter, '%1', 'H001');
                    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.PostingDateFilter, '%1..%2', LastMnthStDate, LastMnthEndDate);
                    SalesReturnJournalData.OPEN;
                    WHILE SalesReturnJournalData.READ DO BEGIN
                        IF (SalesReturnJournalData.Size_Code_Desc = '250X375') THEN BEGIN
                            decLMTDRet[1] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                        END;
                        IF SalesReturnJournalData.NPD = 'Rhino Paver' THEN BEGIN
                            decMTDRet[2] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                        END;
                        IF SalesReturnJournalData.NPD = 'Ascend Step Paver' THEN BEGIN
                            decMTDRet[9] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                        END;
                        IF (SalesReturnJournalData.Size_Code_Desc = '600X600') THEN BEGIN
                            decLMTDRet[10] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                        END;
                        IF (SalesReturnJournalData.Size_Code_Desc = '600X1200') THEN BEGIN
                            decLMTDRet[11] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                        END;
                    END;

                END;

                //Dora Report
                IF (QuantitativeReport) THEN BEGIN
                    IF ("Matrix Master"."Type 1" <> 'CKA') THEN BEGIN

                        CLEAR(SalesOrdersDetails);
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.AreaFilter, '%1', "Matrix Master"."Type 1");
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Document_Type, '%1', DocTypeEnum::Order);
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.StatusFilter, '%1', StatusEnum::Released);
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Item_Category_Code, '%1', 'D001');
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Customer_Type, '<>%1&<>%2&<>%3', 'GET', 'PET', 'SET');
                        SalesOrdersDetails.OPEN;
                        WHILE SalesOrdersDetails.READ DO BEGIN
                            IF (SalesOrdersDetails.Size_Code_Desc = '600X600') AND ((SalesOrdersDetails.Type_Catogery_Code = '54') OR (SalesOrdersDetails.Type_Catogery_Code = '46')) THEN BEGIN
                                decOpnOrderOtstnd[3] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END;
                            IF (SalesOrdersDetails.Size_Code_Desc = '600X600') AND (SalesOrdersDetails.Tableau_Product_Group = 'GVT') THEN BEGIN
                                decOpnOrderOtstnd[4] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END;
                            IF (SalesOrdersDetails.Size_Code_Desc = '600X1200') AND (SalesOrdersDetails.Tableau_Product_Group = 'GVT') THEN BEGIN
                                decOpnOrderOtstnd[5] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END;
                        END;
                        CLEAR(SalesJournalData);
                        SalesJournalData.SETFILTER(SalesJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                        SalesJournalData.SETFILTER(SalesJournalData.Item_Category_Code_Filter, '%1', 'D001');
                        SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', CALCDATE('-CM', AsonDate - 1), AsonDate - 1);
                        SalesJournalData.SETFILTER(SalesJournalData.CustomerType, '<>%1&<>%2&<>%3', 'GET', 'PET', 'SET');
                        SalesJournalData.OPEN;
                        WHILE SalesJournalData.READ DO BEGIN
                            IF (SalesJournalData.SizeCodeDesc = '600X600') AND (SalesJournalData.TypeCatCode = '54') THEN BEGIN
                                decMTDDesp[3] += SalesJournalData.Quantity_in_Sq_Mt;

                                //Keshav01092020
                                recSalInvHdr[3].RESET;
                                recSalInvHdr[3].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                recSalesInvLn[3].SETFILTER(Quantity, '<>%1', 0);
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

                                //Item Count>>
                                recSalesInvLn[3].RESET;
                                recSalesInvLn[3].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                                recSalesInvLn[3].SETRANGE(Type, recSalesInvLn[3].Type::Item); //msks
                                recSalesInvLn[3].SETFILTER(recSalesInvLn[3]."No.", SalesJournalData.ItemNo); //MSKS
                                recSalesInvLn[3].SETFILTER(Quantity, '<>%1', 0); //MSKS
                                IF recSalesInvLn[3].FIND('-') THEN
                                    REPEAT
                                        IF ISValidItem(recSalesInvLn[3]."No.", 'D001', '600X600', '54', '1') THEN
                                            IF (STRPOS(itemno[3], recSalesInvLn[3]."No.") = 0) THEN
                                                IF itemno[3] = '' THEN
                                                    itemno[3] := recSalesInvLn[3]."No."
                                                ELSE
                                                    itemno[3] := itemno[3] + '|' + recSalesInvLn[3]."No.";
                                    UNTIL recSalesInvLn[3].NEXT = 0;

                                ritem.RESET();
                                ritem.SETFILTER("No.", itemno[3]);
                                ritem.SETRANGE("Item Category Code", 'D001');
                                ritem.SETRANGE("Size Code Desc.", '600X600');
                                ritem.SETRANGE("Type Catogery Code", '54');
                                ritem.SETRANGE("Quality Code", '1');
                                IF ritem.FINDFIRST THEN
                                    intMTDItemCnt[3] := ritem.COUNT;
                                //Item Count<<

                            END;
                            IF (SalesJournalData.SizeCodeDesc = '600X600') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decMTDDesp[4] += SalesJournalData.Quantity_in_Sq_Mt;

                                //Keshav01092020
                                recSalInvHdr[4].RESET;
                                recSalInvHdr[4].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                recSalesInvLn[4].SETFILTER(Quantity, '<>%1', 0);
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
                                //Keshav01092020
                                //Item Count>>
                                recSalesInvLn[4].RESET;
                                recSalesInvLn[4].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                                IF recSalesInvLn[4].FIND('-') THEN
                                    REPEAT
                                        IF (STRPOS(itemno[4], recSalesInvLn[4]."No.") = 0) THEN
                                            IF itemno[4] = '' THEN
                                                itemno[4] := recSalesInvLn[4]."No."
                                            ELSE
                                                itemno[4] := itemno[4] + '|' + recSalesInvLn[4]."No.";
                                    UNTIL recSalesInvLn[4].NEXT = 0;

                                ritem.RESET();
                                ritem.SETFILTER("No.", itemno[4]);
                                ritem.SETRANGE("Item Category Code", 'D001');
                                ritem.SETRANGE("Size Code Desc.", '600X600');
                                ritem.SETRANGE("Tableau Product Group", 'GVT');
                                ritem.SETRANGE("Quality Code", '1');
                                IF ritem.FINDFIRST THEN
                                    intMTDItemCnt[4] := ritem.COUNT;
                                //Item Count<<
                            END;
                            IF (SalesJournalData.SizeCodeDesc = '600X1200') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decMTDDesp[5] += SalesJournalData.Quantity_in_Sq_Mt;

                                //Keshav01092020
                                recSalInvHdr[5].RESET;
                                recSalInvHdr[5].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                recSalesInvLn[5].SETFILTER(Quantity, '<>%1', 0);
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
                                //Keshav01092020
                                //Item Count>>
                                recSalesInvLn[5].RESET;
                                recSalesInvLn[5].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                                IF recSalesInvLn[5].FIND('-') THEN
                                    REPEAT
                                        IF (STRPOS(itemno[5], recSalesInvLn[5]."No.") = 0) THEN
                                            IF itemno[5] = '' THEN
                                                itemno[5] := recSalesInvLn[5]."No."
                                            ELSE
                                                itemno[5] := itemno[5] + '|' + recSalesInvLn[5]."No.";
                                    UNTIL recSalesInvLn[5].NEXT = 0;

                                ritem.RESET();
                                ritem.SETFILTER("No.", itemno[5]);
                                ritem.SETRANGE("Item Category Code", 'D001');
                                ritem.SETRANGE("Size Code Desc.", '600X1200');
                                ritem.SETRANGE("Tableau Product Group", 'GVT');
                                ritem.SETRANGE("Quality Code", '1');
                                IF ritem.FINDFIRST THEN
                                    intMTDItemCnt[5] := ritem.COUNT;
                                //Item Count<<
                                //  END;
                            END;
                        END;


                        CLEAR(SalesReturnJournalData);
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code_Filter, '%1', 'D001');
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.PostingDateFilter, '%1..%2', CALCDATE('-CM', AsonDate - 1), AsonDate - 1);
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.CustomerType, '<>%1&<>%2&<>%3', 'GET', 'PET', 'SET');
                        SalesReturnJournalData.OPEN;
                        WHILE SalesReturnJournalData.READ DO BEGIN
                            IF (SalesReturnJournalData.SizeCodeDesc = '600X600') AND ((SalesReturnJournalData.TypeCatCode = '54')) THEN BEGIN //16767  OR (SalesReturnJournalData.TypeCatCode = '46'))
                                decMTDRet[3] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF (SalesReturnJournalData.SizeCodeDesc = '600X600') AND (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decMTDRet[4] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF (SalesReturnJournalData.SizeCodeDesc = '600X1200') AND (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decMTDRet[5] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                        END;

                        CLEAR(SalesJournalData);
                        SalesJournalData.SETFILTER(SalesJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                        SalesJournalData.SETFILTER(SalesJournalData.Item_Category_Code_Filter, '%1', 'D001');
                        SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', AsonDate - 1, AsonDate - 1);
                        SalesJournalData.SETFILTER(SalesJournalData.CustomerType, '<>%1&<>%2&<>%3', 'GET', 'PET', 'SET');
                        SalesJournalData.OPEN;
                        WHILE SalesJournalData.READ DO BEGIN
                            IF (SalesJournalData.SizeCodeDesc = '600X600') AND ((SalesJournalData.TypeCatCode = '54') OR (SalesJournalData.TypeCatCode = '46')) THEN BEGIN
                                decFTDDesp[3] += SalesJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF (SalesJournalData.SizeCodeDesc = '600X600') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decFTDDesp[4] += SalesJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF (SalesJournalData.SizeCodeDesc = '600X1200') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decFTDDesp[5] += SalesJournalData.Quantity_in_Sq_Mt;
                            END;
                        END;

                        CLEAR(SalesReturnJournalData);
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code_Filter, '%1', 'D001');
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.PostingDateFilter, '%1..%2', AsonDate - 1, AsonDate - 1);
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.CustomerType, '<>%1&<>%2&<>%3', 'GET', 'PET', 'SET');
                        SalesReturnJournalData.OPEN;
                        WHILE SalesReturnJournalData.READ DO BEGIN
                            IF (SalesReturnJournalData.SizeCodeDesc = '600X600') AND ((SalesReturnJournalData.TypeCatCode = '54') OR (SalesReturnJournalData.TypeCatCode = '46')) THEN BEGIN
                                decFTDRet[3] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF (SalesReturnJournalData.SizeCodeDesc = '600X600') AND (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decFTDRet[4] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF (SalesReturnJournalData.SizeCodeDesc = '600X1200') AND (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decFTDRet[5] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                        END;
                    END ELSE BEGIN
                        CLEAR(SalesOrdersDetails);
                        //    SalesOrdersDetails.SETFILTER(SalesOrdersDetails.AreaFilter,'%1',"Matrix Master"."Type 1");
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Document_Type, '%1', DocTypeEnum::Order);
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.StatusFilter, '%1', StatusEnum::Released);
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Item_Category_Code, '%1', 'D001');
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Customer_Type, '%1|%2|%3', 'GET', 'SET', 'PET');
                        SalesOrdersDetails.OPEN;
                        WHILE SalesOrdersDetails.READ DO BEGIN
                            IF (SalesOrdersDetails.Size_Code_Desc = '600X600') AND ((SalesOrdersDetails.Type_Catogery_Code = '54') OR (SalesOrdersDetails.Type_Catogery_Code = '46')) THEN BEGIN
                                decOpnOrderOtstnd[3] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END;
                            IF (SalesOrdersDetails.Size_Code_Desc = '600X600') AND (SalesOrdersDetails.Tableau_Product_Group = 'GVT') THEN BEGIN
                                decOpnOrderOtstnd[4] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END;
                            IF (SalesOrdersDetails.Size_Code_Desc = '600X1200') AND (SalesOrdersDetails.Tableau_Product_Group = 'GVT') THEN BEGIN
                                decOpnOrderOtstnd[5] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END;
                        END;

                        CLEAR(SalesReturnJournalData);
                        //    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.AreaFilter,'%1',"Matrix Master"."Type 1");
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code_Filter, '%1', 'D001');
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.PostingDateFilter, '%1..%2', CALCDATE('-CM', AsonDate - 1), AsonDate - 1);
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.CustomerType, '%1|%2|%3', 'GET', 'SET', 'PET');
                        SalesReturnJournalData.OPEN;
                        WHILE SalesReturnJournalData.READ DO BEGIN
                            IF (SalesReturnJournalData.SizeCodeDesc = '600X600') AND ((SalesReturnJournalData.TypeCatCode = '54') OR (SalesReturnJournalData.TypeCatCode = '46')) THEN BEGIN
                                decMTDRet[3] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF (SalesReturnJournalData.SizeCodeDesc = '600X600') AND (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decMTDRet[4] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                            IF (SalesReturnJournalData.SizeCodeDesc = '600X1200') AND (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decMTDRet[5] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                        END;
                        CLEAR(SalesJournalData);
                        //SalesJournalData.SETFILTER(SalesJournalData.AreaFilter,'%1',"Matrix Master"."Type 1");
                        SalesJournalData.SETFILTER(SalesJournalData.Item_Category_Code_Filter, '%1', 'D001');
                        SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', CALCDATE('-CM', AsonDate - 1), AsonDate - 1);
                        SalesJournalData.SETFILTER(SalesJournalData.CustomerType, '%1|%2|%3', 'GET', 'SET', 'PET');
                        SalesJournalData.OPEN;
                        WHILE SalesJournalData.READ DO BEGIN
                            IF (SalesJournalData.SizeCodeDesc = '600X600') AND (SalesJournalData.TypeCatCode = '54') THEN BEGIN
                                decMTDDesp[3] += SalesJournalData.Quantity_in_Sq_Mt;

                                //Keshav01092020
                                recSalInvHdr[3].RESET;
                                recSalInvHdr[3].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                IF recSalInvHdr[3].FIND('-') THEN
                                    IF (STRPOS(custNo[3], recSalInvHdr[3]."Sell-to Customer No.") = 0) THEN
                                        IF custNo[3] = '' THEN
                                            custNo[3] := recSalInvHdr[3]."Sell-to Customer No."
                                        ELSE
                                            custNo[3] := custNo[3] + '|' + recSalInvHdr[3]."Sell-to Customer No.";

                                // custNo:=DELCHR(custNo,'>','|');
                                CustRec.RESET();
                                CustRec.SETFILTER("No.", custNo[3]);
                                IF CustRec.FINDFIRST THEN
                                    intMTDCustCnt[3] := CustRec.COUNT;
                                //Keshav01092020

                                //Item Count>>
                                recSalesInvLn[3].RESET;
                                recSalesInvLn[3].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                                recSalesInvLn[3].SETFILTER(Quantity, '<>%1', 0);
                                IF recSalesInvLn[3].FIND('-') THEN
                                    REPEAT
                                        IF (STRPOS(itemno[3], recSalesInvLn[3]."No.") = 0) THEN
                                            IF itemno[3] = '' THEN
                                                itemno[3] := recSalesInvLn[3]."No."
                                            ELSE
                                                itemno[3] := itemno[3] + '|' + recSalesInvLn[3]."No.";
                                    UNTIL recSalesInvLn[3].NEXT = 0;

                                ritem.RESET();
                                ritem.SETFILTER("No.", itemno[3]);
                                ritem.SETRANGE("Item Category Code", 'D001');
                                ritem.SETRANGE("Size Code Desc.", '600X600');
                                ritem.SETRANGE("Type Catogery Code", '54');
                                ritem.SETRANGE("Quality Code", '1');
                                IF ritem.FINDFIRST THEN
                                    intMTDItemCnt[3] := ritem.COUNT;
                                //Item Count<<

                            END;
                            IF (SalesJournalData.SizeCodeDesc = '600X600') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decMTDDesp[4] += SalesJournalData.Quantity_in_Sq_Mt;
                                //Keshav01092020
                                recSalInvHdr[4].RESET;
                                recSalInvHdr[4].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                IF recSalInvHdr[4].FIND('-') THEN
                                    IF (STRPOS(custNo[4], recSalInvHdr[4]."Sell-to Customer No.") = 0) THEN
                                        IF custNo[4] = '' THEN
                                            custNo[4] := recSalInvHdr[4]."Sell-to Customer No."
                                        ELSE
                                            custNo[4] := custNo[4] + '|' + recSalInvHdr[4]."Sell-to Customer No.";

                                // custNo:=DELCHR(custNo,'>','|');
                                CustRec.RESET();
                                CustRec.SETFILTER("No.", custNo[4]);
                                IF CustRec.FINDFIRST THEN
                                    intMTDCustCnt[4] := CustRec.COUNT;
                                //Keshav01092020

                                //Item Count>>
                                recSalesInvLn[4].RESET;
                                recSalesInvLn[4].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                                recSalesInvLn[4].SETFILTER(Quantity, '<>%1', 0);
                                IF recSalesInvLn[4].FIND('-') THEN
                                    REPEAT
                                        IF (STRPOS(itemno[4], recSalesInvLn[4]."No.") = 0) THEN
                                            IF itemno[4] = '' THEN
                                                itemno[4] := recSalesInvLn[4]."No."
                                            ELSE
                                                itemno[4] := itemno[4] + '|' + recSalesInvLn[4]."No.";
                                    UNTIL recSalesInvLn[4].NEXT = 0;

                                ritem.RESET();
                                ritem.SETFILTER("No.", itemno[4]);
                                ritem.SETRANGE("Item Category Code", 'D001');
                                ritem.SETRANGE("Size Code Desc.", '600X600');
                                ritem.SETRANGE("Tableau Product Group", 'GVT');
                                ritem.SETRANGE("Quality Code", '1');
                                IF ritem.FINDFIRST THEN
                                    intMTDItemCnt[4] := ritem.COUNT;
                                //Item Count<<

                            END;
                            IF (SalesJournalData.SizeCodeDesc = '600X1200') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decMTDDesp[5] += SalesJournalData.Quantity_in_Sq_Mt;
                                //Keshav01092020
                                recSalInvHdr[5].RESET;
                                recSalInvHdr[5].SETRANGE("No.", SalesJournalData.InvoiceNo);
                                IF recSalInvHdr[5].FIND('-') THEN
                                    IF (STRPOS(custNo[5], recSalInvHdr[5]."Sell-to Customer No.") = 0) THEN
                                        IF custNo[5] = '' THEN
                                            custNo[5] := recSalInvHdr[5]."Sell-to Customer No."
                                        ELSE
                                            custNo[5] := custNo[5] + '|' + recSalInvHdr[5]."Sell-to Customer No.";

                                // custNo:=DELCHR(custNo,'>','|');
                                CustRec.RESET();
                                CustRec.SETFILTER("No.", custNo[5]);
                                IF CustRec.FINDFIRST THEN
                                    intMTDCustCnt[5] := CustRec.COUNT;
                                //Keshav01092020

                                //Item Count>>
                                recSalesInvLn[5].RESET;
                                recSalesInvLn[5].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                                recSalesInvLn[5].SETFILTER(Quantity, '<>%1', 0);
                                IF recSalesInvLn[5].FIND('-') THEN
                                    REPEAT
                                        IF (STRPOS(itemno[5], recSalesInvLn[5]."No.") = 0) THEN
                                            IF itemno[5] = '' THEN
                                                itemno[5] := recSalesInvLn[5]."No."
                                            ELSE
                                                itemno[5] := itemno[5] + '|' + recSalesInvLn[5]."No.";
                                    UNTIL recSalesInvLn[5].NEXT = 0;

                                ritem.RESET();
                                ritem.SETFILTER("No.", itemno[5]);
                                ritem.SETRANGE("Item Category Code", 'D001');
                                ritem.SETRANGE("Size Code Desc.", '600X1200');
                                ritem.SETRANGE("Tableau Product Group", 'GVT');
                                ritem.SETRANGE("Quality Code", '1');
                                IF ritem.FINDFIRST THEN
                                    intMTDItemCnt[5] := ritem.COUNT;
                                //Item Count<<

                            END;
                        END;
                    END;


                    CLEAR(SalesJournalData);
                    //SalesJournalData.SETFILTER(SalesJournalData.AreaFilter,'%1',"Matrix Master"."Type 1");
                    SalesJournalData.SETFILTER(SalesJournalData.Item_Category_Code_Filter, '%1', 'D001');
                    SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', AsonDate - 1, AsonDate - 1);
                    SalesJournalData.SETFILTER(SalesJournalData.CustomerType, '%1|%2|%3', 'GET', 'SET', 'PET');
                    SalesJournalData.OPEN;
                    WHILE SalesJournalData.READ DO BEGIN
                        IF (SalesJournalData.SizeCodeDesc = '600X600') AND ((SalesJournalData.TypeCatCode = '54')/*   OR (SalesJournalData.TypeCatCode = '46') 16767*/) THEN BEGIN
                            decFTDDesp[3] += SalesJournalData.Quantity_in_Sq_Mt;
                        END;
                        IF (SalesJournalData.SizeCodeDesc = '600X600') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                            decFTDDesp[4] += SalesJournalData.Quantity_in_Sq_Mt;
                        END;
                        IF (SalesJournalData.SizeCodeDesc = '600X1200') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                            decFTDDesp[5] += SalesJournalData.Quantity_in_Sq_Mt;
                        END;
                    END;

                    CLEAR(SalesReturnJournalData);
                    //    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.AreaFilter,'%1',"Matrix Master"."Type 1");
                    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code_Filter, '%1', 'D001');
                    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.PostingDateFilter, '%1..%2', AsonDate - 1, AsonDate - 1);
                    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.CustomerType, '%1|%2|%3', 'GET', 'SET', 'PET');
                    SalesReturnJournalData.OPEN;
                    WHILE SalesReturnJournalData.READ DO BEGIN
                        IF (SalesReturnJournalData.SizeCodeDesc = '600X600') AND ((SalesReturnJournalData.TypeCatCode = '54') OR (SalesReturnJournalData.TypeCatCode = '46')) THEN BEGIN
                            decFTDRet[3] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                        END;
                        IF (SalesReturnJournalData.SizeCodeDesc = '600X600') AND (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                            decFTDRet[4] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                        END;
                        IF (SalesReturnJournalData.SizeCodeDesc = '600X1200') AND (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                            decFTDRet[5] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                        END;
                    END;
                    IF DATE2DMY(AsonDate, 2) < 4 THEN
                        intMinus := 1
                    ELSE
                        intMinus := 0;

                    CLEAR(SalesJournalData);
                    SalesJournalData.SETFILTER(SalesJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                    SalesJournalData.SETFILTER(SalesJournalData.Item_Category_Code_Filter, '%1', 'D001');
                    //SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter,'%1..%2',DMY2DATE(DATE2DMY(AsonDate-1,1),4,DATE2DMY(AsonDate-1,3)-intMinus),AsonDate-1);
                    SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', DMY2DATE(1, 4, DATE2DMY(AsonDate - 1, 3) - intMinus), AsonDate - 1);
                    //  SalesJournalData.SETFILTER(SalesJournalData.CustomerType,'<>%1','CKA');
                    SalesJournalData.OPEN;
                    WHILE SalesJournalData.READ DO BEGIN
                        IF (SalesJournalData.SizeCodeDesc = '600X600') AND ((SalesJournalData.TypeCatCode = '54') OR (SalesJournalData.TypeCatCode = '46')) THEN BEGIN
                            recSalInvHdr[3].RESET;
                            recSalInvHdr[3].SETRANGE("No.", SalesJournalData.InvoiceNo);
                            IF recSalInvHdr[3].FIND('-') THEN
                                IF (STRPOS(CustNoYTD[3], recSalInvHdr[3]."Sell-to Customer No.") = 0) THEN
                                    IF CustNoYTD[3] = '' THEN
                                        CustNoYTD[3] := recSalInvHdr[3]."Sell-to Customer No."
                                    ELSE
                                        CustNoYTD[3] := CustNoYTD[3] + '|' + recSalInvHdr[3]."Sell-to Customer No.";

                            // custNo:=DELCHR(custNo,'>','|');
                            CustRec.RESET();
                            CustRec.SETFILTER("No.", CustNoYTD[3]);
                            IF CustRec.FINDFIRST THEN
                                intYTDCustCnt[3] := CustRec.COUNT;

                            //Item Count>>
                            recSalesInvLn[3].RESET;
                            recSalesInvLn[3].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                            recSalesInvLn[3].SETFILTER(Quantity, '<>%1', 0);
                            IF recSalesInvLn[3].FIND('-') THEN
                                REPEAT
                                    IF (ISValidItem(recSalesInvLn[3]."No.", 'D001', '600X600', '54', '1')) OR (ISValidItem(recSalesInvLn[3]."No.", 'D001', '600X600', '46', '1')) THEN
                                        IF (STRPOS(itemNoYTD[3], recSalesInvLn[3]."No.") = 0) THEN
                                            IF itemNoYTD[3] = '' THEN
                                                itemNoYTD[3] := recSalesInvLn[3]."No."
                                            ELSE
                                                itemNoYTD[3] := itemNoYTD[3] + '|' + recSalesInvLn[3]."No.";
                                UNTIL recSalesInvLn[3].NEXT = 0;

                            ritem.RESET();
                            ritem.SETFILTER("No.", itemNoYTD[3]);
                            ritem.SETRANGE("Item Category Code", 'D001');
                            ritem.SETRANGE("Size Code Desc.", '600X600');
                            ritem.SETFILTER("Type Catogery Code", '%1|%2', '54', '46');
                            ritem.SETRANGE("Quality Code", '1');
                            IF ritem.FINDFIRST THEN
                                intYTDItemCnt[3] := ritem.COUNT;
                            //Item Count<<


                        END;
                        IF (SalesJournalData.SizeCodeDesc = '600X600') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                            recSalInvHdr[4].RESET;
                            recSalInvHdr[4].SETRANGE("No.", SalesJournalData.InvoiceNo);
                            IF recSalInvHdr[4].FIND('-') THEN
                                IF (STRPOS(CustNoYTD[4], recSalInvHdr[4]."Sell-to Customer No.") = 0) THEN
                                    IF CustNoYTD[4] = '' THEN
                                        CustNoYTD[4] := recSalInvHdr[4]."Sell-to Customer No."
                                    ELSE
                                        CustNoYTD[4] := CustNoYTD[4] + '|' + recSalInvHdr[4]."Sell-to Customer No.";

                            // custNo:=DELCHR(custNo,'>','|');
                            CustRec.RESET();
                            CustRec.SETFILTER("No.", CustNoYTD[4]);
                            IF CustRec.FINDFIRST THEN
                                intYTDCustCnt[4] := CustRec.COUNT;

                            //Item Count>>
                            recSalesInvLn[4].RESET;
                            recSalesInvLn[4].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                            recSalesInvLn[4].SETFILTER(Quantity, '<>%1', 0);
                            IF recSalesInvLn[4].FIND('-') THEN
                                REPEAT
                                    IF (STRPOS(itemNoYTD[4], recSalesInvLn[4]."No.") = 0) THEN
                                        IF itemNoYTD[4] = '' THEN
                                            itemNoYTD[4] := recSalesInvLn[4]."No."
                                        ELSE
                                            itemNoYTD[4] := itemNoYTD[4] + '|' + recSalesInvLn[4]."No.";
                                UNTIL recSalesInvLn[4].NEXT = 0;

                            ritem.RESET();
                            ritem.SETFILTER("No.", itemNoYTD[4]);
                            ritem.SETRANGE("Item Category Code", 'D001');
                            ritem.SETRANGE("Size Code Desc.", '600X600');
                            ritem.SETRANGE("Tableau Product Group", 'GVT');
                            ritem.SETRANGE("Quality Code", '1');
                            IF ritem.FINDFIRST THEN
                                intYTDItemCnt[4] := ritem.COUNT;
                            //Item Count<<
                        END;
                        IF (SalesJournalData.SizeCodeDesc = '600X1200') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                            recSalInvHdr[5].RESET;
                            recSalInvHdr[5].SETRANGE("No.", SalesJournalData.InvoiceNo);
                            IF recSalInvHdr[5].FIND('-') THEN
                                IF (STRPOS(CustNoYTD[5], recSalInvHdr[5]."Sell-to Customer No.") = 0) THEN
                                    IF CustNoYTD[5] = '' THEN
                                        CustNoYTD[5] := recSalInvHdr[5]."Sell-to Customer No."
                                    ELSE
                                        CustNoYTD[5] := CustNoYTD[5] + '|' + recSalInvHdr[5]."Sell-to Customer No.";

                            // custNo:=DELCHR(custNo,'>','|');
                            CustRec.RESET();
                            CustRec.SETFILTER("No.", CustNoYTD[5]);
                            IF CustRec.FINDFIRST THEN
                                intYTDCustCnt[5] := CustRec.COUNT;

                            //Item Count>>
                            recSalesInvLn[5].RESET;
                            recSalesInvLn[5].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                            recSalesInvLn[5].SETFILTER(Quantity, '<>%1', 0);
                            IF recSalesInvLn[5].FIND('-') THEN
                                REPEAT
                                    IF (STRPOS(itemNoYTD[5], recSalesInvLn[5]."No.") = 0) THEN
                                        IF itemNoYTD[5] = '' THEN
                                            itemNoYTD[5] := recSalesInvLn[5]."No."
                                        ELSE
                                            itemNoYTD[5] := itemNoYTD[5] + '|' + recSalesInvLn[5]."No.";
                                UNTIL recSalesInvLn[5].NEXT = 0;

                            ritem.RESET();
                            ritem.SETFILTER("No.", itemNoYTD[5]);
                            ritem.SETRANGE("Item Category Code", 'D001');
                            ritem.SETRANGE("Size Code Desc.", '600X1200');
                            ritem.SETRANGE("Tableau Product Group", 'GVT');
                            ritem.SETRANGE("Quality Code", '1');
                            IF ritem.FINDFIRST THEN
                                intYTDItemCnt[5] := ritem.COUNT;
                            //Item Count<<
                        END;


                    END;

                    CLEAR(SalesJournalData);
                    SalesJournalData.SETFILTER(SalesJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                    SalesJournalData.SETFILTER(SalesJournalData.Item_Category_Code_Filter, '%1', 'D001');
                    //SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter,'%1..%2',CALCDATE('-CM',DMY2DATE(DATE2DMY(TODAY-1,1),DATE2DMY(TODAY-1,2)-1,DATE2DMY(TODAY-1,3))),DMY2DATE(DATE2DMY(AsonDate-1,1),DATE2DMY(AsonDate-1,2)-1,DATE2DMY(AsonDate-1,3)));
                    //  SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter,'%1..%2',CALCDATE('-CM-1M',TODAY-1),CALCDATE('CM-1M',TODAY-1));
                    //SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter,'%1..%2',CALCDATE('-CM-1M',TODAY-1),DMY2DATE(DATE2DMY(AsonDate-1,1),DATE2DMY(AsonDate-1,2)-1,DATE2DMY(AsonDate-1,3)));
                    SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', LastMnthStDate, LastMnthEndDate);
                    //  SalesJournalData.SETFILTER(SalesJournalData.CustomerType,'<>%1','CKA');
                    SalesJournalData.OPEN;
                    WHILE SalesJournalData.READ DO BEGIN
                        IF (SalesJournalData.SizeCodeDesc = '600X600') AND ((SalesJournalData.TypeCatCode = '54') OR (SalesJournalData.TypeCatCode = '46')) THEN BEGIN
                            decLMTDDesp[3] += SalesJournalData.Quantity_in_Sq_Mt;
                            recSalInvHdr[3].RESET;
                            recSalInvHdr[3].SETRANGE("No.", SalesJournalData.InvoiceNo);
                            IF recSalInvHdr[3].FIND('-') THEN
                                IF (STRPOS(CustNoLMTD[3], recSalInvHdr[3]."Sell-to Customer No.") = 0) THEN
                                    IF CustNoLMTD[3] = '' THEN
                                        CustNoLMTD[3] := recSalInvHdr[3]."Sell-to Customer No."
                                    ELSE
                                        CustNoLMTD[3] := CustNoLMTD[3] + '|' + recSalInvHdr[3]."Sell-to Customer No.";

                            // custNo:=DELCHR(custNo,'>','|');
                            CustRec.RESET();
                            CustRec.SETFILTER("No.", CustNoLMTD[3]);
                            IF CustRec.FINDFIRST THEN
                                intLMTDCustCnt[3] := CustRec.COUNT;

                            //Item Count>>
                            recSalesInvLn[3].RESET;
                            recSalesInvLn[3].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                            recSalesInvLn[3].SETFILTER(Quantity, '<>%1', 0);
                            IF recSalesInvLn[3].FIND('-') THEN
                                REPEAT
                                    IF (STRPOS(itemNoLMTD[3], recSalesInvLn[3]."No.") = 0) THEN
                                        IF itemNoLMTD[3] = '' THEN
                                            itemNoLMTD[3] := recSalesInvLn[3]."No."
                                        ELSE
                                            itemNoLMTD[3] := itemNoLMTD[3] + '|' + recSalesInvLn[3]."No.";
                                UNTIL recSalesInvLn[3].NEXT = 0;

                            ritem.RESET();
                            ritem.SETFILTER("No.", itemNoLMTD[3]);
                            ritem.SETRANGE("Item Category Code", 'D001');
                            ritem.SETRANGE("Size Code Desc.", '600X600');
                            ritem.SETFILTER("Type Catogery Code", '%1|%2', '54', '46');
                            ritem.SETRANGE("Quality Code", '1');
                            IF ritem.FINDFIRST THEN
                                intLMTDItemCnt[3] := ritem.COUNT;
                            //Item Count<<

                        END;
                        IF (SalesJournalData.SizeCodeDesc = '600X600') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                            decLMTDDesp[4] += SalesJournalData.Quantity_in_Sq_Mt;
                            recSalInvHdr[4].RESET;
                            recSalInvHdr[4].SETRANGE("No.", SalesJournalData.InvoiceNo);
                            IF recSalInvHdr[4].FIND('-') THEN
                                IF (STRPOS(CustNoLMTD[4], recSalInvHdr[4]."Sell-to Customer No.") = 0) THEN
                                    IF CustNoLMTD[4] = '' THEN
                                        CustNoLMTD[4] := recSalInvHdr[4]."Sell-to Customer No."
                                    ELSE
                                        CustNoLMTD[4] := CustNoLMTD[4] + '|' + recSalInvHdr[4]."Sell-to Customer No.";

                            CustRec.RESET();
                            CustRec.SETFILTER("No.", CustNoLMTD[4]);
                            IF CustRec.FINDFIRST THEN
                                intLMTDCustCnt[4] := CustRec.COUNT;

                            //Item Count>>
                            recSalesInvLn[4].RESET;
                            recSalesInvLn[4].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                            recSalesInvLn[4].SETFILTER(Quantity, '<>%1', 0);
                            IF recSalesInvLn[4].FIND('-') THEN
                                REPEAT
                                    IF (STRPOS(itemNoLMTD[4], recSalesInvLn[4]."No.") = 0) THEN
                                        IF itemNoLMTD[4] = '' THEN
                                            itemNoLMTD[4] := recSalesInvLn[4]."No."
                                        ELSE
                                            itemNoLMTD[4] := itemNoLMTD[4] + '|' + recSalesInvLn[4]."No.";
                                UNTIL recSalesInvLn[4].NEXT = 0;

                            ritem.RESET();
                            ritem.SETFILTER("No.", itemNoLMTD[4]);
                            ritem.SETRANGE("Item Category Code", 'D001');
                            ritem.SETRANGE("Size Code Desc.", '600X600');
                            ritem.SETRANGE("Tableau Product Group", 'GVT');
                            ritem.SETRANGE("Quality Code", '1');
                            IF ritem.FINDFIRST THEN
                                intLMTDItemCnt[4] := ritem.COUNT;
                            //Item Count<<
                        END;
                        IF (SalesJournalData.SizeCodeDesc = '600X1200') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                            decLMTDDesp[5] += SalesJournalData.Quantity_in_Sq_Mt;
                            recSalInvHdr[5].RESET;
                            recSalInvHdr[5].SETRANGE("No.", SalesJournalData.InvoiceNo);
                            IF recSalInvHdr[5].FIND('-') THEN
                                IF (STRPOS(CustNoLMTD[5], recSalInvHdr[5]."Sell-to Customer No.") = 0) THEN
                                    IF CustNoLMTD[5] = '' THEN
                                        CustNoLMTD[5] := recSalInvHdr[5]."Sell-to Customer No."
                                    ELSE
                                        CustNoLMTD[5] := CustNoLMTD[5] + '|' + recSalInvHdr[5]."Sell-to Customer No.";

                            CustRec.RESET();
                            CustRec.SETFILTER("No.", CustNoLMTD[5]);
                            IF CustRec.FINDFIRST THEN
                                intLMTDCustCnt[5] := CustRec.COUNT;

                            //Item Count>>
                            recSalesInvLn[5].RESET;
                            recSalesInvLn[5].SETRANGE("Document No.", SalesJournalData.InvoiceNo);
                            recSalesInvLn[5].SETFILTER(Quantity, '<>%1', 0);
                            IF recSalesInvLn[5].FIND('-') THEN
                                REPEAT
                                    IF (STRPOS(itemNoLMTD[5], recSalesInvLn[5]."No.") = 0) THEN
                                        IF itemNoLMTD[5] = '' THEN
                                            itemNoLMTD[5] := recSalesInvLn[5]."No."
                                        ELSE
                                            itemNoLMTD[5] := itemNoLMTD[5] + '|' + recSalesInvLn[5]."No.";
                                UNTIL recSalesInvLn[5].NEXT = 0;

                            ritem.RESET();
                            ritem.SETFILTER("No.", itemNoLMTD[5]);
                            ritem.SETRANGE("Item Category Code", 'D001');
                            ritem.SETRANGE("Size Code Desc.", '600X1200');
                            ritem.SETRANGE("Tableau Product Group", 'GVT');
                            ritem.SETRANGE("Quality Code", '1');
                            IF ritem.FINDFIRST THEN
                                intLMTDItemCnt[5] := ritem.COUNT;
                            //Item Count<<
                        END;
                    END;

                    CLEAR(SalesReturnJournalData);
                    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code_Filter, '%1', 'D001');
                    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.PostingDateFilter, '%1..%2', LastMnthStDate, LastMnthEndDate);
                    SalesReturnJournalData.OPEN;
                    WHILE SalesReturnJournalData.READ DO BEGIN
                        IF (SalesReturnJournalData.SizeCodeDesc = '600X600') AND ((SalesReturnJournalData.TypeCatCode = '54') OR (SalesReturnJournalData.TypeCatCode = '46')) THEN BEGIN
                            decLMTDRet[3] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                        END;
                        IF (SalesReturnJournalData.SizeCodeDesc = '600X600') AND (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                            decLMTDRet[4] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                        END;
                        IF (SalesReturnJournalData.SizeCodeDesc = '600X1200') AND (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                            decLMTDRet[5] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                        END;
                    END;
                END;
                intCnt += 1;
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
        AsonDate := TODAY;
        //AsonDate:=010822D;
        QuantitativeReport := TRUE;

        LastMnthStDate := CALCDATE('-CM', (CALCDATE('-CM-1D', AsonDate - 1)));

        IF CALCDATE('CM', AsonDate - 1) = AsonDate - 1 THEN
            LastMnthEndDate := CALCDATE('-CM-1D', AsonDate - 1)
        ELSE
            //LastMnthEndDate := DMY2DATE(DATE2DMY(AsonDate,1)-1,DATE2DMY(AsonDate,2)-1,DATE2DMY(AsonDate,3));
            //LastMnthEndDate := CALCDATE('CM',(CALCDATE('-CM-1D',AsonDate-1)));
            LastMnthEndDate := (CALCDATE('<-1M>', AsonDate - 1));
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
        CLEAR(intMTDItemCnt);
        CLEAR(intYTDItemCnt);
        CLEAR(intLMTDItemCnt);
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
        OrderBookedAmt: array[10] of Decimal;
        OrderBookedQty: array[10] of Decimal;
        AsonDate: Date;
        OrderReleasedAmt: array[10] of Decimal;
        OrderReleasedQty: array[10] of Decimal;
        Target: Decimal;
        MTD: Decimal;
        InvBookedQty: array[10] of Decimal;
        InvBookedAmt: array[10] of Decimal;
        InvOrderQty: array[10] of Decimal;
        InvOrderAmt: array[10] of Decimal;
        MTDQty: Decimal;
        QuantitativeReport: Boolean;
        FTDQty: Decimal;
        FTD: Decimal;
        NintyDaySales: Decimal;
        OutStandingAmt: Decimal;
        Sales: Decimal;
        DSO: Decimal;
        recItem: Record Item;
        decOpnOrderOtstnd: array[11] of Decimal;
        decMTDDesp: array[11] of Decimal;
        decFTDDesp: array[11] of Decimal;
        SalesJournalData: Query "Sales Journal Data";
        tempMatrixMaster: Record "Matrix Master" temporary;
        decMTDRet: array[11] of Decimal;
        decFTDRet: array[11] of Decimal;
        intMTDCustCnt: array[11] of Integer;
        intYTDCustCnt: array[11] of Integer;
        intLMTDCustCnt: array[11] of Integer;
        tempSalesInvHdr: array[11] of Record "Sales Invoice Header" temporary;
        recSalInvHdr: array[11] of Record "Sales Invoice Header";
        intMinus: Integer;
        tempSalesInvHdrYTD: array[11] of Record "Sales Invoice Header" temporary;
        tempSalesInvHdrLMTD: array[11] of Record "Sales Invoice Header" temporary;
        intTest: Integer;
        tmSalInv: Record "Sales Invoice Header";
        recSalCrMemoHdr: array[11] of Record "Sales Cr.Memo Header";
        tempSalesCrMemoHdr: array[11] of Record "Sales Cr.Memo Header" temporary;
        custNo: array[11] of Text;
        CustRec: Record Customer;
        CustNoYTD: array[11] of Text;
        CustNoLMTD: array[11] of Text;
        decLMTDDesp: array[11] of Decimal;
        itemno: array[11] of Text;
        recSalesInvLn: array[11] of Record "Sales Invoice Line";
        ritem: Record Item;
        intMTDItemCnt: array[11] of Integer;
        intLMTDItemCnt: array[11] of Integer;
        intYTDItemCnt: array[11] of Integer;
        itemNoYTD: array[11] of Text;
        itemNoLMTD: array[11] of Text;
        intCnt: Integer;
        LastMnthStDate: Date;
        LastMnthEndDate: Date;
        decLMTDRet: array[20] of Decimal;
        DocTypeEnum: Enum "Document Type Enum";
        StatusEnum: Enum "Sales Document Status";

    local procedure InitialisedVariables()
    begin
        CLEAR(OrderBookedAmt);
        CLEAR(OrderBookedQty);
        CLEAR(OrderReleasedQty);
        CLEAR(OrderReleasedAmt);

        CLEAR(InvBookedAmt);
        CLEAR(InvBookedQty);
        CLEAR(InvOrderAmt);
        CLEAR(InvOrderQty);
        OpenOrdersAmt := 0;
        OpenOrdersQty := 0;
        ReleaseOrdersAmt := 0;
        ReleaseOrdersQty := 0;
        MTD := 0;
        MTDQty := 0;
        FTD := 0;
        FTDQty := 0;
        DSO := 0;
        OutStandingAmt := 0;
        Sales := 0;
    end;

    procedure SetReportType(LclQtyReport: Boolean)
    begin
        QuantitativeReport := LclQtyReport;
    end;

    local procedure ISValidItem(ItemNo: Code[20]; ItemCat: Code[10]; SizeCode: Text; TypeCatCode: Code[20]; QualityCode: Code[10]): Boolean
    var
        Item: Record Item;
    begin
        IF Item.GET(ItemNo) THEN BEGIN
            IF (Item."Item Category Code" = ItemCat) AND (Item."Size Code Desc." = SizeCode) AND (Item."Type Catogery Code" = TypeCatCode)
              AND (Item."Quality Code" = QualityCode) THEN
                EXIT(TRUE);
        END;
    end;
}

