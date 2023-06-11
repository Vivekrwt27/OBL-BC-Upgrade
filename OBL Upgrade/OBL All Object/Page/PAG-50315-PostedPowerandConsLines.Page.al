page 50315 "Posted Power and Cons. Lines"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "Posted Power & Fuel Cons.Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Consumed Item No."; Rec."Consumed Item No.")
                {
                    ApplicationArea = All;
                }
                field("FG Item No."; Rec."FG Item No.")
                {
                    ApplicationArea = All;
                }
                field("FG Item Description"; Rec."FG Item Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Total Sq. Meter Produced"; Rec."Total Sq. Meter Produced")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Consumption Qty."; Rec."Consumption Qty.")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

