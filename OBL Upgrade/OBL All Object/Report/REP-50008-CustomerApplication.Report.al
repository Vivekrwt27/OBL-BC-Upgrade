report 50008 "Customer Application"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\CustomerApplication.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code");
            RequestFilterFields = "Customer No.", "Posting Date";
            column(InvoiceApp; InvoiceApp)
            {
            }
            column(Filters; Filters)
            {
            }
            column(CompName1; CompName1)
            {
            }
            column(CompName2; CompName2)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(TNO1; "T.no.")
            {
            }
            column(CustNo1; "Cust. Ledger Entry"."Customer No.")
            {
            }
            column(CustName1; Cust.Name)
            {
            }
            column(CustType1; Cust."Customer Type")
            {
            }
            column(CustCity1; Cust.City)
            {
            }
            column(SalesPersonDes1; Cust."Salesperson Description")
            {
            }
            column(StateDesc1; StateDesc)
            {
            }
            column(CusrDocType1; "Cust. Ledger Entry"."Document Type")
            {
            }
            column(CustDocNo1; "Cust. Ledger Entry"."Document No.")
            {
            }
            column(PosDate1; FORMAT("Cust. Ledger Entry"."Posting Date"))
            {
            }
            column(Amount1; ABS("Cust. Ledger Entry"."Original Amt. (LCY)"))
            {
            }
            column(RemAmt1; ABS("Cust. Ledger Entry"."Remaining Amt. (LCY)"))
            {
            }
            column(Check1; "Cust. Ledger Entry"."Cheque No.")
            {
            }
            column(PCHName1; Cust."PCH Name")
            {
            }
            column(pspname1; pspname)
            {
            }
            column(gspname1; gspname)
            {
            }
            column(Areacode; Cust."Area Code")
            {
            }
            dataitem("CustLedgAppl"; "Cust. Ledger Entry")
            {
                DataItemLink = "Closed by Entry No." = FIELD("Entry No.");
                DataItemTableView = SORTING("Closed by Entry No.", "Posting Date");
                column(DocTpe2; CustLedgAppl."Document Type")
                {
                }
                column(DocNo2; CustLedgAppl."Document No.")
                {
                }
                column(CheckNo2; CLE3."Cheque No.")
                {
                }
                column(PostDate2; FORMAT(CustLedgAppl."Posting Date"))
                {
                }
                column(CloseByAmt2; ABS(CustLedgAppl."Closed by Amount"))
                {
                }
                column(DaysLate; ABS("Cust. Ledger Entry"."Posting Date" - CustLedgAppl."Posting Date"))
                {
                }
                column(OriginalAmt2; OrignalAmt)
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

                    /* //TMC::6823
                    
                    IF PrintToExcel THEN
                     BEGIN
                        {ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');}
                        CustNo := 'C'+FORMAT("Cust. Ledger Entry"."Customer No.");
                        ExcelBuf.AddColumn("T.no.",FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(CustNo,FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(Cust.Name,FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(Cust."Customer Type",FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(Cust.City,FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(StateDesc,FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(Cust."Salesperson Description",FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(Cust."PCH Name",FALSE,'',FALSE,FALSE,FALSE,'');
                        IF saleperson.GET(Cust."Private SP Resp.") THEN
                           pspname := saleperson.Name;
                        ExcelBuf.AddColumn(pspname,FALSE,'',FALSE,FALSE,FALSE,'');
                        IF saleperson.GET(Cust."Govt. SP Resp.") THEN
                           gspname := saleperson.Name;
                        ExcelBuf.AddColumn(gspname,FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(Cust."Area Code",FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(FORMAT("Cust. Ledger Entry"."Document Type"),FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn("Cust. Ledger Entry"."Document No.",FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn("Cust. Ledger Entry"."Posting Date",FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(ROUND(ABS("Cust. Ledger Entry"."Original Amt. (LCY)"),0.001),FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(ROUND(ABS("Cust. Ledger Entry"."Remaining Amt. (LCY)"),0.001),FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(FORMAT(CustLedgAppl."Document Type"),FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(CustLedgAppl."Document No.",FALSE,'',FALSE,FALSE,FALSE,'');
                        Salestype :='';
                        IF sih.GET("Document No.") THEN
                           Salestype := FORMAT(sih."Sales Type");
                        ExcelBuf.AddColumn(Salestype,FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(CLE3."Cheque No.",FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(CustLedgAppl."Posting Date",FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(ABS("Cust. Ledger Entry"."Posting Date"-CustLedgAppl."Posting Date"),
                                            FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(ROUND(ABS("Closed by Amount"),0.001),FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(ROUND(ABS(OrignalAmt),0.001),FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.NewRow;
                     END;
                    
                    */

                end;
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = FILTER(1));
                column(Doctype3; Doctype)
                {
                }
                column(DocNo3; VendorLedger."Document No.")
                {
                }
                column(CheckNo3; CLE3."Cheque No.")
                {
                }
                column(PostDate3; FORMAT(VendorLedger."Posting Date"))
                {
                }
                column(DaysLate2; ABS("Cust. Ledger Entry"."Posting Date" - VendorLedger."Posting Date"))
                {
                }
                column(Closedamount3; ABS(Closedamount))
                {
                }
                column(OriginalAmt3; ABS(Closedamount))
                {
                }

                trigger OnAfterGetRecord()
                begin

                    IF VendorLedger.GET("Cust. Ledger Entry"."Closed by Entry No.") THEN BEGIN
                        VendorLedger.CALCFIELDS(Amount, "Remaining Amount");
                        Closedamount := "Cust. Ledger Entry"."Closed by Amount";
                        RemaingAmt := VendorLedger."Remaining Amount";
                        Doctype := VendorLedger."Document Type";
                    END;
                    IF Closedamount = 0 THEN
                        CurrReport.SKIP;

                    IF saleperson.GET(Cust."Private SP Resp.") THEN
                        pspname := saleperson.Name;
                    IF saleperson.GET(Cust."Govt. SP Resp.") THEN
                        gspname := saleperson.Name;


                    /* //TMC::6823
                    
                    
                    IF PrintToExcel THEN
                     BEGIN
                        {ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');}
                        CustNo := 'C'+FORMAT("Cust. Ledger Entry"."Customer No.");
                        ExcelBuf.AddColumn("T.no.",FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(CustNo,FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(Cust.Name,FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(Cust."Customer Type",FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(Cust.City,FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(StateDesc,FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(Cust."Salesperson Description",FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(Cust."PCH Name",FALSE,'',FALSE,FALSE,FALSE,'');
                        IF saleperson.GET(Cust."Private SP Resp.") THEN
                           pspname := saleperson.Name;
                        ExcelBuf.AddColumn(pspname,FALSE,'',FALSE,FALSE,FALSE,'');
                        IF saleperson.GET(Cust."Govt. SP Resp.") THEN
                           gspname := saleperson.Name;
                        ExcelBuf.AddColumn(gspname,FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(Cust."Area Code",FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(FORMAT("Cust. Ledger Entry"."Document Type"),FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn("Cust. Ledger Entry"."Document No.",FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn("Cust. Ledger Entry"."Posting Date",FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(ROUND(ABS("Cust. Ledger Entry"."Original Amt. (LCY)"),0.001),FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(ROUND(ABS("Cust. Ledger Entry"."Remaining Amt. (LCY)"),0.001),FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(FORMAT(Doctype),FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(VendorLedger."Document No.",FALSE,'',FALSE,FALSE,FALSE,'');
                        Salestype :='';
                        IF sih.GET(VendorLedger."Document No.") THEN
                           Salestype := FORMAT(sih."Sales Type");
                        ExcelBuf.AddColumn(Salestype,FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(CLE3."Cheque No.",FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(VendorLedger."Posting Date",FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(ABS("Cust. Ledger Entry"."Posting Date"-VendorLedger."Posting Date"),
                                            FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(ROUND(ABS(Closedamount),0.001),FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(ROUND(ABS(Closedamount),0.001),FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.AddColumn(ROUND(ABS(RemaingAmt),0.001),FALSE,'',FALSE,FALSE,FALSE,'');
                        ExcelBuf.NewRow;
                     END;
                    
                    */

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
                //CurrReport.SHOWOUTPUT(NOT(InvoiceApp)); //TMC::6823

                //CurrReport.SHOWOUTPUT(InvoiceApp); //TMC::6823

                CompName1 := CompanyInfo.Name;
                CompName2 := CompanyInfo."Name 2";


                "Cust. Ledger Entry".CALCFIELDS("Cust. Ledger Entry"."Original Amt. (LCY)", "Cust. Ledger Entry"."Remaining Amt. (LCY)");
                CustNo2 := "Customer No.";
                Execute := FALSE;
                IF CdCustCode <> "Customer No." THEN BEGIN
                    Execute := TRUE;
                    CdCustCode := "Customer No.";
                END;


                "T.no." += 1;
                IF Cust.GET("Cust. Ledger Entry"."Customer No.") THEN BEGIN
                    State1.RESET;
                    State1.SETRANGE(Code, Cust."State Code");
                    IF State1.FINDFIRST THEN BEGIN
                        StateDesc := State1.Description;
                    END;
                END;


                IF saleperson.GET(Cust."Private SP Resp.") THEN
                    pspname := saleperson.Name;
                IF saleperson.GET(Cust."Govt. SP Resp.") THEN
                    gspname := saleperson.Name;
            end;

            trigger OnPreDataItem()
            begin

                IF InvoiceApp THEN BEGIN
                    "Cust. Ledger Entry".SETRANGE(Positive, FALSE);
                END ELSE BEGIN
                    "Cust. Ledger Entry".SETRANGE(Positive, TRUE);
                END;

                CompanyInfo.GET;
                Filters := "Cust. Ledger Entry".GETFILTERS;
            end;
        }
        dataitem("Unapplied"; "Cust. Ledger Entry")
        {
            CalcFields = "Remaining Amount";
            DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code")
                                WHERE("Remaining Amount" = FILTER(<> 0),
                                      "Document Type" = FILTER('Payment|Refund'));
            column(TNo4; "T.no.")
            {
            }
            column(CustNo4; Unapplied."Customer No.")
            {
            }
            column(CustName3; Cust.Name)
            {
            }
            column(CustType4; Cust."Customer Type")
            {
            }
            column(CustCity4; Cust.City)
            {
            }
            column(StateDesc4; StateDesc)
            {
            }
            column(DocType4; Unapplied."Document Type")
            {
            }
            column(PostDate4; FORMAT(Unapplied."Posting Date"))
            {
            }
            column(OriginalAmtLCYAbS4; ABS(Unapplied."Original Amt. (LCY)"))
            {
            }
            column(Checkno; "Cust. Ledger Entry"."Cheque No.")
            {
            }
            column(DocNo; Unapplied."Document No.")
            {
            }
            column(RemAmtABS4; ABS("Remaining Amt. (LCY)"))
            {
            }
            column(CheckNo4; Unapplied."Cheque No.")
            {
            }
            column(pspname; pspname)
            {
            }
            column(gspname; gspname)
            {
            }
            column(StateDesc; StateDesc)
            {
            }
            column(SalespersonDes; Cust."Salesperson Description")
            {
            }
            column(PCHName; Cust."PCH Name")
            {
            }
            column(AreaCode4; Cust."Area Code")
            {
            }

            trigger OnAfterGetRecord()
            begin

                "T.no." += 1;
                IF Cust.GET("Customer No.") THEN BEGIN
                    State1.RESET;
                    State1.SETRANGE(Code, Cust."State Code");
                    IF State1.FINDFIRST THEN BEGIN
                        StateDesc := State1.Description;
                    END;
                END;
                CALCFIELDS("Original Amt. (LCY)", "Remaining Amt. (LCY)");
                IF saleperson.GET(Cust."Private SP Resp.") THEN
                    pspname := saleperson.Name;
                IF saleperson.GET(Cust."Govt. SP Resp.") THEN
                    gspname := saleperson.Name;

                /*//TEAM::6823
                IF ShowUnappliedEntries THEN BEGIN
                
                    CustNo := 'C'+FORMAT("Customer No.");
                    ExcelBuf.AddColumn("T.no.",FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn(CustNo,FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn(Cust.Name,FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn(Cust."Customer Type",FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn(Cust.City,FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn(StateDesc,FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn(Cust."Salesperson Description",FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn(Cust."PCH Name",FALSE,'',FALSE,FALSE,FALSE,'');
                    IF saleperson.GET(Cust."Private SP Resp.") THEN
                       pspname := saleperson.Name;
                    ExcelBuf.AddColumn(pspname,FALSE,'',FALSE,FALSE,FALSE,'');
                    IF saleperson.GET(Cust."Govt. SP Resp.") THEN
                       gspname := saleperson.Name;
                    ExcelBuf.AddColumn(gspname,FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn(Cust."Area Code",FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn(FORMAT("Document Type"),FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn("Document No.",FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn("Posting Date",FALSE,'',FALSE,FALSE,FALSE,'');
                
                    ExcelBuf.AddColumn(ROUND(ABS("Original Amt. (LCY)"),0.001),FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn(ROUND(ABS("Remaining Amt. (LCY)"),0.001),FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.NewRow;
                END;
                       */

            end;

            trigger OnPreDataItem()
            begin

                //SETRANGE("Customer No.",CdCustCode);
                //COPYFILTERS("Cust. Ledger Entry");
                //Execute :=FALSE;
                /*//TEAM::6823
                IF (ShowUnappliedEntries AND PrintToExcel) THEN BEGIN
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('Unapplied',FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn(FORMAT(''),FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                    ExcelBuf.NewRow;
                END;
                */

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
                    field("Payment Application"; InvoiceApp)
                    {
                        ApplicationArea = All;
                    }
                    field("Show Unapplied Entries"; ShowUnappliedEntries)
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

        IF PrintToExcel THEN
            CreateExcelbook;
        //RepAuditMgt.CreateAudit(50008)
    end;

    trigger OnPreReport()
    begin

        IF PrintToExcel THEN
            MakeExcelInfo;
    end;

    var
        InvoiceApp: Boolean;
        TAmt: Decimal;
        ExcelBuf: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        Cust: Record Customer;
        "T.no.": Integer;
        State1: Record State;
        StateDesc: Text[100];
        CustNo: Text[100];
        IFinvoice: Boolean;
        CLE: Record "Cust. Ledger Entry";
        AMT: Decimal;
        PAMT: Decimal;
        DateFilter1: Text[1000];
        DateFilter2: Text[1000];
        CLE1: Record "Cust. Ledger Entry";
        TAMT2: Decimal;
        ONLYPayment: Boolean;
        "P.No": Integer;
        "S.No": Integer;
        IFPayment: Boolean;
        CLE3: Record "Cust. Ledger Entry";
        OrignalAmt: Decimal;
        CLE4: Record "Cust. Ledger Entry";
        CUST1: Record Customer;
        StateDesc1: Text[100];
        OrignalAmt1: Decimal;
        CustNo1: Text[100];
        VendorLedger: Record "Cust. Ledger Entry";
        Closedamount: Decimal;
        RemaingAmt: Decimal;
        Doctype: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        CompanyInfo: Record "Company Information";
        CompName1: Text[100];
        CompName2: Text[100];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        sih: Record "Sales Invoice Header";
        Salestype: Text[10];
        saleperson: Record "Salesperson/Purchaser";
        gspname: Text[30];
        pspname: Text[30];
        SIHDOC: Code[20];
        ShowUnappliedEntries: Boolean;
        CustNo2: Code[20];
        Execute: Boolean;
        CdCustCode: Code[20];
        TotalFor: Label 'Total for ';
        Text1007: Label 'Customer Applied Payment Document Report';
        Text1001: Label 'For the Period';
        Text1000: Label 'Period: %1';
        Text1002: Label 'Data';
        Text1005: Label 'Company Name';
        Text1006: Label 'Report No.';
        Text1008: Label 'User ID';
        Text1009: Label 'Print Date';
        Text000: Label 'Document';
        Filters: Text[100];

    procedure MakeExcelInfo()
    begin
        //TRIRJ ORIENT1.01 05-09-08:Start
        /*//TEAM::6823
        ExcelBuf.SetUseInfoSheed;
        ExcelBuf.AddInfoColumn(COMPANYNAME,FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text1007),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        //ExcelBuf.AddInfoColumn(FORMAT(Text1001),FALSE,'',TRUE,FALSE,FALSE,'');
        //ExcelBuf.AddInfoColumn(FORMAT(StartDate) + '..' +FORMAT(Enddate),FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text1008),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(USERID,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text1009),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(TODAY,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Filters',FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn("Cust. Ledger Entry".GETFILTERS,FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;*/
        //TRIRJ ORIENT1.01 05-09-08:END

    end;

    local procedure MakeExcelDataHeader()
    begin
        //TRIRJ ORIENT1.01 05-09-08:Start
        /*ExcelBuf.AddColumn('S.No.',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Customer No.',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Customer Name',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Customer Type',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('City',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('State',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Sales Person Name',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('PCH Name',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Private Sales Person Name',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Govt Sales Person Name',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Territory',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Document Type',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Document No./Invoice No.',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Date',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Amount',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Remaining Amount',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Applied Document Type',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Applied Against Document No.',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Sales Type',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Cheque No.',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Posting Date',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Days Late',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Applied Amount',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Original Amount',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.NewRow;
        //TRIRJ ORIENT1.01 05-09-08:END
        */

    end;

    procedure CreateExcelbook()
    begin
        /*//TRIRJ ORIENT1.01 05-09-08:Start
        ExcelBuf.CreateBook;
        ExcelBuf.CreateSheet(Text1002,Text1001,COMPANYNAME,USERID);
        ExcelBuf.GiveUserControl;
        ERROR('');
        //TRIRJ ORIENT1.01 05-09-08:Start
        */

    end;
}

