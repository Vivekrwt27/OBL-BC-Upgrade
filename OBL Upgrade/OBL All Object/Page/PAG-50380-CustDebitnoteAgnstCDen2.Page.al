page 50380 "Cust Debit note Agnst CD en2"
{
    PageType = Card;

    layout
    {
        area(content)
        {
            field(StartDate; StartDate)
            {
                Caption = 'To Date';
                Enabled = false;
                ApplicationArea = All;
            }
            field(NoOfDays; NoOfDays)
            {
                Caption = 'No. Of Days (Backwards)';
                Enabled = false;
                ApplicationArea = All;
            }
            field(IndiCator; cPerCentBar)
            {
                ExtendedDatatype = Ratio;
                MaxValue = 100;
                MinValue = 0;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(BtnStart)
            {
                Caption = 'Create Debit Notes';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    StartDate := WORKDATE;
                    NoOfDays := 23;
                    PrintToExcel := FALSE;
                    iteration := 0;
                    IC := 0;

                    FirstPrdStart := -100; // do not make it zero
                    FirstPrdEnd := 5;
                    SecondPrdStart := 6;
                    SecondPrdEnd := 12;
                    ThirdPrdStart := 13;
                    ThirdPrdEnd := 23;
                    SecondIntervalFraction := 0.75;
                    ThirdIntervalFraction := 0.5;
                    TolerancePercent := 0;

                    MonthEndDate := CALCDATE('-CM-1M-1D', StartDate);
                    // MESSAGE('%1',MonthEndDate);
                    //ERROR('');

                    avDate := StartDate - ABS(NoOfDays) - 1;
                    // MESSAGE('%1',avDate-57);
                    //ERROR('');//
                    /*CALCFIELDS("Remaining Amt. (LCY)");
                   //MESSAGE(FORMAT("Remaining Amt. (LCY)"));
                   IF ROUND("Remaining Amt. (LCY)",0.01) = 0 THEN
                      CurrReport.SKIP;
                   IF ("Posting Date"<=StartDate) AND ("Posting Date">(StartDate-24)) THEN  //Within last 30 Days
                     Amt[1]:="Remaining Amt. (LCY)";
                   IF ("Posting Date"<=(StartDate-0)) AND ("Posting Date">(StartDate-24)) THEN  //Between last  30 days to 35 Days
                     Amt[2]:="Remaining Amt. (LCY)";
                    CALCFIELDS(CLE."Cash Discount");
                    //PrintFlag:=FALSE;
                    IF  CLE."Cash Discount" =0 THEN
                      CurrReport.SKIP;

                       cAmountLCY:=0;
                       DaysInPayment:=100000;
                       cPostingDate:= 0D;
                       ClosingPaidAmount:=0;
                       PreviousPaidAmount:=0;
                       TotalPaidAmount:=0;
                       SkipLoop:=FALSE;
                        CALCFIELDS("Remaining Amt. (LCY)") ;
                        CALCFIELDS("Original Amt. (LCY)") ; */

                    CLE2.RESET;
                    CLE2.SETCURRENTKEY("Customer No.", "Posting Date");
                    //CLE2.SETFILTER(CLE2."Customer No.",'=%1&=%2','110142222201662','110144706906639');
                    // CLE2.SETFILTER(CLE2."Customer No.",'%1','110142728901758');

                    CLE2.SETRANGE(CLE2."Posting Date", avDate - 57, avDate);

                    //CLE.SETRANGE(CLE."Document Type",CLE."Document Type"::Invoice);

                    //CLE2.SETFILTER(CLE2."Posting Date", '%1',avDate);
                    CLE2.SETFILTER(CLE2."Document Type", '%1', CLE2."Document Type"::Invoice);
                    ////////////////////////CLE2.SETFILTER(CLE2."Customer No.",'%1','110132507812681');


                    //CLE2.CALCFIELDS(CLE2."Cash Discount");
                    //CLE2.SETFILTER(CLE2."Cash Discount",'<%1',0);
                    CLE2.SETFILTER(CLE2.AutoDebitCheckFlag, '%1', FALSE);
                    TotalRec := CLE2.COUNT;
                    IF NOT CLE2.FIND('-') THEN
                        AllRecord := TRUE
                    ELSE BEGIN   // Main 01 Starts
                        REPEAT
                            CurRec += 1;
                            IF TotalRec <> 0 THEN
                                cPerCentBar := ROUND(CurRec / TotalRec * 100, 1);

                            CLE2.CALCFIELDS("Cash Discount");
                            cInvoiceNo := CLE2."Document No.";
                            SkipRecordDate := FALSE;
                            SkipRecordCustomer := FALSE;
                            CheckSkipRecordDate;
                            CheckSkipRecordCustomer;
                            IF (CLE2."Cash Discount" < 0) AND (NOT SkipRecordDate) AND (NOT SkipRecordCustomer) THEN BEGIN // K001 starts
                                CustomerNumb := CLE2."Customer No.";
                                cInvoiceNo := CLE2."Document No.";

                                CLE.RESET;
                                CLE.SETCURRENTKEY("Customer No.", "Posting Date");
                                CLE.SETFILTER(CLE."Document No.", cInvoiceNo);
                                //CLE.SETFILTER(CLE."Posting Date", '%1',avDate);
                                CLE.SETFILTER(CLE."Document Type", '%1', CLE."Document Type"::Invoice);
                                CLE.CALCFIELDS(CLE."Cash Discount");
                                CLE.SETFILTER(CLE."Cash Discount", '<%1', 0);
                                CLE.SETFILTER(CLE.AutoDebitCheckFlag, '%1', FALSE);

                                IF CLE.FIND('-') THEN BEGIN  // M02 starts
                                    REPEAT
                                        CLE.CALCFIELDS(CLE."Cash Discount");
                                        IF CLE."Cash Discount" < 0 THEN BEGIN // S02 starts
                                            TotCashDiscount := ABS(CLE."Cash Discount");
                                            CalculateDebitAmount;
                                            // iteration+=1;
                                            // CustomerNumb:=CLE."Customer No.";

                                        END;  // S02 Ends
                                    UNTIL CLE.NEXT = 0;
                                    BEGIN
                                        MarkITCheck;
                                        PostDebitNote;
                                        UnCheckSuspFlag;

                                        COMMIT;
                                    END;
                                    //CurrForm.IndiCator.UPDATE;

                                END;  //M02 ends


                            END; // K001 ends

                            IF (CLE2."Cash Discount" < 0) AND (SkipRecordCustomer = TRUE) THEN BEGIN
                                CustLEntry.RESET;
                                CustLEntry.GET(CLE2."Entry No.");
                                CustLEntry.AutoDebitCheckFlag := TRUE;
                                CustLEntry.DebitCheckStateFlag := TRUE;
                                CustLEntry.MODIFY;
                            END;

                        UNTIL CLE2.NEXT = 0;
                    END;   //Main  01 Ends




                    IF IC > 0 THEN BEGIN
                        MESSAGE('Done .  %1 Debit Notes Created with Posting date %2', TotNoOfCustomer, StartDate);
                        cPerCentBar := 0;
                    END;
                    IF IC = 0 THEN BEGIN
                        MESSAGE(' No records to Debit ');
                        cPerCentBar := 0;
                    END;

                end;
            }
        }
    }

    var
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        StartDate: Date;
        CustomerNumb: Code[30];
        cInvoiceNo: Code[22];
        SkipRecordDate: Boolean;
        SkipRecordCustomer: Boolean;
        MonthEndDate: Date;
        EffectivePostingDate: Date;
        Cust3: Record Customer;
        StateFilterString: Text[250];
        // cStructure: Record 13792; //16630 Table N/F
        CurrStructure: Code[15];
        CurrFormCode: Code[12];
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        TaxGrpCode: Code[20];
        cPerCentBar: Decimal;
        Window1: Dialog;
        TotalRec: Integer;
        CurRec: Integer;
        TotNoOfCustomer: Integer;
        AllRecord: Boolean;
        iteration: Integer;
        CLE: Record "Cust. Ledger Entry";
        CLE2: Record "Cust. Ledger Entry";
        CustFilter: Text[250];
        PeriodStartDate: array[6] of Date;
        CustBalanceDueLCY: array[5] of Decimal;
        PrintCust: Boolean;
        i: Integer;
        avDate: Date;
        IC: Integer;
        Amt: array[12] of Decimal;
        Text: array[12] of Text[2];
        AmtD: array[12] of Decimal;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CustLEntry: Record "Cust. Ledger Entry";
        Summary: Boolean;
        PendingForm: Text[250];
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvLine: Record "Sales Invoice Line";
        CompanyInfo: Record "Company Information";
        CompanyName1: Text[100];
        AmountRestriction: Integer;
        DCLE: Record "Detailed Cust. Ledg. Entry";
        "---": Integer;
        ExcelBuf: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        CustNo: Text[50];
        MinimumAmt: Boolean;
        Printdetail: Boolean;
        State: Record State;
        Cust: Record Customer;
        DaysInPayment: Integer;
        NoDebitFlag: Boolean;
        PaymentFlag: Boolean;
        TotalOpenPayment: Decimal;
        OpenPaymentFlag: Boolean;
        cDebitPercent: Decimal;
        cDebitAmount: Decimal;
        CurrentDebitAmt: Decimal;
        cAmountLCY: Decimal;
        cPostingDate: Date;
        TolerantAmt: Decimal;
        ClosingPaidAmount: Decimal;
        PrintFlag: Boolean;
        TotalPaidAmount: Decimal;
        PreviousPaidAmount: Decimal;
        SkipLoop: Boolean;
        DiscountPerc: Decimal;
        CustomerBalance: Decimal;
        NoOfDays: Integer;
        KP: Integer;
        FirstPrdStart: Integer;
        FirstPrdEnd: Integer;
        SecondPrdStart: Integer;
        SecondPrdEnd: Integer;
        ThirdPrdStart: Integer;
        ThirdPrdEnd: Integer;
        SecondIntervalFraction: Decimal;
        ThirdIntervalFraction: Decimal;
        SafeAmount: Decimal;
        TotCashDiscount: Decimal;
        TolerancePercent: Decimal;
        DebitNoteDescString: Text[500];
        CLeNumberArray: array[99] of Integer;
        InvNoArray: array[99] of Code[25];
        DebitAmtArray: array[99] of Decimal;
        H: Integer;
        L: Integer;
        M: Integer;
        TotLedgerEntryPerCust: Integer;
        DebitNoteDocNo: Code[25];
        Cust2: Record Customer;
        NoMgmt: Codeunit NoSeriesManagement;
        SH1: Record "Sales Header";
        SL1: Record "Sales Line";
        NewSeriesNo: Code[20];
        SH2: Record "Sales Header";
        SL2: Record "Sales Line";
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        PurchaseHeader: Record "Purchase Header";
        SalesPost: Codeunit "Sales-Post";

    procedure SalesDebitNote(var CustDebitAmount: Decimal; var M: Integer; var LedgerEntryArray: array[99] of Integer; var DebitNoteString: Text[500])
    begin
        SH1.RESET;
        Cust2.RESET;
        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETRANGE("No.", cInvoiceNo);
        IF SalesInvoiceHeader.FIND('-') THEN BEGIN
            //16630 start
            /*  CurrStructure := SalesInvoiceHeader.Structure;
              cStructure.RESET;
              IF NOT cStructure.GET(CurrStructure) THEN
                  CurrStructure := 'TAX';
              CurrFormCode := SalesInvoiceHeader."Form Code";*///16630 End
        END;

        SalesInvLine.RESET;
        TaxGrpCode := '';
        SalesInvLine.SETRANGE("Document No.", cInvoiceNo);
        SalesInvLine.SETFILTER(SalesInvLine.Type, '%1', SalesInvLine.Type::Item);
        IF SalesInvLine.FIND('-') THEN BEGIN
            TaxGrpCode := SalesInvLine."Tax Group Code";
            //16630 IF SalesInvLine."Tax %" <> 0 THEN
            //16630CustDebitAmount := CustDebitAmount / (100 + SalesInvLine."Tax %") * 100;
        END;


        Cust2.GET(CustomerNumb);
        NewSeriesNo := NoMgmt.GetNextNo('DN', StartDate, TRUE);
        SH1.INIT;
        SH1."Document Type" := SH1."Document Type"::Invoice;
        SH1."No." := NewSeriesNo; // eff
        SH1."Sell-to Customer No." := CustomerNumb;
        SH1."Bill-to Customer No." := CustomerNumb;
        SH1."Bill-to Name" := Cust2.Name;
        SH1."Bill-to Name 2" := Cust2."Name 2";
        SH1."Bill-to Address" := Cust2.Address;
        SH1."Bill-to Address 2" := Cust2."Address 2";
        SH1."Bill-to City" := Cust2.City;
        SH1."Bill-to Contact" := Cust2.Contact;
        SH1."Ship-to Name" := Cust2.Name;
        SH1."Ship-to Name 2" := Cust2."Name 2";
        SH1."Ship-to Address" := Cust2.Address;
        SH1."Ship-to Address 2" := Cust2."Address 2";

        SH1."Ship-to City" := Cust2.City;
        SH1."Ship-to Contact" := Cust2.Contact;
        SH1."Order Date" := StartDate;
        SH1."Posting Date" := StartDate;
        //SH1."Shipment Date":=StartDate;
        SH1."Posting Description" := 'Invoice ' + NewSeriesNo;
        SH1."Due Date" := StartDate;
        SH1."Customer Posting Group" := Cust2."Customer Posting Group";
        SH1."Customer Price Group" := Cust2."Customer Price Group";
        SH1."Invoice Disc. Code" := Cust2."No.";
        SH1."Salesperson Code" := Cust2."Salesperson Code";
        SH1."Gen. Bus. Posting Group" := Cust2."Gen. Bus. Posting Group";
        SH1."VAT Country/Region Code" := Cust2."Country/Region Code";
        SH1."Sell-to Customer Name" := Cust2.Name;
        SH1."Sell-to Address" := Cust2.Address;
        SH1."Sell-to Address 2" := Cust2."Address 2";
        SH1."Sell-to City" := Cust2.City;
        SH1."Sell-to Contact" := Cust2.Contact;
        SH1."Bill-to Post Code" := Cust2."Post Code";
        SH1."Bill-to Country/Region Code" := Cust2."Country/Region Code";
        SH1."Sell-to Post Code" := Cust2."Post Code";
        SH1."Sell-to Country/Region Code" := Cust2."Country/Region Code";
        SH1."Ship-to Post Code" := Cust2."Post Code";
        SH1."Ship-to Country/Region Code" := Cust2."Country/Region Code";
        SH1."Bal. Account Type" := SH1."Bal. Account Type"::"G/L Account";// g/l  type
        SH1."Document Date" := StartDate;
        SH1."External Document No." := 'CD REVERSE AUTO';  //  all debit notes will have this common for identity.
        SH1."Shipping Agent Code" := 'PARTYVEH'; //Transport method
        SH1."No. Series" := 'DN';    //            no series
        SH1."Posting No. Series" := 'SDNHO';

        ///  sales invoice header copy data
        // MESSAGE('%1',CurrStructure);
        //ERROR('');
        SH1."Tax Area Code" := SalesInvoiceHeader."Tax Area Code";
        SH1."Tax Liable" := SalesInvoiceHeader."Tax Liable";
        SH1."Discount Charges %" := 0.0011;

        //16630 SH1.Structure := CurrStructure; //

        // SH1."Location Code":= 'HO';
        //SH1."Shortcut Dimension 1 Code":='HO';
        //SH1."Shortcut Dimension 2 Code":='HO';
        SH1."Location Code" := SalesInvoiceHeader."Location Code";
        SH1."Shortcut Dimension 1 Code" := SalesInvoiceHeader."Shortcut Dimension 1 Code";
        SH1."Shortcut Dimension 2 Code" := SalesInvoiceHeader."Shortcut Dimension 2 Code";
        SH1."Group Code" := SalesInvoiceHeader."Group Code";

        //16630 SH1."Form Code" := CurrFormCode;



        ///  sales invoice header copy data ENDs

        SH1.Reserve := Cust2.Reserve;
        SH1.Status := SH1.Status::Open;
        SH1."Compress Prepayment" := TRUE;
        SH1."Allow Line Disc." := TRUE;
        //16630 SH1."Excise Bus. Posting Group" := Cust2."Excise Bus. Posting Group";
        //16630 SH1."Bill to Customer State" := Cust2."State Code";*/
        SH1.State := Cust2."State Code";
        SH1."Customer Type" := Cust2."Customer Type";
        //16630 SH1."Tax Registration No." := Cust2."T.I.N. No.";
        SH1.INSERT(TRUE);

        //888888//
        SL1.RESET;
        SL1.INIT;
        // sash 21 may
        SL1."Document Type" := SL1."Document Type"::Invoice;
        SL1."Tax Group Code" := TaxGrpCode;
        //16630 SL1."Form Code" := SalesInvLine."Form Code";

        // sash 21 may
        SL1."Document No." := NewSeriesNo;
        SL1."Line No." := 10000;
        SL1."Sell-to Customer No." := SH1."Sell-to Customer No.";
        SL1.Type := SL1.Type::"G/L Account";
        SL1."No." := '61431000';
        SL1."Location Code" := SalesInvLine."Location Code";
        SL1."Shipment Date" := StartDate;
        SL1.Description := 'AMT DEBITED FOR CD REVERSAL FOR DELAY PYMT';
        SL1."Description 2" := DebitNoteString;  // received as a parameter // inv no+ debit amt
        SL1.Quantity := 1;
        SL1."Outstanding Quantity" := 1;
        SL1."Qty. to Invoice" := 1;
        SL1."Qty. to Ship" := 1;
        SL1."Unit Price" := CustDebitAmount;    // DEBIT AMOUNT
        SL1."Shortcut Dimension 1 Code" := SalesInvLine."Shortcut Dimension 1 Code";  //BRANCH CODE
        SL1."Shortcut Dimension 2 Code" := SalesInvLine."Shortcut Dimension 2 Code";  //BRANCH CODE
        SL1."Tax Area Code" := SalesInvLine."Tax Area Code";
        SL1."VAT Calculation Type" := SalesInvLine."VAT Calculation Type";
        //16630  SL1."Tax %" := SalesInvLine."Tax %";

        SL1."Customer Price Group" := SH1."Customer Price Group";
        SL1."Outstanding Amount" := CustDebitAmount; //debit amt
        SL1."Bill-to Customer No." := SH1."Bill-to Customer No.";
        SL1."Gen. Bus. Posting Group" := SH1."Gen. Bus. Posting Group";
        SL1."Gen. Prod. Posting Group" := SalesInvLine."Gen. Prod. Posting Group";


        SL1."Outstanding Amount (LCY)" := CustDebitAmount;  //debit amt
        SL1."Line Amount" := CustDebitAmount;
        SL1."Qty. per Unit of Measure" := 1;
        SL1."Quantity (Base)" := 1;
        SL1."Outstanding Qty. (Base)" := 1;
        SL1."Qty. to Invoice (Base)" := 1;
        SL1."Qty. to Ship (Base)" := 1;
        SL1."Planned Delivery Date" := StartDate;
        SL1."Planned Shipment Date" := StartDate;
        SL1."Shipping Agent Code" := SH1."Shipping Agent Code";
        SL1."Allow Line Disc." := SH1."Allow Line Disc.";
        //16630 SL1."Excise Bus. Posting Group" := SH1."Excise Bus. Posting Group";
        // SL1."Amount Including Tax":=   CustDebitAmount; // debit amt
        //16630 SL1."Tax Base Amount" := CustDebitAmount; //debit amt
        //16630 SL1.State := SH1.State;
        //SL1."Amount To Customer":= CustDebitAmount; // debit anmt
        //SL1."Buyer's Price":=  CustDebitAmount;      // debit amt
        SL1."Related Location code" := SL1."Location Code";
        SL1."Customer Name" := Cust2.Name;
        SL1.City := Cust2.City;
        //  SL1."State Name" := Cust2."State Desc.";
        SL1.INSERT(TRUE);
        COMMIT;

        // document dimension insert  for sales header
        /*DocDim.RESET;
        DocDim.SETRANGE(DocDim."Table ID",36);
        DocDim.SETRANGE(DocDim."Document Type",2);
        DocDim.SETRANGE(DocDim."Document No.",'%1',NewSeriesNo);
        IF DocDim.FIND('-') THEN
        DocDim.DELETEALL;
        DocDim.RESET;
        DocDim.SETRANGE(DocDim."Table ID",37);
        DocDim.SETRANGE(DocDim."Document Type",2);
        DocDim.SETRANGE(DocDim."Document No.",'%1',NewSeriesNo);
        IF DocDim.FIND('-') THEN
        DocDim.DELETEALL;


       DocDim.RESET;
       DocDim.INIT;
       DocDim."Table ID":=36;
       DocDim."Line No.":=0;
       DocDim."Document Type":=2;
       DocDim."Document No.":= NewSeriesNo;
       DocDim."Dimension Code":='CUSTOMER';
       DocDim."Dimension Value Code":=CustomerNumb;
       DocDim.INSERT(FALSE);
       DocDim.INIT;
       DocDim."Table ID":=36;
       DocDim."Document Type":=2;
       DocDim."Line No.":=0;
       DocDim."Document No.":= NewSeriesNo;
       DocDim."Dimension Code":='BRANCH';
       DocDim."Dimension Value Code":='HO';
       DocDim.INSERT(FALSE);
       DocDim.INIT;
       DocDim."Table ID":=36;
       DocDim."Document Type":=2;
       DocDim."Line No.":=0;
       DocDim."Document No.":= NewSeriesNo;
       DocDim."Dimension Code":='DEPT';
       DocDim."Dimension Value Code":='HO';
       DocDim.INSERT(FALSE);

       DocDim.INIT;
       DocDim."Table ID":=36;
       DocDim."Document Type":=2;
       DocDim."Line No.":=0;
       DocDim."Document No.":= NewSeriesNo;
       DocDim."Dimension Code":='STATE';
       DocDim."Dimension Value Code":=Cust2."State Code";
       DocDim.INSERT(FALSE);*/


        // // document dimension insert  for sales line
        //DocDim.RESET;
        /*DocDim.INIT;
        DocDim."Table ID":=37;
        DocDim."Document Type":=2;
        DocDim."Document No.":= NewSeriesNo;
        DocDim."Line No.":=10000;
        DocDim."Dimension Code":='CUSTOMER';
        DocDim."Dimension Value Code":=CustomerNumb;
        DocDim.INSERT(FALSE);
        DocDim.INIT;
        DocDim."Table ID":=37;
        DocDim."Document Type":=2;
        DocDim."Document No.":= NewSeriesNo;
           DocDim."Line No.":=10000;
        DocDim."Dimension Code":='BRANCH';
        DocDim."Dimension Value Code":='HO';
        DocDim.INSERT(FALSE);
        DocDim.INIT;
        DocDim."Table ID":=37;
        DocDim."Document Type":=2;
        DocDim."Document No.":= NewSeriesNo;
           DocDim."Line No.":=10000;
        DocDim."Dimension Code":='DEPT';
        DocDim."Dimension Value Code":='HO';
        DocDim.INSERT(FALSE);
        DocDim.INIT;
        DocDim."Table ID":=37;
        DocDim."Document Type":=2;
        DocDim."Document No.":= NewSeriesNo;
           DocDim."Line No.":=10000;
        DocDim."Dimension Code":='STATE';
        DocDim."Dimension Value Code":=Cust2."State Code";
        DocDim.INSERT(FALSE);  */

        COMMIT;

        // Validate and release
        SH2.RESET;
        SL2.RESET;
        SH2.GET(2, NewSeriesNo);
        // SH2.VALIDATE("Location Code");
        SH2.VALIDATE("Location Code");
        //16630 SH2.VALIDATE(Structure);
        //16630 SL2.CalculateStructures(SH2);
        //16630SL2.AdjustStructureAmounts(SH2);
        //16630 SL2.UpdateSalesLines(SH2);
        //16630SalesTaxCalculate.UpdateStructureCalculated1(SH2);

        ReleaseSalesDoc.PerformManualRelease(SH2);
        COMMIT;


        // post debit note
        SH2."Posting Date" := StartDate;
        //16630 SL2.UpdateSalesLines(SH2);
        //16630  IF ApprovalMgt.PrePostApprovalCheck(SH2, PurchaseHeader) THEN
        IF ApprovalMgt.PrePostApprovalCheckSales(SH2) THEN
            SalesPost.RUN(SH2);

        IF IC <= 2 THEN
            SLEEP(3500)
        ELSE
            SLEEP(800);

        // Get the new generated debit note number
        DebitNoteDocNo := '';
        CustLEntry.RESET;
        CustLEntry.SETRANGE(CustLEntry."Customer No.", CustomerNumb);
        // CustLEntry.SETRANGE(CustLEntry."Document No.",cInvoiceNo);
        CustLEntry.SETRANGE(CustLEntry."Posting Date", StartDate);     // sash
        IF CustLEntry.FIND('+') THEN BEGIN

            IF ABS(CustLEntry."Sales (LCY)" - CustDebitAmount) < 1 THEN BEGIN   // both are equal most of times
                DebitNoteDocNo := CustLEntry."Document No.";
            END;
        END;

        IF DebitNoteDocNo = '' THEN
            ERROR(' Debit Note Doc No.  created is Not found  ');

        // Mark tick in Customer ledger entries related to current debit note
        //PPPP1 starts
        H := 1;
        BEGIN
            REPEAT
                IF LedgerEntryArray[H] <> 0 THEN BEGIN
                    CustLEntry.RESET;
                    CustLEntry.GET(LedgerEntryArray[H]);
                    CustLEntry.CashDiscountDebitFlag := TRUE;
                    CustLEntry.DebitAmtOnCashDisc := DebitAmtArray[H];
                    CustLEntry.DebitInvNo := DebitNoteDocNo;
                    CustLEntry.MODIFY;
                END;
                H += 1
            UNTIL H - 1 = M;
        END;
        //PPPP1 Ends

        COMMIT;

        IF IC <= 2 THEN
            SLEEP(1200)
        ELSE
            SLEEP(500);

    end;

    procedure CheckStringForDebit(var cString: Text[500])
    var
        k: Integer;
        Str: Text[50];
    begin

        Str := '';
        IF STRLEN(cString) > 50 THEN BEGIN
            k := 1;
            cString := '';
            BEGIN
                REPEAT

                    Str := FORMAT(InvNoArray[k]);
                    Str := DELSTR(Str, 1, (STRLEN(Str) - 5));
                    cString += Str + ' ' + FORMAT(DebitAmtArray[k]) + ';';
                    k += 1;
                UNTIL k - 1 = M;
            END;
            IF STRLEN(cString) > 50 THEN
                cString := DELSTR(cString, 50, STRLEN(cString));
        END;
    end;

    procedure PostDebitNote()
    begin
        IF (cDebitAmount >= 50) AND (M <> 0) THEN BEGIN
            CheckStringForDebit(DebitNoteDescString);
            IC += 1; // counter
                     //ERROR('%1',DebitNoteDescString);

            SalesDebitNote(cDebitAmount, M, CLeNumberArray, DebitNoteDescString);
            TotNoOfCustomer += 1;
        END;



        IF M <> 0 THEN BEGIN  // ss1 starts
            cDebitAmount := 0;
            H := 1;
            BEGIN
                REPEAT
                    CLeNumberArray[H] := 0;
                    InvNoArray[H] := '';
                    DebitAmtArray[H] := 0;
                    H += 1;
                UNTIL (H - 1) <= M;//Total no. of Ledger Entries for this Customer
            END;
            M := 0;
            H := 0;
            L := 0;
            DebitNoteDescString := '';
        END;   // Ss1 ends
    end;

    procedure CalculateDebitAmount()
    begin
        cAmountLCY := 0;
        SafeAmount := 0;
        //DaysInPayment:=100000;
        // cPostingDate:= 0D;
        // ClosingPaidAmount:=0;
        //PreviousPaidAmount:=0;
        TotalPaidAmount := 0;
        TolerantAmt := 0;
        //SkipLoop:=FALSE;
        CLE.CALCFIELDS("Remaining Amt. (LCY)");
        CLE.CALCFIELDS("Original Amt. (LCY)");
        EffectivePostingDate := CLE."Posting Date";
        // PrintFlag:=TRUE;

        SalesInvoiceHeader.RESET;
        DiscountPerc := 0;
        IF SalesInvoiceHeader.GET(cInvoiceNo) THEN BEGIN
            SalesInvoiceHeader.FIND('-');
            DiscountPerc := SalesInvoiceHeader."Discount Charges %";
        END;

        IF CLE."Posting Date" = MonthEndDate THEN
            EffectivePostingDate := CALCDATE('+4D', CLE."Posting Date");



        IF CLE."Remaining Amt. (LCY)" <> CLE."Original Amt. (LCY)" THEN BEGIN
            DCLE.RESET;
            //cAmountLCY:=0;
            TolerantAmt := ROUND((CLE."Original Amt. (LCY)" - (CLE."Original Amt. (LCY)" * TolerancePercent / 100)), 0.01);
            DCLE.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
            DCLE.SETRANGE(DCLE."Cust. Ledger Entry No.", CLE."Entry No.");
            //DCLE.SETRANGE(DCLE."Posting Date",CLE."Posting Date",(CLE."Posting Date"+ThirdPrdEnd));
            DCLE.SETRANGE(DCLE."Posting Date", CLE."Posting Date", (EffectivePostingDate + ThirdPrdEnd));
            DCLE.SETFILTER(DCLE."Entry Type", '%1', DCLE."Entry Type"::Application);
            //DCLE.SETFILTER(DCLE."Document Type",'%1',DCLE."Document Type"::Payment);
            DCLE.SETFILTER(DCLE.Unapplied, '%1', FALSE);
            DCLE.SETFILTER(DCLE."Amount (LCY)", '<%1', 0);
            IF DCLE.FIND('-') THEN BEGIN

                REPEAT

                    DaysInPayment := DCLE."Posting Date" - EffectivePostingDate;
                    TotalPaidAmount := TotalPaidAmount + ABS(DCLE."Amount (LCY)");

                    IF (FirstPrdStart <= DaysInPayment) AND (DaysInPayment <= FirstPrdEnd) THEN BEGIN
                        SafeAmount := SafeAmount + ((ABS(DCLE."Amount (LCY)") / CLE."Original Amt. (LCY)" * TotCashDiscount) * 1);
                    END;

                    IF (SecondPrdStart <= DaysInPayment) AND (DaysInPayment <= SecondPrdEnd) THEN BEGIN
                        SafeAmount := SafeAmount + ((ABS(DCLE."Amount (LCY)") / CLE."Original Amt. (LCY)" * TotCashDiscount) *
                        SecondIntervalFraction);
                    END;

                    IF (ThirdPrdStart <= DaysInPayment) AND (DaysInPayment <= ThirdPrdEnd) THEN BEGIN
                        SafeAmount := SafeAmount + ((ABS(DCLE."Amount (LCY)") / CLE."Original Amt. (LCY)" * TotCashDiscount) *
                        ThirdIntervalFraction);
                    END;

                    IF (DaysInPayment > ThirdPrdEnd) THEN;

                UNTIL DCLE.NEXT = 0;

            END;
        END;

        // If tolerance percent > 0  then some credit amount to customer only if all payment in defined period falls in tolerance

        IF TolerancePercent > 0 THEN BEGIN
            IF (TotalPaidAmount >= TolerantAmt) THEN BEGIN
                SafeAmount := SafeAmount + (((CLE."Original Amt. (LCY)" - TotalPaidAmount) /
                 CLE."Original Amt. (LCY)" * TotCashDiscount) * 1);
            END;
        END;
        //calculation debit Amounts



        SafeAmount := ROUND(SafeAmount, 0.01);
        CurrentDebitAmt := ROUND((TotCashDiscount - SafeAmount), 0.01, '=');
        cDebitAmount := cDebitAmount + CurrentDebitAmt;

        // strings for debit note (sales line) description field which is limited to size 50 characters

        M += 1;
        CLeNumberArray[M] := CLE."Entry No.";
        InvNoArray[M] := cInvoiceNo;
        DebitAmtArray[M] := CurrentDebitAmt;
        DebitNoteDescString := DebitNoteDescString + FORMAT(cInvoiceNo) + ' .Debit Amt: ' + FORMAT(CurrentDebitAmt) + ';';
    end;

    procedure MarkITCheck()
    begin
        // Mark tick in Customer ledger entries related to current Checking done
        //PPPP1 starts
        H := 1;
        BEGIN
            REPEAT
                IF CLeNumberArray[H] <> 0 THEN BEGIN
                    CustLEntry.RESET;
                    CustLEntry.GET(CLeNumberArray[H]);
                    CustLEntry.AutoDebitCheckFlag := TRUE;
                    CustLEntry.DebitSuspFlag := TRUE;
                    CustLEntry.MODIFY;
                END;
                H += 1
            UNTIL H - 1 = M;
        END;
        //PPPP1 Ends
    end;

    procedure CheckSkipRecordDate()
    begin
        IF CLE2."Posting Date" = MonthEndDate THEN BEGIN
            IF StartDate - CALCDATE('+4D', CLE2."Posting Date") <= ThirdPrdEnd THEN
                SkipRecordDate := TRUE;
        END;
    end;

    procedure CheckSkipRecordCustomer()
    begin
        // StateFilterString := '06|09|23|22|47|11|10|27|28|15|05|16|08' ;
        Cust3.RESET;
        IF Cust3.GET(CLE2."Customer No.") THEN BEGIN
            IF Cust3."Allow Auto Debit" = TRUE THEN
                SkipRecordCustomer := FALSE
            ELSE
                SkipRecordCustomer := TRUE;

            /*  IF  (COMPANYNAME ='Orient Tiles Live Set Up') AND (SkipRecordCustomer =FALSE) THEN BEGIN
              IF (NOT ((Cust3."State Code" = '06') OR (Cust3."State Code" = '09') OR (Cust3."State Code" = '23')
               OR (Cust3."State Code" = '22')
                 OR (Cust3."State Code" = '47') OR (Cust3."State Code" = '11') OR (Cust3."State Code" = '10') OR (Cust3."State Code" = '27')
                    OR (Cust3."State Code" = '28') OR (Cust3."State Code" = '15') OR (Cust3."State Code" = '05') OR (Cust3."State Code" = '16'
          )
                   OR (Cust3."State Code" = '08')))   THEN
                   SkipRecordCustomer:=TRUE;
               END; */

            IF (SkipRecordCustomer = FALSE) THEN BEGIN
                IF (NOT ((Cust3."State Code" = '06') OR (Cust3."State Code" = '09') OR (Cust3."State Code" = '23')
                 OR (Cust3."State Code" = '22')
                   OR (Cust3."State Code" = '47') OR (Cust3."State Code" = '11') OR (Cust3."State Code" = '10') OR (Cust3."State Code" = '27')
                    OR (Cust3."State Code" = '28') OR (Cust3."State Code" = '15') OR (Cust3."State Code" = '05'))) THEN
                    SkipRecordCustomer := TRUE;
            END;


        END;

    end;

    procedure UnCheckSuspFlag()
    begin
        CustLEntry.RESET;
        CustLEntry.GET(CLE2."Entry No.");
        CustLEntry.DebitSuspFlag := FALSE;
        CustLEntry.MODIFY;
    end;

    local procedure BtnStartOnActivate()
    begin
        StartDate := WORKDATE;
        NoOfDays := 23;
    end;
}

