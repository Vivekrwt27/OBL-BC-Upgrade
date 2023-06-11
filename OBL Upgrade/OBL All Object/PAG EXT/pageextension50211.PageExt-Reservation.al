pageextension 50211 pageextension50211 extends Reservation
{

    //Unsupported feature: Property Insertion (SourceTableView) on "Reservation(Page 498)".

    layout
    {
        moveafter(Filters; TotalReservedQuantity, QtyAllocatedInWarehouse, TotalAvailableQuantity, "Non-specific Reserved Qty.", "Current Reserved Quantity", "ReservMgt.FormatQty(""Res. Qty. on Picks & Shipmts."")")
        addafter(Filters)
        {
            repeater(group)
            {
                Editable = false;
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                }
                field("Source Subtype"; Rec."Source Subtype")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Warranty Date"; Rec."Warranty Date")
                {
                    ApplicationArea = All;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ApplicationArea = All;
                }
                field("Total Requested Quantity"; Rec."Total Requested Quantity")
                {
                    ApplicationArea = All;
                }
                field("Selected Quantity"; Rec."Selected Quantity")
                {
                    ApplicationArea = All;
                }
                field("Current Pending Quantity"; Rec."Current Pending Quantity")
                {
                    ApplicationArea = All;
                }
                field("Current Requested Quantity"; Rec."Current Requested Quantity")
                {
                    ApplicationArea = All;
                }
                field("Bin Content"; Rec."Bin Content")
                {
                    ApplicationArea = All;
                }
                field("Bin Active"; Rec."Bin Active")
                {
                    ApplicationArea = All;
                }
                field("Double-entry Adjustment"; Rec."Double-entry Adjustment")
                {
                    ApplicationArea = All;
                }

            }

        }
        moveafter("Bin Active"; "Summary Type", "Total Quantity")
    }
    actions
    {
        modify("Auto Reserve")
        {
            ShortCutKey = 'Ctrl+R';
        }

        modify(CancelReservationCurrentLine)
        {
            ShortCutKey = 'Ctrl+C';
            trigger OnAfterAction()
            begin
                //Upgrade(+)
                //Trident-Rakesh-Start
                SalesOrder.RESET;
                SalesOrder.SETCURRENTKEY("Document Type", "No.");
                SalesOrder.SETRANGE("No.", ReservEntry."Source ID");
                IF SalesOrder.FIND('-') THEN
                    IF SalesOrder."Locked Order" THEN
                        ERROR('Reservation Entry can not be deleted while order is Locked');
                TransHeader.RESET;
                TransHeader.SETCURRENTKEY("No.");
                IF TransHeader.GET(ReservEntry."Source ID") THEN
                    IF TransHeader."Locked Order" THEN
                        ERROR('Reservation Entry can not be deleted while order is Locked');
                //trident-rakesh-start 260906

                //trident-rakesh End

                //Upgrade(-)

            end;
        }

    }

    var
        "-----------trident--------": Integer;
        SalesOrder: Record "Sales Header";
        TransHeader: Record "Transfer Header";
        ReservEntry: Record "Reservation Entry";
}

