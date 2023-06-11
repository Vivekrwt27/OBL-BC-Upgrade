page 50317 "Non-Regular Budget Master Card"
{
    RefreshOnActivate = true;
    SourceTable = "Budget Master";
    SourceTableView = WHERE("Capex Request" = CONST("Non-Regular"));

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
                field(Date; Rec."Created Date & Time")
                {
                    ApplicationArea = All;
                }
            }
            group(Control1000000001)
            {
                field("Capex Number"; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Investment (In INR)"; Rec."Investment (In INR)")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
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
                field("Included In Capex Plan"; Rec."Included In Capex Plan")
                {
                    NotBlank = true;
                    ShowMandatory = true;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
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
                field(Supplementary; Rec.Supplementary)
                {
                    NotBlank = true;
                    ShowMandatory = true;
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
            }
            group("Executive Summary ")
            {
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Rows;
                field("Executive Summary"; TxtExeSumm)
                {
                    Importance = Promoted;
                    MultiLine = true;
                    ShowCaption = false;
                    ToolTip = 'Executive summary';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.setExceutiveSummary(TxtExeSumm);
                    end;
                }
            }
            group("Project Rational  ")
            {
                field("Project Rational"; TxtProjectRational)
                {
                    MultiLine = true;
                    ShowCaption = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.setProjectRational(TxtProjectRational);
                    end;
                }
            }
            part("Budget Master Project Subform2"; "Budget Master Project Subform")
            {
                SubPageLink = "Document No." = FIELD("No."),
                              "Capex Request" = FIELD("Capex Request");
                ApplicationArea = All;




            }
            group(Control1000000037)
            {
                field("Expenditure Sum"; Rec."Expenditure Sum")
                {
                    Width = 20;
                    ApplicationArea = All;
                }
                field(Contigency; Rec.Contigency)
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("AFE Total"; Rec."AFE Total")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
            }
            part("Budget Master Project Subform"; "Budget Master Project Subform")
            {
                SubPageLink = "Document No." = FIELD("No."),
                "Capex Request" = FIELD("Capex Request"),
                Type = CONST("Spending Profile per Quarter");
                ApplicationArea = All;


            }
            group("Financial Evaluation ")
            {
                field("Financial Evaluation"; TxtFinancialEvaluation)
                {
                    MultiLine = true;
                    ShowCaption = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.setFinancialEvaluation(TxtFinancialEvaluation);
                    end;
                }
            }
            group("Financial Indicators")
            {
                field("Capital Investment (in INR)"; Rec."Capital Investment (in INR)")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("NPV (In INR)"; Rec."NPV (In INR)")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("IRR%"; Rec."IRR%")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Pay Back Period (In Years)"; Rec."Pay Back Period (In Years)")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Release)
            {
                ApplicationArea = All;
            }
            action("Re-Open")
            {
                ApplicationArea = All;
            }
            action("Send for Approval")
            {
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.SAVERECORD;
                    Rec.TESTFIELD(Status, Rec.Status::Open);
                    Rec.TESTFIELD("Authorization 1");
                    Rec.SendforApprovalAndCreateApprovalEntries(Rec);
                end;
            }
            action(Cancel)
            {
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.TESTFIELD(Status, Rec.Status::"Pending for Approval");
                    Rec.CancelApprovalEntries(Rec);
                end;
            }
            separator(Action1000000021)
            {
            }
            group(Action1000000022)
            {
                action("Approval Entries")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        //ApprovalEntries.Setfilters(DATABASE::"Budget Master", 0, Rec."No.");
                        //ApprovalEntries.RUN;
                    end;
                }
            }
            group(Action1000000042)
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
                action(Attachments)
                {
                    Image = Attachment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        AttachmentLines: Page "Attachment Lines";
                    begin
                        CLEAR(AttachmentLines);
                        AttachmentLines.SetDocumentDetails(Rec."No.", 0, Rec.RECORDID);
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
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF Rec.Status <> Rec.Status::Open THEN
                            ERROR('Status must be Open');

                        AttachmentRecRef.OPEN(DATABASE::"Budget Master");
                        AttachmentRecRef.SETPOSITION(Rec.GETPOSITION);
                        AttachmentRecID := AttachmentRecRef.RECORDID;
                        AttachmentRecRef.CLOSE;
                        AttachmentManagment.ImportAttachment(AttachmentRecID, DATABASE::"Budget Master", 0, Rec."No.", 0);
                    end;
                }
                action(Export)
                {
                    Caption = 'Open Attachment';
                    Image = PostedVendorBill;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        AttachmentRecRef.OPEN(DATABASE::"Budget Master");
                        AttachmentRecRef.SETPOSITION(Rec.GETPOSITION);
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
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF Rec.Status <> Rec.Status::Open THEN
                            ERROR('Status must be Open');

                        AttachmentRecRef.OPEN(DATABASE::"Budget Master");
                        AttachmentRecRef.SETPOSITION(Rec.GETPOSITION);
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
        MakeAuthorisationEditable;
        TxtExeSumm := Rec.getExceutiveSummary();
        TxtFinancialEvaluation := Rec.getFinancialEvaluation();
        TxtProjectRational := Rec.getProjectRational();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Capex Request" := Rec."Capex Request"::"Non-Regular";
    end;

    trigger OnModifyRecord(): Boolean
    begin
        MakeAuthorisationEditable;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        Rec."Capex Request" := Rec."Capex Request"::"Non-Regular";
    end;

    trigger OnOpenPage()
    begin
        MakeAuthorisationEditable;
    end;

    var
        AttachmentRecID: RecordID;
        AttachmentManagment: Record "Attachment Management";
        AttachmentRecRef: RecordRef;
        [InDataSet]
        Auth1: Boolean;
        [InDataSet]
        Auth2: Boolean;
        [InDataSet]
        Auth3: Boolean;
        TxtExeSumm: Text;
        TxtProjectRational: Text;
        TxtFinancialEvaluation: Text;

    local procedure MakeAuthorisationEditable()
    begin
        IF Rec.Status = Rec.Status::Open THEN BEGIN
            Auth1 := TRUE;
            Auth2 := (Rec."Authorization 1" <> '');
            Auth3 := (Rec."Authorization 2" <> '')
        END ELSE BEGIN
            Auth1 := FALSE;
            Auth2 := FALSE;
            Auth3 := FALSE;
        END;
    end;
}

