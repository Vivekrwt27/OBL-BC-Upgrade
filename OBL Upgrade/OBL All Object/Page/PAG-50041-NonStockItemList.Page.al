page 50041 "Non-Stock Item List"
{
    DelayedInsert = false;
    Editable = false;
    PageType = Card;
    SourceTable = "Non-Stock Item";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measurement"; Rec."Unit of Measurement")
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

