table 50096 "EYAIM_ERP 108DFs Report"
{
    Caption = 'EYAIM_ERP 108DFs Report';

    fields
    {
        field(1; SuggestedResponse; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; UserResponse; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "TaxPeriod-GSTR 3B"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; ResponseRemarks; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; MatchReason; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; MismatchReason; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; ReportCategory; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; ReportType; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "ERP Report Type"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "TaxPeriod(2A)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "TaxPeriod(2B)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "TaxPeriod(PR)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "RecipientGSTIN(2A)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "RecipientGSTIN(PR)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "SupplierGSTIN(2A)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "SupplierGSTIN(PR)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "DocType(2A)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "DocType(PR)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "DocumentNumber(2A)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "DocumentNumber(PR)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "DocumentDate(2A)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "DocumentDate(PR)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "POS(2A)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "POS(PR)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "TaxableValue(2A)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "TaxableValue(PR)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "IGST(2A)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "IGST(PR)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "CGST(2A)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "CGST(PR)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "SGST(2A)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "SGST(PR)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Cess(2A)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Cess(PR)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "InvoiceValue(2A)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "InvoiceValue(PR)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "ReverseChargeFlag(2A)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "ReverseChargeFlag(PR)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(39; EligibilityIndicator; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(40; AvailableIGST; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(41; AvailableCGST; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(42; AvailableSGST; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(43; AvailableCESS; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "ITC Availability (2B)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Reason for ITC Unavailab.(2B)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(46; ReturnFilingFrequency; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "GSTR1-FilingStatus"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(48; "GSTR1-FilingDate"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "GSTR1-FilingPeriod"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "GSTR3B-FilingStatus"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(51; "GSTR3B-FilingDate"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "SupplierGSTIN-Status"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(53; "SupplierGSTIN-CancelDate(2A)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(54; VendorComplianceTrend; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(55; SupplierCode; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(56; "BOE-ReferenceDate(2A)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(57; "PortCode(2A)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(58; "PortCode(PR)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(59; "BillOfEntry(2A)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "BillOfEntry(PR)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(61; "BillOfEntryDate(2A)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(62; "BillOfEntryDate(PR)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(63; "TableType(2A)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(64; "SupplyType(2A)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(65; "SupplyType(PR)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(66; CompanyCode; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(67; PlantCode; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(68; Division; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69; PurchaseOrganisation; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70; SourceIdentifier; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(71; AccountingVoucherNumber; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(72; AccountingVoucherDate; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(73; VendorType; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(74; HSN; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(75; VendorRiskCategory; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(76; "VendorPaymentTerms(Days)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(77; VendorRemarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(78; ApprovalStatus; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(79; RecordStatus; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(80; KeyDescription; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(81; "Recon Generated Date"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(82; "Reverse Integrated Date"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(83; "E-InvoiceApplicability"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(84; "IRN(2A)"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(85; "IRNDate(2A)"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(86; "QR-CodeCheck"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(87; "QR-CodeValidationResult"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(88; "QR-CodeMatchCount"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(89; "QR-CodeMismatchCount"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(90; "QR-MismatchAttributes"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(91; UserDefinedField1; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(92; UserDefinedField2; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(93; UserDefinedField3; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(94; UserDefinedField4; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(95; UserDefinedField5; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(96; SystemDefinedField1; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(97; SystemDefinedField2; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(98; SystemDefinedField3; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(99; SystemDefinedField4; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(100; SystemDefinedField5; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(101; SystemDefinedField6; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(102; SystemDefinedField7; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(103; SystemDefinedField8; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(104; SystemDefinedField9; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(105; SystemDefinedField10; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(106; RequestID; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(107; IDPR; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(108; ID2A; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(109; "Update LVE"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(110; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

