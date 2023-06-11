pageextension 50366 pageextension50366 extends "Bookkeeper Role Center"
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

