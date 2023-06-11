page 50011 "SMS - Mobile No. List"
{
    PageType = Card;
    SourceTable = "SMS - Mobile No.";
    UsageCategory = Lists;
    ApplicationArea = ALL;

    layout
    {
        area(content)
        {
            repeater(GROUP)
            {
                Editable = false;
                field("Mobile No."; Rec."Mobile No.")
                {
                    ApplicationArea = All;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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

