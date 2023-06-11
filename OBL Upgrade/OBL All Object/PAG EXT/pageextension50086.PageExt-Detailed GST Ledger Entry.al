pageextension 50086 pageextension50086 extends "Detailed GST Ledger Entry"
{
    layout
    {
        addafter("GST Amount")
        {
            field("Total Amount"; Rec."GST Base Amount" + rec."GST Amount")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Payment Document No."; "Credit Availed")
        addafter("Payment Type")
        {
            field("Qty In Sq.Mt"; UOM1)
            {
                ApplicationArea = All;
            }
            field("Customer Name"; Custname)
            {
                ApplicationArea = All;
            }
            field("Location Code"; rec."Location Code")
            {
                ApplicationArea = All;
            }
        }
    }
    var
        itemuom: Record "Sales Invoice Line";
        UOM1: Decimal;
        TransferShipmentLine: Record "Transfer Shipment Line";
        Customer1: Record Customer;
        Custname: Text[100];

    trigger OnAfterGetRecord()
    begin
        CLEAR(UOM1);
        itemuom.SETRANGE(Type, itemuom.Type::Item);
        itemuom.SETFILTER(itemuom."No.", '%1', rec."No.");
        itemuom.SETRANGE("Document No.", rec."Document No.");
        IF itemuom.FINDFIRST THEN BEGIN
            UOM1 := itemuom."Quantity (Base)"
        END;

        TransferShipmentLine.SETFILTER("Item No.", '%1', rec."No.");
        TransferShipmentLine.SETRANGE("Document No.", rec."Document No.");
        IF TransferShipmentLine.FINDFIRST THEN BEGIN
            UOM1 := TransferShipmentLine."Quantity (Base)"
        END;

        CLEAR(Custname);
        IF Customer1.GET(rec."Source No.") THEN
            Custname := Customer1.Name;

    end;
}

