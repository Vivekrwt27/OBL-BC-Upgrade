page 99991 "Gen Product Posting Group New"
{
    PageType = Card;
    Permissions = tabledata 251 = rim;
    SourceTable = "Gen. Product Posting Group";

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