page 50313 "Posted Consumption List"
{
    Editable = false;
    PageType = List;
    SourceTable = "Posted Power & Fuel Cons. Hdr.";

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
                field("Consumed Qty."; Rec."Consumed Qty.")
                {
                    ApplicationArea = All;
                }
                field("Inventory At Location"; Rec."Inventory At Location")
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

