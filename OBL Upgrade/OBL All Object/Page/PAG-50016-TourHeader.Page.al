page 50016 "Tour Header"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Tour Header";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(GROUP)
            {
                field("Tour No."; rec."Tour No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Purpose; rec.Purpose)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Start Date"; rec."Start Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("End Date"; rec."End Date")
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

