page 50247 "Receive Scan Document Cards"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "Purchase order Attachment";
    UsageCategory = Lists;
    ApplicationArea = ALL;


    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
                {
                    ApplicationArea = All;
                }
                field("Bill Amount"; Rec."Bill Amount")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    Editable = false;
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
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
            }
            group("Recieve Details")
            {
                field(Recieved; Rec.Recieved)
                {
                    ApplicationArea = All;
                }
                field("Recieving DateTime"; Rec."Recieving DateTime")
                {
                    ApplicationArea = All;
                }
                field("Recieving UserID"; Rec."Recieving UserID")
                {
                    ApplicationArea = All;
                }
            }
            group("Rejection Details")
            {
                field("Rejection Remark"; Rec."Rejection Remark")
                {
                    ApplicationArea = All;
                }
                field(Rejected; Rec.Rejected)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(RejectedBy; Rec.RejectedBy)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Rejection DateTime"; Rec."Rejection DateTime")
                {
                    Editable = false;
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
                    begin
                        IF Rec.Posted THEN
                            ERROR('Status must be Open');

                        AttachmentRecRef.OPEN(DATABASE::"Sample Order");
                        AttachmentRecRef.SETPOSITION(Rec.GETPOSITION);
                        AttachmentRecID := AttachmentRecRef.RECORDID;
                        AttachmentRecRef.CLOSE;
                        AttachmentManagment.ImportAttachment(AttachmentRecID, DATABASE::"Sample Order", 0, Rec."No.", 0);
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
                        AttachmentRecRef.OPEN(DATABASE::"Sample Order");
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
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF Rec.Posted THEN
                            ERROR('Status must be Open');

                        AttachmentRecRef.OPEN(DATABASE::"Sample Order");
                        AttachmentRecRef.SETPOSITION(Rec.GETPOSITION);
                        AttachmentRecID := AttachmentRecRef.RECORDID;
                        AttachmentRecRef.CLOSE;
                        AttachmentManagment.DeleteAttachment(AttachmentRecID);
                    end;
                }
            }
            group(control001)
            {
                action(Post)
                {
                    Image = Post;
                    Promoted = true;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    Visible = ShowPostedButton;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD(Posted, FALSE);
                        AttachmentRecRef.OPEN(DATABASE::"Sample Order");
                        AttachmentRecRef.SETPOSITION(Rec.GETPOSITION);
                        AttachmentRecID := AttachmentRecRef.RECORDID;
                        AttachmentRecRef.CLOSE;

                        IF NOT AttachmentManagment.AttachmentExist(AttachmentRecID) THEN
                            ERROR('Please Attach Scan Document First');
                        Rec.PostDocument(Rec);
                    end;
                }
                action(Recieve)
                {
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    RunPageMode = Edit;
                    ShortCutKey = 'F9';
                    Visible = ShowReceiveButton;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD(Recieved, FALSE);
                        Rec.RecieveDocument(Rec);
                    end;
                }
                action(Reject)
                {
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    RunPageMode = Edit;
                    ShortCutKey = 'F9';
                    Visible = ShowReceiveButton;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD(Recieved, FALSE);
                        Rec.TESTFIELD(Rejected, FALSE);
                        Rec.TESTFIELD("Rejection Remark");
                        Rec.RejectDocument(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ShowButton;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ShowButton;
    end;

    trigger OnOpenPage()
    begin
        ShowButton;
    end;

    var
        AttachmentRecRef: RecordRef;
        AttachmentManagment: Record "Attachment Management";
        AttachmentRecID: RecordID;
        [InDataSet]
        ShowPostedButton: Boolean;
        [InDataSet]
        ShowReceiveButton: Boolean;

    local procedure ShowButton()
    begin
        ShowPostedButton := (NOT Rec.Posted);
        ShowReceiveButton := Rec.Posted AND (NOT Rec.Recieved);
    end;
}

