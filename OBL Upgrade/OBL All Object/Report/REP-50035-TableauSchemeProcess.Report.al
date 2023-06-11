report 50035 "Tableau Scheme Process"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\TableauSchemeProcess.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Customer Scheme Details"; 50078)
        {

            trigger OnAfterGetRecord()
            var
                SchemeMaster: Record "Scheme Master";
            begin
                "Customer Scheme Details".CALCFIELDS("Target Achieved - HVP");
                "Customer Scheme Details".CALCFIELDS("Target Achieved - Non-HVP");
                "Customer Scheme Details".CALCFIELDS("Total Target Achieved");
                "Customer Scheme Details".CALCFIELDS("Total Turnover");
                "Customer Scheme Details"."Tableau Target Achieved - HVP" := "Customer Scheme Details"."Target Achieved - HVP";
                "Customer Scheme Details"."Tableau Target Achieved-NonHVP" := "Customer Scheme Details"."Target Achieved - Non-HVP";
                "Customer Scheme Details"."Tableau Total Target Achieved" := "Customer Scheme Details"."Total Target Achieved";
                "Customer Scheme Details"."Tableau Total Turnover" := "Customer Scheme Details"."Total Turnover";

                IF SchemeMaster.GET("Customer Scheme Details"."Scheme Code") THEN;
                Cust.GET("Customer Scheme Details"."Customer No.");
                Area := Cust."Area Code";

                Cust.CALCFIELDS(Cust."Balance (LCY)");
                "Customer Scheme Details".Outstanding := Cust."Balance (LCY)";
                // "Customer Scheme Details"."Over Due" := SchemeStatus.CalculateOverDueBalance("Customer Scheme Details"."Customer No.", TODAY);
                // "Customer Scheme Details"."Pending Invoice" := SchemeStatus.CalculatePendingInvoice("Customer Scheme Details"."Customer No.", SchemeMaster."Pending Invoice Dates");

                MODIFY;
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

    var
        Cust: Record Customer;
        SchemeStatus: Report "Sales Journal Processing Rep";
}

