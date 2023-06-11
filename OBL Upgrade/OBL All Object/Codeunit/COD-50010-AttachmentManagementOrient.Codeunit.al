codeunit 50010 AttachmentManagementOrient
{

    trigger OnRun()
    begin
    end;

    var
        Text000: Label 'Send attachments...\\';
        Text001: Label 'Preparing';
        Text002: Label 'Deliver misc.';
        Text005: Label '\Attachment.%1';
        Text007: Label 'You need to have Microsoft Word 2000 or later installed on your system to run this feature.';


    procedure InsertAttachment(AttachmentNo: Integer): Integer
    var
        Attachment3: Record "Scheme Master for Apps";
        GLSetup: Record "General Ledger Setup";
        Attachment: Record "Scheme Master for Apps";
    begin
        IF AttachmentNo <> 0 THEN BEGIN
            Attachment.GET(AttachmentNo);
            // IF Attachment."Unit of Target" = Attachment."Unit of Target"::"0" THEN
            Attachment.CALCFIELDS(City);
            Attachment3 := Attachment; // Remember "from" attachment
        END;

        Attachment.INSERT(TRUE);

        /*IF AttachmentNo <> 0 THEN
        
          // New attachment is based on old attachment
          TransferAttachment(Attachment3,Attachment); // Transfer attachments of different types.  */

        //  EXIT(Attachment."No.");

    end;


    procedure Send(var DeliverySorter: Record "Delivery Sorter")
    var
        Attachment: Record "Scheme Master for Apps";
        TempDeliverySorterWord: Record "Delivery Sorter" temporary;
        TempDeliverySorterOther: Record "Delivery Sorter" temporary;
        InteractLogEntry: Record "Interaction Log Entry";
        Contact: Record Contact;
        WordManagement: Codeunit WordManagementOrient;
        Mail: Codeunit Mail;
        FileName: Text[260];
        Window: Dialog;
        NoOfAttachments: Integer;
        I: Integer;
    begin
        Window.OPEN(
          Text000 +
          '#1############ @2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\' +
          '#3############ @4@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');

        Window.UPDATE(1, Text001);
        Window.UPDATE(3, Text002);

        IF DeliverySorter.FIND('-') THEN BEGIN
            NoOfAttachments := DeliverySorter.COUNT;
            REPEAT
                DeliverySorter.TESTFIELD("Correspondence Type");
                Attachment.GET(DeliverySorter."Attachment No.");

                /*   IF UseComServer(Attachment."File Extension",
                    DeliverySorter."Correspondence Type" <> DeliverySorter."Correspondence Type"::"E-Mail")
                  THEN BEGIN
                      TempDeliverySorterWord := DeliverySorter;
                      TempDeliverySorterWord.INSERT;
                  END ELSE BEGIN
                      TempDeliverySorterOther := DeliverySorter;
                      TempDeliverySorterOther.INSERT;
                  END;
                 */
                I := I + 1;
                Window.UPDATE(2, ROUND(I / NoOfAttachments * 10000, 1));
            UNTIL DeliverySorter.NEXT = 0;
        END;

        // MS Word merge
        IF TempDeliverySorterWord.FIND('-') THEN
            WordManagement.Merge(TempDeliverySorterWord);

        // Deliver other types
        IF TempDeliverySorterOther.FIND('-') THEN BEGIN
            I := 0;
            NoOfAttachments := TempDeliverySorterOther.COUNT;
            REPEAT
                InteractLogEntry.LOCKTABLE;
                InteractLogEntry.GET(TempDeliverySorterOther."No.");
                IF TempDeliverySorterOther."Correspondence Type" = TempDeliverySorterOther."Correspondence Type"::"E-Mail" THEN BEGIN
                    Attachment.GET(TempDeliverySorterOther."Attachment No.");
                    // Attachment.TESTFIELD("File Extension");
                    // 15578    FileName := STRSUBSTNO(ENVIRON('TEMP') + Text005, Attachment."File Extension");
                    //Attachment.ExportAttachment(FileName);
                    Contact.GET(InteractLogEntry."Contact No.");
                    // Mail.NewMessage(InteractionEMail(InteractLogEntry), '', '', TempDeliverySorterOther.Subject, '', FileName, FALSE);
                    // ERASE(FileName);
                    InteractLogEntry."Delivery Status" := InteractLogEntry."Delivery Status"::" ";
                    InteractLogEntry.MODIFY;
                END ELSE BEGIN
                    InteractLogEntry."Delivery Status" := InteractLogEntry."Delivery Status"::Error;
                    InteractLogEntry.MODIFY;
                END;
                COMMIT;
                I := I + 1;
                Window.UPDATE(4, ROUND(I / NoOfAttachments * 10000, 1));
            UNTIL TempDeliverySorterOther.NEXT = 0;
        END;
        Window.CLOSE;
    end;


    procedure FileExtension(FileName: Text[260]) Extension: Text[260]
    var
        I: Integer;
    begin
        I := STRLEN(FileName);
        WHILE COPYSTR(FileName, I, 1) <> '.' DO
            I := I - 1;
        Extension := COPYSTR(FileName, I + 1, STRLEN(FileName) - I);
    end;

    local procedure TransferAttachment(FromAttachment: Record "Scheme Master for Apps"; var ToAttachment: Record "Scheme Master for Apps")
    var
        GLSetup: Record "General Ledger Setup";
    begin
        // Transfer attachments of different types

        /*   IF (FromAttachment."Storage Type" = FromAttachment."Storage Type"::Embedded) AND
             (ToAttachment."Storage Type" = ToAttachment."Storage Type"::"Disk File")
          THEN BEGIN
              FromAttachment.ExportAttachment(ToAttachment.ConstDiskFileName); // Export blob to diskfile
              WITH ToAttachment DO BEGIN
                  CLEAR(FileAttachment);
                  GLSetup.GET;
                  GLSetup.TESTFIELD("Voith Attmt. Storage Location");
                  "Storage Pointer" := GLSetup."Voith Attmt. Storage Location";
                  MODIFY;
              END;
          END;

         */
        /* IF (FromAttachment."Storage Type" = FromAttachment."Storage Type"::"Disk File") AND
        (ToAttachment."Storage Type" = ToAttachment."Storage Type"::"Disk File")
     THEN BEGIN

            // Copy external attachment (to new storage)
            GLSetup.GET;
            GLSetup.TESTFIELD("Voith Attmt. Storage Location");
            ToAttachment."Storage Pointer" := GLSetup."Voith Attmt. Storage Location";
            ToAttachment.MODIFY;
            FILE.COPY(FromAttachment.ConstDiskFileName, ToAttachment.ConstDiskFileName);
        END;

        IF (FromAttachment."Storage Type" = FromAttachment."Storage Type"::"Disk File") AND
           (ToAttachment."Storage Type" = ToAttachment."Storage Type"::Embedded)
        THEN BEGIN

            // Transfer External to Embedded attachment
            WITH ToAttachment DO BEGIN
                // 15578   ImportAttachment(FromAttachment.ConstDiskFileName, FALSE, FALSE, ToAttachment);
                "File Extension" := FromAttachment."File Extension";
                "Storage Pointer" := '';
                MODIFY;
            END;
        END; */
    end;


    procedure UseComServer(FileExtension: Text[250]; RequireAutomation: Boolean): Boolean
    var
        // 15578  AutomationServers: Record 2000000046;
        VersionNo: Decimal;
        DecimalSymbol: Text[1];
    begin
        IF UPPERCASE(FileExtension) <> 'DOC' THEN
            EXIT(FALSE);

        DecimalSymbol := FORMAT(FORMAT(1 / 10) [2]);

        /*  WITH AutomationServers DO BEGIN
              SETRANGE(GUID, '{00020905-0000-0000-C000-000000000046}');
              IF FIND('-') THEN
                  REPEAT
                      EVALUATE(VersionNo, CONVERTSTR(Version, '.', DecimalSymbol));
                      IF VersionNo >= 8.1 THEN
                          EXIT(TRUE);
                  UNTIL NEXT = 0;*/  // 15578
        IF RequireAutomation THEN
            ERROR(Text007)
        ELSE
            EXIT(FALSE);
    END;
    // end;


    procedure InteractionEMail(var InteractLogEntry: Record "Interaction Log Entry"): Text[80]
    var
        Cont: Record Contact;
        ContAltAddr: Record "Contact Alt. Address";
    begin
        IF InteractLogEntry."Contact Alt. Address Code" = '' THEN BEGIN
            Cont.GET(InteractLogEntry."Contact No.");
            EXIT(Cont."E-Mail");
        END ELSE BEGIN
            ContAltAddr.GET(InteractLogEntry."Contact No.", InteractLogEntry."Contact Alt. Address Code");
            IF ContAltAddr."E-Mail" <> '' THEN
                EXIT(ContAltAddr."E-Mail")
            ELSE BEGIN
                Cont.GET(InteractLogEntry."Contact No.");
                EXIT(Cont."E-Mail");
            END;
        END;
    end;


    procedure InteractionFax(var InteractLogEntry: Record "Interaction Log Entry"): Text[30]
    var
        Cont: Record Contact;
        ContAltAddr: Record "Contact Alt. Address";
    begin
        IF InteractLogEntry."Contact Alt. Address Code" = '' THEN BEGIN
            Cont.GET(InteractLogEntry."Contact No.");
            EXIT(Cont."Fax No.");
        END ELSE BEGIN
            ContAltAddr.GET(InteractLogEntry."Contact No.", InteractLogEntry."Contact Alt. Address Code");
            IF ContAltAddr."Fax No." <> '' THEN
                EXIT(ContAltAddr."Fax No.")
            ELSE BEGIN
                Cont.GET(InteractLogEntry."Contact No.");
                EXIT(Cont."Fax No.");
            END;
        END;
    end;
}

