report 50053 "Avg Coll Pd_Base"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\AvgCollPdBase.rdl';
    Caption = 'Customer - Summary Aging Simp.';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.";
            column(CustBalanceDueLCY_5_; CustBalanceDueLCY[5])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_4_; CustBalanceDueLCY[4])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_3_; CustBalanceDueLCY[3])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_2_; CustBalanceDueLCY[2])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_1_; CustBalanceDueLCY[1])
            {
                AutoFormatType = 1;
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
            column(TerritoryCode_Customer; Customer.City)
            {
            }
            column(FY19Sales; ROUND(FY19Sales))
            {
            }
            column(GSTAmt; GSTAmt + Insurance)
            {
            }
            column(FY19BilledValue; FY19BilledValue)
            {
            }
            column(CreditLimitMarch; (FY19BilledValue / 12 * 1.5) * 1.2)
            {
            }
            column(CreditLimitROY; (FY19BilledValue / 12 * 1.5) * 1)
            {
            }
            column(CreditLimitLCY_Customer; Customer."Credit Limit (LCY)")
            {
            }
            column(FY20SalesTarget; Customer."Minmum Amt pur value")
            {
            }
            column(RequireCreditLimitMarch; ((Customer."Minmum Amt pur value" * 1.188) / 12) * 1.5 * 1.2)
            {
            }
            column(RequireCreditLimitROY; ((Customer."Minmum Amt pur value" * 1.188) / 12) * 1.5 * 1)
            {
            }
            column(SecurityAmount_Customer; Customer."Security Amount")
            {
            }
            column(BankChequeAvail; FORMAT(BankChequeAvail))
            {
            }
            column(FY20FY19; FY20FY19)
            {
            }
            column(CFrmLblty; CFrmLblty)
            {
            }
            column(TotalInvoicedValue; TotalInvoicedValue)
            {
            }
            column(InvValue; InvValue)
            {
            }
            column(CreditRating_Customer; COPYSTR(Customer."Credit Rating", 2, 1))
            {
            }
            column(TurnOverRating; COPYSTR(Customer."Credit Rating", 1, 1))
            {
            }
            column(NoDays; NoDays)
            {
            }
            column(Diffr; Diffr)
            {
            }
            column(FY; FY)
            {
            }
            column(Region; Customer.Zone)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //////
                FOR i := 1 TO 6 DO BEGIN
                    DtldCustLedgEntry.SETCURRENTKEY("Customer No.", "Initial Entry Due Date", "Posting Date");
                    DtldCustLedgEntry.SETRANGE("Customer No.", "No.");
                    DtldCustLedgEntry.SETRANGE("Initial Entry Due Date", PeriodStartDate[i], PeriodStartDate[i + 1] - 1);
                    DtldCustLedgEntry.SETRANGE("Posting Date", 0D, EndDate);
                    DtldCustLedgEntry.CALCSUMS("Amount (LCY)");
                    CustBalanceDueLCY[i] := DtldCustLedgEntry."Amount (LCY)";
                END;
                ////

                InitializeVariable;
                //////
                /*
                SalesInvoiceLine.RESET;
                SalesInvoiceLine.SETCURRENTKEY("Sell-to Customer No.",Type,"Document No.");
                SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Sell-to Customer No.", Customer."No.");
                SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::Item);
                SalesInvoiceLine.SETCURRENTKEY("Posting Date","Document No.");
                SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Posting Date", StartDate, EndDate);
                SalesInvoiceLine.SETFILTER("Item Category Code", '%1|%2|%3|%4','M001','T001','D001','H001');
                SalesInvoiceLine.SETFILTER(Quantity, '<>%1', 0);
                IF SalesInvoiceLine.FINDSET THEN REPEAT
                  FY19Sales += SalesInvoiceLine."Line Amount";
                  GSTAmt += SalesInvoiceLine."Total GST Amount";
                  FY19BilledValue += SalesInvoiceLine."Amount To Customer";
                
                  IF TempInvoiceNo <> SalesInvoiceLine."Document No." THEN BEGIN
                    TempInvoiceNo := SalesInvoiceLine."Document No.";
                    PostedStructureOrderDetails.RESET;
                    PostedStructureOrderDetails.SETCURRENTKEY(Type,"Calculation Order","Document Type","No.","Structure Code","Tax/Charge Type","Tax/Charge Group","Tax/Charge Code","Document Line No.");
                    PostedStructureOrderDetails.SETRANGE(Type, PostedStructureOrderDetails.Type::Sale);
                    PostedStructureOrderDetails.SETRANGE("No.", SalesInvoiceLine."Document No.");
                    PostedStructureOrderDetails.SETRANGE("Tax/Charge Group", 'INSURANCE');
                    IF PostedStructureOrderDetails.FINDFIRST THEN REPEAT
                      Insurance += PostedStructureOrderDetails."Calculation Value";
                    UNTIL PostedStructureOrderDetails.NEXT=0;
                  END;
                UNTIL SalesInvoiceLine.NEXT=0;
                */
                IGSTAmt := 0; // 16630
                IGSTper := 0;
                SGSTAmt := 0;
                SGSTper := 0;
                CGSTAmt := 0;
                CGSTper := 0;
                GSTBaseAmt := 0;
                TotalAmount := 0;
                LineAmount := 0;
                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETCURRENTKEY("Sell-to Customer No.");
                SalesInvoiceHeader.SETRANGE("Sell-to Customer No.", Customer."No.");
                SalesInvoiceHeader.SETRANGE("Posting Date", StartDate, EndDate);
                IF SalesInvoiceHeader.FINDSET THEN
                    REPEAT

                        RecDGLE.RESET();
                        RecDGLE.SetRange("Source Type", RecDGLE."Source Type"::Customer);
                        RecDGLE.SetRange("Source No.", Customer."No.");
                        RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                        RecDGLE.SetRange("Posting Date", StartDate, EndDate);
                        RecDGLE.SETRANGE("GST Component Code", 'IGST');

                        IF RecDGLE.FINDFIRST THEN BEGIN
                            REPEAT
                                IGSTAmt += abs(RecDGLE."GST Amount");
                            UNTIL RecDGLE.NEXT = 0;
                        END;


                        RecDGLE.RESET();
                        RecDGLE.SetRange("Source Type", RecDGLE."Source Type"::Customer);
                        RecDGLE.SetRange("Source No.", Customer."No.");
                        RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                        RecDGLE.SetRange("Posting Date", StartDate, EndDate);
                        RecDGLE.SETRANGE("GST Component Code", 'SGST');
                        IF RecDGLE.FINDFIRST THEN BEGIN
                            REPEAT
                                SGSTAmt += abs(RecDGLE."GST Amount");
                            UNTIL RecDGLE.NEXT = 0;
                        END;
                        RecDGLE.RESET();
                        RecDGLE.SetRange("Source Type", RecDGLE."Source Type"::Customer);
                        RecDGLE.SetRange("Source No.", Customer."No.");
                        RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                        RecDGLE.SetRange("Posting Date", StartDate, EndDate);
                        RecDGLE.SETRANGE("GST Component Code", 'CGST');
                        IF RecDGLE.FINDFIRST THEN BEGIN
                            REPEAT
                                CGSTAmt += abs(RecDGLE."GST Amount");
                            UNTIL RecDGLE.NEXT = 0;
                        END;

                        RecSalesInvoiceLine.RESET;
                        RecSalesInvoiceLine.SETCURRENTKEY("Document No.");
                        RecSalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                        IF RecSalesInvoiceLine.FINDSET THEN
                            REPEAT
                                LineAmount += RecSalesInvoiceLine."Line Amount";
                            UNTIL RecSalesInvoiceLine.NEXT = 0;

                        SalesInvoiceHeader.CALCFIELDS(Amount);
                        // SalesInvoiceHeader.CALCFIELDS("Insurance Amt");
                        FY19Sales += SalesInvoiceHeader.Amount;
                        FY19BilledValue += LineAmount + IGSTAmt + CGSTAmt + SGSTAmt;
                        Insurance += SalesInvoiceHeader."Insurance Amt";

                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETCURRENTKEY("Document No.");
                        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                        IF SalesInvoiceLine.FINDSET THEN
                            REPEAT
                                RecDGLE.RESET();
                                RecDGLE.SETRANGE("Source Type", RecDGLE."Source Type"::Customer);
                                RecDGLE.SetRange("Source No.", Customer."No.");
                                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                RecDGLE.SETRANGE("GST Component Code", 'IGST');
                                IF RecDGLE.FINDFIRST THEN BEGIN
                                    REPEAT
                                        IGSTAmt += abs(RecDGLE."GST Amount");
                                    UNTIL RecDGLE.NEXT = 0;
                                END;


                                RecDGLE.RESET();
                                RecDGLE.SETRANGE("Source Type", RecDGLE."Source Type"::Customer);
                                RecDGLE.SetRange("Source No.", Customer."No.");
                                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                RecDGLE.SETRANGE("GST Component Code", 'SGST');
                                IF RecDGLE.FINDFIRST THEN BEGIN
                                    REPEAT
                                        SGSTAmt += abs(RecDGLE."GST Amount");
                                    UNTIL RecDGLE.NEXT = 0;
                                END;
                                RecDGLE.RESET();
                                RecDGLE.SETRANGE("Source Type", RecDGLE."Source Type"::Customer);
                                RecDGLE.SetRange("Source No.", Customer."No.");
                                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                RecDGLE.SETRANGE("GST Component Code", 'CGST');
                                IF RecDGLE.FINDFIRST THEN BEGIN
                                    REPEAT
                                        CGSTAmt += abs(RecDGLE."GST Amount");
                                    UNTIL RecDGLE.NEXT = 0;
                                END;


                                RecDGLE.RESET();
                                RecDGLE.SETRANGE("Source Type", RecDGLE."Source Type"::Customer);
                                RecDGLE.SetRange("Source No.", Customer."No.");
                                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                RecDGLE.SETRANGE("GST Component Code", 'CGST');
                                IF RecDGLE.FINDFIRST THEN BEGIN
                                    repeat
                                        GSTBaseAmt += abs(RecDGLE."GST Base Amount");
                                    until RecDGLE.next = 0;
                                END;
                                RecDGLE.RESET();
                                RecDGLE.SETRANGE("Source Type", RecDGLE."Source Type"::Customer);
                                RecDGLE.SetRange("Source No.", Customer."No.");
                                RecDGLE.SETRANGE("Entry Type", RecDGLE."Entry Type"::"Initial Entry");
                                RecDGLE.SETRANGE("GST Component Code", 'IGST');
                                IF RecDGLE.FINDFIRST THEN BEGIN
                                    repeat
                                        GSTBaseAmt += abs(RecDGLE."GST Base Amount");
                                    until RecDGLE.Next() = 0;

                                    TotalAmount += IGSTAmt + CGSTAmt + SGSTAmt;
                                    GSTAmt := TotalAmount;

                                END;

                            UNTIL SalesInvoiceLine.NEXT = 0; // 16630

                        ///No of days calculation
                        SalesInvoiceHeader.CALCFIELDS("Last Payment Receipt Date");
                        IF SalesInvoiceHeader."Last Payment Receipt Date" <> 0D THEN
                            NoOfDays := SalesInvoiceHeader."Last Payment Receipt Date" - SalesInvoiceHeader."Posting Date";
                        IF NoOfDays > 0 THEN BEGIN
                            InvValue += NoOfDays * SalesInvoiceHeader.Amount;
                            TotalInvoicedValue += SalesInvoiceHeader.Amount;
                        END;
                    UNTIL SalesInvoiceHeader.NEXT = 0;
                IF (InvValue > 0) AND (TotalInvoicedValue > 0) THEN
                    NoDays := (InvValue / TotalInvoicedValue);

                //////
                /*
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETCURRENTKEY("Customer No.");
                CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                CustLedgerEntry.SETRANGE("Posting Date", StartDate, EndDate);
                
                CustLedgerEntry.SETFILTER("Closed by Entry No.", '<>%1', 0);
                IF CustLedgerEntry.FINDSET THEN REPEAT
                  CustLedgerEntry.CALCFIELDS(Amount);
                  NoOfDays := CustLedgerEntry."Closed at Date" - CustLedgerEntry."Posting Date";
                  IF NoOfDays >0 THEN BEGIN
                    InvValue += (NoOfDays*CustLedgerEntry.Amount);
                    TotalInvoicedValue += CustLedgerEntry.Amount;
                  END;
                UNTIL CustLedgerEntry.NEXT=0;
                //MESSAGE('%1=%2..%3=%4', 'INVVALUE', InvValue, 'TOTAL INVOICED VALUE', TotalInvoicedValue);
                IF (InvValue >0) AND (TotalInvoicedValue >0) THEN
                  NoDays := (InvValue / TotalInvoicedValue);
                */
                IF (Customer."CTS 1" = TRUE) OR (Customer."CTS 2" = TRUE) THEN
                    BankChequeAvail := TRUE
                ELSE
                    BankChequeAvail := FALSE;

                ///////////
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETCURRENTKEY("Customer No.");
                CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                CustLedgerEntry.SETRANGE("Not Enclude CFORM", TRUE);
                IF CustLedgerEntry.FINDFIRST THEN BEGIN
                    CustLedgerEntry.CALCFIELDS(Amount);
                    CFrmLblty := CustLedgerEntry.Amount;
                END;

                IF Customer."Minmum Amt pur value" > 0 THEN BEGIN
                    IF FY19Sales > 0 THEN
                        FY20FY19 := (Customer."Minmum Amt pur value" / FY19Sales) - 1;
                    IF Customer."Credit Amount (LCY)" > 0 THEN
                        Diffr := (Customer."Minmum Amt pur value" / (Customer."Credit Limit (LCY)" / 100000));
                END;

            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS(CustBalanceDueLCY);
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
                group(Options)
                {
                    Caption = 'Options';
                    field("Start Date"; StartDate)
                    {
                        Caption = 'Starting Date';
                        ApplicationArea = All;
                    }
                    field("End Date"; EndDate)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF StartDate = 0D THEN
                StartDate := WORKDATE;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        PeriodStartDate[6] := EndDate;
        PeriodStartDate[7] := 99991231D;
        FOR i := 5 DOWNTO 2 DO
            PeriodStartDate[i] := CALCDATE('<-30D>', PeriodStartDate[i + 1]);

        FY := DATE2DMY(EndDate, 3);
    end;

    var
        Text001: Label 'As of %1';
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        StartDate: Date;
        CustFilter: Text;
        PeriodStartDate: array[7] of Date;
        CustBalanceDueLCY: array[6] of Decimal;
        PrintCust: Boolean;
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
        DateLength: DateFormula;
        EndDate: Date;
        FY19Sales: Decimal;
        GSTAmt: Decimal;
        FY19BilledValue: Decimal;
        DetailedCustLedgerEntry: Record "Detailed Cust. Ledg. Entry";
        DebitNoteAmt: Decimal;
        // 16630 PostedStructureOrderDetails: Record 13760;
        Insurance: Decimal;
        TempInvoiceNo: Code[20];
        BankChequeAvail: Boolean;
        CustomerCreditRating: Record "Customer Credit Rating";
        TurnOverRating: Option;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CFrmLblty: Decimal;
        TotalInvoicedValue: Decimal;
        NoOfDays: Integer;
        InvValue: Decimal;
        FY20FY19: Decimal;
        NoDays: Decimal;
        Diffr: Decimal;
        FY: Integer;
        ActiveCust: Boolean;
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        IGSTAmt: Decimal;
        IGSTper: Decimal;
        SGSTAmt: Decimal;
        SGSTper: Decimal;
        CGSTAmt: Decimal;
        CGSTper: Decimal;
        GSTBaseAmt: Decimal;
        TotalAmount: Decimal;
        RecDGLE: Record "Detailed GST Ledger Entry";
        RecSalesInvoiceLine: Record "Sales Invoice Line";
        LineAmount: Decimal;



    local procedure InitializeVariable()
    begin

        CLEAR(FY19Sales);
        CLEAR(GSTAmt);
        CLEAR(FY19BilledValue);
        CLEAR(DebitNoteAmt);
        CLEAR(Insurance);
        CLEAR(BankChequeAvail);
        CLEAR(TurnOverRating);
        CLEAR(NoOfDays);
        CLEAR(InvValue);
        CLEAR(TotalInvoicedValue);
        CLEAR(NoDays);
        CLEAR(Diffr);
        CLEAR(CFrmLblty);
    end;
}

