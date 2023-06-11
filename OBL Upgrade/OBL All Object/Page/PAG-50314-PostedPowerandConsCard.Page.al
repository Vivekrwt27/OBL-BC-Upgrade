page 50314 "Posted Power and Cons. Card"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Posted Power & Fuel Cons. Hdr.";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Date of Reporting"; Rec."Date of Reporting")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    Editable = false;
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
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prod. Units"; Rec."Prod. Units")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(Lines; "Posted Power and Cons. Lines")
            {
                Caption = 'Lines';
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Suggest Consumption Lines")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
            }
            action("Release ")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
            }
            action("ReOpen ")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
            }
            action(Post)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
            }
        }
    }
}

