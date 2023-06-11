page 50206 "Internal Auditor"
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
                    ApplicationArea = All;
                }
            }
            group(Control1000000022)
            {
                part("Report Inbox Part"; "Report Inbox Part")
                {
                    AccessByPermission = TableData "Report Inbox" = R;
                    ApplicationArea = All;
                }
                part("My Job Queue"; "My Job Queue")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(embedding)
        {
            action("Chart of Accounts")
            {
                RunObject = Page "Chart of Accounts";
                ApplicationArea = All;
            }
            action("Bank Account Card")
            {
                RunObject = Page "Bank Account List";
                ApplicationArea = All;
            }
            action("Customer Card")
            {
                RunObject = Page "Customer List";
                ApplicationArea = All;
            }
            action("Vendor Application")
            {
                Caption = 'Vendor Application';
                RunObject = Page "Vendor Application";
                ApplicationArea = All;
            }
            action(Item)
            {
                Caption = 'Item';
                RunObject = Page "Item List";
                ApplicationArea = All;
            }
            action("Vender Card")
            {
                RunObject = Page "Vendor List";
                ApplicationArea = All;
            }
        }
        area(sections)
        {
            group("Purchase & Receiable")
            {
                Caption = 'Purchase & Receiable';
                Image = FiledPosted;
                action("Purchase Order")
                {
                    Caption = 'Purchase Order';
                    RunObject = Page "Purchase Order List";
                    ApplicationArea = All;
                }
                action("Purchase Invoices")
                {
                    Caption = 'Purchase Invoices';
                    RunObject = Page "Purchase Invoice";
                    ApplicationArea = All;
                }
                action(" Purchase Credit Memos")
                {
                    Caption = ' Purchase Credit Memos';
                    RunObject = Page "Purchase Credit Memos";
                    ApplicationArea = All;
                }
                action("Purchase Return Order")
                {
                    Caption = 'Purchase Return Order';
                    RunObject = Page "Purchase Return Order List";
                    ApplicationArea = All;
                }
            }
            group("Sales & Payables")
            {
                Caption = 'Sales & Payables';
                Image = FiledPosted;
                action("Sales Order")
                {
                    Caption = 'Sales Order';
                    RunObject = Page "Sales Order List";
                    ApplicationArea = All;
                }
                action("Transfer Order External")
                {
                    Caption = 'Transfer Order External';
                    RunObject = Page "Transfer Orders";
                    ApplicationArea = All;
                }
                action("Transfer Order Internal")
                {
                    Caption = 'Transfer Order Internal';
                    RunObject = Page "Transfer Orders";
                    ApplicationArea = All;
                }
                action("Sales Credit Memos")
                {
                    Caption = 'Sales Credit Memos';
                    RunObject = Page "Sales Credit Memo";
                    ApplicationArea = All;
                }
                action("Sales Debit Note")
                {
                    Caption = 'Sales Debit Note ';
                    RunObject = Page "Sales Invoice List";
                    ApplicationArea = All;
                }
            }
            group(Manufacturing)
            {
                Caption = 'Manufacturing';
                Image = FiledPosted;
                action("Released Production Order")
                {
                    Caption = 'Released Production Order';
                    RunObject = Page "Production Order List";
                    ApplicationArea = All;
                }
                action("Direct Consumption Journal")
                {
                    Caption = 'Direct Consumption Journal';
                    RunObject = Page "Direct Consumption Journal";
                    ApplicationArea = All;
                }
                action("Production BOM")
                {
                    Caption = 'Production BOM';
                    RunObject = Page "Production BOM List";
                    ApplicationArea = All;
                }
                action(Routing)
                {
                    Caption = 'Routing';
                    RunObject = Page "Routing List";
                    ApplicationArea = All;
                }
                action("Machine Center List")
                {
                    Caption = 'Machine Center List';
                    RunObject = Page "Machine Center List";
                    ApplicationArea = All;
                }
                action("Work Center List")
                {
                    Caption = 'Work Center List';
                    RunObject = Page "Work Center List";
                    ApplicationArea = All;
                }
                action("Capacity Journal")
                {
                    Caption = 'Capacity Journal';
                    RunObject = Page "Capacity Journal";
                    ApplicationArea = All;
                }
            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action("Posted Service Tax Distribution")
                {
                    ApplicationArea = All;
                    /* RunObject = Page 16336; //16225 Page N/F
                      ApplicationArea = All;*/
                }
                action("Posted Purchase Invoices")
                {
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoice";
                    ApplicationArea = All;
                }
                action("Sales Line Detail")
                {
                    Caption = 'Sales Line Detail';
                    RunObject = Page "Sales Line Detail";
                    ApplicationArea = All;
                }
                action("Posted Purchase Receipts")
                {
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipt";
                    ApplicationArea = All;
                }
                action("Posted Purchase Credit Memos")
                {
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memo";
                    ApplicationArea = All;
                }
                action("Goods In Transit")
                {
                    Caption = 'Goods In Transit';
                    RunObject = Page GIT;
                    ApplicationArea = All;
                }
                action("Sales Order Archives")
                {
                    Caption = 'Sales Order Archives';
                    RunObject = Page "Sales Order Archive";
                    ApplicationArea = All;
                }
                action("Posted Voucher")
                {
                    Caption = 'Posted Voucher';
                    RunObject = Page "General Ledger Entries";
                    ApplicationArea = All;
                }
                action("Posted Sales Invoices")
                {
                    Caption = 'Posted Sales Invoices';
                    RunObject = Page "Posted Sales Invoice";
                    ApplicationArea = All;
                }
                action("Posted Sales Credit Memos")
                {
                    Caption = 'Posted Sales Credit Memos';
                    RunObject = Page "Posted Sales Credit Memo";
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
                action("Finished Production Order")
                {
                    Caption = 'Finished Production Order';
                    RunObject = Page "Production Order List";
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

