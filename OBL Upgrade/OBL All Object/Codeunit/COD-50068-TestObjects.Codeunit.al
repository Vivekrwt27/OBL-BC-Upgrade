codeunit 50068 "Test Objects"
{

    trigger OnRun()
    var
        Item: Record Item;
    begin
        Item.RESET;
        IF Item.FINDFIRST THEN
            REPEAT
                Item.Blocked := FALSE;
                Item.Blocked2 := FALSE;
                Item.MODIFY;
            UNTIL Item.NEXT = 0;
        //GenerateCustomerVoucher;
        //FromCompany := 'Associate Vendors-Morbi-Old';
        //ToCompany := 'Associate Vendors-Morbi';

        //FromCompany := 'Orient Bell Limited-Old';
        //ToCompany := 'Orient Bell Limited';
        //UpdateMastersAndSetup;
        //CopyPicture;
        MESSAGE('Done');
    end;

    var
        LocObject: Record "Indent Status History";
        ProgressWindow: Dialog;
        FromCompany: Text;
        ToCompany: Text;

    local procedure CopyData(ParObjectID: Integer)
    var
        LocSourceTable: RecordRef;
        LocTargetTable: RecordRef;
        LocSourceField: FieldRef;
        LocTargetField: FieldRef;
        LocIntCounter: Integer;
        LocIntRecordCounter: Integer;
        RecordSkip: Boolean;
        OptClass: Option Normal,FlowFilter,FlowField;
        FieldType: Text;
    begin
        LocSourceTable.OPEN(ParObjectID, FALSE, FromCompany);
        // here you have to insert your record selection
        IF LocSourceTable.FIND('-') THEN BEGIN
            LocIntRecordCounter := 0;
            LocTargetTable.OPEN(ParObjectID, FALSE, ToCompany);
            REPEAT
                LocIntRecordCounter += 1;
                RecordSkip := FALSE;
                LocTargetTable.INIT();
                FOR LocIntCounter := 1 TO LocSourceTable.FIELDCOUNT() DO BEGIN
                    LocSourceField := LocSourceTable.FIELDINDEX(LocIntCounter);
                    LocTargetField := LocTargetTable.FIELD(LocSourceField.NUMBER);
                    LocTargetField.VALUE(LocSourceField.VALUE);
                    IF LocSourceField.NAME = 'Not Required' THEN
                        IF UPPERCASE(FORMAT(LocSourceField.VALUE)) IN ['TRUE', 'YES'] THEN
                            RecordSkip := TRUE;
                    EVALUATE(OptClass, FORMAT(LocSourceField.CLASS));
                    EVALUATE(FieldType, FORMAT(LocSourceField.TYPE));
                    //IF (OptClass = OptClass::FlowField) AND (FieldType='Blob') THEN
                    IF (FieldType = 'BLOB') THEN
                        LocSourceField.CALCFIELD();
                END;
                IF SetTables(ParObjectID) THEN BEGIN
                    IF LocTargetTable.FINDFIRST THEN
                        LocTargetTable.DELETEALL;
                END;
                IF NOT LocTargetTable.GET(LocSourceTable.RECORDID) THEN // This is true and will find the first record in the table.
                                                                        //MESSAGE('MyRecordRef does not find');
                    IF NOT RecordSkip THEN
                        LocTargetTable.INSERT(FALSE);
            UNTIL LocSourceTable.NEXT = 0;
        END;

        LocTargetTable.CLOSE();
        LocSourceTable.CLOSE();
    end;

    local procedure SetTables(TableID: Integer): Boolean
    begin
        IF TableID IN [77, 78, 98, 311, 312, 313, 314, 315, 409, 843, 1108, 1200, 1270, 5079, 5603, 5604, 5769, 5911, 99000765] THEN
            EXIT(TRUE);
    end;

    local procedure UpdateMastersAndSetup()
    begin
        //IF LocObject.FINDFIRST THEN
        //LocObject.MODIFYALL(Processed ,FALSE);

        // 15578    LocObject.SETRANGE(Processed, FALSE);
        IF LocObject.FIND('-') THEN BEGIN
            ProgressWindow.OPEN('Processing table number #1#######');
            REPEAT
                SLEEP(100);
                ProgressWindow.UPDATE(1, LocObject."Reporting Date");
                // Process the account.

                //     CopyData(LocObject."Reporting Date");
                //    LocObject.Processed := TRUE;
                LocObject.MODIFY;
                COMMIT;
            UNTIL LocObject.NEXT = 0;
            ProgressWindow.CLOSE;
        END;
    end;

    local procedure GenerateCustomerVoucher()
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        GlobalDim1: Code[20];
    begin
        GlobalDim1 := 'HEADOFFICE';
        CustLedgerEntry.CHANGECOMPANY(FromCompany);
        CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Currency Code");
        //CustLedgerEntry.SETFILTER("Customer No.",'%1','C101216053004201');
        CustLedgerEntry.SETRANGE(Open, TRUE);
        WITH CustLedgerEntry DO BEGIN
            REPEAT
                CustLedgerEntry.CALCFIELDS(Amount, "Amount (LCY)", "Remaining Amount", "Remaining Amt. (LCY)");
                GenJournalLine.CHANGECOMPANY(ToCompany);
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'DEFAULT';
                GenJournalLine."Document Type" := "Document Type";
                GenJournalLine.VALIDATE("Document No.", "Document No.");
                GenJournalLine.VALIDATE("Posting Date", "Posting Date");
                GenJournalLine."Line No." := "Entry No.";
                GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                GenJournalLine.VALIDATE("Account No.", "Customer No.");
                GenJournalLine."External Document No." := "External Document No.";

                //GenJournalLine."Dimension Set ID":= "Dimension Set ID";
                // GenJournalLine."Shortcut Dimension 1 Code" := CustLedgerEntry."Global Dimension 1 Code";
                // GenJournalLine."Shortcut Dimension 2 Code" := CustLedgerEntry."Global Dimension 2 Code";
                IF CustLedgerEntry."Global Dimension 1 Code" <> '' THEN
                    GenJournalLine."Shortcut Dimension 1 Code" := CustLedgerEntry."Global Dimension 1 Code"
                ELSE
                    GenJournalLine."Shortcut Dimension 1 Code" := 'HEADOFFICE';
                GenJournalLine.ValidateShortcutDimCode(1, GenJournalLine."Shortcut Dimension 1 Code");
                // GenJournalLine.ValidateShortcutDimCode(2,CustLedgerEntry."Global Dimension 2 Code");
                GenJournalLine.VALIDATE(Amount, "Remaining Amount");
                GenJournalLine.VALIDATE("Amount (LCY)", "Remaining Amt. (LCY)");
                GenJournalLine."Currency Code" := "Currency Code";
                GenJournalLine."Due Date" := CustLedgerEntry."Due Date";
                GenJournalLine."Entry No. 3.7" := CustLedgerEntry."Entry No.";
                GenJournalLine."Cheque No." := CustLedgerEntry."Cheque No.";
                GenJournalLine."Cheque Date" := CustLedgerEntry."Cheque Date";
                GenJournalLine.Description2 := CustLedgerEntry.Description2;
                //   GenJournalLine.Narration := CustLedgerEntry.Description;
                GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                GenJournalLine."Bal. Account No." := '99999999.1';
                //GenJournalLine."Currency Factor" := CustLedgerEntry.Exc
                GenJournalLine."Document Date" := "Document Date";
                GenJournalLine.INSERT;
            UNTIL NEXT = 0;
        END;
    end;

    local procedure CopyPicture()
    var
        FromItem: Record Vendor;
        ToItem: Record Vendor;
    begin
        FromItem.RESET;
        FromItem.CHANGECOMPANY(FromCompany);
        IF FromItem.FINDFIRST THEN BEGIN
            REPEAT
                ToItem.CHANGECOMPANY(ToCompany);
            /* IF ToItem.GET(FromItem."No.") THEN BEGIN
                 FromItem.CALCFIELDS(Picture);
                 IF FromItem.Picture.HASVALUE THEN BEGIN
                     ToItem.Picture := FromItem.Picture;
                     ToItem.MODIFY;
                 END;
             END;*/  // 15578
            UNTIL FromItem.NEXT = 0;
        END;
    end;
}

