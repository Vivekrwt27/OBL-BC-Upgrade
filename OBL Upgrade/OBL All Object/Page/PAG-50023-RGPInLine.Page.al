page 50023 "RGP In Line"
{
    // Customization No. 63

    AutoSplitKey = true;
    DelayedInsert = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "RGP Line";
    SourceTableView = WHERE("Document Type" = CONST(In));
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("RGP Out No."; Rec."RGP Out No.")
                {
                    ApplicationArea = All;
                }
                field("RGP Outline No."; Rec."RGP Outline No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec."Document Type" := Rec."Document Type"::"In"
                    end;
                }
                field("No."; Rec."No.")
                {
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec."Document Type" := Rec."Document Type"::"In"
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quantity to Receive"; Rec."Quantity to Receive")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Receiving Quantity"; Rec."Receiving Quantity")
                {
                    ApplicationArea = All;
                }
                field("Approximate Price"; Rec."Approximate Price")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Receiving Date"; Rec."Receiving Date")
                {
                    ApplicationArea = All;
                }
                field("HSN Code"; Rec."HSN Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Customization No. 63 Start Vipul
        //       "Document Type" := xRec."Document Type"
        //Customization No. 63 End Vipul
    end;

    var
        RGPLine: Record "RGP Line";
        RGPHeader: Record "RGP Header";
}

