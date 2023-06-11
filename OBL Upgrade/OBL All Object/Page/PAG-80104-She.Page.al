page 80104 She
{
    PageType = Card;
    SourceTable = "G/L Entry";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(GROUP)
            {
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("G/L Account No."; rec."G/L Account No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Source Code"; rec."Source Code")
                {
                    ApplicationArea = All;
                }
                field("System-Created Entry"; rec."System-Created Entry")
                {
                    ApplicationArea = All;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(Amount; rec.Amount)
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

