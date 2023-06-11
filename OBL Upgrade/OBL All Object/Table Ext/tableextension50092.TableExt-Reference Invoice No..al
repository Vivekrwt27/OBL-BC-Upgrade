tableextension 50092 tableextension50092 extends "Reference Invoice No."
{
    fields
    {

        //Unsupported feature: Code Modification on ""Reference Invoice Nos."(Field 4).OnValidate".

        //trigger "(Field 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec."Reference Invoice Nos." <> '' THEN
          IF (xRec."Reference Invoice Nos." <> "Reference Invoice Nos.") AND Verified THEN
            ERROR(RefNoAlterErr);
        #4..21
            DetailedGSTLedgerEntry.SETRANGE("Document No.","Reference Invoice Nos.");
            DetailedGSTLedgerEntry.SETRANGE("Source No.",VendorLedgerEntry1."Vendor No.");
            IF NOT DetailedGSTLedgerEntry.FINDFIRST THEN
              ERROR(ReferenceInvoiceErr);
            GSTApplicationManagement.CheckGSTPurchCrMemoValidationReference(PurchaseHeader,"Reference Invoice Nos.");
          END ELSE BEGIN
            GenJournalLine.SETRANGE("Journal Template Name","Journal Template Name");
            GenJournalLine.SETRANGE("Journal Batch Name","Journal Batch Name");
        #30..58
          END;
        END;
        UpdateCustomerValidations;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..24
                ERROR(ReferenceInvoiceErr);
                GSTApplicationManagement.CheckGSTPurchCrMemoValidationReference(PurchaseHeader,"Reference Invoice Nos.");
        #27..61
        */
        //end;
    }

}

