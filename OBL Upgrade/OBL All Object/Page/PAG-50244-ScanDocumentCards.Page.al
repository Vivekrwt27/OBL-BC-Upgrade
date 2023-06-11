page 50244 "Scan Document Cards"
{
    DeleteAllowed = false;
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
                field(Date; rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice Date"; rec."Vendor Invoice Date")
                {
                    ApplicationArea = All;
                }
                field("Bill Amount"; rec."Bill Amount")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field(Name; rec.Name)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Address; rec.Address)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Address 2"; rec."Address 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(City; rec.City)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Post Code"; rec."Post Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(State; rec.State)
                {
                    Editable = false;
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
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; rec."Document Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Posted; rec.Posted)
                {
                    ApplicationArea = All;
                }
            }
            group("Recieve Details")
            {
                field(Recieved; rec.Recieved)
                {
                    ApplicationArea = All;
                }
                field("Recieving DateTime"; rec."Recieving DateTime")
                {
                    ApplicationArea = All;
                }
                field("Recieving UserID"; rec."Recieving UserID")
                {
                    ApplicationArea = All;
                }
            }
            group("Rejection Details")
            {
                field("Rejection Remark"; rec."Rejection Remark")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Rejected; rec.Rejected)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(RejectedBy; rec.RejectedBy)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Rejection DateTime"; rec."Rejection DateTime")
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
            group(Gernal)
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
                    ShortCutKey = 'F9';
                    Visible = ShowReceiveButton;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD(Recieved, FALSE);
                        Rec.RecieveDocument(Rec);
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

