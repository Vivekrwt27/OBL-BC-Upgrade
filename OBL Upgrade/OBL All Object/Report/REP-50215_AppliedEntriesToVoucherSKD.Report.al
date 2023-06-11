report 50215 "Applied Entries To Voucher SKD"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\AppliedEntriesToVoucherSKD.rdlc';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
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

