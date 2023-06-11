report 50205 kbs
{
    //DefaultLayout = RDLC;
    ProcessingOnly = true;
    //RDLCLayout = '.\ReportLayouts\kbs.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = WHERE("GST Registration No." = FILTER(<> ''));

            trigger OnAfterGetRecord()
            begin
                Customer.GenerateNODNOCData();
                MODIFY;
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
}