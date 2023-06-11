page 50227 "Sales Person Target"
{
    PageType = List;
    SourceTable = "Budget Master";
    UsageCategory = Lists;
    ApplicationArea = all;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                /*  field("SP Name"; "SP Name")
                  {
                      Editable = false;
                      ApplicationArea = All;
                  }
                  field(AssistEdit; AssistEdit)
                  {
                      ApplicationArea = All;
                  }*/
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Amount Utilised"; Rec."Amount Utilised")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Executive Summary"; Rec."Executive Summary")
                {
                    ApplicationArea = All;
                }
                field("Project Rational"; Rec."Project Rational")
                {
                    ApplicationArea = All;
                }
                field("Financial Evaluation"; Rec."Financial Evaluation")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        IF UPPERCASE(USERID) <> 'FA017' THEN
            ERROR('Sorry You are not Authorized to Run this Page');
    end;
}

