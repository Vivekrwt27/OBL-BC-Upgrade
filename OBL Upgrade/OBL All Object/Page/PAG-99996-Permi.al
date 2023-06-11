page 99995 "Posted Narration Permissions"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Permissions = tabledata 18933 = rim;
    SourceTable = 18933;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}