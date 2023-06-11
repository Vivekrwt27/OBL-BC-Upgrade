page 50059 "Item Group 2"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Item Group";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Group Code"; rec."Group Code")
                {
                    ApplicationArea = All;
                }
                field(COCO; rec.COCO)
                {
                    ApplicationArea = All;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Description2; rec.Description2)
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

