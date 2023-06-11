codeunit 50099 "Customer Ledger Roundoff"
{

    trigger OnRun()
    begin
        Window.OPEN('Updating  #1########', i);
        i := 0;
        GenJnlLine.RESET;
        GenJnlLine.LOCKTABLE;
        GenJnlLine.SETFILTER("Journal Template Name", '%1', 'General');
        GenJnlLine.SETFILTER("Journal Batch Name", '%1', 'roundoff');
        IF GenJnlLine.FIND('+') THEN
            LineNo := GenJnlLine."Line No." + 10000
        ELSE
            LineNo := 10000;

        CustomerledgerEntry.RESET;
        CustomerledgerEntry.SETFILTER(CustomerledgerEntry."Document Type", '%1', CustomerledgerEntry."Document Type"::Invoice);
        CustomerledgerEntry.SETFILTER(CustomerledgerEntry.Open, '%1', TRUE);
        IF CustomerledgerEntry.FIND('-') THEN
            REPEAT
                CustomerledgerEntry.CALCFIELDS(Amount);
                IF (CustomerledgerEntry.Amount - ROUND(CustomerledgerEntry.Amount, 1, '=')) <> 0 THEN BEGIN
                    GenJnlLine."Journal Template Name" := 'General';
                    GenJnlLine."Journal Batch Name" := 'roundoff';
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                    GenJnlLine."Account No." := CustomerledgerEntry."Customer No.";
                    GenJnlLine."Posting Date" := CustomerledgerEntry."Posting Date";
                    IF (ROUND(CustomerledgerEntry.Amount, 1, '=') - CustomerledgerEntry.Amount) > 0 THEN
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Invoice
                    ELSE
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::"Credit Memo";
                    GenJnlLine."Document No." := 'R' + CustomerledgerEntry."Document No.";
                    //     GenJnlLine.Narration := CustomerledgerEntry.Description;
                    GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                    IF SalesInvoiceHeader.GET(CustomerledgerEntry."Document No.") THEN
                        GenJnlLine.VALIDATE("Location Code", SalesInvoiceHeader."Location Code");
                    IF CustomerRec.GET(CustomerledgerEntry."Customer No.") THEN
                        IF CustomerPostingGroup.GET(CustomerRec."Customer Posting Group") THEN
                            GenJnlLine."Bal. Account No." := CustomerPostingGroup."Invoice Rounding Account";
                    GenJnlLine.VALIDATE(Amount, ROUND(CustomerledgerEntry.Amount, 1, '=') - CustomerledgerEntry.Amount);
                    //GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type" :: invoice;
                    GenJnlLine."Applies-to Doc. Type" := CustomerledgerEntry."Document Type";
                    GenJnlLine."Applies-to Doc. No." := CustomerledgerEntry."Document No.";
                    GenJnlLine.INSERT(TRUE);
                    i := i + 1;
                    Window.UPDATE;
                END;
            UNTIL CustomerledgerEntry.NEXT = 0;
        Window.CLOSE;
        MESSAGE('A total of %1 Lines Generated', i);
    end;

    var
        i: Integer;
        CustomerledgerEntry: Record "Cust. Ledger Entry";
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        Window: Dialog;
        CustomerPostingGroup: Record "Customer Posting Group";
        CustomerRec: Record Customer;
        SalesInvoiceHeader: Record "Sales Invoice Header";
}

