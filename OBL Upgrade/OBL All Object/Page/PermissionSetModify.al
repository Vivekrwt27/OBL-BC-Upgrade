page 66000 "Permission Set Modify"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Permissions = tabledata "Permission Set" = rimd;
    SourceTable = "Permission Set";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Role ID"; Rec."Role ID")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
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