page 50222 "Discontinued Product List"
{
    PageType = List;
    SourceTable = "HVP/Discontinued Items";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("HVP/Discontinued"; Rec."HVP/Discontinued")
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
        IF UPPERCASE(USERID) <> 'FA017' THEN
            ERROR('Sorry You are not Authorized to Run this Page');
    end;
}

