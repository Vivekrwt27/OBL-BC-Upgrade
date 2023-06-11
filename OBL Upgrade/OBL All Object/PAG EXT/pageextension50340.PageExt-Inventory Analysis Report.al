pageextension 50340 pageextension50340 extends "Inventory Analysis Report"
{

    //Unsupported feature: Code Modification on "SetPointsAnalysisColumn(PROCEDURE 22)".

    //procedure SetPointsAnalysisColumn();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    AnalysisColumn2.SETRANGE("Analysis Area",AnalysisColumn2."Analysis Area"::Inventory);
    AnalysisColumn2.SETRANGE("Analysis Column Template",CurrentColumnTemplate);

    IF (Direction = Direction::Forward) OR
       (FirstColumn = '')
    THEN BEGIN
      IF LastColumn = '' THEN BEGIN
        AnalysisColumn2.FIND('-');
        tmpFirstColumn := AnalysisColumn2."Column Header";
        tmpFirstLineNo := AnalysisColumn2."Line No.";
        AnalysisColumn2.NEXT(NoOfColumns - 1);
        tmpLastColumn := AnalysisColumn2."Column Header";
        tmpLastLineNo := AnalysisColumn2."Line No.";
      END ELSE BEGIN
        IF AnalysisColumn2.GET(AnalysisColumn2."Analysis Area"::Inventory,CurrentColumnTemplate,LastLineNo) THEN;
        AnalysisColumn2.NEXT(1);
        tmpFirstColumn := AnalysisColumn2."Column Header";
        tmpFirstLineNo := AnalysisColumn2."Line No.";
        AnalysisColumn2.NEXT(NoOfColumns - 1);
        tmpLastColumn := AnalysisColumn2."Column Header";
        tmpLastLineNo := AnalysisColumn2."Line No.";
      END;
    END ELSE BEGIN
      IF AnalysisColumn2.GET(AnalysisColumn2."Analysis Area"::Inventory,CurrentColumnTemplate,FirstLineNo) THEN;
      AnalysisColumn2.NEXT(-1);
      tmpLastColumn := AnalysisColumn2."Column Header";
      tmpLastLineNo := AnalysisColumn2."Line No.";
      AnalysisColumn2.NEXT(-NoOfColumns + 1);
      tmpFirstColumn := AnalysisColumn2."Column Header";
      tmpFirstLineNo := AnalysisColumn2."Line No.";
    END;

    #33..38
    LastColumn := tmpLastColumn;
    FirstLineNo := tmpFirstLineNo;
    LastLineNo := tmpLastLineNo;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
        tmpFirstColumn := AnalysisColumn2."Column No.";
        tmpFirstLineNo := AnalysisColumn2."Line No.";
        AnalysisColumn2.NEXT(NoOfColumns - 1);
        tmpLastColumn := AnalysisColumn2."Column No.";
    #13..16
        tmpFirstColumn := AnalysisColumn2."Column No.";
        tmpFirstLineNo := AnalysisColumn2."Line No.";
        AnalysisColumn2.NEXT(NoOfColumns - 1);
        tmpLastColumn := AnalysisColumn2."Column No.";
    #21..25
      tmpLastColumn := AnalysisColumn2."Column No.";
      tmpLastLineNo := AnalysisColumn2."Line No.";
      AnalysisColumn2.NEXT(-NoOfColumns + 1);
      tmpFirstColumn := AnalysisColumn2."Column No.";
    #30..41
    */
    //end;


    //Unsupported feature: Code Modification on "FillMatrixColumns(PROCEDURE 8)".

    //procedure FillMatrixColumns();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    AnalysisColumn2.SETRANGE("Analysis Area",AnalysisColumn2."Analysis Area"::Inventory);
    AnalysisColumn2.SETRANGE("Analysis Column Template",CurrentColumnTemplate);
    AnalysisColumn2.SETRANGE("Line No.",FirstLineNo,LastLineNo);
    AnalysisColumn2.SETFILTER(Show,'<>%1',AnalysisColumn2.Show::Never);
    i := 1;

    IF AnalysisColumn2.FIND('-') THEN
      REPEAT
        MatrixColumnCaptions[i] := AnalysisColumn2."Column Header";
        i := i + 1;
      UNTIL (AnalysisColumn2.NEXT = 0) OR (i > ARRAYLEN(MatrixColumnCaptions));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    #5..11
    */
    //end;
}

