page 50077 "C Form Received Card"
{
    PageType = Card;
    SourceTable = "C-form";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Customer No."; Rec."Customer No.")
                {
                    TableRelation = Customer;
                    ApplicationArea = All;
                }
            }
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Sell To Customer Name"; Rec."Sell To Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Sell To City"; Rec."Sell To City")
                {
                    ApplicationArea = All;
                }
                field("State Desc."; Rec."State Desc.")
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

