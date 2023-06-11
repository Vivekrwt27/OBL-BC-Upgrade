pageextension 50457 pageextension50457 extends "Posted Transfer Shipment"
{
    layout
    {

    }

    actions
    {
        addafter("&Navigate")
        {
            action("GST Transfer Invoice")
            {
                Caption = 'GST Transfer Invoice';
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    TransferShipmentHeader: Record "Transfer Shipment Header";
                begin
                    TransferShipmentHeader.RESET;
                    TransferShipmentHeader.SETRANGE("No.", Rec."No.");
                    IF TransferShipmentHeader.FIND('-') THEN
                        REPORT.RUN(50317, TRUE, FALSE, TransferShipmentHeader);
                end;
            }
        }
    }

    var
        myInt: Integer;
}