page 50079 "Item Creation Card"
{
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Item Creation";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Created Date"; rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Operation unit"; rec."Operation unit")
                {
                    ApplicationArea = All;
                }
            }
            part(ItemCreationLine; "Item Creation Subform")
            {
                SubPageLink = "No." = FIELD("No.");
                ApplicationArea = All;


            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send Item Approval")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.SendItemApproval(Rec);
                end;
            }
            action("Cancel Item Approval")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.CancelItemCreation(Rec);
                end;
            }
        }
    }
}

