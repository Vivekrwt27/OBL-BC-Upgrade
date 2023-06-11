page 50205 Warehouse
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
            group(GERNAL1)
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
            action("Size-Wise Summ. of finishd gd2")
            {
                Caption = 'Size-Wise Summ. of finishd gd2';
                RunObject = Report "Size-Wise Summ. of finshd New";
                ApplicationArea = All;
            }
            action("Warehouse Summary")
            {
                Caption = 'Warehouse Summary';
                RunObject = Report "Warehouse Summary";
                ApplicationArea = All;
            }
            action("Item Age Composition - Qty.")
            {
                Caption = 'Item Age Composition - Qty.';
                RunObject = Report "Item Age Composition - Qty.";
                ApplicationArea = All;
            }
            action("Item Stock by Location")
            {
                Caption = 'Item Stock by Location';
                RunObject = Report "Item Stock by Location";
                ApplicationArea = All;
            }
            action("Date Wise Invoice Wise Sales")
            {
                Caption = 'Date Wise Invoice Wise Sales';
                RunObject = Report "Date Wise Invoice Wise Sales";
                ApplicationArea = All;
            }
            action("Production Planning Report")
            {
                Caption = 'Production Planning Report';
                RunObject = Report "Production Planning Report";
                ApplicationArea = All;
            }
            action("State Cust.Wise SalesJrnl")
            {
                Caption = 'State Cust.Wise SalesJrnl';
                RunObject = Report "Sales Data (Sales Journal)";
                ApplicationArea = All;
            }
            action("Internal Transfer Summry & Det")
            {
                Caption = 'Internal Transfer Summry & Det';
                RunObject = Report "Internal Transfer Summry & Det";
                ApplicationArea = All;
            }
            action("Stock Detail")
            {
                Caption = 'Stock Detail';
                RunObject = Report "Stock Report";
                ApplicationArea = All;
            }
            action("Archive Data")
            {
                Caption = 'Archive Data';
                RunObject = Report "Archive Data";
                ApplicationArea = All;
            }
            action("Internal Warehouse Receipt")
            {
                Caption = 'Internal Warehouse Receipt';
                RunObject = Report "Internal Warehouse Receipt";
                ApplicationArea = All;
            }
            action("Warehouse Receipt(Final)")
            {
                Caption = 'Warehouse Receipt(Final)';
                RunObject = Report "Warehouse Receipt(Final)";
                ApplicationArea = All;
            }
            action("Item Wise Despatch")
            {
                Caption = 'Item Wise Despatch';
                RunObject = Report "Item Wise Despatch";
                ApplicationArea = All;
            }
            action("Closing Stock Sample")
            {
                Caption = 'Closing Stock Sample';
                RunObject = Report "Closing Stock Sample";
                ApplicationArea = All;
            }
            action("Closing Stock Marketing")
            {
                Caption = 'Closing Stock Marketing';
                RunObject = Report "Closing Stock Marketing";
                ApplicationArea = All;
            }
            action("Location Wise Stock")
            {
                Caption = 'Location Wise Stock';
                RunObject = Report "Location Wise Stock";
                ApplicationArea = All;
            }
            action("Dispatch Plan")
            {
                Caption = 'Dispatch Plan';
                RunObject = Report "Dispatch Plan";
                ApplicationArea = All;
            }
            action("Excise Details")
            {
                Caption = 'Excise Details';
                RunObject = Report "Excise Details";
                ApplicationArea = All;
            }
            action("Sales Data (Sales Journal)")
            {
                Caption = 'Sales Data (Sales Journal)';
                RunObject = Report "Sales Data (Sales Journal)";
                ApplicationArea = All;
            }
            action("Dispatch Remarks Update")
            {
                Caption = 'Dispatch Remarks Update';
                RunObject = XMLport "Sales Order Remarks Update";
                ApplicationArea = All;
            }
            action("Closing Stock Store")
            {
                Caption = 'Closing Stock Store';
                RunObject = Report "Closing Stock - Store New";
                ApplicationArea = All;
            }
            action("Mobile App Order Creation")
            {
                Caption = 'Transfer to SO Creation';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Transfer to SO Creation";
                ApplicationArea = All;
            }
        }
        area(embedding)
        {
            action(Item)
            {
                Caption = 'Item';
                RunObject = Page "Item List";
                ApplicationArea = All;
            }
            action("Sales Order")
            {
                Caption = 'Sales Order';
                RunObject = Page "Sales Order List";
                ApplicationArea = All;
            }
            action("Daily Dispatch Plan")
            {
                Caption = 'Daily Dispatch Plan';
                RunObject = Page "Dispatch Plan";
                ApplicationArea = All;
            }
            action("Transfer Order Internal")
            {
                Caption = 'Transfer Order Internal';
                RunObject = Page "Transfer Orders";
                ApplicationArea = All;
            }
            action("Sales Line Detail")
            {
                RunObject = Page "Sales Line Detail";
                ApplicationArea = All;
            }
            action("Purchase Order")
            {
                Caption = 'Purchase Order';
                RunObject = Page "Purchase Order List";
                ApplicationArea = All;
            }
            action("Customer Card")
            {
                Caption = 'Customer Card';
                RunObject = Page "Customer List";
                ApplicationArea = All;
            }
            action("Transfer Order External")
            {
                RunObject = Page "Transfer List-External";
                ApplicationArea = All;
            }
            action("Wharehouse Inv Management")
            {
                Caption = 'Wharehouse Inv Management';
                RunObject = Page 50255;
            }

            action("Item Journal  Adjustment")
            {
                Caption = 'Item Journal  Adjustment';
                RunObject = Page "Item Adjustment";
                ApplicationArea = All;
            }
            action("Sample Breakage Order")
            {
                RunObject = Page "sample brk  Pod Order List";
                ApplicationArea = All;
            }
            action("Generate E Way Bill Invoice")
            {
                Caption = 'Generate E Way Bill Invoice';
                RunObject = Page "Generate E Way Bill Invoice";
                ApplicationArea = All;
            }
            action(" Generate E Way Bill Transfer")
            {
                Caption = ' Generate E Way Bill Transfer';
                RunObject = Page "Generate E Way Bill Transfer";
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
            action("Mis C-Form")
            {
                Caption = 'Mis C-Form';
                RunObject = Page "Mis C-Form";
                ApplicationArea = All;
            }
        }
        area(sections)
        {
            group(Indenting)
            {
                Caption = 'Indenting';
                action("Indent Header")
                {
                    Caption = 'Indent Header';
                    RunObject = Page "Indent Header List";
                    ApplicationArea = All;
                }
                action("Closed Indent")
                {
                    Caption = 'Closed Indent';
                    RunObject = Page "Indent Header List";
                    RunPageView = WHERE(Status = FILTER(Closed));
                    ApplicationArea = All;
                }
            }
            group("Issue Slip")
            {
                Caption = 'Issue Slip';
                Image = FiledPosted;
                action("Issue Slip1")
                {
                    Caption = 'Issue Slip';
                    RunObject = Page "Transfer Orders";
                    ApplicationArea = All;
                }
            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action("Posted Purchase Receipts")
                {
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    ApplicationArea = All;
                }
                action(" Posted Sales Invoices")
                {
                    Caption = ' Posted Sales Invoices';
                    RunObject = Page "Posted Sales Invoices";
                    ApplicationArea = All;
                }
                action("Posted Sales Shipments")
                {
                    Caption = 'Posted Sales Shipments';
                    RunObject = Page "Posted Sales Shipments";
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
                action("Finished Production Orders")
                {
                    RunObject = Page "Finished Production Orders";
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
        area(creation)
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

