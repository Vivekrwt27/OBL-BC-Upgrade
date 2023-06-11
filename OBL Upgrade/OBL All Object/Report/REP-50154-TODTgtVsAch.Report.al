report 50154 "TOD Tgt Vs Ach"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\TODTgtVsAch.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = WHERE("Minmum Amt pur value" = FILTER(<> 0));
            RequestFilterFields = "No.", "Zonal Head";
            column(CustNo; Customer."No.")
            {
            }
            column(Zone; Customer.Zone)
            {
            }
            column(TerritoryCode; "Area Code")
            {
            }
            column(CustNameNdCity; Customer.Name + ', ' + Customer.City)
            {
            }
            column(LYAchvmnt; LYAchvmnt)
            {
            }
            column(QTDAchvmnt; QTDAchvmnt)
            {
            }
            column(TMAchvmnt; TMAchvmnt)
            {
            }
            column(L3MCol; L3MCol)
            {
            }
            column(CMCol; CMCol)
            {
            }
            column(OSAmt; OSAmt)
            {
            }
            column(MonthDue; MonthDue)
            {
            }
            column(TotalOverDue; TotalOverDue)
            {
            }
            column(LFYStart; LFYStart)
            {
            }
            column(Quarter; Quarter)
            {
            }
            column(OverDueAmt; OverDueAmt)
            {
            }
            column(TMAchvmntR; TMAchvmntR)
            {
            }
            column(LYAchvmntR; LYAchvmntR)
            {
            }
            column(QTDAchvmntR; QTDAchvmntR)
            {
            }
            column(TMStart; TMStart)
            {
            }
            column(CFY; CFY)
            {
            }
            column(LFY; LFY)
            {
            }
            column(PCHName; SalespersonPurchaser.Name)
            {
            }
            column(QtrTarget; "Qtr Target")
            {
            }
            column(MnthSalesPlan; "Month Sales Plan")
            {
            }
            column(MnthCltnPlan; "Month Collection Plan")
            {
            }
            column(FYTGT; Customer."Minmum Amt pur value")
            {
            }
            column(ZoneFilter; ZoneFilter)
            {
            }
            column(PCHFilter; PCHFilter)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //MESSAGE('%1 = %2', QTDStart, QTDEnd);
                LYAchvmnt := 0;
                CLEAR(SalesJournalData);
                SalesJournalData.SETRANGE(CustFilter, "No.");
                SalesJournalData.SETRANGE(PostingDateFilter, LFYStart, LFYEnd);
                SalesJournalData.OPEN;
                WHILE SalesJournalData.READ DO BEGIN
                    //IF (SalesJournalData.Customer_Type = 'DEALER') OR (SalesJournalData.Customer_Type = 'DISTIBUTOR') OR
                    // (SalesJournalData.Customer_Type = 'PROJ.DLR') OR (SalesJournalData.Customer_Type = 'PROJECT') OR (SalesJournalData.Customer_Type = 'SUBDLR') THEN
                    LYAchvmnt += SalesJournalData.LineAmount;
                END;

                ////--LYReturn -->>>>
                LYAchvmntR := 0;
                CLEAR(SalesRetJnl);
                SalesRetJnl.SETRANGE(CustomerNo, "No.");
                SalesRetJnl.SETRANGE(PostingDateFilter, LFYStart, LFYEnd);
                SalesRetJnl.OPEN;
                WHILE SalesRetJnl.READ DO BEGIN
                    LYAchvmntR += SalesRetJnl.LineAmount;
                END;


                //--TYReturn-----<<<<
                QTDAchvmnt := 0;
                CLEAR(SalesJournalData);
                SalesJournalData.SETRANGE(CustFilter, "No.");
                SalesJournalData.SETRANGE(PostingDateFilter, QTDStart, QTDEnd);
                SalesJournalData.OPEN;
                WHILE SalesJournalData.READ DO BEGIN
                    QTDAchvmnt += SalesJournalData.LineAmount;
                END;

                //--QTDReturn-->>>
                QTDAchvmntR := 0;
                CLEAR(SalesRetJnl);
                SalesRetJnl.SETRANGE(CustomerNo, "No.");
                SalesRetJnl.SETRANGE(PostingDateFilter, QTDStart, QTDEnd);
                SalesRetJnl.OPEN;
                WHILE SalesRetJnl.READ DO BEGIN
                    QTDAchvmntR += SalesRetJnl.LineAmount;
                END;

                TMAchvmnt := 0;
                CLEAR(SalesJournalData);
                SalesJournalData.SETRANGE(CustFilter, "No.");
                SalesJournalData.SETRANGE(PostingDateFilter, TMStart, TMEnd);
                SalesJournalData.OPEN;
                WHILE SalesJournalData.READ DO BEGIN
                    TMAchvmnt += SalesJournalData.LineAmount;
                END;

                //--TMReturn-->>>
                TMAchvmntR := 0;
                CLEAR(SalesRetJnl);
                SalesRetJnl.SETRANGE(CustomerNo, "No.");
                SalesRetJnl.SETRANGE(PostingDateFilter, TMStart, TMEnd);
                SalesRetJnl.OPEN;
                WHILE SalesRetJnl.READ DO BEGIN
                    TMAchvmntR += SalesRetJnl.LineAmount;
                END;

                //------Collection------->>>

                L3MCol := 0;
                CMCol := 0;
                OSAmt := 0;
                MonthDue := 0;
                TotalOverDue := 0;
                OverDueAmt := 0;


                CLEAR(DebtorsColData);
                DebtorsColData.SETRANGE(CustFilter, "No.");
                DebtorsColData.SETRANGE(DueDate, 0D, EndDt - 89);
                DebtorsColData.OPEN;
                WHILE DebtorsColData.READ DO BEGIN
                    //IF (DebtorsColData.Customer_Type = 'DEALER') OR (DebtorsColData.Customer_Type = 'DISTIBUTOR') OR
                    //(DebtorsColData.Customer_Type = 'PROJ.DLR') OR (DebtorsColData.Customer_Type = 'PROJECT') OR (DebtorsColData.Customer_Type = 'SUBDLR') THEN
                    L3MCol += DebtorsColData.Sum_Remaining_Amt_LCY;
                END;

                CLEAR(DebtorsColData);
                DebtorsColData.SETRANGE(CustFilter, "No.");
                DebtorsColData.SETRANGE(PostDateFilter, TMStart, TMEnd);
                DebtorsColData.SETFILTER(DebtorsColData.Document_Type, '%1|%2', DebtorsColData.Document_Type::Payment, DebtorsColData.Document_Type::Refund);
                DebtorsColData.OPEN;
                WHILE DebtorsColData.READ DO BEGIN
                    CMCol += DebtorsColData.Sum_Amount;
                END;

                CLEAR(DebtorsColData);
                DebtorsColData.SETRANGE(CustFilter, "No.");
                DebtorsColData.SETRANGE(PostDateFilter, 0D, EndDt);
                DebtorsColData.SETRANGE(OpenFilter, TRUE);
                DebtorsColData.OPEN;
                WHILE DebtorsColData.READ DO BEGIN
                    //IF (DebtorsColData.Customer_Type = 'DEALER') OR (DebtorsColData.Customer_Type = 'DISTIBUTOR') OR
                    //(DebtorsColData.Customer_Type = 'PROJ.DLR') OR (DebtorsColData.Customer_Type = 'PROJECT') OR (DebtorsColData.Customer_Type = 'SUBDLR') THEN
                    OSAmt += DebtorsColData.Sum_Remaining_Amt_LCY;
                END;

                CLEAR(DebtorsColData);
                DebtorsColData.SETRANGE(CustFilter, "No.");
                DebtorsColData.SETRANGE(DueDate, DueMStart, DueMEnd);
                DebtorsColData.SETRANGE(OpenFilter, TRUE);
                DebtorsColData.OPEN;
                WHILE DebtorsColData.READ DO BEGIN
                    //IF (DebtorsColData.Customer_Type = 'DEALER') OR (DebtorsColData.Customer_Type = 'DISTIBUTOR') OR
                    //(DebtorsColData.Customer_Type = 'PROJ.DLR')OR (DebtorsColData.Customer_Type = 'PROJECT')OR (DebtorsColData.Customer_Type = 'SUBDLR') THEN
                    MonthDue += DebtorsColData.Sum_Remaining_Amt_LCY;
                END;

                CLEAR(DebtorsColData);
                DebtorsColData.SETRANGE(CustFilter, "No.");
                DebtorsColData.SETRANGE(DueDate, 0D, EndDt);
                DebtorsColData.SETRANGE(OpenFilter, TRUE);
                DebtorsColData.OPEN;
                WHILE DebtorsColData.READ DO BEGIN
                    TotalOverDue += DebtorsColData.Sum_Remaining_Amt_LCY;
                END;
                //MSVRN

                //----Overdue----->>>
                CLEAR(DebtorsColData);
                DebtorsColData.SETRANGE(DebtorsColData.Due_Date, 0D, EndDt - 1);
                //DebtorsColData.SETRANGE(DebtorsColData.No,Customer."No.");
                //, DebtorsColData.Document_Type::"Credit Memo");
                DebtorsColData.SETRANGE(CustFilter, "No.");
                DebtorsColData.SETRANGE(OpenFilter, TRUE);
                DebtorsColData.OPEN;
                WHILE DebtorsColData.READ DO BEGIN
                    // IF (DebtorsColData.Customer_Type = 'DEALER') OR (DebtorsColData.Customer_Type = 'DISTIBUTOR') OR
                    // (DebtorsColData.Customer_Type = 'PROJ.DLR')OR (DebtorsColData.Customer_Type = 'PROJECT')OR (DebtorsColData.Customer_Type = 'SUBDLR')THEN
                    OverDueAmt += DebtorsColData.Sum_Remaining_Amt_LCY
                END;
                //----Overdue-----<<<
                //-----Collection---<<<<<

                IF SalespersonPurchaser.GET(Customer."PCH Code") THEN;
            end;

            trigger OnPreDataItem()
            begin
                Customer.SETFILTER("PCH Code", PCHFilter);

                IF EndDt = 0D THEN
                    EndDt := TODAY;

                Day := DATE2DMY(EndDt, 1);
                Month := DATE2DMY(EndDt, 2);
                Year := DATE2DMY(EndDt, 3);

                CASE Month OF
                    1, 2, 3:
                        BEGIN
                            LFYStart := DMY2DATE(1, 4, Year - 2);
                            LFYEnd := DMY2DATE(31, 3, Year - 1);
                            CFY := Year;
                            LFY := Year - 1;
                        END ELSE BEGIN
                        LFYStart := DMY2DATE(1, 4, Year - 1);
                        LFYEnd := DMY2DATE(31, 3, Year);
                        CFY := Year + 1;
                        LFY := Year;
                    END;
                END;

                CASE Month OF
                    4, 5, 6:
                        BEGIN
                            QTDStart := DMY2DATE(1, 4, Year);
                            QTDEnd := EndDt;
                            Quarter := 1;
                        END;
                    7, 8, 9:
                        BEGIN
                            QTDStart := DMY2DATE(1, 7, Year);
                            QTDEnd := EndDt;
                            Quarter := 2;
                        END;
                    10, 11, 12:
                        BEGIN
                            QTDStart := DMY2DATE(1, 10, Year);
                            QTDEnd := EndDt;
                            Quarter := 3;
                        END;
                    1, 2, 3:
                        BEGIN
                            QTDStart := DMY2DATE(1, 1, Year);
                            QTDEnd := EndDt;
                            Quarter := 4;
                        END;
                END;

                TMStart := DMY2DATE(1, Month, Year);
                TMEnd := EndDt;

                DueMStart := EndDt + 1;
                DueMEnd := DMY2DATE(CalcDays(Month), Month, Year);
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
                field(Today; EndDt)
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
        ZoneFilter := Customer.GETFILTER(Zone);
        PCHFilter := Customer.GETFILTER("PCH Code");
    end;

    var
        DebtorsColData: Query "Debtors Collection MGT 1";
        Day: Integer;
        Month: Integer;
        Year: Integer;
        StartDt: Date;
        EndDt: Date;
        LFYStart: Date;
        LFYEnd: Date;
        QTDStart: Date;
        QTDEnd: Date;
        LYAchvmnt: Decimal;
        QTDAchvmnt: Decimal;
        TMAchvmnt: Decimal;
        L3MCol: Decimal;
        CMCol: Decimal;
        OSAmt: Decimal;
        MonthDue: Decimal;
        TotalOverDue: Decimal;
        Quarter: Integer;
        OverDueAmt: Decimal;
        SalesJournalData: Query "Sales Journal Data 1";
        TMStart: Date;
        TMEnd: Date;
        SalesRetJnl: Query "Sales Return Jrnl Data1";
        LYAchvmntR: Decimal;
        QTDAchvmntR: Decimal;
        TMAchvmntR: Decimal;
        CFY: Integer;
        DueMStart: Date;
        DueMEnd: Date;
        LFY: Integer;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        ZoneFilter: Text;
        PCHFilter: Text;

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
}

