report 50289 "Transfer Order Location Change"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\TransferOrderLocationChange.rdl';

    dataset
    {
        dataitem("Transfer Header"; "Transfer Header")
        {

            trigger OnAfterGetRecord()
            begin

                "Transfer Header"."Transfer-to Code" := 'DRA-STORE';
                MODIFY;
                recTL.RESET;
                recTL.SETRANGE(recTL."Document No.", "No.");
                IF recTL.FINDFIRST THEN BEGIN
                    REPEAT
                        recTL."Transfer-to Code" := 'DRA-STORE';
                        recTL.MODIFY;
                    UNTIL recTL.NEXT = 0;
                END;
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('Done');
            end;

            trigger OnPreDataItem()
            begin

                IF GETFILTER("No.") = '' THEN
                    ERROR('please Select the Trf No.');
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
        recTL: Record "Transfer Line";
        RepAuditMgt: Codeunit "Auto PDF Generate";
}

