pageextension 50214 pageextension50214 extends "Available - Item Ledg. Entries"
{
    actions
    {

        modify(CancelReservation)
        {
            trigger OnAfterAction()
            begin
                ReserEntry.RESET;
                ReserEntry.SETRANGE("Source ID", '');
                ReserEntry.SETRANGE("Source Ref. No.", rec."Entry No.");
                ReserEntry.SETRANGE("Source Type", 32);
                ReserEntry.SETRANGE("Source Subtype", 0);
                ReserEntry.SETRANGE("Source Batch Name", '');
                ReserEntry.SETRANGE("Source Prod. Order Line", 0);
                ReserEntry.SETRANGE("Reservation Status", ReserEntry."Reservation Status"::Reservation);
                IF ReserEntry.FINDFIRST THEN
                    REPEAT
                        SONumber := ReserMgt.CreateForText(ReserEntry);
                        SONumber := COPYSTR(SONumber, 12, STRLEN(SONumber));
                        IF NOT (STRLEN(SONumber) > 29) THEN
                            IF SH.GET(SH."Document Type"::Order, SONumber) THEN
                                SH.TESTFIELD(Status, SH.Status::Open);
                    UNTIL
                    ReserEntry.NEXT = 0;

            end;
        }

    }

    var
        ReserEntry: Record "Reservation Entry";
        ReserMgt: Codeunit "Reservation Engine Mgt.";
        SONumber: Code[30];
        SH: Record "Sales Header";
}

