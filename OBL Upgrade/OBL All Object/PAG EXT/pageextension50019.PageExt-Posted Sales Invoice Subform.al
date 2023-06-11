pageextension 50019 pageextension50019 extends "Posted Sales Invoice Subform"
{

    layout
    {
        addafter("Line Discount %")
        {
            field("GST Place of Supply"; rec."GST Place of Supply")
            {
                ApplicationArea = All;
            }
            field("GST Group Code"; rec."GST Group Code")
            {
                ApplicationArea = All;
            }
            field("GST Group Type"; rec."GST Group Type")
            {
                ApplicationArea = All;
            }
            field("HSN/SAC Code"; rec."HSN/SAC Code")
            {
                ApplicationArea = All;
            }
            field("GST Jurisdiction Type"; rec."GST Jurisdiction Type")
            {
                ApplicationArea = All;
            }

            field("Line No."; rec."Line No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("TCS Nature of Collection"; rec."TCS Nature of Collection")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        moveafter("Shortcut Dimension 2 Code"; "Gross Weight", "Net Weight", "Location Code", "Tax Area Code", "Description 2", "Tax Group Code")
        addafter("Shortcut Dimension 2 Code")
        {
            field("Offer Code"; rec."Offer Code")
            {
                ApplicationArea = All;
            }
            field("Posting Date"; rec."Posting Date")
            {
                ApplicationArea = All;
            }
            field("Sell-to Customer No."; rec."Sell-to Customer No.")
            {
                ApplicationArea = All;
            }
            field(COCO; rec.COCO)
            {
                ApplicationArea = All;
            }
            field("Group Code"; rec."Group Code")
            {
                ApplicationArea = All;
            }
            field(Slab; rec.Slab)
            {
                ApplicationArea = All;
            }
            field("Document No."; rec."Document No.")
            {
                ApplicationArea = All;
            }
            /*   field("VAT %"; rec."VAT %")
              {
                  ApplicationArea = All;
              } */
            field(Remarks; rec.Remarks)
            {
                ApplicationArea = All;
            }
            field(Amount; rec.Amount)
            {
                ApplicationArea = All;
            }
            field("Quantity in Cartons"; rec."Quantity in Cartons")
            {
                ApplicationArea = All;
            }
            field("Buyer's Price"; rec."Buyer's Price")
            {
                ApplicationArea = All;
            }
            field("Discount Per Unit"; rec."Discount Per Unit")
            {
                ApplicationArea = All;
            }
            field("Quantity in Sq. Mt."; rec."Quantity in Sq. Mt.")
            {
                ApplicationArea = All;
            }
            field("Size Code"; rec."Size Code")
            {
                ApplicationArea = All;
            }
            field("Color Code"; rec."Color Code")
            {
                ApplicationArea = All;
            }
            field("Quantity Discount Amount"; rec."Quantity Discount Amount")
            {
                ApplicationArea = All;
            }
            field("Accrued Discount"; rec."Accrued Discount")
            {
                ApplicationArea = All;
            }
            field("Qty. per Unit of Measure"; rec."Qty. per Unit of Measure")
            {
                ApplicationArea = All;
            }
            field(buyerprice; buyerprice)
            {
                Caption = 'Buyer Price/CRT';
                ApplicationArea = All;
            }
        }
    }

    var
        buyerprice: Decimal;

    trigger OnAfterGetRecord()
    begin
        IF rec.Type = rec.Type::Item THEN
            buyerprice := (rec."Buyer's Price" / rec."Qty. per Unit of Measure")
        ELSE
            buyerprice := 0
    end;
}