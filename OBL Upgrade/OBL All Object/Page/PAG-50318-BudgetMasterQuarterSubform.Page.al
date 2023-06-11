page 50318 "Budget Master Quarter Subform"
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
                field("Financial Year"; Rec.Year)
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Quarter; Rec.Quarter)
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Quarter Spending (In INR)"; Rec."Quarter Spending (In INR)")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Cumulative Total (In INR)"; Rec."Cumulative Total (In INR)")
                {
                    ApplicationArea = All;
                }
                field("Progressive (%)"; Rec."Progressive (%)")
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
        Rec.Type := Rec.Type::"Spending Profile per Quarter";
    end;
}

