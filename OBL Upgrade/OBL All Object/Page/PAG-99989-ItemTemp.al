page 99989 "Item_temp1"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = 50030;
    Permissions = tabledata 50030 = rimd;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Type Code"; Rec."Type Code")
                {
                    ApplicationArea = All;
                }
                field("Type Catogery Code"; Rec."Type Catogery Code")
                {
                    ApplicationArea = All;
                }
                field("Size Code"; Rec."Size Code")
                {
                    ApplicationArea = All;
                }
                field("Design Code"; Rec."Design Code")
                {
                    ApplicationArea = All;
                }
                field("Color Code"; Rec."Color Code")
                {
                    ApplicationArea = All;
                }
                field("Packing Code"; Rec."Packing Code")
                {
                    ApplicationArea = All;
                }
                field("Quality Code"; Rec."Quality Code")
                {
                    ApplicationArea = All;
                }
                field("Plant Code"; Rec."Plant Code")
                {
                    ApplicationArea = All;
                }
                field("Item Classification"; Rec."Item Classification")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Excise Prod. Posting Group"; Rec."Excise Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field(COGS; Rec.COGS)
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Default Prod. Plant Code"; Rec."Default Prod. Plant Code")
                {
                    ApplicationArea = All;
                }

                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = All;
                }
                field("Replenishment System"; Rec."Replenishment System")
                {
                    ApplicationArea = All;
                }
                field("Discount Group"; Rec."Discount Group")
                {
                    ApplicationArea = All;
                }
                field("Manuf. Strategy"; Rec."Manuf. Strategy")
                {
                    ApplicationArea = All;
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ApplicationArea = All;
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ApplicationArea = All;
                }
                field("Scheme Group"; Rec."Scheme Group")
                {
                    ApplicationArea = All;
                }
                field(NPD; Rec.NPD)
                {
                    ApplicationArea = All;
                }
                field(Originator; Rec.Originator)
                {
                    ApplicationArea = All;
                }
                field("Tableau Product Group"; Rec."Tableau Product Group")
                {
                    ApplicationArea = All;
                }
                field("Production Group"; Rec."Production Group")
                {
                    ApplicationArea = All;
                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}