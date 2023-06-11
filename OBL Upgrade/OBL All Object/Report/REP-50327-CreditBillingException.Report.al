report 50327 "Credit Billing Exception"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\CreditBillingException.rdl';
    Caption = 'Credit Billing Exception';
    TransactionType = UpdateNoLocks;

    dataset
    {
        dataitem(Customer; Customer)
        {
            CalcFields = "Balance (LCY)";
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.";
            UseTemporary = false;
            column(CustBalanceDueLCY_5_; CustBalanceDueLCY[5] / 100000)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_4_; CustBalanceDueLCY[4] / 100000)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_3_; CustBalanceDueLCY[3] / 100000)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_2_; CustBalanceDueLCY[2] / 100000)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_1_; CustBalanceDueLCY[1] / 100000)
            {
                AutoFormatType = 1;
            }
            column(Due7DaysAmt; Due7DaysAmt / 100000)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(CustomerType_Customer; Customer."Customer Type")
            {
            }
            column(StateCode_Customer; Customer."State Desc.")
            {
            }
            column(CF_Limit; Customer."CF Limit" / 100000)
            {
            }
            column(CF_Customer; Customer."CF Customer")
            {
            }
            column(TerritoryCode_Customer; Customer.City)
            {
            }
            column(Sales_territory; Salesterritory)
            {
            }
            column(Region; Customer."Tableau Zone")
            {
            }
            column(ExitenceSince; ExitenceSince)
            {
            }
            column(SecurityChqAvailability_Customer; FORMAT(Customer."CTS 1"))
            {
            }
            column(SecurityAmount_Customer; Customer."Security Amount")
            {
            }
            column(CreditLimitLCY_Customer; Customer."Credit Limit (LCY)" / 100000)
            {
            }
            column(OutstandingAmount_Customer; Bal / 100000)
            {
            }
            column(MTDSaleAmt; MTDSaleAmt / 100000)
            {
            }
            column(ACPD_cy; Customer."ACPD (Current Year)")
            {
            }
            column(ACPD_2022; Customer."ACD (Previous Year)")
            {
            }
            column(ACPD_LY; Customer."ACPD (Last 12m)")
            {
            }
            column(MTDInvoiceCount; MTDInvoiceCount)
            {
            }
            column(FY20SaleAmt; FY20SaleAmt / 100000)
            {
            }
            column(Anual_Tgt; Customer."Minmum Amt pur value")
            {
            }
            column(ACP; Customer."ACP (Last 12m)")
            {
            }
            column(ACPCY; Customer."ACP (Current Year)")
            {
            }
            column(acp_2022; Customer."ACP (Previous Year)")
            {
            }
            column(kbs_FY19SaleAmt; FY19SaleAmt / 100000)
            {
            }
            column(kbs_FY18SaleAmt; FY18SaleAmt / 100000)
            {
            }
            column(FY19SaleAmt; Customer."Billing FY22")
            {
            }
            column(FY18SaleAmt; Customer."Billing FY21")
            {
            }
            column(ReleasedOrderValue; ReleasedOrderValue / 100000)
            {
            }
            column(OpenOrderValue; OpenOrderValue / 100000)
            {
            }
            column(YTDCollection; ABS(YTDCollection) / 100000)
            {
            }
            column(MTDCollection; ABS(MTDCollection) / 100000)
            {
            }
            column(All; All)
            {
            }
            column(FinalPer50Value; FinalPer50Value / 100000)
            {
            }
            column(balance_conf; Customer."Balance Conf Recd Date")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Sell-to Customer No." = FIELD("No.");
                UseTemporary = false;
                column(LocationCode; "Sales Line"."Location Code")
                {
                }
                column(decOpenOrderVal; decOpenOrderVal / 100000)
                {
                }
                column(decReleasedOrderVal; decReleasedOrderVal / 100000)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(decOpenOrderVal);
                    CLEAR(decReleasedOrderVal);
                    IF "Sales Line".Status = "Sales Line".Status::Open THEN BEGIN
                        //16225   decOpenOrderVal := "Sales Line"."Outstanding Amount (LCY)" + (("Sales Line"."Outstanding Amount (LCY)" * "Sales Line"."GST %") / 100);
                        decOpenOrderVal := "Sales Line"."Outstanding Amount (LCY)" + (("Sales Line"."Outstanding Amount (LCY)" * AmttoCustomerSalesLine("Sales Line")) / 100);
                    END;
                    IF "Sales Line".Status = "Sales Line".Status::Released THEN BEGIN
                        //16225   
                        decReleasedOrderVal := "Sales Line"."Outstanding Amount (LCY)" + (("Sales Line"."Outstanding Amount (LCY)" * AmttoCustomerSalesLine("Sales Line")) / 100);
                    END;
                end;
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                CalcFields = "Original Amt. (LCY)", "Remaining Amt. (LCY)";
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.")
                                    ORDER(Ascending);
                RequestFilterFields = "Document Type";
                UseTemporary = false;
                column(AmtD7; (AmtD[7]) / 100000)
                {
                }
                column(AmtD1; (AmtD[1]) / 100000)
                {
                }
                column(AmtD2; (AmtD[2]) / 100000)
                {
                }
                column(AmtD3; (AmtD[3]) / 100000)
                {
                }
                column(AmtD4; (AmtD[4]) / 100000)
                {
                }
                column(AmtD5; (AmtD[5]) / 100000)
                {
                }
                column(AmtD6; (AmtD[6]) / 100000)
                {
                }
                column(AmtD8; (AmtD[8]) / 100000)
                {
                }
                column(AmtD9; (AmtD[9]) / 100000)
                {
                }
                column(AmtD10; (AmtD[10]) / 100000)
                {
                }
                column(AmtD11; (AmtD[11]) / 100000)
                {
                }
                column(AmtD12; (AmtD[12]) / 100000)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    FOR i := 1 TO 12 DO BEGIN   //Clear Varibales
                        CLEAR(Amt[i]);
                        CLEAR(AmtD[i]);
                    END;

                    CALCFIELDS("Remaining Amt. (LCY)", "Cust. Ledger Entry"."Original Amt. (LCY)");
                    IF ROUND("Remaining Amt. (LCY)", 0.01) = 0 THEN
                        CurrReport.SKIP;

                    Amt[1] := 0;
                    Amt[2] := 0;
                    Amt[3] := 0;
                    Amt[4] := 0;
                    Amt[5] := 0;
                    Amt[6] := 0;
                    Amt[7] := 0;
                    Amt[8] := 0;
                    Amt[9] := 0;
                    Amt[10] := 0;
                    Amt[11] := 0;
                    Amt[12] := 0;

                    IF ("Due Date" > EndDate + 7) THEN  //Notedue
                        Amt[1] := "Remaining Amt. (LCY)";
                    IF ("Due Date" <= EndDate + 7) AND ("Due Date" >= (EndDate + 1)) THEN  //Within -1 To -7  Days
                        Amt[2] := "Remaining Amt. (LCY)";

                    IF ("Due Date" <= EndDate) AND ("Due Date" >= (EndDate - 5)) THEN  //Within 0-5 Days
                        Amt[3] := "Remaining Amt. (LCY)";
                    IF ("Due Date" <= EndDate - 6) AND ("Due Date" >= (EndDate - 10)) THEN  //Within 6-10 Days
                        Amt[4] := "Remaining Amt. (LCY)";

                    IF ("Due Date" <= EndDate - 11) AND ("Due Date" >= (EndDate - 20)) THEN  //Within 11-20 Days
                        Amt[5] := "Remaining Amt. (LCY)";
                    IF ("Due Date" <= EndDate - 21) AND ("Due Date" >= (EndDate - 30)) THEN  //Within 21-30 Days
                        Amt[6] := "Remaining Amt. (LCY)";
                    IF ("Due Date" <= (EndDate - 31)) AND ("Due Date" >= (EndDate - 60)) THEN  //Between 31 Days to 60 Days
                        Amt[7] := "Remaining Amt. (LCY)";

                    IF ("Due Date" <= (EndDate - 61)) AND ("Due Date" >= (EndDate - 90)) THEN  //Between last 61 Days to 90 Days
                        Amt[8] := "Remaining Amt. (LCY)";
                    IF ("Due Date" <= (EndDate - 91)) AND ("Due Date" >= (EndDate - 180)) THEN  //Between last 91 Days to 180 Days
                        Amt[9] := "Remaining Amt. (LCY)";
                    IF ("Due Date" <= (EndDate - 181)) AND ("Due Date" >= (EndDate - 365)) THEN  //Between last 181 Days to 365 Days
                        Amt[10] := "Remaining Amt. (LCY)";
                    IF ("Due Date" <= (EndDate - 366)) THEN //Before 365 Days
                        Amt[11] := "Remaining Amt. (LCY)";

                    //FOR i := 1 TO 11 DO
                    //  Amt[12] += Amt[i];

                    //TRI N.M - 06.12.07 Start
                    IF MinimumAmt = TRUE THEN
                        IF (Amt[12] > 0) AND (AmountRestriction >= Amt[12]) THEN
                            CurrReport.SKIP
                        ELSE
                            IF (Amt[12] < 0) AND (AmountRestriction >= Amt[12]) THEN
                                CurrReport.SKIP;
                    //TRI N.M - 06.12.07 Stop


                    AmtD[12] := 0;
                    Amt[12] := 0;
                    FOR i := 1 TO 11 DO BEGIN
                        IF Amt[i] <> 0 THEN BEGIN
                            AmtD[i] := Amt[i];
                            AmtD[12] += Amt[i];
                        END ELSE BEGIN
                            AmtD[i] := 0;
                            //    Amtd[12]:=0;
                            // Amt[i]:=0;
                        END;


                    END;
                end;

                trigger OnPreDataItem()
                begin

                    FOR i := 1 TO 12 DO
                        CurrReport.CREATETOTALS(Amt[i]);

                    //TRI SB 010607 Add Start
                    SETRANGE("Posting Date", 0D, EndDate);
                    //SETFILTER("Date Filter",'<=%1',StartDate);
                    //TRI SB 010607 Add End
                    CALCFIELDS("Remaining Amt. (LCY)");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(Bal);
                IF Customer."Tableau Zone" <> 'CKA' THEN
                    Salesterritory := Customer."Area Code"
                ELSE
                    Salesterritory := 'CKA';

                Customer.CALCFIELDS("Balance (LCY)");
                Bal := Customer."Balance (LCY)";
                //MESSAGE('%1', Customer."Balance (LCY)");
                //////
                FOR i := 1 TO 6 DO BEGIN
                    DtldCustLedgEntry.SETCURRENTKEY("Customer No.", "Initial Entry Due Date", "Posting Date");
                    DtldCustLedgEntry.SETRANGE("Customer No.", "No.");
                    DtldCustLedgEntry.SETRANGE("Initial Entry Due Date", PeriodStartDate[i], PeriodStartDate[i + 1] - 1);
                    DtldCustLedgEntry.SETRANGE("Posting Date", 0D, EndDate);
                    DtldCustLedgEntry.CALCSUMS("Amount (LCY)");
                    CustBalanceDueLCY[i] := DtldCustLedgEntry."Amount (LCY)";
                END;

                CLEAR(Due7DaysAmt);
                DtldCustLedgEntry.RESET;
                DtldCustLedgEntry.SETCURRENTKEY("Customer No.", "Initial Entry Due Date", "Posting Date");
                DtldCustLedgEntry.SETRANGE("Customer No.", "No.");
                DtldCustLedgEntry.SETRANGE("Initial Entry Due Date", EndDate + 1, Due7DaysEDDate);
                DtldCustLedgEntry.SETRANGE("Posting Date", 0D, EndDate);
                DtldCustLedgEntry.CALCSUMS("Amount (LCY)");
                Due7DaysAmt := DtldCustLedgEntry."Amount (LCY)";

                ////
                CLEAR(ExitenceSince);
                IF Customer."Creation Date" <> 0D THEN
                    ExitenceSince := TODAY - Customer."Creation Date";

                CLEAR(MTDInvoiceCount);
                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETCURRENTKEY("Sell-to Customer No.");
                SalesInvoiceHeader.SETRANGE("Sell-to Customer No.", Customer."No.");
                SalesInvoiceHeader.SETFILTER("Posting Date", '%1..%2', MTDFromDate, EndDate);
                MTDInvoiceCount := SalesInvoiceHeader.COUNT;

                //ERROR('%1..%2',MTDFromDate,EndDate);
                CLEAR(MTDSaleAmt);
                CLEAR(SalesJournalData);
                SalesJournalData.SETRANGE(CustomerNo, Customer."No.");
                SalesJournalData.SETFILTER(PostingDateFilter, '%1..%2', MTDFromDate, EndDate);
                SalesJournalData.OPEN;
                WHILE SalesJournalData.READ DO BEGIN
                    ///    MTDSaleAmt += SalesJournalData.AmountToCustomer;
                END;

                CLEAR(FY20SaleAmt);
                CLEAR(SalesJournalData);
                SalesJournalData.SETRANGE(CustomerNo, Customer."No.");
                SalesJournalData.SETFILTER(PostingDateFilter, '%1..%2', FY20StartDate, EndDate);
                SalesJournalData.OPEN;
                WHILE SalesJournalData.READ DO BEGIN
                    ///    FY20SaleAmt += SalesJournalData.AmountToCustomer;
                END;

                CLEAR(FY19SaleAmt);
                CLEAR(SalesJournalData);
                SalesJournalData.SETRANGE(CustomerNo, Customer."No.");
                SalesJournalData.SETFILTER(PostingDateFilter, '%1..%2', FY19StartDate, FY20StartDate - 1);
                SalesJournalData.OPEN;
                WHILE SalesJournalData.READ DO BEGIN
                    ///    FY19SaleAmt += SalesJournalData.AmountToCustomer;
                END;

                CLEAR(FY18SaleAmt);
                CLEAR(SalesJournalData);
                SalesJournalData.SETRANGE(CustomerNo, Customer."No.");
                SalesJournalData.SETFILTER(PostingDateFilter, '%1..%2', FY18StartDate, FY19StartDate - 1);
                SalesJournalData.OPEN;
                WHILE SalesJournalData.READ DO BEGIN
                    ///    FY18SaleAmt += SalesJournalData.AmountToCustomer;
                END;

                CLEAR(OpenOrderValue);
                CLEAR(ReleasedOrderValue);
                SalesLine.RESET;
                SalesLine.SETCURRENTKEY("Sell-to Customer No.");
                SalesLine.SETRANGE("Sell-to Customer No.", Customer."No.");
                SalesLine.SETFILTER("Posting Date", '%1..%2', 0D, TODAY);
                SalesLine.SETFILTER("Document Type", '%1', SalesLine."Document Type"::Order);
                IF SalesLine.FINDSET THEN
                    REPEAT
                        IF SalesLine.Status = SalesLine.Status::Open THEN BEGIN
                            //16225 OpenOrderValue += SalesLine."Outstanding Amount (LCY)" + ((SalesLine."Outstanding Amount (LCY)" * SalesLine."GST %") / 100);
                            OpenOrderValue += SalesLine."Outstanding Amount (LCY)" + ((SalesLine."Outstanding Amount (LCY)" * AmttoCustomerSalesLine("Sales Line")) / 100);
                        END;
                        IF SalesLine.Status = SalesLine.Status::Released THEN BEGIN
                            //16225  ReleasedOrderValue += SalesLine."Outstanding Amount (LCY)" + ((SalesLine."Outstanding Amount (LCY)" * SalesLine."GST %") / 100);
                            ReleasedOrderValue += SalesLine."Outstanding Amount (LCY)" + ((SalesLine."Outstanding Amount (LCY)" * AmttoCustomerSalesLine("Sales Line")) / 100);
                        END;
                    UNTIL SalesLine.NEXT = 0;

                CLEAR(MTDCollection);
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETCURRENTKEY("Customer No.");
                CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                CustLedgerEntry.SETFILTER("Document Type", '%1|%2', CustLedgerEntry."Document Type"::Payment, CustLedgerEntry."Document Type"::Refund);
                CustLedgerEntry.SETFILTER("Posting Date", '%1..%2', MTDFromDate, EndDate);
                IF CustLedgerEntry.FINDSET THEN
                    REPEAT
                        CustLedgerEntry.CALCFIELDS(Amount);
                        MTDCollection += CustLedgerEntry.Amount;
                    UNTIL CustLedgerEntry.NEXT = 0;
                CLEAR(Per50Value);
                CLEAR(FinalPer50Value);
                Per50Value := MTDCollection / 2;

                Per50Value := ABS(Per50Value) - MTDSaleAmt;
                //MESSAGE('%1', Per50Value);
                IF Per50Value >= 0 THEN
                    FinalPer50Value := Per50Value
                ELSE
                    FinalPer50Value := 0;

                CLEAR(YTDCollection);
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETCURRENTKEY("Customer No.");
                CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                CustLedgerEntry.SETFILTER("Document Type", '%1|%2', CustLedgerEntry."Document Type"::Payment, CustLedgerEntry."Document Type"::Refund);
                CustLedgerEntry.SETFILTER("Posting Date", '%1..%2', FY20StartDate, EndDate);
                IF CustLedgerEntry.FINDSET THEN
                    REPEAT
                        CustLedgerEntry.CALCFIELDS(Amount);
                        YTDCollection += CustLedgerEntry.Amount;
                    UNTIL CustLedgerEntry.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS(CustBalanceDueLCY);
                CurrReport.CREATETOTALS(Due7DaysAmt);
            end;
        }
    }

    requestpage
    {
        SaveValues = false;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("End Date"; EndDate)
                    {
                        ApplicationArea = All;
                    }
                    field("For All Customers"; All)
                    {
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

    trigger OnInitReport()
    begin
        /*IF TIME >160100T THEN
          ERROR('-');*/
        EndDate := TODAY;

    end;

    trigger OnPreReport()
    begin

        All := FALSE;
        MTDFromDate := CALCDATE('-CM', EndDate);

        IF DATE2DMY(EndDate, 2) < 4 THEN
            FY20StartDate := DMY2DATE(1, 4, DATE2DMY(EndDate, 3) - 1)
        ELSE
            FY20StartDate := DMY2DATE(1, 4, DATE2DMY(EndDate, 3));

        FY19StartDate := CALCDATE('-1Y', FY20StartDate);
        FY18StartDate := CALCDATE('-1Y', FY19StartDate);
        Due7DaysEDDate := CALCDATE('7D', EndDate);

        PeriodStartDate[6] := EndDate;
        PeriodStartDate[7] := 99991231D;
        FOR i := 5 DOWNTO 2 DO
            PeriodStartDate[i] := CALCDATE('<-30D>', PeriodStartDate[i + 1]);
    end;

    var
        Text001: Label 'As of %1';
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        PeriodStartDate: array[7] of Date;
        CustBalanceDueLCY: array[6] of Decimal;
        i: Integer;
        Customer___Summary_Aging_Simp_CaptionLbl: Label 'Customer - Summary Aging Simp.';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY';
        CustBalanceDueLCY_5__Control25CaptionLbl: Label 'Not Due';
        CustBalanceDueLCY_4__Control26CaptionLbl: Label '0-30 days';
        CustBalanceDueLCY_3__Control27CaptionLbl: Label '31-60 days';
        CustBalanceDueLCY_2__Control28CaptionLbl: Label '61-90 days';
        CustBalanceDueLCY_1__Control29CaptionLbl: Label 'Over 90 days';
        TotalCaptionLbl: Label 'Total';
        EndDate: Date;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        ExitenceSince: Integer;
        SalesJournalData: Query "Sales Journal Data";
        MTDFromDate: Date;
        MTDInvoiceCount: Integer;
        MTDSaleAmt: Decimal;
        FY19StartDate: Date;
        FY19SaleAmt: Decimal;
        FY18StartDate: Date;
        FY18SaleAmt: Decimal;
        FY20StartDate: Date;
        FY20SaleAmt: Decimal;
        Due7DaysEDDate: Date;
        Due7DaysAmt: Decimal;
        SalesLine: Record "Sales Line";
        OpenOrderValue: Decimal;
        ReleasedOrderValue: Decimal;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        YTDCollection: Decimal;
        MTDCollection: Decimal;
        Amt: array[12] of Decimal;
        AmtD: array[12] of Decimal;
        MinimumAmt: Boolean;
        AmountRestriction: Integer;
        Bal: Decimal;
        All: Boolean;
        Salesterritory: Text[15];
        Per50Value: Decimal;
        FinalPer50Value: Decimal;
        decOpenOrderVal: Decimal;
        decReleasedOrderVal: Decimal;



    procedure AmttoCustomerSalesLine(T37: Record 37): Decimal
    var
        GSTper3: Decimal;
        GSTper1: Decimal;
        GSTper2: Decimal;
        ReccSalesLine: Record "Sales Line";
        GSTSetup: Record "GST Setup";
        ComponentName: Text;
        TaxTransactionValue: Record "Tax Transaction Value";
        TDSSetup: Record "TDS Setup";
    begin
        GSTSetup.Get();
        TDSSetup.Get();

        //TotalAmt := T37."Line Amount";
        //if T37.Type <> T37.Type::" " then begin
        TaxTransactionValue.Reset();
        TaxTransactionValue.SetRange("Tax Record ID", T37.RecordId);
        TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if TaxTransactionValue.FindSet() then
            repeat

                case TaxTransactionValue."Value ID" of
                    6:
                        begin
                            ComponentName := 'SGST';
                            GSTper3 := TaxTransactionValue.Percent;
                        end;
                    2:
                        begin
                            ComponentName := 'CGST';
                            GSTper2 := TaxTransactionValue.Percent;
                        end;
                    3:
                        begin
                            ComponentName := 'IGST';
                            GSTper1 := TaxTransactionValue.Percent;
                        end;
                end;
            until TaxTransactionValue.Next() = 0;

        //end;

        exit(GSTper1 + GSTper2 + GSTper3);
    end;
}

