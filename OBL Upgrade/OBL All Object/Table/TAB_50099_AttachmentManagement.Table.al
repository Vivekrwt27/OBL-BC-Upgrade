table 50099 "Attachment Management"
{

    fields
    {
        field(1; "Primary Key"; RecordID)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Attachment; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Extension; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "File Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Creation Datetime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Table ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Doc Type"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Document Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
        key(Key2; "Table ID", "Doc Type", "Document No.", "Document Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        FileName: Text[1024];
        ServerFileName: Text[1024];
        FileMgmt: Codeunit "File Management";
        ExtensionStart: Integer;
        //TempBlob: Record 99008535;//16225 TABLE REMOVE
        Txt001: Label 'Do you want to overwrite existing Attachment ?';
        Txt002: Label 'Import Attachment.';
        Txt003: Label 'Update Attachment.';
        Txt004: Label 'No Attachment In Current Document.';
        Txt005: Label 'Attachment File ''''%1'''' imported successfully.';
        Txt006: Label 'Do you want to delete the Attachment In %1?';
        Txt007: Label 'Attachment already exist with this document';

    procedure ImportAttachment(RecIDToImport: RecordID; TabID: Integer; DocType: Integer; DocNo: Code[20]; DocLineNo: Integer)
    var
        AttachRecordRef: RecordRef;
    begin
        IF RecordExist(RecIDToImport) THEN
            EXIT;

        INIT;
        "Primary Key" := RecIDToImport;
        "Table ID" := TabID;
        "Doc Type" := DocType;
        "Document No." := DocNo;
        "Document Line No." := DocLineNo;
        //FileName := FileMgmt.BLOBImportWithFilter(TempBlob, Txt002, '', '*.*|', '*.*');//16225 TABLE N/F


        IF FileName = '' THEN
            EXIT;
        FileName := FileMgmt.GetFileName(FileName);

        "File Name" := FileName;
        // Attachment := TempBlob.Blob;//16225 TABLE N/F

        Extension := '.' + FileMgmt.GetExtension(FileName);
        "Creation Datetime" := CURRENTDATETIME;
        "Created By" := USERID;
        INSERT;

        IF Attachment.HASVALUE THEN
            MESSAGE(Txt005, "File Name");
    end;

    procedure ExportAttachment(RecIDToExport: RecordID)
    var
        FileName: Text[1024];
        ServerFileName: Text[1024];
        FileMgmt: Codeunit "File Management";
    begin
        SETRANGE("Primary Key", RecIDToExport);
        IF NOT FINDFIRST THEN
            ERROR(Txt004);

        CALCFIELDS(Attachment);

        IF NOT Attachment.HASVALUE THEN
            ERROR(Txt004);

        // TempBlob.Blob := Attachment;//16225 TABLE N/F
        //  FileMgmt.BLOBExport(TempBlob, FORMAT('*' + Extension + ''), TRUE); //16225 TABLE N/F
    end;

    procedure UpdateAttachment(var RecIDToUpdate: RecordID)
    begin
        CALCFIELDS(Attachment);
        ERROR(Txt007);

        /*
        IF NOT CONFIRM(Txt001) THEN
          EXIT;
        
        FileName := FileMgmt.BLOBImportWithFilter(TempBlob,Txt002,'','*.*|','*.*');
        
        IF FileName = '' THEN
          EXIT;
        
        Attachment := TempBlob.Blob;
        Extension := '.' + FileMgmt.GetExtension(FileName);
        
        MODIFY;
        
        IF Attachment.HASVALUE THEN
          MESSAGE(Txt005,FileName);
        */

    end;

    procedure DeleteAttachment(RecIDToDelete: RecordID)
    begin
        SETRANGE("Primary Key", RecIDToDelete);
        IF NOT FINDFIRST THEN
            ERROR(Txt004);

        CALCFIELDS(Attachment);

        IF Attachment.HASVALUE THEN
            IF CONFIRM(Txt006, FALSE, RecIDToDelete) THEN
                DELETE;
    end;

    procedure RecordExist(RecIDToCheck: RecordID): Boolean
    begin
        SETRANGE("Primary Key", RecIDToCheck);
        IF NOT FINDFIRST THEN
            EXIT(FALSE);

        UpdateAttachment(RecIDToCheck);
        EXIT(TRUE);
    end;

    procedure AttachmentExist(RecIDToCheck: RecordID): Boolean
    begin
        SETRANGE("Primary Key", RecIDToCheck);
        IF NOT FINDFIRST THEN
            EXIT(FALSE) ELSE
            EXIT(TRUE);
    end;

    procedure ExportAttachmentAsFile(RecIDToCheck: RecordID; var FilePath: Text; var FileName: Text): Boolean
    var
        FileMgt: Codeunit "File Management";
        TempSubDirPath: Text;
        AttachmentFileFullName: Text;
        TempFileFullName: Text;
        Attachment1: Record "Attachment Management";
        ExpAttachment: Record Attachment;
        ExportToFile: Text;
        tempblobCU: Codeunit "Temp Blob";
    //TempBlob: Record 99008535;//16225 REMOVE TABLE
    begin
        CLEAR(FileMgt);
        Attachment1.SETRANGE("Primary Key", RecIDToCheck);
        IF Attachment1.FINDFIRST THEN BEGIN
            Attachment1.TESTFIELD(Extension);
            Attachment1.CALCFIELDS(Attachment);

            //16225 TABLE N/F START
            /*IF ExportToFile = '' THEN
                ExportToFile := TEMPORARYPATH + FileMgt.GetFileName(Attachment1."File Name");
            TempBlob.Blob := Attachment1.Attachment;

            FileMgmt.DeleteServerFile(ExportToFile);
            FileMgmt.BLOBExportToServerFile(TempBlob, ExportToFile);

            //ExpAttachment.ExportAttachmentToClientFile(TempFileFullName);
            FilePath := TEMPORARYPATH;*/
            //16225 TABLE N/F END
            FileName := Attachment1."File Name";
            //FileMgt.CopyServerFile(ExportToFile,ExportToFile,FALSE); // Copy from server location to another location (UNC location also)
            EXIT(ExportToFile <> '');
        END;
        /*
        IF Attachment.Attachment.HASVALUE THEN BEGIN
          // Export the attachment to the client TEMP directory, giving it a GUID
          TempFileFullName := FileMgt.ClientTempFileName('');
          ExpAttachment.ExportAttachmentToClientFile(TempFileFullName);
          // Create a temporary subdirectory of the TEMP directory. Move the file to the subdirectory and give it the correct name.
          TempSubDirPath := FileMgt.CreateClientTempSubDirectory;
          AttachmentFileFullName := FileMgt.CombinePath(TempSubDirPath,Attachment."File Name" + '.' + Attachment.Extension);
          FileMgt.MoveFile(TempFileFullName,AttachmentFileFullName);
          EXIT(TempFileFullName);
        END;
        END;
        */

    end;
}

