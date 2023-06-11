page 50139 "Shipment Receipt Report"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Transfer Shipment Line";
    SourceTableView = SORTING("Document No.", "Line No.")
                      ORDER(Ascending)
                      WHERE("Item Category Code" = FILTER('T001|M001'));
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(GROUP)
            {
                field("Transfer Order No."; rec."Transfer Order No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                /* field("Reveiving Amount"; recamt)
                 {
                     Caption = 'Receiving Amount';
                     ApplicationArea = All;
                 }
                 field(recdt; recdt)
                 {
                     Caption = 'Received Date';
                     ApplicationArea = All;
                 }
                 field(rctdoc; rctdoc)
                 {
                     Caption = 'Receipt Docment No.';
                     ApplicationArea = All;

                     trigger OnAssistEdit()
                     begin
                         TRFrect.SETRANGE("Transfer Order No.", Rec."Transfer Order No.")
                     end;
                 }*/
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }
                /*    field(recqty; recqty)
                    {
                        Caption = 'Receipt Qty';
                        ApplicationArea = All;
                    }*/
                field("Description 2"; rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field(Quantity; rec.Quantity)
                {
                    Caption = 'Shiped Quantity';
                    ApplicationArea = All;
                }
                field("Unit of Measure"; rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; rec."Inventory Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Code"; rec."Transfer-from Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Code"; rec."Transfer-to Code")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; rec."Item Category Code")
                {
                    ApplicationArea = All;
                }

                field("Unit Price"; rec."Unit Price")
                {
                    ApplicationArea = All;
                }

                field("Size Code"; rec."Size Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    Caption = 'Ship Date';
                    ApplicationArea = All;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Type Code"; rec."Type Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        recqty := 0;
        TRFrect.SETRANGE("Transfer Order No.", Rec."Transfer Order No.");
        TRFrect.SETRANGE("Item No.", Rec."Item No.");
        IF TRFrect.FINDFIRST THEN
            rctdoc := TRFrect."Document No.";
        recqty := TRFrect.Quantity;
        recdt := TRFrect."Receipt Date";
        recamt := TRFrect.Amount;
    end;

    var
        TRFrect: Record "Transfer Receipt Line";
        rctdoc: Text[30];
        recqty: Decimal;
        recdt: Date;
        recamt: Decimal;
        rectsn: Text[30];
        rectsd: Text[30];
        trfshp: Record "Transfer Shipment Line";
}

