page 50285 "Capex Disposal Master Card"
{
    SourceTable = "Budget Master";
    SourceTableView = WHERE("Capex Request" = CONST(Disposal));

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
                group("Description of Assets")
                {
                    field("Plant & Machinery"; Rec."Plant & Machinery")
                    {
                        ApplicationArea = All;
                    }
                    field("Furniture & Fixture"; Rec."Furniture & Fixture")
                    {
                        ApplicationArea = All;
                    }
                    field("Office Equipment"; Rec."Office Equipment")
                    {
                        ApplicationArea = All;
                    }
                    field(Vehicles; Rec.Vehicles)
                    {
                        ApplicationArea = All;
                    }
                    field(Buildings; Rec.Buildings)
                    {
                        ApplicationArea = All;
                    }
                    field("Computer & Peripherals"; Rec."Computer & Peripherals")
                    {
                        ApplicationArea = All;
                    }
                    field("Furniture & Fixture SIS/COCO"; Rec."Furniture & Fixture SIS/COCO")
                    {
                        ApplicationArea = All;
                    }
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
            group(General1)
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
                    Caption = 'Estimated Disposable Value(In INR)';
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Currency; Rec.Currency)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Conversion; Rec.Conversion)
                {
                    Visible = false;
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
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Supplementary; Rec.Supplementary)
                {
                    NotBlank = true;
                    ShowMandatory = true;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    Visible = false;
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
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Investment Class"; Rec."Investment Class")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    Visible = false;
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
                Caption = 'Justification of Disposal';
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Rows;
                field("Executive Summary"; TxtExeSumm)
                {
                    Caption = 'Justification of Disposal';
                    ColumnSpan = 10;
                    Importance = Promoted;
                    MultiLine = true;
                    RowSpan = 5;
                    ShowCaption = false;
                    ToolTip = 'Executive summary';
                    Width = 10;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.setExceutiveSummary(TxtExeSumm);
                    end;
                }
            }
            field("Replacement required"; Rec."Replacement required")
            {
                ApplicationArea = All;
            }
            group("Evaluation Criteria")
            {
                Caption = 'Capex Required';
                Visible = Rec."Replacement required";
                field("Capex Required"; TxtFinancialEvaluation)
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
            group("Environment Risk")
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
            part("Financial detail of Fixed Assets"; "Financial Detail of Disposal A")
            {
                SubPageLink = "Document No." = FIELD("No."),
                              "Capex Request" = FIELD("Capex Request"),
                              Type = FILTER("Project Budget");
                ApplicationArea = All;
            }
            group(General2)
            {
                Visible = false;
                field("Expenditure Sum"; Rec."Expenditure Sum")
                {
                    Width = 20;
                    ApplicationArea = All;
                }
                field(Contigency; Rec.Contigency)
                {
                    Editable = false;
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
            part("Budget Master Quarter Subform"; "Budget Master Quarter Subform")
            {
                SubPageLink = "Document No." = FIELD("No."),
                              "Capex Request" = FIELD("Capex Request"),
                              Type = CONST("Spending Profile per Quarter");
                ApplicationArea = All;
            }
            group("Financial Indicators")
            {
                Visible = false;
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
            action("Send for Approval")
            {
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.SAVERECORD;
                    Rec.TESTFIELD(Status, Rec.Status::Open);
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
            separator(Control)
            {
            }
            group(General3)
            {
                action("Approval Entries")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        // ApprovalEntries.Setfilters(DATABASE::"Budget Master", 1, Rec."No.");
                        //ApprovalEntries.RUN;
                    end;
                }
                action(Reopen)
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD(Status, Rec.Status::Released);
                        IF Rec.AllowUserToUpdate() THEN
                            Rec.VALIDATE(Status, Rec.Status::Open);
                    end;
                }
                action(Released)
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        BudgetMaster: Record "Budget Master";
                    begin
                        Rec.TESTFIELD(Status, Rec.Status::Open);
                        IF Rec.AllowUserToUpdate() THEN BEGIN
                            BudgetMaster.GET(Rec."Capex Request", Rec."No.");
                            BudgetMaster.ArchiveBudget(BudgetMaster);
                            BudgetMaster.Status := Rec.Status::Released;
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
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        BudgetMaster: Record "Budget Master";
                    begin
                        IF NOT (UPPERCASE(USERID) IN ['FA010', 'ADMIN']) THEN
                            ERROR('You are not Authorized')
                        ELSE BEGIN

                            Rec.TESTFIELD(Status, Rec.Status::Released);
                            IF CONFIRM('Do You want to Close the Budget', TRUE) THEN BEGIN
                                Rec.Status := Rec.Status::Completed;
                                Rec.MODIFY;
                            END;
                        END;

                        //Surbhi mam 2 min
                    end;
                }
            }
            group(Action1000000041)
            {
                action("Capex Disposal Report")
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
                            REPORT.RUNMODAL(Report::"Size-Wise Summ. of finshd New", TRUE, FALSE, BudgetMaster);
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
                        //IF Status <> Status::Open THEN
                        //  ERROR('Status must be Open');

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
                        //IF Status <> Status::Open THEN
                        //  ERROR('Status must be Open');

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
        Rec."Capex Request" := Rec."Capex Request"::Disposal;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        MakeAuthorisationEditable;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        Rec."Capex Request" := Rec."Capex Request"::Disposal;
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

    local procedure GetName(UserCode: Code[50]): Text
    var
        UserSetup: Record "User Setup";
    begin
        IF UserSetup.GET(UserCode) THEN
            EXIT(UserSetup."User Name");
    end;
}

