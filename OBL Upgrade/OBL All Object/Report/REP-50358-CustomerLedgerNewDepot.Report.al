report 50358 "Customer Ledger New (Depot)"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\CustomerLedgerNewDepot.rdl';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            DataItemTableView = SORTING("Primary Key")
                                ORDER(Ascending);
            column(Comp_Name; "Company Information".Name)
            {
            }
            column(TextAddress1; TextAddress1)
            {
            }
            column(TextAddress2; TextAddress2)
            {
            }
            column(TextCity; TextCity)
            {
            }
            column(TextPhone; TextPhone)
            {
            }
            column(TextCIN; TextCIN)
            {
            }
        }
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.";
            column(Name_Customer; Customer.Name)
            {
            }
            column(City_Customer; Customer.City)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Customer No.", Year, Month, "Posting Date")
                                    ORDER(Ascending)
                                    WHERE("Entry Skipped" = FILTER(false));
                RequestFilterFields = "Customer No.";
                column(NarrationText; NarrationText)
                {
                }
                column(CLE_PostingDate; FORMAT("Cust. Ledger Entry"."Posting Date"))
                {
                }
                column(CLE_DocumentNo; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(CLE_Description; "Cust. Ledger Entry".Description)
                {
                }
                column(CLE_Description2; "Cust. Ledger Entry".Description2)
                {
                }
                column(Cheque_No; Cheque_No)
                {
                }
                column(CLE_DebitAmount; "Cust. Ledger Entry"."Debit Amount")
                {
                }
                column(CLE_CreditAmount; "Cust. Ledger Entry"."Credit Amount")
                {
                }
                column(TotalDr; TotalDr)
                {
                }
                column(TotalCr; TotalCr)
                {
                }
                column(ClCr; ClCr)
                {
                }
                column(ClDr; ClDr)
                {
                }
                column(BalanceDr; BalanceDr)
                {
                }
                column(BalanceCr; BalanceCr)
                {
                }
                column(OpDr; OpDr)
                {
                }
                column(OpCr; OpCr)
                {
                }
                column(CLE_CustomerNo; "Cust. Ledger Entry"."Customer No.")
                {
                }
                column(DocumentNo_ExtDocNo; CONVERTSTR("Cust. Ledger Entry"."External Document No.", '\', '/'))
                {
                }
                column(Cust; Cust)
                {
                }
                column(Customer_City; Customer1.City)
                {
                }
                column(ExternalDocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."External Document No.")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    Customer1.RESET;
                    IF Customer1.GET("Cust. Ledger Entry"."Customer No.") THEN BEGIN
                        Cust := Customer1.Name;
                    END;

                    Customer1.GET("Customer No.");
                    Customer1.SETFILTER("Global Dimension 1 Code", GetLocations);

                    Customer1.TESTFIELD(Customer1."Blocked For Customer Ledger", FALSE);
                    Customer1.CALCFIELDS(Balance);
                    IF Customer1.Balance < 0 THEN
                        CurrReport.SKIP;



                    Customer1.RESET;
                    IF Customer1.GET("Cust. Ledger Entry"."Customer No.") THEN BEGIN
                        Cust := Customer1.Name;
                        Customer1.SETFILTER(Customer1."Date Filter", '..%1', ("Cust. Ledger Entry"."Posting Date" - 1));
                        Customer1.CALCFIELDS(Customer1."Net Change");
                        Customer1.CALCFIELDS(Customer1.Balance);
                        Opening := Customer1."Net Change";
                    END;

                    OpCr := 0;
                    OpDr := 0;
                    IF Opening < 0 THEN OpCr := ABS(Opening) ELSE OpDr := ABS(Opening);
                    //-- 5. Tri18.1 PG 13112006 -- Stop

                    Customer1.GET("Customer No.");

                    Check1.RESET;
                    Check1.SETRANGE(Check1."Document No.", "Cust. Ledger Entry"."Document No.");
                    Check1.SETRANGE(Check1."Transaction No.", "Cust. Ledger Entry"."Transaction No.");//TRI A.S 07.07.08
                    Check1.SETFILTER(Check1."Cheque No.", '<>%1', '');
                    IF Check1.FIND('-') THEN BEGIN
                        Cheque_No := Check1."Cheque No.";
                        "Cheque Date" := Check1."Cheque Date";
                    END
                    ELSE BEGIN
                        Cheque_No := '';
                        //      "Cheque Date":=format('');
                    END;



                    TotalDr := "Cust. Ledger Entry"."Debit Amount" + OpDr;
                    TotalCr := "Cust. Ledger Entry"."Credit Amount" + OpCr;

                    Balance := TotalDr - TotalCr;
                    ClCr := 0;
                    ClDr := 0;
                    IF Balance > 0 THEN ClCr := ABS(Balance) ELSE ClDr := ABS(Balance);
                    BalanceDr := TotalDr + ClDr;
                    BalanceCr := TotalCr + ClCr;
                    //-- 6. Tri18.1 PG 13112006 -- Stop
                    CLEAR(NarrationText);
                    PostNarrationRec.RESET;
                    PostNarrationRec.SETRANGE("Document No.", "Cust. Ledger Entry"."Document No.");
                    IF PostNarrationRec.FINDFIRST THEN
                        NarrationText := PostNarrationRec.Narration;
                end;

                trigger OnPreDataItem()
                begin

                    LastFieldNo := FIELDNO("Customer No.");

                    SETRANGE("Posting Date", StartDate, EndDate);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //MESSAGE('%1',Customer.Name);

                IF Customer."Customer Status" = Customer."Customer Status"::Closed THEN
                    ERROR('This Customer is Closed Please contact OBL Auth. Rep.');
            end;

            trigger OnPostDataItem()
            begin
                //MESSAGE('%1',Customer.Name);
            end;

            trigger OnPreDataItem()
            begin


                UserStateSetup.RESET;
                UserStateSetup.SETRANGE("User ID", USERID);
                IF NOT UserStateSetup.ISEMPTY THEN
                    IF GetStates <> '' THEN BEGIN
                        SETFILTER("State Code", GetStates);
                    END ELSE BEGIN
                        IF GetPCHCode <> '' THEN BEGIN
                            SETFILTER("PCH Code", GetPCHCode);
                        END;
                    END;

                //Kulbhushan Sharma Starts
                /*
                IF EndDate >= 310321D THEN
                  EndDate :=  300321D ;
                 */
                //Kulbhushan Sharma End
                SETRANGE("Date Filter", StartDate, EndDate);

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
                    field("Balance Option"; "Balance Option")
                    {
                        ApplicationArea = All;
                    }
                    field("Start Date"; StartDate)
                    {
                        ApplicationArea = All;
                    }
                    field("End Date"; EndDate)
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
        //RepAuditMgt.CreateAudit(50358)
    end;

    trigger OnPreReport()
    begin

        IF (USERID = UPPERCASE('DE021')) OR (USERID = UPPERCASE('BCLD021')) OR (USERID = UPPERCASE('DE022')) OR (USERID = UPPERCASE('BCLD018'))
          OR (USERID = UPPERCASE('DE015')) OR (USERID = UPPERCASE('BCLD008')) THEN
            ERROR('You are not allowed');

        IF COMPANYNAME = 'Orient Bell Limited' THEN
            CompanyName1 := 'Orient Bell Limited';
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Bal: Decimal;
        RecCustomer: Record Customer;
        Cust: Text[200];
        Check1: Record "Bank Account Ledger Entry";
        Cheque_No: Code[10];
        "Cheque Date": Date;
        CLE: Record "Cust. Ledger Entry";
        Opening: Decimal;
        "Balance Option": Option Range,Day,Month,Year;
        CRDRText: Text[2];
        Balance: Decimal;
        OpCr: Decimal;
        OpDr: Decimal;
        ClCr: Decimal;
        ClDr: Decimal;
        BalanceCr: Decimal;
        BalanceDr: Decimal;
        TotalDr: Decimal;
        TotalCr: Decimal;
        CustShow: Boolean;
        CustBalance: Decimal;
        VarLocation: Code[20];
        StateCode1: Code[10];
        RecUserLocation: Record "User Location";
        Location: Record Location;
        UserLocation: Record "User Location";
        UserStateSetup: Record "User State Setup";
        StartDate: Date;
        EndDate: Date;
        CompanyName1: Text[50];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        UserLocation1: Record "User Location";
        TotalFor: Label 'Total for ';
        TextAddress1: Label 'Regd. office:  8 Ind Area Sikandrabad';
        TextAddress2: Label 'Distt. Bulandshahr (UP)';
        TextCity: Label '  SIKANDRABAD';
        TextPhone: Label '  Phone: 28521206  Fax: 28521273';
        TextCIN: Label ' CIN No. L14101UP1977PLC021546';
        Customer1: Record Customer;
        PostNarrationRec: Record "Posted Narration";
        NarrationText: Text[100];

    procedure GetLocations(): Text[800]
    var
        Loc: Text[800];
    begin
        //MSBS.Rao Begin Dt. 01-08-12
        UserLocation.RESET;
        UserLocation.SETRANGE("User ID", USERID);
        UserLocation.SETFILTER("Create Sales Blanket Order", '%1', TRUE);
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

