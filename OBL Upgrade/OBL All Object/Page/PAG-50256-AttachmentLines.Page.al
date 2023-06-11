page 50256 "Attachment Lines"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Attachment Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Source Document No."; Rec."Source Document No.")
                {
                    ApplicationArea = All;
                }
                field(Extension; Rec.Extension)
                {
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                }
                field("Creation Datetime"; Rec."Creation Datetime")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Attachment)
            {
                Caption = 'Attachment';
                action(Import)
                {
                    Caption = 'Attachment Document';
                    Image = PostedTaxInvoice;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        AttachLines: Record "Attachment Lines";
                        LastLineNo: Integer;
                        AttachmentMgt: Record "Attachment Management";
                        BudgetMaster: Record "Budget Master";
                        Instr: InStream;
                        FilePat: Text;
                    begin
                        /* IF BudgetMaster.GET(SourceRecRefId) THEN BEGIN
                            IF BudgetMaster.Status <> BudgetMaster.Status::Open THEN
                                ERROR('Status must be Open');
                        END; */

                        /* 15578 AttachLines.RESET;
                        AttachLines.SETRANGE("Table ID", DATABASE::"Attachment Lines");
                        AttachLines.SETRANGE("Source Document No.", SourceDocNo);
                        // 16630 AttachLines.SETRANGE("Source Line No.", SourceDocLineNo);
                        IF AttachLines.FINDLAST THEN BEGIN
                            LastLineNo := AttachLines."Line No." + 10000;
                        END ELSE
                            LastLineNo := 10000;

                        Rec.INIT;
                        Rec."Table ID" := DATABASE::"Attachment Lines";
                        Rec."Source Document No." := SourceDocNo;
                        Rec."Source Line No." := SourceDocLineNo;
                        Rec."Source Record ID" := SourceRecRefId;
                        Rec."Line No." := LastLineNo;
                        Rec."Created By" := USERID;
                        Rec."Creation Datetime" := CURRENTDATETIME;
                        Rec.INSERT;

                        AttachmentRecRef.OPEN(DATABASE::"Attachment Lines");
                        AttachmentRecRef.SETPOSITION(Rec.GETPOSITION);
                        AttachmentRecID := AttachmentRecRef.RECORDID;
                        AttachmentRecRef.CLOSE;
                        AttachmentManagment.ImportAttachment(AttachmentRecID, DATABASE::"Attachment Lines", 0, Rec."Source Document No.", Rec."Source Line No.");

                        AttachmentMgt.RESET;
                        AttachmentMgt.SETRANGE("Primary Key", AttachmentRecID);
                        IF AttachmentMgt.FINDFIRST THEN BEGIN
                            Rec."File Name" := AttachmentMgt."File Name";
                            Rec.Extension := AttachmentMgt.Extension;
                            Rec.Attachment := AttachmentMgt.Attachment;

                            Rec.MODIFY;
                        END; *///15578
                        if UploadIntoStream('Select File..', '', '', FilePat, Instr) then
                            UploadFile(Instr, FilePat);
                    end;
                }
                action(Export)
                {
                    Caption = 'Open Attachment';
                    Image = PostedVendorBill;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /* AttachmentRecRef.OPEN(DATABASE::"Attachment Lines");
                        AttachmentRecRef.SETPOSITION(Rec.GETPOSITION);
                        AttachmentRecID := AttachmentRecRef.RECORDID;
                        AttachmentRecRef.CLOSE;
                        AttachmentManagment.ExportAttachment(AttachmentRecID);15578 */
                        DownloadFile;

                    end;
                }
                action(Delete)
                {
                    Caption = 'Delete Attachment';
                    Image = VoidRegister;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        AttachLines: Record "Attachment Lines";
                        BudgetMaster: Record "Budget Master";
                    begin
                        //IF Status <> Status::Open THEN
                        //  ERROR('Status must be Open');
                        /* 15578 IF BudgetMaster.GET(SourceRecRefId) THEN BEGIN
                            IF BudgetMaster.Status <> BudgetMaster.Status::Open THEN
                                ERROR('Status must be Open');
                        END;
                        AttachmentRecRef.OPEN(DATABASE::"Attachment Lines");
                        AttachmentRecRef.SETPOSITION(Rec.GETPOSITION);
                        AttachmentRecID := AttachmentRecRef.RECORDID;
                        AttachmentRecRef.CLOSE;
                        AttachmentManagment.DeleteAttachment(AttachmentRecID);
 */
                        AttachLines.RESET;
                        AttachLines.SETRANGE("Table ID", DATABASE::"Attachment Lines");
                        AttachLines.SETRANGE("Source Document No.", SourceDocNo);
                        AttachLines.SETRANGE("Source Line No.", SourceDocLineNo);
                        AttachLines.SETRANGE("Line No.", Rec."Line No.");
                        IF AttachLines.FINDFIRST THEN
                            AttachLines.DELETE;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF SourceDocNo <> '' THEN
            Rec.SETRANGE("Source Document No.", SourceDocNo);
    end;

    var
        AttachmentRecRef: RecordRef;
        AttachmentRecID: RecordID;
        AttachmentManagment: Record "Attachment Management";
        SourceDocNo: Code[20];
        SourceDocLineNo: Integer;
        SourceRecRefId: RecordID;

    procedure SetDocumentDetails(DocNo: Code[20]; DocLineNo: Integer; RecRefId: RecordID)
    begin
        SourceDocNo := DocNo;
        SourceDocLineNo := DocLineNo;
        SourceRecRefId := RecRefId;
    end;

    procedure UploadFile(Documentinstrea: InStream; fileName: Text)//15578
    var
        FileManagmen: Codeunit "File Management";
        OutStram: OutStream;
        AttachLines: Record "Attachment Lines";
        LastLineNo: Integer;
        AttachLines2: Record "Attachment Lines";
    begin
        AttachLines.RESET;
        AttachLines.SETRANGE("Table ID", DATABASE::"Attachment Lines");
        AttachLines.SETRANGE("Source Document No.", SourceDocNo);
        AttachLines.SETRANGE("Source Line No.", SourceDocLineNo);
        IF AttachLines.FINDLAST THEN BEGIN
            LastLineNo := AttachLines."Line No." + 10000;
        END ELSE
            LastLineNo := 10000;


        rec."Table ID" := DATABASE::"Attachment Lines";
        rec."Source Document No." := SourceDocNo;
        rec."Source Line No." := SourceDocLineNo;
        rec."Source Record ID" := SourceRecRefId;
        rec."Line No." := LastLineNo;
        rec."Created By" := USERID;
        rec."Creation Datetime" := CURRENTDATETIME;
        rec.Validate(Extension, FileManagmen.GetExtension(fileName));
        rec.Validate("File Name", FileManagmen.GetFileNameWithoutExtension(fileName));
        Rec.Content.CreateOutStream(OutStram);
        CopyStream(OutStram, Documentinstrea);
        rec.Insert();
    end;

    local procedure DownloadFile()
    var
        ISTream: InStream;
        ExportFileName: Text;
    begin
        ExportFileName := rec."File Name" + '.' + rec.Extension;
        rec.CalcFields(Content);
        if not rec.Content.HasValue then
            exit;
        rec.Content.CreateInStream(ISTream);
        DownloadFromStream(ISTream, '', '', '', ExportFileName);
    end;
}

