codeunit 50112 "Functionincodeunit"
{
    procedure ShowItemafter01048(var item: Record 27)
    var
        valueentry: Record 5802;
    begin
        WITH valueentry DO BEGIN
            RESET;
            SETCURRENTKEY("Item No.", "Expected Cost", "Valuation Date", "Location Code", "Variant Code");
            SETRANGE("Item No.", item."No.");
            SETRANGE("Expected Cost", FALSE);
            SETFILTER("Valuation Date", '%1..', 20080401D);
            SETFILTER("Location Code", item.GETFILTER("Location Filter"));
            SETFILTER("Variant Code", item.GETFILTER("Variant Filter"));
        END;
        PAGE.RUNMODAL(PAGE::"Value Entries", valueentry, valueentry."Cost Amount (Actual)");
    end;

    procedure UpdateUserSetup()
    var
        RecUserSetup: Record 91;
        FinanceDays: Integer;
        SalesDay: Integer;
        PurchaseDay: Integer;
        ProdDay: Integer;
        MRNUser: Integer;
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.GET;
        IF GLSetup."Posting Date Changed On" = TODAY THEN
            EXIT;
        FinanceDays := 3;
        SalesDay := 0;
        PurchaseDay := 2;
        ProdDay := 2;
        MRNUser := 1;
        IF (FORMAT(GLSetup."Allow Posting From") <> '') AND (FORMAT(GLSetup."Allow Posting To") <> '') THEN BEGIN
            RecUserSetup.RESET;
            RecUserSetup.SETRANGE("ByPass Auto Posting Date", FALSE);
            IF RecUserSetup.FINDFIRST THEN BEGIN
                RecUserSetup.MODIFYALL("Allow Posting From", TODAY);
                RecUserSetup.MODIFYALL("Allow FA Posting From", TODAY);
                RecUserSetup.MODIFYALL("Allow Posting To", TODAY);
                RecUserSetup.MODIFYALL("Allow FA Posting To", TODAY);
            END;
            RecUserSetup.SETRANGE("Purchase User", TRUE);
            IF RecUserSetup.FINDFIRST THEN BEGIN
                RecUserSetup.MODIFYALL("Allow Posting From", TODAY - PurchaseDay);
                RecUserSetup.MODIFYALL("Allow FA Posting From", TODAY - PurchaseDay);
                RecUserSetup.MODIFYALL("Allow Posting To", TODAY);
                RecUserSetup.MODIFYALL("Allow FA Posting To", TODAY);
            END;
            RecUserSetup.SETRANGE("Purchase User", FALSE);
            RecUserSetup.SETRANGE("Finance User", TRUE);
            IF RecUserSetup.FINDFIRST THEN BEGIN
                RecUserSetup.MODIFYALL("Allow Posting From", TODAY - FinanceDays);
                RecUserSetup.MODIFYALL("Allow FA Posting From", TODAY - FinanceDays);
                RecUserSetup.MODIFYALL("Allow Posting To", TODAY);
                RecUserSetup.MODIFYALL("Allow FA Posting To", TODAY);
            END;
            RecUserSetup.SETRANGE("Finance User", FALSE);
            RecUserSetup.SETRANGE(RecUserSetup."Sales User", TRUE);
            IF RecUserSetup.FINDFIRST THEN BEGIN
                RecUserSetup.MODIFYALL("Allow Posting From", TODAY - SalesDay);
                RecUserSetup.MODIFYALL("Allow Posting To", TODAY);
            END;
            RecUserSetup.SETRANGE("Sales User", FALSE);
            RecUserSetup.SETRANGE(RecUserSetup."Prod. User", TRUE);
            IF RecUserSetup.FINDFIRST THEN BEGIN
                RecUserSetup.MODIFYALL("Allow Posting From", TODAY - ProdDay);
                RecUserSetup.MODIFYALL("Allow Posting To", TODAY);
            END;

            RecUserSetup.SETRANGE("Prod. User", FALSE);
            RecUserSetup.SETRANGE(RecUserSetup."Warehouse User", TRUE);
            IF RecUserSetup.FINDFIRST THEN BEGIN
                RecUserSetup.MODIFYALL("Allow Posting From", TODAY - MRNUser);
                RecUserSetup.MODIFYALL("Allow Posting To", TODAY);
            END;
            GLSetup."Posting Date Changed On" := TODAY;
            GLSetup.MODIFY;
        END;
    end;

    procedure CheckUserPostingRights(TransactionType: Integer; LocationCode: Code[20])
    var
        RecUserLocations: Record 50007;
    begin
        CASE TransactionType OF
            30: //Transfer Shipment
                BEGIN
                    RecUserLocations.RESET;
                    RecUserLocations.SETRANGE("User ID", UPPERCASE(USERID));
                    RecUserLocations.SETFILTER(RecUserLocations."Transfer Shipment", '%1', TRUE);
                    RecUserLocations.SETFILTER(RecUserLocations."Location Code", '%1', LocationCode);
                    IF NOT RecUserLocations.FINDFIRST THEN BEGIN
                        ERROR('You do not have Permission to Ship The Material for Location %1', LocationCode);
                    END;
                END;
            31: //Transfer Reciept
                BEGIN
                    RecUserLocations.RESET;
                    RecUserLocations.SETRANGE("User ID", UPPERCASE(USERID));
                    RecUserLocations.SETFILTER(RecUserLocations."Transfer Reciept", '%1', TRUE);
                    RecUserLocations.SETFILTER(RecUserLocations."Location Code", '%1', LocationCode);
                    IF NOT RecUserLocations.FINDFIRST THEN BEGIN
                        ERROR('You do not have Permission to Receive The Material for Location %1', LocationCode);
                    END;
                END;

        END;
    end;

    /* 
        [EventSubscriber(ObjectType::Codeunit, 5604, 'OnAfterCopyFromGenJnlLine', '', false, false)]
        local procedure OnAfterCopyFromGenJnlLine(var FALedgerEntry: Record "FA Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
        begin
            FALedgerEntry.Description := GenJournalLine.Narration;
        end;
     */
    procedure PrintInvoiceType(SalesInvHeader: Record 112; Location: Record 14): Text[50]
    var
        Customer: Record 18;
    begin
        //Reason of customization refers to comment 1 in documentation.
        IF Customer.GET(SalesInvHeader."Sell-to Customer No.") THEN BEGIN
            IF Location."State Code" = Customer."State Code" THEN BEGIN
                //  IF Customer."T.I.N. No." <> '' THEN BEGIN
                //  EXIT('VAT/TAX Invoice');
                //END ELSE
                BEGIN
                    EXIT('Retail/Sales Invoice');
                END;
            END ELSE BEGIN
                EXIT('Retail/Sales Invoice');
            END;
        END ELSE BEGIN
            EXIT('');
        END;
    end;


    /* [EventSubscriber(ObjectType::Codeunit, 5642, 'OnBeforeGenJnlLineInsert', '', false, false)]
    local procedure OnBeforeGenJnlLineInsert(var GenJournalLine: Record "Gen. Journal Line"; var FAReclassJournalLine: Record "FA Reclass. Journal Line"; Sign: Integer)
    begin
        GenJournalLine.Narration := FAReclassJournalLine.Description;
    end;
 */
    /*  [EventSubscriber(ObjectType::Codeunit, 395, 'OnAfterInitGenJnlLine', '', false, false)]
     local procedure OnAfterInitGenJnlLine(var GenJnlLine: Record "Gen. Journal Line"; FinChargeMemoHeader: Record "Finance Charge Memo Header"; var SrcCode: Code[10])
     begin

         GenJnlLine.Narration := FinChargeMemoHeader."Posting Description";

     end;

  */


    procedure UpdateStructureCalculated(SalesHeader: Record 36)
    var
        SalesLine: Record 37;
    begin
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE("Structure Calculated", FALSE);
        IF SalesLine.FINDFIRST THEN BEGIN
            REPEAT
                SalesLine."Structure Calculated" := TRUE;
                SalesLine.MODIFY;
            UNTIL SalesLine.NEXT = 0;
        END;
    end;


    procedure CheckStructureCalculated(SalesHeader: Record 36)
    var
        SalesLine: Record 37;
        Text50000: Label 'Kindly Press F10, To correct Tax on Order.';
    begin
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE("Structure Calculated", FALSE);
        IF SalesLine.FINDFIRST THEN BEGIN
            REPEAT
                ERROR(Text50000);
            UNTIL SalesLine.NEXT = 0;
        END;
    end;


    procedure UpdateStructureCalculated1(SalesHeader: Record 36)
    var
        SalesLine: Record 37;
    begin
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type"::Invoice);
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE("Structure Calculated", FALSE);
        IF SalesLine.FINDFIRST THEN BEGIN
            REPEAT
                SalesLine."Structure Calculated" := TRUE;
                SalesLine.MODIFY;
            UNTIL SalesLine.NEXT = 0;
        END;
    end;


    procedure UpdateStructureCalculated2(SalesHeader: Record 36)
    var
        SalesLine: Record 37;
    begin
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE("Structure Calculated", TRUE);
        SalesLine.SETFILTER(SalesLine."Outstanding Quantity", '<>%1', 0);
        IF SalesLine.FINDFIRST THEN BEGIN
            REPEAT
                SalesLine."Structure Calculated" := FALSE;
                SalesLine.MODIFY;
            UNTIL SalesLine.NEXT = 0;
        END;
    end;
}