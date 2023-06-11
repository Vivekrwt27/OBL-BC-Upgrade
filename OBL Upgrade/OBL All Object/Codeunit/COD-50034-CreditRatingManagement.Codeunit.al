codeunit 50034 "Credit Rating Management"
{

    trigger OnRun()
    begin
        //ProcessRatings(310318D);
        IF GUIALLOWED THEN
            MESSAGE('Done');
    end;

    var
        RecCustomer: Record Customer;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        TurnOverFromDate: Date;
        TurnOverToDate: Date;
        CreditDays: Integer;
        CreditProdVallue: Decimal;
        NoofDaysJoin: Integer;


    procedure ProcessRatings(Customer: Record Customer; FDate: Date; TDate: Date; Freeze: Boolean)
    var
        CustomerCreditRating: Record "Customer Credit Rating";
        ProcessCustomerCreditRating: Record "Customer Credit Rating";
    begin
        CustomerCreditRating.RESET;
        CustomerCreditRating.SETRANGE("Customer No.", Customer."No.");
        CustomerCreditRating.SETRANGE(Date, TDate);
        CustomerCreditRating.SETRANGE(Static, FALSE);
        IF CustomerCreditRating.FINDFIRST THEN
            CustomerCreditRating.DELETEALL;

        TurnOverFromDate := CalCulateFinancialYear(FDate);
        TurnOverToDate := DMY2DATE(31, 3, DATE2DMY(TurnOverFromDate, 3) + 1);
        //ERROR('%1..%2',TurnOverFromDate,TurnOverToDate);
        CreateCreditRatingDetails(Customer, FDate, TDate);

        ProcessCustomerCreditRating.RESET;
        ProcessCustomerCreditRating.SETRANGE("Customer No.", Customer."No.");
        ProcessCustomerCreditRating.SETRANGE(Date, TDate);
        ProcessCustomerCreditRating.SETRANGE(Static, FALSE);
        IF ProcessCustomerCreditRating.FINDFIRST THEN BEGIN
            REPEAT
                ProcessCustomerCreditRating."Credit Class Score" := (0.5 * ProcessCustomerCreditRating."Payment Term Score" +
                                                                    0.3 * ProcessCustomerCreditRating."Credit Utilisation Score" +
                                                                    0.2 * ProcessCustomerCreditRating."Average Account Age");


                CASE ProcessCustomerCreditRating."Credit Class Score" OF
                    100 .. 80:
                        ProcessCustomerCreditRating."Credit Class Rating" := ProcessCustomerCreditRating."Credit Class Rating"::A;
                    60 .. 79.99:
                        ProcessCustomerCreditRating."Credit Class Rating" := ProcessCustomerCreditRating."Credit Class Rating"::B;
                    40 .. 59.99:
                        ProcessCustomerCreditRating."Credit Class Rating" := ProcessCustomerCreditRating."Credit Class Rating"::C;
                    20 .. 39.99:
                        ProcessCustomerCreditRating."Credit Class Rating" := ProcessCustomerCreditRating."Credit Class Rating"::D;
                    0 .. 19.99:
                        ProcessCustomerCreditRating."Credit Class Rating" := ProcessCustomerCreditRating."Credit Class Rating"::E;
                END;
                IF Freeze THEN
                    FreezeCreditRating(ProcessCustomerCreditRating);
                ProcessCustomerCreditRating.Static := Freeze;
                ProcessCustomerCreditRating.MODIFY;
            UNTIL ProcessCustomerCreditRating.NEXT = 0;

            ProcessCustomerCreditRating.RESET;
            ProcessCustomerCreditRating.SETRANGE(Date, TDate);
            ProcessCustomerCreditRating.SETRANGE(Static, FALSE);
            IF ProcessCustomerCreditRating.FINDFIRST THEN BEGIN
                REPEAT
                    IF ProcessCustomerCreditRating."Customer No." <> ProcessCustomerCreditRating."Parent Customer No." THEN BEGIN
                        UpdateParentData(ProcessCustomerCreditRating."Parent Customer No.", TDate);
                    END;
                UNTIL ProcessCustomerCreditRating.NEXT = 0;
            END;
        END;
    end;


    procedure CreateCreditRatingDetails(Customer: Record Customer; FDate: Date; DtDate: Date)
    var
        CustomerCreditRating: Record "Customer Credit Rating";
        TurnOverAmt: Decimal;
        FirstBillDate: Date;
        AgedDays: Integer;
    begin
        IF CustomerCreditRating.GET(Customer."No.", DtDate) THEN
            IF NOT CustomerCreditRating.Static THEN
                CustomerCreditRating.DELETE ELSE
                EXIT;
        NoofDaysJoin := 0;
        CustomerCreditRating.INIT;
        CustomerCreditRating."Customer No." := Customer."No.";
        CustomerCreditRating.Date := DtDate;
        TurnOverAmt := CalculateTurnOver(Customer."No.", TurnOverFromDate, TurnOverToDate);
        CustomerCreditRating.TurnOver := TurnOverAmt;
        CustomerCreditRating."Turn-Over Rating" := CalculateTurnOverRating(TurnOverAmt);
        FirstBillDate := DtDate;
        CustomerCreditRating."Average Account Age" := CalculateAvgAccountAge(Customer."No.", FirstBillDate);
        CustomerCreditRating."Date of Joining" := FirstBillDate;

        CustomerCreditRating."Wt. Avg. Due Payment Term(Days" := CalculateWtAvgPaymentTerm(Customer."No.", FDate, DtDate);
        CustomerCreditRating."Wt. Avg. Collection Term(Days)" := CalculateWtAvgCollectionTerm(Customer."No.", FDate, DtDate);

        CustomerCreditRating."Payment Term Score" := CalculatePaymentScore(CustomerCreditRating."Wt. Avg. Due Payment Term(Days", CustomerCreditRating."Wt. Avg. Collection Term(Days)");

        CustomerCreditRating."Credit Utilisation Percentage" := CalculateWtCreditRating(Customer."No.", FDate, DtDate);
        CustomerCreditRating."Credit Utilisation Score" := CalculateCreditUtilisationScore(CustomerCreditRating."Credit Utilisation Percentage");
        CustomerCreditRating."Credit Amt" := CreditProdVallue;
        CustomerCreditRating."No. of Days" := NoofDaysJoin;
        CustomerCreditRating."Parent Customer No." := Customer."Parent Customer No.";
        IF Customer."Parent Customer No." = '' THEN
            CustomerCreditRating."Parent Customer No." := Customer."No.";

        CustomerCreditRating.INSERT;
    end;


    procedure CalculatePaymentScore(DuePayScore: Decimal; CollectionScore: Decimal): Decimal
    var
        TempAmt: Decimal;
    begin
        TempAmt := CollectionScore - DuePayScore;
        IF TempAmt = 0 THEN
            EXIT(0);
        CASE TempAmt OF
            0.01 .. 0.9999:
                EXIT(100);
            1 .. 5:
                EXIT(90);
            5 .. 10.999:
                EXIT(80);
            11 .. 20.999:
                EXIT(60);
            21 .. 30.999:
                EXIT(40);
            31 .. 60.999:
                EXIT(20);
            70 .. 9999999999.0:
                EXIT(0);
        END;
    end;


    procedure CalculateCreditUtilisationScore(CreditutilPer: Decimal): Decimal
    begin
        CASE CreditutilPer OF
            0.01 .. 20:
                EXIT(100);
            21 .. 30.99:
                EXIT(90);
            31 .. 40.999:
                EXIT(80);
            41 .. 50.999:
                EXIT(70);
            51 .. 60.999:
                EXIT(60);
            61 .. 70.999:
                EXIT(50);
            71 .. 80.999:
                EXIT(40);
            81 .. 90.99:
                EXIT(30);
            91 .. 95.99:
                EXIT(20);
            96 .. 9999999999.0:
                EXIT(0);

        END;
    end;


    procedure CalculateAvgAccountAgeScore(CustomerNo: Code[20]; var DtDate: Date; AgedDays: Integer) AgeScore: Decimal
    begin
        CASE AgedDays OF
            0 .. 365:
                EXIT(0);
            366 .. 546:
                EXIT(20);
            547 .. 726:
                EXIT(30);
            727 .. 907:
                EXIT(40);
            908 .. 1088:
                EXIT(50);
            1089 .. 1269:
                EXIT(60);
            1270 .. 1450:
                EXIT(70);
            1451 .. 1631:
                EXIT(80);
            1632 .. 1812:
                EXIT(90);
            1813 .. 99999:
                EXIT(100);

        END;
    end;


    procedure CalculateAvgAccountAge(CustomerNo: Code[20]; var DtDate: Date): Decimal
    var
        SalesInvHeader: Record "Sales Invoice Header";
        TempDate: Date;
        AgedDays: Integer;
        RecCustomer: Record Customer;
    begin
        TempDate := DtDate;
        AgedDays := 0;
        //SalesInvHeader.RESET;
        //SalesInvHeader.SETCURRENTKEY("Sell-to Customer No.","Posting Date");
        //SalesInvHeader.SETRANGE("Sell-to Customer No.",CustomerNo);
        //IF SalesInvHeader.FINDFIRST THEN
        IF RecCustomer.GET(CustomerNo) THEN
            DtDate := RecCustomer."Creation Date"
        ELSE
            DtDate := 0D;

        IF DtDate <> 0D THEN
            AgedDays := TempDate - DtDate + 1;
        NoofDaysJoin := AgedDays;
        CASE AgedDays OF
            0 .. 365:
                EXIT(0);
            366 .. 546:
                EXIT(20);
            547 .. 726:
                EXIT(30);
            727 .. 907:
                EXIT(40);
            908 .. 1088:
                EXIT(50);
            1089 .. 1269:
                EXIT(60);
            1270 .. 1450:
                EXIT(70);
            1451 .. 1631:
                EXIT(80);
            1632 .. 1812:
                EXIT(90);
            1813 .. 99999:
                EXIT(100);

        END;
    end;


    procedure CalculateTurnOver(CustomerNo: Code[20]; FromDate: Date; ToDate: Date): Decimal
    var
        SalesInvLine: Record "Sales Invoice Line";
        Amt: Decimal;
        SalesJournalData: Query "Sales Journal Data";
    begin
        CLEAR(SalesJournalData);
        SalesJournalData.SETFILTER(SalesJournalData.CustomerNo, '%1', CustomerNo);
        SalesJournalData.SETFILTER(SalesJournalData.PostingDateFilter, '%1..%2', FromDate, ToDate);
        SalesJournalData.OPEN;
        WHILE SalesJournalData.READ DO
            // 15578    Amt += SalesJournalData.AmountToCustomer;
            EXIT(Amt);
        /*
        SalesInvLine.RESET;
        SalesInvLine.SETCURRENTKEY(State,"Sell-to Customer No.","Size Code","Unit of Measure Code","Posting Date");
        SalesInvLine.SETFILTER("Sell-to Customer No.",'%1',CustomerNo);
        SalesInvLine.SETFILTER("Posting Date",'%1..%2',FromDate,ToDate);
        IF SalesInvLine.FINDFIRST THEN BEGIN
           SalesInvLine.CALCSUMS(SalesInvLine."Amount To Customer");
           EXIT(SalesInvLine."Amount To Customer");
        
        REPEAT
          Amt += SalesInvLine."Amount To Customer";
        UNTIL SalesInvLine.NEXT=0;
        */
        //END;
        //EXIT(Amt);

    end;


    procedure CalculateTurnOverRating(TurnAmt: Decimal): Integer
    var
        TurnRating: Option;
    begin
        CASE TurnAmt OF
            1 .. 10000000:
                EXIT(4);
            10000000 .. 20000000:
                EXIT(3);
            20000000 .. 40000000:
                EXIT(2);
            40000000 .. 9999999999.0:
                EXIT(1);
            0 .. 1:
                EXIT(0);
        END;
    end;


    procedure CalculateTotalWeightInvoiceValue(CustomerNo: Code[20]; FromDate: Date; ToDate: Date; BlnOpen: Boolean) Amt: Decimal
    begin
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Currency Code");
        CustLedgerEntry.SETFILTER("Customer No.", CustomerNo);
        CustLedgerEntry.SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
        CustLedgerEntry.SETFILTER("Document Type", '%1', CustLedgerEntry."Document Type"::Invoice);
        IF BlnOpen THEN
            CustLedgerEntry.SETFILTER("Due Date", '%1..%2', 0D, ToDate);

        IF CustLedgerEntry.FINDFIRST THEN
            REPEAT
                CustLedgerEntry.CALCFIELDS(Amount, CustLedgerEntry."Remaining Amt. (LCY)");
                Amt += CustLedgerEntry.Amount;
            UNTIL CustLedgerEntry.NEXT = 0;
    end;


    procedure CalculateWtAvgPaymentTerm(CustomerNo: Code[20]; FromDate: Date; ToDate: Date): Decimal
    var
        TempAmt: Decimal;
        TotWtAmt: Decimal;
        SalesInvHeader: Record "Sales Invoice Header";
        CollectionDate: Date;
    begin
        TotWtAmt := CalculateTotalWeightInvoiceValue(CustomerNo, FromDate, ToDate, FALSE);
        IF TotWtAmt = 0 THEN
            EXIT;

        CustLedgerEntry.RESET;
        CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Currency Code");
        CustLedgerEntry.SETFILTER("Document Type", '%1', CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SETFILTER("Customer No.", CustomerNo);
        CustLedgerEntry.SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
        IF CustLedgerEntry.FINDFIRST THEN
            REPEAT
                CustLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)", CustLedgerEntry."Amount (LCY)");
                TempAmt += ((CustLedgerEntry."Due Date" - CustLedgerEntry."Posting Date") * (CustLedgerEntry."Amount (LCY)"));
            UNTIL CustLedgerEntry.NEXT = 0;
        IF TotWtAmt <> 0 THEN
            EXIT(TempAmt / TotWtAmt);
    end;


    procedure CalculateWtAvgCollectionTerm(CustomerNo: Code[20]; FromDate: Date; ToDate: Date): Decimal
    var
        TempAmt: Decimal;
        TotWtAmt: Decimal;
        SalesInvHeader: Record "Sales Invoice Header";
        CollectionDate: Date;
    begin
        TotWtAmt := CalculateTotalWeightInvoiceValue(CustomerNo, FromDate, ToDate, TRUE);
        IF TotWtAmt = 0 THEN
            EXIT;
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Currency Code");
        CustLedgerEntry.SETFILTER("Customer No.", CustomerNo);
        CustLedgerEntry.SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
        CustLedgerEntry.SETFILTER("Document Type", '%1', CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SETFILTER("Due Date", '%1..%2', 0D, ToDate);

        IF CustLedgerEntry.FINDFIRST THEN
            REPEAT
                CollectionDate := 0D;
                SalesInvHeader.SETRANGE("No.", CustLedgerEntry."Document No.");
                IF SalesInvHeader.FINDFIRST THEN BEGIN
                    //    IF SalesInvHeader.GET(CustLedgerEntry."Document No.") THEN
                    SalesInvHeader.CALCFIELDS("Last Payment Receipt Date");
                    CollectionDate := SalesInvHeader."Last Payment Receipt Date";
                END;
                CustLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)", CustLedgerEntry."Amount (LCY)");
                IF CustLedgerEntry."Remaining Amt. (LCY)" = 0 THEN BEGIN
                    IF CollectionDate = 0D THEN
                        CollectionDate := TODAY;

                    TempAmt += ((CollectionDate - CustLedgerEntry."Posting Date") * (CustLedgerEntry."Amount (LCY)"))
                END ELSE BEGIN
                    IF CollectionDate = 0D THEN
                        TempAmt += ((TODAY - CustLedgerEntry."Posting Date") * ((CustLedgerEntry."Remaining Amt. (LCY)")))
                    ELSE
                        TempAmt += ((CollectionDate - CustLedgerEntry."Posting Date") * ((CustLedgerEntry."Amount (LCY)" - CustLedgerEntry."Remaining Amt. (LCY)")))
                                + ((TODAY - CustLedgerEntry."Posting Date") * ((CustLedgerEntry."Remaining Amt. (LCY)")));
                    //        TempAmt := TempAmt/2;
                END;
            /*
           CredSupp.INIT;
           CredSupp."Entry No." := CustLedgerEntry."Entry No.";
           CredSupp."Customer No." := CustLedgerEntry."Customer No.";
           CredSupp."Posting date" := CustLedgerEntry."Posting Date";
           CredSupp."Collection Date" := CollectionDate;
           CredSupp."Collection Prod. Amt" := TempAmt;
           CredSupp."Prod Value" := CustLedgerEntry."Remaining Amt. (LCY)";
           CredSupp."Invoice Amt" := CustLedgerEntry."Amount (LCY)";
           CredSupp.INSERT;
             */
            UNTIL CustLedgerEntry.NEXT = 0;
        IF TotWtAmt <> 0 THEN
            EXIT(TempAmt / TotWtAmt);

    end;


    procedure CalculateWtCreditRating(CustomerNo: Code[20]; FromDate: Date; ToDate: Date): Decimal
    var
        Amt: Decimal;
        NoOfDays: Integer;
        EntryNo: Integer;
        TmpDate: Date;
        TotWtAmt: Decimal;
        TmpAmt: Decimal;
        RecCustomer: Record Customer;
        NextCustLedgerEntry: Record "Cust. Ledger Entry";
        FirstDate: Date;
        OPBalance: Decimal;
        DynamicsCreditLimit: Decimal;
        OBDynamicsCreditLimit: Decimal;
        AvgOBWtCreditLimit: Decimal;
    begin
        RecCustomer.GET(CustomerNo);
        IF RecCustomer."Credit Limit (LCY)" = 0 THEN
            EXIT;
        OBDynamicsCreditLimit := GetCreditLimit(RecCustomer."No.", FromDate - 1);
        DynamicsCreditLimit := CalculateCreditHistoryAmt(RecCustomer."No.", FromDate, ToDate);
        IF DynamicsCreditLimit = 0 THEN
            EXIT;


        OPBalance := CalculateOpeningBalance(CustomerNo, FromDate - 1);
        IF OBDynamicsCreditLimit <> 0 THEN
            AvgOBWtCreditLimit := (OPBalance / OBDynamicsCreditLimit) * 100;

        CustLedgerEntry.RESET;
        CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Currency Code");
        CustLedgerEntry.SETFILTER("Customer No.", CustomerNo);
        CustLedgerEntry.SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
        IF CustLedgerEntry.FINDFIRST THEN BEGIN
            //IF OPBalance = 0 THEN
            FirstDate := CustLedgerEntry."Posting Date";

            TotWtAmt := OPBalance * (FromDate - FirstDate);
            REPEAT

                NoOfDays := 0;
                TmpDate := 0D;
                CustLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)", CustLedgerEntry."Amount (LCY)");
                NextCustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Currency Code");
                //      NextCustLedgerEntry.RESET;
                NextCustLedgerEntry.SETRANGE("Customer No.", CustomerNo);
                NextCustLedgerEntry.SETFILTER("Entry No.", '>%1', CustLedgerEntry."Entry No.");
                // NextCustLedgerEntry.SETFILTER("Posting Date",'%1..%2',FromDate,ToDate);
                IF NextCustLedgerEntry.FINDFIRST THEN
                    TmpDate := NextCustLedgerEntry."Posting Date";
                EntryNo := CustLedgerEntry."Entry No.";
                TmpAmt := CustLedgerEntry."Amount (LCY)";
                IF TmpDate <> 0D THEN
                    TmpDate := TmpDate - 1
                ELSE
                    TmpDate := CustLedgerEntry."Posting Date";

                NoOfDays := TmpDate - CustLedgerEntry."Posting Date" + 1;

                TotWtAmt += TmpAmt * NoOfDays;
            /*
            CredSupp.INIT;
            CredSupp."Entry No." := CustLedgerEntry."Entry No.";
            CredSupp."Customer No." := CustLedgerEntry."Customer No.";
            CredSupp."Posting date" := CustLedgerEntry."Posting Date";
            CredSupp."Noof Days" := NoOfDays;
            CredSupp.TmpDate := TmpDate;
        //    CredSupp."Collection Date" := CollectionDate;
        //    CredSupp."Collection Prod. Amt" := TempAmt;
            CredSupp."Prod Value" := TotWtAmt;
            CredSupp."Invoice Amt" := CustLedgerEntry."Amount (LCY)";
            CredSupp.INSERT;
             */

            UNTIL CustLedgerEntry.NEXT = 0;
        END;
        //IF OPBalance<>0 THEN
        //TotWtAmt := OPBalance *(FromDate-FirstDate) + TotWtAmt;
        CreditProdVallue := TotWtAmt;
        //


        IF (FirstDate = 0D) OR (OPBalance <> 0) THEN
            FirstDate := FromDate;

        IF (DynamicsCreditLimit <> 0) AND (ToDate - FirstDate <> 0) THEN //MSKS0611
            TotWtAmt := 100 * (TotWtAmt / (ToDate - FirstDate) / DynamicsCreditLimit);

        //IF DynamicsCreditLimit <>0 THEN
        //TotWtAmt := 100*(TotWtAmt / (ToDate-FirstDate) / DynamicsCreditLimit) ;

        TotWtAmt := (TotWtAmt + AvgOBWtCreditLimit) / 2;

        EXIT(TotWtAmt);

    end;


    procedure CalculateOpeningBalance(CustomerNo: Code[20]; FromDate: Date): Decimal
    var
        RecCustomer: Record Customer;
    begin
        RecCustomer.SETRANGE("No.", CustomerNo);
        RecCustomer.SETFILTER("Date Filter", '%1..%2', 0D, FromDate);
        IF RecCustomer.FINDFIRST THEN
            RecCustomer.CALCFIELDS(Balance);
        EXIT(RecCustomer.Balance);
    end;


    procedure CalCulateFinancialYear(StDate: Date): Date
    var
        AccPeriod: Record "Accounting Period";
    begin
        AccPeriod.RESET;
        AccPeriod.SETFILTER(AccPeriod."Starting Date", '<=%1', StDate);
        AccPeriod.SETFILTER("New Fiscal Year", '%1', TRUE);
        IF AccPeriod.FINDLAST THEN
            EXIT(AccPeriod."Starting Date");
    end;


    procedure FreezeCreditRating(var CustRating: Record "Customer Credit Rating")
    var
        Cust: Record Customer;
    begin
        Cust.GET(CustRating."Customer No.");
        IF Cust."Last Credit Rating Process" < TurnOverToDate THEN BEGIN
            Cust."Credit Rating" := FORMAT(CustRating."Turn-Over Rating") + FORMAT(CustRating."Credit Class Rating");
            Cust."Last Credit Rating Process" := TurnOverToDate;
            Cust.MODIFY;
        END;
    end;


    procedure UpdateParentData(ParentCode: Code[20]; DtDate: Date)
    var
        CCR: Record "Customer Credit Rating";
        TotTurnOver: Decimal;
        I: Integer;
        AvgPayTerm: Decimal;
        AvgCollectionTerm: Decimal;
        AvgCreditUtilPer: Decimal;
        DtOfJoin: Date;
        AvgAgedScore: Decimal;
    begin
        CCR.RESET;
        CCR.SETRANGE("Parent Customer No.", ParentCode);
        CCR.SETRANGE(CCR.Date, DtDate);
        IF CCR.FINDFIRST THEN BEGIN
            DtOfJoin := CCR."Date of Joining";
            AvgAgedScore := CCR."Average Account Age";
            REPEAT
                TotTurnOver += CCR.TurnOver;
                I += 1;
                AvgPayTerm += CCR."Wt. Avg. Due Payment Term(Days";
                AvgCollectionTerm += CCR."Wt. Avg. Collection Term(Days)";
                AvgCreditUtilPer += CCR."Credit Utilisation Percentage";
                IF AvgAgedScore <= CCR."Average Account Age" THEN
                    AvgAgedScore := CCR."Average Account Age";

            UNTIL CCR.NEXT = 0;
        END;



        CCR.RESET;
        CCR.SETRANGE("Parent Customer No.", ParentCode);
        CCR.SETRANGE(CCR.Date, DtDate);
        IF CCR.FINDFIRST THEN BEGIN
            REPEAT
                CCR."Total Turnover" := TotTurnOver;
                CCR."Parent Turn-Over Rating" := CalculateTurnOverRating(TotTurnOver);
                CCR."Parent Average Account Age" := AvgAgedScore;
                CCR."Parent Wt. Avg. Due P.T.(Days)" := AvgPayTerm / I;
                CCR."Parent Wt. Avg. C.T.(Days)" := AvgCollectionTerm / I;
                CCR."Parent Credit Util. Percentage" := AvgCreditUtilPer / I;

                CCR."Parent Payment Term Score" := CalculatePaymentScore(CCR."Parent Wt. Avg. Due P.T.(Days)", CCR."Parent Wt. Avg. C.T.(Days)");

                CCR."Parent Credit Util. Score" := CalculateCreditUtilisationScore(CCR."Parent Credit Util. Percentage");

                CCR."Parent Credit Class Score" := (0.5 * CCR."Parent Payment Term Score" +
                                                                    0.3 * CCR."Parent Credit Util. Score" +
                                                                    0.2 * CCR."Parent Average Account Age");


                CASE CCR."Parent Credit Class Score" OF
                    100 .. 80:
                        CCR."Parent Credit Class Rating" := CCR."Parent Credit Class Rating"::A;
                    60 .. 79.99:
                        CCR."Parent Credit Class Rating" := CCR."Parent Credit Class Rating"::B;
                    40 .. 59.99:
                        CCR."Parent Credit Class Rating" := CCR."Parent Credit Class Rating"::C;
                    20 .. 39.99:
                        CCR."Parent Credit Class Rating" := CCR."Parent Credit Class Rating"::D;
                    0 .. 19.99:
                        CCR."Parent Credit Class Rating" := CCR."Parent Credit Class Rating"::E;
                END;


                /*

                CustomerCreditRating."Wt. Avg. Due Payment Term(Days" := CalculateWtAvgPaymentTerm(Customer."No.",FDate,DtDate);
                CustomerCreditRating."Wt. Avg. Collection Term(Days)"  := CalculateWtAvgCollectionTerm(Customer."No.",FDate,DtDate);

                CustomerCreditRating."Payment Term Score" :=  CalculatePaymentScore(CustomerCreditRating."Wt. Avg. Due Payment Term(Days",CustomerCreditRating."Wt. Avg. Collection Term(Days)");

                CustomerCreditRating."Credit Utilisation Percentage" := CalculateWtCreditRating(Customer."No.",FDate,DtDate);
                CustomerCreditRating."Credit Utilisation Score" := CalculateCreditUtilisationScore(CustomerCreditRating."Credit Utilisation Percentage");

                */
                CCR.MODIFY;
            UNTIL CCR.NEXT = 0;
        END;

    end;


    procedure CalculateCreditHistoryAmt(CustomerNo: Code[20]; FDate: Date; TDate: Date) Amt: Decimal
    var
        CCH: Record "Customer Credit History";
        CreditLimit: Decimal;
        i: Integer;
        TmpDate: Date;
    begin
        TmpDate := FDate;
        FOR i := 1 TO (TDate - FDate + 1) DO BEGIN
            TmpDate := FDate + i;
            Amt += GetCreditLimit(CustomerNo, TmpDate);
        END;
        IF (TDate - FDate + 1) > 0 THEN
            Amt := Amt / (TDate - FDate + 1);
        EXIT(Amt);
    end;


    procedure GetCreditLimit(CustomerNo: Code[20]; DtDate: Date): Decimal
    var
        CCH: Record "Customer Credit History";
    begin
        CCH.RESET;
        CCH.SETRANGE(CCH."Customer No.", CustomerNo);
        CCH.SETFILTER("Starting date", '%1..%2', 0D, DtDate);
        IF CCH.FINDLAST THEN
            EXIT(CCH."Credit Limit (LCY)");
    end;
}

