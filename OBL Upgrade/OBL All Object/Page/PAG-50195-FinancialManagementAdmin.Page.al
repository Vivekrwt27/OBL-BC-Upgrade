page 50195 "Financial Management Admin"
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
                /*  part(CompanyInfo; 50192)
                  {
                      Editable = false;
                      Visible = false;
                      ApplicationArea = All;
                  }*/
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
        area(embedding)
        {
            action("Chart of Accounts")
            {
                RunObject = Page "Chart of Accounts";
                ApplicationArea = All;
            }
            action("General Journals")
            {
                RunObject = Page "General Journal Template List";
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
            action("Cash Receipt Voucher")
            {
                Caption = 'Cash Receipt Voucher';
                RunObject = Page "Cash Receipt Voucher";
                ApplicationArea = All;
            }
            action("Cash Payment Voucher")
            {
                Caption = 'Cash Payment Voucher';
                RunObject = Page "Cash Payment Voucher";
                ApplicationArea = All;
            }
            action("Create Purchase Invoice (Bulk)")
            {
                Caption = 'Create Purchase Invoice (Bulk)';
                //    RunObject = Page 50226;
                ApplicationArea = All;
            }
            action("Contra Voucher")
            {
                RunObject = Page "Contra Voucher";
                ApplicationArea = All;
            }
            action("Journal Voucher")
            {
                RunObject = Page "Journal Voucher";
                ApplicationArea = All;
            }
            action("Bank Acc. Reconciliation")
            {
                RunObject = Page "Bank Acc. Reconciliation List";
                ApplicationArea = All;
            }
            action("Customer Card")
            {
                RunObject = Page "Customer List";
                ApplicationArea = All;
            }
            action("Receivables-Payables")
            {
                Caption = 'Receivables-Payables';
                RunObject = Page "Receivables-Payables Lines";
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
                action("Capex Mastert")
                {
                    Caption = 'Capex Mastert';
                    RunObject = Page "Regular Budget Master List";
                    ApplicationArea = All;
                }
                action("Vendor Requisition")
                {
                    Caption = 'Vendor Requisition';
                    RunObject = Page "Vendor Requisition List";
                    ApplicationArea = All;
                }
                action("Update TDS Register")
                {
                    RunObject = Page "Update TDS Register";
                    ApplicationArea = All;
                }
                action("Challan Register")
                {
                    ApplicationArea = All;
                    //  RunObject = Page "Challan Register";
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
                    RunObject = Page "T.A.N. Nos.";
                    ApplicationArea = All;
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
            group("GST Setup1")
            {
                Caption = 'GST Setup';
                Image = FiledPosted;
                action("GST Registration Nos.")
                {
                    RunObject = Page "GST Registration Nos.";
                    ApplicationArea = All;
                }
                action("GST Accounting Period")
                {
                    ApplicationArea = All;
                    // RunObject = Page "GST Accounting Period";
                }
                action("GST Claim Setoff")
                {
                    RunObject = Page "GST Claim Setoff";
                    ApplicationArea = All;
                }
                action("GST Group")
                {
                    RunObject = Page "GST Group";
                    ApplicationArea = All;
                }
                action("GST Component")
                {
                    ApplicationArea = All;
                    //   RunObject = Page "GST Component";
                }
                action("GST Posting Setup")
                {
                    RunObject = Page "GST Posting Setup";
                    ApplicationArea = All;
                }
                action("GST Configuration")
                {
                    ApplicationArea = All;
                    //   RunObject = Page "GST Configuration";
                }
                action("GST Setup")
                {
                    ApplicationArea = All;
                    //  RunObject = Page "GST Setup";
                }
                action("GST Liability Line")
                {
                    RunObject = Page "GST Liability Line";
                    ApplicationArea = All;
                }
                action("Posted GST Liability")
                {
                    ApplicationArea = All;
                    //  RunObject = Page "Posted GST Liability";
                }
                action("GST Component Mapping Recon.")
                {
                    RunObject = Page "GST Component Mapping Recon.";
                    ApplicationArea = All;
                }
                action("Posted GST Reconciliation")
                {
                    RunObject = Page "Posted GST Reconciliation";
                    ApplicationArea = All;
                }
                action("GST Reconcilation List")
                {
                    RunObject = Page "GST Reconcilation List";
                    ApplicationArea = All;
                }
                action("GST Recon. Field Mapping")
                {
                    RunObject = Page "GST Recon. Field Mapping";
                    ApplicationArea = All;
                }
                action("Pay GST")
                {
                    RunObject = Page "Pay GST";
                    ApplicationArea = All;
                }
                action("GST Component Dist. List")
                {
                    RunObject = Page "GST Component Dist. List";
                    ApplicationArea = All;
                }
                action("GST Distribution List")
                {
                    RunObject = Page "GST Distribution List";
                    ApplicationArea = All;
                }
                action("GST Distribution Reversal List")
                {
                    RunObject = Page "GST Distribution Reversal List";
                    ApplicationArea = All;
                }
                action("Detailed GST Dist. Entry")
                {
                    AccessByPermission = TableData "Detailed Cr. Adjstmnt. Entry" = R;
                    RunObject = Page "Detailed GST Dist. Entries";
                    ApplicationArea = All;
                }
                action("Detailed GST Ledger Entry")
                {
                    AccessByPermission = TableData "Detailed GST Ledger Entry" = R;
                    RunObject = Page "Detailed GST Ledger Entry";
                    ApplicationArea = All;
                }
                action(HSNSAC)
                {
                    Caption = 'HSNSAC';
                    RunObject = Page "HSN/SAC";
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
                    RunObject = Page "Posted Purchase Invoice";
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
                    //   RunObject = Page 50138;
                    ApplicationArea = All;
                }
                action(" Posted Sales Invoices")
                {
                    Caption = ' Posted Sales Invoices';
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
                    RunObject = Page "Posted Transfer Shipment";
                    ApplicationArea = All;
                }
                action("Posted Transfer Receipts")
                {
                    Caption = 'Posted Transfer Receipts';
                    RunObject = Page "Posted Transfer Receipt";
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
                    //   RunObject = Page "Generate TCS Certificate Nos.";
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
                action("Intrastat Journal")
                {
                    RunObject = Page "Intrastat Journal";
                    ApplicationArea = All;
                }
                action("TCS Adjustment Journal")
                {
                    RunObject = Page "TCS Adjustment Journal";
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
            group("Fixed Assets")
            {
                Caption = 'Fixed Assets';
                Image = FiledPosted;
                action("Fixed Asset")
                {
                    Caption = 'Fixed Asset';
                    RunObject = Page "Fixed Asset List";
                    ApplicationArea = All;
                }
                action(Insurance)
                {
                    Caption = 'Insurance';
                    RunObject = Page "Insurance List";
                    ApplicationArea = All;
                }
                action("Fixed Asset G/L Journal")
                {
                    Caption = 'Fixed Asset G/L Journal';
                    RunObject = Page "Fixed Asset G/L Journal";
                    ApplicationArea = All;
                }
                action("Fixed Asset Journal")
                {
                    Caption = 'Fixed Asset Journal';
                    RunObject = Page "Fixed Asset Journal";
                    ApplicationArea = All;
                }
                action("FA Reclass. Journal")
                {
                    Caption = 'FA Reclass. Journal';
                    RunObject = Page "FA Reclass. Journal";
                    ApplicationArea = All;
                }
                action("Insurance Journal")
                {
                    Caption = 'Insurance Journal';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Insurance Journal";
                    ApplicationArea = All;
                }
            }
            group(Setups)
            {
                Caption = 'Setups';
                Image = FiledPosted;
                action("User Setup")
                {
                    Caption = 'User Setup';
                    RunObject = Page "User Setup";
                    ApplicationArea = All;
                }
                action("User Location Form")
                {
                    Caption = 'User Location Form';
                    RunObject = Page "User Location Form";
                    ApplicationArea = All;
                }
                action("Inventory Periods")
                {
                    Caption = 'Fixed Asset G/L Journal';
                    RunObject = Page "Inventory Periods";
                    ApplicationArea = All;
                }
                action(Currencies)
                {
                    RunObject = Page Currencies;
                    ApplicationArea = All;
                }
                action("Accounting Periods")
                {
                    RunObject = Page "Accounting Periods";
                    ApplicationArea = All;
                }
                action("Inventory Setup")
                {
                    Caption = 'Inventory Setup';
                    RunObject = Page "Inventory Setup";
                    ApplicationArea = All;
                }
                action("General Ledger setup1")
                {
                    RunObject = Page "General Ledger Setup";
                    ApplicationArea = All;
                }
                action("Service Tax Setup")
                {
                    ApplicationArea = All;
                    //  RunObject = Page "Service Tax Setup";
                }
                action("Item Charges")
                {
                    Caption = 'Item Charges';
                    RunObject = Page "Item Charges";
                    ApplicationArea = All;
                }
                action("Item Categories")
                {
                    Caption = ' Item Categories';
                    RunObject = Page "Item Categories";
                    ApplicationArea = All;
                }
                action("Rounding Methods")
                {
                    Caption = 'Rounding Methods';
                    RunObject = Page "Rounding Methods";
                    ApplicationArea = All;
                }
                action("Phys. Invt. Counting Periods")
                {
                    Caption = 'Phys. Invt. Counting Periods';
                    RunObject = Page "Phys. Invt. Counting Periods";
                    ApplicationArea = All;
                }
                action("General Ledger Setup")
                {
                    Caption = 'General Ledger Setup';
                    ApplicationArea = All;
                }
                action("Gen. Business Posting Groups")
                {
                    Caption = 'Gen. Business Posting Groups';
                    RunObject = Page "Gen. Business Posting Groups";
                    ApplicationArea = All;
                }
                action("Gen. Product Posting Groups")
                {
                    Caption = 'Gen. Product Posting Groups';
                    RunObject = Page "Gen. Product Posting Groups";
                    ApplicationArea = All;
                }
                action("General Posting Setup")
                {
                    Caption = 'General Posting Setup';
                    RunObject = Page "General Posting Setup";
                    ApplicationArea = All;
                }
                action("FA Posting Groups")
                {
                    Caption = 'FA Posting Groups';
                    RunObject = Page "FA Posting Groups";
                    ApplicationArea = All;
                }
                action("Inventory Posting Groups")
                {
                    Caption = 'Inventory Posting Groups';
                    RunObject = Page "Inventory Posting Groups";
                    ApplicationArea = All;
                }
                action("Inventory Posting Setup")
                {
                    RunObject = Page "Inventory Posting Setup";
                    ApplicationArea = All;
                }
                action("VAT Business Posting Groups")
                {
                    Caption = 'VAT Business Posting Groups';
                    RunObject = Page "VAT Business Posting Groups";
                    ApplicationArea = All;
                }
                action("VAT Product Posting Groups")
                {
                    Caption = 'VAT Product Posting Groups';
                    RunObject = Page "VAT Product Posting Groups";
                    ApplicationArea = All;
                }
                action("VAT Posting Setup")
                {
                    Caption = 'VAT Product Posting Groups';
                    RunObject = Page "VAT Posting Setup";
                    ApplicationArea = All;
                }
                action(Structure)
                {
                    Caption = 'Structure';
                    ApplicationArea = All;
                    //  RunObject = Page "Structure List";
                }
                action("Tax/Charge Groups")
                {
                    Caption = 'Tax/Charge Groups';
                    ApplicationArea = All;
                    //   RunObject = Page "Tax/Charge Groups";
                }
                action("T.I.N. Nos.")
                {
                    Caption = 'T.I.N. Nos.';
                    RunObject = Page "T.I.N No.";
                    ApplicationArea = All;
                }
                action("Form Codes")
                {
                    Caption = ' Form Codes';
                    ApplicationArea = All;
                    //   RunObject = Page 13787;
                }
                action(Schedules)
                {
                    Caption = 'Schedules';
                    ApplicationArea = All;
                    //   RunObject = Page 16545;
                }
                action(States)
                {
                    Caption = 'States';
                    ApplicationArea = All;
                    //  RunObject = Page "Str Order Line Archive Details";
                }
                action("Tax Components")
                {
                    Caption = 'Tax Components';
                    RunObject = Page "Tax Components";
                    ApplicationArea = All;
                }
                action("Tax Groups")
                {
                    Caption = 'Tax Groups';
                    RunObject = Page "Tax Groups";
                    ApplicationArea = All;
                }
                action("Tax Jurisdictions")
                {
                    Caption = 'Tax Jurisdictions';
                    RunObject = Page "Tax Jurisdictions";
                    ApplicationArea = All;
                }
                action("Tax Details")
                {
                    Caption = 'Tax Details';
                    RunObject = Page "Tax Details";
                    ApplicationArea = All;
                }
                action("Tax Area")
                {
                    Caption = 'Tax Area';
                    RunObject = Page "Tax Area List";
                    ApplicationArea = All;
                }
                action("Tax Area Locations")
                {
                    Caption = 'Tax Area Locations';
                    ApplicationArea = All;
                    //  RunObject = Page "Tax Area Locations";
                }
                action("Tax Forms")
                {
                    Caption = 'Tax Forms';
                    ApplicationArea = All;
                    //   RunObject = Page "Tax Forms";
                }
                action("Transit Documents")
                {
                    Caption = 'Transit Documents';
                    ApplicationArea = All;
                    //  RunObject = Page "Transit Documents";
                }
                action("VAT Reports")
                {
                    Caption = 'VAT Reports';
                    ApplicationArea = All;
                    // RunObject = Page "VAT Reports";
                }
                action("VAT Batches")
                {
                    Caption = ' VAT Batches';
                    ApplicationArea = All;
                    // RunObject = Page "VAT Batches";
                }
                action("Excise Duties")
                {
                    Caption = 'Excise Duties';
                    ApplicationArea = All;
                    // RunObject = Page "Excise Duties";
                }
                action("Excise Business Posting Groups")
                {
                    Caption = 'Excise Business Posting Groups';
                    ApplicationArea = All;
                    //    RunObject = Page "Excise Business Posting Groups";
                }
                action("Excise Product Posting Groups")
                {
                    Caption = 'Excise Product Posting Groups';
                    ApplicationArea = All;
                    //   RunObject = Page "Excise Product Posting Groups";
                }
                action("Excise Posting Setup")
                {
                    Caption = 'Excise Posting Setup';
                    ApplicationArea = All;
                    //    RunObject = Page "Excise Posting Setup";
                }
                action("E.C.C. Nos.")
                {
                    Caption = 'E.C.C. Nos.';
                    ApplicationArea = All;
                    //   RunObject = Page "E.C.C. Nos.";
                }
                action("Excise No. Series")
                {
                    Caption = 'Excise No. Series';
                    ApplicationArea = All;
                    //  RunObject = Page "Excise No. Series";
                }
                action("Claim Setoff List")
                {
                    Caption = 'Claim Setoff List';
                    ApplicationArea = All;
                    // RunObject = Page "Claim Setoff List";
                }
                action("Process Carried Out")
                {
                    Caption = 'Process Carried Out';
                    ApplicationArea = All;
                    //   RunObject = Page "Process Carried Out";
                }
                action(Disposals)
                {
                    Caption = 'Disposals';
                    ApplicationArea = All;
                    // RunObject = Page Disposals;
                }
                action("Source Codes")
                {
                    Caption = 'Source Codes';
                    RunObject = Page "Source Codes";
                    ApplicationArea = All;
                }
                action("Source Code Setup")
                {
                    Caption = 'Source Code Setup';
                    RunObject = Page "Source Code Setup";
                    ApplicationArea = All;
                }
                action("Reason Codes")
                {
                    Caption = 'Reason Codes';
                    RunObject = Page "Reason Codes";
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    RunObject = Page Dimensions;
                    ApplicationArea = All;
                }
                action("Default Dimension Combination")
                {
                    Caption = 'Default Dimension Combination';
                    RunObject = Page "Dimension List";
                    ApplicationArea = All;
                }
                action("Default Dimension Priorities")
                {
                    Caption = ' Default Dimension Priorities';
                    RunObject = Page "Default Dimension Priorities";
                    ApplicationArea = All;
                }
                action("Analysis View")
                {
                    Caption = 'Analysis View';
                    RunObject = Page "Analysis View List";
                    ApplicationArea = All;
                }
                action("IC Partner")
                {
                    Caption = 'IC Partner';
                    RunObject = Page "IC Partner List";
                    ApplicationArea = All;
                }
                action("IC Chart of Accounts")
                {
                    Caption = 'IC Chart of Accounts';
                    RunObject = Page "IC Chart of Accounts";
                    ApplicationArea = All;
                }
                action("IC Dimensions")
                {
                    Caption = 'IC Dimensions';
                    RunObject = Page "IC Dimensions";
                    ApplicationArea = All;
                }
                action("Tariff Numbers")
                {
                    Caption = 'Tariff Numbers';
                    RunObject = Page "Tariff Numbers";
                    ApplicationArea = All;
                }
                action("Transaction Types")
                {
                    Caption = 'Transaction Types';
                    RunObject = Page "Transaction Types";
                    ApplicationArea = All;
                }
                action("Transaction Specifications")
                {
                    Caption = 'Transaction Specifications';
                    RunObject = Page "Transaction Specifications";
                    ApplicationArea = All;
                }
                action("Transport Methods")
                {
                    Caption = 'Transport Methods';
                    RunObject = Page "Transport Methods";
                    ApplicationArea = All;
                }
                action("Entry/Exit Points")
                {
                    Caption = 'Entry/Exit Points';
                    RunObject = Page "Entry/Exit Points";
                    ApplicationArea = All;
                }
                action(" Areas")
                {
                    Caption = ' Areas';
                    RunObject = Page Areas;
                    ApplicationArea = All;
                }
                action("Intrastat Journal Templates")
                {
                    Caption = 'Intrastat Journal Templates';
                    RunObject = Page "Intrastat Journal Templates";
                    ApplicationArea = All;
                }
                action("Standard Text Codes")
                {
                    Caption = 'Standard Text Codes';
                    RunObject = Page "Standard Text Codes";
                    ApplicationArea = All;
                }
                action("General Journal Templates")
                {
                    Caption = 'General Journal Templates';
                    RunObject = Page "General Journal Templates";
                    ApplicationArea = All;
                }
                action("VAT Statement Templates")
                {
                    Caption = 'VAT Statement Templates';
                    RunObject = Page "VAT Statement Templates";
                    ApplicationArea = All;
                }
                action("Tax Journal Templates")
                {
                    Caption = 'Tax Journal Templates';
                    ApplicationArea = All;
                    //  RunObject = Page "Tax Journal Templates";
                }
                action("Column Layout")
                {
                    RunObject = Page "Column Layout";
                    ApplicationArea = All;
                }
            }
            group("Purchase & Payables")
            {
                Caption = 'Purchase & Payables';
                Image = FiledPosted;
                action(Item)
                {
                    Caption = 'Item';
                    RunObject = Page "Item List";
                    ApplicationArea = All;
                }
                action("Indent Header")
                {
                    Caption = 'Indent Header';
                    //   RunObject = Page 50046;
                    ApplicationArea = All;
                }
                action("Vendor Card")
                {
                    RunObject = Page "Vendor list";
                    ApplicationArea = All;
                }
                action("Purchase Order")
                {
                    Caption = 'Purchase Order';
                    RunObject = Page "Purchase Order List";
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
            group("Sales & Receivable")
            {
                Caption = 'Sales & Receivable';
                Image = FiledPosted;
                action(Item1)
                {
                    Caption = 'Item';
                    RunObject = Page "Item List";
                    ApplicationArea = All;
                }
                action("Sales Order")
                {
                    Caption = 'Sales Order';
                    RunObject = Page "Sales Order List";
                    ApplicationArea = All;
                }
                action("Transfer Order External")
                {
                    Caption = 'Transfer Order External';
                    ApplicationArea = All;
                    //  RunObject = Page "Transfer List";
                }
                action("Transfer Order Internal")
                {
                    Caption = 'Transfer Order Internal';
                    ApplicationArea = All;
                    //   RunObject = Page "Transfer List";
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
                action(" Routing")
                {
                    Caption = ' Routing';
                    ApplicationArea = All;
                    //  RunObject = "Page Routing List";
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

