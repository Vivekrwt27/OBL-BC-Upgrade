page 50281 "LC Detail for Export"
{
    PageType = List;
    SourceTable = "LC Detail for Export";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("LC No."; Rec."LC No.")
                {
                    ApplicationArea = All;
                }
                field("LC Date"; Rec."LC Date")
                {
                    ApplicationArea = All;
                }
                field("LC Issuing Bank"; Rec."LC Issuing Bank")
                {
                    ApplicationArea = All;
                }
                field("Terms of Delivery"; Rec."Terms of Delivery")
                {
                    ApplicationArea = All;
                }
                field("Place of Discharge"; Rec."Place of Discharge")
                {
                    ApplicationArea = All;
                }
                field("Plant of Final Distenation"; Rec."Plant of Final Distenation")
                {
                    ApplicationArea = All;
                }
                field("Customer Code"; Rec."Customer Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customer Exim Code"; Rec."Customer Exim Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ecc No."; Rec."Ecc No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Issueing Date"; Rec."Issueing Date")
                {
                    ApplicationArea = All;
                }
                field("Proforma Invoice"; Rec."Proforma Invoice")
                {
                    ApplicationArea = All;
                }
                field("Exporter Bank Detail"; Rec."Exporter Bank Detail")
                {
                    ApplicationArea = All;
                }
                field("Sales Order"; Rec."Sales Order")
                {
                    ApplicationArea = All;
                }
                field(Tolerance; Rec.Tolerance)
                {
                    ApplicationArea = All;
                }
                field("Port of Loading"; Rec."Port of Loading")
                {
                    ApplicationArea = All;
                }
                field("Port of Discharge"; Rec."Port of Discharge")
                {
                    ApplicationArea = All;
                }
                field(Origin; Rec.Origin)
                {
                    ApplicationArea = All;
                }
                field("Partial & Trans Shipment"; Rec."Partial & Trans Shipment")
                {
                    ApplicationArea = All;
                }
                field("Discription of Goods"; Rec."Discription of Goods")
                {
                    ApplicationArea = All;
                }
                field(Harmonic; Rec.Harmonic)
                {
                    ApplicationArea = All;
                }
                field("Post of Discharge"; Rec."Post of Discharge")
                {
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payment Terms Desc"; Rec."Payment Terms Desc")
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

