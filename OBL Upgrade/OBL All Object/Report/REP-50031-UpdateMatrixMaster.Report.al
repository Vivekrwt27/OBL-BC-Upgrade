report 50031 "Update Matrix Master"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Matrix Master"; 50003)
        {
            DataItemTableView = SORTING("Mapping Type", "Type 1", "Type 2");
            RequestFilterFields = "Type 1";

            trigger OnAfterGetRecord()
            begin

                IF DATE2DMY(TODAY, 1) = 1 THEN
                    UpdateOuststandingOverDueAmt;
                UpdateCollectionAmt;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("Start Date"; StartDate)
                    {
                        Editable = false;
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

    trigger OnInitReport()
    begin
        StartDate := TODAY - 1;
    end;

    trigger OnPostReport()
    begin
        IF DATE2DMY(TODAY, 1) = 1 THEN
            UpdateOuststandingOverDueAmtOnCustomer;

        IF GUIALLOWED THEN
            MESSAGE('Done');
    end;

    var
        Customer: Record Customer;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        OutstandingAmt: Decimal;
        OverDueAmt: Decimal;
        CollectionAmt: Decimal;
        StartDate: Date;

    procedure UpdateOuststandingOverDueAmt()
    begin
        IF "Matrix Master"."Type 1" <> 'CKA' THEN BEGIN
            CLEAR(OverDueAmt);
            CLEAR(OutstandingAmt);
            Customer.RESET;
            Customer.SETCURRENTKEY("Area Code", "Tableau Zone");
            Customer.SETRANGE("Area Code", "Matrix Master"."Type 1");
            Customer.SETFILTER("Tableau Zone", '<>%1', 'Enterprise');
            IF Customer.FINDSET THEN
                REPEAT
                    //OUTSTANDING AMOUNT
                    Customer.CALCFIELDS(Balance);
                    IF Customer.Balance > 0 THEN BEGIN
                        OutstandingAmt += Customer.Balance;

                        CustLedgerEntry.RESET;
                        CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                        //    CustLedgerEntry.SETFILTER("Remaining Amt. (LCY)", '<>%1', 0);
                        IF CustLedgerEntry.FINDSET THEN
                            REPEAT
                                CustLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                                //OVERDUE AMOUNT
                                IF (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Invoice) AND
                                  (CustLedgerEntry."Due Date" <= CALCDATE('-1D', TODAY)) THEN BEGIN
                                    OverDueAmt += CustLedgerEntry."Remaining Amt. (LCY)";
                                END;
                            UNTIL CustLedgerEntry.NEXT = 0;
                    END;
                UNTIL Customer.NEXT = 0;
            //MATRIX MASTER UPDATION
            "Matrix Master"."OverDue Amount" := OverDueAmt;
            "Matrix Master"."Outstanding Amount" := OutstandingAmt;
            "Matrix Master".MODIFY;
            //END ELSE IF "Matrix Master"."Type 1" = 'CKA' THEN BEGIN
        END ELSE BEGIN
            CLEAR(OverDueAmt);
            CLEAR(OutstandingAmt);
            Customer.RESET;
            Customer.SETCURRENTKEY("Tableau Zone");
            Customer.SETFILTER("Tableau Zone", '%1', 'Enterprise');
            IF Customer.FINDFIRST THEN
                REPEAT
                    //OUTSTANDING AMOUNT
                    Customer.CALCFIELDS(Balance);
                    IF Customer.Balance > 0 THEN BEGIN
                        OutstandingAmt += Customer.Balance;

                        CustLedgerEntry.RESET;
                        CustLedgerEntry.SETFILTER("Remaining Amt. (LCY)", '<>%1', 0);
                        CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                        IF CustLedgerEntry.FINDSET THEN
                            REPEAT
                                CustLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                                //OVERDUE AMOUNT
                                IF (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Invoice) AND
                                  (CustLedgerEntry."Due Date" <= CALCDATE('-1D', TODAY)) THEN BEGIN
                                    OverDueAmt += CustLedgerEntry."Remaining Amt. (LCY)";
                                END;
                            UNTIL CustLedgerEntry.NEXT = 0;
                    END;
                UNTIL Customer.NEXT = 0;

            //MATRIX MASTER UPDATION
            "Matrix Master"."OverDue Amount" := OverDueAmt;
            "Matrix Master"."Outstanding Amount" := OutstandingAmt;
            "Matrix Master".MODIFY;
        END;
    end;

    procedure UpdateCollectionAmt()
    begin
        IF "Matrix Master"."Type 1" <> 'CKA' THEN BEGIN
            //COLLECTION AMOUNT
            CLEAR(CollectionAmt);
            Customer.RESET;
            Customer.SETCURRENTKEY("Area Code", "Tableau Zone");
            Customer.SETRANGE("Area Code", "Matrix Master"."Type 1");
            Customer.SETFILTER("Tableau Zone", '<>%1', 'Enterprise');
            IF Customer.FINDSET THEN
                REPEAT
                    CustLedgerEntry.RESET;
                    CustLedgerEntry.SETFILTER("Document Type", '%1|%2', CustLedgerEntry."Document Type"::Payment, CustLedgerEntry."Document Type"::Refund);
                    CustLedgerEntry.SETRANGE("Posting Date", CALCDATE('-CM', StartDate), TODAY); //Kulbhushan
                    CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                    IF CustLedgerEntry.FINDSET THEN
                        REPEAT
                            CustLedgerEntry.CALCFIELDS(Amount);
                            CollectionAmt += CustLedgerEntry.Amount;
                        UNTIL CustLedgerEntry.NEXT = 0;
                UNTIL Customer.NEXT = 0;

            //MATRIX MASTER UPDATION
            "Matrix Master"."Collection Amount" := CollectionAmt;
            "Matrix Master".MODIFY;

        END ELSE
            IF "Matrix Master"."Type 1" = 'CKA' THEN BEGIN
                //COLLECTION AMOUNT
                CLEAR(CollectionAmt);
                Customer.RESET;
                Customer.SETCURRENTKEY("Area Code", "Tableau Zone");
                Customer.SETRANGE("Tableau Zone", 'Enterprise');
                IF Customer.FINDSET THEN
                    REPEAT
                        CustLedgerEntry.RESET;
                        CustLedgerEntry.SETFILTER("Document Type", '%1|%2', CustLedgerEntry."Document Type"::Payment, CustLedgerEntry."Document Type"::Refund);
                        CustLedgerEntry.SETRANGE("Posting Date", CALCDATE('-CM', StartDate), TODAY);
                        CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                        IF CustLedgerEntry.FINDSET THEN
                            REPEAT
                                CustLedgerEntry.CALCFIELDS(Amount);
                                CollectionAmt += CustLedgerEntry.Amount;
                            UNTIL CustLedgerEntry.NEXT = 0;
                    UNTIL Customer.NEXT = 0;

                //MATRIX MASTER UPDATION
                "Matrix Master"."Collection Amount" := CollectionAmt;
                "Matrix Master".MODIFY;
            END;
    end;

    procedure UpdateOuststandingOverDueAmtOnCustomer()
    begin
        CLEAR(OverDueAmt);
        CLEAR(OutstandingAmt);
        Customer.RESET;
        Customer.SETCURRENTKEY("Area Code", "Tableau Zone");
        IF Customer.FINDSET THEN
            REPEAT
                //OUTSTANDING AMOUNT
                OutstandingAmt := 0;
                OverDueAmt := 0;
                Customer.CALCFIELDS(Balance);
                IF Customer.Balance > 0 THEN BEGIN
                    OutstandingAmt += Customer.Balance;

                    CustLedgerEntry.RESET;
                    CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                    //    CustLedgerEntry.SETFILTER("Remaining Amt. (LCY)", '<>%1', 0);
                    IF CustLedgerEntry.FINDSET THEN
                        REPEAT
                            CustLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                            //OVERDUE AMOUNT
                            IF (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Invoice) AND
                              (CustLedgerEntry."Due Date" <= CALCDATE('-1D', TODAY)) THEN BEGIN
                                OverDueAmt += CustLedgerEntry."Remaining Amt. (LCY)";
                            END;
                        UNTIL CustLedgerEntry.NEXT = 0;
                END;
                Customer."OverDue Amount" := OverDueAmt;
                Customer.MODIFY;
            UNTIL Customer.NEXT = 0;
    end;
}

