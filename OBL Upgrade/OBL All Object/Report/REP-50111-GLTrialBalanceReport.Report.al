report 50111 "G/L Trial Balance Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\GLTrialBalanceReport.rdl';

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

