report 50325 "Feedback form"
{
    RDLCLayout = '.\ReportLayouts\Feedbackform.rdl';
    DefaultLayout = RDLC;
    PaperSourceDefaultPage = ManualFeed;
    PaperSourceFirstPage = ManualFeed;
    PaperSourceLastPage = ManualFeed;
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            column(Inv_no; "Sales Invoice Header"."No.")
            {
            }
            column(Inv_qty; "Sales Invoice Header"."Qty In carton")
            {
            }
            column(Inv_date; "Sales Invoice Header"."Posting Date")
            {
            }
            column(TPT_Name; "Sales Invoice Header"."Transporter Name")
            {
            }
            column(gr_no; "Sales Invoice Header"."GR No.")
            {
            }
            column(Truck_no; "Sales Invoice Header"."Truck No.")
            {
            }
            column(GR_date; "Sales Invoice Header"."GR Date")
            {
            }
            column(Cust_Name; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(Cust_City; "Sales Invoice Header"."Sell-to City")
            {
            }
            column(State_name; "Sales Invoice Header"."State name")
            {
            }
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

