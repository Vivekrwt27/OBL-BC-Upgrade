page 80111 "Discount Setups"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Permissions = tabledata 50095 = rimd;
    SourceTable = 50095;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Area Code"; Rec."Area Code")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Item Classification"; Rec."Item Classification")
                {
                    ApplicationArea = All;
                }
                field("Manuf. Strategy"; Rec."Manuf. Strategy")
                {
                    ApplicationArea = All;
                }
                field("PreApproved Discount"; Rec."PreApproved Discount")
                {
                    ApplicationArea = All;
                }
                field("Discount on Approval"; Rec."Discount on Approval")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Ending Date"; Rec."Ending Date")
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