pageextension 50327 pageextension50327 extends "Sales Return Order"
{
    layout
    {
    }
    actions
    {
        /* modify("Update Reference Invoice No")
         {
             Visible = false;
         }
       addafter("Send IC Return Order Cnfmn.") //16225 Base Action Button Remove Code In Business Centrel
        {
            action("Update Reference Invoice No")
            {
                Caption = 'Update Reference Invoice No';
                Image = ApplyEntries;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ReferenceInvoiceNo: Record "Reference Invoice No.";
                    UpdateReferenceInvoiceNo: Page "Update Reference Invoice No";
                begin
                    IF GSTManagement.IsGSTApplicable(Structure) THEN BEGIN
                        CALCFIELDS("Price Inclusive of Taxes");
                        IF "Price Inclusive of Taxes" THEN BEGIN
                            SalesLine.InitStrOrdDetail(Rec);
                            SalesLine.GetSalesPriceExclusiveTaxes(Rec);
                            SalesLine.UpdateSalesLinesPIT(Rec);
                        END;
                        SalesLine.CalculateStructures(Rec);
                        SalesLine.AdjustStructureAmounts(Rec);
                        SalesLine.UpdateSalesLines(Rec);

                        ReferenceInvoiceNo.RESET;
                        ReferenceInvoiceNo.SETRANGE("Document No.", "No.");
                        ReferenceInvoiceNo.SETRANGE("Document Type", "Document Type");
                        ReferenceInvoiceNo.SETRANGE("Source No.", "Sell-to Customer No.");
                        UpdateReferenceInvoiceNo.CustomerRecord(ReferenceInvoiceNo."Source Type"::Customer);
                        UpdateReferenceInvoiceNo.SETTABLEVIEW(ReferenceInvoiceNo);
                        UpdateReferenceInvoiceNo.RUN;
                    END ELSE
                        ERROR(ReferenceInvoiceNoErr);
                end;
            }
        }*/
    }



}

