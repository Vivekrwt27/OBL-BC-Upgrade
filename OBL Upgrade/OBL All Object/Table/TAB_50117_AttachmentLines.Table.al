table 50117 "Attachment Lines"
{

    fields
    {
        field(5; "Table ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Source Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Source Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Source Record ID"; RecordID)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Primary Record ID"; RecordID)
        {
            DataClassification = ToBeClassified;
        }
        field(30; Attachment; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(40; Extension; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50; "File Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Creation Datetime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(80; Content; Blob)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Table ID", "Source Document No.", "Source Line No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        FileMgmt: Codeunit "File Management";

    procedure ExportAttachmentAsFile(RecIDToCheck: RecordID; var FilePath: Text; var FileName: Text): Boolean
    var
        FileMgt: Codeunit "File Management";
        TempSubDirPath: Text;
        AttachmentFileFullName: Text;
        TempFileFullName: Text;
        Attachment1: Record "Attachment Lines";
        ExpAttachment: Record Attachment;
        ExportToFile: Text;
    // TempBlob: Record 99008535; //16225 REMOVE RECORD TABLE
    begin
        CLEAR(FileMgt);
        Attachment1.SETRANGE("Primary Record ID", RecIDToCheck);
        IF Attachment1.FINDFIRST THEN BEGIN
            Attachment1.TESTFIELD(Extension);
            Attachment1.CALCFIELDS(Attachment);
            //16225 TEMP BLOB TABLE N/F START
            /*IF ExportToFile = '' THEN
                ExportToFile := TEMPORARYPATH + FileMgt.GetFileName(Attachment1."File Name");
            TempBlob.Blob := Attachment1.Attachment;

            FileMgmt.DeleteServerFile(ExportToFile);
            FileMgmt.BLOBExportToServerFile(TempBlob, ExportToFile);

            //ExpAttachment.ExportAttachmentToClientFile(TempFileFullName);
            FilePath := TEMPORARYPATH;*/
            //16225 TEMP BLOB TABLE N/F END
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

