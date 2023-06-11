page 50048 "Commission Payment Subform"
{
    // Customization No. 26 Vipul

    AutoSplitKey = true;
    InsertAllowed = false;
    PageType = ListPart; //16225 Card Change Listpart
    SourceTable = "Transporter Payment Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("MRN No."; Rec."MRN No.")
                {
                    Caption = 'Posted Sales Shipment No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("MRN Date"; Rec."MRN Date")
                {
                    Caption = 'Posted Sales Shipment Date';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Item; Rec.Item)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(UOM; Rec.UOM)
                {
                    Caption = 'Base UOM';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.VALIDATE("Quantity in Sq. Mt.", Rec.CalcQtyPerSqMt);
                        Rec.VALIDATE("Quantity in Carton", Rec.CalcQtyPerCarton);
                        Rec.MODIFY;
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Amount Before Excise"; Rec."Amount Before Excise")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Amount After Excise"; Rec."Amount After Excise")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Calculation Value"; Rec."Calculation Value")
                {
                    ApplicationArea = All;
                }
                field("Commission Type"; Rec."Commission Type")
                {
                    ApplicationArea = All;
                }
                field("Quantity in Carton"; Rec."Quantity in Carton")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quantity in Sq. Mt."; Rec."Quantity in Sq. Mt.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Calculated Commission"; Rec."Calculated Commission")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

