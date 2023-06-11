page 50124 "Matrix Master List Lookup"
{
    PageType = Card;
    SourceTable = "Matrix Master";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Mapping Type"; Rec."Mapping Type")
                {
                    ApplicationArea = All;
                }
                field("Type 1"; Rec."Type 1")
                {
                    ApplicationArea = All;
                }
                field("Type 2"; Rec."Type 2")
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        IF CurrPage.LOOKUPMODE THEN
            CurrPage.EDITABLE := FALSE;
    end;
}

