report 50348 "MIS Report OverDue"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\MISReportOverDue.rdl';

    dataset
    {
        dataitem("Matrix Master"; "Matrix Master")
        {
            RequestFilterFields = "Type 1", "Tableau Zone";
            column("Area"; "Matrix Master"."Type 1")
            {
            }
            column(Zone; "Matrix Master"."Tableau Zone")
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemLink = "Area Code" = FIELD("Type 1");
                DataItemTableView = WHERE("Tableau Zone" = FILTER('<>CKA'));
                RequestFilterFields = "No.", "Area Code";
                column(CustNo; "No.")
                {
                }
                column(Collection1; (Collection[1]))
                {
                }
                column(Collection2; (Collection[2]))
                {
                }
                column(Collection3; (Collection[3]))
                {
                }
                column(Collection4; (Collection[4]))
                {
                }
                column(Collection5; (Collection[5]))
                {
                }
                column(Collection6; (Collection[6]))
                {
                }
                column(Collection7; (Collection[7]))
                {
                }
                column(Collection8; (Collection[8]))
                {
                }
                column(Collection9; (Collection[9]))
                {
                }
                column(Collection10; (Collection[10]))
                {
                }
                column(Collection11; (Collection[11]))
                {
                }
                column(Collection12; (Collection[12]))
                {
                }
                column(sales1; ABS(Sales[1]))
                {
                }
                column(sales2; ABS(Sales[2]))
                {
                }
                column(sales3; ABS(Sales[3]))
                {
                }
                column(sales4; ABS(Sales[4]))
                {
                }
                column(sales5; ABS(Sales[5]))
                {
                }
                column(sales6; ABS(Sales[6]))
                {
                }
                column(sales7; ABS(Sales[7]))
                {
                }
                column(sales8; ABS(Sales[8]))
                {
                }
                column(sales9; ABS(Sales[9]))
                {
                }
                column(sales10; ABS(Sales[10]))
                {
                }
                column(sales11; ABS(Sales[11]))
                {
                }
                column(sales12; ABS(Sales[12]))
                {
                }
                column(OutStanding4; OpeningBalance)
                {
                }
                column(OutStanding5; (OpeningBalance + OSNetChnge[4]))
                {
                }
                column(OutStanding6; (OpeningBalance + OSNetChnge[4] + OSNetChnge[5]))
                {
                }
                column(OutStanding7; (OpeningBalance + OSNetChnge[4] + OSNetChnge[5] + OSNetChnge[6]))
                {
                }
                column(OutStanding8; (OpeningBalance + OSNetChnge[4] + OSNetChnge[5] + OSNetChnge[6] + OSNetChnge[7]))
                {
                }
                column(OutStanding9; (OpeningBalance + OSNetChnge[4] + OSNetChnge[5] + OSNetChnge[6] + OSNetChnge[7] + OSNetChnge[8]))
                {
                }
                column(OutStanding10; (OpeningBalance + OSNetChnge[4] + OSNetChnge[5] + OSNetChnge[6] + OSNetChnge[7] + OSNetChnge[8] + OSNetChnge[9]))
                {
                }
                column(OutStanding11; (OpeningBalance + OSNetChnge[4] + OSNetChnge[5] + OSNetChnge[6] + OSNetChnge[7] + OSNetChnge[8] + OSNetChnge[9] + OSNetChnge[10]))
                {
                }
                column(OutStanding12; (OpeningBalance + OSNetChnge[4] + OSNetChnge[5] + OSNetChnge[6] + OSNetChnge[7] + OSNetChnge[8] + OSNetChnge[9] + OSNetChnge[10] + OSNetChnge[11]))
                {
                }
                column(OutStanding1; (OpeningBalance + OSNetChnge[4] + OSNetChnge[5] + OSNetChnge[6] + OSNetChnge[7] + OSNetChnge[8] + OSNetChnge[9] + OSNetChnge[10] + OSNetChnge[11] + OSNetChnge[12]))
                {
                }
                column(OutStanding2; (OpeningBalance + OSNetChnge[4] + OSNetChnge[5] + OSNetChnge[6] + OSNetChnge[7] + OSNetChnge[8] + OSNetChnge[9] + OSNetChnge[10] + OSNetChnge[11] + OSNetChnge[12] + OSNetChnge[1]))
                {
                }
                column(OutStanding3; (OpeningBalance + OSNetChnge[4] + OSNetChnge[5] + OSNetChnge[6] + OSNetChnge[7] + OSNetChnge[8] + OSNetChnge[9] + OSNetChnge[10] + OSNetChnge[11] + OSNetChnge[12] + OSNetChnge[1] + OSNetChnge[2]))
                {
                }
                column(OverDue1; ABS(OverDue[1]))
                {
                }
                column(OverDue2; ABS(OverDue[2]))
                {
                }
                column(OverDue3; ABS(OverDue[3]))
                {
                }
                column(OverDue4; ABS(OverDue[4]))
                {
                }
                column(OverDue5; ABS(OverDue[5]))
                {
                }
                column(OverDue6; ABS(OverDue[6]))
                {
                }
                column(OverDue7; ABS(OverDue[7]))
                {
                }
                column(OverDue8; ABS(OverDue[8]))
                {
                }
                column(OverDue9; ABS(OverDue[9]))
                {
                }
                column(OverDue10; ABS(OverDue[10]))
                {
                }
                column(OverDue11; ABS(OverDue[11]))
                {
                }
                column(OverDue12; ABS(OverDue[12]))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(CustLedgerEntry);
                    CLEAR(Sales);
                    CLEAR(Collection);
                    CLEAR(OpeningBalance);
                    CLEAR(OSNetChnge);
                    CLEAR(OverDue);
                    CustLedgerEntry.RESET;
                    CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Currency Code");
                    CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                    CustLedgerEntry.SETFILTER("Posting Date", '%1..%2', 0D, FinEndDate);
                    //CustLedgerEntry.SETRANGE("Posting Date",FinStartDate,FinEndDate);
                    IF CustLedgerEntry.FINDFIRST THEN BEGIN
                        REPEAT
                            CustLedgerEntry.CALCFIELDS("Amount (LCY)");
                            IF (CustLedgerEntry."Posting Date" >= FinStartDate) AND (CustLedgerEntry."Posting Date" <= FinEndDate) THEN BEGIN
                                //Month := DATE2DMY(CustLedgerEntry."Posting Date",2);

                                ///---
                                //      IF Month <> DATE2DMY(CustLedgerEntry."Posting Date", 2) THEN BEGIN
                                Month := DATE2DMY(CustLedgerEntry."Posting Date", 2);
                                //      END;
                                ///---
                                CASE CustLedgerEntry."Document Type" OF
                                    CustLedgerEntry."Document Type"::Payment:
                                        Collection[Month] += CustLedgerEntry."Amount (LCY)";
                                    CustLedgerEntry."Document Type"::Refund:
                                        Collection[Month] += CustLedgerEntry."Amount (LCY)";

                                END;
                                OSNetChnge[Month] += CustLedgerEntry."Amount (LCY)";
                            END;
                            IF CustLedgerEntry."Posting Date" <= FinStartDate - 1 THEN
                                OpeningBalance += CustLedgerEntry."Amount (LCY)";
                            IF (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Invoice) AND (ISOpenEntry(CustLedgerEntry)) THEN
                                CalculateOverDueAmt(CustLedgerEntry);

                        UNTIL CustLedgerEntry.NEXT = 0;
                    END;

                    CLEAR(SalesJournalData);
                    SalesJournalData.SETRANGE(SalesJournalData.CustomerNo, Customer."No.");
                    SalesJournalData.SETRANGE(SalesJournalData.PostingDateFilter, FinStartDate, FinEndDate);
                    SalesJournalData.OPEN;
                    WHILE SalesJournalData.READ DO BEGIN
                        Month := DATE2DMY(SalesJournalData.PostingDate, 2);
                        Sales[Month] += SalesJournalData.LineAmount;
                    END;

                    CLEAR(SalesReturnJournalData);
                    SalesReturnJournalData.SETRANGE(SalesReturnJournalData.CustomerNo, Customer."No.");
                    SalesReturnJournalData.SETRANGE(SalesReturnJournalData.PostingDateFilter, FinStartDate, FinEndDate);
                    SalesReturnJournalData.OPEN;
                    WHILE SalesReturnJournalData.READ DO BEGIN
                        Month := DATE2DMY(SalesReturnJournalData.PostingDate, 2);
                        Sales[Month] -= SalesReturnJournalData.LineAmount;
                    END;

                    /*
                    IF (Collection[1] + Collection[2] + Collection[3] + Collection[4] + Collection[5] +
                      Collection[6] + Collection[7] + Collection[8] + Collection[9] + Collection[10] + Collection[11] + Collection[12]) = 0 THEN
                    
                    
                    Sales[1]+Sales[2]+Sales[3]+Sales[4]+Sales[5]+Sales[6]+Sales[7]+Sales[8]+Sales[9]+Sales[10]+Sales[11]+Sales[12]
                    
                    IF (Collection[4] = 0) AND (Sales[4] = 0) THEN;
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
                field("Financial Year"; FinYr)
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
        ERROR(' Error');
    end;

    trigger OnPreReport()
    begin
        FinStartDate := DMY2DATE(1, 4, FinYr);
        FinEndDate := DMY2DATE(31, 3, FinYr + 1);
    end;

    var
        OverDue: array[12] of Decimal;
        Collection: array[12] of Decimal;
        OpeningBalance: Decimal;
        OSNetChnge: array[12] of Decimal;
        Sales: array[12] of Decimal;
        FinStartDate: Date;
        FinEndDate: Date;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Month: Integer;
        i: Integer;
        FinYr: Integer;
        HideRow: Boolean;
        SalesJournalData: Query "Sales Journal Data";
        SalesReturnJournalData: Query "Sales Return Journal Data";

    local procedure CalculateOverDueAmt(OrgCustLedgerEntry: Record "Cust. Ledger Entry")
    var
        CustLedgerEntry1: Record "Cust. Ledger Entry";
        Date: Record Date;
        Mth: Integer;
    begin

        Date.SETRANGE("Period Type", Date."Period Type"::Month);
        Date.SETFILTER("Period Start", '>=%1', FinStartDate);
        Date.SETFILTER("Period End", '<=%1', FinEndDate);
        IF Date.FINDFIRST THEN BEGIN
            REPEAT
                CustLedgerEntry1.RESET;
                CustLedgerEntry1.SETRANGE("Entry No.", OrgCustLedgerEntry."Entry No.");
                CustLedgerEntry1.SETFILTER("Date Filter", '%1..%2', Date."Period Start", Date."Period End");
                CustLedgerEntry1.SETFILTER("Due Date", '<%1', Date."Period Start");
                IF CustLedgerEntry1.FINDFIRST THEN BEGIN
                    CustLedgerEntry1.CALCFIELDS("Remaining Amt. (LCY)");
                    Mth := DATE2DMY(CustLedgerEntry1."Due Date", 2);
                    IF CustLedgerEntry1."Remaining Amt. (LCY)" <> 0 THEN
                        OverDue[Mth] += CustLedgerEntry1."Remaining Amt. (LCY)";
                END;
            UNTIL Date.NEXT = 0;
        END;
    end;

    local procedure ISOpenEntry(OrgCustLedgerEntry: Record "Cust. Ledger Entry"): Boolean
    begin
        OrgCustLedgerEntry.SETFILTER("Date Filter", '%1..%2', 0D, FinStartDate);
        OrgCustLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
        IF (OrgCustLedgerEntry."Remaining Amt. (LCY)" = 0) THEN
            EXIT(FALSE)
        ELSE
            EXIT(TRUE);
    end;
}

