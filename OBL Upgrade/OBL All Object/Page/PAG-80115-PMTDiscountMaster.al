/* page 80115 "PMT Discount Master"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Permissions = tabledata "PMT Discount Master" = rimd;
    SourceTable = "PMT Discount Master";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Lead ID"; Rec."Lead ID")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Price Validaty"; Rec."Price Validaty")
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
} */