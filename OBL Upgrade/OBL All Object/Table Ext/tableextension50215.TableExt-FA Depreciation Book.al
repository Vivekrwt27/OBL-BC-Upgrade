tableextension 50215 tableextension50215 extends "FA Depreciation Book"
{

    //Unsupported feature: Code Modification on "SetBookValueAfterDisposalFiltersOnFALedgerEntry(PROCEDURE 18)".

    //procedure SetBookValueAfterDisposalFiltersOnFALedgerEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetBookValueFiltersOnFALedgerEntry(FALedgEntry);
    FALedgEntry.SETRANGE("Part of Book Value");
    IF GETFILTER("FA Posting Date Filter") <> '' THEN
      FALedgEntry.SETFILTER("FA Posting Date",GETFILTER("FA Posting Date Filter"));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetBookValueFiltersOnFALedgerEntry(FALedgEntry);
    FALedgEntry.SETRANGE("Part of Book Value");
    FALedgEntry.SETRANGE("FA Posting Category",FALedgEntry."FA Posting Category"::Disposal);
    FALedgEntry.SETRANGE("FA Posting Type",FALedgEntry."FA Posting Type"::"Book Value on Disposal");
    IF GETFILTER("FA Posting Date Filter") <> '' THEN
      FALedgEntry.SETFILTER("FA Posting Date",GETFILTER("FA Posting Date Filter"));
    */
    //end;
}

