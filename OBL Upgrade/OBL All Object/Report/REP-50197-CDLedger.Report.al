report 50197 "CD Ledger"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\CDLedger.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Customer; 18)
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
            dataitem("CD Entry"; 50066)
            {
                DataItemLink = "Cust. No." = FIELD("No.");
                DataItemTableView = SORTING("Cust. No.", "Posting Date", "Cust. Entry No.")
                                    WHERE("CD Amount" = FILTER(<> 0));
                column(InvoiceNo; "CD Entry"."Invoice No.")
                {
                }
                column(DocType; "CD Entry"."CD Document Type")
                {
                }
                column(PostDate; "CD Entry"."Posting Date")
                {
                }
                column(CDPerage; "CD Entry"."CD % age")
                {
                }
                column(CDBaseAmt; "CD Entry"."CD Base Amount")
                {
                }
                column(CDAmount; "CD Entry"."CD Amount")
                {
                }
                column(RunningBal; RunningBal)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    RunningBal := RunningBal + "CD Entry"."CD Amount";
                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
                end;
            }

            trigger OnAfterGetRecord()
            var
                CDEntry: Record "CD Entry";
            begin
                OpenAmt := 0;
                RunningBal := 0;
                ClosingBal := 0;
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
                RunningBal := OpenAmt;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("From Date"; FromDate)
                {
                    ApplicationArea = All;
                }
                field("End Date"; ToDate)
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
        IF (FromDate = 0D) OR (ToDate = 0D) THEN
            ERROR('Please select From Date /ToDate');
    end;

    var
        FromDate: Date;
        ToDate: Date;
        OpenAmt: Decimal;
        RunningBal: Decimal;
        ClosingBal: Decimal;
}

