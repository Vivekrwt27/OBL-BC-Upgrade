report 50178 "Depot Inoice Main"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\DepotInoiceMain.rdlc';

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

