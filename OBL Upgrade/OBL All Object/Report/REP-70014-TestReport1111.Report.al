report 70014 "Test Report1111"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\TestReport1111.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Header"; 36)
        {
            RequestFilterFields = "Order Date", "Releasing Date", "Posting Date", "Payment Date 3", "Location Code", "Make Order Date", Status;
            column(No_SalesInvoiceHeader; "No.")
            {
            }
            dataitem("Sales Line"; 37)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE("Item Category Code" = FILTER('M001|T001|D001|H001'));
                column(LocationCode; "Location Code")
                {
                }
                column(OutstandingQtyBase; "Sales Line"."Outstanding Qty. (Base)")
                {
                }
                column(OutstandingAMt; "Sales Line"."Outstanding Amount" / 100000)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                IF ("Sales Header"."Location Code" = 'DP-MORBI') AND ("Sales Header"."Location Code" = 'DP-BIKANER') THEN
                    CurrReport.SKIP;
            end;
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

