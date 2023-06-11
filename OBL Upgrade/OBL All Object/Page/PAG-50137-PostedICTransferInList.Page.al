page 50137 "Posted IC Transfer - In List"
{
    Editable = false;
    PageType = Card;

    SourceTable = "IC In Header";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("From Company"; Rec."From Company")
                {
                    ApplicationArea = All;
                }
                field("To Company"; Rec."To Company")
                {
                    ApplicationArea = All;
                }
                field("From Location"; Rec."From Location")
                {
                    ApplicationArea = All;
                }
                field("To Location"; Rec."To Location")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
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

