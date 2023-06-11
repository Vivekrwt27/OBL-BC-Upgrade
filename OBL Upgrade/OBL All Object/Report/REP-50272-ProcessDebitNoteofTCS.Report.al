report 50272 "Process Debit Note of TCS"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\ProcessDebitNoteofTCS.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("P.A.N. No.")
                                WHERE("P.A.N. No." = FILTER('<>'''));
            RequestFilterFields = "No.", "P.A.N. No.";
            column(FYStDate; FYStDate)
            {
            }
            column(PeriodStDate; PeriodStDate)
            {
            }
            column(PeriodEndDate; PeriodEndDate)
            {
            }
            column(PANNo; Customer."P.A.N. No.")
            {
            }
            column(CustNo; Customer."No.")
            {
            }
            column(NoofSubCust; NoofSubCust)
            {
            }
            column(Name; Customer.Name)
            {
            }
            column(CollectionBeforeOct; CollectionBeforeOct)
            {
            }
            column(CollectionAfterOct; CollectionAfterOct)
            {
            }
            column(PeriodCollection; PeriodCollection)
            {
            }
            column(CustCollectionBeforeOct; CustCollectionBeforeOct)
            {
            }
            column(CustCollectionBeforeOct1; CustCollectionBeforeOct1)
            {
            }
            column(CustCollectionAfterOct; CustCollectionAfterOct)
            {
            }
            column(CustPeriodCollection; CustPeriodCollection)
            {
            }
            column(TCSBaseAmt; TCSBaseAmt)
            {
            }
            column(TCSAlreadyDedcted; TCSAlreadyDedcted)
            {
            }
            column(TCSRebate; TCSRebate)
            {
            }
            column(DrNoteAmt; DrNoteAmt)
            {
            }

            trigger OnAfterGetRecord()
            var
                LclCustomer: Record Customer;
                txtCustomerLst: Text;
                CustRatio: Decimal;
            begin
                txtCustomerLst := '';
                PeriodCollection := 0;
                CollectionBeforeOct := 0;
                CollectionAfterOct := 0;
                NoofSubCust := 0;
                CustCollectionAfterOct := 0;
                CustCollectionBeforeOct := 0;
                CustPeriodCollection := 0;
                TCSEligible := FALSE;

                ThreshHoldAmt := 5000000;
                LclCustomer.RESET;
                IF Customer."P.A.N. No." <> '' THEN BEGIN
                    LclCustomer.SETCURRENTKEY("P.A.N. No.");
                    LclCustomer.SETFILTER("P.A.N. No.", '%1', Customer."P.A.N. No.");
                END ELSE BEGIN
                    LclCustomer.SETFILTER("No.", '%1', Customer."No.");
                END;
                IF LclCustomer.FINDFIRST THEN
                    REPEAT
                        IF txtCustomerLst = '' THEN
                            txtCustomerLst := LclCustomer."No."
                        ELSE
                            txtCustomerLst += '|' + LclCustomer."No.";
                        NoofSubCust += 1;
                    UNTIL LclCustomer.NEXT = 0;

                TCSEligible := IsEligibleforTCS(txtCustomerLst);

                IF NOT TCSEligible THEN
                    CurrReport.SKIP();

                TCSAlreadyDedcted := 0;
                DrNoteAmt := 0;
                TCSAlreadyDedcted := CalculateAlreadyDeductedTCSBaseAmt(Customer."No.");

                CustCollectionBeforeOct1 := CustCollectionBeforeOct;

                IF ABS(CollectionBeforeOct) > ThreshHoldAmt THEN BEGIN
                    ThreshHoldAmt := 0;
                    CustCollectionBeforeOct := 0;
                    TCSRebate := 0;
                    TCSBaseAmt := ABS(CustCollectionAfterOct + CustPeriodCollection) - (TCSAlreadyDedcted);
                    DrNoteAmt := ROUND((TCSBaseAmt * 0.075) / 100, 0.01, '=');
                    IF GenerateDebitNotes THEN
                        GenerateDebitNoteEntries(Customer."No.", TCSBaseAmt, '');
                END ELSE BEGIN
                    IF ABS(CollectionBeforeOct + CollectionAfterOct + PeriodCollection - ThreshHoldAmt) > 0 THEN BEGIN
                        CustRatio := CalculateRatio((CustCollectionBeforeOct + CustCollectionAfterOct + CustPeriodCollection), (CollectionBeforeOct + CollectionAfterOct + PeriodCollection));
                        TCSRebate := ThreshHoldAmt * CustRatio;
                        TCSBaseAmt := ABS(CustCollectionBeforeOct + CustCollectionAfterOct + CustPeriodCollection) - (TCSRebate + TCSAlreadyDedcted);
                        DrNoteAmt := ROUND((TCSBaseAmt * 0.075) / 100, 0.01, '=');
                        IF GenerateDebitNotes THEN
                            GenerateDebitNoteEntries(Customer."No.", TCSBaseAmt, '');
                    END;
                END;
                //TCSBaseAmt := CalculateTCSBaseAmt(ABS(CustCollectionBeforeOct),ABS(CustCollectionAfterOct),ABS(CustPeriodCollection));
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Generate Dr. Notes"; GenerateDebitNotes)
                {
                    ApplicationArea = All;
                }
                field("Choose Month"; OptMonth)
                {
                    ApplicationArea = All;
                }
                field("Choose Year"; OptYear)
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
        //Report Parameters
        FYStDate := 20200401D;//040120D
        ThreshHoldAmt := 5000000;
    end;

    trigger OnPostReport()
    begin
        NoSeriesManagement.SaveNoSeries();
    end;

    trigger OnPreReport()
    var
        IntYear: Integer;
    begin
        IF (OptMonth = 0) OR (OptYear = 0) THEN ERROR('Please Select Month Year');

        EVALUATE(IntYear, FORMAT(OptYear));
        PeriodStDate := DMY2DATE(1, OptMonth, IntYear);
        PeriodEndDate := CALCDATE('CM', PeriodStDate);

        IF GenerateDebitNotes THEN
            IF NOT CONFIRM((STRSUBSTNO(Text0001, FYStDate, PeriodStDate, PeriodEndDate, ThreshHoldAmt)), FALSE) THEN
                CurrReport.BREAK;

        MESSAGE(TemplateName, BatchName);
        IF GenerateDebitNotes THEN
            IF (TemplateName <> '') AND (BatchName <> '') THEN BEGIN
                GenJournalLine.RESET;
                GenJournalLine.SETFILTER(GenJournalLine."Journal Template Name", '%1', TemplateName);
                GenJournalLine.SETFILTER(GenJournalLine."Journal Batch Name", '%1', BatchName);
                IF GenJournalLine.FINDLAST THEN BEGIN
                    GenJournalBatch.GET(TemplateName, BatchName);
                    MESSAGE('lines already exists Please delete or Next entries will be created');
                    LineNo := GenJournalLine."Line No." + 10000;
                    CLEAR(NoSeriesManagement);
                    IF GenJournalBatch."No. Series" <> '' THEN
                        DocNo := NoSeriesManagement.GetNextNo(GenJournalBatch."No. Series", PeriodEndDate, FALSE);
                END ELSE BEGIN
                    GenJournalBatch.GET(TemplateName, BatchName);
                    CLEAR(NoSeriesManagement);
                    IF GenJournalBatch."No. Series" <> '' THEN
                        DocNo := NoSeriesManagement.GetNextNo(GenJournalBatch."No. Series", PeriodEndDate, FALSE);
                END;
            END;
    end;

    var

        FYStDate: Date;
        PeriodStDate: Date;
        PeriodEndDate: Date;
        CollectionBeforeOct: Decimal;
        CollectionAfterOct: Decimal;
        PeriodCollection: Decimal;
        NoofSubCust: Integer;
        CustCollectionBeforeOct: Decimal;
        CustCollectionBeforeOct1: Decimal;
        CustCollectionAfterOct: Decimal;
        CustPeriodCollection: Decimal;
        TCSBaseAmt: Decimal;
        ShowOnlyEligibleCust: Boolean;
        TCSEligible: Boolean;
        TCSAlreadyDedcted: Decimal;
        TCSRebate: Decimal;
        ThreshHoldAmt: Decimal;
        DrNoteAmt: Decimal;
        TemplateName: Code[20];
        BatchName: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        GenerateDebitNotes: Boolean;
        LineNo: Integer;
        NoSeriesManagement: Codeunit NoSeriesManagement;
        DocNo: Code[20];
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalLine1: Record "Gen. Journal Line";
        TempCustomer: Record Customer temporary;
        OptMonth: Option " ",JANUARY,FEBRUARY,MARCH,APRIL,MAY,JUNE,JULY,AUGUST,SEPTEMBER,OCTOBER,NOVEMBER,DECEMBER;
        OptYear: Option " ","2020","2021","2022","2023","2024","2025","2026","2027",,"2028","2029","2030","2031",,"2032","2033","2034","2035","2036","2037","2038","2039","2040";
        Text0001: Label 'Debit Notes will be Generated for the FY starting %1 and for the Period Starting %2 to %3 with a threshhold Amounting %4.//Lines already exists in Journal will be Deleted,Please delete or Next entries will be created// If you want to Continue Press Yes else No. Once Debit Note Process will not be Rollback.';

    local procedure IsEligibleforTCS(LcltxtCustomerLst: Text): Boolean
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Currency Code");
        CustLedgerEntry.SETFILTER("Customer No.", LcltxtCustomerLst);
        CustLedgerEntry.SETFILTER("Posting Date", '%1..%2', FYStDate, PeriodEndDate);
        CustLedgerEntry.SETFILTER("Document Type", '%1|%2', CustLedgerEntry."Document Type"::Payment, CustLedgerEntry."Document Type"::Refund);
        IF CustLedgerEntry.FINDFIRST THEN BEGIN
            CustLedgerEntry.CALCFIELDS("Amount (LCY)");
            REPEAT
                CustLedgerEntry.CALCFIELDS("Amount (LCY)");
                IF CustLedgerEntry."Posting Date" < 20200110D THEN BEGIN//100120D
                    CollectionBeforeOct -= CustLedgerEntry."Amount (LCY)";
                    IF CustLedgerEntry."Customer No." = Customer."No." THEN BEGIN
                        CustCollectionBeforeOct -= CustLedgerEntry."Amount (LCY)";
                    END;
                END;
                IF (CustLedgerEntry."Posting Date" >= 20200110D) AND (CustLedgerEntry."Posting Date" <= PeriodStDate - 1) THEN BEGIN//100120D
                    CollectionAfterOct -= CustLedgerEntry."Amount (LCY)";
                    IF CustLedgerEntry."Customer No." = Customer."No." THEN BEGIN
                        CustCollectionAfterOct -= CustLedgerEntry."Amount (LCY)";
                    END;

                END;
                IF (CustLedgerEntry."Posting Date" >= PeriodStDate) AND (CustLedgerEntry."Posting Date" <= PeriodEndDate) THEN BEGIN
                    PeriodCollection -= CustLedgerEntry."Amount (LCY)";
                    IF CustLedgerEntry."Customer No." = Customer."No." THEN BEGIN
                        CustPeriodCollection -= CustLedgerEntry."Amount (LCY)";
                    END;
                END;
            UNTIL CustLedgerEntry.NEXT = 0;
        END;

        IF ABS(CollectionBeforeOct) >= ThreshHoldAmt THEN
            EXIT(TRUE);

        IF ABS(CollectionBeforeOct + CollectionAfterOct + PeriodCollection) >= ThreshHoldAmt THEN
            EXIT(TRUE);
    end;

    local procedure CalculateTCSBaseAmt(BeforeAmt: Decimal; Afteramt: Decimal; Periodamt: Decimal) TaxBaseAmt: Decimal
    begin
        IF TCSEligible THEN BEGIN
            TaxBaseAmt := (Periodamt);
            EXIT(TaxBaseAmt);
        END;

        /*
        IF (BeforeAmt) >ThreshHoldAmt THEN BEGIN
          TaxBaseAmt := (BeforeAmt+Afteramt+Periodamt) - ThreshHoldAmt;
          EXIT(TaxBaseAmt);
        END;
        
        IF (BeforeAmt+Afteramt+Periodamt) >ThreshHoldAmt THEN BEGIN
          TaxBaseAmt := BeforeAmt+Afteramt+Periodamt - ThreshHoldAmt;
          EXIT(TaxBaseAmt);
        END;
        */

    end;

    local procedure CalculateRatio(Amt: Decimal; BaseAmt: Decimal): Decimal
    begin
        IF BaseAmt = 0 THEN
            EXIT(1);

        EXIT(Amt / BaseAmt);
    end;

    local procedure CalculateAlreadyDeductedTCSBaseAmt(PartyCode: Code[20]) Amt: Decimal
    var
        TCSEntry: Record "TCS Entry";
    begin
        EXIT;
        TCSEntry.RESET;
        //, TCSEntry."TCS Type",TCSEntry."Party Code",TCSEntry."Party Type" //16225 Remove Field 
        //16225  TCSEntry.SETCURRENTKEY(TCSEntry."Party Type", TCSEntry."Party Code", TCSEntry."Posting Date", TCSEntry."TCS Type", TCSEntry."Assessee Code", TCSEntry.Applied, TCSEntry."Per Contract");
        TCSEntry.SETCURRENTKEY(TCSEntry."Posting Date", TCSEntry."Assessee Code", TCSEntry.Applied, TCSEntry."Per Contract");
        //16225 TCSEntry.SETFILTER(TCSEntry."Party Code", '%1', PartyCode);
        TCSEntry.SETFILTER("Posting Date", '%1..%2', 20200110D, PeriodEndDate);//100120D
        TCSEntry.SETFILTER("TCS Amount", '<>%1', 0);
        IF TCSEntry.FINDFIRST THEN
            REPEAT
                Amt += TCSEntry."TCS Base Amount";
            UNTIL TCSEntry.NEXT = 0;
    end;

    procedure SetTCSJournalBatch(LclTemplateName: Code[20]; LclTemplateBatch: Code[20])
    begin
        TemplateName := LclTemplateName;
        BatchName := LclTemplateBatch;
    end;

    local procedure GenerateDebitNoteEntries(PartyCode: Code[20]; TCSBaseAmt: Decimal; TCSNOC: Code[10])
    begin
        IF TCSBaseAmt <= 0 THEN
            EXIT;

        GenJournalBatch.GET(TemplateName, BatchName);
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document Type" := GenJournalLine."Document Type"::Invoice;
        GenJournalLine."Document No." := DocNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Location Code" := GenJournalBatch."Location Code";
        GenJournalLine.VALIDATE("Posting Date", PeriodEndDate);
        GenJournalLine.INSERT(TRUE);

        GenJournalLine.VALIDATE("Party Type", GenJournalLine."Party Type"::Customer);
        GenJournalLine.VALIDATE("Party Code", PartyCode);
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
        GenJournalLine."Account No." := PartyCode;

        GenJournalLine.VALIDATE(Amount, TCSBaseAmt);
        GenJournalLine."T.A.N. No." := 'DELO00049A';
        GenJournalLine.VALIDATE("TCS Nature of Collection", '206C-1H');
        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine.VALIDATE("Bal. Account No.", '11315131');
        GenJournalLine.MODIFY;
        LineNo += 100;

        GenJournalLine1.INIT;
        GenJournalLine1."Journal Template Name" := TemplateName;
        GenJournalLine1."Journal Batch Name" := BatchName;
        GenJournalLine1."Document Type" := GenJournalLine1."Document Type"::Payment;
        GenJournalLine1."Document No." := DocNo;
        GenJournalLine1."Line No." := LineNo;
        GenJournalLine1."Location Code" := GenJournalBatch."Location Code";
        GenJournalLine1.VALIDATE("Posting Date", PeriodEndDate);
        GenJournalLine1.INSERT(TRUE);

        GenJournalLine1."Account Type" := GenJournalLine1."Account Type"::Customer;
        GenJournalLine1."Account No." := PartyCode;

        GenJournalLine1.VALIDATE(Amount, -1 * TCSBaseAmt);
        GenJournalLine1."Bal. Account Type" := GenJournalLine1."Bal. Account Type"::"G/L Account";
        GenJournalLine1."Applies-to Doc. Type" := GenJournalLine1."Applies-to Doc. Type"::Invoice;
        GenJournalLine1."Applies-to Doc. No." := GenJournalLine."Document No.";
        GenJournalLine1.VALIDATE("Bal. Account No.", '11315131');
        GenJournalLine1.MODIFY;
        LineNo += 100;
        NoSeriesManagement.IncrementNoText(DocNo, 1);
    end;

    local procedure CreateErrorList()
    begin
    end;
}

