tableextension 50016 tableextension50016 extends "Incoming Document"
{

    //Unsupported feature: Code Modification on "CreateGenJnlLine(PROCEDURE 5)".

    //procedure CreateGenJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Document Type" <> "Document Type"::Journal THEN
      TestIfAlreadyExists;
    TestReadyForProcessing;
    #4..26
    GenJnlLine."Line No." := LineNo;
    GenJnlLine.SetUpNewLine(LastGenJnlLine,0,TRUE);
    GenJnlLine."Incoming Document Entry No." := "Entry No.";
    GenJnlLine.Description := COPYSTR(Description,1,MAXSTRLEN(GenJnlLine.Description));

    IF GenJnlLine.INSERT(TRUE) THEN
      OnAfterCreateGenJnlLineFromIncomingDocSuccess(Rec)
    #34..39
      GenJnlLine.ADDLINK(GetURL,Description);

    ShowNAVRecord;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..29
    GenJnlLine.Narration := COPYSTR(Description,1,MAXSTRLEN(GenJnlLine.Narration));
    GenJnlLine.INSERT(TRUE);
    GenJnlLine.Narration := COPYSTR(Description,1,MAXSTRLEN(GenJnlLine.Narration));
    #31..42
    */
    //end;
}

