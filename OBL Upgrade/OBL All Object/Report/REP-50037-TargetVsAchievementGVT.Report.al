report 50037 "Target Vs Achievement GVT"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\TargetVsAchievementGVT.rdl';
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
            column(decLMTDDesp1; decLMTDDesp[1])
            {
            }
            column(decLMTDret1; decLMTDret[1])
            {
            }
            column(decLMTDDesp2; decLMTDDesp[2])
            {
            }
            column(decLMTDret2; decLMTDret[2])
            {
            }
            column(decLMTDDesp3; decLMTDDesp[3])
            {
            }
            column(decLMTDret3; decLMTDret[3])
            {
            }
            column(decLMTDDesp4; decLMTDDesp[4])
            {
            }
            column(decLMTDret4; decLMTDret[4])
            {
            }
            column(decLMTDDesp5; decLMTDDesp[5])
            {
            }
            column(decLMTDret5; decLMTDret[5])
            {
            }
            column(decLMTDDesp6; decLMTDDesp[6])
            {
            }
            column(decLMTDret6; decLMTDret[6])
            {
            }
            column(decLMTDDesp7; decLMTDDesp[7])
            {
            }
            column(decLMTDret7; decLMTDret[7])
            {
            }
            column(decLMTDDesp8; decLMTDDesp[8])
            {
            }
            column(decLMTDDesp9; decLMTDDesp[9])
            {
            }
            column(decLMTDDesp10; decLMTDDesp[10])
            {
            }
            column(decLMTDret8; decLMTDret[8])
            {
            }
            column(decLMTDret9; decLMTDret[9])
            {
            }
            column(decLMTDret10; decLMTDret[10])
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
            column(intMTDItemCnt6; intMTDItemCnt[6])
            {
            }
            column(intMTDItemCnt7; intMTDItemCnt[7])
            {
            }
            column(intMTDItemCnt8; intMTDItemCnt[8])
            {
            }
            column(intMTDItemCnt9; intMTDItemCnt[9])
            {
            }
            column(intMTDItemCnt10; intMTDItemCnt[10])
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
            column(intYTDItemCnt6; intYTDItemCnt[6])
            {
            }
            column(intYTDItemCnt7; intYTDItemCnt[7])
            {
            }
            column(intYTDItemCnt8; intYTDItemCnt[8])
            {
            }
            column(intYTDItemCnt9; intYTDItemCnt[9])
            {
            }
            column(intYTDItemCnt10; intYTDItemCnt[10])
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
            column(intLMTDItemCnt6; intLMTDItemCnt[6])
            {
            }
            column(intLMTDItemCnt7; intLMTDItemCnt[7])
            {
            }
            column(intLMTDItemCnt8; intLMTDItemCnt[8])
            {
            }
            column(intLMTDItemCnt9; intLMTDItemCnt[9])
            {
            }
            column(intLMTDItemCnt10; intLMTDItemCnt[10])
            {
            }

            trigger OnAfterGetRecord()
            var
                OrderReleaseDate: Date;
                InvReleaseDate: Date;
                Customer: Record Customer;
            begin
                InitialisedVariables;
                IF QuantitativeReport THEN
                    Target := "Matrix Master"."Target GVT" ELSE
                    Target := "Matrix Master".Target;

                IF "Matrix Master"."Type 1" <> 'CKA' THEN BEGIN
                    IF QuantitativeReport THEN BEGIN
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.TabProdGrpFilter, '%1', 'GVT');
                    END;
                    //SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Customer_Type,'<>%1&<>%2&<>%3&<>%4','MISC.','CKA','DIRECTPROJ','LEGAL');
                    SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Customer_Type, '<>%1&<>%2&<>%3', 'GET', 'PET', 'SET');
                    SalesOrdersDetails.SETFILTER(SalesOrdersDetails.AreaFilter, '%1', "Matrix Master"."Type 1");
                    IF QuantitativeReport THEN
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Item_Category_Code, '%1', 'M001')
                    ELSE
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Item_Category_Code, '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');

                    SalesOrdersDetails.OPEN;
                    WHILE SalesOrdersDetails.READ DO BEGIN
                        IF SalesOrdersDetails.Location_Code <> 'DP-MORBI' THEN BEGIN
                            OrderReleaseDate := SalesOrdersDetails.Releasing_Date;
                            IF SalesOrdersDetails.Status = SalesOrdersDetails.Status::Released THEN BEGIN
                                ReleaseOrdersAmt += SalesOrdersDetails.Sum_Outstanding_Amount;
                                ReleaseOrdersQty += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END ELSE BEGIN
                                OpenOrdersAmt += SalesOrdersDetails.Sum_Outstanding_Amount;
                                OpenOrdersQty += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END;
                        END ELSE BEGIN
                            OrderReleaseDate := SalesOrdersDetails.OrderProcessDate;
                            IF SalesOrdersDetails.OrderProcessDate <> 0D THEN BEGIN
                                ReleaseOrdersAmt += SalesOrdersDetails.Sum_Outstanding_Amount;
                                ReleaseOrdersQty += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END ELSE BEGIN
                                OpenOrdersAmt += SalesOrdersDetails.Sum_Outstanding_Amount;
                                OpenOrdersQty += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END;
                        END;
                        CASE DT2DATE(SalesOrdersDetails.Make_Order_Date) OF
                            AsonDate - 3:
                                BEGIN
                                    OrderBookedQty[1] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                    OrderBookedAmt[1] += SalesOrdersDetails.Sum_Outstanding_Amount;
                                END;
                            AsonDate - 2:
                                BEGIN
                                    OrderBookedQty[2] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                    OrderBookedAmt[2] += SalesOrdersDetails.Sum_Outstanding_Amount;
                                END;
                            AsonDate - 1:
                                BEGIN
                                    OrderBookedQty[3] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                    OrderBookedAmt[3] += SalesOrdersDetails.Sum_Outstanding_Amount;
                                END;
                        END;
                        CASE OrderReleaseDate OF
                            AsonDate - 3:
                                BEGIN
                                    OrderReleasedQty[1] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                    OrderReleasedAmt[1] += SalesOrdersDetails.Sum_Outstanding_Amount;
                                END;
                            AsonDate - 2:
                                BEGIN
                                    OrderReleasedQty[2] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                    OrderReleasedAmt[2] += SalesOrdersDetails.Sum_Outstanding_Amount;
                                END;
                            AsonDate - 1:
                                BEGIN
                                    OrderReleasedQty[3] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                    OrderReleasedAmt[3] += SalesOrdersDetails.Sum_Outstanding_Amount;
                                END;
                        END;
                    END;
                    //FTD

                    CLEAR(SalesInvoicedDetails);
                    SalesInvoicedDetails.SETFILTER(Area_Code, '%1', "Matrix Master"."Type 1");
                    //SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Customer_Type,'<>%1&<>%2&<>%3&<>%4','MISC.','CKA','DIRECTPROJ','LEGAL');
                    SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Customer_Type, '<>%1&<>%2&<>%3', 'GET', 'PET', 'SET');
                    SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.PostingDateFilter, '%1..%2', AsonDate - 1, AsonDate - 1);
                    IF QuantitativeReport THEN
                        SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Item_Category_Code, '%1', 'M001')
                    ELSE
                        SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Item_Category_Code, '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                    IF QuantitativeReport THEN BEGIN
                        SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.TabProdGrpFilter, '%1', 'GVT');
                    END;
                    //SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Customer_Type,'<>%1','MISC.');
                    SalesInvoicedDetails.OPEN;
                    WHILE SalesInvoicedDetails.READ DO BEGIN
                        // FTD += SalesInvoicedDetails.Sum_Tax_Base_Amount;
                        FTDQty += SalesInvoicedDetails.Sum_Quantity_Base;
                    END;
                    //Sales Return
                    CLEAR(SalesReturnJournalData);
                    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.AreaCode, '%1', "Matrix Master"."Type 1");
                    //SalesReturnJournalData.SETFILTER(SalesReturnJournalData.CustomerType,'<>%1&<>%2&<>%3&<>%4','MISC.','CKA','DIRECTPROJ','LEGAL');
                    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.CustomerType, '<>%1&<>%2&<>%3', 'GET', 'PET', 'SET');
                    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.PostingDateFilter, '%1..%2', AsonDate - 1, AsonDate - 1);
                    IF QuantitativeReport THEN
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code, '%1', 'M001')
                    ELSE
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code, '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                    IF QuantitativeReport THEN BEGIN
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.TabProdGrp, '%1', 'GVT');
                    END;
                    //SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Customer_Type,'<>%1','MISC.');
                    SalesReturnJournalData.OPEN;
                    WHILE SalesReturnJournalData.READ DO BEGIN
                        FTD -= SalesReturnJournalData.LineAmount;
                        FTDQty -= SalesReturnJournalData.Quantity_Base;
                    END;
                    //FTD End

                    //FTD

                    //FTD End

                    CLEAR(SalesInvoicedDetails);
                    SalesInvoicedDetails.SETFILTER(Area_Code, '%1', "Matrix Master"."Type 1");
                    //SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Customer_Type,'<>%1&<>%2&<>%3&<>%4','MISC.','CKA','DIRECTPROJ','LEGAL');
                    SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Customer_Type, '<>%1&<>%2&<>%3', 'GET', 'PET', 'SET');
                    SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.PostingDateFilter, '%1..%2', CALCDATE('-CM', AsonDate - 1), AsonDate - 1);
                    IF QuantitativeReport THEN
                        SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Item_Category_Code, '%1', 'M001')
                    ELSE
                        SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Item_Category_Code, '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                    IF QuantitativeReport THEN BEGIN
                        SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.TabProdGrpFilter, '%1', 'GVT');
                    END;
                    //SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Customer_Type,'<>%1','MISC.');
                    SalesInvoicedDetails.OPEN;
                    WHILE SalesInvoicedDetails.READ DO BEGIN
                        //   MTD += SalesInvoicedDetails.Sum_Tax_Base_Amount;
                        MTDQty += SalesInvoicedDetails.Sum_Quantity_Base;
                    END;
                    //Sales Return
                    CLEAR(SalesReturnJournalData);
                    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.AreaCode, '%1', "Matrix Master"."Type 1");
                    //SalesReturnJournalData.SETFILTER(SalesReturnJournalData.CustomerType,'<>%1&<>%2&<>%3&<>%4','MISC.','CKA','DIRECTPROJ','LEGAL');
                    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.CustomerType, '<>%1&<>%2&<>%3', 'GET', 'PET', 'SET');
                    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.PostingDateFilter, '%1..%2', CALCDATE('-CM', AsonDate - 1), AsonDate - 1);
                    IF QuantitativeReport THEN
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code, '%1', 'M001')
                    ELSE
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code, '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                    IF QuantitativeReport THEN BEGIN
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.TabProdGrp, '%1', 'GVT');
                    END;
                    //SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Customer_Type,'<>%1','MISC.');
                    SalesReturnJournalData.OPEN;
                    WHILE SalesReturnJournalData.READ DO BEGIN
                        MTD -= SalesReturnJournalData.LineAmount;
                        MTDQty -= SalesReturnJournalData.Quantity_Base;
                    END;


                    CLEAR(SalesInvoicedDetails);
                    SalesInvoicedDetails.SETFILTER(Area_Code, '%1', "Matrix Master"."Type 1");
                    //SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Customer_Type,'<>%1&<>%2&<>%3&<>%4','MISC.','CKA','DIRECTPROJ','LEGAL');
                    SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Customer_Type, '<>%1&<>%2&<>%3', 'GET', 'PET', 'SET');
                    SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Releasing_Date, '%1..%2', AsonDate - 30, AsonDate);
                    IF QuantitativeReport THEN
                        SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Item_Category_Code, '%1', 'M001')
                    ELSE
                        SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Item_Category_Code, '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                    IF QuantitativeReport THEN BEGIN
                        SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.TabProdGrpFilter, '%1', 'GVT');
                    END;

                    SalesInvoicedDetails.OPEN;
                    WHILE SalesInvoicedDetails.READ DO BEGIN
                        IF (DT2DATE(SalesInvoicedDetails.Make_Order_Date) = AsonDate - 3) THEN BEGIN
                            //  InvBookedAmt[1] += SalesInvoicedDetails.Sum_Tax_Base_Amount;
                            InvBookedQty[1] += SalesInvoicedDetails.Sum_Quantity_Base;
                        END;
                        IF (DT2DATE(SalesInvoicedDetails.Make_Order_Date) = AsonDate - 2) THEN BEGIN
                            //  InvBookedAmt[2] += SalesInvoicedDetails.Sum_Tax_Base_Amount;
                            InvBookedQty[2] += SalesInvoicedDetails.Sum_Quantity_Base;
                        END;
                        IF (DT2DATE(SalesInvoicedDetails.Make_Order_Date) = AsonDate - 1) THEN BEGIN
                            //   InvBookedAmt[3] += SalesInvoicedDetails.Sum_Tax_Base_Amount;
                            InvBookedQty[3] += SalesInvoicedDetails.Sum_Quantity_Base;
                        END;
                        IF SalesInvoicedDetails.Location_Code = 'DP-MORBI' THEN
                            InvReleaseDate := SalesInvoicedDetails.OrderProcessingDate
                        ELSE
                            InvReleaseDate := SalesInvoicedDetails.Releasing_Date;

                        IF InvReleaseDate = AsonDate - 3 THEN BEGIN
                            //   InvOrderAmt[1] += SalesInvoicedDetails.Sum_Tax_Base_Amount;
                            InvOrderQty[1] += SalesInvoicedDetails.Sum_Quantity_Base;
                        END;
                        IF InvReleaseDate = AsonDate - 2 THEN BEGIN
                            //  InvOrderAmt[2] += SalesInvoicedDetails.Sum_Tax_Base_Amount;
                            InvOrderQty[2] += SalesInvoicedDetails.Sum_Quantity_Base;
                        END;
                        IF InvReleaseDate = AsonDate - 1 THEN BEGIN
                            //  InvOrderAmt[3] += SalesInvoicedDetails.Sum_Tax_Base_Amount;
                            InvOrderQty[3] += SalesInvoicedDetails.Sum_Quantity_Base;
                        END;
                    END;
                END ELSE BEGIN
                    IF QuantitativeReport THEN BEGIN
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.TabProdGrpFilter, '%1', 'GVT');
                    END;
                    //SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Customer_Type,'%1|%2|%3','CKA','DIRECTPROJ','MISC.');
                    SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Customer_Type, '%1|%2|%3', 'GET', 'SET', 'PET');
                    //SalesOrdersDetails.SETFILTER(SalesOrdersDetails.AreaFilter,'%1',"Matrix Master"."Type 1");
                    IF QuantitativeReport THEN
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Item_Category_Code, '%1', 'M001')
                    ELSE
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Item_Category_Code, '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                    SalesOrdersDetails.OPEN;
                    WHILE SalesOrdersDetails.READ DO BEGIN
                        IF SalesOrdersDetails.Location_Code <> 'DP-MORBI' THEN BEGIN
                            OrderReleaseDate := SalesOrdersDetails.Releasing_Date;
                            IF SalesOrdersDetails.Status = SalesOrdersDetails.Status::Released THEN BEGIN
                                ReleaseOrdersAmt += SalesOrdersDetails.Sum_Outstanding_Amount;
                                ReleaseOrdersQty += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END ELSE BEGIN
                                OpenOrdersAmt += SalesOrdersDetails.Sum_Outstanding_Amount;
                                OpenOrdersQty += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END;
                        END ELSE BEGIN
                            OrderReleaseDate := SalesOrdersDetails.OrderProcessDate;
                            IF SalesOrdersDetails.OrderProcessDate <> 0D THEN BEGIN

                                ReleaseOrdersAmt += SalesOrdersDetails.Sum_Outstanding_Amount;
                                ReleaseOrdersQty += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END ELSE BEGIN
                                OpenOrdersAmt += SalesOrdersDetails.Sum_Outstanding_Amount;
                                OpenOrdersQty += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END;

                        END;
                        CASE DT2DATE(SalesOrdersDetails.Make_Order_Date) OF
                            AsonDate - 3:
                                BEGIN
                                    OrderBookedQty[1] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                    OrderBookedAmt[1] += SalesOrdersDetails.Sum_Outstanding_Amount;
                                END;
                            AsonDate - 2:
                                BEGIN
                                    OrderBookedQty[2] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                    OrderBookedAmt[2] += SalesOrdersDetails.Sum_Outstanding_Amount;
                                END;
                            AsonDate - 1:
                                BEGIN
                                    OrderBookedQty[3] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                    OrderBookedAmt[3] += SalesOrdersDetails.Sum_Outstanding_Amount;
                                END;
                        END;
                        CASE OrderReleaseDate OF
                            AsonDate - 3:
                                BEGIN
                                    OrderReleasedQty[1] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                    OrderReleasedAmt[1] += SalesOrdersDetails.Sum_Outstanding_Amount;
                                END;
                            AsonDate - 2:
                                BEGIN
                                    OrderReleasedQty[2] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                    OrderReleasedAmt[2] += SalesOrdersDetails.Sum_Outstanding_Amount;
                                END;
                            AsonDate - 1:
                                BEGIN
                                    OrderReleasedQty[3] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                    OrderReleasedAmt[3] += SalesOrdersDetails.Sum_Outstanding_Amount;
                                END;
                        END;
                    END;
                    //FTD Start
                    CLEAR(SalesInvoicedDetails);
                    //SalesInvoicedDetails.SETFILTER(Area_Code,'%1',"Matrix Master"."Type 1");
                    SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Customer_Type, '%1|%2|%3', 'GET', 'SET', 'PET');
                    SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.PostingDateFilter, '%1..%2', AsonDate - 1, AsonDate - 1);
                    IF QuantitativeReport THEN
                        SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Item_Category_Code, '%1', 'M001')
                    ELSE
                        SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Item_Category_Code, '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                    IF QuantitativeReport THEN BEGIN
                        SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.TabProdGrpFilter, '%1', 'GVT');
                    END;
                    //SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Customer_Type,'<>%1','MISC.');
                    SalesInvoicedDetails.OPEN;
                    WHILE SalesInvoicedDetails.READ DO BEGIN
                        //   FTD += SalesInvoicedDetails.Sum_Tax_Base_Amount;
                        FTDQty += SalesInvoicedDetails.Sum_Quantity_Base;
                    END;
                    //Sales Return
                    CLEAR(SalesReturnJournalData);
                    //SalesReturnJournalData.SETFILTER(SalesReturnJournalData.AreaCode,'%1',"Matrix Master"."Type 1");
                    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.CustomerType, '%1|%2|%3', 'GET', 'SET', 'PET');
                    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.PostingDateFilter, '%1..%2', AsonDate - 1, AsonDate - 1);
                    IF QuantitativeReport THEN
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code, '%1', 'M001')
                    ELSE
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code, '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                    IF QuantitativeReport THEN BEGIN
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.TabProdGrp, '%1', 'GVT');
                    END;
                    //SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Customer_Type,'<>%1','MISC.');
                    SalesReturnJournalData.OPEN;
                    WHILE SalesReturnJournalData.READ DO BEGIN
                        FTD -= SalesReturnJournalData.LineAmount;
                        FTDQty -= SalesReturnJournalData.Quantity_Base;
                    END;
                    //FTD End

                    //FTD Start
                    //FTD End

                    CLEAR(SalesInvoicedDetails);
                    //SalesInvoicedDetails.SETFILTER(Area_Code,'%1',"Matrix Master"."Type 1");
                    SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Customer_Type, '%1|%2|%3', 'GET', 'SET', 'PET');
                    SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.PostingDateFilter, '%1..%2', CALCDATE('-CM', AsonDate - 1), AsonDate - 1);
                    IF QuantitativeReport THEN
                        SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Item_Category_Code, '%1', 'M001')
                    ELSE
                        SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Item_Category_Code, '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                    IF QuantitativeReport THEN BEGIN
                        SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.TabProdGrpFilter, '%1', 'GVT');
                    END;
                    //SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Customer_Type,'<>%1','MISC.');
                    SalesInvoicedDetails.OPEN;
                    WHILE SalesInvoicedDetails.READ DO BEGIN
                        //  MTD += SalesInvoicedDetails.Sum_Tax_Base_Amount;
                        MTDQty += SalesInvoicedDetails.Sum_Quantity_Base;
                    END;
                    //Sales Return
                    CLEAR(SalesReturnJournalData);
                    //SalesReturnJournalData.SETFILTER(SalesReturnJournalData.AreaCode,'%1',"Matrix Master"."Type 1");
                    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.CustomerType, '%1|%2|%3', 'GET', 'SET', 'PET');
                    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.PostingDateFilter, '%1..%2', CALCDATE('-CM', AsonDate - 1), AsonDate - 1);
                    IF QuantitativeReport THEN
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code, '%1', 'M001')
                    ELSE
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code, '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                    IF QuantitativeReport THEN BEGIN
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.TabProdGrp, '%1', 'GVT');
                    END;
                    //SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Customer_Type,'<>%1','MISC.');
                    SalesReturnJournalData.OPEN;
                    WHILE SalesReturnJournalData.READ DO BEGIN
                        MTD -= SalesReturnJournalData.LineAmount;
                        MTDQty -= SalesReturnJournalData.Quantity_Base;
                    END;


                    CLEAR(SalesInvoicedDetails);
                    //SalesInvoicedDetails.SETFILTER(Area_Code,'%1',"Matrix Master"."Type 1");
                    SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Customer_Type, '%1|%2|%3', 'GET', 'SET', 'PET');
                    SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Releasing_Date, '%1..%2', AsonDate - 30, AsonDate);
                    IF QuantitativeReport THEN
                        SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Item_Category_Code, '%1', 'M001')
                    ELSE
                        SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Item_Category_Code, '%1|%2|%3|%4', 'M001', 'T001', 'D001', 'H001');
                    IF QuantitativeReport THEN BEGIN
                        SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.TabProdGrpFilter, '%1', 'GVT');
                    END;
                    SalesInvoicedDetails.OPEN;
                    WHILE SalesInvoicedDetails.READ DO BEGIN
                        IF (DT2DATE(SalesInvoicedDetails.Make_Order_Date) = AsonDate - 3) THEN BEGIN
                            //  InvBookedAmt[1] += SalesInvoicedDetails.Sum_Tax_Base_Amount;
                            InvBookedQty[1] += SalesInvoicedDetails.Sum_Quantity_Base;
                        END;
                        IF (DT2DATE(SalesInvoicedDetails.Make_Order_Date) = AsonDate - 2) THEN BEGIN
                            //  InvBookedAmt[2] += SalesInvoicedDetails.Sum_Tax_Base_Amount;
                            InvBookedQty[2] += SalesInvoicedDetails.Sum_Quantity_Base;
                        END;
                        IF (DT2DATE(SalesInvoicedDetails.Make_Order_Date) = AsonDate - 1) THEN BEGIN
                            //  InvBookedAmt[3] += SalesInvoicedDetails.Sum_Tax_Base_Amount;
                            InvBookedQty[3] += SalesInvoicedDetails.Sum_Quantity_Base;
                        END;
                        IF SalesInvoicedDetails.Location_Code = 'DP-MORBI' THEN
                            InvReleaseDate := SalesInvoicedDetails.OrderProcessingDate
                        ELSE
                            InvReleaseDate := SalesInvoicedDetails.Releasing_Date;

                        IF InvReleaseDate = AsonDate - 3 THEN BEGIN
                            // InvOrderAmt[1] += SalesInvoicedDetails.Sum_Tax_Base_Amount;
                            InvOrderQty[1] += SalesInvoicedDetails.Sum_Quantity_Base;
                        END;
                        IF InvReleaseDate = AsonDate - 2 THEN BEGIN
                            //   InvOrderAmt[2] += SalesInvoicedDetails.Sum_Tax_Base_Amount;
                            InvOrderQty[2] += SalesInvoicedDetails.Sum_Quantity_Base;
                        END;
                        IF InvReleaseDate = AsonDate - 1 THEN BEGIN
                            //  InvOrderAmt[3] += SalesInvoicedDetails.Sum_Tax_Base_Amount;
                            InvOrderQty[3] += SalesInvoicedDetails.Sum_Quantity_Base;
                        END;
                    END;
                END;
                IF "Matrix Master"."Type 1" = 'CKA' THEN BEGIN
                    Customer.RESET;
                    Customer.SETCURRENTKEY("Tableau Zone");
                    Customer.SETRANGE("Tableau Zone", 'Enterprise');
                    IF Customer.FINDFIRST THEN BEGIN
                        REPEAT
                            Customer.CALCFIELDS(Balance);
                            IF Customer.Balance > 0 THEN
                                OutStandingAmt += Customer.Balance;
                            Sales += Calculatesales(Customer."No.", AsonDate - 90, AsonDate - 1);
                        UNTIL Customer.NEXT = 0;
                    END;
                END ELSE BEGIN
                    Customer.RESET;
                    Customer.SETCURRENTKEY("Area Code");
                    Customer.SETFILTER("Area Code", '%1', "Matrix Master"."Type 1");
                    Customer.SETFILTER("Tableau Zone", '<>%1', 'Enterprise');
                    IF Customer.FINDFIRST THEN BEGIN
                        REPEAT
                            Customer.CALCFIELDS(Balance);
                            IF Customer.Balance > 0 THEN
                                OutStandingAmt += Customer.Balance;
                            Sales += Calculatesales(Customer."No.", AsonDate - 90, AsonDate - 1);
                        UNTIL Customer.NEXT = 0;
                    END;
                END;
                DSO := CalculateDSO(OutStandingAmt, Sales, 90);

                //Keshav22072020'Valencica'
                CLEAR(decOpnOrderOtstnd);
                CLEAR(decMTDDesp);
                CLEAR(decMTDRet);
                CLEAR(decFTDRet);
                CLEAR(decFTDDesp);

                IF (QuantitativeReport) THEN BEGIN
                    IF ("Matrix Master"."Type 1" <> 'CKA') THEN BEGIN
                        tempMatrixMaster.DELETEALL;
                        tempMatrixMaster.TRANSFERFIELDS("Matrix Master");
                        IF "Matrix Master".Hide = TRUE THEN BEGIN
                            tempMatrixMaster.Description := 'Others';
                            tempMatrixMaster."Type 1" := '';
                            tempMatrixMaster."Description 2" := 'Others';
                        END;
                        tempMatrixMaster.INSERT;

                        CLEAR(SalesOrdersDetails);
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.AreaFilter, '%1', "Matrix Master"."Type 1");
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Document_Type, '%1', SalesOrdersDetails.Document_Type::Order);
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.StatusFilter, '%1', SalesOrdersDetails.StatusFilter::Released);
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Item_Category_Code, '%1', 'M001');
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Customer_Type, '<>%1&<>%2&<>%3', 'GET', 'PET', 'SET');
                        // SalesOrdersDetails.SETRANGE(salesordersdetails.Tableau_Product_Group,'GVT');
                        SalesOrdersDetails.OPEN;
                        WHILE SalesOrdersDetails.READ DO BEGIN
                            IF (SalesOrdersDetails.Size_Code_Desc = '600X600') AND (SalesOrdersDetails.Tableau_Product_Group = 'GVT') THEN BEGIN
                                decOpnOrderOtstnd[1] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END ELSE
                                IF (SalesOrdersDetails.Size_Code_Desc = '600X1200') AND (SalesOrdersDetails.Tableau_Product_Group = 'GVT') THEN BEGIN
                                    decOpnOrderOtstnd[2] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                END ELSE
                                    IF (SalesOrdersDetails.NPD = 'Valencica') OR (SalesOrdersDetails.NPD = 'Valencica R3') THEN BEGIN
                                        decOpnOrderOtstnd[3] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                    END ELSE
                                        IF (SalesOrdersDetails.Tableau_Product_Group = 'FBVT') AND (SalesOrdersDetails.Size_Code_Desc = '600X600') THEN BEGIN
                                            decOpnOrderOtstnd[4] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                        END ELSE
                                            IF (SalesOrdersDetails.Type_Catogery_Code = '75') AND (SalesOrdersDetails.Size_Code_Desc = '400X400') THEN BEGIN
                                                decOpnOrderOtstnd[5] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                            END ELSE
                                                IF SalesOrdersDetails.NPD = 'Sparkle' THEN BEGIN
                                                    decOpnOrderOtstnd[7] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                                END ELSE
                                                    IF SalesOrdersDetails.NPD = 'HDP Elev 12X24' THEN BEGIN
                                                        decOpnOrderOtstnd[8] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                                    END ELSE
                                                        IF SalesOrdersDetails.NPD = 'HDP Elev 12X18' THEN BEGIN
                                                            decOpnOrderOtstnd[10] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                                        END ELSE
                                                            //16767 IF ((SalesOrdersDetails.Type_Catogery_Code = '75') OR (SalesOrdersDetails.Type_Catogery_Code = '35')) AND (SalesOrdersDetails.Size_Code_Desc = '300X300') THEN BEGIN
                                                            IF (SalesOrdersDetails.NPD = 'Skd 1X1 Paver') AND (SalesOrdersDetails.Size_Code_Desc = '300X300') THEN BEGIN
                                                                decOpnOrderOtstnd[9] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                                            END;
                            IF (SalesOrdersDetails.Tableau_Product_Group = 'GVT') THEN BEGIN
                                decOpnOrderOtstnd[6] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END;
                        END;

                        CLEAR(SalesJournalData);
                        SalesJournalData.SETFILTER(SalesJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                        SalesJournalData.SETFILTER(SalesJournalData.Item_Category_Code_Filter, '%1', 'M001');
                        SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', CALCDATE('-CM', AsonDate - 1), AsonDate - 1);
                        SalesJournalData.SETFILTER(SalesJournalData.CustomerType, '<>%1&<>%2&<>%3', 'GET', 'PET', 'SET');
                        SalesJournalData.OPEN;
                        WHILE SalesJournalData.READ DO BEGIN
                            IF (SalesJournalData.Size_Code_Desc_Filter = '600X600') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decMTDDesp[1] += SalesJournalData.Quantity_in_Sq_Mt;
                                CalculateCustomerCount(SalesJournalData.CustomerNo, 1, 1);
                                CalculateItemCount(SalesJournalData.ItemNo, 1, 1);
                            END ELSE
                                IF (SalesJournalData.Size_Code_Desc_Filter = '600X1200') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                    decMTDDesp[2] += SalesJournalData.Quantity_in_Sq_Mt;
                                    CalculateCustomerCount(SalesJournalData.CustomerNo, 2, 1);
                                    CalculateItemCount(SalesJournalData.ItemNo, 2, 1);
                                END ELSE
                                    IF (SalesJournalData.Item_npd = 'Valencica') OR (SalesJournalData.Item_npd = 'Valencica R3') THEN BEGIN
                                        decMTDDesp[3] += SalesJournalData.Quantity_in_Sq_Mt;
                                        CalculateCustomerCount(SalesJournalData.CustomerNo, 3, 1);
                                        CalculateItemCount(SalesJournalData.ItemNo, 3, 1);
                                    END ELSE
                                        IF (SalesJournalData.TabProdGrp = 'FBVT') AND (SalesJournalData.Size_Code_Desc_Filter = '600X600') THEN BEGIN
                                            decMTDDesp[4] += SalesJournalData.Quantity_in_Sq_Mt;
                                            CalculateCustomerCount(SalesJournalData.CustomerNo, 4, 1);
                                            CalculateItemCount(SalesJournalData.ItemNo, 4, 1);
                                        END ELSE
                                            IF (SalesJournalData.TypeCatCode = '75') AND (SalesJournalData.Size_Code_Desc_Filter = '400X400') THEN BEGIN
                                                decMTDDesp[5] += SalesJournalData.Quantity_in_Sq_Mt;
                                                CalculateCustomerCount(SalesJournalData.CustomerNo, 5, 1);
                                                CalculateItemCount(SalesJournalData.ItemNo, 5, 1);
                                            END ELSE
                                                IF SalesJournalData.Item_npd = 'Sparkle' THEN BEGIN
                                                    decMTDDesp[7] += SalesJournalData.Quantity_in_Sq_Mt;
                                                    CalculateCustomerCount(SalesJournalData.CustomerNo, 7, 1);
                                                    CalculateItemCount(SalesJournalData.ItemNo, 7, 1);
                                                END ELSE
                                                    IF SalesJournalData.Item_npd = 'HDP Elev 12X24' THEN BEGIN
                                                        decMTDDesp[8] += SalesJournalData.Quantity_in_Sq_Mt;
                                                        CalculateCustomerCount(SalesJournalData.CustomerNo, 8, 1);
                                                        CalculateItemCount(SalesJournalData.ItemNo, 8, 1);
                                                    END ELSE
                                                        IF SalesJournalData.Item_npd = 'HDP Elev 12X18' THEN BEGIN
                                                            decMTDDesp[10] += SalesJournalData.Quantity_in_Sq_Mt;
                                                            CalculateCustomerCount(SalesJournalData.CustomerNo, 10, 1);
                                                            CalculateItemCount(SalesJournalData.ItemNo, 10, 1);
                                                        END ELSE
                                                            //16767 IF ((SalesJournalData.TypeCatCode = '75') OR (SalesJournalData.TypeCatCode = '35')) AND (SalesJournalData.Size_Code_Desc_Filter = '300X300') THEN BEGIN
                                                            IF (SalesJournalData.Item_npd = 'Skd 1X1 Paver') AND (SalesJournalData.Size_Code_Desc_Filter = '300X300') THEN BEGIN
                                                                decMTDDesp[9] += SalesJournalData.Quantity_in_Sq_Mt;
                                                                CalculateCustomerCount(SalesJournalData.CustomerNo, 9, 1);
                                                                CalculateItemCount(SalesJournalData.ItemNo, 9, 1);
                                                            END;
                            IF (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decMTDDesp[6] += SalesJournalData.Quantity_in_Sq_Mt;
                                CalculateCustomerCount(SalesJournalData.CustomerNo, 6, 1);
                                CalculateItemCount(SalesJournalData.ItemNo, 6, 1);
                            END;
                        END;

                        CLEAR(SalesJournalData);
                        SalesJournalData.SETFILTER(SalesJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                        SalesJournalData.SETFILTER(SalesJournalData.Item_Category_Code_Filter, '%1', 'M001');
                        SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', AsonDate - 1, AsonDate - 1);
                        SalesJournalData.SETFILTER(SalesJournalData.CustomerType, '<>%1&<>%2&<>%3', 'GET', 'PET', 'SET');
                        SalesJournalData.OPEN;
                        WHILE SalesJournalData.READ DO BEGIN
                            IF (SalesJournalData.Size_Code_Desc_Filter = '600X600') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decFTDDesp[1] += SalesJournalData.Quantity_in_Sq_Mt;
                            END ELSE
                                IF (SalesJournalData.Size_Code_Desc_Filter = '600X1200') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                    decFTDDesp[2] += SalesJournalData.Quantity_in_Sq_Mt;
                                END ELSE
                                    IF (SalesJournalData.Item_npd = 'Valencica') OR (SalesJournalData.Item_npd = 'Valencica R3') THEN BEGIN
                                        decFTDDesp[3] += SalesJournalData.Quantity_in_Sq_Mt;
                                    END ELSE
                                        IF (SalesJournalData.TabProdGrp = 'FBVT') AND (SalesJournalData.Size_Code_Desc_Filter = '600X600') THEN BEGIN
                                            decFTDDesp[4] += SalesJournalData.Quantity_in_Sq_Mt;
                                        END ELSE
                                            IF (SalesJournalData.TypeCatCode = '75') AND (SalesJournalData.Size_Code_Desc_Filter = '400X400') THEN BEGIN
                                                decFTDDesp[5] += SalesJournalData.Quantity_in_Sq_Mt;
                                            END ELSE
                                                IF SalesJournalData.Item_npd = 'Sparkle' THEN BEGIN
                                                    decFTDDesp[7] += SalesJournalData.Quantity_in_Sq_Mt;
                                                END ELSE
                                                    IF SalesJournalData.Item_npd = 'HDP Elev 12X24' THEN BEGIN
                                                        decFTDDesp[8] += SalesJournalData.Quantity_in_Sq_Mt;
                                                    END ELSE
                                                        IF SalesJournalData.Item_npd = 'HDP Elev 12X18' THEN BEGIN
                                                            decFTDDesp[10] += SalesJournalData.Quantity_in_Sq_Mt;
                                                        END ELSE
                                                            //16767   IF ((SalesJournalData.TypeCatCode = '75') OR (SalesJournalData.TypeCatCode = '35')) AND (SalesJournalData.Size_Code_Desc_Filter = '300X300') THEN BEGIN
                                                            IF (SalesJournalData.Item_npd = 'Skd 1X1 Paver') AND (SalesJournalData.Size_Code_Desc_Filter = '300X300') THEN BEGIN
                                                                decFTDDesp[9] += SalesJournalData.Quantity_in_Sq_Mt;
                                                            END;
                            IF (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decFTDDesp[6] += SalesJournalData.Quantity_in_Sq_Mt;
                            END;
                        END;

                        CLEAR(SalesReturnJournalData);
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code_Filter, '%1', 'M001');
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.PostingDateFilter, '%1..%2', CALCDATE('-CM', AsonDate - 1), AsonDate - 1);
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.CustomerType, '<>%1', 'CKA');
                        SalesReturnJournalData.OPEN;
                        WHILE SalesReturnJournalData.READ DO BEGIN
                            IF (SalesReturnJournalData.Size_Code_Desc = '600X600') AND (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decMTDRet[1] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END ELSE
                                IF (SalesReturnJournalData.Size_Code_Desc = '600X1200') AND (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                    decMTDRet[2] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                END ELSE
                                    IF (SalesReturnJournalData.NPD = 'Valencica') OR (SalesReturnJournalData.NPD = 'Valencica R3') THEN BEGIN
                                        decMTDRet[3] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                    END ELSE
                                        IF (SalesReturnJournalData.TabProdGrp = 'FBVT') AND (SalesReturnJournalData.Size_Code_Desc = '600X600') THEN BEGIN
                                            decMTDRet[4] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                        END ELSE
                                            IF (SalesReturnJournalData.TypeCatCode = '75') AND (SalesReturnJournalData.Size_Code_Desc = '400X400') THEN BEGIN
                                                decMTDRet[5] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                            END ELSE
                                                IF SalesReturnJournalData.NPD = 'Sparkle' THEN BEGIN
                                                    decMTDRet[7] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                                END ELSE
                                                    IF SalesReturnJournalData.NPD = 'HDP Elev 12X24' THEN BEGIN
                                                        decMTDRet[8] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                                    END ELSE
                                                        IF SalesReturnJournalData.NPD = 'HDP Elev 12X18' THEN BEGIN
                                                            decMTDRet[10] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                                        END ELSE
                                                            //16767  IF ((SalesReturnJournalData.TypeCatCode = '75') OR (SalesReturnJournalData.TypeCatCode = '35')) AND (SalesReturnJournalData.Size_Code_Desc = '300X300') THEN BEGIN
                                                            IF (SalesReturnJournalData.NPD = 'Skd 1X1 Paver') AND (SalesReturnJournalData.Size_Code_Desc = '300X300') THEN BEGIN
                                                                decMTDRet[9] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                                            END;
                            IF (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decMTDRet[6] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                        END;
                        CLEAR(SalesReturnJournalData);
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code_Filter, '%1', 'M001');
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.PostingDateFilter, '%1..%2', AsonDate - 1, AsonDate - 1);
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.CustomerType, '<>%1&<>%2&<>%3', 'GET', 'PET', 'SET');
                        SalesReturnJournalData.OPEN;
                        WHILE SalesReturnJournalData.READ DO BEGIN
                            IF (SalesReturnJournalData.Size_Code_Desc = '600X600') AND (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decFTDRet[1] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END ELSE
                                IF (SalesReturnJournalData.Size_Code_Desc = '600X1200') AND (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                    decFTDRet[2] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                END ELSE
                                    IF (SalesReturnJournalData.NPD = 'Valencica') OR (SalesReturnJournalData.NPD = 'Valencica R3') THEN BEGIN
                                        decFTDRet[3] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                    END ELSE
                                        IF (SalesReturnJournalData.TabProdGrp = 'FBVT') AND (SalesReturnJournalData.Size_Code_Desc = '600X600') THEN BEGIN
                                            decFTDRet[4] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                        END ELSE
                                            IF (SalesReturnJournalData.TypeCatCode = '75') AND (SalesReturnJournalData.Size_Code_Desc = '400X400') THEN BEGIN
                                                decFTDRet[5] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                            END ELSE
                                                IF SalesReturnJournalData.NPD = 'Sparkle' THEN BEGIN
                                                    decFTDRet[7] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                                END ELSE
                                                    IF SalesReturnJournalData.NPD = 'HDP Elev 12X24' THEN BEGIN
                                                        decFTDRet[8] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                                    END ELSE
                                                        IF SalesReturnJournalData.NPD = 'HDP Elev 12X18' THEN BEGIN
                                                            decFTDRet[10] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                                        END ELSE
                                                            //16767  IF ((SalesReturnJournalData.TypeCatCode = '75') OR (SalesReturnJournalData.TypeCatCode = '35')) AND (SalesReturnJournalData.Size_Code_Desc = '300X300') THEN BEGIN
                                                            IF (SalesReturnJournalData.NPD = 'Skd 1X1 Paver') AND (SalesReturnJournalData.Size_Code_Desc = '300X300') THEN BEGIN
                                                                decFTDRet[9] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                                            END;
                            IF (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decFTDRet[6] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                        END;
                    END ELSE BEGIN
                        tempMatrixMaster.DELETEALL;
                        tempMatrixMaster.TRANSFERFIELDS("Matrix Master");
                        IF "Matrix Master".Hide = TRUE THEN BEGIN
                            tempMatrixMaster.Description := 'Others';
                            tempMatrixMaster."Type 1" := '';
                            tempMatrixMaster."Description 2" := 'Others';
                        END;
                        tempMatrixMaster.INSERT;

                        CLEAR(SalesOrdersDetails);
                        //SalesOrdersDetails.SETFILTER(SalesOrdersDetails.AreaFilter,'%1',"Matrix Master"."Type 1");
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Document_Type, '%1', SalesOrdersDetails.Document_Type::Order);
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Customer_Type, '%1|%2|%3', 'GET', 'PET', 'SET');
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.StatusFilter, '%1', SalesOrdersDetails.StatusFilter::Released);
                        SalesOrdersDetails.SETFILTER(SalesOrdersDetails.Item_Category_Code, '%1', 'M001');
                        // SalesOrdersDetails.SETRANGE(salesordersdetails.Tableau_Product_Group,'GVT');
                        SalesOrdersDetails.OPEN;
                        WHILE SalesOrdersDetails.READ DO BEGIN
                            IF (SalesOrdersDetails.Size_Code_Desc = '600X600') AND (SalesOrdersDetails.Tableau_Product_Group = 'GVT') THEN BEGIN
                                decOpnOrderOtstnd[1] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END ELSE
                                IF (SalesOrdersDetails.Size_Code_Desc = '600X1200') AND (SalesOrdersDetails.Tableau_Product_Group = 'GVT') THEN BEGIN
                                    decOpnOrderOtstnd[2] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                END ELSE
                                    IF (SalesOrdersDetails.NPD = 'Valencica') OR (SalesOrdersDetails.NPD = 'Valencica R3') THEN BEGIN
                                        decOpnOrderOtstnd[3] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                    END ELSE
                                        IF (SalesOrdersDetails.Tableau_Product_Group = 'FBVT') AND (SalesOrdersDetails.Size_Code_Desc = '600X600') THEN BEGIN
                                            decOpnOrderOtstnd[4] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                        END ELSE
                                            IF (SalesOrdersDetails.Type_Catogery_Code = '75') AND (SalesOrdersDetails.Size_Code_Desc = '400X400') THEN BEGIN
                                                decOpnOrderOtstnd[5] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                            END ELSE
                                                IF SalesOrdersDetails.NPD = 'Sparkle' THEN BEGIN
                                                    decOpnOrderOtstnd[7] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                                END ELSE
                                                    IF SalesOrdersDetails.NPD = 'HDP Elev 12X24' THEN BEGIN
                                                        decOpnOrderOtstnd[8] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                                    END ELSE
                                                        IF SalesOrdersDetails.NPD = 'HDP Elev 12X18' THEN BEGIN
                                                            decOpnOrderOtstnd[10] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                                        END ELSE
                                                            //16767 IF ((SalesOrdersDetails.Type_Catogery_Code = '75') OR (SalesOrdersDetails.Type_Catogery_Code = '35')) AND (SalesOrdersDetails.Size_Code_Desc = '300X300') THEN BEGIN
                                                            IF (SalesOrdersDetails.NPD = 'Skd 1X1 Paver') AND (SalesOrdersDetails.Size_Code_Desc = '300X300') THEN BEGIN
                                                                decOpnOrderOtstnd[9] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                                                            END;
                            IF (SalesOrdersDetails.Tableau_Product_Group = 'GVT') THEN BEGIN
                                decOpnOrderOtstnd[6] += SalesOrdersDetails.Sum_Outstanding_Qty_Base;
                            END;
                        END;

                        CLEAR(SalesJournalData);
                        //SalesJournalData.SETFILTER(SalesJournalData.AreaFilter,'%1',"Matrix Master"."Type 1");
                        SalesJournalData.SETFILTER(SalesJournalData.Item_Category_Code_Filter, '%1', 'M001');
                        SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', CALCDATE('-CM', AsonDate - 1), AsonDate - 1);
                        SalesJournalData.SETFILTER(SalesJournalData.CustomerType, '%1|%2|%3', 'GET', 'PET', 'SET');
                        SalesJournalData.OPEN;
                        WHILE SalesJournalData.READ DO BEGIN
                            IF (SalesJournalData.Size_Code_Desc_Filter = '600X600') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decMTDDesp[1] += SalesJournalData.Quantity_in_Sq_Mt;
                                CalculateCustomerCount(SalesJournalData.CustomerNo, 1, 1);
                                CalculateItemCount(SalesJournalData.ItemNo, 1, 1);
                            END ELSE
                                IF (SalesJournalData.Size_Code_Desc_Filter = '600X1200') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                    decMTDDesp[2] += SalesJournalData.Quantity_in_Sq_Mt;
                                    CalculateCustomerCount(SalesJournalData.CustomerNo, 2, 1);
                                    CalculateItemCount(SalesJournalData.ItemNo, 2, 1);
                                END ELSE
                                    IF (SalesJournalData.Item_npd = 'Valencica') OR (SalesJournalData.Item_npd = 'Valencica R3') THEN BEGIN
                                        decMTDDesp[3] += SalesJournalData.Quantity_in_Sq_Mt;
                                        CalculateCustomerCount(SalesJournalData.CustomerNo, 3, 1);
                                        CalculateItemCount(SalesJournalData.ItemNo, 3, 1);
                                    END ELSE
                                        IF (SalesJournalData.TabProdGrp = 'FBVT') AND (SalesJournalData.Size_Code_Desc_Filter = '600X600') THEN BEGIN
                                            decMTDDesp[4] += SalesJournalData.Quantity_in_Sq_Mt;
                                            CalculateCustomerCount(SalesJournalData.CustomerNo, 4, 1);
                                            CalculateItemCount(SalesJournalData.ItemNo, 4, 1);
                                        END ELSE
                                            IF (SalesJournalData.TypeCatCode = '75') AND (SalesJournalData.Size_Code_Desc_Filter = '400X400') THEN BEGIN
                                                decMTDDesp[5] += SalesJournalData.Quantity_in_Sq_Mt;
                                                CalculateCustomerCount(SalesJournalData.CustomerNo, 5, 1);
                                                CalculateItemCount(SalesJournalData.ItemNo, 5, 1);
                                            END ELSE
                                                IF SalesJournalData.Item_npd = 'Sparkle' THEN BEGIN
                                                    decMTDDesp[7] += SalesJournalData.Quantity_in_Sq_Mt;
                                                    CalculateCustomerCount(SalesJournalData.CustomerNo, 7, 1);
                                                    CalculateItemCount(SalesJournalData.ItemNo, 7, 1);
                                                END ELSE
                                                    IF SalesJournalData.Item_npd = 'HDP Elev 12X24' THEN BEGIN
                                                        decMTDDesp[8] += SalesJournalData.Quantity_in_Sq_Mt;
                                                        CalculateCustomerCount(SalesJournalData.CustomerNo, 8, 1);
                                                        CalculateItemCount(SalesJournalData.ItemNo, 8, 1);
                                                    END ELSE
                                                        IF SalesJournalData.Item_npd = 'HDP Elev 12X18' THEN BEGIN
                                                            decMTDDesp[10] += SalesJournalData.Quantity_in_Sq_Mt;
                                                            CalculateCustomerCount(SalesJournalData.CustomerNo, 10, 1);
                                                            CalculateItemCount(SalesJournalData.ItemNo, 10, 1);
                                                        END ELSE
                                                            //16767 IF ((SalesJournalData.TypeCatCode = '75') OR (SalesJournalData.TypeCatCode = '35')) AND (SalesJournalData.Size_Code_Desc_Filter = '300X300') THEN BEGIN
                                                            IF (SalesJournalData.Item_npd = 'Skd 1X1 Paver') AND (SalesJournalData.Size_Code_Desc_Filter = '300X300') THEN BEGIN
                                                                decMTDDesp[9] += SalesJournalData.Quantity_in_Sq_Mt;
                                                                CalculateCustomerCount(SalesJournalData.CustomerNo, 9, 1);
                                                                CalculateItemCount(SalesJournalData.ItemNo, 9, 1);
                                                            END;
                            IF (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decMTDDesp[6] += SalesJournalData.Quantity_in_Sq_Mt;
                                CalculateCustomerCount(SalesJournalData.CustomerNo, 6, 1);
                                CalculateItemCount(SalesJournalData.ItemNo, 6, 1);
                            END;
                        END;

                        CLEAR(SalesJournalData);
                        //SalesJournalData.SETFILTER(SalesJournalData.AreaFilter,'%1',"Matrix Master"."Type 1");
                        SalesJournalData.SETFILTER(SalesJournalData.Item_Category_Code_Filter, '%1', 'M001');
                        SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', AsonDate - 1, AsonDate - 1);
                        SalesJournalData.SETFILTER(SalesJournalData.CustomerType, '%1|%2|%3', 'GET', 'PET', 'SET');
                        SalesJournalData.OPEN;
                        WHILE SalesJournalData.READ DO BEGIN
                            IF (SalesJournalData.Size_Code_Desc_Filter = '600X600') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decFTDDesp[1] += SalesJournalData.Quantity_in_Sq_Mt;
                            END ELSE
                                IF (SalesJournalData.Size_Code_Desc_Filter = '600X1200') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                    decFTDDesp[2] += SalesJournalData.Quantity_in_Sq_Mt;
                                END ELSE
                                    IF (SalesJournalData.Item_npd = 'Valencica') OR (SalesJournalData.Item_npd = 'Valencica R3') THEN BEGIN
                                        decFTDDesp[3] += SalesJournalData.Quantity_in_Sq_Mt;
                                    END ELSE
                                        IF (SalesJournalData.TabProdGrp = 'FBVT') AND (SalesJournalData.Size_Code_Desc_Filter = '600X600') THEN BEGIN
                                            decFTDDesp[4] += SalesJournalData.Quantity_in_Sq_Mt;
                                        END ELSE
                                            IF (SalesJournalData.TypeCatCode = '75') AND (SalesJournalData.Size_Code_Desc_Filter = '400X400') THEN BEGIN
                                                decFTDDesp[5] += SalesJournalData.Quantity_in_Sq_Mt;
                                            END ELSE
                                                IF SalesJournalData.Item_npd = 'Sparkle' THEN BEGIN
                                                    decFTDDesp[7] += SalesJournalData.Quantity_in_Sq_Mt;
                                                END ELSE
                                                    IF SalesJournalData.Item_npd = 'HDP Elev 12X24' THEN BEGIN
                                                        decFTDDesp[8] += SalesJournalData.Quantity_in_Sq_Mt;
                                                    END ELSE
                                                        IF SalesJournalData.Item_npd = 'HDP Elev 12X18' THEN BEGIN
                                                            decFTDDesp[10] += SalesJournalData.Quantity_in_Sq_Mt;
                                                        END ELSE
                                                            //16767 IF ((SalesJournalData.TypeCatCode = '75') OR (SalesJournalData.TypeCatCode = '35')) AND (SalesJournalData.Size_Code_Desc_Filter = '300X300') THEN BEGIN
                                                            IF (SalesJournalData.Item_npd = 'Skd 1X1 Paver') AND (SalesJournalData.Size_Code_Desc_Filter = '300X300') THEN BEGIN
                                                                decFTDDesp[9] += SalesJournalData.Quantity_in_Sq_Mt;
                                                            END;
                            IF (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decFTDDesp[6] += SalesJournalData.Quantity_in_Sq_Mt;
                            END;
                        END;

                        CLEAR(SalesReturnJournalData);
                        //SalesReturnJournalData.SETFILTER(SalesReturnJournalData.AreaFilter,'%1',"Matrix Master"."Type 1");
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code_Filter, '%1', 'M001');
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.PostingDateFilter, '%1..%2', CALCDATE('-CM', AsonDate - 1), AsonDate - 1);
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.CustomerType, '%1|%2|%3', 'GET', 'PET', 'SET');
                        SalesReturnJournalData.OPEN;
                        WHILE SalesReturnJournalData.READ DO BEGIN
                            IF (SalesReturnJournalData.Size_Code_Desc = '600X600') AND (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decMTDRet[1] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END ELSE
                                IF (SalesReturnJournalData.Size_Code_Desc = '600X1200') AND (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                    decMTDRet[2] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                END ELSE
                                    IF (SalesReturnJournalData.NPD = 'Valencica') OR (SalesReturnJournalData.NPD = 'Valencica R3') THEN BEGIN
                                        decMTDRet[3] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                    END ELSE
                                        IF (SalesReturnJournalData.TabProdGrp = 'FBVT') AND (SalesReturnJournalData.Size_Code_Desc = '600X600') THEN BEGIN
                                            decMTDRet[4] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                        END ELSE
                                            IF (SalesReturnJournalData.TypeCatCode = '75') AND (SalesReturnJournalData.Size_Code_Desc = '400X400') THEN BEGIN
                                                decMTDRet[5] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                            END ELSE
                                                IF SalesReturnJournalData.NPD = 'Sparkle' THEN BEGIN
                                                    decMTDRet[7] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                                END ELSE
                                                    IF SalesReturnJournalData.NPD = 'HDP Elev 12X24' THEN BEGIN
                                                        decMTDRet[8] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                                    END ELSE
                                                        IF SalesReturnJournalData.NPD = 'HDP Elev 12X18' THEN BEGIN
                                                            decMTDRet[10] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                                        END ELSE
                                                            //16767 IF ((SalesReturnJournalData.TypeCatCode = '75') OR (SalesReturnJournalData.TypeCatCode = '35')) AND (SalesReturnJournalData.Size_Code_Desc = '300X300') THEN BEGIN
                                                            IF (SalesReturnJournalData.NPD = 'Skd 1X1 Paver') AND (SalesReturnJournalData.Size_Code_Desc = '300X300') THEN BEGIN
                                                                decMTDRet[9] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                                            END;
                            IF (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decMTDRet[6] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                        END;

                        CLEAR(SalesReturnJournalData);
                        //SalesReturnJournalData.SETFILTER(SalesReturnJournalData.AreaFilter,'%1',"Matrix Master"."Type 1");
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code_Filter, '%1', 'M001');
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.PostingDateFilter, '%1..%2', AsonDate - 1, AsonDate - 1);
                        SalesReturnJournalData.SETFILTER(SalesReturnJournalData.CustomerType, '%1|%2|%3', 'GET', 'PET', 'SET');
                        SalesReturnJournalData.OPEN;
                        WHILE SalesReturnJournalData.READ DO BEGIN
                            IF (SalesReturnJournalData.Size_Code_Desc = '600X600') AND (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decFTDRet[1] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END ELSE
                                IF (SalesReturnJournalData.Size_Code_Desc = '600X1200') AND (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                    decFTDRet[2] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                END ELSE
                                    IF (SalesReturnJournalData.NPD = 'Valencica') OR (SalesReturnJournalData.NPD = 'Valencica R3') THEN BEGIN
                                        decFTDRet[3] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                    END ELSE
                                        IF (SalesReturnJournalData.TabProdGrp = 'FBVT') AND (SalesReturnJournalData.Size_Code_Desc = '600X600') THEN BEGIN
                                            decFTDRet[4] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                        END ELSE
                                            IF (SalesReturnJournalData.TypeCatCode = '75') AND (SalesReturnJournalData.Size_Code_Desc = '400X400') THEN BEGIN
                                                decFTDRet[5] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                            END ELSE
                                                IF SalesReturnJournalData.NPD = 'Sparkle' THEN BEGIN
                                                    decFTDRet[7] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                                END ELSE
                                                    IF SalesReturnJournalData.NPD = 'HDP Elev 12X24' THEN BEGIN
                                                        decFTDRet[8] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                                    END ELSE
                                                        IF SalesReturnJournalData.NPD = 'HDP Elev 12X18' THEN BEGIN
                                                            decFTDRet[10] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                                        END ELSE
                                                            //16767 IF ((SalesReturnJournalData.TypeCatCode = '75') OR (SalesReturnJournalData.TypeCatCode = '35')) AND (SalesReturnJournalData.Size_Code_Desc = '300X300') THEN BEGIN
                                                            IF (SalesReturnJournalData.NPD = 'Skd 1X1 Paver') AND (SalesReturnJournalData.Size_Code_Desc = '300X300') THEN BEGIN
                                                                decFTDRet[9] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                                            END;
                            IF (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decFTDRet[6] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END;
                        END;
                    END;
                    IF DATE2DMY(AsonDate, 2) < 4 THEN
                        intMinus := 1
                    ELSE
                        intMinus := 0;

                    CLEAR(SalesJournalData);
                    SalesJournalData.SETFILTER(SalesJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                    SalesJournalData.SETFILTER(SalesJournalData.Item_Category_Code_Filter, '%1', 'M001');
                    //SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter,'%1..%2',DMY2DATE(DATE2DMY(AsonDate-1,1),4,DATE2DMY(AsonDate-1,3)-intMinus),AsonDate-1);
                    SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', DMY2DATE(1, 4, DATE2DMY(AsonDate - 1, 3) - intMinus), AsonDate - 1);
                    //  SalesJournalData.SETFILTER(SalesJournalData.CustomerType,'<>%1','CKA');
                    SalesJournalData.OPEN;
                    WHILE SalesJournalData.READ DO BEGIN
                        IF (SalesJournalData.Size_Code_Desc_Filter = '600X600') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 1, 2);
                            CalculateItemCount(SalesJournalData.ItemNo, 1, 2);
                        END ELSE
                            IF (SalesJournalData.Size_Code_Desc_Filter = '600X1200') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                CalculateCustomerCount(SalesJournalData.CustomerNo, 2, 2);
                                CalculateItemCount(SalesJournalData.ItemNo, 2, 2);
                            END ELSE
                                IF (SalesJournalData.Item_npd = 'Valencica') OR (SalesJournalData.Item_npd = 'Valencica R3') THEN BEGIN
                                    CalculateCustomerCount(SalesJournalData.CustomerNo, 3, 2);
                                    CalculateItemCount(SalesJournalData.ItemNo, 3, 2);
                                END ELSE
                                    IF (SalesJournalData.TabProdGrp = 'FBVT') AND (SalesJournalData.Size_Code_Desc_Filter = '600X600') THEN BEGIN
                                        CalculateCustomerCount(SalesJournalData.CustomerNo, 4, 2);
                                        CalculateItemCount(SalesJournalData.ItemNo, 4, 2);
                                    END ELSE
                                        IF (SalesJournalData.TypeCatCode = '75') AND (SalesJournalData.Size_Code_Desc_Filter = '400X400') THEN BEGIN
                                            CalculateCustomerCount(SalesJournalData.CustomerNo, 5, 2);
                                            CalculateItemCount(SalesJournalData.ItemNo, 5, 2);
                                        END ELSE
                                            IF SalesJournalData.Item_npd = 'Sparkle' THEN BEGIN
                                                CalculateCustomerCount(SalesJournalData.CustomerNo, 7, 2);
                                                CalculateItemCount(SalesJournalData.ItemNo, 7, 2);
                                            END ELSE
                                                IF SalesJournalData.Item_npd = 'HDP Elev 12X24' THEN BEGIN
                                                    CalculateCustomerCount(SalesJournalData.CustomerNo, 8, 2);
                                                    CalculateItemCount(SalesJournalData.ItemNo, 8, 2);
                                                END ELSE
                                                    IF SalesJournalData.Item_npd = 'HDP Elev 12X18' THEN BEGIN
                                                        CalculateCustomerCount(SalesJournalData.CustomerNo, 10, 2);
                                                        CalculateItemCount(SalesJournalData.ItemNo, 10, 2);
                                                    END ELSE
                                                        //16767 IF ((SalesJournalData.TypeCatCode = '75') OR (SalesJournalData.TypeCatCode = '35')) AND (SalesJournalData.Size_Code_Desc_Filter = '300X300') THEN BEGIN
                                                        IF (SalesJournalData.Item_npd = 'Skd 1X1 Paver') AND (SalesJournalData.Size_Code_Desc_Filter = '300X300') THEN BEGIN
                                                            CalculateCustomerCount(SalesJournalData.CustomerNo, 9, 2);
                                                            CalculateItemCount(SalesJournalData.ItemNo, 9, 2);
                                                        END;
                        IF (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 6, 2);
                            CalculateItemCount(SalesJournalData.ItemNo, 6, 2);
                        END;
                    END;

                    CLEAR(SalesJournalData);
                    SalesJournalData.SETFILTER(SalesJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                    SalesJournalData.SETFILTER(SalesJournalData.Item_Category_Code_Filter, '%1', 'M001');
                    //SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter,'%1..%2',CALCDATE('-CM-1M',TODAY-1),DMY2DATE(DATE2DMY(AsonDate-1,1),DATE2DMY(AsonDate-1,2)-1,DATE2DMY(AsonDate-1,3)));
                    SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', LastMnthStDate, LastMnthEndDate);
                    SalesJournalData.OPEN;
                    WHILE SalesJournalData.READ DO BEGIN
                        IF (SalesJournalData.Size_Code_Desc_Filter = '600X600') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                            decLMTDDesp[1] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 1, 3);
                            CalculateItemCount(SalesJournalData.ItemNo, 1, 3);
                        END ELSE
                            IF (SalesJournalData.Size_Code_Desc_Filter = '600X1200') AND (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decLMTDDesp[2] += SalesJournalData.Quantity_in_Sq_Mt;
                                CalculateCustomerCount(SalesJournalData.CustomerNo, 2, 3);
                                CalculateItemCount(SalesJournalData.ItemNo, 2, 3);
                            END ELSE
                                IF (SalesJournalData.Item_npd = 'Valencica') OR (SalesJournalData.Item_npd = 'Valencica R3') THEN BEGIN
                                    decLMTDDesp[3] += SalesJournalData.Quantity_in_Sq_Mt;
                                    CalculateCustomerCount(SalesJournalData.CustomerNo, 3, 3);
                                    CalculateItemCount(SalesJournalData.ItemNo, 3, 3);
                                END ELSE
                                    IF (SalesJournalData.TabProdGrp = 'FBVT') AND (SalesJournalData.Size_Code_Desc_Filter = '600X600') THEN BEGIN
                                        decLMTDDesp[4] += SalesJournalData.Quantity_in_Sq_Mt;
                                        CalculateCustomerCount(SalesJournalData.CustomerNo, 4, 3);
                                        CalculateItemCount(SalesJournalData.ItemNo, 4, 3);
                                    END ELSE
                                        IF (SalesJournalData.TypeCatCode = '75') AND (SalesJournalData.Size_Code_Desc_Filter = '400X400') THEN BEGIN
                                            decLMTDDesp[5] += SalesJournalData.Quantity_in_Sq_Mt;
                                            CalculateCustomerCount(SalesJournalData.CustomerNo, 5, 3);
                                            CalculateItemCount(SalesJournalData.ItemNo, 5, 3);
                                            //item Count<<
                                        END ELSE
                                            IF SalesJournalData.Item_npd = 'Sparkle' THEN BEGIN
                                                decLMTDDesp[7] += SalesJournalData.Quantity_in_Sq_Mt;
                                                CalculateCustomerCount(SalesJournalData.CustomerNo, 7, 3);
                                                CalculateItemCount(SalesJournalData.ItemNo, 7, 3);
                                            END ELSE
                                                IF SalesJournalData.Item_npd = 'HDP Elev 12X24' THEN BEGIN
                                                    decLMTDDesp[8] += SalesJournalData.Quantity_in_Sq_Mt;
                                                    CalculateCustomerCount(SalesJournalData.CustomerNo, 8, 3);
                                                    CalculateItemCount(SalesJournalData.ItemNo, 8, 3);
                                                END ELSE
                                                    IF SalesJournalData.Item_npd = 'HDP Elev 12X18' THEN BEGIN
                                                        decLMTDDesp[10] += SalesJournalData.Quantity_in_Sq_Mt;
                                                        CalculateCustomerCount(SalesJournalData.CustomerNo, 10, 3);
                                                        CalculateItemCount(SalesJournalData.ItemNo, 10, 3);
                                                    END ELSE
                                                        //16767 IF ((SalesJournalData.TypeCatCode = '75') OR (SalesJournalData.TypeCatCode = '35')) AND (SalesJournalData.Size_Code_Desc_Filter = '300X300') THEN BEGIN
                                                        IF (SalesJournalData.Item_npd = 'Skd 1X1 Paver') AND (SalesJournalData.Size_Code_Desc_Filter = '300X300') THEN BEGIN
                                                            decLMTDDesp[9] += SalesJournalData.Quantity_in_Sq_Mt;
                                                            CalculateCustomerCount(SalesJournalData.CustomerNo, 9, 3);
                                                            CalculateItemCount(SalesJournalData.ItemNo, 9, 3);
                                                        END;
                        IF (SalesJournalData.TabProdGrp = 'GVT') THEN BEGIN
                            decLMTDDesp[6] += SalesJournalData.Quantity_in_Sq_Mt;
                            CalculateCustomerCount(SalesJournalData.CustomerNo, 6, 3);
                            CalculateItemCount(SalesJournalData.ItemNo, 6, 3);
                        END;
                    END;

                    CLEAR(SalesReturnJournalData);
                    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.AreaFilter, '%1', "Matrix Master"."Type 1");
                    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.Item_Category_Code_Filter, '%1', 'M001');
                    //SalesReturnJournalData.SETFILTER(SalesReturnJournalData.PostingDateFilter,'%1..%2',CALCDATE('-CM-1M',TODAY-1),DMY2DATE(DATE2DMY(AsonDate-1,1),DATE2DMY(AsonDate-1,2)-1,DATE2DMY(AsonDate-1,3)));
                    SalesReturnJournalData.SETFILTER(SalesReturnJournalData.PostingDateFilter, '%1..%2', LastMnthStDate, LastMnthEndDate);
                    SalesReturnJournalData.OPEN;
                    WHILE SalesReturnJournalData.READ DO BEGIN
                        IF (SalesReturnJournalData.Size_Code_Desc = '600X600') AND (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                            decLMTDret[1] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                        END ELSE
                            IF (SalesReturnJournalData.Size_Code_Desc = '600X1200') AND (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                                decLMTDret[2] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                            END ELSE
                                IF (SalesReturnJournalData.NPD = 'Valencica') OR (SalesReturnJournalData.NPD = 'Valencica R3') THEN BEGIN
                                    decLMTDret[3] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                END ELSE
                                    IF (SalesReturnJournalData.TabProdGrp = 'FBVT') AND (SalesReturnJournalData.Size_Code_Desc = '600X600') THEN BEGIN
                                        decLMTDret[4] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                    END ELSE
                                        IF (SalesReturnJournalData.TypeCatCode = '75') AND (SalesReturnJournalData.Size_Code_Desc = '400X400') THEN BEGIN
                                            decLMTDret[5] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                            //item Count<<
                                        END ELSE
                                            IF SalesReturnJournalData.NPD = 'Sparkle' THEN BEGIN
                                                decLMTDret[7] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                            END ELSE
                                                IF SalesReturnJournalData.NPD = 'HDP Elev 12X24' THEN BEGIN
                                                    decLMTDret[8] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                                END ELSE
                                                    IF SalesReturnJournalData.NPD = 'HDP Elev 12X18' THEN BEGIN
                                                        decLMTDret[10] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                                    END ELSE
                                                        //16767 IF ((SalesReturnJournalData.TypeCatCode = '75') OR (SalesReturnJournalData.TypeCatCode = '35')) AND (SalesReturnJournalData.Size_Code_Desc = '300X300') THEN BEGIN
                                                        IF (SalesReturnJournalData.NPD = 'Skd 1X1 Paver') AND (SalesReturnJournalData.Size_Code_Desc = '300X300') THEN BEGIN
                                                            decLMTDret[9] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                                                        END;
                        IF (SalesReturnJournalData.TabProdGrp = 'GVT') THEN BEGIN
                            decLMTDret[6] += SalesReturnJournalData.Quantity_in_Sq_Mt;
                        END;
                    END;

                END;

                FOR i := 1 TO 10 DO BEGIN
                    CustomerAmount.RESET;
                    CustomerAmount.SETFILTER("Amount (LCY)", '%1', i);
                    CustomerAmount.SETFILTER("Amount 2 (LCY)", '%1', 1);
                    IF CustomerAmount.FINDFIRST THEN BEGIN
                        intMTDCustCnt[i] := CustomerAmount.COUNT;
                    END;
                END;

                FOR i := 1 TO 10 DO BEGIN
                    CustomerAmount.RESET;
                    CustomerAmount.SETFILTER("Amount (LCY)", '%1', i);
                    CustomerAmount.SETFILTER("Amount 2 (LCY)", '%1', 2);
                    IF CustomerAmount.FINDFIRST THEN BEGIN
                        intYTDCustCnt[i] := CustomerAmount.COUNT;
                    END;
                END;

                FOR i := 1 TO 10 DO BEGIN
                    CustomerAmount.RESET;
                    CustomerAmount.SETFILTER("Amount (LCY)", '%1', i);
                    CustomerAmount.SETFILTER("Amount 2 (LCY)", '%1', 3);
                    IF CustomerAmount.FINDFIRST THEN BEGIN
                        intLMTDCustCnt[i] := CustomerAmount.COUNT;
                    END;
                END;

                FOR i := 1 TO 10 DO BEGIN
                    ItemAmount.RESET;
                    ItemAmount.SETFILTER(Amount, '%1', i);
                    ItemAmount.SETFILTER("Amount 2", '%1', 1);
                    IF ItemAmount.FINDFIRST THEN BEGIN
                        intMTDItemCnt[i] := ItemAmount.COUNT;
                    END;
                END;

                FOR i := 1 TO 10 DO BEGIN
                    ItemAmount.RESET;
                    ItemAmount.SETFILTER(Amount, '%1', i);
                    ItemAmount.SETFILTER("Amount 2", '%1', 2);
                    IF ItemAmount.FINDFIRST THEN BEGIN
                        intYTDItemCnt[i] := ItemAmount.COUNT;
                    END;
                END;

                FOR i := 1 TO 10 DO BEGIN
                    ItemAmount.RESET;
                    ItemAmount.SETFILTER(Amount, '%1', i);
                    ItemAmount.SETFILTER("Amount 2", '%1', 3);
                    IF ItemAmount.FINDFIRST THEN BEGIN
                        intLMTDItemCnt[i] := ItemAmount.COUNT;
                    END;
                END;
                /*
                CLEAR(SalesInvoicedDetails);
                SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.Area_CodeFilter,'%1',"Matrix Master"."Type 1");
                SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.ItemCategoryCodeFilter,'%1','M001');
                SalesInvoicedDetails.SETFILTER(SalesInvoicedDetails.PostingDateFilter,'%1..%2',AsonDate-1,AsonDate-1);
                SalesInvoicedDetails.OPEN;
                WHILE SalesInvoicedDetails.READ DO BEGIN
                  IF (SalesInvoicedDetails.Size_Code_Desc='600X600') AND (SalesInvoicedDetails.Tableau_Product_Group='GVT') THEN BEGIN
                    decFTDDesp[1]+=SalesInvoicedDetails.Sum_Quantity_in_Sq_Mt;
                  END ELSE IF (SalesInvoicedDetails.Size_Code_Desc='600X1200') AND (SalesInvoicedDetails.Tableau_Product_Group='GVT') THEN BEGIN
                    decFTDDesp[2]+=SalesInvoicedDetails.Sum_Quantity_in_Sq_Mt;
                  END ELSE IF SalesInvoicedDetails.NPD='Valencica' THEN BEGIN
                    decFTDDesp[3]+=SalesInvoicedDetails.Sum_Quantity_in_Sq_Mt;
                  END ELSE IF (SalesInvoicedDetails.Tableau_Product_Group='FBVT') THEN BEGIN
                    decFTDDesp[4]+=SalesInvoicedDetails.Sum_Quantity_in_Sq_Mt;
                  END ELSE IF (SalesInvoicedDetails.Type_Catogery_Code='75') AND (SalesInvoicedDetails.Size_Code_Desc='400X400') THEN BEGIN
                    decFTDDesp[5]+=SalesInvoicedDetails.Sum_Quantity_in_Sq_Mt;
                  END;
                END;
                */
                //Keshav22072020

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
        //AsonDate := 010321D;
        LastMnthStDate := CALCDATE('-CM', (CALCDATE('-CM-1D', AsonDate - 1)));

        IF CALCDATE('CM', AsonDate - 1) = AsonDate - 1 THEN
            LastMnthEndDate := CALCDATE('-CM-1D', AsonDate - 1)
        ELSE
            //  LastMnthEndDate := DMY2DATE(DATE2DMY(AsonDate,1)-1,DATE2DMY(AsonDate,2)-1,DATE2DMY(AsonDate,3));
            //  LastMnthEndDate := CALCDATE('CM',(CALCDATE('-CM-1D',AsonDate-1)));
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
        CLEAR(decLMTDret);

        IF CustomerAmount.FINDFIRST THEN
            CustomerAmount.DELETEALL;

        IF ItemAmount.FINDFIRST THEN
            ItemAmount.DELETEALL;
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
        decOpnOrderOtstnd: array[10] of Decimal;
        decMTDDesp: array[10] of Decimal;
        decFTDDesp: array[10] of Decimal;
        SalesJournalData: Query "Sales Journal Data";
        tempMatrixMaster: Record "Matrix Master" temporary;
        decMTDRet: array[10] of Decimal;
        decFTDRet: array[10] of Decimal;
        intMTDCustCnt: array[10] of Integer;
        intYTDCustCnt: array[10] of Integer;
        intLMTDCustCnt: array[10] of Integer;
        tempSalesInvHdr: array[10] of Record "Sales Invoice Header" temporary;
        recSalInvHdr: array[10] of Record "Sales Invoice Header";
        intMinus: Integer;
        tempSalesInvHdrYTD: array[10] of Record "Sales Invoice Header" temporary;
        tempSalesInvHdrLMTD: array[10] of Record "Sales Invoice Header" temporary;
        intTest: Integer;
        tmSalInv: Record "Sales Invoice Header";
        recSalCrMemoHdr: array[10] of Record "Sales Cr.Memo Header";
        tempSalesCrMemoHdr: array[10] of Record "Sales Cr.Memo Header" temporary;
        custNo: array[10] of Text;
        CustRec: Record Customer;
        CustNoYTD: array[10] of Text;
        CustNoLMTD: array[10] of Text;
        decLMTDDesp: array[10] of Decimal;
        recSalesInvLn: array[10] of Record "Sales Invoice Line";
        itemno: array[10] of Text;
        ritem: Record Item;
        intMTDItemCnt: array[10] of Integer;
        itemnoYTD: array[10] of Text;
        intYTDItemCnt: array[10] of Integer;
        itemnoLMTD: array[10] of Text;
        intLMTDItemCnt: array[10] of Integer;
        CustomerAmount: Record "Customer Amount";
        Tmpitem: array[10] of Record Item temporary;
        i: Integer;
        ItemAmount: Record "Item Amount";
        LastMnthStDate: Date;
        LastMnthEndDate: Date;
        decLMTDret: array[20] of Decimal;

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

    procedure Calculatesales(CustNo: Code[20]; StartDate: Date; EndDate: Date) SalesAmt: Decimal
    var
        SalesJournalData: Query "Sales Journal Data";
        SalesReturnJournalData: Query "Sales Return Journal Data";
    begin
        CLEAR(SalesJournalData);
        SalesJournalData.SETFILTER(CustomerNo, '%1', CustNo);

        SalesJournalData.SETFILTER(PostingDateFilter, '%1..%2', StartDate, EndDate);
        SalesJournalData.OPEN;
        WHILE SalesJournalData.READ DO BEGIN
            //   SalesAmt += SalesJournalData.AmountToCustomer;
        END;

        SalesReturnJournalData.SETFILTER(CustomerNo, '%1', CustNo);
        SalesReturnJournalData.SETFILTER(PostingDateFilter, '%1..%2', StartDate, EndDate);
        SalesReturnJournalData.OPEN;
        WHILE SalesReturnJournalData.READ DO BEGIN
            //  SalesAmt -= SalesReturnJournalData.AmountToCustomer;
        END;
    end;

    procedure CalculateDSO(OutstandingAmt: Decimal; SalesAmt: Decimal; salesNoOfDays: Decimal) DSO: Decimal
    begin
        IF SalesAmt <> 0 THEN
            DSO := OutstandingAmt / (SalesAmt) * salesNoOfDays;


        IF DSO < 0 THEN
            DSO := 99999;
    end;

    local procedure CalculateCustomerCount(CustomerNo: Code[20]; Slab: Integer; MonthGrp: Integer)
    begin
        CustomerAmount.RESET;
        CustomerAmount.SETFILTER("Customer No.", '%1', CustomerNo);
        CustomerAmount.SETFILTER("Amount (LCY)", '%1', Slab);
        CustomerAmount.SETFILTER("Amount 2 (LCY)", '%1', MonthGrp);
        IF NOT CustomerAmount.FINDFIRST THEN BEGIN
            CustomerAmount.INIT;
            CustomerAmount."Customer No." := CustomerNo;
            CustomerAmount."Amount (LCY)" := Slab;
            CustomerAmount."Amount 2 (LCY)" := MonthGrp;
            CustomerAmount.INSERT;
        END;
    end;

    local procedure CalculateItemCount(ItemNo: Code[20]; Slab: Integer; MonthGrp: Integer)
    var
        rItem: Record Item;
    begin
        rItem.RESET;
        rItem.GET(ItemNo);
        IF rItem."Quality Code" = '1' THEN BEGIN
            ItemAmount.RESET;
            ItemAmount.SETFILTER("Item No.", '%1', ItemNo);
            ItemAmount.SETFILTER(Amount, '%1', Slab);
            ItemAmount.SETFILTER("Amount 2", '%1', MonthGrp);
            IF NOT ItemAmount.FINDFIRST THEN BEGIN
                ItemAmount.INIT;
                ItemAmount."Item No." := ItemNo;
                ItemAmount.Amount := Slab;
                ItemAmount."Amount 2" := MonthGrp;
                ItemAmount.INSERT;
            END;
        END;
    end;
}

