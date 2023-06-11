page 50150 "Posted Out - Documents"
{
    Caption = 'Posted Out - Documents';
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Handled IC Inbox Trans.";
    UsageCategory = Lists;
    ApplicationArea = all;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction No."; Rec."Transaction No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transaction Source"; Rec."Transaction Source")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Outbox Transaction")
            {
                Caption = '&Outbox Transaction';
                action(Details)
                {
                    Caption = 'Details';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowDetails;
                    end;
                }
                action(Comments)
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    RunObject = Page "IC Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Handled IC Outbox Transaction"),
                                  "Transaction No." = FIELD("Transaction No."),

                                  "IC Partner Code" = FIELD("IC Partner Code"),
                                  "Transaction Source" = FIELD("Transaction Source");
                    ApplicationArea = All;
                }
            }
        }
    }
}

