page 50004 "Item Classification"
{
    PageType = Card;
    SourceTable = "Item Classification";
    UsageCategory = Lists;
    ApplicationArea = all;


    layout
    {
        area(content)
        {
            repeater(group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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
            }
        }
    }

    actions
    {
    }
}

