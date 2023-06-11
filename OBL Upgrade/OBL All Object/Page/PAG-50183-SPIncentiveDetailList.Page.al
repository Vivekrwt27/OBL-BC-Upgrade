page 50183 "SP Incentive Detail List"
{
    Editable = false;
    PageType = List;
    SourceTable = "Payment Terms Location Wise";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("State Code"; rec."State Code")
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

