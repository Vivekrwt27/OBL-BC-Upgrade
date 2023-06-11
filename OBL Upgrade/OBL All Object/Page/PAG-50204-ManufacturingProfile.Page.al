page 50204 "Manufacturing Profile"
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
            group(Control1000000049)
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
            action("Indent Detail")
            {
                Caption = 'Indent Detail';
                RunObject = Report "Indent Detail";
                ApplicationArea = All;
            }
            action("No Material Report")
            {
                Caption = 'No Material Report';
                RunObject = Report "Production Planning Report";
                ApplicationArea = All;
            }
            action("Store Inventory")
            {
                Caption = 'Store Inventory';
                RunObject = Report "store inventory";
                ApplicationArea = All;
            }
            action("Consumption Report")
            {
                Caption = 'Consumption Report';
                ///  RunObject = Report 50068;
                ApplicationArea = All;
            }
            action("Production Alert")
            {
                Caption = 'Production Alert';
                RunObject = Report 50130;
            }

            action("Transfer Detail")
            {
                Caption = 'Transfer Detail';
                RunObject = Report "Sales Order List";
                ApplicationArea = All;
            }
            action("Production BOM vs Actual")
            {
                Caption = 'Production BOM vs Actual';
                RunObject = Report "Production BOM vs Actual";
                ApplicationArea = All;
            }
            action("Daybook Report")
            {
                Caption = 'Daybook Report';
                RunObject = Report "Daybook Report";
                ApplicationArea = All;
            }
            action("Inventory Valuation Report")
            {
                Caption = 'Inventory Valuation Report';
                RunObject = Report "Inventory Valuation Report";
                ApplicationArea = All;
            }
            action("Warehouse Summary")
            {
                Caption = 'Warehouse Summary';
                RunObject = Report "Warehouse Summary";
                ApplicationArea = All;
            }
            action("Warehouse Receipt(Final)")
            {
                Caption = 'Warehouse Receipt(Final)';
                RunObject = Report "Warehouse Receipt(Final)";
                ApplicationArea = All;
            }
            action("Internal Transfer Summry & Det")
            {
                Caption = 'Internal Transfer Summry & Det';
                RunObject = Report "Internal Transfer Summry & Det";
                ApplicationArea = All;
            }
            action("Size-Wise Summ. of finishd gd")
            {
                Caption = 'Size-Wise Summ. of finishd gd';
                RunObject = Report "Size-Wise Summ. of finshd New";
                ApplicationArea = All;
            }
            action("Closing Stock - Store")
            {
                Caption = 'Closing Stock - Store';
                RunObject = Report "Closing Stock - Store New";
                ApplicationArea = All;
            }
            action("Closing Stock Marketing")
            {
                Caption = 'Closing Stock Marketing';
                RunObject = Report "Closing Stock Marketing";
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
            action("Production data dump")
            {
                Caption = 'Production data dump';
                RunObject = Report "Indent Location Validate1";
                ApplicationArea = All;
            }
            action("WIP Stock")
            {
                Caption = 'WIP Stock';
                RunObject = Report Stock;
                ApplicationArea = All;
            }
            action("Internal Warehouse Receipt")
            {
                Caption = 'Internal Warehouse Receipt';
                RunObject = Report "Internal Warehouse Receipt";
                ApplicationArea = All;
            }
            action("Location Wise Stock")
            {
                Caption = 'Location Wise Stock';
                RunObject = Report "Location Wise Stock";
                ApplicationArea = All;
            }
            action("Production Costing Report")
            {
                Caption = 'Production Costing Report';
                RunObject = Report "Production Costing Report";
                ApplicationArea = All;
            }
            action("Gate Entry List")
            {
                Caption = 'Gate Entry List';
                RunObject = Report "Gate Entry List";
                ApplicationArea = All;
            }
            action("State Cust.Wise SalesJrnl")
            {
                Caption = 'State Cust.Wise SalesJrnl';
                RunObject = Report "State Cust.Wise SalesJrnl Mod";
                ApplicationArea = All;
            }
        }
        area(embedding)
        {
            action("Physical Journal Prod. List")
            {
                Caption = 'Physical Journal Prod. List';
                RunObject = Page "Physical Journal Prod. List";
                ApplicationArea = All;
            }
            action("WIP Calculation")
            {
                Caption = 'WIP Calculation';
                RunObject = Page "Prod. BOM Explode";
                ApplicationArea = All;
            }
            action("Released Production Order")
            {
                Caption = 'Released Production Order';
                RunObject = Page "Released Production Orders";
                ApplicationArea = All;
            }
            action("Prod. Reporting List")
            {
                Caption = 'Prod. Reporting List';
                RunObject = Page "Prod. Reporting List";
                ApplicationArea = All;
            }
            action("Item Created List")
            {
                Caption = 'Item Created List';
                RunObject = Page "Item Created List";
                ApplicationArea = All;
            }
            action("Power & Consump. List")
            {
                Caption = 'Power & Consump. List';
                RunObject = Page "Power & Consump. List";
                ApplicationArea = All;
            }
            action("Manufacturing Plan")
            {
                RunObject = Page "Manufacturing Plan";
                ApplicationArea = All;
            }
            action("Transfer Order External")
            {
                RunObject = Page "Transfer List-External";
                ApplicationArea = All;
            }
            action("Sample Production Order")
            {
                Caption = 'Sample Production Order';
                RunObject = Page "sample brk  Pod Order List";
                ApplicationArea = All;
            }
            action("Transfer Order Internal")
            {
                Caption = 'Transfer Order Internal';
                RunObject = Page "Transfer Orders";
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
            action("Production BOM Lines Sumit")
            {
                Caption = 'Production BOM Lines Sumit';
                RunObject = Page "Production BOM Lines Sumit";
                ApplicationArea = All;
            }
            action(" Routing")
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
        area(sections)
        {
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
            }
            group("Sales & Payables")
            {
                Caption = 'Sales & Payables';
                Image = FiledPosted;
                action(Item1)
                {
                    Caption = 'Item';
                    RunObject = Page "Item List";
                    ApplicationArea = All;
                }
                action("Archive Sales Order Line")
                {
                    Caption = 'Archive Sales Order Line';
                    RunObject = Page "Archive Sales Order Line";
                    ApplicationArea = All;
                }
                action("Sales Order")
                {
                    Caption = 'Sales Order';
                    RunObject = Page "Sales Order List";
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
                    RunObject = Page "Posted Sales Invoice";
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

