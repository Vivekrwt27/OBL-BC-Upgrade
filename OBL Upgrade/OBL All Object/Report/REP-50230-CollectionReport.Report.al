report 50230 "Collection Report"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\CollectionReport.rdl';

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = SORTING("PCH Code")
                                ORDER(Ascending);
            RequestFilterFields = "PCH Code";
            column(CompName; Compnfo.Name)
            {
            }
            column(CompName2; Compnfo."Name 2")
            {
            }
            column(FromDate; FORMAT(FromDate))
            {
            }
            column(ToDate; FORMAT(ToDate))
            {
            }
            column(Detail; Detail)
            {
            }
            column(PCHCode_Customer; Customer."PCH Code")
            {
            }
            column(PCHName_Customer; Customer."PCH Name")
            {
            }
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
            }
            column(Address_Customer; Customer.Address)
            {
            }
            column(City_Customer; Customer.City)
            {
            }
            column(StateDesc_Customer; Customer."State Desc.")
            {
            }
            column(CustType; Customer."Customer Type")
            {
            }
            column(CurrSaleAmt; CurrSaleAmt)
            {
            }
            column(Terrtory; Terrtory)
            {
            }
            column(CurrJVAmt; CurrJVAmt)
            {
            }
            column(CurrcreditAmt; CurrcreditAmt)
            {
            }
            column(CurrAmt1; CurrAmt[1])
            {
            }
            column(CurrAmt2; CurrAmt[2])
            {
            }
            column(CurrAmt3; CurrAmt[3])
            {
            }
            column(CurrAmt4; CurrAmt[4])
            {
            }
            column(SaleAmt; SaleAmt)
            {
            }
            column(creditAmt; creditAmt)
            {
            }
            column(JVAmt; JVAmt)
            {
            }
            column(PrevAmt1; PrevAmt[1])
            {
            }
            column(PrevAmt2; PrevAmt[2])
            {
            }
            column(PrevAmt3; PrevAmt[3])
            {
            }
            column(PrevAmt4; PrevAmt[4])
            {
            }
            column(TotalCurrAmt1; TotalCurrAmt[1])
            {
            }
            column(TotalCurrAmt2; TotalCurrAmt[2])
            {
            }
            column(TotalCurrAmt3; TotalCurrAmt[3])
            {
            }
            column(TotalPrevAmt1; TotalPrevAmt[1])
            {
            }
            column(TotalPrevAmt2; TotalPrevAmt[2])
            {
            }
            column(TotalPrevAmt3; TotalPrevAmt[3])
            {
            }
            dataitem("Detailed Cust. Ledg. Entry"; 379)
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = WHERE("Document Type" = FILTER('<>Invoice' & '<>Credit Memo' & <> ' '),
                                          "Entry Type" = FILTER("Initial Entry"));
                column(CustomerNo_DetailedCustLedgEntry; "Detailed Cust. Ledg. Entry"."Customer No.")
                {
                }
                column(PostingDate_DetailedCustLedgEntry; "Detailed Cust. Ledg. Entry"."Posting Date")
                {
                }
                column(DocumentType_DetailedCustLedgEntry; "Detailed Cust. Ledg. Entry"."Document Type")
                {
                }
                column(DocumentNo_DetailedCustLedgEntry; "Detailed Cust. Ledg. Entry"."Document No.")
                {
                }
                column(Amount_DetailedCustLedgEntry; AmountCustLEntry)
                {
                }
                column(Name; Name)
                {
                }
                column(City; City)
                {
                }
                column(State; State)
                {
                }
                column(BrachCode; BrachCode)
                {
                }
                column(Terrtory1; Terrtory)
                {
                }
                column(PCHName; PCHName)
                {
                }
                column(Address; Address)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF RecCust.GET("Detailed Cust. Ledg. Entry"."Customer No.") THEN BEGIN
                        Name := RecCust.Name;
                        City := RecCust.City;
                        State := RecCust."State Desc.";
                        BrachCode := RecCust."Global Dimension 1 Code";
                        Terrtory := RecCust."Area Code";
                        PCHName := RecCust."PCH Name";
                        Address := RecCust.Address;
                    END ELSE BEGIN
                        Name := '';
                        City := '';
                        State := '';
                        BrachCode := '';
                        Terrtory := '';
                        PCHName := '';
                        Address := '';
                    END;

                    AmountCustLEntry := 0;
                    IF "Detailed Cust. Ledg. Entry"."Document Type" = "Detailed Cust. Ledg. Entry"."Document Type"::Refund THEN
                        AmountCustLEntry := -("Detailed Cust. Ledg. Entry".Amount)
                    ELSE
                        AmountCustLEntry := "Detailed Cust. Ledg. Entry".Amount;
                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                SETFILTER("Date Filter", '%1..%2', FromDate, ToDate);

                CALCFIELDS("Payments (LCY)", Customer."Refunds (LCY)", "Sales (LCY)");
                CurrAmt[1] := "Payments (LCY)";
                CurrAmt[2] := "Refunds (LCY)";
                CurrAmt[3] := CurrAmt[1] - CurrAmt[2];
                CurrAmt[4] := "Sales (LCY)";
                SETFILTER("Date Filter", '%1..%2', PrevFromDate, PrevToDate);
                CALCFIELDS("Payments (LCY)", Customer."Refunds (LCY)", "Sales (LCY)");
                PrevAmt[1] := "Payments (LCY)";
                PrevAmt[2] := "Refunds (LCY)";
                PrevAmt[3] := PrevAmt[1] - PrevAmt[2];
                PrevAmt[4] := "Sales (LCY)";

                CurrSaleAmt := 0;
                CurrcreditAmt := 0;
                CurrJVAmt := 0;
                DetailedCustLedgEntry3.RESET;
                DetailedCustLedgEntry3.SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
                DetailedCustLedgEntry3.SETRANGE("Entry Type", DetailedCustLedgEntry3."Entry Type"::"Initial Entry");
                DetailedCustLedgEntry3.SETFILTER("Customer No.", '%1', "No.");
                IF DetailedCustLedgEntry3.FINDFIRST THEN BEGIN
                    REPEAT
                        CASE DetailedCustLedgEntry3."Document Type" OF
                            DetailedCustLedgEntry3."Document Type"::Invoice:
                                BEGIN
                                    CurrSaleAmt += DetailedCustLedgEntry3."Amount (LCY)";
                                    //TotalCurrSaleAmt+=DetailedCustLedgEntry3."Amount (LCY)";
                                END;
                            DetailedCustLedgEntry3."Document Type"::"Credit Memo":
                                BEGIN
                                    CurrcreditAmt += DetailedCustLedgEntry3."Amount (LCY)";
                                    // TotalCurrcreditAmt+=DetailedCustLedgEntry3."Amount (LCY)";
                                END;
                            DetailedCustLedgEntry3."Document Type"::" ":
                                BEGIN
                                    CurrJVAmt += DetailedCustLedgEntry3."Amount (LCY)";
                                    //TotalCurrJVAmt+=DetailedCustLedgEntry3."Amount (LCY)";
                                END;
                        END;
                    UNTIL DetailedCustLedgEntry3.NEXT = 0;
                    //MESSAGE('%1=%2=%3=%4',DetailedCustLedgEntry3."Posting Date",DetailedCustLedgEntry3."Customer No.",TotalCurrSaleAmt);
                END;

                SaleAmt := 0;
                creditAmt := 0;
                JVAmt := 0;
                DetailedCustLedgEntry2.RESET;
                DetailedCustLedgEntry2.SETFILTER("Posting Date", '%1..%2', PrevFromDate, PrevToDate);
                DetailedCustLedgEntry2.SETRANGE("Entry Type", DetailedCustLedgEntry2."Entry Type"::"Initial Entry");
                DetailedCustLedgEntry2.SETFILTER("Customer No.", '%1', "No.");
                IF DetailedCustLedgEntry2.FINDFIRST THEN BEGIN
                    REPEAT
                        CASE DetailedCustLedgEntry2."Document Type" OF
                            DetailedCustLedgEntry2."Document Type"::Invoice:
                                BEGIN
                                    SaleAmt += DetailedCustLedgEntry2."Amount (LCY)";
                                    //  TotalSaleAmt+=DetailedCustLedgEntry2."Amount (LCY)";
                                END;
                            DetailedCustLedgEntry2."Document Type"::"Credit Memo":
                                BEGIN
                                    creditAmt += DetailedCustLedgEntry2."Amount (LCY)";
                                    // TotalcreditAmt+=DetailedCustLedgEntry2."Amount (LCY)";
                                END;
                            DetailedCustLedgEntry2."Document Type"::" ":
                                BEGIN
                                    JVAmt += DetailedCustLedgEntry2."Amount (LCY)";
                                    //  TotalJVAmt+=DetailedCustLedgEntry2."Amount (LCY)";
                                END;
                        END;
                    UNTIL DetailedCustLedgEntry2.NEXT = 0;
                    //MESSAGE('%1=%2=%3=%4',DetailedCustLedgEntry2."Posting Date",DetailedCustLedgEntry2."Customer No.",CurrSaleAmt,TotalSaleAmt);
                END;

                IF Customer."PCH Code" <> PCHNo THEN BEGIN
                    TotalCurrAmt[1] := 0;
                    TotalCurrAmt[2] := 0;
                    TotalCurrAmt[3] := 0;
                    TotalPrevAmt[1] := 0;
                    TotalPrevAmt[2] := 0;
                    TotalPrevAmt[3] := 0;
                END;


                SETFILTER("Date Filter", '%1..%2', FromDate, ToDate);
                CALCFIELDS("Payments (LCY)", Customer."Refunds (LCY)");
                TotalCurrAmt[1] += "Payments (LCY)";
                TotalCurrAmt[2] += "Refunds (LCY)";
                TotalCurrAmt[3] := TotalCurrAmt[1] - TotalCurrAmt[2];
                TotalCurrAmt[4] += "Sales (LCY)";
                SETFILTER("Date Filter", '%1..%2', PrevFromDate, PrevToDate - 1);
                CALCFIELDS("Payments (LCY)", Customer."Refunds (LCY)");
                TotalPrevAmt[1] += "Payments (LCY)";
                TotalPrevAmt[2] += "Refunds (LCY)";
                TotalPrevAmt[3] := TotalPrevAmt[1] - TotalPrevAmt[2];
                TotalPrevAmt[4] += "Sales (LCY)";
                PCHNo := Customer."PCH Code";

                DetailedCustLedgEntry3.RESET;
                DetailedCustLedgEntry3.SETFILTER("Posting Date", '%1..%2', FromDate, ToDate);
                DetailedCustLedgEntry3.SETRANGE("Entry Type", DetailedCustLedgEntry3."Entry Type"::"Initial Entry");
                DetailedCustLedgEntry3.SETFILTER("Customer No.", '%1', "No.");
                IF DetailedCustLedgEntry3.FINDFIRST THEN BEGIN
                    REPEAT
                        CASE DetailedCustLedgEntry3."Document Type" OF
                            DetailedCustLedgEntry3."Document Type"::Invoice:
                                BEGIN
                                    // CurrSaleAmt+= DetailedCustLedgEntry3."Amount (LCY)";
                                    TotalCurrSaleAmt += DetailedCustLedgEntry3."Amount (LCY)";
                                END;
                            DetailedCustLedgEntry3."Document Type"::"Credit Memo":
                                BEGIN
                                    //  CurrcreditAmt += DetailedCustLedgEntry3."Amount (LCY)";
                                    TotalCurrcreditAmt += DetailedCustLedgEntry3."Amount (LCY)";
                                END;
                            DetailedCustLedgEntry3."Document Type"::" ":
                                BEGIN
                                    // CurrJVAmt += DetailedCustLedgEntry3."Amount (LCY)";
                                    TotalCurrJVAmt += DetailedCustLedgEntry3."Amount (LCY)";
                                END;
                        END;
                    UNTIL DetailedCustLedgEntry3.NEXT = 0;
                    //MESSAGE('%1=%2=%3=%4',DetailedCustLedgEntry3."Posting Date",DetailedCustLedgEntry3."Customer No.",TotalCurrSaleAmt);
                END;

                DetailedCustLedgEntry2.RESET;
                DetailedCustLedgEntry2.SETFILTER("Posting Date", '%1..%2', PrevFromDate, PrevToDate);
                DetailedCustLedgEntry2.SETRANGE("Entry Type", DetailedCustLedgEntry2."Entry Type"::"Initial Entry");
                DetailedCustLedgEntry2.SETFILTER("Customer No.", '%1', "No.");
                IF DetailedCustLedgEntry2.FINDFIRST THEN BEGIN
                    REPEAT
                        CASE DetailedCustLedgEntry2."Document Type" OF
                            DetailedCustLedgEntry2."Document Type"::Invoice:
                                BEGIN
                                    // SaleAmt+= DetailedCustLedgEntry2."Amount (LCY)";
                                    TotalSaleAmt += DetailedCustLedgEntry2."Amount (LCY)";
                                END;
                            DetailedCustLedgEntry2."Document Type"::"Credit Memo":
                                BEGIN
                                    //  creditAmt += DetailedCustLedgEntry2."Amount (LCY)";
                                    TotalcreditAmt += DetailedCustLedgEntry2."Amount (LCY)";
                                END;
                            DetailedCustLedgEntry2."Document Type"::" ":
                                BEGIN
                                    // JVAmt += DetailedCustLedgEntry2."Amount (LCY)";
                                    TotalJVAmt += DetailedCustLedgEntry2."Amount (LCY)";
                                END;
                        END;
                    UNTIL DetailedCustLedgEntry2.NEXT = 0;
                    //MESSAGE('%1=%2=%3=%4',DetailedCustLedgEntry2."Posting Date",DetailedCustLedgEntry2."Customer No.",CurrSaleAmt,TotalSaleAmt);
                END;
            end;

            trigger OnPreDataItem()
            begin
                Compnfo.GET();


                CurrAmt[1] := 0;
                CurrAmt[2] := 0;
                CurrAmt[3] := 0;
                PrevAmt[1] := 0;
                PrevAmt[2] := 0;
                PrevAmt[3] := 0;


                TotalCurrAmt[1] := 0;
                TotalCurrAmt[2] := 0;
                TotalCurrAmt[3] := 0;
                TotalPrevAmt[1] := 0;
                TotalPrevAmt[2] := 0;
                TotalPrevAmt[3] := 0;

                TotalCurrSaleAmt := 0;
                TotalCurrcreditAmt := 0;
                TotalCurrJVAmt := 0;
                TotalSaleAmt := 0;
                TotalcreditAmt := 0;
                TotalJVAmt := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Cont0000345)
                {
                    field("From Date"; FromDate)
                    {
                        ApplicationArea = All;
                    }
                    field("Period Length"; PeriodLength)
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            UpdateDates();
                        end;
                    }
                    field("Show Collection Details"; Detail)
                    {
                        ApplicationArea = All;
                    }
                    field("To Date"; ToDate)
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Prev. To Date "; PrevFromDate)
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Show Summary"; ShowSummary)
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

    var
        FromDate: Date;
        ToDate: Date;
        Lastdate: Date;
        PrevFromDate: Date;
        PrevToDate: Date;
        CurrAmt: array[4] of Decimal;
        PrevAmt: array[4] of Decimal;
        ExportToExcel: Boolean;
        ExcelBuff: Record "Excel Buffer" temporary;
        K: Integer;
        PeriodLength: DateFormula;
        PeriodLength2: DateFormula;
        TotalCurrAmt: array[4] of Decimal;
        TotalPrevAmt: array[4] of Decimal;
        ShowSummary: Boolean;
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        SaleAmt: Decimal;
        creditAmt: Decimal;
        JVAmt: Decimal;
        DetailedCustLedgEntry2: Record "Detailed Cust. Ledg. Entry";
        DetailedCustLedgEntry3: Record "Detailed Cust. Ledg. Entry";
        CurrSaleAmt: Decimal;
        CurrcreditAmt: Decimal;
        CurrJVAmt: Decimal;
        TotalCurrSaleAmt: Decimal;
        TotalCurrcreditAmt: Decimal;
        TotalCurrJVAmt: Decimal;
        TotalSaleAmt: Decimal;
        TotalcreditAmt: Decimal;
        TotalJVAmt: Decimal;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        CustomerFilter: Code[1000];
        J: Integer;
        Detail: Boolean;
        RecCust: Record Customer;
        Name: Text[70];
        City: Text[30];
        State: Text[30];
        BrachCode: Code[20];
        Terrtory: Code[20];
        PCHName: Text[100];
        Address: Text[150];
        Compnfo: Record "Company Information";
        CustomerRec: Record Customer;
        PCHNo: Code[20];
        AmountCustLEntry: Decimal;


    procedure ENTERCELL(ROWNO: Integer; COLUMNNO: Integer; CELLVALUE: Text[260]; BOLD: Boolean; UNDERLINE: Boolean)
    begin
        ExcelBuff.INIT();
        ExcelBuff.VALIDATE("Row No.", ROWNO);
        ExcelBuff.VALIDATE("Column No.", COLUMNNO);
        ExcelBuff."Cell Value as Text" := CELLVALUE;
        ExcelBuff.Formula := '';
        ExcelBuff.Bold := BOLD;
        ExcelBuff.Underline := UNDERLINE;
        ExcelBuff.INSERT;
    end;

    procedure UpdateDates()
    begin
        IF STRLEN(FORMAT(PeriodLength)) <> 0 THEN BEGIN
            EVALUATE(PeriodLength2, '-1D+' + FORMAT(PeriodLength));
            ToDate := CALCDATE(PeriodLength2, FromDate);

            PrevFromDate := CALCDATE('-1M', FromDate);
            PrevToDate := CALCDATE(PeriodLength, PrevFromDate);
        END;
    end;
}

