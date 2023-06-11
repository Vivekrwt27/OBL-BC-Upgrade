page 50182 "App Approval Entries"
{
    Caption = 'Approval Entries';
    Editable = false;
    PageType = List;
    SourceTable = "Approval Entry";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(group)
            {
                field(Overdue; Overdue)
                {
                    Caption = 'Overdue';
                    Editable = false;
                    ToolTip = 'Overdue Entry';
                    ApplicationArea = All;
                }
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                }
                field("GUID Key"; Rec."GUID Key")
                {
                    ApplicationArea = All;
                }
                field("Limit Type"; Rec."Limit Type")
                {
                    ApplicationArea = All;
                }
                field("Approval Type"; Rec."Approval Type")
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
                field("Sequence No."; Rec."Sequence No.")
                {
                    ApplicationArea = All;
                }
                field("Approver Code"; Rec."Approver Code")
                {
                    ApplicationArea = All;
                }
                field("Approval Code"; Rec."Approval Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Sender ID"; Rec."Sender ID")
                {
                    ApplicationArea = All;
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = All;
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Available Credit Limit (LCY)"; Rec."Available Credit Limit (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Date-Time Sent for Approval"; Rec."Date-Time Sent for Approval")
                {
                    ApplicationArea = All;
                }
                field("Last Date-Time Modified"; Rec."Last Date-Time Modified")
                {
                    ApplicationArea = All;
                }
                /*    field("Last Modified By ID"; "Last Modified By ID")
                    {
                    }*/
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Comment Text"; Rec."Comment Text")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Show")
            {
                Caption = '&Show';
                Image = View;
                action(Document)
                {
                    Caption = 'Document';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //ShowDocument;
                    end;
                }
                action(Comments)
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Approval Comments";
                    RunPageLink = "Table ID" = FIELD("Table ID"),
                                  "Document Type" = FIELD("Document Type"),
                                  "Document No." = FIELD("Document No.");
                    RunPageView = SORTING("Table ID", "Document Type", "Document No.");
                    ApplicationArea = All;
                }
                action("O&verdue Entries")
                {
                    Caption = 'O&verdue Entries';
                    Image = OverdueEntries;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        rec.SETFILTER(Status, '%1|%2', rec.Status::Created, rec.Status::Open);
                        rec.SETFILTER("Due Date", '<%1', TODAY);
                    end;
                }
                action("All Entries")
                {
                    Caption = 'All Entries';
                    Image = Entries;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        rec.SETRANGE(Status);
                        rec.SETRANGE("Due Date");
                    end;
                }
            }
        }
        area(processing)
        {
            action(Approve)
            {
                Caption = '&Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ApproveVisible;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                begin
                    CurrPage.SETSELECTIONFILTER(ApprovalEntry);
                    IF ApprovalEntry.FIND('-') THEN
                        REPEAT
                        // 16630         ApprovalMgt.ApproveApprovalRequest(ApprovalEntry);
                        UNTIL ApprovalEntry.NEXT = 0;
                end;
            }
            action(Reject)
            {
                Caption = '&Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = RejectVisible;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    // 16630    ApprovalSetup: Record 452;
                    ApprovalCommentLine: Record "Approval Comment Line";
                    ApprovalComment: Page "Approval Comments";
                begin
                    CurrPage.SETSELECTIONFILTER(ApprovalEntry);
                    IF ApprovalEntry.FIND('-') THEN
                        REPEAT
                            // 16630        IF NOT ApprovalSetup.GET THEN
                            ERROR(Text004);
                        /*     IF ApprovalSetup."Request Rejection Comment" = TRUE THEN BEGIN
                                 ApprovalCommentLine.SETRANGE("Table ID", ApprovalEntry."Table ID");
                                 ApprovalCommentLine.SETRANGE("Document Type", ApprovalEntry."Document Type");
                                 ApprovalCommentLine.SETRANGE("Document No.", ApprovalEntry."Document No.");
                                 ApprovalComment.SETTABLEVIEW(ApprovalCommentLine);
                                 IF ApprovalComment.RUNMODAL = ACTION::OK THEN
                                     ApprovalMgt.RejectApprovalRequest(ApprovalEntry);
                             END ELSE
                                 ApprovalMgt.RejectApprovalRequest(ApprovalEntry);*/ // 16630

                        UNTIL ApprovalEntry.NEXT = 0;
                end;
            }
            action("&Delegate")
            {
                Caption = '&Delegate';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    TempApprovalEntry: Record "Approval Entry";
                // 16630      ApprovalSetup: Record 452;
                begin
                    CurrPage.SETSELECTIONFILTER(ApprovalEntry);

                    CurrPage.SETSELECTIONFILTER(TempApprovalEntry);
                    IF TempApprovalEntry.FINDFIRST THEN BEGIN
                        TempApprovalEntry.SETFILTER(Status, '<>%1', TempApprovalEntry.Status::Open);
                        IF NOT TempApprovalEntry.ISEMPTY THEN
                            ERROR(Text001);
                    END;

                    IF ApprovalEntry.FIND('-') THEN BEGIN
                        // 16630   IF ApprovalSetup.GET THEN;
                        IF Usersetup.GET(USERID) THEN;
                        IF (ApprovalEntry."Sender ID" = Usersetup."User ID") OR
                           // 16630       (ApprovalSetup."Approval Administrator" = Usersetup."User ID") OR
                           (ApprovalEntry."Approver ID" = Usersetup."User ID")
                        THEN
                            REPEAT
                            // 16630           ApprovalMgt.DelegateApprovalRequest(ApprovalEntry);
                            UNTIL ApprovalEntry.NEXT = 0;
                    END;

                    MESSAGE(Text002);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Overdue := Overdue::" ";
        IF FormatField(Rec) THEN
            Overdue := Overdue::Yes;
    end;

    trigger OnInit()
    begin
        RejectVisible := TRUE;
        ApproveVisible := TRUE;
    end;

    trigger OnOpenPage()
    var
        Filterstring: Text;
    begin
    end;

    var
        Usersetup: Record "User Setup";
        ApprovalMgt: Codeunit "Export F/O Consolidation";
        Text001: Label 'You can only delegate open approval entries.';
        Text002: Label 'The selected approval(s) have been delegated. ';
        Overdue: Option Yes," ";
        Text004: Label 'Approval Setup not found.';
        // 16630   Approval: Codeunit "Approvals Mgt Notification";
        Approvalentry: Record "Approval Entry";
        [InDataSet]
        ApproveVisible: Boolean;
        [InDataSet]
        RejectVisible: Boolean;


    procedure Setfilters(TableId: Integer; DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocumentNo: Code[20])
    begin
        IF TableId <> 0 THEN BEGIN
            rec.FILTERGROUP(2);
            rec.SETCURRENTKEY("Table ID", "Document Type", "Document No.");
            rec.SETRANGE("Table ID", TableId);
            rec.SETRANGE("Document Type", DocumentType);
            IF DocumentNo <> '' THEN
                rec.SETRANGE("Document No.", DocumentNo);
            rec.FILTERGROUP(0);
        END;

        ApproveVisible := FALSE;
        RejectVisible := FALSE;
    end;


    procedure FormatField(Rec: Record "Approval Entry") OK: Boolean
    begin
        IF rec.Status IN [rec.Status::Created, rec.Status::Open] THEN BEGIN
            IF Rec."Due Date" < TODAY THEN
                EXIT(TRUE);

            EXIT(FALSE);
        END;
    end;


    procedure CalledFrom()
    begin
        Overdue := Overdue::" ";
    end;
}

