page 50036 "PMT Discount List"
{
    PageType = List;
    SourceTable = "PMT Discount Master";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("PMT ID"; Rec."PMT ID")
                {
                    ApplicationArea = All;
                }
                field("Lead ID"; Rec."Lead ID")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Price Validaty"; Rec."Price Validaty")
                {
                    ApplicationArea = All;
                }
                field("Discount Amount"; Rec."Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("PMT Qty."; Rec."PMT Qty.")
                {
                    ApplicationArea = All;
                }
                field("Cash Discount"; Rec."Cash Discount")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                }
                field(Tolerance; Rec.Tolerance)
                {
                    ApplicationArea = All;
                }
                field("Ship To Address"; Rec."Ship To Address")
                {
                    ApplicationArea = All;
                }
                field("Ship To Pin"; Rec."Ship To Pin")
                {
                    ApplicationArea = All;
                }
                field("PMT Creation Date"; Rec."PMT Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Ship To Address 2"; Rec."Ship To Address 2")
                {
                    ApplicationArea = All;
                }
                field("Order Qty upto 310322"; Rec."Order Qty upto 310322")
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

