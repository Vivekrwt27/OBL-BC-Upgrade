report 50302 "Batch Finish Prod. Order"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = SORTING(Status, "No.")
                                ORDER(Ascending)
                                WHERE(Status = FILTER(Released),
                                      Finished = FILTER(true));
            RequestFilterFields = "No.", "Starting Date", "Ending Date", "Creation Date", "Location Code";

            trigger OnAfterGetRecord()
            begin
                CLEAR(ProdOrderStatusManagement);
                ProdOrderStatusManagement.ChangeProdOrderStatus("Production Order", 4, NewPostingDate, TRUE);
                i += 1;
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
                field("Posting Date"; NewPostingDate)
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

    trigger OnInitReport()
    begin
        i := 1;
    end;

    trigger OnPostReport()
    begin
        IF NOT SuppressDialog THEN
            MESSAGE('[%1] Prod. Orders finished sucessfully', i);
    end;

    trigger OnPreReport()
    begin
        IF NewPostingDate = 0D THEN
            ERROR('Please select the Posting Date');
    end;

    var
        ProdOrderStatusManagement: Codeunit "Prod. Order Status Management";
        NewPostingDate: Date;
        SuppressDialog: Boolean;
        i: Integer;

    procedure SetParameters(LclPostingdate: Date; LCLSuppressDialog: Boolean)
    begin
        NewPostingDate := LclPostingdate;
        SuppressDialog := LCLSuppressDialog;
    end;
}

