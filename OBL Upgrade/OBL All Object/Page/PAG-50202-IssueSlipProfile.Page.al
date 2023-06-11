page 50202 "Issue Slip Profile"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                part(CompanyInfo; CompanyInfo)
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                part("Finance Reports"; "Finance Reports")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group(Control1000000005)
            {
                part("Report Inbox Part"; "Report Inbox Part")
                {
                    AccessByPermission = TableData "Report Inbox" = R;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Indent Detail")
            {
                Caption = 'Indent Detail';
                RunObject = Report "Indent Detail";
                ApplicationArea = All;
            }
        }
        area(embedding)
        {
            action("Issue Slip")
            {
                Caption = 'Issue Slip';
                RunObject = Page "Transfer Orders";
                ApplicationArea = All;
            }
            action("Posted Issue Slip")
            {
                Caption = 'Posted Issue Slip';
                RunObject = Page "Posted Transfer Shipments";
                ApplicationArea = All;
            }
            action("Posted Issue Receipt")
            {
                Caption = 'Posted Issue Receipt';
                RunObject = Page "Posted Transfer Receipts";
                ApplicationArea = All;
            }
            action("Issue Slip receipt Detail")
            {
                Caption = 'Issue Slip receipt Detail';
                RunObject = Page "Posted Transfer Receipt Lines";
                RunPageView = WHERE("Document No." = CONST('ISS*'));
                ApplicationArea = All;
            }
        }
        area(sections)
        {
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            separator(History)
            {
                Caption = 'History';
                IsHeader = true;
            }
            action("Navi&gate")
            {
                Caption = 'Navi&gate';
                Image = Navigate;
                RunObject = Page Navigate;
                ApplicationArea = All;
            }
        }
    }
}

