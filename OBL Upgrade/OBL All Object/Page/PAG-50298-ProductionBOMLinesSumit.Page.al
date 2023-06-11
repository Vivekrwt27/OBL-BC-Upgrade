page 50298 "Production BOM Lines Sumit"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Production BOM Line";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Production BOM No."; Rec."Production BOM No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Version Code"; Rec."Version Code")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                }
                field("Position 2"; Rec."Position 2")
                {
                    ApplicationArea = All;
                }
                field("Position 3"; Rec."Position 3")
                {
                    ApplicationArea = All;
                }
                field("Lead-Time Offset"; Rec."Lead-Time Offset")
                {
                    ApplicationArea = All;
                }
                field("Routing Link Code"; Rec."Routing Link Code")
                {
                    ApplicationArea = All;
                }
                field("Scrap %"; Rec."Scrap %")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = All;
                }
                field(Length; Rec.Length)
                {
                    ApplicationArea = All;
                }
                field(Width; Rec.Width)
                {
                    ApplicationArea = All;
                }
                field(Weight; Rec.Weight)
                {
                    ApplicationArea = All;
                }
                field(Depth; Rec.Depth)
                {
                    ApplicationArea = All;
                }
                field("Calculation Formula"; Rec."Calculation Formula")
                {
                    ApplicationArea = All;
                }
                field("Quantity per"; Rec."Quantity per")
                {
                    ApplicationArea = All;
                }
                //16225 Field N/F
                /* field("Principal Input"; "Principal Input")
                 {
                     ApplicationArea = All;
                 }*/
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Scrap Item"; Rec."Scrap Item")
                {
                    ApplicationArea = All;
                }
                field("Scrap Qty Per Square Meter"; Rec."Scrap Qty Per Square Meter")
                {
                    ApplicationArea = All;
                }
                field("Production BOM Desc"; Rec."Production BOM Desc")
                {
                    ApplicationArea = All;
                }
                field("Production BOM Desc2"; Rec."Production BOM Desc2")
                {
                    ApplicationArea = All;
                }
                field("Ref code"; Rec."Ref code")
                {
                    ApplicationArea = All;
                }
                field(BomNo; Rec.BomNo)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

