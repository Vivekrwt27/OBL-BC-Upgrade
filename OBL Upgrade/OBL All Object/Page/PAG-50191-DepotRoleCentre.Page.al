page 50191 "Depot Role Centre"
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(rolecenter)
        {
            group(gernal)
            {
                /*   part(CompanyInfo; 50192)
                   {
                       ApplicationArea = All;
                   }*/
                part("SO Processor Activities"; "SO Processor Activities")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group(line)
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
                part("Credit Memo Lines Subform"; "Copy Profile")
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
                // RunObject = Report 50356;
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
            action("Customer Age Bill Date Basis")
            {
                RunObject = Report "Customer - Ageing (30-35 days)";
                ApplicationArea = All;
            }
            action("Customer Ageing - Due Date")
            {
                RunObject = Report "Customer - Ageing Due Date";
                ApplicationArea = All;
            }
            action("Form Wise Detail for Depot Transfer.")
            {
                Caption = 'Form Wise Detail for Depot Transfer.';
                //  RunObject = Report 50357;
                ApplicationArea = All;
            }
            action("Date Wise Invoice Wise Sales")
            {
                Caption = 'Date Wise Invoice Wise Sales';
                RunObject = Report "Date Wise Invoice Wise Sales";
                ApplicationArea = All;
            }
            action(" Transfer Journal")
            {
                Caption = ' Transfer Journal';
                RunObject = Report "Transfer Journal";
                ApplicationArea = All;
            }
            action("Purchase Reportexcel1new")
            {
                Caption = 'Purchase Reportexcel1new';
                RunObject = Report "Purchase Reportexcel1new";
                ApplicationArea = All;
            }
            action("Sales Journal")
            {
                RunObject = Report "Sales Journa(lDepot) New";
                ApplicationArea = All;
            }
            action("Cust State Wise Sales Journal")
            {
                RunObject = Report "State Cust.Wise SalesJrnl-New";
                ApplicationArea = All;
            }
            action("Size State Wise Montly Sales")
            {
                RunObject = Report "Size/StateWise Mnthly New";
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
            action("Sales Order List")
            {
                Caption = 'Sales Order List';
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
                //  RunObject = Page 50307;
                ApplicationArea = All;
            }
            action("Open Purchase Order")
            {
                Caption = 'Open Purchase Orders';
                RunObject = Page "Purchase Order List";
                ApplicationArea = All;
            }
            action("Released Purchase Order")
            {
                ApplicationArea = All;
                // RunObject = Page "Purchase order Released list";
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
                ApplicationArea = All;
                // RunObject = Page "Item Adjustment";
            }
            action("Generate E Way Bill Invoice")
            {
                //    RunObject = Page 50240;
                ApplicationArea = All;
            }
            action("Generate E Way Bill Invv New")
            {
                //  RunObject = Page 50237;
                ApplicationArea = All;
            }
            action("Generate E Way Bill Transfer")
            {
                Caption = 'Generate E Way Bill Transfer';
                //RunObject = Page 50242;
                ApplicationArea = All;
            }
            action("Generate EWay Bill Trfr New")
            {
                Caption = 'Generate EWay Bill Trfr New';
                // RunObject = Page 50239;
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
                RunObject = Page "RGP In List";
                RunPageView = WHERE("Document Type" = FILTER(In),
                                    Posted = FILTER(false));
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
                    ApplicationArea = All;
                    //RunObject = Page "Posted RGP Out List";
                }
                action("Posted RGP In")
                {
                    Caption = 'Posted RGP In';
                    ApplicationArea = All;
                    //RunObject = Page "Posted RGP In List";
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

