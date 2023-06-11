report 50124 "BO Archive Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\ReportLayouts\BOArchiveReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Item Amount3"; 50000)
        {
            column(COMPANYNAME1; COMPANYNAME)
            {
            }
            column(CompanyName2; CompanyName12.Address)
            {
            }
            column(CompanyName3; CompanyName12."Address 2")
            {
            }
            column(FORMAT; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport; CurrReport.PAGENO)
            {
            }
            dataitem("Branch Wise focused Prod IBOT"; 50001)
            {
                //  DataItemLink = "Item No." = FIELD("Item No."), "Variant Code" = FIELD("Amount 2")/* Field5047 = FIELD(Field5047)*/;
                //DataItemTableView = SORTING("Item No.", "Variant Code", "Plant Code", /* Field5047,*/ Inventory);
                column(statecode; statecode.Description)
                {
                }
                column(state; statecode.Code)
                {
                }
                column(Name; customer1.Name)
                {
                }
                column(Quantity; 0) // 16630 blank "Plant Variant Wise Inventory".Quantity 
                {
                }

                trigger OnPreDataItem()
                begin
                    /*
                 IF statecode.GET("Item Amount3".State) THEN;
                 IF customer1.GET("Item Amount3".Amount) THEN;

                 IF PrinttoExcel = TRUE THEN
                  BEGIN
                   Excelbuff.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'');
                   Excelbuff.AddColumn(statecode.Description,FALSE,'',FALSE,FALSE,FALSE,'');
                   Excelbuff.AddColumn(statecode.Code,FALSE,'',FALSE,FALSE,FALSE,'');
                   Excelbuff.AddColumn("Item Amount3"."Sell-to City",FALSE,'',FALSE,FALSE,FALSE,'');
                   Excelbuff.AddColumn("Item Amount3"."Location Code",FALSE,'',FALSE,FALSE,FALSE,'');
                   IF "Item Amount3"."Item No." = "Item Amount3"."Item No."::"4" THEN
                      Excelbuff.AddColumn("Item Amount3"."Amount 2",FALSE,'',FALSE,FALSE,FALSE,'')
                   ELSE
                      Excelbuff.AddColumn("Item Amount3"."Blanket Order No.",FALSE,'',FALSE,FALSE,FALSE,'');
                   Excelbuff.AddColumn("Item Amount3"."Version No.",FALSE,'',FALSE,FALSE,FALSE,'');
                   Excelbuff.AddColumn("Item Amount3"."Date Archived",FALSE,'',FALSE,FALSE,FALSE,'');
                   Excelbuff.AddColumn("Item Amount3"."Time Archived",FALSE,'',FALSE,FALSE,FALSE,'');
                   Excelbuff.AddColumn("Item Amount3".Amount,FALSE,'',FALSE,FALSE,FALSE,'');
                   Excelbuff.AddColumn(customer1.Name,FALSE,'',FALSE,FALSE,FALSE,'');
                   Excelbuff.AddColumn("Item Amount3"."External Document No.",FALSE,'',FALSE,FALSE,FALSE,'');
                   Excelbuff.AddColumn("Item Amount3"."Posting Date",FALSE,'',FALSE,FALSE,FALSE,'');
                   Excelbuff.AddColumn("Item Amount3"."Salesperson Code",FALSE,'',FALSE,FALSE,FALSE,'');
                   Excelbuff.AddColumn("Plant Variant Wise Inventory".Quantity,FALSE,'',FALSE,FALSE,FALSE,'');
                   Excelbuff.AddColumn('Invoiced Quantity',FALSE,'',TRUE,FALSE,FALSE,'');
                   Excelbuff.AddColumn("Plant Variant Wise Inventory".Quantity,FALSE,'',FALSE,FALSE,FALSE,'');
                   Excelbuff.AddColumn(FORMAT("Item Amount3".Quantity),FALSE,'',TRUE,FALSE,FALSE,'');
                   Excelbuff.AddColumn("Item Amount3"."Reason Code",FALSE,'',TRUE,FALSE,FALSE,'');
                   Excelbuff.AddColumn(ReasonCode.Description,FALSE,'',TRUE,FALSE,FALSE,'');

                   Excelbuff.NewRow;
                  END;
                   */

                end;
            }

            trigger OnAfterGetRecord()
            begin

                IF ReasonCode.GET("Item Amount3"."Plant Code") THEN;
            end;

            trigger OnPreDataItem()
            begin

                CompanyName12.GET;

                /*
               IF PrinttoExcel = TRUE THEN
                BEGIN
                 Excelbuff.NewRow;
                 Excelbuff.NewRow;
                 Excelbuff.AddColumn(COMPANYNAME,FALSE,'',TRUE,FALSE,FALSE,'');
                 Excelbuff.NewRow;
                 Excelbuff.AddColumn(USERID,FALSE,'',TRUE,FALSE,FALSE,'');
                 Excelbuff.NewRow;
                 Excelbuff.AddColumn(CurrReport.OBJECTID,FALSE,'',TRUE,FALSE,FALSE,'');
                 Excelbuff.NewRow;
                 Excelbuff.AddColumn(GETFILTERS,FALSE,'',TRUE,FALSE,FALSE,'');

                END;
               */
                /*

               IF PrinttoExcel = TRUE THEN
                BEGIN
                 Excelbuff.NewRow;
                 Excelbuff.NewRow;
                 Excelbuff.AddColumn('Region',FALSE,'',TRUE,FALSE,FALSE,'');
                 Excelbuff.AddColumn('State',FALSE,'',TRUE,FALSE,FALSE,'');
                 Excelbuff.AddColumn('State Code',FALSE,'',TRUE,FALSE,FALSE,'');
                 Excelbuff.AddColumn('City',FALSE,'',TRUE,FALSE,FALSE,'');
                 Excelbuff.AddColumn('Location',FALSE,'',TRUE,FALSE,FALSE,'');
                 Excelbuff.AddColumn('Version No.',FALSE,'',TRUE,FALSE,FALSE,'');
                 Excelbuff.AddColumn('BO No.',FALSE,'',TRUE,FALSE,FALSE,'');
                 Excelbuff.AddColumn('Date Archived',FALSE,'',TRUE,FALSE,FALSE,'');
                 Excelbuff.AddColumn('Time Archived',FALSE,'',TRUE,FALSE,FALSE,'');
                 Excelbuff.AddColumn('Customer Code',FALSE,'',TRUE,FALSE,FALSE,'');
                 Excelbuff.AddColumn('Customer Name',FALSE,'',TRUE,FALSE,FALSE,'');
                 Excelbuff.AddColumn('External doc. No.',FALSE,'',TRUE,FALSE,FALSE,'');
                 Excelbuff.AddColumn('Posting Date',FALSE,'',TRUE,FALSE,FALSE,'');
                 Excelbuff.AddColumn('Salesperson Code',FALSE,'',TRUE,FALSE,FALSE,'');
                 Excelbuff.AddColumn('BO Quantity',FALSE,'',TRUE,FALSE,FALSE,'');
                 Excelbuff.AddColumn('Invoiced Quantity',FALSE,'',TRUE,FALSE,FALSE,'');
                 Excelbuff.AddColumn('Order Quantity',FALSE,'',TRUE,FALSE,FALSE,'');
                 Excelbuff.AddColumn('New Status',FALSE,'',TRUE,FALSE,FALSE,'');
                 Excelbuff.AddColumn('Reason Code',FALSE,'',TRUE,FALSE,FALSE,'');
                 Excelbuff.AddColumn('Reason Code Desc',FALSE,'',TRUE,FALSE,FALSE,'');

                 Excelbuff.NewRow;
                 Excelbuff.NewRow;
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

    trigger OnPostReport()
    begin
        /*
       IF PrinttoExcel = TRUE THEN
        CreateExcelSheet;
        */

    end;

    trigger OnPreReport()
    begin
        /*
      IF PrinttoExcel = TRUE THEN
       BEGIN
        Excelbuff.RESET;
        Excelbuff.DELETEALL;
       END;
         */

    end;

    var
        statecode: Record State;
        customer1: Record Customer;
        Excelbuff: Record "Excel Buffer";
        PrinttoExcel: Boolean;
        CompanyName12: Record "Company Information";
        ReasonCode: Record "Reason Code";

    procedure CreateExcelSheet()
    begin
        /*
        Excelbuff.CreateBook();
        Excelbuff.CreateSheet('Pending BO','51000',COMPANYNAME,USERID);
        Excelbuff.GiveUserControl();
        ERROR('');
        */

    end;
}

