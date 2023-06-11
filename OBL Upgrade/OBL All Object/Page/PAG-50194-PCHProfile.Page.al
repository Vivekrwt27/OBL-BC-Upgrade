page 50194 "PCH Profile"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                Visible = true;
                part(CompanyInfo; CompanyInfo)
                {
                    ShowFilter = false;
                    ApplicationArea = All;
                }
                part("SO Processor Activities"; "SO Processor Activities")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group(Control1900724708)
            {
                Visible = false;
                part("Trailing Sales Orders Chart"; "Trailing Sales Orders Chart")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                part("My Job Queue"; "My Job Queue")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                part("My Customers"; "My Customers")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                part("My Items"; "My Items")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                part("Copy Profile"; "Copy Profile")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                systempart(MyNotes; MyNotes)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
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
            action("Customer Ledger")
            {
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Customer Ledger New (Depot)";
                ApplicationArea = All;
            }
            action("Customer Detailed Aging")
            {
                /// RunObject = Report 50356;
                ApplicationArea = All;
            }
            action("Customer - Ageing")
            {
                RunObject = Report "Customer - Ageing (Depot)";
                ApplicationArea = All;
            }
            action("Customer - Ageing Due Date")
            {
                RunObject = Report "Customer - Ageing Due Date";
                ApplicationArea = All;
            }
            action("Sales Journa")
            {
                RunObject = Report "Sales Journa(lDepot)";
                ApplicationArea = All;
            }
            action("State Cust. Wise SalesJournal")
            {
                RunObject = Report "State Cust. Wise SalesJournal";
                ApplicationArea = All;
            }
        }
        area(creation)
        {
            action("Sales &Order")
            {
                Caption = 'Sales &Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 42;
                RunPageMode = Create;
                ApplicationArea = All;
            }
        }
    }
}

