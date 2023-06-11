report 50310 "Validate SMS Details"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    ProcessingOnly = true;
    // RDLCLayout = '.\ReportLayouts\ValidateSMSDetails.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {

            trigger OnAfterGetRecord()
            begin
                if SalesPur.GET("Phone No.") THEN
                    IF SalesPur.Status = SalesPur.Status::Enable THEN
                        "Phone No." := SalesPur."Phone No.";
                VALIDATE("Phone No.");

                IF SalesPur.GET("Salesperson Code") THEN
                    IF SalesPur.Status = SalesPur.Status::Enable THEN
                        VALIDATE("Salesperson Code");

                IF SalesPur1.GET("PCH Code") THEN
                    IF SalesPur1.Status = SalesPur1.Status::Enable THEN begin
                        "PCH Name" := SalesPur1.Name;
                        "PCH E-Maill ID" := SalesPur1."E-Mail";
                        VALIDATE("PCH Code");
                    end;

                IF SalesPur1.GET("Govt. SP Resp.") THEN
                    IF SalesPur1.Status = SalesPur1.Status::Enable THEN
                        VALIDATE("Govt. SP Resp.");

                IF SalesPur1.GET("Private SP Resp.") THEN
                    IF SalesPur1.Status = SalesPur1.Status::Enable THEN
                        VALIDATE("Private SP Resp.");
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
        SalesPur: Record "Salesperson/Purchaser";
        SalesPur1: Record "Salesperson/Purchaser";
        SalesPur2: Record "Salesperson/Purchaser";
        RepAuditMgt: Codeunit "Auto PDF Generate";
        SMSMobile: Record "SMS - Mobile No.";
        MS0001: Label 'Do you want update all the record.';
}

