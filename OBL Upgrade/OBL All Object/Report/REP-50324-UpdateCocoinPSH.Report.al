report 50324 "Update Coco in PSH"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\UpdateCocoinPSH.rdl';
    Permissions = TableData "Sales Invoice Header" = rimd;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = WHERE("Coco Customer" = CONST(true));
            RequestFilterFields = "No.";
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemLink = "Sell-to Customer No." = FIELD("No.");

                trigger OnAfterGetRecord()
                begin
                    "Sales Invoice Header".COCO := TRUE;
                    "Sales Invoice Header".MODIFY;
                end;

                trigger OnPostDataItem()
                begin
                    MESSAGE('Done');
                end;
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

