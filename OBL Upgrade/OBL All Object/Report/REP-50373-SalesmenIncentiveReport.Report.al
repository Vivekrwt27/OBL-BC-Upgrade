report 50373 "Salesmen Incentive Report"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\SalesmenIncentiveReport.rdl';

    dataset
    {
        dataitem("Budget Master"; "Budget Master")
        {
            RequestFilterFields = "No.", "Amount Utilised";
            column(SPCode; "Budget Master"."No.")
            {
            }
            column(SPName; SalespersonTable.Name)
            {
            }
            column(MnthTarget; "Budget Master"."No. Series")
            {
            }
            column(AchvTarget; "Budget Master"."Executive Summary")
            {
            }
            column(PercentAchivd; PercentAchivd)
            {
            }
            column(DSO; DSO)
            {
            }
            column(Payout; Payout)
            {
            }
            column(Monthname; monthname)
            {
            }
            column(SPType_SalesPersonTarget; '')
            {
            }

            trigger OnAfterGetRecord()
            begin
                //16225  month := DATE2DMY("Amount Utilised", 2);
                CASE month OF
                    1:
                        monthname := 'January';
                    2:
                        monthname := 'February';
                    3:
                        monthname := 'March';
                    4:
                        monthname := 'April';
                    5:
                        monthname := 'May';
                    6:
                        monthname := 'June';
                    7:
                        monthname := 'July';
                    8:
                        monthname := 'August';
                    9:
                        monthname := 'September';
                    10:
                        monthname := 'October';
                    11:
                        monthname := 'November';
                    12:
                        monthname := 'December';
                END;


                PercentAchivd := 0;
                Payout := 0;
                DSO := 0;

                SalespersonTable.RESET;
                SalespersonTable.SETRANGE(SalespersonTable.Code, "No.");
                IF SalespersonTable.FINDFIRST THEN;
                //16225 Not compile
                /*  IF "Budget Master"."No. Series" THEN
                      PercentAchivd := ("Budget Master"."Executive Summary" / "Budget Master"."No. Series") * 100
                  ELSE
                      PercentAchivd := 0;

                  CALCFIELDS("Budget Master"."Financial Evaluation", "Budget Master"."Project Rational");

                  IF "Budget Master"."Financial Evaluation" <> 0 THEN
                      DSO := ((ROUND(("Budget Master"."Project Rational" * 90) / ("Budget Master"."Financial Evaluation"), 0.01, '=') / 100) * 100)
                  ELSE
                      DSO := 0;*/

                IF DSO < 0 THEN
                    DSO := 0;
                IF (PercentAchivd > 0) AND (DSO > 0) THEN
                    Payout := CalculateIncentivePer(PercentAchivd, DSO);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
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
        SalespersonTable: Record "Salesperson/Purchaser";
        SalesPersonIncentiveDetails: Record "Payment Terms Location Wise";
        IncentiveSetup: Record "Capex Entry";
        PercentAchivd: Decimal;
        PercentAchivd1: Decimal;
        Payout: Decimal;
        Avg90Days: Decimal;
        DSO: Decimal;
        EffectiveMonth: Option Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec;
        month: Integer;
        monthname: Text[10];

    procedure CalculateIncentivePer(TargetAchieve: Decimal; DaysOver: Decimal) Per: Decimal
    var
        IncSetup: Record "Capex Entry";
    begin
        IncSetup.RESET;
        IncSetup.SETCURRENTKEY("Capex No.");
        //16225  IncSetup.SETFILTER("Capex No.", '>%1', DaysOver);
        IF IncSetup.FINDFIRST THEN BEGIN
            CASE TargetAchieve OF
                0 .. 79.99:
                    EXIT(IncSetup.Amount);
                //16225  80 .. 84.99:
                //16225  EXIT(IncSetup."Between 80-85");
                85 .. 89.99:
                    EXIT(IncSetup."Total GST Amount");
                90 .. 94.99:
                    EXIT(IncSetup."Other Charges");
                95 .. 99.99:
                    EXIT(IncSetup."Amount to Vendor");
                100 .. 9999999:
                    EXIT(IncSetup."Invoice Amount");
            END;
        END;
    end;
}

