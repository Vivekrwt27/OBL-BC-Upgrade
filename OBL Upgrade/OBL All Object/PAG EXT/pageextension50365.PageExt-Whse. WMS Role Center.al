pageextension 50365 pageextension50365 extends "Whse. WMS Role Center"
{
    layout
    {
        addafter(ApprovalsActivities)
        {
            part("Report Inbox Part"; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = R;
                ApplicationArea = All;
            }
        }
    }
}

