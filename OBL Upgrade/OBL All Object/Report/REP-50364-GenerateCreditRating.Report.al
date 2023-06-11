report 50364 "Generate Credit Rating"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("State Code", "Customer Type")
                                WHERE("Customer Type" = FILTER('DEALER' | 'DISTIBUTOR'));
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                CLEAR(CRMgt);
                CRMgt.ProcessRatings(Customer, FromDate, ToDate, BlnFreeze);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("From Date"; FromDate)
                {
                    ApplicationArea = All;
                }
                field("To Date"; ToDate)
                {
                    ApplicationArea = All;
                }
                field(Freeze; BlnFreeze)
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

    trigger OnPostReport()
    begin
        IF GUIALLOWED THEN
            MESSAGE('Process Sucessfully');
    end;

    var
        CRMgt: Codeunit "Credit Rating Management";
        FromDate: Date;
        ToDate: Date;
        BlnFreeze: Boolean;
}

