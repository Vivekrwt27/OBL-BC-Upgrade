page 50220 "Scheme Dealer Target"
{
    PageType = List;
    SourceTable = "Customer Scheme Details";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Total Target"; rec."Total Target")
                {
                    ApplicationArea = All;
                }
                field("With HVP Target"; rec."With HVP Target")
                {
                    ApplicationArea = All;
                }
                field("Target Achieved - HVP"; rec."Target Achieved - HVP")
                {
                    ApplicationArea = All;
                }
                field("Target Achieved - Non-HVP"; rec."Target Achieved - Non-HVP")
                {
                    ApplicationArea = All;
                }
                field("Total Target Achieved"; rec."Total Target Achieved")
                {
                    ApplicationArea = All;
                }
                field("Incentive %age HVP"; rec."Incentive %age HVP")
                {
                    ApplicationArea = All;
                }
                field("Incentive %age Non-HVP"; rec."Incentive %age Non-HVP")
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Scheme Code"; rec."Scheme Code")
                {
                    ApplicationArea = All;
                }
                field("Total Turnover"; rec."Total Turnover")
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

