tableextension 50180 tableextension50180 extends "Excel Buffer"
{

    //Unsupported feature: Code Modification on "CreateBook(PROCEDURE 1)".

    //procedure CreateBook();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF SheetName = '' THEN
      ERROR(Text002);

    IF FileName = '' THEN
      FileNameServer := FileManagement.ServerTempFileName('xlsx')
    ELSE BEGIN
      IF EXISTS(FileName) THEN
        ERASE(FileName);
      FileNameServer := FileName;
    END;

    XlWrkBkWriter := XlWrkBkWriter.Create(FileNameServer);
    IF ISNULL(XlWrkBkWriter) THEN
      ERROR(Text037);
    #15..17
      XlWrkShtWriter.Name := SheetName;
      ActiveSheetName := SheetName;
    END
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
        FileNameServer := FileName;
    END;

    FileNameServer := FileManagement.ServerTempFileName('xlsx');//MSVRN 170418 >><<
    #12..20
    */
    //end;


    //Unsupported feature: Code Modification on "OpenBook(PROCEDURE 2)".

    //procedure OpenBook();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF FileName = '' THEN
      ERROR(Text001);

    IF SheetName = '' THEN
      ERROR(Text002);

    XlWrkBkReader := XlWrkBkReader.Open(FileName);
    IF XlWrkBkReader.HasWorksheet(SheetName) THEN BEGIN
      XlWrkShtReader := XlWrkBkReader.GetWorksheetByName(SheetName);
    END ELSE BEGIN
      QuitExcel;
      ERROR(Text004,SheetName);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3

    #4..6
    XlWrkBkReader := XlWrkBkReader.Open(FileName + '.xlsx');
    #8..13
    */
    //end;

    /*procedure OpenBookNew(FileName: Text; SheetName: Text[250])
    begin
        IF FileName = '' THEN
            ERROR(Text001);

        IF SheetName = '' THEN
            ERROR(Text002);

        XlWrkBkReader := XlWrkBkReader.Open(FileName);
        IF XlWrkBkReader.HasWorksheet(SheetName) THEN BEGIN
            XlWrkShtReader := XlWrkBkReader.GetWorksheetByName(SheetName);
        END ELSE BEGIN
            QuitExcel;
            ERROR(Text004, SheetName);
        END;
    end;

    var

        Text001: Label 'You must enter a file name.';
        Text004: Label 'The Excel worksheet %1 does not exist.';
        Text002: Label 'You must enter an Excel worksheet name.';
        XlWrkBkReader: DotNet;
        XlWrkShtReader: DotNet;*/// 15578
}

