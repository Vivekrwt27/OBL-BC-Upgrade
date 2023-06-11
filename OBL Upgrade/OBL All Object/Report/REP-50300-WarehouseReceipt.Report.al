report 50300 "Warehouse Receipt"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\WarehouseReceipt.rdl';

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

