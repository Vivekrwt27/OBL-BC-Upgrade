page 50329 "IT Prod Wise Item Images IBOT"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Permissions = tabledata "Product Wise Item Images IBOT" = rimd;
    SourceTable = "Product Wise Item Images IBOT";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = All;

                }
                field("Product Image"; Rec."Product Image")
                {
                    ApplicationArea = All;

                }
                field("Product Information"; Rec."Product Information")
                {
                    ApplicationArea = All;

                }
                field("Updation Date"; Rec."Updation Date")
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