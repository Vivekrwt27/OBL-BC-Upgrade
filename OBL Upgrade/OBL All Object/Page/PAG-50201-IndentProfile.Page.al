page 50201 "Indent Profile"
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                part(CompanyInfo; "CompanyInfo")
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
            group(Control1000000012)
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
            action("Consumption Report")
            {
                Caption = 'Consumption Report';
                ///RunObject = Report 50068;
                ApplicationArea = All;
            }
            action("Production Alert Report")
            {
                Caption = 'Production Alert Report';
                RunObject = Report "Production Alert Six Month";
                ApplicationArea = All;
            }
            action("Indent Detail")
            {
                Caption = 'Indent Detail';
                RunObject = Report "Indent Detail";
                ApplicationArea = All;
            }
            action("Inventory Valuation Report")
            {
                Caption = 'Inventory Valuation Report';
                RunObject = Report "Inventory Valuation Report";
                ApplicationArea = All;
            }
            action("store inventory")
            {
                Caption = 'store inventory';
                RunObject = Report "store inventory";
                ApplicationArea = All;
            }
            action("Warehouse Receipt(Final)")
            {
                Caption = 'Warehouse Receipt(Final)';
                RunObject = Report "Warehouse Receipt(Final)";
                ApplicationArea = All;
            }
            action("Sales Journal")
            {
                Caption = 'Sales Journal';
                RunObject = Report "Sales Journal";
                ApplicationArea = All;
            }
            action("Plant Wise Size Wise Prod.")
            {
                RunObject = Report "Update Matrix Master";
                ApplicationArea = All;
            }
        }
        area(embedding)
        {
            action("Capex Master")
            {
                RunObject = Page "Regular Budget Master List";
                ApplicationArea = All;
            }
            action("Vendor Requisition")
            {
                Caption = 'Vendor Requisition';
                RunObject = Page "Vendor Requisition List";
                ApplicationArea = All;
            }
            action("Indent Header")
            {
                Caption = 'Indent Header';
                RunObject = Page "Indent Header List";
                ApplicationArea = All;
            }
            action("Item Created List")
            {
                Caption = 'Item Created List';
                RunObject = Page "Item Created List";
                ApplicationArea = All;
            }
            action("Closed Indent")
            {
                Caption = 'Closed Indent';
                RunObject = Page "Indent Header List";
                RunPageView = WHERE("Status" = FILTER("Closed"));
                ApplicationArea = All;
            }
            action("Vendor Card")
            {
                RunObject = Page "Vendor List";
                ApplicationArea = All;
            }
            group("Issue Slip1")
            {
                Caption = 'Issue Slip';
                Image = FiledPosted;
                action("Issue Slip")
                {
                    Caption = 'Issue Slip';
                    RunObject = Page "Issue Slip List";
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

