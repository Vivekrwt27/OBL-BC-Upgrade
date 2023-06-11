page 50164 "Quantity Discount Entry"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Quantity Discount Entry";
    SourceTableView = SORTING("Posted Document No.", "Sell to Customer Code");
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Sell to Customer Code"; Rec."Sell to Customer Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Applicable Quantity"; Rec."Applicable Quantity")
                {
                    ApplicationArea = All;
                }
                field("Quantity Discount Accrued"; Rec."Quantity Discount Accrued")
                {
                    ApplicationArea = All;
                }
                field("QD Given Amount"; Rec."QD Given Amount")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Total Document Quantity"; Rec."Total Document Quantity")
                {
                    ApplicationArea = All;
                }
                field("Accrued Quantity"; Rec."Accrued Quantity")
                {
                    ApplicationArea = All;
                }
                field("Posted Document No."; Rec."Posted Document No.")
                {
                    ApplicationArea = All;
                }
                field("Slab Rate"; Rec."Slab Rate")
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

