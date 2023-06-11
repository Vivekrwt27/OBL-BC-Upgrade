page 50305 "Budget Master Archive List"
{
    Editable = false;
    PageType = List;
    SourceTable = "Budget Master Archive";

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
                field("Capex Request"; Rec."Capex Request")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Budget Amount (In Rs)"; Rec."Budget Amount (In Rs)")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date & Time"; Rec."Created Date & Time")
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

