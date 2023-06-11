report 50182 "Vendor Ledger"
{
    // 
    // //-------------------------------------------------------------------------------
    // //-- Multi Balancing Option Tri 18.1 (Pahul Gupta)
    // //-------------------------------------------------------------------------------
    // //-- 1. Tri18.1 PG 13112006
    // //-- Data Item ( Vendor Ledger Entry ) Table View Changed
    // //-- SORTING(Vendor No.,Year,Month,Posting Date) ORDER(Ascending)
    // 
    // //-- 2. Tri18.1 PG 13112006
    // //-- Data Item ( Vendor Ledger Entry ) Group Total Field Changed
    // //-- Vendor No.,Year,Month,Posting Date
    // 
    // 
    // //-- 3. Tri18.1 PG 13112006
    // //-- New Global Variable Added "Balance Option" Type Option ("Range,Day,Month,Year")
    // 
    // //-- 4. Tri18.1 PG 13112006
    // //-- Global Variable "Balance Option" Located on Request Form
    // 
    // 
    // //-- 5. Tri18.1 PG 13112006
    // //-- New Code Added In "Cust. Ledger Entry, GroupHeader (4) - OnPreSection()" Trigger
    // 
    // //-- 6. Tri18.1 PG 13112006
    // //-- New Code Added In "Cust. Ledger Entry, GroupFooter (6) - OnPreSection()" Trigger
    // //-------------------------------------------------------------------------------
    // //-- Changes Done In Table No. (25) "Vendor Ledger Entry"
    // //-------------------------------------------------------------------------------
    // //-------------------------------------------------------------------------------
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\VendorLedger.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("Company Information"; 79)
        {
            DataItemTableView = SORTING("Primary Key")
                                ORDER(Ascending);
            column(DateFilter; DateFilter)
            {
            }
            column(Name1; "Company Information".Name)
            {
            }
            column(Name2; "Company Information"."Name 2")
            {
            }
            column(Address; "Company Information".Address)
            {
            }
            column(Address2; "Company Information"."Address 2")
            {
            }
            column(FORMAT; FORMAT(TODAY, 0, 4))
            {
            }
            column(PAGENO; CurrReport.PAGENO)
            {
            }
        }
        dataitem("Cust. Ledger Entry"; 25)
        {
            DataItemTableView = SORTING("Vendor No.", Year, Month, "Posting Date")
                                ORDER(Ascending);
            RequestFilterFields = "Vendor No.", "Posting Date", "Global Dimension 1 Code";
            column(VendorNo; Customer."No.")
            {
            }
            column(VendorName; Customer.Name)
            {
            }
            column(VendorNo_CustLedgerEntry; "Cust. Ledger Entry"."Vendor No.")
            {
            }
            column(Vendor1; 'Vendor Detailed Ledger  for the period   ' + GETFILTER("Posting Date"))
            {
            }
            column(Custt; Customer.Name)
            {
            }
            column(City; Customer.City)
            {
            }
            column(OpDr1; OpDr)
            {
            }
            column(OpCr1; OpCr)
            {
            }
            column(PostingDate; FORMAT("Posting Date"))
            {
            }
            column(DocumentNo1; "Document No.")
            {
            }
            column(ExternalDocumentNo; "Cust. Ledger Entry"."External Document No.")
            {
            }
            column(Description; "Cust. Ledger Entry".Description)
            {
            }
            column(ChequeNo; Cheque_No)
            {
            }
            column(DebitAmountLCY; "Cust. Ledger Entry"."Debit Amount (LCY)")
            {
            }
            column(CreditAmountLCY; "Cust. Ledger Entry"."Credit Amount (LCY)")
            {
            }
            column(Description2; "Cust. Ledger Entry".Description2)
            {
            }
            column(TotalDr1; TotalDr)
            {
            }
            column(TotalCr1; TotalCr)
            {
            }
            column(DebitAmount; "Cust. Ledger Entry"."Debit Amount" - "Cust. Ledger Entry"."Credit Amount" + Opening)
            {
            }
            column(ClCr1; ClCr)
            {
            }
            column(ClDr1; ClDr)
            {
            }
            column(Opening1; "Cust. Ledger Entry"."Debit Amount" - "Cust. Ledger Entry"."Credit Amount" + Opening)
            {
            }
            column(BalanceCr1; BalanceCr)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Customer.GET("Cust. Ledger Entry"."Vendor No.") THEN;



                IF "Balance Option" = "Balance Option"::Day THEN BEGIN
                    /*  CurrReport.SHOWOUTPUT :=
                         CurrReport.TOTALSCAUSEDBY = "Cust. Ledger Entry".FIELDNO("Posting Date");*/ // 16630
                END
                ELSE
                    IF "Balance Option" = "Balance Option"::Month THEN BEGIN
                        /*  CurrReport.SHOWOUTPUT :=
                             CurrReport.TOTALSCAUSEDBY = "Cust. Ledger Entry".FIELDNO(Month);*/ // 16630
                    END
                    ELSE
                        IF "Balance Option" = "Balance Option"::Year THEN BEGIN
                            /*  CurrReport.SHOWOUTPUT :=
                                 CurrReport.TOTALSCAUSEDBY = "Cust. Ledger Entry".FIELDNO(Year);*/ // 16630
                        END
                        ELSE
                            IF "Balance Option" = "Balance Option"::Range THEN BEGIN
                                /*  CurrReport.SHOWOUTPUT :=
                                     CurrReport.TOTALSCAUSEDBY = "Cust. Ledger Entry".FIELDNO("Vendor No.");*/ // 16630
                            END;

                Customer.RESET;
                IF Customer.GET("Cust. Ledger Entry"."Vendor No.") THEN BEGIN
                    Cust := Customer.Name;
                    Customer.SETFILTER(Customer."Date Filter", '..%1', ("Cust. Ledger Entry"."Posting Date" - 1));
                    Customer.CALCFIELDS(Customer."Net Change", Customer."Net Change (LCY)");
                    //Opening:=Customer."Net Change";
                    Opening := Customer."Net Change (LCY)";
                END;
                OpCr := 0;
                OpDr := 0;
                IF Opening > 0 THEN OpCr := ABS(Opening) ELSE OpDr := ABS(Opening);
                //-- 5. Tri18.1 PG 13112006 -- Stop

                Check1.RESET;
                Check1.SETRANGE(Check1."Document No.", "Cust. Ledger Entry"."Document No.");
                Check1.SETFILTER(Check1."Cheque No.", '<>%1', '');
                IF Check1.FIND('-') THEN BEGIN
                    Cheque_No := Check1."Cheque No.";
                    "Cheque Date" := Check1."Cheque Date";
                END
                ELSE BEGIN
                    Cheque_No := '';
                    //      "Cheque Date":=format('');
                END;

                TotalDr := "Cust. Ledger Entry"."Debit Amount (LCY)" + OpDr;
                TotalCr := "Cust. Ledger Entry"."Credit Amount (LCY)" + OpCr;
                Balance := TotalDr - TotalCr;
                ClCr := 0;
                ClDr := 0;
                IF Balance > 0 THEN ClCr := ABS(Balance) ELSE ClDr := ABS(Balance);
                BalanceDr := TotalDr + ClDr;
                BalanceCr := TotalCr + ClCr;

                //-- 6. Tri18.1 PG 13112006 -- Stop
            end;

            trigger OnPreDataItem()
            begin

                LastFieldNo := FIELDNO("Vendor No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(group)
                {
                    field("Balance Option"; "Balance Option")
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

        //RepAuditMgt.CreateAudit(50182)
    end;

    trigger OnPreReport()
    begin

        //MSBS.Rao Begin
        IF Customer.Blocked <> 0 THEN
            ERROR('Report Cannot Be Generate When Vendor is Blocked');
        DateFilter := "Cust. Ledger Entry".GETFILTER("Posting Date");
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Bal: Decimal;
        Customer: Record Vendor;
        Cust: Text[100];
        Check1: Record "Bank Account Ledger Entry";
        Cheque_No: Code[10];
        "Cheque Date": Date;
        Opening: Decimal;
        "Balance Option": Option Range,Day,Month,Year;
        Balance: Decimal;
        OpCr: Decimal;
        OpDr: Decimal;
        ClCr: Decimal;
        ClDr: Decimal;
        BalanceCr: Decimal;
        BalanceDr: Decimal;
        TotalDr: Decimal;
        TotalCr: Decimal;
        "--MIPL--": Integer;
        ExportToExcel: Boolean;
        RowNo: Text[50];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        ReportAuditTrial1: Record "Vendor Requisition";
        TotalFor: Label 'Total for ';
        ExcelBuff: Record "Excel Buffer";
        DateFilter: Text[30];
}

