report 50367 "Vendor Application"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\VendorApplication.rdl';

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            CalcFields = "Original Amt. (LCY)", "Remaining Amt. (LCY)";
            DataItemTableView = SORTING("Vendor No.", "Posting Date", "Currency Code");
            RequestFilterFields = "Vendor No.", "Posting Date";
            column(EntryNo_VendorLedgerEntry; "Vendor Ledger Entry"."Entry No.")
            {
            }
            column(ReportCaption; ReportCaption)
            {
            }
            column(CompAdd1; CompanyInfo.Name)
            {
            }
            column(CompAdd2; CompanyInfo."Name 2")
            {
            }
            column(Filters; Filters)
            {
            }
            column(TODAY; FORMAT(TODAY))
            {
            }
            column(VendorNo_VendorLedgerEntry; "Vendor Ledger Entry"."Vendor No.")
            {
            }
            column(VendName; Vend.Name)
            {
            }
            //  column(VendType; Vend."Vendor Type")
            column(VendType; '')
            {
            }
            column(SNo; "T.no.")
            {
            }
            column(StateDesc; StateDesc)
            {
            }
            column(DoccNoVenLedEntry; "Vendor Ledger Entry"."Document No.")
            {
            }
            column(DocTypeVLE; "Vendor Ledger Entry"."Document Type")
            {
            }
            column(PostDateVLE; "Vendor Ledger Entry"."Posting Date")
            {
            }
            column(OrigAmtVLE; ABS("Vendor Ledger Entry"."Original Amt. (LCY)"))
            {
            }
            column(RemAmtVLE; ABS(VendorLedgerApp."Remaining Amt. (LCY)"))
            {
            }
            dataitem(VendorLedgerApp; "Vendor Ledger Entry")
            {
                DataItemLink = "Closed by Entry No." = FIELD("Entry No.");
                DataItemTableView = SORTING("Closed by Entry No.", "Posting Date");
                column(DocumentNo_VendorLedgerApp; VendorLedgerApp."Document No.")
                {
                }
                column(DocumentType_VendorLedgerApp; VendorLedgerApp."Document Type")
                {
                }
                column(PostingDate_VendorLedgerApp; VendorLedgerApp."Posting Date")
                {
                }
                column(OriginalAmtLCY_VendorLedgerApp; ABS(VendorLedgerApp."Original Amt. (LCY)"))
                {
                }
                column(ClosedbyAmount_VendorLedgerApp; VendorLedgerApp."Closed by Amount")
                {
                }
                column(OrignalAmt; OrignalAmt)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    CLE3.RESET;
                    CLE3.SETRANGE(CLE3."Document No.", "Document No.");
                    IF CLE3.FIND('-') THEN BEGIN
                        CLE3.CALCFIELDS("Amount (LCY)");
                        OrignalAmt := CLE3."Amount (LCY)";
                    END;
                end;
            }
            dataitem(Integer; Integer)
            {
                column(DocType; Doctype)
                {
                }
                column(DocNoInt; VendorLedger."Document No.")
                {
                }
                column(PostDateInt; VendorLedger."Posting Date")
                {
                }
                column(Closedamount; Closedamount)
                {
                }
                column(Closedamount1; ABS(Closedamount))
                {
                }

                trigger OnAfterGetRecord()
                begin

                    IF VendorLedger.GET("Vendor Ledger Entry"."Closed by Entry No.") THEN BEGIN
                        VendorLedger.CALCFIELDS(Amount, "Remaining Amount");
                        Closedamount := "Vendor Ledger Entry"."Closed by Amount";
                        RemaingAmt := VendorLedger."Remaining Amount";
                        Doctype := VendorLedger."Document Type";
                    END;
                    IF Closedamount = 0 THEN
                        CurrReport.SKIP;
                end;

                trigger OnPreDataItem()
                begin

                    Closedamount := 0;
                    RemaingAmt := 0;
                    Doctype := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                "Vendor Ledger Entry".CALCFIELDS("Vendor Ledger Entry"."Original Amt. (LCY)", "Vendor Ledger Entry"."Remaining Amt. (LCY)");

                "T.no." += 1;
                IF Vend.GET("Vendor Ledger Entry"."Vendor No.") THEN BEGIN
                    State1.RESET;
                    State1.SETRANGE(Code, Vend."State Code");
                    IF State1.FINDFIRST THEN BEGIN
                        StateDesc := State1.Description;
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin

                IF InvoiceApp THEN BEGIN
                    "Vendor Ledger Entry".SETRANGE(Positive, FALSE);
                END ELSE BEGIN
                    "Vendor Ledger Entry".SETRANGE(Positive, TRUE);
                END;
                Filters := '';
                Filters := "Vendor Ledger Entry".GETFILTERS;

                CompanyInfo.GET;
                CompName1 := CompanyInfo.Name;
                CompName2 := CompanyInfo."Name 2";
            end;
        }
    }

    requestpage
    {

        layout
        {
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
        IF InvoiceApp = FALSE THEN
            ReportCaption := 'Vendor Invoice Wise Application Report'
        ELSE
            ReportCaption := 'Vendor Payment Wise Application Report';
    end;

    var
        InvoiceApp: Boolean;
        TAmt: Decimal;
        ExcelBuf: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        Vend: Record Vendor;
        "T.no.": Integer;
        State1: Record State;
        StateDesc: Text[100];
        CustNo: Text[250];
        IFinvoice: Boolean;
        CLE: Record "Vendor Ledger Entry";
        AMT: Decimal;
        PAMT: Decimal;
        DateFilter1: Text[1000];
        DateFilter2: Text[1000];
        CLE1: Record "Vendor Ledger Entry";
        TAMT2: Decimal;
        ONLYPayment: Boolean;
        "P.No": Integer;
        "S.No": Integer;
        IFPayment: Boolean;
        CLE3: Record "Vendor Ledger Entry";
        OrignalAmt: Decimal;
        CLE4: Record "Vendor Ledger Entry";
        CUST1: Record Vendor;
        StateDesc1: Text[100];
        OrignalAmt1: Decimal;
        CustNo1: Text[100];
        VendorLedger: Record "Vendor Ledger Entry";
        Closedamount: Decimal;
        RemaingAmt: Decimal;
        Doctype: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        CompanyInfo: Record "Company Information";
        CompName1: Text[100];
        CompName2: Text[100];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        TotalFor: Label 'Total for ';
        Text1007: Label 'Vendor Applied Payment Document Report';
        Text1001: Label 'For the Period';
        Text1000: Label 'Period: %1';
        Text1002: Label 'Data';
        Text1005: Label 'Company Name';
        Text1006: Label 'Report No.';
        Text1008: Label 'User ID';
        Text1009: Label 'Print Date';
        Text000: Label 'Document';
        Filters: Text[100];
        ReportCaption: Text[50];
}

