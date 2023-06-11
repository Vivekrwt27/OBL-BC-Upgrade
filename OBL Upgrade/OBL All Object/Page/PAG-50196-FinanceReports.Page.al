page 50196 "Finance Reports"
{
    /*     Caption = 'Activities';
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
                            Promoted = true;
                            PromotedCategory = "Report";
                            PromotedIsBig = true;
                            RunObject = Report "Applied Entries To Voucher";
                            ApplicationArea = All;
                        }
                        action("Aged Accounts Payable")
                        {
                            Caption = 'Aged Accounts Payable';
                            RunObject = Report "Aged Accounts Payable";
                            ApplicationArea = All;
                        }
                        action("Process Debit Note of TCS")
                        {
                            RunObject = Report "Process Debit Note of TCS";
                            ApplicationArea = All;
                        }
                        action("Purchase GST Data Report")
                        {
                            Caption = 'Purchase GST Data Report';
                            RunObject = Report "Purchase GST Data Report";
                            ApplicationArea = All;
                        }
                        action("Bank Reconcilation")
                        {
                            Caption = 'Bank Reconcilation';
                            Promoted = true;
                            PromotedCategory = "Report";
                            PromotedIsBig = true;
                            RunObject = Report "Bank Reconcilation";
                            ApplicationArea = All;
                        }
                        action("Production BOM vs Actual")
                        {
                            Caption = 'Production BOM vs Actual';
                            RunObject = Report "Production BOM vs Actual";
                            ApplicationArea = All;
                        }
                        action("Bank Paying Slip")
                        {
                            Caption = 'Bank Paying Slip';
                            Promoted = true;
                            PromotedCategory = "Report";
                            PromotedIsBig = true;
                            RunObject = Report "Bank Paying Slip";
                            ApplicationArea = All;
                        }
                        action("Archive Data")
                        {
                            Caption = 'Archive Data';
                            RunObject = Report "Archive Data";
                            ApplicationArea = All;
                        }
                        action("No Material")
                        {
                            Caption = 'No Material';
                            RunObject = Report "Production Planning Report";
                            ApplicationArea = All;
                        }
                        action("TCS Payment on Collection Report")
                        {
                            Caption = 'TCS Payment on Collection Report';
                            RunObject = Report "TCS Collection Report";
                            ApplicationArea = All;
                        }
                        action("SO Line Combined Report")
                        {
                            Caption = 'SO Line Combined Report';
                            RunObject = Report "SO Line Combined Report";
                            ApplicationArea = All;
                        }
                        action("Datewise Booking & Releasing")
                        {
                            RunObject = Report "Datewise Booking & Releasing";
                            ApplicationArea = All;
                        }
                        action("Overall Pending Orders")
                        {
                            Caption = 'Overall Pending Orders';
                            RunObject = Report "Overall Pending Orders";
                            ApplicationArea = All;
                        }
                        action("Orders Fulfilment Details")
                        {
                            Caption = 'Orders Fulfilment Details';
                            RunObject = Report "Orders Fulfilment Details";
                            ApplicationArea = All;
                        }
                        action("Payment & Credit Issue")
                        {
                            Caption = 'Payment & Credit Issue';
                            RunObject = Report "Credit Billing Exception New";
                            ApplicationArea = All;
                        }
                        action("BOM Vs Actual Report")
                        {
                            Caption = 'BOM Vs Actual Report';
                            RunObject = Report "BOM Vs Actual Report";
                            ApplicationArea = All;
                        }
                        action("Customer - Ageing Due Date")
                        {
                            Caption = 'Customer - Ageing Due Date';
                            Promoted = true;
                            PromotedCategory = "Report";
                            PromotedIsBig = true;
                            RunObject = Report "Customer - Ageing Due Date";
                            ApplicationArea = All;
                        }
                        action("Consumption Report")
                        {
                            Caption = 'Consumption Report';
                            Promoted = true;
                            PromotedCategory = "Report";
                            PromotedIsBig = true;
                            //   RunObject = Report 50068;
                            ApplicationArea = All;
                        }
                        action("Sales GST Data Report")
                        {
                            Caption = 'Sales GST Data Report';
                            RunObject = Report "Sales GST Data Report";
                            ApplicationArea = All;
                        }
                        action("sales Debit Note (Bulk)")
                        {
                            RunObject = Report "sales Debit Note (Bulk)";
                            ApplicationArea = All;
                        }
                        action("Security Credit Note")
                        {
                            Caption = 'Security Credit Note';
                            //    RunObject = Report 50084;
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
                        action("Customer Ledger Mail")
                        {
                            Caption = 'Customer Ledger Mail';
                            RunObject = Report "Customer Ledger Mail";
                            ApplicationArea = All;
                        }
                        action("Customer Application")
                        {
                            Caption = 'Customer Application';
                            Promoted = true;
                            PromotedCategory = "Report";
                            PromotedIsBig = true;
                            RunObject = Report "Customer Application";
                            ApplicationArea = All;
                        }
                        action("Vendor Payment Due Date")
                        {
                            Caption = 'Vendor Payment Due Date';
                            RunObject = Report "Creditors Report MIS";
                            ApplicationArea = All;
                        }
                        action(" Sales Data (Sales Journal New)")
                        {
                            Caption = ' Sales Data (Sales Journal New)';
                            RunObject = Report "Sales Data (Sales Journal New)";
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
                        action("CD Ledger")
                        {
                            Caption = 'CD Ledger';
                            RunObject = Report "CD Ledger";
                            ApplicationArea = All;
                        }
                        action("CD Summary")
                        {
                            Caption = 'CD Summary';
                            RunObject = Report "CD Summary";
                            ApplicationArea = All;
                        }
                        action("CN Ledger")
                        {
                            Caption = 'CN Ledger';
                            RunObject = Report "CN Ledger";
                            ApplicationArea = All;
                        }
                        action("Order TAT Report")
                        {
                            Caption = 'Order TAT Report';
                            RunObject = Report "Order TAT Report_NEW";
                            ApplicationArea = All;
                        }
                        action("Avg Coll Pd_Base")
                        {
                            Caption = 'Avg Coll Pd_Base';
                            RunObject = Report "Avg Coll Pd_Base";
                            ApplicationArea = All;
                        }
                        action("Day Book")
                        {
                            Caption = 'Day Book';
                            Promoted = true;
                            PromotedCategory = "Report";
                            PromotedIsBig = true;
                            RunObject = Report "Day Book";
                            ApplicationArea = All;
                        }
                        action("Warehouse Summary")
                        {
                            Caption = 'Warehouse Summary';
                            RunObject = Report "Warehouse Summary";
                            ApplicationArea = All;
                        }
                        action("Date Wise Invoice Wise Sales")
                        {
                            Caption = ' Date Wise Invoice Wise Sales';
                            Promoted = true;
                            PromotedCategory = "Report";
                            PromotedIsBig = true;
                            RunObject = Report "Date Wise Invoice Wise Sales";
                            ApplicationArea = All;
                        }
                        action("Depot Wise Dispatch Report")
                        {
                            Caption = 'Depot Wise Dispatch Report';
                            RunObject = Report "Depot Wise Dispatch Report";
                            ApplicationArea = All;
                        }
                        action("E-way Bill Input IRIS")
                        {
                            Caption = 'E-way Bill Input Report';
                            RunObject = Report "E-way Bill Input Report";
                            ApplicationArea = All;
                        }
                        action("Excise Details")
                        {
                            Caption = 'Excise Details';
                            RunObject = Report "Excise Details";
                            ApplicationArea = All;
                        }
                        action("FormWise Detail for DepotTrfr.")
                        {
                            Caption = 'FormWise Detail for DepotTrfr.';
                            Image = "Report";
                            //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                            //PromotedCategory = New;
                            //  RunObject = Report 50357;
                            ApplicationArea = All;
                        }
                        action("Generate DSA")
                        {
                            Caption = 'Generate DSA';
                            // 16630   RunObject = Report 16475;
                            ApplicationArea = All;
                        }
                        action("General Ledger")
                        {
                            Caption = 'General Ledger';
                            RunObject = Report Ledger;
                            ApplicationArea = All;
                        }
                        action("Item Stock by Location")
                        {
                            Caption = 'Item Stock by Location';
                            Promoted = true;
                            PromotedCategory = "Report";
                            PromotedIsBig = true;
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
                        action("Indent Detail")
                        {
                            Caption = 'Indent Detail';
                            RunObject = Report "Indent Detail";
                            ApplicationArea = All;
                        }
                        action("Purchase V/S Dispatch Report")
                        {
                            Caption = 'Purchase V/S Dispatch Report';
                            RunObject = Report "Purchase V/S Dispatch Report";
                            ApplicationArea = All;
                        }
                        action("Inventory Valuation Report (Base)")
                        {
                            Caption = 'Inventory Valuation Report (Base)';
                            RunObject = Report "Inventory Valuation Report";
                            ApplicationArea = All;
                        }
                        action("Item Application Report")
                        {
                            Caption = 'Item Application Report';
                            RunObject = Report "Item Application Report";
                            ApplicationArea = All;
                        }
                        action("Inventory Ageing Report new")
                        {
                            Caption = 'Inventory Ageing Report new';
                            RunObject = Report "Inventory Ageing.";
                            ApplicationArea = All;
                        }
                        action("Item Age Composition - Qty.")
                        {
                            Caption = 'Item Age Composition - Qty.';
                            RunObject = Report "Item Age Composition - Qty.";
                            ApplicationArea = All;
                        }
                        action("Item Wise Despatch")
                        {
                            Caption = 'Item Wise Despatch';
                            RunObject = Report "Item Wise Despatch";
                            ApplicationArea = All;
                        }
                        action("Internal Warehouse Receipt")
                        {
                            Caption = 'Internal Warehouse Receipt';
                            RunObject = Report "Internal Warehouse Receipt";
                            ApplicationArea = All;
                        }
                        action("GSTR-2 XL-V2.1-Live")
                        {
                            Caption = 'GSTR-2 XL-V2.1-Live';
                            //RunObject = Report "GSTR-2 XL-V2.1-Live"; // 12568 need to check report first
                            ApplicationArea = All;
                        }
                        action("GSTR-1 Report")
                        {
                            Caption = 'GSTR-1 Report';
                            RunObject = Report "GSTR-1 Report";
                            ApplicationArea = All;
                        }
                        action("Location Wise Stock")
                        {
                            Caption = 'Location Wise Stock';
                            Image = "Report";
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
                        action(" Order Fulfilment")
                        {
                            Caption = ' Order Fulfilment';
                            RunObject = Report "Loss of Sales Report New1";
                            ApplicationArea = All;
                        }
                        action("New State Cust. Wise Sales Cr.")
                        {
                            Caption = 'New State Cust. Wise Sales Cr.';
                            Image = "Report";
                            RunObject = Report "New State Cust. Wise Sales Cr.";
                            ApplicationArea = All;
                        }
                        action("Outstanding RGP")
                        {
                            Caption = 'Outstanding RGP';
                            RunObject = Report "Outstanding RGP";
                            ApplicationArea = All;
                        }
                        action("Pending Application Vendor")
                        {
                            Caption = 'Pending Application Vendor';
                            RunObject = Report "Pending Application Vendor";
                            ApplicationArea = All;
                        }
                        action("Purchase Report Excel New")
                        {
                            Caption = 'Purchase Report Excel New';
                            Promoted = true;
                            PromotedCategory = "Report";
                            PromotedIsBig = true;
                            RunObject = Report "Purchase Reportexcel1new";
                            ApplicationArea = All;
                        }
                        action("Production data dump")
                        {
                            Caption = 'Production data dump';
                            RunObject = Report "Indent Location Validate1";
                            ApplicationArea = All;
                        }
                        action("Salesmen Incentive Report")
                        {
                            Caption = 'Salesmen Incentive Report';
                            RunObject = Report "Salesmen Incentive Report";
                            ApplicationArea = All;
                        }
                        action("Generate MRN To Purch. Invoice")
                        {
                            Caption = 'Generate MRN To Purch. Invoice';
                            RunObject = Report "Generate MRN To Purch. Invo";
                            ApplicationArea = All;
                        }
                        action("Payment Collection Report")
                        {
                            Caption = 'Payment Collection Report';
                            RunObject = Report "Payment Collection Report";
                            ApplicationArea = All;
                        }
                        action("Production Alert Report")
                        {
                            RunObject = Report "Production Alert Report";
                            ApplicationArea = All;
                        }
                        action("Production Alert Six Month")
                        {
                            Caption = 'Production Alert Six Month';
                            RunObject = Report "Production Alert Six Month";
                            ApplicationArea = All;
                        }
                        action("Dispatch Plan")
                        {
                            Caption = 'Dispatch Plan';
                            RunObject = Report "Dispatch Plan";
                            ApplicationArea = All;
                        }
                        action("Purchase Journal")
                        {
                            Caption = 'Purchase Journal';
                            Promoted = true;
                            PromotedCategory = "Report";
                            PromotedIsBig = true;
                            //    RunObject = Report 50196;
                            ApplicationArea = All;
                        }
                        action("Posted Voucher")
                        {
                            Caption = ' Posted Voucher';
                            Promoted = true;
                            PromotedCategory = "Report";
                            PromotedIsBig = true;
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
                            // RunObject = Report 50342;
                            ApplicationArea = All;
                        }
                        action("Page Forcast List")
                        {
                            //   RunObject = Page 50231;
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
                            Image = "Report";
                            RunObject = Report "Pending Intran";
                            ApplicationArea = All;
                        }
                        action("Sales Journal")
                        {
                            Caption = 'Sales Journal';
                            Promoted = true;
                            PromotedCategory = "Report";
                            PromotedIsBig = true;
                            RunObject = Report "Sales Journal";
                            ApplicationArea = All;
                        }
                        action("Bad Inventory Report")
                        {
                            Caption = 'Bad Inventory Report';
                            RunObject = Report "Bad Inventory Report";
                            ApplicationArea = All;
                        }
                        action("State Cust.Wise SalesJrnl")
                        {
                            Caption = ' State Cust.Wise SalesJrnl';
                            Promoted = true;
                            PromotedCategory = "Report";
                            PromotedIsBig = true;
                            RunObject = Report "State Cust.Wise SalesJrnl Mod";
                            ApplicationArea = All;
                        }
                        action("Size-Wise Summ. of finishd gd")
                        {
                            Caption = 'Size-Wise Summ. of finishd gd';
                            Promoted = true;
                            PromotedCategory = "Report";
                            PromotedIsBig = true;
                            RunObject = Report "Size-Wise Summ. of finshd New";
                            ApplicationArea = All;
                        }
                        action("Size/State Wise Monthly Sales")
                        {
                            Caption = 'Size/State Wise Monthly Sales';
                            //   RunObject = Report 50167;
                            ApplicationArea = All;
                        }
                        action("Service Tax Register")
                        {
                            Caption = 'Service Tax Register';
                            //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                            //PromotedCategory = "Report";
                            // 16630 RunObject = Report 16473;
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
                            Promoted = true;
                            PromotedCategory = "Report";
                            PromotedIsBig = true;
                            RunObject = Report "TDS Payable Detail.1";
                            ApplicationArea = All;
                        }
                        action("Transfer Journal")
                        {
                            Caption = 'Transfer Journal';
                            Image = "Report";
                            //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                            //PromotedCategory = New;
                            RunObject = Report "Transfer Journal";
                            ApplicationArea = All;
                        }
                        action("TDS 16A")
                        {
                            Caption = 'TDS 16A';
                            // 16630  RunObject = Report 13713;
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
                            Promoted = true;
                            PromotedCategory = "Report";
                            PromotedIsBig = true;
                            RunObject = Report "Voucher Register";
                            ApplicationArea = All;
                        }
                        action("Vendor Ledger")
                        {
                            Caption = 'Vendor Ledger';
                            Promoted = true;
                            PromotedCategory = "Report";
                            PromotedIsBig = true;
                            RunObject = Report "Vendor Ledger";
                            ApplicationArea = All;
                        }
                        action("Size-Wise Summ. of finishd gd4 (Manish)")
                        {
                            Caption = 'Size-Wise Summ. of finishd gd4 (Manish)';
                            RunObject = Report "Update Purchase Line";
                            ApplicationArea = All;
                        }
                        action("Vendor Application")
                        {
                            Caption = 'Vendor Application';
                            RunObject = Report "Vendor Application";
                            ApplicationArea = All;
                        }
                        action("Warehouse Receipt(Final)")
                        {
                            Caption = 'Warehouse Receipt(Final)';
                            RunObject = Report "Warehouse Receipt(Final)";
                            ApplicationArea = All;
                        }
                        action("Indent Summary/Pending Indents")
                        {
                            Caption = 'Indent Summary/Pending Indents';
                            RunObject = Report "Indent Summary/Pending Indents";
                            ApplicationArea = All;
                        }
                        action("Daybook Report")
                        {
                            Caption = 'Daybook Report';
                            RunObject = Report "Daybook Report";
                            ApplicationArea = All;
                        }
                        action("Pending Purchase Orders")
                        {
                            Caption = 'Pending Purchase Orders';
                            RunObject = Report "Pending Purchase Orders";
                            ApplicationArea = All;
                        }
                        action("Closing Stock - Store New")
                        {
                            Caption = 'Closing Stock - Store New';
                            RunObject = Report "Closing Stock - Store New";
                            ApplicationArea = All;
                        }
                        action("Closing Stock Marketing")
                        {
                            Caption = 'Closing Stock Marketing';
                            RunObject = Report "Closing Stock Marketing";
                            ApplicationArea = All;
                        }
                        action("Show Consump With Zero New")
                        {
                            Caption = 'Show Consump With Zero New';
                            //  RunObject = Report 50271;
                            ApplicationArea = All;
                        }
                        action("Sales and Stock Report")
                        {
                            Caption = 'Sales and Stock Report';
                            RunObject = Report "Size-Wise Summ. of finishd gd4";
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


                action("Applied Entries To Voucher")
                {
                    Caption = 'Applied Entries To Voucher';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Applied Entries To Voucher";
                    ApplicationArea = All;
                }
                action("Aged Accounts Payable")
                {
                    Caption = 'Aged Accounts Payable';
                    RunObject = Report "Aged Accounts Payable";
                    ApplicationArea = All;
                }
                action("Archive Data")
                {
                    Caption = 'Archive Data';
                    RunObject = Report "Archive Data";
                    ApplicationArea = All;
                }
                action("No Material")
                {
                    Caption = 'No Material';
                    RunObject = Report "Production Planning Report";
                    ApplicationArea = All;
                }
                action("Purchase GST Data Report")
                {
                    Caption = 'Purchase GST Data Report';
                    RunObject = Report "Purchase GST Data Report";
                    ApplicationArea = All;
                }
                action("Process Debit Note of TCS")
                {
                    RunObject = Report "Process Debit Note of TCS";
                    ApplicationArea = All;
                }
                action("Bank Reconcilation")
                {
                    Caption = 'Bank Reconcilation';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Bank Reconcilation";
                    ApplicationArea = All;
                }
                action("Production BOM vs Actual")
                {
                    Caption = 'Production BOM vs Actual';
                    RunObject = Report "Production BOM vs Actual";
                    ApplicationArea = All;
                }
                action("Bank Paying Slip")
                {
                    Caption = 'Bank Paying Slip';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Bank Paying Slip";
                    ApplicationArea = All;
                }
                action("Item Ageing -Store and Spares")
                {
                    Caption = 'Item Ageing -Store and Spares';
                    RunObject = Report 50233;
                }

                action("SO Line Combined Report")
                {
                    Caption = 'SO Line Combined Report';
                    RunObject = Report "SO Line Combined Report";
                    ApplicationArea = All;
                }
                action("Datewise Booking & Releasing")
                {
                    RunObject = Report "Datewise Booking & Releasing";
                    ApplicationArea = All;
                }
                action("Overall Pending Orders")
                {
                    Caption = 'Overall Pending Orders';
                    RunObject = Report "Overall Pending Orders";
                    ApplicationArea = All;
                }
                action("Orders Fulfilment Details")
                {
                    Caption = 'Orders Fulfilment Details';
                    RunObject = Report "Orders Fulfilment Details";
                    ApplicationArea = All;
                }
                action("Payment & Credit Issue")
                {
                    Caption = 'Payment & Credit Issue';
                    RunObject = Report "Credit Billing Exception New";
                    ApplicationArea = All;
                }
                action("TCS Payment on Collection Report")
                {
                    Caption = 'TCS Payment on Collection Report';
                    RunObject = Report "TCS Collection Report";
                    ApplicationArea = All;
                }
                action("sales Debit Note (Bulk)")
                {
                    RunObject = Report "sales Debit Note (Bulk)";
                    ApplicationArea = All;
                }
                action(" Sales Data (Sales Journal New)")
                {
                    Caption = ' Sales Data (Sales Journal New)';
                    RunObject = Report "Sales Data (Sales Journal New)";
                    ApplicationArea = All;
                }
                action("Security Credit Note")
                {
                    Caption = 'Security Credit Note';
                    //   RunObject = Report 50084;
                    ApplicationArea = All;
                }
                action("Sales GST Data Report")
                {
                    Caption = 'Sales GST Data Report';
                    RunObject = Report "Sales GST Data Report";
                    ApplicationArea = All;
                }
                action("Customer - Ageing Due Date")
                {
                    Caption = 'Customer - Ageing Due Date';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Customer - Ageing Due Date";
                    ApplicationArea = All;
                }
                action("Consumption Report")
                {
                    Caption = 'Consumption Report';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    //    RunObject = Report 50068;
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
                action("Customer Ledger Mail")
                {
                    Caption = 'Customer Ledger Mail';
                    RunObject = Report "Customer Ledger Mail";
                    ApplicationArea = All;
                }
                action("Customer Application")
                {
                    Caption = 'Customer Application';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Customer Application";
                    ApplicationArea = All;
                }
                action("Closing Stock - Store")
                {
                    Caption = 'Closing Stock - Store';
                    RunObject = Report "Closing Stock - Store New";
                    ApplicationArea = All;
                }
                action("Salesmen Incentive Report")
                {
                    Caption = 'Salesmen Incentive Report';
                    RunObject = Report "Salesmen Incentive Report";
                    ApplicationArea = All;
                }
                action("Customer Ledger CCTeam")
                {
                    Caption = 'Customer Ledger CCTeam';
                    RunObject = Report "Customer Ledger CCTeam";
                    ApplicationArea = All;
                }
                action("Vendor Payment Due Date")
                {
                    Caption = 'Vendor Payment Due Date';
                    RunObject = Report "Creditors Report MIS";
                    ApplicationArea = All;
                }
                action("CD Ledger")
                {
                    Caption = 'CD Ledger';
                    RunObject = Report "CD Ledger";
                    ApplicationArea = All;
                }
                action("CD Summary")
                {
                    Caption = 'CD Summary';
                    RunObject = Report "CD Summary";
                    ApplicationArea = All;
                }
                action("CN Ledger")
                {
                    Caption = 'CN Ledger';
                    RunObject = Report "CN Ledger";
                    ApplicationArea = All;
                }
                action("Order TAT Report")
                {
                    Caption = 'Order TAT Report';
                    RunObject = Report "Order TAT Report_NEW";
                    ApplicationArea = All;
                }
                action("Avg Coll Pd_Base")
                {
                    Caption = 'Avg Coll Pd_Base';
                    RunObject = Report "Avg Coll Pd_Base";
                    ApplicationArea = All;
                }
                action("Day Book")
                {
                    Caption = 'Day Book';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Day Book";
                    ApplicationArea = All;
                }
                action("Warehouse Summary")
                {
                    Caption = 'Warehouse Summary';
                    RunObject = Report "Warehouse Summary";
                    ApplicationArea = All;
                }
                action("Date Wise Invoice Wise Sales")
                {
                    Caption = ' Date Wise Invoice Wise Sales';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Date Wise Invoice Wise Sales";
                    ApplicationArea = All;
                }
                action("Depot Wise Dispatch Report")
                {
                    Caption = 'Depot Wise Dispatch Report';
                    RunObject = Report "Depot Wise Dispatch Report";
                    ApplicationArea = All;
                }
                action("Purchase V/S Dispatch Report")
                {
                    Caption = 'Purchase V/S Dispatch Report';
                    RunObject = Report "Purchase V/S Dispatch Report";
                    ApplicationArea = All;
                }
                action("E-way Bill Input IRIS")
                {
                    Caption = 'E-way Bill Input Report';
                    RunObject = Report "E-way Bill Input Report";
                    ApplicationArea = All;
                }
                action("FormWise Detail for DepotTrfr.")
                {
                    Caption = 'FormWise Detail for DepotTrfr.';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = New;
                    //    RunObject = Report 50357;
                    ApplicationArea = All;
                }
                action("Dispatch Plan")
                {
                    Caption = 'Dispatch Plan';
                    RunObject = Report "Dispatch Plan";
                    ApplicationArea = All;
                }
                action("Generate DSA")
                {
                    Caption = 'Generate DSA';
                    // 16630  RunObject = Report 16475;
                    ApplicationArea = All;
                }
                action("General Ledger")
                {
                    Caption = 'General Ledger';
                    RunObject = Report Ledger;
                    ApplicationArea = All;
                }
                action("Generate Credit Rating")
                {
                    Caption = 'Generate Credit Rating';
                    RunObject = Report "Generate Credit Rating";
                    ApplicationArea = All;
                }
                action("Item Stock by Location")
                {
                    Caption = 'Item Stock by Location';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
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
                action("Item Application Report")
                {
                    Caption = 'Item Application Report';
                    RunObject = Report "Item Application Report";
                    ApplicationArea = All;
                }
                action("Inventory Valuation Report (Base)")
                {
                    Caption = 'Inventory Valuation Report (Base)';
                    RunObject = Report "Inventory Valuation Report";
                    ApplicationArea = All;
                }
                action("Inventory Ageing Report new")
                {
                    Caption = 'Inventory Ageing Report new';
                    RunObject = Report "Inventory Ageing.";
                    ApplicationArea = All;
                }
                action("Item Age Composition - Qty.")
                {
                    Caption = 'Item Age Composition - Qty.';
                    RunObject = Report "Item Age Composition - Qty.";
                    ApplicationArea = All;
                }
                action("Item Wise Despatch")
                {
                    Caption = 'Item Wise Despatch';
                    RunObject = Report "Item Wise Despatch";
                    ApplicationArea = All;
                }
                action("GSTR-2 XL-V2.1-Live")
                {
                    Caption = 'GSTR-2 XL-V2.1-Live';
                    //RunObject = Report "GSTR-2 XL-V2.1-Live"; // 12568 need to check report first
                    ApplicationArea = All;
                }
                action("GSTR-1 Report")
                {
                    Caption = 'GSTR-1 Report';
                    RunObject = Report "GSTR-1 Report";
                    ApplicationArea = All;
                }
                action("Location Wise Stock")
                {
                    Caption = 'Location Wise Stock';
                    Image = "Report";
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
                action(" Order Fulfilment")
                {
                    Caption = ' Order Fulfilment';
                    RunObject = Report "Loss of Sales Report New1";
                    ApplicationArea = All;
                }
                action("New State Cust. Wise Sales Cr.")
                {
                    Caption = 'New State Cust. Wise Sales Cr.';
                    Image = "Report";
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
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Purchase Reportexcel1new";
                    ApplicationArea = All;
                }
                action("Payment Collection Report")
                {
                    Caption = 'Payment Collection Report';
                    RunObject = Report "Payment Collection Report";
                    ApplicationArea = All;
                }
                action("Production Alert Report")
                {
                    Caption = 'Production Alert Report';
                    RunObject = Report "Production Alert Report";
                    ApplicationArea = All;
                }
                action("Production Alert Six Month")
                {
                    Caption = 'Production Alert Six Month';
                    RunObject = Report "Production Alert Six Month";
                    ApplicationArea = All;
                }
                action("Purchase Journal")
                {
                    Caption = 'Purchase Journal';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    //    RunObject = Report 50196;
                    ApplicationArea = All;
                }
                action("Posted Voucher")
                {
                    Caption = ' Posted Voucher';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Posted Voucher";
                    ApplicationArea = All;
                }
                action("Page Forcast List")
                {
                    //  RunObject = Page 50231;
                    ApplicationArea = All;
                }
                action("Generate MRN To Purch. Invoice")
                {
                    Caption = 'Generate MRN To Purch. Invoice';
                    RunObject = Report "Generate MRN To Purch. Invo";
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
                    Image = "Report";
                    RunObject = Report "Pending Intran";
                    ApplicationArea = All;
                }
                action("Sales Journal")
                {
                    Caption = 'Sales Journal';
                    Enabled = false;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Bad Inventory Report")
                {
                    Caption = 'Bad Inventory Report';
                    RunObject = Report "Bad Inventory Report";
                    ApplicationArea = All;
                }
                action("State Cust.Wise SalesJrnl")
                {
                    Caption = ' State Cust.Wise SalesJrnl';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "State Cust.Wise SalesJrnl Mod";
                    ApplicationArea = All;
                }
                action("Size-Wise Summ. of finishd gd")
                {
                    Caption = 'Size-Wise Summ. of finishd gd';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Size-Wise Summ. of finshd New";
                    ApplicationArea = All;
                }
                action("Size/State Wise Monthly Sales")
                {
                    Caption = 'Size/State Wise Monthly Sales';
                    //   RunObject = Report 50167;
                    ApplicationArea = All;
                }
                action("Service Tax Register")
                {
                    Caption = 'Service Tax Register';
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    // RunObject = Report 16473;
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
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "TDS Payable Detail.1";
                    ApplicationArea = All;
                }
                action("Transfer Journal")
                {
                    Caption = 'Transfer Journal';
                    Image = "Report";
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
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Voucher Register";
                    ApplicationArea = All;
                }
                action("Excise Details")
                {
                    Caption = 'Excise Details';
                    RunObject = Report "Excise Details";
                    ApplicationArea = All;
                }
                action("Vendor Ledger")
                {
                    Caption = 'Vendor Ledger';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Vendor Ledger";
                    ApplicationArea = All;
                }
                action("Vendor Application")
                {
                    Caption = 'Vendor Application';
                    RunObject = Report "Vendor Application";
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
     */
}

