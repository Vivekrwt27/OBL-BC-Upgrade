page 50165 "Auto Batch Run"
{
    Caption = 'Auto PDF and Mail - Form';
    PageType = Card;
    SourceTable = Integer;
    SourceTableView = SORTING(Number)
                      WHERE(Number = CONST(1));

    layout
    {
        area(content)
        {
            label(Action009999)
            {
                CaptionClass = Text19077561;
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        SLEEP(90000);
        //REPORT.RUN(795,FALSE,FALSE);
        REPORT.RUN(Report::"c-FORM", FALSE, FALSE);
    end;

    var
        CdReportMail: Codeunit "Report Mail Utility";
        Text19077561: Label 'Auto PDF Generation - Form';

    local procedure OnTimer()
    begin
        //REPORT.RUN(795,FALSE,FALSE);
        REPORT.RUN(Report::"c-FORM", FALSE, FALSE);
    end;
}

