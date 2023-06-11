table 50097 EYAIM_PurcahseRegister
{
    Caption = 'EYAIM_PurcahseRegister';

    fields
    {
        field(1; SupplyType; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; DocumentType; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; DocumentNumber; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; DocumentDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; ReverseChargeFlag; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; SupplierGSTIN; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; CustomerGSTIN; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; BillingPOS; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; HSN; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; ItemAssessableAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; IGSTRate; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; IGSTAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; CGSTRate; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; CGSTAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; SGSTRate; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; SGSTAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; CessAdvaloremRate; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; CessAdvaloremAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; CessSpecificRate; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; CessSpecificAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; StateCessAdvaloremRate; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; StateCessAdvaloremAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; StateCessSpecificRate; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; StateCessSpecificAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; TotalItemAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; InvoiceAssessableAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(27; InvoiceIGSTAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; InvoiceCGSTAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; InvoiceSGSTAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; InvoiceCessAdvaloremAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; InvoiceCessSpecificAmount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(32; InvoiceValue; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33; EligibilityIndicator; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(34; AvailableIGST; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(35; AvailableCGST; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(36; AvailableSGST; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(37; AvailableCess; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(38; PortCode; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39; BillOfEntry; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(40; BillOfEntryDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(41; ReturnPeriod; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(42; DifferentialPercentageFlag; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(43; Section7OfIGSTFlag; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(44; ClaimRefundFlag; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(45; AutoPopulateToRefund; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Item Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "vendor Ledger Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(49; X_REQUEST_ID; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50; status; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(51; AckNo; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(52; AckDt; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(53; errorDetails; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Sync Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Pending,Error,Success';
            OptionMembers = Pending,Error,Success;
        }
        field(62; "Sync Error Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Request Json"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Response Json"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; DocumentType, DocumentNumber, "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        DimensionValue: Record "Dimension Value";
}

