page 50086 "WS Sales Target"
{
    PageType = List;
    SourceTable = Capacity;
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Production Line"; rec."Production Line")
                {
                    ApplicationArea = All;
                }
                field(Size; rec.Size)
                {
                    ApplicationArea = All;
                }
                field(Capicity; rec.Capicity)
                {
                    ApplicationArea = All;
                }
                field("type Category Code"; rec."type Category Code")
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

