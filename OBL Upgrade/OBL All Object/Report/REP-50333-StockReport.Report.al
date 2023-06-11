report 50333 "Stock Report"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\StockReport.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("Size Code", "Quality Code")
                                ORDER(Ascending)
                                WHERE("Net Change" = FILTER(<> 0));
            RequestFilterFields = "No.", "Location Filter", "Quality Code", "Size Code", "Date Filter", "Plant Code";
            column(Detail; Detail)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(TODAY; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID; USERID)
            {
            }
            column(GetItemFilters; Item.GETFILTERS)
            {
            }
            column(No; Item."No.")
            {
            }
            column(description; Item.Description + ' ' + Item."Description 2")
            {
            }
            column(SizeCodeDesc; Item."Size Code Desc.")
            {
            }
            column(BaseUnitOfMeasure; Item."Base Unit of Measure")
            {
            }
            column(Inventory; Item.Inventory)
            {
            }
            column(SizeCode; Item."Size Code")
            {
            }
            column(QualityCodeDesc; Item."Quality Code Desc.")
            {
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Quality Code");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Summary; Detail)
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

        //RepAuditMgt.CreateAudit(50333) ;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Detail: Boolean;
        RepAuditMgt: Codeunit "Auto PDF Generate";
        ExportToExcel: Boolean;
        k: Integer;
        TotalFor: Label 'Total for ';
}

