tableextension 50214 tableextension50214 extends "FA Ledger Entry"
{
    fields
    {
        field(50000; "Tax Amount"; Decimal)
        {
        }
        field(50001; "Charges Amount"; Decimal)
        {
        }
    }




    //Unsupported feature: Code Modification on "MoveToFAJnl(PROCEDURE 2)".

    //procedure MoveToFAJnl();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    NextLineNo := FAJnlLine."Line No.";
    FAJnlLine."Line No." := 0;
    FAJnlLine.INIT;
    #4..19
    FAJnlLine."FA Reclassification Entry" := "Reclassification Entry";
    FAJnlLine."Index Entry" := "Index Entry";
    FAJnlLine."Line No." := NextLineNo;
    FAJnlLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
    FAJnlLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
    FAJnlLine."Dimension Set ID" := "Dimension Set ID";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..22
    FAJnlLine."Dimension Set ID" := "Dimension Set ID";
    */
    //end;
}

