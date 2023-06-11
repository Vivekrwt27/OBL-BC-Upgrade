page 50309 "Budget Master Project Subform"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Budget Master Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                FreezeColumn = "S. No.";
                field("S. No."; Rec."S. No.")
                {
                    ApplicationArea = All;
                }
                field("Expenditure Element"; Rec."Expenditure Element")
                {
                    ApplicationArea = All;
                }
                field("Estimation (In INR)"; Rec."Estimation (In INR)")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Percentage; Rec.Percentage)
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::"Project Budget";
    end;
}

