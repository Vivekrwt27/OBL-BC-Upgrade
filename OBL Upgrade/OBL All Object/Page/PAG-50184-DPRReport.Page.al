page 50184 "DPR Report"
{
    PageType = List;
    Permissions = TableData EYAIM_PurcahseRegister = ri;
    SourceTable = EYAIM_PurcahseRegister;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(SupplyType; Rec.SupplyType)
                {
                    ApplicationArea = All;
                }
                field(DocumentType; Rec.DocumentType)
                {
                    ApplicationArea = All;
                }
                field(DocumentNumber; Rec.DocumentNumber)
                {
                    ApplicationArea = All;
                }
                field(DocumentDate; Rec.DocumentDate)
                {
                    ApplicationArea = All;
                }
                field(ReverseChargeFlag; Rec.ReverseChargeFlag)
                {
                    ApplicationArea = All;
                }
                field(SupplierGSTIN; Rec.SupplierGSTIN)
                {
                    ApplicationArea = All;
                }
                field(CustomerGSTIN; Rec.CustomerGSTIN)
                {
                    ApplicationArea = All;
                }
                field(BillingPOS; Rec.BillingPOS)
                {
                    ApplicationArea = All;
                }
                field(HSN; Rec.HSN)
                {
                    ApplicationArea = All;
                }
                field(ItemAssessableAmount; Rec.ItemAssessableAmount)
                {
                    ApplicationArea = All;
                }
                field(IGSTRate; Rec.IGSTRate)
                {
                    ApplicationArea = All;
                }
                field(IGSTAmount; Rec.IGSTAmount)
                {
                    ApplicationArea = All;
                }
                field(CGSTRate; Rec.CGSTRate)
                {
                    ApplicationArea = All;
                }
                field(CGSTAmount; Rec.CGSTAmount)
                {
                    ApplicationArea = All;
                }
                field(SGSTRate; Rec.SGSTRate)
                {
                    ApplicationArea = All;
                }
                field(SGSTAmount; Rec.SGSTAmount)
                {
                    ApplicationArea = All;
                }
                field(CessAdvaloremRate; Rec.CessAdvaloremRate)
                {
                    ApplicationArea = All;
                }
                field(CessAdvaloremAmount; Rec.CessAdvaloremAmount)
                {
                    ApplicationArea = All;
                }
                field(CessSpecificRate; Rec.CessSpecificRate)
                {
                    ApplicationArea = All;
                }
                field(CessSpecificAmount; Rec.CessSpecificAmount)
                {
                    ApplicationArea = All;
                }
                field(StateCessAdvaloremRate; Rec.StateCessAdvaloremRate)
                {
                    ApplicationArea = All;
                }
                field(StateCessAdvaloremAmount; Rec.StateCessAdvaloremAmount)
                {
                    ApplicationArea = All;
                }
                field(StateCessSpecificRate; Rec.StateCessSpecificRate)
                {
                    ApplicationArea = All;
                }
                field(StateCessSpecificAmount; Rec.StateCessSpecificAmount)
                {
                    ApplicationArea = All;
                }
                field(TotalItemAmount; Rec.TotalItemAmount)
                {
                    ApplicationArea = All;
                }
                field(InvoiceAssessableAmount; Rec.InvoiceAssessableAmount)
                {
                    ApplicationArea = All;
                }
                field(InvoiceIGSTAmount; Rec.InvoiceIGSTAmount)
                {
                    ApplicationArea = All;
                }
                field(InvoiceSGSTAmount; Rec.InvoiceSGSTAmount)
                {
                    ApplicationArea = All;
                }
                field(InvoiceCessAdvaloremAmount; Rec.InvoiceCessAdvaloremAmount)
                {
                    ApplicationArea = All;
                }
                field(InvoiceCessSpecificAmount; Rec.InvoiceCessSpecificAmount)
                {
                    ApplicationArea = All;
                }
                field(InvoiceValue; Rec.InvoiceValue)
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
                field(AvailableCess; Rec.AvailableCess)
                {
                    ApplicationArea = All;
                }
                field(PortCode; Rec.PortCode)
                {
                    ApplicationArea = All;
                }
                field(BillOfEntry; Rec.BillOfEntry)
                {
                    ApplicationArea = All;
                }
                field(BillOfEntryDate; Rec.BillOfEntryDate)
                {
                    ApplicationArea = All;
                }
                field(ReturnPeriod; Rec.ReturnPeriod)
                {
                    ApplicationArea = All;
                }
                field(DifferentialPercentageFlag; Rec.DifferentialPercentageFlag)
                {
                    ApplicationArea = All;
                }
                field(Section7OfIGSTFlag; Rec.Section7OfIGSTFlag)
                {
                    ApplicationArea = All;
                }
                field(ClaimRefundFlag; Rec.ClaimRefundFlag)
                {
                    ApplicationArea = All;
                }
                field(AutoPopulateToRefund; Rec.AutoPopulateToRefund)
                {
                    ApplicationArea = All;
                }
                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("vendor Ledger Entry No."; Rec."vendor Ledger Entry No.")
                {
                    ApplicationArea = All;
                }
                field(X_REQUEST_ID; Rec.X_REQUEST_ID)
                {
                    ApplicationArea = All;
                }
                field(status; Rec.status)
                {
                    ApplicationArea = All;
                }
                field(AckNo; Rec.AckNo)
                {
                    ApplicationArea = All;
                }
                field(AckDt; Rec.AckDt)
                {
                    ApplicationArea = All;
                }
                field(errorDetails; Rec.errorDetails)
                {
                    ApplicationArea = All;
                }
                /*    field("Power-EB"; "Power-EB")
                    {
                    }
                    field("Power-Total"; Rec."Power-Total")
                    {
                    }
                    field("Gas-GE"; Rec."Gas-GE")
                    {
                    }
                    field("Gas-Dryer"; Rec."Gas-Dryer")
                    {
                    }
                    field("Gas-Kiln"; Rec."Gas-Kiln")
                    {
                    }
                    field("Gas-Spray Dryer MF"; Rec."Gas-Spray Dryer MF")
                    {
                    }
                    field("Gas-Spray Dryer MP"; Rec."Gas-Spray Dryer MP")
                    {
                    }*/
                field("Sync Status"; Rec."Sync Status")
                {
                    ApplicationArea = All;
                }
                field("Request Json"; Rec."Request Json")
                {
                    ApplicationArea = All;
                }
                field("Response Json"; Rec."Response Json")
                {
                    ApplicationArea = All;
                }
                /*  field("Power DG Per Unit"; Rec."Power DG Per Unit")
                  {
                  }
                  field("Saw Dust Total"; Rec."Saw Dust Total")
                  {
                  }
                  field("Coal Total"; Rec."Coal Total")
                  {
                  }
                  field("Saw Dust Price per Unit"; Rec."Saw Dust Price per Unit")
                  {
                  }
                  field("Coal Price Per Unit"; Rec."Coal Price Per Unit")
                  {
                  }
                  field("Klin Gap"; Rec."Klin Gap")
                  {
                  }
                  field("Line Capecity"; Rec."Line Capecity")
                  {
                  }*/
            }
        }
    }

    actions
    {
    }
}

