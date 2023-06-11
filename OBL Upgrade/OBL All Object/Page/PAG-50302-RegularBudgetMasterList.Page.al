page 50302 "Regular Budget Master List"
{
    CardPageID = "Regular Budget Master Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Budget Master";
    SourceTableView = WHERE("Capex Request" = CONST(Regular));
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Posting No."; Rec."Posting No.")
                {
                    Editable = false;
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
                field("Capex Value (Value In Rs.)"; Rec."Investment (In INR)")
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
                field("PO Amount"; Rec."UnPosted Amount")
                {
                    ApplicationArea = All;
                }
                field("Invoice Amount"; Rec."Amount Utilised")
                {
                    ApplicationArea = All;
                }
                field("Payment Amount"; Rec."Payment Amount")
                {
                    ApplicationArea = All;
                }
                field("Estimated Start Date"; Rec."Estimated Start Date")
                {
                    ApplicationArea = All;
                }
                field("Estimated Completion Date"; Rec."Estimated Completion Date")
                {
                    ApplicationArea = All;
                }
                field("Type of Investment"; Rec."Type of Investment")
                {
                    ApplicationArea = All;
                }
                field("Pending With"; Rec."Pending Approval UserID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("User Name"; Rec.GetName(Rec."Created By"))
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(grenal)
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
                            REPORT.RUNMODAL(50085, TRUE, FALSE, BudgetMaster);
                    end;
                }
                action("Update Payment Amount")
                {
                    Image = Payment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        BudgetMaster: Record "Budget Master";
                    begin
                        BudgetMaster.RESET;
                        IF BudgetMaster.FINDFIRST THEN
                            REPEAT
                                BudgetMaster.UpdatePaymentAmount();
                            UNTIL BudgetMaster.NEXT = 0;
                        MESSAGE('Process Completed');
                    end;
                }

                action(Orders)
                {
                    Caption = 'Orders';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Category10;
                    RunObject = Page 54;
                    RunPageLink = "Capex No." = FIELD("Posting No.");
                    RunPageView = SORTING("Buy-from Vendor No.");
                    ShortCutKey = 'F4';
                }
                action("Posted Purch. Invoice Subform")
                {
                    RunObject = Page 139;
                    RunPageLink = "Capex No." = FIELD("Posting No.");
                    RunPageView = SORTING("Buy-from Vendor No.");
                    ShortCutKey = 'F11';
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

