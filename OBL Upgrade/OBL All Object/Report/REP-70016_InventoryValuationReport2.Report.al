report 70016 "Inventory Valuation Report-2"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\InventoryValuationReport2.rdl';

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

