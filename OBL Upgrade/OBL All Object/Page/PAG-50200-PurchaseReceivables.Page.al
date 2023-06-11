page 50200 "Purchase & Receivables"
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
                part("Purchase Report Profile"; "Purchase Report Profile")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
            }
            group(Control1000000021)
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
            action(Item)
            {
                Caption = 'Item';
                RunObject = Page "Item List";
                ApplicationArea = All;
            }
            action("Vendor Card")
            {
                RunObject = Page "Vendor List";
                ApplicationArea = All;
            }
            action("Vendor Requisition")
            {
                Caption = 'Vendor Requisition';
                RunObject = Page "Vendor Requisition List";
                ApplicationArea = All;
            }
            action("Purchase Order")
            {
                Caption = 'Purchase Order';
                RunObject = Page "Purchase Order List";
                ApplicationArea = All;
            }
            action("Purchase Invoices")
            {
                Caption = 'Purchase Invoices';
                RunObject = Page "Purchase Invoices";
                ApplicationArea = All;
            }
            action("Purchase Credit Memos")
            {
                Caption = 'Purchase Credit Memos';
                RunObject = Page "Purchase Credit Memos";
                ApplicationArea = All;
            }
            action("Purchase Return Order")
            {
                Caption = 'Purchase Return Order';
                RunObject = Page "Purchase Return Order List";
                ApplicationArea = All;
            }
            action("Sales Order")
            {
                Caption = 'Sales Order';
                RunObject = Page "Sales Order List";
                ApplicationArea = All;
            }
            action("Transporter Payment")
            {
                Caption = 'Transporter Payment';
                RunObject = Page "Transporter Payment List";
                ApplicationArea = All;
            }
            action("Transfer Order Internal")
            {
                Caption = 'Transfer Order Internal';
                RunObject = Page "Transfer Orders";
                ApplicationArea = All;
            }
            action("Transfer Order External")
            {
                RunObject = Page "Transfer List-External";
                ApplicationArea = All;
            }
            action("Item Journals")
            {
                Caption = 'Item Journals';
                RunObject = Page "Item Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(Item),
                                    Recurring = CONST(false));
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
            action("Generate EWay Bill P. Ret New")
            {
                Caption = 'Generate EWay Bill P. Ret New';
                RunObject = Page "Generate EWay Bill P. Ret New";
                ApplicationArea = All;
            }
            action("Generate E Way Bill Invv New")
            {
                Caption = 'Generate E Way Bill Invv New';
                RunObject = Page "Generate E Way Bill Invv New";
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
            action("Indent Header")
            {
                Caption = 'Indent Header';
                RunObject = Page "Indent Header List";
                ApplicationArea = All;
            }
            action("Comment Line")
            {
                Caption = 'Comment Line';
                RunObject = Page "Comment Line";
                ApplicationArea = All;
            }
            action("Physical Journal Store List")
            {
                Caption = 'Physical Journal Store List';
                RunObject = Page "Physical Journal Store List";
                ApplicationArea = All;
            }
        }
        area(sections)
        {
            group("Issue Slip")
            {
                Caption = 'Issue Slip';
                Image = FiledPosted;
                action("Issue Slips")
                {
                    Caption = 'Issue Slip';
                    RunObject = Page "Transfer Orders";
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
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action("Posted Purchase Invoices")
                {
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ApplicationArea = All;
                }
                action("Posted Purchase Receipts")
                {
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    ApplicationArea = All;
                }
                action("Posted Purchase Credit Memos")
                {
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ApplicationArea = All;
                }
                action("Posted Sales Invoices")
                {
                    Caption = 'Posted Sales Invoices';
                    RunObject = Page "Posted Sales Invoices";
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
                action("Rejection List")
                {
                    Caption = 'Rejection List';
                    RunObject = Page "Rejection List";
                    ApplicationArea = All;
                }
                action("Posted Return Shipments")
                {
                    Caption = 'Posted Return Shipments';
                    RunObject = Page "Posted Return Shipments";
                    ApplicationArea = All;
                }
                action("Indent User Wise Inventory")
                {
                    Caption = 'Indent User Wise Inventory';
                    RunObject = Page 50287;
                }

            }
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

