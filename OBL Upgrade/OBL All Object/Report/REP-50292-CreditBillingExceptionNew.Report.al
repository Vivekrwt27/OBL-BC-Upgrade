report 50292 "Credit Billing Exception New"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\CreditBillingExceptionNew.rdl';
    Caption = 'Credit Billing Exception New';
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
            column(Customer__No__; "No.")
            {
            }
            column(Region; Customer."Tableau Zone")
            {
            }
            column(Sales_territory; Salesterritory)
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(CustomerType_Customer; Customer."Customer Type")
            {
            }
            column(TerritoryCode_Customer; Customer.City)
            {
            }
            column(StateCode_Customer; Customer."State Desc.")
            {
            }
            column(ExitenceSince; ExitenceSince)
            {
            }
            column(balance_conf; Customer."Balance Conf Recd Date")
            {
            }
            column(SecurityChqAvailability_Customer; FORMAT(Customer."CTS 1"))
            {
            }
            column(SecurityAmount_Customer; Customer."Security Amount")
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
            column(FY20SaleAmt; FY20SaleAmt / 100000)
            {
            }
            column(MTDSaleAmt; MTDSaleAmt / 100000)
            {
            }
            column(YTDCollection; ABS(YTDCollection) / 100000)
            {
            }
            column(MTDCollection; ABS(MTDCollection) / 100000)
            {
            }
            column(CreditLimitLCY_Customer; Customer."Credit Limit (LCY)" / 100000)
            {
            }
            column(OutstandingAmount_Customer; Bal / 100000)
            {
            }
            column(AdvTermsAmt; AdvTermsAmt / 100000)
            {
            }
            column(MTDInvoiceCount; MTDInvoiceCount)
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
            column(ACPD_cy; Customer."ACPD (Current Year)")
            {
            }
            column(ACPD_LY; Customer."ACPD (Last 12m)")
            {
            }
            column(ReleasedOrderValue; ReleasedOrderValue / 100000)
            {
            }
            column(OpenOrderValue; OpenOrderValue / 100000)
            {
            }
            column(All; All)
            {
            }
            column(Due7DaysAmt; Due7DaysAmt / 100000)
            {
            }
            column(FinalPer50Value; FinalPer50Value / 100000)
            {
            }
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
            dataitem("Sales Header"; "Sales Header")
            {
                DataItemLink = "Sell-to Customer No." = FIELD("No.");
                column(PaymentTerms; PaymentTerms)
                {
                }
                column(M001Value; M001Value / 100000)
                {
                }
                column(D001Value; D001Value / 100000)
                {
                }
                column(H001Value; H001Value / 100000)
                {
                }
                column(T001Value; T001Value / 100000)
                {
                }
                column(OtherAmount; OtherAmount / 100000)
                {
                }

                trigger OnAfterGetRecord()
                var

                begin
                    Clear(sgst);
                    Clear(igst);
                    Clear(cgst);
                    Clear(TotalAmt);
                    Clear(TGstPer);
                    ReccSalesLine.Reset();
                    ReccSalesLine.SetRange("Document Type", "Document Type");
                    ReccSalesLine.SetRange("Document No.", "No.");
                    if ReccSalesLine.FindSet() then
                        repeat
                            TotalAmt += ReccSalesLine."Line Amount";
                            GSTSetup.Get();
                            if GSTSetup."GST Tax Type" = GSTLbl then
                                if ReccSalesLine."GST Jurisdiction Type" = ReccSalesLine."GST Jurisdiction Type"::Interstate then
                                    ComponentName := IGSTLbl
                                else
                                    ComponentName := CGSTLbl
                            else
                                if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                                    ComponentName := CESSLbl;

                            if ReccSalesLine.Type <> ReccSalesLine.Type::" " then begin
                                TaxTransactionValue.Reset();
                                TaxTransactionValue.SetRange("Tax Record ID", ReccSalesLine.RecordId);
                                TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
                                TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                                TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
                                if TaxTransactionValue.FindSet() then
                                    repeat
                                        case TaxTransactionValue."Value ID" of
                                            6:
                                                begin
                                                    sgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                                    GSTper3 := TaxTransactionValue.Percent;
                                                end;
                                            2:
                                                begin
                                                    cgst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                                    GSTper2 := TaxTransactionValue.Percent;
                                                end;
                                            3:
                                                begin
                                                    igst += abs(Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName)));
                                                    GSTper1 := TaxTransactionValue.Percent;
                                                end;
                                        end;
                                    until TaxTransactionValue.Next() = 0;
                                cgstTOTAL += cgst;
                                sgstTOTAL += sgst;
                                igstTotal += igst;
                                TGstPer += GSTper1 + GSTper2 + GSTper3;///16225
                            end;
                            TotalAmt := ReccSalesLine."Line Amount" + cgst + sgst + igst;
                        until ReccSalesLine.Next() = 0;



                    CLEAR(M001Value);
                    CLEAR(D001Value);
                    CLEAR(H001Value);
                    CLEAR(T001Value);
                    CLEAR(OtherAmount);

                    //16225  "Sales Header".CALCFIELDS("Sales Header"."Amount to Customer");
                    IF ("Sales Header".Status = "Sales Header".Status::Open) OR ("Sales Header".Status = "Sales Header".Status::"Credit Approval Pending") AND ("Sales Header".Commitment = 'Payment / Credit Issue') THEN BEGIN
                        IF COPYSTR("Sales Header"."Location Code", 1, 3) = 'SKD' THEN BEGIN
                            //16225   M001Value := "Sales Header"."Amount to Customer";
                            M001Value := TotalAmt;
                        END;
                        IF COPYSTR("Sales Header"."Location Code", 1, 3) = 'DRA' THEN BEGIN
                            //16225   D001Value := "Sales Header"."Amount to Customer";
                            D001Value := TotalAmt;
                        END;
                        IF COPYSTR("Sales Header"."Location Code", 1, 3) = 'HSK' THEN BEGIN
                            //16225   H001Value := "Sales Header"."Amount to Customer";
                            H001Value := TotalAmt;
                        END;
                        IF COPYSTR("Sales Header"."Location Code", 1, 3) = 'DP-' THEN BEGIN
                            //16225    T001Value := "Sales Header"."Amount to Customer";
                            T001Value := TotalAmt;
                        END;
                    END;

                    IF ("Sales Header".Status = "Sales Header".Status::Open) OR ("Sales Header".Status = "Sales Header".Status::"Credit Approval Pending") AND ("Sales Header".Commitment <> 'Payment / Credit Issue') THEN BEGIN
                        //16225 OtherAmount := "Sales Header"."Amount to Customer";
                        OtherAmount := TotalAmt;
                    END;


                    CLEAR(PaymentTerms);
                    IF ("Sales Header".Status = "Sales Header".Status::Open) OR ("Sales Header".Status = "Sales Header".Status::"Credit Approval Pending") THEN BEGIN
                        IF ("Sales Header"."Payment Terms Code" = '0') OR ("Sales Header"."Payment Terms Code" = '00') THEN BEGIN
                            PaymentTerms := 'YES';
                        END ELSE BEGIN
                            PaymentTerms := 'NO';
                        END;
                    END;
                end;
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Sell-to Customer No." = FIELD("No.");
                UseTemporary = false;
                column(NewAddition; NewAddition)
                {
                }
                column(OldCustNo; OldCustNo)
                {
                }
                column(LocationCode; "Sales Line"."Location Code")
                {
                }
                column(decOpenOrderVal; decOpenOrderVal / 100000)
                {
                }
                column(decReleasedOrderVal; decReleasedOrderVal / 100000)
                {
                }
                column(DocumentType_SalesLine; "Sales Line"."Document Type")
                {
                }
                column(Status_SalesLine; "Sales Line".Status)
                {
                }
                column(AlredyProcessValue1; AlredyProcessValue1 / 100000)
                {
                }
                column(AlredyProcessValue2; AlredyProcessValue2 / 100000)
                {
                }
                column(OrderAgeing; OrderAgeing)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(NewAddition);
                    CLEAR(OldCustNo);
                    CLEAR(decOpenOrderVal);
                    CLEAR(decReleasedOrderVal);
                    CLEAR(AlredyProcessValue1);
                    CLEAR(AlredyProcessValue2);
                    CLEAR(OrderAgeing);

                    IF "Sales Line".Status = "Sales Line".Status::Released THEN BEGIN
                        decReleasedOrderVal := "Sales Line"."Outstanding Amount (LCY)" + (("Sales Line"."Outstanding Amount (LCY)" * TGstPer) / 100);//16225 "Sales Line"."GST %"
                        IF COPYSTR("Sales Line"."Location Code", 1, 3) <> 'DP-' THEN BEGIN
                            AlredyProcessValue1 := "Sales Line"."Outstanding Amount (LCY)" + (("Sales Line"."Outstanding Amount (LCY)" * TGstPer) / 100);//16225 "Sales Line"."GST %"
                        END;
                    END;

                    IF ("Sales Line"."Outstanding Amount (LCY)" > 0) AND (COPYSTR("Sales Line"."Location Code", 1, 3) = 'DP-') THEN BEGIN
                        SalesHeader.RESET;
                        SalesHeader.SETCURRENTKEY("Sell-to Customer No.");
                        SalesHeader.SETRANGE("Sell-to Customer No.", "Sales Line"."Sell-to Customer No.");
                        SalesHeader.SETFILTER("Payment Date 3", '<>%1', 0D);
                        IF SalesHeader.FINDSET THEN BEGIN
                            SalesLine.RESET;
                            SalesLine.SETCURRENTKEY("Sell-to Customer No.");
                            SalesLine.SETRANGE("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
                            IF SalesLine.FINDSET THEN BEGIN
                                AlredyProcessValue2 := SalesLine."Outstanding Amount (LCY)" + ((SalesLine."Outstanding Amount (LCY)" * TGstPer) / 100);//16225 "Sales Line"."GST %"
                            END;
                        END;
                    END;

                    SalesHeader.RESET;
                    SalesHeader.SETFILTER(Status, '%1|%2', SalesHeader.Status::Open, SalesHeader.Status::"Credit Approval Pending");
                    SalesHeader.SETFILTER("Sell-to Customer No.", '%1', "Sales Line"."Sell-to Customer No.");
                    SalesHeader.SETFILTER("Order Date", '<>%1', 0D);
                    //SalesHeader.SETFILTER(Commitment,'%1','Payment / Credit Issue');
                    IF SalesHeader.FIND('-') THEN BEGIN
                        IF TODAY - SalesHeader."Order Date" <= 1 THEN BEGIN
                            OrderAgeing := '0 - 1 Day'
                        END ELSE
                            IF (TODAY - SalesHeader."Order Date" > 1) AND (TODAY - SalesHeader."Order Date" <= 2) THEN BEGIN
                                OrderAgeing := '1 - 2 Days'
                            END ELSE
                                IF (TODAY - SalesHeader."Order Date" > 2) AND (TODAY - SalesHeader."Order Date" <= 3) THEN BEGIN
                                    OrderAgeing := '2 - 3 Days'
                                END ELSE
                                    IF (TODAY - SalesHeader."Order Date" > 3) AND (TODAY - SalesHeader."Order Date" <= 10) THEN BEGIN
                                        OrderAgeing := '4 - 10 Days'
                                    END ELSE
                                        IF TODAY - SalesHeader."Order Date" > 10 THEN BEGIN
                                            OrderAgeing := ' > 10 Days';
                                        END;
                    END;
                    /*
                    CLEAR(PaymentTerms);
                    SalesHeader.RESET;
                    SalesHeader.SETCURRENTKEY("Sell-to Customer No.");
                    SalesHeader.SETFILTER(Status,'%1',SalesHeader.Status::Open);
                    SalesHeader.SETFILTER("Sell-to Customer No.",'%1',"Sales Line"."Sell-to Customer No.");
                    SalesHeader.SETFILTER("Payment Terms Code",'%1|%2','0','00');
                    IF SalesHeader.FINDSET THEN BEGIN
                      PaymentTerms := 'Yes';
                    END ELSE BEGIN
                      PaymentTerms := 'No';
                    END;
                    */

                end;

                trigger OnPreDataItem()
                begin
                    "Sales Line".SETFILTER("Sales Line"."Item Category Code", '%1|%2|%3|%4', 'M001', 'D001', 'H001', 'T001');

                    SalesHeader.RESET;
                    SalesHeader.SETCURRENTKEY("Sell-to Customer No.");
                    SalesHeader.SETRANGE("Sell-to Customer No.", "Sales Line"."Sell-to Customer No.");
                    SalesHeader.SETFILTER("Posting Date", '%1', TODAY - 1);
                    SalesHeader.SETFILTER("Document Type", '%1', SalesHeader."Document Type"::Order);
                    SalesHeader.SETFILTER(Status, '%1|%2', SalesHeader.Status::Open, SalesHeader.Status::"Credit Approval Pending");
                    //SalesHeader.SETFILTER("Payment Terms Code",'%1|%2','0','00');
                    //16767 SalesHeader.SETFILTER(Commitment, '%1', 'Payment / Credit Issue');
                    SalesHeader.SETFILTER("Credit Approved", '%1', FALSE);
                    IF SalesHeader.FINDFIRST THEN BEGIN
                        REPEAT
                            OldCustNo := SalesHeader."Sell-to Customer No.";
                        UNTIL SalesHeader.NEXT = 0;
                    END;

                    IF OldCustNo = "Sales Line"."Sell-to Customer No." THEN BEGIN
                        NewAddition := ''
                    END ELSE BEGIN
                        NewAddition := 'Yes';
                    END;
                    //MESSAGE('%1 = %2',OldCustNo,TODAY-1);
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
                column(AmtD7; (AmtD[7]) / 100000)
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
                column(AmtD2; (AmtD[2]) / 100000)
                {
                }
                column(AmtD1; (AmtD[1]) / 100000)
                {
                }
                column(AmtD12; (AmtD[12]) / 100000)
                {
                }
                column(YesterdayCollection; YesterdayCollection / 100000)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    FOR i := 1 TO 12 DO BEGIN   //Clear Varibales
                        CLEAR(Amt[i]);
                        CLEAR(AmtD[i]);
                        CLEAR(YesterdayCollection);  //Rk180621
                    END;

                    CALCFIELDS("Remaining Amt. (LCY)", "Cust. Ledger Entry"."Original Amt. (LCY)");
                    IF ROUND("Remaining Amt. (LCY)", 0.01) = 0 THEN
                        CurrReport.SKIP;
                    YesterdayCollection := 0;
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

                    IF ("Posting Date" = TODAY + 1) AND ("Document Type" = "Document Type"::Payment) THEN
                        YesterdayCollection := "Cust. Ledger Entry"."Credit Amount (LCY)";

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
            var
                RecSalesHeader: Record "Sales Header";
            begin
                CLEAR(Bal);
                IF Customer."Tableau Zone" <> 'Enterprise' THEN
                    Salesterritory := Customer."Area Code"
                ELSE
                    Salesterritory := 'ENTERPRISE';

                RecSalesHeader.RESET;
                RecSalesHeader.SETRANGE("Document Type", RecSalesHeader."Document Type"::Order);
                RecSalesHeader.SETRANGE("Sell-to Customer No.", "No.");
                // 16767 RecSalesHeader.SETFILTER(Status, '%1|%2', RecSalesHeader.Status::Open, RecSalesHeader.Status::"Credit Approval Pending");
                //16767 RecSalesHeader.SETFILTER(Commitment, '%1', 'Payment / Credit Issue');
                RecSalesHeader.SETFILTER("Credit Approved", '%1', FALSE);
                IF NOT RecSalesHeader.FINDFIRST THEN
                    CurrReport.SKIP;

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
                CLEAR(FY20SaleAmt);
                CLEAR(FY19SaleAmt);
                CLEAR(FY18SaleAmt);
                CLEAR(SalesJournalData);
                SalesJournalData.SETRANGE(SalesJournalData.CustomerNo, Customer."No.");
                SalesJournalData.SETFILTER(SalesJournalData.PostingDate, '%1..%2', FY18StartDate, EndDate);
                SalesJournalData.OPEN;
                WHILE SalesJournalData.READ DO BEGIN
                    CASE SalesJournalData.PostingDate OF
                    /*  MTDFromDate .. EndDate:
                          MTDSaleAmt += SalesJournalData.AmountToCustomer;
                      FY20StartDate .. EndDate:
                          FY20SaleAmt += SalesJournalData.AmountToCustomer;
                      FY19StartDate .. FY20StartDate - 1:
                          FY19SaleAmt += SalesJournalData.AmountToCustomer;
                      FY18StartDate .. FY19StartDate - 1:
                          FY18SaleAmt += SalesJournalData.AmountToCustomer;*///
                    END;
                END;
                /*
                CLEAR(FY20SaleAmt);
                CLEAR(SalesJournalData);
                SalesJournalData.SETRANGE(CustomerNo, Customer."No.");
                SalesJournalData.SETFILTER(PostingDateFilter,'%1..%2',FY20StartDate,EndDate);
                SalesJournalData.OPEN;
                WHILE SalesJournalData.READ DO BEGIN
                  FY20SaleAmt += SalesJournalData.AmountToCustomer;
                END;
                
                CLEAR(FY19SaleAmt);
                CLEAR(SalesJournalData);
                SalesJournalData.SETRANGE(CustomerNo, Customer."No.");
                SalesJournalData.SETFILTER(PostingDateFilter,'%1..%2',FY19StartDate,FY20StartDate-1);
                SalesJournalData.OPEN;
                WHILE SalesJournalData.READ DO BEGIN
                  FY19SaleAmt += SalesJournalData.AmountToCustomer;
                END;
                
                CLEAR(FY18SaleAmt);
                CLEAR(SalesJournalData);
                SalesJournalData.SETRANGE(CustomerNo, Customer."No.");
                SalesJournalData.SETFILTER(PostingDateFilter,'%1..%2',FY18StartDate,FY19StartDate-1);
                SalesJournalData.OPEN;
                WHILE SalesJournalData.READ DO BEGIN
                  FY18SaleAmt += SalesJournalData.AmountToCustomer;
                END;
                */

                CLEAR(OpenOrderValue);
                CLEAR(ReleasedOrderValue);
                //>>
                CLEAR(AdvTermsAmt);
                SalesHeader.RESET;
                SalesHeader.SETCURRENTKEY("Sell-to Customer No.");
                SalesHeader.SETRANGE("Sell-to Customer No.", Customer."No.");
                SalesHeader.SETFILTER("Posting Date", '%1..%2', 0D, TODAY);
                SalesHeader.SETFILTER("Document Type", '%1', SalesHeader."Document Type"::Order);
                SalesHeader.SETFILTER(Status, '%1|%2', RecSalesHeader.Status::Open, RecSalesHeader.Status::"Credit Approval Pending");
                SalesHeader.SETFILTER("Payment Terms Code", '%1|%2', '0', '00');
                IF SalesHeader.FINDFIRST THEN BEGIN
                    AdvTermsAmt += SalesHeader."Outstanding Amount";
                    //<<
                    SalesLine.RESET;
                    SalesLine.SETCURRENTKEY("Sell-to Customer No.");
                    //SalesLine.SETRANGE("Sell-to Customer No.", Customer."No.");  //<<
                    SalesLine.SETRANGE("Sell-to Customer No.", SalesHeader."Sell-to Customer No."); //>>
                                                                                                    //SalesLine.SETFILTER("Posting Date", '%1..%2', 0D, TODAY);  //<<
                                                                                                    //SalesLine.SETFILTER("Document Type",'%1',SalesLine."Document Type"::Order); //<<
                    IF SalesLine.FINDSET THEN
                        REPEAT
                            IF SalesLine.Status = SalesLine.Status::Open THEN BEGIN
                                OpenOrderValue += SalesLine."Outstanding Amount (LCY)" + ((SalesLine."Outstanding Amount (LCY)" * TGstPer) / 100);//16225 "Sales Line"."GST %"
                            END;
                            IF SalesLine.Status = SalesLine.Status::Released THEN BEGIN
                                ReleasedOrderValue += SalesLine."Outstanding Amount (LCY)" + ((SalesLine."Outstanding Amount (LCY)" * TGstPer) / 100);//16225 "Sales Line"."GST %"
                            END;
                        UNTIL SalesLine.NEXT = 0;
                END;

                //MIPLRK170621<<

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
        PeriodStartDate[7] := 99991231D;//31129999D
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
        SalesHeader: Record "Sales Header";
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
        AdvTermsAmt: Decimal;
        H001Value: Decimal;
        D001Value: Decimal;
        T001Value: Decimal;
        M001Value: Decimal;
        OtherAmount: Decimal;
        AlredyProcessValue1: Decimal;
        AlredyProcessValue2: Decimal;
        OrderAgeing: Text;
        YesterdayCollection: Decimal;
        NewAddition: Text;
        OldCustNo: Code[20];
        PaymentTerms: Text[3];
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
        sgstTOTAL: Decimal;
        GSTLbl: Label 'GST';
        IGSTLbl: Label 'IGST';
        CGSTLbl: Label 'CGST';
        GSTCESSLbl: Label 'GST CESS';
        CESSLbl: Label 'CESS';
        igst: Decimal;
        igstTotal: Decimal;
        sgst: Decimal;
        GSTper3: Decimal;
        cgst: Decimal;
        GSTper1: Decimal;
        GSTper2: Decimal;
        cgstTOTAL: Decimal;
        ReccSalesLine: Record "Sales Line";
        ComponentName: Code[20];
        TotalAmt: Decimal;
        TGstPer: Decimal;

    procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal// 16225 text
    var
        TaxComponent: Record "Tax Component";
        GSTSetup1: Record "GST Setup";
        GSTRoundingPrecision: Decimal;
    begin
        if not GSTSetup1.Get() then
            exit;
        GSTSetup1.TestField("GST Tax Type");

        TaxComponent.SetRange("Tax Type", GSTSetup1."GST Tax Type");
        TaxComponent.SetRange(Name, ComponentName);
        TaxComponent.FindFirst();
        if TaxComponent."Rounding Precision" <> 0 then
            GSTRoundingPrecision := TaxComponent."Rounding Precision"
        else
            GSTRoundingPrecision := 1;
        exit(GSTRoundingPrecision);
    end;
}

