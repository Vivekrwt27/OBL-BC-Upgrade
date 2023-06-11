codeunit 50009 WordManagementOrient
{

    trigger OnRun()
    begin
    end;

    var
        Text003: Label 'Merging Microsoft Word Documents...\\';
        Text004: Label 'Preparing';
        Text005: Label 'Program status';
        Text006: Label 'Preparing Merge...';
        Text007: Label 'Waiting for print job...';
        Text008: Label 'Transferring %1 data to Microsoft Word...';
        Text009: Label 'Sending individual mails...';
        Text010: Label '%1 %2 must have %3 DOC.';
        Text011: Label 'Attachment file error';
        Text012: Label 'Creating merge source...';
        Text013: Label 'Microsoft Word is opening merge source...';
        Text014: Label 'Merging %1 in Microsoft Word...';
        Text015: Label 'FaxMailTo';
        Text017: Label 'The merge source file is locked by another process.\';
        Text018: Label 'Please try again later.';
        Text019: Label ' Mail Address';
        Text020: Label 'Document ';
        Text021: Label 'Import attachment ';
        Text022: Label 'Delete %1?';
        Text023: Label 'Another user has modified the record for this %1\after you retrieved it from the database.\\';
        Text025: Label 'Enter the changes again in the updated document.';
        Text027: Label '\Doc';
        Text029: Label '\MergeSource';
        Window: Dialog;
        AttachmentManagement: Codeunit AttachmentManagement;
        Text030: Label 'Formal Salutation';
        Text031: Label 'Informal Salutation';


    procedure CreateWordAttachment(WordCaption: Text[260]; AttachRec: Record "Scheme Master for Apps") NewAttachNo: Integer
    var
        AttachmentVoith: Record "Scheme Master for Apps";
        AttachmentManagement: Codeunit AttachmentManagement;
        FileName: Text[260];
        MergeFileName: Text[260];
        ParamInt: Integer;
    begin

        AttachmentVoith."Slab 1 Target" := 'DOC';

        /*IF ISCLEAR(wrdApp) THEN
          CREATE(wrdApp);
        IF ISCLEAR(wrdMergefile) THEN
          CREATE(wrdMergefile);
         */
        MergeFileName := ConstMergeSourceFileName;
        //CreateHeader(wrdMergefile,TRUE,MergeFileName); // Header without data

        /*wrdDoc := wrdApp.Documents.Add;
        wrdDoc.MailMerge.MainDocumentType := 0; // 0 = wdFormLetters
        ParamInt := 7; // 7 = HTML
        wrdDoc.MailMerge.OpenDataSource2000(MergeFileName,ParamInt);
         */
        //FileName := AttachmentVoith.ConstFileName;

        /*wrdDoc.SaveAs2000(FileName);
        wrdDoc.ActiveWindow.Caption := WordCaption;
        wrdDoc.Saved := TRUE;
        wrdApp.Visible := TRUE;
         */

        //IF WordHandler(wrdDoc,AttachmentVoith,WordCaption,FALSE,FileName,FALSE) THEN
        /*IF WordHandler(wrdDoc,AttachRec,WordCaption,FALSE,FileName,FALSE) THEN
          NewAttachNo := AttachmentVoith."No."
        ELSE
          NewAttachNo := 0;
         */
        /*
       CLEAR(wrdMergefile);
       CLEAR(wrdDoc);
       CLEAR(wrdApp);

       DeleteFile(MergeFileName);
         */

    end;


    procedure OpenWordAttachment(var AttachmentVoith: Record "Scheme Master for Apps"; FileName: Text[260]; Caption: Text[260]; IsTemporary: Boolean)
    var
        ParamFalse: Boolean;
        MergeFileName: Text[260];
        ParamInt: Integer;
    begin
        /*IF ISCLEAR(wrdApp) THEN
          CREATE(wrdApp);
        IF ISCLEAR(wrdMergefile) THEN
          CREATE(wrdMergefile);
         */
        /*
        //MergeFileName := ConstMergeSourceFileName;
        //CreateHeader(wrdMergefile,TRUE,MergeFileName);
        ParamFalse := FALSE;
        wrdDoc := wrdApp.Documents.Open2000(FileName,ParamFalse,AttachmentVoith."Read Only");
        IF wrdDoc.MailMerge.MainDocumentType = -1 THEN BEGIN
          wrdDoc.MailMerge.MainDocumentType := 0; // 0 = wdFormLetters
          MergeFileName := ConstMergeSourceFileName;
          CreateHeader(wrdMergefile,TRUE,MergeFileName); // Header without data
          wrdDoc.MailMerge.OpenDataSource2000(MergeFileName,ParamInt);
        END;
        
        IF wrdDoc.MailMerge.Fields.Count > 0 THEN BEGIN
          IF ISCLEAR(wrdMergefile) THEN
            CREATE(wrdMergefile);
          ParamInt := 7; // 7 = HTML
          wrdDoc.MailMerge.OpenDataSource2000(MergeFileName,ParamInt);
        END;
        
        wrdDoc.ActiveWindow.Caption := Caption;
        wrdDoc.ActiveWindow.WindowState := 1; // 1 = wdWindowStateMaximize
        wrdDoc.Saved := TRUE;
        wrdApp.Visible := TRUE;
        
        WordHandler(wrdDoc,AttachmentVoith,Caption,IsTemporary,FileName,FALSE);
        
        CLEAR(wrdMergefile);
        CLEAR(wrdDoc);
        CLEAR(wrdApp);
        
        DeleteFile(MergeFileName);
         */

    end;


    procedure Merge(var TempDeliverySorter: Record "Delivery Sorter" temporary)
    var
        TempDeliverySorter2: Record "Delivery Sorter" temporary;
        LastAttachmentNo: Integer;
        LastCorrType: Integer;
        LastSubject: Text[50];
        LastSendWordDocsAsAttmt: Boolean;
        LineCount: Integer;
        NoOfRecords: Integer;
        WordHided: Boolean;
        Param: Boolean;
        FirstRecord: Boolean;
    begin
        Window.OPEN(
          Text003 +
          '#1############ @2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\' +
          '#3############ @4@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\\' +
          '#5############ #6################################');

        Window.UPDATE(1, Text004);
        Window.UPDATE(5, Text005);
        /*
        IF ISCLEAR(wrdApp) THEN
          CREATE(wrdApp);
        IF ISCLEAR(wrdMergefile) THEN
          CREATE(wrdMergefile);
        
        IF wrdApp.Documents.Count > 0 THEN BEGIN
          wrdApp.Visible := FALSE;
          WordHided := TRUE;
        END;
        
        Window.UPDATE(6,Text006);
        TempDeliverySorter.SETCURRENTKEY(
          "Attachment No.","Correspondence Type",Subject,"Send Word Docs. as Attmt.");
        TempDeliverySorter.SETFILTER(TempDeliverySorter."Correspondence Type",'<>0');
        NoOfRecords := TempDeliverySorter.COUNT;
        TempDeliverySorter.FIND('-');
        
        FirstRecord := TRUE;
        REPEAT
          LineCount := LineCount + 1;
          Window.UPDATE(2,ROUND(LineCount / NoOfRecords * 10000,1));
          Window.UPDATE(3,STRSUBSTNO('%1',TempDeliverySorter."Correspondence Type"));
        
          IF NOT FirstRecord AND
            (((TempDeliverySorter."Attachment No." <> LastAttachmentNo)) OR
            ((TempDeliverySorter."Correspondence Type" <> LastCorrType)) OR
            ((TempDeliverySorter.Subject <> LastSubject)) OR
            ((TempDeliverySorter."Send Word Docs. as Attmt." <> LastSendWordDocsAsAttmt)))
          THEN BEGIN
            ExecuteMerge(wrdApp,TempDeliverySorter2);
            TempDeliverySorter2.DELETEALL;
          END;
        
          TempDeliverySorter2 := TempDeliverySorter;
          TempDeliverySorter2.INSERT;
          LastAttachmentNo := TempDeliverySorter."Attachment No.";
          LastCorrType := TempDeliverySorter."Correspondence Type";
          LastSubject := TempDeliverySorter.Subject;
          LastSendWordDocsAsAttmt := TempDeliverySorter."Send Word Docs. as Attmt.";
        
          FirstRecord := FALSE;
        UNTIL TempDeliverySorter.NEXT = 0;
        
        IF TempDeliverySorter2.FIND('-') THEN
          ExecuteMerge(wrdApp,TempDeliverySorter2);
        
        IF WordHided THEN
          wrdApp.Visible := TRUE
        ELSE BEGIN
        
          // Wait for print job to finish
          IF wrdApp.BackgroundPrintingStatus <> 0 THEN
            REPEAT
              Window.UPDATE(6,Text007);
              SLEEP(500);
            UNTIL wrdApp.BackgroundPrintingStatus = 0;
        
          Param := FALSE;
          wrdApp.Quit(Param)
        END;
        
        CLEAR(wrdMergefile);
        CLEAR(wrdApp);
         */

    end;

    local procedure ExecuteMerge(var TempDeliverySorter: Record "Delivery Sorter")
    var
        AttachmentVoith: Record "Scheme Master for Apps";
        InteractLogEntry: Record "Interaction Log Entry";
        Salesperson: Record "Salesperson/Purchaser";
        Country: Record "Country/Region";
        Country2: Record "Country/Region";
        Contact: Record Contact;
        CompanyInfo: Record "Company Information";
        FormatAddr: Codeunit "Format Address";
        Mail: Codeunit Mail;
        MergeFileName: Text[260];
        MainFileName: Text[260];
        NoOfRecords: Integer;
        ParamBln: Boolean;
        ParamInt: Integer;
        ContAddr: array[8] of Text[50];
        ContAddr2: array[8] of Text[50];
        MultiAddress: array[2] of Text[260];
        i: Integer;
        Row: Integer;
    begin
        /*Window.UPDATE(
          6,STRSUBSTNO(Text008,
          FORMAT(TempDeliverySorter."Correspondence Type")));
        IF TempDeliverySorter.FIND('-') THEN
          NoOfRecords := TempDeliverySorter.COUNT;
        
        AttachmentVoith.GET(TempDeliverySorter."Attachment No.");
        // Handle Word documents without mergefields
        IF NOT DocContainMergefields(AttachmentVoith) THEN BEGIN
          CASE TempDeliverySorter."Correspondence Type" OF
            TempDeliverySorter."Correspondence Type"::"Hard Copy":
              BEGIN
                MainFileName := ConstDocFilename;
                AttachmentVoith.ExportAttachment(MainFileName);
                wrdDoc := wrdApp.Documents.Open2000(MainFileName);
        
                REPEAT
                  InteractLogEntry.LOCKTABLE;
                  InteractLogEntry.GET(TempDeliverySorter."No.");
                  wrdDoc.PrintOut2000;
                  InteractLogEntry."Delivery Status" := InteractLogEntry."Delivery Status"::" ";
                  InteractLogEntry.MODIFY;
                  COMMIT;
                UNTIL TempDeliverySorter.NEXT = 0;
                ParamBln := FALSE;
                wrdDoc.Close(ParamBln);
              END;
            TempDeliverySorter."Correspondence Type"::"E-Mail":
              BEGIN
        
                // Send attachment to all contacts in buffer
                Window.UPDATE(6,Text009);
                AttachmentVoith.TESTFIELD("File Extension");
                MainFileName := ConstDocFilename;
                AttachmentVoith.ExportAttachment(MainFileName);
                REPEAT
                  InteractLogEntry.LOCKTABLE;
                  InteractLogEntry.GET(TempDeliverySorter."No.");
                  Contact.GET(InteractLogEntry."Contact No.");
                  Mail.NewMessage(
                    AttachmentManagement.InteractionEMail(InteractLogEntry),'',
                    TempDeliverySorter.Subject,'',MainFileName,FALSE);
                  InteractLogEntry."Delivery Status" := InteractLogEntry."Delivery Status"::" ";
                  InteractLogEntry.MODIFY;
                  COMMIT;
                UNTIL TempDeliverySorter.NEXT = 0;
                DeleteFile(MainFileName);
              END;
          END;
          EXIT;
        END;
        
        // Merge possible
        MergeFileName := ConstMergeSourceFileName;
        IF DeleteFile(MergeFileName) THEN;
        
        CREATE(wrdMergefile);
        CreateHeader(wrdMergefile,FALSE,MergeFileName);
        
        WITH TempDeliverySorter DO BEGIN
          SETCURRENTKEY("Attachment No.","Correspondence Type",Subject);
          FIND('-');
        END;
        Row := 2;
        
        MainFileName := ConstDocFilename;
        TempDeliverySorter.FIND('-');
        AttachmentVoith.GET(TempDeliverySorter."Attachment No.");
        IF AttachmentVoith."File Extension" <> 'DOC' THEN
          ERROR(STRSUBSTNO(Text010,AttachmentVoith.TABLECAPTION,AttachmentVoith."No.",
            AttachmentVoith.FIELDCAPTION("File Extension")));
        IF AttachmentManagement.UseComServer(AttachmentVoith."File Extension",TRUE) THEN;
        
        IF NOT AttachmentVoith.ExportAttachment(MainFileName) THEN
          ERROR(Text011);
        
        Window.UPDATE(6,Text012);
        REPEAT
          InteractLogEntry.GET(TempDeliverySorter."No.");
          Contact.GET(InteractLogEntry."Contact No.");
          CompanyInfo.GET;
          IF NOT Country2.GET(CompanyInfo."Country/Region Code") THEN
            CLEAR(Country2);
        
          IF NOT Country.GET(Contact."Country/Region Code") THEN
            CLEAR(Country);
          IF NOT Salesperson.GET(InteractLogEntry."Salesperson Code") THEN
            CLEAR(Salesperson);
        
          // Add mulitline fielddata
          i := 1;
          CLEAR(MultiAddress);
          FormatAddr.ContactAddrAlt(ContAddr,Contact,InteractLogEntry."Contact Alt. Address Code",InteractLogEntry.Date);
        
          wrdMergefile.NewMultiField;
          COPYARRAY(ContAddr2,ContAddr,1);
          COMPRESSARRAY(ContAddr2);
          WHILE ContAddr2[1] <> '' DO BEGIN
            IF ContAddr[i] <> '' THEN BEGIN
              wrdMergefile.AddMultiToField(ContAddr[i]);
              ContAddr2[1] := '';
              COMPRESSARRAY(ContAddr2);
            END ELSE
              wrdMergefile.AddMultiToField('&nbsp;');
            i := i + 1;
          END;
          wrdMergefile.EndMultiField;
        
          WITH wrdMergefile DO BEGIN
            AddField(Contact."No.");
            AddField(Contact."Company Name");
            AddField(Contact.Name);
            AddField(Contact."Name 2");
            AddField(Contact.Address);
            AddField(Contact."Address 2");
            AddField(Contact."Post Code");
            AddField(Contact.City);
            AddField(Contact.County);
            AddField(Country.Name);
            AddField(Contact."Job Title");
            AddField(Contact."Phone No.");
            AddField(Contact."Fax No.");
            AddField(Contact."E-Mail");
            AddField(Contact."Mobile Phone No.");
            AddField(Contact."VAT Registration No.");
            AddField(Contact."Home Page");
            AddField(Contact.GetSalutation(0,InteractLogEntry."Interaction Language Code"));
            AddField(Contact.GetSalutation(1,InteractLogEntry."Interaction Language Code"));
            AddField(Salesperson.Code);
            AddField(Salesperson.Name);
            AddField(Salesperson."Job Title");
            AddField(Salesperson."Phone No.");
            AddField(Salesperson."E-Mail");
            AddField(FORMAT(InteractLogEntry.Date));
            AddField(InteractLogEntry."Campaign No.");
            AddField(InteractLogEntry."Segment No.");
            AddField(InteractLogEntry.Description);
            AddField(InteractLogEntry.Subject);
            AddField(CompanyInfo.Name);
            AddField(CompanyInfo."Name 2");
            AddField(CompanyInfo.Address);
            AddField(CompanyInfo."Address 2");
            AddField(CompanyInfo."Post Code");
            AddField(CompanyInfo.City);
            AddField(CompanyInfo.County);
            AddField(Country2.Name);
            AddField(CompanyInfo."VAT Registration No.");
            AddField(CompanyInfo."Registration No.");
            AddField(CompanyInfo."Phone No.");
            AddField(CompanyInfo."Fax No.");
            AddField(CompanyInfo."Bank Branch No.");
            AddField(CompanyInfo."Bank Name");
            AddField(CompanyInfo."Bank Account No.");
            AddField(CompanyInfo."Giro No.");
        
            CASE TempDeliverySorter."Correspondence Type" OF
              TempDeliverySorter."Correspondence Type"::Fax:
                AddField(AttachmentManagement.InteractionFax(InteractLogEntry));
              TempDeliverySorter."Correspondence Type"::"E-Mail":
                AddField(AttachmentManagement.InteractionEMail(InteractLogEntry));
            END;
        
            WriteLine;
        
            Row := Row + 1;
            Window.UPDATE(4,ROUND(Row / NoOfRecords * 10000,1));
          END;
        
        UNTIL TempDeliverySorter.NEXT = 0;
        wrdMergefile.CloseFile;
        
        wrdDoc := wrdApp.Documents.Open2000(MainFileName);
        wrdDoc.MailMerge.MainDocumentType := 0;
        
        Window.UPDATE(6,Text013);
        ParamInt := 7; // 7 = HTML
        wrdDoc.MailMerge.OpenDataSource2000(MergeFileName,ParamInt);
        Window.UPDATE(6,STRSUBSTNO(Text014,TempDeliverySorter."Correspondence Type"));
        
        CASE TempDeliverySorter."Correspondence Type" OF
          TempDeliverySorter."Correspondence Type"::Fax:
            BEGIN
              wrdDoc.MailMerge.Destination := 3;
              wrdDoc.MailMerge.MailAddressFieldName := Text015;
              wrdDoc.MailMerge.MailAsAttachment := TRUE;
              wrdDoc.MailMerge.Execute;
            END;
          TempDeliverySorter."Correspondence Type"::"E-Mail":
            BEGIN
              wrdDoc.MailMerge.Destination := 2;
              wrdDoc.MailMerge.MailAddressFieldName := Text015;
              wrdDoc.MailMerge.MailSubject := TempDeliverySorter.Subject;
              wrdDoc.MailMerge.MailAsAttachment := TempDeliverySorter."Send Word Docs. as Attmt.";
              wrdDoc.MailMerge.Execute;
            END;
          TempDeliverySorter."Correspondence Type"::"Hard Copy":
            BEGIN
              wrdDoc.MailMerge.Destination := 0; // 0 = wdSendToNewDocument
              wrdDoc.MailMerge.Execute;
              wrdApp.ActiveDocument.PrintOut2000;
              ParamBln := FALSE;
              wrdApp.ActiveDocument.Close(ParamBln);
            END;
        END;
        
        // Update delivery status on Interaction Log Entry
        IF TempDeliverySorter.FIND('-') THEN BEGIN
          InteractLogEntry.LOCKTABLE;
          REPEAT
            WITH InteractLogEntry DO BEGIN
              GET(TempDeliverySorter."No.");
              "Delivery Status" := InteractLogEntry."Delivery Status"::" ";
              MODIFY;
            END;
          UNTIL TempDeliverySorter.NEXT = 0;
          COMMIT;
        END;
        
        ParamBln := FALSE;
        wrdDoc.Close(ParamBln);
        ERASE(MainFileName);
        ERASE(MergeFileName);
        
        CLEAR(wrdMergefile);
        CLEAR(wrdDoc);
         */

    end;


    procedure ShowMergedDocument(var SegLine: Record "Segment Line"; var Attachment: Record "Scheme Master for Apps"; WordCaption: Text[260]; IsTemporary: Boolean)
    var
        Salesperson: Record "Salesperson/Purchaser";
        Country: Record "Country/Region";
        Country2: Record "Country/Region";
        Contact: Record Contact;
        CompanyInfo: Record "Company Information";
        FormatAddr: Codeunit "Format Address";
        MergeFileName: Text[260];
        MainFileName: Text[260];
        ParamInt: Integer;
        ParamFalse: Boolean;
        ContAddr: array[8] of Text[50];
        ContAddr2: array[8] of Text[50];
        MultiAddress: array[2] of Text[260];
        I: Integer;
        IsInherited: Boolean;
    begin
        /*IF NOT AttachmentManagement.UseComServer(Attachment."File Extension",TRUE) THEN
          ERROR(STRSUBSTNO(Text010,Attachment.TABLECAPTION,Attachment."No.",
            Attachment.FIELDCAPTION("File Extension")));
        
        IF ISCLEAR(wrdApp) THEN
          CREATE(wrdApp);
        IF ISCLEAR(wrdMergefile) THEN
          CREATE(wrdMergefile);
        
        IF SegLine.AttachmentInherited THEN
          IsInherited := TRUE;
        
        // Handle Word documents without mergefields
        IF NOT DocContainMergefields(Attachment) THEN BEGIN
          MainFileName := ConstDocFilename;
          Attachment.ExportAttachment(MainFileName);
          ParamFalse := FALSE;
          wrdDoc := wrdApp.Documents.Open2000(MainFileName,ParamFalse,Attachment."Read Only");
          wrdDoc.ActiveWindow.Caption := WordCaption;
          wrdDoc.Saved := TRUE;
          wrdApp.Visible := TRUE;
          WordHandler(wrdDoc,Attachment,WordCaption,TRUE,MainFileName,IsInherited);
        END ELSE BEGIN
          // Merge possible
          MergeFileName := ConstMergeSourceFileName;
          IF ERASE(MergeFileName) THEN;
        
          CreateHeader(wrdMergefile,FALSE,MergeFileName);
          MainFileName := ConstDocFilename;
          IF NOT Attachment.ExportAttachment(MainFileName) THEN
            ERROR(Text011);
        
          Contact.GET(SegLine."Contact No.");
          CompanyInfo.GET;
          IF NOT Country2.GET(CompanyInfo."Country/Region Code") THEN
            CLEAR(Country2);
        
          IF NOT Country.GET(Contact."Country/Region Code") THEN
            CLEAR(Country);
          IF NOT Salesperson.GET(SegLine."Salesperson Code") THEN
            CLEAR(Salesperson);
        
          // Add mulitline fielddata
          I := 1;
          CLEAR(MultiAddress);
          FormatAddr.ContactAddrAlt(ContAddr,Contact,SegLine."Contact Alt. Address Code",SegLine.Date);
          wrdMergefile.NewMultiField;
          COPYARRAY(ContAddr2,ContAddr,1);
          COMPRESSARRAY(ContAddr2);
          WHILE ContAddr2[1] <> '' DO BEGIN
            IF ContAddr[I] <> '' THEN BEGIN
              wrdMergefile.AddMultiToField(ContAddr[I]);
              ContAddr2[1] := '';
              COMPRESSARRAY(ContAddr2);
            END ELSE
              wrdMergefile.AddMultiToField('&nbsp;');
            I := I + 1;
          END;
          wrdMergefile.EndMultiField;
        
          WITH wrdMergefile DO BEGIN
            AddField(Contact."No.");
            AddField(Contact."Company Name");
            AddField(Contact.Name);
            AddField(Contact."Name 2");
            AddField(Contact.Address);
            AddField(Contact."Address 2");
            AddField(Contact."Post Code");
            AddField(Contact.City);
            AddField(Contact.County);
            AddField(Country.Name);
            AddField(Contact."Job Title");
            AddField(Contact."Phone No.");
            AddField(Contact."Fax No.");
            AddField(Contact."E-Mail");
            AddField(Contact."Mobile Phone No.");
            AddField(Contact."VAT Registration No.");
            AddField(Contact."Home Page");
            AddField(Contact.GetSalutation(0,SegLine."Language Code"));
            AddField(Contact.GetSalutation(1,SegLine."Language Code"));
            AddField(Salesperson.Code);
            AddField(Salesperson.Name);
            AddField(Salesperson."Job Title");
            AddField(Salesperson."Phone No.");
            AddField(Salesperson."E-Mail");
            AddField(FORMAT(SegLine.Date));
            AddField(FORMAT(SegLine."Campaign No."));
            AddField(SegLine."Segment No.");
            AddField(SegLine.Description);
            AddField(SegLine.Subject);
            AddField(CompanyInfo.Name);
            AddField(CompanyInfo."Name 2");
            AddField(CompanyInfo.Address);
            AddField(CompanyInfo."Address 2");
            AddField(CompanyInfo."Post Code");
            AddField(CompanyInfo.City);
            AddField(CompanyInfo.County);
            AddField(Country2.Name);
            AddField(CompanyInfo."VAT Registration No.");
            AddField(CompanyInfo."Registration No.");
            AddField(CompanyInfo."Phone No.");
            AddField(CompanyInfo."Fax No.");
            AddField(CompanyInfo."Bank Branch No.");
            AddField(CompanyInfo."Bank Name");
            AddField(CompanyInfo."Bank Account No.");
            AddField(CompanyInfo."Giro No.");
            AddField('');
            WriteLine;
            CloseFile;
          END;
        
          ParamFalse := FALSE;
          wrdDoc := wrdApp.Documents.Open2000(MainFileName,ParamFalse,Attachment."Read Only");
          wrdDoc.MailMerge.MainDocumentType := 0;
          ParamInt := 7; // 7 = HTML
          wrdDoc.MailMerge.OpenDataSource2000(MergeFileName,ParamInt);
          ParamInt := 9999998; // 9999998 = wdToggle
          wrdDoc.MailMerge.ViewMailMergeFieldCodes(ParamInt);
          wrdDoc.ActiveWindow.Caption := WordCaption;
          wrdDoc.Saved := TRUE;
          wrdApp.Visible := TRUE;
        
          WordHandler(wrdDoc,Attachment,WordCaption,IsTemporary,MainFileName,IsInherited);
        END;
        
        CLEAR(wrdMergefile);
        CLEAR(wrdDoc);
        CLEAR(wrdApp);
        
        DeleteFile(MergeFileName);
         */

    end;

    local procedure CreateHeader(MergeFieldsOnly: Boolean; MergeFileName: Text[260])
    var
        Salesperson: Record "Salesperson/Purchaser";
        Country: Record "Country/Region";
        Contact: Record Contact;
        SegLine: Record "Segment Line";
        CompanyInfo: Record "Company Information";
        RMSetup: Record "Marketing Setup";
        I: Integer;
        MainLanguage: Integer;
        CreateOk: Boolean;
        Text001: Label 'Attaxhment File';
        Text002: Label 'This is a test file';
    begin
        /*CreateOk := TRUE;
        IF NOT wrdMergefile.CreateFile(MergeFileName) THEN
          ERROR(Text017+Text018);
         */
        // Create HTML Header source
        /*WITH wrdMergefile DO BEGIN
          MainLanguage := GLOBALLANGUAGE;
          RMSetup.GET;
          IF RMSetup."Mergefield Language ID" <> 0 THEN
            GLOBALLANGUAGE := RMSetup."Mergefield Language ID";
          AddField(Contact.TABLECAPTION + Text019);
          AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION(Contact."No."));
          AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION("Company Name"));
          AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION(Name));
          AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION("Name 2"));
          AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION(Address));
          AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION("Address 2"));
          AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION("Post Code"));
          AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION(City));
          AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION(County));
          AddField(Contact.TABLECAPTION + ' ' + Country.TABLECAPTION + ' ' + Country.FIELDCAPTION(Name));
          AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION("Job Title"));
          AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION("Phone No."));
          AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION("Fax No."));
          AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION("E-Mail"));
          AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION("Mobile Phone No."));
          AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION("VAT Registration No."));
          AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION("Home Page"));
          AddField(Text030);
          AddField(Text031);
          AddField(Salesperson.TABLECAPTION + ' ' + Salesperson.FIELDCAPTION(Code));
          AddField(Salesperson.TABLECAPTION + ' ' + Salesperson.FIELDCAPTION(Name));
          AddField(Salesperson.TABLECAPTION + ' ' + Salesperson.FIELDCAPTION("Job Title"));
          AddField(Salesperson.TABLECAPTION + ' ' + Salesperson.FIELDCAPTION("Phone No."));
          AddField(Salesperson.TABLECAPTION + ' ' + Salesperson.FIELDCAPTION("E-Mail"));
          AddField(Text020 + SegLine.FIELDCAPTION(Date));
          AddField(Text020 + SegLine.FIELDCAPTION("Campaign No."));
          AddField(Text020 + SegLine.FIELDCAPTION("Segment No."));
          AddField(Text020 + SegLine.FIELDCAPTION(Description));
          AddField(Text020 + SegLine.FIELDCAPTION(Subject));
          AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION(Name));
          AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Name 2"));
          AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION(Address));
          AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Address 2"));
          AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Post Code"));
          AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION(City));
          AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION(County));
          AddField(CompanyInfo.TABLECAPTION + ' ' + Country.TABLECAPTION + ' ' +
            Country.FIELDCAPTION(Name));
          AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("VAT Registration No."));
          AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Registration No."));
          AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Phone No."));
          AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Fax No."));
          AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Bank Branch No."));
          AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Bank Name"));
          AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Bank Account No."));
          AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Giro No."));
          GLOBALLANGUAGE := MainLanguage;
          AddField(Text015);
          WriteLine;
        */
        /*WITH wrdMergefile DO BEGIN
          AddField(Text001);
          AddField(Text002);
          WriteLine;
          // Mergesource must be at least two lines
          {IF MergeFieldsOnly THEN BEGIN
            FOR I := 1 TO 47 DO
              AddField('');
            WriteLine;
            CloseFile;
          END; }
          IF MergeFieldsOnly THEN BEGIN
            FOR I := 1 TO 2 DO
              AddField('');
            WriteLine;
            CloseFile;
          END;
        END;
         */

    end;


    procedure WordHandler(var AttachmentGet: Record "Scheme Master for Apps"; Caption: Text[260]; IsTemporary: Boolean; FileName: Text[260]; IsInherited: Boolean) DocImported: Boolean
    var
        Attachment2: Record "Scheme Master for Apps";
        NewFileName: Text[260];
        Attachment: Record "Scheme Master for Apps";
    begin

        /*
        CREATE(wrdHandler);
        NewFileName := wrdHandler.WaitForDocument(wrdDoc);
        
        IF NOT AttachmentGet."Read Only" THEN
          IF wrdHandler.DocIsClosed THEN
            IF wrdHandler.DocChanged THEN BEGIN
              CLEAR(wrdHandler);
              IF CONFIRM(Text021 + Caption +'?',TRUE) THEN BEGIN
                IF (NOT IsTemporary) AND Attachment2.GET(AttachmentGet."No.") THEN
                  IF Attachment2."Last Time Modified" <> AttachmentGet."Last Time Modified" THEN BEGIN
                    DeleteFile(FileName);
                    IF NewFileName <> FileName THEN
                      IF CONFIRM(
                        STRSUBSTNO(Text022,NewFileName), FALSE)
                      THEN
                        DeleteFile(NewFileName);
                    ERROR(
                      STRSUBSTNO(Text023+Text025,AttachmentGet.TABLECAPTION));
                  END;
          //      Attachment.ImportAttachment(NewFileName,IsTemporary,IsInherited);
                 Attachment.ImportAttachment(NewFileName,IsTemporary,TRUE,AttachmentGet);        // jb
                DeleteFile(NewFileName);
                DocImported := TRUE;
              END;
            END;
        
        IF NOT ISCLEAR(wrdHandler) THEN
          CLEAR(wrdHandler);
        
        DeleteFile(FileName);
         */

    end;


    /* procedure DeleteFile(FileName: Text[1024]) DeleteOk: Boolean
    var
        I: Integer;
    begin
        // Wait for Word to release files
        IF FileName = '' THEN
            EXIT(FALSE);

        IF NOT EXISTS(FileName) THEN
            EXIT(TRUE);

        REPEAT
            SLEEP(250);
            I := I + 1;
        UNTIL ERASE(FileName) OR (I = 25);
        EXIT(NOT EXISTS(FileName));
    end;
 */

    procedure ConstDocFilename() FileName: Text[260]
    var
        I: Integer;
        DocNo: Text[30];
    begin
        REPEAT
            IF I <> 0 THEN
                DocNo := FORMAT(I);
            // 15578  FileName := ENVIRON('TEMP') + Text027 + DocNo + '.DOC';
            /*  IF NOT EXISTS(FileName) THEN
                 EXIT;
             */
            I := I + 1;
        UNTIL I = 999;
    end;


    procedure ConstMergeSourceFileName() FileName: Text[260]
    var
        DocNo: Text[30];
        I: Integer;
    begin
        REPEAT
            IF I <> 0 THEN
                DocNo := FORMAT(I);
            // 15578   FileName := ENVIRON('TEMP') + Text029 + DocNo + '.HTM';
            /*  IF NOT EXISTS(FileName) THEN
                 EXIT;
             */
            I := I + 1;
        UNTIL I = 999;
    end;


    procedure DocContainMergefields(var Attachment: Record "Scheme Master for Apps") MergeFields: Boolean
    var
        //  [WithEvents]
        //  wrdApp: Automation;// 15578
        //  wrdDoc: Automation;// 15578
        ParamBln: Boolean;
        FileName: Text[260];
    begin
        /*IF ISCLEAR(wrdApp) THEN
          CREATE(wrdApp);
         
        IF UPPERCASE(Attachment."File Extension") <> 'DOC' THEN
            EXIT(FALSE);
        FileName := Attachment.ConstFileName;
        Attachment.ExportAttachment(FileName);
        // 15578  wrdDoc := wrdApp.Documents.Open2000(FileName);
        //  MergeFields := (wrdDoc.MailMerge.Fields.Count > 0);
        ParamBln := FALSE;
        //  wrdDoc.Close(ParamBln);
        ERASE(FileName);

        //  CLEAR(wrdDoc);
        //  CLEAR(wrdApp);//15578

        */

    end;
}

