page 50147 "In - Documents from Oth. Comp."
{
    Caption = 'In - Documents from Oth. Comp.';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "IC Inbox Transaction";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("ShowLines"; "ShowLines")
                {
                    Caption = 'Show Transaction Source';
                    OptionCaption = ' ,Returned by Partner,Created by Partner';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.SETRANGE("Transaction Source");
                        CASE ShowLines OF
                            ShowLines::"Returned by Partner":
                                Rec.SETRANGE("Transaction Source", Rec."Transaction Source"::"Returned by Partner");
                            ShowLines::"Created by Partner":
                                Rec.SETRANGE("Transaction Source", Rec."Transaction Source"::"Created by Partner");
                        END;
                        ShowLinesOnAfterValidate;
                    end;
                }
                field(ShowAction; ShowAction)
                {
                    Caption = 'Show Line Action';
                    OptionCaption = 'All,No Action,Accept,Return to IC Partner';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        REC.SETRANGE("Line Action");
                        CASE ShowAction OF
                            ShowAction::"No Action":
                                Rec.SETRANGE("Line Action", Rec."Line Action"::"No Action");
                            ShowAction::Accept:
                                Rec.SETRANGE("Line Action", Rec."Line Action"::Accept);
                            ShowAction::"Return to IC Partner":
                                Rec.SETRANGE("Line Action", Rec."Line Action"::"Return to IC Partner");
                            ShowAction::Cancel:
                                Rec.SETRANGE("Line Action", Rec."Line Action"::Cancel);

                        END;
                        ShowActionOnAfterValidate;
                    end;
                }
            }
            repeater(group)
            {
                field("Transaction No."; rec."Transaction No.")
                {
                    ApplicationArea = All;
                }
                field("IC Partner Code"; rec."IC Partner Code")
                {
                    ApplicationArea = All;
                }
                field("Source Type"; rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Transaction Source"; rec."Transaction Source")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; rec."Document Date")
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
            group("&Inbox Transaction")
            {
                Caption = '&Inbox Transaction';
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
                    RunPageLink = "Table Name" = CONST("IC Inbox Transaction"),
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
                            CurrPage.SETSELECTIONFILTER(ICInboxTransaction);
                            IF ICInboxTransaction.FIND('-') THEN
                                REPEAT
                                    ICInboxTransaction."Line Action" := ICInboxTransaction."Line Action"::"No Action";
                                    ICInboxTransaction.MODIFY;
                                UNTIL ICInboxTransaction.NEXT = 0;
                        end;
                    }
                    action(Accept)
                    {
                        Caption = 'Accept';
                        Visible = false;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            CurrPage.SETSELECTIONFILTER(ICInboxTransaction);
                            IF ICInboxTransaction.FIND('-') THEN
                                REPEAT
                                    rec.TESTFIELD("Transaction Source", ICInboxTransaction."Transaction Source"::"Created by Partner");
                                    ICInboxTransaction.VALIDATE("Line Action", ICInboxTransaction."Line Action"::Accept);
                                    ICInboxTransaction.MODIFY;
                                UNTIL ICInboxTransaction.NEXT = 0;
                        end;
                    }
                    action("Return to IC Partner")
                    {
                        Caption = 'Return to IC Partner';
                        Visible = false;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            CurrPage.SETSELECTIONFILTER(ICInboxTransaction);
                            IF ICInboxTransaction.FIND('-') THEN
                                REPEAT
                                    rec.TESTFIELD("Transaction Source", ICInboxTransaction."Transaction Source"::"Created by Partner");
                                    ICInboxTransaction."Line Action" := ICInboxTransaction."Line Action"::"Return to IC Partner";
                                    ICInboxTransaction.MODIFY;
                                UNTIL ICInboxTransaction.NEXT = 0;
                        end;
                    }
                    action(Cancel)
                    {
                        Caption = 'Cancel';
                        Visible = false;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            CurrPage.SETSELECTIONFILTER(ICInboxTransaction);
                            IF ICInboxTransaction.FIND('-') THEN
                                REPEAT
                                    ICInboxTransaction."Line Action" := ICInboxTransaction."Line Action"::Cancel;
                                    ICInboxTransaction.MODIFY;
                                UNTIL ICInboxTransaction.NEXT = 0;
                        end;
                    }
                }
                action("Complete Line Actions")
                {
                    Caption = 'Complete Line Actions';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        CarryOutICInboxAction: Report "Complete IC Inbox Action";
                    begin
                        /*CurrForm.SETSELECTIONFILTER(ICInboxTransaction);
                        IF ICInboxTransaction.FIND('-') THEN
                          REPEAT
                            TESTFIELD("Transaction Source",ICInboxTransaction."Transaction Source"::"Created by Partner");
                            ICInboxTransaction.VALIDATE("Line Action",ICInboxTransaction."Line Action"::Accept);
                            ICInboxTransaction.MODIFY;
                          UNTIL ICInboxTransaction.NEXT = 0;
                        
                        */

                        CarryOutICInboxAction.SETTABLEVIEW(Rec);
                        CarryOutICInboxAction.RUNMODAL;
                        CurrPage.UPDATE(TRUE);

                    end;
                }
                action("Import Transaction File")
                {
                    Caption = 'Import Transaction File';
                    RunObject = Codeunit "IC Inbox Import";
                    RunPageOnRec = true;
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        ICInboxTransaction: Record "IC Inbox Transaction";
        PartnerFilter: Code[250];
        ShowLines: Option " ","Returned by Partner","Created by Partner";
        ShowAction: Option All,"No Action",Accept,"Return to IC Partner",Cancel;
        ICInboxTransaction2: Record "IC Inbox Transaction";

    local procedure ShowLinesOnAfterValidate()
    begin
        CurrPage.UPDATE(FALSE);
    end;

    local procedure ShowActionOnAfterValidate()
    begin
        CurrPage.UPDATE(FALSE);
    end;
}

