pageextension 50172 pageextension50172 extends "Purchase Order Statistics"
{

    //Unsupported feature: Code Modification on "GSTApplicationAmount(PROCEDURE 1500002)".// FUNCTION N/F

    //procedure GSTApplicationAmount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    VendorLedgerEntry.SETCURRENTKEY("Document No.","Document Type","Buy-from Vendor No.");
    IF "Applies-to Doc. No." <> '' THEN BEGIN
      VendorLedgerEntry.SETRANGE("Document Type","Applies-to Doc. Type");
      VendorLedgerEntry.SETRANGE("Document No.","Applies-to Doc. No.");
    END;
    IF "Applies-to ID" <> '' THEN
      VendorLedgerEntry.SETRANGE("Applies-to ID","Applies-to ID");
    #8..22
        UNTIL GSTApplicationBuffer.NEXT = 0;
      UNTIL VendorLedgerEntry.NEXT = 0;
    EXIT(TotalAdvAmount);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    VendorLedgerEntry.SETCURRENTKEY("Document No.","Document Type","Buy-from Vendor No.");
    IF "Applies-to Doc. No." <> '' THEN BEGIN
      VendorLedgerEntry.SETRANGE("Document No.","Applies-to Doc. No.");
      VendorLedgerEntry.SETRANGE("Document Type","Applies-to Doc. Type");
    #5..25
    */
    //end;
}

