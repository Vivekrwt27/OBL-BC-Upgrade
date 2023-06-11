codeunit 50072 "Auto Reserve"
{

    trigger OnRun()
    begin
        ProcessCDOrder;
        ProcessCreditClearOrder;
        ProcessPriceOrder;
        //ProcessRemainingOrder;
    end;

    var
        ReserveMgt: Codeunit 99000845;
        FullAutoReservation: Boolean;
        SalesHeader: Record 36;

    local procedure ProcessCDOrder()
    begin
        SalesHeader.RESET;
        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SETFILTER("Discount Charges %", '<>%1', 0);
        SalesHeader.SETRANGE("Order Date", 20230410D, TODAY);
        SalesHeader.SETFILTER("No.", '%1', 'SOSKD/2223/028154');
        SalesHeader.SETFILTER(Status, '<>%1', SalesHeader.Status::Released);
        SalesHeader.SETFILTER("Location Code", '<>%1', 'DP-MORBI');
        IF SalesHeader.FINDFIRST THEN
            REPEAT
                ProcessSalesOrders(SalesHeader."No.", '', '');
            UNTIL SalesHeader.NEXT = 0;
    end;

    local procedure ProcessCreditClearOrder()
    begin
        SalesHeader.RESET;
        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SETFILTER("Discount Charges %", '%1', 0);
        SalesHeader.SETRANGE("Order Date", 20230410D, TODAY);
        SalesHeader.SETFILTER("No.", '%1', 'SOSKD/2223/028154');
        SalesHeader.SETFILTER(Status, '<>%1', SalesHeader.Status::Released);
        SalesHeader.SETFILTER("Credit Approved", '%1', TRUE);
        SalesHeader.SETFILTER("Location Code", '<>%1', 'DP-MORBI');
        IF SalesHeader.FINDFIRST THEN
            REPEAT
                ProcessSalesOrders(SalesHeader."No.", '', '');
            UNTIL SalesHeader.NEXT = 0;
    end;

    local procedure ProcessPriceOrder()
    begin
        SalesHeader.RESET;
        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SETFILTER(Status, '<>%1', SalesHeader.Status::Released);
        SalesHeader.SETRANGE("Order Date", 20230410D, TODAY);
        SalesHeader.SETFILTER("No.", '%1', 'SOSKD/2223/028154');
        SalesHeader.SETFILTER("Price Approved", '%1', TRUE);
        SalesHeader.SETFILTER("Location Code", '<>%1', 'DP-MORBI');
        IF SalesHeader.FINDFIRST THEN
            REPEAT
                ProcessSalesOrders(SalesHeader."No.", '', '');
            UNTIL SalesHeader.NEXT = 0;
    end;

    local procedure ProcessRemainingOrder()
    begin
        SalesHeader.RESET;
        //SalesHeader.SETCURRENTKEY();
        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SETFILTER("Discount Charges %", '%1', 0);
        //SalesHeader.SETFILTER("No.",'%1','SOSKD/2223/029881');
        SalesHeader.SETFILTER(Status, '<>%1', SalesHeader.Status::Released);
        SalesHeader.SETCURRENTKEY("Document Type", "Order Date");
        IF SalesHeader.FINDFIRST THEN
            REPEAT
                ProcessSalesOrders(SalesHeader."No.", '', '');
            UNTIL SalesHeader.NEXT = 0;
    end;


    procedure ProcessSalesOrders(DocNo: Code[20]; ItemNo: Code[20]; LocNo: Code[20])
    var
        SalesLine: Record 37;
        Item: Record 27;
        AvailableInventory: Decimal;
        Qty: Decimal;
        QtyBase: Decimal;
        ReservEntry: Record 337;
        TempEntrySummary: Record 338 temporary;
        SalesHeader: Record 36;
    begin
        IF DocNo <> '' THEN BEGIN
            DeleteItemTrackingLines(DocNo, 0);
            CreateItemTrackingLines(DocNo, 0);
        END;
        SalesLine.RESET;
        SalesLine.SETCURRENTKEY("Document Type", "No.", "Promised Delivery Date");
        SalesLine.SETFILTER("Document Type", '%1', SalesLine."Document Type"::Order);

        IF DocNo <> '' THEN
            SalesLine.SETFILTER("Document No.", '%1', DocNo);
        SalesLine.SETFILTER(Type, '%1', SalesLine.Type::Item);
        IF ItemNo <> '' THEN
            SalesLine.SETFILTER("No.", '%1', ItemNo)
        ELSE
            SalesLine.SETFILTER("No.", '<>%1', '');
        SalesLine.SETFILTER("Outstanding Qty. (Base)", '<>%1', 0);
        IF SalesLine.FINDFIRST THEN BEGIN
            REPEAT
                IF SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.") THEN
                    IF SalesHeader.Status <> SalesHeader.Status::Released THEN BEGIN
                        SalesLine.CALCFIELDS("Reserved Qty. (Base)");
                        Item.GET(SalesLine."No.");
                        Item.CALCFIELDS(Inventory, "Reserved Qty. on Inventory");
                        IF (Item.Inventory - Item."Reserved Qty. on Inventory") > 0 THEN BEGIN
                            AvailableInventory := (Item.Inventory - Item."Reserved Qty. on Inventory");
                            IF AvailableInventory > 0 THEN BEGIN
                                Qty := SalesLine."Outstanding Qty. (Base)" - SalesLine."Reserved Qty. (Base)";
                                QtyBase := Qty;
                                CLEAR(ReserveMgt);
                                SalesLine.Reserve := SalesLine.Reserve::Optional;
                                //  ReserveMgt.SetSalesLine(SalesLine);
                                //ReserveMgt.SetReserveAgainstInventory(TRUE);

                                IF not (SalesHeader."Credit Approved") AND not (SalesHeader."Inventory Approved") AND not (SalesHeader."Price Approved") THEN
                                    ReserveMgt.AutoReserve(
                                    FullAutoReservation, 'AUTO-RESERVE',
                                    SalesLine."Promised Delivery Date", Qty, QtyBase);
                            END;
                        END;
                    END;
            UNTIL SalesLine.NEXT = 0;
        END;
    end;


    procedure CreateItemTrackingLines(DocNo: Code[20]; DocLineNo: Integer)
    var
        ReservationEntry: Record 337;
        TrackingReserveEntry: Record 337;
    begin
        ReservationEntry.RESET;
        ReservationEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date");
        ReservationEntry.SETFILTER("Source ID", '%1', DocNo);
        IF DocLineNo <> 0 THEN
            ReservationEntry.SETFILTER("Source Ref. No.", '%1', DocLineNo);
        ReservationEntry.SETFILTER("Source Type", '<>%1', 32);
        ReservationEntry.SETFILTER("Lot No.", '%1', '');
        IF ReservationEntry.FINDFIRST THEN BEGIN
            REPEAT
                IF TrackingReserveEntry.GET(ReservationEntry."Entry No.", NOT ReservationEntry.Positive) THEN BEGIN
                    IF (TrackingReserveEntry."Source Type" = 32) AND (TrackingReserveEntry."Lot No." <> '') THEN BEGIN
                        ReservationEntry."Lot No." := TrackingReserveEntry."Lot No.";
                        ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking"::"Lot No.";
                        ReservationEntry.MODIFY;
                    END;
                END;
            UNTIL ReservationEntry.NEXT = 0;
        END;
    end;

    local procedure DeleteItemTrackingLines(DocNo: Code[20]; DocLineNo: Integer)
    var
        ReservationEntry: Record 337;
        TrackingReserveEntry: Record 337;
    begin
        ReservationEntry.RESET;
        ReservationEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date");
        IF DocNo <> '' THEN
            ReservationEntry.SETFILTER("Source ID", '%1', DocNo);
        IF DocLineNo <> 0 THEN
            ReservationEntry.SETFILTER("Source Ref. No.", '%1', DocLineNo);
        ReservationEntry.SETFILTER("Source Type", '%1|%2|%3', 5407, 39, 37);
        IF ReservationEntry.FINDFIRST THEN BEGIN
            REPEAT
                IF ReservationEntry."Reservation Status" = ReservationEntry."Reservation Status"::Surplus THEN BEGIN
                    ReservationEntry.DELETE;
                END;
                IF ReservationEntry."Reservation Status" = ReservationEntry."Reservation Status"::Tracking THEN BEGIN
                    IF ReservationEntry."Lot No." <> '' THEN BEGIN
                        IF TrackingReserveEntry.GET(ReservationEntry."Entry No.", NOT ReservationEntry.Positive) THEN BEGIN
                            TrackingReserveEntry.DELETE;
                            ReservationEntry.DELETE;
                        END;
                    END ELSE BEGIN
                        IF TrackingReserveEntry.GET(ReservationEntry."Entry No.", NOT ReservationEntry.Positive) THEN BEGIN
                            TrackingReserveEntry.DELETE;
                            ReservationEntry.DELETE;
                        END;
                    END;
                END;
            UNTIL ReservationEntry.NEXT = 0;
        END;
    end;
}

