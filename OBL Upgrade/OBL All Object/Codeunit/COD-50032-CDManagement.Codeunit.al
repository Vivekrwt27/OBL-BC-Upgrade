codeunit 50032 "CD Management"
{
    Permissions = TableData "Sales Invoice Header" = rm,
                  TableData "Detailed Cust. Ledg. Entry" = rm;

    trigger OnRun()
    begin
        CDEntry1.RESET;
        //CDEntry1.SETFILTER("Cust. No.",'%1','C101411025602276'); //Cust
        CDEntry1.SETRANGE(Posted, FALSE);
        IF CDEntry1.FINDFIRST THEN
            CDEntry1.DELETEALL;

        UpdateCollectionDate;
        ProcessCD;
        /*IF DATE2DMY(TODAY,1)=1 THEN
        UpdateCustomerBalance;*/
        IF GUIALLOWED THEN
            MESSAGE('Done');
    end;

    var
        DetCustLedgerEntry: Record "Detailed Cust. Ledg. Entry";
        SalesSetup: Record "Sales & Receivables Setup";
        CustLedgEntry: Record "Cust. Ledger Entry";
        SalesInvHeader: Record "Sales Invoice Header";
        CDEntry1: Record "CD Entry";
        SlabRate: Decimal;
        ToleranceAmt: Decimal;
        CdEntry: Record "CD Entry";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DocNo: Code[20];
        UpperLimit: array[10] of Integer;
        RecCustomer: Record Customer;
        MaxSlab: Decimal;
        GSTCalculatedPosted: Codeunit "GST Calculated Posted";


    procedure ProcessCD()
    begin
        SalesSetup.GET;
        SalesInvHeader.RESET;
        SalesInvHeader.SETCURRENTKEY("Posting Date");
        SalesInvHeader.SETFILTER("Posting Date", '>=%1', 20230410D);
        SalesInvHeader.SETFILTER("CD Applicable", '%1', TRUE);
        //SalesInvHeader.SetRange("No.", 'SIPL/2223/022424');
        //SalesInvHeader.SETFILTER("Sell-to Customer No.",'%1','C101411025602276'); //Cust
        IF SalesInvHeader.FINDFIRST THEN BEGIN
            REPEAT
                IF RecCustomer.GET(SalesInvHeader."Sell-to Customer No.") THEN
                    //IF RecCustomer.Blocked = 0 THEN
                        CreateEntry(SalesInvHeader);
            UNTIL SalesInvHeader.NEXT = 0;
        END;
    end;


    procedure GetSalesInvoiceDueDate(EntryNo: Integer; PaymentRecieptDate: Date): Integer
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        IF EntryNo = 0 THEN
            EXIT;
        IF CustLedgEntry.GET(EntryNo) THEN BEGIN
            CustLedgEntry.CALCFIELDS(CustLedgEntry."Remaining Amount");
            IF CustLedgEntry."Remaining Amount" = 0 THEN BEGIN
                IF PaymentRecieptDate - CustLedgEntry."Due Date" > 0 THEN
                    EXIT(PaymentRecieptDate - CustLedgEntry."Due Date");
            END;
        END;
    end;


    procedure CreateEntry(SalesInvHeader: Record "Sales Invoice Header")
    var
        CDEntry: Record "CD Entry";
        CDDays: Integer;
        PaymentRecDate: Date;
        CDBaseAmount: Decimal;
        AmounttoCustomer: Decimal;
    begin
        GSTCalculatedPosted.PostedDocumentGSTCalculated(SalesInvHeader, AmounttoCustomer);

        ToleranceAmt := 10;
        IF SalesInvHeader."Discount Charges %" <> 0 THEN
            EXIT;
        SalesInvHeader.CALCFIELDS(SalesInvHeader."Remaining Amount");
        IF SalesInvHeader."Remaining Amount" > ToleranceAmt THEN
            EXIT;
        IF NOT CDEntry.GET(0, SalesInvHeader."Cust. Ledger Entry No.") THEN BEGIN
            SalesInvHeader.CALCFIELDS("Last Payment Receipt Date");
            // 15578 110423 SalesInvHeader.CALCFIELDS("Last Payment Receipt Date", "Tax Base", "Insurance Amt");
            IF AmounttoCustomer = SalesInvHeader."Remaining Amount" THEN
                EXIT;
            // IF SalesInvHeader."Free Supply" THEN
            //EXIT;

            CDEntry.INIT;
            CDEntry."CD Document Type" := 0;
            CDEntry."Cust. Entry No." := SalesInvHeader."Cust. Ledger Entry No.";
            CDEntry."Cust. No." := SalesInvHeader."Sell-to Customer No.";
            CDEntry."Customer Type" := RecCustomer."Customer Type";
            CDEntry."Invoice Amount" := AmounttoCustomer;
            CDEntry."Payment Amount" := AmounttoCustomer - SalesInvHeader."Remaining Amount";
            CDEntry."State Code" := SalesInvHeader.State;
            CDEntry."Invoice No." := SalesInvHeader."No.";
            CDEntry."Order No." := SalesInvHeader."Order No.";
            //CDEntry."CD Base Amount" :=SalesInvHeader."Tax Base";
            //15578  CDBaseAmount := CalculateTaxableAmount(SalesInvHeader);
            CDBaseAmount := AmounttoCustomer;
            CDEntry."CD Base Amount" := CDBaseAmount;
            CDEntry."Insurance Amount" := SalesInvHeader."Insurance Amt";

            PaymentRecDate := SalesInvHeader."Last Payment Receipt Date";
            IF PaymentRecDate = 0D THEN
                CDDays := 0
            ELSE
                CDDays := (PaymentRecDate - SalesInvHeader."Posting Date");

            IF PaymentRecDate = SalesInvHeader."Posting Date" THEN
                CDDays := 1;

            CDEntry."Posting Date" := SalesInvHeader."Posting Date";
            CDEntry."Due Date" := SalesInvHeader."Due Date";
            CDEntry."Reciept Date" := PaymentRecDate;

            IF (SalesInvHeader."Remaining Amount" = 0) AND (CDDays > 0) THEN
                CDEntry."CD Days" := ABS(CDDays);

            CLEAR(UpperLimit);
            CLEAR(MaxSlab);
            SlabRate := GetCDSlab(SalesInvHeader."Sell-to Customer No.", SalesInvHeader."Customer Type", SalesInvHeader."Posting Date", CDDays, UpperLimit);
            CDEntry."Next Slab Date" := CalculateNextSlabs(CDDays, SalesInvHeader."Posting Date", PaymentRecDate);

            CDEntry."Holidays Grace" := NoHolidayExists(SalesInvHeader.State, CDEntry."Next Slab Date", PaymentRecDate);

            IF (CDEntry."Holidays Grace" <> CDDays) AND (CDDays <> 0) THEN
                CDDays := CDDays - CDEntry."Holidays Grace";

            SlabRate := GetCDSlab(SalesInvHeader."Sell-to Customer No.", SalesInvHeader."Customer Type", SalesInvHeader."Posting Date", CDDays, UpperLimit);
            //  ERROR('%1-%2-%3-%4=%5',SalesInvHeader."Sell-to Customer No.",SalesInvHeader."Posting Date",CDDays,'zzz',SlabRate);
            //IF CDDays > MaxSlab THEN
            //  EXIT;

            CDEntry."CD % age" := SlabRate;
            //CDEntry."CD Amount" := ROUND((((CDBaseAmount-SalesInvHeader."Insurance Amt") * SlabRate)/100),0.01);
            CDEntry."CD Amount" := ROUND((((CDBaseAmount) * SlabRate) / 100), 0.01);
            IF (CDDays > 0) AND (PaymentRecDate <> 0D) THEN
                CDEntry.INSERT;
        END;
    end;


    procedure GenerateDebitNote()
    begin
    end;


    procedure GetNexTPaymentEntryNo(): Integer
    var
        CDEntry: Record "CD Entry";
    begin
        CDEntry.RESET;
        CDEntry.SETRANGE("CD Document Type", 1);
        IF CDEntry.FINDLAST THEN
            EXIT(CDEntry."Cust. Entry No." + 1)
        ELSE
            EXIT(900000000);
    end;


    procedure GetInvoiceEntry(EntryNo: Integer)
    begin
        IF EntryNo = 0 THEN
            EXIT;
        IF CustLedgEntry.GET(EntryNo) THEN;
        CustLedgEntry.CALCFIELDS(CustLedgEntry.Amount, CustLedgEntry."Remaining Amount");
    end;


    procedure GetCDSlab(CustNo: Code[20]; CustType: Code[20]; PostingDate: Date; Days: Integer; var ArraySlab: array[10] of Integer) Slab: Decimal
    var
        RecCust: Record Customer;
        StateWiseCDSlabs: Record "State Wise CD Slabs";
        CDApplicableSlab: Record "CD Applicable";
        RecordFound: Boolean;
        SlabFound: Boolean;
        I: Integer;
    begin
        RecCust.GET(CustNo);
        RecordFound := FALSE;
        IF CustType = '' THEN
            CustType := RecCust."Customer Type";

        CLEAR(ArraySlab);
        CDApplicableSlab.RESET;
        CDApplicableSlab.SETFILTER(Type, '%1', CDApplicableSlab.Type::Customer);
        CDApplicableSlab.SETFILTER(Code, '%1', CustNo);
        CDApplicableSlab.SETFILTER(Include, '%1', TRUE);
        IF CDApplicableSlab.FINDFIRST THEN BEGIN
            RecordFound := TRUE;
            ArraySlab[1] := CDApplicableSlab."Days Slab 0";
            ArraySlab[2] := CDApplicableSlab."Days Slab 1";
            ArraySlab[3] := CDApplicableSlab."Days Slab 2";
            ArraySlab[4] := CDApplicableSlab."Days Slab 3";
            ArraySlab[5] := CDApplicableSlab."Days Slab 4";
            ArraySlab[6] := CDApplicableSlab."Days Slab 5";
            ArraySlab[7] := CDApplicableSlab."Days Slab 6";
        END;
        IF NOT RecordFound THEN BEGIN
            CDApplicableSlab.RESET;
            //  CDApplicableSlab.SETFILTER(Type,'%1',CDApplicableSlab.Type::"Customer Type");
            CDApplicableSlab.SETFILTER("State Code", '%1', RecCust."State Code");
            CDApplicableSlab.SETFILTER(Code, '%1', CustType);
            CDApplicableSlab.SETFILTER(Include, '%1', TRUE);
            IF CDApplicableSlab.FINDFIRST THEN BEGIN
                ArraySlab[1] := CDApplicableSlab."Days Slab 0";
                ArraySlab[2] := CDApplicableSlab."Days Slab 1";
                ArraySlab[3] := CDApplicableSlab."Days Slab 2";
                ArraySlab[4] := CDApplicableSlab."Days Slab 3";
                ArraySlab[5] := CDApplicableSlab."Days Slab 4";
                ArraySlab[6] := CDApplicableSlab."Days Slab 5";
                ArraySlab[7] := CDApplicableSlab."Days Slab 6";
            END;
        END;
        MaxSlab := 0;
        FOR I := 1 TO 9 DO BEGIN
            //IF ArraySlab[I]>0 THEN
            IF ArraySlab[I] > MaxSlab THEN
                MaxSlab := ArraySlab[I]
        END;
        //IF MaxSlab=0 THEN
        //  MaxSlab:=30;
        SlabFound := FALSE;
        StateWiseCDSlabs.RESET;
        StateWiseCDSlabs.SETFILTER(Type, '%1', StateWiseCDSlabs.Type::Customer);
        StateWiseCDSlabs.SETFILTER("State/Customer Code", '%1', RecCust."No.");
        StateWiseCDSlabs.SETFILTER("Effective Date", '%1..%2', 0D, PostingDate);
        IF StateWiseCDSlabs.FINDLAST THEN BEGIN
            SlabFound := TRUE;
            CASE Days OF
                ArraySlab[1] .. ArraySlab[2]:
                    EXIT(StateWiseCDSlabs."Slab 1");
                ArraySlab[2] .. ArraySlab[3]:
                    EXIT(StateWiseCDSlabs."Slab 2");
                ArraySlab[3] .. ArraySlab[4]:
                    EXIT(StateWiseCDSlabs."Slab 3");
                ArraySlab[4] .. ArraySlab[5]:
                    EXIT(StateWiseCDSlabs."Slab 4");
                ArraySlab[5] .. ArraySlab[6]:
                    EXIT(StateWiseCDSlabs."Slab 5");
                ArraySlab[6] .. ArraySlab[7]:
                    EXIT(StateWiseCDSlabs."Slab 6");
            END;
        END;
        IF NOT SlabFound THEN BEGIN
            StateWiseCDSlabs.RESET;
            StateWiseCDSlabs.SETFILTER(Type, '%1', StateWiseCDSlabs.Type::State);
            StateWiseCDSlabs.SETFILTER("State/Customer Code", '%1', RecCust."State Code");
            StateWiseCDSlabs.SETFILTER("Effective Date", '%1..%2', 0D, PostingDate);
            IF StateWiseCDSlabs.FINDLAST THEN BEGIN
                //    ERROR('hi - %1',CustType);
                CASE Days OF
                    ArraySlab[1] .. ArraySlab[2]:
                        EXIT(StateWiseCDSlabs."Slab 1");
                    ArraySlab[2] .. ArraySlab[3]:
                        EXIT(StateWiseCDSlabs."Slab 2");
                    ArraySlab[3] .. ArraySlab[4]:
                        EXIT(StateWiseCDSlabs."Slab 3");
                    ArraySlab[4] .. ArraySlab[5]:
                        EXIT(StateWiseCDSlabs."Slab 4");
                    ArraySlab[5] .. ArraySlab[6]:
                        EXIT(StateWiseCDSlabs."Slab 5");
                    ArraySlab[6] .. ArraySlab[7]:
                        EXIT(StateWiseCDSlabs."Slab 6");
                END;
            END;
        END;
    end;


    procedure CreateGenJounalLine(TemplateName: Code[20]; BatchName: Code[20]; var "GLCD Entry": Record "CD Entry")
    var
        GenJLine: Record "Gen. Journal Line";
        LineNo: Integer;
        GenJLineNew: Record "Gen. Journal Line";
        SalesSetup: Record "Sales & Receivables Setup";
        GenJournalBatch: Record "Gen. Journal Batch";
    begin
        SalesSetup.GET;
        SalesSetup.TESTFIELD("CD Account");
        GenJLine.INIT;
        GenJLine.SETRANGE("Journal Template Name", TemplateName);
        GenJLine.SETRANGE(GenJLine."Journal Batch Name", BatchName);
        IF GenJLine.FINDLAST THEN
            LineNo := GenJLine."Line No." + 10000
        ELSE
            LineNo := 10000;

        GenJournalBatch.RESET;
        GenJournalBatch.SETRANGE("Journal Template Name", TemplateName);
        GenJournalBatch.SETRANGE(GenJournalBatch.Name, BatchName);
        IF GenJournalBatch.FINDFIRST THEN;
        CLEAR(NoSeriesMgt);
        //DocNo := NoSeriesMgt.
        //NoSeriesMgt.InitSeries(GenJournalBatch."No. Series",GenJournalBatch."No. Series",TODAY,DocNo,GenJournalBatch."No. Series");
        DocNo := NoSeriesMgt.GetNextNo(GenJournalBatch."No. Series", WORKDATE, TRUE);
        BEGIN
            GenJLineNew.INIT;
            GenJLineNew."Journal Template Name" := TemplateName;
            GenJLineNew."Journal Batch Name" := BatchName;
            GenJLineNew."Document No." := DocNo;
            GenJLineNew."Line No." := LineNo;
            GenJLineNew.VALIDATE("Location Code", 'HEADOFFICE');
            GenJLineNew."Posting Date" := TODAY;

            GenJLineNew.INSERT();

            GenJLineNew."Account Type" := GenJLineNew."Account Type"::Customer;
            GenJLineNew.VALIDATE("Account No.", "GLCD Entry"."Cust. No.");
            GenJLineNew.VALIDATE(Amount, "GLCD Entry"."CD Amount");
            GenJLineNew.VALIDATE("External Document No.", "GLCD Entry"."Invoice No.");
            GenJLineNew.VALIDATE("Bal. Account Type", GenJLineNew."Bal. Account Type"::"G/L Account");
            GenJLineNew.VALIDATE("Bal. Account No.", SalesSetup."CD Account");
            GenJLineNew.MODIFY;

            "GLCD Entry".Posted := TRUE;
            "GLCD Entry".MODIFY;
        END;
    end;


    procedure GenerateVoucher(TemplateNAme: Code[20]; BatchName: Code[20])
    begin
        CdEntry.RESET;
        CdEntry.SETRANGE(Posted, FALSE);
        IF CdEntry.FINDFIRST THEN BEGIN
            REPEAT
                CreateGenJounalLine(TemplateNAme, BatchName, CdEntry);
            UNTIL CdEntry.NEXT = 0;
        END;
    end;


    procedure CalculateNextSlabs(TempDays: Integer; InvDate: Date; RecieptDate: Date): Date
    var
        K: Integer;
        i: Integer;
    begin
        IF TempDays > MaxSlab THEN
            EXIT;
        TempDays := ROUND((TempDays / 10), 1, '<') * 10;

        EXIT(InvDate + TempDays);
    end;


    procedure NoHolidayExists(StateCode: Code[10]; StartDate: Date; EndDate: Date): Integer
    var
        StateWiseHolidays: Record "State wise Holiday";
        HolidaysExist: Integer;
    begin
        IF (EndDate = 0D) OR (StartDate = 0D) THEN
            EXIT;
        StateWiseHolidays.RESET;
        StateWiseHolidays.SETRANGE("State Code", StateCode);
        StateWiseHolidays.SETRANGE(Date, StartDate, EndDate);
        IF StateWiseHolidays.FINDFIRST THEN
            HolidaysExist := StateWiseHolidays.COUNT;

        IF (EndDate - StartDate) = HolidaysExist THEN
            EXIT(HolidaysExist);
    end;


    procedure ISCDApplicable(CustomerNo: Code[20]): Boolean
    var
        CDApplicable: Record "CD Applicable";
        RecCustomer: Record Customer;
    begin
        RecCustomer.GET(CustomerNo);
        //Sepcific Customer
        CDApplicable.RESET;
        CDApplicable.SETRANGE("State Code", RecCustomer."State Code");
        CDApplicable.SETRANGE(Code, RecCustomer."No.");
        IF CDApplicable.FINDFIRST THEN
            EXIT(CDApplicable.Include);

        //Customer type
        CDApplicable.SETRANGE("State Code", RecCustomer."State Code");
        CDApplicable.SETRANGE(Code, RecCustomer."Customer Type");
        IF CDApplicable.FINDFIRST THEN
            EXIT(CDApplicable.Include);
    end;


    /* procedure CalculateTaxableAmount(SalesInvHeader: Record 112) SaleableValue: Decimal
     var
         SalesInvLine: Record 113;
         PostedStrOrderLDetails: Record 13798;
         InvDisc: Decimal;
         ExAmount: Decimal;
     begin
         SalesInvLine.RESET;
         SalesInvLine.SETRANGE(SalesInvLine."Document No.", SalesInvHeader."No.");
         SalesInvLine.SETFILTER(Type, '%1|%2|%3', SalesInvLine.Type::Item, SalesInvLine.Type::"G/L Account", SalesInvLine.Type::Resource);
         SalesInvLine.SETRANGE(SalesInvLine.Supplementary, FALSE);
         SalesInvLine.SETFILTER(Quantity, '<>%1', 0);
         IF SalesInvLine.FINDFIRST THEN BEGIN
             REPEAT
                 IF NOT SalesInvLine."Free Supply" THEN BEGIN
                     IF SalesInvLine.Amount <> 0 THEN
                         ExAmount += SalesInvLine.Amount + SalesInvLine."Excise Amount"
                     ELSE
                         IF SalesInvLine."Line Discount %" <> 100 THEN
                             ExAmount += ROUND((SalesInvLine."Unit Price" * SalesInvLine.Quantity) +
                              SalesInvLine."Excise Amount", 0.01, '=');
                 END ELSE BEGIN
                     ExAmount += SalesInvLine.Amount + SalesInvLine."Excise Amount";
                 END;
             UNTIL SalesInvLine.NEXT = 0;
             InvDisc := 0;
             PostedStrOrderLDetails.RESET;
             PostedStrOrderLDetails.SETRANGE("Document Type", PostedStrOrderLDetails."Document Type"::Invoice);
             PostedStrOrderLDetails.SETRANGE("Invoice No.", SalesInvHeader."No.");
             PostedStrOrderLDetails.SETRANGE("Tax/Charge Group", 'DISCOUNT');
             IF PostedStrOrderLDetails.FIND('-') THEN BEGIN
                 REPEAT
                     InvDisc += PostedStrOrderLDetails.Amount;
                 UNTIL PostedStrOrderLDetails.NEXT = 0;
             END;
         END;
         SaleableValue := ExAmount - ABS(InvDisc);
         EXIT(SaleableValue);
     end;*/ // 15578


    procedure UtiliseCD(SalesInvHeader: Record "Sales Invoice Header"; UtilisedAmt: Decimal; InvNo: Code[20])
    var
        SalesHeader: Record "Sales Header";
        AmounttoCustomer: Decimal;
        RecSalesInvoiceLine: Record "Sales Invoice Line";
    begin
        Clear(AmounttoCustomer);

        //TEAM 14763 03-06-23
        RecSalesInvoiceLine.RESET;
        RecSalesInvoiceLine.SetRange("Document No.", SalesInvHeader."No.");
        RecSalesInvoiceLine.SetRange(Type, RecSalesInvoiceLine.Type::Item);
        if RecSalesInvoiceLine.FindFirst then
            RecSalesInvoiceLine.CalcSums("Amount Inc CD");
        //TEAM 14763 03-06-23

        GSTCalculatedPosted.PostedDocumentGSTCalculated(SalesInvHeader, AmounttoCustomer);

        CdEntry.INIT;
        CdEntry."CD Document Type" := 1;
        CdEntry."Cust. Entry No." := GetNexTPaymentEntryNo;
        CdEntry."Cust. No." := SalesInvHeader."Sell-to Customer No.";
        IF UtilisedAmt > 0 THEN
            UtilisedAmt := -1 * UtilisedAmt;
        CdEntry."Invoice Amount" := AmounttoCustomer;
        CdEntry."Payment Amount" := UtilisedAmt;
        CdEntry."State Code" := SalesInvHeader.State;
        CdEntry."Invoice No." := InvNo;
        CdEntry."Sales Order No." := SalesInvHeader."No.";
        CdEntry."Posting Date" := SalesInvHeader."Posting Date";
        CdEntry."Due Date" := SalesInvHeader."Due Date";
        CdEntry."CD Amount" := UtilisedAmt;
        CdEntry."CD Base Amount" := RecSalesInvoiceLine."Amount Inc CD"; //TEAM 14763 03-06-23
        CdEntry.Posted := TRUE;
        IF CdEntry."CD Amount" <> 0 THEN
            CdEntry.INSERT;

        SalesHeader.RESET;
        SalesHeader.SETCURRENTKEY("Document Type", "Sell-to Customer No.");
        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SETFILTER("Sell-to Customer No.", '%1', SalesInvHeader."Sell-to Customer No.");
        SalesHeader.SETFILTER("No.", '<>%1', SalesInvHeader."Order No."); //MSKS2610

        IF SalesHeader.FINDFIRST THEN
            REPEAT
                SalesHeader."Posting Date" := 0D;
                SalesHeader.MODIFY;
            UNTIL SalesHeader.NEXT = 0;
    end;

    local procedure UpdateCollectionDate()
    var
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        DetailedCustLedgEntry.RESET;
        DetailedCustLedgEntry.SETCURRENTKEY("Document No.", "Document Type", "Posting Date");
        DetailedCustLedgEntry.SETRANGE("Document Type", DetailedCustLedgEntry."Document Type"::Payment);
        DetailedCustLedgEntry.SETRANGE("Collection Date", 0D);
        IF DetailedCustLedgEntry.FINDFIRST THEN BEGIN
            REPEAT
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETCURRENTKEY("Document No.", "Posting Date", "Transaction No.");
                CustLedgerEntry.SETRANGE("Document No.", DetailedCustLedgEntry."Document No.");
                IF CustLedgerEntry.FINDFIRST THEN BEGIN
                    DetailedCustLedgEntry."Collection Date" := CustLedgerEntry."Posting Date";
                    DetailedCustLedgEntry.MODIFY;
                END;
            UNTIL DetailedCustLedgEntry.NEXT = 0;
        END;
    end;

    local procedure UpdateCustomerBalance()
    var
        Customer: Record Customer;
    begin
        WITH Customer DO BEGIN
            REPEAT
                Customer.CALCFIELDS(Balance);
                IF Customer.Balance > 0 THEN
                    Customer."Available Credit Limit IBOT" := Customer.Balance
                ELSE
                    Customer."Available Credit Limit IBOT" := 0;
                Customer.MODIFY
            UNTIL Customer.NEXT = 0;
        END;
    end;

    local procedure CalculateUpperSlabLimit(Customer: Record Customer)
    var
        CDApplicable: Record "CD Applicable";
    begin
        CDApplicable.RESET;
    end;
}