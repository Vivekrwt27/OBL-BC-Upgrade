report 50206 "Dispatch Plan (Morbi)"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\DispatchPlanMorbi.rdl';

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

