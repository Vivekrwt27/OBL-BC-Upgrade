codeunit 50028 "Auto PDF Generate"
{

    trigger OnRun()
    var
        CdReportMail: Codeunit "Report Mail Utility";
    begin

        //REPORT.RUN(50181,FALSE,FALSE);

        CLEAR(CdReportMail);
        CdReportMail.GEneratePDFsGST;
    end;

    var
        EmailUtility: Codeunit "Report Mail Utility";
}

