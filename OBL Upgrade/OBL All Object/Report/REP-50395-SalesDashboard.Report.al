report 50395 "Sales Dashboard"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\SalesDashboard.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "State Code";
            column(CformPendingAmt; cformAMT / 100000)
            {
            }
            column(CustomerType_Customer; "Customer Type")
            {
            }
            column(BalanceLCY_Customer; "Balance (LCY)" / 100000)
            {
            }
            column(Balance_Customer; Balance / 100000)
            {
            }
            column(SalesLCY_Customer; "Sales (LCY)")
            {
            }
            column(CreditLimitLCY_Customer; "Credit Limit (LCY)" / 100000)
            {
            }
            column(City_Customer; City)
            {
            }
            column(No_Customer; "No.")
            {
            }
            column(Name_Customer; Name)
            {
            }
            column(Value; Value)
            {
            }
            column(OustandingDays; OustDays)
            {
            }
            column(SalesValue; SalesValue / 100000)
            {
            }
            column(OverDueDy; OverDueDy)
            {
            }
            column(OverDueAmt; OverDueAmt / 100000)
            {
            }
            column(MonthValue; MonthValue / 100000)
            {
            }
            column(TODAY; TODAY)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CformRec.RESET;
                GLSetup.RESET;
                ExAmount := 0;
                ExAmount1 := 0;
                Value := 0;
                Value1 := 0;
                SalesValue := 0;
                InvDisc1 := 0;
                InsDisc := 0;
                MonthValue := 0;
                GLSetup.GET;

                //Del_Gur_Far_Sale:=0;
                //Chennai_Sales:=0;
                PanInd_Sales := 0;
                cformAMT := 0;
                IF Customer."No." = '' THEN
                    CurrReport.SKIP;
                CALCFIELDS("Balance (LCY)");

                //IF CformRec.GET("No.") THEN;
                //CformRec.SETRANGE("Customer No.","No.");
                CformRec.SETRANGE("C Form No.", '');
                IF CformRec.FINDFIRST THEN
                    REPEAT
                        IF CformRec."Customer No." = "No." THEN BEGIN
                            cformAMT += CformRec."C-Form Pending Amt";

                            IF Customer.City IN ['Delhi', 'Gurgaon', 'Faridabad'] THEN
                                CformNCR += CformRec."C-Form Pending Amt";

                            IF Customer.City = 'Chennai' THEN
                                CformChennai += CformRec."C-Form Pending Amt";
                        END;
                        PANCForm += CformRec."C-Form Pending Amt";
                    UNTIL CformRec.NEXT = 0;



                SalesInvHeader.RESET;
                SalesInvHeader.SETCURRENTKEY("Sell-to Customer No.", "Posting Date");
                SalesInvHeader.SETRANGE("Sell-to Customer No.", "No.");
                SalesInvHeader.SETFILTER("Posting Date", '%1..%2', FiscalStartDate, TODAY);
                IF SalesInvHeader.FINDFIRST THEN BEGIN
                    REPEAT
                        SalesLineAmt := 0;
                        SaleInvLine.RESET;
                        SaleInvLine.SETCURRENTKEY("Sell-to Customer No.", Type, "Document No.");
                        SaleInvLine.SETRANGE("Sell-to Customer No.", "No.");
                        SaleInvLine.SETRANGE(SaleInvLine.Type, SaleInvLine.Type::Item);
                        SaleInvLine.SETRANGE("Document No.", SalesInvHeader."No.");
                        SaleInvLine.SETFILTER(SaleInvLine.Quantity, '<>%1', 0);
                        SaleInvLine.SETFILTER(SaleInvLine."No.", '<>%1', '');
                        SaleInvLine.SETFILTER("Posting Date", '%1', SalesInvHeader."Posting Date");
                        IF SaleInvLine.FINDFIRST THEN
                            REPEAT
                                InvDisc1 := 0;
                                Value := (SaleInvLine.Quantity * SaleInvLine."Unit Price")//16225 Remove Code + SaleInvLine."Excise Amount"
                                          - (SaleInvLine."Discount Amt 1" + SaleInvLine."Discount Amt 2" + SaleInvLine."Discount Amt 3" + SaleInvLine."Discount Amt 4" + SaleInvLine."Quantity Discount Amount");
                                //16225 table N/F start
                                /* PostedStrOrderLineDetails.RESET;
                                 PostedStrOrderLineDetails.SETCURRENTKEY(Type, "Document Type", "Invoice No.", "Tax/Charge Type", "Tax/Charge Group");
                                 PostedStrOrderLineDetails.SETRANGE(Type, PostedStrOrderLineDetails.Type::Sale);
                                 PostedStrOrderLineDetails.SETRANGE("Document Type", PostedStrOrderLineDetails."Document Type"::Invoice);
                                 PostedStrOrderLineDetails.SETRANGE("Invoice No.", SaleInvLine."Document No.");
                                 PostedStrOrderLineDetails.SETRANGE("Line No.", SaleInvLine."Line No.");
                                 IF PostedStrOrderLineDetails.FIND('-') THEN
                                     REPEAT
                                         CASE PostedStrOrderLineDetails."Tax/Charge Type" OF
                                             PostedStrOrderLineDetails."Tax/Charge Type"::Charges:
                                                 BEGIN
                                                     IF PostedStrOrderLineDetails."Tax/Charge Group" = GLSetup."Discount Charge" THEN
                                                         IF PostedStrOrderLineDetails.Amount < 0 THEN
                                                             InvDisc1 := InvDisc1 + ABS(PostedStrOrderLineDetails.Amount)
                                                         ELSE
                                                             InvDisc1 := InvDisc1 + -PostedStrOrderLineDetails.Amount;

                                                     IF PostedStrOrderLineDetails."Tax/Charge Group" = GLSetup.AddInsuranceDisc THEN
                                                         IF PostedStrOrderLineDetails.Amount < 0 THEN
                                                             InsDisc := InsDisc + ABS(PostedStrOrderLineDetails.Amount)
                                                         ELSE
                                                             InsDisc := InsDisc + PostedStrOrderLineDetails.Amount;
                                                 END;
                                         END;
                                     UNTIL PostedStrOrderLineDetails.NEXT = 0;*///16225 table N/F End
                                IF InvDisc1 < 0 THEN
                                    SalesLineAmt += Value - ABS(InvDisc1)
                                ELSE
                                    SalesLineAmt += Value - (InvDisc1);

                            //********** monthly Sales**********//

                            UNTIL SaleInvLine.NEXT = 0;
                        SalesValue += SalesLineAmt; //month sale end

                        IF (SalesInvHeader."Posting Date" >= MonthStartdate) THEN BEGIN
                            MonthValue += SalesLineAmt;
                            IF SalesInvHeader."Bill-to City" IN ['Delhi', 'Gurgaon', 'Faridabad'] THEN
                                MonthNCRSales += SalesLineAmt;
                            IF SalesInvHeader."Bill-to City" = 'Chennai' THEN
                                MonthChennai_Sales += SalesLineAmt;

                        END;
                        //city wise sales

                        IF SalesInvHeader."Bill-to City" IN ['Delhi', 'Gurgaon', 'Faridabad'] THEN BEGIN
                            Del_Gur_Far_Sale += SalesLineAmt;
                            OutstandingNCR += Customer."Balance (LCY)";
                        END;
                        IF SalesInvHeader."Bill-to City" = 'Chennai' THEN BEGIN
                            Chennai_Sales += SalesLineAmt;
                            OutstandingChennai += Customer."Balance (LCY)";
                        END;
                    UNTIL SalesInvHeader.NEXT = 0;
                END;

                //Days Calculation

                OverDueAmt := 0;
                OustDays := 0;
                OverDueDy := 0;


                CustLedEntry.RESET;
                CustLedEntry.SETCURRENTKEY("Customer No.", Open, Positive, "Due Date", "Currency Code");
                CustLedEntry.SETRANGE("Customer No.", "No.");
                CustLedEntry.SETRANGE("Document Type", CustLedEntry."Document Type"::Invoice);
                CustLedEntry.SETFILTER("Due Date", '<=%1', TODAY);
                IF CustLedEntry.FINDFIRST THEN BEGIN
                    i := 1;
                    REPEAT
                        CustLedEntry.CALCFIELDS("Remaining Amount");
                        IF CustLedEntry."Remaining Amount" <> 0 THEN BEGIN
                            IF i = 1 THEN BEGIN
                                OverDueDy := TODAY - CustLedEntry."Due Date";
                                OustDays := (TODAY - CustLedEntry."Posting Date");
                            END;
                            OverDueAmt += CustLedEntry."Remaining Amount";
                            IF Customer.City IN ['Delhi', 'Gurgaon', 'Faridabad'] THEN
                                OverDueNCR += CustLedEntry."Remaining Amount";

                            IF Customer.City = 'Chennai' THEN
                                OverdueChennai += CustLedEntry."Remaining Amount";

                            i += 1;
                        END;

                    UNTIL CustLedEntry.NEXT = 0;
                END;

                IF (OverDueAmt + SalesValue + cformAMT + ABS("Balance (LCY)")) = 0 THEN
                    CurrReport.SKIP;

                CustLedEntry.RESET;
                CustLedEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Currency Code");
                CustLedEntry.SETRANGE("Customer No.", "No.");
                CustLedEntry.SETRANGE("Document Type", CustLedEntry."Document Type"::Invoice);
                CustLedEntry.SETFILTER("Posting Date", '<=%1', TODAY);
                CustLedEntry.SETRANGE(Open, TRUE);
                IF CustLedEntry.FINDFIRST THEN BEGIN
                    OustDays := (TODAY - CustLedEntry."Posting Date");
                END;

                TotalMTD += MonthValue;
                TotalYTD += SalesValue;
                TotalOutstanding += Customer."Balance (LCY)";
                TotalOverdue += OverDueAmt;
                TotalCForm += cformAMT;
            end;

            trigger OnPreDataItem()
            begin
                //MonthDate := CALCDATE('<-1M>',TODAY);
                IF NOT ShowAllCity THEN BEGIN
                    Customer.SETFILTER("Customer Type", '<>%1&<>%2&<>%3&<>%4&<>%5', 'COCO', 'DIRECTPROJ', 'HOPROJECT', '');
                    Customer.SETFILTER(City, '%1|%2|%3|%4', 'Delhi', 'Faridabad', 'Gurgaon', 'Chennai');
                END;
                //******** Yearly Sales*******//
            end;
        }
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));
            column(Del_Gur_Far_Sale; Del_Gur_Far_Sale / 100000)
            {
            }
            column(Chennai_Sales; Chennai_Sales / 100000)
            {
            }
            column(TotalMTD; TotalMTD / 100000)
            {
            }
            column(TotalYTD; TotalYTD / 100000)
            {
            }
            column(MonthNCRSales; MonthNCRSales / 100000)
            {
            }
            column(MonthChennai_Sales; MonthChennai_Sales / 100000)
            {
            }
            column(TotalCForm; TotalCForm / 100000)
            {
            }
            column(TotalOutstanding; TotalOutstanding / 100000)
            {
            }
            column(TotalOverdue; TotalOverdue / 100000)
            {
            }
            column(OutstandingNCR; OutstandingNCR / 100000)
            {
            }
            column(OutstandingChennai; OutstandingChennai / 100000)
            {
            }
            column(OverDueNCR; OverDueNCR / 100000)
            {
            }
            column(OverdueChennai; OverdueChennai / 100000)
            {
            }
            column(CformNCR; CformNCR / 100000)
            {
            }
            column(CformChennai; CformChennai / 100000)
            {
            }
            column(PanSalesValue; PanSalesValue / 100000)
            {
            }
            column(PanMonthValue; PanMonthValue / 100000)
            {
            }
            column(PanOutstanding; PanOutstanding / 100000)
            {
            }
            column(PanOverDue; PanOverDue / 100000)
            {
            }
            column(PANCForm; PANCForm / 100000)
            {
            }
            column(MonthSaleReturn; MonthSaleReturn / 100000)
            {
            }
            column(TotalSaleReturn; TotalSaleReturn / 100000)
            {
            }

            trigger OnPreDataItem()
            begin
                CalculatePanIndiaData;
                CalculateReturn('', FiscalStartDate, TODAY);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Show All City"; ShowAllCity)
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
        ShowAllCity := TRUE;
        FiscalStartDate := FindFiscalYear(TODAY);
        MonthStartdate := FindMonthStartDate(TODAY);
    end;

    var
        cformAMT: Decimal;
        CformRec: Record "C-form";
        PanInd_Sales: Decimal;
        Chennai_Sales: Decimal;
        Del_Gur_Far_Sale: Decimal;
        MonthValue: Decimal;
        i: Integer;
        OverDueAmt: Decimal;
        MonthDate: Date;
        InsDisc: Decimal;
        GLSetup: Record "General Ledger Setup";
        //16225 PostedStrOrderLineDetails: Record "13798";
        SILDocNoNew: Code[30];
        Roundoff: Decimal;
        InvDisNew: Decimal;
        InvDisc1: Decimal;
        ShowAllCity: Boolean;
        DetailCusLedg: Record "Detailed Cust. Ledg. Entry";
        RecSalesInvLine: Record "Sales Invoice Line";
        SaleInvLine: Record "Sales Invoice Line";
        SaleInvLine1: Record "Sales Invoice Line";
        ExAmount: Decimal;
        ExAmount1: Decimal;
        Value: Decimal;
        Value1: Decimal;
        SalesValue: Decimal;
        NetValue: Decimal;
        CustLedEntry: Record "Cust. Ledger Entry";
        OverDueDy: Integer;
        ToDat: Date;
        OustDays: Integer;
        SalesInvHeader: Record "Sales Invoice Header";
        SalesLineAmt: Decimal;
        TotalMTD: Decimal;
        TotalYTD: Decimal;
        MonthNCRSales: Decimal;
        MonthChennai_Sales: Decimal;
        TotalOutstanding: Decimal;
        TotalCForm: Decimal;
        TotalOverdue: Decimal;
        OutstandingNCR: Decimal;
        OutstandingChennai: Decimal;
        OverDueNCR: Decimal;
        OverdueChennai: Decimal;
        CformNCR: Decimal;
        CformChennai: Decimal;
        PanSalesValue: Decimal;
        PanMonthValue: Decimal;
        PanOutstanding: Decimal;
        RecCustomer: Record Customer;
        PanOverDue: Decimal;
        PANCForm: Decimal;
        FiscalStartDate: Date;
        MonthStartdate: Date;
        MonthSaleReturn: Decimal;
        TotalSaleReturn: Decimal;

    procedure CalculateReturn(CustNo: Code[20]; fromDate: Date; ToDate: Date) Amt: Decimal
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
    begin
        SalesCrMemoLine.RESET;
        SalesCrMemoLine.SETCURRENTKEY("Document No.", Type);
        //SalesCrMemoLine.SETRANGE("Sell-to Customer No.",CustNo);
        SalesCrMemoLine.SETFILTER(Type, '%1', SalesCrMemoLine.Type::Item);
        SalesCrMemoLine.SETRANGE("Posting Date", fromDate, ToDate);
        IF SalesCrMemoLine.FINDFIRST THEN BEGIN
            REPEAT
                /* 16225 TotalSaleReturn += (SalesCrMemoLine.Quantity * SalesCrMemoLine."Unit Price") + SalesCrMemoLine."Excise Amount"
                           - (SalesCrMemoLine."Discount Amt 1" + SalesCrMemoLine."Discount Amt 2" + SalesCrMemoLine."Discount Amt 3" + SalesCrMemoLine."Discount Amt 4" + SalesCrMemoLine."Quantity Discount Amount");*/
                TotalSaleReturn += (SalesCrMemoLine.Quantity * SalesCrMemoLine."Unit Price")
                                  - (SalesCrMemoLine."Discount Amt 1" + SalesCrMemoLine."Discount Amt 2" + SalesCrMemoLine."Discount Amt 3" + SalesCrMemoLine."Discount Amt 4" + SalesCrMemoLine."Quantity Discount Amount");
                IF SalesCrMemoLine."Posting Date" >= MonthStartdate THEN
                    MonthSaleReturn += (SalesCrMemoLine.Quantity * SalesCrMemoLine."Unit Price")
                                      - (SalesCrMemoLine."Discount Amt 1" + SalesCrMemoLine."Discount Amt 2" + SalesCrMemoLine."Discount Amt 3" + SalesCrMemoLine."Discount Amt 4" + SalesCrMemoLine."Quantity Discount Amount");
            /* 16225 MonthSaleReturn += (SalesCrMemoLine.Quantity * SalesCrMemoLine."Unit Price") + SalesCrMemoLine."Excise Amount"
                           - (SalesCrMemoLine."Discount Amt 1" + SalesCrMemoLine."Discount Amt 2" + SalesCrMemoLine."Discount Amt 3" + SalesCrMemoLine."Discount Amt 4" + SalesCrMemoLine."Quantity Discount Amount");*/

            UNTIL SalesCrMemoLine.NEXT = 0;
        END;
        //EXIT(-Amt);
    end;

    procedure CalculatePanIndiaData()
    begin
        SalesInvHeader.RESET;
        SalesInvHeader.SETCURRENTKEY("Posting Date");
        //SalesInvHeader.SETRANGE("Sell-to Customer No.","No.");
        SalesInvHeader.SETFILTER("Posting Date", '%1..%2', FiscalStartDate, TODAY);
        IF SalesInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                SalesLineAmt := 0;
                SaleInvLine.RESET;
                SaleInvLine.SETCURRENTKEY("Sell-to Customer No.", Type, "Document No.");
                //  SaleInvLine.SETRANGE("Sell-to Customer No.","No.");
                SaleInvLine.SETRANGE(SaleInvLine.Type, SaleInvLine.Type::Item);
                SaleInvLine.SETRANGE("Document No.", SalesInvHeader."No.");
                SaleInvLine.SETFILTER(SaleInvLine.Quantity, '<>%1', 0);
                SaleInvLine.SETFILTER(SaleInvLine."No.", '<>%1', '');
                SaleInvLine.SETFILTER("Posting Date", '%1', SalesInvHeader."Posting Date");
                IF SaleInvLine.FINDFIRST THEN
                    REPEAT
                        InvDisc1 := 0;
                        //16225  + SaleInvLine."Excise Amount"
                        Value := (SaleInvLine.Quantity * SaleInvLine."Unit Price")
                                  - (SaleInvLine."Discount Amt 1" + SaleInvLine."Discount Amt 2" + SaleInvLine."Discount Amt 3" + SaleInvLine."Discount Amt 4" + SaleInvLine."Quantity Discount Amount");
                        //16225 table N/F start
                        /* PostedStrOrderLineDetails.RESET;
                         PostedStrOrderLineDetails.SETCURRENTKEY(Type, "Document Type", "Invoice No.", "Tax/Charge Type", "Tax/Charge Group");
                         PostedStrOrderLineDetails.SETRANGE(Type, PostedStrOrderLineDetails.Type::Sale);
                         PostedStrOrderLineDetails.SETRANGE("Document Type", PostedStrOrderLineDetails."Document Type"::Invoice);
                         PostedStrOrderLineDetails.SETRANGE("Invoice No.", SaleInvLine."Document No.");
                         PostedStrOrderLineDetails.SETRANGE("Line No.", SaleInvLine."Line No.");
                         IF PostedStrOrderLineDetails.FIND('-') THEN
                             REPEAT
                                 CASE PostedStrOrderLineDetails."Tax/Charge Type" OF
                                     PostedStrOrderLineDetails."Tax/Charge Type"::Charges:
                                         BEGIN
                                             IF PostedStrOrderLineDetails."Tax/Charge Group" = GLSetup."Discount Charge" THEN
                                                 IF PostedStrOrderLineDetails.Amount < 0 THEN
                                                     InvDisc1 := InvDisc1 + ABS(PostedStrOrderLineDetails.Amount)
                                                 ELSE
                                                     InvDisc1 := InvDisc1 + -PostedStrOrderLineDetails.Amount;

                                             IF PostedStrOrderLineDetails."Tax/Charge Group" = GLSetup.AddInsuranceDisc THEN
                                                 IF PostedStrOrderLineDetails.Amount < 0 THEN
                                                     InsDisc := InsDisc + ABS(PostedStrOrderLineDetails.Amount)
                                                 ELSE
                                                     InsDisc := InsDisc + PostedStrOrderLineDetails.Amount;
                                         END;
                                 END;
                             UNTIL PostedStrOrderLineDetails.NEXT = 0;*///16225 table N/F End
                        IF InvDisc1 < 0 THEN
                            SalesLineAmt += Value - ABS(InvDisc1)
                        ELSE
                            SalesLineAmt += Value - (InvDisc1);

                    //********** monthly Sales**********//

                    UNTIL SaleInvLine.NEXT = 0;
                PanSalesValue += SalesLineAmt; //month sale end

                IF (SalesInvHeader."Posting Date" >= MonthStartdate) THEN BEGIN
                    PanMonthValue += SalesLineAmt;

                END;
            UNTIL SalesInvHeader.NEXT = 0;
        END;

        RecCustomer.RESET;
        IF RecCustomer.FINDFIRST THEN
            REPEAT
                RecCustomer.CALCFIELDS(RecCustomer."Balance (LCY)");
                PanOutstanding += RecCustomer."Balance (LCY)";
            //  TotalSaleReturn := CalculateReturn(RecCustomer."No.",FiscalStartDate,TODAY);
            UNTIL RecCustomer.NEXT = 0;

        CustLedEntry.RESET;
        CustLedEntry.SETCURRENTKEY("Customer No.", Open, Positive, "Due Date", "Currency Code");
        CustLedEntry.SETRANGE("Document Type", CustLedEntry."Document Type"::Invoice);
        CustLedEntry.SETFILTER("Due Date", '<=%1', TODAY);
        IF CustLedEntry.FINDFIRST THEN BEGIN
            REPEAT
                CustLedEntry.CALCFIELDS("Remaining Amount");
                IF CustLedEntry."Remaining Amount" <> 0 THEN BEGIN
                    PanOverDue += CustLedEntry."Remaining Amount";
                END;
            UNTIL CustLedEntry.NEXT = 0;
        END;
    end;

    procedure FindFiscalYear(BalanceDate: Date): Date
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        AccountingPeriod.SETRANGE("New Fiscal Year", TRUE);
        AccountingPeriod.SETRANGE("Starting Date", 0D, BalanceDate);
        IF AccountingPeriod.FINDLAST THEN
            EXIT(AccountingPeriod."Starting Date");
        AccountingPeriod.RESET;
        AccountingPeriod.FINDFIRST;
        EXIT(AccountingPeriod."Starting Date");
    end;

    procedure FindMonthStartDate(BalanceDate: Date): Date
    begin
        //EXIT(CALCDATE('CM',BalanceDate));
        EXIT(CALCDATE('CM+1D-1M', BalanceDate))
    end;
}

