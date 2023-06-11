page 50236 "Morbi Location"
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
            action("Customer Detailed Ageing")
            {
                ///  RunObject = Report 50356;
                ApplicationArea = All;
            }
            action("Inventory Ageing Report new")
            {
                Caption = 'Inventory Ageing Report new';
                RunObject = Report "Inventory Ageing.";
                ApplicationArea = All;
            }
            action("Closing Stock Store")
            {
                RunObject = Report "Item Stock by Location..";
                ApplicationArea = All;
            }
            action("State Cust.Wise SalesJrnl Mod")
            {
                Caption = 'State Cust.Wise SalesJrnl Mod';
                RunObject = Report "State Cust.Wise SalesJrnl Mod";
                ApplicationArea = All;
            }
            action("Customer Age Bill Date Basis")
            {
                RunObject = Report "Customer - Ageing (30-35 days)";
                ApplicationArea = All;
            }
            action("Purchase V/S Dispatch Report")
            {
                Caption = 'Purchase V/S Dispatch Report';
                RunObject = Report "Purchase V/S Dispatch Report";
                ApplicationArea = All;
            }
            action("Closing Stock Marketing")
            {
                Caption = 'Closing Stock Marketing';
                RunObject = Report "Closing Stock Marketing";
                ApplicationArea = All;
            }
            action("Customer Ageing - Due Date")
            {
                RunObject = Report "Customer - Ageing Due Date";
                ApplicationArea = All;
            }
            action("Date Wise Invoice Wise Sales")
            {
                Caption = 'Date Wise Invoice Wise Sales';
                RunObject = Report "Date Wise Invoice Wise Sales";
                ApplicationArea = All;
            }
            action("Purchase Reportexcel1new")
            {
                Caption = 'Purchase Reportexcel1new';
                RunObject = Report "Purchase Reportexcel1new";
                ApplicationArea = All;
            }
            action("Transfer Journal")
            {
                Caption = 'Transfer Journal';
                RunObject = Report "Transfer Journal";
                ApplicationArea = All;
            }
            action("Closing Stock - Store Associat")
            {
                Caption = 'Closing Stock - Store Associat';
                RunObject = Report "Closing Stock - Store Associat";
                ApplicationArea = All;
            }
            action("Sales Data (Sales Journal New)")
            {
                Caption = 'Sales Data (Sales Journal New)';
                RunObject = Report "Sales Data (Sales Journal New)";
                ApplicationArea = All;
            }
            action("Customer - Ageing")
            {
                RunObject = Report "Customer - Ageing (Depot)";
                ApplicationArea = All;
            }
            action("Location Wise Stock")
            {
                Caption = 'Location Wise Stock';
                RunObject = Report "Location Wise Stock";
                ApplicationArea = All;
            }
            action("Location Wise Breakage")
            {
                Caption = 'Location Wise Breakage';
                RunObject = Report "Location Wise Breakage";
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
            action("Transfer Order External")
            {
                RunObject = Page "Transfer List-External";
                ApplicationArea = All;
            }
            action("Morbi Sales Line")
            {
                Caption = 'Morbi Sales Line';
                RunObject = Page "Morbi Sales Line";
                ApplicationArea = All;
            }
            action("Open Purchase Order")
            {
                Caption = 'Open Purchase Orders';
                RunObject = Page "Purchase Order List";
                ApplicationArea = All;
            }
            action("Item Created List")
            {
                Caption = 'Item Created List';
                RunObject = Page "Item Created List";
                ApplicationArea = All;
            }
            action("Vendor Requisition")
            {
                Caption = 'Vendor Requisition';
                RunObject = Page "Vendor Requisition List";
                ApplicationArea = All;
            }
            action("Released Purchase Order")
            {
                RunObject = Page "Purchase order Released list";
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
            action(Customers)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
                ApplicationArea = All;
            }
            action("Sample Breakage Order")
            {
                RunObject = Page "sample brk  Pod Order List";
                ApplicationArea = All;
            }
            action("Short/Excess Adjustment")
            {
                RunObject = Page "Item Adjustment";
                ApplicationArea = All;
            }
            action("Generate E Way Bill Invoice")
            {
                RunObject = Page "Generate E Way Bill Invoice";
                ApplicationArea = All;
            }
            action("Generate E Way Bill Invv New")
            {
                RunObject = Page "Generate E Way Bill Invv New";
                ApplicationArea = All;
            }
            action("Generate E Way Bill Transfer")
            {
                Caption = 'Generate E Way Bill Transfer';
                RunObject = Page "Generate E Way Bill Transfer";
                ApplicationArea = All;
            }
            action("Generate EWay Bill Trfr New")
            {
                Caption = 'Generate EWay Bill Trfr New';
                RunObject = Page "Generate EWay Bill Trfr New";
                ApplicationArea = All;
            }
            action("RGP Out Header")
            {
                Caption = 'RGP Out Header';
                RunObject = Page "RGP Out List";
                RunPageView = WHERE("Document Type" = FILTER(Out),
                                Posted = FILTER(false));
                ApplicationArea = All;


            }
            action("RGP In Header")
            {
                Caption = 'RGP In Header';
                RunObject = Page "RGP Out List";
                RunPageView = WHERE("Document Type" = FILTER("In"),
                                    Posted = FILTER(false));
                ApplicationArea = All;
            }
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
            action("Vehicle Reminder Report")
            {
                RunObject = Page "Vehicle Reminder Report";
                ApplicationArea = All;
            }
            action("Item List")
            {
                Caption = 'Item List';
                RunObject = Page "Item List";
                ApplicationArea = All;
            }
            action("Reservation Entry Ass. Vendor")
            {
                Caption = 'Reservation Entry Ass. Vendor';
                RunObject = Page "Reservation Entry Ass. Vendor";
                ApplicationArea = All;
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
                    RunObject = Page "Posted Transfer Receipts";
                    ApplicationArea = All;
                }
                action("Posted Purchase Receipts")
                {
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    ApplicationArea = All;
                }
                action("Finished Production Orders")
                {
                    RunObject = Page "Finished Production Orders";
                    ApplicationArea = All;
                }
                action("Sales Line Detail")
                {
                    Caption = 'Sales Line Detail';
                    RunObject = Page "Sales Line Detail";
                    ApplicationArea = All;
                }
                action("Posted RGP Out")
                {
                    Caption = 'Posted RGP Out';
                    RunObject = Page "Posted RGP Out List";
                    ApplicationArea = All;
                }
                action("Posted RGP In")
                {
                    Caption = 'Posted RGP In';
                    RunObject = Page "Posted RGP In List";
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

