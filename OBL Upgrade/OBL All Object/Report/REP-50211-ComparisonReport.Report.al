report 50211 "Comparison Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\ComparisonReport.rdl';

    dataset
    {
        dataitem("Sales Header"; 36)
        {
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

