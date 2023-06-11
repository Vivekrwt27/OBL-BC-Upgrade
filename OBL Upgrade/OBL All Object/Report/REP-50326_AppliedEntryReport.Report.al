report 50326 "Applied Entry Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\AppliedEntryReport.rdl';

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

