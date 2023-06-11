pageextension 50400 pageextension50400 extends "Output Journal"
{
    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                TrySetApplyToEntries;
            end;
        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            begin
                TrySetApplyToEntries;
            end;
        }
    }

    local procedure TrySetApplyToEntries()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemJournalLine2: Record "Item Journal Line";
        ReservationEntry: Record "Reservation Entry";
    begin
        ItemJournalLine2.COPY(Rec);
        IF ItemJournalLine2.FINDSET THEN
            REPEAT
                IF FindReservationsReverseOutput(ReservationEntry, ItemJournalLine2) THEN
                    REPEAT
                        IF FindILEFromReservation(ItemLedgerEntry, ItemJournalLine2, ReservationEntry, Rec."Order No.") THEN BEGIN
                            ReservationEntry.VALIDATE("Appl.-to Item Entry", ItemLedgerEntry."Entry No.");
                            ReservationEntry.MODIFY(TRUE);
                        END;
                    UNTIL ReservationEntry.NEXT = 0;

            UNTIL ItemJournalLine2.NEXT = 0;
    end;

    local procedure FindReservationsReverseOutput(var ReservationEntry: Record "Reservation Entry"; ItemJnlLine: Record "Item Journal Line"): Boolean
    begin
        IF ItemJnlLine.Quantity >= 0 THEN
            EXIT(FALSE);

        ReservationEntry.SETCURRENTKEY(
          "Source ID", "Source Ref. No.", "Source Type", "Source Subtype",
          "Source Batch Name", "Source Prod. Order Line");
        ReservationEntry.SETRANGE("Source ID", ItemJnlLine."Journal Template Name");
        ReservationEntry.SETRANGE("Source Ref. No.", ItemJnlLine."Line No.");
        ReservationEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
        ReservationEntry.SETRANGE("Source Subtype", ItemJnlLine."Entry Type");
        ReservationEntry.SETRANGE("Source Batch Name", ItemJnlLine."Journal Batch Name");

        ReservationEntry.SETFILTER("Serial No.", '<>%1', '');
        ReservationEntry.SETRANGE("Qty. to Handle (Base)", -1);
        ReservationEntry.SETRANGE("Appl.-to Item Entry", 0);

        EXIT(ReservationEntry.FINDSET);
    end;

    local procedure FindILEFromReservation(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJnlLine: Record "Item Journal Line"; ReservationEntry: Record "Reservation Entry"; ProductionOrderNo: Code[20]): Boolean
    begin
        ItemLedgerEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive,
          "Location Code", "Posting Date", "Expiration Date", "Lot No.", "Serial No.");

        ItemLedgerEntry.SETRANGE("Item No.", ItemJnlLine."Item No.");
        ItemLedgerEntry.SETRANGE(Open, TRUE);
        ItemLedgerEntry.SETRANGE("Variant Code", ItemJnlLine."Variant Code");
        ItemLedgerEntry.SETRANGE(Positive, TRUE);
        ItemLedgerEntry.SETRANGE("Location Code", ItemJnlLine."Location Code");
        ItemLedgerEntry.SETRANGE("Serial No.", ReservationEntry."Lot No.");
        ItemLedgerEntry.SETRANGE("Serial No.", ReservationEntry."Serial No.");
        ItemLedgerEntry.SETRANGE("Document No.", ProductionOrderNo);

        EXIT(ItemLedgerEntry.FINDSET);
    end;
}

