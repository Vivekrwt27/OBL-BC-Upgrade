report 50274 "Location Wise Breakage"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = '.\ReportLayouts\LocationWiseBreakage.rdl';

    dataset
    {
        dataitem(Location; Location)
        {
            DataItemTableView = SORTING(Code);
            PrintOnlyIfDetail = true;
            column(CompName1; CompName1)
            {
            }
            column(CompName2; CompName2)
            {
            }
            column(DateFilter; 'From Date : ' + FORMAT(FromDate) + ' to ' + FORMAT(ToDate))
            {
            }
            column(LocationFilters; Location.GETFILTERS)
            {
            }
            column(LocationCode; 'Location Code : ' + Code)
            {
            }
            column("Code"; Location.Code)
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                CalcFields = "Cost Amount (Expected)", "Cost Amount (Actual)";
                DataItemLink = "Location Code" = FIELD(Code);
                DataItemTableView = SORTING("Item No.", "Posting Date")
                                    ORDER(Descending)
                                    WHERE("Entry Type" = FILTER("Consumption" | "Output"),
                                          "Source No." = FILTER('BREAKAGE'));
                column(ItemNo; "Item Ledger Entry"."Item No.")
                {
                }
                column(Description; tgItem.Description + ' ' + tgItem."Description 2")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(QtyInCarton; "Qty In Carton")
                {
                }
                column(CostAmount; "Cost Amount (Expected)" + "Cost Amount (Actual)")
                {
                }
                column(TotalOf; 'Total of : ' + Location.Code)
                {
                }
                column(QtySQMT; QtySQMT)
                {
                }
                column(QtyCarton; QtyCarton)
                {
                }
                column(Cost; Cost)
                {
                }
                column(Locationcodeeee; Locationcode)
                {
                }
                column(FromDate; FromDate)
                {
                }
                column(ToDate; ToDate)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    QtyCarton := 0;
                    QtySQMT := 0;
                    Cost := 0;

                    tgItem.GET("Item No.");
                    IF "Entry Type" = "Entry Type"::Consumption THEN BEGIN
                        QtyCarton += "Qty In Carton";
                        QtySQMT += Quantity;
                        Cost += "Cost Amount (Expected)" + "Cost Amount (Actual)";
                    END;
                end;

                trigger OnPreDataItem()
                begin

                    SETRANGE("Posting Date", FromDate, ToDate);
                    CurrReport.CREATETOTALS(QtyCarton, QtySQMT, Cost);
                end;
            }

            trigger OnAfterGetRecord()
            begin

                CompanyInfo.GET;
                CompName1 := CompanyInfo.Name;
                CompName2 := CompanyInfo."Name 2";
            end;

            trigger OnPreDataItem()
            begin

                IF Locationcode <> '' THEN
                    SETRANGE(Code, Locationcode);

                CurrReport.CREATETOTALS("Item Ledger Entry".Quantity, "Item Ledger Entry"."Qty In Carton",
                                    "Item Ledger Entry"."Cost Amount (Expected)", "Item Ledger Entry"."Cost Amount (Actual)", QtyCarton, QtySQMT, Cost);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Location Code"; Locationcode)
                {
                    TableRelation = Location.Code;
                    ApplicationArea = All;
                }
                field("From Date"; FromDate)
                {
                    ApplicationArea = All;
                }
                field("To Date"; ToDate)
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
        RowNo := 1;
    end;

    trigger OnPostReport()
    begin
        //      RepAuditMgt.CreateAudit(50274)
    end;

    trigger OnPreReport()
    begin


        IF (FromDate = 0D) OR (ToDate = 0D) THEN
            ERROR(Text002);

        i := 0;
        j := 0;
        QtyCarton := 0;
        QtySQMT := 0;
        Cost := 0;
    end;

    var
        tgItem: Record Item;
        tgWin: Dialog;
        i: Integer;
        j: Integer;
        FromDate: Date;
        ToDate: Date;
        Locationcode: Code[20];
        tgLocation: Record Location;
        QtyCarton: Decimal;
        QtySQMT: Decimal;
        Cost: Decimal;
        ExporttoExcel: Boolean;
        ExcelBUff: Record "Excel Buffer" temporary;
        NotDecimalValues: Boolean;
        RowNo: Integer;
        Colno: Integer;
        CompanyInfo: Record "Company Information";
        CompName1: Text[100];
        CompName2: Text[100];
        RepAuditMgt: Codeunit "Auto PDF Generate";
        Text001: Label 'Process @1@@@@@@@@@@@@@@@@@@@';
        Text002: Label 'From Date and To Date should not be blank.';
}

