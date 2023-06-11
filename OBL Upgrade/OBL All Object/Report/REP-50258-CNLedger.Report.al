report 50258 "CN Ledger"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\CNLedger.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(FromDate; FORMAT(FromDate))
            {
            }
            column(ToDate; FORMAT(ToDate))
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
            dataitem("Issued Credit Details"; "Issued Credit Details")
            {
                DataItemLink = "Cust. No." = FIELD("No.");
                DataItemTableView = SORTING("Cust. No.", "Posting Date", "Entry No.")
                                    WHERE(Amount = FILTER(<> 0));
                RequestFilterFields = "Sales Order No.";
                column(Inv_no; "Issued Credit Details"."Invoice No.")
                {
                }
                column(doc_type; "Issued Credit Details"."Document Type")
                {
                }
                column(inv_amt; "Issued Credit Details"."Invoice Amount")
                {
                }
                column(pay_amt; "Issued Credit Details".Amount)
                {
                }
                column(ext_doc; "Issued Credit Details"."External Doc. No.")
                {
                }
                column(so_no; "Issued Credit Details"."Sales Order No.")
                {
                }
                column(posting_date; FORMAT("Issued Credit Details"."Posting Date"))
                {
                }
                column(narration; "Issued Credit Details".Narration)
                {
                }
                column(RunningBal; RunningBal)
                {
                }
                column(Doc_type1; "Issued Credit Details"."Item Charge No.")
                {
                }
                column(Sales_inv_no; sin)
                {
                }
                column(Inv_dt; FORMAT(sindt))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    RunningBal := RunningBal + "Issued Credit Details".Amount;
                    sih.RESET;
                    sih.SETRANGE(sih."Order No.", "Sales Order No.");
                    IF sih.FINDFIRST THEN BEGIN
                        sin := sih."No.";
                        sindt := sih."Posting Date";
                        //      message('%1', sindt);
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
                end;
            }

            trigger OnAfterGetRecord()
            var
                CnEntry: Record "Issued Credit Details";
            begin
                OpenAmt := 0;
                RunningBal := 0;
                ClosingBal := 0;
                CnEntry.RESET;
                CnEntry.SETRANGE("Cust. No.", Customer."No.");
                CnEntry.SETFILTER("Posting Date", '%1..%2', 0D, ToDate);
                IF NOT CnEntry.FINDFIRST THEN BEGIN
                    //  CnEntry.CALCSUMS(Amount);
                    //  ClosingBal := CnEntry.Amount;
                    CurrReport.SKIP;

                END;

                //IF ClosingBal= 0 THEN
                //  CurrReport.SKIP;

                CnEntry.RESET;
                CnEntry.SETFILTER("Cust. No.", '%1', Customer."No.");
                CnEntry.SETFILTER("Posting Date", '%1..%2', 0D, FromDate - 1);
                IF CnEntry.FINDFIRST THEN
                    REPEAT
                        OpenAmt += CnEntry.Amount;
                    UNTIL CnEntry.NEXT = 0;
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
        sih: Record "Sales Invoice Header";
        sin: Code[20];
        sindt: Date;
}

