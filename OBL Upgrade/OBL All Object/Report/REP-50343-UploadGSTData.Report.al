report 50343 "Upload GST Data"
{
    //DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    ProcessingOnly = true;
    //RDLCLayout = '.\ReportLayouts\UploadGSTData.rdl';

    dataset
    {
        dataitem("Vendor Requisition"; "Vendor Requisition")
        {

            trigger OnAfterGetRecord()
            begin

                /* CASE "Vendor Requisition"."No." OF
                 "Vendor Requisition"."No."::"1":
                 //"Vendor Requisition"."No." = 
                     BEGIN
                         Vendor.GET("Vendor Requisition".Name);
                         IF Vendor."GST Registration No." = '' THEN BEGIN
                             Vendor."GST Registration No." := "Vendor Requisition"."Search Name";
                             Vendor."GST Vendor Type" := Vendor."GST Vendor Type"::Registered;
                             Vendor.MODIFY;
                         END;
                     END;
                 "Vendor Requisition"."No."::"2":
                     BEGIN
                         Customer.GET("Vendor Requisition".Name);
                         IF Customer."GST Registration No." = '' THEN BEGIN
                             Customer."GST Registration No." := "Vendor Requisition"."Search Name";
                             Customer."GST Customer Type" := Customer."GST Customer Type"::Registered;
                             Customer.MODIFY;
                         END;
                     END;
                 "Vendor Requisition"."No."::"3":
                     BEGIN
                         Item.GET("Vendor Requisition".Name);
                         IF Item."GST Group Code" = '' THEN BEGIN
                             Item.VALIDATE("GST Group Code", "Vendor Requisition".Address);
                             Item.VALIDATE("HSN/SAC Code", "Vendor Requisition"."Telex No.");
                             Item.VALIDATE("GST Credit", Item."GST Credit"::Availment);
                             Item.MODIFY;
                         END;
                     END;

                END;
          */
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

    trigger OnPreReport()
    begin
        /*
        Customer.RESET;
        Customer.SETRANGE("GST Registration No.",'');
        IF Customer.FINDFIRST THEN BEGIN
           Customer.MODIFYALL(Customer."GST Customer Type",Customer."GST Customer Type"::Unregistered);
        END;
         */

    end;

    var
        Vendor: Record Vendor;
        Customer: Record Customer;
        Item: Record Item;
}

