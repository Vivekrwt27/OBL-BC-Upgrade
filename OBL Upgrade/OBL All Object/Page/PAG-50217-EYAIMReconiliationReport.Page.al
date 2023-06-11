page 50217 "EYAIM_Reconiliation Report"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "EYAIM_ERP 108DFs Report";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(SuggestedResponse; Rec.SuggestedResponse)
                {
                    ApplicationArea = All;
                }
                field(UserResponse; Rec.UserResponse)
                {
                    ApplicationArea = All;
                }
                field("TaxPeriod-GSTR 3B"; Rec."TaxPeriod-GSTR 3B")
                {
                    ApplicationArea = All;
                }
                field(ResponseRemarks; Rec.ResponseRemarks)
                {
                    ApplicationArea = All;
                }
                field(MatchReason; Rec.MatchReason)
                {
                    ApplicationArea = All;
                }
                field(MismatchReason; Rec.MismatchReason)
                {
                    ApplicationArea = All;
                }
                field(ReportCategory; Rec.ReportCategory)
                {
                    ApplicationArea = All;
                }
                field(ReportType; Rec.ReportType)
                {
                    ApplicationArea = All;
                }
                field("ERP Report Type"; Rec."ERP Report Type")
                {
                    ApplicationArea = All;
                }
                field("TaxPeriod(2A)"; Rec."TaxPeriod(2A)")
                {
                    ApplicationArea = All;
                }
                field("TaxPeriod(2B)"; Rec."TaxPeriod(2B)")
                {
                    ApplicationArea = All;
                }
                field("TaxPeriod(PR)"; Rec."TaxPeriod(PR)")
                {
                    ApplicationArea = All;
                }
                field("RecipientGSTIN(2A)"; Rec."RecipientGSTIN(2A)")
                {
                    ApplicationArea = All;
                }
                field("RecipientGSTIN(PR)"; Rec."RecipientGSTIN(PR)")
                {
                    ApplicationArea = All;
                }
                field("SupplierGSTIN(2A)"; Rec."SupplierGSTIN(2A)")
                {
                    ApplicationArea = All;
                }
                field("SupplierGSTIN(PR)"; Rec."SupplierGSTIN(PR)")
                {
                    ApplicationArea = All;
                }
                field("DocType(2A)"; Rec."DocType(2A)")
                {
                    ApplicationArea = All;
                }
                field("DocType(PR)"; Rec."DocType(PR)")
                {
                    ApplicationArea = All;
                }
                field("DocumentNumber(2A)"; Rec."DocumentNumber(2A)")
                {
                    ApplicationArea = All;
                }
                field("DocumentNumber(PR)"; Rec."DocumentNumber(PR)")
                {
                    ApplicationArea = All;
                }
                field("DocumentDate(2A)"; Rec."DocumentDate(2A)")
                {
                    ApplicationArea = All;
                }
                field("DocumentDate(PR)"; Rec."DocumentDate(PR)")
                {
                    ApplicationArea = All;
                }
                field("POS(2A)"; Rec."POS(2A)")
                {
                    ApplicationArea = All;
                }
                field("POS(PR)"; Rec."POS(PR)")
                {
                    ApplicationArea = All;
                }
                field("TaxableValue(2A)"; Rec."TaxableValue(2A)")
                {
                    ApplicationArea = All;
                }
                field("TaxableValue(PR)"; Rec."TaxableValue(PR)")
                {
                    ApplicationArea = All;
                }
                field("IGST(2A)"; Rec."IGST(2A)")
                {
                    ApplicationArea = All;
                }
                field("IGST(PR)"; Rec."IGST(PR)")
                {
                    ApplicationArea = All;
                }
                field("CGST(2A)"; Rec."CGST(2A)")
                {
                    ApplicationArea = All;
                }
                field("CGST(PR)"; Rec."CGST(PR)")
                {
                    ApplicationArea = All;
                }
                field("SGST(2A)"; Rec."SGST(2A)")
                {
                    ApplicationArea = All;
                }
                field("SGST(PR)"; Rec."SGST(PR)")
                {
                    ApplicationArea = All;
                }
                field("Cess(2A)"; Rec."Cess(2A)")
                {
                    ApplicationArea = All;
                }
                field("Cess(PR)"; Rec."Cess(PR)")
                {
                    ApplicationArea = All;
                }
                field("InvoiceValue(2A)"; Rec."InvoiceValue(2A)")
                {
                    ApplicationArea = All;
                }
                field("InvoiceValue(PR)"; Rec."InvoiceValue(PR)")
                {
                    ApplicationArea = All;
                }
                field("ReverseChargeFlag(2A)"; Rec."ReverseChargeFlag(2A)")
                {
                    ApplicationArea = All;
                }
                field("ReverseChargeFlag(PR)"; Rec."ReverseChargeFlag(PR)")
                {
                    ApplicationArea = All;
                }
                field(EligibilityIndicator; Rec.EligibilityIndicator)
                {
                    ApplicationArea = All;
                }
                field(AvailableIGST; Rec.AvailableIGST)
                {
                    ApplicationArea = All;
                }
                field(AvailableCGST; Rec.AvailableCGST)
                {
                    ApplicationArea = All;
                }
                field(AvailableSGST; Rec.AvailableSGST)
                {
                    ApplicationArea = All;
                }
                field(AvailableCESS; Rec.AvailableCESS)
                {
                    ApplicationArea = All;
                }
                field("ITC Availability (2B)"; Rec."ITC Availability (2B)")
                {
                    ApplicationArea = All;
                }
                field("Reason for ITC Unavailab.(2B)"; Rec."Reason for ITC Unavailab.(2B)")
                {
                    ApplicationArea = All;
                }
                field(ReturnFilingFrequency; Rec.ReturnFilingFrequency)
                {
                    ApplicationArea = All;
                }
                field("GSTR1-FilingStatus"; Rec."GSTR1-FilingStatus")
                {
                    ApplicationArea = All;
                }
                field("GSTR1-FilingDate"; Rec."GSTR1-FilingDate")
                {
                    ApplicationArea = All;
                }
                field("GSTR1-FilingPeriod"; Rec."GSTR1-FilingPeriod")
                {
                    ApplicationArea = All;
                }
                field("GSTR3B-FilingStatus"; Rec."GSTR3B-FilingStatus")
                {
                    ApplicationArea = All;
                }
                field("GSTR3B-FilingDate"; Rec."GSTR3B-FilingDate")
                {
                    ApplicationArea = All;
                }
                field("SupplierGSTIN-Status"; Rec."SupplierGSTIN-Status")
                {
                    ApplicationArea = All;
                }
                field("SupplierGSTIN-CancelDate(2A)"; Rec."SupplierGSTIN-CancelDate(2A)")
                {
                    ApplicationArea = All;
                }
                field(VendorComplianceTrend; Rec.VendorComplianceTrend)
                {
                    ApplicationArea = All;
                }
                field(SupplierCode; Rec.SupplierCode)
                {
                    ApplicationArea = All;
                }
                field("BOE-ReferenceDate(2A)"; Rec."BOE-ReferenceDate(2A)")
                {
                    ApplicationArea = All;
                }
                field("PortCode(2A)"; Rec."PortCode(2A)")
                {
                    ApplicationArea = All;
                }
                field("PortCode(PR)"; Rec."PortCode(PR)")
                {
                    ApplicationArea = All;
                }
                field("BillOfEntry(2A)"; Rec."BillOfEntry(2A)")
                {
                    ApplicationArea = All;
                }
                field("BillOfEntry(PR)"; Rec."BillOfEntry(PR)")
                {
                    ApplicationArea = All;
                }
                field("BillOfEntryDate(2A)"; Rec."BillOfEntryDate(2A)")
                {
                    ApplicationArea = All;
                }
                field("BillOfEntryDate(PR)"; Rec."BillOfEntryDate(PR)")
                {
                    ApplicationArea = All;
                }
                field("TableType(2A)"; Rec."TableType(2A)")
                {
                    ApplicationArea = All;
                }
                field("SupplyType(2A)"; Rec."SupplyType(2A)")
                {
                    ApplicationArea = All;
                }
                field("SupplyType(PR)"; Rec."SupplyType(PR)")
                {
                    ApplicationArea = All;
                }
                field(CompanyCode; Rec.CompanyCode)
                {
                    ApplicationArea = All;
                }
                field(PlantCode; Rec.PlantCode)
                {
                    ApplicationArea = All;
                }
                field(Division; Rec.Division)
                {
                    ApplicationArea = All;
                }
                field(PurchaseOrganisation; Rec.PurchaseOrganisation)
                {
                    ApplicationArea = All;
                }
                field(SourceIdentifier; Rec.SourceIdentifier)
                {
                    ApplicationArea = All;
                }
                field(AccountingVoucherNumber; Rec.AccountingVoucherNumber)
                {
                    ApplicationArea = All;
                }
                field(AccountingVoucherDate; Rec.AccountingVoucherDate)
                {
                    ApplicationArea = All;
                }
                field(VendorType; Rec.VendorType)
                {
                    ApplicationArea = All;
                }
                field(HSN; Rec.HSN)
                {
                    ApplicationArea = All;
                }
                field(VendorRiskCategory; Rec.VendorRiskCategory)
                {
                    ApplicationArea = All;
                }
                field("VendorPaymentTerms(Days)"; Rec."VendorPaymentTerms(Days)")
                {
                    ApplicationArea = All;
                }
                field(VendorRemarks; Rec.VendorRemarks)
                {
                    ApplicationArea = All;
                }
                field(ApprovalStatus; Rec.ApprovalStatus)
                {
                    ApplicationArea = All;
                }
                field(RecordStatus; Rec.RecordStatus)
                {
                    ApplicationArea = All;
                }
                field(KeyDescription; Rec.KeyDescription)
                {
                    ApplicationArea = All;
                }
                field("Recon Generated Date"; Rec."Recon Generated Date")
                {
                    ApplicationArea = All;
                }
                field("Reverse Integrated Date"; Rec."Reverse Integrated Date")
                {
                    ApplicationArea = All;
                }
                field("E-InvoiceApplicability"; Rec."E-InvoiceApplicability")
                {
                    ApplicationArea = All;
                }
                field("IRN(2A)"; Rec."IRN(2A)")
                {
                    ApplicationArea = All;
                }
                field("IRNDate(2A)"; Rec."IRNDate(2A)")
                {
                    ApplicationArea = All;
                }
                field("QR-CodeCheck"; Rec."QR-CodeCheck")
                {
                    ApplicationArea = All;
                }
                field("QR-CodeValidationResult"; Rec."QR-CodeValidationResult")
                {
                    ApplicationArea = All;
                }
                field("QR-CodeMatchCount"; Rec."QR-CodeMatchCount")
                {
                    ApplicationArea = All;
                }
                field("QR-CodeMismatchCount"; Rec."QR-CodeMismatchCount")
                {
                    ApplicationArea = All;
                }
                field("QR-MismatchAttributes"; Rec."QR-MismatchAttributes")
                {
                    ApplicationArea = All;
                }
                field(UserDefinedField1; Rec.UserDefinedField1)
                {
                    ApplicationArea = All;
                }
                field(UserDefinedField2; Rec.UserDefinedField2)
                {
                    ApplicationArea = All;
                }
                field(UserDefinedField3; Rec.UserDefinedField3)
                {
                    ApplicationArea = All;
                }
                field(UserDefinedField4; Rec.UserDefinedField4)
                {
                    ApplicationArea = All;
                }
                field(UserDefinedField5; Rec.UserDefinedField5)
                {
                    ApplicationArea = All;
                }
                field(SystemDefinedField1; Rec.SystemDefinedField1)
                {
                    ApplicationArea = All;
                }
                field(SystemDefinedField2; Rec.SystemDefinedField2)
                {
                    ApplicationArea = All;
                }
                field(SystemDefinedField3; Rec.SystemDefinedField3)
                {
                    ApplicationArea = All;
                }
                field(SystemDefinedField4; Rec.SystemDefinedField4)
                {
                    ApplicationArea = All;
                }
                field(SystemDefinedField5; Rec.SystemDefinedField5)
                {
                    ApplicationArea = All;
                }
                field(SystemDefinedField6; Rec.SystemDefinedField6)
                {
                    ApplicationArea = All;
                }
                field(SystemDefinedField7; Rec.SystemDefinedField7)
                {
                    ApplicationArea = All;
                }
                field(SystemDefinedField8; Rec.SystemDefinedField8)
                {
                    ApplicationArea = All;
                }
                field(SystemDefinedField9; Rec.SystemDefinedField9)
                {
                    ApplicationArea = All;
                }
                field(SystemDefinedField10; Rec.SystemDefinedField10)
                {
                    ApplicationArea = All;
                }
                field(RequestID; Rec.RequestID)
                {
                    ApplicationArea = All;
                }
                field(IDPR; Rec.IDPR)
                {
                    ApplicationArea = All;
                }
                field(ID2A; Rec.ID2A)
                {
                    ApplicationArea = All;
                }
                field("Update LVE"; Rec."Update LVE")
                {
                    Caption = 'Updated';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(General)
            {
                action("Reconcile Ledger")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /// UpdateVLE.RUN;
                    end;
                }
                action("Get Reconciliation Data ")
                {
                    Caption = 'Get Reconciliation Data';
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        EYIntegratonManagment: Codeunit "EY Integraton Managment";
                        CompanyInformation: Record "Company Information";
                    begin
                        CompanyInformation.GET;
                        EYIntegratonManagment.GetReconcilationReport(EYIntegratonManagment.GetReconcilationDetails(CompanyInformation."P.A.N. No."), '1');
                        //EYIntegratonManagment.GetReconcilationReport('100150870','1');
                        MESSAGE('Reconciliation data has been synched');
                    end;
                }
            }
        }
    }

    var
    ///  UpdateVLE: Report 50146;
}

