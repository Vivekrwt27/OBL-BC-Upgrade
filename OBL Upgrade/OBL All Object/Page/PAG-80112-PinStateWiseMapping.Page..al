page 80112 "Pin State Wise Mapping"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Pin State Wise Mapping";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Pin No."; Rec."Pin No.")
                {
                    ApplicationArea = All;
                }
                field("State Code"; Rec."State Code")
                {
                    ApplicationArea = All;
                }
                field("State Name"; Rec."State Name")
                {
                    ApplicationArea = All;
                }
                field("Sales Terretory"; Rec."Sales Terretory")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field("City Name"; Rec."City Name")
                {
                    ApplicationArea = All;
                }
                field(Zone; Rec.Zone)
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