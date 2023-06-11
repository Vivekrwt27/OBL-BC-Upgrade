report 50353 "Customer - Ageing (Depot)"
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
    // TRIRJ ORIENT5.0 01-11-08:Added code for the export to excel
    // TRI DG More Periods Added in the report
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\CustomerAgeingDepot.rdl';


    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("Salesperson Code")
                                ORDER(Ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(Summary; Summary)
            {
            }
            column(STRSUBSTNO; STRSUBSTNO(Text001, FORMAT(StartDate)))
            {
            }
            column(CompanyName1; CompanyName1)
            {
            }
            column(Customer_TableCaption; Customer.TABLECAPTION)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(Customer_No; Customer."No.")
            {
            }
            column(Customer_Name; Customer.Name)
            {
            }
            column(Customer_City; Customer.City)
            {
            }
            column(Customer_CreditLimitLCY; Customer."Credit Limit (LCY)")
            {
            }
            column(Customer_StateCode; Customer."State Code")
            {
            }
            column(Customer_SalespersonDescription; Customer."Salesperson Description")
            {
            }
            column(Customer_SalespersonCode; Customer."Salesperson Code")
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.")
                                    ORDER(Ascending)
                                    WHERE("Entry Skipped" = FILTER(false));
                column(CLE_PostingDate; "Cust. Ledger Entry"."Posting Date")
                {
                }
                column(CLE_DocumentNo; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(CLE_DocumentType; FORMAT("Cust. Ledger Entry"."Document Type"))
                {
                }
                column(Text8; Text[8])
                {
                }
                column(Amd11; (AmtD[11]))
                {
                }
                column(Text1; Text[1])
                {
                }
                column(Amd1; ABS(AmtD[1]))
                {
                }
                column(Text2; Text[2])
                {
                }
                column(Amd2; ABS(AmtD[2]))
                {
                }
                column(Text3; Text[3])
                {
                }
                column(Amd3; ABS(AmtD[3]))
                {
                }
                column(Text4; Text[4])
                {
                }
                column(Amd4; ABS(AmtD[4]))
                {
                }
                column(Text5; Text[5])
                {
                }
                column(Amd5; ABS(AmtD[5]))
                {
                }
                column(Text6; Text[6])
                {
                }
                column(Amd6; ABS(AmtD[6]))
                {
                }
                column(Text7; Text[7])
                {
                }
                column(Amd7; ABS(AmtD[7]))
                {
                }
                column(Amd8; ABS(AmtD[8]))
                {
                }
                column(Amd9; ABS(AmtD[9]))
                {
                }
                column(Amd10; ABS(AmtD[10]))
                {
                }
                column(CLE_RemainingAmountLCY; "Cust. Ledger Entry"."Remaining Amt. (LCY)")
                {
                }
                column(SalesPerName; SalePurch.Name)
                {
                }
                column(CustType; Customer."Customer Type")
                {
                }
                column(PendingForm; PendingForm)
                {
                }

                trigger OnAfterGetRecord()
                begin


                    IF SalePurch.GET(RecCustomer."Salesperson Code") THEN;

                    //TRI SB 010607 Add Start
                    FOR i := 1 TO 11 DO BEGIN   //Clear Varibales
                        CLEAR(Amt[i]);
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
                    IF ("Posting Date" <= (StartDate - 90)) AND ("Posting Date" > (StartDate - 180)) THEN  //Between last 91 Days to 180 Days
                        Amt[6] := "Remaining Amt. (LCY)";
                    IF ("Posting Date" <= (StartDate - 180)) AND ("Posting Date" > (StartDate - 365)) THEN  //Between last 181 Days to 365 Days
                        Amt[7] := "Remaining Amt. (LCY)";
                    IF ("Posting Date" <= (StartDate - 365)) AND ("Posting Date" > (StartDate - 730))  //Between 1 to 2 yrs
                    THEN
                        Amt[8] := "Remaining Amt. (LCY)";
                    IF ("Posting Date" <= (StartDate - 730)) AND ("Posting Date" > (StartDate - 1095))  //Between 2 to 3 yrs
                    THEN
                        Amt[9] := "Remaining Amt. (LCY)";

                    IF "Posting Date" <= (StartDate - 1095)
                    THEN  //Before 365 Days
                        Amt[10] := "Remaining Amt. (LCY)";

                    FOR i := 1 TO 10 DO
                        Amt[11] := Amt[11] + Amt[i];


                    //TRI N.M - 06.12.07 Start
                    IF MinimumAmt = TRUE THEN
                        IF (Amt[11] > 0) AND (AmountRestriction >= Amt[11]) THEN
                            CurrReport.SKIP
                        ELSE
                            IF (Amt[11] < 0) AND (AmountRestriction >= Amt[11]) THEN
                                CurrReport.SKIP;
                    //TRI N.M - 06.12.07 Stop


                    FOR i := 1 TO 11 DO
                        IF Amt[i] < 0 THEN
                            Text[i] := '-'
                        ELSE
                            Text[i] := ' ';
                    //  ELSE IF Amt[i] > 0 THEN
                    //    Text[i] := '+';

                    //TRI SB 010607 Add End
                    FOR i := 1 TO 11 DO
                        //  AmtD[i] := ABS(Amt[i]); //VS
                        AmtD[i] := Amt[i];
                    PendingForm := '';

                    IF "Document Type" = "Document Type"::Invoice THEN
                        IF SalesInvoiceHeader.GET("Document No.") THEN
                            /*  IF SalesInvoiceHeader."Form Code" <> '' THEN//16225 filed N/F
                                IF SalesInvoiceHeader."Form No." <> '' THEN//16225 filed N/F
                                  PendingForm := SalesInvoiceHeader."Form No.";*///16225 filed N/F



                            //************If SUMMARY TRUE****************
                            IF (Summary = TRUE) THEN BEGIN
                                FOR i := 1 TO 11 DO
                                    IF Amt[i] < 0 THEN
                                        Text[i] := '-'
                                    ELSE             // TRI LM  IF Amt[i] = 0 THEN
                                        Text[i] := '';
                                //TRI LM  ELSE IF Amt[i] > 0 THEN
                                //TRI LM    Text[i] := '+';
                                FOR i := 1 TO 11 DO
                                    AmtD[i] := Amt[i];
                            END;

                    //********** If SUMMARY FALSE*************
                    IF (Summary = FALSE) THEN BEGIN
                        FOR i := 1 TO 11 DO
                            IF Amt[i] < 0 THEN
                                Text[i] := '-'
                            ELSE                     //TRI LM  IF Amt[i] = 0 THEN
                                Text[i] := '';
                        //TRI LM  ELSE IF Amt[i] > 0 THEN
                        //TRI LM    Text[i] := '+';

                        FOR i := 1 TO 11 DO
                            AmtD[i] := Amt[i];
                    END;

                    //*********************************************
                    FOR i := 1 TO 11 DO
                        IF Amt[i] < 0 THEN
                            Text[i] := '-'
                        ELSE                //TRI LM  IF Amt[i] = 0 THEN
                            Text[i] := '';
                    //TRI LM  ELSE IF Amt[i] > 0 THEN
                    //TRI LM    Text[i] := '+';

                    FOR i := 1 TO 11 DO
                        AmtD[i] := Amt[i];
                end;

                trigger OnPreDataItem()
                begin


                    //TRI SB 010607 Add Start
                    SETRANGE("Posting Date", 0D, StartDate);
                    SETFILTER("Date Filter", '<=%1', StartDate);
                    //TRI SB 010607 Add End
                    SETFILTER("Cust. Ledger Entry"."Entry Skipped", '%1', FALSE);


                    //********** If SUMMARY FALSE*************
                end;
            }

            trigger OnAfterGetRecord()
            begin

                //If "Location Code" <> VarLocation Then
                //CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            begin

                CompanyInfo.GET;
                CompanyName1 := CompanyInfo.Name;

                //RecLocation.GET(RecUserLocation."Location Code");
                //MSBS.Rao Begin Dt. 01-08-12
                //MSAK.BEGIN 300415
                UserLocation1.RESET;
                UserLocation1.SETRANGE("User ID", USERID);
                IF UserLocation1.ISEMPTY THEN BEGIN
                    IF GetPCHCode <> '' THEN
                        SETFILTER("PCH Code", GetPCHCode);
                END ELSE BEGIN
                    //MSAK.END 300415
                    IF GetLocations <> '' THEN
                        SETFILTER("Global Dimension 1 Code", GetLocations);
                END;
                //MSAK.BEGIN 300415
                /*
                ELSE IF GetStates <> '' THEN
                  SETFILTER("State Code",GetStates);
                */
                //MSAK.END 300415
                //MSBS.Rao End Dt. 01-08-12

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Aged As Of"; StartDate)
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
        //RepAuditMgt.CreateAudit(50353)
    end;

    trigger OnPreReport()
    begin

        //IF VarLocation = '' THEN
        //ERROR('Please Select Location Code');

        //TRI SB 010607 Add Start
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
        SalePurch: Record "Salesperson/Purchaser";
        RecCustomer: Record Customer;
        RecUserLocation: Record "User Location";
        VarLocation: Code[10];
        RecLocation: Record Location;
        VarState: Code[20];
        Location: Record Location;
        StateCode: Code[10];
        UserLocation: Record "User Location";
        UserStateSetup: Record "User State Setup";
        RepAuditMgt: Codeunit "Auto PDF Generate";
        UserLocation1: Record "User Location";
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
        Text013: Label 'Please select correct State Code of Location %1.';
        Customer1: Record Customer;


    procedure GetLocations(): Text[800]
    var
        Loc: Text[800];
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

    procedure GetStates(): Text[800]
    var
        StateCode: Text[800];
    begin
        //MSBS.Rao Begin Dt. 01-08-12
        UserStateSetup.RESET;
        UserStateSetup.SETRANGE("User ID", USERID);
        IF UserStateSetup.FINDFIRST THEN BEGIN
            REPEAT
                IF StateCode = '' THEN
                    StateCode := UserStateSetup.State
                ELSE
                    StateCode := StateCode + '|' + UserStateSetup.State;
            UNTIL UserStateSetup.NEXT = 0;
        END;
        EXIT(StateCode);
        //MSBS.Rao End Dt. 01-08-12
    end;

    procedure GetPCHCode(): Text[800]
    var
        PCHCode: Text[800];
    begin
        //MSAK.Begin 30-04-15
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
        //MSAK.End 30-04-15
    end;
}

