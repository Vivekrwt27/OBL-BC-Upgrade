page 60001 "Auto Batch Started"
{
    PageType = Card;
    SourceTable = "Auto Batch Started";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Report ID"; Rec."Report ID")
                {
                    ApplicationArea = All;
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = All;
                }
                field("End Time"; Rec."End Time")
                {
                    ApplicationArea = All;
                }
                field(BatchStarted; Rec.BatchStarted)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        SIH: Record "Sales Invoice Header";
        SIL: Record "Sales Invoice Line";

    local procedure OnTimer()
    begin
        IF NOT Rec.BatchStarted AND (Rec."Report ID" <> 0) THEN
            IF (TIME >= Rec."Start Time") AND (TIME <= Rec."End Time") THEN BEGIN
                SIH.SETRANGE("Posting Date", TODAY);
                SIL.SETFILTER("Unit of Measure Code", 'CRT');
                REPORT.RUNMODAL(Report::"Sales Journal", TRUE, TRUE, SIL);
                Rec.BatchStarted := TRUE;
                Rec.MODIFY;
            END;
    end;
}

