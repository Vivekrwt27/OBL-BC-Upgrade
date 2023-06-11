page 50212 "Delegation of Authority"
{
    PageType = List;
    SourceTable = "Sales Person Leave Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sales Person Code"; Rec."Sales Person Code")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
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
        /*UserSetup.GET(USERID);
        IF NOT UserSetup.DOA THEN
          ERROR('Not Allowed');
          */

    end;

    var
        UserSetup: Record "User Setup";
}

