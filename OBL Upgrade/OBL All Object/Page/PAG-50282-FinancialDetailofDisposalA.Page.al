page 50282 "Financial Detail of Disposal A"
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
                //16225 Feild N/F Start
                /*field("Installation Date"; "Installation Date")
                {
                }
                field("Original Cost(Rs)"; "Original Cost(Rs)")
                {
                }
                field(WDV; WDV)
                {
                }
                field("Sales Value"; "Sales Value")
                {
                }
                field(Remark; Remark)
                {
                }*///16225 Feild N/F End
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::"Spending Profile per Quarter"; //16225 "3" Replace "Spending Profile per Quarter"
    end;
}

