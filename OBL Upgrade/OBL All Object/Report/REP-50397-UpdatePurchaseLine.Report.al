report 50397 "Update Purchase Line"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\UpdatePurchaseLine.rdl';

    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
        {
            RequestFilterFields = "Document No.";

            trigger OnAfterGetRecord()
            begin
                "Qty. Rcd. Not Invoiced" := 0;
                "Qty. Rcd. Not Invoiced (Base)" := 0;
                IF "Quantity Received" <= "Quantity Invoiced" THEN BEGIN
                    "Quantity Invoiced" := "Quantity Received";
                    "Qty. Invoiced (Base)" := "Qty. Received (Base)";
                END;
                MODIFY;
            end;

            trigger OnPreDataItem()
            begin
                ERROR('');
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
}

