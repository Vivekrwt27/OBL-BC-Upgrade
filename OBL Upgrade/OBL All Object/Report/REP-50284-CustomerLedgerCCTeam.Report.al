report 50284 "Customer Ledger CCTeam"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\CustomerLedgerCCTeam.rdl';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            DataItemTableView = SORTING("Primary Key")
                                ORDER(Ascending);
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemTableView = SORTING("Customer No.", Year, Month, "Posting Date")
                                    ORDER(Ascending)
                                    WHERE("Entry Skipped" = FILTER(false));
                RequestFilterFields = "Customer No.", "Posting Date";
                column(ReturnGroup; ReturnGroup)
                {
                }
                column(YearCust; "Cust. Ledger Entry".Year)
                {
                }
                column(CustLedgerMonth; "Cust. Ledger Entry".Month)
                {
                }
                column(CompanyName1; CompanyName1)
                {
                }
                column(DocNo; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(ChequeNo; "Cust. Ledger Entry"."Cheque No.")
                {
                }
                column(TextAddress1; TextAddress1)
                {
                }
                column(DateToday; TODAY)
                {
                }
                column(TextAddress2; TextAddress2)
                {
                }
                column(TextCity; TextCity)
                {
                }
                column(TextPhone; TextPhone)
                {
                }
                column(TextCIN; TextCIN)
                {
                }
                column(PostingDate_CustLedgerEntry; FORMAT(GETFILTER("Cust. Ledger Entry"."Posting Date")))
                {
                }
                column(CustomerNo; "Cust. Ledger Entry"."Customer No.")
                {
                }
                column(PostingDate; FORMAT("Cust. Ledger Entry"."Posting Date"))
                {
                }
                column(Cust; Cust)
                {
                }
                column(CustName; Customer.Name)
                {
                }
                column(CustomerCity; Customer.City)
                {
                }
                column(OpDr; OpDr)
                {
                }
                column(OpCr; OpCr)
                {
                }
                column(Description2_CustLedgerEntry; "Cust. Ledger Entry".Description2)
                {
                }
                column(Description_CustLedgerEntry; "Cust. Ledger Entry".Description)
                {
                }
                column(DocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(Cheque_No; Cheque_No)
                {
                }
                column(CreditAmount_CustLedgerEntry; "Cust. Ledger Entry"."Credit Amount")
                {
                }
                column(DebitAmount_CustLedgerEntry; "Cust. Ledger Entry"."Debit Amount")
                {
                }
                column(ClDr; ClDr)
                {
                }
                column(ClCr; ClCr)
                {
                }
                column(BalanceCr; BalanceCr)
                {
                }
                column(BalanceDr; BalanceDr)
                {
                }
                column(Today; FORMAT(TODAY))
                {
                }
                column(TotalDr; TotalDr)
                {
                }
                column(TotalCr; TotalCr)
                {
                }
                column(NarrationText; NarrationText)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Customer.GET("Customer No.");
                    Customer.TESTFIELD(Customer."Blocked For Customer Ledger", FALSE);

                    Customer.RESET;
                    IF Customer.GET("Cust. Ledger Entry"."Customer No.") THEN BEGIN
                        Cust := Customer.Name;
                    END;

                    IF ReturnGroup = 1 THEN BEGIN
                        IF CustGlobal <> "Cust. Ledger Entry"."Customer No." THEN
                            CLEAR(DateGlobal);
                        IF DateGlobal <> "Cust. Ledger Entry"."Posting Date" THEN BEGIN
                            CLEAR(SnoCHeck);
                            IF Customer.GET("Cust. Ledger Entry"."Customer No.") THEN BEGIN
                                CLEAR(TotalDr);
                                CLEAR(TotalCr);
                                CLEAR(Opening);
                                CLEAR(Cust);
                                Cust := Customer.Name;
                                Customer.SETFILTER(Customer."Date Filter", '..%1', ("Cust. Ledger Entry"."Posting Date" - 1));
                                Customer.CALCFIELDS(Customer."Net Change");
                                Opening := Customer."Net Change";
                                OpCr := 0;
                                OpDr := 0;
                                IF Opening < 0 THEN
                                    OpCr := ABS(Opening)
                                ELSE
                                    OpDr := ABS(Opening);

                                TotalDr := "Cust. Ledger Entry"."Debit Amount" + OpDr;
                                TotalCr := "Cust. Ledger Entry"."Credit Amount" + OpCr;
                            END;
                        END;

                        DateGlobal := "Cust. Ledger Entry"."Posting Date";


                        CustGlobal := "Cust. Ledger Entry"."Customer No.";
                    END;

                    IF ReturnGroup = 2 THEN BEGIN
                        IF CustGlobal <> "Cust. Ledger Entry"."Customer No." THEN
                            CLEAR(MonthGlobal);
                        //END;
                        IF MonthGlobal <> "Cust. Ledger Entry".Month THEN BEGIN
                            CLEAR(SnoCHeck);
                            IF Customer.GET("Cust. Ledger Entry"."Customer No.") THEN BEGIN
                                CLEAR(TotalDr);
                                CLEAR(TotalCr);
                                CLEAR(Opening);
                                CLEAR(Cust);
                                Cust := Customer.Name;
                                Customer.SETFILTER(Customer."Date Filter", '..%1', ("Cust. Ledger Entry"."Posting Date" - 1));
                                Customer.CALCFIELDS(Customer."Net Change");
                                Opening := Customer."Net Change";
                                OpCr := 0;
                                OpDr := 0;
                                IF Opening < 0 THEN
                                    OpCr := ABS(Opening)
                                ELSE
                                    OpDr := ABS(Opening);

                                TotalDr := "Cust. Ledger Entry"."Debit Amount" + OpDr;
                                TotalCr := "Cust. Ledger Entry"."Credit Amount" + OpCr;
                            END;
                        END;

                        MonthGlobal := "Cust. Ledger Entry".Month;


                        CustGlobal := "Cust. Ledger Entry"."Customer No.";

                    END;

                    IF ReturnGroup = 3 THEN BEGIN
                        IF CustGlobal <> "Cust. Ledger Entry"."Customer No." THEN
                            CLEAR(YearGlobal);
                        //END;
                        IF YearGlobal <> "Cust. Ledger Entry".Month THEN BEGIN
                            CLEAR(SnoCHeck);
                            IF Customer.GET("Cust. Ledger Entry"."Customer No.") THEN BEGIN
                                CLEAR(TotalDr);
                                CLEAR(TotalCr);
                                CLEAR(Opening);
                                CLEAR(Cust);
                                Cust := Customer.Name;
                                Customer.SETFILTER(Customer."Date Filter", '..%1', ("Cust. Ledger Entry"."Posting Date" - 1));
                                Customer.CALCFIELDS(Customer."Net Change");
                                Opening := Customer."Net Change";
                                OpCr := 0;
                                OpDr := 0;
                                IF Opening < 0 THEN
                                    OpCr := ABS(Opening)
                                ELSE
                                    OpDr := ABS(Opening);

                                TotalDr := "Cust. Ledger Entry"."Debit Amount" + OpDr;
                                TotalCr := "Cust. Ledger Entry"."Credit Amount" + OpCr;
                            END;
                        END;

                        YearGlobal := "Cust. Ledger Entry".Month;


                        CustGlobal := "Cust. Ledger Entry"."Customer No.";

                    END;

                    IF ReturnGroup = 4 THEN BEGIN

                        IF CustGlobal <> "Cust. Ledger Entry"."Customer No." THEN
                            CLEAR(SnoCHeck);
                        IF Customer.GET("Cust. Ledger Entry"."Customer No.") THEN BEGIN
                            CLEAR(TotalDr);
                            CLEAR(TotalCr);
                            CLEAR(Opening);
                            CLEAR(Cust);
                            Cust := Customer.Name;
                            Customer.SETFILTER(Customer."Date Filter", '..%1', ("Cust. Ledger Entry"."Posting Date" - 1));
                            Customer.CALCFIELDS(Customer."Net Change");
                            Opening := Customer."Net Change";
                            OpCr := 0;
                            OpDr := 0;
                            IF Opening < 0 THEN
                                OpCr := ABS(Opening)
                            ELSE
                                OpDr := ABS(Opening);

                            TotalDr := "Cust. Ledger Entry"."Debit Amount" + OpDr;
                            TotalCr := "Cust. Ledger Entry"."Credit Amount" + OpCr;
                        END;

                        CustGlobal := "Cust. Ledger Entry"."Customer No.";

                    END;

                    IF SnoCHeck = 1 THEN BEGIN
                        IF ReturnGroup <> 0 THEN BEGIN
                            Customer.RESET;
                            IF Customer.GET("Cust. Ledger Entry"."Customer No.") THEN BEGIN
                                Cust := Customer.Name;
                                Customer.SETFILTER(Customer."Date Filter", '..%1', ("Cust. Ledger Entry"."Posting Date" - 1));
                                Customer.CALCFIELDS(Customer."Net Change");
                                Opening := Customer."Net Change";
                            END;
                        END ELSE
                            ERROR('Please Select The  balance Option');

                        OpCr := 0;
                        OpDr := 0;
                        IF Opening < 0 THEN OpCr := ABS(Opening) ELSE OpDr := ABS(Opening);
                    END;
                    //-- 5. Tri18.1 PG 13112006 -- Stop


                    Check1.RESET;
                    Check1.SETRANGE(Check1."Document No.", "Cust. Ledger Entry"."Document No.");
                    Check1.SETRANGE(Check1."Transaction No.", "Cust. Ledger Entry"."Transaction No.");//TRI A.S 07.07.08
                    Check1.SETFILTER(Check1."Cheque No.", '<>%1', '');
                    IF Check1.FIND('-') THEN BEGIN
                        Cheque_No := Check1."Cheque No.";
                        "Cheque Date" := Check1."Cheque Date";
                    END
                    ELSE BEGIN
                        Cheque_No := '';
                        //      "Cheque Date":=format('');
                    END;

                    //-- 6. Tri18.1 PG 13112006 -- Start
                    TotalDr := "Cust. Ledger Entry"."Debit Amount" + OpDr;
                    TotalCr := "Cust. Ledger Entry"."Credit Amount" + OpCr;

                    Balance := TotalDr - TotalCr;
                    ClCr := 0;
                    ClDr := 0;
                    IF Balance > 0 THEN ClCr := ABS(Balance) ELSE ClDr := ABS(Balance);
                    BalanceDr := TotalDr + ClDr;
                    BalanceCr := TotalCr + ClCr;

                    //-- 6. Tri18.1 PG 13112006 -- Stop

                    //
                    PostNarrationRec.RESET;
                    PostNarrationRec.SETRANGE("Document No.", "Cust. Ledger Entry"."Document No.");
                    IF PostNarrationRec.FINDFIRST THEN
                        NarrationText := PostNarrationRec.Narration;

                    Customer.GET(Customer."No.");
                    IF Customer."Customer Status" = Customer."Customer Status"::Closed THEN
                        ERROR('This Customer is Closed Please contact OBL Auth. Rep.');
                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FIELDNO("Customer No.");
                    CLEAR(SnoCHeck);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(ReturnGroup);
                //-- 5. Tri18.1 PG 13112006 -- Start
                IF "Balance Option" = "Balance Option"::Day THEN BEGIN
                    ReturnGroup := 1;
                END

                ELSE
                    IF "Balance Option" = "Balance Option"::Month THEN BEGIN
                        ReturnGroup := 2;
                    END
                    ELSE
                        IF "Balance Option" = "Balance Option"::Year THEN BEGIN
                            ReturnGroup := 3;
                        END
                        ELSE
                            IF "Balance Option" = "Balance Option"::Range THEN BEGIN
                                ReturnGroup := 4;
                            END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Balance Option"; "Balance Option")
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

    trigger OnPostReport()
    begin
        //             RepAuditMgt.CreateAudit(50284)
    end;

    trigger OnPreReport()
    begin
        IF COMPANYNAME = 'Orient Bell Limited' THEN
            CompanyName1 := 'Orient Bell Ltd.';
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Bal: Decimal;
        Customer: Record Customer;
        Cust: Text[200];
        Check1: Record "Bank Account Ledger Entry";
        Cheque_No: Code[10];
        "Cheque Date": Date;
        CLE: Record "Cust. Ledger Entry";
        Opening: Decimal;
        "Balance Option": Option Range,Day,Month,Year;
        CRDRText: Text[2];
        Balance: Decimal;
        OpCr: Decimal;
        OpDr: Decimal;
        ClCr: Decimal;
        ClDr: Decimal;
        BalanceCr: Decimal;
        BalanceDr: Decimal;
        TotalDr: Decimal;
        TotalCr: Decimal;
        CompanyName1: Text[50];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        TotalFor: Label 'Total for ';
        TextAddress1: Label 'Regd. office:  8 Ind Area Sikandrabad';
        TextAddress2: Label 'Distt. Bulandshahr (UP)';
        TextCity: Label '  SIKANDRABAD';
        TextPhone: Label '  Phone: 28521206  Fax: 28521273';
        TextCIN: Label 'CIN No. L14101UP1977PLC021546';
        //  Text002: ;
        //  Text001: ;
        ReturnGroup: Integer;
        SnoCHeck: Integer;
        CustGlobal: Code[30];
        DateGlobal: Date;
        MonthGlobal: Integer;
        YearGlobal: Integer;
        PostNarrationRec: Record "Posted Narration";
        NarrationText: Text;

    procedure SetDateFilters(LCLStDate: Date; LCLToDate: Date)
    begin
    end;
}

