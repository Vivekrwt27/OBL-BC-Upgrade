page 50197 "Financial Management dept"
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
                /* part(CompanyInfo; 50192)
                 {
                     Editable = false;
                     Visible = false;
                     ApplicationArea = All;
                 }*/ // 16630
                part("Finance Reports"; "Finance Reports")
                {
                    ApplicationArea = All;
                }
            }
            group(gernal1)
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
        area(reporting)
        {
            action("GSTR-3B")
            {
                Image = PrintDocument;
                RunObject = Report "GSTR-3B";
                ApplicationArea = All;
            }
            action("GSTR-1")
            {
                Image = PrintDocument;
                RunObject = Report "GSTR-1 File Format";
                ApplicationArea = All;
            }
            action("GSTR-2")
            {
                Image = PrintDocument;
                // 16630  RunObject = Report 16414;
                ApplicationArea = All;
            }
            action("GSTR-1 Sales Data Export")
            {
                Image = PrintDocument;
                RunObject = Report "GSTR-1 Sales Data Export";
                ApplicationArea = All;
            }
            action("GSTR-2 Purchase Data Export")
            {
                Image = PrintDocument;
                RunObject = Report "GSTR-2 Purchase Data Export";
                ApplicationArea = All;
            }
        }
        area(embedding)
        {
            action("Chart of Accounts")
            {
                RunObject = Page "Chart of Accounts";
                ApplicationArea = All;
            }
            action("General Journals")
            {
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Journal Template Name" = FILTER('GENERAL|OPENING'));
                Visible = true;
                ApplicationArea = All;
            }
            action("Vendor Requisition")
            {
                Caption = 'Vendor Requisition';
                RunObject = Page "Vendor Requisition List";
                ApplicationArea = All;
            }
            action("Posted Sales Invoices")
            {
                Caption = 'Posted Sales Invoices';
                RunObject = Page "Posted Sales Invoices";
                ApplicationArea = All;
            }
            action("Payment Journal")
            {
                RunObject = Page "Payment Journal";
                ApplicationArea = All;
            }
            action("Bank Account Card")
            {
                RunObject = Page "Bank Account List";
                ApplicationArea = All;
            }
            action("Bank Receipt Journal")
            {
                RunObject = Page "Bank Receipt Voucher";
                ApplicationArea = All;
            }
            action("TCS Adjustment Journal")
            {
                Caption = 'TCS Adjustment Journal';
                RunObject = Page "TCS Adjustment Journal";
                ApplicationArea = All;
            }
            action("Bank Payment Voucher")
            {
                Caption = 'Bank Payment Voucher';
                RunObject = Page "Bank Payment Voucher";
                ApplicationArea = All;
            }
            action("Cash Receipt Journal")
            {
                RunObject = Page "Cash Receipt Journal";
                ApplicationArea = All;
            }
            action("Cash Receipt Voucher1")
            {
                Caption = 'Cash Receipt Voucher';
                RunObject = Page "Cash Receipt Voucher";
                Visible = false;
                ApplicationArea = All;
            }
            action("Cash Payment Voucher")
            {
                Caption = 'Cash Payment Voucher';
                RunObject = Page "Cash Payment Voucher";
                ApplicationArea = All;
            }
            action("Contra Voucher")
            {
                RunObject = Page "Contra Voucher";
                ApplicationArea = All;
            }
            action("Item Created List")
            {
                Caption = 'Item Created List';
                //   RunObject = Page 50081;
                ApplicationArea = All;
            }
            action("Create Purchase Invoice (Bulk)")
            {
                Caption = 'Create Purchase Invoice (Bulk)';
                //   RunObject = Page 50226;
                ApplicationArea = All;
            }
            action("Transporter Payment")
            {
                Caption = 'Transporter Payment';
                RunObject = Page "Transporter Payment List";
                ApplicationArea = All;
            }
            action("Sales Debit Note")
            {
                Caption = 'Sales Debit Note ';
                RunObject = Page "Sales Invoice List";
                ApplicationArea = All;
            }
            action("Sales Credit Memos")
            {
                Caption = 'Sales Credit Memos';
                RunObject = Page "Sales Credit Memos";
                ApplicationArea = All;
            }
            action("Journal Voucher")
            {
                Caption = 'Journal Voucher';
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(General),
                                    //   "Sub Type" = CONST("Journal Voucher"),
                                    Recurring = CONST(false));
                ApplicationArea = All;
            }
            action("Prod. Reporting List")
            {
                Caption = 'Prod. Reporting List';
                //  RunObject = Page 50215;
                ApplicationArea = All;
            }
            action("DPR Report")
            {
                Caption = 'DPR Report';
                RunObject = Page "DPR Report";
                ApplicationArea = All;
            }
            action("Power & Consump. List")
            {
                Caption = 'Power & Consump. List';
                //  RunObject = Page 50299;
                ApplicationArea = All;
            }
            action("Bank Acc. Reconciliation")
            {
                RunObject = Page "Bank Acc. Reconciliation List";
                ApplicationArea = All;
            }
            action("Indent Header")
            {
                Caption = 'Indent Header';
                //  RunObject = Page 50046;
                ApplicationArea = All;
            }
            action("Receivables-Payables")
            {
                Caption = 'Receivables-Payables';
                RunObject = Page "Receivables-Payables Lines";
                ApplicationArea = All;
            }
            action("Cash Receipt Voucher")
            {
                Caption = 'Cash Receipt Voucher';
                Image = Journals;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(General),
                                    // "Sub Type" = CONST("Cash Receipt Voucher"),
                                    Recurring = CONST(false));
                ApplicationArea = All;
            }
        }
        area(sections)
        {
            group("Tax Deducted At Source")
            {
                Caption = 'Tax Deducted At Source';
                Image = FiledPosted;
                action("TDS Adjustment Journal")
                {
                    RunObject = Page "TDS Adjustment Journal";
                    ApplicationArea = All;
                }
                action("Update TDS Register")
                {
                    RunObject = Page "Update TDS Register";
                    ApplicationArea = All;
                }
                action("Generate Certificate Nos.")
                {
                    ApplicationArea = All;
                    //RunObject = Page "Generate Certificate Nos.";
                }
                action("Generate e-TDS")
                {
                    ApplicationArea = All;
                    //RunObject = Page "Generate e-TDS";
                }
                action("Generate Revised e-TDS")
                {
                    Caption = 'Generate Revised e-TDS';
                    ApplicationArea = All;
                    //RunObject = Page "Generate Revised e-TDS";
                }
                action("Service Tax Entry Details")
                {
                    Caption = 'Service Tax Entry Details';
                    ApplicationArea = All;
                    //RunObject = Page "Service Tax Entry Details";
                }
                action("ST3 Removed as such/LTU Dtls.")
                {
                    Caption = 'ST3 Removed as such/LTU Dtls.';
                    ApplicationArea = All;
                    //RunObject = Page "ST3 Removed as such/LTU Dtls.";
                }
                action("Update FBT Entries")
                {
                    Caption = 'Update FBT Entries';
                    ApplicationArea = All;
                    //RunObject = Page "Update FBT Entries";
                }
                action("Calculate FBT")
                {
                    Caption = 'Calculate FBT';
                    ApplicationArea = All;
                    //RunObject = Page "Calculate FBT List";
                }
                action("Assessee Codes")
                {
                    Caption = 'Assessee Codes';
                    RunObject = Page "Assessee Codes";
                    ApplicationArea = All;
                }
                action(Parties)
                {
                    Caption = 'Parties';
                    RunObject = Page Parties;
                    ApplicationArea = All;
                }
                action("Concessional Codes")
                {
                    Caption = 'Concessional Codes';
                    RunObject = Page "Concessional Codes";
                    ApplicationArea = All;
                }
                action("Correction Codes")
                {
                    Caption = 'Correction Codes';
                    ApplicationArea = All;
                    //RunObject = Page "Correction Codes";
                }
                action("NOD/NOC")
                {
                    Caption = 'NOD/NOC';
                    ApplicationArea = All;
                    //RunObject = Page "NOD/NOC List";
                }
                action(Ministries)
                {
                    Caption = 'Ministries';
                    RunObject = Page Ministries;
                    ApplicationArea = All;
                }
                action("Deductor Categories")
                {
                    Caption = 'Deductor Categories';
                    RunObject = Page "Deductor Categories";
                    ApplicationArea = All;
                }
                action("FBT Groups")
                {
                    Caption = 'FBT Groups';
                    ApplicationArea = All;
                    //RunObject = Page "FBT Groups";
                }
                action("FBT Setup")
                {
                    Caption = 'FBT Setup';
                    ApplicationArea = All;
                    //RunObject = Page "FBT Setup";
                }
                action("TDS Groups")
                {
                    Caption = 'TDS Groups';
                    ApplicationArea = All;
                    //RunObject = Page "TDS Groups";
                }
                action("TDS Nature of Deductions")
                {
                    Caption = 'TDS Nature of Deductions';
                    ApplicationArea = All;
                    //RunObject = Page "TDS Nature of Deductions";
                }
                action("T.A.N. Nos.")
                {
                    Caption = 'T.A.N. Nos.';
                    ApplicationArea = All;
                    //RunObject = Page "T.A.N. Nos.";
                }
                action("TDS Setup")
                {
                    Caption = 'TDS Setup';
                    RunObject = Page "TDS Setup";
                    ApplicationArea = All;
                }
                action("TCS Nature of Collections")
                {
                    Caption = 'TCS Nature of Collections';
                    RunObject = Page "TCS Nature of Collections";
                    ApplicationArea = All;
                }
                action("T.C.A.N. Nos.")
                {
                    Caption = 'T.C.A.N. Nos.';
                    RunObject = Page "T.C.A.N. Nos.";
                    ApplicationArea = All;
                }
                action("TCS Setup")
                {
                    Caption = 'TCS Setup';
                    RunObject = Page "TCS Setup";
                    ApplicationArea = All;
                }
            }
            group("Generate E-Way")
            {
                Caption = 'Generate E-Way';
                Image = FiledPosted;
                action("Generate E Way Bill Invoice")
                {
                    Caption = 'Generate E Way Bill Invoice';
                    //  RunObject = Page 50240;
                    ApplicationArea = All;
                }
                action("Generate EWay Bill Purch. Ret.")
                {
                    Caption = 'Generate EWay Bill Purch. Ret.';
                    // RunObject = Page 50241;
                    ApplicationArea = All;
                }
                action("Generate E Way Bill Transfer")
                {
                    Caption = 'Generate E Way Bill Transfer';
                    //  RunObject = Page 50242;
                    ApplicationArea = All;
                }
                action("Generate E Way Bill Invv New")
                {
                    //  RunObject = Page 50237;
                    ApplicationArea = All;
                }
                action("Generate EWay Bill Trfr New")
                {
                    Caption = 'Generate EWay Bill Trfr New';
                    //  RunObject = Page 50239;
                    ApplicationArea = All;
                }
                action("Generate EWay Bill P. Ret New")
                {
                    Caption = 'Generate EWay Bill P. Ret New';
                    //  RunObject = Page 50238;
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
                    //RunObject = Page "Posted Distribution List";
                }
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
                action("G/L Registers")
                {
                    Caption = 'G/L Registers';
                    RunObject = Page "G/L Registers";
                    ApplicationArea = All;
                }
                action("General Ledger Entries")
                {
                    Caption = 'General Ledger Entries';
                    RunObject = Page "General Ledger Entries";
                    ApplicationArea = All;
                }
                action("Posted Voucher")
                {
                    Caption = 'Posted Voucher';
                    RunObject = Page "General Ledger Entries";
                    ApplicationArea = All;
                }
                action(" Posted Sales Invoices")
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
                action("Item Application Entry")
                {
                    Caption = 'Item Application Entry';
                    //  RunObject = Page 50168;
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
            group("Periodic Activity")
            {
                Caption = 'Periodic Activity';
                Image = FiledPosted;
                action("Budget Master List")
                {
                    RunObject = Page "Regular Budget Master List";
                    ApplicationArea = All;
                }
                action("Update TCS Register")
                {
                    RunObject = Page "Update TCS Register";
                    ApplicationArea = All;
                }
                action("TCS Challan Register")
                {
                    RunObject = Page "TCS Challan Register";
                    ApplicationArea = All;
                }
                action("Generate TCS Certificate Nos.")
                {
                    ApplicationArea = All;
                    //RunObject = Page "Generate TCS Certificate Nos.";
                }
                action("Assign TDS Cert. Details")
                {
                    RunObject = Page "Assign TDS Cert. Details";
                    ApplicationArea = All;
                }
                action("Recurring General Journal")
                {
                    RunObject = Page "Recurring General Journal";
                    ApplicationArea = All;
                }
                action("Goods In Transit")
                {
                    Caption = 'Goods In Transit';
                    //  RunObject = Page 50138;
                    ApplicationArea = All;
                }
                action("Intrastat Journal")
                {
                    RunObject = Page "Intrastat Journal";
                    ApplicationArea = All;
                }
                action("Update TDS Certificate Details")
                {
                    RunObject = Page "Update TDS Certificate Details";
                    ApplicationArea = All;
                }
                action("VAT Opening Detail")
                {
                    ApplicationArea = All;
                    //RunObject = Page "VAT Opening Detail";
                }
                action("VAT Adjustment Journal")
                {
                    ApplicationArea = All;
                    //RunObject = Page "VAT Adjustment Journal";
                }
                action("Application Worksheet")
                {
                    Caption = 'Application Worksheet';
                    RunObject = Page "Item Ledger Entries";
                    ApplicationArea = All;
                }
                action("Inventory Analysis Lines")
                {
                    Caption = 'Inventory Analysis Lines';
                    RunObject = Page "Inventory Analysis Lines";
                    ApplicationArea = All;
                }
                action("LC Detail")
                {
                    Caption = 'LC Detail';
                    ApplicationArea = All;
                    //RunObject = Page "LC Detail List";
                }
            }
            group("Production Order")
            {
                Caption = 'Production Order';
                Image = FiledPosted;
                action("Released Production Order")
                {
                    Caption = 'Released Production Order';
                    RunObject = Page "Released Production Orders";
                    ApplicationArea = All;
                }
                action("Production BOM")
                {
                    Caption = 'Production BOM';
                    RunObject = Page "Production BOM List";
                    ApplicationArea = All;
                }
                action(" Routing")
                {
                    Caption = ' Routing';
                    RunObject = Page "Routing List";
                    ApplicationArea = All;
                }
            }
            group("Purchase & Receiable")
            {
                Caption = 'Purchase & Receiable';
                Image = FiledPosted;
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
                action("Customer Card")
                {
                    RunObject = Page "Customer List";
                    ApplicationArea = All;
                }
                action("Sales Order")
                {
                    Caption = 'Sales Order';
                    RunObject = Page "Sales Order List";
                    ApplicationArea = All;
                }
                action("Purchase Order")
                {
                    Caption = 'Purchase Order';
                    RunObject = Page "Purchase Order List";
                    ApplicationArea = All;
                }
                action("Physical Journal Store List")
                {
                    Caption = 'Physical Journal Store List';
                    //  RunObject = Page 50154;
                    ApplicationArea = All;
                }
                action("Physical Journal Prod. List")
                {
                    Caption = 'Physical Journal Prod. List';
                    //  RunObject = Page 50098;
                    ApplicationArea = All;
                }
                action("Purchase Invoices")
                {
                    Caption = 'Purchase Invoices';
                    RunObject = Page "Purchase Invoices";
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
                action("WIP Calculation")
                {
                    Caption = 'WIP Calculation';
                    //  RunObject = Page 50253;
                    ApplicationArea = All;
                }
            }
            group("Issue Slip1")
            {
                Caption = 'Issue Slip';
                Image = FiledPosted;
                action("Transfer Order Internal")
                {
                    Caption = 'Transfer Order Internal';
                    RunObject = Page "Transfer Orders";
                    ApplicationArea = All;
                }
                action("Issue Slip")
                {
                    Caption = 'Issue Slip';
                    RunObject = Page "Transfer Orders";
                    ApplicationArea = All;
                }
                action("Transfer Order External")
                {
                    RunObject = Page "Transfer List-External";
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
            group("GST Setup")
            {
                Caption = 'GST Setup';
                Image = FiledPosted;
                action("Posted GST Reconciliation")
                {
                    RunObject = Page "Posted GST Reconciliation";
                    ApplicationArea = All;
                }
                action("GST Payment")
                {
                    Caption = 'GST Payment';
                    ApplicationArea = All;
                    //RunObject = Page "GST Payment";
                }
                action("Detailed GST Ledger Entry")
                {
                    Caption = 'Detailed GST Ledger Entry';
                    RunObject = Page "Detailed GST Ledger Entry";
                    ApplicationArea = All;
                }
                action("GST Distribution List")
                {
                    Caption = 'GST Distribution List';
                    RunObject = Page "GST Distribution List";
                    ApplicationArea = All;
                }
                action("Posted Settlement Entries")
                {
                    ApplicationArea = All;
                    //RunObject = Page "Posted Settlement Entries";
                }
                action("GST Reconcilation List")
                {
                    RunObject = Page "GST Reconcilation List";
                    ApplicationArea = All;
                }
                action("GST Distribution Reversal List")
                {
                    Caption = 'GST Distribution Reversal List';
                    RunObject = Page "GST Distribution Reversal List";
                    ApplicationArea = All;
                }
                action("GST Recon. Field Mapping")
                {
                    RunObject = Page "GST Recon. Field Mapping";
                    ApplicationArea = All;
                }
                action("Detailed GST Dist. Entry")
                {
                    // AccessByPermission = TableData "Capitalize CWIP List" = R;
                    RunObject = Page "Detailed GST Dist. Entries";
                    ApplicationArea = All;
                }
                action("Pay GST")
                {
                    RunObject = Page "Pay GST";
                    ApplicationArea = All;
                }
            }
            group(Forecast)
            {
                Caption = 'Forecast';
                action("Page Forcast List")
                {
                    Caption = 'Page Forcast List';
                    //  RunObject = Page 50231;
                    ApplicationArea = All;
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

