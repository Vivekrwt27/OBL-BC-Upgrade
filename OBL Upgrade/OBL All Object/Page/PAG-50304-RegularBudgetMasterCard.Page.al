page 50304 "Regular Budget Master Card"
{
    SourceTable = "Budget Master";
    SourceTableView = WHERE("Capex Request" = CONST(Regular));


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Operation Unit"; Rec."Operation Unit")
                {
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
                field("Project Name"; Rec."Project Name")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Prepared By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Prepared By Name"; Rec.GetName(Rec."Created By"))
                {
                    ApplicationArea = All;
                }
                field(Date; Rec."Created Date & Time")
                {
                    ApplicationArea = All;
                }
            }
            group("General 1")
            {
                field("Capex Number"; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Investment (In INR)"; Rec."Investment (In INR)")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = All;
                }
                field(Conversion; Rec.Conversion)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Included In Capex Plan"; Rec."Included In Capex Plan")
                {
                    ShowMandatory = true;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Supplementary; Rec.Supplementary)
                {
                    NotBlank = true;
                    ShowMandatory = true;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Pending Approval UserID"; Rec."Pending Approval UserID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Type of Investment"; Rec."Type of Investment")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Investment Class"; Rec."Investment Class")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Estimated Start Date"; Rec."Estimated Start Date")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Estimated Completion Date"; Rec."Estimated Completion Date")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Posting No."; Rec."Posting No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("Executive Summary ")
            {
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Rows;
                field("Executive Summary 1"; TxtExeSumm)
                {
                    Importance = Promoted;
                    MultiLine = true;
                    RowSpan = 5;
                    ShowCaption = false;
                    ToolTip = 'Executive summary';
                    ApplicationArea = All;

                    trigger OnValidate()
                    var

                    begin
                        rec.Validate("Executive Summary 1", TxtExeSumm);//15578
                        //15578  Rec.setExceutiveSummary(TxtExeSumm);

                    end;
                }
            }
            group("Project Rational  ")
            {
                field("Project Rational 1"; TxtProjectRational)
                {
                    MultiLine = true;
                    ShowCaption = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.Validate("Project Rational 1", TxtProjectRational);
                        //15578 rec.setProjectRational(TxtProjectRational);
                    end;
                }
            }
            part("Budget Master Project Subform"; "Budget Master Project Subform")
            {
                SubPageLink = "Document No." = FIELD("No.")
,
                              "Capex Request" = FIELD("Capex Request"),
                              Type = FILTER("Project Budget");
                ApplicationArea = all;
            }
            group("General 2")
            {
                field("Expenditure Sum"; rec."Expenditure Sum")
                {
                    Width = 20;
                    ApplicationArea = all;
                }
                field(Contigency; rec.Contigency)
                {
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("AFE Total"; rec."AFE Total")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
            }
            part("Budget Master Quarter Subform"; "Budget Master Quarter Subform")
            {
                SubPageLink = "Document No." = FIELD("No."),
                              "Capex Request" = FIELD("Capex Request"),
                              Type = CONST("Spending Profile per Quarter");
                ApplicationArea = all;
            }
            group("Evaluation Criteria")
            {
                Caption = 'Evaluation Criteria';
                field("Financial Evaluation 1"; TxtFinancialEvaluation)//15578
                {
                    MultiLine = true;
                    ShowCaption = false;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        rec.Validate("Financial Evaluation 1", TxtFinancialEvaluation);
                        // 15578 rec.setFinancialEvaluation(TxtFinancialEvaluation);
                    end;
                }
            }
            group("Financial Indicators")
            {
                field("Capital Investment (in INR)"; rec."Capital Investment (in INR)")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("NPV (In INR)"; rec."NPV (In INR)")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("IRR%"; rec."IRR%")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Pay Back Period (In Years)"; rec."Pay Back Period (In Years)")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send for Approval")
            {
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    CurrPage.SAVERECORD;
                    rec.TESTFIELD(Status, rec.Status::Open);

                    rec.TESTFIELD("Posting No. Series");
                    rec.UpdatePostingNo;
                    rec.SendforApprovalAndCreateApprovalEntries(Rec);
                end;
            }
            action(Cancel)
            {
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    rec.TESTFIELD(Status, rec.Status::"Pending for Approval");
                    rec.CancelApprovalEntries(Rec);
                end;
            }
            group(control)
            {
                action("Approval Entries")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        // ApprovalEntries.Setfilters(DATABASE::"Budget Master", 1, rec."No.");
                        //ApprovalEntries.RUN;
                    end;
                }
                action(Reopen)
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        rec.TESTFIELD(Status, rec.Status::Released);
                        IF rec.AllowUserToUpdate() THEN
                            rec.VALIDATE(Status, rec.Status::Open);
                    end;
                }
                action(Released)
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        BudgetMaster: Record "Budget Master";
                    begin
                        rec.TESTFIELD(Status, rec.Status::Open);
                        IF rec.AllowUserToUpdate() THEN BEGIN
                            BudgetMaster.GET(rec."Capex Request", rec."No.");
                            BudgetMaster.ArchiveBudget(BudgetMaster);
                            BudgetMaster.Status := rec.Status::Released;
                            BudgetMaster.MODIFY(FALSE);
                        END;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action(Closed)
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        BudgetMaster: Record "Budget Master";
                    begin
                        IF NOT (UPPERCASE(USERID) IN ['FA010', 'ADMIN']) THEN
                            ERROR('You are not Authorized')
                        ELSE BEGIN

                            rec.TESTFIELD(Status, rec.Status::Released);
                            IF CONFIRM('Do You want to Complete the Budget', TRUE) THEN BEGIN
                                rec.Status := rec.Status::Completed;
                                rec.MODIFY;
                            END;
                        END;

                        //Surbhi mam 2 min
                    end;
                }
                action(Rejected)
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        BudgetMaster: Record "Budget Master";
                    begin
                        IF NOT (UPPERCASE(USERID) IN ['FA010', 'ADMIN']) THEN
                            ERROR('You are not Authorized')
                        ELSE BEGIN

                            //TESTFIELD(Status,Status::Released);
                            IF CONFIRM('Do You want to Reject the Budget', TRUE) THEN BEGIN
                                rec.Status := rec.Status::Rejected;
                                rec.MODIFY;
                            END;
                        END;

                        //Surbhi mam 2 min
                    end;
                }
            }
            group(gernal2)
            {
                action("Capex Project Report")
                {
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        BudgetMaster: Record "Budget Master";
                    begin
                        BudgetMaster.RESET;
                        BudgetMaster.SETRANGE("Capex Request", rec."Capex Request");
                        BudgetMaster.SETRANGE("No.", rec."No.");
                        IF BudgetMaster.FINDFIRST THEN
                            REPORT.RUNMODAL(50085, TRUE, FALSE, BudgetMaster);
                    end;
                }
                action(Attachments)
                {
                    Image = Attachment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        AttachmentLines: Page "Attachment Lines";
                    begin
                        CLEAR(AttachmentLines);
                        AttachmentLines.SetDocumentDetails(rec."No.", 0, Rec.RECORDID);
                        AttachmentLines.RUN;
                    end;
                }
            }
            group(Attachment)
            {
                Caption = 'Attachment';
                Visible = false;

                action(Import)
                {
                    Caption = 'Attachment Document';
                    Image = PostedTaxInvoice;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        //IF Status <> Status::Open THEN
                        //  ERROR('Status must be Open');

                        AttachmentRecRef.OPEN(DATABASE::"Budget Master");
                        AttachmentRecRef.SETPOSITION(rec.GETPOSITION);
                        AttachmentRecID := AttachmentRecRef.RECORDID;
                        AttachmentRecRef.CLOSE;
                        AttachmentManagment.ImportAttachment(AttachmentRecID, DATABASE::"Budget Master", 0, rec."No.", 0);
                    end;
                }
                action(Export)
                {
                    Caption = 'Open Attachment';
                    Image = PostedVendorBill;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        AttachmentRecRef.OPEN(DATABASE::"Budget Master");
                        AttachmentRecRef.SETPOSITION(rec.GETPOSITION);
                        AttachmentRecID := AttachmentRecRef.RECORDID;
                        AttachmentRecRef.CLOSE;
                        AttachmentManagment.ExportAttachment(AttachmentRecID);
                    end;
                }
                action(Delete)
                {
                    Caption = 'Delete Attachment';
                    Image = VoidRegister;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        //IF Status <> Status::Open THEN
                        //  ERROR('Status must be Open');

                        AttachmentRecRef.OPEN(DATABASE::"Budget Master");
                        AttachmentRecRef.SETPOSITION(rec.GETPOSITION);
                        AttachmentRecID := AttachmentRecRef.RECORDID;
                        AttachmentRecRef.CLOSE;
                        AttachmentManagment.DeleteAttachment(AttachmentRecID);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        MakeAuthorisationEditable;
    end;

    trigger OnAfterGetRecord()
    begin
        rec.SetAutoCalcFields("Executive Summary");
        MakeAuthorisationEditable;
        //TxtExeSumm := rec.getExceutiveSummary();
        TxtExeSumm := rec."Executive Summary 1";//15578

        //TxtFinancialEvaluation := rec.getFinancialEvaluation();
        //15578 TxtProjectRational := rec.getProjectRational();
        TxtProjectRational := rec."Project Rational 1";//15578
        TxtFinancialEvaluation := rec."Financial Evaluation 1";//15578
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        rec."Capex Request" := rec."Capex Request"::Regular;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        MakeAuthorisationEditable;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        rec."Capex Request" := rec."Capex Request"::Regular;
    end;

    trigger OnOpenPage()
    begin
        MakeAuthorisationEditable;
    end;

    var
        UserSetup: Record "User Setup";
        [InDataSet]
        Auth1: Boolean;
        [InDataSet]
        Auth2: Boolean;
        [InDataSet]
        Auth3: Boolean;
        TxtExeSumm: Text;
        TxtProjectRational: Text;
        TxtFinancialEvaluation: Text;
        AttachmentRecRef: RecordRef;
        AttachmentRecID: RecordID;
        AttachmentManagment: Record "Attachment Management";

    local procedure MakeAuthorisationEditable()
    begin
        IF rec.Status = rec.Status::Open THEN BEGIN
            Auth1 := TRUE;
            Auth2 := (rec."Authorization 1" <> '');
            Auth3 := (rec."Authorization 2" <> '')
        END ELSE BEGIN
            Auth1 := FALSE;
            Auth2 := FALSE;
            Auth3 := FALSE;
        END;
    end;

    local procedure GetName(UserCode: Code[50]): Text
    var
        UserSetup: Record "User Setup";
    begin
        IF UserSetup.GET(UserCode) THEN
            EXIT(UserSetup."User Name");
    end;
}

