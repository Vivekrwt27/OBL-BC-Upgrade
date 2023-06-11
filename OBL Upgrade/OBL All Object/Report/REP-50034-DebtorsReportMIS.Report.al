report 50034 "Debtors Report MIS"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\DebtorsReportMIS.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = SORTING("Zonal Head", "Zonal Manager", "PCH Code", "Salesperson Code")
                                WHERE("Area Code" = FILTER(<> 'OBTB'));
            column(GblStartDate; FORMAT(GblStartDate))
            {
            }
            column(GBLEndDate; FORMAT(GBLEndDate))
            {
            }
            column(CustNo; Customer."No.")
            {
            }
            column(CustName; Customer.Name)
            {
            }
            column(OpenBal; OpenBal - CFormAmt)
            {
            }
            column(CFormAmt; CFormAmt)
            {
            }
            column(ZHBal; ZHBal / InLac)
            {
            }
            column(ZMBal; ZMBal / InLac)
            {
            }
            column(PCHBal; PCHBal / InLac)
            {
            }
            column(SPBal; SPBal / InLac)
            {
            }
            column(PCHCode; Customer."PCH Code")
            {
            }
            column(PCHName; GetSPName(Customer."PCH Code"))
            {
            }
            column(ZH; Customer."Zonal Head")
            {
            }
            column(ZhName; GetSPName(Customer."Zonal Head"))
            {
            }
            column(ZM; Customer."Zonal Manager")
            {
            }
            column(ZMName; GetSPName(Customer."Zonal Manager"))
            {
            }
            column(SpCode; Customer."Salesperson Code")
            {
            }
            column(SPName; GetSPName(Customer."Salesperson Code"))
            {
            }
            column(ClosBal; ClosBal)
            {
            }
            column(AreaCode; Customer."Area Code")
            {
            }
            column(CustType; Customer."Customer Type")
            {
            }
            column(Balance; Balance / InLac)
            {
            }
            column(CustSales; CustomerSales / InLac)
            {
            }
            column(DSO; DSO)
            {
            }
            column(PCHDSO; PCHDSO)
            {
            }
            column(PCHSales; PCHSales)
            {
            }
            column(SPDSO; SPDSO)
            {
            }
            column(ZHDSO; ZHDSO)
            {
            }
            column(ZMDSO; ZMDSO)
            {
            }
            dataitem(Integer; 2000000026)
            {
                column(BalanceNew; Bal)
                {
                }
                column(Detailed; Detailed)
                {
                }
                column(PostDate; CustAgeingMGT.Posting_Date)
                {
                }
                column(Amt; CustAgeingMGT.Sum_Amount / InLac)
                {
                }
                column(Day1; DueAmt[1])
                {
                }
                column(Day2; DueAmt[2])
                {
                }
                column(Day3; DueAmt[3])
                {
                }
                column(Day4; DueAmt[4])
                {
                }
                column(Day5; DueAmt[5])
                {
                }
                column(Day6; DueAmt[6])
                {
                }
                column(Day7; DueAmt[7])
                {
                }
                column(Day8; DueAmt[8])
                {
                }
                column(Day9; DueAmt[9])
                {
                }
                column(Day10; DueAmt[10])
                {
                }
                column(Day11; DueAmt[11])
                {
                }
                column(Day12; DueAmt[12])
                {
                }
                column(Day13; DueAmt[13])
                {
                }
                column(Day14; DueAmt[14])
                {
                }
                column(Day15; DueAmt[15])
                {
                }
                column(Day16; DueAmt[16])
                {
                }
                column(Day17; DueAmt[17])
                {
                }
                column(Day18; DueAmt[18])
                {
                }
                column(Day19; DueAmt[19])
                {
                }
                column(Day20; DueAmt[20])
                {
                }
                column(Day21; DueAmt[21])
                {
                }
                column(Day22; DueAmt[22])
                {
                }
                column(Day23; DueAmt[23])
                {
                }
                column(Day24; DueAmt[24])
                {
                }
                column(Day25; DueAmt[25])
                {
                }
                column(Day26; DueAmt[26])
                {
                }
                column(Day27; DueAmt[27])
                {
                }
                column(Day28; DueAmt[28])
                {
                }
                column(Day29; DueAmt[29])
                {
                }
                column(Day30; DueAmt[30])
                {
                }
                column(Day31; DueAmt[31])
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(DueAmt);
                    IF NOT CustAgeingMGT.READ THEN BEGIN
                        RecordNotFound := TRUE;
                        CurrReport.BREAK;
                    END;
                    //IF NOT FirstRecordNotExist THEN
                    FOR I := 1 TO 31 DO BEGIN
                        IF I = DATE2DMY(CustAgeingMGT.Due_Date, 1) THEN
                            DueAmt[I] := CustAgeingMGT.Sum_Remaining_Amt_LCY / InLac;
                    END;

                    //IF NOT RecordNotFound THEN
                    IF (CustCode = Customer."No.") THEN BEGIN
                        OpenBal := 0;
                        CFormAmt := 0;
                        //  Bal :=0;
                    END;

                    CustCode := Customer."No.";
                    //IF Customer.GET(CustAgeingMGT.No) THEN;
                end;

                trigger OnPreDataItem()
                begin
                    CLEAR(CustAgeingMGT);
                    CustAgeingMGT.SETFILTER(CustAgeingMGT.Due_Date, '%1..%2', GblStartDate, GBLEndDate);
                    CustAgeingMGT.SETRANGE(CustAgeingMGT.No, Customer."No.");
                    CustAgeingMGT.SETFILTER(CustAgeingMGT.Document_Type, '%1', DocTypeEnum::Invoice);
                    CustAgeingMGT.SETFILTER(CustAgeingMGT.Sum_Remaining_Amt_LCY, '<>%1', 0);
                    CustAgeingMGT.OPEN;
                end;
            }

            trigger OnAfterGetRecord()
            var
                SPPCHGoalSheetCalculation: Codeunit "SP  PCH Goal Sheet Calculation";
                CustBalance: Decimal;
            begin
                OpenBal := 0;
                ClosBal := 0;
                CFormAmt := 0;
                RecordNotFound := FALSE;
                Customer.CALCFIELDS(Balance);
                CustBalance := 0;
                // CustBalance := Customer.Balance;

                CustBalance := SPPCHGoalSheetCalculation.CalcActualBalance(Customer."No.", TODAY);
                IF CustBalance < 0 THEN
                    CustBalance := 1;
                //CurrReport.SKIP;
                CLEAR(OCCustAgeingMGT);

                OCCustAgeingMGT.SETFILTER(OCCustAgeingMGT.No, '%1', Customer."No.");
                OCCustAgeingMGT.SETFILTER(OCCustAgeingMGT.Due_Date, '%1..%2', 0D, GblStartDate - 1);
                OCCustAgeingMGT.OPEN;
                WHILE OCCustAgeingMGT.READ DO BEGIN
                    OpenBal += OCCustAgeingMGT.Sum_Remaining_Amt_LCY / InLac;
                    IF OCCustAgeingMGT.Not_Enclude_CFORM THEN
                        CFormAmt += OCCustAgeingMGT.Sum_Remaining_Amt_LCY / InLac;
                END;
                CLEAR(OCCustAgeingMGT);
                OCCustAgeingMGT.SETFILTER(OCCustAgeingMGT.No, '%1', Customer."No.");
                OCCustAgeingMGT.SETFILTER(OCCustAgeingMGT.Due_Date, '%1..%2', GBLEndDate + 1, 99990331D);
                OCCustAgeingMGT.OPEN;
                WHILE OCCustAgeingMGT.READ DO BEGIN
                    ClosBal += OCCustAgeingMGT.Sum_Remaining_Amt_LCY / InLac;
                END;

                IF Customer."PCH Code" <> PCHCode THEN BEGIN
                    PCHBal := 0;
                    PCHSales := 0;
                    PCHCode := Customer."PCH Code";
                    PCHDSO := 0;
                END;

                IF Customer."Zonal Head" <> ZHCode THEN BEGIN
                    ZHBal := 0;
                    ZHsales := 0;
                    ZHCode := Customer."Zonal Head";
                    ZHDSO := 0;
                END;

                IF Customer."Zonal Manager" <> ZMCode THEN BEGIN
                    ZMBal := 0;
                    ZMSales := 0;
                    ZMCode := Customer."Zonal Manager";
                    ZMDSO := 0;
                END;

                IF Customer."Salesperson Code" <> SPCode THEN BEGIN
                    SPBal := 0;
                    SPSales := 0;
                    SPCode := Customer."Salesperson Code";
                    SPDSO := 0;
                END;
                CustomerSales := Calculatesales(Customer."No.", TODAY - 91, TODAY - 1);

                DSO := CalculateDSO(CustBalance, CustomerSales, 90);

                IF CustBalance > 0 THEN BEGIN
                    Bal := CustBalance / InLac;
                    SPBal += CustBalance;
                    ZMBal += CustBalance;
                    ZHBal += CustBalance;
                    PCHBal += CustBalance;
                END;

                SPSales += CustomerSales;
                ZMSales += CustomerSales;
                ZHsales += CustomerSales;
                PCHSales += CustomerSales;
                //MESSAGE('%1--%2-%3',Customer."No.",PCHSales,PCHBal);
                //IF Customer.Balance <10 THEN
                //  CurrReport.SKIP;

                PCHDSO := CalculateDSO(PCHBal, PCHSales, 90);
                SPDSO := CalculateDSO(SPBal, SPSales, 90);
                ZHDSO := CalculateDSO(ZHBal, ZHsales, 90);
                ZMDSO := CalculateDSO(ZMBal, ZMSales, 90);
            end;

            trigger OnPreDataItem()
            begin
                IF GBLAreaCode <> '' THEN
                    SETFILTER(Customer."Area Code", '%1', GBLAreaCode);

                IF GBLPCHCode <> '' THEN
                    SETFILTER(Customer."PCH Code", '%1', GBLPCHCode);

                IF GBLSPCode <> '' THEN
                    SETFILTER(Customer."Salesperson Code", '%1', GBLSPCode);

                IF GBLZHCode <> '' THEN
                    SETFILTER(Customer."Zonal Head", '%1', GBLZHCode);

                IF GBLZMCode <> '' THEN
                    SETFILTER(Customer."Zonal Manager", '%1', GBLZMCode);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Start Date"; GblStartDate)
                {
                    ApplicationArea = All;
                }
                field("End Date"; GBLEndDate)
                {
                    ApplicationArea = All;
                }
                field("Zonal Head"; GBLZHCode)
                {
                    TableRelation = "Salesperson/Purchaser";
                    ApplicationArea = All;
                }
                field("Zonal Manager"; GBLZMCode)
                {
                    TableRelation = "Salesperson/Purchaser";
                    ApplicationArea = All;
                }
                field("PCH Code"; GBLPCHCode)
                {
                    TableRelation = "Salesperson/Purchaser";
                    ApplicationArea = All;
                }
                field("SP Code"; GBLSPCode)
                {
                    TableRelation = "Salesperson/Purchaser";
                    ApplicationArea = All;
                }
                field(Detailed; Detailed)
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
        //GblStartDate := 010119D;
        //GBLEndDate := 310119D;
        InLac := 100000;
        GblStartDate := TODAY();
        GBLEndDate := CALCDATE('CM', TODAY);
    end;

    trigger OnPostReport()
    begin
        CustAgeingMGT.CLOSE;
    end;

    var
        GblStartDate: Date;
        GBLEndDate: Date;
        GBLAreaCode: Code[20];
        GBLZHCode: Code[20];
        GBLZMCode: Code[20];
        GBLPCHCode: Code[20];
        GBLSPCode: Code[20];
        Detailed: Boolean;
        CustAgeingMGT: Query "Cust. Ageing MGT";
        OpenBal: Decimal;
        CustNo: Code[20];
        DueAmt: array[64] of Decimal;
        I: Integer;
        ClosBal: Decimal;
        OCCustAgeingMGT: Query "Cust. Ageing MGT";
        InLac: Decimal;
        CFormAmt: Decimal;
        FirstRecordNotExist: Boolean;
        ZHBal: Decimal;
        ZMBal: Decimal;
        PCHBal: Decimal;
        SPBal: Decimal;
        PCHCode: Code[10];
        ZMCode: Code[10];
        ZHCode: Code[10];
        SPCode: Code[10];
        CustCode: Code[20];
        Bal: Decimal;
        RecordNotFound: Boolean;
        DSO: Decimal;
        CustomerSales: Decimal;
        ZHsales: Decimal;
        ZMSales: Decimal;
        PCHSales: Decimal;
        SPSales: Decimal;
        PCHDSO: Decimal;
        SPDSO: Decimal;
        ZHDSO: Decimal;
        ZMDSO: Decimal;
        DocTypeEnum: Enum "Document Type Enum";

    procedure SetParameters(StartDate: Date; EndDate: Date; AreaCode: Code[20]; ZH: Code[20]; ZM: Code[20]; PCHCode: Code[20]; SPCode: Code[20]; Detail: Boolean)
    begin
        GblStartDate := StartDate;
        GBLEndDate := EndDate;
        GBLAreaCode := AreaCode;
        GBLZHCode := ZH;
        GBLZMCode := ZM;
        GBLPCHCode := PCHCode;
        GBLSPCode := SPCode;
        Detailed := Detail;
    end;

    local procedure GetStateName(StateCode: Code[10]): Text
    var
        State: Record State;
    begin
        IF State.GET(StateCode) THEN
            EXIT(State.Description);
    end;

    local procedure GetSPName(SPCode: Code[10]): Text
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
    begin
        IF SalespersonPurchaser.GET(SPCode) THEN
            EXIT(SalespersonPurchaser.Name);
    end;

    procedure Calculatesales(CustNo: Code[20]; StartDate: Date; EndDate: Date) SalesAmt: Decimal
    var
        SalesJournalData: Query "Sales Journal Data";
        SalesReturnJournalData: Query "Sales Return Journal Data";
        AmountToCustomer: Decimal;
    begin
        CLEAR(SalesJournalData);
        SalesJournalData.SETFILTER(CustomerNo, '%1', CustNo);

        SalesJournalData.SETFILTER(PostingDateFilter, '%1..%2', StartDate, EndDate);
        SalesJournalData.OPEN;
        WHILE SalesJournalData.READ DO BEGIN
            //  SalesAmt += SalesJournalData.AmountToCustomer;
        END;

        SalesReturnJournalData.SETFILTER(CustomerNo, '%1', CustNo);
        SalesReturnJournalData.SETFILTER(PostingDateFilter, '%1..%2', StartDate, EndDate);
        SalesReturnJournalData.OPEN;
        WHILE SalesReturnJournalData.READ DO BEGIN
            //   SalesAmt -= SalesReturnJournalData.AmountToCustomer;
        END;
    end;

    procedure CalculateDSO(OutstandingAmt: Decimal; SalesAmt: Decimal; salesNoOfDays: Decimal) DSO: Decimal
    begin
        IF SalesAmt <> 0 THEN
            DSO := OutstandingAmt / (SalesAmt) * salesNoOfDays;


        IF DSO < 0 THEN
            DSO := 99999;
    end;
}

