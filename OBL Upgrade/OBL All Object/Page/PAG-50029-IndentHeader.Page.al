page 50029 "Indent Header"
{
    PageType = Card;
    SourceTable = "Indent Header";



    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    var
                        rNoSeries: Record "No. Series";
                        rUserLocation: Record "User Location";
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;

                        //Keshav08042020
                        rNoSeries.RESET;
                        rNoSeries.SETRANGE(Code, Rec."No. Series");
                        IF rNoSeries.FIND('-') THEN BEGIN
                            rNoSeries.TESTFIELD(Location);
                            rUserLocation.RESET;
                            rUserLocation.SETRANGE("User ID", USERID);
                            rUserLocation.SETRANGE("Location Code", rNoSeries.Location);
                            rUserLocation.SETRANGE("Create Indent", TRUE);
                            IF rUserLocation.FIND('-') THEN BEGIN
                                Rec.VALIDATE("Location Code", rNoSeries.Location);
                                Rec.MODIFY;
                            END ELSE BEGIN
                                ERROR('You are not authorised to use this location : ' + rNoSeries.Location);
                            END;
                        END;
                        //Keshav08042020
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Requition Type"; Rec."Requition Type")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Indent Date"; Rec."Indent Date")
                {
                    ApplicationArea = All;
                }
                field("Executed By"; Rec."Executed By")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF UserSetup.GET(Rec."Executed By") THEN
                            Rec."Executed By" := UserSetup."User Name";
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Capex No."; Rec."Capex No.")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = All;
                }
                field(Commented; Rec.Commented)
                {
                    Caption = 'Replied';
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Replied; Rec.Replied)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Validate Upto"; Rec."Validate Upto")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        DepartmentCodeOnAfterValidate;
                    end;
                }
                field("Plant Code"; Rec."Plant Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PlantCodeOnAfterValidate;
                    end;
                }
                field("Authorization 1"; Rec."Authorization 1")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Authorization 2"; Rec."Authorization 2")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Authorization 3"; Rec."Authorization 3")
                {
                    Caption = 'Authorization 3';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Validity Period"; Rec."Validity Period")
                {
                    ApplicationArea = All;
                }
                field("Closed Time"; Rec."Closed Time")
                {
                    Caption = 'Closed Date/Time';
                    ApplicationArea = All;
                }
                field("Authorization Date"; Rec."Authorization Date")
                {
                    Caption = 'Authorization Date/Time';
                    ApplicationArea = All;
                }
                field("Closed Date"; Rec."Closed Date")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Hold; Rec.Hold)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Hold By"; Rec."Hold By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Authorization 1 Date"; Rec."Authorization 1 Date")
                {
                    Caption = 'Authorization 1 Date/Time';
                    QuickEntry = false;
                    ApplicationArea = All;
                }
                field("Authorization 1 Time"; Rec."Authorization 1 Time")
                {
                    ApplicationArea = All;
                }
                field("Authorization 2 Date"; Rec."Authorization 2 Date")
                {
                    Caption = 'Authorization 2 Date/Time';
                    ApplicationArea = All;
                }
                field("Authorization 2 Time"; Rec."Authorization 2 Time")
                {
                    ApplicationArea = All;
                }
                field("Authorization 3 Date"; Rec."Authorization 3 Date")
                {
                    Caption = 'Authorization 3 Date/Time';
                    ApplicationArea = All;
                }
                field("Authorization 3 Time"; Rec."Authorization 3 Time")
                {
                    ApplicationArea = All;
                }
            }
            part("Indent Subform"; 50030)
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            } // 16630
            group(Reason)
            {
                Caption = 'Reason';
                field("Reason of Rejection"; Rec."Reason of Rejection")
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
            action("Re&lease")
            {
                Caption = 'Re&lease';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Codeunit IndentRelease;
                ShortCutKey = 'Ctrl+F9';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.SAVERECORD;
                    IF Rec."Requition Type" = Rec."Requition Type"::" " THEN
                        ERROR('Please Enter the Requition Type');

                    IF Rec."Executed By" = '' THEN
                        ERROR('Executed By Cannot be Blank');
                end;
            }
            action("Hold Indent")
            {
                Ellipsis = true;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you want to HOLD the Indent', FALSE) THEN BEGIN
                        Rec.HoldIndent(Rec);
                    END;
                end;
            }
            action("UnHold Indent")
            {
                Ellipsis = true;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you want to UNHOLD the Indent', FALSE) THEN BEGIN
                        Rec.UnHoldIndent(Rec);
                        MailMgt.SendNotificationHold(Rec)
                    END;
                end;
            }
            action("Comment Line")
            {
                Caption = 'Comment Line';
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                RunObject = Page 50096;
                RunPageView = SORTING("Table Name", "No.", "Line No.")
                                 WHERE("Table Name" = FILTER("Indent Header"));

            }
            action(Comment)
            {
                Caption = 'Comment';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Comment Sheet";
                RunPageLink = "Table Name" = FILTER("Indent Header"),
                              "No." = FIELD("No.");
                ApplicationArea = All;
            }
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
                        IF Rec.Status <> Rec.Status::Open THEN
                            ERROR('Status must be Open');

                        AttachmentRecRef.OPEN(DATABASE::"Indent Header");
                        AttachmentRecRef.SETPOSITION(Rec.GETPOSITION);
                        AttachmentRecID := AttachmentRecRef.RECORDID;
                        AttachmentRecRef.CLOSE;
                        AttachmentManagment.ImportAttachment(AttachmentRecID, DATABASE::"Indent Header", 0, Rec."No.", 0);
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
                        AttachmentRecRef.OPEN(DATABASE::"Indent Header");
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
                        IF Rec.Status <> rec.Status::Open THEN
                            ERROR('Status must be Open');

                        AttachmentRecRef.OPEN(DATABASE::"Indent Header");
                        AttachmentRecRef.SETPOSITION(Rec.GETPOSITION);
                        AttachmentRecID := AttachmentRecRef.RECORDID;
                        AttachmentRecRef.CLOSE;
                        AttachmentManagment.DeleteAttachment(AttachmentRecID);
                    end;
                }
            }
            group("&Indent")
            {
            }
            group("F&unctions")
            {
                action("&Generate Purchase Order")
                {
                    Caption = '&Generate Purchase Order';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        IF CONFIRM('Do you want to generate Purchase Order for Indent %1?', TRUE, Rec."No.") THEN BEGIN
                            IF (COPYSTR((Rec."No."), 1, 6) = 'INDCAP') THEN BEGIN
                                IF (Rec."Capex No." = '') THEN
                                    ERROR('Pls mention the Capex No.');
                            END;

                            IndentLine.RESET;
                            IndentLine.SETFILTER(IndentLine."Document No.", '%1', Rec."No.");
                            IF IndentLine.FIND('-') THEN
                                REPEAT
                                    IndentLine.TESTFIELD(IndentLine.Quantity);
                                UNTIL IndentLine.NEXT = 0;

                            UserLocation.RESET;
                            UserLocation.SETFILTER(UserLocation."User ID", '%1', USERID);
                            UserLocation.SETFILTER(UserLocation."Location Code", '%1', Rec."Location Code");
                            UserLocation.SETFILTER(UserLocation.Purchaser, '%1', TRUE);
                            IF UserLocation.FIND('-') THEN BEGIN
                                IF Rec.Status = Rec.Status::Authorized THEN BEGIN
                                    i := 1;

                                    IndentLine.RESET;
                                    IndentLine.SETCURRENTKEY("Vendor No.");
                                    IndentLine.SETFILTER(IndentLine."Document No.", '%1', Rec."No.");
                                    IndentLine.SETFILTER(Deleted, '%1', FALSE);
                                    IndentLine.SETFILTER("Order No.", '%1', '');
                                    IF IndentLine.FIND('-') THEN BEGIN
                                        REPEAT
                                            IF i = 1 THEN BEGIN
                                                VendorNo[i] := IndentLine."Vendor No.";
                                                IF VendorNo[i] = '' THEN
                                                    ERROR('You must specify Vendor No. in Line No. %1', IndentLine."Line No.");
                                                i := i + 1;
                                            END;
                                            IF i <> 1 THEN
                                                IF IndentLine."Vendor No." <> VendorNo[i - 1] THEN BEGIN
                                                    VendorNo[i] := IndentLine."Vendor No.";
                                                    i := i + 1;
                                                END;

                                        //END;

                                        UNTIL IndentLine.NEXT = 0;
                                    END ELSE BEGIN
                                        ERROR('Purchase Order cannot be generated for any of the lines.');
                                    END;
                                    LineNo := 10000;
                                    FOR j := 1 TO i - 1 DO BEGIN
                                        PurchaseHeader.INIT;
                                        PurchaseHeader.RESET;
                                        PurchaseSetup.RESET;
                                        PurchaseSetup.FIND('-');
                                        PurchaseHeader.VALIDATE(PurchaseHeader."Document Type", PurchaseHeader."Document Type"::Order);
                                        PurchaseHeader."No." := NoSeriesMgt.GetNextNo(PurchaseSetup."Order Nos.", WORKDATE, TRUE);
                                        PurchaseHeader.VALIDATE(PurchaseHeader."Buy-from Vendor No.", VendorNo[j]);
                                        PurchaseHeader.VALIDATE(PurchaseHeader."Location Code", Rec."Location Code");
                                        PurchaseHeader.VALIDATE(PurchaseHeader."Capex No.", Rec."Capex No.");

                                        PurchaseHeader.INSERT(TRUE);
                                        COMMIT;
                                        IndentLine.RESET;
                                        IndentLine.SETFILTER(IndentLine."Document No.", '%1', Rec."No.");
                                        IndentLine.SETFILTER(IndentLine."Vendor No.", '%1', VendorNo[j]);
                                        IndentLine.SETFILTER(Deleted, '%1', FALSE);
                                        IndentLine.SETFILTER("Order No.", '%1', '');

                                        IF IndentLine.FIND('-') THEN
                                            REPEAT
                                                IF IndentLine.Type = IndentLine.Type::Item THEN BEGIN
                                                    PurchaseLine.VALIDATE(PurchaseLine."Document Type", PurchaseLine."Document Type"::Order);
                                                    PurchaseLine.VALIDATE(PurchaseLine."Document No.", PurchaseHeader."No.");
                                                    PurchaseLine.VALIDATE(PurchaseLine."Line No.", LineNo);
                                                    PurchaseLine.VALIDATE(PurchaseLine.Type, PurchaseLine.Type::Item);
                                                    PurchaseLine.VALIDATE(PurchaseLine."No.", IndentLine."No.");
                                                    PurchaseLine.VALIDATE(PurchaseLine."Unit of Measure", IndentLine."Unit of Measurement");
                                                    PurchaseLine.VALIDATE(PurchaseLine."Item Category Code", IndentLine."Item Category Code");
                                                    PurchaseLine.VALIDATE(PurchaseLine.Quantity, IndentLine.Quantity);
                                                    PurchaseLine.VALIDATE(PurchaseLine."Indent Date", IndentLine.Date);
                                                    PurchaseLine.VALIDATE(PurchaseLine."Direct Unit Cost", IndentLine.Rate);
                                                    PurchaseLine.VALIDATE(PurchaseLine."Indent No.", IndentLine."Document No.");
                                                    PurchaseLine.VALIDATE(PurchaseLine."Indent Line No.", IndentLine."Line No.");
                                                    PurchaseLine.VALIDATE(PurchaseLine."Location Code", Rec."Location Code");
                                                    IndentLine.CALCFIELDS(IndentLine."Capex No.");
                                                    PurchaseLine.VALIDATE(PurchaseLine."Capex No.", IndentLine."Capex No.");
                                                    PurchaseLine.INSERT(TRUE);
                                                END ELSE
                                                    IF IndentLine.Type = IndentLine.Type::"Non Stock Item" THEN BEGIN
                                                        IndentLine.TESTFIELD(IndentLine."G/L Account");
                                                        PurchaseLine.VALIDATE(PurchaseLine."Document Type", PurchaseLine."Document Type"::Order);
                                                        PurchaseLine.VALIDATE(PurchaseLine."Document No.", PurchaseHeader."No.");
                                                        PurchaseLine.VALIDATE(PurchaseLine."Line No.", LineNo);
                                                        //    PurchaseLine.VALIDATE(PurchaseLine."Location Code","Location Code");
                                                        PurchaseLine.VALIDATE(PurchaseLine.Type, PurchaseLine.Type::"G/L Account");
                                                        PurchaseLine.VALIDATE(PurchaseLine."No.", IndentLine."G/L Account");
                                                        PurchaseLine.VALIDATE(PurchaseLine."Unit of Measure", IndentLine."Unit of Measurement");
                                                        PurchaseLine.VALIDATE(PurchaseLine."Item Category Code", IndentLine."Item Category Code");
                                                        PurchaseLine.VALIDATE(PurchaseLine.Quantity, IndentLine.Quantity);
                                                        PurchaseLine.VALIDATE(PurchaseLine."Direct Unit Cost", IndentLine.Rate);
                                                        PurchaseLine.VALIDATE(PurchaseLine."Indent No.", IndentLine."Document No.");
                                                        PurchaseLine.VALIDATE(PurchaseLine."Indent Line No.", IndentLine."Line No.");
                                                        PurchaseLine.INSERT(TRUE);
                                                        COMMIT;
                                                    END;

                                                LineNo := LineNo + 10000;
                                                IndentLine."Order No." := PurchaseLine."Document No.";
                                                IndentLine."Order Line No." := PurchaseLine."Line No.";
                                                IndentLine."Order Date" := PurchaseHeader."Posting Date";
                                                IndentLine.MODIFY(TRUE);

                                                Rec.MODIFY;

                                            UNTIL IndentLine.NEXT = 0;

                                        MESSAGE('Purchase Order %1 has been generated.', PurchaseHeader."No.");

                                    END;
                                END ELSE BEGIN
                                    ERROR('Status must be Authorized to generate Purchase Order');
                                END;
                            END ELSE BEGIN
                                ERROR('You are not authorised to generate Purchase Order from this Indent.');
                            END;

                        END;
                    end;
                }
                action("&Reject")
                {
                    Caption = '&Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //TESTFIELD("Reason of Rejection");

                        CLEAR(EmailN);
                        SLEEP(1000);
                        //EmailN.SendMail(Rec);

                        IF Rec."Authorization 3" <> UPPERCASE(USERID) THEN BEGIN
                            IndentLine.RESET;
                            IndentLine.SETFILTER(IndentLine."Document No.", Rec."No.");
                            IndentLine.SETFILTER(IndentLine."Order No.", '<>%1', '');
                            IF NOT IndentLine.FIND('-') THEN
                                ERROR('You cannot Close Indent %1 as Purchase Order Details does not exist for any of the lines. Please Delete the Indent.', Rec."No."
                               );
                        END;
                        //IF Status <> Status::Authorization3 THEN
                        // ERROR('Status must be authorized to close the Indent');

                        IF CONFIRM('Do you want to Close Indent %1?', TRUE, Rec."No.") THEN BEGIN
                            UserLocation.RESET;
                            UserLocation.SETFILTER(UserLocation."User ID", USERID);
                            UserLocation.SETFILTER(UserLocation."Location Code", Rec."Location Code");
                            UserLocation.SETFILTER(UserLocation.Purchaser, '%1', TRUE);
                            IF UserLocation.FIND('-') THEN BEGIN
                                Rec.VALIDATE(Status, Rec.Status::Closed);
                                Rec.MODIFY;


                                IndentLine.RESET;
                                IndentLine.SETFILTER(IndentLine."Document No.", Rec."No.");
                                IndentLine.SETFILTER(IndentLine."Order No.", '%1', '');
                                IF IndentLine.FIND('-') THEN
                                    REPEAT
                                        IndentLine.Deleted := TRUE;
                                        IndentLine.MODIFY;
                                    UNTIL IndentLine.NEXT = 0;
                            END ELSE BEGIN
                                MESSAGE('You are not authorized to Close this indent');
                            END;
                            MESSAGE('Indent %1 is available as Archived.', Rec."No.");
                        END;
                        //MESSAGE('Hello');
                    end;
                }
                action("&Delete")
                {
                    Caption = '&Delete';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF UPPERCASE(USERID) <> 'PROD004' THEN
                            ERROR('You are not allowed to delete the Indent');

                        IndentLine.RESET;
                        IndentLine.SETFILTER(IndentLine."Document No.", Rec."No.");
                        IndentLine.SETFILTER(IndentLine."Order No.", '<>%1', '');
                        IF IndentLine.FIND('-') THEN
                            ERROR('Line No. %1 has already been included in Purchase Order %2, Line No. %3. Please Close the Indent.',
                              IndentLine."Line No.", IndentLine."Order No.", IndentLine."Order Line No.");

                        IF CONFIRM('Do you want to Delete Indent %1?', TRUE, Rec."No.") THEN BEGIN

                            UserLocation.RESET;
                            UserLocation.SETFILTER(UserLocation."User ID", USERID);
                            UserLocation.SETFILTER(UserLocation."Location Code", Rec."Location Code");
                            UserLocation.SETFILTER(UserLocation.Purchaser, '%1', TRUE);

                            UserSetup.RESET;
                            UserSetup.SETFILTER(UserSetup."User ID", Rec."User ID");
                            IF UserSetup.FIND('-') THEN BEGIN
                                CASE Rec.Status OF
                                    Rec.Status::Open:
                                        IF UserSetup."User ID" = UPPERCASE(USERID) THEN
                                            Rec.VALIDATE(Deleted, TRUE);

                                    Rec.Status::Authorization1:
                                        IF UserSetup."Authorization 1" = UPPERCASE(USERID) THEN
                                            Rec.VALIDATE(Deleted, TRUE);

                                    Rec.Status::Authorization2:
                                        IF UserSetup."Authorization 2" = UPPERCASE(USERID) THEN
                                            Rec.VALIDATE(Deleted, TRUE);
                                    Rec.Status::Authorization3:
                                        IF UserSetup."Authorization 3" = UPPERCASE(USERID) THEN
                                            Rec.VALIDATE(Deleted, TRUE);




                                    Rec.Status::Authorized:
                                        IF UserLocation.FIND('-') THEN
                                            IF UserLocation."User ID" = UPPERCASE(USERID) THEN
                                                Rec.VALIDATE(Deleted, TRUE);

                                END;

                                Rec.VALIDATE(Status, Rec.Status::Closed);
                                MESSAGE('Indent %1 is available as Archived.', Rec."No.");

                            END;

                            Rec.MODIFY;

                            IF rec.Deleted = FALSE THEN
                                MESSAGE('You are not authorized to Delete this Indent.');
                        END;
                    end;
                }
                action(CheckMail)
                {
                    Caption = 'CheckMail';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CLEAR(EmailN);
                        //EmailN.MailSendRejection(Rec);
                        //EmailN.SendMail(Rec);
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IndentHeader1.RESET;
                    IndentHeader1.SETFILTER("No.", Rec."No.");
                    PurchIndentRep.SETTABLEVIEW(IndentHeader1);
                    PurchIndentRep.RUN;
                end;
            }
            action(comm)
            {
                Caption = 'Comment';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Comment';
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CommentLine: Record "Comment Line";
                    CommentSheetForm: Page "Comment Sheet";
                begin
                    CommentLine.RESET;
                    CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::"Indent Header");
                    CommentLine.SETFILTER("No.", '%1', Rec."No.");
                    PAGE.RUN(0, CommentLine);
                    //IF CommentLine.FINDFIRST THEN BEGIN
                    //  CommentSheetForm.SETTABLEVIEW(CommentLine);
                    //  CommentSheetForm.RUNMODAL;
                    //END;
                end;
            }
            action(Temp)
            {
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                var
                    IndHead: Record "Indent Header";
                    IndLine: Record "Indent Line";
                begin
                    IndHead.RESET;
                    IndHead.SETFILTER(Status, '<>%1', IndHead.Status::Closed);
                    IF IndHead.FINDFIRST THEN
                        REPEAT
                            IndLine.RESET;
                            IndLine.SETRANGE("Document No.", IndHead."No.");
                            IndLine.MODIFYALL("Location Code", IndHead."Location Code");
                        UNTIL
                        IndHead.NEXT = 0;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin



        /*CommentLine.RESET;
        CommentLine.SETRANGE("Table Name",CommentLine."Table Name"::"Indent Header");
        CommentLine.SETRANGE("No.","No.");
        CommentLine.SETFILTER("Creater ID",'%1',UPPERCASE(USERID));
        CommentLine.SETRANGE("Reply/Comment",CommentLine."Reply/Comment"::Comment);
        //CommentLine.SETRANGE(Checked,FALSE);
        IF CommentLine.FINDFIRST THEN
          BComment:=TRUE
        ELSE
          BComment:=FALSE;
        
        CommentLine.RESET;
        CommentLine.SETRANGE("Table Name",CommentLine."Table Name"::"Indent Header");
        CommentLine.SETRANGE("No.","No.");
        CommentLine.SETFILTER("Creater ID",'%1',UPPERCASE(USERID));
        CommentLine.SETRANGE("Reply/Comment",CommentLine."Reply/Comment"::Reply);
        //CommentLine.SETRANGE(Checked,FALSE);
        IF CommentLine.FINDFIRST THEN
          BComment:=TRUE
        ELSE
          BComment:=FALSE;
        
        
        
        
        CommentLine.RESET;
        CommentLine.SETRANGE("Table Name",CommentLine."Table Name"::"Indent Header");
        CommentLine.SETRANGE("No.","No.");
        CommentLine.SETFILTER("Creater ID",'<>%1',UPPERCASE(USERID));
        CommentLine.SETRANGE("Reply/Comment",CommentLine."Reply/Comment"::Comment);
        //CommentLine.SETRANGE(Checked,FALSE);
        IF CommentLine.FINDFIRST THEN
          BReply:=TRUE
        ELSE
          BReply:=FALSE;
        
        CurrForm.UPDATECONTROLS;
        
        CommentLine.RESET;
        CommentLine.SETRANGE("Table Name",CommentLine."Table Name"::"Indent Header");
        CommentLine.SETRANGE("No.","No.");
        CommentLine.SETFILTER("Creater ID",UPPERCASE(USERID));
        CommentLine.SETRANGE("Reply/Comment",CommentLine."Reply/Comment"::Reply);
        //CommentLine.SETRANGE(Checked,FALSE);
        IF CommentLine.FINDFIRST THEN
          BReply:=TRUE
        ELSE
          BReply:=FALSE;
        
        
        
        
        NextUser:='';
        IF "User ID"= UPPERCASE(USERID) THEN
          IF "Authorization 1"<>'' THEN
            NextUser:="Authorization 1";
        
        IF "Authorization 1"= UPPERCASE(USERID) THEN
          IF "Authorization 2"<>'' THEN
            NextUser:="Authorization 2";
        
        IF "Authorization 2"= UPPERCASE(USERID) THEN
          IF "Authorization 1"<>'' THEN
            NextUser:="Authorization 3";
        
        CommentLine.RESET;
        CommentLine.SETRANGE("Table Name",CommentLine."Table Name"::"Indent Header");
        CommentLine.SETRANGE("No.","No.");
        CommentLine.SETRANGE("Creater ID",UPPERCASE(USERID));
        CommentLine.SETRANGE(Test,1);
        IF CommentLine.FINDFIRST THEN
          LastLineNo:=CommentLine."Line No.";
        
        CommentLine.RESET;
        CommentLine.SETRANGE("Table Name",CommentLine."Table Name"::"Indent Header");
        CommentLine.SETRANGE("No.","No.");
        CommentLine.SETRANGE("Creater ID",UPPERCASE(NextUser));
        CommentLine.SETRANGE(Test,1);
        IF CommentLine.FINDFIRST THEN
          LastLineNo1:=CommentLine."Line No.";
        
        IF LastLineNo<LastLineNo1 THEN BEGIN
          Reply:=TRUE;
        END ELSE
        BComment:=TRUE;
        */

        //MESSAGE('%1..%2..%3..%4..%5',USERID,NextUser,Reply,LastLineNo ,LastLineNo1);
        /*
        //TRI DG Add Start
         IF Status=Status::Authorized THEN
          CurrForm."Indent Subform".ENABLED(FALSE)
         ELSE
          CurrForm."Indent Subform".ENABLED(TRUE);
        
        // TRI DG ADD  END
        */
        IF Rec.Status > Rec.Status::Open THEN
            CurrPage."Indent Subform".PAGE.TrackControls(FALSE)
        ELSE
            CurrPage."Indent Subform".PAGE.TrackControls(TRUE);

        /*IF Status = Status::Authorized THEN
          CurrForm.SalesLines.FORM.RecCurformUpdate(FALSE)
        ELSE
          CurrForm.SalesLines.FORM.RecCurformUpdate(TRUE);*/

        IF Rec.Status = Rec.Status::Authorized THEN BEGIN
            "Capex No.Editable" := FALSE;
        END ELSE
            "Capex No.Editable" := TRUE;
        BEGIN
        END;
        //TRI

    end;

    trigger OnInit()
    begin
        "Capex No.Editable" := TRUE;
    end;

    var
        CommentLine: Record "Comment Line";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        IndentHeader: Record "Indent Header";
        IndentLine: Record "Indent Line";
        i: Integer;
        VendorNo: array[100] of Code[20];
        j: Integer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchaseSetup: Record "Purchases & Payables Setup";
        LineNo: Integer;
        UserLocation: Record "User Location";
        UserSetup: Record "User Setup";
        IndentHeader1: Record "Indent Header";
        PurchIndentRep: Report "Purchase Indent Report";
        Err001: Label 'Enter the Dept Code.';
        Err002: Label 'Enter the Plant Code.';
        cAPEX: array[100] of Code[20];
        NextUser: Code[20];
        LastLineNo: Integer;
        LastLineNo1: Integer;
        RejectionMail: Codeunit IndentRelease;
        EmailN: Codeunit "Email Notification1";
        [InDataSet]
        "Capex No.Editable": Boolean;
        MailMgt: Codeunit IndentRelease;
        AttachmentRecRef: RecordRef;
        AttachmentManagment: Record "Attachment Management";
        AttachmentRecID: RecordID;

    local procedure DepartmentCodeOnAfterValidate()
    begin
        //TRI A.S 31.07.08 Start
        IF Rec."Department Code" = '' THEN
            ERROR(Err001);
        //TRI A.S 31.07.08 End
    end;

    local procedure PlantCodeOnAfterValidate()
    begin
        //TRI A.S 31.07.08 Start
        IF Rec."Plant Code" = '' THEN
            ERROR(Err002);
        //TRI A.S 31.07.08 End
    end;
}

