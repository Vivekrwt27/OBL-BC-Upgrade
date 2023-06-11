page 50316 "Non-Regular Budget Master List"
{
    CardPageID = "Non-Regular Budget Master Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Budget Master";
    SourceTableView = WHERE("Capex Request" = CONST("Non-Regular"));

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Budget Amount (In Rs)"; Rec."Budget Amount (In Rs)")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date & Time"; Rec."Created Date & Time")
                {
                    ApplicationArea = All;
                }
                field("UnPosted Amount"; Rec."UnPosted Amount")
                {
                    ApplicationArea = All;
                }
                field("Amount Utilised"; Rec."Amount Utilised")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Action1000000015)
            {
                action("Capex Project Report")
                {
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        BudgetMaster: Record "Budget Master";
                    begin
                        BudgetMaster.RESET;
                        BudgetMaster.SETRANGE("Capex Request", Rec."Capex Request");
                        BudgetMaster.SETRANGE("No.", Rec."No.");
                        IF BudgetMaster.FINDFIRST THEN
                            REPORT.RUNMODAL(Report::"Sales Dashboard", TRUE, FALSE, BudgetMaster);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        //IF (UPPERCASE(USERID) <> 'FA010') AND (UPPERCASE(USERID) <> 'FA009') THEN
        //   ERROR('You are not Authorized to Execute this object');
    end;
}

