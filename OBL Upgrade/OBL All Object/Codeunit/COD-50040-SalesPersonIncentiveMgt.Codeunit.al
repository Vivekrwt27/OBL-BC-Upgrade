codeunit 50040 "Sales Person Incentive Mgt"
{

    trigger OnRun()
    begin
        ReportDate := CALCDATE('CM', TODAY);
        //ReportDate := CALCDATE('CM',011117D);
        FromDate := CALCDATE('CM+1D-1m', ReportDate);
        //ERROR('%1-%2',FromDate,ReportDate);
        GlobalSPIncentiveDetail.RESET;
        /*    GlobalSPIncentiveDetail.SETCURRENTKEY("Effective Month", "Posting Date");
            GlobalSPIncentiveDetail.SETFILTER("Effective Month", '%1', ReportDate);*/ // 15578
        IF GlobalSPIncentiveDetail.FINDFIRST THEN
            GlobalSPIncentiveDetail.DELETEALL;

        Cust.RESET;
        IF Cust.FINDFIRST THEN BEGIN
            REPEAT
                CreateOverDueEntry(Cust, ReportDate);
                SIH.RESET;
                SIH.SETCURRENTKEY("Sell-to Customer No.", "Posting Date");
                SIH.SETRANGE("Sell-to Customer No.", Cust."No.");
                SIH.SETFILTER("Posting Date", '%1..%2', FromDate, ReportDate);
                IF SIH.FINDFIRST THEN BEGIN
                    REPEAT
                        IF SIH."Order No." <> '' THEN
                            CreateSPIncInvEntry(SIH);
                    UNTIL SIH.NEXT = 0;
                END;
            UNTIL Cust.NEXT = 0;
        END;
        MESSAGE('Done');
    end;

    var
        SIH: Record "Sales Invoice Header";
        SalesPerson: Record "Salesperson/Purchaser";
        GlobalSPIncentiveDetail: Record "Payment Terms Location Wise";
        Cust: Record Customer;
        ReportDate: Date;
        FromDate: Date;


    procedure CreateSPIncInvEntry(SalesInvHeader: Record "Sales Invoice Header")
    var
        SPIncentiveDetail: Record "Payment Terms Location Wise";
        Customer: Record Customer;
        PCHIncentiveDetail: Record "Payment Terms Location Wise";
        ZMIncentiveDetail: Record "Payment Terms Location Wise";
    begin
        SalesInvHeader.CALCFIELDS(Amount);
        IF Customer.GET(SalesInvHeader."Sell-to Customer No.") THEN;
        SPIncentiveDetail.RESET;
        // 15578    SPIncentiveDetail.SETFILTER("State Code", '%1', SPIncentiveDetail."State Code"::"1");
        SPIncentiveDetail.SETFILTER("Location Code", '%1', Customer."Salesperson Code");
        // 15578     SPIncentiveDetail.SETFILTER("Document No.", '%1', SalesInvHeader."No.");
        IF SPIncentiveDetail.FINDFIRST THEN
            EXIT
        ELSE BEGIN
            //IF NOT SPIncentiveDetail.GET(SPIncentiveDetail."SP Type"::"Sales Person",Customer."Salesperson Code",SPIncentiveDetail."Document Type"::Invoice,SalesInvHeader."No.") THEN BEGIN //MSKS2711
            SPIncentiveDetail."Location Code" := SalesInvHeader."Salesperson Code";
            /*    SPIncentiveDetail."Customer Name" := Customer.Name;
                SPIncentiveDetail."Customer No." := SalesInvHeader."Sell-to Customer No.";
                SPIncentiveDetail."Document Type" := SPIncentiveDetail."Document Type"::"1";
                SPIncentiveDetail."Document No." := SalesInvHeader."No.";
                SPIncentiveDetail.VALIDATE("Posting Date", SalesInvHeader."Posting Date");
                SPIncentiveDetail."State Code" := SPIncentiveDetail."State Code"::"1";
                SPIncentiveDetail."Document Amount" := SalesInvHeader.Amount;
                SPIncentiveDetail."Eligible Amount" := SalesInvHeader.Amount;
                //  SPIncentiveDetail."Eligible Amount" := CalculateInvoiceBaseAmount(SalesInvHeader);
                SPIncentiveDetail."Overdue Amount" := CalculateOverDueAmount(SalesInvHeader."Sell-to Customer No.", SPIncentiveDetail."Effective Month");*/ // 15578
                                                                                                                                                            //  SPIncentiveDetail."Last 90 Days Sales" := CalculateLast90Days(SalesInvHeader."Sell-to Customer No.",SPIncentiveDetail."Effective Month"-90,SPIncentiveDetail."Effective Month");
                                                                                                                                                            /*   IF SalesPerson.GET(SPIncentiveDetail."Location Code") THEN
                                                                                                                                                                   SPIncentiveDetail."Sales Person Name" := SalesPerson.Name;
                                                                                                                                                               SPIncentiveDetail.INSERT;
                                                                                                                                                               //  END;
                                                                                                                                                               IF Customer."PCH Code" <> '' THEN BEGIN
                                                                                                                                                                   IF NOT PCHIncentiveDetail.GET(PCHIncentiveDetail."State Code"::"2", Customer."PCH Code", PCHIncentiveDetail."Document Type"::"1", SalesInvHeader."No.") THEN BEGIN
                                                                                                                                                                       PCHIncentiveDetail.INIT;
                                                                                                                                                                       PCHIncentiveDetail.TRANSFERFIELDS(SPIncentiveDetail);
                                                                                                                                                                       PCHIncentiveDetail."Location Code" := Customer."PCH Code";
                                                                                                                                                                       PCHIncentiveDetail."State Code" := PCHIncentiveDetail."State Code"::"2";
                                                                                                                                                                       IF SalesPerson.GET(PCHIncentiveDetail."Location Code") THEN
                                                                                                                                                                           PCHIncentiveDetail."Sales Person Name" := SalesPerson.Name;
                                                                                                                                                                       PCHIncentiveDetail.INSERT;
                                                                                                                                                                   END;
                                                                                                                                                               END;
            IF Customer."Zonal Manager" <> '' THEN BEGIN
                IF NOT ZMIncentiveDetail.GET(3, Customer."Zonal Manager", ZMIncentiveDetail."Document Type"::"1", SalesInvHeader."No.") THEN BEGIN
                    ZMIncentiveDetail.INIT;
                    ZMIncentiveDetail.TRANSFERFIELDS(SPIncentiveDetail);
                    ZMIncentiveDetail."Location Code" := Customer."Zonal Manager";
                    ZMIncentiveDetail."State Code" := ZMIncentiveDetail."State Code"::"3";
                    IF SalesPerson.GET(ZMIncentiveDetail."Location Code") THEN
                        ZMIncentiveDetail."Sales Person Name" := SalesPerson.Name;
                    ZMIncentiveDetail.INSERT;
                END;
            END;*/  // 15578
        END;
    end;


    procedure CalculateInvoiceBaseAmount(SalesInvHdr: Record "Sales Invoice Header") SaleableValue: Decimal
    var
        InvDisc: Decimal;
        ExAmount: Decimal;
        SalesInvLine: Record "Sales Invoice Line";
    begin
        /*    SalesInvLine.SETFILTER("Document No.", SalesInvHdr."No.");
            IF SalesInvLine.FINDFIRST THEN BEGIN
                REPEAT
                    IF NOT SalesInvLine."Free Supply" THEN BEGIN
                        IF SalesInvLine.Amount <> 0 THEN
                            ExAmount += SalesInvLine.Amount + SalesInvLine."Excise Amount"
                        ELSE
                            IF SalesInvLine."Line Discount %" <> 100 THEN
                                ExAmount += ROUND((SalesInvLine."Unit Price" * SalesInvLine.Quantity) +
                                 SalesInvLine."Excise Amount", 0.01, '=');
                    END ELSE BEGIN
                        ExAmount += SalesInvLine.Amount + SalesInvLine."Excise Amount";
                    END;
                UNTIL SalesInvLine.NEXT = 0;
            END;
            InvDisc := 0;
            SaleableValue := ExAmount - ABS(InvDisc);
            EXIT(SaleableValue);*/  // 15578
    end;


    procedure CalculateOverDueAmount(CustNo: Code[20]; DtDate: Date) OverDueAmt: Decimal
    var
        DetCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        DetCustLedgEntry.RESET;
        DetCustLedgEntry.SETCURRENTKEY("Customer No.", "Initial Entry Due Date", "Posting Date", "Currency Code");
        DetCustLedgEntry.SETFILTER("Customer No.", '%1', CustNo);
        //DetCustLedgEntry.SETFILTER("Entry Type",'%1',DetCustLedgEntry."Entry Type"::"Initial Entry");
        DetCustLedgEntry.SETFILTER(DetCustLedgEntry."Initial Entry Due Date", '<=%1', DtDate);
        IF DetCustLedgEntry.FINDFIRST THEN
            REPEAT
                OverDueAmt += DetCustLedgEntry."Amount (LCY)";
            UNTIL DetCustLedgEntry.NEXT = 0;
        EXIT(OverDueAmt);
    end;


    procedure CalculateLast90Days(CustNo: Code[20]; FromDate: Date; ToDate: Date) OverDueAmt: Decimal
    var
        DetCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        DetCustLedgEntry.RESET;
        DetCustLedgEntry.SETCURRENTKEY("Customer No.", "Initial Entry Due Date", "Posting Date", "Currency Code");
        DetCustLedgEntry.SETFILTER("Customer No.", '%1', CustNo);
        DetCustLedgEntry.SETFILTER("Entry Type", '%1', DetCustLedgEntry."Entry Type"::"Initial Entry");
        DetCustLedgEntry.SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
        DetCustLedgEntry.SETFILTER("Document Type", '%1', DetCustLedgEntry."Document Type"::Invoice);
        IF DetCustLedgEntry.FINDFIRST THEN
            REPEAT
                OverDueAmt += DetCustLedgEntry."Amount (LCY)";
            UNTIL DetCustLedgEntry.NEXT = 0;
        EXIT(OverDueAmt);
    end;


    procedure CreateOverDueEntry(Customer: Record Customer; DtDate: Date)
    var
        SPIncentiveDetail: Record "Payment Terms Location Wise";
        PCHIncentiveDetail: Record "Payment Terms Location Wise";
        ZMIncentiveDetail: Record "Payment Terms Location Wise";
        ODEntryNo: Code[30];
    begin
        /*   ODEntryNo := 'OD-' + FORMAT(Customer."No.") + '-' + FORMAT(DtDate);
           SPIncentiveDetail.RESET;
           SPIncentiveDetail.SETFILTER("State Code", '%1', SPIncentiveDetail."State Code"::"1");
           SPIncentiveDetail.SETFILTER("Customer No.", '%1', Customer."No.");
           SPIncentiveDetail.SETFILTER("Document No.", '%1', ODEntryNo);
           SPIncentiveDetail.SETFILTER("Effective Month", '%1', DtDate);
           IF SPIncentiveDetail.FINDFIRST THEN
               EXIT;
           //  ELSE BEGIN
           SPIncentiveDetail."Location Code" := Customer."Salesperson Code";
           SPIncentiveDetail."Customer Name" := Customer.Name;
           SPIncentiveDetail."Customer No." := Customer."No.";
           SPIncentiveDetail."Document Type" := SPIncentiveDetail."Document Type"::"1";
           SPIncentiveDetail."Document No." := ODEntryNo;
           SPIncentiveDetail.VALIDATE("Posting Date", DtDate);
           SPIncentiveDetail."State Code" := SPIncentiveDetail."State Code"::"1";
           SPIncentiveDetail."Document Amount" := 0;
           SPIncentiveDetail."Eligible Amount" := 0;
           SPIncentiveDetail."Primary Entry" := TRUE;
           SPIncentiveDetail."Overdue Amount" := CalculateOverDueAmount(Customer."No.", SPIncentiveDetail."Effective Month");
           SPIncentiveDetail."Last 90 Days Sales" := CalculateLast90Days(Customer."No.", SPIncentiveDetail."Effective Month" - 90, SPIncentiveDetail."Effective Month");
           IF SalesPerson.GET(SPIncentiveDetail."Location Code") THEN
               SPIncentiveDetail."Sales Person Name" := SalesPerson.Name;
           IF SPIncentiveDetail."Location Code" <> '' THEN
               SPIncentiveDetail.INSERT;
           IF Customer."PCH Code" <> '' THEN BEGIN
               IF NOT PCHIncentiveDetail.GET(PCHIncentiveDetail."State Code"::"2", Customer."PCH Code", PCHIncentiveDetail."Document Type"::"1", ODEntryNo) THEN BEGIN
                   PCHIncentiveDetail.INIT;
                   PCHIncentiveDetail.TRANSFERFIELDS(SPIncentiveDetail);
                   PCHIncentiveDetail."Location Code" := Customer."PCH Code";
                   PCHIncentiveDetail."State Code" := PCHIncentiveDetail."State Code"::"2";
                   IF SalesPerson.GET(PCHIncentiveDetail."Location Code") THEN
                       PCHIncentiveDetail."Sales Person Name" := SalesPerson.Name;
                   PCHIncentiveDetail."Primary Entry" := TRUE;
                   IF PCHIncentiveDetail."Location Code" <> '' THEN
                       PCHIncentiveDetail.INSERT;
               END;
           END;
           IF Customer."Zonal Manager" <> '' THEN BEGIN
               IF NOT ZMIncentiveDetail.GET(3, Customer."Zonal Manager", ZMIncentiveDetail."Document Type"::"1", ODEntryNo) THEN BEGIN
                   ZMIncentiveDetail.INIT;
                   ZMIncentiveDetail.TRANSFERFIELDS(SPIncentiveDetail);
                   ZMIncentiveDetail."Location Code" := Customer."Zonal Manager";
                   ZMIncentiveDetail."State Code" := ZMIncentiveDetail."State Code"::"3";
                   ZMIncentiveDetail."Primary Entry" := TRUE;
                   IF SalesPerson.GET(ZMIncentiveDetail."Location Code") THEN
                       ZMIncentiveDetail."Sales Person Name" := SalesPerson.Name;
                   IF ZMIncentiveDetail."Location Code" <> '' THEN
                       ZMIncentiveDetail.INSERT;
               END;
           END;*/ // 15578
                  //END;
    end;
}

