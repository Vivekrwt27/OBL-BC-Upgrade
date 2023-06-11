page 50033 "Customer Credit Rating"
{
    Editable = false;
    PageType = List;
    SourceTable = "Customer Credit Rating";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Parent Customer No."; Rec."Parent Customer No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No. of Accounts"; Rec."No. of Accounts")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Credit Class Rating"; Rec."Credit Class Rating")
                {
                    ApplicationArea = All;
                }
                field("Turn-Over Rating"; Rec."Turn-Over Rating")
                {
                    ApplicationArea = All;
                }
                field("Payment Term Score"; Rec."Payment Term Score")
                {
                    ApplicationArea = All;
                }
                field("Credit Utilisation Score"; Rec."Credit Utilisation Score")
                {
                    ApplicationArea = All;
                }
                field("Average Account Age"; Rec."Average Account Age")
                {
                    ApplicationArea = All;
                }
                field("Wt. Avg. Due Payment Term(Days"; Rec."Wt. Avg. Due Payment Term(Days")
                {
                    ApplicationArea = All;
                }
                field("Wt. Avg. Collection Term(Days)"; Rec."Wt. Avg. Collection Term(Days)")
                {
                    ApplicationArea = All;
                }
                field("Credit Class Score"; Rec."Credit Class Score")
                {
                    ApplicationArea = All;
                }
                field("Credit Utilisation Percentage"; Rec."Credit Utilisation Percentage")
                {
                    ApplicationArea = All;
                }
                field(TurnOver; Rec.TurnOver)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Parent Credit Class Rating"; Rec."Parent Credit Class Rating")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Parent Turn-Over Rating"; Rec."Parent Turn-Over Rating")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Total Turnover"; Rec."Total Turnover")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Parent Credit Class Score"; Rec."Parent Credit Class Score")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Static; Rec.Static)
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

