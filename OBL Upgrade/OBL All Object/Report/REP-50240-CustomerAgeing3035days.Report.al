report 50240 "Customer - Ageing (30-35 days)"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\CustomerAgeing3035days.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("Salesperson Code")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Global Dimension 1 Code", "State Code";
            column(Summary; Summary)
            {
            }
            column(Filters; Filters)
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CustNo; FORMAT("No."))
            {
            }
            column(CustName; Customer.Name)
            {
            }
            column(CustStateCode; Customer."State Code")
            {
            }
            column(CustNameAndCity; Customer.Name + ' , ' + Customer.City)
            {
            }
            column(StateDes; Customer."State Desc.")
            {
            }
            column(CreditLimit; Customer."Credit Limit (LCY)")
            {
            }
            column(SalesPersonCode; Customer."Salesperson Code")
            {
            }
            column(PchName; Customer."PCH Name")
            {
            }
            column(SalePurchName; Customer."Salesperson Description")
            {
            }
            column(CustomerCity; Customer.City)
            {
            }
            column(CusomerType; Customer."Customer Type")
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                CalcFields = "Original Amt. (LCY)", "Remaining Amt. (LCY)";
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.")
                                    ORDER(Ascending);
                RequestFilterFields = "Document Type";
                column(BranchCode; "Cust. Ledger Entry"."Global Dimension 1 Code")
                {
                }
                column(PostingDate; FORMAT("Posting Date"))
                {
                }
                column(DocNo; "Document No.")
                {
                }
                column(DocType; FORMAT("Document Type"))
                {
                }
                column(PendingForm; PendingForm)
                {
                }
                column(AmtD11; Amt[11])
                {
                }
                column(AmtD1; Amt[1])
                {
                }
                column(AmtD2; Amt[2])
                {
                }
                column(AmtD3; Amt[3])
                {
                }
                column(AmtD4; Amt[4])
                {
                }
                column(AmtD5; Amt[5])
                {
                }
                column(AmtD6; Amt[6])
                {
                }
                column(AmtD7; Amt[7])
                {
                }
                column(AmtD8; Amt[8])
                {
                }
                column(AmtD9; Amt[9])
                {
                }
                column(AmtD10; Amt[10])
                {
                }
                column(AmtD12; Amt[12])
                {
                }
                column(AmtD13; Amt[13])
                {
                }
                column(RecCustomerCustomerType; RecCustomer."Customer Type")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    FOR i := 1 TO 13 DO BEGIN   //Clear Varibales
                        CLEAR(Amt[i]);
                    END;

                    IF NOT Summary THEN BEGIN

                        IF RecCustomer.GET("Customer No.") THEN;
                        IF RecCustomer."Salesperson Code" <> '' THEN;


                        FOR i := 1 TO 13 DO
                            //  AmtD[i] := ABS(Amt[i]); //VS
                            AmtD[i] := Amt[i];
                        PendingForm := '';

                        IF "Document Type" = "Document Type"::Invoice THEN
                            IF SalesInvoiceHeader.GET("Document No.") THEN;
                        /*//16225 IF SalesInvoiceHeader."Form Code" <> '' THEN
                            /16225 IF SalesInvoiceHeader."Form No." = '' THEN
                               /16225  PendingForm := SalesInvoiceHeader."Form No.";*/
                    END;

                    IF Summary THEN BEGIN

                        CustNo := 'C' + FORMAT("Customer No.");

                        FOR i := 1 TO 13 DO
                            IF Amt[i] < 0 THEN
                                Text[i] := '-'
                            ELSE             // TRI LM  IF Amt[i] = 0 THEN
                                Text[i] := '';
                        //TRI LM  ELSE IF Amt[i] > 0 THEN
                        //TRI LM    Text[i] := '+';
                        FOR i := 1 TO 13 DO
                            AmtD[i] := Amt[i];

                    END;

                    CALCFIELDS("Remaining Amt. (LCY)");
                    //MESSAGE(FORMAT("Remaining Amt. (LCY)"));
                    IF ROUND("Remaining Amt. (LCY)", 0.01) = 0 THEN
                        CurrReport.SKIP;
                    IF ("Posting Date" <= StartDate) AND ("Posting Date" > (StartDate - 30)) THEN  //Within last 30 Days
                        Amt[1] := "Remaining Amt. (LCY)";
                    IF ("Posting Date" <= (StartDate - 30)) AND ("Posting Date" > (StartDate - 35)) THEN  //Between last  30 days to 35 Days
                        Amt[2] := "Remaining Amt. (LCY)";

                    //TRI A.S 31.07.08 START
                    IF ("Posting Date" <= (StartDate - 35)) AND ("Posting Date" > (StartDate - 45)) THEN  //Between last 36 Days to 45 Days
                        Amt[3] := "Remaining Amt. (LCY)";
                    IF ("Posting Date" <= (StartDate - 45)) AND ("Posting Date" > (StartDate - 60)) THEN  //Between last 46 Days to 60 Days
                        Amt[4] := "Remaining Amt. (LCY)";
                    //TRI A.S 31.07.08 END

                    IF ("Posting Date" <= (StartDate - 60)) AND ("Posting Date" > (StartDate - 90)) THEN  //Between last 61 Days to 90 Days
                        Amt[5] := "Remaining Amt. (LCY)";
                    IF ("Posting Date" <= (StartDate - 90)) AND ("Posting Date" > (StartDate - 120)) THEN  //Between last 91 Days to 180 Days
                        Amt[6] := "Remaining Amt. (LCY)";

                    IF ("Posting Date" <= (StartDate - 120)) AND ("Posting Date" > (StartDate - 150)) THEN  //Between last 91 Days to 180 Days
                        Amt[7] := "Remaining Amt. (LCY)";

                    IF ("Posting Date" <= (StartDate - 150)) AND ("Posting Date" > (StartDate - 180)) THEN  //Between last 91 Days to 180 Days
                        Amt[8] := "Remaining Amt. (LCY)";


                    IF ("Posting Date" <= (StartDate - 180)) AND ("Posting Date" > (StartDate - 365)) THEN  //Between last 181 Days to 365 Days
                        Amt[9] := "Remaining Amt. (LCY)";
                    IF ("Posting Date" <= (StartDate - 365)) AND ("Posting Date" > (StartDate - 730))  //Between 1 to 2 yrs
                    THEN
                        Amt[10] := "Remaining Amt. (LCY)";
                    IF ("Posting Date" <= (StartDate - 730)) AND ("Posting Date" > (StartDate - 1095))  //Between 2 to 3 yrs
                    THEN
                        Amt[11] := "Remaining Amt. (LCY)";

                    IF "Posting Date" <= (StartDate - 1095)
                    THEN  //Before 365 Days
                        Amt[12] := "Remaining Amt. (LCY)";

                    FOR i := 1 TO 12 DO
                        Amt[13] := Amt[13] + Amt[i];

                    //TRI N.M - 06.12.07 Start
                    IF MinimumAmt = TRUE THEN
                        IF (Amt[13] > 0) AND (AmountRestriction >= Amt[13]) THEN
                            CurrReport.SKIP
                        ELSE
                            IF (Amt[13] < 0) AND (AmountRestriction >= Amt[13]) THEN
                                CurrReport.SKIP;
                    //TRI N.M - 06.12.07 Stop


                    FOR i := 1 TO 13 DO
                        IF Amt[i] < 0 THEN
                            Text[i] := '-'
                        ELSE
                            Text[i] := ' ';
                    //  ELSE IF Amt[i] > 0 THEN
                    //    Text[i] := '+';

                    //TRI SB 010607 Add End
                end;

                trigger OnPreDataItem()
                begin

                    SETRANGE("Posting Date", 0D, StartDate);
                    SETFILTER("Date Filter", '<=%1', StartDate);
                    SETFILTER("Cust. Ledger Entry"."Entry Skipped", '%1', FALSE);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF SalePurch.GET(RecCustomer."Salesperson Code") THEN;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET();
                Filters := Customer.GETFILTERS;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Aged as of"; StartDate)
                {
                    ApplicationArea = All;
                }
                field("Amount Restriction"; AmountRestriction)
                {
                    ApplicationArea = All;
                }
                field(Summary; Summary)
                {
                    ApplicationArea = All;
                }
                field("Minimum Amount"; MinimumAmt)
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

        IF StartDate = 0D THEN
            StartDate := WORKDATE;
        //TRI SB 010607 Add End
    end;

    var
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        StartDate: Date;
        CustFilter: Text[250];
        PeriodStartDate: array[6] of Date;
        CustBalanceDueLCY: array[5] of Decimal;
        PrintCust: Boolean;
        i: Integer;
        Amt: array[14] of Decimal;
        Text: array[14] of Text[2];
        AmtD: array[14] of Decimal;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Summary: Boolean;
        PendingForm: Text[250];
        SalesInvoiceHeader: Record "Sales Invoice Header";
        CompanyInfo: Record "Company Information";
        CompanyName1: Text[100];
        AmountRestriction: Integer;
        recDtldCustLedEnt: Record "Detailed Cust. Ledg. Entry";
        "---": Integer;
        ExcelBuf: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        ReportTitle: Text[100];
        CustNo: Text[50];
        MinimumAmt: Boolean;
        Printdetail: Boolean;
        SalePurch: Record "Salesperson/Purchaser";
        RecCustomer: Record Customer;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Text001: Label 'As of %1';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Print Date';
        Text011: Label 'Filters';
        Text012: Label 'Filters 2';
        Text01: Label 'Customer Aging Report';
        Text002: Label 'Data';
        Filters: Text[100];
}

