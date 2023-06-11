report 50065 "Customer - Ageing Due Date"
{
    // 
    // //-- Report Modified For Ageing As On Date
    // //-- 1. Tri27.0PG 16112006 PG -- New Code Added In "Cust. Ledger Entry - OnPreDataItem()"
    // 
    // //-- 2. Tri27.0PG 16112006 PG -- New Code Added In "Cust. Ledger Entry - OnAfterGetRecord()"
    // 
    // //-- 3. Tri27.0PG 16112006 PG -- New GLOBAL Variable Added "recDtldCustLedEnt" Record Type On Table "Detailed Cust. Ledg. Entry"
    // 
    // //-- Changes Done In Table No. 21 (Cust. Ledger Entry)
    // //-- 1. Tri27.0PG 16112006 PG -- New Key Created "Posting Date,Closed at Date" -- As on date Ageing Report
    // //TRI N.M - 06.12.07 - Code Added for Minimum amount calculation in Cust. Ledger Entry - OnAfterGetRecord().
    // //TRI DG Report on Due Date and Period changed
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\CustomerAgeingDueDate.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = SORTING("Salesperson Code")
                                ORDER(Ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Post Code", "Global Dimension 1 Code", "PCH Code";
            column(StartDate; StartDate)
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CustNameAndCity; Customer.Name + '' + ', ' + '' + Customer.City)
            {
            }
            column(CompName2; CompanyInfo."Name 2")
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(CustNo; Customer."No.")
            {
            }
            column(CustGlobDim1; Customer."Global Dimension 1 Code")
            {
            }
            column(SalesPersonCode; Customer."Salesperson Code")
            {
            }
            column(custName; Customer.Name)
            {
            }
            column(CustCity; Customer.City)
            {
            }
            column(CustStateCode; Customer."State Code")
            {
            }
            column(StateDes; Statedesription)
            {
            }
            column(Summary; Summary)
            {
            }
            column(StateDesc; Statedesription)
            {
            }
            column(ACP; Customer."ACP (Last 12m)")
            {
            }
            column(Balance_conf; Customer."Balance Confirmation")
            {
            }
            column(Balance_conf_date; Customer."Balance Conf Recd Date")
            {
            }
            column(Virtual; Customer."Virtual ID")
            {
            }
            dataitem("Cust. Ledger Entry"; 21)
            {
                CalcFields = "Original Amt. (LCY)", "Remaining Amt. (LCY)";
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.")
                                    ORDER(Ascending);
                RequestFilterFields = "Document Type";
                column(PostingDate_CustLedgerEntry; FORMAT("Cust. Ledger Entry"."Posting Date"))
                {
                }
                column(DocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(DocumentType_CustLedgerEntry; "Cust. Ledger Entry"."Document Type")
                {
                }
                column(PendingForm; PendingForm)
                {
                }
                column(OriginalAmtLCY_CustLedgerEntry; "Cust. Ledger Entry"."Original Amt. (LCY)")
                {
                }
                column(DueDAte; "Cust. Ledger Entry"."Due Date")
                {
                }
                column(Text7; Text[7])
                {
                }
                column(AmtD7; (AmtD[7]))
                {
                }
                column(Text1; Text[1])
                {
                }
                column(AmtD1; (AmtD[1]))
                {
                }
                column(Text2; Text[2])
                {
                }
                column(AmtD2; (AmtD[2]))
                {
                }
                column(Text3; Text[3])
                {
                }
                column(AmtD3; (AmtD[3]))
                {
                }
                column(Text4; Text[4])
                {
                }
                column(AmtD4; (AmtD[4]))
                {
                }
                column(Text5; Text[5])
                {
                }
                column(AmtD5; (AmtD[5]))
                {
                }
                column(Text6; Text[6])
                {
                }
                column(AmtD6; (AmtD[6]))
                {
                }
                column(AmtD8; (AmtD[8]))
                {
                }
                column(AmtD9; (AmtD[9]))
                {
                }
                column(AmtD10; (AmtD[10]))
                {
                }
                column(AmtD11; (AmtD[11]))
                {
                }
                column(AmtD12; (AmtD[12]))
                {
                }
                column(CustomerType; Customer."Customer Type")
                {
                }
                column(CreditLmitLcy; Customer."Credit Limit (LCY)")
                {
                }
                column(CustomerBlocked; FORMAT(Customer.Blocked))
                {
                }
                column(SecurityAmt; Customer."Security Amount")
                {
                }
                column(SalesPersonName; RecSalespersonPurchaser.Name)
                {
                }
                column(PCHCOde; RecSalespersonPurchaser2.Name)
                {
                }
                column(SPName; RecSalespersonPurchaser3.Name)
                {
                }
                column(PrivateSPName; RecSalespersonPurchaser4.Name)
                {
                }
                column(Dim1; Customer."Global Dimension 1 Code")
                {
                }
                column(CustAreaCode; Customer."Area Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF RecSalespersonPurchaser.GET(Customer."Salesperson Code") THEN;
                    IF RecSalespersonPurchaser2.GET(Customer."PCH Code") THEN;
                    IF RecSalespersonPurchaser3.GET(Customer."Govt. SP Resp.") THEN
                        IF RecSalespersonPurchaser4.GET(Customer."Private SP Resp.") THEN
                            FOR i := 1 TO 12 DO BEGIN   //Clear Varibales
                                CLEAR(Amt[i]);
                                CLEAR(AmtD[i]);
                            END;

                    CALCFIELDS("Remaining Amt. (LCY)", "Cust. Ledger Entry"."Original Amt. (LCY)");
                    IF ROUND("Remaining Amt. (LCY)", 0.01) = 0 THEN
                        CurrReport.SKIP;
                    Amt[1] := 0;
                    Amt[2] := 0;
                    Amt[3] := 0;
                    Amt[4] := 0;
                    Amt[5] := 0;
                    Amt[6] := 0;
                    Amt[7] := 0;
                    Amt[8] := 0;
                    Amt[9] := 0;
                    Amt[10] := 0;
                    Amt[11] := 0;
                    Amt[12] := 0;

                    IF ("Due Date" > StartDate + 7) THEN  //Notedue
                        Amt[1] := "Remaining Amt. (LCY)";
                    IF ("Due Date" <= StartDate + 7) AND ("Due Date" >= (StartDate + 1)) THEN  //Within -1 To -7  Days
                        Amt[2] := "Remaining Amt. (LCY)";

                    IF ("Due Date" <= StartDate) AND ("Due Date" >= (StartDate - 5)) THEN  //Within 0-5 Days
                        Amt[3] := "Remaining Amt. (LCY)";
                    IF ("Due Date" <= StartDate - 6) AND ("Due Date" >= (StartDate - 10)) THEN  //Within 6-10 Days
                        Amt[4] := "Remaining Amt. (LCY)";

                    IF ("Due Date" <= StartDate - 11) AND ("Due Date" >= (StartDate - 20)) THEN  //Within 11-20 Days
                        Amt[5] := "Remaining Amt. (LCY)";
                    IF ("Due Date" <= StartDate - 21) AND ("Due Date" >= (StartDate - 30)) THEN  //Within 21-30 Days
                        Amt[6] := "Remaining Amt. (LCY)";
                    IF ("Due Date" <= (StartDate - 31)) AND ("Due Date" >= (StartDate - 60)) THEN  //Between 31 Days to 60 Days
                        Amt[7] := "Remaining Amt. (LCY)";

                    IF ("Due Date" <= (StartDate - 61)) AND ("Due Date" >= (StartDate - 90)) THEN  //Between last 61 Days to 90 Days
                        Amt[8] := "Remaining Amt. (LCY)";
                    IF ("Due Date" <= (StartDate - 91)) AND ("Due Date" >= (StartDate - 180)) THEN  //Between last 91 Days to 180 Days
                        Amt[9] := "Remaining Amt. (LCY)";
                    IF ("Due Date" <= (StartDate - 181)) AND ("Due Date" >= (StartDate - 365)) THEN  //Between last 181 Days to 365 Days
                        Amt[10] := "Remaining Amt. (LCY)";
                    IF ("Due Date" <= (StartDate - 366)) THEN //Before 365 Days
                        Amt[11] := "Remaining Amt. (LCY)";

                    //FOR i := 1 TO 11 DO
                    //  Amt[12] += Amt[i];

                    //TRI N.M - 06.12.07 Start
                    IF MinimumAmt = TRUE THEN
                        IF (Amt[12] > 0) AND (AmountRestriction >= Amt[12]) THEN
                            CurrReport.SKIP
                        ELSE
                            IF (Amt[12] < 0) AND (AmountRestriction >= Amt[12]) THEN
                                CurrReport.SKIP;
                    //TRI N.M - 06.12.07 Stop


                    FOR i := 1 TO 12 DO
                        IF Amt[i] < 0 THEN
                            Text[i] := '-'
                        ELSE
                            Text[i] := ' ';
                    //  ELSE IF Amt[i] > 0 THEN
                    //    Text[i] := '+';

                    //TRI SB 010607 Add End

                    AmtD[12] := 0;
                    Amt[12] := 0;
                    FOR i := 1 TO 11 DO BEGIN
                        IF Amt[i] <> 0 THEN BEGIN
                            AmtD[i] := Amt[i];
                            AmtD[12] += Amt[i];
                        END ELSE BEGIN
                            AmtD[i] := 0;
                            //    Amtd[12]:=0;
                            // Amt[i]:=0;
                        END;


                    END;

                    /* 16630 PendingForm := '';
                    IF "Document Type" = "Document Type"::Invoice THEN
                        IF SalesInvoiceHeader.GET("Document No.") THEN
                            IF SalesInvoiceHeader."Form Code" <> '' THEN
                                IF SalesInvoiceHeader."Form No." = '' THEN
                                    PendingForm := SalesInvoiceHeader."Form No.";*/ // 16630
                end;

                trigger OnPreDataItem()
                begin
                    FOR i := 1 TO 12 DO
                        CurrReport.CREATETOTALS(Amt[i]);

                    SETFILTER("Cust. Ledger Entry"."Entry Skipped", '%1', FALSE);

                    //TRI SB 010607 Add Start
                    SETRANGE("Posting Date", 0D, StartDate);
                    //SETFILTER("Date Filter",'<=%1',StartDate);
                    //TRI SB 010607 Add End

                    CALCFIELDS("Remaining Amt. (LCY)");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF StateRec.GET(Customer."State Code") THEN;
                /*
                 //TMC::6823
                IF CurrReport.SHOWOUTPUT AND PrintToExcel   THEN
                BEGIN
                    CustNo := 'C'+FORMAT("No.");
                    ExcelBuf.AddColumn(CustNo,FALSE,'',TRUE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn(Name,FALSE,'',TRUE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn('City :'+City,FALSE,'',TRUE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn('Branch :'+ ' '+Customer."Global Dimension 1 Code",FALSE,'',TRUE,FALSE,FALSE,'');
                    ExcelBuf.AddColumn('PCH :'+ ' '+Customer."PCH Name",FALSE,'',TRUE,FALSE,FALSE,'');
                    ExcelBuf.NewRow;
                
                */

                IF State.GET("State Code") THEN
                    Statedesription := State.Description
                ELSE
                    Statedesription := '';

            end;

            trigger OnPreDataItem()
            begin
                //MSAK.BEGIN 010515
                UserLocation2.RESET;
                UserLocation2.SETRANGE("User ID", USERID);
                UserLocation2.SETRANGE("View Customer", TRUE);
                IF UserLocation2.FINDFIRST THEN BEGIN
                    UserLocation1.RESET;
                    UserLocation1.SETRANGE("User ID", USERID);
                    IF UserLocation1.ISEMPTY THEN BEGIN
                        IF GetPCHCode <> '' THEN
                            SETFILTER("PCH Code", GetPCHCode);
                    END ELSE BEGIN
                        IF GetLocations <> '' THEN
                            SETFILTER("Global Dimension 1 Code", GetLocations);
                    END;
                END;
                //MSAK.END 010515
                FOR i := 1 TO 12 DO
                    CurrReport.CREATETOTALS(Amt[i]);
                CurrReport.CREATETOTALS("Cust. Ledger Entry"."Original Amt. (LCY)");


                CompanyInfo.GET;
                CompanyName1 := CompanyInfo.Name;
                CompanyName2 := CompanyInfo."Name 2";
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

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        //ERROR('Please Retry');
        Summary := TRUE;
    end;

    trigger OnPostReport()
    begin
        /*
        //TMC::6823
        IF PrintToExcel THEN
          CreateExcelbook;
        RepAuditMgt.CreateAudit(50065)
        */

    end;

    trigger OnPreReport()
    begin
        //TRI SB 010607 Add Start
        IF StartDate = 0D THEN
            StartDate := WORKDATE;




        //TRI SB 010607 Add End

        /*
        //TMC::6832
        
        IF PrintToExcel THEN
          MakeExcelInfo;
        
        */

    end;

    var
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        StartDate: Date;
        CustFilter: Text[250];
        PeriodStartDate: array[6] of Date;
        CustBalanceDueLCY: array[5] of Decimal;
        PrintCust: Boolean;
        i: Integer;
        Amt: array[12] of Decimal;
        Text: array[12] of Text[2];
        AmtD: array[12] of Decimal;
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
        State: Record State;
        RecSalespersonPurchaser: Record "Salesperson/Purchaser";
        Cust: Record Customer;
        CompanyName2: Text[100];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        UserLocation1: Record "User Location";
        UserLocation2: Record "User Location";
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
        RecSalespersonPurchaser2: Record "Salesperson/Purchaser";
        RecSalespersonPurchaser3: Record "Salesperson/Purchaser";
        RecSalespersonPurchaser4: Record "Salesperson/Purchaser";
        StateRec: Record State;
        Statedesription: Text[50];

    procedure MakeExcelInfo()
    begin
        /*
        //TMC::6823
        ExcelBuf.SetUseInfoSheed;
        ExcelBuf.AddInfoColumn(FORMAT(Text005),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(COMPANYNAME,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn('Customer Aging (Due Date) Report',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(REPORT::"Customer - Ageing SP Wise Test",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text008),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(USERID,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text009),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(TODAY,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text011),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(Customer.GETFILTERS,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text012),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn("Cust. Ledger Entry".GETFILTERS,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.ClearNewRow;
        IF Summary THEN
         MakeExcelDataHeader2
        ELSE
         MakeExcelDataHeader;
        */

    end;

    local procedure MakeExcelDataHeader()
    begin
        /*
        //TMC::6823
        
        ExcelBuf.AddColumn('Posting date',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Document No.',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Document Type',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('State Code',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Orignal Amount',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Pending Amount',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Not Due',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('-1 To -7 Days',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('0 - 5 Days',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('6 - 10 Days',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('11 - 20 Days',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('21 - 30 Days',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('31 to 60 Days',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('61 to 90 Days',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('91 to 180 Days',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('181 to 365 Days',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('1 Years +',FALSE,'',TRUE,FALSE,TRUE,'');
        
        ExcelBuf.AddColumn('Customer Type',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Credit Limit ',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Status of Blocked',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('Security Of Amount',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('Salesperson Name',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('PCH Name',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Govt SP Name',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Private SP Name',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Branch Name',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Sales Territory',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.NewRow;
         */

    end;

    procedure CreateExcelbook()
    begin
        /*
        //TMC::6823
        ExcelBuf.CreateBook;
        ExcelBuf.CreateSheet(Text002,Text01,COMPANYNAME,USERID);
        ExcelBuf.GiveUserControl;
        ERROR('');
        */

    end;

    local procedure MakeExcelDataHeader2()
    begin
        /*
        //TMC::6823
        ExcelBuf.AddColumn('Customer No',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Customer Name',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('State Code',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Orignal Amount',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Pending Amount',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Not Due',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('-1 To -7 Days',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('0 - 5 Days',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('6 - 10 Days',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('11 - 20 Days',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('21 - 30 Days',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('31 to 60 Days',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('61 to 90 Days',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('91 to 180 Days',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('181 to 365 Days',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('1 Years +',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Customer Type',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Credit Limit',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Status of Blocked',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('Security Of Amount',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('Salesperson Name',FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn('PCH Name',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Govt SP Name',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Private SP Name',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Branch Name',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn('Sales Territory',FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.NewRow;
        */

    end;

    procedure GetLocations(): Text[800]
    var
        Loc: Text[800];
        UserLocation: Record "User Location";
    begin
        //MSBS.Rao Begin Dt. 01-08-12
        UserLocation.RESET;
        UserLocation.SETRANGE("User ID", USERID);
        UserLocation.SETFILTER("Create Sales Order", '%1', TRUE);
        IF UserLocation.FINDFIRST THEN BEGIN
            REPEAT
                IF Loc = '' THEN
                    Loc := UserLocation."Location Code"
                ELSE
                    Loc := Loc + '|' + UserLocation."Location Code";
            UNTIL UserLocation.NEXT = 0;
        END;
        EXIT(Loc);
        //MSBS.Rao End Dt. 01-08-12
    end;

    procedure GetPCHCode(): Text[800]
    var
        PCHCode: Text[800];
        UserStateSetup: Record "User State Setup";
    begin
        //MSAK.Begin 01-05-15
        UserStateSetup.RESET;
        UserStateSetup.SETRANGE("User ID", USERID);
        IF UserStateSetup.FINDFIRST THEN BEGIN
            REPEAT
                IF PCHCode = '' THEN
                    PCHCode := UserStateSetup."PCH Code"
                ELSE
                    PCHCode := PCHCode + '|' + UserStateSetup."PCH Code";
            UNTIL UserStateSetup.NEXT = 0;
        END;
        EXIT(PCHCode);
        //MSAK.End 01-05-15
    end;
}

