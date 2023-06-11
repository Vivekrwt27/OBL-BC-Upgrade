page 99994 "UEI - Source Field List"
{
    Caption = 'Source column';
    Editable = false;
    PageType = Card;
    SourceTable = "Excel Buffer";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("Column No."; rec."Column No.")
                {
                    ApplicationArea = All;
                }
                field(xlColID; rec.xlColID)
                {
                    ApplicationArea = All;
                }
                field("Cell Value as Text"; rec."Cell Value as Text")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

