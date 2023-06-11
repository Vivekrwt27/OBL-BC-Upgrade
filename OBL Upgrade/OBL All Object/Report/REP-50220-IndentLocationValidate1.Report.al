report 50220 "Indent Location Validate1"
{
    // DefaultLayout = RDLC;
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    // RDLCLayout = '.\ReportLayouts\IndentLocationValidate1.rdl';

    dataset
    {
        dataitem("Indent Header"; "Indent Header")
        {

            trigger OnAfterGetRecord()
            begin
                IndentLine.RESET;
                IndentLine.SETRANGE("Document No.", "No.");
                IF IndentLine.FINDFIRST THEN BEGIN
                    REPEAT
                        IndentLine."Location Code" := "Location Code";
                        IndentLine.MODIFY;
                    UNTIL IndentLine.NEXT = 0;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        MESSAGE('Done');
    end;

    var
        IndentLine: Record "Indent Line";
}

