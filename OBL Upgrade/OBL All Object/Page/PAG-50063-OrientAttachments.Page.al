page 50063 "Orient Attachments"
{
    PageType = Card;
    SourceTable = "Scheme Master for Apps";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Scheme Name"; Rec."Scheme Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Slab 1 Reward"; Rec."Slab 1 Reward")
                {
                    NotBlank = false;
                    ApplicationArea = All;
                }
                field("Slab 2 Reward"; Rec."Slab 2 Reward")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Current Achievement"; Rec."Current Achievement")
                {
                    ApplicationArea = All;
                }
                field("Slab 2 Target"; Rec."Slab 2 Target")
                {
                    ApplicationArea = All;
                }
                field("Slab 3 Target"; Rec."Slab 3 Target")
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
            group("&Attachment")
            {
                Caption = '&Attachment';
                action(Open)
                {
                    Caption = 'Open';
                    ShortCutKey = 'Return';

                    trigger OnAction()
                    var
                        Attachment: Record 50026;
                    begin
                        //  IF rec."Scheme Name" = 0 THEN
                        //    EXIT;
                        Attachment.GET(rec."Scheme Name", rec."Date & Time of Update", rec."Customer Code", rec."Customer Name");
                        //  Attachment.OpenAttachment(rec."Slab 1 Reward", FALSE);
                    end;
                }
                action(Create)
                {
                    Caption = 'Create';
                    Ellipsis = true;

                    trigger OnAction()
                    begin
                        // Rec.CreateAttachment;
                    end;
                }
                action(Import)
                {
                    Caption = 'Import';
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        FileName: Text[260];
                        AttachVoith: Record 50026;
                    begin
                        // AttachVoith.ImportAttachment(FileName, FALSE, TRUE, Rec);
                    end;
                }
                action("E&xport")
                {
                    Caption = 'E&xport';
                    Ellipsis = true;

                    trigger OnAction()
                    begin
                        // ExportAttachment('');
                    end;
                }
                action(Remove)
                {
                    Caption = 'Remove';
                    Ellipsis = true;

                    trigger OnAction()
                    begin
                        // RemoveAttachment(TRUE);
                    end;
                }
            }
        }
    }

    var
        CustAttachments: Record 50026;
        AttachNo: Integer;
}

