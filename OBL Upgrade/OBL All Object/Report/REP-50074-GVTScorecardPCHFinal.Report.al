report 50074 "GVT Scorecard PCH Final"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\GVTScorecardPCHFinal.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Matrix Master"; 50003)
        {
            DataItemTableView = SORTING(PCH, Description)
                                ORDER(Ascending)
                                WHERE(PCH = FILTER(<> ''));
            PrintOnlyIfDetail = true;
            RequestFilterFields = PCH;
            column(StartDt; StartDt)
            {
            }
            column(EndDt; EndDt)
            {
            }
            column(PCHGrp; PCH)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(PCHName; "Matrix Master"."PCH Name")
            {
            }
            column(Zone; "Matrix Master"."Tableau Zone")
            {
            }
            dataitem(Integer0; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    ORDER(Ascending)
                                    WHERE(Number = FILTER(1));
                column(StartDt1; NxtYear)
                {
                }
                column(Totals; '---Total---')
                {
                }
                column(MonthGVT1; MonthGVT[1])
                {
                }
                column(MonthGVT2; MonthGVT[2])
                {
                }
                column(MonthGVT3; MonthGVT[3])
                {
                }
                column(MonthGVT4; MonthGVT[4])
                {
                }
                column(MonthGVT5; MonthGVT[5])
                {
                }
                column(MonthGVT6; MonthGVT[6])
                {
                }
                column(MonthGVT7; MonthGVT[7])
                {
                }
                column(MonthGVT8; MonthGVT[8])
                {
                }
                column(MonthGVT9; MonthGVT[9])
                {
                }
                column(MonthGVT10; MonthGVT[10])
                {
                }
                column(MonthGVT11; MonthGVT[11])
                {
                }
                column(MonthGVT12; MonthGVT[12])
                {
                }
                column(MonthPCH1; MonthPCH[1])
                {
                }
                column(MonthPCH2; MonthPCH[2])
                {
                }
                column(MonthPCH3; MonthPCH[3])
                {
                }
                column(MonthPCH4; MonthPCH[4])
                {
                }
                column(MonthPCH5; MonthPCH[5])
                {
                }
                column(MonthPCH6; MonthPCH[6])
                {
                }
                column(MonthPCH7; MonthPCH[7])
                {
                }
                column(MonthPCH8; MonthPCH[8])
                {
                }
                column(MonthPCH9; MonthPCH[9])
                {
                }
                column(MonthPCH10; MonthPCH[10])
                {
                }
                column(MonthPCH11; MonthPCH[11])
                {
                }
                column(MonthPCH12; MonthPCH[12])
                {
                }

                trigger OnAfterGetRecord()
                begin
                    /*
                    IF Month <> DATE2DMY("Sales Invoice Header"."Posting Date",2) THEN BEGIN
                      Month := DATE2DMY("Sales Invoice Header"."Posting Date",2);
                      CustNo := '';
                      CustCXO := '';
                      CustPCH := '';
                    END;
                    */

                    CLEAR(TotalGVT);
                    CLEAR(TotalItems);
                    CLEAR(MonthGVT);
                    CLEAR(TotalMonthGVT);
                    CLEAR(MonthCXO);
                    CLEAR(TotalGVTQty);
                    CLEAR(MonthPCH);
                    CLEAR(MonthItem);

                    WHILE SalesGVTCust.READ DO BEGIN
                        IF Month <> DATE2DMY(SalesGVTCust.Posting_Date, 2) THEN BEGIN
                            Month := DATE2DMY(SalesGVTCust.Posting_Date, 2);
                            CustNo := '';
                            // CustCXO := '';
                            CustPCH := '';
                        END;
                        IF CustNo <> SalesGVTCust.CustNo THEN BEGIN
                            CASE Month OF
                                1:
                                    MonthGVT[1] += 1;
                                2:
                                    MonthGVT[2] += 1;
                                3:
                                    MonthGVT[3] += 1;
                                4:
                                    MonthGVT[4] += 1;
                                5:
                                    MonthGVT[5] += 1;
                                6:
                                    MonthGVT[6] += 1;
                                7:
                                    MonthGVT[7] += 1;
                                8:
                                    MonthGVT[8] += 1;
                                9:
                                    MonthGVT[9] += 1;
                                10:
                                    MonthGVT[10] += 1;
                                11:
                                    MonthGVT[11] += 1;
                                12:
                                    MonthGVT[12] += 1;
                            END;
                            CustNo := SalesGVTCust.CustNo;
                        END;
                        ///---PCH --->>
                        IF CustPCH <> SalesGVTCust.CustNo THEN BEGIN
                            IF (SalesGVTCust.PCH_Code <> '') AND (SalesGVTCust.PCHTieUp = TRUE) THEN BEGIN
                                CASE Month OF
                                    1:
                                        MonthPCH[1] += 1;
                                    2:
                                        MonthPCH[2] += 1;
                                    3:
                                        MonthPCH[3] += 1;
                                    4:
                                        MonthPCH[4] += 1;
                                    5:
                                        MonthPCH[5] += 1;
                                    6:
                                        MonthPCH[6] += 1;
                                    7:
                                        MonthPCH[7] += 1;
                                    8:
                                        MonthPCH[8] += 1;
                                    9:
                                        MonthPCH[9] += 1;
                                    10:
                                        MonthPCH[10] += 1;
                                    11:
                                        MonthPCH[11] += 1;
                                    12:
                                        MonthPCH[12] += 1;
                                END;
                                ////--PCH-----<<
                            END;
                            CustPCH := SalesGVTCust.CustNo;
                        END;
                    END;

                    /*
                      //END;
                      ////---Total GVT------->>>
                    
                        CASE Month OF
                          1:
                            BEGIN
                            TotalMonthGVT[1] += SalesGVTCust.Amt;
                            TotalGVTQty[1] += SalesGVTCust.Qty;
                            END;
                          2:
                            BEGIN
                            TotalMonthGVT[2] += SalesGVTCust.Amt;
                            TotalGVTQty[2] += SalesGVTCust.Qty;
                            END;
                          3:
                            BEGIN
                            TotalMonthGVT[3] += SalesGVTCust.Amt;
                            TotalGVTQty[3] += SalesGVTCust.Qty;
                            END;
                          4:
                            BEGIN
                            TotalMonthGVT[4] += SalesGVTCust.Amt;
                            TotalGVTQty[4] += SalesGVTCust.Qty;
                            END;
                          5:
                            BEGIN
                            TotalMonthGVT[5] += SalesGVTCust.Amt;
                            TotalGVTQty[5] += SalesGVTCust.Qty;
                            END;
                          6:
                            BEGIN
                            TotalMonthGVT[6] += SalesGVTCust.Amt;
                            TotalGVTQty[6] += SalesGVTCust.Qty;
                            END;
                          7:
                            BEGIN
                            TotalMonthGVT[7] += SalesGVTCust.Amt;
                            TotalGVTQty[7] += SalesGVTCust.Qty;
                            END;
                          8:
                            BEGIN
                            TotalMonthGVT[8] += SalesGVTCust.Amt;
                            TotalGVTQty[8] += SalesGVTCust.Qty;
                            END;
                          9:
                            BEGIN
                            TotalMonthGVT[9] += SalesGVTCust.Amt;
                            TotalGVTQty[9] += SalesGVTCust.Qty;
                            END;
                          10:
                            BEGIN
                            TotalMonthGVT[10] += SalesGVTCust.Amt;
                            TotalGVTQty[10] += SalesGVTCust.Qty;
                            END;
                          11:
                            BEGIN
                            TotalMonthGVT[11] += SalesGVTCust.Amt;
                            TotalGVTQty[11] += SalesGVTCust.Qty;
                            END;
                          12:
                            BEGIN
                            TotalMonthGVT[12] += SalesGVTCust.Amt;
                            TotalGVTQty[12] += SalesGVTCust.Qty;
                            END;
                        END;
                        {
                             CustNo := SalesGVTCust.CustNo;
                       IF NOT SalesGVTCust.READ THEN
                        CurrReport.BREAK;
                        END;
                    END;
                    }
                    ///--CXO Data-->>
                      recCustomer.RESET;
                      recCustomer.SETRANGE("No.", SalesGVTCust.CustNo);
                      //recCustomer.SETRANGE("CXO Tie Up", TRUE);
                      IF recCustomer.FINDFIRST THEN BEGIN
                        IF recCustomer."CXO Tie Up" = TRUE THEN BEGIN
                          IF CustCXO <> recCustomer."No." THEN BEGIN
                            CASE Month OF
                              1:
                                MonthCXO[1] += 1;
                              2:
                                MonthCXO[2] += 1;
                              3:
                                MonthCXO[3] += 1;
                              4:
                                MonthCXO[4] += 1;
                              5:
                                MonthCXO[5] += 1;
                              6:
                                MonthCXO[6] += 1;
                              7:
                                MonthCXO[7] += 1;
                              8:
                                MonthCXO[8] += 1;
                              9:
                                MonthCXO[9] += 1;
                              10:
                                MonthCXO[10] += 1;
                              11:
                                MonthCXO[11] += 1;
                              12:
                                MonthCXO[12] += 1;
                            END;
                            CustCXO := recCustomer."No.";
                          END;
                        END;
                          ///---PCH --->>
                        IF recCustomer."PCH Code" <> '' THEN BEGIN
                          IF CustPCH <> SalesGVTCust.CustNo THEN BEGIN
                            CASE Month OF
                              1:
                               MonthPCH[1] += 1;
                              2:
                               MonthPCH[2] += 1;
                              3:
                               MonthPCH[3] += 1;
                              4:
                               MonthPCH[4] += 1;
                              5:
                               MonthPCH[5] += 1;
                              6:
                               MonthPCH[6] += 1;
                              7:
                               MonthPCH[7] += 1;
                              8:
                               MonthPCH[8] += 1;
                              9:
                               MonthPCH[9] += 1;
                              10:
                               MonthPCH[10] += 1;
                              11:
                               MonthPCH[11] += 1;
                              12:
                               MonthPCH[12] += 1;
                            END;
                          ////--PCH-----<<
                            CustPCH := recCustomer."No.";
                          END;
                        END;
                      //END;
                    ///--CXO Data--<<
                      END;
                       CustNo := SalesGVTCust.CustNo;
                       {
                       IF NOT SalesGVTCust.READ THEN
                         CurrReport.BREAK;
                         }
                       END;
                    END;
                    
                        {
                      ////---Total GVT -------<<<
                       CustNo := SalesGVTCust.CustNo;
                       IF NOT SalesGVTCust.READ THEN
                        CurrReport.BREAK;
                    END;
                    }
                    */

                end;

                trigger OnPreDataItem()
                begin
                    CLEAR(SalesGVTCust);
                    SalesGVTCust.SETRANGE(PostingDtFilter, StartDt, EndDt);
                    SalesGVTCust.SETRANGE(PCHFilter, "Matrix Master".PCH);
                    SalesGVTCust.OPEN;
                end;
            }
            dataitem(Integer1; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    ORDER(Ascending)
                                    WHERE(Number = FILTER(1));
                column(TotalMonthGVT1; TotalMonthGVT[1])
                {
                }
                column(TotalMonthGVT2; TotalMonthGVT[2])
                {
                }
                column(TotalMonthGVT3; TotalMonthGVT[3])
                {
                }
                column(TotalMonthGVT4; TotalMonthGVT[4])
                {
                }
                column(TotalMonthGVT5; TotalMonthGVT[5])
                {
                }
                column(TotalMonthGVT6; TotalMonthGVT[6])
                {
                }
                column(TotalMonthGVT7; TotalMonthGVT[7])
                {
                }
                column(TotalMonthGVT8; TotalMonthGVT[8])
                {
                }
                column(TotalMonthGVT9; TotalMonthGVT[9])
                {
                }
                column(TotalMonthGVT10; TotalMonthGVT[10])
                {
                }
                column(TotalMonthGVT11; TotalMonthGVT[11])
                {
                }
                column(TotalMonthGVT12; TotalMonthGVT[12])
                {
                }
                column(MonthCXO1; MonthCXO[1])
                {
                }
                column(MonthCXO2; MonthCXO[2])
                {
                }
                column(MonthCXO3; MonthCXO[3])
                {
                }
                column(MonthCXO4; MonthCXO[4])
                {
                }
                column(MonthCXO5; MonthCXO[5])
                {
                }
                column(MonthCXO6; MonthCXO[6])
                {
                }
                column(MonthCXO7; MonthCXO[7])
                {
                }
                column(MonthCXO8; MonthCXO[8])
                {
                }
                column(MonthCXO9; MonthCXO[9])
                {
                }
                column(MonthCXO10; MonthCXO[10])
                {
                }
                column(MonthCXO11; MonthCXO[11])
                {
                }
                column(MonthCXO12; MonthCXO[12])
                {
                }
                column(TotalGVTQty1; TotalGVTQty[1])
                {
                }
                column(TotalGVTQty2; TotalGVTQty[2])
                {
                }
                column(TotalGVTQty3; TotalGVTQty[3])
                {
                }
                column(TotalGVTQty4; TotalGVTQty[4])
                {
                }
                column(TotalGVTQty5; TotalGVTQty[5])
                {
                }
                column(TotalGVTQty6; TotalGVTQty[6])
                {
                }
                column(TotalGVTQty7; TotalGVTQty[7])
                {
                }
                column(TotalGVTQty8; TotalGVTQty[8])
                {
                }
                column(TotalGVTQty9; TotalGVTQty[9])
                {
                }
                column(TotalGVTQty10; TotalGVTQty[10])
                {
                }
                column(TotalGVTQty11; TotalGVTQty[11])
                {
                }
                column(TotalGVTQty12; TotalGVTQty[12])
                {
                }
                dataitem(CustomerPCH; 18)
                {
                    DataItemTableView = SORTING("No.")
                                        ORDER(Ascending)
                                        WHERE("PCH Code" = FILTER(<> ''));

                    trigger OnAfterGetRecord()
                    begin
                        /*
                         IF CustPCH <> "No." THEN BEGIN
                           CASE Month OF
                             1:
                              MonthPCH[1] += 1;
                             2:
                              MonthPCH[2] += 1;
                             3:
                              MonthPCH[3] += 1;
                             4:
                              MonthPCH[4] += 1;
                             5:
                              MonthPCH[5] += 1;
                             6:
                              MonthPCH[6] += 1;
                             7:
                              MonthPCH[7] += 1;
                             8:
                              MonthPCH[8] += 1;
                             9:
                              MonthPCH[9] += 1;
                             10:
                              MonthPCH[10] += 1;
                             11:
                              MonthPCH[11] += 1;
                             12:
                              MonthPCH[12] += 1;
                           END;
                           CustPCH := "No.";
                           TotalCustPCH += 1;
                         END;
                         */

                    end;
                }

                trigger OnAfterGetRecord()
                var
                    Customer: Record Customer;
                begin
                    /*
                    IF Month <> DATE2DMY("Sales Invoice Header"."Posting Date",2) THEN BEGIN
                      Month := DATE2DMY("Sales Invoice Header"."Posting Date",2);
                      CustNo := '';
                      CustCXO := '';
                      CustPCH := '';
                    END;
                    */

                    CLEAR(TotalGVT);
                    CLEAR(TotalItems);
                    CLEAR(MonthGVT);
                    CLEAR(TotalMonthGVT);
                    CLEAR(MonthCXO);
                    CLEAR(TotalGVTQty);
                    CLEAR(MonthPCH);
                    CLEAR(MonthItem);

                    WHILE SalesGVTCust.READ DO BEGIN
                        //IF Month <> DATE2DMY(SalesGVTCust.Posting_Date,2) THEN BEGIN
                        Month := DATE2DMY(SalesGVTCust.Posting_Date, 2);
                        // CustNo := '';
                        // CustCXO := '';
                        /// CustPCH := '';
                        // END;
                        TotalMonthGVT[Month] += SalesGVTCust.Amt;
                        TotalGVTQty[Month] += SalesGVTCust.Qty;

                        IF CustNo <> SalesGVTCust.CustNo THEN BEGIN
                            Customer.GET(SalesGVTCust.CustNo);
                            CASE Month OF
                                1:
                                    BEGIN
                                        MonthGVT[1] += 1;
                                        IF Customer."CXO Tie Up" THEN
                                            MonthCXO[1] += 1;
                                    END;
                                2:
                                    BEGIN
                                        MonthGVT[2] += 1;
                                        IF Customer."CXO Tie Up" THEN
                                            MonthCXO[2] += 1;
                                    END;
                                3:
                                    BEGIN
                                        MonthGVT[3] += 1;
                                        IF Customer."CXO Tie Up" THEN
                                            MonthCXO[3] += 1;
                                    END;
                                4:
                                    BEGIN
                                        MonthGVT[4] += 1;
                                        IF Customer."CXO Tie Up" THEN
                                            MonthCXO[4] += 1;
                                    END;
                                5:
                                    BEGIN
                                        MonthGVT[5] += 1;
                                        IF Customer."CXO Tie Up" THEN
                                            MonthCXO[5] += 1;
                                    END;
                                6:
                                    BEGIN
                                        MonthGVT[6] += 1;
                                        IF Customer."CXO Tie Up" THEN
                                            MonthCXO[6] += 1;
                                    END;
                                7:
                                    BEGIN
                                        MonthGVT[7] += 1;
                                        IF Customer."CXO Tie Up" THEN
                                            MonthCXO[7] += 1;
                                    END;
                                8:
                                    BEGIN
                                        MonthGVT[8] += 1;
                                        IF Customer."CXO Tie Up" THEN
                                            MonthCXO[8] += 1;
                                    END;
                                9:
                                    BEGIN
                                        MonthGVT[9] += 1;
                                        IF Customer."CXO Tie Up" THEN
                                            MonthCXO[9] += 1;
                                    END;
                                10:
                                    BEGIN
                                        MonthGVT[10] += 1;
                                        IF Customer."CXO Tie Up" THEN
                                            MonthCXO[10] += 1;
                                    END;
                                11:
                                    BEGIN
                                        MonthGVT[11] += 1;
                                        IF Customer."CXO Tie Up" THEN
                                            MonthCXO[11] += 1;
                                    END;
                                12:
                                    BEGIN
                                        MonthGVT[12] += 1;
                                        IF Customer."CXO Tie Up" THEN
                                            MonthCXO[12] += 1;
                                    END;
                            END;
                            CustNo := SalesGVTCust.CustNo;
                        END;
                    END;


                    /*
                      //END;
                      ////---Total GVT------->>>
                    
                        CASE Month OF
                          1:
                            BEGIN
                            TotalMonthGVT[1] += SalesGVTCust.Amt;
                            TotalGVTQty[1] += SalesGVTCust.Qty;
                            END;
                          2:
                            BEGIN
                            TotalMonthGVT[2] += SalesGVTCust.Amt;
                            TotalGVTQty[2] += SalesGVTCust.Qty;
                            END;
                          3:
                            BEGIN
                            TotalMonthGVT[3] += SalesGVTCust.Amt;
                            TotalGVTQty[3] += SalesGVTCust.Qty;
                            END;
                          4:
                            BEGIN
                            TotalMonthGVT[4] += SalesGVTCust.Amt;
                            TotalGVTQty[4] += SalesGVTCust.Qty;
                            END;
                          5:
                            BEGIN
                            TotalMonthGVT[5] += SalesGVTCust.Amt;
                            TotalGVTQty[5] += SalesGVTCust.Qty;
                            END;
                          6:
                            BEGIN
                            TotalMonthGVT[6] += SalesGVTCust.Amt;
                            TotalGVTQty[6] += SalesGVTCust.Qty;
                            END;
                          7:
                            BEGIN
                            TotalMonthGVT[7] += SalesGVTCust.Amt;
                            TotalGVTQty[7] += SalesGVTCust.Qty;
                            END;
                          8:
                            BEGIN
                            TotalMonthGVT[8] += SalesGVTCust.Amt;
                            TotalGVTQty[8] += SalesGVTCust.Qty;
                            END;
                          9:
                            BEGIN
                            TotalMonthGVT[9] += SalesGVTCust.Amt;
                            TotalGVTQty[9] += SalesGVTCust.Qty;
                            END;
                          10:
                            BEGIN
                            TotalMonthGVT[10] += SalesGVTCust.Amt;
                            TotalGVTQty[10] += SalesGVTCust.Qty;
                            END;
                          11:
                            BEGIN
                            TotalMonthGVT[11] += SalesGVTCust.Amt;
                            TotalGVTQty[11] += SalesGVTCust.Qty;
                            END;
                          12:
                            BEGIN
                            TotalMonthGVT[12] += SalesGVTCust.Amt;
                            TotalGVTQty[12] += SalesGVTCust.Qty;
                            END;
                        END;
                        {
                             CustNo := SalesGVTCust.CustNo;
                       IF NOT SalesGVTCust.READ THEN
                        CurrReport.BREAK;
                        END;
                    END;
                    }
                    */

                end;

                trigger OnPreDataItem()
                begin
                    CLEAR(SalesGVTCust);
                    SalesGVTCust.SETRANGE(PostingDtFilter, StartDt, EndDt);
                    SalesGVTCust.SETRANGE(PCHFilter, "Matrix Master".PCH);
                    SalesGVTCust.OPEN;
                end;
            }
            dataitem(Integer; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    ORDER(Ascending)
                                    WHERE(Number = FILTER(1));
                column(MonthItem1; MonthItem[1])
                {
                }
                column(MonthItem2; MonthItem[2])
                {
                }
                column(MonthItem3; MonthItem[3])
                {
                }
                column(MonthItem4; MonthItem[4])
                {
                }
                column(MonthItem5; MonthItem[5])
                {
                }
                column(MonthItem6; MonthItem[6])
                {
                }
                column(MonthItem7; MonthItem[7])
                {
                }
                column(MonthItem8; MonthItem[8])
                {
                }
                column(MonthItem9; MonthItem[9])
                {
                }
                column(MonthItem10; MonthItem[10])
                {
                }
                column(MonthItem11; MonthItem[11])
                {
                }
                column(MonthItem12; MonthItem[12])
                {
                }
                column(TotalItems; TotalItems)
                {
                }
                column(GVTNPD1; GVTNPD[1])
                {
                }
                column(GVTNPD2; GVTNPD[2])
                {
                }
                column(GVTNPD3; GVTNPD[3])
                {
                }
                column(GVTNPD4; GVTNPD[4])
                {
                }
                column(GVTNPD5; GVTNPD[5])
                {
                }
                column(GVTNPD6; GVTNPD[6])
                {
                }
                column(GVTNPD7; GVTNPD[7])
                {
                }
                column(GVTNPD8; GVTNPD[8])
                {
                }
                column(GVTNPD9; GVTNPD[9])
                {
                }
                column(GVTNPD10; GVTNPD[10])
                {
                }
                column(GVTNPD11; GVTNPD[11])
                {
                }
                column(GVTNPD12; GVTNPD[12])
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(MonthItem);
                    CLEAR(GVTNPD);

                    WHILE SalesGVT1.READ DO BEGIN

                        IF Month1 <> DATE2DMY(SalesGVT1.Posting_Date, 2) THEN BEGIN
                            Month1 := DATE2DMY(SalesGVT1.Posting_Date, 2);
                            ItemNo := '';
                        END;

                        IF ItemNo <> SalesGVT1.No THEN BEGIN
                            CASE Month1 OF
                                1:
                                    MonthItem[1] += 1;
                                2:
                                    MonthItem[2] += 1;
                                3:
                                    MonthItem[3] += 1;
                                4:
                                    MonthItem[4] += 1;
                                5:
                                    MonthItem[5] += 1;
                                6:
                                    MonthItem[6] += 1;
                                7:
                                    MonthItem[7] += 1;
                                8:
                                    MonthItem[8] += 1;
                                9:
                                    MonthItem[9] += 1;
                                10:
                                    MonthItem[10] += 1;
                                11:
                                    MonthItem[11] += 1;
                                12:
                                    MonthItem[12] += 1;
                            END;

                            IF (SalesGVT1.NPD <> 'XYZ Rest of SKU') THEN BEGIN
                                //IF GVTNPDItemNo <> SalesGVT1.No THEN BEGIN
                                CASE Month1 OF
                                    1:
                                        GVTNPD[1] += 1;
                                    2:
                                        GVTNPD[2] += 1;
                                    3:
                                        GVTNPD[3] += 1;
                                    4:
                                        GVTNPD[4] += 1;
                                    5:
                                        GVTNPD[5] += 1;
                                    6:
                                        GVTNPD[6] += 1;
                                    7:
                                        GVTNPD[7] += 1;
                                    8:
                                        GVTNPD[8] += 1;
                                    9:
                                        GVTNPD[9] += 1;
                                    10:
                                        GVTNPD[10] += 1;
                                    11:
                                        GVTNPD[11] += 1;
                                    12:
                                        GVTNPD[12] += 1;
                                END;
                                // GVTNPDItemNo := SalesGVT1.No;
                            END;
                            ItemNo := SalesGVT1.No;
                            /*
                            IF NOT SalesGVT1.READ THEN
                              CurrReport.BREAK;
                              */
                        END;
                    END;

                end;

                trigger OnPreDataItem()
                begin
                    CLEAR(SalesGVT1);
                    SalesGVT1.SETRANGE(PostingDtFilter, StartDt, EndDt);
                    SalesGVT1.SETRANGE(PCHFilter, "Matrix Master".PCH);
                    //SalesGVT1.SETRANGE(TableauFilter, 'GVT');
                    SalesGVT1.OPEN;
                end;
            }
            dataitem(IntegerOrders; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    ORDER(Ascending)
                                    WHERE(Number = FILTER(1));
                column(GVTOrders1; GVTOrders[1])
                {
                }
                column(GVTOrders2; GVTOrders[2])
                {
                }
                column(GVTOrders3; GVTOrders[3])
                {
                }
                column(GVTOrders4; GVTOrders[4])
                {
                }
                column(GVTOrders5; GVTOrders[5])
                {
                }
                column(GVTOrders6; GVTOrders[6])
                {
                }
                column(GVTOrders7; GVTOrders[7])
                {
                }
                column(GVTOrders8; GVTOrders[8])
                {
                }
                column(GVTOrders9; GVTOrders[9])
                {
                }
                column(GVTOrders10; GVTOrders[10])
                {
                }
                column(GVTOrders11; GVTOrders[11])
                {
                }
                column(GVTOrders12; GVTOrders[12])
                {
                }
                column(OrdrAmt1; OrdrAmt[1])
                {
                }
                column(OrdrAmt2; OrdrAmt[2])
                {
                }
                column(OrdrAmt3; OrdrAmt[3])
                {
                }
                column(OrdrAmt4; OrdrAmt[4])
                {
                }
                column(OrdrAmt5; OrdrAmt[5])
                {
                }
                column(OrdrAmt6; OrdrAmt[6])
                {
                }
                column(OrdrAmt7; OrdrAmt[7])
                {
                }
                column(OrdrAmt8; OrdrAmt[8])
                {
                }
                column(OrdrAmt9; OrdrAmt[9])
                {
                }
                column(OrdrAmt10; OrdrAmt[10])
                {
                }
                column(OrdrAmt11; OrdrAmt[11])
                {
                }
                column(OrdrAmt12; OrdrAmt[12])
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(GVTOrders);
                    WHILE SalesGVTOrderNo.READ DO BEGIN
                        //---Orders booked and billed--->>
                        IF OrderNo <> SalesGVTOrderNo.OrderNo THEN BEGIN
                            IF Month <> DATE2DMY(SalesGVTOrderNo.OrderDate, 2) THEN BEGIN
                                Month := DATE2DMY(SalesGVTOrderNo.OrderDate, 2);
                                OrderNo := '';
                            END;
                            CASE Month OF
                                1:
                                    GVTOrders[1] += 1;
                                2:
                                    GVTOrders[2] += 1;
                                3:
                                    GVTOrders[3] += 1;
                                4:
                                    GVTOrders[4] += 1;
                                5:
                                    GVTOrders[5] += 1;
                                6:
                                    GVTOrders[6] += 1;
                                7:
                                    GVTOrders[7] += 1;
                                8:
                                    GVTOrders[8] += 1;
                                9:
                                    GVTOrders[9] += 1;
                                10:
                                    GVTOrders[10] += 1;
                                11:
                                    GVTOrders[11] += 1;
                                12:
                                    GVTOrders[12] += 1;
                            END;
                            OrderNo := SalesGVTOrderNo.OrderNo;
                            /*
                            IF NOT SalesGVTOrderNo.READ THEN
                              CurrReport.BREAK;
                              */
                        END;
                        //---Orders booked and billed---<<
                    END;

                end;

                trigger OnPreDataItem()
                begin
                    CLEAR(SalesGVTOrderNo);
                    SalesGVTOrderNo.SETFILTER(OrderDate, '%1..%2', StartDt, EndDt);
                    SalesGVTOrderNo.SETRANGE(PCHFilter, "Matrix Master".PCH);
                    SalesGVTOrderNo.OPEN;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF "Matrix Master".PCH <> PCHRep THEN
                    PCHRep := "Matrix Master".PCH
                ELSE
                    CurrReport.SKIP;

                IF PrintOnlyOnePerPage THEN
                    PageGroupNo := PageGroupNo + 1;
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;
                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;
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
                field("Start Date"; StartDt)
                {
                    ApplicationArea = All;
                }
                field("End Date"; EndDt)
                {
                    ApplicationArea = All;
                }
                field(NewPageperCustomer; PrintOnlyOnePerPage)
                {
                    Caption = 'New Page per Customer';
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
        /*
        IF DATE2DMY(TODAY,2) < 4 THEN
          StartDt := DMY2DATE(1,4,(DATE2DMY(TODAY,3)-1))
        ELSE
        IF DATE2DMY(010419D,2) > 3 THEN
          StartDt := DMY2DATE(1,4,(DATE2DMY(TODAY,3)));
        
        EndDt := TODAY - 1;
        */
        IF StartDt = 0D THEN
            StartDt := 20190104D;

        IF EndDt = 0D THEN
            EndDt := TODAY - 1;

    end;

    var
        CustNo: Code[20];
        StartDt: Date;
        EndDt: Date;
        NxtYear: Date;
        Month: Integer;
        Month1: Integer;
        Month2: Integer;
        recCustomer: Record Customer;
        OrderNo: Code[20];
        Year: Date;
        FinStartDt: Date;
        FinEndDt: Date;
        StartDt1: Date;
        EndDt1: Date;
        "-----------------Totals------------": Integer;
        TotalGVT: Decimal;
        MonthGVT: array[12] of Decimal;
        TotalMonthGVT: array[12] of Decimal;
        MonthCXO: array[12] of Integer;
        TotalCustCXO: Integer;
        MonthPCH: array[12] of Integer;
        MonthItem: array[12] of Decimal;
        CustCXO: Code[20];
        CustPCH: Code[20];
        TotalCustPCH: Integer;
        ItemNo: Code[20];
        SalesGVT1: Query "Sales GVT";
        TotalItems: Decimal;
        TotalItem10: Integer;
        SalesInvoiceLine: Record "Sales Invoice Line";
        GVTNPD: array[12] of Integer;
        TotalGVTQty: array[12] of Decimal;
        SalesGVTCust: Query "Sales GVT Cust.";
        SalesGVTCust1: Query "Sales GVT Cust.";
        GVTOrders: array[12] of Integer;
        SalesLine: Record "Sales Line";
        recItem: Record Item;
        OrdrAmt: array[12] of Decimal;
        GVTNPDItemNo: Code[20];
        GVTAmt: array[12] of Decimal;
        SalesGVTOrderNo: Query "Sales GVT OrderNo.";
        "----------------------ForExcelMulti-----": Integer;
        PrintOnlyOnePerPage: Boolean;
        PageGroupNo: Integer;
        CustFilter: Text;
        PCHRep: Code[10];

    procedure InitializeRequest(ShowAmountInLCY: Boolean; SetPrintOnlyOnePerPage: Boolean; SetExcludeBalanceOnly: Boolean)
    begin
        PrintOnlyOnePerPage := SetPrintOnlyOnePerPage;
        //PrintAmountsInLCY := ShowAmountInLCY;
        //ExcludeBalanceOnly := SetExcludeBalanceOnly;
    end;
}

