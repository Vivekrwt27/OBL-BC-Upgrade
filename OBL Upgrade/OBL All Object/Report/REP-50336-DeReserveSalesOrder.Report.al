report 50336 "De-Reserve Sales Order"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
            WHERE("Document Type" = CONST(Order),
            Status = FILTER('<>Approved' & '<>Released'),
            "Location Code" = FILTER('SKD-WH-MFG' | 'DRA-WH-MFG' | 'HSK-WH-MFG'),
             "No." = FILTER('<>SOSKD/2223/019897'),
             "Credit Approved" = FILTER(false));
            RequestFilterFields = "No.";
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                trigger OnAfterGetRecord()
                var
                    ReservEntry: Record "Reservation Entry";
                    ReservEntry2: Record "Reservation Entry";
                    ReservEntry3: Record "Reservation Entry";
                    ReservMgt: Codeunit "Reservation Management";
                    ReservationEngineMgt: Codeunit "Reservation Engine Mgt.";
                begin
                    ReservEntry.SETRANGE("Source ID", "Sales Line"."Document No.");
                    ReservEntry.SETRANGE("Source Ref. No.", "Sales Line"."Line No.");
                    ReservEntry.SETRANGE("Reservation Status", ReservEntry2."Reservation Status"::Reservation);
                    ReservEntry.SETRANGE("Disallow Cancellation", FALSE);
                    ReservEntry.SETFILTER("Creation Date", '..%1', TODAY - DefaultPeriod);
                    IF ReservEntry.FINDSET THEN
                        REPEAT
                            IF ReservEntry."Reservation Status" <> ReservEntry."Reservation Status"::Surplus THEN BEGIN
                                ReservEntry2.GET(ReservEntry."Entry No.", NOT ReservEntry.Positive);
                                ReservEntry2.DELETE;
                            END;
                            ReservEntry.DELETE;
                        UNTIL ReservEntry.NEXT = 0;
                end;
            }

            trigger OnAfterGetRecord()
            var
                Location: Record Location;
            begin
                IF Location.GET("Sales Header"."Location Code") THEN BEGIN
                    DefaultPeriod := Location."Delete Reservation Before Days";
                    IF DefaultPeriod = 0 THEN
                        DefaultPeriod := 7;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        DefaultPeriod: Integer;
}

