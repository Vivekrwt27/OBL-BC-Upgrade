page 50229 "Sales Person Incentive Details"
{
    PageType = List;
    SourceTable = "Payment Terms Location Wise";
    UsageCategory = Lists;
    ApplicationArea = all;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("State Code"; Rec."State Code")
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

