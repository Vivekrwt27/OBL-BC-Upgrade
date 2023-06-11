page 50207 "Supply Chain"
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    UsageCategory = Lists;
    ApplicationArea = all;


    layout
    {
        area(rolecenter)
        {
            group(GERNAL)
            {
                part(CompanyInfo; CompanyInfo)
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group(CONTROL)
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
            action("Closing Stock - Store New")
            {
                Caption = 'Closing Stock - Store New';
                RunObject = Report "Closing Stock - Store New";
                ApplicationArea = All;
            }
            action("Closing Stock Marketing")
            {
                Caption = 'Closing Stock Marketing';
                RunObject = Report "Closing Stock Marketing";
                ApplicationArea = All;
            }
            action("Warehouse Receipt(Final)")
            {
                Caption = 'Warehouse Receipt(Final)';
                RunObject = Report "Warehouse Receipt(Final)";
                ApplicationArea = All;
            }
            action("Location Wise Stock")
            {
                Caption = 'Location Wise Stock';
                RunObject = Report "Location Wise Stock";
                ApplicationArea = All;
            }
            action("Sales Data (Sales Journal New)")
            {
                Caption = 'Sales Data (Sales Journal New)';
                RunObject = Report "Sales Data (Sales Journal New)";
                ApplicationArea = All;
            }
            action("State Cust.Wise SalesJrnl")
            {
                Caption = 'State Cust.Wise SalesJrnl';
                RunObject = Report "State Cust.Wise SalesJrnl Mod";
                ApplicationArea = All;
            }
            action("Transfer Journal")
            {
                Caption = 'Transfer Journal';
                RunObject = Report "Transfer Journal";
                ApplicationArea = All;
            }
            action("Date Wise Invoice Wise Sales")
            {
                Caption = 'Date Wise Invoice Wise Sales';
                RunObject = Report "Date Wise Invoice Wise Sales";
                ApplicationArea = All;
            }
            action("Show Consump With Zero New")
            {
                Caption = 'Show Consump With Zero New';
                // RunObject = Report 50271;
                ApplicationArea = All;
            }
            action("Pending Intran")
            {
                Caption = 'Pending Intran';
                Image = "Report";
                RunObject = Report "Pending Intran";
                ApplicationArea = All;
            }
            action("Production Alert Report")
            {
                Caption = 'Production Alert Report';
                RunObject = Report "Production Alert Report";
                ApplicationArea = All;
            }
            action("Production Alert Six Month")
            {
                Caption = 'Production Alert Six Month';
                RunObject = Report "Production Alert Six Month";
                ApplicationArea = All;
            }
            action("New State Cust. Wise Sales Cr.")
            {
                Caption = 'New State Cust. Wise Sales Cr.';
                Image = "Report";
                RunObject = Report "New State Cust. Wise Sales Cr.";
                ApplicationArea = All;
            }
            action("Item Stock by Location")
            {
                Caption = 'Item Stock by Location';
                RunObject = Report "Item Stock by Location";
                ApplicationArea = All;
            }
            action("Inventory Ageing Report new")
            {
                Caption = 'Inventory Ageing Report new';
                RunObject = Report "Inventory Ageing.";
                ApplicationArea = All;
            }
            action("Item Age Composition - Qty.")
            {
                Caption = 'Item Age Composition - Qty.';
                RunObject = Report "Item Age Composition - Qty.";
                ApplicationArea = All;
            }
            action("Sales and Stock Report")
            {
                Caption = 'Sales and Stock Report';
                RunObject = Report "Size-Wise Summ. of finishd gd4";
                ApplicationArea = All;
            }
        }
        area(embedding)
        {
            action("Item List")
            {
                Caption = 'Item List';
                RunObject = Page "Item List";
                ApplicationArea = All;
            }
            action("Posted Sales Invoices")
            {
                Caption = 'Posted Sales Invoices';
                RunObject = Page "Posted Sales Invoices";
                ApplicationArea = All;
            }
            action("Vendor Requisition")
            {
                Caption = 'Vendor Requisition';
                RunObject = Page "Vendor Requisition List";
                ApplicationArea = All;
            }
            action("Posted Transfer Shipments")
            {
                Caption = 'Posted Transfer Shipments';
                RunObject = Page "Posted Transfer Shipments";
                ApplicationArea = All;
            }
            action("Posted Transfer Receipts")
            {
                Caption = 'Posted Transfer Receipts';
                RunObject = Page "Posted Transfer Receipts";
                ApplicationArea = All;
            }
            action("Sales Line Data")
            {
                RunObject = Page "Sales Invoice Header Ashok";
                ApplicationArea = All;
            }
            action("Generate E Way Bill Invv New")
            {
                RunObject = Page "Generate E Way Bill Invv New";
                ApplicationArea = All;
            }
            action("Generate EWay Bill Trfr New")
            {
                Caption = 'Generate EWay Bill Trfr New';
                RunObject = Page "Generate EWay Bill Trfr New";
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

