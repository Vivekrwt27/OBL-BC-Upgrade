report 50100 Collection
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\Collection.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Matrix Master"; 50003)
        {
            DataItemTableView = SORTING("Type 1")
                                ORDER(Ascending)
                                WHERE(Description = FILTER(<> ''));
            RequestFilterFields = "Mapping Type";
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
            column(Target; TotalTGT)
            {
            }
            column(MTD; MTD / 100000)
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
            column(Month; Month)
            {
            }
            column(MnthTxt; MnthTxt)
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
            column(L3MCol; ABS(L3MCol))
            {
            }
            column(ZhName; SalespersonPurchaser.Name)
            {
            }
            column(OSAmt; ABS(OSAmt))
            {
            }
            column(StartDt; StartDt)
            {
            }
            column(MonthDue; ABS(MonthDue))
            {
            }
            column(TotalOverDue; ABS(TotalOverDue))
            {
            }
            column(OverDueAmt; OverDueAmt)
            {
            }
            column(OSAmtCK; OSAmtCK)
            {
            }
            column(MonthDueCK; MonthDueCK)
            {
            }
            column(TotalOverDueCK; TotalOverDueCK)
            {
            }
            column(L3MColCK; L3MColCK)
            {
            }
            column(OverDueAmtCK; OverDueAmtCK)
            {
            }
            column(Col1To8; "Matrix Master"."Collection Phasing 1-7")
            {
            }
            column(Col9To16; "Matrix Master"."Collection Phasing 8-14")
            {
            }
            column(Col17To23; "Matrix Master"."Collection Phasing 15-21")
            {
            }
            column(Col24To31; "Matrix Master"."Collection Phasing 22-27")
            {
            }
            column(Col28To30; "Matrix Master"."Collection Phasing 28-30")
            {
            }
            column(TargetCKA; TargetCKA)
            {
            }
            column(Col1To8CKA; Col1To8CKA)
            {
            }
            column(Col9To16CKA; Col9To16CKA)
            {
            }
            column(Col17To23CKA; Col17To23CKA)
            {
            }
            column(Col24To31CKA; Col24To31CKA)
            {
            }
            column(Col28To30CKA; Col28To30CKA)
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
                InitialisedVariables;

                CLEAR(SalespersonPurchaser);
                IF SalespersonPurchaser.GET("Matrix Master".ZH) THEN;

                IF "Matrix Master"."Type 1" <> 'CKA' THEN BEGIN
                    //CurrReport.SKIP;


                    //------Collection------->>>
                    CLEAR(DebtorsCollection);
                    DebtorsCollection.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    DebtorsCollection.SETRANGE(DueDate, 0D, EndDt - 89);
                    DebtorsCollection.OPEN;
                    WHILE DebtorsCollection.READ DO BEGIN
                        IF (DebtorsCollection.Customer_Type = 'DEALER') OR (DebtorsCollection.Customer_Type = 'DISTIBUTOR') OR
                          (DebtorsCollection.Customer_Type = 'PROJ.DLR') OR (DebtorsCollection.Customer_Type = 'PROJECT') OR (DebtorsCollection.Customer_Type = 'SUBDLR') THEN
                            L3MCol += DebtorsCollection.Sum_Remaining_Amt_LCY
                        ELSE
                            IF (DebtorsCollection.Customer_Type = 'GET') OR (DebtorsCollection.Customer_Type = 'SET') OR (DebtorsCollection.Customer_Type = 'PET') OR (DebtorsCollection.Customer_Type = 'DIRECTPROJ') OR
                               (DebtorsCollection.Customer_Type = 'HOPROJECT') THEN
                                L3MColCK += DebtorsCollection.Sum_Remaining_Amt_LCY;
                    END;

                    CLEAR(DebtorsCollection);
                    DebtorsCollection.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    DebtorsCollection.SETRANGE(PostDateFilter, StartDt, EndDt);
                    DebtorsCollection.SETRANGE(No, 'C101301000100786');
                    DebtorsCollection.SETFILTER(Document_Type, '%1|%2', Doctypeenum::Payment, Doctypeenum::Refund);
                    DebtorsCollection.OPEN;
                    WHILE DebtorsCollection.READ DO BEGIN
                        IF (DebtorsCollection.Customer_Type = 'DEALER') OR (DebtorsCollection.Customer_Type = 'DISTIBUTOR') OR
                          (DebtorsCollection.Customer_Type = 'PROJ.DLR') OR (DebtorsCollection.Customer_Type = 'PROJECT') OR (DebtorsCollection.Customer_Type = 'SUBDLR') THEN BEGIN
                            CMCol += DebtorsCollection.Sum_Amount;
                        END ELSE
                            IF (DebtorsCollection.Customer_Type = 'GET') OR (DebtorsCollection.Customer_Type = 'SET') OR (DebtorsCollection.Customer_Type = 'PET') OR (DebtorsCollection.Customer_Type = 'DIRECTPROJ') OR
                               (DebtorsCollection.Customer_Type = 'HOPROJECT') THEN BEGIN
                                CMColCK += DebtorsCollection.Sum_Amount;
                            END;
                    END;

                    CLEAR(DebtorsCollection);
                    DebtorsCollection.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    DebtorsCollection.SETRANGE(PostDateFilter, 0D, EndDt);
                    //  DebtorsCollection.SETRANGE(OpenFilter, TRUE);
                    DebtorsCollection.OPEN;
                    WHILE DebtorsCollection.READ DO BEGIN
                        IF (DebtorsCollection.Customer_Type = 'DEALER') OR (DebtorsCollection.Customer_Type = 'DISTIBUTOR') OR
                          (DebtorsCollection.Customer_Type = 'PROJ.DLR') OR (DebtorsCollection.Customer_Type = 'PROJECT') OR (DebtorsCollection.Customer_Type = 'SUBDLR') THEN
                            OSAmt += DebtorsCollection.Sum_Remaining_Amt_LCY
                        ELSE
                            IF (DebtorsCollection.Customer_Type = 'GET') OR (DebtorsCollection.Customer_Type = 'SET') OR (DebtorsCollection.Customer_Type = 'PET') OR (DebtorsCollection.Customer_Type = 'DIRECTPROJ') OR
                                 (DebtorsCollection.Customer_Type = 'HOPROJECT') THEN
                                OSAmtCK += DebtorsCollection.Sum_Remaining_Amt_LCY;

                    END;

                    CLEAR(DebtorsCollection);
                    //   DebtorsCollection.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    //   DebtorsCollection.SETRANGE(DueDate, StartDt, EndDt);
                    DebtorsCollection.OPEN;
                    WHILE DebtorsCollection.READ DO BEGIN
                        IF (DebtorsCollection.Customer_Type = 'DEALER') OR (DebtorsCollection.Customer_Type = 'DISTIBUTOR') OR
                          (DebtorsCollection.Customer_Type = 'PROJ.DLR') OR (DebtorsCollection.Customer_Type = 'PROJECT') OR (DebtorsCollection.Customer_Type = 'SUBDLR') THEN
                            MonthDue += DebtorsCollection.Sum_Remaining_Amt_LCY
                        ELSE
                            IF (DebtorsCollection.Customer_Type = 'GET') OR (DebtorsCollection.Customer_Type = 'PET') OR (DebtorsCollection.Customer_Type = 'SET') OR (DebtorsCollection.Customer_Type = 'DIRECTPROJ') OR
                                 (DebtorsCollection.Customer_Type = 'HOPROJECT') THEN
                                MonthDueCK += DebtorsCollection.Sum_Remaining_Amt_LCY;
                    END;

                    /*
                    CLEAR(DebtorsCollection);
                    DebtorsCollection.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    DebtorsCollection.SETRANGE(DueDate, 0D, EndDt);
                    DebtorsCollection.OPEN;
                    WHILE DebtorsCollection.READ DO BEGIN
                      IF (DebtorsCollection.Customer_Type = 'DEALER') OR (DebtorsCollection.Customer_Type = 'DISTIBUTOR') OR
                        (DebtorsCollection.Customer_Type = 'PROJ.DLR')OR (DebtorsCollection.Customer_Type = 'PROJECT')OR (DebtorsCollection.Customer_Type = 'SUBDLR') THEN
                         TotalOverDue += DebtorsCollection.Sum_Remaining_Amt_LCY
                      ELSE
                      IF (DebtorsCollection.Customer_Type = 'CKA') OR (DebtorsCollection.Customer_Type = 'DIRECTPROJ') OR
                           (DebtorsCollection.Customer_Type = 'HOPROJECT') THEN
                        TotalOverDueCK += DebtorsCollection.Sum_Remaining_Amt_LCY;
                    END;
                    */

                    //MSVRN
                    //-----Collection---<<<<<

                    //----Overdue----->>>
                    OverDueAmt := 0;
                    CLEAR(DebtorsCollection);
                    DebtorsCollection.SETRANGE(AreaFilter, "Matrix Master"."Type 1");
                    DebtorsCollection.SETRANGE(DueDate, 0D, EndDt);
                    DebtorsCollection.OPEN;
                    WHILE DebtorsCollection.READ DO BEGIN
                        IF (DebtorsCollection.Customer_Type = 'DEALER') OR (DebtorsCollection.Customer_Type = 'DISTIBUTOR') OR
                          (DebtorsCollection.Customer_Type = 'PROJ.DLR') OR (DebtorsCollection.Customer_Type = 'PROJECT') OR (DebtorsCollection.Customer_Type = 'SUBDLR') THEN
                            OverDueAmt += DebtorsCollection.Sum_Remaining_Amt_LCY
                        ELSE
                            IF (DebtorsCollection.Customer_Type = 'GET') OR (DebtorsCollection.Customer_Type = 'PET') OR (DebtorsCollection.Customer_Type = 'SET') OR (DebtorsCollection.Customer_Type = 'DIRECTPROJ') OR
                                 (DebtorsCollection.Customer_Type = 'HOPROJECT') THEN
                                OverDueAmtCK += DebtorsCollection.Sum_Remaining_Amt_LCY;
                    END;
                    //----Overdue-----<<<

                END ELSE
                    IF "Matrix Master"."Type 1" = 'CKA' THEN BEGIN
                        Col1To8CKA := "Matrix Master"."Collection Phasing 1-7";
                        Col9To16CKA := "Matrix Master"."Collection Phasing 8-14";
                        Col17To23CKA := "Matrix Master"."Collection Phasing 15-21";
                        Col24To31CKA := "Matrix Master"."Collection Phasing 22-27";
                        Col28To30CKA := "Matrix Master"."Collection Phasing 28-30";
                        TargetCKA := "Matrix Master"."Collection Phasing 1-7" + "Matrix Master"."Collection Phasing 8-14" + "Matrix Master"."Collection Phasing 15-21"
                                     + "Matrix Master"."Collection Phasing 22-27" + "Matrix Master"."Collection Phasing 28-30";
                    END;

                TotalTGT := "Matrix Master"."Collection Phasing 1-7" + "Matrix Master"."Collection Phasing 8-14" + "Matrix Master"."Collection Phasing 15-21"
                               + "Matrix Master"."Collection Phasing 22-27" + "Matrix Master"."Collection Phasing 28-30";

            end;

            trigger OnPreDataItem()
            begin
                LYMStart := 0D;
                LYMEnd := 0D;

                QYStart := 0D;
                QYEnd := 0D;
                QNum := 0;
                LFYStart := 0D;
                LFYEnd := 0D;


                MnthTxt := CalcMonth(Month);
                LYTDStart := DMY2DATE(1, Month, Year - 1);
                LYTDEnd := DMY2DATE(Day, Month, Year - 1);

                LYMStart := DMY2DATE(1, Month, Year - 1);
                LYMEnd := DMY2DATE(CalcDays(Month), Month, Year - 1);

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
                field("Start Date"; StartDt)
                {
                    ApplicationArea = All;
                }
                field("End Date"; EndDt)
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
        ZoneFilter := "Matrix Master".GETFILTER(ZH);
        PCHFilter := "Matrix Master".GETFILTER(PCH);
        TypeFilter := "Matrix Master".GETFILTER("Type 1");

        EndDt := TODAY - 1;
        Day := DATE2DMY(EndDt, 1);
        Month := DATE2DMY(EndDt, 2);
        Year := DATE2DMY(EndDt, 3);
        StartDt := DMY2DATE(1, Month, Year);
    end;

    var
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
        HVPItems: Record "HVP/Discontinued Items";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        Customer: Record Customer;
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
        CYHVPAchv: Decimal;
        LYHVPAchv: Decimal;
        LYMVal: Decimal;
        MTD: Decimal;
        CYAchvmnt: Decimal;
        LQYHVPVal: Decimal;
        LFYHVPVal: Decimal;
        CFYHVPVal: Decimal;
        LMHVPVal: Decimal;
        LYMHVPVal: Decimal;
        DebtorsCollection: Query 50050;
        CMAchvmnt: Decimal;
        QYHVPVal: Decimal;
        CYMAchv: Decimal;
        CYMHVPAchv: Decimal;
        LYMCol: Decimal;
        LYCol: Decimal;
        CYCol: Decimal;
        LMCol: Decimal;
        CMCol: Decimal;
        L3MCol: Decimal;
        "-------------MSVRN-------------": Integer;
        LYMColCK: Decimal;
        LYColCK: Decimal;
        CYColCK: Decimal;
        LMColCK: Decimal;
        CMColCK: Decimal;
        LYAchvmntCK: Decimal;
        LYHVPAchvCK: Decimal;
        CYMAchvCK: Decimal;
        CYMHVPAchvCK: Decimal;
        QYValCK: Decimal;
        QYHVPValCK: Decimal;
        LQYValCK: Decimal;
        LQYHVPValCK: Decimal;
        LFYValCK: Decimal;
        LFYHVPValCK: Decimal;
        CFYValCK: Decimal;
        CFYHVPValCK: Decimal;
        LMValCK: Decimal;
        LMHVPValCK: Decimal;
        LYMValCK: Decimal;
        LYMHVPValCK: Decimal;
        CustNo: Code[20];
        CustNoLYM: Code[20];
        CustNoCYM: Code[20];
        CounterCYM: Integer;
        CounterCYMCK: Integer;
        CounterLM: Integer;
        CounterLMCK: Integer;
        CounterLYM: Integer;
        CounterLYMCK: Integer;
        "-------Return": Integer;
        LYMValR: Decimal;
        LYMHVPValR: Decimal;
        LYMValCKR: Decimal;
        LYMHVPValCKR: Decimal;
        RecCustomer: Record Customer;
        LYAchvmntR: Decimal;
        LYHVPAchvR: Decimal;
        LYAchvmntCKR: Decimal;
        LYHVPAchvCKR: Decimal;
        CYMAchvR: Decimal;
        CYMHVPAchvR: Decimal;
        CYMAchvCKR: Decimal;
        CYMHVPAchvCKR: Decimal;
        QYValR: Decimal;
        QYHVPValR: Decimal;
        QYValCKR: Decimal;
        QYHVPValCKR: Decimal;
        LQYValR: Decimal;
        LQYHVPValR: Decimal;
        LQYValCKR: Decimal;
        LQYHVPValCKR: Decimal;
        LFYValR: Decimal;
        LFYHVPValR: Decimal;
        LFYValCKR: Decimal;
        LFYHVPValCKR: Decimal;
        CFYValR: Decimal;
        CFYHVPValR: Decimal;
        CFYValCKR: Decimal;
        CFYHVPValCKR: Decimal;
        LMValR: Decimal;
        LMHVPValR: Decimal;
        LMValCKR: Decimal;
        LMHVPValCKR: Decimal;
        ZHName: Text[20];
        SPCode: Code[10];
        TargetCKA: Decimal;
        MatrixMaster: Record "Matrix Master";
        CustAgeingMGT: Query "Cust. Ageing MGT";
        OverDueAmt: Decimal;
        GBLAreaCode: Code[20];
        GBLZHCode: Code[20];
        GBLZMCode: Code[20];
        GBLPCHCode: Code[20];
        GBLSPCode: Code[20];
        CYMAchv2M: Decimal;
        CYMHVPAchv2M: Decimal;
        CYMAchvCK2M: Decimal;
        CYMHVPAchvCK2M: Decimal;
        CYMAchvR2M: Decimal;
        CYMHVPAchvR2M: Decimal;
        CYMAchvCKR2M: Decimal;
        CYMHVPAchvCKR2M: Decimal;
        "------------Collection--": Integer;
        OSAmt: Decimal;
        MonthDue: Decimal;
        TotalOverDue: Decimal;
        OSAmtCK: Decimal;
        MonthDueCK: Decimal;
        TotalOverDueCK: Decimal;
        L3MColCK: Decimal;
        OverDueAmtCK: Decimal;
        Col1To8CKA: Decimal;
        Col9To16CKA: Decimal;
        Col17To23CKA: Decimal;
        Col24To31CKA: Decimal;
        ZoneFilter: Text;
        PCHFilter: Text;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Col28To30CKA: Decimal;
        TotalTGT: Decimal;
        TypeFilter: Text;
        Doctypeenum: Enum "Document Type Enum";

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
        CYHVPAchv := 0;
        LYHVPAchv := 0;
        LYMVal := 0;
        //Target:=0;
        MTD := 0;
        CYAchvmnt := 0;
        LQYHVPVal := 0;
        LFYHVPVal := 0;
        CFYHVPVal := 0;
        LMHVPVal := 0;
        LYMHVPVal := 0;
        QYHVPVal := 0;

        CYMAchv := 0;
        CYMHVPAchv := 0;
        LYMCol := 0;
        LYCol := 0;
        CYCol := 0;
        LMCol := 0;
        CMCol := 0;
        OSAmt := 0;
        //--RK
        LYMColCK := 0;
        LYColCK := 0;
        CYColCK := 0;
        LMColCK := 0;
        CMColCK := 0;
        L3MCol := 0;
        MonthDue := 0;
        TotalOverDue := 0;
        //abc
        LYAchvmntCK := 0;
        LYHVPAchvCK := 0;
        CYMAchvCK := 0;
        CYMHVPAchvCK := 0;
        QYValCK := 0;
        QYHVPValCK := 0;
        LQYValCK := 0;
        LQYHVPValCK := 0;
        LFYValCK := 0;
        LFYHVPValCK := 0;
        CFYValCK := 0;
        CFYHVPValCK := 0;
        LMValCK := 0;
        LMHVPValCK := 0;
        LYMValCK := 0;
        LYMHVPValCK := 0;
        CYMAchv2M := 0;
        CYMHVPAchv2M := 0;
        CYMAchvCK2M := 0;
        CYMHVPAchvCK2M := 0;
        CYMAchvR2M := 0;
        CYMHVPAchvR2M := 0;
        CYMAchvCKR2M := 0;
        CYMHVPAchvCKR2M := 0;

        //---Ret
        LYMValR := 0;
        LYMHVPValR := 0;
        LYMValCKR := 0;
        LYMHVPValCKR := 0;
        LYAchvmntR := 0;
        LYHVPAchvR := 0;
        LYAchvmntCKR := 0;
        LYHVPAchvCKR := 0;
        CYMAchvR := 0;
        CYMHVPAchvR := 0;
        CYMAchvCKR := 0;
        CYMHVPAchvCKR := 0;
        //--
        LYAchvmntR := 0;
        LYHVPAchvR := 0;
        LYAchvmntCKR := 0;
        LYHVPAchvCKR := 0;
        CYMAchvR := 0;
        CYMHVPAchvR := 0;
        CYMAchvCKR := 0;
        CYMHVPAchvCKR := 0;
        QYValR := 0;
        QYHVPValR := 0;
        QYValCKR := 0;
        QYHVPValCKR := 0;
        LQYValR := 0;
        LQYHVPValR := 0;
        LQYValCKR := 0;
        LQYHVPValCKR := 0;
        LFYValR := 0;
        LFYHVPValR := 0;
        LFYValCKR := 0;
        LFYHVPValCKR := 0;
        CFYValR := 0;
        CFYHVPValR := 0;
        CFYValCKR := 0;
        CFYHVPValCKR := 0;
        LMValR := 0;
        LMHVPValR := 0;
        LMValCKR := 0;
        LMHVPValCKR := 0;
        OverDueAmt := 0;
        //ABC

        OSAmtCK := 0;
        MonthDueCK := 0;
        TotalOverDueCK := 0;
        L3MColCK := 0;
        OverDueAmtCK := 0;

        TotalTGT := 0;
        TargetCKA := 0;
        Col1To8CKA := 0;
        Col9To16CKA := 0;
        Col17To23CKA := 0;
        Col24To31CKA := 0;
        Col28To30CKA := 0;
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
}

