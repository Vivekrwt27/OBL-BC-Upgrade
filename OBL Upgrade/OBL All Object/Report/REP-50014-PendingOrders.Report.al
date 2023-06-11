report 50014 "Pending Orders"
{
    // 2222
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\PendingOrders.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;



    dataset
    {
        dataitem("Matrix Master"; 50003)
        {
            DataItemTableView = SORTING("Type 1")
                                ORDER(Ascending)
                                WHERE(Description = FILTER(<> ''));
            RequestFilterFields = Description;
            column(Zone; "Matrix Master".Description)
            {
            }
            column(AreaCode; "Matrix Master"."Type 1")
            {
            }
            column(SalesTerritory; "Matrix Master"."Type 2")
            {
            }
            column(AreaDescription; "Matrix Master"."Description 2")
            {
            }
            column(PCHName; "PCH Name")
            {
            }
            column(Target; "Matrix Master".Target)
            {
            }
            column(PCHFilter; PCHFilter)
            {
            }
            column(ZoneFilter; ZoneFilter)
            {
            }
            column(TypeFilter; TypeFilter)
            {
            }
            column(Today; EndDt)
            {
            }
            column(LYToday; LYTDEnd)
            {
            }
            column(StartDt; StartDt)
            {
            }
            column(LYMToDAchv; LYMToDAchv)
            {
            }
            column(TMToDAchv; TMToDAchv)
            {
            }
            column(LYMAchv; LYMAchv)
            {
            }
            column(CKALYMAchv; (CKALYMAchv - CKALYMTDValR))
            {
            }
            column(MSVRN; 'MSVRN')
            {
            }
            column(Fusion; (Fusion1 + Fusion) / 100000)
            {
            }
            column(PayCr; (PayCr1 + PayCr) / 100000)
            {
            }
            column(PayAG4; (PayAG41 + PayAG4) / 100000)
            {
            }
            column(Underload; (Underload1 + Underload) / 100000)
            {
            }
            column(Overload; (Overload1 + Overload) / 100000)
            {
            }
            column(PartyVeh; (partyVeh1 + partyVeh) / 100000)
            {
            }
            column(Exect; (Exect1 + Exect) / 100000)
            {
            }
            column(NoMtri; (NoMtri1 + NoMtri) / 100000)
            {
            }
            column(ConfReq; (ConfReq1 + ConfReq) / 100000)
            {
            }
            column(PriceDisc; (PriceDisc1 + PriceDisc) / 100000)
            {
            }
            column(NoRes; (NoRes1 + NoRes) / 100000)
            {
            }
            column(TotalPend; (TotalPend1 + TotalPend) / 100000)
            {
            }
            column(CKA; 'CKA')
            {
            }
            column(CKATarget; CKATarget)
            {
            }
            column(CKALYMToDAchv; CKALYMToDAchv)
            {
            }
            column(CKATMToDAchv; CKATMToDAchv)
            {
            }
            column(MSVRNCKA; 'CKAMSVRN')
            {
            }
            column(CKAFusion; (CKAFusion1 + CKAFusion) / 100000)
            {
            }
            column(CKAPayCr; (CKAPayCr1 + CKAPayCr) / 100000)
            {
            }
            column(CKAPayAG4; (CKAPayAG41 + CKAPayAG4) / 100000)
            {
            }
            column(CKAUnderload; (CKAUnderload1 + CKAUnderload) / 100000)
            {
            }
            column(CKAOverload; (CKAOverload1 + CKAOverload) / 100000)
            {
            }
            column(CKAPartyVeh; (CKAPartyVeh1 + CKAPartyVeh) / 100000)
            {
            }
            column(CKAExect; (CKAExect1 + CKAExect) / 100000)
            {
            }
            column(CKANoMtri; (CKANoMtri1 + CKANoMtri) / 100000)
            {
            }
            column(CKAConfReq; (CKAConfReq1 + CKAConfReq) / 100000)
            {
            }
            column(CKAPriceDisc; (CKAPriceDisc1 + CKAPriceDisc) / 100000)
            {
            }
            column(CKANoRes; (CKANoRes1 + CKANoRes) / 100000)
            {
            }
            column(CKATotalPend; (CKATotalPend1 + CKATotalPend) / 100000)
            {
            }
            column(Days; Days)
            {
            }
            column(Month; CalcMonth(Month))
            {
            }
            column(Ret; 'Return')
            {
            }
            column(LYMTDValR; LYMTDValR)
            {
            }
            column(TYMTDValR; TYMTDValR)
            {
            }
            column(LYMToDAchvR; LYMToDAchvR)
            {
            }
            column(CKALYMToDAchvR; CKALYMToDAchvR)
            {
            }
            column(CKALYMTDValR; CKALYMTDValR)
            {
            }
            column(CKATYMTDValR; CKATYMTDValR)
            {
            }
            column(LYMTDValCK; LYMTDValCK)
            {
            }
            column(LYMTDVal; LYMTDVal)
            {
            }
            column(LYMTDValCKR; LYMTDValCKR)
            {
            }
            column(LYMTDValRM; LYMTDValRM)
            {
            }
            column(LYMTDValCKRM; LYMTDValCKRM)
            {
            }
            column(LYMTDValM; LYMTDValM)
            {
            }
            column(LYMTDValCKM; LYMTDValCKM)
            {
            }
            column(CYMAchvR; CYMAchvR)
            {
            }
            column(CYMAchvCKR; CYMAchvCKR)
            {
            }

            trigger OnAfterGetRecord()
            begin
                InitVar;

                //--Curr Year Data-->>
                CLEAR(SalesJournalData);
                SalesJournalData.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                SalesJournalData.SETRANGE(PostingDateFilter, TMStart, TMEnd);
                SalesJournalData.OPEN;
                WHILE SalesJournalData.READ DO BEGIN
                    IF (SalesJournalData.CustomerType = 'DEALER') OR (SalesJournalData.CustomerType = 'DISTIBUTOR') OR (SalesJournalData.CustomerType = 'PROJ.DLR') OR
                      (SalesJournalData.CustomerType = 'PROJECT') OR (SalesJournalData.CustomerType = 'SUBDLR') THEN BEGIN
                        TMToDAchv += SalesJournalData.LineAmount;
                    END ELSE
                        IF (SalesJournalData.CustomerType = 'GET') OR (SalesJournalData.CustomerType = 'PET') OR (SalesJournalData.CustomerType = 'SET') OR (SalesJournalData.CustomerType = 'DIRECTPROJ') OR
                          (SalesJournalData.CustomerType = 'HOPROJECT') THEN BEGIN
                            CKATMToDAchv += SalesJournalData.LineAmount;
                        END;
                END;
                //-- Return Data CY--->>
                //--CYReturnData-->>
                CYMAchvR := 0;
                CYMAchvCKR := 0;

                CLEAR(SalesRetJnl);
                SalesRetJnl.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                SalesRetJnl.SETRANGE(PostingDateFilter, StartDt, EndDt);
                SalesRetJnl.OPEN;
                WHILE SalesRetJnl.READ DO BEGIN
                    //IF RecCustomer.GET(SalesRetJnl.CustomerNo) THEN
                    IF (SalesRetJnl.CustType = 'DEALER') OR (SalesRetJnl.CustType = 'DISTIBUTOR') OR
                      (SalesRetJnl.CustType = 'PROJ.DLR') OR (SalesRetJnl.CustType = 'PROJECT') OR (SalesRetJnl.CustType = 'SUBDLR') THEN BEGIN
                        TYMTDValR += SalesRetJnl.LineAmount;
                        CYMAchvR += SalesRetJnl.LineAmount;
                        //MESSAGE('2 %1', SalesRetJnl.LineAmount); //MSVRN
                    END ELSE
                        IF (SalesRetJnl.CustType = 'GET') OR (SalesRetJnl.CustType = 'SET') OR (SalesRetJnl.CustType = 'PET') OR (SalesRetJnl.CustType = 'DIRECTPROJ') OR
                           (SalesRetJnl.CustType = 'HOPROJECT') THEN BEGIN
                            CKATYMTDValR += SalesRetJnl.LineAmount;
                            CYMAchvCKR += SalesRetJnl.LineAmount;
                        END;
                END;
                //--Return Data CY end--<<

                //--Curr Year Data--<<



                //--Last year Data-->>
                /*
                //--LYTD-->>
                LYMTDVal :=0;
                LYMTDValCK := 0;
                CLEAR(SalesJournalData);
                SalesJournalData.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                //SalesJournalData.SETRANGE(PostingDateFilter, LYTDStart, LYTDEnd);
                SalesJournalData.SETRANGE(PostingDateFilter, LYTDStart, LYTDEnd);
                //SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3','MISC.','CKA','PROJECT');
                //SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                SalesJournalData.OPEN;
                WHILE SalesJournalData.READ DO BEGIN
                  IF (SalesJournalData.CustomerType = 'DEALER') OR (SalesJournalData.CustomerType = 'DISTIBUTOR') OR
                    (SalesJournalData.CustomerType = 'PROJ.DLR')OR (SalesJournalData.CustomerType = 'PROJECT')OR (SalesJournalData.CustomerType = 'SUBDLR')THEN BEGIN
                    LYMTDVal += SalesJournalData.LineAmount;
                
                  END ELSE
                  IF (SalesJournalData.CustomerType = 'CKA') OR (SalesJournalData.CustomerType = 'DIRECTPROJ') OR
                     (SalesJournalData.CustomerType = 'HOPROJECT') THEN
                  BEGIN
                    LYMTDValCK += SalesJournalData.LineAmount;
                
                  END;
                END;
                //--LYTD---<<
                */
                //--LYTDData-->>
                LYMTDValR := 0;
                LYMTDValCKR := 0;
                /*
                CLEAR(SalesRetJnl);
                SalesRetJnl.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                SalesRetJnl.SETRANGE(PostingDateFilter, LYTDStart, LYTDEnd);
                SalesRetJnl.OPEN;
                WHILE SalesRetJnl.READ DO BEGIN
                IF RecCustomer.GET(SalesRetJnl.CustomerNo) THEN
                  IF (SalesRetJnl.CustomerType = 'DEALER') OR (SalesRetJnl.CustomerType = 'DISTIBUTOR') OR
                    (SalesRetJnl.CustomerType = 'PROJ.DLR')OR (SalesRetJnl.CustomerType = 'PROJECT')OR (SalesRetJnl.CustomerType = 'SUBDLR')THEN BEGIN
                    LYMTDValR += SalesRetJnl.LineAmount;
                
                  END ELSE
                  IF (SalesRetJnl.CustomerType = 'GET') OR (SalesRetJnl.CustomerType = 'PET') OR (SalesRetJnl.CustomerType = 'SET') OR (SalesRetJnl.CustomerType = 'DIRECTPROJ') OR
                     (SalesRetJnl.CustomerType = 'HOPROJECT') THEN
                  BEGIN
                    LYMTDValCKR += SalesRetJnl.LineAmount;
                
                  END;
                END;
                */
                LYMTDValR := GetLastRevenue(1, FALSE, "Matrix Master"."Type 1", LYTDStart, LYTDEnd, NotRequired);
                LYMTDValCKR := GetLastRevenue(1, TRUE, '', LYTDStart, LYTDEnd, NotRequired);

                //MSVRN--
                LYMTDVal := 0;
                LYMTDValCK := 0;
                LYMTDVal := GetLastRevenue(0, FALSE, "Matrix Master"."Type 1", LYTDStart, LYTDEnd, NotRequired);
                LYMTDValCK := GetLastRevenue(0, TRUE, '', LYTDStart, LYTDEnd, NotRequired);
                /*
                CLEAR(SalesJournalData);
                  SalesJournalData.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                  SalesJournalData.SETRANGE(PostingDateFilter, LYTDStart, LYTDEnd);
                  SalesJournalData.OPEN;
                  WHILE SalesJournalData.READ DO BEGIN
                    IF (SalesJournalData.CustomerType = 'DEALER') OR (SalesJournalData.CustomerType = 'DISTIBUTOR') OR (SalesJournalData.CustomerType = 'PROJ.DLR') OR
                      (SalesJournalData.CustomerType = 'PROJECT') OR (SalesJournalData.CustomerType = 'SUBDLR') THEN BEGIN
                      LYMTDVal += SalesJournalData.LineAmount;
                    END ELSE
                    IF (SalesJournalData.CustomerType = 'GET') OR (SalesJournalData.CustomerType = 'PET') OR (SalesJournalData.CustomerType = 'SET') OR (SalesJournalData.CustomerType = 'DIRECTPROJ') OR
                      (SalesJournalData.CustomerType = 'HOPROJECT') THEN BEGIN
                      LYMTDValCK += SalesJournalData.LineAmount;
                    END;
                  END;
                */
                //MSVRN--<<
                //LYTDData----end--


                //---Month data begin--
                /*
                LYMTDValRM := 0;
                LYMTDValCKRM := 0;
                CLEAR(SalesRetJnl);
                SalesRetJnl.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                SalesRetJnl.SETRANGE(PostingDateFilter, LYMStart, LYMEnd); //--
                SalesRetJnl.OPEN;
                WHILE SalesRetJnl.READ DO BEGIN
                IF RecCustomer.GET(SalesRetJnl.CustomerNo) THEN
                  IF (SalesRetJnl.CustomerType = 'DEALER') OR (SalesRetJnl.CustomerType = 'DISTIBUTOR') OR
                    (SalesRetJnl.CustomerType = 'PROJ.DLR')OR (SalesRetJnl.CustomerType = 'PROJECT')OR (SalesRetJnl.CustomerType = 'SUBDLR')THEN BEGIN
                    LYMTDValRM += SalesRetJnl.LineAmount;
                
                  END ELSE
                  IF (SalesRetJnl.CustomerType = 'CKA') OR (SalesRetJnl.CustomerType = 'DIRECTPROJ') OR
                     (SalesRetJnl.CustomerType = 'HOPROJECT') THEN
                  BEGIN
                    LYMTDValCKRM += SalesRetJnl.LineAmount;
                
                  END;
                END;
                */

                LYMTDValRM := 0;
                LYMTDValCKRM := 0;

                LYMTDValRM := GetLastRevenue(1, FALSE, "Matrix Master"."Type 1", LYMStart, LYMEnd, NotRequired);
                IF "Matrix Master"."Type 1" = 'CKA' THEN
                    LYMTDValCKRM := GetLastRevenue(1, TRUE, '', LYTDStart, LYMEnd, NotRequired);

                //MSVRN--
                LYMTDValM := 0;
                LYMTDValCKM := 0;
                LYMTDValM := GetLastRevenue(0, FALSE, "Matrix Master"."Type 1", LYTDStart, LYMEnd, NotRequired);
                IF "Matrix Master"."Type 1" = 'CKA' THEN
                    LYMTDValCKM := GetLastRevenue(0, TRUE, '', LYTDStart, LYMEnd, NotRequired);

                /*
                CLEAR(SalesRetJnl);
                SalesRetJnl.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                SalesRetJnl.SETRANGE(PostingDateFilter, LYMStart, LYMEnd);
                //SalesRetJnl.SETFILTER(CustomerType, '<>%1&<>%2&<>%3','MISC.','CKA','PROJECT');
                //SalesRetJnl.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                SalesRetJnl.OPEN;
                WHILE SalesRetJnl.READ DO BEGIN
                  IF RecCustomer.GET(SalesRetJnl.CustomerNo) THEN
                  IF (RecCustomer."Customer Type" = 'DEALER') OR (RecCustomer."Customer Type" = 'DISTIBUTOR') OR
                    (RecCustomer."Customer Type" = 'PROJ.DLR')OR (RecCustomer."Customer Type" = 'PROJECT')OR (RecCustomer."Customer Type" = 'SUBDLR')THEN BEGIN
                    LYMTDValRM += SalesRetJnl.LineAmount;
                  END ELSE
                  IF (RecCustomer."Customer Type" = 'GET') OR (RecCustomer."Customer Type" = 'PET') OR (RecCustomer."Customer Type" = 'SET') OR (RecCustomer."Customer Type" = 'DIRECTPROJ') OR
                     (RecCustomer."Customer Type" = 'HOPROJECT') THEN
                  BEGIN
                    LYMTDValCKRM += SalesRetJnl.LineAmount;
                  END;
                END;
                */
                //MSVRN--
                /*
                LYMTDValM := 0;
                LYMTDValCKM := 0;
                CLEAR(SalesJournalData);
                  SalesJournalData.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                  SalesJournalData.SETRANGE(PostingDateFilter, LYMStart, LYMEnd);
                  SalesJournalData.OPEN;
                  WHILE SalesJournalData.READ DO BEGIN
                    IF (SalesJournalData.CustomerType = 'DEALER') OR (SalesJournalData.CustomerType = 'DISTIBUTOR') OR (SalesJournalData.CustomerType = 'PROJ.DLR') OR
                      (SalesJournalData.CustomerType = 'PROJECT') OR (SalesJournalData.CustomerType = 'SUBDLR') THEN BEGIN
                      LYMTDValM += SalesJournalData.LineAmount;
                    END ELSE
                    IF (SalesJournalData.CustomerType = 'CKA') OR (SalesJournalData.CustomerType = 'DIRECTPROJ') OR
                      (SalesJournalData.CustomerType = 'HOPROJECT') THEN BEGIN
                      LYMTDValCKM += SalesJournalData.LineAmount;
                    END;
                  END;
                */

                /*
                LYMTDValM := 0;
                LYMTDValCKM := 0;
                CLEAR(SalesJournalData);
                SalesJournalData.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                SalesJournalData.SETRANGE(PostingDateFilter, LYMStart, LYMEnd);
                //SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3','MISC.','CKA','PROJECT');
                //SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                SalesJournalData.OPEN;
                WHILE SalesJournalData.READ DO BEGIN
                  IF (SalesJournalData.CustomerType = 'DEALER') OR (SalesJournalData.CustomerType = 'DISTIBUTOR') OR
                    (SalesJournalData.CustomerType = 'PROJ.DLR')OR (SalesJournalData.CustomerType = 'PROJECT')OR (SalesJournalData.CustomerType = 'SUBDLR')THEN BEGIN
                    LYMTDValM += SalesJournalData.LineAmount;
                
                  END ELSE
                  IF (SalesJournalData.CustomerType = 'GET') OR (SalesJournalData.CustomerType = 'PET') OR (SalesJournalData.CustomerType = 'SET') OR (SalesJournalData.CustomerType = 'DIRECTPROJ') OR
                     (SalesJournalData.CustomerType = 'HOPROJECT') THEN
                  BEGIN
                    LYMTDValCKM += SalesJournalData.LineAmount;
                
                  END;
                END;
                */
                //MSVRN--<<  ----Month data End
                //--LYMData--<<


                //--------- Delete code
                LYMToDAchv := 0;
                CKALYMToDAchv := 0;
                CLEAR(SalesJournalData);
                SalesJournalData.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                SalesJournalData.SETRANGE(PostingDateFilter, LYTDStart, LYTDEnd);
                SalesJournalData.OPEN;
                WHILE SalesJournalData.READ DO BEGIN
                    IF (SalesJournalData.CustomerType = 'DEALER') OR (SalesJournalData.CustomerType = 'DISTIBUTOR') OR (SalesJournalData.CustomerType = 'PROJ.DLR') OR
                      (SalesJournalData.CustomerType = 'PROJECT') OR (SalesJournalData.CustomerType = 'SUBDLR') THEN
                        LYMToDAchv += SalesJournalData.LineAmount
                    ELSE
                        IF (SalesJournalData.CustomerType = 'GET') OR (SalesJournalData.CustomerType = 'PET') OR (SalesJournalData.CustomerType = 'SET') OR (SalesJournalData.CustomerType = 'DIRECTPROJ') OR
                          (SalesJournalData.CustomerType = 'HOPROJECT') THEN
                            CKALYMToDAchv += SalesJournalData.LineAmount;
                END;

                LYMAchv := 0;
                CKALYMAchv := 0;
                CLEAR(SalesJournalData);
                SalesJournalData.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                SalesJournalData.SETRANGE(PostingDateFilter, LYMStart, LYMEnd);
                SalesJournalData.OPEN;
                WHILE SalesJournalData.READ DO BEGIN
                    IF (SalesJournalData.CustomerType = 'DEALER') OR (SalesJournalData.CustomerType = 'DISTIBUTOR') OR (SalesJournalData.CustomerType = 'PROJ.DLR') OR
                      (SalesJournalData.CustomerType = 'PROJECT') OR (SalesJournalData.CustomerType = 'SUBDLR') THEN
                        LYMAchv += SalesJournalData.LineAmount
                    ELSE
                        IF (SalesJournalData.CustomerType = 'GET') OR (SalesJournalData.CustomerType = 'PET') OR (SalesJournalData.CustomerType = 'SET') OR (SalesJournalData.CustomerType = 'DIRECTPROJ') OR
                          (SalesJournalData.CustomerType = 'HOPROJECT') THEN BEGIN
                            CKALYMAchv += SalesJournalData.LineAmount;
                        END;
                END;

                LYMToDAchvR := 0;
                CKALYMToDAchvR := 0;
                CLEAR(SalesRetJnl);
                SalesRetJnl.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                SalesRetJnl.SETRANGE(PostingDateFilter, LYTDStart, LYTDEnd);
                SalesRetJnl.OPEN;
                WHILE SalesRetJnl.READ DO BEGIN
                    IF (SalesRetJnl.CustType = 'DEALER') OR (SalesRetJnl.CustType = 'DISTIBUTOR') OR
                    (SalesRetJnl.CustType = 'PROJ.DLR') OR (SalesRetJnl.CustType = 'PROJECT') OR (SalesRetJnl.CustType = 'SUBDLR') THEN BEGIN
                        LYMToDAchvR += SalesRetJnl.LineAmount;

                    END ELSE
                        IF (SalesRetJnl.CustType = 'GET') OR (SalesRetJnl.CustType = 'PET') OR (SalesRetJnl.CustType = 'SET') OR (SalesRetJnl.CustType = 'DIRECTPROJ') OR
                           (SalesRetJnl.CustType = 'HOPROJECT') THEN BEGIN
                            CKALYMToDAchvR += SalesRetJnl.LineAmount;
                        END;
                END;

                //--Last Year Data--<<

                CLEAR(SalesOrderData);
                SalesOrderData.SETRANGE(DocType, DocTypeEnum::Order);
                SalesOrderData.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                SalesOrderData.SETRANGE(PostingDateFilter, 0D, TMEnd);
                //SalesOrderData.SETRANGE(InvoiceNo, 'SOGM/1920/003263');
                //SalesOrderData.SETRANGE(PostingDateFilter, 210819D);
                SalesOrderData.OPEN;
                WHILE SalesOrderData.READ DO BEGIN
                    IF (SalesOrderData.CustomerType = 'DEALER') OR (SalesOrderData.CustomerType = 'DISTIBUTOR') OR
                      (SalesOrderData.CustomerType = 'PROJ.DLR') OR (SalesOrderData.CustomerType = 'PROJECT') OR (SalesOrderData.CustomerType = 'SUBDLR') THEN BEGIN
                        //MSVRN 011119 --->>>

                        IF SalesOrderData.Status <> stausenum::Released THEN BEGIN
                            CASE SalesOrderData.RsnToHoldFilter OF
                                'Fusion Series Pending Order':
                                    Fusion1 += SalesOrderData.OSAmtLCY;
                                'Payment / Credit Issue':
                                    PayCr1 += SalesOrderData.OSAmtLCY;
                                'Payment Ag. 4% CD':
                                    PayAG41 += SalesOrderData.OSAmtLCY;
                                'Underload':
                                    Underload1 += SalesOrderData.OSAmtLCY;
                                'Overload':
                                    Overload1 += SalesOrderData.OSAmtLCY;
                                'Party Vehicle':
                                    partyVeh1 += SalesOrderData.OSAmtLCY;
                                'Executable':
                                    Exect1 += SalesOrderData.OSAmtLCY;
                                'No Material':
                                    NoMtri1 += SalesOrderData.OSAmtLCY;
                                'Order Confirmation (CKA)':
                                    ConfReq1 += SalesOrderData.OSAmtLCY;
                                'Pricing & Discount':
                                    PriceDisc1 += SalesOrderData.OSAmtLCY;
                                '':
                                    //BEGIN
                                    NoRes1 += SalesOrderData.OSAmtLCY;
                            //MESSAGE('Status %1 = Inv No. %2 = Amt %3 = %4', SalesOrderData.Status, SalesOrderData.InvoiceNo, SalesOrderData.OSAmtLCY, SalesOrderData.ReasonToHold);
                            //END;
                            END;
                            TotalPend1 := Fusion1 + PayCr1 + PayAG41 + Underload1 + Overload1 + partyVeh1 + Exect1 + NoMtri1 + ConfReq1 + PriceDisc1 + NoRes1;
                        END ELSE
                            IF SalesOrderData.Status = stausenum::Released THEN BEGIN
                                CASE SalesOrderData.DispRemFilter OF
                                    'Fusion Series Pending Order':
                                        Fusion += SalesOrderData.OSAmtLCY;
                                    'Payment / Credit Issue':
                                        PayCr += SalesOrderData.OSAmtLCY;
                                    'Payment Ag. 4% CD':
                                        PayAG4 += SalesOrderData.OSAmtLCY;
                                    'Underload':
                                        Underload += SalesOrderData.OSAmtLCY;
                                    'Overload':
                                        Overload += SalesOrderData.OSAmtLCY;
                                    'Party Vehicle':
                                        partyVeh += SalesOrderData.OSAmtLCY;
                                    'Executable':
                                        Exect += SalesOrderData.OSAmtLCY;
                                    'No Material':
                                        NoMtri += SalesOrderData.OSAmtLCY;
                                    'Order Confirmation (CKA)':
                                        ConfReq += SalesOrderData.OSAmtLCY;
                                    'Pricing & Discount':
                                        PriceDisc += SalesOrderData.OSAmtLCY;
                                    '':
                                        //BEGIN
                                        NoRes += SalesOrderData.OSAmtLCY;
                                //MESSAGE('%1 = %2', SalesOrderData.InvoiceNo, SalesOrderData.OSAmtLCY);
                                //END;
                                END;

                                TotalPend := Fusion + PayCr + PayAG4 + Underload + Overload + partyVeh + Exect + NoMtri + ConfReq + PriceDisc + NoRes;
                            END;

                    END;
                END;
                //-------CKA----->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

                //END ELSE

                CLEAR(SalesOrderData1);
                SalesOrderData1.SETRANGE(DocType, DocTypeEnum::Order);
                SalesOrderData1.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                SalesOrderData1.SETRANGE(PostingDateFilter, 0D, TMEnd);
                //SalesOrderData1.SETRANGE(InvoiceNo, 'SOGM/1920/003263');
                //SalesOrderData1.SETRANGE(PostingDateFilter, 210819D);
                SalesOrderData1.OPEN;
                WHILE SalesOrderData1.READ DO BEGIN
                    IF (SalesOrderData1.CustomerType = 'CKA') OR (SalesOrderData1.CustomerType = 'DIRECTPROJ') OR
                      (SalesOrderData1.CustomerType = 'HOPROJECT') THEN BEGIN
                        IF SalesOrderData1.Status <> stausenum::Released THEN BEGIN
                            CASE SalesOrderData1.RsnToHoldFilter OF
                                'Fusion Series Pending Order':
                                    CKAFusion1 += SalesOrderData1.OSAmtLCY;
                                'Payment / Credit Issue':
                                    CKAPayCr1 += SalesOrderData1.OSAmtLCY;
                                'Payment Ag. 4% CD':
                                    CKAPayAG41 += SalesOrderData1.OSAmtLCY;
                                'Underload':
                                    CKAUnderload1 += SalesOrderData1.OSAmtLCY;
                                'Overload':
                                    CKAOverload1 += SalesOrderData1.OSAmtLCY;
                                'Party Vehicle':
                                    CKAPartyVeh1 += SalesOrderData1.OSAmtLCY;
                                'Executable':
                                    CKAExect1 += SalesOrderData1.OSAmtLCY;
                                'No Material':
                                    CKANoMtri1 += SalesOrderData1.OSAmtLCY;
                                'Order Confirmation (CKA)':
                                    CKAConfReq1 += SalesOrderData1.OSAmtLCY;
                                'Pricing & Discount':
                                    CKAPriceDisc1 += SalesOrderData1.OSAmtLCY;
                                '':
                                    CKANoRes1 += SalesOrderData1.OSAmtLCY;
                            END;
                            CKATotalPend1 := CKAFusion1 + CKAPayCr1 + CKAPayAG41 + CKAUnderload1 + CKAOverload1 + CKAPartyVeh1 + CKAExect1 + CKANoMtri1 + CKAConfReq1 + CKAPriceDisc1 + CKANoRes1;
                        END ELSE
                            IF SalesOrderData1.Status = stausenum::Released THEN BEGIN
                                CASE SalesOrderData1.DispRemFilter OF
                                    'Fusion Series Pending Order':
                                        CKAFusion += SalesOrderData1.OSAmtLCY;
                                    'Payment / Credit Issue':
                                        CKAPayCr += SalesOrderData1.OSAmtLCY;
                                    'Payment Ag. 4% CD':
                                        CKAPayAG4 += SalesOrderData1.OSAmtLCY;
                                    'Underload':
                                        CKAUnderload += SalesOrderData1.OSAmtLCY;
                                    'Overload':
                                        CKAOverload += SalesOrderData1.OSAmtLCY;
                                    'Party Vehicle':
                                        CKAPartyVeh += SalesOrderData1.OSAmtLCY;
                                    'Executable':
                                        CKAExect += SalesOrderData1.OSAmtLCY;
                                    'No Material':
                                        CKANoMtri += SalesOrderData1.OSAmtLCY;
                                    'Order Confirmation (CKA)':
                                        CKAConfReq += SalesOrderData1.OSAmtLCY;
                                    'Pricing & Discount':
                                        CKAPriceDisc += SalesOrderData1.OSAmtLCY;
                                    '':
                                        CKANoRes1 += SalesOrderData1.OSAmtLCY;
                                END;
                                CKATotalPend := CKAFusion + CKAPayCr + CKAPayAG4 + CKAUnderload + CKAOverload + CKAPartyVeh + CKAExect + CKANoMtri + CKAConfReq + CKAPriceDisc + CKANoRes;

                            END;

                        //MSVRN 011119 ---<<<
                    END;
                END;
                //END;




                IF "Type 1" = 'CKA' THEN BEGIN
                    CKATarget := "Matrix Master".Target;
                END;

            end;

            trigger OnPreDataItem()
            begin
                ZoneFilter := "Matrix Master".GETFILTER(ZH);
                PCHFilter := "Matrix Master".GETFILTER(PCH);
                TypeFilter := "Matrix Master".GETFILTER("Type 1");

                MnthTxt := CalcMonth(Month);

                LYMStart := DMY2DATE(1, Month, Year - 1);
                // LYMEnd := DMY2DATE(CalcDays(Month), Month, Year - 1);
                LYMEnd := DMY2DATE(CalcDaysNew(Month, Year - 1), Month, Year - 1);//Keshav09022021

                LYTDStart := DMY2DATE(1, Month, Year - 1);
                LYTDEnd := DMY2DATE(DATE2DMY(EndDt, 1), Month, Year - 1);

                CKATarget := 0;
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
        //2222
    end;

    trigger OnPreReport()
    begin
        ZoneFilter := "Matrix Master".GETFILTER(ZH);
        PCHFilter := "Matrix Master".GETFILTER(PCH);
        TypeFilter := "Matrix Master".GETFILTER("Type 1");

        //EndDt := TODAY;
        EndDt := TODAY - 1;
        Day := DATE2DMY(EndDt, 1);
        Month := DATE2DMY(EndDt, 2);
        Year := DATE2DMY(EndDt, 3);
        StartDt := DMY2DATE(1, Month, Year);

        TMStart := DMY2DATE(1, Month, Year);
        TMEnd := EndDt;

        // Days := CalcDays(Month) - DATE2DMY(EndDt, 1);
        Days := CalcDaysNew(Month, Year) - DATE2DMY(EndDt, 1);   //Keshav09022021
    end;

    var
        ZoneFilter: Text;
        PCHFilter: Text;
        Day: Integer;
        Month: Integer;
        Year: Integer;
        TypeFilter: Text;
        EndDt: Date;
        StartDt: Date;
        MnthTxt: Text;
        LYTDStart: Date;
        LYTDEnd: Date;
        LYMStart: Date;
        LYMEnd: Date;
        TMToDAchv: Decimal;
        SalesJournalData: Query "Sales Journal Data 1";
        TMStart: Date;
        TMEnd: Date;
        SalesOrderData: Query "Sales Order Data";
        SalesOrderData1: Query "Sales Order Data";
        "----MSVRN--": Integer;
        Fusion: Decimal;
        PayCr: Decimal;
        PayAG4: Decimal;
        Underload: Decimal;
        Overload: Decimal;
        partyVeh: Decimal;
        Exect: Decimal;
        NoMtri: Decimal;
        ConfReq: Decimal;
        PriceDisc: Decimal;
        NoRes: Decimal;
        TotalPend: Decimal;
        LYMAchv: Decimal;
        Fusion1: Decimal;
        PayCr1: Decimal;
        PayAG41: Decimal;
        Underload1: Decimal;
        Overload1: Decimal;
        partyVeh1: Decimal;
        Exect1: Decimal;
        NoMtri1: Decimal;
        ConfReq1: Decimal;
        PriceDisc1: Decimal;
        NoRes1: Decimal;
        TotalPend1: Decimal;
        "----CKA--": Integer;
        CKAFusion: Decimal;
        CKAPayCr: Decimal;
        CKAPayAG4: Decimal;
        CKAUnderload: Decimal;
        CKAOverload: Decimal;
        CKAPartyVeh: Decimal;
        CKAExect: Decimal;
        CKANoMtri: Decimal;
        CKAConfReq: Decimal;
        CKAPriceDisc: Decimal;
        CKANoRes: Decimal;
        CKATotalPend: Decimal;
        CKAFusion1: Decimal;
        CKAPayCr1: Decimal;
        CKAPayAG41: Decimal;
        CKAUnderload1: Decimal;
        CKAOverload1: Decimal;
        CKAPartyVeh1: Decimal;
        CKAExect1: Decimal;
        CKANoMtri1: Decimal;
        CKAConfReq1: Decimal;
        CKAPriceDisc1: Decimal;
        CKANoRes1: Decimal;
        CKATotalPend1: Decimal;
        "////--------": Integer;
        CKALYMToDAchv: Decimal;
        CKATMToDAchv: Decimal;
        CKATarget: Decimal;
        CKALYMAchv: Decimal;
        SalesRetJnl: Query "Sales Return Jrnl Data1";
        CKALYMTDValR: Decimal;
        RecCustomer: Record Customer;
        TYMTDValR: Decimal;
        CKATYMTDValR: Decimal;
        LYMToDAchv: Decimal;
        "---CKA--": Integer;
        LYMToDAchvR: Decimal;
        CKALYMToDAchvR: Decimal;
        "--NewVAr--": Integer;
        LYMTDVal: Decimal;
        LYMTDValCK: Decimal;
        LYMTDValCKR: Decimal;
        LYMTDValR: Decimal;
        "--LYMonth--": Integer;
        LYMTDValRM: Decimal;
        LYMTDValCKRM: Decimal;
        LYMTDValM: Decimal;
        LYMTDValCKM: Decimal;
        CYMAchvR: Decimal;
        CYMAchvCKR: Decimal;
        TotalTarget: Decimal;
        Days: Integer;
        NotRequired: Decimal;
        DocTypeEnum: Enum "Document Type Enum";
        stausenum: Enum "Sales Document Status";


    local procedure CalcDays(Month: Integer) TotalDays: Integer
    begin
        CASE Month OF
            1, 3, 5, 7, 8, 10, 12:
                TotalDays := 31;

            4, 6, 9, 11:
                TotalDays := 30;

            2:
                TotalDays := 28;
        END;
    end;

    local procedure CalcMonth(Month: Integer) MonthText: Text[10]
    begin
        CASE Month OF
            1:
                MonthText := 'Jan';
            2:
                MonthText := 'Feb';
            3:
                MonthText := 'Mar';
            4:
                MonthText := 'April';
            5:
                MonthText := 'May';
            6:
                MonthText := 'June';
            7:
                MonthText := 'July';
            8:
                MonthText := 'Aug';
            9:
                MonthText := 'Sep';
            10:
                MonthText := 'Oct';
            11:
                MonthText := 'Nov';
            12:
                MonthText := 'Dec';
        END;
    end;

    local procedure InitVar()
    begin
        Fusion := 0;
        PayCr := 0;
        PayAG4 := 0;
        Underload := 0;
        Overload := 0;
        partyVeh := 0;
        Exect := 0;
        NoMtri := 0;
        ConfReq := 0;
        PriceDisc := 0;
        NoRes := 0;
        TotalPend := 0;
        LYMAchv := 0;
        Fusion1 := 0;
        PayCr1 := 0;
        PayAG41 := 0;
        Underload1 := 0;
        Overload1 := 0;
        partyVeh1 := 0;
        Exect1 := 0;
        NoMtri1 := 0;
        ConfReq1 := 0;
        PriceDisc1 := 0;
        NoRes1 := 0;
        TotalPend1 := 0;


        CKAFusion := 0;
        CKAPayCr := 0;
        CKAPayAG4 := 0;
        CKAUnderload := 0;
        CKAOverload := 0;
        CKAPartyVeh := 0;
        CKAExect := 0;
        CKANoMtri := 0;
        CKAConfReq := 0;
        CKAPriceDisc := 0;
        CKANoRes := 0;
        CKATotalPend := 0;
        CKAFusion1 := 0;
        CKAPayCr1 := 0;
        CKAPayAG41 := 0;
        CKAUnderload1 := 0;
        CKAOverload1 := 0;
        CKAPartyVeh1 := 0;
        CKAExect1 := 0;
        CKANoMtri1 := 0;
        CKAConfReq1 := 0;
        CKAPriceDisc1 := 0;
        CKANoRes1 := 0;
        CKATotalPend1 := 0;


        //--
        TYMTDValR := 0;
        CKATYMTDValR := 0;
        TMToDAchv := 0;
        CKATMToDAchv := 0;
    end;

    local procedure CalcDaysNew(Month: Integer; Year: Integer) TotalDays: Integer
    begin
        IF Month = 2 THEN
            IF Year MOD 4 = 0 THEN
                TotalDays := 29
            ELSE
                TotalDays := 28;

        CASE Month OF
            1, 3, 5, 7, 8, 10, 12:
                TotalDays := 31;

            4, 6, 9, 11:
                TotalDays := 30;
        END;
    end;

    procedure GetLastRevenue(TranType: Option Sale,Return,Both; CKANonCKA: Boolean; AreaCode: Code[20]; FromDate: Date; ToDate: Date; var SalesQty: Decimal) SalesAmt: Decimal
    var
        LYSalesJournalData: Query "Last Year Data";
        FieldForceCode: Code[20];
        MonthDate: Date;
        SalesJournalData1: Query "Sales Return Journal Data";
        LastGoalCode: Code[20];
        LastDealerCode: Code[20];
        RangeProdSalesSqlMt: Decimal;
        QryFocusCount: Query "Focus Count";
        "Const": Decimal;
    begin
        SalesAmt := 0;
        SalesQty := 0;
        Const := 1;

        IF TranType = TranType::Both THEN Const := -1;

        CLEAR(LYSalesJournalData);
        IF TranType IN [TranType::Sale, TranType::Both] THEN BEGIN
            IF CKANonCKA THEN
                LYSalesJournalData.SETFILTER(LYSalesJournalData.CustomerType, '%1|%2', 'CKA', 'ENTERPRISE')
            ELSE
                LYSalesJournalData.SETFILTER(LYSalesJournalData.CustomerType, '<>%1&<>%2', 'CKA', 'ENTERPRISE');

            IF AreaCode <> '' THEN
                LYSalesJournalData.SETFILTER(LYSalesJournalData.Area_Code, '%1', AreaCode); //MSKS
                                                                                            //IF AreaCode<>'' THEN
                                                                                            //  LYSalesJournalData.SETRANGE(LYSalesJournalData.LYSalesJournalData.Tableau_Zone ,LYSalesJournalData.DocumentType::Invoice);
            LYSalesJournalData.SETRANGE(LYSalesJournalData.DocumentType, DocTypeEnum::Invoice);
            LYSalesJournalData.SETFILTER(LYSalesJournalData.PostingDate, '%1..%2', FromDate, ToDate);
            LYSalesJournalData.OPEN;
            WHILE LYSalesJournalData.READ DO BEGIN
                SalesAmt += LYSalesJournalData.Sum_LineAmount;
                SalesQty += LYSalesJournalData.Sum_Quantity_Base;
            END;
        END;
        CLEAR(LYSalesJournalData);
        IF TranType IN [TranType::Return, TranType::Both] THEN BEGIN
            IF CKANonCKA THEN
                LYSalesJournalData.SETFILTER(LYSalesJournalData.CustomerType, '%1|%2', 'CKA', 'ENTERPRISE')
            ELSE
                LYSalesJournalData.SETFILTER(LYSalesJournalData.CustomerType, '<>%1&<>%2', 'CKA', 'ENTERPRISE');
            IF AreaCode <> '' THEN
                LYSalesJournalData.SETFILTER(LYSalesJournalData.Area_Code, '%1', AreaCode); //MSKS

            LYSalesJournalData.SETRANGE(LYSalesJournalData.DocumentType, DocTypeEnum::"Credit Memo");
            LYSalesJournalData.SETFILTER(LYSalesJournalData.PostingDate, '%1..%2', FromDate, ToDate);
            LYSalesJournalData.OPEN;
            WHILE LYSalesJournalData.READ DO BEGIN

                SalesAmt += LYSalesJournalData.Sum_LineAmount * Const;
                SalesQty += LYSalesJournalData.Sum_Quantity_Base * Const;
            END;
        END;
    end;
}

