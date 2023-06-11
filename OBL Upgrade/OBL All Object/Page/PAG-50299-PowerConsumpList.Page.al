page 50299 "Power & Consump. List"
{
    CardPageID = "Power and Cons. Card";
    Editable = false;
    PageType = List;
    SourceTable = "Power and Fuel Header";

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
                field("Date of Reporting"; Rec."Date of Reporting")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Consumed Qty."; Rec."Consumed Qty.")
                {
                    ApplicationArea = All;
                }
                field("Prod. Units"; Rec."Prod. Units")
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

