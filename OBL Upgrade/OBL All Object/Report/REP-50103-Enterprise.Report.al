report 50103 Enterprise
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\Enterprise.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = WHERE("Customer Type" = FILTER('CKA|DIRECTPROJ'));
            RequestFilterFields = "No.", "Salesperson Code";
            column(SalesPers; Customer."Salesperson Code")
            {
            }
            column(SalesPerName; SalespersonPurchaser.Name)
            {
            }
            column(AchvmntCKA; AchvmntCKA)
            {
            }
            column(StartDt; StartDt)
            {
            }

            trigger OnAfterGetRecord()
            begin
                AchvmntCKA := 0;
                CLEAR(SalesJournalData);
                SalesJournalData.SETRANGE(SalesJournalData.CustomerNo, "No.");
                SalesJournalData.SETRANGE(PostingDateFilter, StartDt, EndDt);
                SalesJournalData.SETFILTER(CustomerType, '<>%1&<>%2&<>%3', 'GET', 'PET', 'SET');
                SalesJournalData.OPEN;

                WHILE SalesJournalData.READ DO BEGIN
                    AchvmntCKA += SalesJournalData.LineAmount;
                END;

                IF SalespersonPurchaser.GET(Customer."Salesperson Code") THEN;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field("Start Date"; StartDt)
                {
                    ApplicationArea = All;
                }
                field("End Date"; EndDt)
                {
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SalesJournalData: Query "Sales Journal Data";
        StartDt: Date;
        EndDt: Date;
        AchvmntCKA: Decimal;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
}

