pageextension 50244 pageextension50244 extends "Purchase List"
{
    layout
    {
        addafter("Currency Code")
        {
            field(ShipmentNo; ShipmentNo)
            {
                Caption = 'Return Shipment No.';
                Editable = false;
                ApplicationArea = All;
            }
            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = All;
            }
            field("No. of Archived Versions"; Rec."No. of Archived Versions")
            {
                ApplicationArea = All;
            }
            field("Payment Terms Code"; Rec."Payment Terms Code")
            {
                ApplicationArea = All;
            }
            field("Receiving No."; Rec."Receiving No.")
            {
                ApplicationArea = All;
            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
            field("Vendor Shipment No."; Rec."Vendor Shipment No.")
            {
                ApplicationArea = All;
            }
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
            field("Bal. Account No."; Rec."Bal. Account No.")
            {
                ApplicationArea = All;
            }
            field(Invoice; Rec.Invoice)
            {
                ApplicationArea = All;
            }
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
                ApplicationArea = All;
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field("GE No."; Rec."GE No.")
            {
                ApplicationArea = All;
            }
            field("Ordered Qty"; Rec."Ordered Qty")
            {
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("Total Recd. Quantity"; Rec."Total Recd. Quantity")
            {
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
            }
        }
    }

    var
        RecShipmentNo: Record "Return Shipment Header";
        ShipmentNo: Code[20];

    trigger OnAfterGetRecord()//16225 Add Block Code
    begin
        IF Rec."Document Type" = Rec."Document Type"::"Return Order" THEN BEGIN
            ShipmentNo := '';
            RecShipmentNo.RESET;
            RecShipmentNo.SETRANGE(RecShipmentNo."Return Order No.", Rec."No.");
            IF RecShipmentNo.FINDFIRST THEN BEGIN
                ShipmentNo := RecShipmentNo."No.";
            END;
        END;
    end;

}

