page 50250 "Vendor Inventory Management1"
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(rolecenter)
        {
            group(Gernal)
            {
                part(CompanyInfo; CompanyInfo)
                {
                    ApplicationArea = All;
                }
                part("SO Processor Activities"; "SO Processor Activities")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group(Control)
            {
                Visible = true;
                part("My Job Queue"; "My Job Queue")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                part("My Customers"; "My Customers")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                part("Connect Online"; "Copy Profile")
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
            action("Closing Stock - Store Associat")
            {
                Caption = 'Closing Stock - Store Associat';
                RunObject = Report "Closing Stock - Store Associat";
                ApplicationArea = All;
            }
        }
        area(embedding)
        {
            group(Indenting)
            {
                Caption = 'Indenting';
                action("Item Journal Batches")
                {
                    Caption = 'Item Journal Batches';
                    RunObject = Page "Item Journal Batches";
                    RunPageMode = Create;
                    ApplicationArea = All;
                }
                action("Prod. Reporting List")
                {
                    Caption = 'Prod. Reporting List';
                    RunObject = Page "Prod. Reporting List";
                    ApplicationArea = All;
                }
                action("Morbi Inventory Block")
                {
                    Caption = 'Morbi Inventory Block';
                    RunObject = Page "Morbi Inventory Block";
                    ApplicationArea = All;
                }
                action("Item List")
                {
                    Caption = 'Item List';
                    RunObject = Page "Item List";
                    ApplicationArea = All;
                }
            }
            action("Reservation Entry Ass. Vendor")
            {
                Caption = 'Reservation Entry Ass. Vendor';
                RunObject = Page "Reservation Entry Ass. Vendor";
                ApplicationArea = All;
            }
            separator(Action1500023)
            {
                IsHeader = true;
            }
        }
    }
}

