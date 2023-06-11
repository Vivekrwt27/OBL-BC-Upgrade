report 70015 "Internal Stock Transfer"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\InternalStockTransfer.rdl';

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

