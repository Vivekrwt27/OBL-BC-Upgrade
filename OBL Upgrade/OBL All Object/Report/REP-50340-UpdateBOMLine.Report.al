report 50340 "Update BOM Line"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\UpdateBOMLine.rdl';

    dataset
    {
        dataitem("BOM Line Update"; "QuickLook API Data")
        {
            dataitem(Vendor; Vendor)
            {
                DataItemLink = "No." = FIELD("Customer No."); // 16225 Field1 replace "Customer No."

                trigger OnAfterGetRecord()
                begin
                    /*
                    "Production BOM Line".VALIDATE("Salesperson Code","BOM Line Update".NewNo);
                    Customer.VALIDATE("PCH Code","BOM Line Update"."PCH Code");
                    Customer.VALIDATE("Zonal Manager","BOM Line Update".ZM);
                    Customer.VALIDATE("Zonal Head","BOM Line Update".ZM);
                    Customer.VALIDATE("Private SP Resp.","BOM Line Update"."Private SP Code");
                     */
                    /*
                    Customer.VALIDATE("PCH Code","BOM Line Update".GST);
                    Customer.VALIDATE("Zonal Manager","BOM Line Update".ZM);
                    Customer.VALIDATE("Zonal Head","BOM Line Update".ZH);
                    //Customer.VALIDATE(Zone,"BOM Line Update".Zone);
                    
                    //"Production BOM Line".VALIDATE("No.","BOM Line Update".PCH);
                    MODIFY;
                     */
                    //16225 Vendor.VALIDATE(Vendor."GST No.", "BOM Line Update"."GST");
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
        MESSAGE('Done');
    end;
}

