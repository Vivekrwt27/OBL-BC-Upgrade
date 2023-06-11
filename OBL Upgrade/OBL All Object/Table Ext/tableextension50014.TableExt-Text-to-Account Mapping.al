tableextension 50014 tableextension50014 extends "Text-to-Account Mapping"
{

    //Unsupported feature: Code Modification on "InsertRec(PROCEDURE 1)".

    //procedure InsertRec();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF RecordMatchMgt.Trim(GenJnlLine.Description) <> '' THEN BEGIN
      TextToAccMapping.SETFILTER("Mapping Text",'%1','@' + RecordMatchMgt.Trim(GenJnlLine.Description));
      IF TextToAccMapping.FINDFIRST THEN
        COPY(TextToAccMapping)
      ELSE BEGIN
    #6..8

        INIT;
        "Line No." := LastLineNo + 10000;
        VALIDATE("Mapping Text",GenJnlLine.Description);
        SetBalSourceType(GenJnlLine);
        IF "Bal. Source Type" <> "Bal. Source Type"::"G/L Account" THEN
          "Bal. Source No." := GenJnlLine."Account No."
        ELSE BEGIN
          "Debit Acc. No." := GenJnlLine."Account No.";
          "Credit Acc. No." := GenJnlLine."Account No.";
        END;

        IF "Mapping Text" <> '' THEN
          INSERT;
      END;

      RESET;
    END;

    PAGE.RUN(PAGE::"Text-to-Account Mapping",Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF RecordMatchMgt.Trim(GenJnlLine.Narration) <> '' THEN BEGIN
      TextToAccMapping.SETFILTER("Mapping Text",'%1','@' + RecordMatchMgt.Trim(GenJnlLine.Narration));
    #3..11
        VALIDATE("Mapping Text",GenJnlLine.Narration);
    #13..19
    #21..28
    */
    //end;
}

