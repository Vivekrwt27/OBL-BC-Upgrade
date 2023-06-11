report 50070 "Bank Reconciliation Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\BankReconciliationStatement.rdl';

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

