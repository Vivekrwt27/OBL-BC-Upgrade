report 50362 "TCS Collection Report"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\TCSCollectionReport.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("P.A.N. No.")
                                WHERE("P.A.N. No." = FILTER(<> ''),
                                "Customer Type" = FILTER('<>MISC.'),
                                      "Country/Region Code" = FILTER(01));

            column(FYear; FYear)
            {
            }
            column(Detail; Detail)
            {
            }
            column(PANNo; Customer."P.A.N. No.")
            {
            }
            column(No; Customer."No.")
            {
            }
            column(Name; Customer.Name)
            {
            }
            column(Address; Customer.Address)
            {
            }
            column(City; Customer.City)
            {
            }
            column(StateName; State.Description)
            {
            }
            column(TabZone; Customer."Tableau Zone")
            {
            }
            column(SPCode; Customer."Salesperson Code")
            {
            }
            column(Collection_Jan; Collection[1])
            {
            }
            column(Collection_Feb; Collection[2])
            {
            }
            column(Collection_March; Collection[3])
            {
            }
            column(Collection_April; Collection[4])
            {
            }
            column(Collection_May; Collection[5])
            {
            }
            column(Collection_June; Collection[6])
            {
            }
            column(Collection_July; Collection[7])
            {
            }
            column(Collection_Aug; Collection[8])
            {
            }
            column(Collection_Sept; Collection[9])
            {
            }
            column(Collection_Oct; Collection[10])
            {
            }
            column(Collection_Nov; Collection[11])
            {
            }
            column(Collection_Dec; Collection[12])
            {
            }
            column(TotCollection; TotCollection)
            {
            }
            column(ThresholdValue; ThresholdValue)
            {
            }
            column(TCSPrc; TCSPrc)
            {
            }
            column(Cust_type; Customer."Customer Type")
            {

            }

            trigger OnAfterGetRecord()
            var
                CalcDate: Date;
            begin
                IF State.GET(Customer."State Code") THEN;

                CLEAR(Collection);
                TotCollection := 0;
                CalcDate := EDate;
                //IF LastPAN <> Customer."P.A.N. No." THEN BEGIN
                CalcDate := CalculateEndDate(Customer."P.A.N. No.");
                CalculatePaymentCollection(Customer."No.", StDate, CalcDate, Collection);
                FOR I := 1 TO 12 DO BEGIN
                    TotCollection += Collection[I];
                END;
                //END;
                IF TotCollection = 0 THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                ThresholdValue := 5000000;
                //TCSPrc := 0.0001;
                TCSPrc := 0.001;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Financial Year"; FYear)
                {
                    ApplicationArea = All;
                }
                field("End Date"; EDate)
                {
                    ApplicationArea = All;
                }
                field("Show Detail"; Detail)
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

    trigger OnPreReport()
    begin
        EVALUATE(FFYr, FORMAT(FYear));
        StDate := DMY2DATE(1, 4, FFYr);

        IF EDate = 0D THEN
            EDate := DMY2DATE(31, 3, FFYr + 1);
    end;

    var
        Collection: array[12] of Decimal;
        StDate: Date;
        EDate: Date;
        I: Integer;
        TotCollection: Decimal;
        LastPAN: Code[20];
        PanCollection: array[12] of Decimal;
        FYear: Option " ","2020","2021","2022","2023","2024","2025";
        FinancialYr: Integer;
        ThresholdValue: Decimal;
        TCSPrc: Decimal;
        Detail: Boolean;
        State: Record State;
        FFYr: Integer;

    local procedure CalculatePaymentCollection(CustNo: Code[20]; DtFrom: Date; DtTo: Date; var PaymentCollection: array[12] of Decimal)
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        i: Integer;
        J: Integer;
    begin
        CLEAR(PaymentCollection);
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETCURRENTKEY("Document Type", "Customer No.", "Posting Date", "Currency Code");
        CustLedgerEntry.SETRANGE("Customer No.", CustNo);
        CustLedgerEntry.SETFILTER("Posting Date", '%1..%2', DtFrom, DtTo);
        //CustLedgerEntry.SETFILTER("Document Type",'%1',CustLedgerEntry."Document Type"::Payment,CustLedgerEntry."Document Type"::Refund);
        CustLedgerEntry.SETFILTER("Document Type", '%1|%2', CustLedgerEntry."Document Type"::Payment, CustLedgerEntry."Document Type"::Refund);
        //CustLedgerEntry.SETFILTER("TCS On Collection Entry",'%1',TRUE);
        //CustLedgerEntry.SETFILTER("Document Type",'%1|%2',CustLedgerEntry."Document Type"::Payment,CustLedgerEntry."Document Type"::Refund);
        IF CustLedgerEntry.FINDFIRST THEN
            REPEAT
                CustLedgerEntry.CALCFIELDS("Amount (LCY)");
                //IF CustLedgerEntry."Amount (LCY)"<0 THEN BEGIN
                IF CustLedgerEntry."Amount (LCY)" <> 0 THEN BEGIN  //MIPLRK130922
                    FOR i := 1 TO 12 DO BEGIN
                        IF i = DATE2DMY(CustLedgerEntry."Posting Date", 2) THEN
                            PaymentCollection[i] -= CustLedgerEntry."Amount (LCY)";
                    END;
                END;
            UNTIL CustLedgerEntry.NEXT = 0;
    end;

    local procedure CalculateEndDate(PanNo: Code[20]) EndDate: Date
    var
        PANCustomer: Record Customer;
    begin
        PANCustomer.RESET;
        PANCustomer.SETRANGE("P.A.N. No.", PanNo);
        PANCustomer.SETFILTER("TCS Charge Stop Date", '%1..%2', StDate, EDate);
        IF PANCustomer.FINDFIRST THEN
            EXIT(PANCustomer."TCS Charge Stop Date")
        ELSE
            EXIT(EDate);
    end;
}

