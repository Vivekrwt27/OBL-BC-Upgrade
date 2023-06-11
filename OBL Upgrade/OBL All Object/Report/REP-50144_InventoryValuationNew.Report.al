report 50144 "Inventory Valuation New"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\InventoryValuationNew.rdl';

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

