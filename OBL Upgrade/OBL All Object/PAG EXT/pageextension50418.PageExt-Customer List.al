pageextension 50418 pageextension50418 extends "Customer List"
{
    layout
    {

        addafter("Base Calendar Code")
        {

            field("GST Registration No."; Rec."GST Registration No.")
            {
                ApplicationArea = All;
            }
            field("State Code"; Rec."State Code")
            {
                ApplicationArea = All;
            }
            field("Pin Code"; Rec."Pin Code")
            {

                ApplicationArea = all;
            }

            field("Area Code"; Rec."Area Code")
            {
                Caption = 'Sales Territory';
                ApplicationArea = all;
            }
            field("Virtual ID"; Rec."Virtual ID")
            {
                ApplicationArea = all;
            }
            field("Balance Confirmation"; Rec."Balance Confirmation")
            {
                ApplicationArea = all;
            }
            field("Balance Conf Recd Date"; Rec."Balance Conf Recd Date")
            {
                ApplicationArea = all;
            }
            field("PCH Code"; Rec."PCH Code")
            {
                ApplicationArea = all;
            }
            field("Zonal Manager"; Rec."Zonal Manager")
            {
                ApplicationArea = all;
            }
            field("Zonal Head"; Rec."Zonal Head")
            {
                ApplicationArea = all;
            }

            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field(Address; Rec.Address)
            {
                ApplicationArea = All;
            }
            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = All;
            }
            field(City; Rec.City)
            {
                ApplicationArea = All;
            }
            field("Telex No."; Rec."Telex No.")
            {
                ApplicationArea = All;
            }
            field("Our Account No."; Rec."Our Account No.")
            {
                ApplicationArea = All;
            }
            field("Territory Code"; Rec."Territory Code")
            {
                ApplicationArea = All;
            }
            field("Debit Amount"; Rec."Debit Amount")
            {
                ApplicationArea = All;
            }
            field("Credit Amount"; Rec."Credit Amount")
            {
                ApplicationArea = All;
            }
            field(Balance; Rec.Balance)
            {
                ApplicationArea = All;
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
            }
            field("P.A.N. No."; Rec."P.A.N. No.")
            {
                ApplicationArea = All;
            }
            field("P.A.N. Reference No."; Rec."P.A.N. Reference No.")
            {
                ApplicationArea = All;
            }
            field("Net Change"; Rec."Net Change")
            {
                ApplicationArea = All;
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field("Net Change (LCY)"; Rec."Net Change (LCY)")
            {
                ApplicationArea = All;
            }
            field("TCS Applicable"; TCSApplicable)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Cust. Balance"; CustBalance)
            {
                Editable = false;
                ApplicationArea = All;
            }

        }
        addafter("TCS Applicable")
        {
            field("TCS Charge Stop Date"; Rec."TCS Charge Stop Date")
            {
                Editable = false;
                ApplicationArea = all;
            }
        }
        moveafter("GST Registration No."; "Sales (LCY)")
        moveafter("Global Dimension 1 Code"; "Name 2")
        moveafter("Net Change (LCY)"; "Balance (LCY)")
    }
    actions
    {
        addafter(ReportCustomerPaymentReceipt)
        {
            action(UpdateTemp)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    CustLedEntry: Record "Cust. Ledger Entry";
                    SIH: Record "Sales Invoice Header";
                begin
                    CustLedEntry.RESET;
                    CustLedEntry.SETRANGE("Document Type", CustLedEntry."Document Type"::Invoice);
                    CustLedEntry.SETRANGE("Dealer Code", '');
                    IF CustLedEntry.FINDFIRST THEN
                        REPEAT
                            SIH.RESET;
                            SIH.SETRANGE("No.", CustLedEntry."Document No.");
                            IF SIH.FINDFIRST THEN BEGIN
                                CustLedEntry."Dealer Code" := SIH."Dealer Code";
                                CustLedEntry.MODIFY;
                            END;
                        UNTIL
                        CustLedEntry.NEXT = 0;
                end;
            }
        }
    }

    var
        Cust: Page "Customer Card";
        UserSetup: Record "User Setup";
        [InDataSet]
        BalanceVisible: Boolean;
        [InDataSet]
        "Net ChangeVisible": Boolean;
        [InDataSet]
        "Balance (LCY)Visible": Boolean;
        [InDataSet]
        CustomerEnable: Boolean;
        SPPCHGoalSheetCalculation: Codeunit "SP  PCH Goal Sheet Calculation";
        CustBalance: Decimal;
        [InDataSet]
        TCSApplicable: Boolean;
        TCS: Record "Allowed NOC";


    trigger OnAfterGetRecord()
    var
    begin
        //Upgrade(+)
        //MSAK.BEGIN 050515
        //RB Rec.FILTERGROUP(2);
        IF GetLocations <> '' THEN
            Rec.SETFILTER("Global Dimension 1 Code", GetLocations);
        Rec.FILTERGROUP(0);
        //MSAK.END 050515

        //Upgrade(-)

        CustBalance := SPPCHGoalSheetCalculation.CalcActualBalance(Rec."No.", TODAY);

        TCSApplicable := FALSE;
        TCS.SETFILTER("Customer No.", '%1', rec."No.");
        TCS.SETFILTER("TCS Nature of Collection", '%1', '206C-1H');
        IF TCS.FINDFIRST THEN
            TCSApplicable := TRUE;

    end;

    trigger OnOpenPage()
    begin
        CurrPage.LOOKUPMODE := TRUE;
        CustomerEnable := TRUE;
        "Balance (LCY)Visible" := TRUE;
        "Net ChangeVisible" := TRUE;
        BalanceVisible := TRUE;
        //Upgrade(+)
        //MSAK.BEGIN 050515
        Rec.FILTERGROUP(2);
        IF GetLocations <> '' THEN
            Rec.SETFILTER("Global Dimension 1 Code", GetLocations);
        Rec.FILTERGROUP(0);
        //MSAK.END 050515

        //Ori Ut 21-02-11 For Checking
        IF USERID IN ['de025'] THEN BEGIN
            CurrPage.EDITABLE(FALSE);
            CustomerEnable := FALSE;
            BalanceVisible := FALSE;
            "Net ChangeVisible" := FALSE;
            "Balance (LCY)Visible" := FALSE;
        END;
        //Ori Ut 21-02-11

        //Upgrade(-)

    end;


    //Unsupported feature: Code Insertion on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //begin
    /*
                 CurrPage.LOOKUPMODE := TRUE;
                 CustomerEnable := TRUE;
                 "Balance (LCY)Visible" := TRUE;
                 "Net ChangeVisible" := TRUE;
                 BalanceVisible := TRUE;
    */
    //end;



    procedure GetLocations(): Text[800]
    var
        Loc: Text[800];
        UserLocation: Record "User Location";
    begin
        //MSAK Begin 05-05-15
        UserLocation.RESET;
        UserLocation.SETRANGE("User ID", USERID);
        UserLocation.SETFILTER("View Customer", '%1', TRUE);
        IF UserLocation.FINDFIRST THEN BEGIN
            REPEAT
                IF Loc = '' THEN
                    Loc := UserLocation."Location Code"
                ELSE
                    Loc := Loc + '|' + UserLocation."Location Code";
            UNTIL UserLocation.NEXT = 0;
        END;
        EXIT(Loc);
        //MSAK End 05-05-15
    end;
}

