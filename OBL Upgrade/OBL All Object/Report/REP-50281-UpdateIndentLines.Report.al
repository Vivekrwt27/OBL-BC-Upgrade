report 50281 "Update Indent Lines"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\UpdateIndentLines.rdl';

    dataset
    {
        dataitem("Indent Header"; "Indent Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                IndentLine.RESET;
                IndentLine.SETRANGE(IndentLine."Document No.", "No.");
                IF IndentLine.FINDSET THEN
                    REPEAT
                        IF IndentLine.Type <> IndentLine.Type::" " THEN BEGIN
                            IndentLine.VALIDATE(Status, "Indent Header".Status);
                            IndentLine.MODIFY;
                        END;
                    UNTIL IndentLine.NEXT = 0;
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

    var
        IndentLine: Record "Indent Line";
}

