pageextension 50210 pageextension50210 extends "Reservation Entries"
{
    layout
    {
        addafter("Transferred from Entry No.")
        {
            field(Status; status)
            {
                Editable = false;
                OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Price Approved';
                ApplicationArea = All;
            }
            field(Positive; Rec.Positive)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(CancelReservation)
        {
            trigger OnAfterAction()
            var
                ReservEntry: Record "Reservation Entry";
            begin
                CurrPage.SETSELECTIONFILTER(ReservEntry);
                IF ReservEntry.FIND('-') THEN
                    REPEAT
                        //6700
                        IF SH.GET(SH."Document Type"::Order, ReservEntry."Source ID") THEN
                            SH.TESTFIELD(Status, SH.Status::Open);

                        SONumber := ReservEngineMgt.CreateForText(ReservEntry);
                        SONumber := COPYSTR(SONumber, 12, STRLEN(SONumber));
                        IF NOT (STRLEN(SONumber) > 30) THEN BEGIN
                            SH.RESET;
                            SH.SETRANGE("Document Type", SH."Document Type"::Order);
                            SH.SETFILTER("No.", SONumber);
                            IF SH.FINDFIRST THEN
                                SH.TESTFIELD(Status, SH.Status::Open);
                        END;
                        //6700
                        ReservEntry.TESTFIELD("Reservation Status", rec."Reservation Status"::Reservation);
                        ReservEntry.TESTFIELD("Disallow Cancellation", FALSE);
                        //Upgrade(+)
                        //trident-rakesh-start 260906
                        SalesHeader.RESET;
                        SalesHeader.SETCURRENTKEY("Document Type", "No.");
                        ResvEntry.GET(ReservEntry."Entry No.", FALSE);
                        SalesHeader.SETRANGE("No.", ResvEntry."Source ID");
                        IF SalesHeader.FIND('-') THEN
                            IF SalesHeader."Locked Order" THEN
                                ERROR('Reservation Entry can not be deleted while order is Locked');//TRI Karan

                        TransHeader.RESET;
                        TransHeader.SETCURRENTKEY("No.");
                        ResvEntry.GET(ReservEntry."Entry No.", FALSE);
                        IF TransHeader.GET(ResvEntry."Source ID") THEN
                            IF TransHeader."Locked Order" THEN
                                ERROR('Reservation Entry can not be deleted while order is Locked'); //TRI Karan
                                                                                                     //trident-rakesh-start 260906

                        //Upgrade(-)
                        IF CONFIRM(
                          Text001, FALSE, ReservEntry."Quantity (Base)",
                          ReservEntry."Item No.", ReservEngineMgt.CreateForText(Rec),
                          ReservEngineMgt.CreateFromText(Rec))
                     THEN BEGIN
                            ReservEngineMgt.CancelReservation(ReservEntry);
                            COMMIT;
                        END;
                    UNTIL ReservEntry.NEXT = 0;
            end;
        }
    }

    var
        SH: Record "Sales Header";
        SONumber: Code[100];
        "--------trident--------": Integer;
        SalesHeader: Record "Sales Header";
        TransHeader: Record "Transfer Header";
        ResvEntry: Record "Reservation Entry";
        ReservationEntry: Record "Reservation Entry";
        status: Option;
        SalesHeader1: Record "Sales Header";
        Text001: Label 'Cancel reservation of %1 of item number %2, reserved for %3 from %4?';



}

