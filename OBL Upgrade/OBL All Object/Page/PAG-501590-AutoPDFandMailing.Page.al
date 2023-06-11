page 50159 "Auto PDF and Mailing."
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
            label(Action0012)
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
        SLEEP(1000);

        CLEAR(CdReportMail);
        CdReportMail.GEneratePDFs;
        // CdReportMail.RUN;
    end;

    var
        CdReportMail: Codeunit "Report Mail Utility";
        Text19077561: Label 'Auto PDF Generation - Form';

    local procedure OnTimer()
    begin
        CLEAR(CdReportMail);
        CdReportMail.GEneratePDFs;
    end;
}

