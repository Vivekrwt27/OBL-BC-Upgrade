page 50199 "Credit Control Department"
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    UsageCategory = Lists;
    ApplicationArea = all;


    layout
    {
        area(rolecenter)
        {
            group(General)
            {
                /*  part(CompanyInfo; 50192)
                  {
                      Visible = false;
                      ApplicationArea = All;
                  }*/
                part("SO Processor Activities"; "SO Processor Activities")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group(Line)
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
                part("Connect Online"; "Copy Profile")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                systempart(MyNotes; MyNotes)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                part("Finance Reports"; "Finance Reports")
                {
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
            action("New State Cust. Wise Sales (Return)")
            {
                Caption = 'New State Cust. Wise Sales (Return)';
                RunObject = Report "New State Cust. Wise Sales Cr.";
                ApplicationArea = All;
            }
            action("Closing Stock Marketing")
            {
                Caption = 'Closing Stock Marketing';
                RunObject = Report "Closing Stock Marketing";
                ApplicationArea = All;
            }
            action("Production Planing")
            {
                Caption = 'Production Planing';
                RunObject = Report "Production Planing";
                ApplicationArea = All;
            }
            action("Sales Line Details")
            {
                Caption = 'Sales Line Details';
                RunObject = Report "Sales Line Details";
                ApplicationArea = All;
            }
            action("Customer - Ageing Due Date")
            {
                Caption = 'Customer - Ageing Due Date';
                RunObject = Report "Customer - Ageing Due Date";
                ApplicationArea = All;
            }
            action("Bank Paying Slip")
            {
                Caption = 'Bank Paying Slip';
                RunObject = Report "Bank Paying Slip";
                ApplicationArea = All;
            }
            action("Posted Voucher")
            {
                Caption = 'Posted Voucher';
                RunObject = Report "Posted Voucher";
                ApplicationArea = All;
            }
            action("Archive Data")
            {
                RunObject = Report "Archive Data";
                ApplicationArea = All;
            }
            action("Credit Debit Note Mail")
            {
                Caption = 'Credit Debit Note Mail';
                RunObject = Report "Credit Debit Note Mail";
                ApplicationArea = All;
            }
            action(" Customer Application")
            {
                Caption = ' Customer Application';
                RunObject = Report "Customer Application";
                ApplicationArea = All;
            }
            action("Applied Entries To Voucher")
            {
                Caption = 'Applied Entries To Voucher';
                RunObject = Report "Applied Entries To Voucher";
                ApplicationArea = All;
            }
            action("Balance Confirmation")
            {
                Caption = 'Balance Confirmation';
                RunObject = XMLport "Balance Confirmation";
                ApplicationArea = All;
            }
            action("Sales Line")
            {
                Caption = 'Sales Line Update';
                Image = XMLFile;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = XMLport "Sales Line";
                ApplicationArea = All;
            }
            action("Transfer to SO Creation")
            {
                Caption = 'Transfer to SO Creation';
                RunObject = Report "Transfer to SO Creation";
                Visible = true;
                ApplicationArea = All;
            }
            action(" Customer - Ageing (30-35 days)")
            {
                Caption = ' Customer - Ageing (30-35 days)';
                RunObject = Report "Customer - Ageing (30-35 days)";
                ApplicationArea = All;
            }
            action("Dunning Letter")
            {
                Caption = 'Dunning Letter';
                RunObject = Report "Dunning Letter";
                ApplicationArea = All;
            }
            action("Vendor Requisition List")
            {
                Caption = 'Vendor Requisition List';
                RunObject = Page 50039;
            }

            action("Warehouse Receipt(Final)")
            {
                Caption = 'Warehouse Receipt(Final)';
                RunObject = Report "Warehouse Receipt(Final)";
                ApplicationArea = All;
            }
            action("Sales Collection Report")
            {
                RunObject = Report "Payment Collection Report";
                ApplicationArea = All;
            }
        }
        area(embedding)
        {
            action("Chart of Accounts")
            {
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
                ApplicationArea = All;
            }
            action("Customer Credit Rating")
            {
                Caption = 'Customer Credit Rating';
                Promoted = true;
                PromotedIsBig = true;
                //  RunObject = Page 50033;
                ApplicationArea = All;
            }
            action("Production Planning")
            {
                Caption = 'Production Planning';
                RunObject = Page 50235;
            }

            action("Vendor List")
            {
                Caption = 'Vendor List';
                Image = Item;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Vendor List";
                ApplicationArea = All;
            }
            action("Bank Account List")
            {
                Caption = 'Bank Account List';
                Image = Item;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Bank Account List";
                ApplicationArea = All;
            }
            action("Issue Credits")
            {
                Caption = 'Issue Online Credits Note';
                //   RunObject = Page 50034;
                ApplicationArea = All;
            }
            action("TCS Adjustment Journal")
            {
                Caption = 'TCS Adjustment Journal';
                RunObject = Page "TCS Adjustment Journal";
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
            action("Payment Journal")
            {
                RunObject = Page "Payment Journal";
                ApplicationArea = All;
            }
            action(Customers)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
                ApplicationArea = All;
            }
            action("Customer To Customer Contra")
            {
                Caption = 'Customer To Customer Contra';
                RunObject = Page "Customer To Customer Contra";
                ApplicationArea = All;
            }
            action("Blanket Order")
            {
                Caption = 'Blanket Order';
                RunObject = Page "Blanket Order List";
                ApplicationArea = All;
            }
            action("Indent Header")
            {
                Caption = 'Indent Header';
                //   RunObject = Page 50046;
                ApplicationArea = All;
            }
            action("sales order")
            {
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page "Sales Order List";
                ApplicationArea = All;
            }
            action("Goods In Transit")
            {
                Caption = 'Goods In Transit';
                //   RunObject = Page 50138;
                ApplicationArea = All;
            }
            action("Transfer Order External")
            {
                RunObject = Page "Transfer List-External";
                ApplicationArea = All;
            }
            action("General Journals")
            {
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Journal Template Name" = FILTER('GENERAL|OPENING'));
                Visible = true;
                ApplicationArea = All;
            }
            action("Sales Journals")
            {
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Journal Template Name" = FILTER('SALES'));
                ApplicationArea = All;
            }
            action("Open Purchase Order")
            {
                Caption = 'Open Purchase Orders';
                RunObject = Page "Purchase Order List";
                ApplicationArea = All;
            }
            action(" Mis C-Form")
            {
                Caption = ' Mis C-Form';
                Image = Customer;
                //  RunObject = Page 50075;
                ApplicationArea = All;
            }
            action("Morbi Sales Line")
            {
                Caption = 'Morbi Sales Line';
                //  RunObject = Page 50307;
                ApplicationArea = All;
            }
            action("Sales Credit Memos")
            {
                Caption = 'Sales Credit Memos';
                RunObject = Page "Sales Credit Memos";
                ApplicationArea = All;
            }
            action("Purchase Order")
            {
                Caption = 'Purchase Order';
                RunObject = Page "Purchase Order List";
                ApplicationArea = All;
            }
            action("Sales Debit Note")
            {
                Caption = 'Sales Debit Note ';
                RunObject = Page "Sales Invoice List";
                ApplicationArea = All;
            }
            action("Bank Receipt Voucher")
            {
                Caption = 'Bank Receipt Voucher';
                RunObject = Page "Bank Receipt Voucher";
                ApplicationArea = All;
            }
            action("Payment Commitment")
            {
                Caption = 'Payment Commitment';
                //  RunObject = Page 50235;
                ApplicationArea = All;
            }
            action("Purchase Invoices")
            {
                Caption = 'Purchase Invoices';
                RunObject = Page "Purchase Invoices";
                ApplicationArea = All;
            }
            action("Journal Voucher")
            {
                RunObject = Page "Journal Voucher";
                ApplicationArea = All;
            }
            separator(Control)
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
                action("LC Detail for Export")
                {
                    Caption = 'LC Detail for Export';
                    //    RunObject = Page 50281;
                    ApplicationArea = All;
                }
                action("PMT Discount Master")
                {
                    Caption = 'PMT Discount Master';
                    //   RunObject = Page 50290;
                    ApplicationArea = All;
                }
                action("Posted Sales Credit Memos")
                {
                    Caption = 'Posted Sales Credit Memos';
                    RunObject = Page "Posted Sales Credit Memos";
                    ApplicationArea = All;
                }
                action("Posted Purchase Invoices")
                {
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ApplicationArea = All;
                }
                action("Posted Transfer Shipment")
                {
                    RunObject = Page "Posted Transfer Shipments";
                    ApplicationArea = All;
                }
                action("Auto Credit Issue Memo")
                {
                    Caption = 'Auto Credit Issue Memo';
                    RunObject = Page 50225;
                    ApplicationArea = All;
                }
                action("Wharehouse Inv Management")
                {
                    Caption = 'Wharehouse Inv Management';
                    RunObject = Page 50255;
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
                action("Discontinued Product List")
                {
                    Caption = 'Discontinued Product List';
                    //   RunObject = Page 50222;
                    ApplicationArea = All;
                }
            }
            group("Salesman Incentive")
            {
                Caption = 'Salesman Incentive';
                Image = FiledPosted;
                action("Sales Person Target")
                {
                    Caption = 'Sales Person Target';
                    RunObject = Page "Sales Person Target";
                    ApplicationArea = All;
                }
                action("Incentive Setup")
                {
                    Caption = 'Incentive Setup';
                    //  RunObject = Page 50228;
                    ApplicationArea = All;
                }
                action("Sales Person Incentive Details")
                {
                    Caption = 'Sales Person Incentive Details';
                    RunObject = Page "Sales Person Incentive Details";
                    ApplicationArea = All;
                }
            }
            group("Other Detail")
            {
                Caption = 'Other Detail';
                Image = FiledPosted;
                action("Invoice Line")
                {
                    Caption = 'Invoice Line';
                    RunObject = Page "Sales Inv Line (Ashok)";
                    ApplicationArea = All;
                }
                action("Sales Line Detail")
                {
                    Caption = 'Sales Line Detail';
                    RunObject = Page "Sales Line Detail";
                    ApplicationArea = All;
                }
                action("Transfer Order Lines CC Team")
                {
                    Caption = 'Transfer Order Lines CC Team';
                    RunObject = Page "Transfer Order Lines CC Team";
                    ApplicationArea = All;
                }
                action("Archive Sales Order Line")
                {
                    Caption = 'Archive Sales Order Line';
                    RunObject = Page "Archive Sales Order Line";
                    ApplicationArea = All;
                }
                action("Sales List Archive")
                {
                    Caption = 'Sales List Archive';
                    RunObject = Page "Sales List Archive";
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

