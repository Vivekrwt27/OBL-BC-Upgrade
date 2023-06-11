report 50267 "Vendor Balance Update"
{
    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("Start Date"; StartDate)
                    {
                        Editable = false;
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
        //StartDate := TODAY -1;
    end;

    trigger OnPostReport()
    begin
        UpdateOuststandingOverDueAmtOnCustomer;

        IF GUIALLOWED THEN
            MESSAGE('Done');
    end;

    var
        Vendorkbs: Record Vendor;
        vendtLedgerEntry: Record "Vendor Ledger Entry";
        OutstandingAmt: Decimal;
        StartDate: Date;

    procedure UpdateOuststandingOverDueAmtOnCustomer()
    begin
        CLEAR(OutstandingAmt);
        Vendorkbs.RESET;
        Vendorkbs.SETFILTER("Balance Conf Date", '<>%1', 0D);
        IF Vendorkbs.FINDFIRST THEN
            REPEAT
                OutstandingAmt := 0;
                vendtLedgerEntry.RESET;
                vendtLedgerEntry.SETRANGE("Vendor No.", Vendorkbs."No.");
                IF vendtLedgerEntry.FINDFIRST THEN
                    REPEAT
                        IF (vendtLedgerEntry."Posting Date" <= Vendorkbs."Balance Conf Date") THEN BEGIN
                            vendtLedgerEntry.CALCFIELDS(Amount);
                            OutstandingAmt += vendtLedgerEntry.Amount;
                        END;
                    UNTIL vendtLedgerEntry.NEXT = 0;
                Vendorkbs."Bal on Balance Conf Date" := OutstandingAmt;
                Vendorkbs.MODIFY;
            UNTIL Vendorkbs.NEXT = 0;
    end;
}

