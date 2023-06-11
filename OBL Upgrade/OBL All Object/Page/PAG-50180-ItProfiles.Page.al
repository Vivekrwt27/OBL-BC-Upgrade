page 50180 "It Profiles"
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
            }
            group(Control1000000036)
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
            action("Item Age Composition - Qty.")
            {
                Caption = 'Item Age Composition - Qty.';
                RunObject = Report "Item Age Composition - Qty.";
                ApplicationArea = All;
            }
            action("Size-Wise Summ. of finishd gd2")
            {
                Caption = 'Size-Wise Summ. of finishd gd2';
                RunObject = Report "Order Contribution";
                ApplicationArea = All;
            }
            action("Sales Data (Sales Journal New)")
            {
                Caption = 'Sales Data (Sales Journal New)';
                RunObject = Report "Sales Data (Sales Journal New)";
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
            action("State Cust.Wise SalesJrnl")
            {
                Caption = 'State Cust.Wise SalesJrnl';
                RunObject = Report "State Cust.Wise SalesJrnl Mod";
                ApplicationArea = All;
            }
            action("Indent Detail")
            {
                Caption = 'Indent Detail';
                RunObject = Report "Indent Detail";
                ApplicationArea = All;
            }
            action("Indent Summary/Pending Indents")
            {
                Caption = 'Indent Summary/Pending Indents';
                RunObject = Report "Indent Summary/Pending Indents";
                ApplicationArea = All;
            }
            action("Stock Detail")
            {
                Caption = 'Stock Detail';
                RunObject = Report "Stock Report";
                ApplicationArea = All;
            }
            action("Quantity Discount Details")
            {
                Caption = 'Quantity Discount Details';
                ///  RunObject = Report 50334;
                ApplicationArea = All;
            }
            action("Internal Warehouse Receipt")
            {
                Caption = 'Internal Warehouse Receipt';
                RunObject = Report "Internal Warehouse Receipt";
                ApplicationArea = All;
            }
            action("Size wise Item wise Sales & Tr")
            {
                Caption = 'Size wise Item wise Sales & Tr';
                ///   RunObject = Report 50337;
                ApplicationArea = All;
            }
            action("Consumption Report")
            {
                Caption = 'Consumption Report';
                ///  RunObject = Report 50068;
                ApplicationArea = All;
            }
            action("Internal Transfer Summry & Det")
            {
                Caption = 'Internal Transfer Summry & Det';
                RunObject = Report "Internal Transfer Summry & Det";
                ApplicationArea = All;
            }
            action("Size Wise Item Detail.")
            {
                Caption = 'Size Wise Item Detail.';
                ///  RunObject = Report 50347;
                ApplicationArea = All;
            }
            action("Transfer Detail")
            {
                Caption = 'Transfer Detail';
                RunObject = Report "Sales Order List";
                ApplicationArea = All;
            }
            action("Warehouse Receipt(Final)")
            {
                Caption = 'Warehouse Receipt(Final)';
                RunObject = Report "Warehouse Receipt(Final)";
                ApplicationArea = All;
            }
            action("Inventory Valuation Report")
            {
                Caption = 'Inventory Valuation Report';
                RunObject = Report "Inventory Valuation Report";
                ApplicationArea = All;
            }
            action("Production Alert Report")
            {
                Caption = 'Production Alert Report';
                RunObject = Report "Production Alert Six Month";
                ApplicationArea = All;
            }
            action("Location Wise Stock")
            {
                Caption = 'Location Wise Stock';
                RunObject = Report "Location Wise Stock";
                ApplicationArea = All;
            }
            action("Inventory Ageing Report new")
            {
                Caption = 'Inventory Ageing Report new';
                RunObject = Report "Inventory Ageing.";
                ApplicationArea = All;
            }
            action("Dispatch Plan")
            {
                Caption = 'Dispatch Plan';
                RunObject = Report "Dispatch Plan";
                ApplicationArea = All;
            }
        }
        area(embedding)
        {
            action("Customer Card")
            {
                RunObject = Page "Customer List";
                ApplicationArea = All;
            }
            action("Capex Master")
            {
                Caption = 'Capex Master';
                RunObject = Page "Regular Budget Master List";
                ApplicationArea = All;
            }
            action("Vendor Requisition")
            {
                Caption = 'Vendor Requisition';
                RunObject = Page "Vendor Requisition List";
                ApplicationArea = All;
            }
            action("Item Journal  Adjustment")
            {
                Caption = 'Item Journal  Adjustment';
                RunObject = Page "Item Adjustment";
                ApplicationArea = All;
            }
            action("Item Journal Template List")
            {
                Caption = 'Item Journal Template List';
                RunObject = Page "Item Journal Template List";
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
                action("Purchase Invoices")
                {
                    Caption = 'Purchase Invoices';
                    RunObject = Page "Purchase Invoices";
                    ApplicationArea = All;
                }
                action("Purchase Credit Memos")
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
                    RunObject = Page "Sales Credit Memos";
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
                    Caption = ' Routing';
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
                    Caption = ' Posted Sales Invoices';
                    RunObject = Page "Posted Sales Invoices";
                    ApplicationArea = All;
                }
                action("Posted Sales Credit Memos")
                {
                    Caption = 'Posted Sales Credit Memos';
                    RunObject = Page "Posted Sales Credit Memos";
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
            group("Issue Slip")
            {
                Caption = 'Issue Slip';
                Image = FiledPosted;
                action("Issue Slips")
                {
                    Caption = 'Issue Slip';
                    RunObject = Page "Issue Slip List";
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

