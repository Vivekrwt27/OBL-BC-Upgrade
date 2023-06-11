report 50250 "Daily Indent Authorised report"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\DailyIndentAuthorisedreport.rdlc';

    dataset
    {
        dataitem("Indent Header"; "Indent Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE("Authorization Date" = FILTER(<> ''));
            column(AuthorizationDate_IndentHeader; "Indent Header"."Authorization Date")
            {
            }
            column(No_IndentHeader; "Indent Header"."No.")
            {
            }
            dataitem("Indent Line"; "Indent Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Quantity = FILTER(<> 0));
                column(No_IndentLine; "Indent Line"."No.")
                {
                }
                column(Description_IndentLine; "Indent Line".Description)
                {
                }
                column(Description2_IndentLine; "Indent Line"."Description 2")
                {
                }
                column(UnitofMeasurement_IndentLine; "Indent Line"."Unit of Measurement")
                {
                }
                column(Quantity_IndentLine; "Indent Line".Quantity)
                {
                }
                column(Rate_IndentLine; "Indent Line".Rate)
                {
                }
                column(Amount_IndentLine; "Indent Line".Amount)
                {
                }
                column(LocationCode_IndentLine; "Indent Line"."Location Code")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                GraceDate := "Indent Header"."Authorization Date" + 1;
                IF WORKDATE - GraceDate <> 0 THEN
                    CurrReport.SKIP;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        GraceDate: Date;
}

