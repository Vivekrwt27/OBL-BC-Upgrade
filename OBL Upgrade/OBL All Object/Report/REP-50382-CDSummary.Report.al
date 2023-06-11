report 50382 "CD Summary"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\CDSummary.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(FromDate; FromDate)
            {
            }
            column(ToDate; ToDate)
            {
            }
            column(CustomerNo; Customer."No.")
            {
            }
            column(CustName; Customer.Name)
            {
            }
            column(State; Customer."State Code")
            {
            }
            column(OpenAmt; OpenAmt)
            {
            }
            column(ClosingBal; ClosingBal)
            {
            }
            column(Availed1; Availed[1])
            {
            }
            column(Availed2; Availed[2])
            {
            }
            column(Availed3; Availed[3])
            {
            }
            column(Availed4; Availed[4])
            {
            }
            column(Availed5; Availed[5])
            {
            }
            column(Availed6; Availed[6])
            {
            }
            column(Availed7; Availed[7])
            {
            }
            column(Availed8; Availed[8])
            {
            }
            column(Availed9; Availed[9])
            {
            }
            column(Availed10; Availed[10])
            {
            }
            column(Availed11; Availed[11])
            {
            }
            column(Availed12; Availed[12])
            {
            }
            column(Earned1; Earned[1])
            {
            }
            column(Earned2; Earned[2])
            {
            }
            column(Earned3; Earned[3])
            {
            }
            column(Earned4; Earned[4])
            {
            }
            column(Earned5; Earned[5])
            {
            }
            column(Earned6; Earned[6])
            {
            }
            column(Earned7; Earned[7])
            {
            }
            column(Earned8; Earned[8])
            {
            }
            column(Earned9; Earned[9])
            {
            }
            column(Earned10; Earned[10])
            {
            }
            column(Earned11; Earned[11])
            {
            }
            column(Earned12; Earned[12])
            {
            }

            trigger OnAfterGetRecord()
            var
                CDEntry: Record "CD Entry";
            begin
                OpenAmt := 0;
                RunningBal := 0;
                ClosingBal := 0;
                CLEAR(Availed);
                CLEAR(Earned);


                CDEntry.RESET;
                CDEntry.SETRANGE("Cust. No.", Customer."No.");
                CDEntry.SETFILTER("Posting Date", '%1..%2', 0D, ToDate);
                IF CDEntry.FINDFIRST THEN BEGIN
                    CDEntry.CALCSUMS("CD Amount");
                    ClosingBal := CDEntry."CD Amount";
                END;

                IF ClosingBal = 0 THEN
                    CurrReport.SKIP;

                CDEntry.RESET;
                CDEntry.SETRANGE("Cust. No.", Customer."No.");
                CDEntry.SETFILTER("Posting Date", '%1..%2', 0D, FromDate);
                IF CDEntry.FINDFIRST THEN
                    REPEAT
                        OpenAmt += CDEntry."CD Amount";
                    UNTIL CDEntry.NEXT = 0;

                CDEntry.RESET;
                CDEntry.SETRANGE("Cust. No.", Customer."No.");
                CDEntry.SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
                IF CDEntry.FINDFIRST THEN
                    REPEAT
                        IF CDEntry."CD Amount" < 0 THEN
                            Availed[DATE2DMY(CDEntry."Posting Date", 2)] -= CDEntry."CD Amount"
                        ELSE
                            Earned[DATE2DMY(CDEntry."Posting Date", 2)] += CDEntry."CD Amount";
                    UNTIL CDEntry.NEXT = 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Year; Year)
                {
                    ApplicationArea = All;
                }
                field("From Month"; FromMonth)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Year = 0 THEN
                            ERROR('Please select the Year');
                        FromDate := DMY2DATE(1, FromMonth, Year);

                        IF ToMonth < FromMonth THEN
                            ToYear := Year + 1;
                    end;
                }
                field("To Month"; ToMonth)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ToDate := CALCDATE('CM', DMY2DATE(1, ToMonth, ToYear));
                    end;
                }
                field("From Date"; FromDate)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("End Date"; ToDate)
                {
                    Editable = false;
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
        IF (FromDate = 0D) OR (ToDate = 0D) THEN
            ERROR('Please select From Date /ToDate');
    end;

    var
        FromDate: Date;
        ToDate: Date;
        OpenAmt: Decimal;
        RunningBal: Decimal;
        ClosingBal: Decimal;
        Availed: array[12] of Decimal;
        Earned: array[12] of Decimal;
        I: Integer;
        FromMonth: Option " ",Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec;
        ToMonth: Option " ",Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec;
        Year: Integer;
        ToYear: Integer;
}

