report 50033 "Sales TGT vs Achvmnt"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\SalesTGTvsAchvmnt.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Matrix Master"; 50003)
        {
            DataItemTableView = SORTING("Type 1")
                                ORDER(Ascending)
                                WHERE(Description = FILTER(<> ''));
            RequestFilterFields = "Mapping Type", Description;
            column(Zone; "Matrix Master".Description)
            {
            }
            column(TotalTGT; TotalTGT)
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
            column(MTD; MTD / 100000)
            {
            }
            column(Target; Target)
            {
            }
            column(Spread8; Spread8)
            {
            }
            column(Spread16; Spread16)
            {
            }
            column(Spread23; Spread23)
            {
            }
            column(Spread31; Spread31)
            {
            }
            column(LYAchvmnt; LYAchvmnt)
            {
            }
            column(CYAchvmnt; CYAchvmnt)
            {
            }
            column(QYVal; QYVal)
            {
            }
            column(LQYVal; LQYVal)
            {
            }
            column(LFYVal; LFYVal)
            {
            }
            column(CFYVal; CFYVal)
            {
            }
            column(LMVal; LMVal)
            {
            }
            column(LYMVal; LYMVal)
            {
            }
            column(QNum; QNum)
            {
            }
            column(Year; Year)
            {
            }
            column(intFyYearFrst; intFyYearFrst)
            {
            }
            column(intFyYearLst; intFyYearLst)
            {
            }
            column(Month; Month)
            {
            }
            column(MnthTxt; MnthTxt)
            {
            }
            column(CYMAchv; CYMAchv)
            {
            }
            column(CYMHVPAchv; CYMHVPAchv)
            {
            }
            column(LYMCol; ABS(LYMCol))
            {
            }
            column(LYCol; ABS(LYCol))
            {
            }
            column(CYCol; ABS(CYCol))
            {
            }
            column(LMCol; ABS(LMCol))
            {
            }
            column(CMCol; ABS(CMCol))
            {
            }
            column(LYMColCK; ABS(LYMColCK))
            {
            }
            column(LYColCK; ABS(LYColCK))
            {
            }
            column(CYColCK; ABS(CYColCK))
            {
            }
            column(LMColCK; ABS(LMColCK))
            {
            }
            column(CMColCK; ABS(CMColCK))
            {
            }
            column(LYAchvmntCK; LYAchvmntCK)
            {
            }
            column(CYMAchvCK; CYMAchvCK)
            {
            }
            column(CYMHVPAchvCK; CYMHVPAchvCK)
            {
            }
            column(QYValCK; QYValCK)
            {
            }
            column(QYHVPValCK; QYHVPValCK)
            {
            }
            column(LQYValCK; LQYValCK)
            {
            }
            column(LFYValCK; LFYValCK)
            {
            }
            column(CFYValCK; CFYValCK)
            {
            }
            column(LMValCK; LMValCK)
            {
            }
            column(LYMValCK; LYMValCK)
            {
            }
            column(Return; '-------Return----')
            {
            }
            column(LYMValR; LYMValR)
            {
            }
            column(LYMValCKR; LYMValCKR)
            {
            }
            column(LYAchvmntR; LYAchvmntR)
            {
            }
            column(LYAchvmntCKR; LYAchvmntCKR)
            {
            }
            column(CYMAchvR; CYMAchvR)
            {
            }
            column(CYMAchvCKR; CYMAchvCKR)
            {
            }
            column(Ret2; 'Ret 2')
            {
            }
            column(QYValR; QYValR)
            {
            }
            column(QYValCKR; QYValCKR)
            {
            }
            column(LQYValR; LQYValR)
            {
            }
            column(LQYValCKR; LQYValCKR)
            {
            }
            column(LFYValR; LFYValR)
            {
            }
            column(LFYValCKR; LFYValCKR)
            {
            }
            column(CFYValR; CFYValR)
            {
            }
            column(CFYValCKR; CFYValCKR)
            {
            }
            column(LMValR; LMValR)
            {
            }
            column(LMValCKR; LMValCKR)
            {
            }
            column(ZhName; SalespersonPurchaser.Name)
            {
            }
            column(OverDueAmt; OverDueAmt)
            {
            }
            column(OverDueAmtCK; OverDueAmtCK)
            {
            }
            column(LastMonth; CalcMonth(Month - 1))
            {
            }
            column(LastMDays; CalcDays(Month - 1))
            {
            }
            column(CMonthDays; CalcDays(Month))
            {
            }
            column(LMonthDays; CalcDays(Month - 1))
            {
            }
            column(Last2Month; CalcMonth(Month - 2))
            {
            }
            column(CYMAchv2M; CYMAchv2M)
            {
            }
            column(CYMAchvCK2M; CYMAchvCK2M)
            {
            }
            column(CYMAchvR2M; CYMAchvR2M)
            {
            }
            column(CYMAchvCKR2M; CYMAchvCKR2M)
            {
            }
            column(LYMTDVal; LYMTDVal)
            {
            }
            column(LYMTDValCK; LYMTDValCK)
            {
            }
            column(LYMTDValR; LYMTDValR)
            {
            }
            column(LYMTDValCKR; LYMTDValCKR)
            {
            }
            column(AnnualTGT; "Matrix Master"."Annual Target")
            {
            }
            column(Q1TGT; "Matrix Master"."Q1 Tgt")
            {
            }
            column(RetailTGT; "Matrix Master"."Retail Sales Tgt")
            {
            }
            column(EntrpTGT; "Matrix Master"."Enterprise Tgt")
            {
            }
            column(SalesTGT1To8; "Matrix Master"."Sales Tgt Phasing 1-7")
            {
            }
            column(SalesTGT9To16; "Matrix Master"."Sales Tgt Phasing 8-14")
            {
            }
            column(SalesTGT17To23; "Matrix Master"."Sales Tgt Phasing 15-21")
            {
            }
            column(SalesTGT24To31; "Matrix Master"."Sales Tgt Phasing 22-27")
            {
            }
            column(SalesTGT28To30; "Matrix Master"."Sales Tgt Phasing 28-30")
            {
            }
            column(TargetCKA; TargetCKA)
            {
            }
            column(AnnualTGTCKA; AnnualTGTCKA)
            {
            }
            column(Q1TGTCKA; Q1TGTCKA)
            {
            }
            column(RetailTGTCKA; RetailTGTCKA)
            {
            }
            column(EntrpTGTCKA; EntrpTGTCKA)
            {
            }
            column(SalesTGT1To8CKA; SalesTGT1To8CKA)
            {
            }
            column(SalesTGT9To16CKA; SalesTGT9To16CKA)
            {
            }
            column(SalesTGT17To23CKA; SalesTGT17To23CKA)
            {
            }
            column(SalesTGT24To31CKA; SalesTGT24To31CKA)
            {
            }
            column(SalesTGT28To30CKA; SalesTGT28To30CKA)
            {
            }
            column(CKA; CKA)
            {
            }
            column(ZoneFilter; ZoneFilter)
            {
            }
            column(PCHFilter; PCHFilter)
            {
            }
            column(TypeFilter; TypeFilter)
            {
            }

            trigger OnAfterGetRecord()
            var
                OrderReleaseDate: Date;
                InvReleaseDate: Date;
            begin
                //IF "Matrix Master"."Type 1" <> MasterZone THEN BEGIN
                InitialisedVariables;
                ///MasterZone := "Matrix Master"."Type 1";
                //END;

                IF "Matrix Master"."Type 1" <> 'CKA' THEN BEGIN
                    //CurrReport.SKIP;

                    ///////--Acheivements------>>>>
                    CLEAR(SalesJournalData);
                    SalesJournalData.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    SalesJournalData.SETRANGE(PostingDateFilter, LFYStart, LFYEnd);
                    //SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                    SalesJournalData.OPEN;
                    WHILE SalesJournalData.READ DO BEGIN
                        IF (SalesJournalData.CustomerType = 'DEALER') OR (SalesJournalData.CustomerType = 'DISTIBUTOR') OR
                           (SalesJournalData.CustomerType = 'PROJ.DLR') OR (SalesJournalData.CustomerType = 'PROJECT') OR (SalesJournalData.CustomerType = 'SUBDLR') THEN BEGIN
                            //MESSAGE('%1 = %2', SalesJournalData.PostingDate, SalesJournalData.LineAmount);
                            LYAchvmnt += SalesJournalData.LineAmount;
                        END ELSE
                            IF (SalesJournalData.CustomerType = 'GET') OR (SalesJournalData.CustomerType = 'SET') OR (SalesJournalData.CustomerType = 'PET') OR (SalesJournalData.CustomerType = 'DIRECTPROJ') OR
                               (SalesJournalData.CustomerType = 'HOPROJECT') THEN BEGIN
                                LYAchvmntCK += SalesJournalData.LineAmount;

                            END;
                    END;

                    CLEAR(SalesJournalData);
                    SalesJournalData.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    SalesJournalData.SETRANGE(PostingDateFilter, StartDt, EndDt);
                    //SalesJournalData.SETRANGE(PostingDateFilter, StartDt, TODAY);
                    //SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3','MISC.','CKA','PROJECT');
                    //SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                    SalesJournalData.OPEN;
                    WHILE SalesJournalData.READ DO BEGIN
                        IF (SalesJournalData.CustomerType = 'DEALER') OR (SalesJournalData.CustomerType = 'DISTIBUTOR') OR
                           (SalesJournalData.CustomerType = 'PROJ.DLR') OR (SalesJournalData.CustomerType = 'PROJECT') OR (SalesJournalData.CustomerType = 'SUBDLR') THEN BEGIN
                            CYMAchv += SalesJournalData.LineAmount;
                        END ELSE
                            IF (SalesJournalData.CustomerType = 'GET') OR (SalesJournalData.CustomerType = 'SET') OR (SalesJournalData.CustomerType = 'PET') OR (SalesJournalData.CustomerType = 'DIRECTPROJ') OR
                               (SalesJournalData.CustomerType = 'HOPROJECT') THEN BEGIN
                                CYMAchvCK += SalesJournalData.LineAmount;
                            END;
                    END;


                    CLEAR(SalesJournalData);
                    SalesJournalData.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    SalesJournalData.SETRANGE(PostingDateFilter, CALCDATE('<-2M>', StartDt), StartDt - 1);
                    //SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3','MISC.','CKA','PROJECT');
                    //SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                    SalesJournalData.OPEN;
                    WHILE SalesJournalData.READ DO BEGIN
                        IF (SalesJournalData.CustomerType = 'DEALER') OR (SalesJournalData.CustomerType = 'DISTIBUTOR') OR
                           (SalesJournalData.CustomerType = 'PROJ.DLR') OR (SalesJournalData.CustomerType = 'PROJECT') OR (SalesJournalData.CustomerType = 'SUBDLR') THEN BEGIN
                            CYMAchv2M += SalesJournalData.LineAmount;
                        END ELSE
                            IF (SalesJournalData.CustomerType = 'GET') OR (SalesJournalData.CustomerType = 'SET') OR (SalesJournalData.CustomerType = 'PET') OR (SalesJournalData.CustomerType = 'DIRECTPROJ') OR
                               (SalesJournalData.CustomerType = 'HOPROJECT') THEN BEGIN
                                CYMAchvCK2M += SalesJournalData.LineAmount;
                            END;
                    END;

                    ///////--Acheivements------<<<<

                    ///////--Quarter Data------>>>>
                    CLEAR(SalesJournalData);
                    SalesJournalData.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    SalesJournalData.SETRANGE(PostingDateFilter, QYStart, QYEnd);
                    //SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3','MISC.','CKA','PROJECT');
                    //SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                    SalesJournalData.OPEN;
                    WHILE SalesJournalData.READ DO BEGIN
                        IF (SalesJournalData.CustomerType = 'DEALER') OR (SalesJournalData.CustomerType = 'DISTIBUTOR') OR
                           (SalesJournalData.CustomerType = 'PROJ.DLR') OR (SalesJournalData.CustomerType = 'PROJECT') OR (SalesJournalData.CustomerType = 'SUBDLR') THEN BEGIN
                            QYVal += SalesJournalData.LineAmount;

                        END ELSE
                            IF (SalesJournalData.CustomerType = 'GET') OR (SalesJournalData.CustomerType = 'SET') OR (SalesJournalData.CustomerType = 'PET') OR (SalesJournalData.CustomerType = 'DIRECTPROJ') OR
                               (SalesJournalData.CustomerType = 'HOPROJECT') THEN BEGIN
                                QYValCK += SalesJournalData.LineAmount;
                            END;

                    END;

                    CLEAR(SalesJournalData);
                    SalesJournalData.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    SalesJournalData.SETRANGE(PostingDateFilter, LQYStart, LQYEnd);
                    //SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3','MISC.','CKA','PROJECT');
                    //SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                    SalesJournalData.OPEN;
                    WHILE SalesJournalData.READ DO BEGIN
                        IF (SalesJournalData.CustomerType = 'DEALER') OR (SalesJournalData.CustomerType = 'DISTIBUTOR') OR
                          (SalesJournalData.CustomerType = 'PROJ.DLR') OR (SalesJournalData.CustomerType = 'PROJECT') OR (SalesJournalData.CustomerType = 'SUBDLR') THEN BEGIN
                            LQYVal += SalesJournalData.LineAmount;
                        END ELSE
                            IF (SalesJournalData.CustomerType = 'GET') OR (SalesJournalData.CustomerType = 'SET') OR (SalesJournalData.CustomerType = 'PET') OR (SalesJournalData.CustomerType = 'DIRECTPROJ') OR
                               (SalesJournalData.CustomerType = 'HOPROJECT') THEN BEGIN
                                LQYValCK += SalesJournalData.LineAmount;
                            END;

                    END;
                    ///////--Quarter Data------>>>>

                    ////-----F Year-------->>>>>
                    CLEAR(SalesJournalData);
                    SalesJournalData.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    SalesJournalData.SETRANGE(PostingDateFilter, LFYStart, LFYEnd);
                    //SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3','MISC.','CKA','PROJECT');
                    //SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                    SalesJournalData.OPEN;
                    WHILE SalesJournalData.READ DO BEGIN
                        IF (SalesJournalData.CustomerType = 'DEALER') OR (SalesJournalData.CustomerType = 'DISTIBUTOR') OR
                          (SalesJournalData.CustomerType = 'PROJ.DLR') OR (SalesJournalData.CustomerType = 'PROJECT') OR (SalesJournalData.CustomerType = 'SUBDLR') THEN BEGIN
                            LFYVal += SalesJournalData.LineAmount;
                        END ELSE
                            IF (SalesJournalData.CustomerType = 'GET') OR (SalesJournalData.CustomerType = 'SET') OR (SalesJournalData.CustomerType = 'PET') OR (SalesJournalData.CustomerType = 'DIRECTPROJ') OR
                               (SalesJournalData.CustomerType = 'HOPROJECT') THEN BEGIN
                                LFYValCK += SalesJournalData.LineAmount;
                            END;
                    END;

                    CLEAR(SalesJournalData);
                    SalesJournalData.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    SalesJournalData.SETRANGE(PostingDateFilter, CFYStart, CFYEnd);
                    //SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3','MISC.','CKA','PROJECT');
                    //SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                    SalesJournalData.OPEN;
                    WHILE SalesJournalData.READ DO BEGIN
                        IF (SalesJournalData.CustomerType = 'DEALER') OR (SalesJournalData.CustomerType = 'DISTIBUTOR') OR
                          (SalesJournalData.CustomerType = 'PROJ.DLR') OR (SalesJournalData.CustomerType = 'PROJECT') OR (SalesJournalData.CustomerType = 'SUBDLR') THEN BEGIN
                            CFYVal += SalesJournalData.LineAmount;
                        END ELSE
                            IF (SalesJournalData.CustomerType = 'GET') OR (SalesJournalData.CustomerType = 'SET') OR (SalesJournalData.CustomerType = 'PET') OR (SalesJournalData.CustomerType = 'DIRECTPROJ') OR
                               (SalesJournalData.CustomerType = 'HOPROJECT') THEN BEGIN
                                CFYValCK += SalesJournalData.LineAmount;
                            END;
                    END;

                    ///-------Last Month--------->>>>>>
                    CLEAR(SalesJournalData);
                    SalesJournalData.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    SalesJournalData.SETRANGE(PostingDateFilter, LMStart, LMEnd);
                    //SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3','MISC.','CKA','PROJECT');
                    //SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                    SalesJournalData.OPEN;
                    WHILE SalesJournalData.READ DO BEGIN
                        IF (SalesJournalData.CustomerType = 'DEALER') OR (SalesJournalData.CustomerType = 'DISTIBUTOR') OR
                          (SalesJournalData.CustomerType = 'PROJ.DLR') OR (SalesJournalData.CustomerType = 'PROJECT') OR (SalesJournalData.CustomerType = 'SUBDLR') THEN BEGIN
                            LMVal += SalesJournalData.LineAmount;

                        END ELSE
                            IF (SalesJournalData.CustomerType = 'GET') OR (SalesJournalData.CustomerType = 'SET') OR (SalesJournalData.CustomerType = 'PET') OR (SalesJournalData.CustomerType = 'DIRECTPROJ') OR
                               (SalesJournalData.CustomerType = 'HOPROJECT') THEN BEGIN
                                LMValCK += SalesJournalData.LineAmount;

                            END;
                    END;

                    CLEAR(SalesJournalData);
                    SalesJournalData.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    SalesJournalData.SETRANGE(PostingDateFilter, LYMStart, LYMEnd);
                    //SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3','MISC.','CKA','PROJECT');
                    //SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                    SalesJournalData.OPEN;
                    WHILE SalesJournalData.READ DO BEGIN
                        IF (SalesJournalData.CustomerType = 'DEALER') OR (SalesJournalData.CustomerType = 'DISTIBUTOR') OR
                          (SalesJournalData.CustomerType = 'PROJ.DLR') OR (SalesJournalData.CustomerType = 'PROJECT') OR (SalesJournalData.CustomerType = 'SUBDLR') THEN BEGIN
                            LYMVal += SalesJournalData.LineAmount;

                        END ELSE
                            IF (SalesJournalData.CustomerType = 'SET') OR (SalesJournalData.CustomerType = 'GET') OR (SalesJournalData.CustomerType = 'PET') OR (SalesJournalData.CustomerType = 'DIRECTPROJ') OR
                               (SalesJournalData.CustomerType = 'HOPROJECT') THEN BEGIN
                                LYMValCK += SalesJournalData.LineAmount;

                            END;
                    END;

                    CLEAR(SalesJournalData);
                    SalesJournalData.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    //SalesJournalData.SETRANGE(PostingDateFilter, LYTDStart, LYTDEnd);
                    SalesJournalData.SETRANGE(PostingDateFilter, LYTDStart, LYTDEnd);
                    //SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3','MISC.','CKA','PROJECT');
                    //SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                    SalesJournalData.OPEN;
                    WHILE SalesJournalData.READ DO BEGIN
                        IF (SalesJournalData.CustomerType = 'DEALER') OR (SalesJournalData.CustomerType = 'DISTIBUTOR') OR
                          (SalesJournalData.CustomerType = 'PROJ.DLR') OR (SalesJournalData.CustomerType = 'PROJECT') OR (SalesJournalData.CustomerType = 'SUBDLR') THEN BEGIN
                            LYMTDVal += SalesJournalData.LineAmount;

                        END ELSE
                            IF (SalesJournalData.CustomerType = 'SET') OR (SalesJournalData.CustomerType = 'GET') OR (SalesJournalData.CustomerType = 'PET') OR (SalesJournalData.CustomerType = 'DIRECTPROJ') OR
                               (SalesJournalData.CustomerType = 'HOPROJECT') THEN BEGIN
                                LYMTDValCK += SalesJournalData.LineAmount;

                            END;
                    END;


                    ///----Return---------------- For all return values BEGIN


                    ///////--Acheivements Return------>>>>
                    CLEAR(SalesRetJnl);
                    SalesRetJnl.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    SalesRetJnl.SETRANGE(PostingDateFilter, LFYStart, LFYEnd);
                    //SalesRetJnl.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                    SalesRetJnl.OPEN;
                    WHILE SalesRetJnl.READ DO BEGIN
                        IF RecCustomer.GET(SalesRetJnl.CustomerNo) THEN
                            IF (SalesRetJnl.CustomerType = 'DEALER') OR (SalesRetJnl.CustomerType = 'DISTIBUTOR') OR
                              (SalesRetJnl.CustomerType = 'PROJ.DLR') OR (SalesRetJnl.CustomerType = 'PROJECT') OR (SalesRetJnl.CustomerType = 'SUBDLR') THEN BEGIN
                                //MESSAGE('%1 = %2', SalesRetJnl.PostingDate, SalesRetJnl.LineAmount);
                                LYAchvmntR += SalesRetJnl.LineAmount;

                                IF RecCustomer."Salesperson Code" <> SPCode THEN BEGIN
                                    SPCode := Customer."Salesperson Code";
                                END;

                            END ELSE
                                IF (SalesRetJnl.CustomerType = 'GET') OR (SalesRetJnl.CustomerType = 'SET') OR (SalesRetJnl.CustomerType = 'PET') OR (SalesRetJnl.CustomerType = 'DIRECTPROJ') OR
                                   (SalesRetJnl.CustomerType = 'HOPROJECT') THEN BEGIN
                                    LYAchvmntCKR += SalesRetJnl.LineAmount;
                                    IF RecCustomer."Salesperson Code" <> SPCode THEN BEGIN
                                        SPCode := Customer."Salesperson Code";
                                    END;
                                END;
                    END;

                    /*
                    CLEAR(SalesRetJnl);
                    SalesRetJnl.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    SalesRetJnl.SETRANGE(PostingDateFilter, StartDt, EndDt);
                    //SalesRetJnl.SETRANGE(PostingDateFilter, StartDt, TODAY);
                    //SalesRetJnl.SETFILTER(CustomerType, '<>%1&<>%2&<>%3','MISC.','CKA','PROJECT');
                    //SalesRetJnl.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                    SalesRetJnl.OPEN;
                    WHILE SalesRetJnl.READ DO BEGIN
                    //IF RecCustomer.GET(SalesRetJnl.CustomerNo) THEN
                      IF (SalesRetJnl.CustomerType = 'DEALER') OR (SalesRetJnl.CustomerType = 'DISTIBUTOR') OR
                        (SalesRetJnl.CustomerType = 'PROJ.DLR')OR (SalesRetJnl.CustomerType = 'PROJECT')OR (SalesRetJnl.CustomerType = 'SUBDLR')THEN BEGIN
                        CYMAchvR += SalesRetJnl.LineAmount;
                        MESSAGE('%1', SalesRetJnl.LineAmount);
                      END ELSE
                      IF (SalesRetJnl.CustomerType = 'CKA') OR (SalesRetJnl.CustomerType = 'DIRECTPROJ') OR
                         (SalesRetJnl.CustomerType = 'HOPROJECT') THEN
                      BEGIN
                        CYMAchvCKR += SalesRetJnl.LineAmount;

                      END;
                    END;
                    */
                    CLEAR(SalesRetJnl);
                    SalesRetJnl.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    SalesRetJnl.SETRANGE(PostingDateFilter, StartDt, EndDt);
                    SalesRetJnl.OPEN;
                    WHILE SalesRetJnl.READ DO BEGIN
                        //IF RecCustomer.GET(SalesRetJnl.CustomerNo) THEN
                        IF (SalesRetJnl.CustType = 'DEALER') OR (SalesRetJnl.CustType = 'DISTIBUTOR') OR
                          (SalesRetJnl.CustType = 'PROJ.DLR') OR (SalesRetJnl.CustType = 'PROJECT') OR (SalesRetJnl.CustType = 'SUBDLR') THEN BEGIN
                            CYMAchvR += SalesRetJnl.LineAmount;
                            //MESSAGE('2 %1', SalesRetJnl.LineAmount); //MSVRN
                        END ELSE
                            IF (SalesRetJnl.CustType = 'GET') OR (SalesRetJnl.CustType = 'PET') OR (SalesRetJnl.CustType = 'SET') OR (SalesRetJnl.CustType = 'DIRECTPROJ') OR
                               (SalesRetJnl.CustType = 'HOPROJECT') THEN BEGIN
                                CYMAchvCKR += SalesRetJnl.LineAmount;
                            END;
                    END;


                    ///---------------------------

                    CLEAR(SalesRetJnl);
                    SalesRetJnl.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    SalesRetJnl.SETRANGE(PostingDateFilter, CALCDATE('<-2M>', StartDt), StartDt - 1);
                    //SalesRetJnl.SETFILTER(CustomerType, '<>%1&<>%2&<>%3','MISC.','CKA','PROJECT');
                    //SalesRetJnl.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                    SalesRetJnl.OPEN;
                    WHILE SalesRetJnl.READ DO BEGIN
                        IF RecCustomer.GET(SalesRetJnl.CustomerNo) THEN
                            IF (SalesRetJnl.CustomerType = 'DEALER') OR (SalesRetJnl.CustomerType = 'DISTIBUTOR') OR
                              (SalesRetJnl.CustomerType = 'PROJ.DLR') OR (SalesRetJnl.CustomerType = 'PROJECT') OR (SalesRetJnl.CustomerType = 'SUBDLR') THEN BEGIN
                                CYMAchvR2M += SalesRetJnl.LineAmount;

                            END ELSE
                                IF (SalesRetJnl.CustomerType = 'GET') OR (SalesRetJnl.CustomerType = 'PET') OR (SalesRetJnl.CustomerType = 'SET') OR (SalesRetJnl.CustomerType = 'DIRECTPROJ') OR
                                   (SalesRetJnl.CustomerType = 'HOPROJECT') THEN BEGIN
                                    CYMAchvCKR2M += SalesRetJnl.LineAmount;

                                END;
                    END;
                    ///////--Acheivements Return------<<<<

                    ///////--Quarter Data Return------>>>>
                    CLEAR(SalesRetJnl);
                    SalesRetJnl.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    SalesRetJnl.SETRANGE(PostingDateFilter, QYStart, QYEnd);
                    //SalesRetJnl.SETFILTER(CustomerType, '<>%1&<>%2&<>%3','MISC.','CKA','PROJECT');
                    //SalesRetJnl.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                    SalesRetJnl.OPEN;
                    WHILE SalesRetJnl.READ DO BEGIN
                        IF RecCustomer.GET(SalesRetJnl.CustomerNo) THEN
                            IF (SalesRetJnl.CustomerType = 'DEALER') OR (SalesRetJnl.CustomerType = 'DISTIBUTOR') OR
                              (SalesRetJnl.CustomerType = 'PROJ.DLR') OR (SalesRetJnl.CustomerType = 'PROJECT') OR (SalesRetJnl.CustomerType = 'SUBDLR') THEN BEGIN
                                QYValR += SalesRetJnl.LineAmount;

                            END ELSE
                                IF (SalesRetJnl.CustomerType = 'SET') OR (SalesRetJnl.CustomerType = 'PET') OR (SalesRetJnl.CustomerType = 'GET') OR (SalesRetJnl.CustomerType = 'DIRECTPROJ') OR
                                   (SalesRetJnl.CustomerType = 'HOPROJECT') THEN BEGIN
                                    QYValCKR += SalesRetJnl.LineAmount;

                                END;

                    END;

                    CLEAR(SalesRetJnl);
                    SalesRetJnl.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    SalesRetJnl.SETRANGE(PostingDateFilter, LQYStart, LQYEnd);
                    //SalesRetJnl.SETFILTER(CustomerType, '<>%1&<>%2&<>%3','MISC.','CKA','PROJECT');
                    //SalesRetJnl.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                    SalesRetJnl.OPEN;
                    WHILE SalesRetJnl.READ DO BEGIN
                        IF RecCustomer.GET(SalesRetJnl.CustomerNo) THEN
                            IF (SalesRetJnl.CustomerType = 'DEALER') OR (SalesRetJnl.CustomerType = 'DISTIBUTOR') OR
                              (SalesRetJnl.CustomerType = 'PROJ.DLR') OR (SalesRetJnl.CustomerType = 'PROJECT') OR (SalesRetJnl.CustomerType = 'SUBDLR') THEN BEGIN
                                LQYValR += SalesRetJnl.LineAmount;

                            END ELSE
                                IF (SalesRetJnl.CustomerType = 'GET') OR (SalesRetJnl.CustomerType = 'PET') OR (SalesRetJnl.CustomerType = 'SET') OR (SalesRetJnl.CustomerType = 'DIRECTPROJ') OR
                                   (SalesRetJnl.CustomerType = 'HOPROJECT') THEN BEGIN
                                    LQYValCKR += SalesRetJnl.LineAmount;

                                END;

                    END;
                    ///////--Quarter Data Return------>>>>

                    ////-----F Year Return-------->>>>>
                    CLEAR(SalesRetJnl);
                    SalesRetJnl.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    SalesRetJnl.SETRANGE(PostingDateFilter, LFYStart, LFYEnd);
                    //SalesRetJnl.SETFILTER(CustomerType, '<>%1&<>%2&<>%3','MISC.','CKA','PROJECT');
                    //SalesRetJnl.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                    SalesRetJnl.OPEN;
                    WHILE SalesRetJnl.READ DO BEGIN
                        IF RecCustomer.GET(SalesRetJnl.CustomerNo) THEN
                            IF (SalesRetJnl.CustomerType = 'DEALER') OR (SalesRetJnl.CustomerType = 'DISTIBUTOR') OR
                              (SalesRetJnl.CustomerType = 'PROJ.DLR') OR (SalesRetJnl.CustomerType = 'PROJECT') OR (SalesRetJnl.CustomerType = 'SUBDLR') THEN BEGIN
                                LFYValR += SalesRetJnl.LineAmount;

                            END ELSE
                                IF (SalesRetJnl.CustomerType = 'SET') OR (SalesRetJnl.CustomerType = 'PET') OR (SalesRetJnl.CustomerType = 'GET') OR (SalesRetJnl.CustomerType = 'DIRECTPROJ') OR
                                   (SalesRetJnl.CustomerType = 'HOPROJECT') THEN BEGIN
                                    LFYValCKR += SalesRetJnl.LineAmount;

                                END;
                    END;

                    CLEAR(SalesRetJnl);
                    SalesRetJnl.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    SalesRetJnl.SETRANGE(PostingDateFilter, CFYStart, CFYEnd);
                    //SalesRetJnl.SETFILTER(CustomerType, '<>%1&<>%2&<>%3','MISC.','CKA','PROJECT');
                    //SalesRetJnl.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                    SalesRetJnl.OPEN;
                    WHILE SalesRetJnl.READ DO BEGIN
                        IF RecCustomer.GET(SalesRetJnl.CustomerNo) THEN
                            IF (SalesRetJnl.CustomerType = 'DEALER') OR (SalesRetJnl.CustomerType = 'DISTIBUTOR') OR
                              (SalesRetJnl.CustomerType = 'PROJ.DLR') OR (SalesRetJnl.CustomerType = 'PROJECT') OR (SalesRetJnl.CustomerType = 'SUBDLR') THEN BEGIN
                                CFYValR += SalesRetJnl.LineAmount;


                            END ELSE
                                IF (SalesRetJnl.CustomerType = 'GET') OR (SalesRetJnl.CustomerType = 'SET') OR (SalesRetJnl.CustomerType = 'PET') OR (SalesRetJnl.CustomerType = 'DIRECTPROJ') OR
                                   (SalesRetJnl.CustomerType = 'HOPROJECT') THEN BEGIN
                                    CFYValCKR += SalesRetJnl.LineAmount;


                                END;
                    END;

                    ///-------Last Month Return--------->>>>>>
                    CLEAR(SalesRetJnl);
                    SalesRetJnl.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    SalesRetJnl.SETRANGE(PostingDateFilter, LMStart, LMEnd);
                    //SalesRetJnl.SETFILTER(CustomerType, '<>%1&<>%2&<>%3','MISC.','CKA','PROJECT');
                    //SalesRetJnl.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                    SalesRetJnl.OPEN;
                    WHILE SalesRetJnl.READ DO BEGIN
                        IF RecCustomer.GET(SalesRetJnl.CustomerNo) THEN
                            IF (SalesRetJnl.CustomerType = 'DEALER') OR (SalesRetJnl.CustomerType = 'DISTIBUTOR') OR
                              (SalesRetJnl.CustomerType = 'PROJ.DLR') OR (SalesRetJnl.CustomerType = 'PROJECT') OR (SalesRetJnl.CustomerType = 'SUBDLR') THEN BEGIN
                                LMValR += SalesRetJnl.LineAmount;

                            END ELSE
                                IF (SalesRetJnl.CustomerType = 'SET') OR (SalesRetJnl.CustomerType = 'PET') OR (SalesRetJnl.CustomerType = 'GET') OR (SalesRetJnl.CustomerType = 'DIRECTPROJ') OR
                                   (SalesRetJnl.CustomerType = 'HOPROJECT') THEN BEGIN
                                    LMValCKR += SalesRetJnl.LineAmount;

                                END;
                    END;

                    CLEAR(SalesRetJnl);
                    SalesRetJnl.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    SalesRetJnl.SETRANGE(PostingDateFilter, LYMStart, LYMEnd);
                    //SalesRetJnl.SETFILTER(CustomerType, '<>%1&<>%2&<>%3','MISC.','CKA','PROJECT');
                    //SalesRetJnl.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                    SalesRetJnl.OPEN;
                    WHILE SalesRetJnl.READ DO BEGIN
                        IF RecCustomer.GET(SalesRetJnl.CustomerNo) THEN
                            IF (SalesRetJnl.CustomerType = 'DEALER') OR (SalesRetJnl.CustomerType = 'DISTIBUTOR') OR
                              (SalesRetJnl.CustomerType = 'PROJ.DLR') OR (SalesRetJnl.CustomerType = 'PROJECT') OR (SalesRetJnl.CustomerType = 'SUBDLR') THEN BEGIN
                                LYMValR += SalesRetJnl.LineAmount;

                            END ELSE
                                IF (SalesRetJnl.CustomerType = 'GET') OR (SalesRetJnl.CustomerType = 'SET') OR (SalesRetJnl.CustomerType = 'PET') OR (SalesRetJnl.CustomerType = 'DIRECTPROJ') OR
                                   (SalesRetJnl.CustomerType = 'HOPROJECT') THEN BEGIN
                                    LYMValCKR += SalesRetJnl.LineAmount;

                                END;
                    END;

                    CLEAR(SalesRetJnl);
                    SalesRetJnl.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    //SalesRetJnl.SETRANGE(PostingDateFilter, LYTDStart, LYTDEnd);
                    SalesRetJnl.SETRANGE(PostingDateFilter, LYTDStart, LYTDEnd);
                    //SalesRetJnl.SETFILTER(CustomerType, '<>%1&<>%2&<>%3','MISC.','CKA','PROJECT');
                    //SalesRetJnl.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                    SalesRetJnl.OPEN;
                    WHILE SalesRetJnl.READ DO BEGIN
                        IF RecCustomer.GET(SalesRetJnl.CustomerNo) THEN
                            IF (SalesRetJnl.CustomerType = 'DEALER') OR (SalesRetJnl.CustomerType = 'DISTIBUTOR') OR
                              (SalesRetJnl.CustomerType = 'PROJ.DLR') OR (SalesRetJnl.CustomerType = 'PROJECT') OR (SalesRetJnl.CustomerType = 'SUBDLR') THEN BEGIN
                                LYMTDValR += SalesRetJnl.LineAmount;

                            END ELSE
                                IF (SalesRetJnl.CustomerType = 'GET') OR (SalesRetJnl.CustomerType = 'PET') OR (SalesRetJnl.CustomerType = 'SET') OR (SalesRetJnl.CustomerType = 'DIRECTPROJ') OR
                                   (SalesRetJnl.CustomerType = 'HOPROJECT') THEN BEGIN
                                    LYMTDValCKR += SalesRetJnl.LineAmount;

                                END;
                    END;



                    ///////----Sales Ret---->> For all return values END
                    CLEAR(SalesRetJnl);
                    SalesRetJnl.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    SalesRetJnl.SETRANGE(PostingDateFilter, LYMStart, LYMEnd);
                    //SalesRetJnl.SETFILTER(CustomerType, '<>%1&<>%2&<>%3','MISC.','CKA','PROJECT');
                    //SalesRetJnl.SETFILTER(CustomerType, '<>%1&<>%2&<>%3&<>%4&<>%5','MISC.','CKA','PROJECT', 'PROJ.DLR', 'DIRECTPROJ');
                    SalesRetJnl.OPEN;
                    WHILE SalesRetJnl.READ DO BEGIN
                        IF RecCustomer.GET(SalesRetJnl.CustomerNo) THEN
                            IF (RecCustomer."Customer Type" = 'DEALER') OR (RecCustomer."Customer Type" = 'DISTIBUTOR') OR
                              (RecCustomer."Customer Type" = 'PROJ.DLR') OR (RecCustomer."Customer Type" = 'PROJECT') OR (RecCustomer."Customer Type" = 'SUBDLR') THEN BEGIN
                                LYMValR += SalesRetJnl.LineAmount;

                            END ELSE
                                IF (RecCustomer."Customer Type" = 'GET') OR (RecCustomer."Customer Type" = 'SET') OR (RecCustomer."Customer Type" = 'PET') OR (RecCustomer."Customer Type" = 'DIRECTPROJ') OR
                                   (RecCustomer."Customer Type" = 'HOPROJECT') THEN BEGIN
                                    LYMValCKR += SalesRetJnl.LineAmount;

                                END;
                    END;


                    ////----Return---------------

                    TargetCKA := 0;
                    MatrixMaster.RESET;
                    MatrixMaster.SETRANGE("Type 1", 'CKA');
                    IF MatrixMaster.FINDFIRST THEN
                        TargetCKA := MatrixMaster.Target;

                    //----Overdue----->>>
                    CLEAR(CustAgeingMGT);
                    CustAgeingMGT.SETRANGE(CustAgeingMGT.Due_Date, 0D, EndDt - 1);
                    //CustAgeingMGT.SETRANGE(CustAgeingMGT.No,Customer."No.");
                    CustAgeingMGT.SETFILTER(CustAgeingMGT.Document_Type, '%1|%2', DocTypeEnum::Invoice, DocTypeEnum::"Credit Memo");
                    CustAgeingMGT.SETFILTER(CustAgeingMGT.Sum_Remaining_Amt_LCY, '<>%1', 0);
                    CustAgeingMGT.SETRANGE(Area_Code, "Matrix Master"."Type 1");
                    CustAgeingMGT.OPEN;
                    WHILE CustAgeingMGT.READ DO BEGIN
                        IF (CustAgeingMGT.Customer_Type = 'DEALER') OR (CustAgeingMGT.Customer_Type = 'DISTIBUTOR') OR
                          (CustAgeingMGT.Customer_Type = 'PROJ.DLR') OR (CustAgeingMGT.Customer_Type = 'PROJECT') OR (CustAgeingMGT.Customer_Type = 'SUBDLR') THEN
                            OverDueAmt += CustAgeingMGT.Sum_Remaining_Amt_LCY
                        ELSE
                            IF (CustAgeingMGT.Customer_Type = 'GET') OR (CustAgeingMGT.Customer_Type = 'PET') OR (CustAgeingMGT.Customer_Type = 'SET') OR (CustAgeingMGT.Customer_Type = 'DIRECTPROJ') OR
                               (CustAgeingMGT.Customer_Type = 'HOPROJECT') THEN
                                OverDueAmtCK += CustAgeingMGT.Sum_Remaining_Amt_LCY;
                    END;
                    //----Overdue-----<<<
                    IF SalespersonPurchaser.GET("Matrix Master".ZH) THEN;
                END ELSE
                    IF "Matrix Master"."Type 1" = 'CKA' THEN BEGIN
                        //TargetCKA :=
                        AnnualTGTCKA := "Matrix Master"."Annual Target";
                        Q1TGTCKA := "Matrix Master"."Q1 Tgt";
                        RetailTGTCKA := "Matrix Master"."Retail Sales Tgt";
                        EntrpTGTCKA := "Matrix Master"."Enterprise Tgt";

                        SalesTGT1To8CKA := "Matrix Master"."Sales Tgt Phasing 1-7";
                        SalesTGT9To16CKA := "Matrix Master"."Sales Tgt Phasing 8-14";
                        SalesTGT17To23CKA := "Matrix Master"."Sales Tgt Phasing 15-21";
                        SalesTGT24To31CKA := "Matrix Master"."Sales Tgt Phasing 22-27";
                        SalesTGT28To30CKA := "Matrix Master"."Sales Tgt Phasing 28-30";
                    END;

                TotalTGT := "Matrix Master"."Sales Tgt Phasing 1-7" + "Matrix Master"."Sales Tgt Phasing 8-14" + "Matrix Master"."Sales Tgt Phasing 15-21"
                           + "Matrix Master"."Sales Tgt Phasing 22-27" + "Matrix Master"."Sales Tgt Phasing 28-30";

            end;

            trigger OnPreDataItem()
            begin

                /*
                IF ZoneFilter <> '' THEN
                  CKA := TRUE
                ELSE
                  CKA := FALSE;
                  */
                /*
                Day := 0;
                Month := 0;
                Year := 0;
                */

                LYMStart := 0D;
                LYMEnd := 0D;

                QYStart := 0D;
                QYEnd := 0D;
                QNum := 0;
                LFYStart := 0D;
                LFYEnd := 0D;

                MnthTxt := CalcMonth(Month);
                LYTDStart := DMY2DATE(1, Month, Year - 1);
                LYTDEnd := DMY2DATE(DATE2DMY(EndDt, 1), Month, Year - 1);

                LYMStart := DMY2DATE(1, Month, Year - 1);
                LYMEnd := DMY2DATE(CalcDaysNew(Month, Year - 1), Month, Year - 1);


                IF Month = 1 THEN BEGIN
                    LMStart := DMY2DATE(1, 12, Year - 1);
                    LMEnd := DMY2DATE(31, 12, Year - 1);
                END ELSE BEGIN
                    LMStart := DMY2DATE(1, Month - 1, Year);
                    LMEnd := (StartDt - 1);
                END;

                IF Month > 3 THEN BEGIN
                    CFYStart := DMY2DATE(1, 4, Year);
                    CFYEnd := EndDt;
                    LFYStart := DMY2DATE(1, 4, Year - 1);
                    LFYEnd := DMY2DATE(31, 3, Year);
                END ELSE BEGIN
                    CFYStart := DMY2DATE(1, 4, Year - 1);
                    CFYEnd := EndDt;
                    LFYStart := DMY2DATE(1, 4, Year - 2);
                    LFYEnd := DMY2DATE(31, 3, Year - 1);
                END;

                QYCalc(DATE2DMY(StartDt, 2));

                CASE QYCalc(DATE2DMY(StartDt, 2)) OF
                    1:
                        BEGIN
                            QYStart := DMY2DATE(1, 4, Year);
                            //QYEnd := DMY2DATE(30,6,Year);
                            QYEnd := EndDt;
                            QNum := 1;
                            LQYStart := DMY2DATE(1, 4, Year - 1);
                            LQYEnd := DMY2DATE(30, 6, Year - 1);
                        END;

                    2:
                        BEGIN
                            QYStart := DMY2DATE(1, 7, Year);
                            //QYEnd := DMY2DATE(30,9,Year);
                            QYEnd := EndDt;
                            QNum := 2;
                            LQYStart := DMY2DATE(1, 7, Year - 1);
                            LQYEnd := DMY2DATE(30, 9, Year - 1);
                        END;

                    3:
                        BEGIN
                            QYStart := DMY2DATE(1, 10, Year);
                            //QYEnd := DMY2DATE(31,12,Year);
                            QYEnd := EndDt;
                            QNum := 3;
                            LQYStart := DMY2DATE(1, 10, Year - 1);
                            LQYEnd := DMY2DATE(31, 12, Year - 1);
                        END;

                    4:
                        BEGIN
                            QYStart := DMY2DATE(1, 1, Year);
                            //QYEnd := DMY2DATE(28,DATE2DMY(EndDt,2),Year);  //MSAK
                            //QYEnd := DMY2DATE(31,3,Year);
                            //QYEnd := DMY2DATE(DATE2DMY(EndDt,1), DATE2DMY(EndDt,2), Year);
                            QYEnd := EndDt;
                            QNum := 4;
                            LQYStart := DMY2DATE(1, 1, Year - 1);
                            LQYEnd := DMY2DATE(31, 3, Year - 1);
                        END;
                END;

            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(StartDt; StartDt)
                {
                    Caption = 'Start Date';
                    ApplicationArea = All;
                }
                field(EndDt; EndDt)
                {
                    Caption = 'End Date';
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
        ZoneFilter := "Matrix Master".GETFILTER(ZH);
        PCHFilter := "Matrix Master".GETFILTER(PCH);
        TypeFilter := "Matrix Master".GETFILTER("Type 1");

        EndDt := TODAY - 1;
        Day := DATE2DMY(EndDt, 1);
        /*
        Month := DATE2DMY(StartDt,2);
        Year := DATE2DMY(StartDt,3);
        */
        Month := DATE2DMY(EndDt, 2);
        Year := DATE2DMY(EndDt, 3);
        StartDt := DMY2DATE(1, Month, Year);
        intFyYearFrst := 0;
        intFyYearLst := 0;
        //Keshav13072020
        IF Month < 4 THEN BEGIN
            intFyYearLst := DATE2DMY(EndDt, 3);
            intFyYearFrst := intFyYearLst - 1;
        END ELSE BEGIN
            intFyYearFrst := DATE2DMY(EndDt, 3);
            intFyYearLst := intFyYearFrst + 1;
        END;
        //Keshav13072020

    end;

    var
        DocTypeEnum: Enum "Document Type Enum";
        Spread8: Integer;
        Spread16: Integer;
        Spread23: Integer;
        Spread31: Integer;
        Day: Integer;
        Month: Integer;
        Year: Integer;
        LYQ: Integer;
        TYQ: Integer;
        QNum: Integer;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        Customer: Record Customer;
        SalesJournalData: Query "Sales Journal Data 1";
        MasterZone: Code[20];
        PCHCode: Code[20];
        MnthTxt: Text[10];
        LYMStart: Date;
        LYMEnd: Date;
        StartDt: Date;
        EndDt: Date;
        LMStart: Date;
        LMEnd: Date;
        QYStart: Date;
        QYEnd: Date;
        LQYStart: Date;
        LQYEnd: Date;
        LFYStart: Date;
        LFYEnd: Date;
        LYTDStart: Date;
        LYTDEnd: Date;
        CFYStart: Date;
        CFYEnd: Date;
        LYAchvmnt: Decimal;
        LFYVal: Decimal;
        LYTDVal: Decimal;
        CFYVal: Decimal;
        LQYVal: Decimal;
        QYVal: Decimal;
        LMVal: Decimal;
        QTDLY1: Decimal;
        QTDLY2: Decimal;
        QTDLY3: Decimal;
        QTDLY4: Decimal;
        QTDTY1: Decimal;
        QTDTY2: Decimal;
        QTDTY3: Decimal;
        QTDTY4: Decimal;
        LYMVal: Decimal;
        MTD: Decimal;
        CYAchvmnt: Decimal;
        LMHVPVal: Decimal;
        LYMHVPVal: Decimal;
        DebtorsCollection: Query "Debtors Collection MGT 1";
        CMAchvmnt: Decimal;
        QYHVPVal: Decimal;
        CYMAchv: Decimal;
        CYMHVPAchv: Decimal;
        LYMCol: Decimal;
        LYCol: Decimal;
        CYCol: Decimal;
        LMCol: Decimal;
        CMCol: Decimal;
        "-------------MSVRN-------------": Integer;
        LYMColCK: Decimal;
        LYColCK: Decimal;
        CYColCK: Decimal;
        LMColCK: Decimal;
        CMColCK: Decimal;
        LYAchvmntCK: Decimal;
        CYMAchvCK: Decimal;
        QYValCK: Decimal;
        QYHVPValCK: Decimal;
        CYMHVPAchvCK: Decimal;
        LQYValCK: Decimal;
        LFYValCK: Decimal;
        CFYValCK: Decimal;
        LMValCK: Decimal;
        LYMValCK: Decimal;
        CustNo: Code[20];
        CustNoLYM: Code[20];
        CustNoCYM: Code[20];
        SalesRetJnl: Query "Sales Return Jrnl Data1";
        "-------Return": Integer;
        LYMValR: Decimal;
        LYMValCKR: Decimal;
        RecCustomer: Record Customer;
        LYAchvmntR: Decimal;
        LYAchvmntCKR: Decimal;
        CYMAchvR: Decimal;
        CYMAchvCKR: Decimal;
        QYValR: Decimal;
        QYValCKR: Decimal;
        LQYValR: Decimal;
        LQYValCKR: Decimal;
        LFYValR: Decimal;
        LFYValCKR: Decimal;
        CFYValR: Decimal;
        CFYValCKR: Decimal;
        LMValR: Decimal;
        LMValCKR: Decimal;
        ZHName: Text[20];
        SPCode: Code[10];
        TargetCKA: Decimal;
        MatrixMaster: Record "Matrix Master";
        CustAgeingMGT: Query "Cust. Ageing MGT";
        OverDueAmt: Decimal;
        OverDueAmtCK: Decimal;
        GBLAreaCode: Code[20];
        GBLZHCode: Code[20];
        GBLZMCode: Code[20];
        GBLPCHCode: Code[20];
        GBLSPCode: Code[20];
        CYMAchv2M: Decimal;
        CYMAchvCK2M: Decimal;
        CYMAchvR2M: Decimal;
        CYMAchvCKR2M: Decimal;
        "-----HVP---": Integer;
        LYMTDVal: Decimal;
        LYMTDValCK: Decimal;
        LYMTDValR: Decimal;
        LYMTDValCKR: Decimal;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        AnnualTGTCKA: Decimal;
        Q1TGTCKA: Decimal;
        RetailTGTCKA: Decimal;
        EntrpTGTCKA: Decimal;
        SalesTGT1To8CKA: Decimal;
        SalesTGT9To16CKA: Decimal;
        SalesTGT17To23CKA: Decimal;
        SalesTGT24To31CKA: Decimal;
        CKA: Boolean;
        ZoneFilter: Text;
        PCHFilter: Text;
        SalesTGT28To30CKA: Decimal;
        SalesTGT28To30: Decimal;
        TotalTGT: Decimal;
        TypeFilter: Text;
        intFyYearFrst: Integer;
        intFyYearLst: Integer;

    local procedure InitialisedVariables()
    begin
        LYAchvmnt := 0;
        LFYVal := 0;
        LYTDVal := 0;
        CFYVal := 0;
        LQYVal := 0;
        QYVal := 0;
        LMVal := 0;
        QTDLY1 := 0;
        QTDLY2 := 0;
        QTDLY3 := 0;
        QTDLY4 := 0;
        QTDTY1 := 0;
        QTDTY2 := 0;
        QTDTY3 := 0;
        QTDTY4 := 0;
        LYMVal := 0;
        //Target:=0;
        MTD := 0;
        CYAchvmnt := 0;
        CYMAchv := 0;
        LYMCol := 0;
        LYCol := 0;
        CYCol := 0;
        LMCol := 0;
        CMCol := 0;
        //--RK
        LYMColCK := 0;
        LYColCK := 0;
        CYColCK := 0;
        LMColCK := 0;
        CMColCK := 0;
        //abc
        LYAchvmntCK := 0;
        CYMAchvCK := 0;
        QYValCK := 0;
        LQYValCK := 0;
        LFYValCK := 0;
        CFYValCK := 0;
        LMValCK := 0;
        LYMValCK := 0;
        CYMAchv2M := 0;
        CYMAchvCK2M := 0;
        CYMAchvR2M := 0;
        CYMAchvCKR2M := 0;
        //---Ret
        LYMValR := 0;
        LYMValCKR := 0;
        LYAchvmntR := 0;
        LYAchvmntCKR := 0;
        CYMAchvR := 0;
        CYMAchvCKR := 0;
        //--
        LYAchvmntR := 0;
        LYAchvmntCKR := 0;
        CYMAchvR := 0;
        CYMAchvCKR := 0;
        QYValR := 0;
        QYValCKR := 0;
        LQYValR := 0;
        LQYValCKR := 0;
        LFYValR := 0;
        LFYValCKR := 0;
        CFYValR := 0;
        CFYValCKR := 0;
        LMValR := 0;
        LMValCKR := 0;
        OverDueAmt := 0;
        //ABC
        OverDueAmtCK := 0;
        LYMTDVal := 0;
        LYMTDValCK := 0;
        LYMTDValR := 0;
        LYMTDValCKR := 0;

        AnnualTGTCKA := 0;
        Q1TGTCKA := 0;
        RetailTGTCKA := 0;
        EntrpTGTCKA := 0;
        SalesTGT1To8CKA := 0;
        SalesTGT9To16CKA := 0;
        SalesTGT17To23CKA := 0;
        SalesTGT24To31CKA := 0;
        SalesTGT28To30CKA := 0;
        SalesTGT28To30 := 0;
        TotalTGT := 0;
    end;

    procedure SetReportType(LclQtyReport: Boolean)
    begin
    end;

    local procedure QYCalc(QMonth: Integer) QM: Integer
    begin
        CASE QMonth OF
            4, 5, 6:
                QM := 1;

            7, 8, 9:
                QM := 2;

            10, 11, 12:
                QM := 3;

            1, 2, 3:
                QM := 4;
        END;
    end;

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

    local procedure GetSPName(SPCode: Code[10]): Text
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
    begin
        IF SalespersonPurchaser.GET(SPCode) THEN
            EXIT(SalespersonPurchaser.Name);
    end;

    procedure SetParameters(StartDate: Date; EndDate: Date; AreaCode: Code[20]; ZH: Code[20]; ZM: Code[20]; PCHCode: Code[20]; SPCode: Code[20]; Detail: Boolean)
    begin
        StartDt := StartDate;
        EndDt := EndDate;
        GBLAreaCode := AreaCode;
        GBLZHCode := ZH;
        GBLZMCode := ZM;
        GBLPCHCode := PCHCode;
        GBLSPCode := SPCode;
        //Detailed := Detail;
    end;

    local procedure CalcDaysNew(Month: Integer; Year: Integer) TotalDays: Integer
    begin
        IF Month = 2 THEN BEGIN
            IF Year MOD 4 = 0 THEN
                TotalDays := 29
            ELSE
                TotalDays := 28;
        END;

        CASE Month OF
            1, 3, 5, 7, 8, 10, 12:
                TotalDays := 31;

            4, 6, 9, 11:
                TotalDays := 30;
        END;
    end;
}

