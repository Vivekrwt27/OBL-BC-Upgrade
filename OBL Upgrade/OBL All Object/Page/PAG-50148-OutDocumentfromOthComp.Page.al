page 50148 "Out - Document from Oth. Comp."
{
    Caption = 'Out - Document from Oth. Comp.';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "IC Outbox Transaction";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field(ShowLines; ShowLines)
                {
                    Caption = 'Show Transaction Source';
                    OptionCaption = ' ,Rejected by Current Company,Created by Current Company';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.SETRANGE("Transaction Source");
                        CASE ShowLines OF
                            ShowLines::"Rejected by Current Company":
                                Rec.SETRANGE("Transaction Source", Rec."Transaction Source"::"Rejected by Current Company");
                            ShowLines::"Created by Current Company":
                                Rec.SETRANGE("Transaction Source", Rec."Transaction Source"::"Created by Current Company");
                        END;
                        ShowLinesOnAfterValidate;
                    end;
                }
                field(ShowAction; ShowAction)
                {
                    Caption = 'Show Line Action';
                    OptionCaption = 'All,No Action,Send to IC Partner,Return to Inbox,Create Correction Lines';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.SETRANGE("Line Action");
                        CASE ShowAction OF
                            ShowAction::"No Action":
                                Rec.SETRANGE("Line Action", Rec."Line Action"::"No Action");
                            ShowAction::"Send to IC Partner":
                                Rec.SETRANGE("Line Action", Rec."Line Action"::"Send to IC Partner");
                            ShowAction::"Return to Inbox":
                                Rec.SETRANGE("Line Action", Rec."Line Action"::"Return to Inbox");
                            ShowAction::Cancel:
                                Rec.SETRANGE("Line Action", Rec."Line Action"::Cancel);
                        END;
                        ShowActionOnAfterValidate;
                    end;
                }
            }
            repeater(Act004)//16225 Add Act004
            {
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = All;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Transaction Source"; Rec."Transaction Source")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Outbox Transaction")
            {
                Caption = '&Outbox Transaction';
                action(Details)
                {
                    Caption = 'Details';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowDetails;
                    end;
                }
                action(Comments)
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    RunObject = Page "IC Comment Sheet";
                    RunPageLink = "Table Name" = CONST("IC Outbox Transaction"),
                                  "Transaction No." = FIELD("Transaction No."),
                                  "IC Partner Code" = FIELD("IC Partner Code"),
                                  "Transaction Source" = FIELD("Transaction Source");
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                group("Set Line Action")
                {
                    Caption = 'Set Line Action';
                    Visible = false;
                    action("No Action")
                    {
                        Caption = 'No Action';
                        Visible = false;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            CurrPage.SETSELECTIONFILTER(ICOutboxTransaction);
                            IF ICOutboxTransaction.FIND('-') THEN
                                REPEAT
                                    ICOutboxTransaction."Line Action" := ICOutboxTransaction."Line Action"::"No Action";
                                    ICOutboxTransaction.MODIFY;
                                UNTIL ICOutboxTransaction.NEXT = 0;
                        end;
                    }
                    action("Send to IC Partner")
                    {
                        Caption = 'Send to IC Partner';
                        Visible = false;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            CurrPage.SETSELECTIONFILTER(ICOutboxTransaction);
                            IF ICOutboxTransaction.FIND('-') THEN
                                REPEAT
                                    ICOutboxTransaction.VALIDATE("Line Action", ICOutboxTransaction."Line Action"::"Send to IC Partner");
                                    ICOutboxTransaction.MODIFY;
                                UNTIL ICOutboxTransaction.NEXT = 0;
                        end;
                    }
                    action("Return to Inbox")
                    {
                        Caption = 'Return to Inbox';
                        Visible = false;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            CurrPage.SETSELECTIONFILTER(ICOutboxTransaction);
                            IF ICOutboxTransaction.FIND('-') THEN
                                REPEAT
                                    Rec.TESTFIELD("Transaction Source", ICOutboxTransaction."Transaction Source"::"Rejected by Current Company");
                                    ICOutboxTransaction."Line Action" := ICOutboxTransaction."Line Action"::"Return to Inbox";
                                    ICOutboxTransaction.MODIFY;
                                UNTIL ICOutboxTransaction.NEXT = 0;
                        end;
                    }
                    action(Cancel)
                    {
                        Caption = 'Cancel';
                        Visible = false;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            CurrPage.SETSELECTIONFILTER(ICOutboxTransaction);
                            IF ICOutboxTransaction.FIND('-') THEN
                                REPEAT
                                    ICOutboxTransaction."Line Action" := ICOutboxTransaction."Line Action"::Cancel;
                                    ICOutboxTransaction.MODIFY;
                                UNTIL ICOutboxTransaction.NEXT = 0;
                        end;
                    }
                }
                action("Complete Line Actions")
                {
                    Caption = 'Complete Line Actions';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //MS-PB Set Line Action "Send- To IC Partner" BEGIN
                        IF ICOutboxTransaction.FIND('-') THEN
                            REPEAT
                                ICOutboxTransaction.VALIDATE("Line Action", ICOutboxTransaction."Line Action"::"Send to IC Partner");
                                ICOutboxTransaction.MODIFY;
                                CodeunitICOutboxExport.RUN(ICOutboxTransaction);
                            UNTIL ICOutboxTransaction.NEXT = 0;
                        //END;
                    end;
                }
            }
        }
    }

    var
        ICOutboxTransaction: Record "IC Outbox Transaction";
        PartnerFilter: Code[250];
        ShowLines: Option " ","Rejected by Current Company","Created by Current Company";
        ShowAction: Option All,"No Action","Send to IC Partner","Return to Inbox",Cancel;
        CodeunitICOutboxExport: Codeunit "IC Outbox Export";

    local procedure ShowLinesOnAfterValidate()
    begin
        CurrPage.UPDATE(FALSE);
    end;

    local procedure ShowActionOnAfterValidate()
    begin
        CurrPage.UPDATE(FALSE);
    end;
}

