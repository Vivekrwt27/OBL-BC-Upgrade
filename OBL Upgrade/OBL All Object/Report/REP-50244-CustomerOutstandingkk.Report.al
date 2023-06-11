report 50244 "Customer Outstanding kk"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\CustomerOutstandingkk.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.";
            column(CustNo; Customer."No.")
            {
            }
            column(CustType; Customer."Customer Type")
            {
            }
            column(CustName; Customer.Name)
            {
            }
            column(TableauZone; Customer."Tableau Zone")
            {
            }
            column(CustCity; Customer.City)
            {
            }
            column(CustState; Customer."State Desc.")
            {
            }
            column(CustTerrtry; Customer."Area Code")
            {
            }
            column(dtAsOn; dtAsOn)
            {
            }
            column(decBalance; decBalance)
            {
            }
            column(decLstFyBal; decLstFyBal)
            {
            }
            column(dtFYLst; dtFYLst)
            {
            }
            column(decPayment; decPayment)
            {
            }
            column(txtCustFilters; txtCustFilters)
            {
            }
            column(decRemOutStndLstFy; decRemOutStndLstFy)
            {
            }
            column(decBckDayPayment; decBckDayPayment)
            {
            }

            trigger OnAfterGetRecord()
            begin
                decBalance := 0;
                decLstFyBal := 0;
                decPayment := 0;
                decRemOutStndLstFy := 0;
                decBckDayPayment := 0;
                Customer.CALCFIELDS("Balance (LCY)");
                decBalance := Customer."Balance (LCY)";

                CLEAR(CustLedger);
                CustLedger.SETFILTER(CustLedger.Customer_No_filter, '%1', Customer."No.");
                CustLedger.SETFILTER(CustLedger.Posting_Date, '%1..%2', 0D, dtFYLst);
                CustLedger.OPEN;
                WHILE CustLedger.READ DO BEGIN
                    IF xEntryNo <> CustLedger.Entry_No THEN BEGIN
                        IF (NOT CustLedger.Entry_Skipped) AND (NOT CustLedger.Open_CLE) THEN BEGIN
                            decLstFyBal += CustLedger.Amount_LCY;
                            decRemOutStndLstFy += CustLedger.Remaining_Amt_LCY;
                        END;
                    END;
                    xEntryNo := CustLedger.Entry_No;
                END;
                /*
                CLEAR(CustLedger);
                CustLedger.SETFILTER(CustLedger.Customer_No_filter,'%1',Customer."No.");
                CustLedger.SETFILTER(CustLedger.Posting_Date,'%1..%2',0D,dtFYLst);
                CustLedger.OPEN;
                WHILE CustLedger.READ DO BEGIN
                  IF xEntryNo<>CustLedger.Entry_No THEN BEGIN
                //    IF (CustLedger.Entry_Skipped<>TRUE) AND (CustLedger.Open_CLE<>TRUE) THEN
                      decRemOutStndLstFy+=CustLedger.Remaining_Amt_LCY;
                  END;
                  xEntryNo:=CustLedger.Entry_No;
                END;
                */
                CLEAR(CustLedger);
                CustLedger.SETFILTER(CustLedger.Customer_No_filter, '%1', Customer."No.");
                CustLedger.SETFILTER(CustLedger.Posting_Date, '%1..%2', 0D, dtFYLst);
                CustLedger.OPEN;
                WHILE CustLedger.READ DO BEGIN
                    /*  IF (CustLedger.Det_Posting_Date >= dtFYLst + 1) AND (CustLedger.Det_Posting_Date <= 29990401D) THEN BEGIN//04012999D
                          IF (CustLedger.Det_Entry_Type = CustLedger.Det_Entry_Type::Application) AND
                            ((CustLedger.Det_Document_Type = CustLedger.Det_Document_Type::Payment) OR
                            (CustLedger.Det_Document_Type = CustLedger.Det_Document_Type::Refund)) THEN
                              decPayment += CustLedger.Sum_Amount_Det;
                      END;*///
                END;
                /*
                CLEAR(CustLedger);
                CustLedger.SETFILTER(CustLedger.Customer_No_filter,'%1',Customer."No.");
                CustLedger.OPEN;
                WHILE CustLedger.READ DO BEGIN
                  IF xEntryNo<>CustLedger.Entry_No THEN BEGIN
                    decBalance+=CustLedger.Amount_LCY;
                  END;
                  xEntryNo:=CustLedger.Entry_No;
                END;
                */
                CLEAR(CustLedger);
                CustLedger.SETFILTER(CustLedger.Customer_No_filter, '%1', Customer."No.");
                CustLedger.SETFILTER(CustLedger.Posting_Date, '%1..%2', CALCDATE('-CM', dtAsOn), dtAsOn);
                CustLedger.SETFILTER(CustLedger.Document_Type, '%1|%2', DocTypeEnum::Payment, DocTypeEnum::Refund);
                CustLedger.OPEN;
                WHILE CustLedger.READ DO BEGIN
                    IF xEntryNo <> CustLedger.Entry_No THEN BEGIN
                        decBckDayPayment += CustLedger.Amount_LCY;
                    END;
                    xEntryNo := CustLedger.Entry_No;
                END;

            end;

            trigger OnPreDataItem()
            begin
                txtCustFilters := Customer.GETFILTERS;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("As On Date"; dtAsOn)
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
        CustLedger.CLOSE
    end;

    trigger OnPreReport()
    begin
        IF dtAsOn = 0D THEN
            ERROR('As on date cannot be Blank');
        intMonth := DATE2DMY(dtAsOn, 2);
        intYear := DATE2DMY(dtAsOn, 3);

        IF intMonth < 4 THEN
            dtFYLst := DMY2DATE(31, 3, intYear - 1)
        ELSE
            dtFYLst := DMY2DATE(31, 3, intYear);
    end;

    var
        dtAsOn: Date;
        decBalance: Decimal;
        decLstFyBal: Decimal;
        recCust: Record Customer;
        dtFYLst: Date;
        intYear: Integer;
        recDetCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        decPayment: Decimal;
        recCustLedgEntr: Record "Cust. Ledger Entry";
        intMonth: Integer;
        txtCustFilters: Text;
        decRemOutStndLstFy: Decimal;
        decBckDayPayment: Decimal;
        CustLedger: Query "Cust. Ledger";
        blnSpeed: Boolean;
        xEntryNo: Integer;
        DocTypeEnum: Enum "Document Type Enum";
}

