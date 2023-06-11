page 50131 "IC Transfer - Out List"
{
    PageType = Card;
    SourceTable = "IC Header";

    layout
    {
        area(content)
        {
            repeater(group)
            {
                Editable = false;
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
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

