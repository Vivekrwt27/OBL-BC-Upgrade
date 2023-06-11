codeunit 50038 "Scheme Job Queue"
{

    trigger OnRun()
    var
        SchemeMaster: Record "Scheme Master";
    begin
        SchemeMaster.RESET;
        //SchemeMaster.sETRANGE();
        IF SchemeMaster.FINDFIRST THEN
            REPEAT
                IF SchemeApplicable(SchemeMaster.Code, TODAY) THEN BEGIN
                    //15578    SendSchemeSMS.ApplySchemeFilters(SchemeMaster.Code);
                    SendSchemeSMS.USEREQUESTPAGE(FALSE);
                    SendSchemeSMS.RUN;
                END;
            UNTIL SchemeMaster.NEXT = 0;
    end;

    var
        SendSchemeSMS: Report "TCS Collection Report";


    procedure SchemeApplicable(SchemeCode: Code[20]; DtDate: Date): Boolean
    var
        SchemeMas: Record "Scheme Master";
    begin
        SchemeMas.RESET;
        SchemeMas.SETFILTER(Code, '%1', SchemeCode);
        SchemeMas.SETFILTER("Scheme Start Date", '<=%1', DtDate);
        SchemeMas.SETFILTER("Scheme End Date", '>=%1', DtDate);
        IF SchemeMas.FINDFIRST THEN
            EXIT(TRUE) ELSE
            EXIT(FALSE);
    end;
}

