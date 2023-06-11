page 50218 EYAIM_PurcahseRegister
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
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
                field(InvoiceCGSTAmount; Rec.InvoiceCGSTAmount)
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
                field(X_REQUEST_ID; Rec.X_REQUEST_ID)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(status; Rec.status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(AckNo; Rec.AckNo)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(AckDt; Rec.AckDt)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(errorDetails; Rec.errorDetails)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sync Status"; Rec."Sync Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sync Error Description"; Rec."Sync Error Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(SendData)
            {
                Caption = 'Send PR Data';
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    EYIntegratonManagment: Codeunit "EY Integraton Managment";
                    EYPurchaseRegister: Record EYAIM_PurcahseRegister;
                begin
                    EYPurchaseRegister.RESET;
                    EYPurchaseRegister.SETFILTER("Sync Status", '%1|%2', EYPurchaseRegister."Sync Status"::Pending, EYPurchaseRegister."Sync Status"::Error);
                    IF EYPurchaseRegister.FINDSET THEN
                        REPEAT
                            //15578 Codeunit 50058/ 5006 EYIntegratonManagment.GenratePurchaseRegisterJson(EYPurchaseRegister);
                        UNTIL EYPurchaseRegister.NEXT = 0;
                    MESSAGE('Purchase Register has been Submitted');
                end;
            }
            action("Fetch from Vendor Ledger")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    UpdatedfromVLEToStaging.RUN;
                end;
            }
            action("View Request Json")
            {
                Image = View;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    IStream: InStream;
                    Content: Text;
                    LineValue: Text;
                begin
                    Rec.CALCFIELDS("Request Json");
                    Rec."Request Json".CREATEINSTREAM(IStream);
                    WHILE NOT IStream.EOS DO BEGIN
                        IStream.READTEXT(LineValue);
                        Content := Content + LineValue;
                    END;
                    MESSAGE(Content);
                end;
            }
            action("View Response Json")
            {
                Image = View;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    IStream: InStream;
                    Content: Text;
                    LineValue: Text;
                begin
                    Rec.CALCFIELDS("Response Json");
                    Rec."Response Json".CREATEINSTREAM(IStream);
                    WHILE NOT IStream.EOS DO BEGIN
                        IStream.READTEXT(LineValue);
                        Content := Content + LineValue;
                    END;
                    MESSAGE(Content);
                end;
            }
        }
    }

    var
        UpdatedfromVLEToStaging: Report "Updated from VLE To Staging";
        Text001: Label 'Alredy synced with EY Portal with AckNo %1 and X_REQUEST_ID %2.';
        EYIntegratonManagment: Codeunit "EY Integraton Managment";
}

