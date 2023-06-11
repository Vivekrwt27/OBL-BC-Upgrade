report 50349 "Vendor - Ageing1"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\VendorAgeing1.rdl';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("Purchaser Code");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Msme Code";
            column(Vendor_PurchaserCode; Vendor."Purchaser Code")
            {
            }
            column(NameCity; Name + '  ' + City)
            {
            }
            column(Summary; Summary)
            {
            }
            column(VenNo; Vendor."No.")
            {
            }
            column(VenStateCode; Vendor."State Code")
            {
            }
            column(VenPostGrp; Vendor."Vendor Posting Group")
            {
            }
            column(VenFilter; VenFilter)
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                CalcFields = "Original Amt. (LCY)", "Remaining Amt. (LCY)", "Vendor Invoice No.";
                DataItemLink = "Vendor No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Vendor No.", "Posting Date", "Currency Code")
                                    ORDER(Ascending);
                column(GlobDimSet1; "Vendor Ledger Entry"."Global Dimension 1 Code")
                {
                }
                column(PostingDate; "Posting Date")
                {
                }
                column(DocumentNo; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(VenInvNo; vin)
                {
                }
                column(Doc_Dt; FORMAT(vid))
                {
                }
                column(DocType; FORMAT("Document Type"))
                {
                }
                column(ExternalDocNo; "Vendor Ledger Entry"."External Document No.")
                {
                }
                column(OriginAmtLCY; "Vendor Ledger Entry"."Original Amt. (LCY)")
                {
                }
                column(PosDate; "Vendor Ledger Entry"."Posting Date")
                {
                }
                column(DocNo; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(DocDt; "Vendor Ledger Entry"."Document Date")
                {
                }
                column(AmtD9; AmtD[9])
                {
                }
                column(AmtD1; AmtD[1])
                {
                }
                column(AmtD2; AmtD[2])
                {
                }
                column(AmtD3; AmtD[3])
                {
                }
                column(AmtD4; AmtD[4])
                {
                }
                column(AmtD5; AmtD[5])
                {
                }
                column(AmtD6; AmtD[6])
                {
                }
                column(AmtD7; AmtD[7])
                {
                }
                column(AmtD8; AmtD[8])
                {
                }
                column(VendLedgEntryFilter; VendLedgEntryFilter)
                {
                }
                column(PO_no; "Vendor Ledger Entry"."Vendor Order No.")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    //TRI SB 010607 Add Start
                    FOR i := 1 TO 9 DO BEGIN   //Clear Varibales
                        CLEAR(Amt[i]);
                    END;
                    CALCFIELDS("Vendor Invoice Date");
                    CALCFIELDS("Remaining Amt. (LCY)");
                    //MESSAGE(FORMAT("Remaining Amt. (LCY)"));
                    IF ROUND("Remaining Amt. (LCY)", 0.01) = 0 THEN
                        CurrReport.SKIP;
                    TmpDate := "Vendor Invoice Date";
                    IF TmpDate = 0D THEN
                        TmpDate := "Vendor Ledger Entry"."Posting Date";
                    /*
                    IF ("Vendor Invoice Date"<=StartDate) AND ("Vendor Invoice Date">(StartDate-30)) THEN  //Within last 30 Days
                      Amt[1]:="Remaining Amt. (LCY)";
                    IF ("Vendor Invoice Date"<=(StartDate-30)) AND ("Vendor Invoice Date">(StartDate-60)) THEN  //Between last 31 Days to 60 Days
                      Amt[2]:="Remaining Amt. (LCY)";
                    IF ("Vendor Invoice Date"<=(StartDate-60)) AND ("Vendor Invoice Date">(StartDate-90)) THEN  //Between last 61 Days to 90 Days
                      Amt[3]:="Remaining Amt. (LCY)";
                    IF ("Vendor Invoice Date"<=(StartDate-90)) AND ("Vendor Invoice Date">(StartDate-180)) THEN  //Between last 91 Days to 180 Days
                      Amt[4]:="Remaining Amt. (LCY)";
                    IF ("Vendor Invoice Date"<=(StartDate-180)) AND ("Vendor Invoice Date">(StartDate-365)) THEN  //Between last 181 Days to 365 Days
                      Amt[5]:="Remaining Amt. (LCY)";
                    IF "Vendor Invoice Date"<=(StartDate-365) THEN  //Before 365 Days
                      Amt[6]:="Remaining Amt. (LCY)";
                    */

                    IF (TmpDate <= StartDate) AND (TmpDate > (StartDate - 30)) THEN  //Within last 30 Days
                        Amt[1] := "Remaining Amt. (LCY)";
                    IF (TmpDate <= (StartDate - 30)) AND (TmpDate > (StartDate - 60)) THEN  //Between last 31 Days to 60 Days
                        Amt[2] := "Remaining Amt. (LCY)";
                    IF (TmpDate <= (StartDate - 60)) AND (TmpDate > (StartDate - 90)) THEN  //Between last 61 Days to 90 Days
                        Amt[3] := "Remaining Amt. (LCY)";
                    IF (TmpDate <= (StartDate - 90)) AND (TmpDate > (StartDate - 120)) THEN  //Between last 91 Days to 180 Days
                        Amt[4] := "Remaining Amt. (LCY)";
                    IF (TmpDate <= (StartDate - 120)) AND (TmpDate > (StartDate - 150)) THEN  //Between last 91 Days to 180 Days
                        Amt[5] := "Remaining Amt. (LCY)";
                    IF (TmpDate <= (StartDate - 150)) AND (TmpDate > (StartDate - 180)) THEN  //Between last 91 Days to 180 Days
                        Amt[6] := "Remaining Amt. (LCY)";


                    IF (TmpDate <= (StartDate - 180)) AND (TmpDate > (StartDate - 365)) THEN  //Between last 181 Days to 365 Days
                        Amt[7] := "Remaining Amt. (LCY)";
                    IF TmpDate <= (StartDate - 365) THEN  //Before 365 Days
                        Amt[8] := "Remaining Amt. (LCY)";

                    FOR i := 1 TO 8 DO
                        Amt[9] := Amt[9] + Amt[i];


                    //TRI N.M - 06.12.07 Start
                    IF MinimumAmt = TRUE THEN
                        IF (Amt[9] > 0) AND (AmountRestriction <= Amt[9]) THEN
                            CurrReport.SKIP
                        ELSE
                            IF (Amt[9] < 0) AND (AmountRestriction <= Amt[9]) THEN
                                CurrReport.SKIP;
                    //TRI N.M - 06.12.07 Stop

                    IF Amt[9] = 0 THEN
                        CurrReport.SKIP;


                    FOR i := 1 TO 9 DO
                        IF Amt[i] < 0 THEN
                            Text[i] := '-'
                        ELSE
                            Text[i] := ' ';
                    //  ELSE IF Amt[i] > 0 THEN
                    //    Text[i] := '+';

                    //TRI SB 010607 Add End

                    //********************


                    FOR i := 1 TO 9 DO
                        //  AmtD[i] := ABS(Amt[i]); //VS
                        AmtD[i] := Amt[i];
                    PendingForm := '';
                    IF "Document Type" = "Document Type"::Invoice THEN
                        IF SalesInvoiceHeader.GET("Document No.") THEN
                            /* IF SalesInvoiceHeader."Form Code" <> '' THEN//16225 field n/F
                                 IF SalesInvoiceHeader."Form No." = '' THEN//16225 field n/F
                                     PendingForm := SalesInvoiceHeader."Form No.";*///16225 field n/F
                                                                                    //********************

                            FOR i := 1 TO 9 DO
                                IF Amt[i] < 0 THEN
                                    Text[i] := '-'
                                ELSE             // TRI LM  IF Amt[i] = 0 THEN
                                    Text[i] := '';
                    //TRI LM  ELSE IF Amt[i] > 0 THEN
                    //TRI LM    Text[i] := '+';
                    FOR i := 1 TO 9 DO
                        AmtD[i] := Amt[i];

                    //**********************

                    FOR i := 1 TO 9 DO
                        IF Amt[i] < 0 THEN
                            Text[i] := '-'
                        ELSE                     //TRI LM  IF Amt[i] = 0 THEN
                            Text[i] := '';
                    //TRI LM  ELSE IF Amt[i] > 0 THEN
                    //TRI LM    Text[i] := '+';

                    FOR i := 1 TO 9 DO
                        AmtD[i] := Amt[i];

                    vin := '';
                    vid := 0D;
                    IF purinvhead.GET("Document No.") THEN
                        vin := purinvhead."Vendor Invoice No.";
                    vid := purinvhead."Vendor Invoice Date";

                end;

                trigger OnPreDataItem()
                begin

                    CurrReport.CREATETOTALS("Vendor Ledger Entry"."Original Amt. (LCY)");
                    FOR i := 1 TO 9 DO
                        CurrReport.CREATETOTALS(Amt[i]);

                    //TRI SB 010607 Add Start
                    SETRANGE("Vendor Invoice Date", 0D, StartDate);
                    SETFILTER("Date Filter", '<=%1', StartDate);
                    //TRI SB 010607 Add End

                    VendLedgEntryFilter := "Vendor Ledger Entry".GETFILTERS;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //****************

                FOR i := 1 TO 9 DO
                    IF Amt[i] < 0 THEN
                        Text[i] := '-'
                    ELSE                //TRI LM  IF Amt[i] = 0 THEN
                        Text[i] := '';
                //TRI LM  ELSE IF Amt[i] > 0 THEN
                //TRI LM    Text[i] := '+';

                FOR i := 1 TO 9 DO
                    AmtD[i] := Amt[i];

                //****************
            end;

            trigger OnPreDataItem()
            begin
                //SETRANGE("No.",'D0121601116');

                FOR i := 1 TO 7 DO
                    CurrReport.CREATETOTALS(Amt[i]);
                CurrReport.CREATETOTALS("Vendor Ledger Entry"."Original Amt. (LCY)");

                CompanyInfo.GET;
                CompanyName1 := CompanyInfo.Name;
                CompanyName2 := CompanyInfo."Name 2";
                VendFilter := Vendor.GETFILTERS;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control1000000001)
                {
                    field("Aged as of"; StartDate)
                    {
                        ApplicationArea = All;
                    }
                    field("Minimum Amount"; AmountRestriction)
                    {
                        ApplicationArea = All;
                    }
                    field(Summary; Summary)
                    {
                        ApplicationArea = All;
                    }
                    field("Minimum Amt"; MinimumAmt)
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

    trigger OnPostReport()
    begin
        //RepAuditMgt.CreateAudit(50349)
    end;

    trigger OnPreReport()
    begin

        //TRI SB 010607 Add Start
        IF StartDate = 0D THEN
            StartDate := WORKDATE;
        //TRI SB 010607 Add End

        /*FOR i := 3 TO 5 DO
          PeriodStartDate[i] := CALCDATE(PeriodLength,PeriodStartDate[i-1]);
        PeriodStartDate[6] := 31129999D;*/

    end;

    var
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        StartDate: Date;
        VendFilter: Text[250];
        PeriodStartDate: array[6] of Date;
        CustBalanceDueLCY: array[5] of Decimal;
        PrintCust: Boolean;
        i: Integer;
        Amt: array[10] of Decimal;
        Text: array[10] of Text[50];
        AmtD: array[10] of Decimal;
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
        PeriodLength: DateFormula;
        CompanyName2: Text[100];
        TmpDate: Date;
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
        VenFilter: Text[100];
        VendLedgEntryFilter: Text[100];
        MSME: Boolean;
        puinvline: Record "Purch. Inv. Line";
        pono: Text[50];
        purinvhead: Record "Purch. Inv. Header";
        vid: Date;
        vin: Text[50];
}

