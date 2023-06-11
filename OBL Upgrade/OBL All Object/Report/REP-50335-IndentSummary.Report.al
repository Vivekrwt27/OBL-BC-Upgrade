report 50335 "Indent Summary"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\IndentSummary.rdl';

    dataset
    {
        dataitem("Indent Status History"; "Indent Status History")
        {
            DataItemTableView = WHERE(Plant = FILTER('SKD-STORE' | 'HSK-STORE' | 'DRA-STORE'),
                                      "Indent Status" = FILTER(Authorized),
                                      Status = FILTER('<>EXECUTED'),
                                       "Item Category Code" = FILTER('<>UD999&<>FD104&<>PD105&<>PD199&<>RD299&<>RD399&<>RD199&<>FD103&<>RD202&<>RI203&<>RD203&<>RD201&<>RD302&<>PD101&<>RD301&<>RD102&<>RI101&<>RD101&<>RD103'));
            column(ReportingDate; "Reporting Date")
            {
            }
            column(IndentNo; "Indent No.")
            {
            }
            column(IndentLineNo; "Indent Line No.")
            {
            }
            column(Status; Status)
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(ItemCategoryCode; "Item Category Code")
            {
            }
            column(ItemCategoryDesc; ItemCategory.Description)
            {
            }
            column(Plant; Plant)
            {
            }
            column(Department; Department)
            {
            }
            column(TotalItemCount; TotalItemCount)
            {
            }
            column(Filters; Filters)
            {
            }
            column(No; 1)
            {
            }
            column(Date1; Date1)
            {
            }
            column(Date2; Date2)
            {
            }
            column(OldDate; OldDate)
            {
            }
            column(ShowOldData; ShowOldData)
            {
            }
            column(PlantColor; PlantColor)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF ItemCategory.GET("Indent Status History"."Item Category Code") THEN;

                /*IF "Indent Status History".Plant = 'HSK-STORE' THEN
                  PlantColor := 'LightGreen'
                ELSE
                  IF "Indent Status History".Plant = 'SKD-STORE' THEN
                    PlantColor := 'Yellow'
                ELSE
                  IF "Indent Status History".Plant = 'DRA-STORE' THEN
                    PlantColor := 'Blue'
                */
                IF "Indent Status History".Plant = 'DRA-STORE' THEN
                    PlantColor := 'LightBlue'
                ELSE
                    IF "Indent Status History".Plant = 'HSK-STORE' THEN
                        PlantColor := 'LightGreen'
                    ELSE
                        IF "Indent Status History".Plant = 'SKD-STORE' THEN
                            PlantColor := 'PaleTurquoise'

                //TotalItemCount:="Indent Status History".COUNT;

            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Indent Status History"."Reporting Date", '%1|%2', Date1, Date2);
                CLEAR(PlantColor);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Date1; Date1)
                {
                    ApplicationArea = All;
                }
                field(Date2; Date2)
                {
                    ApplicationArea = All;
                }
                field("Show Old Data"; ShowOldData)
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

    trigger OnPreReport()
    begin
        IF Date1 = 0D THEN Date1 := TODAY - 6;
        IF Date2 = 0D THEN Date2 := TODAY;

        IF (Date1 = 0D) OR (Date2 = 0D) THEN
            ERROR('Please select the From Date and To Date');

        Date1 := PreviousDateData(Date1);
        Date2 := PreviousDateData(Date2);

        Filters := "Indent Status History".GETFILTERS();

        CLEAR(OldDate);
        IF Date1 <> Date2 THEN
            OldDate := Date1;
    end;

    var
        RecUser: Record "User Setup";
        ItemCategory: Record "Item Category";
        TotalItemCount: Integer;
        Filters: Text;
        Date1: Date;
        Date2: Date;
        ReportDate: Date;
        OldDate: Date;
        ShowOldData: Boolean;
        PlantColor: Text;

    local procedure PreviousDateData(Dt: Date): Date
    var
        IndentStatusHistory1: Record "Indent Status History";
    begin
        IndentStatusHistory1.RESET;
        IndentStatusHistory1.SETFILTER("Reporting Date", '..%1', Dt);
        IF IndentStatusHistory1.FINDLAST THEN
            EXIT(IndentStatusHistory1."Reporting Date");
    end;
}

