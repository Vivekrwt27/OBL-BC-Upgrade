page 50198 "Order Processing Department"
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
                Visible = true;
                part("Trailing Sales Orders Chart"; "Trailing Sales Orders Chart")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
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
            action("State Cust.Wise SalesJrnl")
            {
                RunObject = Report "State Cust.Wise SalesJrnl Mod";
                ApplicationArea = All;
            }
            action("Closing Stock - Store New")
            {
                Caption = 'Closing Stock - Store New';
                RunObject = Report "Closing Stock - Store New";
                ApplicationArea = All;
            }
            action("Sales Journal")
            {
                Caption = 'Sales Journal';
                RunObject = Report "Sales Journal";
                ApplicationArea = All;
            }
            action("Customer - Ageing (30-35 days)")
            {
                Caption = 'Customer - Ageing (30-35 days)';
                RunObject = Report "Customer - Ageing (30-35 days)";
                ApplicationArea = All;
            }
            action("Customer - Ageing Due Date")
            {
                Caption = 'Customer - Ageing Due Date';
                RunObject = Report "Customer - Ageing Due Date";
                ApplicationArea = All;
            }
            action("Transfer Journal")
            {
                Caption = 'Transfer Journal';
                RunObject = Report "Transfer Journal";
                ApplicationArea = All;
            }
            action("Indent Detail")
            {
                Caption = 'Indent Detail';
                RunObject = Report "Indent Detail";
                ApplicationArea = All;
            }
            action("Production Alert Report")
            {
                Caption = 'Production Alert Report';
                RunObject = Report "Production Alert Report";
                ApplicationArea = All;
            }
            action("StockTransfer Received")
            {
                Caption = 'StockTransfer Received';
                ///  RunObject = Report 50201;
                ApplicationArea = All;
            }
            action(" Sales Data (Sales Journal)")
            {
                Caption = ' Sales Data (Sales Journal)';
                RunObject = Report "Sales Data (Sales Journal)";
                ApplicationArea = All;
            }
            action("Dispatch Plan")
            {
                Caption = 'Dispatch Plan';
                RunObject = Report "Dispatch Plan";
                ApplicationArea = All;
            }
            action("Transfer to SO Creation")
            {
                Caption = 'Transfer to SO Creation';
                RunObject = Report "Transfer to SO Creation";
                Visible = false;
                ApplicationArea = All;
            }
            action("Transfer Detail")
            {
                Caption = 'Transfer Detail';
                RunObject = Report "Sales Order List";
                ApplicationArea = All;
            }
            action("Inventory Ageing")
            {
                Caption = 'Inventory Ageing';
                RunObject = Report "Inventory Ageing -MGT";
                ApplicationArea = All;
            }
            action("Warehouse Receipt(Final)")
            {
                Caption = 'Warehouse Receipt(Final)';
                RunObject = Report "Warehouse Receipt(Final)";
                ApplicationArea = All;
            }
            action("Inventory Ageing.")
            {
                Caption = 'Inventory Ageing.';
                RunObject = Report "Inventory Ageing.";
                ApplicationArea = All;
            }
            action("New State Cust. Wise Sales Cr.")
            {
                Caption = 'New State Cust. Wise Sales Cr.';
                RunObject = Report "New State Cust. Wise Sales Cr.";
                ApplicationArea = All;
            }
            action("Closing Stock Marketing")
            {
                Caption = 'Closing Stock Marketing';
                RunObject = Report "Closing Stock Marketing";
                ApplicationArea = All;
            }
            action("Sales Data (Sales Journal)")
            {
                RunObject = Report "Sales Data (Sales Journal)";
                ApplicationArea = All;
            }
            action("BOM Vs Actual Report")
            {
                Caption = 'BOM Vs Actual Report';
                RunObject = Report "BOM Vs Actual Report";
                ApplicationArea = All;
            }
        }
        area(embedding)
        {
            action("sales order")
            {
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page "Sales Order List";
                ApplicationArea = All;
            }
            action(GIT)
            {
                Caption = 'GIT';
                RunObject = Page GIT;
                ApplicationArea = All;
            }
            action("Vendor Requisition")
            {
                Caption = 'Vendor Requisition';
                RunObject = Page "Vendor Requisition List";
                ApplicationArea = All;
            }
            action("Blanket Order")
            {
                Caption = 'Blanket Order';
                RunObject = Page "Blanket Order List";
                ApplicationArea = All;
            }
            action("Transfer Order External")
            {
                RunObject = Page "Transfer List-External";
                ApplicationArea = All;
            }
            action("Open Purchase Order")
            {
                Caption = 'Open Purchase Orders';
                RunObject = Page "Purchase Order List";
                ApplicationArea = All;
            }
            action("Sales Line Detail")
            {
                Caption = 'Sales Line Detail';
                RunObject = Page "Sales Line Detail";
                ApplicationArea = All;
            }
            action(Items)
            {
                Caption = 'Items';
                Image = Item;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Item List";
                ApplicationArea = All;
            }
            action("Capexr Master List")
            {
                Caption = 'Capexr Master List';
                RunObject = Page "Regular Budget Master List";
                ApplicationArea = All;
            }
            action(Customers)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
                ApplicationArea = All;
            }
            action("Item Created List")
            {
                Caption = 'Item Created List';
                RunObject = Page "Item Created List";
                ApplicationArea = All;
            }
            action("Delegation of Authority")
            {
                Caption = 'Delegation of Authority';
                RunObject = Page "Delegation of Authority";
                ApplicationArea = All;
            }
            group(Indenting)
            {
                Caption = 'Indenting';
                action("Indent Header")
                {
                    Caption = 'Indent Header';
                    RunObject = Page "Indent Header List";
                    RunPageMode = Create;
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
            separator(Action1500023)
            {
                IsHeader = true;
            }
        }
        area(sections)
        {
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action("Posted Sales Shipments")
                {
                    Caption = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page "Posted Sales Shipments";
                    ApplicationArea = All;
                }
                action("Posted Sales Invoices")
                {
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                    ApplicationArea = All;
                }
                action("Posted Transfer Shipment")
                {
                    RunObject = Page "Posted Transfer Shipments";
                    ApplicationArea = All;
                }
                action("Posted Transfer Receipt")
                {
                    RunObject = Page "Posted Return Receipts";
                    ApplicationArea = All;
                }
                action("Posted Purchase Receipts")
                {
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
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

