report 50032 "Payment Collection Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\PaymentCollectionReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = SORTING("Tableau Zone", "Area Code", "PCH Code", "No.");
            RequestFilterFields = "No.";
            column(CurrentYrStartDate; FORMAT(CurrentYrStartDate))
            {
            }
            column(CurrentYrEndDate; FORMAT(CurrentYrEndDate))
            {
            }
            column(LastYrStartDate; FORMAT(LastYrStartDate))
            {
            }
            column(LastYrEndDate; FORMAT(LastYrEndDate))
            {
            }
            column(prevMonthStartDate; FORMAT(prevMonthStartDate))
            {
            }
            column(prevMonthEndDate; FORMAT(prevMonthEndDate))
            {
            }
            column(Detailed; Detailed)
            {
            }
            column(PCHName; Customer."PCH Name")
            {
            }
            column(PCHCode_Customer; Customer."PCH Code")
            {
            }
            column(TableauZone_Customer; Customer."Tableau Zone")
            {
            }
            column(StateDesc_Customer; Customer."Area Code")
            {
            }
            column(CurrTotAmt; ABS(CurrTotAmt))
            {
            }
            column(PrevTotAmt; ABS(PrevTotAmt))
            {
            }
            column(LastTotAmt; ABS(LastTotAmt))
            {
            }
            column(FinalCurrRemAmt; ABS(FinalCurrRemAmt))
            {
            }
            column(FinalPrevRemAmt; ABS(FinalPrevRemAmt))
            {
            }
            column(FinalLastRemAmt; ABS(FinalLastRemAmt))
            {
            }
            dataitem("Cust. Ledger Entry"; 21)
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code")
                                    WHERE("Document Type" = FILTER('Payment|Refund'));
                RequestFilterFields = "Entry No.";
                column(CustomerNo_CustLedgerEntry; "Cust. Ledger Entry"."Customer No.")
                {
                }
                column(PostingDate_CustLedgerEntry; FORMAT("Cust. Ledger Entry"."Posting Date"))
                {
                }
                column(DocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(PayRemAmt; "Cust. Ledger Entry"."Remaining Amt. (LCY)")
                {
                }
                dataitem(AppliedCustLedgEntries; 2000000026)
                {
                    column(OverDueAmt; OverDueAmt)
                    {
                    }
                    column(DueInvoiceAmt; DueInvoiceAmt)
                    {
                    }
                    column(AdvanceAmt; AdvanceAmt)
                    {
                    }
                    column(DocumentNo_CustLedgerEntry2; CustLedgerEntry1."Document No.")
                    {
                    }
                    column(DueDate_CustLedgerEntry2; FORMAT(CustLedgerEntry1."Due Date"))
                    {
                    }
                    column(Amt; CustLedgerEntry1."Closed by Amount")
                    {
                    }
                    column(OverDueAmt2; OverDueAmt2)
                    {
                    }
                    column(DueInvoiceAmt2; DueInvoiceAmt2)
                    {
                    }
                    column(AdvanceAmt2; AdvanceAmt2)
                    {
                    }
                    column(OverDueAmt3; OverDueAmt3)
                    {
                    }
                    column(DueInvoiceAmt3; DueInvoiceAmt3)
                    {
                    }
                    column(AdvanceAmt3; AdvanceAmt3)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        InitialiseVariables;
                        IF Number = 1 THEN
                            CustLedgerEntry1.FIND('-')
                        ELSE
                            CustLedgerEntry1.NEXT;
                        //MESSAGE('%1..%2..%3', CustLedgerEntry1."Document No.", CustLedgerEntry1."Due Date", CustLedgerEntry1."Closed by Amount");

                        IF ("Cust. Ledger Entry"."Posting Date" >= CurrentYrStartDate) AND ("Cust. Ledger Entry"."Posting Date" <= CurrentYrEndDate) THEN
                            AllocateAmt(OverDueAmt, DueInvoiceAmt, AdvanceAmt, CurrentYrStartDate, CurrentYrEndDate, CustLedgerEntry1)
                        ELSE
                            IF ("Cust. Ledger Entry"."Posting Date" >= prevMonthStartDate) AND ("Cust. Ledger Entry"."Posting Date" <= prevMonthEndDate) THEN
                                AllocateAmt(OverDueAmt2, DueInvoiceAmt2, AdvanceAmt2, prevMonthStartDate, prevMonthEndDate, CustLedgerEntry1)
                            ELSE
                                IF ("Cust. Ledger Entry"."Posting Date" >= LastYrStartDate) AND ("Cust. Ledger Entry"."Posting Date" <= LastYrEndDate) THEN
                                    AllocateAmt(OverDueAmt3, DueInvoiceAmt3, AdvanceAmt3, LastYrStartDate, LastYrEndDate, CustLedgerEntry1);
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETFILTER(AppliedCustLedgEntries.Number, '%1..%2', 1, CustLedgerEntry1.COUNT);
                        //MESSAGE('%1',CustLedgerEntry1.COUNT);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(CustLedgerEntry1);
                    GetCustAppliedEntries("Cust. Ledger Entry"."Entry No.", CustLedgerEntry1);

                    //IF ("Cust. Ledger Entry"."Posting Date" >= CurrentYrStartDate) AND ("Cust. Ledger Entry"."Posting Date" <=CurrentYrEndDate) then
                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Posting Date", '%1..%2|%3..%4|%5..%6', CurrentYrStartDate, CurrentYrEndDate, prevMonthStartDate, prevMonthEndDate, LastYrStartDate, LastYrEndDate);
                end;
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = WHERE(Number = CONST(1));
                column(CurrMonthPCHAmt; ABS(CurrMonthPCHAmt))
                {
                }
                column(CurrMonthZoneAmt; ABS(CurrMonthZoneAmt))
                {
                }
                column(PrevMonthPCHAmt; ABS(PrevMonthPCHAmt))
                {
                }
                column(PrevMonthZoneAmt; ABS(PrevMonthZoneAmt))
                {
                }
                column(LastYrPCHAmt; ABS(LastYrPCHAmt))
                {
                }
                column(LastYrZoneAmt; ABS(LastYrZoneAmt))
                {
                }
                column(CurrRemAmt; ABS(CurrRemAmt))
                {
                }
                column(PrevRemAmt; ABS(PrevRemAmt))
                {
                }
                column(LastRemAmt; ABS(LastRemAmt))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF PchCode <> Customer."Area Code" THEN BEGIN
                        PchCode := Customer."Area Code";
                        CLEAR(CurrMonthPCHAmt);
                        CLEAR(PrevMonthPCHAmt);
                        CLEAR(LastYrPCHAmt);
                        CLEAR(CurrRemAmt);
                        CLEAR(PrevRemAmt);
                        CLEAR(LastRemAmt);
                    END;
                    IF PchCode = Customer."Area Code" THEN BEGIN
                        CustLedgerEntry.RESET;
                        CustLedgerEntry.SETCURRENTKEY("Customer No.");
                        CustLedgerEntry.SETFILTER("Posting Date", '%1..%2', CurrentYrStartDate, CurrentYrEndDate);
                        CustLedgerEntry.SETFILTER("Document Type", '%1|%2', CustLedgerEntry."Document Type"::Payment, CustLedgerEntry."Document Type"::Refund);
                        CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                        IF CustLedgerEntry.FINDFIRST THEN
                            REPEAT
                                CustLedgerEntry.CALCFIELDS(Amount);
                                CurrMonthPCHAmt += CustLedgerEntry.Amount;
                                CurrTotAmt += CustLedgerEntry.Amount;
                                CustLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                                CurrRemAmt += CustLedgerEntry."Remaining Amt. (LCY)";
                                FinalCurrRemAmt += CustLedgerEntry."Remaining Amt. (LCY)"
UNTIL CustLedgerEntry.NEXT = 0;

                        CustLedgerEntry.RESET;
                        CustLedgerEntry.SETCURRENTKEY("Customer No.");
                        CustLedgerEntry.SETFILTER("Posting Date", '%1..%2', prevMonthStartDate, prevMonthEndDate);
                        CustLedgerEntry.SETFILTER("Document Type", '%1|%2', CustLedgerEntry."Document Type"::Payment, CustLedgerEntry."Document Type"::Refund);
                        CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                        IF CustLedgerEntry.FINDFIRST THEN
                            REPEAT
                                CustLedgerEntry.CALCFIELDS(Amount);
                                PrevMonthPCHAmt += CustLedgerEntry.Amount;
                                PrevTotAmt += CustLedgerEntry.Amount;
                                CustLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                                PrevRemAmt += CustLedgerEntry."Remaining Amt. (LCY)";
                                FinalPrevRemAmt += CustLedgerEntry."Remaining Amt. (LCY)";
                            UNTIL CustLedgerEntry.NEXT = 0;

                        CustLedgerEntry.RESET;
                        CustLedgerEntry.SETCURRENTKEY("Customer No.");
                        CustLedgerEntry.SETFILTER("Posting Date", '%1..%2', LastYrStartDate, LastYrEndDate);
                        CustLedgerEntry.SETFILTER("Document Type", '%1|%2', CustLedgerEntry."Document Type"::Payment, CustLedgerEntry."Document Type"::Refund);
                        CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                        IF CustLedgerEntry.FINDFIRST THEN
                            REPEAT
                                CustLedgerEntry.CALCFIELDS(Amount);
                                LastYrPCHAmt += CustLedgerEntry.Amount;
                                LastTotAmt += CustLedgerEntry.Amount;
                                CustLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                                LastRemAmt += CustLedgerEntry."Remaining Amt. (LCY)";
                                FinalLastRemAmt += CustLedgerEntry."Remaining Amt. (LCY)";
                            UNTIL CustLedgerEntry.NEXT = 0;
                    END;

                    /*
                    IF TabZoneCode <> Customer."Tableau Zone" THEN BEGIN
                      TabZoneCode := Customer."Tableau Zone";
                      CLEAR(CurrMonthZoneAmt);
                      CLEAR(PrevMonthZoneAmt);
                      CLEAR(LastYrZoneAmt);
                    END;
                    IF TabZoneCode = Customer."Tableau Zone" THEN BEGIN
                      CustLedgerEntry.RESET;
                      CustLedgerEntry.SETCURRENTKEY("Customer No.");
                      CustLedgerEntry.SETFILTER("Posting Date", '%1..%2', CurrentYrStartDate, CurrentYrEndDate);
                      CustLedgerEntry.SETFILTER("Document Type", '%1|%2', CustLedgerEntry."Document Type"::Payment, CustLedgerEntry."Document Type"::Refund);
                      CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                      IF CustLedgerEntry.FINDFIRST THEN REPEAT
                        CustLedgerEntry.CALCFIELDS(Amount);
                        CurrMonthZoneAmt += CustLedgerEntry.Amount;
                      UNTIL CustLedgerEntry.NEXT=0;
                    
                      CustLedgerEntry.RESET;
                      CustLedgerEntry.SETCURRENTKEY("Customer No.");
                      CustLedgerEntry.SETFILTER("Posting Date", '%1..%2', prevMonthStartDate, prevMonthEndDate);
                      CustLedgerEntry.SETFILTER("Document Type", '%1|%2', CustLedgerEntry."Document Type"::Payment, CustLedgerEntry."Document Type"::Refund);
                      CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                      IF CustLedgerEntry.FINDFIRST THEN REPEAT
                        CustLedgerEntry.CALCFIELDS(Amount);
                        PrevMonthZoneAmt += CustLedgerEntry.Amount;
                      UNTIL CustLedgerEntry.NEXT=0;
                    
                      CustLedgerEntry.RESET;
                      CustLedgerEntry.SETCURRENTKEY("Customer No.");
                      CustLedgerEntry.SETFILTER("Posting Date", '%1..%2', LastYrStartDate, LastYrEndDate);
                      CustLedgerEntry.SETFILTER("Document Type", '%1|%2', CustLedgerEntry."Document Type"::Payment, CustLedgerEntry."Document Type"::Refund);
                      CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                      IF CustLedgerEntry.FINDFIRST THEN REPEAT
                        CustLedgerEntry.CALCFIELDS(Amount);
                        LastYrZoneAmt += CustLedgerEntry.Amount;
                      UNTIL CustLedgerEntry.NEXT=0;
                    END;
                    */

                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("Month Date"; StartDate)
                    {
                        ApplicationArea = All;
                    }
                    field(Detailed; Detailed)
                    {
                        Visible = false;
                        ApplicationArea = All;
                    }
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
        CurrentYrStartDate := CALCDATE('-CM', StartDate);
        ;
        CurrentYrEndDate := StartDate;
        //MESSAGE('%1..%2', CurrentYrStartDate, CurrentYrEndDate);

        prevMonthStartDate := CALCDATE('-1D-CM', CurrentYrStartDate);
        //prevMonthEndDate := CALCDATE('CM',prevMonthStartDate);

        CalculateDate := (CALCDATE('CM', CurrentYrStartDate));
        IF CalculateDate = StartDate THEN
            prevMonthEndDate := CALCDATE('CM', prevMonthStartDate)
        ELSE
            prevMonthEndDate := DMY2DATE(DATE2DMY(StartDate, 1), DATE2DMY(StartDate, 2) - 1, DATE2DMY(StartDate, 3));
        //MESSAGE('%1..%2',prevMonthStartDate, prevMonthEndDate);

        LastYrEndDate := CALCDATE('-1Y', StartDate);
        ;
        LastYrStartDate := CALCDATE('-CM', LastYrEndDate);
        //ERROR('%1..%2',LastYrStartDate, LastYrEndDate);

        CLEAR(CurrTotAmt);
        CLEAR(PrevTotAmt);
        CLEAR(LastTotAmt);
        CLEAR(FinalCurrRemAmt);
        CLEAR(FinalLastRemAmt);
        CLEAR(FinalPrevRemAmt);
    end;

    var
        CurrentYrStartDate: Date;
        CurrentYrEndDate: Date;
        LastYrStartDate: Date;
        LastYrEndDate: Date;
        prevMonthStartDate: Date;
        prevMonthEndDate: Date;
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        OverDueAmt: Decimal;
        DueInvoiceAmt: Decimal;
        AdvanceAmt: Decimal;
        Detailed: Boolean;
        StartDate: Date;
        OverDueAmt2: Decimal;
        DueInvoiceAmt2: Decimal;
        AdvanceAmt2: Decimal;
        OverDueAmt3: Decimal;
        DueInvoiceAmt3: Decimal;
        AdvanceAmt3: Decimal;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CurrMonthPCHAmt: Decimal;
        CurrMonthZoneAmt: Decimal;
        PchCode: Code[20];
        TabZoneCode: Text[10];
        PrevMonthPCHAmt: Decimal;
        PrevMonthZoneAmt: Decimal;
        LastYrPCHAmt: Decimal;
        LastYrZoneAmt: Decimal;
        AppDueDate: Date;
        AppDocNo: Code[20];
        CustLedgerEntry1: Record "Cust. Ledger Entry" temporary;
        CalculateDate: Date;
        CurrTotAmt: Decimal;
        PrevTotAmt: Decimal;
        LastTotAmt: Decimal;
        CurrRemAmt: Decimal;
        PrevRemAmt: Decimal;
        LastRemAmt: Decimal;
        FinalCurrRemAmt: Decimal;
        FinalPrevRemAmt: Decimal;
        FinalLastRemAmt: Decimal;

    local procedure AllocateAmt(var Amt1: Decimal; var Amt2: Decimal; var Amt3: Decimal; STDate: Date; EDDate: Date; CustLedgEntry: Record "Cust. Ledger Entry")
    begin

        IF (CustLedgEntry."Due Date" < STDate) AND (CustLedgEntry."Posting Date" < STDate) THEN BEGIN
            Amt1 := CustLedgEntry."Closed by Amount";
        END ELSE
            IF (CustLedgEntry."Due Date" >= STDate) AND (CustLedgEntry."Posting Date" < STDate) THEN BEGIN
                Amt2 := CustLedgEntry."Closed by Amount";
            END ELSE
                IF ((CustLedgEntry."Posting Date" >= STDate) AND (CustLedgEntry."Posting Date" <= EDDate))
                   AND (CustLedgEntry."Due Date" >= STDate) THEN BEGIN
                    Amt3 := CustLedgEntry."Closed by Amount";
                END;
    end;

    local procedure InitialiseVariables()
    begin
        CLEAR(OverDueAmt);
        CLEAR(DueInvoiceAmt);
        CLEAR(AdvanceAmt);
        CLEAR(OverDueAmt2);
        CLEAR(DueInvoiceAmt2);
        CLEAR(AdvanceAmt2);
        CLEAR(OverDueAmt3);
        CLEAR(DueInvoiceAmt3);
        CLEAR(AdvanceAmt3);
    end;

    procedure GetCustAppliedEntries(SourceEntryNo: Integer; var AppliedCustLedgEntry: Record "Cust. Ledger Entry" temporary)
    var
        SourceCustLedgerEntry: Record "Cust. Ledger Entry";
        CreateCustLedgEntry: Record "Cust. Ledger Entry";
    begin
        IF SourceEntryNo <> 0 THEN BEGIN
            SourceCustLedgerEntry.GET(SourceEntryNo);
            FindCustApplnEntriesDtldtLedgEntry(SourceEntryNo, AppliedCustLedgEntry);

            AppliedCustLedgEntry.SETCURRENTKEY("Entry No.");
            IF AppliedCustLedgEntry."Closed by Entry No." <> 0 THEN BEGIN
                AppliedCustLedgEntry."Entry No." := SourceCustLedgerEntry."Closed by Entry No.";
                AppliedCustLedgEntry.MARK(TRUE);
            END;

            AppliedCustLedgEntry.SETCURRENTKEY("Closed by Entry No.");
            AppliedCustLedgEntry.SETRANGE("Closed by Entry No.", SourceCustLedgerEntry."Entry No.");
            IF AppliedCustLedgEntry.FIND('-') THEN
                REPEAT
                    AppliedCustLedgEntry.MARK(TRUE);
                UNTIL AppliedCustLedgEntry.NEXT = 0;

            AppliedCustLedgEntry.SETCURRENTKEY("Entry No.");
            AppliedCustLedgEntry.SETRANGE("Closed by Entry No.");
        END;

        AppliedCustLedgEntry.MARKEDONLY(TRUE);
    end;

    procedure FindCustApplnEntriesDtldtLedgEntry(EntryNo: Integer; var CustomerLedgerEntry: Record "Cust. Ledger Entry" temporary)
    var
        DtldCustLedgEntry1: Record "Detailed Cust. Ledg. Entry";
        DtldCustLedgEntry2: Record "Detailed Cust. Ledg. Entry";
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        DtldCustLedgEntry1.SETCURRENTKEY("Cust. Ledger Entry No.");
        DtldCustLedgEntry1.SETRANGE("Cust. Ledger Entry No.", EntryNo);
        DtldCustLedgEntry1.SETRANGE(Unapplied, FALSE);
        IF DtldCustLedgEntry1.FIND('-') THEN
            REPEAT
                IF DtldCustLedgEntry1."Cust. Ledger Entry No." =
                   DtldCustLedgEntry1."Applied Cust. Ledger Entry No."
                THEN BEGIN
                    DtldCustLedgEntry2.INIT;
                    DtldCustLedgEntry2.SETCURRENTKEY("Applied Cust. Ledger Entry No.", "Entry Type");
                    DtldCustLedgEntry2.SETRANGE(
                      "Applied Cust. Ledger Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                    DtldCustLedgEntry2.SETRANGE("Entry Type", DtldCustLedgEntry2."Entry Type"::Application);
                    DtldCustLedgEntry2.SETRANGE(Unapplied, FALSE);
                    IF DtldCustLedgEntry2.FIND('-') THEN
                        REPEAT

                            IF DtldCustLedgEntry2."Cust. Ledger Entry No." <>
                               DtldCustLedgEntry2."Applied Cust. Ledger Entry No."
                            THEN BEGIN
                                CustLedgerEntry.SETCURRENTKEY("Entry No.");
                                CustLedgerEntry.SETRANGE("Entry No.", DtldCustLedgEntry2."Cust. Ledger Entry No.");
                                IF CustLedgerEntry.FIND('-') THEN BEGIN
                                    IF NOT CustomerLedgerEntry.GET(CustLedgerEntry."Entry No.") THEN BEGIN
                                        CustomerLedgerEntry.TRANSFERFIELDS(CustLedgerEntry);
                                        CustomerLedgerEntry.INSERT;
                                    END;
                                END;
                            END;
                        UNTIL DtldCustLedgEntry2.NEXT = 0;
                END ELSE BEGIN
                    CustLedgerEntry.SETCURRENTKEY("Entry No.");
                    CustLedgerEntry.SETRANGE("Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                    IF CustLedgerEntry.FIND('-') THEN BEGIN
                        IF NOT CustomerLedgerEntry.GET(CustLedgerEntry."Entry No.") THEN BEGIN
                            CustomerLedgerEntry.TRANSFERFIELDS(CustLedgerEntry);
                            CustomerLedgerEntry.INSERT;
                        END;
                    END;
                END;
            UNTIL DtldCustLedgEntry1.NEXT = 0;
    end;
}

