page 50210 "Finance Dept Reports"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Finance Cue";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            cuegroup(Reports)
            {
                Caption = 'Reports';
                Visible = true;

                actions
                {
                    action("Applied Entries To Voucher")
                    {
                        Caption = 'Applied Entries To Voucher';
                        RunObject = Report "Applied Entries To Voucher";
                        ApplicationArea = All;
                    }
                    action("Aged Accounts Payable")
                    {
                        Caption = 'Aged Accounts Payable';
                        RunObject = Report "Aged Accounts Payable";
                        ApplicationArea = All;
                    }
                    action("Bank Reconcilation")
                    {
                        Caption = 'Bank Reconcilation';
                        RunObject = Report "Bank Reconcilation";
                        ApplicationArea = All;
                    }
                    action("Bank Paying Slip")
                    {
                        Caption = 'Bank Paying Slip';
                        RunObject = Report "Bank Paying Slip";
                        ApplicationArea = All;
                    }
                    action("Customer - Ageing Due Date")
                    {
                        Caption = 'Customer - Ageing Due Date';
                        RunObject = Report "Customer - Ageing Due Date";
                        ApplicationArea = All;
                    }
                    action("Consumption Report")
                    {
                        Caption = 'Consumption Report';
                        //  RunObject = Report 50068;
                        ApplicationArea = All;
                    }
                    action("Collection Report")
                    {
                        Caption = 'Collection Report';
                        RunObject = Report "Collection Report";
                        ApplicationArea = All;
                    }
                    action("Customer - Ageing (30-35 days)")
                    {
                        Caption = 'Customer - Ageing (30-35 days)';
                        RunObject = Report "Customer - Ageing (30-35 days)";
                        ApplicationArea = All;
                    }
                    action("Customer Application")
                    {
                        Caption = 'Customer Application';
                        RunObject = Report "Customer Application";
                        ApplicationArea = All;
                    }
                    action("Closing Stock - Store")
                    {
                        Caption = 'Closing Stock - Store';
                        RunObject = Report "Closing Stock - Store New";
                        ApplicationArea = All;
                    }
                    action("Customer Ledger CCTeam")
                    {
                        Caption = 'Customer Ledger CCTeam';
                        RunObject = Report "Customer Ledger CCTeam";
                        ApplicationArea = All;
                    }
                    action("Day Book")
                    {
                        Caption = 'Day Book';
                        RunObject = Report "Day Book";
                        ApplicationArea = All;
                    }
                    action("Date Wise Invoice Wise Sales")
                    {
                        Caption = ' Date Wise Invoice Wise Sales';
                        RunObject = Report "Date Wise Invoice Wise Sales";
                        ApplicationArea = All;
                    }
                    action("Depot Wise Dispatch Report")
                    {
                        Caption = 'Depot Wise Dispatch Report';
                        RunObject = Report "Depot Wise Dispatch Report";
                        ApplicationArea = All;
                    }
                    action("FormWise Detail for DepotTrfr.")
                    {
                        Caption = 'FormWise Detail for DepotTrfr.';
                        //   Image = "Report";
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = New;
                        //RunObject = Report 50357;
                        ApplicationArea = All;
                    }
                    action("Generate DSA")
                    {
                        Caption = 'Generate DSA';
                        //   RunObject = Report 16475;
                        ApplicationArea = All;
                    }
                    action("Item Stock by Location")
                    {
                        Caption = 'Item Stock by Location';
                        RunObject = Report "Item Stock by Location";
                        ApplicationArea = All;
                    }
                    action("Inventory Valuation (Location Wise)")
                    {
                        Caption = 'Inventory Valuation (Location Wise)';
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Inventory Valuation Report Lo2";
                        ApplicationArea = All;
                    }
                    action("Inventory Valuation Report (Base)")
                    {
                        Caption = 'Inventory Valuation Report (Base)';
                        RunObject = Report "Inventory Valuation Report";
                        ApplicationArea = All;
                    }
                    action("Item Wise Despatch")
                    {
                        Caption = 'Item Wise Despatch';
                        RunObject = Report "Item Wise Despatch";
                        ApplicationArea = All;
                    }
                    action("Location Wise Stock")
                    {
                        Caption = 'Location Wise Stock';
                        //Image = "Report";
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = New;
                        RunObject = Report "Location Wise Stock";
                        ApplicationArea = All;
                    }
                    action("Location Wise Breakage")
                    {
                        Caption = 'Location Wise Breakage';
                        RunObject = Report "Location Wise Breakage";
                        ApplicationArea = All;
                    }
                    action("New State Cust. Wise Sales Cr.")
                    {
                        Caption = 'New State Cust. Wise Sales Cr.';
                        //Image = "Report";
                        RunObject = Report "New State Cust. Wise Sales Cr.";
                        ApplicationArea = All;
                    }
                    action("Outstanding RGP")
                    {
                        Caption = 'Outstanding RGP';
                        RunObject = Report "Outstanding RGP";
                        ApplicationArea = All;
                    }
                    action("Purchase Report Excel New")
                    {
                        Caption = 'Purchase Report Excel New';
                        RunObject = Report "Purchase Reportexcel1new";
                        ApplicationArea = All;
                    }
                    action("Production data dump")
                    {
                        Caption = 'Production data dump';
                        RunObject = Report "Indent Location Validate1";
                        ApplicationArea = All;
                    }
                    action("Purchase Journal")
                    {
                        Caption = 'Purchase Journal';
                        //    RunObject = Report 50196;
                        ApplicationArea = All;
                    }
                    action("Posted Voucher")
                    {
                        Caption = ' Posted Voucher';
                        RunObject = Report "Posted Voucher";
                        ApplicationArea = All;
                    }
                    action("Purch. Received not Invoiced")
                    {
                        Caption = 'Purch. Received not Invoiced';
                        RunObject = Report "Purch. Received not Invoiced";
                        ApplicationArea = All;
                    }
                    action("Purchase Journal-2")
                    {
                        Caption = ' Purchase Journal-2';
                        //  RunObject = Report 50196;
                        ApplicationArea = All;
                    }
                    action("Purchase Tax Detail")
                    {
                        Caption = 'Purchase Tax Detail';
                        //  RunObject = Report 50342;
                        ApplicationArea = All;
                    }
                    action("Production Costing Report")
                    {
                        Caption = 'Production Costing Report';
                        RunObject = Report "Production Costing Report";
                        ApplicationArea = All;
                    }
                    action("Pending Intran")
                    {
                        Caption = 'Pending Intran';
                        // Image = "Report";
                        RunObject = Report "Pending Intran";
                        ApplicationArea = All;
                    }
                    action("Sales Journal")
                    {
                        Caption = 'Sales Journal';
                        RunObject = Report "Sales Journal";
                        ApplicationArea = All;
                    }
                    action("State Cust.Wise SalesJrnl")
                    {
                        Caption = ' State Cust.Wise SalesJrnl';
                        RunObject = Report "State Cust.Wise SalesJrnl Mod";
                        ApplicationArea = All;
                    }
                    action("Size-Wise Summ. of finishd gd")
                    {
                        Caption = 'Size-Wise Summ. of finishd gd';
                        RunObject = Report "Size-Wise Summ. of finshd New";
                        ApplicationArea = All;
                    }
                    action("Service Tax Register")
                    {
                        Caption = 'Service Tax Register';
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        //   RunObject = Report 16473;
                        ApplicationArea = All;
                    }
                    action("Store Inventory")
                    {
                        Caption = 'Store Inventory';
                        RunObject = Report "store inventory";
                        ApplicationArea = All;
                    }
                    action("TDS Payable Detail")
                    {
                        Caption = 'TDS Payable Detail';
                        RunObject = Report "TDS Payable Detail.1";
                        ApplicationArea = All;
                    }
                    action("Transfer Journal")
                    {
                        Caption = 'Transfer Journal';
                        // Image = "Report";
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = New;
                        RunObject = Report "Transfer Journal";
                        ApplicationArea = All;
                    }
                    action("TDS 16A")
                    {
                        Caption = 'TDS 16A';
                        //   RunObject = Report 13713;
                        ApplicationArea = All;
                    }
                    action("Vendor - Ageing  (Bill/Posting Date)")
                    {
                        Caption = 'Vendor - Ageing  (Bill/Posting Date)';
                        RunObject = Report "Vendor - Ageing1";
                        ApplicationArea = All;
                    }
                    action("Voucher Register")
                    {
                        Caption = 'Voucher Register';
                        RunObject = Report "Voucher Register";
                        ApplicationArea = All;
                    }
                    action("Vendor Ledger")
                    {
                        Caption = 'Vendor Ledger';
                        RunObject = Report "Vendor Ledger";
                        ApplicationArea = All;
                    }
                    action("Warehouse Receipt(Final)")
                    {
                        Caption = 'Warehouse Receipt(Final)';
                        RunObject = Report "Warehouse Receipt(Final)";
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Purchase Reportexcel1new")
            {
                Caption = 'Purchase Reportexcel1new';
                RunObject = Report "Purchase Reportexcel1new";
                ApplicationArea = All;
            }
            action("General Ledger")
            {
                Caption = 'General Ledger';
                RunObject = Report "General Ledger";
                ApplicationArea = All;
            }
            action("Internal Warehouse Receipt")
            {
                Caption = 'Internal Warehouse Receipt';
                RunObject = Report "Internal Warehouse Receipt";
                ApplicationArea = All;
            }
            action("Size/StateWise Mnthly New")
            {
                Caption = 'Size/StateWise Mnthly New';
                RunObject = Report "Size/StateWise Mnthly New";
                ApplicationArea = All;
            }

        }
    }

    trigger OnOpenPage()
    begin
        rec.RESET;
        IF NOT rec.GET THEN BEGIN
            rec.INIT;
            rec.INSERT;
        END;

        rec.SETFILTER("Due Date Filter", '<=%1', WORKDATE);
        rec.SETFILTER("Overdue Date Filter", '<%1', WORKDATE);
    end;
}

