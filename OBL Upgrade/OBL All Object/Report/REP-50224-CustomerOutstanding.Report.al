report 50224 "Customer Outstanding"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\CustomerOutstanding.rdl';

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

                recCustLedgEntr.RESET;
                recCustLedgEntr.SETRANGE("Customer No.", Customer."No.");
                recCustLedgEntr.SETRANGE("Posting Date", 0D, dtFYLst);
                IF recCustLedgEntr.FIND('-') THEN
                    REPEAT
                        //IF (recCustLedgEntr."Entry Skipped"<>TRUE) OR (recCustLedgEntr.Open<>TRUE) THEN BEGIN
                        recCustLedgEntr.CALCFIELDS("Amount (LCY)");
                        decLstFyBal += recCustLedgEntr."Amount (LCY)";
                    //END;
                    UNTIL recCustLedgEntr.NEXT = 0;

                recCustLedgEntr.RESET;
                recCustLedgEntr.SETRANGE("Customer No.", Customer."No.");
                recCustLedgEntr.SETRANGE("Posting Date", 0D, dtFYLst);
                // recCustLedgEntr.SETRANGE("Document Type",recCustLedgEntr."Document Type"::Invoice);
                IF recCustLedgEntr.FIND('-') THEN
                    REPEAT
                        //IF (recCustLedgEntr."Entry Skipped"<>TRUE) OR (recCustLedgEntr.Open<>TRUE) THEN BEGIN
                        recCustLedgEntr.CALCFIELDS("Remaining Amt. (LCY)");
                        decRemOutStndLstFy += recCustLedgEntr."Remaining Amt. (LCY)";
                    //END;
                    UNTIL recCustLedgEntr.NEXT = 0;

                recCustLedgEntr.RESET;
                recCustLedgEntr.SETRANGE("Customer No.", Customer."No.");
                recCustLedgEntr.SETRANGE("Posting Date", 0D, dtFYLst);
                IF recCustLedgEntr.FIND('-') THEN
                    REPEAT
                        recDetCustLedgEntry.RESET;
                        recDetCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", recCustLedgEntr."Entry No.");
                        recDetCustLedgEntry.SETRANGE("Entry Type", recDetCustLedgEntry."Entry Type"::Application);
                        recDetCustLedgEntry.SETFILTER("Document Type", '%1|%2', recDetCustLedgEntry."Document Type"::Payment, recDetCustLedgEntry."Document Type"::Refund);
                        recDetCustLedgEntry.SETRANGE("Posting Date", dtFYLst + 1, 29990401D);//16225 04012999D
                        IF recDetCustLedgEntry.FIND('-') THEN
                            REPEAT
                                decPayment += recDetCustLedgEntry.Amount;
                            UNTIL recDetCustLedgEntry.NEXT = 0;
                    UNTIL recCustLedgEntr.NEXT = 0;

                recCustLedgEntr.RESET;
                recCustLedgEntr.SETRANGE("Customer No.", Customer."No.");
                IF recCustLedgEntr.FIND('-') THEN
                    REPEAT
                        //IF (recCustLedgEntr."Entry Skipped"<>TRUE) OR (recCustLedgEntr.Open<>TRUE) THEN BEGIN
                        recCustLedgEntr.CALCFIELDS("Amount (LCY)");
                        decBalance += recCustLedgEntr."Amount (LCY)";
                    //END;
                    UNTIL recCustLedgEntr.NEXT = 0;

                recCustLedgEntr.RESET;
                recCustLedgEntr.SETRANGE("Customer No.", Customer."No.");
                recCustLedgEntr.SETRANGE("Posting Date", CALCDATE('-CM', dtAsOn), dtAsOn);
                recCustLedgEntr.SETFILTER("Document Type", '%1|%2', recCustLedgEntr."Document Type"::Payment, recCustLedgEntr."Document Type"::Refund);
                IF recCustLedgEntr.FIND('-') THEN
                    REPEAT
                        recCustLedgEntr.CALCFIELDS("Amount (LCY)");
                        decBckDayPayment += recCustLedgEntr."Amount (LCY)";
                    UNTIL recCustLedgEntr.NEXT = 0;
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

    trigger OnPreReport()
    begin
        IF dtAsOn = 0D THEN
            ERROR('Ad on date cannot be Blank');
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
}

