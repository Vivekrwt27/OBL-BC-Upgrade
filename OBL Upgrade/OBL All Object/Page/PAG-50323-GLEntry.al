/* page 50323 "G/L Entry Modify 1"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Permissions = tabledata "G/L Entry" = rimd;
    SourceTable = "G/L Entry";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = All;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = All;
                }

                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = All;
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                    ApplicationArea = All;
                }


            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                var
                    hh: Record "Detailed GST Ledger Entry";
                begin

                end;
            }
        }
    }
} */