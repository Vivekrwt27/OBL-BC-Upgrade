page 50046 "Indent Header List"
{
    CardPageID = "Indent Header";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Indent Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;
                field(Selection; Rec.Selection)
                {
                    ApplicationArea = All;
                }
                field(Replied; Rec.Replied)
                {
                    ApplicationArea = All;
                }
                field("Authorization 3"; Rec."Authorization 3")
                {
                    ApplicationArea = All;
                }
                field(Commented; Rec.Commented)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Capex No."; Rec."Capex No.")
                {
                    ApplicationArea = All;
                }
                field("Indent Date"; Rec."Indent Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Authorization 2"; Rec."Authorization 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Authorization 1"; Rec."Authorization 1")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Plant Code"; Rec."Plant Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Authorization 1 Date"; Rec."Authorization 1 Date")
                {
                    ApplicationArea = All;
                }
                field("Authorization 1 Time"; Rec."Authorization 1 Time")
                {
                    ApplicationArea = All;
                }
                field("Authorization 2 Date"; Rec."Authorization 2 Date")
                {
                    ApplicationArea = All;
                }
                field("Authorization 2 Time"; Rec."Authorization 2 Time")
                {
                    ApplicationArea = All;
                }
                field("Authorization Date"; Rec."Authorization Date")
                {
                    ApplicationArea = All;
                }
                field("Authorization Time"; Rec."Authorization Time")
                {
                    ApplicationArea = All;
                }
                field("Executed By"; Rec."Executed By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Closed Date"; Rec."Closed Date")
                {
                    ApplicationArea = All;
                }
                field("Closed Time"; Rec."Closed Time")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Hold By"; Rec."Hold By")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
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
            group("&Indent")
            {
                action(comm)
                {
                    Caption = 'Comment';
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Comment';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        CommentLine: Record "Comment Line";
                        CommentSheetForm: Page "Comment Sheet";
                    begin
                        CommentLine.RESET;
                        CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::"Indent Header");
                        CommentLine.SETFILTER("No.", '%1', Rec."No.");
                        PAGE.RUN(0, CommentLine);
                        //.SETTABLEVIEW(CommentLine);
                        //CommentSheetForm.RUN;
                    end;
                }
            }
            group("F&unction")
            {
                Caption = 'F&unction';
                action("Line&s")
                {
                    Caption = 'Line&s';
                    RunObject = Page "Indent Lines List";
                    RunPageLink = "Document No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Indent Header";
                    RunPageLink = "No." = FIELD("No.");
                    RunPageView = SORTING("No.");
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                }
                action("Hold Indent")
                {
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Do you want to HOLD the Indent', FALSE) THEN BEGIN
                            Rec.HoldIndent(Rec);
                        END;
                    end;
                }
                action("UnHold Indent")
                {
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Do you want to UNHOLD the Indent', FALSE) THEN BEGIN
                            Rec.UnHoldIndent(Rec);
                            MailMgt.SendNotificationHold(Rec)
                        END;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF UserSetup.GET(Rec."Executed By") THEN
            Rec."Executed By" := UserSetup."User Name";
    end;

    var
        MailMgt: Codeunit IndentRelease;
        UserSetup: Record "User Setup";
}

