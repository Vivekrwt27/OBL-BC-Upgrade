codeunit 50000 "Post Auto Application"
{
    trigger OnRun()
    var
        TEntryNo: Integer;
        r: Record 5800;
    begin
        CustledgerEntry.RESET;
        CustledgerEntry.SETFILTER("Entry No.", '<>%1', 0);
        CustledgerEntry.SETRANGE(Open, TRUE);
        IF CustledgerEntry.FINDFIRST THEN
            REPEAT
                TEntryNo := CustledgerEntry."Entry No.";
                RecCustLedger.RESET;
                RecCustLedger.SETRANGE(Open, TRUE);
                IF RecCustLedger.FIND('-') THEN
                    REPEAT
                        RecCustLedger."Applies-to ID" := '';
                        RecCustLedger."Amount to Apply" := 0;
                        RecCustLedger."Applying Entry" := FALSE;
                        IF RecCustLedger.MODIFY THEN;
                    UNTIL RecCustLedger.NEXT = 0;
                RecCustLedger.RESET;
                RecCustLedger.SETRANGE("Customer No.", CustledgerEntry."Customer No.");
                RecCustLedger.SETRANGE("Closed By Entry No. 3.7", CustledgerEntry."Entry No. 3.7");
                RecCustLedger.SETRANGE(Open, TRUE);
                IF RecCustLedger.FIND('-') THEN BEGIN
                    REPEAT
                        RecCustLedger.CALCFIELDS("Remaining Amount");
                        RecCustLedger."Applies-to ID" := USERID;
                        RecCustLedger."Applying Entry" := TRUE;
                        RecCustLedger."Amount to Apply" := RecCustLedger."Remaining Amount";
                        RecCustLedger.MODIFY;
                    UNTIL RecCustLedger.NEXT = 0;
                END ELSE BEGIN
                    RecCustLedger.VALIDATE("Applies-to ID", '');
                    RecCustLedger.VALIDATE("Amount to Apply", 0);
                    RecCustLedger.VALIDATE("Applying Entry", FALSE);
                    IF RecCustLedger.MODIFY THEN;
                END;
                IF TempCust.GET(TEntryNo) THEN
                    PostApplicationEntry.RUN(TempCust);

                CustledgerEntry.FINDFIRST;
            UNTIL CustledgerEntry.NEXT = 0;


        /*
        VendledgerEntry.RESET;
        VendledgerEntry.SETFILTER("Entry No.",'<>%1',0);
        VendledgerEntry.SETRANGE(Open,TRUE);
         IF VendledgerEntry.FIND('-') THEN
          REPEAT
           RecVendLedger.RESET;
           RecVendLedger.SETRANGE(Open,TRUE);
           IF RecVendLedger.FIND('-') THEN
            REPEAT
             RecVendLedger."Applies-to ID" := '';
             RecVendLedger."Amount to Apply" := 0;
             RecVendLedger."Applying Entry" := FALSE;
             IF RecVendLedger.MODIFY THEN;
            UNTIL RecVendLedger.NEXT = 0;
           RecVendLedger.RESET;
           RecVendLedger.SETRANGE("Vendor No.",VendledgerEntry."Vendor No.");
           RecVendLedger.SETRANGE("Closed By Entry No. 3.7",VendledgerEntry."Entry No. 3.7");
            IF RecVendLedger.FIND('-') THEN
             BEGIN
              REPEAT
               RecVendLedger.CALCFIELDS("Remaining Amount");
               RecVendLedger.VALIDATE("Applies-to ID",USERID);
               RecVendLedger.VALIDATE("Applying Entry",TRUE);
               RecVendLedger.VALIDATE("Amount to Apply",RecVendLedger."Closed By Amount 3.7");
               RecVendLedger.MODIFY;
              UNTIL RecVendLedger.NEXT = 0;
             END ELSE
              BEGIN
               RecVendLedger.validate("Applies-to ID",'');
               RecVendLedger.validate("Amount to Apply",0);
               RecVendLedger.validate("Applying Entry",FALSE);
               IF RecVendLedger.MODIFY THEN;
              END;
           IF TempVend.GET(VendledgerEntry."Entry No.") THEN
            PostVendApplicationEntry.ApplyVendEntryformEntry(VendledgerEntry);
          UNTIL VendledgerEntry.NEXT = 0;
         */

    end;

    var
        CustledgerEntry: Record "Cust. Ledger Entry";
        RecCustLedger: Record "Cust. Ledger Entry";
        PostApplicationEntry: Codeunit "CustEntry-Apply Posted Entries";
        VendledgerEntry: Record "Vendor Ledger Entry";
        RecVendLedger: Record "Vendor Ledger Entry";
        TempCust: Record "Cust. Ledger Entry";
        ApplyCustEntries: Page "Apply Customer Entries";
        PostVendApplicationEntry: Codeunit "VendEntry-Apply Posted Entries";
        TempVend: Record "Vendor Ledger Entry";

}

