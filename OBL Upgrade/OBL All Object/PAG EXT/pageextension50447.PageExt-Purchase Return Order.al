pageextension 50447 pageextension50447 extends "Purchase Return Order"
{
    layout
    {

        addafter("No. of Archived Versions")
        {
            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = All;
            }
            field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
            {
                ApplicationArea = All;
            }

        }
        moveafter("Vendor Invoice Date"; "GST Reason Type")
        addafter("Vendor Authorization No.")
        {
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Purchaser Code"; "Vendor Cr. Memo No.")
        addafter("Purchaser Code")
        {
            field("Is Vendor GST C_Note  available"; Rec."Vendor GST CN  available")
            {
                ApplicationArea = All;
            }
            field("Vendor CN Date"; Rec."Vendor CN Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Job Queue Status")
        {
            field("Posting Description"; Rec."Posting Description")
            {
                ApplicationArea = All;
            }
        }
        addafter("VAT Bus. Posting Group")
        {
            field("Return Shipment No. Series"; Rec."Return Shipment No. Series")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        //16225 Remove In Bus. centrel
        /* modify("Update Reference Invoice No")
         {
             Visible = false;
         }
         addafter(CopyDocument)
         {
             action("Update Reference Invoice No")
             {
                 Caption = 'Update Reference Invoice No';
                 Image = ApplyEntries;
                 Promoted = true;
                 PromotedCategory = Process;

                 trigger OnAction()
                 var
                     ReferenceInvoiceNo: Record "16470";
                     UpdateReferenceInvoiceNo: Page "16627";
                 begin
                     IF GSTManagement.IsGSTApplicable(Structure) THEN BEGIN
                         PurchLine.CalculateStructures(Rec);
                         PurchLine.AdjustStructureAmounts(Rec);
                         PurchLine.UpdatePurchLines(Rec);

                         ReferenceInvoiceNo.RESET;
                         ReferenceInvoiceNo.SETRANGE("Document No.", "No.");
                         ReferenceInvoiceNo.SETRANGE("Document Type", "Document Type");
                         ReferenceInvoiceNo.SETRANGE("Source No.", "Buy-from Vendor No.");
                         UpdateReferenceInvoiceNo.CustomerRecord(ReferenceInvoiceNo."Source Type"::Vendor);
                         UpdateReferenceInvoiceNo.SETTABLEVIEW(ReferenceInvoiceNo);
                         UpdateReferenceInvoiceNo.RUN;
                     END ELSE
                         ERROR(ReferenceInvoiceNoErr);
                 end;
             }
         }*/
    }

    var
        Text19030419: Label 'Posting Description';

    var
        ReferenceNoErr: Label 'Reference Invoice No is  required where Invoice Type is Debit Note and Supplementary.';





}

