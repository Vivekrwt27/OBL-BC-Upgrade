report 50195 "Update Sales Inv. Cust. Name"
{
    Permissions = TableData "Sales Invoice Header" = rimd;
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Customer; 18)
        {
            RequestFilterFields = "No.";
            dataitem("Sales Invoice Header"; 112)
            {
                DataItemLink = "Sell-to Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Sell-to Customer No.", "Posting Date");
                RequestFilterFields = "Sell-to Customer No.";

                trigger OnAfterGetRecord()
                begin
                    "Sales Invoice Header"."Sell-to Customer Name" := Customer.Name;
                    "Sales Invoice Header"."Bill-to Name" := Customer.Name;
                    MODIFY;
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

    trigger OnPostReport()
    begin
        MESSAGE('Processed');
    end;
}

