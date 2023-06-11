pageextension 50044 pageextension50044 extends "Posted Purchase Receipts"
{
    layout
    {

        addafter("Shipment Method Code")
        {
            field("Form 38 No."; rec."Form 38 No.")
            {
                ApplicationArea = All;
            }
            field(Residue; rec.Residue)
            {
                ApplicationArea = All;
            }
            field(Moisture; rec.Moisture)
            {
                ApplicationArea = All;
            }
            field("Your Reference"; rec."Your Reference")
            {
                ApplicationArea = All;
            }
            field("Gate Entry No."; rec."Gate Entry No.")
            {
                ApplicationArea = All;
            }
            field("Total Recd. Quantity"; rec."Total Recd. Quantity")
            {
                ApplicationArea = All;
            }
            field("GE No."; rec."GE No.")
            {
                ApplicationArea = All;
            }

            field("Transporter's Code"; rec."Transporter's Code")
            {
                ApplicationArea = All;
            }
            field("Order No."; rec."Order No.")
            {
                ApplicationArea = All;
            }
            field("Order Date"; rec."Order Date")
            {
                ApplicationArea = All;
            }
            field("Vendor Invoice No."; rec."Vendor Invoice No.")
            {
                ApplicationArea = All;
            }
            field("Total Qty. Rcd. Not Invoiced"; rec."Total Qty. Rcd. Not Invoiced")
            {
                Caption = 'Qty. Rcd. Not Invoiced';
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("Total UnitCost(LCY)"; rec."Total UnitCost(LCY)")
            {
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            field("Transporter Name"; rec."Transporter Name")
            {
                ApplicationArea = All;
            }
            field("Vendor Order No."; rec."Vendor Order No.")
            {
                Caption = 'Truck No';
                ApplicationArea = All;
            }
            field("Vendor Invoice Date"; rec."Vendor Invoice Date")
            {
                ApplicationArea = All;
            }
            field("Vendor Shipment No."; rec."Vendor Shipment No.")
            {
                ApplicationArea = All;
            }
            field("GE Date"; rec."GE Date")
            {
                ApplicationArea = All;
            }
            field("Capex No."; rec."Capex No.")
            {
                ApplicationArea = All;
            }
            field("User ID"; rec."User ID")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("E-Way Bill No."; rec."E-Way Bill No.")
            {
                ApplicationArea = All;
            }

        }
    }
}

